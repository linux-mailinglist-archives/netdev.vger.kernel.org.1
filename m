Return-Path: <netdev+bounces-205309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6AFAFE2A9
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 10:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A1AD582350
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 08:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D85F2797B5;
	Wed,  9 Jul 2025 08:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="fqlNCNqI"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C7927815C
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 08:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752049893; cv=none; b=qs+U47ZcB21L+GlWy7jF4YeqYtHWUURHsB4Bf1UgAKQGCrWECtcaIrOKv4HroWrDgM68tZFtm+QuuCqOJKNSgp9Hn9w6mn1XNop3+dhH0eVIrfthGTsMWmRuWTiqb5DWy4GCKVJiW9o2Za6KNf36GwGnGkTeSFNF4oXQQpJKlQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752049893; c=relaxed/simple;
	bh=qbUPpbuAtXKWNztb7goL/LKDpu8M6GCMk7MYtw3/cs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h/y6EoffER5YLojeFySrcWRWn2cQq9aY7gw34DgDyiNmUgwlaYbo6Wg+XN10Y+TinqgfBVnaob2VJ2pCPLZzuMEgAZD54auP5mwZyNiY2fN1aTZpJ0nwreOLqnFVEsMXLUerQWt3Cy9IHQxqRy4yhHz317v5Js8PKwFLbL1Zu/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=fqlNCNqI; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1752049881;
	bh=6+aQwJOPUBabKXZ43RleR7ZQ6kRzRgYz4xsnT0pAD4A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fqlNCNqIdnbj+8oSV4CJcdKO3KWOm39OLqWMHDg2OEgb3Oz1xQKED3kX3Q3QJL1Ra
	 lQdydPLwhD9q4JiX9CM7u/KGrttiB3IulbWEM9l67Kjyl2/W7VAqP97BxgvV47cFjw
	 QMbYM4CUYBmAFQHFo/A7XWgqPXzYifzGdYY8UsPZS3CkFfjRMZhatJjgTJTemGJxkG
	 yaSMIqC4OII2vx8X7saiAWskONpFiPQeuSnRP3QAwHu5FaoRc8mmX6uhP9HFeHxmCu
	 hlVAX4kIO3nJOu82kMBNe7PobZpN18g3lF2UWJwENKai30IPI+4Unz+WryXznp03+6
	 EhP5pYoYEgO/g==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id A2B9A6B16A; Wed,  9 Jul 2025 16:31:21 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
Date: Wed, 09 Jul 2025 16:31:07 +0800
Subject: [PATCH net-next v3 6/8] net: mctp: Allow limiting binds to a peer
 address
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-mctp-bind-v3-6-eac98bbf5e95@codeconstruct.com.au>
References: <20250709-mctp-bind-v3-0-eac98bbf5e95@codeconstruct.com.au>
In-Reply-To: <20250709-mctp-bind-v3-0-eac98bbf5e95@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>
X-Mailer: b4 0.15-dev-cbbb4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752049878; l=6652;
 i=matt@codeconstruct.com.au; s=20241018; h=from:subject:message-id;
 bh=qbUPpbuAtXKWNztb7goL/LKDpu8M6GCMk7MYtw3/cs4=;
 b=c/zSfYtaOHbpnBtyh3KdlDEkUi8KJqzvHItwkWZgxqOpk+d4yPWGxiHOoAZcYhGZ13RAAwIYI
 2wcB9/pJuPvC5O1Oor+g87b+fqKJz/BGhkVKFan2ybaIn+qP49A7O3w
X-Developer-Key: i=matt@codeconstruct.com.au; a=ed25519;
 pk=exersTcCYD/pEBOzXGO6HkLd6kKXRuWxHhj+LXn3DYE=

Prior to calling bind() a program may call connect() on a socket to
restrict to a remote peer address.

Using connect() is the normal mechanism to specify a remote network
peer, so we use that here. In MCTP connect() is only used for bound
sockets - send() is not available for MCTP since a tag must be provided
for each message.

