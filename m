Return-Path: <netdev+bounces-204464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3052AFAB43
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 07:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B815189D783
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 05:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34D22750FD;
	Mon,  7 Jul 2025 05:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="VyT5cyTZ"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F50C1D7E54
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 05:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751867728; cv=none; b=qUcMiaIdLG5Rs6Ip6ZhcyqEXLfPkgymaKB6jvAuILXfKI+4cAwWJN6FVfiOvTy7BFn6z5r/lb1shsC1mCjPwqZRxndvwz87hdLrMNtGwvjSXK25CNMCQtPsr9ee93y8QMn2fh//L5VfFp5ZiIcDE7cE5yCO7ydzeg73/tukDKkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751867728; c=relaxed/simple;
	bh=uj+MTUqUYOkDwJRXzNWlWgm5TtGItZBAPzxck5afFn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JzeXImzwLWtZmNhLxBX8VvVfpKwSB0K8ErPtib4MsCLXL5p+qBoOWdrUEz0CTUWrJwyZ20ys2J0Ma3QRT+3IzoMw72fljXcuYVycGQgt9SH4yITzugTpw7zTS8E+UYnYbP+8f289eYKgeH2lTnBByi1+fuql0xWcna/2kTfCTS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=VyT5cyTZ; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1751867719;
	bh=Qm5WvPjE6Ah16HuRdaFOQ8/A3GMEcUI/aYZjere7kzo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VyT5cyTZoqbZfccyDibJM6WrgUDweBbT4Y4oQiM0Lwj4LuOxBBgYvBfj9NyZBUwpK
	 zlUxBvlSNDT+o5q43lCxleio+NxhHwlXjqMXVIwBuj8/6wWZ6WPVL5rOSB9UG2FeWJ
	 yRzTHQbIzUA96mXspI6+nvzkq4cyZ5R0Sym4qV/DIxYxqUbva2cNux9Hrjw3p2qe82
	 lz6byOB5RnVYYHC+ax7GFGGwosllDU2sUiJeMvVLUVnwVtJSPmwFinmrnWRLZc3ybP
	 qK5rYnX12OH4GTixo1KNiR8J5UHv/OplkxeJxI/Y9PHTAa8rqhMtolKfGnbBFI+zRU
	 astlFHqma+lww==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id 23ECD6AC87; Mon,  7 Jul 2025 13:55:19 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
Date: Mon, 07 Jul 2025 13:55:15 +0800
Subject: [PATCH net-next v2 2/7] net: mctp: Treat MCTP_NET_ANY specially in
 bind()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-mctp-bind-v2-2-fbaed8c1fb4d@codeconstruct.com.au>
References: <20250707-mctp-bind-v2-0-fbaed8c1fb4d@codeconstruct.com.au>
In-Reply-To: <20250707-mctp-bind-v2-0-fbaed8c1fb4d@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>
X-Mailer: b4 0.15-dev-cbbb4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751867717; l=1794;
 i=matt@codeconstruct.com.au; s=20241018; h=from:subject:message-id;
 bh=uj+MTUqUYOkDwJRXzNWlWgm5TtGItZBAPzxck5afFn4=;
 b=k9fT2snXCQWZl2zafrVMR012VzXQxkk/GCkR07ggEUt/XUsc52LDD9WPKhUsB07nNXwjbK7dc
 RxKJRhIrSNMD2/xAa9F18tkcKJ4AA5Lqd63hD0RX3JjuGIrwOPKAXow
X-Developer-Key: i=matt@codeconstruct.com.au; a=ed25519;
 pk=exersTcCYD/pEBOzXGO6HkLd6kKXRuWxHhj+LXn3DYE=

When a specific EID is passed as a bind address, it only makes sense to
interpret with an actual network ID, so resolve that to the default
network at bind time.

For bind address of MCTP_ADDR_ANY, we want to be able to capture traffic
to any network and address, so keep the current behaviour of matching
traffic from any network interface (don't interpret MCTP_NET_ANY as
the default network ID).

Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
---
 net/mctp/af_mctp.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index 9d5db3feedec57d18dd85599058761d3f6277ef0..4f456b1c82d182ac2c64acebb0e603726826a7e7 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -53,6 +53,7 @@ static int mctp_bind(struct socket *sock, struct sockaddr *addr, int addrlen)
 {
 	struct sock *sk = sock->sk;
 	struct mctp_sock *msk = container_of(sk, struct mctp_sock, sk);
+	struct net *net = sock_net(&msk->sk);
 	struct sockaddr_mctp *smctp;
 	int rc;
 
@@ -77,8 +78,21 @@ static int mctp_bind(struct socket *sock, struct sockaddr *addr, int addrlen)
 		rc = -EADDRINUSE;
 		goto out_release;
 	}
-	msk->bind_net = smctp->smctp_network;
+
 	msk->bind_addr = smctp->smctp_addr.s_addr;
+
+	/* MCTP_NET_ANY with a specific EID is resolved to the default net
+	 * at bind() time.
+	 * For bind_addr=MCTP_ADDR_ANY it is handled specially at route
+	 * lookup time.
+	 */
+	if (smctp->smctp_network == MCTP_NET_ANY &&
+	    msk->bind_addr != MCTP_ADDR_ANY) {
+		msk->bind_net = mctp_default_net(net);
+	} else {
+		msk->bind_net = smctp->smctp_network;
+	}
+
 	msk->bind_type = smctp->smctp_type & 0x7f; /* ignore the IC bit */
 
 	rc = sk->sk_prot->hash(sk);

-- 
2.43.0


