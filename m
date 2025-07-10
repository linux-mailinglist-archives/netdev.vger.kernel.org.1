Return-Path: <netdev+bounces-205711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9FCAFFD06
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 10:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92BFF1C8724A
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 08:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99EC290BBD;
	Thu, 10 Jul 2025 08:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="el/93Z/V"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35B2291C01
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 08:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137775; cv=none; b=gaP211GrMnRZFuz1JChUk84UjTxSuNMOu9Bq1lycICCh6oeTOOlH0o9DzK0pAjoEFC0r+5P0HyHmRZ9G5/59uIP5Dr9iXjGplPItlldPvbNf9KUXFt9dLRSi5C0EQ4uxhlhIadNYuCq5h/wS2nfJ5786XVSE9Fb+mubZhqqiKvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137775; c=relaxed/simple;
	bh=ippW102rNZbVxwH3Tdr+dT3cgpv5fom/bzDy2F/521c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YFAtueGNxk/1ifACD0kAWBIPYzU+Dja8/y8a12OflL76hgOM+52RBU+v7koOXTiGZ8qagviYolsV368c+VRKCBGbaiDNCgDeaThfEw4eygHxkCin82wfUHPh3WqshM+f769cgEp2TV54roB3cOfAY9CyurfUVj3vAVQEEpT5TVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=el/93Z/V; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1752137763;
	bh=JTA3uiLWUPZtwcXglguGEmGlXJxjJJsQSxYhFgUcVlk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=el/93Z/V/LUVbzgzEvXYSk8llSfOYlCxg0phkBwfVZAmYVjXiCnRPS+7ahMnUsVqQ
	 h6uuT0D1002Q6Z8g3m8+KZCov1/fZb0Boymx4ju8z+p8L8Cb27RcRt2oRz5nenfSSg
	 Gz09IloT8YuCO5dSBazT2n3CFnKvhw9/6xlBntTL6QSoeP9WGXFJ3xgE2hZOV0JaAD
	 07Y8yyOZBG8y7TXO83ads1GDSF//0G3D15WU33ATE9/Ca9wyMSwadH/8zot8VIvVX0
	 XQFn6P5wTX8OmtO0OsVxoKvetAHTvLSDtPrNFudibdo+fJYP9XfXnmKt8yR49bR4tG
	 uqGuTCxSMPaLg==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id E5E736B243; Thu, 10 Jul 2025 16:56:03 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
Date: Thu, 10 Jul 2025 16:55:58 +0800
Subject: [PATCH net-next v4 5/8] net: mctp: Use hashtable for binds
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-mctp-bind-v4-5-8ec2f6460c56@codeconstruct.com.au>
References: <20250710-mctp-bind-v4-0-8ec2f6460c56@codeconstruct.com.au>
In-Reply-To: <20250710-mctp-bind-v4-0-8ec2f6460c56@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>
X-Mailer: b4 0.15-dev-cbbb4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752137761; l=6492;
 i=matt@codeconstruct.com.au; s=20241018; h=from:subject:message-id;
 bh=ippW102rNZbVxwH3Tdr+dT3cgpv5fom/bzDy2F/521c=;
 b=d501Aj18suQqZ+WY2k7wn5FBs4r0bkDtorGLEl6wgthlpCbuTkvVh7MoIWXfhCdT8BLWiIgjR
 hu1emR/re/CDUFz5AlexmoYD7tE6QpRoUuSIkctn7TNtkp73yxahPzR
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


