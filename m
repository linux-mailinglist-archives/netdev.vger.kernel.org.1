Return-Path: <netdev+bounces-227514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8A4BB1B0E
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 22:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AD3919C221A
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 20:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA7D30215C;
	Wed,  1 Oct 2025 20:29:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018C42877F0
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 20:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759350576; cv=none; b=bJjj3mRraPrSTQgd0UUS+niVGDhe/iTMuGYYHXOxr3pIqqWibisZXHIDqWh8Qrg4I9x7w7Z///yn3wZ7K5D6uUBRYhBdFQAcvb5u1LCc/k4VRhNi3Dw/0eL6xiCN54aqrMJ5eViYQ7xPGdbpa5cNbgckiRkSkehZc9VbhfKqoGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759350576; c=relaxed/simple;
	bh=xizJpJhs20vwWazvCxAuKvGZtI0dKM36cAiWmPw+rYE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=b/GZ7s5vuzfCqkFiAzDuyOkyOwF3tEn1IXsYr8ijXRvcGzSSX47M1XeDTpRk8niGhCcdgg6mfhhmlFoDfW+SRqlSzRMggsJho5YUGAzwlpiRQ6LJ6gREkzV/rkoaQkW5j17X5P1biIJ7E0Cir0dtCmWFudyZXSAcQm3Xl5HC6MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-8ccb7d90c82so33806539f.2
        for <netdev@vger.kernel.org>; Wed, 01 Oct 2025 13:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759350572; x=1759955372;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=totY7WNqyQ5roC2m9h3qPfIgzk0ngZ3k1XLYvM9LS/g=;
        b=LxRrGcAUpp7Y7gFZEBkjLtd7sIV96H9Jq7LPSf59/xYWtJlLpK5UVDfxjVF9LPXiia
         G6/W9P58ZmoKMWOk0XjbwXeOxgWRS25N8aJ71RfDiiivTvIff7ntGUVndeLuYnkA4O6N
         gp7/enYTgodVkU1cAX1qDcbdXFUo39OIkEihkXg7tppwhDB+MFXw+PzQ+ziQIi8ZMg2B
         3CeyG7FPKLtNrVFrr2VGLyrHaduiiPqBy3xu6ODo7iPo1+4WogFokKNLMh+tHkw1ElF2
         MZxJISRkiou3GkjdanSGrvyiOAunNIKgGkdCH0DztH8jiTLozepmsmqFspX0UTKZlsl6
         5c7g==
X-Forwarded-Encrypted: i=1; AJvYcCU8ecpO1OlCvj/Eq2IRMeRhKN6ITRaaxrLZHJUCUbNcScgPUoHEU50XKv9w58gSDZuwef12Q+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk76brLzTzHgigPxZh+lf2VChQbe4BULgFUHd4Vv2N1lqBm6ve
	7VY6nJMgrraO2YJ+ycn9aAi/tYJQfhd9aK4SFEF6bg3I6TBmkICwDKUgSn0x0Xhy65ksmumefDA
	tL3ILTny8WFK7IK7gC1DAseCarSTvO8GO7PIzRIMqhMPM2AdMcK+ubMtqBw0=
X-Google-Smtp-Source: AGHT+IGWTKhtj8yQkyJyKiigBZehXomZzCD2byeTUaQp4EmQiaP7UXIIuct5IeDGC9z9mr9IInwOhMnYwYT5A8pDLquuQA5BAE9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2185:b0:42d:80fb:734b with SMTP id
 e9e14a558f8ab-42d81612bd3mr68294395ab.14.1759350572006; Wed, 01 Oct 2025
 13:29:32 -0700 (PDT)
