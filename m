Return-Path: <netdev+bounces-205307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 277B7AFE2AB
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 10:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C8CF3AA34A
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 08:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8C7273D8F;
	Wed,  9 Jul 2025 08:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="BXmJ9QM6"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2189C277C9E
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 08:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752049892; cv=none; b=sqPKtR7Fl4zKfQ9O6sLZ6oee/iZBtwOUy0+PQVd/JfAlDud7vOtpIfVZa5sg/jFFGWUSEcGPoimRhZW1JgVBryNgaVz2OM5/FnckvSFW4CO4GcZx7L8MKnUC8ZN0KalS7subSW431U2rhoCsKUSqUu1Svo3AJpxh2tBMaxdM24Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752049892; c=relaxed/simple;
	bh=ippW102rNZbVxwH3Tdr+dT3cgpv5fom/bzDy2F/521c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b08DdJLcCANPTCyaKG6XwdgfJ48CGfVq8FzR5ri1lsVtX/nd7WcZCMf8sPXQjQfeUO7YKr+u8BsWiN+cf+fIcB6cfj6uE8sTh/L7iStJtlyQVEojs2rFQDpOeLoKeAusNOk0FdUQbpFDkMxDkEm/wP00t4VwxlIXFbs2GbrrwvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=BXmJ9QM6; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1752049881;
	bh=JTA3uiLWUPZtwcXglguGEmGlXJxjJJsQSxYhFgUcVlk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BXmJ9QM6L20AKRE/jreWl8ucf6sgK55R/G3nm7wGSTxF2KZ3O6W3lB8G8JclwSRO1
	 4gRZDwKicZz0M1w6cUc0wVsCmzstu/YqpL+nfBY0j7nQ1qVHDDP51vFvTSJYCWW2Wk
	 IQhVkB1O3axwQWDWFdZz3IjgfWD30AQTnAhw1zdZQtL5i0VSkATvwkxOlYVvLTl7+4
	 OjqLuY0vM+fKw3MKMrdEEaBqXg5FGprhgnAJQFsaW487hnNKF9CAqkLYLt+t4iDau1
	 6PZQQhQ2M+RdHIZxPKoZfpb0hqcVgOFOvuGurRYmuzTmaakwJBJQ1eE23f2d7ph6Hp
	 t/zKvfr05y1Kw==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id 4A3B66B169; Wed,  9 Jul 2025 16:31:21 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
Date: Wed, 09 Jul 2025 16:31:06 +0800
Subject: [PATCH net-next v3 5/8] net: mctp: Use hashtable for binds
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-mctp-bind-v3-5-eac98bbf5e95@codeconstruct.com.au>
References: <20250709-mctp-bind-v3-0-eac98bbf5e95@codeconstruct.com.au>
In-Reply-To: <20250709-mctp-bind-v3-0-eac98bbf5e95@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>
X-Mailer: b4 0.15-dev-cbbb4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752049878; l=6492;
 i=matt@codeconstruct.com.au; s=20241018; h=from:subject:message-id;
 bh=ippW102rNZbVxwH3Tdr+dT3cgpv5fom/bzDy2F/521c=;
 b=6EEKsDwP2WWmMcN3PaHPKj4MSb7mhqTtLXwrrJJ11nGTgAzw3E5P7uAYVRFdvvx2YqkRnz8gC
 CfwNbLf/CU3Ay7Jp5yy175wh36k1+Ba08Iz59yyWqAONsokIsyld1Sa
X-Developer-Key: i=matt@codeconstruct.com.au; a=ed25519;
 pk=exersTcCYD/pEBOzXGO6HkLd6kKXRuWxHhj+LXn3DYE=

Ensure that a specific EID (remote or local) bind will match in
preference to a MCTP_ADDR_ANY bind.

This adds infrastructure for binding a socket to receive messages from a
specific remote peer address, a future commit will expose an API for
this.

Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>

