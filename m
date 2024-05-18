Return-Path: <netdev+bounces-97050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D3B8C8F09
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 03:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75364B2133E
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 01:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A07564D;
	Sat, 18 May 2024 01:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ehBots4Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A384624
	for <netdev@vger.kernel.org>; Sat, 18 May 2024 01:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715994849; cv=none; b=QuYElxYgzRGN2lEEO+FI/neNBT172+5+7pJthNCEnWy1cH1ZGqueDka6WXv5wv2xGgDKd18Vhc1cOjp/bCE//xraTeQT/9PbRzmIL4m+p7j7+jv8/sIO0lU6l6x6AV4Un27j8pYmjs8UcKErpOV+FvvUCrLJk6USZfhQ2+1/oxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715994849; c=relaxed/simple;
	bh=4zJos9JNnu7T1auHSQHXwiGoAoCOlksPyfQnHD6nxRk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wq00ilyVQOhQ6xE49ms9TBw//uxLuhIgP5X46CV9mfd+OXyKxnenatL0HCk9wi7+xTn2rSVgC8zgrTlYUR+X2Vekuvvxddm8iePluxjkp18mndhgrnyeqgnCRplJfrn5kRlG1F4aeg81CwHqq/YS01SJ9eLELIF4Ej3AkCx2k6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ehBots4Y; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715994848; x=1747530848;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0PdiHla2OA4q+w91G6ItT/rvl3i9t9FUjLF+3BxwmwM=;
  b=ehBots4YnXTDtBOd0HgG1/YipPrfWEh0MyEUzoSGNtcliaweoFPWvsj7
   KkoogQF6WH78/aXbfmAeLCIbZZnAksF3q14+Oq6s92xkH02RyAMoi2nLj
   9aRPGHLQu9VnxPtImurofM5sD69TUxSlUmG0B1BmU3Huz49iH4P24Kh2f
   Y=;
X-IronPort-AV: E=Sophos;i="6.08,169,1712620800"; 
   d="scan'208";a="407559196"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2024 01:14:05 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:62854]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.175:2525] with esmtp (Farcaster)
 id 18a6dad0-b630-4150-8fd5-5f116a6c2cbc; Sat, 18 May 2024 01:14:04 +0000 (UTC)
X-Farcaster-Flow-ID: 18a6dad0-b630-4150-8fd5-5f116a6c2cbc
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sat, 18 May 2024 01:14:03 +0000
Received: from 88665a182662.ant.amazon.com (10.119.8.176) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sat, 18 May 2024 01:14:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, syzkaller
	<syzkaller@googlegroups.com>
Subject: [PATCH v1 net] af_unix: Annotate data-races around sk->sk_hash.
Date: Sat, 18 May 2024 10:13:46 +0900
Message-ID: <20240518011346.36248-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB002.ant.amazon.com (10.13.138.89) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

syzkaller reported data-race of sk->sk_hash in unix_autobind() [0],
and the same ones exist in unix_bind_bsd() and unix_bind_abstract().

The three bind() functions prefetch sk->sk_hash locklessly and
use it later after validating that unix_sk(sk)->addr is NULL under
unix_sk(sk)->bindlock.

The prefetched sk->sk_hash is the hash value of unbound socket set
in unix_create1() and does not change until bind() completes.

There could be a chance that sk->sk_hash changes after the lockless
read.  However, in such a case, non-NULL unix_sk(sk)->addr is visible
under unix_sk(sk)->bindlock, and bind() returns -EINVAL without using
the prefetched value.

The KCSAN splat is false-positive, but let's use WRITE_ONCE() and
READ_ONCE() to silence it.

[0]:
BUG: KCSAN: data-race in unix_autobind / unix_autobind

write to 0xffff888034a9fb88 of 4 bytes by task 4468 on cpu 0:
 __unix_set_addr_hash net/unix/af_unix.c:331 [inline]
 unix_autobind+0x47a/0x7d0 net/unix/af_unix.c:1185
 unix_dgram_connect+0x7e3/0x890 net/unix/af_unix.c:1373
 __sys_connect_file+0xd7/0xe0 net/socket.c:2048
 __sys_connect+0x114/0x140 net/socket.c:2065
 __do_sys_connect net/socket.c:2075 [inline]
 __se_sys_connect net/socket.c:2072 [inline]
 __x64_sys_connect+0x40/0x50 net/socket.c:2072
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x4f/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x46/0x4e

read to 0xffff888034a9fb88 of 4 bytes by task 4465 on cpu 1:
 unix_autobind+0x28/0x7d0 net/unix/af_unix.c:1134
 unix_dgram_connect+0x7e3/0x890 net/unix/af_unix.c:1373
 __sys_connect_file+0xd7/0xe0 net/socket.c:2048
 __sys_connect+0x114/0x140 net/socket.c:2065
 __do_sys_connect net/socket.c:2075 [inline]
 __se_sys_connect net/socket.c:2072 [inline]
 __x64_sys_connect+0x40/0x50 net/socket.c:2072
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x4f/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x46/0x4e

value changed: 0x000000e4 -> 0x000001e3

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 4465 Comm: syz-executor.0 Not tainted 6.8.0-12822-gcd51db110a7e #12
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014

Fixes: afd20b9290e1 ("af_unix: Replace the big lock with small locks.")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 92a88ac070ca..e92b45e21664 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -327,8 +327,7 @@ static void __unix_set_addr_hash(struct net *net, struct sock *sk,
 {
 	__unix_remove_socket(sk);
 	smp_store_release(&unix_sk(sk)->addr, addr);
-
-	sk->sk_hash = hash;
+	WRITE_ONCE(sk->sk_hash, hash);
 	__unix_insert_socket(net, sk);
 }
 
@@ -1131,7 +1130,7 @@ static struct sock *unix_find_other(struct net *net,
 
 static int unix_autobind(struct sock *sk)
 {
-	unsigned int new_hash, old_hash = sk->sk_hash;
+	unsigned int new_hash, old_hash = READ_ONCE(sk->sk_hash);
 	struct unix_sock *u = unix_sk(sk);
 	struct net *net = sock_net(sk);
 	struct unix_address *addr;
@@ -1195,7 +1194,7 @@ static int unix_bind_bsd(struct sock *sk, struct sockaddr_un *sunaddr,
 {
 	umode_t mode = S_IFSOCK |
 	       (SOCK_INODE(sk->sk_socket)->i_mode & ~current_umask());
-	unsigned int new_hash, old_hash = sk->sk_hash;
+	unsigned int new_hash, old_hash = READ_ONCE(sk->sk_hash);
 	struct unix_sock *u = unix_sk(sk);
 	struct net *net = sock_net(sk);
 	struct mnt_idmap *idmap;
@@ -1261,7 +1260,7 @@ static int unix_bind_bsd(struct sock *sk, struct sockaddr_un *sunaddr,
 static int unix_bind_abstract(struct sock *sk, struct sockaddr_un *sunaddr,
 			      int addr_len)
 {
-	unsigned int new_hash, old_hash = sk->sk_hash;
+	unsigned int new_hash, old_hash = READ_ONCE(sk->sk_hash);
 	struct unix_sock *u = unix_sk(sk);
 	struct net *net = sock_net(sk);
 	struct unix_address *addr;
-- 
2.30.2


