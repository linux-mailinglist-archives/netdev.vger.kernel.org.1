Return-Path: <netdev+bounces-277437-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIrwLsUM2Wl+lggAu9opvQ
	(envelope-from <netdev+bounces-277437-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 16:44:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E91A3D8C4C
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 16:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 228063013D5F
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 14:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D58B3D3001;
	Fri, 10 Apr 2026 14:41:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BFE3C2770
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 14:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775832089; cv=none; b=KQlyQrYkTQgqMhezWlbbMZhip2K2L3EyuW14rchROzIjsaahLV2AeISnmsChbI8/SBiis1LajVPyDfN2C3KvHL6DveJrT0l1KjWJknJyeQpHNt3Oc04sWeNrsQnT3rGHJd1bOveDNmS6+H5kfhvh6go5i2EJrkZjiiuIPBkTHVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775832089; c=relaxed/simple;
	bh=qyRRJ0sRJKfldB6It3n4ao0BRmGNKWXfeRnBIvYGlvU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QrU+08j2wzoZJgEAO2HNKSwE7E1DPcqA0ubz9ay/xOCq4WUR9yClO0vdbWV3nZZ3fipLHxfmI9SfyZ5dMcOg0hr+nXq6H/cjay5oX8o5KmvHEgXhH73hvvAVNA3v1hS6nruFDyvVq7VlO7PHT0zMNEtEET7FDAlmZUeIWfPvjIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-68240056f4cso3864448eaf.1
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 07:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775832086; x=1776436886;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hHhfzTdB+PCPQvltuUjqKgnDvTCQ9krHPUO1aW9Pu7Q=;
        b=AEOT4RKFR5fUdPC6Qlg159gREqXEbRhrqyPR4JUHqKDJ+rhUsXEkzbfez7EDr+5jot
         iMfitecaZIHmCSs0Zc/cQf5qCmoNdSWOXvhION4FKUGUxwM0EMwzrB63ZgP7r/d4OWQk
         CX8zA1Bem71SiDgnT6yACkFr2Ers0zt/SjSd1LKY8iZTv6dV2d0YG922gRn3pK3TpKyy
         kGfgign3UcmuJYDcjtN7h8EMli50QPIAkS4IGHrp5HpsHYdfETIV05pfkv1wqk6zgX9h
         zaEYZJRzIJY302o4jseTjFNgc6L7MRdYqLLHVqvBwTpcTP5dfMj6QO/ygZu8A7soo+7u
         cHbA==
X-Forwarded-Encrypted: i=1; AJvYcCWx8iwnVIM4CDlVfAcJOIAPnJQDuWzRlo2/JHrJji/l8vXz/xHkYFPrUjTWyvbudY30GfJmKCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YypSF0+ae3opOTaUW8Hzvz93al1sP4npqih6B07i5qMHuuZ8wAF
	vLYGesGJOtzWNkRm3V1s1VzAVTSvk4bahuhw1DvjYgVjTFDM0iCa3NQIVlZo88Pqrv9B+qfB1Ix
	IM25mrGEqzhjAQGid4MRNmbkqioAn6kgwx2ESwy9zuyUg5P/vXhxq3XVEYNY=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4b91:b0:68a:f494:e8fc with SMTP id
 006d021491bc7-68be7ae79c2mr1627283eaf.33.1775832086540; Fri, 10 Apr 2026
 07:41:26 -0700 (PDT)
Date: Fri, 10 Apr 2026 07:41:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69d90c16.050a0220.adfb3.000a.GAE@google.com>
Subject: [syzbot] [mptcp?] possible deadlock in mptcp_pm_nl_set_flags
From: syzbot <syzbot+dfa28bb6444d8f169cbb@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, geliang@kernel.org, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martineau@kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=5a3e5e8c17cc174e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-277437-lists,netdev=lfdr.de,dfa28bb6444d8f169cbb];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,googlegroups.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url,goo.gl:url,appspotmail.com:email]
X-Rspamd-Queue-Id: 0E91A3D8C4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    591cd656a1bf Linux 7.0-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1779ce06580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a3e5e8c17cc174e
dashboard link: https://syzkaller.appspot.com/bug?extid=dfa28bb6444d8f169cbb
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-591cd656.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3e99d0e29df0/vmlinux-591cd656.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5877fee0a056/bzImage-591cd656.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dfa28bb6444d8f169cbb@syzkaller.appspotmail.com

