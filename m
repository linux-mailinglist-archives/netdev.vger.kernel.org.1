Return-Path: <netdev+bounces-203722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B67AF6E3D
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 11:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAD953B2FC0
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 09:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03D02D4B68;
	Thu,  3 Jul 2025 09:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="VtiJ6m6k"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A443F2D372E
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 09:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533931; cv=none; b=Jxi/69SmH1BOIp95/EHvnl+RQdF5QWqE4osaPTLF5YscoG8YTyaMG6NY6PoBBubQ0EvG+Zx1OsFAdyXFUZ4+MfviVFcnyr7FNPcIlKXqrv1sNvOfuR/gfQFAmaFOfAr3o+1LrapvwgK6sTGovqhQShy6In3+rljUzs68X9sbuLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533931; c=relaxed/simple;
	bh=T9D3cGgcxtYMyyLnoDUEBXT7ruYRk1BAyF+UAcLllOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mZceYnFAvlauwZIPTAjg7ISy7pIf+Y5mDWAmr0eBb3fTsv4kRiSe94YQjquZvRXPaTiYucdv5oBK7QAz4FvD8bWhMkE4kDNqApDeTb31TeO/HLg9KmBto9LV/d/3afh9t2hQ9UQv4CylaFJwIGCTQZnTjuAt4eLdpt20dEAuilo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=VtiJ6m6k; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1751533921;
	bh=Yzx7aAbdQUagiD5CS7GG4YC5/qNGZo6dHJRsflbibW8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VtiJ6m6kzHW8ajBYoLFGqLxvc66uXWoJhs7AjARyIcP0UOxhm/H9Xa/C6DzyMwsMa
	 pkSTWvcQCvQdwC11CRBHyvoPDeAOsbI/UUSh/mFzE6MLFVIFQP42kzQy+4kcQlu1OG
	 /pRdnjX+pROGtpzoek0pMRbu8ai8XIeV+IZYx7o961UMjxnfoxXiIkBSnJ8xeqj2zo
	 cyJ5iZs+UPjIlUjHgI/xuuWt10+p+FBmR9u+XMwcscz6V1Z+oxktUKw3OnUj1UGppd
	 3QPwc97nkEYx/NGSJpJkGAK0o2hXDfICZu7hoqYI+vUStzjzKTKbgho9M1gMOZxcgz
	 gI5bLdhxztKng==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id AE0776A8E5; Thu,  3 Jul 2025 17:12:01 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
Date: Thu, 03 Jul 2025 17:11:48 +0800
Subject: [PATCH net-next 1/7] net: mctp: Prevent duplicate binds
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-mctp-bind-v1-1-bb7e97c24613@codeconstruct.com.au>
References: <20250703-mctp-bind-v1-0-bb7e97c24613@codeconstruct.com.au>
In-Reply-To: <20250703-mctp-bind-v1-0-bb7e97c24613@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>
X-Mailer: b4 0.15-dev-cbbb4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751533920; l=1996;
 i=matt@codeconstruct.com.au; s=20241018; h=from:subject:message-id;
 bh=T9D3cGgcxtYMyyLnoDUEBXT7ruYRk1BAyF+UAcLllOo=;
 b=FmGCcPFWhj964l+ukeMMo4Jrs4xgMjjpVVZaeahym5Io7Q3V46yrrNPxfnECxh3EYndRFUPPL
 ZrK2kqlXbThDsiLSs3CFenXXJY95A7N1bAC/Z5SHy+zDLp70lKeNUNj
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
 net/mctp/af_mctp.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index 9b12ca97f412827c350fe7a03b7a6d365df74826..72ab8449ebfc68f6b7a9954cbf13a7be00543358 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -73,7 +73,6 @@ static int mctp_bind(struct socket *sock, struct sockaddr *addr, int addrlen)
 
 	lock_sock(sk);
 
-	/* TODO: allow rebind */
 	if (sk_hashed(sk)) {
 		rc = -EADDRINUSE;
 		goto out_release;
@@ -629,15 +628,35 @@ static void mctp_sk_close(struct sock *sk, long timeout)
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
+		struct mctp_sock *mex = container_of(existing, struct mctp_sock, sk);
+
+		if (mex->bind_type == msk->bind_type &&
+		    mex->bind_addr == msk->bind_addr &&
+			mex->bind_net == msk->bind_net) {
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


