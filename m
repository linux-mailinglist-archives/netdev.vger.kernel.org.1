Return-Path: <netdev+bounces-287125-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEeBEWcnA2qw1AEAu9opvQ
	(envelope-from <netdev+bounces-287125-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:13:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B70520DF1
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30D303106A67
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31E23A2E3E;
	Tue, 12 May 2026 12:48:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAE739060E
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 12:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778590121; cv=none; b=HulH2Kz/xHI9e3D/elWWs+QmArmT2tISZ84hq8jru18yktxx7UGYZUFsOWzxjr9MwGoyVo9zxBNksGJYWjKkM5jfRyeXNBCB4V/OE4NK5amtfWLP7gChFdCGl+7tb3VRke2QS1zjjH0X3UidrkS4LtfpkPX/uMTlVXxddMyWMvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778590121; c=relaxed/simple;
	bh=SfxcNzeS1JuRK07IVzQeKJTzXG6c5s/TzC50C+qycuw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hxtemiDP8N84D5XHpcY2EeUj4KXzPa5wXxAJCZu3ImZ9WCcfNp2Qm+t/VnWiB2u3stFB3l0RBymagRwps3l/uLqj83piZ4sINCmZLGBdnpUooye7581RpLMt9Y0CnYweFLlqsQXafVOFI5hbzJjAxRouMdW9QP9xweh9rigJ5Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-7dccdbdf5c2so7154543a34.3
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 05:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778590116; x=1779194916;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cd9LXtPhfDHePTwxJGaWHmcjhogkblqCX5pNoCYmZaY=;
        b=DC5AR8cjAbNoNuYb/brkHkGY+NLPxXJC9xS8RwjbN1Gg4ZyGLTbfWr+tK+XRMCCHLa
         7MyMCI7xS6jhk0qutz26pDkKXGrGTtQBSFGdhFBtlXvuQR8oARMU/zO2Txh/ZAB5OZ2h
         IAZv2UaP3vEIp9x6/EvBpMb48kuKaNSx5CbuJqr27ZUIWEcalxyNb0FEYwbv8IQeZnLY
         dZXWgD2FAhvagdzMVNyAdnSEq+1d9DbedrF7vGoI+mXUDULofwPGTVfYvItHsz7i/bWf
         QuB1e0mFLRZBEKqRIYGUTZ8Fvl/XWgaJQryvcS/bui5wPTWQ9HfIvBcr49u0a1OQEWOL
         kJ/w==
X-Forwarded-Encrypted: i=1; AFNElJ9xcRGedfBF8bogOsH3UqaLATJwBKUJu72vLgcga0SmpgLr5SCtIUF4oYg/RXtOGwpdEwBAQUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW8ye/gW4KTUts/Lhj4YSb15PraZmeg5Zim1LZ9iRCCwIM//M7
	j5Uk7boBTMXyL+JGTYJh2s1dHrYU0gtyVGx/jns5crZo3N7Z56KX0Ynzz8sJXHr9icK5/rzW5h6
	WoCw/VvqjoFIOZKf9S0xD0ui+sGwxiGIHz1g+70f4jcpCHsWnuj9SNMhlnB0=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4df7:b0:694:9b71:3743 with SMTP id
 006d021491bc7-69b36ec93d4mr7379144eaf.51.1778590115802; Tue, 12 May 2026
 05:48:35 -0700 (PDT)
Date: Tue, 12 May 2026 05:48:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a0321a3.050a0220.106bf4.0005.GAE@google.com>
Subject: [syzbot] [mm?] possible deadlock in gup_fast_fallback (3)
From: syzbot <syzbot+8edc46c9c781c802acf4@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, david@kernel.org, jgg@ziepe.ca, 
	jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	netdev@vger.kernel.org, peterx@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 85B70520DF1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=f2b487b72ffad035];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-287125-lists,netdev=lfdr.de,8edc46c9c781c802acf4];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlegroups.com:email,syzkaller.appspot.com:url,storage.googleapis.com:url,goo.gl:url,appspotmail.com:email]
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    63751099502d Merge branch 'net-mlx5-steering-misc-enhancem..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1714fbce580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f2b487b72ffad035
dashboard link: https://syzkaller.appspot.com/bug?extid=8edc46c9c781c802acf4
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1f8de738e2f8/disk-63751099.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ae6cfb0d3b70/vmlinux-63751099.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f00e218e1a55/bzImage-63751099.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8edc46c9c781c802acf4@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.4.2801/16593 is trying to acquire lock:
ffff88802ae527f8 (&mm->mmap_lock){++++}-{4:4}, at: gup_fast_fallback+0x20d/0x20d0 mm/gup.c:3193

