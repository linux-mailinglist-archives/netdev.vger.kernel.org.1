Return-Path: <netdev+bounces-268832-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJi9DETtuWm3PgIAu9opvQ
	(envelope-from <netdev+bounces-268832-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 01:09:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF192B4876
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 01:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7BB653018418
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 00:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628BF175A5;
	Wed, 18 Mar 2026 00:09:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8381EB640
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 00:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773792576; cv=none; b=bHlJz4s4EuSzeNr0zVrNfazlI90NgJSNIEIK8HLgXn589a/ZmsL9SjmAvj/fYc0coixBw12eaF02gjMvEf1bHEab3NEgJ3+pSwoFYRn0UKg2y+nWATiKW4exBAAPX4YC53Y7DT0RgZCZWFCXutiZ9Ep/DV2uOS26xaLvZ460Ncc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773792576; c=relaxed/simple;
	bh=tqLVOEws6j6qhGVCJTReDISHNuu1EIziWmG6/Sg7E8s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UjjeSFNwvmwhy2AUCct/aeQTnfag6g9xutWqUtcg6trDwFQQBHg5W4Ml/CleAboH0lOR1sCyK56GlTUNWzN3AZHo/LHPFyRS8dGw1bKAwAFH2vfMI4WV78udmISgbzMMStnMc5RIuOMVO4wDwXwI8wPWqUvBRQpyJJLm5iW9iSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-67bb7ed941fso103155970eaf.0
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 17:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773792573; x=1774397373;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VK4/JIa49NhqARMo7dkKyosrLK30v0uR441rzA2hMlY=;
        b=r50QmN9lZ/qBvTuwBt4O4mnoU5l9HlucejVugE7yL1akI7TYWGqWDSOPe+eDF4nZg8
         Gl8aHkezR7gJVL+3PFmgpr+MJKSU4hvtY/tDxEh8SHw3XrbFfCBbj07IM3uT63bV3ugX
         fqbKA6o3e5Si+eGgN7qtkqAIE9LEw/HyikotHCBxd6lY00ObzDvSNp2r25u177Y/rlyk
         cyBDqAO+JLCxGrLRoOXGjbkTBOQ1BBf+wm0NcxqCodwEb3Nq4/f6TNMyAjcDI4fYtylK
         JAQlbA0DM+KtwgkwgW5Zz+XEEH2iOPHoIsqSTLt6AmidSwsxLVjvomDNKgGm0BTkap7N
         z+pw==
X-Forwarded-Encrypted: i=1; AJvYcCXFJxm1akJk7yXSWQU7lv96GRmV3wfDJf5qmcAYXys9ftS52bP0ND5ooCCLQiiAMDJEPKQdOqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YytpRKf8Hoqv/Z3FHxRNeDu3rwbIOLYuUJcTovlnatf659CJgrU
	u1qKk1TMKv3/Dxzb/RJJCiF6x7fEBeklR+Rnqtgn+Fyci1d2sLANYOYfk5DvdLIzw5jU8zjQUsO
	+Bj0fyU/Ht6KuSyG/oYhMB6d5Q2aHFJ147ajfLhIMV+6Za+KZgtaBoCGM3OA=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4687:b0:67b:a4fa:7a0 with SMTP id
 006d021491bc7-67c0dafa161mr808150eaf.44.1773792573450; Tue, 17 Mar 2026
 17:09:33 -0700 (PDT)
Date: Tue, 17 Mar 2026 17:09:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69b9ed3d.a00a0220.3b25d1.0032.GAE@google.com>
Subject: [syzbot] [net?] possible deadlock in inet_stream_connect (4)
From: syzbot <syzbot+e1a1439ba49a7a9aa9f5@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=aade4334d9486a4];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-268832-lists,netdev=lfdr.de,e1a1439ba49a7a9aa9f5];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.979];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,googlegroups.com:email,appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 9BF192B4876
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    b36eb6e3f5d8 Merge tag 'spi-fix-v7.0-rc3' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11d11def980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aade4334d9486a4
dashboard link: https://syzkaller.appspot.com/bug?extid=e1a1439ba49a7a9aa9f5
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-b36eb6e3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a7e997cac6da/vmlinux-b36eb6e3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c41b86e18d15/bzImage-b36eb6e3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e1a1439ba49a7a9aa9f5@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.1.10180/8739 is trying to acquire lock:
ffffffff8e9aafc0 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:317 [inline]
ffffffff8e9aafc0 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slub.c:4489 [inline]
ffffffff8e9aafc0 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:4843 [inline]
ffffffff8e9aafc0 (fs_reclaim){+.+.}-{0:0}, at: kmem_cache_alloc_node_noprof+0x53/0x6f0 mm/slub.c:4918

