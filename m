Return-Path: <netdev+bounces-287729-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id thxKDGv2BGrvQwIAu9opvQ
	(envelope-from <netdev+bounces-287729-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 00:08:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2387C53B43E
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 00:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 90B0B3007A71
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 22:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD8B3CAA2F;
	Wed, 13 May 2026 22:08:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBAC3C9EE9
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 22:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778710115; cv=none; b=Jo7NrXpQsAZSKC0oWlsYTLBUjPXeKpiED/GwKxUDsGaz7iJJbf/6LXyKNn4Vf9P84oxO5BbDdBCZCAhaajUk6aVer0sa7P7eXOiwuQINKOKJhSqmv/AP7h1S7rxOIE7icvZmrYSqJK7v9FU18+NY5oKdyQI+VQb8Xc8fnqTGnH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778710115; c=relaxed/simple;
	bh=YPR8BJYgZ46QxTQCgqvbpMBPBYcMqHx+ffAh7KCRgtk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ExV8OY/67hS3sgkTyzLPGogi32zhj5wzzuSZOATDEg604ibDQ6lK9KFSnHMhFrV23AJfHkac82MUue3SNkNM3VpbRgxNKjlsPT3KYATE4ZMVjfwYL3FwhpYvK3G4ZyUu6atqdVscr8ExNJsLqaDUPkp6gk3n0IG12mk2f6oVp0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-698229e6b62so13122494eaf.3
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 15:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778710112; x=1779314912;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z8z0AdX0Vcxohf8RV/trjqqAyojHdIKq6N1TRI769CI=;
        b=Jin/3FBxTNWPOLkXqpWX/2O8atuZoUob+4gYo9G3g+iKFWWRIu0bKblSkmrRY3cuyl
         qCGtIuXTCpqTpc6gnnTpa/Y09vO97xJ617OeGbTFSCRbUKOoPNcpmKOPRmiFU9Do/U02
         y908KLISohyd7KgsKzeKUP0G/aS3rFLXOCxpOeXp4o8109iq2inJn31EU80iaX254M61
         7lStx7eO2N6uCF+Fo6HUQShOeJMzQljSXC3uNxOuT1VeKiHn9Vh9Y1cZgPC0gPYKQ8X2
         zS0h1q1YaJY8iK/AOPLatLX8N3+k1jtaAeM8mJAxI3NetEk+gtOyF4AxExz5ekAM2PK6
         mP/A==
X-Forwarded-Encrypted: i=1; AFNElJ9lqh0TnjkwkO7+cVtD14ujlT0bJ+wGDYoxOzh8B04Zr155mWKoczOsmY2ErCIEKX582X098cs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNlvseSkVwleqquNFhuUCfRoNko82NheTIvt065hI7HSF4DiBS
	xw8WNNQuHrW6Wp2T6d8amID6QMx1JKH6ZhMmqTV7aSReEjb//xYpGOojWoYJ87kT6TTHjyLGB31
	qO10siGw8DKWr49dHfIMl1CrUYtSo4n5LVG7jujqJ6ui13wDBEp9EHVSoQLU=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:812:b0:696:982b:1c24 with SMTP id
 006d021491bc7-69b7abc5ce3mr2500422eaf.57.1778710112686; Wed, 13 May 2026
 15:08:32 -0700 (PDT)
Date: Wed, 13 May 2026 15:08:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a04f660.170a0220.14b6e7.0322.GAE@google.com>
Subject: [syzbot] [fs?] possible deadlock in dump_user_range
From: syzbot <syzbot+e38c5976dd6f8050906a@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 2387C53B43E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=f2b487b72ffad035];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-287729-lists,netdev=lfdr.de,e38c5976dd6f8050906a];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,syzkaller.appspot.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,goo.gl:url,appspotmail.com:email,googlegroups.com:email]
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    8b2feced65cd Merge branch 'net-dsa-microchip-remove-one-in..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16df71ce580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f2b487b72ffad035
dashboard link: https://syzkaller.appspot.com/bug?extid=e38c5976dd6f8050906a
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/25f12e68ab8d/disk-8b2feced.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d8c43b4ea8e7/vmlinux-8b2feced.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e3d8f43606e0/bzImage-8b2feced.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e38c5976dd6f8050906a@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.2.4726/25180 is trying to acquire lock:
ffffffff8ea85520 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:317 [inline]
ffffffff8ea85520 (fs_reclaim){+.+.}-{0:0}, at: prepare_alloc_pages+0x152/0x650 mm/page_alloc.c:4995

