Return-Path: <netdev+bounces-77457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F378871D1C
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 12:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90C261C2148F
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 11:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144A15A118;
	Tue,  5 Mar 2024 11:10:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D79B2579
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 11:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709637031; cv=none; b=jfU1MknaJaku57EUbAvdz01PqBywN8aDt0p9mTPLwdLzEaseBZ5oECsQy5cRH28unHTy0Cdae5IJJb2nYqVMYJMWXIs7Puwo4SG/Zo7WIy9YkRzCvqL5QxGvRdgSsxDF3O/emxIjuMpwiXSvDDHMNNoOtGxsDy5IHHkAnHrOIrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709637031; c=relaxed/simple;
	bh=3aWM+91DGc9RE3bgTrHL867wjYtGysNmqDvLBzzTZaY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=B0fpl+3dJqYZIC6/p7CLrE1iNFijHamjRLXhaFH+Tvk5d0NaKcvUF09fwnn/jZtbvlR6RvsAOiLyfhsh5p9tytzy3sXU7ENMHFEFCl5XPROgd6wSyur9xA1mgsw7OXhV6NZbIQIRpqFAcYYhDmdBOOW1Xn6+PXq+sHMIrPGjlAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c83a903014so292150939f.2
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 03:10:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709637028; x=1710241828;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GlbGQTRl1i1EmCVY75Q3aR01OrbCMT+99f6zJT7YSHM=;
        b=qQCJ5nOzKRaNp6UiJIM4KE1cA2eSNqeK4OBZKOwVsE8TMmdwV17VQEi1F3r38lT/Fm
         Xc/Rc5Qiqs7RLeQxIUqMjPyH5o6sucPIjN0m9q1WydvSQ2zZuPGvHlJPOIbSB1hid1/V
         gaSGiOzX44nQoT4WcjxbrEtLd4S5HJYIwpO2wKEmBeXXmVQVy4UOryJQPu+l3b66k+Ke
         jFL8cixCesCSk1NJDZuOSCOStQb4YDUNxHQ9SU39d1aRvA2Gnvfjv0cbtZK2XMsbqXYd
         kFe0rw69+AC4VUfn++GvrDyw78acbk4LFtAtfabinUwknuNfQCbqxqfDPm/MxQNS5mXs
         LwAg==
X-Forwarded-Encrypted: i=1; AJvYcCU5OJI3PsONI/L8Sr7PpsRF/qdXhxx9aKflcNZ5e9e4rHDUxIc8LWOovy8RDBxZl+GYQZILqNXoU3Gz1jRq+6BLbZaYLQZ3
X-Gm-Message-State: AOJu0YweYPTBMojEKHGq2p+6T2ZCKW8fBQ0G6toy8r4zcjgDIDMWDM4f
	aiFM0wK6tAC91dg1sGF/gFD5S2+i/3E5v6crcA7Ny210o+WWQ8fSxquQG06oMt5h6fM4cCG8/4S
	KAZof/n/WHPiAmpvfPbqtQkQ7AaE7kZWyMFO7aFSNymLg2wxNqBvvHsk=
X-Google-Smtp-Source: AGHT+IHp3WS83ust8Ksdj+hUBC78IFEEyfY1HV/DLw6pXRpDzKVan7IPZBIFLya9QJyc2diwAZ/whRJPVClTM6jKlj+30It+RNUg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c241:0:b0:365:1611:5d5b with SMTP id
 k1-20020a92c241000000b0036516115d5bmr638510ilo.2.1709637028447; Tue, 05 Mar
 2024 03:10:28 -0800 (PST)
Date: Tue, 05 Mar 2024 03:10:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c690fb0612e7e30f@google.com>
Subject: [syzbot] Monthly wireless report (Mar 2024)
From: syzbot <syzbot+list1dffa7f965b817f6f840@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 2 new issues were detected and 1 were fixed.
In total, 28 issues are still open and 121 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  6920    Yes   WARNING in __ieee80211_beacon_get
                   https://syzkaller.appspot.com/bug?extid=18c783c5cf6a781e3e2c
<2>  6045    Yes   WARNING in ieee80211_link_info_change_notify (2)
                   https://syzkaller.appspot.com/bug?extid=de87c09cc7b964ea2e23
<3>  4412    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<4>  1222    Yes   WARNING in __rate_control_send_low
                   https://syzkaller.appspot.com/bug?extid=fdc5123366fb9c3fdc6d
<5>  844     Yes   WARNING in ar5523_submit_rx_cmd/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=6101b0c732dea13ea55b
<6>  750     Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<7>  720     No    INFO: task hung in ath9k_hif_usb_firmware_cb (2)
                   https://syzkaller.appspot.com/bug?extid=d5635158fb0281b27bff
<8>  73      Yes   WARNING in ieee80211_free_ack_frame (2)
                   https://syzkaller.appspot.com/bug?extid=ac648b0525be1feba506
<9>  46      Yes   WARNING in carl9170_usb_submit_cmd_urb/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=9468df99cb63a4a4c4e1
<10> 38      Yes   WARNING in ar5523_cmd/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=1bc2c2afd44f820a669f

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

