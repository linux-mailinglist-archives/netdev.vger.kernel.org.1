Return-Path: <netdev+bounces-175766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D409BA676DC
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 15:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D05919A500E
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 14:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5863F20E01F;
	Tue, 18 Mar 2025 14:49:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F2620E01E
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742309397; cv=none; b=qzqtRLyPTjzHjlwxUKA9G3650L1q+3ZgaJjhiWr6XGGMpexC9utmIshT0+iJGwk8G/bgGT/Wsrgo3zxkU2w4j8AJvDrbH7KjHQY+KsjuxZCnlMj8XpVl/8YTJMg5afkfiJFr5tAEs+GKd7NZ9erGYcXYGNTgoHyzfMjM8Jqxp7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742309397; c=relaxed/simple;
	bh=6odYDy/WzoLJB1dmBWgEDOpufGqtMVPdGIhz8jVMsEw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bjKqhWAuicQD9XllUGt9NEmNIR41tRaUFTWNfcoquY7L6lmPCv3cdj4dFLFrJxHsIaPUaz3bwpqrgUn26wGpVpGwH9s96QVQqxCJeGCtE/PFLR4SxI3kujLYHHCukTI6FPhZWg8DfP+5r9ykfIHbTS44sC+OHXVtXdDETWqpr+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3cfb20d74b5so70625305ab.3
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 07:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742309391; x=1742914191;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Svpb8PP6bZBAtbgaSvAJuXTALbR5zT82p2qdsD8Izlk=;
        b=wOXr3yjSDyldm3qo3Y2HQeOtLGmJlHQEj9HwtLJ02B3FtoWlvOsQQ9xR1bpNyKaT37
         BJehbyLpDqqNgAVw0piFv4LtU7KGivbmGghgjt9+qh76tLAwrWA/jk3+Nn/jaz41q3ce
         bSPvGmEyoxlOsxr4sKQnGc/nsgwCdR9hVmgr4GyG7Mdtmxfn9WtEjMf/Gq0nptMibs99
         SzbTo0J33G4NHbl9biJ5LJ/rn0A5yx0cjZSn04p79Ane18uH26g1OVmcXx3mHBvoHyGh
         Y3eJXFD6gFkGOlx/AZdt2/+pQ82VT+XbdJMsKIc+c+KEMI7m9R92aFxWjTEyttlrEq9Q
         esFg==
X-Forwarded-Encrypted: i=1; AJvYcCWhRTqbeLsP2R7JFW4tee9/m4txeXiCJdhlVedQq3SmFOtL61TQCF6FmiPcKXRVr/VLjqNxzXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbHQLUMebjbho5a3hH4T5u3De5YZj70LB6TmneLWS5WoOmySS8
	4gqE4Gk3ihUuYu+lnMm2Xu8oBAPjp4lBd4uC5+waWy4ttIM5Lwv3m23kHFxEYs8tYCow1R0Fdf0
	jx7rZ55KkF/8gfFACYftqCR13rN+RCGwXBjwVab48NSXls/lZ/pDbnDU=
X-Google-Smtp-Source: AGHT+IFDs/o3eedmzhMw6Yzzrqxh3GBYltN/cYObP4ptRO7nE4JJcEBYePc11P3ivmib9uw7EuNw2I5rm4LmA7fqY6U6BjJvn8OJ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1648:b0:3d3:f19c:77c7 with SMTP id
 e9e14a558f8ab-3d483a79cc6mr169890705ab.16.1742309391155; Tue, 18 Mar 2025
 07:49:51 -0700 (PDT)
Date: Tue, 18 Mar 2025 07:49:51 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d9880f.050a0220.2ca2c6.018b.GAE@google.com>
Subject: [syzbot] Monthly wireless report (Mar 2025)
From: syzbot <syzbot+list454c6e9dbba22fe541cf@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 4 new issues were detected and 1 were fixed.
In total, 58 issues are still open and 156 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  101957  Yes   WARNING in __ieee80211_beacon_get
                   https://syzkaller.appspot.com/bug?extid=18c783c5cf6a781e3e2c
<2>  8431    Yes   WARNING in rate_control_rate_init (3)
                   https://syzkaller.appspot.com/bug?extid=9bdc0c5998ab45b05030
<3>  7317    Yes   WARNING in ath6kl_bmi_get_target_info (2)
                   https://syzkaller.appspot.com/bug?extid=92c6dd14aaa230be6855
<4>  6350    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<5>  5147    Yes   WARNING in __rate_control_send_low (3)
                   https://syzkaller.appspot.com/bug?extid=34463a129786910405dd
<6>  2991    Yes   WARNING in plfxlc_mac_release
                   https://syzkaller.appspot.com/bug?extid=51a42f7c2e399392ea82
<7>  1205    Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<8>  899     Yes   INFO: task hung in rfkill_global_led_trigger_worker (3)
                   https://syzkaller.appspot.com/bug?extid=50499e163bfa302dfe7b
<9>  558     Yes   INFO: task hung in crda_timeout_work (8)
                   https://syzkaller.appspot.com/bug?extid=d41f74db64598e0b5016
<10> 428     Yes   INFO: task hung in reg_check_chans_work (7)
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