Date: Wed, 01 Oct 2025 13:29:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dd8f2b.a00a0220.102ee.0063.GAE@google.com>
Subject: [syzbot] [net?] possible deadlock in l2tp_ip6_sendmsg
From: syzbot <syzbot+a2667f4df816b1e2651f@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    30d4efb2f5a5 Merge tag 'for-linus-6.18-rc1-tag' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13908092580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=15ae667b7d4fba35
dashboard link: https://syzkaller.appspot.com/bug?extid=a2667f4df816b1e2651f
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0d17a722ec0e/disk-30d4efb2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f57b31c84a36/vmlinux-30d4efb2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8fafc96499a6/bzImage-30d4efb2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a2667f4df816b1e2651f@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.1.353/7583 is trying to acquire lock:
ffffffff8e35c620 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:318 [inline]
ffffffff8e35c620 (fs_reclaim){+.+.}-{0:0}, at: prepare_alloc_pages+0x162/0x610 mm/page_alloc.c:4916

but task is already holding lock:
ffff888075fc0258 (sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1669 [inline]
ffff888075fc0258 (sk_lock-AF_INET6){+.+.}-{0:0}, at: l2tp_ip6_sendmsg+0xf58/0x1e70 net/l2tp/l2tp_ip6.c:652

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #6 (sk_lock-AF_INET6){+.+.}-{0:0}:
       lock_sock_nested+0x41/0xf0 net/core/sock.c:3711
       lock_sock include/net/sock.h:1669 [inline]
       inet_autobind+0x1a/0x1a0 net/ipv4/af_inet.c:178
       inet_send_prepare+0x31b/0x530 net/ipv4/af_inet.c:837
       inet_sendmsg+0x43/0x140 net/ipv4/af_inet.c:848
       sock_sendmsg_nosec net/socket.c:714 [inline]
       __sock_sendmsg net/socket.c:729 [inline]
       sock_sendmsg+0x37f/0x470 net/socket.c:752
       __sock_xmit+0x1e7/0x4f0 drivers/block/nbd.c:574
       sock_xmit drivers/block/nbd.c:602 [inline]
       nbd_send_cmd+0x8e4/0x1c90 drivers/block/nbd.c:712
       nbd_handle_cmd drivers/block/nbd.c:1174 [inline]
       nbd_queue_rq+0x940/0x12d0 drivers/block/nbd.c:1204
       blk_mq_dispatch_rq_list+0x416/0x1e20 block/blk-mq.c:2120
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xcb7/0x15f0 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd8/0x1b0 block/blk-mq-sched.c:329
       blk_mq_run_hw_queue+0x239/0x670 block/blk-mq.c:2358
       blk_mq_dispatch_list+0x514/0x1310 block/blk-mq.c:2919
       blk_mq_flush_plug_list block/blk-mq.c:2967 [inline]
       blk_mq_flush_plug_list+0x130/0x600 block/blk-mq.c:2939
       __blk_flush_plug+0x2c4/0x4b0 block/blk-core.c:1222
       blk_finish_plug block/blk-core.c:1249 [inline]
       blk_finish_plug block/blk-core.c:1246 [inline]
       __submit_bio+0x545/0x690 block/blk-core.c:651
       __submit_bio_noacct_mq block/blk-core.c:724 [inline]
       submit_bio_noacct_nocheck+0x660/0xd30 block/blk-core.c:753
       submit_bio_noacct+0xb49/0x1ed0 block/blk-core.c:876
       submit_bh fs/buffer.c:2829 [inline]
       block_read_full_folio+0x4db/0x850 fs/buffer.c:2461
       filemap_read_folio+0xc5/0x2a0 mm/filemap.c:2413
       do_read_cache_folio+0x263/0x5c0 mm/filemap.c:3957
       read_mapping_folio include/linux/pagemap.h:991 [inline]
       read_part_sector+0xd4/0x370 block/partitions/core.c:722
       adfspart_check_ICS+0x93/0x940 block/partitions/acorn.c:360
       check_partition block/partitions/core.c:141 [inline]
       blk_add_partitions block/partitions/core.c:589 [inline]
       bdev_disk_changed+0x720/0x1520 block/partitions/core.c:693
       blkdev_get_whole+0x187/0x290 block/bdev.c:748
       bdev_open+0x2c7/0xe40 block/bdev.c:957
       blkdev_open+0x34e/0x4f0 block/fops.c:694
       do_dentry_open+0x97f/0x1530 fs/open.c:965
       vfs_open+0x82/0x3f0 fs/open.c:1095
       do_open fs/namei.c:3975 [inline]
       path_openat+0x1de4/0x2cb0 fs/namei.c:4134
       do_filp_open+0x20b/0x470 fs/namei.c:4161
       do_sys_openat2+0x11b/0x1d0 fs/open.c:1435
       do_sys_open fs/open.c:1450 [inline]
       __do_sys_openat fs/open.c:1466 [inline]
       __se_sys_openat fs/open.c:1461 [inline]
       __x64_sys_openat+0x174/0x210 fs/open.c:1461
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #5 (&nsock->tx_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x193/0x1060 kernel/locking/mutex.c:760
       nbd_handle_cmd drivers/block/nbd.c:1140 [inline]
       nbd_queue_rq+0x423/0x12d0 drivers/block/nbd.c:1204
       blk_mq_dispatch_rq_list+0x416/0x1e20 block/blk-mq.c:2120
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xcb7/0x15f0 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd8/0x1b0 block/blk-mq-sched.c:329
       blk_mq_run_hw_queue+0x239/0x670 block/blk-mq.c:2358
       blk_mq_dispatch_list+0x514/0x1310 block/blk-mq.c:2919
       blk_mq_flush_plug_list block/blk-mq.c:2967 [inline]
       blk_mq_flush_plug_list+0x130/0x600 block/blk-mq.c:2939
       __blk_flush_plug+0x2c4/0x4b0 block/blk-core.c:1222
       blk_finish_plug block/blk-core.c:1249 [inline]
       blk_finish_plug block/blk-core.c:1246 [inline]
       __submit_bio+0x545/0x690 block/blk-core.c:651
       __submit_bio_noacct_mq block/blk-core.c:724 [inline]
       submit_bio_noacct_nocheck+0x660/0xd30 block/blk-core.c:753
       submit_bio_noacct+0xb49/0x1ed0 block/blk-core.c:876
       submit_bh fs/buffer.c:2829 [inline]
       block_read_full_folio+0x4db/0x850 fs/buffer.c:2461
       filemap_read_folio+0xc5/0x2a0 mm/filemap.c:2413
       do_read_cache_folio+0x263/0x5c0 mm/filemap.c:3957
       read_mapping_folio include/linux/pagemap.h:991 [inline]
       read_part_sector+0xd4/0x370 block/partitions/core.c:722
       adfspart_check_ICS+0x93/0x940 block/partitions/acorn.c:360
       check_partition block/partitions/core.c:141 [inline]
       blk_add_partitions block/partitions/core.c:589 [inline]
       bdev_disk_changed+0x720/0x1520 block/partitions/core.c:693
       blkdev_get_whole+0x187/0x290 block/bdev.c:748
       bdev_open+0x2c7/0xe40 block/bdev.c:957
       blkdev_open+0x34e/0x4f0 block/fops.c:694
       do_dentry_open+0x97f/0x1530 fs/open.c:965
       vfs_open+0x82/0x3f0 fs/open.c:1095
       do_open fs/namei.c:3975 [inline]
       path_openat+0x1de4/0x2cb0 fs/namei.c:4134
       do_filp_open+0x20b/0x470 fs/namei.c:4161
       do_sys_openat2+0x11b/0x1d0 fs/open.c:1435
       do_sys_open fs/open.c:1450 [inline]
       __do_sys_openat fs/open.c:1466 [inline]
       __se_sys_openat fs/open.c:1461 [inline]
       __x64_sys_openat+0x174/0x210 fs/open.c:1461
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (&cmd->lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x193/0x1060 kernel/locking/mutex.c:760
       nbd_queue_rq+0xbd/0x12d0 drivers/block/nbd.c:1196
       blk_mq_dispatch_rq_list+0x416/0x1e20 block/blk-mq.c:2120
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xcb7/0x15f0 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd8/0x1b0 block/blk-mq-sched.c:329
       blk_mq_run_hw_queue+0x239/0x670 block/blk-mq.c:2358
       blk_mq_dispatch_list+0x514/0x1310 block/blk-mq.c:2919
       blk_mq_flush_plug_list block/blk-mq.c:2967 [inline]
       blk_mq_flush_plug_list+0x130/0x600 block/blk-mq.c:2939
       __blk_flush_plug+0x2c4/0x4b0 block/blk-core.c:1222
       blk_finish_plug block/blk-core.c:1249 [inline]
       blk_finish_plug block/blk-core.c:1246 [inline]
       __submit_bio+0x545/0x690 block/blk-core.c:651
       __submit_bio_noacct_mq block/blk-core.c:724 [inline]
       submit_bio_noacct_nocheck+0x660/0xd30 block/blk-core.c:753
       submit_bio_noacct+0xb49/0x1ed0 block/blk-core.c:876
       submit_bh fs/buffer.c:2829 [inline]
       block_read_full_folio+0x4db/0x850 fs/buffer.c:2461
       filemap_read_folio+0xc5/0x2a0 mm/filemap.c:2413
       do_read_cache_folio+0x263/0x5c0 mm/filemap.c:3957
       read_mapping_folio include/linux/pagemap.h:991 [inline]
       read_part_sector+0xd4/0x370 block/partitions/core.c:722
       adfspart_check_ICS+0x93/0x940 block/partitions/acorn.c:360
       check_partition block/partitions/core.c:141 [inline]
       blk_add_partitions block/partitions/core.c:589 [inline]
       bdev_disk_changed+0x720/0x1520 block/partitions/core.c:693
       blkdev_get_whole+0x187/0x290 block/bdev.c:748
       bdev_open+0x2c7/0xe40 block/bdev.c:957
       blkdev_open+0x34e/0x4f0 block/fops.c:694
       do_dentry_open+0x97f/0x1530 fs/open.c:965
       vfs_open+0x82/0x3f0 fs/open.c:1095
       do_open fs/namei.c:3975 [inline]
       path_openat+0x1de4/0x2cb0 fs/namei.c:4134
       do_filp_open+0x20b/0x470 fs/namei.c:4161
       do_sys_openat2+0x11b/0x1d0 fs/open.c:1435
       do_sys_open fs/open.c:1450 [inline]
       __do_sys_openat fs/open.c:1466 [inline]
       __se_sys_openat fs/open.c:1461 [inline]
       __x64_sys_openat+0x174/0x210 fs/open.c:1461
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (set->srcu){.+.+}-{0:0}:
       srcu_lock_sync include/linux/srcu.h:173 [inline]
       __synchronize_srcu+0xa1/0x290 kernel/rcu/srcutree.c:1429
       blk_mq_wait_quiesce_done block/blk-mq.c:283 [inline]
       blk_mq_wait_quiesce_done block/blk-mq.c:280 [inline]
       blk_mq_quiesce_queue block/blk-mq.c:303 [inline]
       blk_mq_quiesce_queue+0x149/0x1b0 block/blk-mq.c:298
       elevator_switch+0x17d/0x810 block/elevator.c:588
       elevator_change+0x391/0x580 block/elevator.c:690
       elevator_set_default+0x2e9/0x380 block/elevator.c:766
       blk_register_queue+0x384/0x4e0 block/blk-sysfs.c:904
       __add_disk+0x74a/0xf00 block/genhd.c:528
       add_disk_fwnode+0x13f/0x5d0 block/genhd.c:597
       add_disk include/linux/blkdev.h:774 [inline]
       nbd_dev_add+0x783/0xbb0 drivers/block/nbd.c:1973
       nbd_init+0x181/0x320 drivers/block/nbd.c:2680
       do_one_initcall+0x120/0x6e0 init/main.c:1271
       do_initcall_level init/main.c:1333 [inline]
       do_initcalls init/main.c:1349 [inline]
       do_basic_setup init/main.c:1368 [inline]
       kernel_init_freeable+0x5c2/0x910 init/main.c:1581
       kernel_init+0x1c/0x2b0 init/main.c:1471
       ret_from_fork+0x56d/0x730 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #2 (&q->elevator_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x193/0x1060 kernel/locking/mutex.c:760
       elevator_change+0x17d/0x580 block/elevator.c:688
       elv_iosched_store+0x315/0x3c0 block/elevator.c:823
       queue_attr_store+0x26b/0x310 block/blk-sysfs.c:831
       sysfs_kf_write+0xef/0x150 fs/sysfs/file.c:145
       kernfs_fop_write_iter+0x3ac/0x570 fs/kernfs/file.c:352
       new_sync_write fs/read_write.c:593 [inline]
       vfs_write+0x7d3/0x11d0 fs/read_write.c:686
       ksys_write+0x12a/0x250 fs/read_write.c:738
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&q->q_usage_counter(io)#62){++++}-{0:0}:
       blk_alloc_queue+0x619/0x760 block/blk-core.c:461
       blk_mq_alloc_queue+0x172/0x280 block/blk-mq.c:4400
       __blk_mq_alloc_disk+0x29/0x120 block/blk-mq.c:4447
       nbd_dev_add+0x492/0xbb0 drivers/block/nbd.c:1943
       nbd_init+0x181/0x320 drivers/block/nbd.c:2680
       do_one_initcall+0x120/0x6e0 init/main.c:1271
       do_initcall_level init/main.c:1333 [inline]
       do_initcalls init/main.c:1349 [inline]
       do_basic_setup init/main.c:1368 [inline]
       kernel_init_freeable+0x5c2/0x910 init/main.c:1581
       kernel_init+0x1c/0x2b0 init/main.c:1471
       ret_from_fork+0x56d/0x730 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x12a6/0x1ce0 kernel/locking/lockdep.c:5237
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5825
       __fs_reclaim_acquire mm/page_alloc.c:4234 [inline]
       fs_reclaim_acquire+0x102/0x150 mm/page_alloc.c:4248
       might_alloc include/linux/sched/mm.h:318 [inline]
       prepare_alloc_pages+0x162/0x610 mm/page_alloc.c:4916
       __alloc_frozen_pages_noprof+0x18b/0x23f0 mm/page_alloc.c:5137
       alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2416
       alloc_frozen_pages_noprof mm/mempolicy.c:2487 [inline]
       alloc_pages_noprof+0x131/0x390 mm/mempolicy.c:2507
       pagetable_alloc_noprof include/linux/mm.h:2881 [inline]
       pmd_alloc_one_noprof include/asm-generic/pgalloc.h:142 [inline]
       __pmd_alloc+0x3b/0x930 mm/memory.c:6450
       pmd_alloc include/linux/mm.h:2844 [inline]
       __handle_mm_fault+0xa06/0x2a50 mm/memory.c:6155
       handle_mm_fault+0x589/0xd10 mm/memory.c:6364
       do_user_addr_fault+0x7a6/0x1370 arch/x86/mm/fault.c:1387
       handle_page_fault arch/x86/mm/fault.c:1476 [inline]
       exc_page_fault+0x5c/0xb0 arch/x86/mm/fault.c:1532
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
       rep_movs_alternative+0x4a/0x90 arch/x86/lib/copy_user_64.S:68
       copy_user_generic arch/x86/include/asm/uaccess_64.h:126 [inline]
       raw_copy_from_user arch/x86/include/asm/uaccess_64.h:141 [inline]
       _inline_copy_from_user include/linux/uaccess.h:178 [inline]
       _copy_from_user+0x98/0xd0 lib/usercopy.c:18
       copy_from_user include/linux/uaccess.h:212 [inline]
       csum_and_copy_from_user include/net/checksum.h:31 [inline]
       copy_from_user_iter_csum net/core/skbuff.c:7323 [inline]
       iterate_ubuf include/linux/iov_iter.h:30 [inline]
       iterate_and_advance2 include/linux/iov_iter.h:302 [inline]
       csum_and_copy_from_iter_full+0x21a/0x1f90 net/core/skbuff.c:7335
       ip_generic_getfrag+0x170/0x270 net/ipv4/ip_output.c:940
       __ip6_append_data+0x2e36/0x4750 net/ipv6/ip6_output.c:1706
       ip6_append_data+0x1bd/0x4c0 net/ipv6/ip6_output.c:1860
       l2tp_ip6_sendmsg+0xfe6/0x1e70 net/l2tp/l2tp_ip6.c:654
       inet_sendmsg+0x11c/0x140 net/ipv4/af_inet.c:851
       sock_sendmsg_nosec net/socket.c:714 [inline]
       __sock_sendmsg net/socket.c:729 [inline]
       __sys_sendto+0x43c/0x520 net/socket.c:2231
       __do_sys_sendto net/socket.c:2238 [inline]
       __se_sys_sendto net/socket.c:2234 [inline]
       __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2234
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  fs_reclaim --> &nsock->tx_lock --> sk_lock-AF_INET6

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sk_lock-AF_INET6);
                               lock(&nsock->tx_lock);
                               lock(sk_lock-AF_INET6);
  lock(fs_reclaim);

 *** DEADLOCK ***

2 locks held by syz.1.353/7583:
 #0: ffff888075fc0258 (sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1669 [inline]
 #0: ffff888075fc0258 (sk_lock-AF_INET6){+.+.}-{0:0}, at: l2tp_ip6_sendmsg+0xf58/0x1e70 net/l2tp/l2tp_ip6.c:652
 #1: ffff88807ca2d7e0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_trylock include/linux/mmap_lock.h:472 [inline]
 #1: ffff88807ca2d7e0 (&mm->mmap_lock){++++}-{4:4}, at: get_mmap_lock_carefully mm/mmap_lock.c:277 [inline]
 #1: ffff88807ca2d7e0 (&mm->mmap_lock){++++}-{4:4}, at: lock_mm_and_find_vma+0x35/0x6e0 mm/mmap_lock.c:337

stack backtrace:
CPU: 1 UID: 0 PID: 7583 Comm: syz.1.353 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x275/0x350 kernel/locking/lockdep.c:2043
 check_noncircular+0x14c/0x170 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x12a6/0x1ce0 kernel/locking/lockdep.c:5237
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5825
 __fs_reclaim_acquire mm/page_alloc.c:4234 [inline]
 fs_reclaim_acquire+0x102/0x150 mm/page_alloc.c:4248
 might_alloc include/linux/sched/mm.h:318 [inline]
 prepare_alloc_pages+0x162/0x610 mm/page_alloc.c:4916
 __alloc_frozen_pages_noprof+0x18b/0x23f0 mm/page_alloc.c:5137
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2416
 alloc_frozen_pages_noprof mm/mempolicy.c:2487 [inline]
 alloc_pages_noprof+0x131/0x390 mm/mempolicy.c:2507
 pagetable_alloc_noprof include/linux/mm.h:2881 [inline]
 pmd_alloc_one_noprof include/asm-generic/pgalloc.h:142 [inline]
 __pmd_alloc+0x3b/0x930 mm/memory.c:6450
 pmd_alloc include/linux/mm.h:2844 [inline]
 __handle_mm_fault+0xa06/0x2a50 mm/memory.c:6155
 handle_mm_fault+0x589/0xd10 mm/memory.c:6364
 do_user_addr_fault+0x7a6/0x1370 arch/x86/mm/fault.c:1387
 handle_page_fault arch/x86/mm/fault.c:1476 [inline]
 exc_page_fault+0x5c/0xb0 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:rep_movs_alternative+0x4a/0x90 arch/x86/lib/copy_user_64.S:74
Code: 1e 04 00 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 8b 06 48 89 07 48 83 c6 08 48 83 c7 08 83 e9 08 74 db 83 f9 08 73 e8 eb c5 <f3> a4 e9 4f 1e 04 00 48 8b 06 48 89 07 48 8d 47 08 48 83 e0 f8 48
RSP: 0018:ffffc9000e67f648 EFLAGS: 00050202
RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000402
RDX: ffffed100f846e89 RSI: 0000000000000000 RDI: ffff88807c237044
RBP: 0000000000000402 R08: 0000000000000001 R09: ffffed100f846e88
R10: ffff88807c237445 R11: 0000000000000000 R12: 0000000000000000
R13: ffff88807c237044 R14: 0000000000000000 R15: 0000000000000402
 copy_user_generic arch/x86/include/asm/uaccess_64.h:126 [inline]
 raw_copy_from_user arch/x86/include/asm/uaccess_64.h:141 [inline]
 _inline_copy_from_user include/linux/uaccess.h:178 [inline]
 _copy_from_user+0x98/0xd0 lib/usercopy.c:18
 copy_from_user include/linux/uaccess.h:212 [inline]
 csum_and_copy_from_user include/net/checksum.h:31 [inline]
 copy_from_user_iter_csum net/core/skbuff.c:7323 [inline]
 iterate_ubuf include/linux/iov_iter.h:30 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:302 [inline]
 csum_and_copy_from_iter_full+0x21a/0x1f90 net/core/skbuff.c:7335
 ip_generic_getfrag+0x170/0x270 net/ipv4/ip_output.c:940
 __ip6_append_data+0x2e36/0x4750 net/ipv6/ip6_output.c:1706
 ip6_append_data+0x1bd/0x4c0 net/ipv6/ip6_output.c:1860
 l2tp_ip6_sendmsg+0xfe6/0x1e70 net/l2tp/l2tp_ip6.c:654
 inet_sendmsg+0x11c/0x140 net/ipv4/af_inet.c:851
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg net/socket.c:729 [inline]
 __sys_sendto+0x43c/0x520 net/socket.c:2231
 __do_sys_sendto net/socket.c:2238 [inline]
 __se_sys_sendto net/socket.c:2234 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2234
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7dbc78eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7dbd580038 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f7dbc9e5fa0 RCX: 00007f7dbc78eec9
RDX: 0000000000000402 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f7dbc811f91 R08: 0000200000000000 R09: 000000000000001c
R10: 000000000000fe80 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f7dbc9e6038 R14: 00007f7dbc9e5fa0 R15: 00007ffc5c9749e8
 </TASK>
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	04 00                	add    $0x0,%al
   2:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   9:	00 00 00 00
   d:	66 90                	xchg   %ax,%ax
   f:	48 8b 06             	mov    (%rsi),%rax
  12:	48 89 07             	mov    %rax,(%rdi)
  15:	48 83 c6 08          	add    $0x8,%rsi
  19:	48 83 c7 08          	add    $0x8,%rdi
  1d:	83 e9 08             	sub    $0x8,%ecx
  20:	74 db                	je     0xfffffffd
  22:	83 f9 08             	cmp    $0x8,%ecx
  25:	73 e8                	jae    0xf
  27:	eb c5                	jmp    0xffffffee
* 29:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi) <-- trapping instruction
  2b:	e9 4f 1e 04 00       	jmp    0x41e7f
  30:	48 8b 06             	mov    (%rsi),%rax
  33:	48 89 07             	mov    %rax,(%rdi)
  36:	48 8d 47 08          	lea    0x8(%rdi),%rax
  3a:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
  3e:	48                   	rex.W


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