but task is already holding lock:
ffff888055ac9d60 (sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1713 [inline]
ffff888055ac9d60 (sk_lock-AF_INET6){+.+.}-{0:0}, at: tls_sw_sendmsg+0x15d/0x2430 net/tls/tls_sw.c:1291

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #7 (sk_lock-AF_INET6){+.+.}-{0:0}:
       lock_sock_nested+0x41/0x100 net/core/sock.c:3783
       lock_sock include/net/sock.h:1713 [inline]
       inet_shutdown+0x6a/0x390 net/ipv4/af_inet.c:915
       nbd_mark_nsock_dead+0x2e9/0x560 drivers/block/nbd.c:318
       sock_shutdown+0x15e/0x260 drivers/block/nbd.c:411
       nbd_clear_sock+0x24/0x170 drivers/block/nbd.c:1427
       nbd_config_put+0x2dd/0x580 drivers/block/nbd.c:1451
       nbd_genl_connect+0x19d5/0x1cf0 drivers/block/nbd.c:2248
       genl_family_rcv_msg_doit+0x22a/0x330 net/netlink/genetlink.c:1114
       genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
       genl_rcv_msg+0x61c/0x7a0 net/netlink/genetlink.c:1209
       netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2551
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
       netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
       netlink_unicast+0x75c/0x8e0 net/netlink/af_netlink.c:1345
       netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1895
       sock_sendmsg_nosec net/socket.c:787 [inline]
       __sock_sendmsg net/socket.c:802 [inline]
       ____sys_sendmsg+0x972/0x9f0 net/socket.c:2698
       ___sys_sendmsg+0x2a5/0x360 net/socket.c:2752
       __sys_sendmsg net/socket.c:2784 [inline]
       __do_sys_sendmsg net/socket.c:2789 [inline]
       __se_sys_sendmsg net/socket.c:2787 [inline]
       __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2787
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #6 (&nsock->tx_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a3/0x1550 kernel/locking/mutex.c:820
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
       submit_bio_noacct_nocheck+0x2f4/0xa40 block/blk-core.c:753
       submit_bh fs/buffer.c:2742 [inline]
       block_read_full_folio+0x599/0x830 fs/buffer.c:2344
       filemap_read_folio+0x137/0x3b0 mm/filemap.c:2502
       do_read_cache_folio+0x358/0x590 mm/filemap.c:4107
       read_mapping_folio include/linux/pagemap.h:1017 [inline]
       read_part_sector+0xb6/0x2b0 block/partitions/core.c:724
       adfspart_check_ICS+0xb1/0x960 block/partitions/acorn.c:356
       check_partition block/partitions/core.c:143 [inline]
       blk_add_partitions block/partitions/core.c:591 [inline]
       bdev_disk_changed+0x817/0x1770 block/partitions/core.c:695
       blkdev_get_whole+0x380/0x510 block/bdev.c:756
       bdev_open+0x31e/0xd30 block/bdev.c:965
       blkdev_open+0x470/0x610 block/fops.c:697
       do_dentry_open+0x785/0x14e0 fs/open.c:947
       vfs_open+0x3b/0x340 fs/open.c:1079
       do_open fs/namei.c:4699 [inline]
       path_openat+0x2e08/0x3860 fs/namei.c:4858
       do_file_open+0x23e/0x4a0 fs/namei.c:4887
       do_sys_openat2+0x113/0x200 fs/open.c:1364
       do_sys_open fs/open.c:1370 [inline]
       __do_sys_openat fs/open.c:1386 [inline]
       __se_sys_openat fs/open.c:1381 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1381
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #5 (&cmd->lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a3/0x1550 kernel/locking/mutex.c:820
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
       submit_bio_noacct_nocheck+0x2f4/0xa40 block/blk-core.c:753
       submit_bh fs/buffer.c:2742 [inline]
       block_read_full_folio+0x599/0x830 fs/buffer.c:2344
       filemap_read_folio+0x137/0x3b0 mm/filemap.c:2502
       do_read_cache_folio+0x358/0x590 mm/filemap.c:4107
       read_mapping_folio include/linux/pagemap.h:1017 [inline]
       read_part_sector+0xb6/0x2b0 block/partitions/core.c:724
       adfspart_check_ICS+0xb1/0x960 block/partitions/acorn.c:356
       check_partition block/partitions/core.c:143 [inline]
       blk_add_partitions block/partitions/core.c:591 [inline]
       bdev_disk_changed+0x817/0x1770 block/partitions/core.c:695
       blkdev_get_whole+0x380/0x510 block/bdev.c:756
       bdev_open+0x31e/0xd30 block/bdev.c:965
       blkdev_open+0x470/0x610 block/fops.c:697
       do_dentry_open+0x785/0x14e0 fs/open.c:947
       vfs_open+0x3b/0x340 fs/open.c:1079
       do_open fs/namei.c:4699 [inline]
       path_openat+0x2e08/0x3860 fs/namei.c:4858
       do_file_open+0x23e/0x4a0 fs/namei.c:4887
       do_sys_openat2+0x113/0x200 fs/open.c:1364
       do_sys_open fs/open.c:1370 [inline]
       __do_sys_openat fs/open.c:1386 [inline]
       __se_sys_openat fs/open.c:1381 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1381
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (set->srcu){.+.+}-{0:0}:
       srcu_lock_sync include/linux/srcu.h:199 [inline]
       __synchronize_srcu+0xca/0x300 kernel/rcu/srcutree.c:1481
       elevator_switch+0x1e8/0x7a0 block/elevator.c:576
       elevator_change+0x2cc/0x450 block/elevator.c:681
       elevator_set_default+0x36c/0x430 block/elevator.c:754
       blk_register_queue+0x3e9/0x4e0 block/blk-sysfs.c:987
       __add_disk+0x677/0xd50 block/genhd.c:528
       add_disk_fwnode+0xfb/0x480 block/genhd.c:597
       add_disk include/linux/blkdev.h:794 [inline]
       nbd_dev_add+0x72c/0xb50 drivers/block/nbd.c:1984
       nbd_init+0x168/0x1f0 drivers/block/nbd.c:2692
       do_one_initcall+0x250/0x870 init/main.c:1392
       do_initcall_level+0x104/0x190 init/main.c:1454
       do_initcalls+0x59/0xa0 init/main.c:1470
       kernel_init_freeable+0x2a6/0x3e0 init/main.c:1703
       kernel_init+0x1d/0x1d0 init/main.c:1593
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #3 (&q->elevator_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a3/0x1550 kernel/locking/mutex.c:820
       elevator_change+0x1b3/0x450 block/elevator.c:679
       elevator_set_none+0xb5/0x140 block/elevator.c:769
       blk_mq_elv_switch_none block/blk-mq.c:5131 [inline]
       __blk_mq_update_nr_hw_queues block/blk-mq.c:5176 [inline]
       blk_mq_update_nr_hw_queues+0x5e7/0x1a60 block/blk-mq.c:5241
       nbd_start_device+0x17f/0xb10 drivers/block/nbd.c:1489
       nbd_genl_connect+0x165b/0x1cf0 drivers/block/nbd.c:2239
       genl_family_rcv_msg_doit+0x22a/0x330 net/netlink/genetlink.c:1114
       genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
       genl_rcv_msg+0x61c/0x7a0 net/netlink/genetlink.c:1209
       netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2551
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
       netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
       netlink_unicast+0x75c/0x8e0 net/netlink/af_netlink.c:1345
       netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1895
       sock_sendmsg_nosec net/socket.c:787 [inline]
       __sock_sendmsg net/socket.c:802 [inline]
       ____sys_sendmsg+0x972/0x9f0 net/socket.c:2698
       ___sys_sendmsg+0x2a5/0x360 net/socket.c:2752
       __sys_sendmsg net/socket.c:2784 [inline]
       __do_sys_sendmsg net/socket.c:2789 [inline]
       __se_sys_sendmsg net/socket.c:2787 [inline]
       __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2787
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&q->q_usage_counter(io)#49){++++}-{0:0}:
       blk_alloc_queue+0x546/0x680 block/blk-core.c:461
       blk_mq_alloc_queue block/blk-mq.c:4450 [inline]
       __blk_mq_alloc_disk+0x197/0x390 block/blk-mq.c:4497
       nbd_dev_add+0x499/0xb50 drivers/block/nbd.c:1954
       nbd_init+0x168/0x1f0 drivers/block/nbd.c:2692
       do_one_initcall+0x250/0x870 init/main.c:1392
       do_initcall_level+0x104/0x190 init/main.c:1454
       do_initcalls+0x59/0xa0 init/main.c:1470
       kernel_init_freeable+0x2a6/0x3e0 init/main.c:1703
       kernel_init+0x1d/0x1d0 init/main.c:1593
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #1 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:4325 [inline]
       fs_reclaim_acquire+0x71/0x100 mm/page_alloc.c:4339
       might_alloc include/linux/sched/mm.h:317 [inline]
       slab_pre_alloc_hook mm/slub.c:4520 [inline]
       slab_alloc_node mm/slub.c:4875 [inline]
       kmem_cache_alloc_noprof+0x40/0x650 mm/slub.c:4905
       mt_alloc_one lib/maple_tree.c:139 [inline]
       mas_alloc_nodes+0x291/0x350 lib/maple_tree.c:1089
       mas_preallocate+0x2d6/0x640 lib/maple_tree.c:4961
       vma_iter_prealloc mm/vma.h:577 [inline]
       vma_link+0x123/0x470 mm/vma.c:1849
       insert_vm_struct+0x1a5/0x270 mm/vma.c:3325
       create_init_stack_vma+0x546/0x9b0 mm/vma_exec.c:147
       bprm_mm_init fs/exec.c:274 [inline]
       alloc_bprm+0x495/0x5c0 fs/exec.c:1457
       class_bprm_constructor fs/exec.c:1466 [inline]
       kernel_execve+0x87/0x930 fs/exec.c:1859
       try_to_run_init_process+0x13/0x60 init/main.c:1521
       kernel_init+0xad/0x1d0 init/main.c:1649
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (&mm->mmap_lock){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x15a5/0x2cf0 kernel/locking/lockdep.c:5237
       lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
       gup_fast_fallback+0x226/0x20d0 mm/gup.c:3193
       __iov_iter_get_pages_alloc+0x370/0xa10 lib/iov_iter.c:1091
       iov_iter_get_pages2+0x5e/0xa0 lib/iov_iter.c:1137
       sk_msg_zerocopy_from_iter+0x22c/0x880 net/core/skmsg.c:328
       tls_sw_sendmsg_locked net/tls/tls_sw.c:1140 [inline]
       tls_sw_sendmsg+0x9f5/0x2430 net/tls/tls_sw.c:1292
       sock_sendmsg_nosec net/socket.c:787 [inline]
       __sock_sendmsg net/socket.c:802 [inline]
       __sys_sendto+0x4a3/0x710 net/socket.c:2265
       __do_sys_sendto net/socket.c:2272 [inline]
       __se_sys_sendto net/socket.c:2268 [inline]
       __x64_sys_sendto+0xde/0x100 net/socket.c:2268
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &mm->mmap_lock --> &nsock->tx_lock --> sk_lock-AF_INET6

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sk_lock-AF_INET6);
                               lock(&nsock->tx_lock);
                               lock(sk_lock-AF_INET6);
  rlock(&mm->mmap_lock);

 *** DEADLOCK ***

2 locks held by syz.4.2801/16593:
 #0: ffff888057aca0e8 (&ctx->tx_lock){+.+.}-{4:4}, at: tls_sw_sendmsg+0x130/0x2430 net/tls/tls_sw.c:1288
 #1: ffff888055ac9d60 (sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1713 [inline]
 #1: ffff888055ac9d60 (sk_lock-AF_INET6){+.+.}-{0:0}, at: tls_sw_sendmsg+0x15d/0x2430 net/tls/tls_sw.c:1291

stack backtrace:
CPU: 0 UID: 0 PID: 16593 Comm: syz.4.2801 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e1/0x300 kernel/locking/lockdep.c:2043
 check_noncircular+0x12e/0x150 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x15a5/0x2cf0 kernel/locking/lockdep.c:5237
 lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
 gup_fast_fallback+0x226/0x20d0 mm/gup.c:3193
 __iov_iter_get_pages_alloc+0x370/0xa10 lib/iov_iter.c:1091
 iov_iter_get_pages2+0x5e/0xa0 lib/iov_iter.c:1137
 sk_msg_zerocopy_from_iter+0x22c/0x880 net/core/skmsg.c:328
 tls_sw_sendmsg_locked net/tls/tls_sw.c:1140 [inline]
 tls_sw_sendmsg+0x9f5/0x2430 net/tls/tls_sw.c:1292
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 __sys_sendto+0x4a3/0x710 net/socket.c:2265
 __do_sys_sendto net/socket.c:2272 [inline]
 __se_sys_sendto net/socket.c:2268 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2268
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f75d6d5d60e
Code: 08 0f 85 a5 a8 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 00 00 00 48 83 ec 08
RSP: 002b:00007f75d7bc6e88 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f75d7bc86c0 RCX: 00007f75d6d5d60e
RDX: 0000000000000020 RSI: 00007f75d7bc7000 RDI: 0000000000000004
RBP: 0000000000000000 R08: 00007f75d7bc6f04 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: 00007f75d7bc6f58 R14: 00007f75d7bc7000 R15: 0000000000000000
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

