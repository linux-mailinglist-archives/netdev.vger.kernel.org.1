Return-Path: <netdev+bounces-268099-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NbUC8jct2mcWAEAu9opvQ
	(envelope-from <netdev+bounces-268099-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:34:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A9C297F7B
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA5B0301A736
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 10:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558F937CD32;
	Mon, 16 Mar 2026 10:33:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8763A372ED7
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 10:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773657209; cv=none; b=cFvr9+54dC7g4JkWbTHKKyxNpr4pdPi4bzYqWs29Ekg/1vsvtwNNFnZGXuo7pVem8ILuZ7RDJi2teZiOKdrpSd+od59qMDRExEKgZrUyW8/yhc62Rf97GqNpS8Bxf5wP+ETZ3JsUa7BRr/KtvAduQtCci8AVw8PspIpDoer7s4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773657209; c=relaxed/simple;
	bh=PCZPZ3Yf+Ki/Ei/bfPQrImByvPdz7ezwWX1QcI4TDCY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FV9owNazCDhd15n26WMk71r44x3j49PzEts4Z0YSdfc0ai/nMNsImC95P1/Sw3n1Oeo2in/VrLxGG9I3rL/I7vTVg4opO7HlY2pY/pB+EV0jQDbMTTPqrb6ldai+POURloECJtKFJ7wMepenluxSKIBKg52mewB3HIDz6VJu7s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-67bd1b31789so38482630eaf.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 03:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773657206; x=1774262006;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/uSFtZw3QSfsw1msVIIPfRGGPvw4aJjfI69zgTTRxxY=;
        b=Zt/jRwdDLD6in36mk8dwcf/q2W46RJCOAi1MiF0IjJ2FWKBD1v6wo3LtxaAbigTl5M
         /t/q20qf29itmYo4L+T1KGIbINMd5DAvt1+a9LH93lzQbrWqDBqP1ORe6J7jVZKqlR69
         1Mn8MMfNIRC80PjXp4EF6ndz83OrPXEejiSxJqwRzkINjlPl+mfOOIpndjTDc4xH5spE
         YFDPJt/W4gHGCoD2s8HVQWLx/iSuKzXx5/v3pd80MSccnjl1BKiL6XXX+rvVBoUvrDbY
         KXCqS3i62JJ/cBaDmlDX304LYPx+TXmjoKhzRitYkEh11hHdGrF2+U+UozNhRRxdGMo4
         EggA==
X-Forwarded-Encrypted: i=1; AJvYcCURHD+jBCD6Z61tDiJ3PSDlJjIe2nq/m6emjZDeAPwnHiG1Kq8y55sQOj5zopA98yhBg/+fbQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YynJj0Ce6CZXMIfjlF5JUYqPVCHkKtmG/vM02Cf67vPjXxgrK0A
	kZFcHGqbh8PIFU5ZC9AqvC4BdfCm89NCJlhOA1f7f0AwlIu0ssT+UYNjitrQhx4Gk4twlWsgNhq
	SraUq2W9ORiR58MnV87RdqDHWgTX12xm2tU233HsHZMTcebUTBc0omTH5+C8=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:210a:b0:67b:c4bd:2a89 with SMTP id
 006d021491bc7-67bda9b7fd5mr8519298eaf.20.1773657206507; Mon, 16 Mar 2026
 03:33:26 -0700 (PDT)
Date: Mon, 16 Mar 2026 03:33:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69b7dc76.050a0220.248e02.0113.GAE@google.com>
Subject: [syzbot] [net?] possible deadlock in __ipv6_dev_mc_inc
From: syzbot <syzbot+afbcf622635e98bf40d2@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=976ba5a93c4add9e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-268099-lists,netdev=lfdr.de,afbcf622635e98bf40d2];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.944];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,goo.gl:url,googlegroups.com:email,storage.googleapis.com:url,appspotmail.com:email]
X-Rspamd-Queue-Id: 84A9C297F7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    80234b5ab240 Merge tag 'rproc-v7.0-fixes' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10f4cd52580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=976ba5a93c4add9e
dashboard link: https://syzkaller.appspot.com/bug?extid=afbcf622635e98bf40d2
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2e6b301fd0a3/disk-80234b5a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b7beeadf358c/vmlinux-80234b5a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0570bee580ee/bzImage-80234b5a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+afbcf622635e98bf40d2@syzkaller.appspotmail.com

