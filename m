Return-Path: <netdev+bounces-224682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EB7B8834F
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 09:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 155BEB60A00
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 07:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209262F8BE4;
	Fri, 19 Sep 2025 07:33:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E4D2F7ADD
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 07:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267213; cv=none; b=ffnvQotX3wsbdnSt84OLRfGE2BtrZTYEwL0XFqzK1MI8ZPXQQMkTiKYzULguwPmNMYnv0Q+5YnAXWKD9lboFcMvqxDsurW0hdXMQG3TujVZSyQsm9YEkijzoEVNbQrB6dlF85pWeTQpeW7A1AIA5Vqdj0T/5perPtdQbJyznX84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267213; c=relaxed/simple;
	bh=+2TJblT6LHI57S9AzaMiROC9Kq8+LmktTXhZRPyPaVc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JK2tttI2wFCKBqYejJXKsXiWy/p8U4ZZOv6cRQOsCrejOf5eD/4OK1rsTrG5Bf5g9mVmGMtiWi+Ji8ow0xS4fWEt8mVFCNwAqTIBrGDFmg+dDKXABS+ysVFNXuaoXFVAlb6mKlZCkcSyqARvw5LDjR3mUWE6dDPaYfSDlEJkfqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-423f9d1ea61so38146275ab.0
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 00:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758267210; x=1758872010;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iOLMQZh+p8WZQSf5C0CCnZHd4Mr5OtFWTXlqTXn35ho=;
        b=RfG/JzTT6kfCCqG9e6lH+HYTNe/377wXqa3koAPHr+h65aCNVZmG3AQ9/rsXGXpsch
         32kJsA8ZGjWETQxCGC+JqoAQuRcZUFx+QWKM/aZATYWi3pvaatTtGQgmF2+i13//+UEr
         ivsMp48nWUmHRne4lGRjchTPyusMVJLkVD9lR+xoQf2sr6oCm+XkqadtwczDXalB62gJ
         GQKJUCVuiO0u1CFQcwj4KFrZOEH4GQFxzJWc0pb50MkcMa05z5q8dbQp2ZGYJToMnqxa
         Keq8yPFmJuXKQvJelO+LtTzYcHeuF1zOyQ2TExo6sApXA4FWU7FsOFyffu19k0CEXuC8
         Ndfw==
X-Forwarded-Encrypted: i=1; AJvYcCXuXqp5Nt9MydDWqeRs72Qd8SnxD7ScKis2lr25AIFtXEe6G6fKTKidVjdaj0OpL/zwi5q2VVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH5p4tYwmZEEHTfyzyfU1dVeuUG4w0TjBap8QopaHtC9XNnZq9
	4v9zwTF2x0Jz8P9cOw/4eY441a558nPPaMUnYpJjXYqmOTwT92vOV3J6xxuQpZ7mRG2F0E5TrQ+
	iozkp4Isi9ytfHem0Vzn0/cDQ+Wsw/1fmdS3NheGg4kTuKjQxXCp9qWm2OzY=
X-Google-Smtp-Source: AGHT+IGSIL56u0FooE8IiACmPgSgu3KOpk6TzvSGcyHoh57v+4rqxqX50T0Vun0q8H2sFhjYMKpv5vP99iAaB4z28VfmYrUMEs3c
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16c7:b0:424:388:6ced with SMTP id
 e9e14a558f8ab-4248192733bmr40617935ab.14.1758267210259; Fri, 19 Sep 2025
 00:33:30 -0700 (PDT)
Date: Fri, 19 Sep 2025 00:33:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cd074a.a00a0220.37dadf.0017.GAE@google.com>
Subject: [syzbot] [net?] WARNING in dev_shutdown (7)
From: syzbot <syzbot+c9ecf60a8adb7629821e@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a4d43c1f17b9 Merge 6.17-rc6 into usb-next
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=10a0bb12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=64a9fba56fdb0aef
dashboard link: https://syzkaller.appspot.com/bug?extid=c9ecf60a8adb7629821e
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6eefb11d9e81/disk-a4d43c1f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6232f2c26d00/vmlinux-a4d43c1f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8d192b0d2295/bzImage-a4d43c1f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c9ecf60a8adb7629821e@syzkaller.appspotmail.com

asix 3-1:7.204 eth1: unregister 'asix' usb-dummy_hcd.2-1, ASIX AX88178 USB 2.0 Ethernet
------------[ cut here ]------------
WARNING: CPU: 1 PID: 12317 at net/sched/sch_generic.c:1500 dev_shutdown+0x3b6/0x430 net/sched/sch_generic.c:1500
Modules linked in:
CPU: 1 UID: 0 PID: 12317 Comm: kworker/1:9 Not tainted syzkaller #0 PREEMPT(voluntary) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Workqueue: usb_hub_wq hub_event

RIP: 0010:dev_shutdown+0x3b6/0x430 net/sched/sch_generic.c:1500
Code: 48 c7 c2 60 a6 41 88 be a3 00 00 00 48 c7 c7 20 ab 41 88 c6 05 36 08 4e 04 01 e8 85 71 18 fb e9 8f fd ff ff e8 7b 42 3c fb 90 <0f> 0b 90 e9 5f fe ff ff 4c 89 f7 e8 8a 74 9a fb e9 77 fc ff ff 4c
RSP: 0018:ffffc90013087498 EFLAGS: 00010283
RAX: 000000000002f429 RBX: ffff8881355c8488 RCX: ffffc9001024c000
RDX: 0000000000100000 RSI: ffffffff8641b875 RDI: ffff8881355c8568
RBP: ffff8881355c8000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff8881355c8438
R13: ffffed1026ab9003 R14: ffff8881355c8480 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff888268ff6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c37e36c CR3: 00000000090a4000 CR4: 00000000003506f0
Call Trace:
 <TASK>
 unregister_netdevice_many_notify+0xcb6/0x2310 net/core/dev.c:12154
 unregister_netdevice_many net/core/dev.c:12229 [inline]
 unregister_netdevice_queue+0x305/0x3f0 net/core/dev.c:12073
 unregister_netdevice include/linux/netdevice.h:3385 [inline]
 unregister_netdev+0x1f/0x60 net/core/dev.c:12247
 usbnet_disconnect+0x109/0x500 drivers/net/usb/usbnet.c:1658
 usb_unbind_interface+0x1da/0x9e0 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:571 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:563
 __device_release_driver drivers/base/dd.c:1274 [inline]
 device_release_driver_internal+0x44b/0x620 drivers/base/dd.c:1297
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:579
 device_del+0x396/0x9f0 drivers/base/core.c:3878
 usb_disable_device+0x355/0x7d0 drivers/usb/core/message.c:1418
 usb_disconnect+0x2e1/0x9c0 drivers/usb/core/hub.c:2344
 hub_port_connect drivers/usb/core/hub.c:5406 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5706 [inline]
 port_event drivers/usb/core/hub.c:5870 [inline]
 hub_event+0x1aa2/0x5060 drivers/usb/core/hub.c:5952
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x56d/0x700 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


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

