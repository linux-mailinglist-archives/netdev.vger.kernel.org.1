Return-Path: <netdev+bounces-83815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55655894649
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 22:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AD2B281F52
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 20:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597C653E35;
	Mon,  1 Apr 2024 20:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="EY2pXIpX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F3E53E16
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 20:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712004648; cv=none; b=NOmwsOtSpaQ/HQOj1dpvC/sgj1HqSw4KoU18xaYjlIy1k5jnUXYF7vL+53XDDbYnK3c9vL4Bwq08JVPJw1qA3TV/2Cw++dXrXQ862yTWPkvGhhF97MtX/pY4X5W2q7dOqjC3FwQ8PhibgNR4XUw8gGqaq3EQFf830oVI3tDO7Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712004648; c=relaxed/simple;
	bh=TpMAzY4Yg9GC6QWsoksYhR5wSAzFa55L0LlL/nK7bd0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UyI9VRj81s7TJaxYavgKrZfIEuRlVoIGdPAqfnIIxECk/Wj0hKpYYuCumQCHCjtIhbF8LdAyt3DMDMQTT9HCji3KdXYEMB0WHW0zsYpQ30sD0TbUAclVSu0NmJeQ+q/UmDmSd9VOw2GFQHnUTvyajdVGXn+BWJnxVjG6bwTij/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=EY2pXIpX; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712004646; x=1743540646;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c/Kh61zRHBlg5hbNzh/XJ0mkdgsB1lfFuCiRwyXxFHc=;
  b=EY2pXIpXT9igL+eAAGYhLWbFpW6V6tyEXfItnLu3ccZ5HuRqtrG9nbs1
   fJgqIeWidyceIYZrjO9WV/xiv3021TGbFF5ss10QpEZDX+HQUHiH64JYF
   vKtTB2sB4IKX39CRRZDZSayxDY/ZeM6KVgT/jEVpstDe0y2Kq2QPOgFtE
   0=;
X-IronPort-AV: E=Sophos;i="6.07,173,1708387200"; 
   d="scan'208";a="285369837"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 20:50:43 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:14576]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.22:2525] with esmtp (Farcaster)
 id 4a30ffad-47d2-4a50-91c7-aee7193acd6a; Mon, 1 Apr 2024 20:50:43 +0000 (UTC)
X-Farcaster-Flow-ID: 4a30ffad-47d2-4a50-91c7-aee7193acd6a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 1 Apr 2024 20:50:41 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Mon, 1 Apr 2024 20:50:38 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, syzkaller
	<syzkaller@googlegroups.com>
Subject: [PATCH v1 net] ipv6: Fix infinite recursion in fib6_dump_done().
Date: Mon, 1 Apr 2024 13:50:20 -0700
Message-ID: <20240401205020.22723-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC001.ant.amazon.com (10.13.139.197) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

1;95;0csyzkaller reported infinite recursive calls of fib6_dump_done() during
netlink socket destruction.  [1]

From the log, syzkaller sent an AF_UNSPEC RTM_GETROUTE message, and then
the response was generated.  The following recvmmsg() resumed the dump
for IPv6, but the first call of inet6_dump_fib() failed at kzalloc() due
to the fault injection.  [0]

  12:01:34 executing program 3:
  r0 = socket$nl_route(0x10, 0x3, 0x0)
  sendmsg$nl_route(r0, ... snip ...)
  recvmmsg(r0, ... snip ...) (fail_nth: 8)

Here, fib6_dump_done() was set to nlk_sk(sk)->cb.done, and the next call
of inet6_dump_fib() set it to nlk_sk(sk)->cb.args[3].  syzkaller stopped
receiving the response halfway through, and finally netlink_sock_destruct()
called nlk_sk(sk)->cb.done().

fib6_dump_done() calls fib6_dump_end() and nlk_sk(sk)->cb.done() if it
is still not NULL.  fib6_dump_end() rewrites nlk_sk(sk)->cb.done() by
nlk_sk(sk)->cb.args[3], but it has the same function, not NULL, calling
itself recursively and hitting the stack guard page.

To avoid the issue, let's set the destructor after kzalloc().

