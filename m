Return-Path: <netdev+bounces-205303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2C7AFE2A6
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 10:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC95C1C42AD9
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 08:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C4027510B;
	Wed,  9 Jul 2025 08:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="KYoKPf8m"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D09223C8CE
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 08:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752049889; cv=none; b=iJKdg1blBgX5s9OwdKtML2pOxv7d3/Dah29RtryZiTJ9ag4Fl/T7xPQU5JD9K0is7BTBWWC6DWiqK/xS63g3D4HWxV4K1c0OJ+ec9p94uCU+VJnrvq1jrGZ3lNOVKn93jdMHAdMVk4n3KCNo/cDfHUkkHFdzqccq8+OTcm4py6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752049889; c=relaxed/simple;
	bh=P6hr7WhgZPpd5Zbg2h2gV8CLmhk9rX3kiW+ZHYh+qVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jb1Z3W521khQpOv7zL1+el6SQ72GxySzh0mdwTUjpG8gcQUQ8xlLwYDYR7tUAknDKSzEQ1UnWS1HUNB2vU8buAzKD0Unj+gv2kPxGZZn1rCXFsSck2xLWYWZ9OXnqhOjmcZCXRMb8E8asPBh2grGdXRGJAd0JPC2emlGezxjFb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=KYoKPf8m; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1752049880;
	bh=1jUDZcHg2ZFpOuhDAzQoZx2ZNn4rLiOhJeFEvhT9SWo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KYoKPf8mbYh0bx8I5a+e1RQEJoMJez/5X0I/p8im9Jmh4Los0KSSgsroYWGEyLkgS
	 zjAi11Uza0RYY7opWouvX6zoECrzqzKlt3L+HyhrZ1cm6LPdLvhazy01kBy5r0Pm81
	 nchXasKFPtwfhxiekHxgfPlFIKANF/LTeVU+VrhXPb7DSslkIFgmZYxe0P/s2mUHI1
	 o8L7U7rjOngMl5WlRBlhp8MbjXW19ZywRnP0fxT4c3+F0mjm2wQWI2r4LzywkwtL2c
	 khdx8VwmX3lTyNuxMMPVJZX8LHQWPzsvtZarPLfkRXECM0muc6eqoseI04RJTlaeuY
	 13sudT3sfB94Q==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id 258176B161; Wed,  9 Jul 2025 16:31:20 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
Date: Wed, 09 Jul 2025 16:31:03 +0800
Subject: [PATCH net-next v3 2/8] net: mctp: Prevent duplicate binds
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-mctp-bind-v3-2-eac98bbf5e95@codeconstruct.com.au>
References: <20250709-mctp-bind-v3-0-eac98bbf5e95@codeconstruct.com.au>
In-Reply-To: <20250709-mctp-bind-v3-0-eac98bbf5e95@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>
X-Mailer: b4 0.15-dev-cbbb4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752049878; l=2005;
 i=matt@codeconstruct.com.au; s=20241018; h=from:subject:message-id;
 bh=P6hr7WhgZPpd5Zbg2h2gV8CLmhk9rX3kiW+ZHYh+qVM=;
 b=xUXLbdPQxIm6ca7LtqNQwQzAbxepqgrUMlX5nqYg2vu9yrHDg7pCOud6Qkrg/xjz97gbiMil1
 /r4wvlVerhICy0VWt6nyXNy4qPlIJF3p/4SEOO46+C3sDlOUwseH0z4
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