---
v2:
- Use DECLARE_HASHTABLE
- Fix long lines
---
 include/net/netns/mctp.h | 20 +++++++++---
 net/mctp/af_mctp.c       | 11 ++++---
 net/mctp/route.c         | 81 ++++++++++++++++++++++++++++++++++++++----------
 3 files changed, 87 insertions(+), 25 deletions(-)

diff --git a/include/net/netns/mctp.h b/include/net/netns/mctp.h
index 1db8f9aaddb4b96f4803df9f30a762f5f88d7f7f..89555f90b97b297e50a571b26c5232b824909da7 100644
--- a/include/net/netns/mctp.h
+++ b/include/net/netns/mctp.h
@@ -6,19 +6,25 @@
 #ifndef __NETNS_MCTP_H__
 #define __NETNS_MCTP_H__
 
+#include <linux/hash.h>
+#include <linux/hashtable.h>
 #include <linux/mutex.h>
 #include <linux/types.h>
 
+#define MCTP_BINDS_BITS 7
+
 struct netns_mctp {
 	/* Only updated under RTNL, entries freed via RCU */
 	struct list_head routes;
 
-	/* Bound sockets: list of sockets bound by type.
-	 * This list is updated from non-atomic contexts (under bind_lock),
-	 * and read (under rcu) in packet rx
+	/* Bound sockets: hash table of sockets, keyed by
+	 * (type, src_eid, dest_eid).
+	 * Specific src_eid/dest_eid entries also have an entry for
+	 * MCTP_ADDR_ANY. This list is updated from non-atomic contexts
+	 * (under bind_lock), and read (under rcu) in packet rx.
 	 */
 	struct mutex bind_lock;
-	struct hlist_head binds;
+	DECLARE_HASHTABLE(binds, MCTP_BINDS_BITS);
 
 	/* tag allocations. This list is read and updated from atomic contexts,
 	 * but elements are free()ed after a RCU grace-period
@@ -34,4 +40,10 @@ struct netns_mctp {
 	struct list_head neighbours;
 };
 
+static inline u32 mctp_bind_hash(u8 type, u8 local_addr, u8 peer_addr)
+{
+	return hash_32(type | (u32)local_addr << 8 | (u32)peer_addr << 16,
+		       MCTP_BINDS_BITS);
+}
+
 #endif /* __NETNS_MCTP_H__ */
diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index 20edaf840a607700c04b740708763fbd02a2df47..16341de5cf2893bbc04a8c05a038c30be6570296 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -626,17 +626,17 @@ static int mctp_sk_hash(struct sock *sk)
 	struct net *net = sock_net(sk);
 	struct sock *existing;
 	struct mctp_sock *msk;
+	u32 hash;
 	int rc;
 
 	msk = container_of(sk, struct mctp_sock, sk);
 
-	/* Bind lookup runs under RCU, remain live during that. */
-	sock_set_flag(sk, SOCK_RCU_FREE);
+	hash = mctp_bind_hash(msk->bind_type, msk->bind_addr, MCTP_ADDR_ANY);
 
 	mutex_lock(&net->mctp.bind_lock);
 
 	/* Prevent duplicate binds. */
-	sk_for_each(existing, &net->mctp.binds) {
+	sk_for_each(existing, &net->mctp.binds[hash]) {
 		struct mctp_sock *mex =
 			container_of(existing, struct mctp_sock, sk);
 
@@ -648,7 +648,10 @@ static int mctp_sk_hash(struct sock *sk)
 		}
 	}
 
-	sk_add_node_rcu(sk, &net->mctp.binds);
+	/* Bind lookup runs under RCU, remain live during that. */
+	sock_set_flag(sk, SOCK_RCU_FREE);
+
+	sk_add_node_rcu(sk, &net->mctp.binds[hash]);
 	rc = 0;
 
 out:
diff --git a/net/mctp/route.c b/net/mctp/route.c
index a20d6b11d4186b55cab9d76e367169ea712553c7..69cfb0e6c545c2b44e5defdfac4e602c4f0265b1 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -40,14 +40,45 @@ static int mctp_dst_discard(struct mctp_dst *dst, struct sk_buff *skb)
 	return 0;
 }
 