but task is already holding lock:
ffff888038354220 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1709 [inline]
ffff888038354220 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: inet_stream_connect+0x43/0xa0 net/ipv4/af_inet.c:755

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #7 (k-sk_lock-AF_INET){+.+.}-{0:0}:
       lock_sock_fast include/net/sock.h:1741 [inline]
       tcp_get_info+0x2a6/0x2870 net/ipv4/tcp.c:4284
       do_tcp_getsockopt+0x954/0x2a90 net/ipv4/tcp.c:4575
       tcp_getsockopt+0xe4/0x110 net/ipv4/tcp.c:4896
       mptcp_getsockopt_first_sf_only net/mptcp/sockopt.c:949 [inline]
       mptcp_getsockopt_sol_tcp net/mptcp/sockopt.c:1411 [inline]
       mptcp_getsockopt+0xbdb/0xe50 net/mptcp/sockopt.c:1529
       do_sock_getsockopt+0x259/0x3d0 net/socket.c:2383
       __sys_getsockopt+0x148/0x260 net/socket.c:2412
       __do_sys_getsockopt net/socket.c:2419 [inline]
       __se_sys_getsockopt net/socket.c:2416 [inline]
       __x64_sys_getsockopt+0xbd/0x160 net/socket.c:2416
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #6 (sk_lock-AF_INET){+.+.}-{0:0}:
       lock_sock_nested+0x41/0xf0 net/core/sock.c:3780
       lock_sock include/net/sock.h:1709 [inline]
       inet_shutdown+0x67/0x410 net/ipv4/af_inet.c:919
       nbd_mark_nsock_dead+0xae/0x5c0 drivers/block/nbd.c:318
       sock_shutdown+0x16b/0x200 drivers/block/nbd.c:411
       nbd_clear_sock drivers/block/nbd.c:1427 [inline]
       nbd_config_put+0x1eb/0x750 drivers/block/nbd.c:1451
       nbd_release+0xb7/0x190 drivers/block/nbd.c:1756
       blkdev_put_whole+0xb0/0xf0 block/bdev.c:737
       bdev_release+0x47f/0x6d0 block/bdev.c:1160
       blkdev_release+0x15/0x20 block/fops.c:705
       __fput+0x3ff/0xb40 fs/file_table.c:469
       task_work_run+0x150/0x240 kernel/task_work.c:233
       resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
       __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
       exit_to_user_mode_loop+0x100/0x4a0 kernel/entry/common.c:98
       __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
       syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
       syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
       do_syscall_64+0x67c/0xf80 arch/x86/entry/syscall_64.c:100
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

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