but task is already holding lock:
ffff888025b88338 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock_killable include/linux/mmap_lock.h:601 [inline]
ffff888025b88338 (&mm->mmap_lock){++++}-{4:4}, at: dump_user_range+0x1c5/0x12c0 fs/coredump.c:1360

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #7 (&mm->mmap_lock){++++}-{4:4}:
       __might_fault+0xcb/0x130 mm/memory.c:7324
       _inline_copy_from_user include/linux/uaccess.h:169 [inline]
       _copy_from_user+0x28/0xb0 lib/usercopy.c:18
       copy_from_user include/linux/uaccess.h:223 [inline]
       csum_and_copy_from_user include/net/checksum.h:31 [inline]
       copy_from_user_iter_csum net/core/skbuff.c:7402 [inline]
       iterate_ubuf include/linux/iov_iter.h:30 [inline]
       iterate_and_advance2 include/linux/iov_iter.h:302 [inline]
       csum_and_copy_from_iter_full+0x1e7/0x1f00 net/core/skbuff.c:7414
       ip_generic_getfrag+0x149/0x2d0 net/ipv4/ip_output.c:942
       __ip6_append_data+0x39cd/0x3f60 net/ipv6/ip6_output.c:1736
       ip6_append_data+0x10f/0x280 net/ipv6/ip6_output.c:1891
       rawv6_sendmsg+0x12d3/0x18e0 net/ipv6/raw.c:913
       sock_sendmsg_nosec net/socket.c:787 [inline]
       __sock_sendmsg net/socket.c:802 [inline]
       ____sys_sendmsg+0x80a/0x9f0 net/socket.c:2698
       ___sys_sendmsg+0x2a5/0x360 net/socket.c:2752
       __sys_sendmsg net/socket.c:2784 [inline]
       __do_sys_sendmsg net/socket.c:2789 [inline]
       __se_sys_sendmsg net/socket.c:2787 [inline]
       __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2787
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #6 (sk_lock-AF_INET6){+.+.}-{0:0}:
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

-> #5 (&nsock->tx_lock){+.+.}-{4:4}:
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

-> #4 (&cmd->lock){+.+.}-{4:4}:
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

-> #3 (set->srcu){.+.+}-{0:0}:
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

-> #2 (&q->elevator_lock){+.+.}-{4:4}:
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

-> #1 (&q->q_usage_counter(io)#49){++++}-{0:0}:
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

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x15a5/0x2cf0 kernel/locking/lockdep.c:5237
       lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
       __fs_reclaim_acquire mm/page_alloc.c:4325 [inline]
       fs_reclaim_acquire+0x71/0x100 mm/page_alloc.c:4339
       might_alloc include/linux/sched/mm.h:317 [inline]
       prepare_alloc_pages+0x152/0x650 mm/page_alloc.c:4995
       __alloc_frozen_pages_noprof+0x12f/0x380 mm/page_alloc.c:5215
       alloc_pages_mpol+0x235/0x490 mm/mempolicy.c:2490
       alloc_frozen_pages_noprof mm/mempolicy.c:2561 [inline]
       alloc_pages_noprof+0xac/0x2a0 mm/mempolicy.c:2581
       pagetable_alloc_noprof include/linux/mm.h:3651 [inline]
       pmd_alloc_one_noprof include/asm-generic/pgalloc.h:143 [inline]
       __pmd_alloc+0x3a/0x5c0 mm/memory.c:6804
       pmd_alloc include/linux/mm.h:3567 [inline]
       __handle_mm_fault mm/memory.c:6501 [inline]
       handle_mm_fault+0xe96/0x3170 mm/memory.c:6718
       faultin_page mm/gup.c:1126 [inline]
       __get_user_pages+0x1683/0x2720 mm/gup.c:1428
       __get_user_pages_locked mm/gup.c:1692 [inline]
       get_dump_page+0x1b5/0x410 mm/gup.c:2192
       dump_user_range+0x20a/0x12c0 fs/coredump.c:1372
       elf_core_dump+0x34c2/0x3ad0 fs/binfmt_elf.c:2109
       coredump_write+0x1216/0x1910 fs/coredump.c:1053
       do_coredump fs/coredump.c:1132 [inline]
       vfs_coredump+0x3807/0x4530 fs/coredump.c:1206
       get_signal+0x1107/0x1330 kernel/signal.c:3022
       arch_do_signal_or_restart+0xbc/0x830 arch/x86/kernel/signal.c:337
       __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
       exit_to_user_mode_loop+0x86/0x480 kernel/entry/common.c:98
       __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
       syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:238 [inline]
       syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
       do_syscall_64+0x33e/0xf80 arch/x86/entry/syscall_64.c:100
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  fs_reclaim --> sk_lock-AF_INET6 --> &mm->mmap_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(&mm->mmap_lock);
                               lock(sk_lock-AF_INET6);
                               lock(&mm->mmap_lock);
  lock(fs_reclaim);

 *** DEADLOCK ***

