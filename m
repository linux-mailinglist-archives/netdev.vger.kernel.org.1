Return-Path: <netdev+bounces-192861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3B6AC1688
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 00:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2F1E3B98A3
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 22:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FB526FA40;
	Thu, 22 May 2025 22:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Ts/6w6uG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FE526B968;
	Thu, 22 May 2025 22:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747952361; cv=none; b=tZoYd4RmrdXL0Jax9G2a/T/asShwcTzh0o32+ewjJwCTMrIU4CVdPItaR0VPHBZ6oQhWbeCx+ykoArSd7dho82d3wTQcUVCf6T7fQBUYbGKi6nsDTmU7HtclXGgd3alde4aJ2sTTEhesl4LtC5Xfp2tu6PDopau19AYQgaGEi/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747952361; c=relaxed/simple;
	bh=9dxErB5pS2CXLkaOwc0EHf+ZBZ+Z0Mc51fJGO8IndLw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZHF9ti9uA8e8WQJg4EjlK+nnsgGRxR1CuKNkq2UHOyhAiS/6uRjQUZZHSQ38EYMxCVQ29zL0cAuDTRkZtXTmhuiJ8OEGpdRQgn/lfK4CnTRiWpjYVu8SBmF5MTj6MxRasm302gXXmL5FqI+CHXN45MyjdbuTQIbiDMDN9D0IqNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Ts/6w6uG; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747952360; x=1779488360;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4vV82EZnd8rNKHjUbikYWXs6eZjhALAVx/i3Z/Ci0cg=;
  b=Ts/6w6uGvTSsU33W+++xBGxqqt41psgEPn8pWknViUsfchM7NpqpqxOb
   TtgCF10r8EGVXD77e7F9mbB6LveGUn1TVotV8AfD/Zt4+OXj2cNIjlGMV
   jjLZ09xSPblHi7bZUHgwdVvL6LMRWOCqiKjTPXlJo6Z7WwD1BnoADWXQ6
   BxxlFAXzrFY3jt7E9Ps6+jpYlhoHxPmJII5Xk2TXsYG063S7fWYvFNb0b
   fm3B8yjirubkBOzcLaRkwteR0semEoIaTzup1ule8bxD9eo0YyVMmLWyT
   R66cdFBjOFTZV447bG4KkWDIzhG3M/pf+7Y/x1R2vQhLbkJU8JYrbkVzN
   w==;
X-IronPort-AV: E=Sophos;i="6.15,307,1739836800"; 
   d="scan'208";a="22912941"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 22:19:11 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:34472]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.147:2525] with esmtp (Farcaster)
 id d0938ecf-7d11-4b40-8e3f-6c58e1e30ecc; Thu, 22 May 2025 22:19:10 +0000 (UTC)
X-Farcaster-Flow-ID: d0938ecf-7d11-4b40-8e3f-6c58e1e30ecc
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 22:19:09 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 22:19:06 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Paul Moore <paul@paul-moore.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Huw Davies <huw@codeweavers.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, syzkaller
	<syzkaller@googlegroups.com>, John Cheung <john.cs.hey@gmail.com>
Subject: [PATCH v1 net] calipso: Don't call calipso functions for AF_INET sk.
Date: Thu, 22 May 2025 15:18:56 -0700
Message-ID: <20250522221858.91240-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB004.ant.amazon.com (10.13.139.134) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

syzkaller reported a null-ptr-deref in txopt_get(). [0]

The offset 0x70 was of struct ipv6_txoptions in struct ipv6_pinfo,
so struct ipv6_pinfo was NULL there.

However, this never happens for IPv6 sockets as inet_sk(sk)->pinet6
is always set in inet6_create(), meaning the socket was not IPv6 one.

The root cause is missing validation in netlbl_conn_setattr().

netlbl_conn_setattr() switches branches based on struct
sockaddr.sa_family, which is passed from userspace.  However,
netlbl_conn_setattr() does not check if the address family matches
the socket.

