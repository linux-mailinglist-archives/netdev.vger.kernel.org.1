Return-Path: <netdev+bounces-277080-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFdqMmDf12klTwgAu9opvQ
	(envelope-from <netdev+bounces-277080-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 19:18:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2EF3CE097
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 19:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8306A3010522
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 17:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D023E2748;
	Thu,  9 Apr 2026 17:13:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E25C281525
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 17:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775754806; cv=none; b=SJvUwArWiSc4znxA1rE5NnQqWItRRA90ZDyTa4XS+5YqrAnBL6qtedyFSmkwm+MvhK27e52+v9sQGSIEVJUHJgA/MoiDc1X6P8Q+jLgHbglp08EKMDlkBWBzkf+JBT8vZfs98PNy9gGKmOxDlDEEykEn57LuKibS3jrIzK79OeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775754806; c=relaxed/simple;
	bh=nyWpomPwat/aPdJMaJ1JTwOxMGukjxe1KBPZP38Zht8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=opIGxyyhSg+Kb1RIjsp9l3/UI4gKmgJVHVHcqPD6b1OCyxYKzDN30hOwd+I2R8QDYwjh4kXlWBdFjN2UP8NtIuv7GmE/M5bah5QlLXsv+mxzWXIQElPOc1oGlCWi6Et7DaL5Lu6lq2egpVh4I212Ii+BJQjsmYoAbwR1W2yrD1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-688c232dd72so2000424eaf.1
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 10:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775754804; x=1776359604;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gh7chO9GvdQUnUzLCNNTv1QFWxpwUI0SpETGIovHTjY=;
        b=nCBPeaL9zsu6a8e56NfaXR+uglDV//TlQAWA0C/SXachGgY2OuyLm2JbRVx0FW/epi
         be6TJmGYkMpGNgSsHGvbUWeC+2Q5fjk1N3lu3ZAN5zFMtvT+EbxzdpntTN9ohZFYLdAM
         lQetFBLw623IJ7IQPol8+OFHzdzzY7JXutY9xOt/L0WI6TThFfhCBPxJ4Jo4ufeSTpBV
         NX8FHsI1yrweXBI7Ro4+4lvzkTaeFETmd5hyUP2499eJwRTtRgsrVMRd6ytX+L6DXOtu
         WyyHi/GPKJrWWhSxazgAlpmOK0NCgYg0A6RTFmHD4/kQv7BvvJd6URC4JZRhDL+imxDU
         yIjg==
X-Forwarded-Encrypted: i=1; AJvYcCUy05y7RDO5rl1CFua6QQ83TW+QrnY5xJpBrvWHspKgxWgFSTKH4sbptFtucXA7ztQmRg3iy5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhRJK5cmxl3FYNNFDz5UFdYgODT9oR/xjRkvUxQyJl2PSICy4R
	O2dWfv70KbquX/bfYKa6U9QaYAqHO7nv3S6NT8ZTPwgGmohZsmFqkn/5dE3TEeMxQusq3f6Y0FN
	VYE+YXPlZxQNdik+3bNp9X5Ydwb0BtJ1lTU8OmYYVYqPie/5t8d8x4WhQ0dg=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:e917:0:b0:689:7cd7:259e with SMTP id
 006d021491bc7-68a63a9443dmr2348615eaf.57.1775754804065; Thu, 09 Apr 2026
 10:13:24 -0700 (PDT)
Date: Thu, 09 Apr 2026 10:13:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69d7de34.050a0220.3030df.0019.GAE@google.com>
Subject: [syzbot] [mptcp?] possible deadlock in mptcp_pm_mp_prio_send_ack
From: syzbot <syzbot+2204dbe6a049b3218db9@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, geliang@kernel.org, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martineau@kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=6754c86e8d9e4c91];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-277080-lists,netdev=lfdr.de,2204dbe6a049b3218db9];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,storage.googleapis.com:url,goo.gl:url,googlegroups.com:email,appspotmail.com:email]
X-Rspamd-Queue-Id: 1B2EF3CE097
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    1caa871bb061 Merge branch 'net-stmmac-fix-tegra234-mgbe-cl..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=11d74e06580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6754c86e8d9e4c91
dashboard link: https://syzkaller.appspot.com/bug?extid=2204dbe6a049b3218db9
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/014aae23b990/disk-1caa871b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c574a710638c/vmlinux-1caa871b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b29909f4efc4/bzImage-1caa871b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2204dbe6a049b3218db9@syzkaller.appspotmail.com

