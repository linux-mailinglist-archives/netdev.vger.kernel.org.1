Return-Path: <netdev+bounces-217835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46150B39F2C
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 15:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0B853AAA3E
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 13:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4A330EF8E;
	Thu, 28 Aug 2025 13:39:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2BA220F2A
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 13:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756388371; cv=none; b=VITy9ZA9bQI/pb8X2jnONrh8RTATrTmpJVzO41cM1TPzFMUpYIzxC2sOzkOL+PVzMtsuJ9Yv6Juj4uKudZzXrErq+mkXDiTXnWRnGjATqBRwW2v7xFONsci84gn/cWLJr4ilbEsxOSXHRJqZkMF6TVsdHZMMyuNrhR0aXVmxUhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756388371; c=relaxed/simple;
	bh=KLE7zDvup+oVGJY8/LDoBBs05A/xmGHvn1Hx1L1H6Io=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VKksZV/OdYJeurBiOPvPEmAbnvu2dXA4wgb3nHh+x2HCKzDZQ2ypwGV9t5i1EytFHT0q+yw6Ie6M5lzSX1EB4inmSA49r/0e+AEmt5+Q/avKLwMxlc2GgebMLMLJxhnGoolrYiINKGpSazE5fVxxFJTGxyTJLg6OxMWviZwwhTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3efd62bc46fso10187095ab.3
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 06:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756388369; x=1756993169;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QektFrnC4mN/79JbyrdXktJYYVT4Tjl+pDvNCMND5L0=;
        b=tcNQajkjdzPL0ZpR4wSL6WqCxq/JwbNqFRHkpk9CnN5H1Ek0dOpaVE8kXBJzR0DOI9
         iBTQJexMXhdu397hRw+gPIgJDp/krtQVfq3lGMy9/wsr6HfdG5hrSWyHQFJbdNGgfOXh
         hBNu1GRWKTy8qjBFYgYUvsJdWKhnOhTv7nvD4k/9VzhG6pyj/VEyHZoTjf//YO5K7z5s
         t81hauRXIWIrlqPwIleZ4hox/1K9MA8bQVRLEHzh/jGAcWGj+MvgeSbUJZkJ1CywMVOw
         O/YU+/r+yRvVVgvp/QJeZyxewk10s3ld7ONW6nNu/jItjqChUyt6gZjQgkCblTWOTg84
         7B0A==
X-Forwarded-Encrypted: i=1; AJvYcCX7MdIQvKYC1qwyFW4rl7p5R4qdr+h5ly9TnIOh2VeYjkXqGkJUNyDtix5p+dy5Ga5bxfdbY3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQsZALwfC0jjyIagUmvHp8FPQlY1m1id54loQ3ftxFwwE0ycgO
	H5af6Q9V2YxU6sSm7wHobwICynhgoBSaUFdBLnChN3V3/wY8bOyUeQF9J7uL2W/H9lyPH8NYmjQ
	J+nFm3vN01p+kxDUw2z5KzNSjStq6gxnUy8zMuQah8IuNkzqkIwXntbfKtXE=
X-Google-Smtp-Source: AGHT+IHpRdvvwiC7wzF5awAQ2gyKkapCl7Gn+lDNvDSTxrRGwC3fqd3j8GbPayOeAH9i+5nQeZbVe8xilaqcpzF4GiJHs5OInthy
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2582:b0:3ed:256a:d680 with SMTP id
 e9e14a558f8ab-3ed256ad943mr201056015ab.13.1756388368974; Thu, 28 Aug 2025
 06:39:28 -0700 (PDT)
Date: Thu, 28 Aug 2025 06:39:28 -0700
In-Reply-To: <681a176f.050a0220.a19a9.000c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b05c10.050a0220.3db4df.001c.GAE@google.com>
Subject: Re: [syzbot] [net?] INFO: task hung in inet6_rtm_newaddr (2)
From: syzbot <syzbot+101224300649c3eb8af4@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

