Return-Path: <netdev+bounces-227880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0488BB930B
	for <lists+netdev@lfdr.de>; Sun, 05 Oct 2025 02:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 382D93C147E
	for <lists+netdev@lfdr.de>; Sun,  5 Oct 2025 00:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A862ABA4A;
	Sun,  5 Oct 2025 00:02:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8868134BA5F
	for <netdev@vger.kernel.org>; Sun,  5 Oct 2025 00:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759622554; cv=none; b=QWp2ZCzHJZ4bIvJbNLmGwNK+C/uF92mv7GT78wwUtkoW/3GEXQOKw0JwrSm+TJRSYDKC80yl8BPF/K+v+6uVdMkvPu6cnpFW727Q6w2iSWqWWajUC22T5Mf7ajG09G7P+s0mjQQ5N8nhoOiP3NbqRg0g/FhHFKuSxbS8oG5ApOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759622554; c=relaxed/simple;
	bh=lo63t1L+UB05neQU6bwjdC12nyKnjWsSyczwzCbQqv8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cn1UZMoZaRtDxx7bkRXVxk/1lKiWJ1JjTrGAz/43bqNzI/RqULSUwiTCg8otrJOnJtyvLJQwHkrE6JGXw/lNpxXOL5omIR+c8X8riuW9O9cP1ExVlX8q4RNl23UsolvXOcHG3rMAmILRJQi6k0IVexwoECC1li43Nek485IgnJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-42571c700d2so85728215ab.1
        for <netdev@vger.kernel.org>; Sat, 04 Oct 2025 17:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759622551; x=1760227351;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5gbSOXqFdQhFV7RV7nKtZmoWiQqVai1588UeQBrSxg8=;
        b=DOFN6HJx4eewlVMUVRuGMAYVZWs2yorD4U+f4KjDH/lkqw/6IFDZ21oK/OlLBpmuxa
         F00JEFecwrVecPmm/Xal9jHfJr1uFN7sxGMCFeqZzKbWm9S/9JOm1kmYIezqisdnWsmQ
         ZmvzHriG0wgK9jOVMyUaPzVjaPpgerwYVNpFyxm+iKQdpb6Snvb//wUue7tb0lhYeTmd
         5ZBbhyN5FQmWIKUjGIyrOvNif/DJfaPMeuAD/J17OpxuimFoCXxI8rO+WvttcDxbljp7
         EgIK9TG1Qnl9eeg7Cr24J6+T/OS3W4fhMq3Ld5gWivCL/Sno3L/svaTHjP2JT13WgKpj
         9JJg==
X-Forwarded-Encrypted: i=1; AJvYcCWd9a/iGw3lss5rVliXNIRjZSfzod9Sgg8N09MME7aFif2NdK8taZjdQ4b06TCtgGroA7XK8qI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuY+XlhN99fVor1EsDTBK/BU/t8uNxgCsEp8poCLlIkbDlBAgJ
	R2dJVKtD7k+2P0MctJM++tW4949//xy5zeLM5sLl5GEwwydUFCHoK7YpoSILvvZC6/9FSMCGdOx
	y1YFX92Lr1bzqfPTrR7lWQ1BuOolMJj4V6rv043NrE4pbUna6rKbzhL3sPOk=
X-Google-Smtp-Source: AGHT+IF4CfTlFlD8Q0XV5pDqo+m72N2N35dBC5nHoqAge+VTbTQ1Gl56yB1lQ8cHw9h9uLMiCDfmwI03T67Z6ZDYBxXmvbixDSI1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1885:b0:42d:84ec:b5e5 with SMTP id
 e9e14a558f8ab-42e7ad04f91mr111118535ab.3.1759622551648; Sat, 04 Oct 2025
 17:02:31 -0700 (PDT)
