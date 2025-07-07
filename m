Return-Path: <netdev+bounces-204466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62324AFAB47
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 07:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE984189DC21
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 05:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF981277013;
	Mon,  7 Jul 2025 05:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="fEqKEu4L"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E326D274FD7
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 05:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751867729; cv=none; b=svvHJFhxpTOOjUjJSNb3prtb403CtKC5anUOp9gSqAjZJ69rupBIVBohFrTP6oXQZ+r+FZnEjNKaFh5HEv1BjXQCKwqn4CgGEtkzWFQ35wgkx5AE438tQbTj1ULPHgIVH7ZKntnRIcuW7CHkgo9/EhcHmg4QNQ/ULu6UnKveKeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751867729; c=relaxed/simple;
	bh=dH/27trRqm1rIOUFV8rZ3R7gke4g0I70Vfn7GFc02yg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d001yqz2IA1LYBpYF3yU++zxYFAGFWg9qL+NOan2Vjxhb0ajQ/eCdvaY7OKsLdMawLVcF3PxQuBeJFSVSfAquQgypGi32TpuYUV0qg5WuyNEVEvRJSjT/rbGzDCzxFCLF0ksfysZ+qTtgiju/nRow+kVSvxVBRZpE+RlXOMC7aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=fEqKEu4L; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1751867720;
	bh=jOfSkCrYe6RhxegkChtgJRI4yNeotcbv/GhIPsYBVno=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fEqKEu4Lh2q7BaUVhgrHDsiUQWUCJY8JojF1OvFFxcRypVoiWTLZ695SCTYB5vYDH
	 P9IzKZKo6MiXAO+RWC+iedWQwvy/fKjRs3BuBInyzihwge2wRHKodrVGSWkGvCsg7o
	 u5NJW6TZuUKzqbqjlH0cxagV5zOuhvhfukwUVsQP4VENM/wFClCqHFJ/R19N+7nL0f
	 +H7emdZldo8hOSN0oa77wqUvr6H/grmESn0iyqNVbzENGgI0htLYm/LcI2YEByHurh
	 dwa78ODXjYWT6OxJONz1DZZq/Ew06zm2I+I1KZ37r6TGX4GMp2UUO/frOAABjbfO2U
	 79vNHtaynmMBQ==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id 1A9206AC89; Mon,  7 Jul 2025 13:55:20 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
Date: Mon, 07 Jul 2025 13:55:17 +0800
Subject: [PATCH net-next v2 4/7] net: mctp: Use hashtable for binds
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-mctp-bind-v2-4-fbaed8c1fb4d@codeconstruct.com.au>
References: <20250707-mctp-bind-v2-0-fbaed8c1fb4d@codeconstruct.com.au>
In-Reply-To: <20250707-mctp-bind-v2-0-fbaed8c1fb4d@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>
X-Mailer: b4 0.15-dev-cbbb4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751867717; l=6498;
 i=matt@codeconstruct.com.au; s=20241018; h=from:subject:message-id;
 bh=dH/27trRqm1rIOUFV8rZ3R7gke4g0I70Vfn7GFc02yg=;
 b=c+qyWIy1eVSbm23o3KXpBw/j8C7zxm2dO9zSLrmTLAYvFJAxPbybbl99h0DiT4fBg6wxhkkh4
 CTJ8nLerQMjBirzFtqx372n8BCehmyJ3rkl3TeJIOoXAJDtU32NedeF
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
index 4f456b1c82d182ac2c64acebb0e603726826a7e7..a07da537bab41005ce643862b23d3050e958a66a 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -644,17 +644,17 @@ static int mctp_sk_hash(struct sock *sk)
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
 
@@ -666,7 +666,10 @@ static int mctp_sk_hash(struct sock *sk)
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
index d9c8e5a5f9ce9aefbf16730c65a1f54caa5592b9..815fcb8db3beff338eedbabe6b3f4d44dd238f11 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -38,14 +38,45 @@ static int mctp_route_discard(struct mctp_route *route, struct sk_buff *skb)
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
@@ -55,20 +86,36 @@ static struct mctp_sock *mctp_lookup_bind(struct net *net, struct sk_buff *skb)
 
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
@@ -1475,7 +1522,7 @@ static int __net_init mctp_routes_net_init(struct net *net)
 	struct netns_mctp *ns = &net->mctp;
 
 	INIT_LIST_HEAD(&ns->routes);
-	INIT_HLIST_HEAD(&ns->binds);
+	hash_init(ns->binds);
 	mutex_init(&ns->bind_lock);
 	INIT_HLIST_HEAD(&ns->keys);
 	spin_lock_init(&ns->keys_lock);

-- 
2.43.0


