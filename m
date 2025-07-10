Return-Path: <netdev+bounces-205708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 118D8AFFCFC
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 10:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D41F13A3569
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 08:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEE028FFCF;
	Thu, 10 Jul 2025 08:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="j2kunTDk"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63591C861B
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 08:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137772; cv=none; b=MHUKpn2Pv1sxv8iD7DCpMcj85ybuxSub5c8EmP+Nf6L8doLdRfUK9nJFtEOSYIK27sN/0yz474KwAVXJZSmRAmD8DIWInY1is3EbnIFUXtUpe+CmwgU5YRuUp7b4XQ/1fpnaJJdutJff7S3eqDlAurXJkoUbVFG6yhPlZhaKgRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137772; c=relaxed/simple;
	bh=P6hr7WhgZPpd5Zbg2h2gV8CLmhk9rX3kiW+ZHYh+qVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J+6fAtSn30TWrKtLuVivYLMKNxbyN26tGvEFs7aE969sTFAI8LwveEy/aXMr+QXR8q8doRgb/7Xt5gO+HSvTEkGBrUyUcjg85buEAYkvOsIGgtCgetgyyLkVc/6au22foNg36Ko/OA7xziTdJuXLZp4tBAGv9vmrblyST7S8+cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=j2kunTDk; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1752137762;
	bh=1jUDZcHg2ZFpOuhDAzQoZx2ZNn4rLiOhJeFEvhT9SWo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=j2kunTDkKy2bksVMgjB2l/1jNbs4aK/4XaaC/O8igrO8mHTR716kPBY3oBPI0iUHG
	 YDkPZ6XSnuM4g+57uOMcD2B/Wy43ytvcM1VFm/Z/opNPUrDE7HOmzdZZQ4bgVqd3HQ
	 B7mLJ9Jbl7SloA6fGamZkpS6Knwqn9U7as+UUOmbAI8stus+JoIjZBtSORCA2Co0W8
	 6oeGH0FTy6f6oFl/pxO2JzcxWWfuZ+XBaIFrMcgn1gteRP4XzIXAkkVqwMDUseiylD
	 lUxjs3zJDiN91urHdjWQd8JSW8/m4eKMklZ1AXs5lpjsYy7dp4bvUgo5uqe3vkUGHu
	 qhFqzhSJHyUiw==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id D44A86B238; Thu, 10 Jul 2025 16:56:02 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
Date: Thu, 10 Jul 2025 16:55:55 +0800
Subject: [PATCH net-next v4 2/8] net: mctp: Prevent duplicate binds
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-mctp-bind-v4-2-8ec2f6460c56@codeconstruct.com.au>
References: <20250710-mctp-bind-v4-0-8ec2f6460c56@codeconstruct.com.au>
In-Reply-To: <20250710-mctp-bind-v4-0-8ec2f6460c56@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>
X-Mailer: b4 0.15-dev-cbbb4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752137761; l=2005;
 i=matt@codeconstruct.com.au; s=20241018; h=from:subject:message-id;
 bh=P6hr7WhgZPpd5Zbg2h2gV8CLmhk9rX3kiW+ZHYh+qVM=;
 b=6P7DGT+JH5vDfE7VLo6rdk7pMx2shIHW/gfUW+k7PKX6vMiK1EGexVhjc83AfVSHXxGwsoLcY
 j9+VFfuyXV4Bhqc5dhFiJzkkn94WbCVJDQJthQPtVlQvLrMzbIIka+k
X-Developer-Key: i=matt@codeconstruct.com.au; a=ed25519;
 pk=exersTcCYD/pEBOzXGO6HkLd6kKXRuWxHhj+LXn3DYE=

Disallow bind() calls that have the same arguments as existing bound
sockets.  Previously multiple sockets could bind() to the same
type/local address, with an arbitrary socket receiving matched messages.

This is only a partial fix, a future commit will define precedence order
for MCTP_ADDR_ANY versus specific EID bind(), which are allowed to exist
together.

Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
---
 net/mctp/af_mctp.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index aef74308c18e3273008cb84aabe23ff700d0f842..0d073bc32ec17905ac0118d1aa653a46d829b150 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -73,7 +73,6 @@ static int mctp_bind(struct socket *sock, struct sockaddr *addr, int addrlen)
 
 	lock_sock(sk);
 
-	/* TODO: allow rebind */
 	if (sk_hashed(sk)) {
 		rc = -EADDRINUSE;
 		goto out_release;
@@ -611,15 +610,36 @@ static void mctp_sk_close(struct sock *sk, long timeout)
 static int mctp_sk_hash(struct sock *sk)
 {
 	struct net *net = sock_net(sk);
+	struct sock *existing;
+	struct mctp_sock *msk;
+	int rc;
+
+	msk = container_of(sk, struct mctp_sock, sk);
 
 	/* Bind lookup runs under RCU, remain live during that. */
 	sock_set_flag(sk, SOCK_RCU_FREE);
 
 	mutex_lock(&net->mctp.bind_lock);
-	sk_add_node_rcu(sk, &net->mctp.binds);
-	mutex_unlock(&net->mctp.bind_lock);
 
-	return 0;
+	/* Prevent duplicate binds. */
+	sk_for_each(existing, &net->mctp.binds) {
+		struct mctp_sock *mex =
+			container_of(existing, struct mctp_sock, sk);
+
+		if (mex->bind_type == msk->bind_type &&
+		    mex->bind_addr == msk->bind_addr &&
+		    mex->bind_net == msk->bind_net) {
+			rc = -EADDRINUSE;
+			goto out;
+		}
+	}
+
+	sk_add_node_rcu(sk, &net->mctp.binds);
+	rc = 0;
+
+out:
+	mutex_unlock(&net->mctp.bind_lock);
+	return rc;
 }
 
 static void mctp_sk_unhash(struct sock *sk)

-- 
2.43.0