The smctp_type must match between connect() and bind() calls.

Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
---
 include/net/mctp.h |   5 ++-
 net/mctp/af_mctp.c | 103 +++++++++++++++++++++++++++++++++++++++++++++++++----
 net/mctp/route.c   |   6 +++-
 3 files changed, 106 insertions(+), 8 deletions(-)

diff --git a/include/net/mctp.h b/include/net/mctp.h
index ac4f4ecdfc24f1f481ff22a5673cb95e1bf21310..c3207ce98f07fcbb436e968d503bc45666794fdc 100644
--- a/include/net/mctp.h
+++ b/include/net/mctp.h
@@ -69,7 +69,10 @@ struct mctp_sock {
 
 	/* bind() params */
 	unsigned int	bind_net;
-	mctp_eid_t	bind_addr;
+	mctp_eid_t	bind_local_addr;
+	mctp_eid_t	bind_peer_addr;
+	unsigned int	bind_peer_net;
+	bool		bind_peer_set;
 	__u8		bind_type;
 
 	/* sendmsg()/recvmsg() uses struct sockaddr_mctp_ext */
diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index 16341de5cf2893bbc04a8c05a038c30be6570296..79f3c53afebe4aafc14b710d8af2582e662b2df8 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -79,7 +79,7 @@ static int mctp_bind(struct socket *sock, struct sockaddr *addr, int addrlen)
 		goto out_release;
 	}
 
-	msk->bind_addr = smctp->smctp_addr.s_addr;
+	msk->bind_local_addr = smctp->smctp_addr.s_addr;
 
 	/* MCTP_NET_ANY with a specific EID is resolved to the default net
 	 * at bind() time.
@@ -87,13 +87,33 @@ static int mctp_bind(struct socket *sock, struct sockaddr *addr, int addrlen)
 	 * lookup time.
 	 */
 	if (smctp->smctp_network == MCTP_NET_ANY &&
-	    msk->bind_addr != MCTP_ADDR_ANY) {
+	    msk->bind_local_addr != MCTP_ADDR_ANY) {
 		msk->bind_net = mctp_default_net(net);
 	} else {
 		msk->bind_net = smctp->smctp_network;
 	}
 
-	msk->bind_type = smctp->smctp_type & 0x7f; /* ignore the IC bit */
+	/* ignore the IC bit */
+	smctp->smctp_type &= 0x7f;
+
+	if (msk->bind_peer_set) {
+		if (msk->bind_type != smctp->smctp_type) {
+			/* Prior connect() had a different type */
+			return -EINVAL;
+		}
+
+		if (msk->bind_net == MCTP_NET_ANY) {
+			/* Restrict to the network passed to connect() */
+			msk->bind_net = msk->bind_peer_net;
+		}
+
+		if (msk->bind_net != msk->bind_peer_net) {
+			/* connect() had a different net to bind() */
+			return -EINVAL;
+		}
+	} else {
+		msk->bind_type = smctp->smctp_type;
+	}
 
 	rc = sk->sk_prot->hash(sk);
 
@@ -103,6 +123,67 @@ static int mctp_bind(struct socket *sock, struct sockaddr *addr, int addrlen)
 	return rc;
 }
 
