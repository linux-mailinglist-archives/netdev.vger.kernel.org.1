Return-Path: <netdev+bounces-149623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 831349E684A
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 08:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60DE6161F1C
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 07:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE4B1DD88F;
	Fri,  6 Dec 2024 07:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="OYLkCUdt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D776B1DA0E9
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 07:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733471781; cv=none; b=EMkUROZWidDGmFH4XvjU2RJwpAx6WveVeWWi1BL7qV/HEKreGejzR3ivvnK0XDPYxVxzA139HsAVSAMFaKvxooGzG1kKqqZwZ0KSEM9h5QvUVEbk6mW2NiMJ4xQnHKwd1Nf6v9pwRtzxIBwKhmHHdErLd+Fv7ysZy1LGs+1oNGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733471781; c=relaxed/simple;
	bh=r2+lGsLtxpHeVNNKFcRgwPKo7UjtOvc2N5cbIljDq5U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G0K1NwVc5X58qziU156UIzT6dIFybWcS88W8MXKZIo7C9uzTyK5KkMhQCmAV2A22/G2ikhQKpZwig7zVFz75HDPRUF1UVWKQi3qcdqPqeFUq39iiPbNRK/of+XeOB/lufZRslJItJ6ssDh5GER+/APkA1JJEzYD9KfDics8J1ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=OYLkCUdt; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733471779; x=1765007779;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wgiKOgTEdrNBIiVGTtX+CucVKB0t62H5m9b4n0LKQzM=;
  b=OYLkCUdtLmuqt6o+4NVBu0rdM9NOsKTS+vubRfRiaPPIoetrKNMAe3Vs
   Wa9+Dh0eekAIx2rD+E5v3vislD35hWsthHbaa3im0ciC4J4NDxLpX7Kho
   NvBj7hrgVtxHhUxtau9z5iSMU6fh/K/JXMFUa0l9dLL+iowAwjVTWkpj8
   c=;
X-IronPort-AV: E=Sophos;i="6.12,212,1728950400"; 
   d="scan'208";a="47150982"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 07:56:15 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:15522]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.230:2525] with esmtp (Farcaster)
 id 0080d5ae-bb73-4ad7-b1ba-9ceda03c2a05; Fri, 6 Dec 2024 07:56:15 +0000 (UTC)
X-Farcaster-Flow-ID: 0080d5ae-bb73-4ad7-b1ba-9ceda03c2a05
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 6 Dec 2024 07:56:15 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.244.93) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 6 Dec 2024 07:56:12 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 03/15] smc: Pass kern to smc_sock_alloc().
Date: Fri, 6 Dec 2024 16:54:52 +0900
Message-ID: <20241206075504.24153-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241206075504.24153-1-kuniyu@amazon.com>
References: <20241206075504.24153-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB002.ant.amazon.com (10.13.138.97) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Since commit d7cd421da9da ("net/smc: Introduce TCP ULP support"),
smc_ulp_init() calls __smc_create() with kern=1.

However, __smc_create() does not pass it to smc_sock_alloc(),
which finally calls sk_alloc() with kern=0.

Let's pass kern down to smc_sock_alloc() and sk_alloc().

Note that we change kern from 1 to 0 in smc_ulp_init() not to
introduce any functional change.

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


