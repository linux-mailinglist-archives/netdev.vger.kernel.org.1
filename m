Return-Path: <netdev+bounces-147956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0F29DF6FC
	for <lists+netdev@lfdr.de>; Sun,  1 Dec 2024 20:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64E80281638
	for <lists+netdev@lfdr.de>; Sun,  1 Dec 2024 19:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192D21D7E5F;
	Sun,  1 Dec 2024 19:35:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2557618A6D3
	for <netdev@vger.kernel.org>; Sun,  1 Dec 2024 19:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733081735; cv=none; b=uNLDzS/H31tj8VM5HgHNuQVR/x3oEWZticga9MIvzjIIzrP324hvUWkM0XBPLzS3sQz/8ZzRojMrCQeokvkzKuw69ABm0NXPbYw/o/Rh8BEqef/xewcPVJAFvHT+fynLwhBD5bjLQHMi/2BNQZDCdhBgBYIrMZMVjh9Nk4Ajruc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733081735; c=relaxed/simple;
	bh=z8uvY8r9BngxMNmQwsdC5OYjyRD+PQbbT7IW+Payc28=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DZ/p81vQSnqEH24Ur2JDsUbmt1XhVTHcwYWRGqiOjWeCeHXP22EoWuyrGjg4+F78BFh5Ce7rP05Ms72TGGAGHzCgGMLAfxGA4VA8WRbiXfgZxmFEe0R3NOT8vSby9IXPoPXcyttQeqfOXa1mzXtrNEhIVLeJ5dxaogX5n3pY22Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a7cf41b54eso68902425ab.2
        for <netdev@vger.kernel.org>; Sun, 01 Dec 2024 11:35:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733081732; x=1733686532;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UiYYFVS7zXNAEGNB8zSuwYY/wBPkiY1gkF+FTRYF13M=;
        b=IqJ+OLyP74UCEceLabFOGFQjsnnPlwd6858g+swF755LsryGW5TDZ+oklmxdaLtCxM
         MwkwH23STvacFMxYXzvT4zbwO9mgoRscUHj2IFnjZlpKqf0YjeN5a0XBFnE/JKvhQmoA
         pupwnvIOCzLe7/+NAUw1AzoCVQ5mW4e5P302X5ZkndeqZoVE6LCVBKY/ue5PXw8wS1xF
         ke5quxpWNpj0zMYVgvlvJ+YxS/ElSFi717k5/SZtkf8NJuptDplKdyzhDtesOYLRCqdp
         2nddJAfRTFy8op8pEaDpCZBn/lqh1e5BcxNFNbNglhZx3/k3Zmj09kH/7lA1DENkjTNn
         QIuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVn80JjhD3VJKF9FzAttOzOsw7+Ummv07wBLIwCJAsN5ytUfCRh+pmM/dUcwN9tC5nvUng8rHE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk9cRNnUKmpBT6xL0ZuTK2qGRw6qBKisC9/NpXgSDbFIaKZUik
	vUcy/YlLb94Ylm4FcVeJJnr8pJCfyUk7Gp9gwy2hBBb/IcZ+cWqn7mFRbOS61PSA4O644XBqie+
	Y0l6QYjuoNVj2+ZUlnCfpRuJAnD3uFHe4xgdTkxH5xGXuwElu1GkRVyw=
X-Google-Smtp-Source: AGHT+IF0Y7VrKKoeBypb/8YoUJPdlLXROmdBP2ZHFMzlaUKF1Xewo1IOoIxztc4KegsUSa5b1oLtmkHrwjvPO5ssAhnB0kXbwUdr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a6:b0:3a7:4674:d637 with SMTP id
 e9e14a558f8ab-3a7c55259a8mr228318515ab.3.1733081732374; Sun, 01 Dec 2024
 11:35:32 -0800 (PST)
Date: Sun, 01 Dec 2024 11:35:32 -0800
In-Reply-To: <0000000000004fc49a0617826da3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674cba84.050a0220.48a03.0010.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] possible deadlock in mgmt_remove_adv_monitor_complete
From: syzbot <syzbot+e8651419c44dbc2b8768@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    c44daa7e3c73 net: Fix icmp host relookup triggering ip_rt_..
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13f120df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3891b550f14aea0f
dashboard link: https://syzkaller.appspot.com/bug?extid=e8651419c44dbc2b8768
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177067c0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e83d30580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a57b9e94b2ce/disk-c44daa7e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/da8c55111f3e/vmlinux-c44daa7e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d05428962b58/bzImage-c44daa7e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e8651419c44dbc2b8768@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.12.0-syzkaller-10694-gc44daa7e3c73 #0 Not tainted
------------------------------------------------------
syz-executor280/6027 is trying to acquire lock:
ffff888031dd8078 (&hdev->lock){+.+.}-{4:4}, at: mgmt_remove_adv_monitor_complete+0xaf/0x550 net/bluetooth/mgmt.c:5524