The syzkaller must have called connect() for an IPv6 address on
an IPv4 socket.

We have a proper validation in tcp_v[46]_connect(), but
security_socket_connect() is called in the earlier stage.

Let's copy the validation to netlbl_conn_setattr().

[0]:
Oops: general protection fault, probably for non-canonical address 0xdffffc000000000e: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000070-0x0000000000000077]
CPU: 2 UID: 0 PID: 12928 Comm: syz.9.1677 Not tainted 6.12.0 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:txopt_get include/net/ipv6.h:390 [inline]
RIP: 0010:
Code: 02 00 00 49 8b ac 24 f8 02 00 00 e8 84 69 2a fd e8 ff 00 16 fd 48 8d 7d 70 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 53 02 00 00 48 8b 6d 70 48 85 ed 0f 84 ab 01 00
RSP: 0018:ffff88811b8afc48 EFLAGS: 00010212
RAX: dffffc0000000000 RBX: 1ffff11023715f8a RCX: ffffffff841ab00c
RDX: 000000000000000e RSI: ffffc90007d9e000 RDI: 0000000000000070
RBP: 0000000000000000 R08: ffffed1023715f9d R09: ffffed1023715f9e
R10: ffffed1023715f9d R11: 0000000000000003 R12: ffff888123075f00
R13: ffff88810245bd80 R14: ffff888113646780 R15: ffff888100578a80
FS:  00007f9019bd7640(0000) GS:ffff8882d2d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f901b927bac CR3: 0000000104788003 CR4: 0000000000770ef0
PKRU: 80000000
Call Trace:
 <TASK>
 calipso_sock_setattr+0x56/0x80 net/netlabel/netlabel_calipso.c:557
 netlbl_conn_setattr+0x10c/0x280 net/netlabel/netlabel_kapi.c:1177
 selinux_netlbl_socket_connect_helper+0xd3/0x1b0 security/selinux/netlabel.c:569
 selinux_netlbl_socket_connect_locked security/selinux/netlabel.c:597 [inline]
 selinux_netlbl_socket_connect+0xb6/0x100 security/selinux/netlabel.c:615
 selinux_socket_connect+0x5f/0x80 security/selinux/hooks.c:4931
 security_socket_connect+0x50/0xa0 security/security.c:4598
 __sys_connect_file+0xa4/0x190 net/socket.c:2067
 __sys_connect+0x12c/0x170 net/socket.c:2088
 __do_sys_connect net/socket.c:2098 [inline]
 __se_sys_connect net/socket.c:2095 [inline]
 __x64_sys_connect+0x73/0xb0 net/socket.c:2095
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xaa/0x1b0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f901b61a12d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9019bd6fa8 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007f901b925fa0 RCX: 00007f901b61a12d
RDX: 000000000000001c RSI: 0000200000000140 RDI: 0000000000000003
RBP: 00007f901b701505 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f901b5b62a0 R15: 00007f9019bb7000
 </TASK>
Modules linked in:

Fixes: ceba1832b1b2 ("calipso: Set the calipso socket label to match the secattr.")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Reported-by: John Cheung <john.cs.hey@gmail.com>
Closes: https://lore.kernel.org/netdev/CAP=Rh=M1LzunrcQB1fSGauMrJrhL6GGps5cPAKzHJXj6GQV+-g@mail.gmail.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/netlabel/netlabel_kapi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index cd9160bbc919..6ea16138582c 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -1165,6 +1165,9 @@ int netlbl_conn_setattr(struct sock *sk,
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6:
+		if (sk->sk_family != AF_INET6)
+			return -EAFNOSUPPORT;
+
 		addr6 = (struct sockaddr_in6 *)addr;
 		entry = netlbl_domhsh_getentry_af6(secattr->domain,
 						   &addr6->sin6_addr);
-- 
2.49.0


