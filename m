Return-Path: <netdev+bounces-247873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A07ED0013E
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 22:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36F79301E6EF
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 21:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076F425A2A2;
	Wed,  7 Jan 2026 21:00:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEC2218E91
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 21:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767819625; cv=none; b=XFi4yVAITg2eMIiM+XtR0XWJTks0+3ueoxyTv+dttWaF4fJ04bUPtN2P/L7LB7p+aMACyfBDJqjxzuSik0YnAXry/biRU0BpGwmixgdzca6INN+Lg6HAoA+w2o+MhiPPOg+LB8QkduH0BYedKoXPq3FeTF4uTEXeHOdeAAwcpqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767819625; c=relaxed/simple;
	bh=I//82h5qS61Pe6DYJ0HkyVd/Row1IGBojEkpHligplQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=e25U6ql1120L6qxo+Npo51PTvtJrGjGYfHZx49MtvaXxKDvC6Cv8xq57enjUf5FThrk7UabgKsZtpnAabuM5rruGR7nZsSuw42itGORSqWpgm0PD3W+eVvqz02nRtre0I6NsRZUZx13PzIEEs+BG2Zn4rfDMdyCcuaJyNC4rj5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-65f54007ca6so3245337eaf.2
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 13:00:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767819623; x=1768424423;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fOb3oSaomwNIflDw655R0cARhraIEOQ3jGNRILqjGeo=;
        b=vpFOEoOzQVESvfr0KpyA/TSXiqSQzSUYuzP+vLFnFbYHllshpcGZn5tD+hesmdJTtF
         Wh6xrscGYX03aGa2Q9IfVQ0MEq2lpFz0VHQVSV6VtqE0k/DsmuE6gdOop9IOngMDDxYI
         zWY4MEUZK1yPBdGZ5Fdf3RneLXogT2NCHHb90Mrv/Q5Iq3QUZZMxFh/xkaeYvVSYboSx
         oR7nIWsQWklvx1jPPgmjBfsN1cJQqeFKyEucwd6H9scpOCSrTMRb5asEfsXTFRK1G2H0
         dQ7mBb7eync0qavU62GFJCo0cwlMoU1Ir2pmQBvHh8kuR0pgY3TFFVHrZinMyxSFByjH
         8Gng==
X-Forwarded-Encrypted: i=1; AJvYcCWFeVJ7SJVscaxOmhwlW1IxPqAL7ge1svlnmoV19tdthlc4JPcanSUcLbF8hcSB5RtD9Yne2Dg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUfrh4i4dyhpjhnzN4czvG/o1vw0Va2sezBy1+fz/0rI21gJ9O
	CSvO+2JEhguJQVWmO6ELRuNqnSp/hELtTchEuZ58RUu5VnSCL12xI7m/Vinz70xqSHmC9bkj8Ot
	qT6UMNsNOH0OH8mKAfh2zl16kgbcE6z6t31EjE3VpA0WrU3pNzoZC9l3aN/8=
X-Google-Smtp-Source: AGHT+IEuxNL75Vv+fukcvWDzc4osfESlRf10pFnk8vjJGeCwAwjmP+O1I9WcJGoxXtGHHDbYTeuLnl8nsjRRsGnX9DX0fw8dB+v2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:c311:0:b0:65d:1e7:9527 with SMTP id
 006d021491bc7-65f54f52631mr1316453eaf.51.1767819622530; Wed, 07 Jan 2026
 13:00:22 -0800 (PST)
Date: Wed, 07 Jan 2026 13:00:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <695ec966.050a0220.1c677c.037c.GAE@google.com>
Subject: [syzbot] [net?] KASAN: slab-use-after-free Write in arp_create
From: syzbot <syzbot+58b44a770a1585795351@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8e7148b56023 atm: idt77252: Use sb_pool_remove()
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1253c1fc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a94030c847137a18
dashboard link: https://syzkaller.appspot.com/bug?extid=58b44a770a1585795351
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2913fe5e8157/disk-8e7148b5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f91ee7db4b2e/vmlinux-8e7148b5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e5ce7b3f1144/bzImage-8e7148b5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+58b44a770a1585795351@syzkaller.appspotmail.com

sit0: left promiscuous mode
ip6gre0: left promiscuous mode
==================================================================
BUG: KASAN: slab-use-after-free in arp_create+0x859/0x990 net/ipv4/arp.c:-1
Write of size 2 at addr ffff888031c51d50 by task syz.3.2633/16059

