Return-Path: <netdev+bounces-97602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 017578CC44A
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 17:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB915284302
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 15:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622E982491;
	Wed, 22 May 2024 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ncUOdWmn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B320B824A1
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 15:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716392561; cv=none; b=Y1saelIdNyp/Qzln5YF4RR/AHIlwocBfA+sOoMsfGegGRrQ4I+fggcYaMH5StWz1hWR4sv/GIN+P3TJBzP19lhUKHz6e8h+EFPS1GjjfpulpZTsE/hqVcWzfx0O+IX0gJge+KWMNpTPm2rrETH1DeTW2uvVblHMctwzqN52grhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716392561; c=relaxed/simple;
	bh=hImPJBiEyCvy/xQ6+nlZBOsnVDsbgGQgRvdQhSSugR8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a3+i8WqYpFZ5eAD4iwQk6V5cKcGRJBuuJAD+lkZaBk+BseisFA/0sh18MtwIbV7K3TMu7hJFAiiDjCmTfovo/BDrbfNGVuXW8NLGRTPXSblmimQ7B69kM/Ys2gAS1DCbBMEdQqaRjbndzJH17ywEolmyIjBCoPz6C8PRd24RJNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ncUOdWmn; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1716392559; x=1747928559;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=boUJw4gxHN2w2N+OmmxOA1aUWVzkKHuSVhYttVOT12I=;
  b=ncUOdWmnDTaNBmqSnbBLCGYyX1jm9eri/L0zNpjOhz7LrLl/JRoom/K9
   bh+D7GLJQQr3MPGsVT5xOOF3TS5e5GuKX3ze6zEFVFiOm6+i/BS04Uxvf
   bTZdCWGF4pj3Ns3jMAKI+6Prq5qj72Jxdihj0Aw7sIHplK3hY2VJGi9Ny
   c=;
X-IronPort-AV: E=Sophos;i="6.08,181,1712620800"; 
   d="scan'208";a="91036577"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 15:42:37 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:45214]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.80:2525] with esmtp (Farcaster)
 id 24cf1dd3-1a18-4d92-bc4c-c1e5dd6d6321; Wed, 22 May 2024 15:42:37 +0000 (UTC)
X-Farcaster-Flow-ID: 24cf1dd3-1a18-4d92-bc4c-c1e5dd6d6321
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 22 May 2024 15:42:33 +0000
Received: from 88665a182662.ant.amazon.com (10.143.93.121) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 22 May 2024 15:42:29 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, syzkaller
	<syzkaller@googlegroups.com>
Subject: [PATCH v2 net] af_unix: Read sk->sk_hash under bindlock during bind().
Date: Thu, 23 May 2024 00:42:18 +0900
Message-ID: <20240522154218.78088-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA001.ant.amazon.com (10.13.139.92) To
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

The KCSAN splat is false-positive, but let's silence it by reading
sk->sk_hash under unix_sk(sk)->bindlock.

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
v2: Move sk->sk_hash read under bindlock

v1: https://lore.kernel.org/netdev/20240518011346.36248-1-kuniyu@amazon.com/
---
 net/unix/af_unix.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 92a88ac070ca..5ec375da782f 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1131,8 +1131,8 @@ static struct sock *unix_find_other(struct net *net,
 
 static int unix_autobind(struct sock *sk)
 {
-	unsigned int new_hash, old_hash = sk->sk_hash;
 	struct unix_sock *u = unix_sk(sk);
+	unsigned int new_hash, old_hash;
 	struct net *net = sock_net(sk);
 	struct unix_address *addr;
 	u32 lastnum, ordernum;
@@ -1155,6 +1155,7 @@ static int unix_autobind(struct sock *sk)
 	addr->name->sun_family = AF_UNIX;
 	refcount_set(&addr->refcnt, 1);
 
+	old_hash = sk->sk_hash;
 	ordernum = get_random_u32();
 	lastnum = ordernum & 0xFFFFF;
 retry:
@@ -1195,8 +1196,8 @@ static int unix_bind_bsd(struct sock *sk, struct sockaddr_un *sunaddr,
 {
 	umode_t mode = S_IFSOCK |
 	       (SOCK_INODE(sk->sk_socket)->i_mode & ~current_umask());
-	unsigned int new_hash, old_hash = sk->sk_hash;
 	struct unix_sock *u = unix_sk(sk);
+	unsigned int new_hash, old_hash;
 	struct net *net = sock_net(sk);
 	struct mnt_idmap *idmap;
 	struct unix_address *addr;
@@ -1234,6 +1235,7 @@ static int unix_bind_bsd(struct sock *sk, struct sockaddr_un *sunaddr,
 	if (u->addr)
 		goto out_unlock;
 
+	old_hash = sk->sk_hash;
 	new_hash = unix_bsd_hash(d_backing_inode(dentry));
 	unix_table_double_lock(net, old_hash, new_hash);
 	u->path.mnt = mntget(parent.mnt);
@@ -1261,8 +1263,8 @@ static int unix_bind_bsd(struct sock *sk, struct sockaddr_un *sunaddr,
 static int unix_bind_abstract(struct sock *sk, struct sockaddr_un *sunaddr,
 			      int addr_len)
 {
-	unsigned int new_hash, old_hash = sk->sk_hash;
 	struct unix_sock *u = unix_sk(sk);
+	unsigned int new_hash, old_hash;
 	struct net *net = sock_net(sk);
 	struct unix_address *addr;
 	int err;
@@ -1280,6 +1282,7 @@ static int unix_bind_abstract(struct sock *sk, struct sockaddr_un *sunaddr,
 		goto out_mutex;
 	}
 
+	old_hash = sk->sk_hash;
 	new_hash = unix_abstract_hash(addr->name, addr->len, sk->sk_type);
 	unix_table_double_lock(net, old_hash, new_hash);
 
-- 
2.30.2


