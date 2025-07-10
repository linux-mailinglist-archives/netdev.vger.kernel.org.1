Return-Path: <netdev+bounces-205714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E74AFFD05
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 10:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 875BC3AE93D
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 08:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1A1292B2F;
	Thu, 10 Jul 2025 08:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="j5z6YJqu"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A343B2918F0
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 08:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137776; cv=none; b=kI1QqRxP+9gLqisO/D+B7fy3SQ8rvpQBcy159tKRPz/Jx9CqF3euH/IBootDHIxi3xxAl068lMYvvEhWd56o3cw6VmIHECuCQdO4bZZcOUE6uEURU1RHNyVCyj/UBygH53nm+we/39k4YgsUkFZ7ce5MZqSN4utbsNgeIzeK0pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137776; c=relaxed/simple;
	bh=T+HFA9g8VXxrJq3B7GU3Ec4uQ1aV1Uh/sFdG+UqwTEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lDGMOLsI73Rjubng+vlLfAFXBXVzxROzqYy1aSmDuOEPZczHpKR+c8uE4HsHmK0BKFG7QpGBE2z67JBRYcWLasE1ID6ggz+hLAqwYK5ht9YSc9sNm6bJ9yTZhYOx/XZw9M06XXFJ7ptH6cQ6uKpZKbajyu53/xBznheLhUmyyfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=j5z6YJqu; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1752137764;
	bh=4AvVg0CRmyVrIOlC6it+JQYC82VtRZwn+Kme2dzFgfA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=j5z6YJqux5kNPh94JzgL9kY1VSeI+NtGMPy29j0tW00uJ/zBuLLyDrKxFECorvnmS
	 5iq2w26a4u68rrZEvdoOEWSuPmTseERF86BliQdifRyja2z683qRoelbPFgO1j3QcS
	 xCPft+A5IBPMK5s3ZZx1ccxTxwZmNsIggBGCA6QKgp69bHttpHCQlfsQXRnkDK9JFb
	 ysmSPS9YJ1hWkJR3wClpAcAaDnEEDcla8PY8LR6K6bBoJkPIh3OeLyOeNpqXlN9LiD
	 dpVGZmsqEDA+eDi+INonxxPg7M/n7FscVgxBgR28p0/R2gjPw0CT0FQIVfkNAACrTg
	 Pb/WLWiteNMZg==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id 51ED66B247; Thu, 10 Jul 2025 16:56:04 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
Date: Thu, 10 Jul 2025 16:55:59 +0800
Subject: [PATCH net-next v4 6/8] net: mctp: Allow limiting binds to a peer
 address
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-mctp-bind-v4-6-8ec2f6460c56@codeconstruct.com.au>
References: <20250710-mctp-bind-v4-0-8ec2f6460c56@codeconstruct.com.au>
In-Reply-To: <20250710-mctp-bind-v4-0-8ec2f6460c56@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>
X-Mailer: b4 0.15-dev-cbbb4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752137761; l=6742;
 i=matt@codeconstruct.com.au; s=20241018; h=from:subject:message-id;
 bh=T+HFA9g8VXxrJq3B7GU3Ec4uQ1aV1Uh/sFdG+UqwTEw=;
 b=VeDb1Yu9A5G97xwv6RA8FI3u2huKFkPYrJZ04eTsRi6x97yuHTDxqSeLBqtnHETbNcWvA0F4K
 IR5RlOq3wliBG0iwKQ0WdZvDj/j42CWQtw/fLvM0lfLqxvjDe6XLaUO
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
v4:
- Fix socket release on error paths
---
 include/net/mctp.h |   5 ++-
 net/mctp/af_mctp.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 net/mctp/route.c   |   6 ++-
 3 files changed, 108 insertions(+), 8 deletions(-)

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
index 16341de5cf2893bbc04a8c05a038c30be6570296..df4e8cf33899befeffc82044b68a70b38f3a9b74 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -79,7 +79,7 @@ static int mctp_bind(struct socket *sock, struct sockaddr *addr, int addrlen)
 		goto out_release;
 	}
 
-	msk->bind_addr = smctp->smctp_addr.s_addr;
+	msk->bind_local_addr = smctp->smctp_addr.s_addr;
 
 	/* MCTP_NET_ANY with a specific EID is resolved to the default net
 	 * at bind() time.
@@ -87,13 +87,35 @@ static int mctp_bind(struct socket *sock, struct sockaddr *addr, int addrlen)
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
+			rc = -EINVAL;
+			goto out_release;
+		}
+
+		if (msk->bind_net == MCTP_NET_ANY) {
+			/* Restrict to the network passed to connect() */
+			msk->bind_net = msk->bind_peer_net;
+		}
+
+		if (msk->bind_net != msk->bind_peer_net) {
+			/* connect() had a different net to bind() */
+			rc = -EINVAL;
+			goto out_release;
+		}
+	} else {
+		msk->bind_type = smctp->smctp_type;
+	}
 
 	rc = sk->sk_prot->hash(sk);
 
@@ -103,6 +125,67 @@ static int mctp_bind(struct socket *sock, struct sockaddr *addr, int addrlen)
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
@@ -546,7 +629,7 @@ static const struct proto_ops mctp_dgram_ops = {
 	.family		= PF_MCTP,
 	.release	= mctp_release,
 	.bind		= mctp_bind,
-	.connect	= sock_no_connect,
+	.connect	= mctp_connect,
 	.socketpair	= sock_no_socketpair,
 	.accept		= sock_no_accept,
 	.getname	= sock_no_getname,
@@ -613,6 +696,7 @@ static int mctp_sk_init(struct sock *sk)
 
 	INIT_HLIST_HEAD(&msk->keys);
 	timer_setup(&msk->key_expiry, mctp_sk_expire_keys, 0);
+	msk->bind_peer_set = false;
 	return 0;
 }
 
@@ -626,12 +710,17 @@ static int mctp_sk_hash(struct sock *sk)
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
 
@@ -640,8 +729,12 @@ static int mctp_sk_hash(struct sock *sk)
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