netlink: 132 bytes leftover after parsing attributes in process `syz.2.4459'.
======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.2.4459/20989 is trying to acquire lock:
ffffffff8e9ab040 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:317 [inline]
ffffffff8e9ab040 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slub.c:4493 [inline]
ffffffff8e9ab040 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:4846 [inline]
ffffffff8e9ab040 (fs_reclaim){+.+.}-{0:0}, at: __kmalloc_cache_noprof+0x4b/0x6f0 mm/slub.c:5378

but task is already holding lock:
ffff88803538d538 (&idev->mc_lock){+.+.}-{4:4}, at: __ipv6_dev_mc_inc+0x53/0xbc0 net/ipv6/mcast.c:943

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #7 (&idev->mc_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:614 [inline]
       __mutex_lock+0x1a2/0x1b90 kernel/locking/mutex.c:776
       __ipv6_dev_mc_inc+0x53/0xbc0 net/ipv6/mcast.c:943
       __ipv6_sock_mc_join+0x5b8/0x8e0 net/ipv6/mcast.c:234
       do_ipv6_mcast_group_source+0x21e/0x270 net/ipv6/ipv6_sockglue.c:173
       do_ipv6_setsockopt+0x1fe3/0x4510 net/ipv6/ipv6_sockglue.c:919
       ipv6_setsockopt+0xcb/0x170 net/ipv6/ipv6_sockglue.c:973
       udpv6_setsockopt+0x7d/0xd0 net/ipv6/udp.c:1846
       do_sock_setsockopt+0xf3/0x1d0 net/socket.c:2322
       __sys_setsockopt+0x195/0x220 net/socket.c:2347
       __do_sys_setsockopt net/socket.c:2353 [inline]
       __se_sys_setsockopt net/socket.c:2350 [inline]
       __x64_sys_setsockopt+0xbd/0x160 net/socket.c:2350
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #6 (sk_lock-AF_INET6){+.+.}-{0:0}:
       lock_sock_nested+0x41/0xf0 net/core/sock.c:3780
       lock_sock include/net/sock.h:1709 [inline]
       inet_shutdown+0x67/0x410 net/ipv4/af_inet.c:913
       nbd_mark_nsock_dead+0xae/0x5c0 drivers/block/nbd.c:318
       recv_work+0x5fb/0x8c0 drivers/block/nbd.c:1021
       process_one_work+0x9d7/0x1920 kernel/workqueue.c:3275
       process_scheduled_works kernel/workqueue.c:3358 [inline]
       worker_thread+0x5da/0xe40 kernel/workqueue.c:3439
       kthread+0x370/0x450 kernel/kthread.c:436
       ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #5 (&nsock->tx_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:614 [inline]
       __mutex_lock+0x1a2/0x1b90 kernel/locking/mutex.c:776
       nbd_handle_cmd drivers/block/nbd.c:1143 [inline]
       nbd_queue_rq+0x428/0x1080 drivers/block/nbd.c:1207
       blk_mq_dispatch_rq_list+0x422/0x1e70 block/blk-mq.c:2148
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xcea/0x1620 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd7/0x1c0 block/blk-mq-sched.c:329
       blk_mq_run_hw_queue+0x23c/0x670 block/blk-mq.c:2386
       blk_mq_dispatch_list+0x51d/0x1360 block/blk-mq.c:2949
       blk_mq_flush_plug_list block/blk-mq.c:2997 [inline]
       blk_mq_flush_plug_list+0x130/0x600 block/blk-mq.c:2969
       __blk_flush_plug+0x2c4/0x4b0 block/blk-core.c:1230
       blk_finish_plug block/blk-core.c:1257 [inline]
       __submit_bio+0x584/0x6c0 block/blk-core.c:649
       __submit_bio_noacct_mq block/blk-core.c:722 [inline]
       submit_bio_noacct_nocheck+0x562/0xc10 block/blk-core.c:753
       submit_bio_noacct+0xd17/0x2010 block/blk-core.c:884
       blk_crypto_submit_bio include/linux/blk-crypto.h:203 [inline]
       submit_bh_wbc+0x59c/0x770 fs/buffer.c:2821
       submit_bh fs/buffer.c:2826 [inline]
       block_read_full_folio+0x264/0x8e0 fs/buffer.c:2444
       filemap_read_folio+0xfc/0x3b0 mm/filemap.c:2501
       do_read_cache_folio+0x2d7/0x6b0 mm/filemap.c:4101
       read_mapping_folio include/linux/pagemap.h:1028 [inline]
       read_part_sector+0xd1/0x370 block/partitions/core.c:723
       adfspart_check_ICS+0x93/0x910 block/partitions/acorn.c:360
       check_partition block/partitions/core.c:142 [inline]
       blk_add_partitions block/partitions/core.c:590 [inline]
       bdev_disk_changed+0x7f8/0xc80 block/partitions/core.c:694
       blkdev_get_whole+0x187/0x290 block/bdev.c:764
       bdev_open+0x2c7/0xe40 block/bdev.c:973
       blkdev_open+0x34e/0x4f0 block/fops.c:697
       do_dentry_open+0x6d8/0x1660 fs/open.c:949
       vfs_open+0x82/0x3f0 fs/open.c:1081
       do_open fs/namei.c:4671 [inline]
       path_openat+0x208c/0x31a0 fs/namei.c:4830
       do_file_open+0x20e/0x430 fs/namei.c:4859
       do_sys_openat2+0x10d/0x1e0 fs/open.c:1366
       do_sys_open fs/open.c:1372 [inline]
       __do_sys_openat fs/open.c:1388 [inline]
       __se_sys_openat fs/open.c:1383 [inline]
       __x64_sys_openat+0x12d/0x210 fs/open.c:1383
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (&cmd->lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:614 [inline]
       __mutex_lock+0x1a2/0x1b90 kernel/locking/mutex.c:776
       nbd_queue_rq+0xba/0x1080 drivers/block/nbd.c:1199
       blk_mq_dispatch_rq_list+0x422/0x1e70 block/blk-mq.c:2148
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xcea/0x1620 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd7/0x1c0 block/blk-mq-sched.c:329
       blk_mq_run_hw_queue+0x23c/0x670 block/blk-mq.c:2386
       blk_mq_dispatch_list+0x51d/0x1360 block/blk-mq.c:2949
       blk_mq_flush_plug_list block/blk-mq.c:2997 [inline]
       blk_mq_flush_plug_list+0x130/0x600 block/blk-mq.c:2969
       __blk_flush_plug+0x2c4/0x4b0 block/blk-core.c:1230
       blk_finish_plug block/blk-core.c:1257 [inline]
       __submit_bio+0x584/0x6c0 block/blk-core.c:649
       __submit_bio_noacct_mq block/blk-core.c:722 [inline]
       submit_bio_noacct_nocheck+0x562/0xc10 block/blk-core.c:753
       submit_bio_noacct+0xd17/0x2010 block/blk-core.c:884
       blk_crypto_submit_bio include/linux/blk-crypto.h:203 [inline]
       submit_bh_wbc+0x59c/0x770 fs/buffer.c:2821
       submit_bh fs/buffer.c:2826 [inline]
       block_read_full_folio+0x264/0x8e0 fs/buffer.c:2444
       filemap_read_folio+0xfc/0x3b0 mm/filemap.c:2501
       do_read_cache_folio+0x2d7/0x6b0 mm/filemap.c:4101
       read_mapping_folio include/linux/pagemap.h:1028 [inline]
       read_part_sector+0xd1/0x370 block/partitions/core.c:723
       adfspart_check_ICS+0x93/0x910 block/partitions/acorn.c:360
       check_partition block/partitions/core.c:142 [inline]
       blk_add_partitions block/partitions/core.c:590 [inline]
       bdev_disk_changed+0x7f8/0xc80 block/partitions/core.c:694
       blkdev_get_whole+0x187/0x290 block/bdev.c:764
       bdev_open+0x2c7/0xe40 block/bdev.c:973
       blkdev_open+0x34e/0x4f0 block/fops.c:697
       do_dentry_open+0x6d8/0x1660 fs/open.c:949
       vfs_open+0x82/0x3f0 fs/open.c:1081
       do_open fs/namei.c:4671 [inline]
       path_openat+0x208c/0x31a0 fs/namei.c:4830
       do_file_open+0x20e/0x430 fs/namei.c:4859
       do_sys_openat2+0x10d/0x1e0 fs/open.c:1366
       do_sys_open fs/open.c:1372 [inline]
       __do_sys_openat fs/open.c:1388 [inline]
       __se_sys_openat fs/open.c:1383 [inline]
       __x64_sys_openat+0x12d/0x210 fs/open.c:1383
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (set->srcu){.+.+}-{0:0}:
       srcu_lock_sync include/linux/srcu.h:199 [inline]
       __synchronize_srcu+0xa1/0x2a0 kernel/rcu/srcutree.c:1505
       blk_mq_wait_quiesce_done block/blk-mq.c:284 [inline]
       blk_mq_wait_quiesce_done block/blk-mq.c:281 [inline]
       blk_mq_quiesce_queue block/blk-mq.c:304 [inline]
       blk_mq_quiesce_queue+0x149/0x1c0 block/blk-mq.c:299
       elevator_switch+0x17b/0x7e0 block/elevator.c:576
       elevator_change+0x352/0x530 block/elevator.c:681
       elevator_set_default+0x29e/0x360 block/elevator.c:754
       blk_register_queue+0x412/0x590 block/blk-sysfs.c:946
       __add_disk+0x73f/0xe40 block/genhd.c:528
       add_disk_fwnode+0x118/0x5c0 block/genhd.c:597
       add_disk include/linux/blkdev.h:785 [inline]
       nbd_dev_add+0x77a/0xb10 drivers/block/nbd.c:1984
       nbd_init+0x291/0x2b0 drivers/block/nbd.c:2692
       do_one_initcall+0x11d/0x760 init/main.c:1382
       do_initcall_level init/main.c:1444 [inline]
       do_initcalls init/main.c:1460 [inline]
       do_basic_setup init/main.c:1479 [inline]
       kernel_init_freeable+0x6e5/0x7a0 init/main.c:1692
       kernel_init+0x1f/0x1e0 init/main.c:1582
       ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #2 (&q->elevator_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:614 [inline]
       __mutex_lock+0x1a2/0x1b90 kernel/locking/mutex.c:776
       elevator_change+0x1bc/0x530 block/elevator.c:679
       elevator_set_none+0x92/0xf0 block/elevator.c:769
       blk_mq_elv_switch_none block/blk-mq.c:5110 [inline]
       __blk_mq_update_nr_hw_queues block/blk-mq.c:5155 [inline]
       blk_mq_update_nr_hw_queues+0x4c1/0x15f0 block/blk-mq.c:5220
       nbd_start_device+0x1a6/0xbd0 drivers/block/nbd.c:1489
       nbd_start_device_ioctl drivers/block/nbd.c:1548 [inline]
       __nbd_ioctl drivers/block/nbd.c:1623 [inline]
       nbd_ioctl+0x4a6/0xd30 drivers/block/nbd.c:1663
       blkdev_ioctl+0x5ad/0x6f0 block/ioctl.c:804
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:597 [inline]
       __se_sys_ioctl fs/ioctl.c:583 [inline]
       __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&q->q_usage_counter(io)#53){++++}-{0:0}:
       blk_alloc_queue+0x610/0x790 block/blk-core.c:461
       blk_mq_alloc_queue+0x174/0x290 block/blk-mq.c:4429
       __blk_mq_alloc_disk+0x29/0x120 block/blk-mq.c:4476
       nbd_dev_add+0x492/0xb10 drivers/block/nbd.c:1954
       nbd_init+0x291/0x2b0 drivers/block/nbd.c:2692
       do_one_initcall+0x11d/0x760 init/main.c:1382
       do_initcall_level init/main.c:1444 [inline]
       do_initcalls init/main.c:1460 [inline]
       do_basic_setup init/main.c:1479 [inline]
       kernel_init_freeable+0x6e5/0x7a0 init/main.c:1692
       kernel_init+0x1f/0x1e0 init/main.c:1582
       ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x14b8/0x2630 kernel/locking/lockdep.c:5237
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1cf/0x380 kernel/locking/lockdep.c:5825
       __fs_reclaim_acquire mm/page_alloc.c:4348 [inline]
       fs_reclaim_acquire+0xc4/0x100 mm/page_alloc.c:4362
       might_alloc include/linux/sched/mm.h:317 [inline]
       slab_pre_alloc_hook mm/slub.c:4493 [inline]
       slab_alloc_node mm/slub.c:4846 [inline]
       __kmalloc_cache_noprof+0x4b/0x6f0 mm/slub.c:5378
       kmalloc_noprof include/linux/slab.h:950 [inline]
       kzalloc_noprof include/linux/slab.h:1188 [inline]
       mca_alloc net/ipv6/mcast.c:871 [inline]
       __ipv6_dev_mc_inc+0x2f1/0xbc0 net/ipv6/mcast.c:961
       pndisc_constructor+0xf7/0x150 net/ipv6/ndisc.c:383
       pneigh_create+0x2ae/0x4f0 net/core/neighbour.c:810
       neigh_add+0x458/0x1210 net/core/neighbour.c:2088
       rtnetlink_rcv_msg+0x3c9/0xe90 net/core/rtnetlink.c:6967
       netlink_rcv_skb+0x159/0x420 net/netlink/af_netlink.c:2550
       netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
       netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1344
       netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1894
       sock_sendmsg_nosec net/socket.c:727 [inline]
       __sock_sendmsg net/socket.c:742 [inline]
       ____sys_sendmsg+0x9e1/0xb70 net/socket.c:2592
       ___sys_sendmsg+0x190/0x1e0 net/socket.c:2646
       __sys_sendmsg+0x170/0x220 net/socket.c:2678
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  fs_reclaim --> sk_lock-AF_INET6 --> &idev->mc_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&idev->mc_lock);
                               lock(sk_lock-AF_INET6);
                               lock(&idev->mc_lock);
  lock(fs_reclaim);

 *** DEADLOCK ***

3 locks held by syz.2.4459/20989:
 #0: ffffffff90610828 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #0: ffffffff90610828 (rtnl_mutex){+.+.}-{4:4}, at: rtnetlink_rcv_msg+0x371/0xe90 net/core/rtnetlink.c:6964
 #1: ffffffff908161a0 (&tbl->phash_lock){+.+.}-{4:4}, at: pneigh_create+0x46/0x4f0 net/core/neighbour.c:792
 #2: ffff88803538d538 (&idev->mc_lock){+.+.}-{4:4}, at: __ipv6_dev_mc_inc+0x53/0xbc0 net/ipv6/mcast.c:943

stack backtrace:
CPU: 0 UID: 0 PID: 20989 Comm: syz.2.4459 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/27/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_circular_bug.cold+0x178/0x1c7 kernel/locking/lockdep.c:2043
 check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x14b8/0x2630 kernel/locking/lockdep.c:5237
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x1cf/0x380 kernel/locking/lockdep.c:5825
 __fs_reclaim_acquire mm/page_alloc.c:4348 [inline]
 fs_reclaim_acquire+0xc4/0x100 mm/page_alloc.c:4362
 might_alloc include/linux/sched/mm.h:317 [inline]
 slab_pre_alloc_hook mm/slub.c:4493 [inline]
 slab_alloc_node mm/slub.c:4846 [inline]
 __kmalloc_cache_noprof+0x4b/0x6f0 mm/slub.c:5378
 kmalloc_noprof include/linux/slab.h:950 [inline]
 kzalloc_noprof include/linux/slab.h:1188 [inline]
 mca_alloc net/ipv6/mcast.c:871 [inline]
 __ipv6_dev_mc_inc+0x2f1/0xbc0 net/ipv6/mcast.c:961
 pndisc_constructor+0xf7/0x150 net/ipv6/ndisc.c:383
 pneigh_create+0x2ae/0x4f0 net/core/neighbour.c:810
 neigh_add+0x458/0x1210 net/core/neighbour.c:2088
 rtnetlink_rcv_msg+0x3c9/0xe90 net/core/rtnetlink.c:6967
 netlink_rcv_skb+0x159/0x420 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0x9e1/0xb70 net/socket.c:2592
 ___sys_sendmsg+0x190/0x1e0 net/socket.c:2646
 __sys_sendmsg+0x170/0x220 net/socket.c:2678
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f26f559c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f26f650a028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f26f5816090 RCX: 00007f26f559c799
RDX: 0000000000040094 RSI: 0000200000000100 RDI: 0000000000000005
RBP: 00007f26f5632c99 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f26f5816128 R14: 00007f26f5816090 R15: 00007fffe7ac39c8
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

