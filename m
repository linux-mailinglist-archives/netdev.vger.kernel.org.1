Return-Path: <netdev+bounces-197478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDCBAD8BF5
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 14:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96279189657A
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 12:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A922E1740;
	Fri, 13 Jun 2025 12:25:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC5A291C2E
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 12:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749817536; cv=none; b=GJJBQHQb9289AayN2YHDXUY2MhKz8G3/7ahpok8yWQzVmzpTCWlPTOOp5u5y5bpIpCGit5ffcHpI0CbsDoCdL9j2H0Q67GN5KoIO16lObVk7TbCxkYSxzvY5ut92yGxHeBoCzmvRw3aPeQuo5Lw1YtzL89ehDXN6bsNZ/kHb6YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749817536; c=relaxed/simple;
	bh=bpp0lVGEuF8flpcxOKWAMQ4XuePdjmQCqwirpfl2Elo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lCsuM2vKvdjqU1taJEzRzvdtycR4aasDyoQEoXJqchxEtA04N/Ef5IhgwFHezPmplX+h2kB9xmO9BGQC9HLhVPKR+DdxICoE6uBVs64mqT3t62I/3Q3HIAO456bzSudKdyaXakE0ohOBRZ051JlSRtfCKcZ/iqxh2huCX3aRSR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-8730ca8143eso313060939f.0
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 05:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749817533; x=1750422333;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h7VCsyeBXQVlEm/NEuR15PqCAZc8r9XyBDY6gEZqVeU=;
        b=m38RNcsEfsWzeVd8KndQq7VZsOe1xiWdwLZiyJF+0TUNm6m5vPsDUhq82+SzZMrUWP
         wvu1r+mZQeo5vjJYIGWlu4jwx5+XnhJH8QW6pHWdsQwrVekAobEBP6m/l+Su4XH/w2eQ
         nc5TrvSPWyYQGsTcGGejUOkru4EZP1FFH8lFh4uT82bNfaCZTiibgdr7hOhm5uFMRSfo
         19QH949OZgnt+PLngGju/UFalFmlkHAXOjvoz/iTYWy4sGWgIwnXXGKIj411eZyqOWHX
         dDE8wQJ4oJTKo9GdnE54ho55ijhM3l8HktYLOTZSp4P7cZ2Z+F/kFEIa5R+Z57zcqqNW
         OudQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXfbOBrC5HZMmmO2cCXwcFwfO+mOdV4NBSmdWVbcnqpI17ezv1z9/hbXttsIprQFS/KQyHz7A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9fdsQe8lHZidNuLd8p53i4bazXUUYqHrbU0CWhXq4ubtgA/yh
	DGlOZxPVu5T1i4B8wrRxnWbJgxnkAih18jyh+oR28W6FHqDefxVp8NK/ZDMRWfLnQqTQbGhk3P8
	aP48LstQsOmT+R8M3gRs3bjo6863IzMDNox837nYg27wTYIsbKfuIGG1Hko0=
X-Google-Smtp-Source: AGHT+IF5lS7pRNDXI2C1hp76avg35cCs65dqcgBlXimFpvWWQT6tb5REUn/PFG4YVx3rH8QIFbpEyTAhVwVpNeeJMflgS4b7/4cz
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fcb:b0:3dd:6696:2da7 with SMTP id
 e9e14a558f8ab-3de067161acmr5528985ab.1.1749817533492; Fri, 13 Jun 2025
 05:25:33 -0700 (PDT)
Date: Fri, 13 Jun 2025 05:25:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <684c18bd.a00a0220.279073.000b.GAE@google.com>
Subject: [syzbot] [bridge?] KASAN: slab-use-after-free Read in br_multicast_add_router
From: syzbot <syzbot+7bfa4b72c6a5da128d32@syzkaller.appspotmail.com>
To: bridge@lists.linux.dev, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	razor@blackwall.org, roopa@nvidia.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    82cbd06f327f net: enetc: fix the netc-lib driver build dep..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=163549d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73696606574e3967
dashboard link: https://syzkaller.appspot.com/bug?extid=7bfa4b72c6a5da128d32
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7bcff4a03866/disk-82cbd06f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/80e0c2155db8/vmlinux-82cbd06f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e766bd001fb5/bzImage-82cbd06f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7bfa4b72c6a5da128d32@syzkaller.appspotmail.com

