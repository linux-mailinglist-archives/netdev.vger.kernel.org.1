Return-Path: <netdev+bounces-187227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7827DAA5DB1
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 13:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC9354C0DF3
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 11:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADCD221701;
	Thu,  1 May 2025 11:17:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243591DE8B4
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 11:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746098252; cv=none; b=EEbCxVrO8eLTEIqLUvgxFKO2ZB3W+GSpBc1JivAfz/LJ68ZPfmOIaU1BnRT4mzyniBIj6ovagEGatUvZi+Jl4SpCqIp6vHqASvXMV66GD6bFUd838KKGrkQiYjqjUESM6Exx0AcoEyBa0khqVVHHhv1qR6/SxbcUSs+TS2WvdXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746098252; c=relaxed/simple;
	bh=wGOiGyhkiz9Ye/2FJ6DNBeT0LNLI3OjcbeoKmsMkFNg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ovrfZ7k0v2dvMGdhlfD97nB/2S0Cqbef1/lm5K+Anm0/1fggVgkwpdtQJDZ+A/dNjAttzlCq21HjFXiG6Sj+6novk7DyKYPHRTHXf65PUbvkVSIwJGqcoA1DrHRecy6rq4TLGAdCPCaWTegtdkNEesARjbLPFL8YjAs2SelmDT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d9099f9056so18867855ab.2
        for <netdev@vger.kernel.org>; Thu, 01 May 2025 04:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746098250; x=1746703050;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xImHD0yfyXrdoMc79mLP5OX1O47Lcz17EVKu4gMvCcg=;
        b=GTAvc108Pnh+dGF9yJGRWT7i7Ws0k2DH0EnZf67u1l0oq8vg6pTXNbXsMz91LOVWo2
         Q2wf5O29RM3RRrX2r1k+zw/NUoNBYe3rPunrxSAOqIYWym9PL71Ak8wZSPDISeyatEzS
         P2MRHPTJizkIiFMjLAb2/ATNzzuKzgGRCO5m80BBBsNX6+s4EohsG3Sg9F3PG+N3zEgh
         fLWeCPOvBxKs8xwxZn6FeCXjOcGpzOzG/pWJGxHO2idbvuzyf5pb1pta757LD9NfAv/e
         L12FLzGweFxRrHKiUtGbYJoU6QnmqfKEDWjPtlpjn3T2TcM0EO405ODXeDB+xnQmpMzR
         mKVA==
X-Forwarded-Encrypted: i=1; AJvYcCWtN5YEHbaEyraXGZ8owrCkeya0yDRRXpBy9yZ1hUABgDKTlG033YNy+jwk35T0LUfJAtmdZds=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ139FcltXeZ/wt+WSU4EMGOl6gNZx9IbmNxOiu9uoGYGZ47qZ
	Q6wP7WZ6AfreYLAHuaafG2YMsXHdRsa+3L3pQu2go90b0rKm0qlw49Aa8cFF7iIjnXdsQ7F8OKY
	y+kQEU5Dlw+GXeuS/5XZHBSPnfa4D4gTiv1rsvbpBbs0VyezeYbv3iIs=
X-Google-Smtp-Source: AGHT+IFlrUU4y60HWx+K7KsuUp2nROsQin3fLSsqcUJYSnCaUvqRmrvOH7RdTq5XzGlnR6GgXwOYog21+mEjJ8HWDGVE8O51SEGx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc5:b0:3d9:4785:3dd5 with SMTP id
 e9e14a558f8ab-3d96771bbdfmr77663665ab.15.1746098250298; Thu, 01 May 2025
 04:17:30 -0700 (PDT)