-> #1 (&q->q_usage_counter(io)#50){++++}-{0:0}:
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
       kmem_cache_alloc_node_noprof+0x53/0x6f0 mm/slub.c:4918
       __alloc_skb+0x140/0x710 net/core/skbuff.c:702
       alloc_skb_fclone include/linux/skbuff.h:1433 [inline]
       tcp_stream_alloc_skb+0x34/0x660 net/ipv4/tcp.c:945
       tcp_connect+0xe8c/0x5630 net/ipv4/tcp_output.c:4361
       tcp_v4_connect+0x1603/0x1b40 net/ipv4/tcp_ipv4.c:346
       __inet_stream_connect+0x208/0xfa0 net/ipv4/af_inet.c:685
       inet_stream_connect+0x57/0xa0 net/ipv4/af_inet.c:756
       p9_fd_create_tcp+0x379/0x4d0 net/9p/trans_fd.c:917
       p9_client_create+0x563/0xd40 net/9p/client.c:894
       v9fs_session_init+0x40/0xce0 fs/9p/v9fs.c:442
       v9fs_get_tree+0xb8/0xb50 fs/9p/vfs_super.c:97
       vfs_get_tree+0x92/0x320 fs/super.c:1754
       fc_mount fs/namespace.c:1193 [inline]
       do_new_mount_fc fs/namespace.c:3763 [inline]
       do_new_mount fs/namespace.c:3839 [inline]
       path_mount+0x7d0/0x23d0 fs/namespace.c:4159
       do_mount fs/namespace.c:4172 [inline]
       __do_sys_mount fs/namespace.c:4361 [inline]
       __se_sys_mount fs/namespace.c:4338 [inline]
       __x64_sys_mount+0x293/0x310 fs/namespace.c:4338
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  fs_reclaim --> sk_lock-AF_INET --> k-sk_lock-AF_INET

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(k-sk_lock-AF_INET);
                               lock(sk_lock-AF_INET);
                               lock(k-sk_lock-AF_INET);
  lock(fs_reclaim);

 *** DEADLOCK ***

1 lock held by syz.1.10180/8739:
 #0: ffff888038354220 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1709 [inline]
 #0: ffff888038354220 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: inet_stream_connect+0x43/0xa0 net/ipv4/af_inet.c:755

stack backtrace:
CPU: 2 UID: 0 PID: 8739 Comm: syz.1.10180 Tainted: G             L      syzkaller #0 PREEMPT(full) 
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
 kmem_cache_alloc_node_noprof+0x53/0x6f0 mm/slub.c:4918
 __alloc_skb+0x140/0x710 net/core/skbuff.c:702
 alloc_skb_fclone include/linux/skbuff.h:1433 [inline]
 tcp_stream_alloc_skb+0x34/0x660 net/ipv4/tcp.c:945
 tcp_connect+0xe8c/0x5630 net/ipv4/tcp_output.c:4361
 tcp_v4_connect+0x1603/0x1b40 net/ipv4/tcp_ipv4.c:346
 __inet_stream_connect+0x208/0xfa0 net/ipv4/af_inet.c:685
 inet_stream_connect+0x57/0xa0 net/ipv4/af_inet.c:756
 p9_fd_create_tcp+0x379/0x4d0 net/9p/trans_fd.c:917
 p9_client_create+0x563/0xd40 net/9p/client.c:894
 v9fs_session_init+0x40/0xce0 fs/9p/v9fs.c:442
 v9fs_get_tree+0xb8/0xb50 fs/9p/vfs_super.c:97
 vfs_get_tree+0x92/0x320 fs/super.c:1754
 fc_mount fs/namespace.c:1193 [inline]
 do_new_mount_fc fs/namespace.c:3763 [inline]
 do_new_mount fs/namespace.c:3839 [inline]
 path_mount+0x7d0/0x23d0 fs/namespace.c:4159
 do_mount fs/namespace.c:4172 [inline]
 __do_sys_mount fs/namespace.c:4361 [inline]
 __se_sys_mount fs/namespace.c:4338 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:4338
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f614c59c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f614d4ce028 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f614c816090 RCX: 00007f614c59c799
RDX: 0000200000000040 RSI: 0000200000000680 RDI: 0000200000000640
RBP: 00007f614c632c99 R08: 00002000000000c0 R09: 0000000000000000
R10: 0000000000008010 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f614c816128 R14: 00007f614c816090 R15: 00007ffef49712c8
 </TASK>
9pnet_fd: p9_fd_create_tcp (8739): problem connecting socket to 127.0.0.1


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

