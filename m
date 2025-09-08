Return-Path: <netdev+bounces-220904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BA7B496D6
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 19:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EABB018873EB
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 17:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4093115B5;
	Mon,  8 Sep 2025 17:19:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15021CEADB
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 17:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757351975; cv=none; b=eFsXuoYhMMsH3t//IJRJDxv+h4sI58Z/P+lv5UV5yS3LR3ikMoPssNA0PAEYllOL2qYwmpA4xoKJYwnMyjnk9cpUH95FjasgJjz1tDdt+n8WBUuN8hxeqPQgqHVvnzD/exqyCN1WxF+BEENBV7ss4fIxxuHVYMq/TcK7zHdx9Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757351975; c=relaxed/simple;
	bh=xgPpdpRS5YeqJM2vSt6bfnP09qMLw1kkYAKZN+6WBeo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WYKjy/7gSZhG4Vab6dJhsY5dwtsyjjN1lQZupCLRrdFFQHDvI9crEHK5Oix31V5dfn2zZfOmsUKXEGOD5yGJoqJHcHp17mCKqD0QOFKUTcU+lpF+oCAzrQrRypyXPadll6wjhpnTj+UVC0hqHbjRi5SK7E61Q0aUzxnN78BrEZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3f761116867so122153655ab.3
        for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 10:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757351973; x=1757956773;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Leg9cAeI1Aa4vz9zGTp/K9ybu4DKv+4gSxkOFVAjtQ=;
        b=f2lredb1u9AifJFwfKzLpvhjXZgxbk+6wgzno3/kmb4vUWTBV1FbNqHryf6BoNbHcy
         qSFsYn4FT/YdzwfL0pOWrJh3ym01v7/jF0V85o2bcVu6076Mq7rssD1+oLa29FfrA/cH
         l8PzO1Xmef1HcDVWPNZS5ctHaoN9K+VUSKmmNIIqVKcCpVI7UMorAJUwOZvgcXaMJOf/
         1iiFki8133CVR46rhepMlmzmC30Dea2M6c46gkCp0W2v7gRXhg7lAkVy+tUw8GLVUyxR
         +x06VQjAHtkEvUm/PNRgDg15GCBMKvvfIg6n7iQQcJja9Y8zwd1KgGGLUaiUuilRnIUj
         A31w==
X-Forwarded-Encrypted: i=1; AJvYcCWoWXkwUvr1FDtji7yxplkXiX3gXQgEN5aPWw8DpIDbl4LyMKK1ToWxyg6g0rh+APYPPfzuH1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF2ms1d2FIAJ4vQf5VQBmqE56xq3ZV95quzVri/ke9imx1l8Wf
	55c+9p2w+h+nIf/+JhprE1e6YtWB5b/Zk5xlRKmoXPKFMkAsOd7wkD70yBk8C3kwmnATCVTVYom
	V2ddSNgOOeksT7uyTMqycx9uQqC/Va40eg4tdmBPkD5zQqcdnPbi+G/6NYHA=
X-Google-Smtp-Source: AGHT+IHTkIIBanqFC2H6WTUrou5t48+ZFeoSZMY4CSI3hByunRoE2qEKI8hFqQ+6dXkUNEz04jnsUekHe92LnKSS8Qnb09c8/5nG
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a69:b0:3ed:eab:439a with SMTP id
 e9e14a558f8ab-3fd82164022mr123234325ab.12.1757351973009; Mon, 08 Sep 2025
 10:19:33 -0700 (PDT)