netlink: 8 bytes leftover after parsing attributes in process `syz.8.6915'.
netlink: 8 bytes leftover after parsing attributes in process `syz.8.6915'.
======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.8.6915/29783 is trying to acquire lock:
ffffffff8e9ab8a0 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:317 [inline]
ffffffff8e9ab8a0 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slub.c:4489 [inline]
ffffffff8e9ab8a0 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:4843 [inline]
ffffffff8e9ab8a0 (fs_reclaim){+.+.}-{0:0}, at: kmem_cache_alloc_lru_noprof+0x51/0x6e0 mm/slub.c:4885

but task is already holding lock:
ffff888034761ae0 (sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1709 [inline]
ffff888034761ae0 (sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_pm_nl_set_flags_all net/mptcp/pm_kernel.c:1482 [inline]
ffff888034761ae0 (sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_pm_nl_set_flags+0x605/0xd30 net/mptcp/pm_kernel.c:1551

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #6 (sk_lock-AF_INET){+.+.}-{0:0}:
       lock_sock_nested+0x41/0xf0 net/core/sock.c:3780
       lock_sock include/net/sock.h:1709 [inline]
       inet_shutdown+0x67/0x410 net/ipv4/af_inet.c:919
       nbd_mark_nsock_dead+0xae/0x5c0 drivers/block/nbd.c:318
       recv_work+0x5fb/0x8c0 drivers/block/nbd.c:1021
       process_one_work+0xa23/0x19a0 kernel/workqueue.c:3276
       process_scheduled_works kernel/workqueue.c:3359 [inline]
       worker_thread+0x5ef/0xe50 kernel/workqueue.c:3440
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
       block_read_full_folio+0x4c8/0x8e0 fs/buffer.c:2458
       filemap_read_folio+0xfc/0x3b0 mm/filemap.c:2501
       do_read_cache_folio+0x2d7/0x6b0 mm/filemap.c:4101
       read_mapping_folio include/linux/pagemap.h:1017 [inline]
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
       do_open fs/namei.c:4677 [inline]
       path_openat+0x208c/0x31a0 fs/namei.c:4836
       do_file_open+0x20e/0x430 fs/namei.c:4865
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
       block_read_full_folio+0x4c8/0x8e0 fs/buffer.c:2458
       filemap_read_folio+0xfc/0x3b0 mm/filemap.c:2501
       do_read_cache_folio+0x2d7/0x6b0 mm/filemap.c:4101
       read_mapping_folio include/linux/pagemap.h:1017 [inline]
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
       do_open fs/namei.c:4677 [inline]
       path_openat+0x208c/0x31a0 fs/namei.c:4836
       do_file_open+0x20e/0x430 fs/namei.c:4865
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
       __synchronize_srcu+0xa2/0x300 kernel/rcu/srcutree.c:1481
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
       nbd_genl_connect+0xff2/0x1a40 drivers/block/nbd.c:2239
       genl_family_rcv_msg_doit+0x214/0x300 net/netlink/genetlink.c:1114
       genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
       genl_rcv_msg+0x560/0x800 net/netlink/genetlink.c:1209
       netlink_rcv_skb+0x159/0x420 net/netlink/af_netlink.c:2550
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
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

-> #1 (&q->q_usage_counter(io)#51){++++}-{0:0}:
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
       slab_pre_alloc_hook mm/slub.c:4489 [inline]
       slab_alloc_node mm/slub.c:4843 [inline]
       kmem_cache_alloc_lru_noprof+0x51/0x6e0 mm/slub.c:4885
       sock_alloc_inode+0x25/0x1c0 net/socket.c:322
       alloc_inode+0x68/0x250 fs/inode.c:347
       new_inode_pseudo include/linux/fs.h:3003 [inline]
       sock_alloc+0x44/0x280 net/socket.c:637
       __sock_create+0xc2/0x860 net/socket.c:1569
       mptcp_subflow_create_socket+0xec/0xa30 net/mptcp/subflow.c:1790
       __mptcp_subflow_connect+0x3c6/0x1480 net/mptcp/subflow.c:1631
       mptcp_pm_create_subflow_or_signal_addr+0xc3e/0x18d0 net/mptcp/pm_kernel.c:416
       mptcp_pm_nl_fullmesh net/mptcp/pm_kernel.c:1460 [inline]
       mptcp_pm_nl_set_flags_all net/mptcp/pm_kernel.c:1487 [inline]
       mptcp_pm_nl_set_flags+0x814/0xd30 net/mptcp/pm_kernel.c:1551
       mptcp_pm_set_flags net/mptcp/pm_netlink.c:277 [inline]
       mptcp_pm_nl_set_flags_doit+0x1b0/0x290 net/mptcp/pm_netlink.c:282
       genl_family_rcv_msg_doit+0x214/0x300 net/netlink/genetlink.c:1114
       genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
       genl_rcv_msg+0x560/0x800 net/netlink/genetlink.c:1209
       netlink_rcv_skb+0x159/0x420 net/netlink/af_netlink.c:2550
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
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
  fs_reclaim --> &nsock->tx_lock --> sk_lock-AF_INET

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sk_lock-AF_INET);
                               lock(&nsock->tx_lock);
                               lock(sk_lock-AF_INET);
  lock(fs_reclaim);

 *** DEADLOCK ***

3 locks held by syz.8.6915/29783:
 #0: ffffffff906c06f0 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1217
 #1: ffffffff906c07a8 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff906c07a8 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff906c07a8 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:57 [inline]
 #1: ffffffff906c07a8 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x57b/0x800 net/netlink/genetlink.c:1208
 #2: ffff888034761ae0 (sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1709 [inline]
 #2: ffff888034761ae0 (sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_pm_nl_set_flags_all net/mptcp/pm_kernel.c:1482 [inline]
 #2: ffff888034761ae0 (sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_pm_nl_set_flags+0x605/0xd30 net/mptcp/pm_kernel.c:1551

stack backtrace:
CPU: 3 UID: 0 PID: 29783 Comm: syz.8.6915 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
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
 slab_pre_alloc_hook mm/slub.c:4489 [inline]
 slab_alloc_node mm/slub.c:4843 [inline]
 kmem_cache_alloc_lru_noprof+0x51/0x6e0 mm/slub.c:4885
 sock_alloc_inode+0x25/0x1c0 net/socket.c:322
 alloc_inode+0x68/0x250 fs/inode.c:347
 new_inode_pseudo include/linux/fs.h:3003 [inline]
 sock_alloc+0x44/0x280 net/socket.c:637
 __sock_create+0xc2/0x860 net/socket.c:1569
 mptcp_subflow_create_socket+0xec/0xa30 net/mptcp/subflow.c:1790
 __mptcp_subflow_connect+0x3c6/0x1480 net/mptcp/subflow.c:1631
 mptcp_pm_create_subflow_or_signal_addr+0xc3e/0x18d0 net/mptcp/pm_kernel.c:416
 mptcp_pm_nl_fullmesh net/mptcp/pm_kernel.c:1460 [inline]
 mptcp_pm_nl_set_flags_all net/mptcp/pm_kernel.c:1487 [inline]
 mptcp_pm_nl_set_flags+0x814/0xd30 net/mptcp/pm_kernel.c:1551
 mptcp_pm_set_flags net/mptcp/pm_netlink.c:277 [inline]
 mptcp_pm_nl_set_flags_doit+0x1b0/0x290 net/mptcp/pm_netlink.c:282
 genl_family_rcv_msg_doit+0x214/0x300 net/netlink/genetlink.c:1114
 genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
 genl_rcv_msg+0x560/0x800 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x159/0x420 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
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
RIP: 0033:0x7f989e39c819
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f989f2e9028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f989e615fa0 RCX: 00007f989e39c819
RDX: 0000000000000000 RSI: 0000200000000400 RDI: 000000000000000a
RBP: 00007f989e432c91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f989e616038 R14: 00007f989e615fa0 R15: 00007ffe13f4f538
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