syzbot has found a reproducer for the following issue on:

HEAD commit:    07d9df80082b Merge tag 'perf-tools-fixes-for-v6.17-2025-08.=
.
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=3D124be634580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Da7016efe6aaa498=
c
dashboard link: https://syzkaller.appspot.com/bug?extid=3D101224300649c3eb8=
af4
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-=
1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1067dc6258000=
0
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16a33ef0580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d90=
0f083ada3/non_bootable_disk-07d9df80.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/64a01edfb5ff/vmlinux-=
07d9df80.xz
kernel image: https://storage.googleapis.com/syzbot-assets/78c915400ff9/bzI=
mage-07d9df80.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+101224300649c3eb8af4@syzkaller.appspotmail.com

INFO: task dhcpcd:5050 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:dhcpcd          state:D stack:21352 pid:5050  tgid:5050  ppid:5049   t=
ask_flags:0x400140 flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7115
 __mutex_lock_common kernel/locking/mutex.c:676 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:760
 rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 inet6_rtm_newaddr+0x5b7/0xd20 net/ipv6/addrconf.c:5027
 rtnetlink_rcv_msg+0x7cc/0xb70 net/core/rtnetlink.c:6946
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
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
RIP: 0033:0x7f92a9337407
RSP: 002b:00007ffe9186d4f0 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f92a92ad740 RCX: 00007f92a9337407
RDX: 0000000000000000 RSI: 00007ffe918816d0 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffe91891900
R13: 00007f92a92ad6c8 R14: 0000000000000048 R15: 00007ffe918816d0
 </TASK>
INFO: task syz-executor:5514 blocked for more than 146 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:21480 pid:5514  tgid:5514  ppid:1      t=
ask_flags:0x400140 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7115
 __mutex_lock_common kernel/locking/mutex.c:676 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:760
 rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 inet6_rtm_newaddr+0x5b7/0xd20 net/ipv6/addrconf.c:5027
 rtnetlink_rcv_msg+0x7cc/0xb70 net/core/rtnetlink.c:6946
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 __sys_sendto+0x3bd/0x520 net/socket.c:2228
 __do_sys_sendto net/socket.c:2235 [inline]
 __se_sys_sendto net/socket.c:2231 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2231
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5fde590a7c
RSP: 002b:00007ffe3bda8b90 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f5fdf2e4620 RCX: 00007f5fde590a7c
RDX: 0000000000000040 RSI: 00007f5fdf2e4670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffe3bda8be4 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007f5fdf2e4670 R15: 0000000000000000
 </TASK>
INFO: task syz-executor:5523 blocked for more than 146 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:22280 pid:5523  tgid:5523  ppid:1      t=
ask_flags:0x400140 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7115
 __mutex_lock_common kernel/locking/mutex.c:676 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:760
 rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 inet6_rtm_newaddr+0x5b7/0xd20 net/ipv6/addrconf.c:5027
 rtnetlink_rcv_msg+0x7cc/0xb70 net/core/rtnetlink.c:6946
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 __sys_sendto+0x3bd/0x520 net/socket.c:2228
 __do_sys_sendto net/socket.c:2235 [inline]
 __se_sys_sendto net/socket.c:2231 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2231
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1fe2590a7c
RSP: 002b:00007ffecd1e35b0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f1fe32e4620 RCX: 00007f1fe2590a7c
RDX: 0000000000000040 RSI: 00007f1fe32e4670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffecd1e3604 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007f1fe32e4670 R15: 0000000000000000
 </TASK>
