Return-Path: <netdev+bounces-150541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B9A9EA9BF
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 08:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13AAC284C4C
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 07:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0D71FCCE6;
	Tue, 10 Dec 2024 07:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="V5jNoAjQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852C7172BD5
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 07:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733816386; cv=none; b=EIZI2OQIudz2U7cCaw6W3ntIllpHyb33MrcY8P1Wd1ahCCt77u3+hhyZSU7HOgUF5dUKrXv0e+rhZbojFtkG8mQ+e2MepE/rup7IfdlBTkDQHTtnOA/3CGNCEdrWDh4NWhamm8soPXhbA3nxBkBqtqj6hiJFIkeG/pen+iHC6ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733816386; c=relaxed/simple;
	bh=iaSUHXMVtI2zkvdqcIdWeIgFecoQUt7sFQE1bfNFrGA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fcb9bJf/Ev/YR+BlgpyJCw75KfUiACSwx5x4BhyF04il2Z/I7NKGG42nQM9Puv2S5QCMaGNBl77cpT0CcG1inSKHVjPe76s7duNm1fqCJqNc7HjwplY0JbMw8jtD4e/xe6cYch98jgUAgSvTdnIv3ov58BKOUHGwCrzL44rYk2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=V5jNoAjQ; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733816386; x=1765352386;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bw4SQjzkiztxuUlVvjCr/iVuwPoKWOPTFpxXuYDdGWs=;
  b=V5jNoAjQyN1g6stcS0QAB9QU1CIgJ1v1pEPXj6xxTItuMZP/RKGsd2yo
   4JoSiJaoQ1VWfiLAxO2Knat4AS2hwDSTlkvR5TBdcVYvTcbPT/izR4+pr
   8kb3lO/i/dhuV1hBtvRFtakATA0fgbfQQUeq1bzIBhcZBpcuSOyZwGTBI
   c=;
X-IronPort-AV: E=Sophos;i="6.12,221,1728950400"; 
   d="scan'208";a="782128256"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 07:39:45 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:40324]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.73:2525] with esmtp (Farcaster)
 id 98303f3f-4427-4edd-aafa-174106b60e2a; Tue, 10 Dec 2024 07:39:43 +0000 (UTC)
X-Farcaster-Flow-ID: 98303f3f-4427-4edd-aafa-174106b60e2a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Dec 2024 07:39:43 +0000
Received: from 6c7e67c6786f.amazon.com (10.143.88.19) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 10 Dec 2024 07:39:40 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 03/15] smc: Pass kern to smc_sock_alloc().
Date: Tue, 10 Dec 2024 16:38:17 +0900
Message-ID: <20241210073829.62520-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241210073829.62520-1-kuniyu@amazon.com>
References: <20241210073829.62520-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC002.ant.amazon.com (10.13.139.250) To
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
index 9e6c69d18581..a9679c37202d 100644
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
 
@@ -1712,7 +1712,7 @@ static int smc_clcsock_accept(struct smc_sock *lsmc, struct smc_sock **new_smc)
 	int rc = -EINVAL;
 
 	release_sock(lsk);
-	new_sk = smc_sock_alloc(sock_net(lsk), NULL, lsk->sk_protocol);
+	new_sk = smc_sock_alloc(sock_net(lsk), NULL, lsk->sk_protocol, 0);
 	if (!new_sk) {
 		rc = -ENOMEM;
 		lsk->sk_err = ENOMEM;
@@ -3346,7 +3346,7 @@ static int __smc_create(struct net *net, struct socket *sock, int protocol,
 	rc = -ENOBUFS;
 	sock->ops = &smc_sock_ops;
 	sock->state = SS_UNCONNECTED;
-	sk = smc_sock_alloc(net, sock, protocol);
+	sk = smc_sock_alloc(net, sock, protocol, kern);
 	if (!sk)
 		goto out;
 
@@ -3405,7 +3405,7 @@ static int smc_ulp_init(struct sock *sk)
 
 	smcsock->type = SOCK_STREAM;
 	__module_get(THIS_MODULE); /* tried in __tcp_ulp_find_autoload */
-	ret = __smc_create(net, smcsock, protocol, 1, tcp);
+	ret = __smc_create(net, smcsock, protocol, 0, tcp);
 	if (ret) {
 		sock_release(smcsock); /* module_put() which ops won't be NULL */
 		return ret;
-- 
2.39.5 (Apple Git-154)


