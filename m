Return-Path: <netdev+bounces-194402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A0AAC93CC
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 18:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87FE07B2516
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 16:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440481DD525;
	Fri, 30 May 2025 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="Pfd44QIN"
X-Original-To: netdev@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03A11C8FBA
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 16:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748623388; cv=none; b=jDOEC7ydZwY8O9vKSQUTsJjhQLtIgDF3o8t5lh7ZRGQtW2f3CX8ExIvKZVxGKHlFO5d3aydszPJx67SFlIVSNcNAxp+ilv2tqo+e9s80OLRUgPtH5WGhI0J9I5PbjAbpbKdp6tWpgENw2yI48muRNkQo0UnipUy5/+1eW6mO0V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748623388; c=relaxed/simple;
	bh=6VnR19aWjvwXwg1SYHxcyQ9gqRgNVhxoENlPONOs/74=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=MQCItFADXG0z2oa4tUX+V2W5YEc4Ee8aONNrtXv594rHqBtgPSQlrb+Ve7eP3yKvj5jUC+eH05arQ2Ot7r/ic3Oqs9HkYp4mv0tTs48ncAkGEA/mqtH+WeSnUgDTL4KoPBbXq63fbsHqvF3b0UshLQW6d9k/VPubTLQAHo1Y3qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=Pfd44QIN; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 47C39240029
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 18:42:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1748623377; bh=6VnR19aWjvwXwg1SYHxcyQ9gqRgNVhxoENlPONOs/74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=Pfd44QINrX4OSQycDrGrPtpg44V7MZ66nsSU4eHUCR2KjZHxjdpbSAN3+y+8xLEZJ
	 PP747CfglyJ1hvIITWyzciXS6CNyYi/JprerpkFQLU5crnzH75OEYCLqiI6PaKtgvg
	 BWcZ0NX18SPIbDcHnnYx+QExJkI/ac+0Wz75cg0zeGTvAXfDReKtQCKhuiiMf2He8Q
	 WnCyagBI2zdbPTgaP3+RnD4bNYuyZ56xfA9AR+HrcJePOMGGAbE/6wgBkUqW2yPpHC
	 4g/+C3gyUn/hRsIGZ6oOKtRCxVgq2xJq2BfqQWtOHmnVWmNOGPqdLDHUH2WAqLNvSQ
	 kygU7zMkina0Q==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4b88DZ0h3Qz6v0W;
	Fri, 30 May 2025 18:42:53 +0200 (CEST)
References: <68138dfa.050a0220.14dd7d.0016.GAE@google.com>
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: syzbot <syzbot+a259a17220263c2d73fc@syzkaller.appspotmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, horms@kernel.org, kuba@kernel.org, kuniyu@amazon.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in nsim_fib_event_nb
Date: Fri, 30 May 2025 16:41:34 +0000
In-reply-to: <68138dfa.050a0220.14dd7d.0016.GAE@google.com>
Message-ID: <87r006nj7e.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


