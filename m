Return-Path: <netdev+bounces-204469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5593AFAB4B
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 07:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8FD5189D98F
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 05:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDD0279787;
	Mon,  7 Jul 2025 05:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="aNbw6Hoo"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B0127817A
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 05:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751867732; cv=none; b=Rka+Em8rGAH/W0NFs947hEVoniapw/lni45nvAy7woqWRbxGzNJh37R8fu5aJ+yOOofFOBzaAUcvmRXYQWxfX8wDBTxoFlGQjj1RsfEXeKBRDXr6TPafqoZYGrqlorK6ZPLZ0sRIRhFw5QQ5H2YFWPS8RLWLZ4Qnivtt64+HZzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751867732; c=relaxed/simple;
	bh=trE8FJ7bRdnRo6m51zg++UoyMq/KGF7hAcGoXuS9nwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K3MUsY7/GX0yM627d5CjgeoBnbZcLhlMoeSgs6s8E7HHdJzRsx2Ru5ptqBq8miBts4w4WCOxIhIxQt6Awt2p1PBxevQxYHgRuobGxczag9BAcJg2LPSIfWcM21VNc2CQEShQkMejML+gMctgJY+4qGkhj2i8KDzQKo0vC9k578k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=aNbw6Hoo; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1751867720;
	bh=bTuIWqri53r9ZwJOwIqQ30VfjE/j5eNbsJZWxlre7eE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aNbw6HooxCGGfv52CydUOmEhpj/j2XLIuSED8MGpyC+JWDntSkX8UG8VhUd1fWGC9
	 Tg7QVL2gj7gkrVttzcZ0TJKOBUsyiCaAEVyRIx1sj/F7kO7lDt+EH1krUiE7YbSHd3
	 AqhFmy8Qulii875OAbU7FPJCm1ENuHWDB5qCiFM2rvofbpnszLgTCjTl4SDdLghUXh
	 5Trman4BmZifiR6r5IrNlMUKPN2Sgm+uZCGnwUBFihBgPBjSFTY7h4ulRTEMp+hoIH
	 j5AUg1EmFJEoD2CD3BbT8AfLDPKor9jydyaCFEpMs40SpIyLCssOeh3aHe7pPXEK4f
	 nhZmgxMVhulIg==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id 84E146AC8B; Mon,  7 Jul 2025 13:55:20 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
Date: Mon, 07 Jul 2025 13:55:18 +0800
Subject: [PATCH net-next v2 5/7] net: mctp: Allow limiting binds to a peer
 address
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-mctp-bind-v2-5-fbaed8c1fb4d@codeconstruct.com.au>
References: <20250707-mctp-bind-v2-0-fbaed8c1fb4d@codeconstruct.com.au>
In-Reply-To: <20250707-mctp-bind-v2-0-fbaed8c1fb4d@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>
X-Mailer: b4 0.15-dev-cbbb4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751867717; l=6652;
 i=matt@codeconstruct.com.au; s=20241018; h=from:subject:message-id;
 bh=trE8FJ7bRdnRo6m51zg++UoyMq/KGF7hAcGoXuS9nwU=;
 b=Q477x6IyfhzOECITBbXyHbOpjnEk+++l2e9G3lPuLMG0IID0hoJyefVPpkfVJFjHTNpj3QPpe
 zHytru9X3QxBl9qAMBZve0zKd8tQHU6vAfrh0yr2AuTyjNjBWgD9P5Q
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
index 07d458990113d2bc2ca597e40152f3d30e41e5dd..8d3c45bd9cda642af2fc3b3bc403bf36fc8d2990 100644
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
index a07da537bab41005ce643862b23d3050e958a66a..bbac390156406b8b7250267967e13afa486828d0 100644
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
@@ -564,7 +645,7 @@ static const struct proto_ops mctp_dgram_ops = {
 	.family		= PF_MCTP,
 	.release	= mctp_release,
 	.bind		= mctp_bind,
-	.connect	= sock_no_connect,
+	.connect	= mctp_connect,
 	.socketpair	= sock_no_socketpair,
 	.accept		= sock_no_accept,
 	.getname	= sock_no_getname,
@@ -631,6 +712,7 @@ static int mctp_sk_init(struct sock *sk)
 
 	INIT_HLIST_HEAD(&msk->keys);
 	timer_setup(&msk->key_expiry, mctp_sk_expire_keys, 0);
+	msk->bind_peer_set = false;
 	return 0;
 }
 
@@ -644,12 +726,17 @@ static int mctp_sk_hash(struct sock *sk)
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
 
@@ -658,8 +745,12 @@ static int mctp_sk_hash(struct sock *sk)
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
index 815fcb8db3beff338eedbabe6b3f4d44dd238f11..2118b0accbf73e62f5ced62b20d690f7414a0dd3 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -63,7 +63,11 @@ static struct mctp_sock *mctp_lookup_bind_details(struct net *net,
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


