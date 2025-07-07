Return-Path: <netdev+bounces-204465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C3FAFAB44
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 07:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41EFA189D72F
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 05:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F159D275853;
	Mon,  7 Jul 2025 05:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="cS+XD1bB"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F57A270574
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 05:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751867728; cv=none; b=rVxLcV1TaM8abgFcsiD33AwJTVe2j13paRCx7PPIiA+rRcoCs34QI65oSrvomuZtZDufjlrLoy9Esg2tG5i41Ot47lS67jPc8zQJfeQLy2/W3wfi8qcGHcS0zn1GqbYhS5613Kl/Xq6cjGjI6b7ow0Xx9bDRtt2NiXd6wErupgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751867728; c=relaxed/simple;
	bh=AXPgzHyC0cNgFqxjL7SgmDUGjqAtPnSTijjTitRez2w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vf36uNkA47RDJwjX9AcWjARn2bcdQVRX9F02xHZgyU1bg34Yb7wCWEspxioGp0yQaD1PQ5IW2Yuyrz5xUu/FN5j+foKmkiJ/s2vUCIyw5tfhWO+N8VYjgGqPmiZEiW2Loq20AeqDhu4rBBhuQ8v4sWVXn1/xTs7+eDyk12qbHL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=cS+XD1bB; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1751867718;
	bh=Mo0WLg3ezFpcbfGtnDmEBUlMGaryaOaSyC3rCW+QCkI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cS+XD1bBqTOpRQHqHl5QqoShBrf7ur2STSTiJVHtNaVqfBF3SSm+UbTjMDhn1jYys
	 cJZPAvIo65Tbyd+TX4FhDc71XFhYCgqydl1o81PARari79tnB3RZeb26JUzAKpLywm
	 pvflXNfSXNPfEJgAlNz7QP9RNQPzDrVNZuO+cYK0DvXtiGxj2x7S0cUDkEOCaAsl8D
	 i9vuGfSxvN1drW5i+mXG4gqoW/HCq8R4Xdli3kJs18MFP3WfyD+SAS4Bpnkcplfg1h
	 zOVQeVPw7+ZxTCnDwd0jw3pFwN8kHV5eyf1UIwxXZhhsLCUb7TvPcXpjvHEIHTrraY
	 ystyoBaIbPIBQ==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id 913E86AC84; Mon,  7 Jul 2025 13:55:18 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
Date: Mon, 07 Jul 2025 13:55:14 +0800
Subject: [PATCH net-next v2 1/7] net: mctp: Prevent duplicate binds
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-mctp-bind-v2-1-fbaed8c1fb4d@codeconstruct.com.au>
References: <20250707-mctp-bind-v2-0-fbaed8c1fb4d@codeconstruct.com.au>
In-Reply-To: <20250707-mctp-bind-v2-0-fbaed8c1fb4d@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>
X-Mailer: b4 0.15-dev-cbbb4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751867717; l=2005;
 i=matt@codeconstruct.com.au; s=20241018; h=from:subject:message-id;
 bh=AXPgzHyC0cNgFqxjL7SgmDUGjqAtPnSTijjTitRez2w=;
 b=2p6OnLAcRfrhPlBPu+pUTjGQRJZZfyNm8LLdNrK3uXEgHJXp9kUhkPitmv4+2huBoKQd6ReFq
 PY2PkaalfyPA1iBGkGEPs1w5/JiKMB+YB4kYW7+ZfQj+tHoOreQKT0G
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
index 9b12ca97f412827c350fe7a03b7a6d365df74826..9d5db3feedec57d18dd85599058761d3f6277ef0 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -73,7 +73,6 @@ static int mctp_bind(struct socket *sock, struct sockaddr *addr, int addrlen)
 
 	lock_sock(sk);
 
-	/* TODO: allow rebind */
 	if (sk_hashed(sk)) {
 		rc = -EADDRINUSE;
 		goto out_release;
@@ -629,15 +628,36 @@ static void mctp_sk_close(struct sock *sk, long timeout)
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


