Return-Path: <netdev+bounces-271537-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EO8YLkvaw2m1uQQAu9opvQ
	(envelope-from <netdev+bounces-271537-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:51:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 162243252FA
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02A2330922D8
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 12:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BE43D5236;
	Wed, 25 Mar 2026 12:43:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35EE3CF697
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 12:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774442608; cv=none; b=pmGfcK1y0epmhesuHu9yum/3RuKy8yjLjCP4rAObQsJGHicFAJP4/tGNYeF9IcjHqYOMSia7ucy1Qn113HcBMYfaGCKBPEm3B7nSsGaSpFOH3ouhwuZt/lsd4WNV/wgfw/Cy7V/hdpZCDwdOuNDybqCKH0tWaHlXqHEyVcGzpBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774442608; c=relaxed/simple;
	bh=soJmySXvbkuEZ9jgWqH+xwtDE73MCNW21lsKBvMY61s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BLbSSY9N+PSPzVo7acUXeFKMlY9T+dUZPJXuc3r9PPIhnZxRaU0o8UlfjO0voKXLbGhrf0vcz4eI7Frl89MM6u/EYK56biVEDccaQFLzf9MoGqf+fk3TWJYmjhJ5LMnKPhCI0KZYCOW4kVx5gqzkwIp8X87K9YFEtOtjj0cYCik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-67c21b7d5f8so30033543eaf.1
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 05:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774442605; x=1775047405;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UyFw2bSyMQ70U/GG78uFflBW+dktjUduSwnBfNkMoDk=;
        b=A+EhgvrMbYpAGTEXBrToq5jRkco5nyOnNuG1isCiM/tFAFH2H6foJugsam1FcwbekL
         Ktwyn+Btu3nrha4OzC1mJyJwDWWHY6TwLNL5V+pS77QoHvCvq/TrjE4su2k9EBIJWtdk
         HtQOX0KerM89DKRuahpsFEwfXbl944sjnpeTBZ7UnoJ+eShirIY7Og8NSQYSEEyvjRMa
         e0f5jM7kXCeG7U3cQgsPuyIZSTvsxjWOXN7S5kaLQkap+Ak2F4umdrwL0UFKDVHDRtMP
         4uMJZUtkUPPKQVnoo4WCgGCNT+h3Lv/y5mKVxBNq4LuV0OGwzSMm+bJauGvhKs74OVus
         at7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9GoFflJdzFn77Q5aKl8zBPjqof8872EG/sFFvUwu9Y6k5hhA0vtwmRa05HDUr0O2JEISQ/tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPPQE0PMJlOYdLCH38aXjXa7My1mxgp1zsFbEspE7973Wvrf9a
	7RA960qD9gF6m9XBsnc2yo21fV9V+APBdyxsW0ac87QHWD8XwqUSwpYLxLvMpKWAYsc3Ff0yhyt
	lRet7bhJ0+BKrNmekCXH+t8pt4MS6DnbmcaMp2q/gU/UtJQM+69y4GaanbQ0=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:221d:b0:67b:afd7:ab03 with SMTP id
 006d021491bc7-67dff3d07bamr1693456eaf.7.1774442605687; Wed, 25 Mar 2026
 05:43:25 -0700 (PDT)
Date: Wed, 25 Mar 2026 05:43:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69c3d86d.a70a0220.234938.0050.GAE@google.com>
Subject: [syzbot] [kernfs?] possible deadlock in kernfs_iop_setattr
From: syzbot <syzbot+98b54002b447b9825ad0@syzkaller.appspotmail.com>
To: driver-core@lists.linux.dev, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=6754c86e8d9e4c91];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271537-lists,netdev=lfdr.de,98b54002b447b9825ad0];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,goo.gl:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 162243252FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    e069034bd660 Merge branch 'net-macb-fix-two-lock-warnings-..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=13cf606a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6754c86e8d9e4c91
dashboard link: https://syzkaller.appspot.com/bug?extid=98b54002b447b9825ad0
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f16068fdd943/disk-e069034b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9e37fb157caa/vmlinux-e069034b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e29f095e41cd/bzImage-e069034b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+98b54002b447b9825ad0@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.3.5991/28469 is trying to acquire lock:
ffffffff8e883040 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:317 [inline]
ffffffff8e883040 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slub.c:4489 [inline]
ffffffff8e883040 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:4843 [inline]
ffffffff8e883040 (fs_reclaim){+.+.}-{0:0}, at: kmem_cache_alloc_noprof+0x40/0x650 mm/slub.c:4873

