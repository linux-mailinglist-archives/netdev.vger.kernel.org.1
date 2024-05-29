Return-Path: <netdev+bounces-99201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7491E8D4116
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 00:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9F31F22BB8
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 22:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B32F1C8FCA;
	Wed, 29 May 2024 22:08:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B511F1C2321
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 22:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717020510; cv=none; b=kFSEwnNeW8CAYdubWyyeSDTUJ1JIuXF77heANFTh1WhFrwp2KTYtXv+UlDGtTluK505u2wNGL5sEndLCzwCo7ipCntY2rj+otOCMswrY0oyMlZj7Ty4M/y03aYZOv5fs/TeVk5pyzaUOAiAiBWHOliqDN5/2TTA/dpqUpbokACw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717020510; c=relaxed/simple;
	bh=qlTTWGw8g4V5EQGOqrQjz4puCme7kPOvgv7L6YSc4Bk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=O6XvtaqQ5Q+2unm+arwKYsOKmA2NcdE7xk+DvI8H1h/ohAtWdiWY2FlZMHBUjypWmw/duvFbpNopIMH0AEmeCcGTXqI6hTacetm4zv0EEoKzI57I0LAH+mNYjdls3vSy0hAvfFsAA/g5vJJWRQP//98pMaxd/NJeC0Fw4Er4Rdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-37458393465so2204105ab.0
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 15:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717020508; x=1717625308;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y2TP+cVoXsWGxaPYDHxSt3opPN7Ye6m5B6CFDizYDNQ=;
        b=pu70Np+PHrgfWXmlznLuzuOul5Jd6l/IT/66J5JLptNyXduVJbQldM4gptgyCUlJjR
         tUm/9a+mGLEEvFXAdZSWGsuK79H5MYsDQNmDMov9GM735MEQM79dxZHTCOBYXTnCvLGD
         2mcFJunVRF5yY9jnxaXA6/7kfhcOGI0IIr54pi61CudnVcahkZpOLUBFyEsPJc4a7zzc
         kMpe6PNUFk5Z+vVw9R4DVgJSfI5rEWiHjm4YTCqkCad4ap1V/yCf5IOtfuraA20VrS33
         rOJ+s89mqxgdP1tVtKRMEiDXxw5+6MieyjMHHDSecUyQWpTcXJ7n+PlaY6Pv5qPGwC3m
         0t9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUoAq5a1BXZVwhCSLaPV6qBQxJ4nvZOp176E0V2AtSLk3bn1BYVvlnGeSZQa4re9KnxrUjJXHLmTD/VAXqQ/fcZisEmURp1
X-Gm-Message-State: AOJu0YyvDlpwTHQYvG2HX7ptjaOzYEzWxGYctjmf+p3o8OQjSUKGKrHh
	5tFGJop02kfiAr+pY+aTLOJSvAwMePkHDCCewH0jrgND6Ve5WXX23i/R753Do4GnBsuzIHhuuBE
	bMTE4cXHnOYKFztQWeBvtwp+V/l30iKih+O45VclAZ2gDka/7tJ5pZP0=
X-Google-Smtp-Source: AGHT+IGscVBJk0L7gvnjqMs1VFcnHllRu/Y7i65SekTk48C2yUUMzF11fi2fL9bYsUdKqxSOL4NNyNmdsZB9Aqg2DPLUaJARJBVj
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160e:b0:374:5382:72be with SMTP id
 e9e14a558f8ab-3747dfcae56mr115275ab.3.1717020508088; Wed, 29 May 2024
 15:08:28 -0700 (PDT)
Date: Wed, 29 May 2024 15:08:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000074ff7b06199efd7b@google.com>
Subject: [syzbot] [kvm?] [net?] [virt?] INFO: task hung in __vhost_worker_flush
From: syzbot <syzbot+7f3bbe59e8dd2328a990@syzkaller.appspotmail.com>
To: eperezma@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9b62e02e6336 Merge tag 'mm-hotfixes-stable-2024-05-25-09-1..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16cb0eec980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e73beba72b96506
dashboard link: https://syzkaller.appspot.com/bug?extid=7f3bbe59e8dd2328a990
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/61b507f6e56c/disk-9b62e02e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6991f1313243/vmlinux-9b62e02e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/65f88b96d046/bzImage-9b62e02e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7f3bbe59e8dd2328a990@syzkaller.appspotmail.com