INFO: task syz-executor:5767 blocked for more than 146 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:25096 pid:5767  tgid:5767  ppid:1      t=
ask_flags:0x400140 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7115
 __mutex_lock_common kernel/locking/mutex.c:676 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:760
 rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 inet_rtm_newaddr+0x3b0/0x18b0 net/ipv4/devinet.c:979
 rtnetlink_rcv_msg+0x7cc/0xb70 net/core/rtnetlink.c:6946
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 __sys_sendto+0x3bd/0x520 net/socket.c:2228
 __do_sys_sendto net/socket.c:2235 [inline]
 __se_sys_sendto net/socket.c:2231 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2231
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa5ffd90a7c
RSP: 002b:00007ffd3b9be780 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007fa600ae4620 RCX: 00007fa5ffd90a7c
RDX: 0000000000000028 RSI: 00007fa600ae4670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffd3b9be7d4 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007fa600ae4670 R15: 0000000000000000
 </TASK>

Showing all locks held in the system:
4 locks held by kworker/0:0/9:
4 locks held by kworker/0:1/10:
3 locks held by kworker/u4:0/12:
1 lock held by khungtaskd/26:
 #0: ffffffff8e139ee0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire inc=
lude/linux/rcupdate.h:331 [inline]
 #0: ffffffff8e139ee0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock includ=
e/linux/rcupdate.h:841 [inline]
 #0: ffffffff8e139ee0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks=
+0x2e/0x180 kernel/locking/lockdep.c:6775
4 locks held by kworker/u4:2/31:
3 locks held by kworker/u4:3/43:
3 locks held by kworker/u4:5/62:
4 locks held by kworker/0:2/796:
3 locks held by kworker/u4:6/1038:
4 locks held by kworker/u4:7/1039:
3 locks held by kworker/u4:8/1069:
 #0: ffff88803ef28148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: proce=
ss_one_work kernel/workqueue.c:3211 [inline]
 #0: ffff88803ef28148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: proce=
ss_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3319
 #1: ffffc900025ffbc0 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0=
:0}, at: process_one_work kernel/workqueue.c:3212 [inline]
 #1: ffffc900025ffbc0 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0=
:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3319
 #2: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/l=
inux/rtnetlink.h:130 [inline]
 #2: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: addrconf_dad_work+0x112=
/0x14b0 net/ipv6/addrconf.c:4194
4 locks held by kworker/u4:9/1094:
3 locks held by kworker/u4:11/3039:
1 lock held by klogd/4741:
1 lock held by dhcpcd/5050:
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/l=
inux/rtnetlink.h:130 [inline]
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: inet6_rtm_newaddr+0x5b7=
/0xd20 net/ipv6/addrconf.c:5027
2 locks held by getty/5143:
 #0: ffff8880339e50a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait=
+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900028262f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_rea=
d+0x43e/0x1400 drivers/tty/n_tty.c:2222
4 locks held by syz-executor/5508:
 #0: ffffffff8f59fff0 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/net=
link/genetlink.c:1218
 #1: ffffffff8f59fe08 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/g=
enetlink.c:35 [inline]
 #1: ffffffff8f59fe08 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlin=
k/genetlink.c:60 [inline]
 #1: ffffffff8f59fe08 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x10d/0x79=
0 net/netlink/genetlink.c:1209
 #2: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: wiphy_register+0x1b8d/0=
x28d0 net/wireless/core.c:1021
 #3: ffff888051510768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: class_wiphy_const=
ructor include/net/cfg80211.h:6212 [inline]
 #3: ffff888051510768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: reg_process_self_=
managed_hints+0xaf/0x1c0 net/wireless/reg.c:3209
1 lock held by syz-executor/5511:
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: tun_detach drivers/net/=
tun.c:634 [inline]
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: tun_chr_close+0x3e/0x1c=
0 drivers/net/tun.c:3433
1 lock held by syz-executor/5514:
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/l=
inux/rtnetlink.h:130 [inline]
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: inet6_rtm_newaddr+0x5b7=
/0xd20 net/ipv6/addrconf.c:5027
3 locks held by kworker/0:4/5517:
1 lock held by syz-executor/5521:
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtne=
tlink.c:80 [inline]
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core=
/rtnetlink.c:341 [inline]
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x8db/0x1c=
70 net/core/rtnetlink.c:4056
1 lock held by syz-executor/5523:
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/l=
inux/rtnetlink.h:130 [inline]
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: inet6_rtm_newaddr+0x5b7=
/0xd20 net/ipv6/addrconf.c:5027
4 locks held by kworker/0:5/5655:
 #0: ffff88803ee26148 ((wq_completion)wg-kex-wg1#4){+.+.}-{0:0}, at: proces=