Date: Sat, 04 Oct 2025 17:02:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e1b597.a00a0220.102ee.0123.GAE@google.com>
Subject: [syzbot] [net?] possible deadlock in tcp_sigpool_alloc_ahash
From: syzbot <syzbot+6e6d72af97b9d4e47a40@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, kuniyu@google.com, 
	linux-kernel@vger.kernel.org, ncardwell@google.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3b9b1f8df454 Add linux-next specific files for 20250929
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15e88092580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c7c078c891391b1
dashboard link: https://syzkaller.appspot.com/bug?extid=6e6d72af97b9d4e47a40
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1ccfc1a8eb22/disk-3b9b1f8d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c4e52fa84079/vmlinux-3b9b1f8d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9eacf34feeec/bzImage-3b9b1f8d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6e6d72af97b9d4e47a40@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.4.3033/16107 is trying to acquire lock:
ffffffff8fa52dc8 (cpool_mutex){+.+.}-{4:4}, at: tcp_sigpool_alloc_ahash+0x88/0xc70 net/ipv4/tcp_sigpool.c:162

but task is already holding lock:
ffff888021793558 (sk_lock-AF_INET){+.+.}-{0:0}, at: do_tcp_setsockopt+0x854/0x1f20 net/ipv4/tcp.c:3928

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #7 (sk_lock-AF_INET){+.+.}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       lock_sock_nested+0x48/0x100 net/core/sock.c:3720
       lock_sock include/net/sock.h:1679 [inline]
       inet_shutdown+0x6a/0x390 net/ipv4/af_inet.c:907
       nbd_mark_nsock_dead+0x2e9/0x560 drivers/block/nbd.c:318
       sock_shutdown+0x15e/0x260 drivers/block/nbd.c:411
       nbd_clear_sock drivers/block/nbd.c:1424 [inline]
       nbd_config_put+0x342/0x790 drivers/block/nbd.c:1448
       nbd_release+0xfe/0x140 drivers/block/nbd.c:1753
       bdev_release+0x536/0x650 block/bdev.c:-1
       blkdev_release+0x15/0x20 block/fops.c:702
       __fput+0x44c/0xa70 fs/file_table.c:468
       task_work_run+0x1d4/0x260 kernel/task_work.c:227
       exit_task_work include/linux/task_work.h:40 [inline]
       do_exit+0x6b5/0x2300 kernel/exit.c:966
       do_group_exit+0x21c/0x2d0 kernel/exit.c:1107
       get_signal+0x1285/0x1340 kernel/signal.c:3034
       arch_do_signal_or_restart+0xa0/0x790 arch/x86/kernel/signal.c:337
       exit_to_user_mode_loop+0x72/0x130 kernel/entry/common.c:40
       exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
       syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
       syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
       do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #6 (&nsock->tx_lock){+.+.}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:760
       nbd_handle_cmd drivers/block/nbd.c:1140 [inline]
       nbd_queue_rq+0x257/0xf10 drivers/block/nbd.c:1204
       blk_mq_dispatch_rq_list+0x4c0/0x1900 block/blk-mq.c:2129
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xda4/0x1570 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
       blk_mq_run_hw_queue+0x348/0x4f0 block/blk-mq.c:2367
       blk_mq_dispatch_list+0xd0c/0xe00 include/linux/spinlock.h:-1
       blk_mq_flush_plug_list+0x469/0x550 block/blk-mq.c:2976
       __blk_flush_plug+0x3d3/0x4b0 block/blk-core.c:1225
       blk_finish_plug block/blk-core.c:1252 [inline]
       __submit_bio+0x2d3/0x5a0 block/blk-core.c:651
       __submit_bio_noacct_mq block/blk-core.c:724 [inline]
       submit_bio_noacct_nocheck+0x2fb/0xa50 block/blk-core.c:755
       submit_bh fs/buffer.c:2829 [inline]
       block_read_full_folio+0x599/0x830 fs/buffer.c:2447
       filemap_read_folio+0x117/0x380 mm/filemap.c:2444
       do_read_cache_folio+0x350/0x590 mm/filemap.c:4024
       read_mapping_folio include/linux/pagemap.h:999 [inline]
       read_part_sector+0xb6/0x2b0 block/partitions/core.c:722
       adfspart_check_ICS+0xa4/0xa50 block/partitions/acorn.c:360
       check_partition block/partitions/core.c:141 [inline]
       blk_add_partitions block/partitions/core.c:589 [inline]
       bdev_disk_changed+0x75f/0x14b0 block/partitions/core.c:693
       blkdev_get_whole+0x380/0x510 block/bdev.c:748
       bdev_open+0x31e/0xd30 block/bdev.c:957
       blkdev_open+0x457/0x600 block/fops.c:694
       do_dentry_open+0x953/0x13f0 fs/open.c:965
       vfs_open+0x3b/0x340 fs/open.c:1097
       do_open fs/namei.c:3975 [inline]
       path_openat+0x2ee5/0x3830 fs/namei.c:4134
       do_filp_open+0x1fa/0x410 fs/namei.c:4161
       do_sys_openat2+0x121/0x1c0 fs/open.c:1437
       do_sys_open fs/open.c:1452 [inline]
       __do_sys_openat fs/open.c:1468 [inline]
       __se_sys_openat fs/open.c:1463 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1463
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #5 (&cmd->lock){+.+.}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:760
       nbd_queue_rq+0xc8/0xf10 drivers/block/nbd.c:1196
       blk_mq_dispatch_rq_list+0x4c0/0x1900 block/blk-mq.c:2129
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xda4/0x1570 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
       blk_mq_run_hw_queue+0x348/0x4f0 block/blk-mq.c:2367
       blk_mq_dispatch_list+0xd0c/0xe00 include/linux/spinlock.h:-1
       blk_mq_flush_plug_list+0x469/0x550 block/blk-mq.c:2976
       __blk_flush_plug+0x3d3/0x4b0 block/blk-core.c:1225
       blk_finish_plug block/blk-core.c:1252 [inline]
       __submit_bio+0x2d3/0x5a0 block/blk-core.c:651
       __submit_bio_noacct_mq block/blk-core.c:724 [inline]
       submit_bio_noacct_nocheck+0x2fb/0xa50 block/blk-core.c:755
       submit_bh fs/buffer.c:2829 [inline]
       block_read_full_folio+0x599/0x830 fs/buffer.c:2447
       filemap_read_folio+0x117/0x380 mm/filemap.c:2444
       do_read_cache_folio+0x350/0x590 mm/filemap.c:4024
       read_mapping_folio include/linux/pagemap.h:999 [inline]
       read_part_sector+0xb6/0x2b0 block/partitions/core.c:722
       adfspart_check_ICS+0xa4/0xa50 block/partitions/acorn.c:360
       check_partition block/partitions/core.c:141 [inline]
       blk_add_partitions block/partitions/core.c:589 [inline]
       bdev_disk_changed+0x75f/0x14b0 block/partitions/core.c:693
       blkdev_get_whole+0x380/0x510 block/bdev.c:748
       bdev_open+0x31e/0xd30 block/bdev.c:957
       blkdev_open+0x457/0x600 block/fops.c:694
       do_dentry_open+0x953/0x13f0 fs/open.c:965
       vfs_open+0x3b/0x340 fs/open.c:1097
       do_open fs/namei.c:3975 [inline]
       path_openat+0x2ee5/0x3830 fs/namei.c:4134
       do_filp_open+0x1fa/0x410 fs/namei.c:4161
       do_sys_openat2+0x121/0x1c0 fs/open.c:1437
       do_sys_open fs/open.c:1452 [inline]
       __do_sys_openat fs/open.c:1468 [inline]
       __se_sys_openat fs/open.c:1463 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1463
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (set->srcu){.+.+}-{0:0}:
       lock_sync+0xba/0x160 kernel/locking/lockdep.c:5916
       srcu_lock_sync include/linux/srcu.h:173 [inline]
       __synchronize_srcu+0x96/0x3a0 kernel/rcu/srcutree.c:1439
       elevator_switch+0x12b/0x640 block/elevator.c:588
       elevator_change+0x315/0x4c0 block/elevator.c:691
       elevator_set_default+0x186/0x260 block/elevator.c:767
       blk_register_queue+0x34e/0x3f0 block/blk-sysfs.c:942
       __add_disk+0x677/0xd50 block/genhd.c:528
       add_disk_fwnode+0xfc/0x480 block/genhd.c:597
       add_disk include/linux/blkdev.h:775 [inline]
       nbd_dev_add+0x717/0xae0 drivers/block/nbd.c:1981
       nbd_init+0x168/0x1f0 drivers/block/nbd.c:2688
       do_one_initcall+0x236/0x820 init/main.c:1283
       do_initcall_level+0x104/0x190 init/main.c:1345
       do_initcalls+0x59/0xa0 init/main.c:1361
       kernel_init_freeable+0x334/0x4b0 init/main.c:1593
       kernel_init+0x1d/0x1d0 init/main.c:1483
       ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #3 (&q->elevator_lock){+.+.}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:760
       elevator_change+0x1e5/0x4c0 block/elevator.c:689
       elevator_set_none+0x42/0xb0 block/elevator.c:782
       blk_mq_elv_switch_none block/blk-mq.c:5032 [inline]
       __blk_mq_update_nr_hw_queues block/blk-mq.c:5075 [inline]
       blk_mq_update_nr_hw_queues+0x598/0x1ab0 block/blk-mq.c:5133
       nbd_start_device+0x17f/0xb10 drivers/block/nbd.c:1486
       nbd_genl_connect+0x135b/0x18f0 drivers/block/nbd.c:2236
       genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
       genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
       genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
       netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
       netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
       netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
       netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
       sock_sendmsg_nosec net/socket.c:714 [inline]
       __sock_sendmsg+0x21c/0x270 net/socket.c:729
       ____sys_sendmsg+0x505/0x830 net/socket.c:2617
       ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2671
       __sys_sendmsg net/socket.c:2703 [inline]
       __do_sys_sendmsg net/socket.c:2708 [inline]
       __se_sys_sendmsg net/socket.c:2706 [inline]
       __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2706
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&q->q_usage_counter(io)#49){++++}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       blk_alloc_queue+0x538/0x620 block/blk-core.c:461
       blk_mq_alloc_queue block/blk-mq.c:4399 [inline]
       __blk_mq_alloc_disk+0x15c/0x340 block/blk-mq.c:4446
       nbd_dev_add+0x46c/0xae0 drivers/block/nbd.c:1951
       nbd_init+0x168/0x1f0 drivers/block/nbd.c:2688
       do_one_initcall+0x236/0x820 init/main.c:1283
       do_initcall_level+0x104/0x190 init/main.c:1345
       do_initcalls+0x59/0xa0 init/main.c:1361
       kernel_init_freeable+0x334/0x4b0 init/main.c:1593
       kernel_init+0x1d/0x1d0 init/main.c:1483
       ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #1 (fs_reclaim){+.+.}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __fs_reclaim_acquire mm/page_alloc.c:4269 [inline]
       fs_reclaim_acquire+0x72/0x100 mm/page_alloc.c:4283
       might_alloc include/linux/sched/mm.h:318 [inline]
       slab_pre_alloc_hook mm/slub.c:4897 [inline]
       slab_alloc_node mm/slub.c:5221 [inline]
       __do_kmalloc_node mm/slub.c:5602 [inline]
       __kmalloc_noprof+0x9c/0x7f0 mm/slub.c:5615
       kmalloc_noprof include/linux/slab.h:961 [inline]
       sigpool_reserve_scratch net/ipv4/tcp_sigpool.c:66 [inline]
       tcp_sigpool_alloc_ahash+0x144/0xc70 net/ipv4/tcp_sigpool.c:163
       tcp_md5_alloc_sigpool+0x1b/0x50 net/ipv4/tcp.c:4824
       tcp_md5_do_add+0x107/0x3a0 net/ipv4/tcp_ipv4.c:1428
       tcp_v6_parse_md5_keys+0x4df/0x610 net/ipv6/tcp_ipv6.c:-1
       do_tcp_setsockopt+0x11dc/0x1f20 net/ipv4/tcp.c:4059
       do_sock_setsockopt+0x17c/0x1b0 net/socket.c:2347
       __sys_setsockopt net/socket.c:2372 [inline]
       __do_sys_setsockopt net/socket.c:2378 [inline]
       __se_sys_setsockopt net/socket.c:2375 [inline]
       __x64_sys_setsockopt+0x13f/0x1b0 net/socket.c:2375
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (cpool_mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:760
       tcp_sigpool_alloc_ahash+0x88/0xc70 net/ipv4/tcp_sigpool.c:162
       tcp_md5_alloc_sigpool+0x1b/0x50 net/ipv4/tcp.c:4824
       tcp_md5_do_add+0x107/0x3a0 net/ipv4/tcp_ipv4.c:1428
       tcp_v4_parse_md5_keys+0x412/0x600 net/ipv4/tcp_ipv4.c:1577
       do_tcp_setsockopt+0x11dc/0x1f20 net/ipv4/tcp.c:4059
       do_sock_setsockopt+0x17c/0x1b0 net/socket.c:2347
       __sys_setsockopt net/socket.c:2372 [inline]
       __do_sys_setsockopt net/socket.c:2378 [inline]
       __se_sys_setsockopt net/socket.c:2375 [inline]
       __x64_sys_setsockopt+0x13f/0x1b0 net/socket.c:2375
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  cpool_mutex --> &nsock->tx_lock --> sk_lock-AF_INET

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sk_lock-AF_INET);
                               lock(&nsock->tx_lock);
                               lock(sk_lock-AF_INET);
  lock(cpool_mutex);

 *** DEADLOCK ***