+/* Used to set a specific peer prior to bind. Not used for outbound
+ * connections (Tag Owner set) since MCTP is a datagram protocol.
+ */
+static int mctp_connect(struct socket *sock, struct sockaddr *addr,
+			int addrlen, int flags)
+{
+	struct sock *sk = sock->sk;
+	struct mctp_sock *msk = container_of(sk, struct mctp_sock, sk);
+	struct net *net = sock_net(&msk->sk);
+	struct sockaddr_mctp *smctp;
+	int rc;
+
+	if (addrlen != sizeof(*smctp))
+		return -EINVAL;
+
+	if (addr->sa_family != AF_MCTP)
+		return -EAFNOSUPPORT;
+
+	/* It's a valid sockaddr for MCTP, cast and do protocol checks */
+	smctp = (struct sockaddr_mctp *)addr;
+
+	if (!mctp_sockaddr_is_ok(smctp))
+		return -EINVAL;
+
+	/* Can't bind by tag */
+	if (smctp->smctp_tag)
+		return -EINVAL;
+
+	/* IC bit must be unset */
+	if (smctp->smctp_type & 0x80)
+		return -EINVAL;
+
+	lock_sock(sk);
+
+	if (sk_hashed(sk)) {
+		/* bind() already */
+		rc = -EADDRINUSE;
+		goto out_release;
+	}
+
+	if (msk->bind_peer_set) {
+		/* connect() already */
+		rc = -EADDRINUSE;
+		goto out_release;
+	}
+
+	msk->bind_peer_set = true;
+	msk->bind_peer_addr = smctp->smctp_addr.s_addr;
+	msk->bind_type = smctp->smctp_type;
+	if (smctp->smctp_network == MCTP_NET_ANY)
+		msk->bind_peer_net = mctp_default_net(net);
+	else
+		msk->bind_peer_net = smctp->smctp_network;
+
+	rc = 0;
+
+out_release:
+	release_sock(sk);
+	return rc;
+}
+
 static int mctp_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 {
 	DECLARE_SOCKADDR(struct sockaddr_mctp *, addr, msg->msg_name);
@@ -546,7 +627,7 @@ static const struct proto_ops mctp_dgram_ops = {
 	.family		= PF_MCTP,
 	.release	= mctp_release,
 	.bind		= mctp_bind,
-	.connect	= sock_no_connect,
+	.connect	= mctp_connect,
 	.socketpair	= sock_no_socketpair,
 	.accept		= sock_no_accept,
 	.getname	= sock_no_getname,
@@ -613,6 +694,7 @@ static int mctp_sk_init(struct sock *sk)
 
 	INIT_HLIST_HEAD(&msk->keys);
 	timer_setup(&msk->key_expiry, mctp_sk_expire_keys, 0);
+	msk->bind_peer_set = false;
 	return 0;
 }
 
@@ -626,12 +708,17 @@ static int mctp_sk_hash(struct sock *sk)
 	struct net *net = sock_net(sk);
 	struct sock *existing;
 	struct mctp_sock *msk;
+	mctp_eid_t remote;
 	u32 hash;
 	int rc;
 
 	msk = container_of(sk, struct mctp_sock, sk);
 
-	hash = mctp_bind_hash(msk->bind_type, msk->bind_addr, MCTP_ADDR_ANY);
+	if (msk->bind_peer_set)
+		remote = msk->bind_peer_addr;
+	else
+		remote = MCTP_ADDR_ANY;
+	hash = mctp_bind_hash(msk->bind_type, msk->bind_local_addr, remote);
 
 	mutex_lock(&net->mctp.bind_lock);
 
@@ -640,8 +727,12 @@ static int mctp_sk_hash(struct sock *sk)
 		struct mctp_sock *mex =
 			container_of(existing, struct mctp_sock, sk);
 
+		bool same_peer = (mex->bind_peer_set && msk->bind_peer_set &&
+				  mex->bind_peer_addr == msk->bind_peer_addr) ||
+				 (!mex->bind_peer_set && !msk->bind_peer_set);
+
 		if (mex->bind_type == msk->bind_type &&
-		    mex->bind_addr == msk->bind_addr &&
+		    mex->bind_local_addr == msk->bind_local_addr && same_peer &&
 		    mex->bind_net == msk->bind_net) {
 			rc = -EADDRINUSE;
 			goto out;
diff --git a/net/mctp/route.c b/net/mctp/route.c
index 69cfb0e6c545c2b44e5defdfac4e602c4f0265b1..2b2b958ef6a37525cc4d3f6a5758bd3880c98e6c 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -65,7 +65,11 @@ static struct mctp_sock *mctp_lookup_bind_details(struct net *net,
 		if (msk->bind_type != type)
 			continue;
 
-		if (!mctp_address_matches(msk->bind_addr, dest))
+		if (msk->bind_peer_set &&
+		    !mctp_address_matches(msk->bind_peer_addr, src))
+			continue;
+
+		if (!mctp_address_matches(msk->bind_local_addr, dest))
 			continue;
 
 		return msk;

-- 
2.43.0


