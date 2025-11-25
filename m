Return-Path: <netdev+bounces-241544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 78322C8595A
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 15:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 04CA64ECF3E
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 14:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC67021ABDC;
	Tue, 25 Nov 2025 14:53:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9693326959
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764082407; cv=none; b=Lf0CDyxA4DoP2vUHFX1YFp4/cdMLgSFe2q/Gu3tpst58zFwfODTeonPiM6wVWsbDyluxw6KZZxQSaMscTHIvy/t16YbkJ5TzSLueDBmJrtRzTmPLdvhAaxxdb2XHhEP1o8Qaq6JDp7ezqvDdzJmCECsT2lmEIIbQ+JTHXeR43uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764082407; c=relaxed/simple;
	bh=7yrCoyUYTnytN76+GRYmNVMRrrYLaTD+oZan3ei3owI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Pqpy7kRxbXmCjwqJl9yIiERhmCQj3OmvdwmZ2yZVwfhBbfTs9kMu6IvoNVjinPesu5IaNo5Gkns8C1wuYq8tuTJ7mx65zL3jCjcSHIokn2M5P1Pt/iq7/d/rFSvxJuxNtjcbFZTZ4H72ifgM4Q+Q3Se/TVAyFnKVc/tlfQcjStU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-4330f62ef60so48049455ab.0
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 06:53:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764082405; x=1764687205;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QOA03dBPZiH7SCa2ITGq3r5TJoapfypfq+bcamX9nSE=;
        b=TuwmGusikCYi6fmP3nNEJVyoYertjiSaBv0H7exyddja4OJ2o0W/d7Rlcxx7XhEU07
         9xVNkJxEDsOuAjkgpKoWfe3qdzlTBzlbthu/3x1STTav9R4Qg16pbSWXQ1hOFOuiMoWs
         dOseDQqsdlzCxHlA/xxDnY+hDNMNIm6YCEjN0BJ9RtUbqdyBiCnm71qxzccH3DuEm8gi
         PouZkvXjputf1d1kbW7DykWfLU+XQ3u5j4WRp/sSHKdoP3P72ZphOdh8TZXSlTQtGeS+
         HR/tCw5x1jZSbFLeBoq/x3fVeT/FoiDCGjByRxzSOT6O//DRPAixOSxvT32gvBnnry7D
         rqpw==
X-Forwarded-Encrypted: i=1; AJvYcCWkwj/6QooR75sHf4bRvUqN9Wft00RvMZF4A4MNl2Rlq844zjrgMUZiZE7xGLRQS7CeJcJ0Dk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS2CpomlaUJCzKFA8zA697P/AZCvc17dgPL60XIft2qhKRBTTG
	gLTVz1Gfrf17fl9kNWR6K/MuMjZQjVvYPSKkgwv7JsdTZHFg+/jQT4iJ4tICAnvQEGD5nB9qWb0
	nT6EG2WmTINW6YCzXaWVqxJ1heMk3nqBCrD3e49/vBQpcixXWCyu3u7IwDpo=
X-Google-Smtp-Source: AGHT+IHMnhD38uWXqVjboY8dbQ+ujG3Mzk1eorjWVlGzEJ9/bwXPPK7UfwUen20ZAGdXM2q5psGAcbLW00qGPpIjHifwOdXP7daJ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1806:b0:42d:8b25:47ed with SMTP id
 e9e14a558f8ab-435b8e3d9f4mr140727555ab.6.1764082404851; Tue, 25 Nov 2025
 06:53:24 -0800 (PST)
Date: Tue, 25 Nov 2025 06:53:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6925c2e4.a70a0220.d98e3.00ab.GAE@google.com>
Subject: [syzbot] [net?] possible deadlock in inet_shutdown (2)
From: syzbot <syzbot+8840610b1405ddb12baa@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d724c6f85e80 Add linux-next specific files for 20251121
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13977a12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=68d11c703cf8e4a0
dashboard link: https://syzkaller.appspot.com/bug?extid=8840610b1405ddb12baa
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0ccfc806f65a/disk-d724c6f8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c2ec31ffb05e/vmlinux-d724c6f8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c25d9c0c1917/bzImage-d724c6f8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8840610b1405ddb12baa@syzkaller.appspotmail.com