s_one_work kernel/workqueue.c:3211 [inline]
 #0: ffff88803ee26148 ((wq_completion)wg-kex-wg1#4){+.+.}-{0:0}, at: proces=
s_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3319
 #1: ffffc9000ce57bc0 ((work_completion)(&({ do { const void *__vpp_verify =
=3D (typeof((worker) + 0))((void *)0); (void)__vpp_verify; } while (0); ({ =
unsigned long __ptr; __ptr =3D (unsigned long) ((__typeof_unqual__(*((worke=
r))) *)(( unsigned long)((worker)))); (typeof((__typeof_unqual__(*((worker)=
)) *)(( unsigned long)((worker))))) (__ptr + (((__per_cpu_offset[(cpu)]))))=
; }); })->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3212 =
[inline]
 #1: ffffc9000ce57bc0 ((work_completion)(&({ do { const void *__vpp_verify =
=3D (typeof((worker) + 0))((void *)0); (void)__vpp_verify; } while (0); ({ =
unsigned long __ptr; __ptr =3D (unsigned long) ((__typeof_unqual__(*((worke=
r))) *)(( unsigned long)((worker)))); (typeof((__typeof_unqual__(*((worker)=
)) *)(( unsigned long)((worker))))) (__ptr + (((__per_cpu_offset[(cpu)]))))=
; }); })->work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kern=
el/workqueue.c:3319
 #2: ffff888058c65308 (&wg->static_identity.lock){++++}-{4:4}, at: wg_noise=
_handshake_consume_initiation+0x150/0x900 drivers/net/wireguard/noise.c:598
 #3: ffff88803f1f5c60 (&handshake->lock){++++}-{4:4}, at: wg_noise_handshak=
e_consume_initiation+0x4de/0x900 drivers/net/wireguard/noise.c:632
2 locks held by kworker/0:6/5665:
4 locks held by kworker/0:7/5698:
4 locks held by kworker/0:8/5727:
4 locks held by kworker/u4:13/5741:
2 locks held by kworker/u4:14/5742:
3 locks held by kworker/u4:15/5743:
3 locks held by kworker/u4:17/5746:
1 lock held by syz.0.28/5754:
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: tun_detach drivers/net/=
tun.c:634 [inline]
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: tun_chr_close+0x3e/0x1c=
0 drivers/net/tun.c:3433
3 locks held by kworker/0:10/5760:
 #0: ffff88801a4d4148 ((wq_completion)events_power_efficient){+.+.}-{0:0}, =
at: process_one_work kernel/workqueue.c:3211 [inline]
 #0: ffff88801a4d4148 ((wq_completion)events_power_efficient){+.+.}-{0:0}, =
at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3319
 #1: ffffc9000d557bc0 ((reg_check_chans).work){+.+.}-{0:0}, at: process_one=
_work kernel/workqueue.c:3212 [inline]
 #1: ffffc9000d557bc0 ((reg_check_chans).work){+.+.}-{0:0}, at: process_sch=
eduled_works+0x9ef/0x17b0 kernel/workqueue.c:3319
 #2: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: reg_check_chans_work+0x=
