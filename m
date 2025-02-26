Return-Path: <netdev+bounces-169902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A073A465AF
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 16:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ACAC425D94
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 15:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3E521CFF4;
	Wed, 26 Feb 2025 15:44:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34837215764
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584662; cv=none; b=D6XmbBSyUWd5z/MsJ18/sltrxIaSxEs7eMprA13fFqs1EoP5ymDFxbLr9/JdmdfojcAjmqpyfhQOSYl/sQsKA3rXTw8KrQLKuT7eqkWcqQXkIugu69Z+2XExN04XH90ZulQs5x33f/AGxxIp1FsW8+WtG9/RnaA+oTi1gvU4xU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584662; c=relaxed/simple;
	bh=jQWGtiwUMbK9EpvVC6A07sD50bV3LE9jiqhidCemgEM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uj/SJ6BZrKB+qlJ2LiiLaWpDOWRSp5el78g5tLmWbZehx+PEy3DXnfabiGbXCLDGfWdAgGGuT0MFqSl0HPw/viloOG/hf8vyDbGis7H4esms/GO0HXW71GHizyVav2AOQhMXTjrrKzqgu0xuI/T4+kICwbQqlM9NQIE7KhT3kDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d2b3882febso45958045ab.1
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 07:44:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740584659; x=1741189459;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gW3c0T4SQd+xntB/X6MFD4fJslBbj6oN4QbWpGD4aAk=;
        b=A7bmdKJDRuTnyoVmUXrrTPkLEe2OOtyqP8tKioT32Iw/ueIY0aCRkO9WDfIlPWeddX
         utC3aEXjgHqUZveslyDxiTXZG7AHvR+pS+z2zpBVHDrEKquRquYBVPnzjpQiLlaZ4MkU
         d6UxaZP6klatvm0qwtLy9lEZ+0CXCAFD0DQjLwwfnc3VjYnwbFv3rKz0kLL8VYY5u3Am
         ywnGqeh/E0NcCyYUO4RWYcesWYN88Lj6HJtLe4opBG/W5/DHEe0686WgMOnbsQ6wrZr9
         lMKm57eD5NRKQ3yOMjf+m35L3oqLhueG39jyjgM7NZR9UPji+X8QyCfsjWQ3RNscptm1
         vHMw==
X-Forwarded-Encrypted: i=1; AJvYcCUNsUdiQNxkg6r7vFlRJnA9mTQ05muBsyMUFTRhMb0tjX62da+pqp0jZh2JLmBCTxLBLSBZY58=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3onb466NLz5PUW9Gp2jZs3wGzLCrQ/Gy9gSBqEbRp2aRLVw43
	/YXr2J3Uya1DB0k2MofPy0tVMahQNEZDflvcoYr8FBNn6Gc2qKQmNwRWtSsq1t2GDmbwHTPyHRI
	JiJW7JYkphXNPSZrdrj7b743j1FlKyTfg2w/z2gJUG3FzZ941I76TgoI=
X-Google-Smtp-Source: AGHT+IFHAPreiTBW/x4aw1EHkJ+xwFEwTp7VKuG/mVJow7Yr8RLePATwqXZ4fsrz1nfOajC8ztz3lRiQ+gIc4ySw3aLXDkSDqeA7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c545:0:b0:3d1:78f8:7490 with SMTP id
 e9e14a558f8ab-3d30487a027mr64643795ab.14.1740584659314; Wed, 26 Feb 2025
 07:44:19 -0800 (PST)
Date: Wed, 26 Feb 2025 07:44:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bf36d3.050a0220.38b081.01ff.GAE@google.com>
Subject: [syzbot] [wireless?] KMSAN: uninit-value in cfg80211_tx_mlme_mgmt
From: syzbot <syzbot+5a7b40bcb34dea5ca959@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ff202c5028a1 Merge tag 'soc-fixes-6.14' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12d447a4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aca5947365998f67
dashboard link: https://syzkaller.appspot.com/bug?extid=5a7b40bcb34dea5ca959
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/788b15dfbf95/disk-ff202c50.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/48f236cd3e71/vmlinux-ff202c50.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b92116dbc946/bzImage-ff202c50.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5a7b40bcb34dea5ca959@syzkaller.appspotmail.com

 cfg80211_wiphy_work+0x396/0x860 net/wireless/core.c:435
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xc1a/0x1e80 kernel/workqueue.c:3317
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3398
 kthread+0x6b9/0xef0 kernel/kthread.c:464
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
---[ end trace 0000000000000000 ]---
=====================================================
BUG: KMSAN: uninit-value in cfg80211_tx_mlme_mgmt+0x155/0x300 net/wireless/mlme.c:226
 cfg80211_tx_mlme_mgmt+0x155/0x300 net/wireless/mlme.c:226
 ieee80211_report_disconnect net/mac80211/mlme.c:4238 [inline]
 ieee80211_sta_connection_lost+0xfa/0x150 net/mac80211/mlme.c:7811
 ieee80211_sta_work+0x1dea/0x4ef0
 ieee80211_iface_work+0x1900/0x1970 net/mac80211/iface.c:1684
 cfg80211_wiphy_work+0x396/0x860 net/wireless/core.c:435
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xc1a/0x1e80 kernel/workqueue.c:3317
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3398
 kthread+0x6b9/0xef0 kernel/kthread.c:464
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Local variable frame_buf created at:
 ieee80211_sta_connection_lost+0x43/0x150 net/mac80211/mlme.c:7806
 ieee80211_sta_work+0x1dea/0x4ef0

CPU: 1 UID: 0 PID: 4086 Comm: kworker/u8:16 Tainted: G        W          6.14.0-rc3-syzkaller-00267-gff202c5028a1 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: events_unbound cfg80211_wiphy_work
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