2 locks held by syz.2.4726/25180:
 #0: ffff88807db3a410 (sb_writers#5){.+.+}-{0:0}, at: do_coredump fs/coredump.c:1132 [inline]
 #0: ffff88807db3a410 (sb_writers#5){.+.+}-{0:0}, at: vfs_coredump+0x3807/0x4530 fs/coredump.c:1206
 #1: ffff888025b88338 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock_killable include/linux/mmap_lock.h:601 [inline]
 #1: ffff888025b88338 (&mm->mmap_lock){++++}-{4:4}, at: dump_user_range+0x1c5/0x12c0 fs/coredump.c:1360

stack backtrace:
CPU: 1 UID: 0 PID: 25180 Comm: syz.2.4726 Not tainted syzkaller #0 PREEMPT(full) 
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
 __fs_reclaim_acquire mm/page_alloc.c:4325 [inline]
 fs_reclaim_acquire+0x71/0x100 mm/page_alloc.c:4339
 might_alloc include/linux/sched/mm.h:317 [inline]
 prepare_alloc_pages+0x152/0x650 mm/page_alloc.c:4995
 __alloc_frozen_pages_noprof+0x12f/0x380 mm/page_alloc.c:5215
 alloc_pages_mpol+0x235/0x490 mm/mempolicy.c:2490
 alloc_frozen_pages_noprof mm/mempolicy.c:2561 [inline]
 alloc_pages_noprof+0xac/0x2a0 mm/mempolicy.c:2581
 pagetable_alloc_noprof include/linux/mm.h:3651 [inline]
 pmd_alloc_one_noprof include/asm-generic/pgalloc.h:143 [inline]
 __pmd_alloc+0x3a/0x5c0 mm/memory.c:6804
 pmd_alloc include/linux/mm.h:3567 [inline]
 __handle_mm_fault mm/memory.c:6501 [inline]
 handle_mm_fault+0xe96/0x3170 mm/memory.c:6718
 faultin_page mm/gup.c:1126 [inline]
 __get_user_pages+0x1683/0x2720 mm/gup.c:1428
 __get_user_pages_locked mm/gup.c:1692 [inline]
 get_dump_page+0x1b5/0x410 mm/gup.c:2192
 dump_user_range+0x20a/0x12c0 fs/coredump.c:1372
 elf_core_dump+0x34c2/0x3ad0 fs/binfmt_elf.c:2109
 coredump_write+0x1216/0x1910 fs/coredump.c:1053
 do_coredump fs/coredump.c:1132 [inline]
 vfs_coredump+0x3807/0x4530 fs/coredump.c:1206
 get_signal+0x1107/0x1330 kernel/signal.c:3022
 arch_do_signal_or_restart+0xbc/0x830 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
 exit_to_user_mode_loop+0x86/0x480 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:238 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
 do_syscall_64+0x33e/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f71b9b9cdd9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f71bab36028 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: 0000000000000000 RBX: 00007f71b9e15fa0 RCX: 00007f71b9b9cdd9
RDX: 0000000000000048 RSI: 0000200000000500 RDI: 000000000000000a
RBP: 00007f71b9c32d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f71b9e16038 R14: 00007f71b9e15fa0 R15: 00007ffd0ce6f698
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