but task is already holding lock:
ffff888031dd8690 (&hdev->cmd_sync_work_lock){+.+.}-{4:4}, at: hci_cmd_sync_dequeue+0x44/0x3d0 net/bluetooth/hci_sync.c:887

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&hdev->cmd_sync_work_lock){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       hci_cmd_sync_lookup_entry net/bluetooth/hci_sync.c:838 [inline]
       hci_cmd_sync_queue_once+0x43/0x240 net/bluetooth/hci_sync.c:782
       le_conn_complete_evt+0xae1/0x12e0 net/bluetooth/hci_event.c:5778
       hci_le_conn_complete_evt+0x18c/0x420 net/bluetooth/hci_event.c:5789
       hci_event_func net/bluetooth/hci_event.c:7481 [inline]
       hci_event_packet+0xa55/0x1540 net/bluetooth/hci_event.c:7536
       hci_rx_work+0x3f3/0xdb0 net/bluetooth/hci_core.c:4039
       process_one_work kernel/workqueue.c:3229 [inline]
       process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
       worker_thread+0x870/0xd30 kernel/workqueue.c:3391
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (&hdev->lock){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       mgmt_remove_adv_monitor_complete+0xaf/0x550 net/bluetooth/mgmt.c:5524
       _hci_cmd_sync_cancel_entry net/bluetooth/hci_sync.c:645 [inline]
       hci_cmd_sync_dequeue+0x22b/0x3d0 net/bluetooth/hci_sync.c:890
       cmd_complete_rsp+0x4c/0x180 net/bluetooth/mgmt.c:1469
       mgmt_pending_foreach+0xd1/0x130 net/bluetooth/mgmt_util.c:259
       mgmt_index_removed+0x133/0x390 net/bluetooth/mgmt.c:9483
       hci_sock_bind+0xcce/0x1150 net/bluetooth/hci_sock.c:1307
       __sys_bind_socket net/socket.c:1827 [inline]
       __sys_bind+0x1e4/0x290 net/socket.c:1858
       __do_sys_bind net/socket.c:1863 [inline]
       __se_sys_bind net/socket.c:1861 [inline]
       __x64_sys_bind+0x7a/0x90 net/socket.c:1861
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&hdev->cmd_sync_work_lock);
                               lock(&hdev->lock);
                               lock(&hdev->cmd_sync_work_lock);
  lock(&hdev->lock);

 *** DEADLOCK ***

2 locks held by syz-executor280/6027:
 #0: ffff8880751cf258 (sk_lock-AF_BLUETOOTH-BTPROTO_HCI){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1617 [inline]
 #0: ffff8880751cf258 (sk_lock-AF_BLUETOOTH-BTPROTO_HCI){+.+.}-{0:0}, at: hci_sock_bind+0x149/0x1150 net/bluetooth/hci_sock.c:1202
 #1: ffff888031dd8690 (&hdev->cmd_sync_work_lock){+.+.}-{4:4}, at: hci_cmd_sync_dequeue+0x44/0x3d0 net/bluetooth/hci_sync.c:887

stack backtrace:
CPU: 1 UID: 0 PID: 6027 Comm: syz-executor280 Not tainted 6.12.0-syzkaller-10694-gc44daa7e3c73 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
 mgmt_remove_adv_monitor_complete+0xaf/0x550 net/bluetooth/mgmt.c:5524
 _hci_cmd_sync_cancel_entry net/bluetooth/hci_sync.c:645 [inline]
 hci_cmd_sync_dequeue+0x22b/0x3d0 net/bluetooth/hci_sync.c:890
 cmd_complete_rsp+0x4c/0x180 net/bluetooth/mgmt.c:1469
 mgmt_pending_foreach+0xd1/0x130 net/bluetooth/mgmt_util.c:259
 mgmt_index_removed+0x133/0x390 net/bluetooth/mgmt.c:9483
 hci_sock_bind+0xcce/0x1150 net/bluetooth/hci_sock.c:1307
 __sys_bind_socket net/socket.c:1827 [inline]
 __sys_bind+0x1e4/0x290 net/socket.c:1858
 __do_sys_bind net/socket.c:1863 [inline]
 __se_sys_bind net/socket.c:1861 [inline]
 __x64_sys_bind+0x7a/0x90 net/socket.c:1861
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe10fa9a479
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc7400a558 EFLAGS: 00000246 ORIG_RAX: 0000000000000031
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fe10fa9a479
RDX: 0000000000000006 RSI: 0000000020000040 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000003
R10: 00007ffc7400a540 R11: 0000000000000246 R12: 00007ffc7400a59c
R13: 00007ffc7400a5d0 R14: 00007ffc7400a5b0 R15: 000000000000001c
 </TASK>
==================================================================
BUG: KASAN: slab-use-after-free in cmd_complete_rsp+0x67/0x180 net/bluetooth/mgmt.c:1471
Read of size 8 at addr ffff888140ef2fc0 by task syz-executor280/6027

CPU: 0 UID: 0 PID: 6027 Comm: syz-executor280 Not tainted 6.12.0-syzkaller-10694-gc44daa7e3c73 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 cmd_complete_rsp+0x67/0x180 net/bluetooth/mgmt.c:1471
 mgmt_pending_foreach+0xd1/0x130 net/bluetooth/mgmt_util.c:259
 mgmt_index_removed+0x133/0x390 net/bluetooth/mgmt.c:9483
 hci_sock_bind+0xcce/0x1150 net/bluetooth/hci_sock.c:1307
 __sys_bind_socket net/socket.c:1827 [inline]
 __sys_bind+0x1e4/0x290 net/socket.c:1858
 __do_sys_bind net/socket.c:1863 [inline]
 __se_sys_bind net/socket.c:1861 [inline]
 __x64_sys_bind+0x7a/0x90 net/socket.c:1861
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe10fa9a479
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc7400a558 EFLAGS: 00000246 ORIG_RAX: 0000000000000031
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fe10fa9a479
RDX: 0000000000000006 RSI: 0000000020000040 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000003
R10: 00007ffc7400a540 R11: 0000000000000246 R12: 00007ffc7400a59c
R13: 00007ffc7400a5d0 R14: 00007ffc7400a5b0 R15: 000000000000001c
 </TASK>

Allocated by task 6026:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x243/0x390 mm/slub.c:4314
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 mgmt_pending_new+0x65/0x250 net/bluetooth/mgmt_util.c:269
 mgmt_pending_add+0x36/0x120 net/bluetooth/mgmt_util.c:296
 remove_adv_monitor+0x102/0x1b0 net/bluetooth/mgmt.c:5568
 hci_mgmt_cmd+0xc47/0x11d0 net/bluetooth/hci_sock.c:1712
 hci_sock_sendmsg+0x7b8/0x11c0 net/bluetooth/hci_sock.c:1832
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:726
 sock_write_iter+0x2d7/0x3f0 net/socket.c:1147
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6027:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2338 [inline]
 slab_free mm/slub.c:4598 [inline]
 kfree+0x196/0x420 mm/slub.c:4746
 mgmt_remove_adv_monitor_complete+0x2bf/0x550 net/bluetooth/mgmt.c:5533
 _hci_cmd_sync_cancel_entry net/bluetooth/hci_sync.c:645 [inline]
 hci_cmd_sync_dequeue+0x22b/0x3d0 net/bluetooth/hci_sync.c:890
 cmd_complete_rsp+0x4c/0x180 net/bluetooth/mgmt.c:1469
 mgmt_pending_foreach+0xd1/0x130 net/bluetooth/mgmt_util.c:259
 mgmt_index_removed+0x133/0x390 net/bluetooth/mgmt.c:9483
 hci_sock_bind+0xcce/0x1150 net/bluetooth/hci_sock.c:1307
 __sys_bind_socket net/socket.c:1827 [inline]
 __sys_bind+0x1e4/0x290 net/socket.c:1858
 __do_sys_bind net/socket.c:1863 [inline]
 __se_sys_bind net/socket.c:1861 [inline]
 __x64_sys_bind+0x7a/0x90 net/socket.c:1861
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888140ef2f80
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 64 bytes inside of
 freed 96-byte region [ffff888140ef2f80, ffff888140ef2fe0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x140ef2
anon flags: 0x57ff00000000000(node=1|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 057ff00000000000 ffff88801ac41280 ffffea000518f100 dead000000000005
raw: 0000000000000000 0000000000200020 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0), ts 3010995590, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3649/0x3790 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x140 mm/slub.c:2408
 allocate_slab+0x5a/0x2f0 mm/slub.c:2574
 new_slab mm/slub.c:2627 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3815
 __slab_alloc+0x58/0xa0 mm/slub.c:3905
 __slab_alloc_node mm/slub.c:3980 [inline]
 slab_alloc_node mm/slub.c:4141 [inline]
 __kmalloc_cache_noprof+0x27b/0x390 mm/slub.c:4309
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 acpi_os_create_semaphore+0xfa/0x3b0 drivers/acpi/osl.c:1210
 acpi_ds_create_method_mutex drivers/acpi/acpica/dsmethod.c:263 [inline]
 acpi_ds_begin_method_execution+0x2af/0x9f0 drivers/acpi/acpica/dsmethod.c:324
 acpi_ds_call_control_method+0xc1/0x7c0 drivers/acpi/acpica/dsmethod.c:489
 acpi_ps_parse_aml+0x2df/0x960 drivers/acpi/acpica/psparse.c:503
 acpi_ps_execute_method+0x74d/0x880 drivers/acpi/acpica/psxface.c:190
 acpi_ns_evaluate+0x5df/0xa40 drivers/acpi/acpica/nseval.c:205
 acpi_ut_evaluate_object+0x154/0x4a0 drivers/acpi/acpica/uteval.c:60
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888140ef2e80: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
 ffff888140ef2f00: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
>ffff888140ef2f80: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                                           ^
 ffff888140ef3000: fa fb fb fb fb fb fb fb fb fc fc fc fc fa fb fb
 ffff888140ef3080: fb fb fb fb fb fb fc fc fc fc fa fb fb fb fb fb
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