CPU: 0 UID: 0 PID: 16059 Comm: syz.3.2633 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 arp_create+0x859/0x990 net/ipv4/arp.c:-1
 arp_send_dst net/ipv4/arp.c:314 [inline]
 arp_send+0xa5/0x190 net/ipv4/arp.c:328
 inetdev_send_gratuitous_arp net/ipv4/devinet.c:1571 [inline]
 inetdev_event+0x1156/0x15b0 net/ipv4/devinet.c:1638
 notifier_call_chain+0x19d/0x3a0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
 call_netdevice_notifiers net/core/dev.c:2281 [inline]
 __dev_notify_flags+0x18d/0x2e0 net/core/dev.c:-1
 netif_change_flags+0xe8/0x1a0 net/core/dev.c:9803
 do_setlink+0xc55/0x41c0 net/core/rtnetlink.c:3158
 rtnl_group_changelink net/core/rtnetlink.c:3790 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3944 [inline]
 rtnl_newlink+0x14b0/0x1c90 net/core/rtnetlink.c:4072
 rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6958
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:742
 ____sys_sendmsg+0x505/0x820 net/socket.c:2592
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2646
 __sys_sendmsg net/socket.c:2678 [inline]
 __do_sys_sendmsg net/socket.c:2683 [inline]
 __se_sys_sendmsg net/socket.c:2681 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2681
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f50a2d8f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f50a3c64038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f50a2fe6180 RCX: 00007f50a2d8f749
RDX: 0000000000000000 RSI: 0000200000000140 RDI: 000000000000000d
RBP: 00007f50a2e13f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f50a2fe6218 R14: 00007f50a2fe6180 R15: 00007ffe4aa758d8
 </TASK>

Allocated by task 16059:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4953 [inline]
 slab_alloc_node mm/slub.c:5263 [inline]
 kmem_cache_alloc_node_noprof+0x43c/0x720 mm/slub.c:5315
 kmalloc_reserve+0xbd/0x290 net/core/skbuff.c:586
 __alloc_skb+0x204/0x3a0 net/core/skbuff.c:690
 alloc_skb include/linux/skbuff.h:1383 [inline]
 arp_create+0x189/0x990 net/ipv4/arp.c:561
 arp_send_dst net/ipv4/arp.c:314 [inline]
 arp_send+0xa5/0x190 net/ipv4/arp.c:328
 inetdev_send_gratuitous_arp net/ipv4/devinet.c:1571 [inline]
 inetdev_event+0x1156/0x15b0 net/ipv4/devinet.c:1638
 notifier_call_chain+0x19d/0x3a0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
 call_netdevice_notifiers net/core/dev.c:2281 [inline]
 __dev_notify_flags+0x18d/0x2e0 net/core/dev.c:-1
 netif_change_flags+0xe8/0x1a0 net/core/dev.c:9803
 do_setlink+0xc55/0x41c0 net/core/rtnetlink.c:3158
 rtnl_group_changelink net/core/rtnetlink.c:3790 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3944 [inline]
 rtnl_newlink+0x14b0/0x1c90 net/core/rtnetlink.c:4072
 rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6958
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:742
 ____sys_sendmsg+0x505/0x820 net/socket.c:2592
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2646
 __sys_sendmsg net/socket.c:2678 [inline]
 __do_sys_sendmsg net/socket.c:2683 [inline]
 __se_sys_sendmsg net/socket.c:2681 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2681
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 16059:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2540 [inline]
 slab_free mm/slub.c:6670 [inline]
 kmem_cache_free+0x197/0x620 mm/slub.c:6781
 pskb_expand_head+0x39e/0x1160 net/core/skbuff.c:2314
 ip6gre_header+0x13c/0x820 net/ipv6/ip6_gre.c:1376
 dev_hard_header include/linux/netdevice.h:3436 [inline]
 arp_create+0x3fd/0x990 net/ipv4/arp.c:578
 arp_send_dst net/ipv4/arp.c:314 [inline]
 arp_send+0xa5/0x190 net/ipv4/arp.c:328
 inetdev_send_gratuitous_arp net/ipv4/devinet.c:1571 [inline]
 inetdev_event+0x1156/0x15b0 net/ipv4/devinet.c:1638
 notifier_call_chain+0x19d/0x3a0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
 call_netdevice_notifiers net/core/dev.c:2281 [inline]
 __dev_notify_flags+0x18d/0x2e0 net/core/dev.c:-1
 netif_change_flags+0xe8/0x1a0 net/core/dev.c:9803
 do_setlink+0xc55/0x41c0 net/core/rtnetlink.c:3158
 rtnl_group_changelink net/core/rtnetlink.c:3790 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3944 [inline]
 rtnl_newlink+0x14b0/0x1c90 net/core/rtnetlink.c:4072
 rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6958
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:742
 ____sys_sendmsg+0x505/0x820 net/socket.c:2592
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2646
 __sys_sendmsg net/socket.c:2678 [inline]
 __do_sys_sendmsg net/socket.c:2683 [inline]
 __se_sys_sendmsg net/socket.c:2681 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2681
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888031c51d40
 which belongs to the cache skbuff_small_head of size 704
