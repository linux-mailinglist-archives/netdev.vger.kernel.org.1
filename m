Return-Path: <netdev+bounces-166963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8ECEA3826C
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 12:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74BD916503F
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 11:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDD4219E8C;
	Mon, 17 Feb 2025 11:55:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74941218EA8
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 11:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739793319; cv=none; b=i2i2reYHT7Ktv6dD/wIJ87bneG+x75WCJXeUBYRezU2fX5LloMuXWUtpWvZI9VeDJsEvO2O/lPm+o9m/SSuq9VgDjIdUFnF6s/gyg3StbAbiKtX2t0s1LKIRzWXZoajcuCzoZeper0q743eEFiTVDV0wYiCOyj6aj9aUdCgemtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739793319; c=relaxed/simple;
	bh=ILp6NWLJjwn2+wYDs/55/nIpNNTPnEsZR6bwXdUBTGI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XNzVGoPnpIBm5sKN3rtbhUdr3Qbt5BcSbQZUK4b3/myFls738v5AxdKuyDtyyvJCramsTkzk2NxU5yXhn2x3ukiFwqjEzQFOgQ9p+r4BuvlJo9vJuM3oPp9dVvKsnpA5ryRbCFct+7X25S5JJB8DlVOJpnXsWKk1ugnwALVEcDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3cf64584097so32700385ab.2
        for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 03:55:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739793316; x=1740398116;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+lbVHv9nkluAVpd1VJ6PZljCLsy3EjbT3NB72IM2Efs=;
        b=wNUBT5xuCgkTts//pUHyb4L7FT0Gzb7BNgmvQAxj2CaWnbYOFEBDUzHGmC2eZzZQZ1
         T15tW98CXwkV0rPzPWeOv9RC/YtnB6fP4cAKMoYIJmI8fehg9jOpaSxnRr9KZfL5vJkT
         zvcG2adTPJ52gwLGygTELgBGVqcYQ1o6AzmZ1LrbwtR8Y6xxCc2tWeeV6rg1rmhb+/Vw
         NW4y3uYJy2JfCJqWENRFb6RDlzrA2E6Pe8zio6BDqTqeV0opcZO2lfz+D7q6tPXBshRl
         Ga2pkYtTdiLXzsIbt6PfiYQajCe2HSQ9LQrDi5qKxk0zzT8Lf/VmxC8nPYoTheTmZ7+c
         6Drw==
X-Forwarded-Encrypted: i=1; AJvYcCVz3CqMYTomwoPjLcmYxEybZ7lg7zTQnQGf3FMVqralXbz5Kw+0DydRhCM+2cO6F52+FWt131U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/xXhJIyuwks7bVqZieqvlAdQYBpn2P5A1jkUC/ZjQSZbxf++j
	xG6h32qqbmxcV5RXTM1rN5QAohQMmqFbO6w193I8mCsIUkcOS6KarWNS12W4kv7aJu6LKdQVQCk
	r/eYaptCLMPYTM/DkhjkkSMhvhj3FN9FZNk8QCbwI/9G1W8F1jde4cLQ=
X-Google-Smtp-Source: AGHT+IGVc4wtbO074YxvTM6HOoNeAUM7xoiuJHzKiJhlLb1qhI95g/SyTCL0NkKSJYwaUb5UtCjq5ejGormVjjOYiSi427J4CH8G
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd82:0:b0:3cf:b3ab:584d with SMTP id
 e9e14a558f8ab-3d2809209f9mr67293775ab.13.1739793316624; Mon, 17 Feb 2025
 03:55:16 -0800 (PST)
Date: Mon, 17 Feb 2025 03:55:16 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b323a4.050a0220.173698.002a.GAE@google.com>
Subject: [syzbot] [usb?] KMSAN: uninit-value in mii_nway_restart (2)
From: syzbot <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    128c8f96eb86 Merge tag 'drm-fixes-2025-02-14' of https://g..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11546098580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=264db44f1897cdc3
dashboard link: https://syzkaller.appspot.com/bug?extid=3361c2d6f78a3e0892f9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d9d9b0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1039d9b0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7aa6f3aa12c5/disk-128c8f96.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7ca2c0dbfd2f/vmlinux-128c8f96.xz
kernel image: https://storage.googleapis.com/syzbot-assets/aa690978a38e/bzImage-128c8f96.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in mii_nway_restart+0x119/0x1e0 drivers/net/mii.c:468
 mii_nway_restart+0x119/0x1e0 drivers/net/mii.c:468
 ch9200_bind+0x238/0xeb0 drivers/net/usb/ch9200.c:354
 usbnet_probe+0xdb0/0x3eb0 drivers/net/usb/usbnet.c:1761
 usb_probe_interface+0xd33/0x12e0 drivers/usb/core/driver.c:396
 really_probe+0x4dc/0xd90 drivers/base/dd.c:658
 __driver_probe_device+0x2ab/0x5d0 drivers/base/dd.c:800
 driver_probe_device+0x72/0x890 drivers/base/dd.c:830
 __device_attach_driver+0x568/0x9e0 drivers/base/dd.c:958
 bus_for_each_drv+0x403/0x620 drivers/base/bus.c:462
 __device_attach+0x3c1/0x650 drivers/base/dd.c:1030
 device_initial_probe+0x32/0x40 drivers/base/dd.c:1079
 bus_probe_device+0x3dc/0x5c0 drivers/base/bus.c:537
 device_add+0x13aa/0x1ba0 drivers/base/core.c:3665
 usb_set_configuration+0x31c9/0x38d0 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0x109/0x2a0 drivers/usb/core/generic.c:250
 usb_probe_device+0x3a7/0x690 drivers/usb/core/driver.c:291
 really_probe+0x4dc/0xd90 drivers/base/dd.c:658
 __driver_probe_device+0x2ab/0x5d0 drivers/base/dd.c:800
 driver_probe_device+0x72/0x890 drivers/base/dd.c:830
 __device_attach_driver+0x568/0x9e0 drivers/base/dd.c:958
 bus_for_each_drv+0x403/0x620 drivers/base/bus.c:462
 __device_attach+0x3c1/0x650 drivers/base/dd.c:1030
 device_initial_probe+0x32/0x40 drivers/base/dd.c:1079
 bus_probe_device+0x3dc/0x5c0 drivers/base/bus.c:537
 device_add+0x13aa/0x1ba0 drivers/base/core.c:3665
 usb_new_device+0x15f0/0x2470 drivers/usb/core/hub.c:2652
 hub_port_connect drivers/usb/core/hub.c:5523 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5663 [inline]
 port_event drivers/usb/core/hub.c:5823 [inline]
 hub_event+0x4ffb/0x72d0 drivers/usb/core/hub.c:5905
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xc1a/0x1e80 kernel/workqueue.c:3317
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3398
 kthread+0x6b9/0xef0 kernel/kthread.c:464
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Local variable buff created at:
 ch9200_mdio_read+0x3c/0x100 drivers/net/usb/ch9200.c:180
 mii_nway_restart+0x8a/0x1e0 drivers/net/mii.c:466

CPU: 1 UID: 0 PID: 3067 Comm: kworker/1:2 Not tainted 6.14.0-rc2-syzkaller-00185-g128c8f96eb86 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Workqueue: usb_hub_wq hub_event
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