95/0xf30 net/wireless/reg.c:2483
1 lock held by syz-executor/5767:
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/l=
inux/rtnetlink.h:130 [inline]
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x3b0/=
0x18b0 net/ipv4/devinet.c:979
1 lock held by syz-executor/5780:
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/l=
inux/rtnetlink.h:130 [inline]
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x3b0/=
0x18b0 net/ipv4/devinet.c:979
1 lock held by syz-executor/5783:
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/l=
inux/rtnetlink.h:130 [inline]
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x3b0/=
0x18b0 net/ipv4/devinet.c:979
1 lock held by syz-executor/5789:
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/l=
inux/rtnetlink.h:130 [inline]
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x3b0/=
0x18b0 net/ipv4/devinet.c:979
1 lock held by syz-executor/5795:
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/l=
inux/rtnetlink.h:130 [inline]
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x3b0/=
0x18b0 net/ipv4/devinet.c:979
1 lock held by syz-executor/5800:
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/l=
inux/rtnetlink.h:130 [inline]
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x3b0/=
0x18b0 net/ipv4/devinet.c:979
1 lock held by syz-executor/5810:
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/l=
inux/rtnetlink.h:130 [inline]
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x3b0/=
0x18b0 net/ipv4/devinet.c:979
1 lock held by syz-executor/5819:
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/l=
inux/rtnetlink.h:130 [inline]
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x3b0/=
0x18b0 net/ipv4/devinet.c:979
1 lock held by syz-executor/5822:
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/l=
inux/rtnetlink.h:130 [inline]
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x3b0/=
0x18b0 net/ipv4/devinet.c:979
1 lock held by syz-executor/5826:
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/l=
inux/rtnetlink.h:130 [inline]
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x3b0/=
0x18b0 net/ipv4/devinet.c:979
4 locks held by kworker/u4:20/5832:
 #0: ffff8880230b0148 ((wq_completion)wg-kex-wg1){+.+.}-{0:0}, at: process_=
one_work kernel/workqueue.c:3211 [inline]
 #0: ffff8880230b0148 ((wq_completion)wg-kex-wg1){+.+.}-{0:0}, at: process_=
scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3319
 #1: ffffc9000d807bc0 ((work_completion)(&peer->transmit_handshake_work)){+=
.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3212 [inline]
 #1: ffffc9000d807bc0 ((work_completion)(&peer->transmit_handshake_work)){+=
.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:331=
9
 #2: ffff88803f125308 (&wg->static_identity.lock){++++}-{4:4}, at: wg_noise=
_handshake_create_initiation+0x10a/0x7e0 drivers/net/wireguard/noise.c:529
 #3: ffff88803f1f4890 (&handshake->lock){++++}-{4:4}, at: wg_noise_handshak=
e_create_initiation+0x11b/0x7e0 drivers/net/wireguard/noise.c:530
1 lock held by syz-executor/5835:
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/l=
inux/rtnetlink.h:130 [inline]
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x3b0/=
0x18b0 net/ipv4/devinet.c:979
1 lock held by syz-executor/5838:
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/l=
inux/rtnetlink.h:130 [inline]
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x3b0/=
0x18b0 net/ipv4/devinet.c:979
1 lock held by syz-executor/5846:
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/l=
inux/rtnetlink.h:130 [inline]
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x3b0/=
0x18b0 net/ipv4/devinet.c:979
1 lock held by syz-executor/5852:
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/l=
inux/rtnetlink.h:130 [inline]
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x3b0/=
0x18b0 net/ipv4/devinet.c:979
1 lock held by syz-executor/5857:
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/l=
inux/rtnetlink.h:130 [inline]
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x3b0/=
0x18b0 net/ipv4/devinet.c:979
1 lock held by syz-executor/5863:
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/l=
inux/rtnetlink.h:130 [inline]
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x3b0/=
0x18b0 net/ipv4/devinet.c:979
3 locks held by kworker/u4:21/5864:
1 lock held by syz-executor/5871:
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/l=
inux/rtnetlink.h:130 [inline]
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x3b0/=
0x18b0 net/ipv4/devinet.c:979
1 lock held by syz-executor/5875:
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/l=
inux/rtnetlink.h:130 [inline]
 #0: ffffffff8f53a948 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x3b0/=
0x18b0 net/ipv4/devinet.c:979

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 26 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(ful=
l)=20
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16=
.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:328 [inline]
 watchdog+0xf93/0xfe0 kernel/hung_task.c:491
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

