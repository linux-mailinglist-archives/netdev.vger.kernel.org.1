Return-Path: <netdev+bounces-187270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F90AA601E
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 16:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A0C21BC55AD
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 14:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A081F130E;
	Thu,  1 May 2025 14:38:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BE0125D6
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 14:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746110318; cv=none; b=ranu2xWu9gWfj6in9IWbCMTSzR75IC/kmERTW5Cn+LMogEbyUEeAY7Auzh9kgT+/tZFsFmgHDcXm0LIaGrDbYbfnDR8N3bwv84koGOXUtWbjNoM/y2BfiReJ4nfRprNBCDfWM/YUOw30uVLYatOMcjPfCmxru1H+fPe2+cvx+8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746110318; c=relaxed/simple;
	bh=tUbsaY/8B+Rd9q+gF4e6Cbo0H9XPbRuTyWUcriCiXac=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=m9p6nDprRxaD5vui7HoQ57I/GKaS/4SGcni+j2b0TjAwugZgb74ECkAN5htg+s8JEzy1ZA/cGFOHuGWZErDqo+6hBw0i9/8UoYUrAWZ9aen/Z1wS7Tds97I9YFnUe7WOMA+veo8xqF22OLuIkkDFYYd0DauazARU6l4wgZf/Vuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d96661c8a2so13158555ab.0
        for <netdev@vger.kernel.org>; Thu, 01 May 2025 07:38:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746110315; x=1746715115;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VyRcE9m1wg6LuGGD3KBVXgQwsUK0rn90BhklyTj2ouI=;
        b=Pqa0MrvjGAJhAE6a9fXB8cFzfmGVbkDRbKBoeByp4Ap7Rq56aKKt/DDHsHIfm6LQJf
         ZySs1KnGsDjyoJWpnTKTjw63NmFlxcBa524tQPnQdmJi3D9n5hI1Rl+abApZWerSeo7G
         vD7Ci8kY+A92Fl2YIyzDrPeVtCmyL4or9gdb/Pmh+7BcgUP4wO6UZiwYSyFyMHQgL8/n
         S+XxdQ/VVW5uoWvaNj325A60wW8IBOsdUnYYjGHjoTqmqG/2QU3io1QyU6IMLbK3hjBh
         BSnjHPPTdPjpYsT5XbXNghcs5MlXOi8QsRJ1SaZdnyJ2qW9LVlE987gdtC7NA0DVf8G5
         DeEA==
X-Forwarded-Encrypted: i=1; AJvYcCVajWguGOmOaPpXoD32mNSxsIqc7bBY9k+m0WZGPT6otMPIKOYHPht1EiSifDHjSF3xJb7GsqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzddqjXJCs/XbwvM3IFWgIRyxYyA4xfCyX+N9ZuibCQEVpQ0/gc
	VyInh3Zr6EFhdpZZmBdaQabmJlcEgQ4FVVypzixgzca1xzm1tyFACQ70P9liT0YVX1UVbdh33W7
	4gsWX56wAwL9/sfrQYqSerIma21OmZZkW9Adjh4GdXv86Nxvxq/cjAcI=
X-Google-Smtp-Source: AGHT+IGHcp0/TNpxjpmhhsCo14GTUQym9kHqJ0tpF30C55k9vfOlR2Zg8wisXkQdl9oMtRriu8cvBvmssb+w5BGCw5FmqTYNt0OA
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d96:b0:3d8:1d2d:60b0 with SMTP id
 e9e14a558f8ab-3d9701c9398mr32900395ab.5.1746110315539; Thu, 01 May 2025
 07:38:35 -0700 (PDT)
Date: Thu, 01 May 2025 07:38:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6813876b.050a0220.14dd7d.0010.GAE@google.com>
Subject: [syzbot] [net?] KASAN: global-out-of-bounds Read in fib6_clean_node (2)
From: syzbot <syzbot+ef84446be20ce6c5e514@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4f79eaa2ceac kbuild: Properly disable -Wunterminated-strin..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=156a4814580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9a25b7a36123454
dashboard link: https://syzkaller.appspot.com/bug?extid=ef84446be20ce6c5e514
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4108e43f4175/disk-4f79eaa2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/238784ec1e47/vmlinux-4f79eaa2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/670207e0b3e7/bzImage-4f79eaa2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ef84446be20ce6c5e514@syzkaller.appspotmail.com

netlink: 20 bytes leftover after parsing attributes in process `syz.0.4277'.
==================================================================
BUG: KASAN: global-out-of-bounds in fib6_clean_node+0x35d/0x590 net/ipv6/ip6_fib.c:2198
Read of size 8 at addr ffffffff99d13828 by task syz.0.4277/21355

CPU: 0 UID: 0 PID: 21355 Comm: syz.0.4277 Not tainted 6.15.0-rc4-syzkaller-00052-g4f79eaa2ceac #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/19/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xb4/0x290 mm/kasan/report.c:521
 kasan_report+0x118/0x150 mm/kasan/report.c:634
 fib6_clean_node+0x35d/0x590 net/ipv6/ip6_fib.c:2198
 fib6_walk_continue+0x67b/0x910 net/ipv6/ip6_fib.c:2124
 fib6_walk+0x149/0x290 net/ipv6/ip6_fib.c:2172
 fib6_clean_tree net/ipv6/ip6_fib.c:2252 [inline]
 __fib6_clean_all+0x234/0x380 net/ipv6/ip6_fib.c:2268
 rt6_sync_up+0x128/0x160 net/ipv6/route.c:4837
 addrconf_notify+0xb1c/0x1010 net/ipv6/addrconf.c:3748
 notifier_call_chain+0x1b6/0x3e0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2214 [inline]
 call_netdevice_notifiers net/core/dev.c:2228 [inline]
 __dev_notify_flags+0x18d/0x2e0 net/core/dev.c:-1
 rtnl_configure_link net/core/rtnetlink.c:-1 [inline]
 rtnl_newlink_create+0x606/0xaf0 net/core/rtnetlink.c:3843
 __rtnl_newlink net/core/rtnetlink.c:3950 [inline]
 rtnl_newlink+0x16d6/0x1c70 net/core/rtnetlink.c:4065
 rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6955
 netlink_rcv_skb+0x21c/0x490 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x75b/0x8d0 net/netlink/af_netlink.c:1339
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
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbfc4f8e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbfc5de2038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fbfc51b6080 RCX: 00007fbfc4f8e969
RDX: 0000000000000000 RSI: 0000200000000480 RDI: 0000000000000009
RBP: 00007fbfc5010ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fbfc51b6080 R15: 00007fffda169088
 </TASK>

The buggy address belongs to the variable:
 binder_devices+0x8/0x20

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x19d13
flags: 0xfff00000002000(reserved|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000002000 ffffea00006744c8 ffffea00006744c8 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner info is not present (never set?)

Memory state around the buggy address:
 ffffffff99d13700: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
 ffffffff99d13780: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
>ffffffff99d13800: f9 f9 f9 f9 00 f9 f9 f9 00 00 f9 f9 00 00 00 00
                                  ^
 ffffffff99d13880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffffff99d13900: 00 00 00 00 00 00 00 00 00 00 04 f9 f9 f9 f9 f9
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