Date: Thu, 01 May 2025 04:17:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6813584a.050a0220.3a872c.0011.GAE@google.com>
Subject: [syzbot] [net?] WARNING: suspicious RCU usage in __fib6_update_sernum_upto_root
From: syzbot <syzbot+8dd1a8ebe4c3793f5aca@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b6ea1680d0ac Merge tag 'v6.15-p6' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1457502f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a42a9d552788177b
dashboard link: https://syzkaller.appspot.com/bug?extid=8dd1a8ebe4c3793f5aca
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8b0865e8a7ea/disk-b6ea1680.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fab387b8c42a/vmlinux-b6ea1680.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bfb50db06aa1/bzImage-b6ea1680.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8dd1a8ebe4c3793f5aca@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
6.15.0-rc4-syzkaller-00042-gb6ea1680d0ac #0 Not tainted
-----------------------------
net/ipv6/ip6_fib.c:1351 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
3 locks held by syz.0.6334/23457:
 #0: ffffffff8f2e2008 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #0: ffffffff8f2e2008 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
 #0: ffffffff8f2e2008 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x8db/0x1c70 net/core/rtnetlink.c:4064
 #1: ffffffff8df3b860 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #1: ffffffff8df3b860 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #1: ffffffff8df3b860 (rcu_read_lock){....}-{1:3}, at: __fib6_clean_all+0x9b/0x380 net/ipv6/ip6_fib.c:2263
 #2: ffff88807b4a5830 (&tb->tb6_lock){+.-.}-{3:3}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
 #2: ffff88807b4a5830 (&tb->tb6_lock){+.-.}-{3:3}, at: __fib6_clean_all+0x1ce/0x380 net/ipv6/ip6_fib.c:2267

stack backtrace:
CPU: 0 UID: 0 PID: 23457 Comm: syz.0.6334 Not tainted 6.15.0-rc4-syzkaller-00042-gb6ea1680d0ac #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/19/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x140/0x1d0 kernel/locking/lockdep.c:6865
 __fib6_update_sernum_upto_root+0x223/0x230 net/ipv6/ip6_fib.c:1350
 fib6_update_sernum_upto_root+0x125/0x190 net/ipv6/ip6_fib.c:1364
 fib6_ifup+0x142/0x180 net/ipv6/route.c:4818
 fib6_clean_node+0x24a/0x590 net/ipv6/ip6_fib.c:2199
 fib6_walk_continue+0x678/0x910 net/ipv6/ip6_fib.c:2124
 fib6_walk+0x149/0x290 net/ipv6/ip6_fib.c:2172
 fib6_clean_tree net/ipv6/ip6_fib.c:2252 [inline]
 __fib6_clean_all+0x234/0x380 net/ipv6/ip6_fib.c:2268
 rt6_sync_up+0x128/0x160 net/ipv6/route.c:4837
 addrconf_notify+0xd55/0x1010 net/ipv6/addrconf.c:3729
 notifier_call_chain+0x1b3/0x3e0 kernel/notifier.c:85
 netif_state_change+0x284/0x3a0 net/core/dev.c:1530
 do_setlink+0x2eb6/0x40d0 net/core/rtnetlink.c:3399
 rtnl_group_changelink net/core/rtnetlink.c:3783 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3937 [inline]
 rtnl_newlink+0x149f/0x1c70 net/core/rtnetlink.c:4065
 rtnetlink_rcv_msg+0x7cc/0xb70 net/core/rtnetlink.c:6955
 netlink_rcv_skb+0x219/0x490 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x758/0x8d0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:727
 ____sys_sendmsg+0x505/0x830 net/socket.c:2566
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
 __sys_sendmsg net/socket.c:2652 [inline]
 __do_sys_sendmsg net/socket.c:2657 [inline]
 __se_sys_sendmsg net/socket.c:2655 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f093758e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0938453038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f09377b5fa0 RCX: 00007f093758e969
RDX: 0000000000000000 RSI: 0000200000000280 RDI: 0000000000000004
RBP: 00007f0937610ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f09377b5fa0 R15: 00007ffeeca2ddc8
 </TASK>