block nbd5: Receive control failed (result -107)
======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
kworker/u9:4/5836 is trying to acquire lock:
ffff888054cbb560 (sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1693 [inline]
ffff888054cbb560 (sk_lock-AF_INET){+.+.}-{0:0}, at: inet_shutdown+0x6a/0x390 net/ipv4/af_inet.c:928

but task is already holding lock:
ffff888077f49e70 (&nsock->tx_lock){+.+.}-{4:4}, at: recv_work+0x1b71/0x1ca0 drivers/block/nbd.c:1020

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #5 (&nsock->tx_lock){+.+.}-{4:4}:
       lock_acquire+0x117/0x350 kernel/locking/lockdep.c:5868
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:770
       nbd_handle_cmd drivers/block/nbd.c:1143 [inline]
       nbd_queue_rq+0x257/0xf10 drivers/block/nbd.c:1207
       blk_mq_dispatch_rq_list+0x4c0/0x1900 block/blk-mq.c:2137
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xdac/0x1570 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
       blk_mq_run_hw_queue+0x348/0x4f0 block/blk-mq.c:2375
       blk_mq_dispatch_list+0xd0c/0xe00 include/linux/spinlock.h:-1
       blk_mq_flush_plug_list+0x469/0x550 block/blk-mq.c:2986
       __blk_flush_plug+0x3d3/0x4b0 block/blk-core.c:1225
       blk_finish_plug block/blk-core.c:1252 [inline]
       __submit_bio+0x2d3/0x5a0 block/blk-core.c:651
       __submit_bio_noacct_mq block/blk-core.c:724 [inline]
       submit_bio_noacct_nocheck+0x2eb/0xa50 block/blk-core.c:755
       submit_bh fs/buffer.c:2829 [inline]
       block_read_full_folio+0x599/0x830 fs/buffer.c:2447
       filemap_read_folio+0x117/0x380 mm/filemap.c:2496
       do_read_cache_folio+0x358/0x590 mm/filemap.c:4096
       read_mapping_folio include/linux/pagemap.h:1017 [inline]
       read_part_sector+0xb6/0x2b0 block/partitions/core.c:722
       adfspart_check_ICS+0xa4/0xa50 block/partitions/acorn.c:360
       check_partition block/partitions/core.c:141 [inline]
       blk_add_partitions block/partitions/core.c:589 [inline]
       bdev_disk_changed+0x75f/0x14b0 block/partitions/core.c:693
       blkdev_get_whole+0x380/0x510 block/bdev.c:765
       bdev_open+0x31e/0xd30 block/bdev.c:974
       blkdev_open+0x457/0x600 block/fops.c:703
       do_dentry_open+0x7ce/0x1420 fs/open.c:962
       vfs_open+0x3b/0x340 fs/open.c:1094
       do_open fs/namei.c:4597 [inline]
       path_openat+0x33ce/0x3d90 fs/namei.c:4756
       do_filp_open+0x1fa/0x410 fs/namei.c:4783
       do_sys_openat2+0x121/0x1c0 fs/open.c:1432
       do_sys_open fs/open.c:1447 [inline]
       __do_sys_openat fs/open.c:1463 [inline]
       __se_sys_openat fs/open.c:1458 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1458
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (&cmd->lock){+.+.}-{4:4}:
       lock_acquire+0x117/0x350 kernel/locking/lockdep.c:5868
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:770
       nbd_queue_rq+0xc8/0xf10 drivers/block/nbd.c:1199
       blk_mq_dispatch_rq_list+0x4c0/0x1900 block/blk-mq.c:2137
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xdac/0x1570 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
       blk_mq_run_hw_queue+0x348/0x4f0 block/blk-mq.c:2375
       blk_mq_dispatch_list+0xd0c/0xe00 include/linux/spinlock.h:-1
       blk_mq_flush_plug_list+0x469/0x550 block/blk-mq.c:2986
       __blk_flush_plug+0x3d3/0x4b0 block/blk-core.c:1225
       blk_finish_plug block/blk-core.c:1252 [inline]
       __submit_bio+0x2d3/0x5a0 block/blk-core.c:651
       __submit_bio_noacct_mq block/blk-core.c:724 [inline]
       submit_bio_noacct_nocheck+0x2eb/0xa50 block/blk-core.c:755
       submit_bh fs/buffer.c:2829 [inline]
       block_read_full_folio+0x599/0x830 fs/buffer.c:2447
       filemap_read_folio+0x117/0x380 mm/filemap.c:2496
       do_read_cache_folio+0x358/0x590 mm/filemap.c:4096
       read_mapping_folio include/linux/pagemap.h:1017 [inline]
       read_part_sector+0xb6/0x2b0 block/partitions/core.c:722
       adfspart_check_ICS+0xa4/0xa50 block/partitions/acorn.c:360
       check_partition block/partitions/core.c:141 [inline]
       blk_add_partitions block/partitions/core.c:589 [inline]
       bdev_disk_changed+0x75f/0x14b0 block/partitions/core.c:693
       blkdev_get_whole+0x380/0x510 block/bdev.c:765
       bdev_open+0x31e/0xd30 block/bdev.c:974
       blkdev_open+0x457/0x600 block/fops.c:703
       do_dentry_open+0x7ce/0x1420 fs/open.c:962
       vfs_open+0x3b/0x340 fs/open.c:1094
       do_open fs/namei.c:4597 [inline]
       path_openat+0x33ce/0x3d90 fs/namei.c:4756
       do_filp_open+0x1fa/0x410 fs/namei.c:4783
       do_sys_openat2+0x121/0x1c0 fs/open.c:1432
       do_sys_open fs/open.c:1447 [inline]
       __do_sys_openat fs/open.c:1463 [inline]
       __se_sys_openat fs/open.c:1458 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1458
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (set->srcu){.+.?}-{0:0}:
       lock_sync+0xba/0x160 kernel/locking/lockdep.c:5916
       srcu_lock_sync include/linux/srcu.h:197 [inline]
       __synchronize_srcu+0x96/0x3a0 kernel/rcu/srcutree.c:1503
       blk_throtl_init+0x298/0x410 block/blk-throttle.c:1324
       tg_set_conf+0x1c6/0x4b0 block/blk-throttle.c:1359
       cgroup_file_write+0x3a1/0x740 kernel/cgroup/cgroup.c:4312
       kernfs_fop_write_iter+0x3af/0x540 fs/kernfs/file.c:352
       new_sync_write fs/read_write.c:593 [inline]
       vfs_write+0x5c9/0xb30 fs/read_write.c:686
       ksys_write+0x145/0x250 fs/read_write.c:738
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&q->q_usage_counter(io)#17){++++}-{0:0}:
       lock_acquire+0x117/0x350 kernel/locking/lockdep.c:5868
       blk_alloc_queue+0x538/0x620 block/blk-core.c:461
       blk_mq_alloc_queue block/blk-mq.c:4410 [inline]
       __blk_mq_alloc_disk+0x15c/0x340 block/blk-mq.c:4457
       loop_add+0x411/0xad0 drivers/block/loop.c:2206
       loop_init+0xd9/0x170 drivers/block/loop.c:2441
       do_one_initcall+0x1fb/0x870 init/main.c:1378
       do_initcall_level+0x104/0x190 init/main.c:1440
       do_initcalls+0x59/0xa0 init/main.c:1456
       kernel_init_freeable+0x334/0x4b0 init/main.c:1688
       kernel_init+0x1d/0x1d0 init/main.c:1578
       ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

-> #1 (fs_reclaim){+.+.}-{0:0}:
       lock_acquire+0x117/0x350 kernel/locking/lockdep.c:5868
       __fs_reclaim_acquire mm/page_alloc.c:4301 [inline]
       fs_reclaim_acquire+0x72/0x100 mm/page_alloc.c:4315
       might_alloc include/linux/sched/mm.h:317 [inline]
       slab_pre_alloc_hook mm/slub.c:4899 [inline]
       slab_alloc_node mm/slub.c:5234 [inline]
       kmem_cache_alloc_node_noprof+0x48/0x710 mm/slub.c:5310
       __alloc_skb+0x255/0x430 net/core/skbuff.c:679
       alloc_skb_fclone include/linux/skbuff.h:1433 [inline]
       tcp_stream_alloc_skb+0x3d/0x350 net/ipv4/tcp.c:910
       tcp_sendmsg_locked+0x1c6f/0x5550 net/ipv4/tcp.c:1217
       tcp_sendmsg+0x2f/0x50 net/ipv4/tcp.c:1412
       sock_sendmsg_nosec net/socket.c:727 [inline]
       __sock_sendmsg+0x19c/0x270 net/socket.c:746
       sock_write_iter+0x279/0x360 net/socket.c:1199
       new_sync_write fs/read_write.c:593 [inline]
       vfs_write+0x5c9/0xb30 fs/read_write.c:686
       ksys_write+0x145/0x250 fs/read_write.c:738
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (sk_lock-AF_INET){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain+0xb9b/0x2130 kernel/locking/lockdep.c:3908
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
       lock_acquire+0x117/0x350 kernel/locking/lockdep.c:5868
       lock_sock_nested+0x48/0x100 net/core/sock.c:3762
       lock_sock include/net/sock.h:1693 [inline]
       inet_shutdown+0x6a/0x390 net/ipv4/af_inet.c:928
       nbd_mark_nsock_dead+0x2e9/0x560 drivers/block/nbd.c:318
       recv_work+0x1b86/0x1ca0 drivers/block/nbd.c:1021
       process_one_work+0x93a/0x15e0 kernel/workqueue.c:3261
       process_scheduled_works kernel/workqueue.c:3344 [inline]
       worker_thread+0x9b0/0xee0 kernel/workqueue.c:3425
       kthread+0x711/0x8a0 kernel/kthread.c:463
       ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

other info that might help us debug this:

Chain exists of:
  sk_lock-AF_INET --> &cmd->lock --> &nsock->tx_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&nsock->tx_lock);
                               lock(&cmd->lock);
                               lock(&nsock->tx_lock);
  lock(sk_lock-AF_INET);

 *** DEADLOCK ***

3 locks held by kworker/u9:4/5836:
 #0: ffff8881405f8148 ((wq_completion)nbd5-recv){+.+.}-{0:0}, at: process_one_work+0x841/0x15e0 kernel/workqueue.c:3236
 #1: ffffc9000417fb80 ((work_completion)(&args->work)){+.+.}-{0:0}, at: process_one_work+0x868/0x15e0 kernel/workqueue.c:3237
 #2: ffff888077f49e70 (&nsock->tx_lock){+.+.}-{4:4}, at: recv_work+0x1b71/0x1ca0 drivers/block/nbd.c:1020

stack backtrace:
CPU: 0 UID: 0 PID: 5836 Comm: kworker/u9:4 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Workqueue: nbd5-recv recv_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_circular_bug+0x2ee/0x310 kernel/locking/lockdep.c:2043
 check_noncircular+0x134/0x160 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain+0xb9b/0x2130 kernel/locking/lockdep.c:3908
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
 lock_acquire+0x117/0x350 kernel/locking/lockdep.c:5868
 lock_sock_nested+0x48/0x100 net/core/sock.c:3762
 lock_sock include/net/sock.h:1693 [inline]
 inet_shutdown+0x6a/0x390 net/ipv4/af_inet.c:928
 nbd_mark_nsock_dead+0x2e9/0x560 drivers/block/nbd.c:318
 recv_work+0x1b86/0x1ca0 drivers/block/nbd.c:1021
 process_one_work+0x93a/0x15e0 kernel/workqueue.c:3261
 process_scheduled_works kernel/workqueue.c:3344 [inline]
 worker_thread+0x9b0/0xee0 kernel/workqueue.c:3425
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
Bluetooth: hci4: command 0x0406 tx timeout


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