The buggy address is located 16 bytes inside of
 freed 704-byte region [ffff888031c51d40, ffff888031c52000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x31c50
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801d6e1c80 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080130013 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801d6e1c80 dead000000000122 0000000000000000
head: 0000000000000000 0000000080130013 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffea0000c71401 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 16059, tgid 16050 (syz.3.2633), ts 579733121729, free_ts 429869578042
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x234/0x290 mm/page_alloc.c:1857
 prep_new_page mm/page_alloc.c:1865 [inline]
 get_page_from_freelist+0x24e0/0x2580 mm/page_alloc.c:3915
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5210
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2486
 alloc_slab_page mm/slub.c:3075 [inline]
 allocate_slab+0x86/0x3b0 mm/slub.c:3248
 new_slab mm/slub.c:3302 [inline]
 ___slab_alloc+0xe53/0x1820 mm/slub.c:4656
 __slab_alloc+0x65/0x100 mm/slub.c:4779
 __slab_alloc_node mm/slub.c:4855 [inline]
 slab_alloc_node mm/slub.c:5251 [inline]
 kmem_cache_alloc_node_noprof+0x4ce/0x720 mm/slub.c:5315
 kmalloc_reserve+0xbd/0x290 net/core/skbuff.c:586
 __alloc_skb+0x204/0x3a0 net/core/skbuff.c:690
 alloc_skb include/linux/skbuff.h:1383 [inline]
 nlmsg_new include/net/netlink.h:1055 [inline]
 inet_ifmcaddr_notify+0x7e/0x150 net/ipv4/igmp.c:1481
 ____ip_mc_inc_group+0x9a8/0xdd0 net/ipv4/igmp.c:1564
 __ip_mc_inc_group net/ipv4/igmp.c:1573 [inline]
 ip_mc_inc_group net/ipv4/igmp.c:1579 [inline]
 ip_mc_up+0x115/0x2e0 net/ipv4/igmp.c:1880
 inetdev_event+0xf93/0x15b0 net/ipv4/devinet.c:1630
 notifier_call_chain+0x19d/0x3a0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
 call_netdevice_notifiers net/core/dev.c:2281 [inline]
 __dev_notify_flags+0x18d/0x2e0 net/core/dev.c:-1
page last free pid 5186 tgid 5186 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1406 [inline]
 __free_frozen_pages+0xbc8/0xd30 mm/page_alloc.c:2943
 __slab_free+0x2ce/0x320 mm/slub.c:6004
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x100 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4953 [inline]
 slab_alloc_node mm/slub.c:5263 [inline]
 __do_kmalloc_node mm/slub.c:5656 [inline]
 __kmalloc_node_track_caller_noprof+0x526/0x820 mm/slub.c:5764
 kmalloc_reserve+0x136/0x290 net/core/skbuff.c:608
 __alloc_skb+0x204/0x3a0 net/core/skbuff.c:690
 alloc_skb include/linux/skbuff.h:1383 [inline]
 alloc_skb_with_frags+0xca/0x890 net/core/skbuff.c:6712
 sock_alloc_send_pskb+0x84d/0x980 net/core/sock.c:2995
 unix_dgram_sendmsg+0x454/0x1840 net/unix/af_unix.c:2130
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:742
 __sys_sendto+0x3bd/0x520 net/socket.c:2206
 __do_sys_sendto net/socket.c:2213 [inline]
 __se_sys_sendto net/socket.c:2209 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2209
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888031c51c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888031c51c80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff888031c51d00: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
                                                 ^
 ffff888031c51d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888031c51e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