netlink: 'syz.1.1059': attribute type 25 has an invalid length.
==================================================================
BUG: KASAN: slab-use-after-free in br_multicast_rport_from_node net/bridge/br_multicast.c:3298 [inline]
BUG: KASAN: slab-use-after-free in br_multicast_get_rport_slot net/bridge/br_multicast.c:3312 [inline]
BUG: KASAN: slab-use-after-free in br_multicast_add_router+0x15e/0x520 net/bridge/br_multicast.c:3350
Read of size 8 at addr ffff8880285f11b0 by task syz.1.1059/9405

CPU: 0 UID: 0 PID: 9405 Comm: syz.1.1059 Not tainted 6.15.0-syzkaller-12425-g82cbd06f327f #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xd2/0x2b0 mm/kasan/report.c:521
 kasan_report+0x118/0x150 mm/kasan/report.c:634
 br_multicast_rport_from_node net/bridge/br_multicast.c:3298 [inline]
 br_multicast_get_rport_slot net/bridge/br_multicast.c:3312 [inline]
 br_multicast_add_router+0x15e/0x520 net/bridge/br_multicast.c:3350
 br_multicast_mark_router+0x3fa/0x5d0 net/bridge/br_multicast.c:3416
 br_ip4_multicast_mark_router net/bridge/br_multicast.c:3431 [inline]
 br_multicast_set_port_router+0x3cf/0xc50 net/bridge/br_multicast.c:4569
 br_setport+0xeab/0x1670 net/bridge/br_netlink.c:1027
 br_setlink+0x4d5/0x800 net/bridge/br_netlink.c:1118
 rtnl_bridge_setlink+0x5b2/0x7d0 net/core/rtnetlink.c:5520
 rtnetlink_rcv_msg+0x779/0xb70 net/core/rtnetlink.c:6953
 netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x758/0x8d0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:727
 ____sys_sendmsg+0x505/0x830 net/socket.c:2566
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
 __sys_sendmsg net/socket.c:2652 [inline]
 __do_sys_sendmsg net/socket.c:2657 [inline]
 __se_sys_sendmsg net/socket.c:2655 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4e4158e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4e424d3038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f4e417b5fa0 RCX: 00007f4e4158e929
RDX: 0000000000000000 RSI: 0000200000000000 RDI: 0000000000000003
RBP: 00007f4e41610b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f4e417b5fa0 R15: 00007fffe0e7f318
 </TASK>

