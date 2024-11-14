Return-Path: <netdev+bounces-144737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DAD9C8564
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 09:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC31C1F22434
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 08:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93171F756F;
	Thu, 14 Nov 2024 08:58:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407001F6663
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 08:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731574704; cv=none; b=l2DRTHiKUWzjlbBnorl8cc56brmbmXTkAMuAKXOCPb0W220txLEsVJzCxqHLDd1yHYQ2RQ5e8nJVzeNOCmsMlHxb6Gpwn5KwOWjF/UPodxQUOXF0E0jctoKZ0Szzp0qEixJScIFt1oR33NAOaTI9mDAyIqx83iphkjRRW25Rmn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731574704; c=relaxed/simple;
	bh=arb5ev8D1gkREW3LGy4zcItfQnrfzM8oO7P/fIyEGH0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tjgoA+qBjDsg86oXX/XNw4FL49r23YqXfPnofUO4MDQo96xMVbWVfIQDkAWq5DYOlhyjfsCm72I6gjHnZs1WrxruzY6DyQnJGtGAIoRmB+MwTa3Y4UAcDPCzlRF++lKQ00CR8WPlBaixHSg8Ea5dyW1cPeZngsgcHyIgNtcbv78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83a9bd80875so38309239f.2
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 00:58:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731574702; x=1732179502;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NkslEva3xH+202UFk1N4Z5nFB7hQ9vtTqIsb5mgRVjc=;
        b=inDC8xuzzwNdvr8vJrp7VsaqhToYbUS+s0AybiWtXVg4/fe7F4X7msH2flgFiqZ4rw
         gJNh99TojUueLoDj30DsCLyhZfPGru+sVNZRz583+1aCGPcJE3IQ9pmH6B1YkldbhGi8
         0KYa8G/7a3MAgzW2IW3y5o8Xeom5Rb5LxAwu3Q7wIF0WE7JmuDgq6zfA65LGG+8vojSy
         b2uorHUZMDwJ99OX6F+4FOIRu9eb/MsvJHzRTUPbybr05oH4qqrVvhGoek9bHG/EMRmj
         PyreUercSDb1oCyWDbU47yfep7eqhgWRPCqGQ8VVfdxt9oDX9KFZSzeMKXv+gpg3n9p4
         JYVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEgi5IL9mnM3NUuLgftWv/vP+R8exV/dRLwO2E+fpmAUsXSQpPURZZsFk5KklRiqBqVtHtEQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpM18f5G9iK9tsClD6WgZ1tGoE643m8NlbqNML/TMgK0A8DIcD
	gi1IZzQ8YpCfk0w37m1tsUoe5c9NXuTKmokIXufHWkjvSdatyQkqmyu5sZEy9V65KIr/6OsZ8zM
	+7MZCvtr6FDnouIOcqWXztfAP8E17lOaI2dNdyu9amjm7Q7YMycZ3Ntk=
X-Google-Smtp-Source: AGHT+IEIkCC8N1t3g1bFzgXedY1Bkr0mma44mi/1bc5v4Jq5iS0Rq6K9BCAIGlp4mxA4h010nK3uHM+G6TudeUGpnR10/ajX8bi1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:194a:b0:3a7:1a65:2fbc with SMTP id
 e9e14a558f8ab-3a71a653086mr51886145ab.23.1731574702355; Thu, 14 Nov 2024
 00:58:22 -0800 (PST)
Date: Thu, 14 Nov 2024 00:58:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6735bbae.050a0220.1324f8.0094.GAE@google.com>
Subject: [syzbot] Monthly wireless report (Nov 2024)
From: syzbot <syzbot+lista52bb331ee700442ac9c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 10 new issues were detected and 1 were fixed.
In total, 48 issues are still open and 145 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  40995   Yes   WARNING in __ieee80211_beacon_get
                   https://syzkaller.appspot.com/bug?extid=18c783c5cf6a781e3e2c
<2>  5954    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<3>  3744    Yes   WARNING in ath6kl_bmi_get_target_info (2)
                   https://syzkaller.appspot.com/bug?extid=92c6dd14aaa230be6855
<4>  2962    Yes   WARNING in rate_control_rate_init (3)
                   https://syzkaller.appspot.com/bug?extid=9bdc0c5998ab45b05030
<5>  1415    Yes   WARNING in plfxlc_mac_release
                   https://syzkaller.appspot.com/bug?extid=51a42f7c2e399392ea82
<6>  1167    Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<7>  812     Yes   WARNING in __rate_control_send_low (3)
                   https://syzkaller.appspot.com/bug?extid=34463a129786910405dd
<8>  516     Yes   INFO: task hung in rfkill_global_led_trigger_worker (3)
                   https://syzkaller.appspot.com/bug?extid=50499e163bfa302dfe7b
<9>  364     Yes   INFO: task hung in crda_timeout_work (8)
                   https://syzkaller.appspot.com/bug?extid=d41f74db64598e0b5016
<10> 286     Yes   INFO: task hung in reg_check_chans_work (7)
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