=============================
WARNING: suspicious RCU usage
6.15.0-rc4-syzkaller-00042-gb6ea1680d0ac #0 Not tainted
-----------------------------
net/ipv6/ip6_fib.c:1358 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
3 locks held by syz.0.6334/23457:
 #0: ffffffff8f2e2008 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #0: ffffffff8f2e2008 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
 #0: ffffffff8f2e2008 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x8db/0x1c70 net/core/rtnetlink.c:4064
 #1: ffffffff8df3b860 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #1: ffffffff8df3b860 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #1: ffffffff8df3b860 (rcu_read_lock){....}-{1:3}, at: __fib6_clean_all+0x9b/0x380 net/ipv6/ip6_fib.c:2263
 #2: ffff88807b4a5830 (&tb->tb6_lock){+.-.}-{3:3}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
 #2: ffff88807b4a5830 (&tb->tb6_lock){+.-.}-{3:3}, at: __fib6_clean_all+0x1ce/0x380 net/ipv6/ip6_fib.c:2267

stack backtrace:
CPU: 0 UID: 0 PID: 23457 Comm: syz.0.6334 Not tainted 6.15.0-rc4-syzkaller-00042-gb6ea1680d0ac #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/19/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x140/0x1d0 kernel/locking/lockdep.c:6865
 __fib6_update_sernum_upto_root+0x18e/0x230 net/ipv6/ip6_fib.c:1357
 fib6_update_sernum_upto_root+0x125/0x190 net/ipv6/ip6_fib.c:1364
 fib6_ifup+0x142/0x180 net/ipv6/route.c:4818
 fib6_clean_node+0x24a/0x590 net/ipv6/ip6_fib.c:2199
 fib6_walk_continue+0x678/0x910 net/ipv6/ip6_fib.c:2124
 fib6_walk+0x149/0x290 net/ipv6/ip6_fib.c:2172
 fib6_clean_tree net/ipv6/ip6_fib.c:2252 [inline]
 __fib6_clean_all+0x234/0x380 net/ipv6/ip6_fib.c:2268
 rt6_sync_up+0x128/0x160 net/ipv6/route.c:4837
 addrconf_notify+0xd55/0x1010 net/ipv6/addrconf.c:3729
 notifier_call_chain+0x1b3/0x3e0 kernel/notifier.c:85
 netif_state_change+0x284/0x3a0 net/core/dev.c:1530
 do_setlink+0x2eb6/0x40d0 net/core/rtnetlink.c:3399
 rtnl_group_changelink net/core/rtnetlink.c:3783 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3937 [inline]
 rtnl_newlink+0x149f/0x1c70 net/core/rtnetlink.c:4065
 rtnetlink_rcv_msg+0x7cc/0xb70 net/core/rtnetlink.c:6955
 netlink_rcv_skb+0x219/0x490 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x758/0x8d0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:727
 ____sys_sendmsg+0x505/0x830 net/socket.c:2566
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
 __sys_sendmsg net/socket.c:2652 [inline]
 __do_sys_sendmsg net/socket.c:2657 [inline]
 __se_sys_sendmsg net/socket.c:2655 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f093758e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0938453038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f09377b5fa0 RCX: 00007f093758e969
RDX: 0000000000000000 RSI: 0000200000000280 RDI: 0000000000000004
RBP: 00007f0937610ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f09377b5fa0 R15: 00007ffeeca2ddc8
 </TASK>
bridge_slave_0: left allmulticast mode
bridge_slave_0: left promiscuous mode
bridge0: port 1(bridge_slave_0) entered disabled state
bridge_slave_1: left allmulticast mode
bridge_slave_1: left promiscuous mode
bridge0: port 2(bridge_slave_1) entered disabled state
bond0: (slave bond_slave_0): Releasing backup interface
bond0: (slave bond_slave_1): Releasing backup interface
team0: Port device team_slave_0 removed
team0: Port device team_slave_1 removed
batman_adv: batadv0: Interface deactivated: batadv_slave_0
batman_adv: batadv0: Removing interface: batadv_slave_0
batman_adv: batadv0: Interface deactivated: batadv_slave_1
batman_adv: batadv0: Removing interface: batadv_slave_1


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