netlink: 8 bytes leftover after parsing attributes in process `syz.2.2034'.
netlink: 8 bytes leftover after parsing attributes in process `syz.2.2034'.
======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.2.2034/13659 is trying to acquire lock:
ffff888031173560 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_pm_mp_prio_send_ack+0xaf8/0xba0 net/mptcp/pm.c:296

but task is already holding lock:
ffff88807e300ea0 (sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1709 [inline]
ffff88807e300ea0 (sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_pm_nl_set_flags_all net/mptcp/pm_kernel.c:1482 [inline]
ffff88807e300ea0 (sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_pm_nl_set_flags+0x795/0xc90 net/mptcp/pm_kernel.c:1551

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #7 (sk_lock-AF_INET){+.+.}-{0:0}:
       lock_sock_nested+0x48/0x100 net/core/sock.c:3780
       lock_sock include/net/sock.h:1709 [inline]
       inet_shutdown+0x6a/0x390 net/ipv4/af_inet.c:919
       nbd_mark_nsock_dead+0x2e9/0x560 drivers/block/nbd.c:318
       recv_work+0x1c7f/0x1d90 drivers/block/nbd.c:1021
       process_one_work kernel/workqueue.c:3276 [inline]
       process_scheduled_works+0xb6e/0x18c0 kernel/workqueue.c:3359
       worker_thread+0xa53/0xfc0 kernel/workqueue.c:3440
       kthread+0x388/0x470 kernel/kthread.c:436
       ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #6 (&nsock->tx_lock){+.+.}-{4:4}:
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
       read_mapping_folio include/linux/pagemap.h:1017 [inline]
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
       do_open fs/namei.c:4677 [inline]
       path_openat+0x2e08/0x3860 fs/namei.c:4836
       do_file_open+0x23e/0x4a0 fs/namei.c:4865
       do_sys_openat2+0x113/0x200 fs/open.c:1366
       do_sys_open fs/open.c:1372 [inline]
       __do_sys_openat fs/open.c:1388 [inline]
       __se_sys_openat fs/open.c:1383 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1383
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #5 (&cmd->lock){+.+.}-{4:4}:
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
       read_mapping_folio include/linux/pagemap.h:1017 [inline]
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
       do_open fs/namei.c:4677 [inline]
       path_openat+0x2e08/0x3860 fs/namei.c:4836
       do_file_open+0x23e/0x4a0 fs/namei.c:4865
       do_sys_openat2+0x113/0x200 fs/open.c:1366
       do_sys_open fs/open.c:1372 [inline]
       __do_sys_openat fs/open.c:1388 [inline]
       __se_sys_openat fs/open.c:1383 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1383
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (set->srcu){.+.+}-{0:0}:
       srcu_lock_sync include/linux/srcu.h:199 [inline]
       __synchronize_srcu+0xca/0x300 kernel/rcu/srcutree.c:1481
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

-> #3 (&q->elevator_lock){+.+.}-{4:4}:
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

-> #2 (&q->q_usage_counter(io)#49){++++}-{0:0}:
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

-> #1 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:4348 [inline]
       fs_reclaim_acquire+0x71/0x100 mm/page_alloc.c:4362
       might_alloc include/linux/sched/mm.h:317 [inline]
       slab_pre_alloc_hook mm/slub.c:4489 [inline]
       slab_alloc_node mm/slub.c:4843 [inline]
       __do_kmalloc_node mm/slub.c:5259 [inline]
       __kmalloc_node_track_caller_noprof+0x9d/0x7b0 mm/slub.c:5368
       memdup_sockptr_noprof include/linux/sockptr.h:126 [inline]
       xfrm_user_policy+0x1c4/0x960 net/xfrm/xfrm_state.c:2975
       do_ip_setsockopt+0x1aab/0x2ea0 net/ipv4/ip_sockglue.c:1347
       ip_setsockopt+0x66/0x110 net/ipv4/ip_sockglue.c:1417
       smc_setsockopt+0x249/0xac0 net/smc/af_smc.c:3110
       do_sock_setsockopt+0x17c/0x1b0 net/socket.c:2322
       __sys_setsockopt net/socket.c:2347 [inline]
       __do_sys_setsockopt net/socket.c:2353 [inline]
       __se_sys_setsockopt net/socket.c:2350 [inline]
       __x64_sys_setsockopt+0x13d/0x1b0 net/socket.c:2350
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (k-sk_lock-AF_INET){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x15a5/0x2cf0 kernel/locking/lockdep.c:5237
       lock_acquire+0xf0/0x2e0 kernel/locking/lockdep.c:5868
       lock_sock_fast include/net/sock.h:1741 [inline]
       __mptcp_pm_send_ack+0x76/0x200 net/mptcp/pm.c:196
       mptcp_pm_mp_prio_send_ack+0xaf8/0xba0 net/mptcp/pm.c:296
       mptcp_pm_nl_set_flags_all net/mptcp/pm_kernel.c:1484 [inline]
       mptcp_pm_nl_set_flags+0x893/0xc90 net/mptcp/pm_kernel.c:1551
       mptcp_pm_set_flags net/mptcp/pm_netlink.c:277 [inline]
       mptcp_pm_nl_set_flags_doit+0x364/0x450 net/mptcp/pm_netlink.c:282
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

other info that might help us debug this:

Chain exists of:
  k-sk_lock-AF_INET --> &nsock->tx_lock --> sk_lock-AF_INET

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sk_lock-AF_INET);
                               lock(&nsock->tx_lock);
                               lock(sk_lock-AF_INET);
  lock(k-sk_lock-AF_INET);

 *** DEADLOCK ***

3 locks held by syz.2.2034/13659:
 #0: ffffffff8fc3de70 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1217
 #1: ffffffff8fc3dc88 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8fc3dc88 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8fc3dc88 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x10b/0x7a0 net/netlink/genetlink.c:1208
 #2: ffff88807e300ea0 (sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1709 [inline]
 #2: ffff88807e300ea0 (sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_pm_nl_set_flags_all net/mptcp/pm_kernel.c:1482 [inline]
 #2: ffff88807e300ea0 (sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_pm_nl_set_flags+0x795/0xc90 net/mptcp/pm_kernel.c:1551

stack backtrace:
CPU: 1 UID: 0 PID: 13659 Comm: syz.2.2034 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
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
 lock_sock_fast include/net/sock.h:1741 [inline]
 __mptcp_pm_send_ack+0x76/0x200 net/mptcp/pm.c:196
 mptcp_pm_mp_prio_send_ack+0xaf8/0xba0 net/mptcp/pm.c:296
 mptcp_pm_nl_set_flags_all net/mptcp/pm_kernel.c:1484 [inline]
 mptcp_pm_nl_set_flags+0x893/0xc90 net/mptcp/pm_kernel.c:1551
 mptcp_pm_set_flags net/mptcp/pm_netlink.c:277 [inline]
 mptcp_pm_nl_set_flags_doit+0x364/0x450 net/mptcp/pm_netlink.c:282
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
RIP: 0033:0x7fb82ef9c819
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb82fe60028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fb82f216090 RCX: 00007fb82ef9c819
RDX: 0000000000000000 RSI: 0000200000000400 RDI: 0000000000000009
RBP: 00007fb82f032c91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fb82f216128 R14: 00007fb82f216090 R15: 00007ffcfa510d88
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