[0]:
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
CPU: 1 PID: 432110 Comm: syz-executor.3 Not tainted 6.8.0-12821-g537c2e91d354-dirty #11
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl (lib/dump_stack.c:117)
 should_fail_ex (lib/fault-inject.c:52 lib/fault-inject.c:153)
 should_failslab (mm/slub.c:3733)
 kmalloc_trace (mm/slub.c:3748 mm/slub.c:3827 mm/slub.c:3992)
 inet6_dump_fib (./include/linux/slab.h:628 ./include/linux/slab.h:749 net/ipv6/ip6_fib.c:662)
 rtnl_dump_all (net/core/rtnetlink.c:4029)
 netlink_dump (net/netlink/af_netlink.c:2269)
 netlink_recvmsg (net/netlink/af_netlink.c:1988)
 ____sys_recvmsg (net/socket.c:1046 net/socket.c:2801)
 ___sys_recvmsg (net/socket.c:2846)
 do_recvmmsg (net/socket.c:2943)
 __x64_sys_recvmmsg (net/socket.c:3041 net/socket.c:3034 net/socket.c:3034)

[1]:
BUG: TASK stack guard page was hit at 00000000f2fa9af1 (stack is 00000000b7912430..000000009a436beb)
stack guard page: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 223719 Comm: kworker/1:3 Not tainted 6.8.0-12821-g537c2e91d354-dirty #11
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
Workqueue: events netlink_sock_destruct_work
RIP: 0010:fib6_dump_done (net/ipv6/ip6_fib.c:570)
Code: 3c 24 e8 f3 e9 51 fd e9 28 fd ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 41 57 41 56 41 55 41 54 55 48 89 fd <53> 48 8d 5d 60 e8 b6 4d 07 fd 48 89 da 48 b8 00 00 00 00 00 fc ff
RSP: 0018:ffffc9000d980000 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffffff84405990 RCX: ffffffff844059d3
RDX: ffff8881028e0000 RSI: ffffffff84405ac2 RDI: ffff88810c02f358
RBP: ffff88810c02f358 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000224 R12: 0000000000000000
R13: ffff888007c82c78 R14: ffff888007c82c68 R15: ffff888007c82c68
FS:  0000000000000000(0000) GS:ffff88811b100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc9000d97fff8 CR3: 0000000102309002 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
 <#DF>
 </#DF>
 <TASK>
 fib6_dump_done (net/ipv6/ip6_fib.c:572 (discriminator 1))
 fib6_dump_done (net/ipv6/ip6_fib.c:572 (discriminator 1))
 ...
 fib6_dump_done (net/ipv6/ip6_fib.c:572 (discriminator 1))
 fib6_dump_done (net/ipv6/ip6_fib.c:572 (discriminator 1))
 netlink_sock_destruct (net/netlink/af_netlink.c:401)
 __sk_destruct (net/core/sock.c:2177 (discriminator 2))
 sk_destruct (net/core/sock.c:2224)
 __sk_free (net/core/sock.c:2235)
 sk_free (net/core/sock.c:2246)
 process_one_work (kernel/workqueue.c:3259)
 worker_thread (kernel/workqueue.c:3329 kernel/workqueue.c:3416)
 kthread (kernel/kthread.c:388)
 ret_from_fork (arch/x86/kernel/process.c:153)
 ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
Modules linked in:

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Conflict with:
https://lore.kernel.org/netdev/20240329183053.644630-1-edumazet@google.com/
---
 net/ipv6/ip6_fib.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 5c558dc1c683..7209419cfb0e 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -651,19 +651,19 @@ static int inet6_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 	if (!w) {
 		/* New dump:
 		 *
-		 * 1. hook callback destructor.
-		 */
-		cb->args[3] = (long)cb->done;
-		cb->done = fib6_dump_done;
-
-		/*
-		 * 2. allocate and initialize walker.
+		 * 1. allocate and initialize walker.
 		 */
 		w = kzalloc(sizeof(*w), GFP_ATOMIC);
 		if (!w)
 			return -ENOMEM;
 		w->func = fib6_dump_node;
 		cb->args[2] = (long)w;
+
+		/* 2. hook callback destructor.
+		 */
+		cb->args[3] = (long)cb->done;
+		cb->done = fib6_dump_done;
+
 	}
 
 	arg.skb = skb;
-- 
2.30.2


