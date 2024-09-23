Return-Path: <netdev+bounces-129252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C6697E811
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 11:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D76221C20DBB
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 09:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C2F194A40;
	Mon, 23 Sep 2024 09:02:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E89F188918
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 09:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727082144; cv=none; b=Gw9yi2mN7EhnSAVJDlvndem/dNxi/rQ/Rbtunl8ugRuHmlNBhuRUalHxStMvH1GK8dJbQvt6jtAEkBxsumaiW34rPdq/np/r8Ar1fLu4AUmZgd7MCIeGCqiJn8bfXWkQKPXuwikMLaYYNraDVtS80NkD2uNyrQpkBPRobmL+rmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727082144; c=relaxed/simple;
	bh=GAd44S+5klCaPfKDd6etwTCIXJl3mBx+mqeSxPW4+dE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=H7dJNEdTkGNd4h3ZpBe0AD4XzF3Z9ckVEbLOQ2j4UCEE8I9DszV9PV22KlcoL3tnGFmj7U9u3jLkvLfGsOOwpIMdzdr5HF8dBShJ+WBZ/O3UB9QUs9uBxK1Fw8nuEjYNu6UUiK2ZNa5rKYDRfpVn1Iq5iH7UAeAK8YOksRnn9No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82cf261659bso632366339f.2
        for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 02:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727082142; x=1727686942;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5iWrHDgy75ujQSAtkrd1YSd/BK1uHyW7PPvp12qtc8g=;
        b=igwt328ZnaCYz6iG9ebm1XMzW0Jt51699h7RwCnPPQIIECpzj01j6PpEBVc1yuua+f
         wUQjpzHrS4icvBmAuiUxlsC0Sv4hhEhd4TaA7oU4kadVsREnH8nlB3tcC3z8vsSeneu1
         DLzWsWyWwjIrp6kkWm8oSxWJp9itYHpon0g5yDWdHyZA7Mg1nwocH9569TDJ7UJbwlrH
         vzVcg+Q17GezwWau/dQJyfcnpe8+rWVCgnFkfM2xQbWZR0cIvT3Wvmk76EECxGdk1iL1
         xznj4khDqiS/hgopLXNSHEcMFNWMXtuOCbafTNcVFHWSiPBxT3HaF5YaojWSYQH8ayhX
         LRDw==
X-Forwarded-Encrypted: i=1; AJvYcCXnBT4+C0A3bPSylCAIqQHbit3+yG/iTiT8OAYFHSNIRBvADAlnJs55Re1VJpGG8S1P8KYNUtk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfThdr2PR4MytpUwqZTpworyP+lTotaP/I0h0vit2APN8z7For
	gjQU0HR6TB8gRi+PQGDQbNXQWcz1HcRLJMJz54v+/vOMVbzGworfBZcSttFt/HmtNFNeJy4XWWF
	dREJLie7zS/fvfefzqjQibmNJqDlrh3zPy2AhOUEsaOMzemjr28QxFGc=
X-Google-Smtp-Source: AGHT+IHr/1nMZN9npsBJqflH8EDyMKxMKowp6Z57TX0KA0hBnVZKYlmZ/dMEdZ0nIpW8iSX+MxjK+mYO90E3bQ/u+/HoicntAi0w
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2184:b0:3a0:b0dc:abfe with SMTP id
 e9e14a558f8ab-3a0c8d25cffmr81200665ab.17.1727082142465; Mon, 23 Sep 2024
 02:02:22 -0700 (PDT)
Date: Mon, 23 Sep 2024 02:02:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f12e9e.050a0220.3eed3.000a.GAE@google.com>
Subject: [syzbot] Monthly ppp report (Sep 2024)
From: syzbot <syzbot+list22f4c01bc59cfcacc23a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ppp maintainers/developers,

This is a 31-day syzbot report for the ppp subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ppp

During the period, 1 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 9 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 73      No    INFO: task hung in ppp_exit_net (4)
                  https://syzkaller.appspot.com/bug?extid=32bd764abd98eb40dea8
<2> 27      Yes   inconsistent lock state in valid_state (4)
                  https://syzkaller.appspot.com/bug?extid=d43eb079c2addf2439c3
<3> 16      No    possible deadlock in ppp_input
                  https://syzkaller.appspot.com/bug?extid=38ad8c7c6638c5381a47

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