Date: Mon, 08 Sep 2025 10:19:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bf1024.a70a0220.7a912.02c2.GAE@google.com>
Subject: [syzbot] [net?] KASAN: slab-use-after-free Read in xfrm_state_find
From: syzbot <syzbot+e136d86d34b42399a8b1@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6ab41fca2e80 Merge tag 'timers-urgent-2025-09-07' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=142f0642580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d7c422a5f41c669
dashboard link: https://syzkaller.appspot.com/bug?extid=e136d86d34b42399a8b1
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5ab9812c379f/disk-6ab41fca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5d3df1acc5a7/vmlinux-6ab41fca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/12541033d833/bzImage-6ab41fca.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e136d86d34b42399a8b1@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in xfrm_state_find+0x44cd/0x5400 net/xfrm/xfrm_state.c:1574
Read of size 1 at addr ffff88806ad62970 by task syz.5.2024/14900

CPU: 1 UID: 0 PID: 14900 Comm: syz.5.2024 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 xfrm_state_find+0x44cd/0x5400 net/xfrm/xfrm_state.c:1574
 xfrm_tmpl_resolve_one net/xfrm/xfrm_policy.c:2522 [inline]
 xfrm_tmpl_resolve net/xfrm/xfrm_policy.c:2573 [inline]
 xfrm_resolve_and_create_bundle+0x768/0x2f80 net/xfrm/xfrm_policy.c:2871
 xfrm_lookup_with_ifid+0x2a7/0x1a70 net/xfrm/xfrm_policy.c:3205
 xfrm_lookup net/xfrm/xfrm_policy.c:3336 [inline]
 xfrm_lookup_route+0x3c/0x1c0 net/xfrm/xfrm_policy.c:3347
 ip_route_connect include/net/route.h:355 [inline]
 __ip4_datagram_connect+0x9a5/0x1270 net/ipv4/datagram.c:49
 __ip6_datagram_connect+0x9f0/0x1150 net/ipv6/datagram.c:196
 ip6_datagram_connect net/ipv6/datagram.c:279 [inline]
 ip6_datagram_connect_v6_only+0x63/0xa0 net/ipv6/datagram.c:291
 __sys_connect_file net/socket.c:2086 [inline]
 __sys_connect+0x316/0x440 net/socket.c:2105
 __do_sys_connect net/socket.c:2111 [inline]
 __se_sys_connect net/socket.c:2108 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2108
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd80af8ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd80be3f038 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007fd80b1c6090 RCX: 00007fd80af8ebe9
RDX: 000000000000001c RSI: 0000200000000040 RDI: 000000000000000d
RBP: 00007fd80b011e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fd80b1c6128 R14: 00007fd80b1c6090 R15: 00007fd80b2efa28
 </TASK>

Allocated by task 12709:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:330 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:356
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4191 [inline]
 slab_alloc_node mm/slub.c:4240 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4247
 xfrm_state_alloc+0x24/0x2f0 net/xfrm/xfrm_state.c:733
 xfrm_state_construct net/xfrm/xfrm_user.c:889 [inline]
 xfrm_add_sa+0x17d1/0x4070 net/xfrm/xfrm_user.c:1019
 xfrm_user_rcv_msg+0x7a0/0xab0 net/xfrm/xfrm_user.c:3501
 netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2552
 xfrm_netlink_rcv+0x79/0x90 net/xfrm/xfrm_user.c:3523
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82c/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 ____sys_sendmsg+0x505/0x830 net/socket.c:2614
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
 __sys_sendmsg net/socket.c:2700 [inline]
 __do_sys_sendmsg net/socket.c:2705 [inline]
 __se_sys_sendmsg net/socket.c:2703 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2703
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 12093:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x5b/0x80 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2422 [inline]
 slab_free mm/slub.c:4695 [inline]
 kmem_cache_free+0x18f/0x400 mm/slub.c:4797
 xfrm_state_free net/xfrm/xfrm_state.c:591 [inline]
 xfrm_state_gc_destroy net/xfrm/xfrm_state.c:618 [inline]
 xfrm_state_gc_task+0x52d/0x6b0 net/xfrm/xfrm_state.c:634
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff88806ad62640
 which belongs to the cache xfrm_state of size 928
