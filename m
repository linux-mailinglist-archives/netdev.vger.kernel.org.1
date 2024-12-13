Return-Path: <netdev+bounces-151654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2068E9F07C2
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 10:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFCDF168479
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 09:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BABB1AF0CE;
	Fri, 13 Dec 2024 09:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gZmfosKa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7676F1AF0C5
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734081789; cv=none; b=QNW1Avlgr4fW/Q3BWHTf0/JTUfePCjp71s0+w4P4uOQpqv6PymX8pHlt1cZjRGfmugNE0dhfD6Vh8tplZyth0BKSkXzy/6i5UDrSGFhpYNC3ei/WGJzEqpg8NwhMhx8qSo/ZPcWnb7IVDCf/oq5z18WBQk3qNU/nTwncPsFuTyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734081789; c=relaxed/simple;
	bh=HpOYJNwzZbDd0iLiCFkLQM+hE3z1Vo4EaGNQYK8LgFU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FKwhd8yHX+kIwof891t8y9Pl2EzcDS2c6qln+yPww69y9ADfJ6ZJw66+bmQDodePXeRlmLdf8NQ+v4Zzo3wSs/DqS+2/Pyzd4C2ENAX1RhSK7pEtksQq098CJyFfhrAyTI+Dbn9oMQ1llkh1bRrfdmUmXIxMQu+lD2C+LlO9fhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=gZmfosKa; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734081788; x=1765617788;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YhgYL+TRrt6OyTXupYifzZqaQKXArhbfIbw4+rjiUqw=;
  b=gZmfosKaKDUcoKwhU95CjKoSV+CiI+Waj4d4x8LFIF8UxfzVSsmIsug7
   7vBB8YjXl+a4evvv/KKv3cRdxA8zwLDKieDjXy0bxTzg5+mLg7+C7tH2Q
   UB6vc3rq6vjtbdq+IPODS0oRZwjy2Ab6FYGsZErbP2fk+qKD4EF86ykL+
   0=;
X-IronPort-AV: E=Sophos;i="6.12,230,1728950400"; 
   d="scan'208";a="360481741"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 09:23:06 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:31173]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.45.5:2525] with esmtp (Farcaster)
 id 8186012c-4e99-4f33-adfe-7de056c9ba8f; Fri, 13 Dec 2024 09:23:05 +0000 (UTC)
X-Farcaster-Flow-ID: 8186012c-4e99-4f33-adfe-7de056c9ba8f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 09:23:05 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.208) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 09:23:01 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 03/15] smc: Pass kern to smc_sock_alloc().
Date: Fri, 13 Dec 2024 18:21:40 +0900
Message-ID: <20241213092152.14057-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241213092152.14057-1-kuniyu@amazon.com>
References: <20241213092152.14057-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

AF_SMC was introduced in commit ac7138746e14 ("smc: establish
new socket family").

Since then, smc_create() ignores the kern argument and calls
smc_sock_alloc(), which calls sk_alloc() with hard-coded arguments.

  sk = sk_alloc(net, PF_SMC, GFP_KERNEL, prot, 0);

This means sock_create_kern(AF_SMC) always creates a userspace
socket.

Later, commit d7cd421da9da ("net/smc: Introduce TCP ULP support")
added another confusing call site.

smc_ulp_init() calls __smc_create() with kern=1, but again,
smc_sock_alloc() allocates a userspace socket by calling
sk_alloc() with kern=0.

To fix up the weird paths, let's pass kern down to smc_sock_alloc()
and sk_alloc().

This commit does not introduce functional change because we have
no in-tree users calling sock_create_kern(AF_SMC) and we change
kern from 1 to 0 in smc_ulp_init().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/smc/af_smc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 19ebff1c2579..b52bee98a3eb 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -387,13 +387,13 @@ void smc_sk_init(struct net *net, struct sock *sk, int protocol)
 }
 
 static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,
-				   int protocol)
+				   int protocol, int kern)
 {
 	struct proto *prot;
 	struct sock *sk;
 
 	prot = (protocol == SMCPROTO_SMC6) ? &smc_proto6 : &smc_proto;
-	sk = sk_alloc(net, PF_SMC, GFP_KERNEL, prot, 0);
+	sk = sk_alloc(net, PF_SMC, GFP_KERNEL, prot, kern);
 	if (!sk)
 		return NULL;
 
@@ -1715,7 +1715,7 @@ static int smc_clcsock_accept(struct smc_sock *lsmc, struct smc_sock **new_smc)
 	int rc = -EINVAL;
 
 	release_sock(lsk);
-	new_sk = smc_sock_alloc(sock_net(lsk), NULL, lsk->sk_protocol);
+	new_sk = smc_sock_alloc(sock_net(lsk), NULL, lsk->sk_protocol, 0);
 	if (!new_sk) {
 		rc = -ENOMEM;
 		lsk->sk_err = ENOMEM;
@@ -3349,7 +3349,7 @@ static int __smc_create(struct net *net, struct socket *sock, int protocol,
 	rc = -ENOBUFS;
 	sock->ops = &smc_sock_ops;
 	sock->state = SS_UNCONNECTED;
-	sk = smc_sock_alloc(net, sock, protocol);
+	sk = smc_sock_alloc(net, sock, protocol, kern);
 	if (!sk)
 		goto out;
 
@@ -3408,7 +3408,7 @@ static int smc_ulp_init(struct sock *sk)
 
 	smcsock->type = SOCK_STREAM;
 	__module_get(THIS_MODULE); /* tried in __tcp_ulp_find_autoload */
-	ret = __smc_create(net, smcsock, protocol, 1, tcp);
+	ret = __smc_create(net, smcsock, protocol, 0, tcp);
 	if (ret) {
 		sock_release(smcsock); /* module_put() which ops won't be NULL */
 		return ret;
-- 
2.39.5 (Apple Git-154)