syzbot <syzbot+a259a17220263c2d73fc@syzkaller.appspotmail.com> writes:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    deeed351e982 Merge branch 'pds_core-cleanups'
> git tree:       net-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1125e39b980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=96ee122b7e5ad7d4
> dashboard link: https://syzkaller.appspot.com/bug?extid=a259a17220263c2d73fc
> compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a46f74580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e2d02f980000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f9cc381b3437/disk-deeed351.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/2df0da84738b/vmlinux-deeed351.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a1f015928ca2/bzImage-deeed351.xz
>
> The issue was bisected to:
>
> commit e6f497955fb6a072999db491a01dd3a203d5bcea
> Author: Kuniyuki Iwashima <kuniyu@amazon.com>
> Date:   Fri Apr 18 00:03:45 2025 +0000
>
>     ipv6: Check GATEWAY in rtm_to_fib6_multipath_config().
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=153481cc580000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=173481cc580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=133481cc580000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+a259a17220263c2d73fc@syzkaller.appspotmail.com
> Fixes: e6f497955fb6 ("ipv6: Check GATEWAY in rtm_to_fib6_multipath_config().")
>
> IPv6: RTM_NEWROUTE with no NLM_F_CREATE or NLM_F_REPLACE
> IPv6: NLM_F_CREATE should be set when creating new route
> IPv6: NLM_F_CREATE should be set when creating new route
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5822 at drivers/net/netdevsim/fib.c:831 nsim_fib6_event_init drivers/net/netdevsim/fib.c:831 [inline]
> WARNING: CPU: 0 PID: 5822 at drivers/net/netdevsim/fib.c:831 nsim_fib6_prepare_event drivers/net/netdevsim/fib.c:947 [inline]
> WARNING: CPU: 0 PID: 5822 at drivers/net/netdevsim/fib.c:831 nsim_fib_event_schedule_work drivers/net/netdevsim/fib.c:1003 [inline]
> WARNING: CPU: 0 PID: 5822 at drivers/net/netdevsim/fib.c:831 nsim_fib_event_nb+0xed8/0x1080 drivers/net/netdevsim/fib.c:1043
> Modules linked in:
> CPU: 0 UID: 0 PID: 5822 Comm: syz-executor175 Not tainted 6.15.0-rc3-syzkaller-00644-gdeeed351e982 #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/19/2025
> RIP: 0010:nsim_fib6_event_init drivers/net/netdevsim/fib.c:831 [inline]
> RIP: 0010:nsim_fib6_prepare_event drivers/net/netdevsim/fib.c:947 [inline]
> RIP: 0010:nsim_fib_event_schedule_work drivers/net/netdevsim/fib.c:1003 [inline]
> RIP: 0010:nsim_fib_event_nb+0xed8/0x1080 drivers/net/netdevsim/fib.c:1043
> Code: fa be 02 00 00 00 eb 0a e8 25 a2 bf fa be 01 00 00 00 4c 89 f7 e8 38 e6 b7 fd 4c 8b 64 24 08 e9 91 f4 ff ff e8 09 a2 bf fa 90 <0f> 0b 90 e9 70 fb ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c 35
> RSP: 0018:ffffc90003fff028 EFLAGS: 00010293
> RAX: ffffffff87001b77 RBX: 0000000000000002 RCX: ffff88802d180000
> RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000001
> RBP: dffffc0000000000 R08: ffff888078d6642f R09: 1ffff1100f1acc85
> R10: dffffc0000000000 R11: ffffed100f1acc86 R12: ffff888072f34000
> R13: ffffc90003fff1a0 R14: 0000000000000001 R15: ffffc90003fff1b8
> FS:  00005555830fa380(0000) GS:ffff8881260c4000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 000000007d7da000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  notifier_call_chain+0x1b3/0x3e0 kernel/notifier.c:85
>  atomic_notifier_call_chain+0xda/0x180 kernel/notifier.c:223
>  call_fib_notifiers+0x31/0x60 net/core/fib_notifier.c:35
>  call_fib6_multipath_entry_notifiers+0xe6/0x150 net/ipv6/ip6_fib.c:427
>  ip6_route_multipath_add net/ipv6/route.c:5593 [inline]
>  inet6_rtm_newroute+0x1a0c/0x1c70 net/ipv6/route.c:5717
>  rtnetlink_rcv_msg+0x7cc/0xb70 net/core/rtnetlink.c:6955
>  netlink_rcv_skb+0x219/0x490 net/netlink/af_netlink.c:2534
>  netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
>  netlink_unicast+0x758/0x8d0 net/netlink/af_netlink.c:1339
>  netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
>  sock_sendmsg_nosec net/socket.c:712 [inline]
>  __sock_sendmsg+0x219/0x270 net/socket.c:727
>  ____sys_sendmsg+0x505/0x830 net/socket.c:2566
>  ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
>  __sys_sendmsg net/socket.c:2652 [inline]
>  __do_sys_sendmsg net/socket.c:2657 [inline]
>  __se_sys_sendmsg net/socket.c:2655 [inline]
>  __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f6d91f8d999
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff05e7f5e8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 0000200000000300 RCX: 00007f6d91f8d999
> RDX: 0000000000000000 RSI: 0000200000000100 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 0000555500000000 R09: 0000555500000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash

#syz test: https://github.com/charmitro/linux.git a5ecfdd98680b51a58a570660086f871873506f4