The buggy address is located 816 bytes inside of
 freed 928-byte region [ffff88806ad62640, ffff88806ad629e0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88806ad62640 pfn:0x6ad60
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801afdf280 dead000000000122 0000000000000000
raw: ffff88806ad62640 00000000800f000c 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801afdf280 dead000000000122 0000000000000000
head: ffff88806ad62640 00000000800f000c 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffea0001ab5801 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 7519, tgid 7518 (syz.8.350), ts 330117177647, free_ts 330086232405
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:2492 [inline]
 allocate_slab+0x8a/0x370 mm/slub.c:2660
 new_slab mm/slub.c:2714 [inline]
 ___slab_alloc+0xbeb/0x1420 mm/slub.c:3901
 __slab_alloc mm/slub.c:3992 [inline]
 __slab_alloc_node mm/slub.c:4067 [inline]
 slab_alloc_node mm/slub.c:4228 [inline]
 kmem_cache_alloc_noprof+0x283/0x3c0 mm/slub.c:4247
 xfrm_state_alloc+0x24/0x2f0 net/xfrm/xfrm_state.c:733
 xfrm_state_find+0x37d4/0x5400 net/xfrm/xfrm_state.c:1513
 xfrm_tmpl_resolve_one net/xfrm/xfrm_policy.c:2522 [inline]
 xfrm_tmpl_resolve net/xfrm/xfrm_policy.c:2573 [inline]
 xfrm_resolve_and_create_bundle+0x768/0x2f80 net/xfrm/xfrm_policy.c:2871
 xfrm_bundle_lookup net/xfrm/xfrm_policy.c:3106 [inline]
 xfrm_lookup_with_ifid+0x58a/0x1a70 net/xfrm/xfrm_policy.c:3237
 xfrm_lookup net/xfrm/xfrm_policy.c:3336 [inline]
 xfrm_lookup_route+0x3c/0x1c0 net/xfrm/xfrm_policy.c:3347
 udp_sendmsg+0x142e/0x2170 net/ipv4/udp.c:1450
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x19c/0x270 net/socket.c:729
 ____sys_sendmsg+0x52d/0x830 net/socket.c:2614
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
page last free pid 7493 tgid 7486 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2895
 stack_depot_save_flags+0x436/0x860 lib/stackdepot.c:727
 kasan_save_stack mm/kasan/common.c:48 [inline]
 kasan_save_track+0x4f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:330 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:356
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4191 [inline]
 slab_alloc_node mm/slub.c:4240 [inline]
 kmem_cache_alloc_node_noprof+0x1bb/0x3c0 mm/slub.c:4292
 kmalloc_reserve+0xbd/0x290 net/core/skbuff.c:578
 __alloc_skb+0x142/0x2d0 net/core/skbuff.c:669
 alloc_skb include/linux/skbuff.h:1336 [inline]
 alloc_uevent_skb+0x7d/0x230 lib/kobject_uevent.c:289
 uevent_net_broadcast_untagged lib/kobject_uevent.c:326 [inline]
 kobject_uevent_net_broadcast+0x2fa/0x560 lib/kobject_uevent.c:410
 kobject_uevent_env+0x55b/0x8c0 lib/kobject_uevent.c:608
 device_del+0x73a/0x8e0 drivers/base/core.c:3896
 device_unregister+0x20/0xc0 drivers/base/core.c:3919
 hci_conn_cleanup net/bluetooth/hci_conn.c:173 [inline]
 hci_conn_del+0xc33/0x11b0 net/bluetooth/hci_conn.c:1211
 hci_abort_conn_sync+0x658/0xe30 net/bluetooth/hci_sync.c:5689
 hci_disconnect_all_sync+0x1b5/0x350 net/bluetooth/hci_sync.c:5712
 hci_suspend_sync+0x3fc/0xc60 net/bluetooth/hci_sync.c:6188

Memory state around the buggy address:
 ffff88806ad62800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88806ad62880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88806ad62900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                             ^
 ffff88806ad62980: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff88806ad62a00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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