INFO: task syz-executor.2:9163 blocked for more than 143 seconds.
      Not tainted 6.9.0-syzkaller-12393-g9b62e02e6336 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.2  state:D stack:27024 pid:9163  tgid:9163  ppid:8496   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0xf15/0x5d00 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6837
 schedule_timeout+0x258/0x2a0 kernel/time/timer.c:2557
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common+0x3de/0x5f0 kernel/sched/completion.c:116
 __vhost_worker_flush+0x1aa/0x1e0 drivers/vhost/vhost.c:288
 vhost_worker_flush drivers/vhost/vhost.c:295 [inline]
 vhost_dev_flush+0xad/0x120 drivers/vhost/vhost.c:305
 vhost_vsock_flush drivers/vhost/vsock.c:694 [inline]
 vhost_vsock_dev_release+0x1a5/0x400 drivers/vhost/vsock.c:746
 __fput+0x408/0xbb0 fs/file_table.c:422
 __fput_sync+0x47/0x50 fs/file_table.c:507
 __do_sys_close fs/open.c:1555 [inline]
 __se_sys_close fs/open.c:1540 [inline]
 __x64_sys_close+0x86/0x100 fs/open.c:1540
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f910027bdda
RSP: 002b:00007ffc83a68930 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f910027bdda
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000006
RBP: 00007f91003ad980 R08: 0000001b2ec20000 R09: 00000000000003f6
R10: 000000008ae9c606 R11: 0000000000000293 R12: 0000000000056292
R13: 00007f91003abf8c R14: 00007ffc83a68a30 R15: 0000000000000032
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8dbb18e0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8dbb18e0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8dbb18e0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6614
2 locks held by kworker/u8:3/51:
 #0: ffff8880196fe948 ((wq_completion)iou_exit){+.+.}-{0:0}, at: process_one_work+0x12bf/0x1b60 kernel/workqueue.c:3206
 #1: ffffc90000bc7d80 ((work_completion)(&ctx->exit_work)){+.+.}-{0:0}, at: process_one_work+0x957/0x1b60 kernel/workqueue.c:3207
3 locks held by kworker/u8:6/1041:
 #0: ffff888029f54148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x12bf/0x1b60 kernel/workqueue.c:3206
 #1: ffffc90004507d80 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work+0x957/0x1b60 kernel/workqueue.c:3207
 #2: ffffffff8f74afa8 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xcf/0x1500 net/ipv6/addrconf.c:4193
2 locks held by kworker/u8:8/1261:
2 locks held by getty/4844:
 #0: ffff88802b1860a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc8/0x1490 drivers/tty/n_tty.c:2201
2 locks held by syz-fuzzer/7666:
3 locks held by syz-executor.1/9466:
 #0: ffff88802ce84d88 (&hdev->req_lock){+.+.}-{3:3}, at: hci_dev_do_close+0x26/0x90 net/bluetooth/hci_core.c:554
 #1: ffff88802ce84078 (&hdev->lock){+.+.}-{3:3}, at: hci_dev_close_sync+0x339/0x1100 net/bluetooth/hci_sync.c:5050
 #2: ffffffff8dbbd078 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock+0x1a4/0x3b0 kernel/rcu/tree_exp.h:323
1 lock held by syz-executor.3/11000:
 #0: ffffffff8f74afa8 (rtnl_mutex){+.+.}-{3:3}, at: tun_detach drivers/net/tun.c:698 [inline]
 #0: ffffffff8f74afa8 (rtnl_mutex){+.+.}-{3:3}, at: tun_chr_close+0x3e/0x250 drivers/net/tun.c:3500
1 lock held by syz-executor.3/11005:
 #0: ffffffff8f74afa8 (rtnl_mutex){+.+.}-{3:3}, at: tun_detach drivers/net/tun.c:698 [inline]
 #0: ffffffff8f74afa8 (rtnl_mutex){+.+.}-{3:3}, at: tun_chr_close+0x3e/0x250 drivers/net/tun.c:3500
1 lock held by syz-executor.4/11002:
 #0: ffffffff8f74afa8 (rtnl_mutex){+.+.}-{3:3}, at: tun_detach drivers/net/tun.c:698 [inline]
 #0: ffffffff8f74afa8 (rtnl_mutex){+.+.}-{3:3}, at: tun_chr_close+0x3e/0x250 drivers/net/tun.c:3500
1 lock held by syz-executor.1/11013:
 #0: ffffffff8f74afa8 (rtnl_mutex){+.+.}-{3:3}, at: __tun_chr_ioctl+0x4fc/0x4770 drivers/net/tun.c:3110


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