but task is already holding lock:
ffff888035aeea20 (&root->kernfs_iattr_rwsem){++++}-{4:4}, at: kernfs_iop_setattr+0x83/0x3f0 fs/kernfs/inode.c:123

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #7 (&root->kernfs_iattr_rwsem){++++}-{4:4}:
       down_read+0x47/0x2e0 kernel/locking/rwsem.c:1537
       kernfs_iop_permission+0x7f/0x430 fs/kernfs/inode.c:289
       do_inode_permission fs/namei.c:578 [inline]
       inode_permission+0x46f/0x5f0 fs/namei.c:648
       cgroup_may_write kernel/cgroup/cgroup.c:5308 [inline]
       cgroup_procs_write_permission kernel/cgroup/cgroup.c:5328 [inline]
       cgroup_attach_permissions+0x286/0x9e0 kernel/cgroup/cgroup.c:5351
       __cgroup_procs_write+0x23a/0x300 kernel/cgroup/cgroup.c:5394
       cgroup_threads_write+0x24/0x50 kernel/cgroup/cgroup.c:5424
       cgroup_file_write+0x36f/0x790 kernel/cgroup/cgroup.c:4310
       kernfs_fop_write_iter+0x3af/0x540 fs/kernfs/file.c:352
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x61d/0xb90 fs/read_write.c:688
       ksys_write+0x150/0x270 fs/read_write.c:740
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #6 (cpu_hotplug_lock){++++}-{0:0}:
       percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
       percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
       cpus_read_lock+0x42/0x160 kernel/cpu.c:490
       static_key_slow_inc+0x12/0x30 kernel/jump_label.c:190
       nbd_reconnect_socket drivers/block/nbd.c:1342 [inline]
       nbd_genl_reconfigure+0x132f/0x1ea0 drivers/block/nbd.c:2431
       genl_family_rcv_msg_doit+0x22a/0x330 net/netlink/genetlink.c:1114
       genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
       genl_rcv_msg+0x61c/0x7a0 net/netlink/genetlink.c:1209
       netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
       netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
       netlink_unicast+0x80f/0x9b0 net/netlink/af_netlink.c:1344
       netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
       sock_sendmsg_nosec net/socket.c:727 [inline]
       __sock_sendmsg net/socket.c:742 [inline]
       ____sys_sendmsg+0x972/0x9f0 net/socket.c:2592
       ___sys_sendmsg+0x2a5/0x360 net/socket.c:2646
       __sys_sendmsg net/socket.c:2678 [inline]
       __do_sys_sendmsg net/socket.c:2683 [inline]
       __se_sys_sendmsg net/socket.c:2681 [inline]
       __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2681
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #5 (&nsock->tx_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:614 [inline]
       __mutex_lock+0x19f/0x1300 kernel/locking/mutex.c:776
       nbd_handle_cmd drivers/block/nbd.c:1143 [inline]
       nbd_queue_rq+0x37b/0x1100 drivers/block/nbd.c:1207
       blk_mq_dispatch_rq_list+0xa70/0x1910 block/blk-mq.c:2148
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xdcc/0x1600 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
       blk_mq_run_hw_queue+0x348/0x4f0 block/blk-mq.c:2386
       blk_mq_dispatch_list+0xd16/0xe10 include/linux/spinlock.h:-1
       blk_mq_flush_plug_list+0x48d/0x570 block/blk-mq.c:2997
       __blk_flush_plug+0x3ed/0x4d0 block/blk-core.c:1230
       blk_finish_plug block/blk-core.c:1257 [inline]
       __submit_bio+0x28d/0x580 block/blk-core.c:649
       __submit_bio_noacct_mq block/blk-core.c:722 [inline]
       submit_bio_noacct_nocheck+0x2f4/0xa70 block/blk-core.c:753
       submit_bh fs/buffer.c:2826 [inline]
       block_read_full_folio+0x599/0x830 fs/buffer.c:2444
       filemap_read_folio+0x137/0x3b0 mm/filemap.c:2501
       do_read_cache_folio+0x358/0x590 mm/filemap.c:4101
       read_mapping_folio include/linux/pagemap.h:1028 [inline]
       read_part_sector+0xb6/0x2b0 block/partitions/core.c:723
       adfspart_check_ICS+0xa5/0xa40 block/partitions/acorn.c:360
       check_partition block/partitions/core.c:142 [inline]
       blk_add_partitions block/partitions/core.c:590 [inline]
       bdev_disk_changed+0x7ba/0x1550 block/partitions/core.c:694
       blkdev_get_whole+0x380/0x510 block/bdev.c:764
       bdev_open+0x31e/0xd30 block/bdev.c:973
       blkdev_open+0x470/0x610 block/fops.c:697
       do_dentry_open+0x785/0x14e0 fs/open.c:949
       vfs_open+0x3b/0x340 fs/open.c:1081
       do_open fs/namei.c:4671 [inline]
       path_openat+0x2e08/0x3860 fs/namei.c:4830
       do_file_open+0x23e/0x4a0 fs/namei.c:4859
       do_sys_openat2+0x113/0x200 fs/open.c:1366
       do_sys_open fs/open.c:1372 [inline]
       __do_sys_openat fs/open.c:1388 [inline]
       __se_sys_openat fs/open.c:1383 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1383
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (&cmd->lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:614 [inline]
       __mutex_lock+0x19f/0x1300 kernel/locking/mutex.c:776
       nbd_queue_rq+0xc6/0x1100 drivers/block/nbd.c:1199
       blk_mq_dispatch_rq_list+0xa70/0x1910 block/blk-mq.c:2148
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xdcc/0x1600 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
       blk_mq_run_hw_queue+0x348/0x4f0 block/blk-mq.c:2386
       blk_mq_dispatch_list+0xd16/0xe10 include/linux/spinlock.h:-1
       blk_mq_flush_plug_list+0x48d/0x570 block/blk-mq.c:2997
       __blk_flush_plug+0x3ed/0x4d0 block/blk-core.c:1230
       blk_finish_plug block/blk-core.c:1257 [inline]
       __submit_bio+0x28d/0x580 block/blk-core.c:649
       __submit_bio_noacct_mq block/blk-core.c:722 [inline]
       submit_bio_noacct_nocheck+0x2f4/0xa70 block/blk-core.c:753
       submit_bh fs/buffer.c:2826 [inline]
       block_read_full_folio+0x599/0x830 fs/buffer.c:2444
       filemap_read_folio+0x137/0x3b0 mm/filemap.c:2501
       do_read_cache_folio+0x358/0x590 mm/filemap.c:4101
       read_mapping_folio include/linux/pagemap.h:1028 [inline]
       read_part_sector+0xb6/0x2b0 block/partitions/core.c:723
       adfspart_check_ICS+0xa5/0xa40 block/partitions/acorn.c:360
       check_partition block/partitions/core.c:142 [inline]
       blk_add_partitions block/partitions/core.c:590 [inline]
       bdev_disk_changed+0x7ba/0x1550 block/partitions/core.c:694
       blkdev_get_whole+0x380/0x510 block/bdev.c:764
       bdev_open+0x31e/0xd30 block/bdev.c:973
       blkdev_open+0x470/0x610 block/fops.c:697
       do_dentry_open+0x785/0x14e0 fs/open.c:949
       vfs_open+0x3b/0x340 fs/open.c:1081
       do_open fs/namei.c:4671 [inline]
       path_openat+0x2e08/0x3860 fs/namei.c:4830
       do_file_open+0x23e/0x4a0 fs/namei.c:4859
       do_sys_openat2+0x113/0x200 fs/open.c:1366
       do_sys_open fs/open.c:1372 [inline]
       __do_sys_openat fs/open.c:1388 [inline]
       __se_sys_openat fs/open.c:1383 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1383
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (set->srcu){.+.+}-{0:0}:
       srcu_lock_sync include/linux/srcu.h:199 [inline]
       __synchronize_srcu+0xca/0x3e0 kernel/rcu/srcutree.c:1505
       elevator_switch+0x1e8/0x7a0 block/elevator.c:576
       elevator_change+0x2cc/0x450 block/elevator.c:681
       elevator_set_default+0x36c/0x430 block/elevator.c:754
       blk_register_queue+0x366/0x430 block/blk-sysfs.c:946
       __add_disk+0x677/0xd50 block/genhd.c:528
       add_disk_fwnode+0xfb/0x480 block/genhd.c:597
       add_disk include/linux/blkdev.h:785 [inline]
       nbd_dev_add+0x72c/0xb50 drivers/block/nbd.c:1984
       nbd_init+0x168/0x1f0 drivers/block/nbd.c:2692
       do_one_initcall+0x250/0x8d0 init/main.c:1382
       do_initcall_level+0x104/0x190 init/main.c:1444
       do_initcalls+0x59/0xa0 init/main.c:1460
       kernel_init_freeable+0x2a6/0x3e0 init/main.c:1692
       kernel_init+0x1d/0x1d0 init/main.c:1582
       ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #2 (&q->elevator_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:614 [inline]
       __mutex_lock+0x19f/0x1300 kernel/locking/mutex.c:776
       elevator_change+0x1b3/0x450 block/elevator.c:679
       elevator_set_none+0xb5/0x140 block/elevator.c:769
       blk_mq_elv_switch_none block/blk-mq.c:5110 [inline]
       __blk_mq_update_nr_hw_queues block/blk-mq.c:5155 [inline]
       blk_mq_update_nr_hw_queues+0x5e7/0x1a60 block/blk-mq.c:5220
       nbd_start_device+0x17f/0xb10 drivers/block/nbd.c:1489
       nbd_genl_connect+0x165b/0x1cf0 drivers/block/nbd.c:2239
       genl_family_rcv_msg_doit+0x22a/0x330 net/netlink/genetlink.c:1114
       genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
       genl_rcv_msg+0x61c/0x7a0 net/netlink/genetlink.c:1209
       netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
       netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
       netlink_unicast+0x80f/0x9b0 net/netlink/af_netlink.c:1344
       netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
       sock_sendmsg_nosec net/socket.c:727 [inline]
       __sock_sendmsg net/socket.c:742 [inline]
       ____sys_sendmsg+0x972/0x9f0 net/socket.c:2592
       ___sys_sendmsg+0x2a5/0x360 net/socket.c:2646
       __sys_sendmsg net/socket.c:2678 [inline]
       __do_sys_sendmsg net/socket.c:2683 [inline]
       __se_sys_sendmsg net/socket.c:2681 [inline]
       __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2681
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&q->q_usage_counter(io)#50){++++}-{0:0}:
       blk_alloc_queue+0x546/0x680 block/blk-core.c:461
       blk_mq_alloc_queue block/blk-mq.c:4429 [inline]
       __blk_mq_alloc_disk+0x197/0x390 block/blk-mq.c:4476
       nbd_dev_add+0x499/0xb50 drivers/block/nbd.c:1954
       nbd_init+0x168/0x1f0 drivers/block/nbd.c:2692
       do_one_initcall+0x250/0x8d0 init/main.c:1382
       do_initcall_level+0x104/0x190 init/main.c:1444
       do_initcalls+0x59/0xa0 init/main.c:1460
       kernel_init_freeable+0x2a6/0x3e0 init/main.c:1692
       kernel_init+0x1d/0x1d0 init/main.c:1582
       ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x15a5/0x2cf0 kernel/locking/lockdep.c:5237
       lock_acquire+0xf0/0x2e0 kernel/locking/lockdep.c:5868
       __fs_reclaim_acquire mm/page_alloc.c:4348 [inline]
       fs_reclaim_acquire+0x71/0x100 mm/page_alloc.c:4362
       might_alloc include/linux/sched/mm.h:317 [inline]
       slab_pre_alloc_hook mm/slub.c:4489 [inline]
       slab_alloc_node mm/slub.c:4843 [inline]
       kmem_cache_alloc_noprof+0x40/0x650 mm/slub.c:4873
       __kernfs_iattrs+0xdf/0x340 fs/kernfs/inode.c:36
       kernfs_iattrs fs/kernfs/inode.c:61 [inline]
       __kernfs_setattr fs/kernfs/inode.c:74 [inline]
       kernfs_iop_setattr+0xea/0x3f0 fs/kernfs/inode.c:128
       notify_change+0xc1a/0xf40 fs/attr.c:556
       do_truncate+0x1c2/0x250 fs/open.c:68
       handle_truncate fs/namei.c:4279 [inline]
       do_open fs/namei.c:4675 [inline]
       path_openat+0x2f89/0x3860 fs/namei.c:4830
       do_file_open+0x23e/0x4a0 fs/namei.c:4859
       do_sys_openat2+0x113/0x200 fs/open.c:1366
       do_sys_open fs/open.c:1372 [inline]
       __do_sys_openat fs/open.c:1388 [inline]
       __se_sys_openat fs/open.c:1383 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1383
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  fs_reclaim --> cpu_hotplug_lock --> &root->kernfs_iattr_rwsem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&root->kernfs_iattr_rwsem);
                               lock(cpu_hotplug_lock);
                               lock(&root->kernfs_iattr_rwsem);
  lock(fs_reclaim);

 *** DEADLOCK ***

