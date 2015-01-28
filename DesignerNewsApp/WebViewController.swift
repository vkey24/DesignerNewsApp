//
//  WebViewController.swift
//  DesignerNewsApp
//
//  Created by Meng To on 2015-01-10.
//  Copyright (c) 2015 Meng To. All rights reserved.
//

import UIKit
import Spring

class WebViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var webView: UIWebView!
    var timer = NSTimer()
    var shareTitle : String?
    var url : NSURL!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var closeButton: SpringButton!
    
    @IBAction func shareButtonPressed(sender: AnyObject) {
        var shareString = self.shareTitle ?? ""
        var shareURL = self.url
        let activityViewController = UIActivityViewController(activityItems: [shareString, shareURL], applicationActivities: nil)
        activityViewController.setValue(shareString, forKey: "subject")
        activityViewController.excludedActivityTypes = [UIActivityTypeAirDrop]
        presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
        webView.delegate = self
    }

    func webViewDidFinishLoad(webView: UIWebView) {
        self.shareTitle = webView.stringByEvaluatingJavaScriptFromString("document.title");

        timer = NSTimer.scheduledTimerWithTimeInterval(
            0.1,
            target: self,
            selector: Selector("updateProgress"),
            userInfo: progressView,
            repeats: true
        )
    }
    
    func updateProgress() {
        if progressView.progress == 1 {
            progressView.hidden = true
            timer.invalidate()
        }
        else {
            UIView.animateWithDuration(0.1, animations: {
                self.progressView.progress += 0.1
            })
        }
    }
}