1 lock held by syz.4.3033/16107:
 #0: ffff888021793558 (sk_lock-AF_INET){+.+.}-{0:0}, at: do_tcp_setsockopt+0x854/0x1f20 net/ipv4/tcp.c:3928

stack backtrace:
CPU: 0 UID: 0 PID: 16107 Comm: syz.4.3033 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_circular_bug+0x2ee/0x310 kernel/locking/lockdep.c:2043
 check_noncircular+0x134/0x160 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 __mutex_lock_common kernel/locking/mutex.c:598 [inline]
 __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:760
 tcp_sigpool_alloc_ahash+0x88/0xc70 net/ipv4/tcp_sigpool.c:162
 tcp_md5_alloc_sigpool+0x1b/0x50 net/ipv4/tcp.c:4824
 tcp_md5_do_add+0x107/0x3a0 net/ipv4/tcp_ipv4.c:1428
 tcp_v4_parse_md5_keys+0x412/0x600 net/ipv4/tcp_ipv4.c:1577
 do_tcp_setsockopt+0x11dc/0x1f20 net/ipv4/tcp.c:4059
 do_sock_setsockopt+0x17c/0x1b0 net/socket.c:2347
 __sys_setsockopt net/socket.c:2372 [inline]
 __do_sys_setsockopt net/socket.c:2378 [inline]
 __se_sys_setsockopt net/socket.c:2375 [inline]
 __x64_sys_setsockopt+0x13f/0x1b0 net/socket.c:2375
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe60a78eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe60b545038 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00007fe60a9e5fa0 RCX: 00007fe60a78eec9
RDX: 000000000000000e RSI: 0000000000000006 RDI: 0000000000000004
RBP: 00007fe60a811f91 R08: 00000000000000d8 R09: 0000000000000000
R10: 0000200000000200 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fe60a9e6038 R14: 00007fe60a9e5fa0 R15: 00007ffc33a46b58
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