3 locks held by syz.3.5991/28469:
 #0: ffff88807a7ae420 (sb_writers#10){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:493
 #1: ffff88806ddf9528 (&sb->s_type->i_mutex_key#20){+.+.}-{4:4}, at: inode_lock_killable include/linux/fs.h:1033 [inline]
 #1: ffff88806ddf9528 (&sb->s_type->i_mutex_key#20){+.+.}-{4:4}, at: do_truncate+0x18f/0x250 fs/open.c:63
 #2: ffff888035aeea20 (&root->kernfs_iattr_rwsem){++++}-{4:4}, at: kernfs_iop_setattr+0x83/0x3f0 fs/kernfs/inode.c:123

stack backtrace:
CPU: 1 UID: 0 PID: 28469 Comm: syz.3.5991 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e1/0x300 kernel/locking/lockdep.c:2043
 check_noncircular+0x12e/0x150 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x15a5/0x2cf0 kernel/locking/lockdep.c:5237
 lock_acquire+0xf0/0x2e0 kernel/locking/lockdep.c:5868
 __fs_reclaim_acquire mm/page_alloc.c:4348 [inline]
 fs_reclaim_acquire+0x71/0x100 mm/page_alloc.c:4362
 might_alloc include/linux/sched/mm.h:317 [inline]
 slab_pre_alloc_hook mm/slub.c:4489 [inline]
 slab_alloc_node mm/slub.c:4843 [inline]
 kmem_cache_alloc_noprof+0x40/0x650 mm/slub.c:4873
 __kernfs_iattrs+0xdf/0x340 fs/kernfs/inode.c:36
 kernfs_iattrs fs/kernfs/inode.c:61 [inline]
 __kernfs_setattr fs/kernfs/inode.c:74 [inline]
 kernfs_iop_setattr+0xea/0x3f0 fs/kernfs/inode.c:128
 notify_change+0xc1a/0xf40 fs/attr.c:556
 do_truncate+0x1c2/0x250 fs/open.c:68
 handle_truncate fs/namei.c:4279 [inline]
 do_open fs/namei.c:4675 [inline]
 path_openat+0x2f89/0x3860 fs/namei.c:4830
 do_file_open+0x23e/0x4a0 fs/namei.c:4859
 do_sys_openat2+0x113/0x200 fs/open.c:1366
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1383
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9a91b9c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9a92b1c028 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f9a91e15fa0 RCX: 00007f9a91b9c799
RDX: 000000000000275a RSI: 0000200000000000 RDI: 0000000000000006
RBP: 00007f9a91c32c99 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f9a91e16038 R14: 00007f9a91e15fa0 R15: 00007ffebab4e6b8
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