-static struct mctp_sock *mctp_lookup_bind(struct net *net, struct sk_buff *skb)
+static struct mctp_sock *mctp_lookup_bind_details(struct net *net,
+						  struct sk_buff *skb,
+						  u8 type, u8 dest,
+						  u8 src, bool allow_net_any)
 {
 	struct mctp_skb_cb *cb = mctp_cb(skb);
-	struct mctp_hdr *mh;
 	struct sock *sk;
-	u8 type;
+	u8 hash;
 
-	WARN_ON(!rcu_read_lock_held());
+	WARN_ON_ONCE(!rcu_read_lock_held());
+
+	hash = mctp_bind_hash(type, dest, src);
+
+	sk_for_each_rcu(sk, &net->mctp.binds[hash]) {
+		struct mctp_sock *msk = container_of(sk, struct mctp_sock, sk);
+
+		if (!allow_net_any && msk->bind_net == MCTP_NET_ANY)
+			continue;
+
+		if (msk->bind_net != MCTP_NET_ANY && msk->bind_net != cb->net)
+			continue;
+
+		if (msk->bind_type != type)
+			continue;
+
+		if (!mctp_address_matches(msk->bind_addr, dest))
+			continue;
+
+		return msk;
+	}
+
+	return NULL;
+}
+
+static struct mctp_sock *mctp_lookup_bind(struct net *net, struct sk_buff *skb)
+{
+	struct mctp_sock *msk;
+	struct mctp_hdr *mh;
+	u8 type;
 
 	/* TODO: look up in skb->cb? */
 	mh = mctp_hdr(skb);
@@ -57,20 +88,36 @@ static struct mctp_sock *mctp_lookup_bind(struct net *net, struct sk_buff *skb)
 
 	type = (*(u8 *)skb->data) & 0x7f;
 
-	sk_for_each_rcu(sk, &net->mctp.binds) {
-		struct mctp_sock *msk = container_of(sk, struct mctp_sock, sk);
-
-		if (msk->bind_net != MCTP_NET_ANY && msk->bind_net != cb->net)
-			continue;
-
-		if (msk->bind_type != type)
-			continue;
-
-		if (!mctp_address_matches(msk->bind_addr, mh->dest))
-			continue;
+	/* Look for binds in order of widening scope. A given destination or
+	 * source address also implies matching on a particular network.
+	 *
+	 * - Matching destination and source
+	 * - Matching destination
+	 * - Matching source
+	 * - Matching network, any address
+	 * - Any network or address
+	 */
 
+	msk = mctp_lookup_bind_details(net, skb, type, mh->dest, mh->src,
+				       false);
+	if (msk)
+		return msk;
+	msk = mctp_lookup_bind_details(net, skb, type, MCTP_ADDR_ANY, mh->src,
+				       false);
+	if (msk)
+		return msk;
+	msk = mctp_lookup_bind_details(net, skb, type, mh->dest, MCTP_ADDR_ANY,
+				       false);
+	if (msk)
+		return msk;
+	msk = mctp_lookup_bind_details(net, skb, type, MCTP_ADDR_ANY,
+				       MCTP_ADDR_ANY, false);
+	if (msk)
+		return msk;
+	msk = mctp_lookup_bind_details(net, skb, type, MCTP_ADDR_ANY,
+				       MCTP_ADDR_ANY, true);
+	if (msk)
 		return msk;
-	}
 
 	return NULL;
 }
@@ -1671,7 +1718,7 @@ static int __net_init mctp_routes_net_init(struct net *net)
 	struct netns_mctp *ns = &net->mctp;
 
 	INIT_LIST_HEAD(&ns->routes);
-	INIT_HLIST_HEAD(&ns->binds);
+	hash_init(ns->binds);
 	mutex_init(&ns->bind_lock);
 	INIT_HLIST_HEAD(&ns->keys);
 	spin_lock_init(&ns->keys_lock);

-- 
2.43.0


