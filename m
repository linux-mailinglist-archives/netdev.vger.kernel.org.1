Return-Path: <netdev+bounces-166832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E379FA377E6
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 22:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05D743AD5C2
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 21:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311B71A238F;
	Sun, 16 Feb 2025 21:53:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671161531E9
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 21:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739742802; cv=none; b=f9qwEqMbltssyPQrjb2S0ErWX3aguyglked75mV5zXogj0vEuVzGUXsVLn2gDmwUYE6L6UKamUq2AaLv6T0SpyHJMm011dqyuHtWJcVTGtiODjvW6u0AV+4j+J4I5Qfp9i4Q1ES845tfW5cylhrlB3WNVC5k1JI3Q1kXxHwScBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739742802; c=relaxed/simple;
	bh=2HdV9K1090TNcWMgtBDZ/CrmvyVDjRkPYrKYHVxxQiI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HEosDCW1QniJ4Bm3J0SMI8kIUHmSXcAn/w5mHVTKXJMI1aYM+1IMHX41zMkc53L8DddTDpoNXjsaBfz57i5jqIdsyyfyZcaG2J2T8Xc3oT54Z2ix+7vAZKd4xHGI/dZZ/oKfyuHTdbR8+FOqsf7xnBJpIR+j6ZJwNZiLwawOWgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8559602b59bso12413639f.0
        for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 13:53:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739742799; x=1740347599;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8j34y60xPQfNM3NuVW72lMLYLLNzfF/77lksqY3ZGos=;
        b=icl5OtrthX2sHao1hDd0nBV/llrfGlC/ydPVTCoJWPw1ZWbFjmHVratw5/qDys4xKl
         BOGmYzN4ZmDQBTojL3dCqHhBnoHdruXRRxw4ZrgAD/1vCi9QxsEKIy6KnY0gFEinhcr2
         RD6byFD8BEWgAxvk4x9eSFZ2KOIQEpCcTSdBLABsFCk6j8WkqPyi8cHnF0ZJjHmwARVR
         /rAageNwECLK4bOTskvL0TpIHlwNGcWjA2iRHNbMz48/7KFJa+Xz7E/Usg/0NHoGtZHZ
         W5bd28683sCUol++tay09Cmk+so8CzOP6J/oh7U4U+8JUePvaJ6YjsmbvoMY69nTYjIF
         BMJg==
X-Forwarded-Encrypted: i=1; AJvYcCX1mcAgcRC+ZnNWTgHGPbsNMPPafCysGzv/d9bMcS23Ozpai9VihJJo8YhO6O0/EtIZzUxMClU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmQU9y7kgqLolEMnCWX+s+Q5qzAvVmzKq+jeBmBOu0QU3orpU/
	A7Wn2NPClug3qDGTF5Mh1mXsz3G0044JJB+KnXoFLzsOUe2LQJDA4pv6R+QPXLkSexmu63OmtmG
	aKlt93ybuqimAnJcqGl9+gNGe0CQg9v+qlSyN9i0EeDHTT471Jk1T4Cg=
X-Google-Smtp-Source: AGHT+IG2MFvfRLzbqLO5UDabd4n/3XziSxoOym4jvpO3IAILNVCNMeyyKALPLOteFzRAcBMFVvdmIKPnvREtlY67sjtjOWmYBeEq
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c8:b0:3cf:b626:66c2 with SMTP id
 e9e14a558f8ab-3d280921393mr50007475ab.19.1739742799584; Sun, 16 Feb 2025
 13:53:19 -0800 (PST)
Date: Sun, 16 Feb 2025 13:53:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b25e4f.050a0220.173698.0016.GAE@google.com>
Subject: [syzbot] Monthly wireless report (Feb 2025)
From: syzbot <syzbot+list8ccdbcb0368002fe97e4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 5 new issues were detected and 7 were fixed.
In total, 58 issues are still open and 155 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  88473   Yes   WARNING in __ieee80211_beacon_get
                   https://syzkaller.appspot.com/bug?extid=18c783c5cf6a781e3e2c
<2>  7039    Yes   WARNING in rate_control_rate_init (3)
                   https://syzkaller.appspot.com/bug?extid=9bdc0c5998ab45b05030
<3>  6511    Yes   WARNING in ath6kl_bmi_get_target_info (2)
                   https://syzkaller.appspot.com/bug?extid=92c6dd14aaa230be6855
<4>  6323    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<5>  4563    Yes   WARNING in __rate_control_send_low (3)
                   https://syzkaller.appspot.com/bug?extid=34463a129786910405dd
<6>  2622    Yes   WARNING in plfxlc_mac_release
                   https://syzkaller.appspot.com/bug?extid=51a42f7c2e399392ea82
<7>  1200    Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<8>  809     Yes   INFO: task hung in rfkill_global_led_trigger_worker (3)
                   https://syzkaller.appspot.com/bug?extid=50499e163bfa302dfe7b
<9>  550     Yes   INFO: task hung in crda_timeout_work (8)
                   https://syzkaller.appspot.com/bug?extid=d41f74db64598e0b5016
<10> 388     Yes   INFO: task hung in reg_check_chans_work (7)
                   https://syzkaller.appspot.com/bug?extid=a2de4763f84f61499210

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

