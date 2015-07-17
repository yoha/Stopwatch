//
//  ViewController.swift
//  Stopwatch
//
//  Created by Yohannes Wijaya on 7/3/15.
//  Copyright © 2015 Yohannes Wijaya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    var timer = NSTimer()
    var count = 0
    var playStatusButton = true
    var remainingTime = (hours: 0, minutes: 0, seconds: 0)
    
    // MARK: - IB outlets & actions

    @IBOutlet weak var stopwatchLabel: UILabel!
    @IBOutlet weak var playPauseBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var stopButton: UIBarButtonItem!
    @IBAction func playPauseButton(sender: UIBarButtonItem) {
        togglePlayPauseStatus()
    }
    @IBAction func stopButton(sender: UIBarButtonItem) {
        timer.invalidate()
        count = 0
        stopwatchLabel.text = "00:00:00"
        stopButton.enabled = false
    }
    
    // MARK: - Custom methods
    
    func startTimerCounter() {
        var hrs: String
        var mnts: String
        var secs: String
        remainingTime = getHoursMinutesSecondsFromStartTimerCounter(++count)
        hrs = String(format: "%02d", remainingTime.hours)
        mnts = String(format: "%02d", remainingTime.minutes)
        secs = String(format: "%02d", remainingTime.seconds)
        stopwatchLabel.text = "\(hrs):\(mnts):\(secs)"
    }
    
    func getHoursMinutesSecondsFromStartTimerCounter(seconds: Int) -> (Int, Int, Int) {
        let remainingHours = seconds / 3600
        let remainingMinutes = (seconds % 3600) / 60
        let remainingSeconds = (seconds % 3600) % 60
        return (remainingHours, remainingMinutes, remainingSeconds)
    }
    
    func togglePlayPauseStatus() {
        togglePlayPauseImageButton(playStatusButton)
        playStatusButton = !playStatusButton
    }
    
    func togglePlayPauseImageButton(status: Bool) {
        var playPauseImageButton: UIBarButtonItem
        var barButtonItems = toolBar.items!
        if status {
            playPauseImageButton = UIBarButtonItem(barButtonSystemItem: .Pause, target: self, action: "togglePlayPauseStatus")
            barButtonItems[1] = playPauseImageButton
            stopButton.enabled = false
        }
        else {
            playPauseImageButton = UIBarButtonItem(barButtonSystemItem: .Play, target: self, action: "togglePlayPauseStatus")
            barButtonItems[1] = playPauseImageButton
            stopButton.enabled = true
        }
        toolBar.setItems(barButtonItems, animated: true)
        togglePlayPauseAction()
    }
    
    func togglePlayPauseAction() {
        if playStatusButton {
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "startTimerCounter", userInfo: nil, repeats: true)
        }
        else {
            timer.invalidate()
        }
    }
    
    // MARK: - Default methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopButton.enabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