Allocated by task 5847:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x230/0x3d0 mm/slub.c:4359
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 new_nbp+0x188/0x440 net/bridge/br_if.c:431
 br_add_if+0x28e/0xec0 net/bridge/br_if.c:599
 do_set_master+0x533/0x6d0 net/core/rtnetlink.c:2946
 do_setlink+0xcf0/0x41c0 net/core/rtnetlink.c:3148
 rtnl_changelink net/core/rtnetlink.c:3759 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3918 [inline]
 rtnl_newlink+0x160b/0x1c70 net/core/rtnetlink.c:4055
 rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6944
 netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x758/0x8d0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:727
 __sys_sendto+0x3bd/0x520 net/socket.c:2180
 __do_sys_sendto net/socket.c:2187 [inline]
 __se_sys_sendto net/socket.c:2183 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2183
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 23:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2381 [inline]
 slab_free mm/slub.c:4643 [inline]
 kfree+0x18e/0x440 mm/slub.c:4842
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22b/0x480 lib/kobject.c:737
 rcu_do_batch kernel/rcu/tree.c:2576 [inline]
 rcu_core+0xca5/0x1710 kernel/rcu/tree.c:2832
 handle_softirqs+0x286/0x870 kernel/softirq.c:579
 run_ksoftirqd+0x9b/0x100 kernel/softirq.c:968
 smpboot_thread_fn+0x53f/0xa60 kernel/smpboot.c:164
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:548
 __call_rcu_common kernel/rcu/tree.c:3090 [inline]
 call_rcu+0x142/0x990 kernel/rcu/tree.c:3210
 br_del_if+0x146/0x320 net/bridge/br_if.c:739
 do_set_master+0x30f/0x6d0 net/core/rtnetlink.c:2930
 do_setlink+0xcf0/0x41c0 net/core/rtnetlink.c:3148
 rtnl_changelink net/core/rtnetlink.c:3759 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3918 [inline]
 rtnl_newlink+0x160b/0x1c70 net/core/rtnetlink.c:4055
 rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6944
 netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x758/0x8d0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:727
 ____sys_sendmsg+0x505/0x830 net/socket.c:2566
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
 __sys_sendmsg net/socket.c:2652 [inline]
 __do_sys_sendmsg net/socket.c:2657 [inline]
 __se_sys_sendmsg net/socket.c:2655 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880285f1000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 432 bytes inside of
 freed 1024-byte region [ffff8880285f1000, ffff8880285f1400)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x285f0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801a441dc0 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801a441dc0 0000000000000000 dead000000000001
head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea0000a17c01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x252800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP|__GFP_THISNODE), pid 151, tgid 151 (kworker/u8:5), ts 13293406822, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1704
 prep_new_page mm/page_alloc.c:1712 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3669
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:4959
 alloc_slab_page mm/slub.c:2453 [inline]
 allocate_slab+0x65/0x3b0 mm/slub.c:2619
 new_slab mm/slub.c:2673 [inline]
 ___slab_alloc+0xbfc/0x1480 mm/slub.c:3859
 __slab_alloc mm/slub.c:3949 [inline]
 __slab_alloc_node mm/slub.c:4024 [inline]
 slab_alloc_node mm/slub.c:4185 [inline]
 __do_kmalloc_node mm/slub.c:4327 [inline]
 __kmalloc_node_noprof+0x2fd/0x4e0 mm/slub.c:4334
 kmalloc_node_noprof include/linux/slab.h:932 [inline]
 blk_alloc_flush_queue+0xe2/0x230 block/blk-flush.c:490
 blk_mq_alloc_hctx block/blk-mq.c:4037 [inline]
 blk_mq_alloc_and_init_hctx+0x679/0xd60 block/blk-mq.c:4500
 __blk_mq_realloc_hw_ctxs+0x169/0x400 block/blk-mq.c:4531
 blk_mq_realloc_hw_ctxs block/blk-mq.c:4558 [inline]
 blk_mq_init_allocated_queue+0x400/0x1490 block/blk-mq.c:4590
 blk_mq_alloc_queue+0x197/0x290 block/blk-mq.c:4400
 scsi_alloc_sdev+0x76d/0xb50 drivers/scsi/scsi_scan.c:339
 scsi_probe_and_add_lun+0x1cb/0x4520 drivers/scsi/scsi_scan.c:1210
 __scsi_scan_target+0x1dd/0xd10 drivers/scsi/scsi_scan.c:1775
 scsi_scan_channel drivers/scsi/scsi_scan.c:1863 [inline]
 scsi_scan_host_selected+0x372/0x690 drivers/scsi/scsi_scan.c:1892
 do_scsi_scan_host drivers/scsi/scsi_scan.c:2031 [inline]
 do_scan_async+0x124/0x760 drivers/scsi/scsi_scan.c:2041
page_owner free stack trace missing

Memory state around the buggy address:
 ffff8880285f1080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880285f1100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880285f1180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff8880285f1200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880285f1280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


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

