Return-Path: <netdev+bounces-203724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 398A3AF6E3F
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 11:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6916A5272BA
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 09:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727492D5C69;
	Thu,  3 Jul 2025 09:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="mymZ3dQY"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5602E2D46D9
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 09:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533934; cv=none; b=ZY5j5TjWTMmZvcGx3OwWeNIbgTR0PH0ApZCeiKRJk0UJUXIh/P+WhwDQiizsmGPkf9epgCadHDP8GhAlPQolDj+QFSI+5Dyr7kdpCZ+qXroDkv+ln8aNDIflEUeSamsYqwrbxtMWy/7Tk0TinQxUq3y/kz6+dFcAZpoLmXND7Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533934; c=relaxed/simple;
	bh=Wa8kUGibZE6/ufFbrRyDdinD3QkvYPUqgGiJpYz/99s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nKYbmJPI6Av5D+YKR5qeaQLdyc+9gwYvjJpf5FdqBNLkUsfc+fInSu5Dyza3o2l3plENTxpwDUSY/EQQn945z8GsEEhGcXV6TLTecM/jiypXoX0Diq2FxnygFScgRlgicBCXCtLhIiLwcBRSj21Zz3NTUdU6kkfJkwwnDrGOLJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=mymZ3dQY; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1751533923;
	bh=gPysy5d2w5nJ05WuNLSt/9b/sqjfwsrLIWIgWic0iOQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mymZ3dQYQNTYvmeX2pe2vC5xsJ9VXSmPRw4Z8k64MwAvXIxXPdG4eM+3khEbDrLQW
	 4TVC2fuH6Jy/7xoMKhUiZlL00W7lambwfoguDAX9UW3cuLPpoiMZWuhm6SGWBFeBvZ
	 wA35HjtyzcaUfHY2I5pfrNLzI7yVXq0J1pe9QJXn533zm7gKDRAHmnIw2O8SgaVZ+e
	 uBjfsOEaAQrWeXb1g8UI+h7dm/FZQy+gZGkYs26eeWoqMAV8LXbMyq95VRfL/tr+gX
	 BfpSIEeHLJAcTqtGzBnm5Xp4RUjJpORdSi+SorfdT5Jc02qa5HSFJoYkvVTzsK5drc
	 t4ciPbai12HOQ==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id 059E46A8EB; Thu,  3 Jul 2025 17:12:03 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
Date: Thu, 03 Jul 2025 17:11:51 +0800
Subject: [PATCH net-next 4/7] net: mctp: Use hashtable for binds
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-mctp-bind-v1-4-bb7e97c24613@codeconstruct.com.au>
References: <20250703-mctp-bind-v1-0-bb7e97c24613@codeconstruct.com.au>
In-Reply-To: <20250703-mctp-bind-v1-0-bb7e97c24613@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>
X-Mailer: b4 0.15-dev-cbbb4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751533920; l=6350;
 i=matt@codeconstruct.com.au; s=20241018; h=from:subject:message-id;
 bh=Wa8kUGibZE6/ufFbrRyDdinD3QkvYPUqgGiJpYz/99s=;
 b=f68XPO6S2M/iVeUtR0U/ZNqK3QSdvh01lghzzw5Zn8lhQN/mFqcaott/dxUdUNezT8p/uS4vH
 gxFxmxi3nwrA/ozmnnmKtRso103moqnYKKu2eyRKU8Y16yiJ38xSVbb
X-Developer-Key: i=matt@codeconstruct.com.au; a=ed25519;
 pk=exersTcCYD/pEBOzXGO6HkLd6kKXRuWxHhj+LXn3DYE=

Ensure that a specific EID (remote or local) bind will match in
preference to a MCTP_ADDR_ANY bind.

This adds infrastructure for binding a socket to receive messages from a
specific remote peer address, a future commit will expose an API for
this.

Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
---
 include/net/netns/mctp.h | 15 ++++++++--
 net/mctp/af_mctp.c       | 11 ++++---
 net/mctp/route.c         | 76 +++++++++++++++++++++++++++++++++++++-----------
 3 files changed, 79 insertions(+), 23 deletions(-)

diff --git a/include/net/netns/mctp.h b/include/net/netns/mctp.h
index 1db8f9aaddb4b96f4803df9f30a762f5f88d7f7f..9f4f1c1065a8f00bbd5b1df5fa8f1cedf8d60686 100644
--- a/include/net/netns/mctp.h
+++ b/include/net/netns/mctp.h
@@ -6,19 +6,25 @@
 #ifndef __NETNS_MCTP_H__
 #define __NETNS_MCTP_H__
 
+#include <linux/hash.h>
 #include <linux/mutex.h>
 #include <linux/types.h>
 
+#define MCTP_BINDS_BITS 7
+#define MCTP_BINDS_SIZE (1 << MCTP_BINDS_BITS)
+#define MCTP_BINDS_MASK (MCTP_BINDS_SIZE - 1)
+
 struct netns_mctp {
 	/* Only updated under RTNL, entries freed via RCU */
 	struct list_head routes;
 
-	/* Bound sockets: list of sockets bound by type.
+	/* Bound sockets: hash table of sockets, keyed by (type, src_eid, dest_eid).
+	 * Specific src_eid/dest_eid entries also have an entry for MCTP_ADDR_ANY.
 	 * This list is updated from non-atomic contexts (under bind_lock),
 	 * and read (under rcu) in packet rx
 	 */
 	struct mutex bind_lock;
-	struct hlist_head binds;
+	struct hlist_head binds[MCTP_BINDS_SIZE];
 
 	/* tag allocations. This list is read and updated from atomic contexts,
 	 * but elements are free()ed after a RCU grace-period
@@ -34,4 +40,9 @@ struct netns_mctp {
 	struct list_head neighbours;
 };
 
+static inline u32 mctp_bind_hash(u8 type, u8 local_addr, u8 peer_addr)
+{
+	return hash_32(type | (u32)local_addr << 8 | (u32)peer_addr << 16, MCTP_BINDS_BITS);
+}
+
 #endif /* __NETNS_MCTP_H__ */
diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index 4751f5fc082dcab27df77a9c5acbc6abb4e861d5..7638e22bf03848868768700fdac07f74891dad0d 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -643,17 +643,17 @@ static int mctp_sk_hash(struct sock *sk)
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
 		struct mctp_sock *mex = container_of(existing, struct mctp_sock, sk);
 
 		if (mex->bind_type == msk->bind_type &&
@@ -664,7 +664,10 @@ static int mctp_sk_hash(struct sock *sk)
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
index d9c8e5a5f9ce9aefbf16730c65a1f54caa5592b9..8a8c7841d2382717b3c9a6698036d56f64da77f0 100644
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
@@ -55,20 +86,31 @@ static struct mctp_sock *mctp_lookup_bind(struct net *net, struct sk_buff *skb)
 
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
 
+	msk = mctp_lookup_bind_details(net, skb, type, mh->dest, mh->src, false);
+	if (msk)
+		return msk;
+	msk = mctp_lookup_bind_details(net, skb, type, MCTP_ADDR_ANY, mh->src, false);
+	if (msk)
+		return msk;
+	msk = mctp_lookup_bind_details(net, skb, type, mh->dest, MCTP_ADDR_ANY, false);
+	if (msk)
+		return msk;
+	msk = mctp_lookup_bind_details(net, skb, type, MCTP_ADDR_ANY, MCTP_ADDR_ANY, false);
+	if (msk)
+		return msk;
+	msk = mctp_lookup_bind_details(net, skb, type, MCTP_ADDR_ANY, MCTP_ADDR_ANY, true);
+	if (msk)
 		return msk;
-	}
 
 	return NULL;
 }
@@ -1475,7 +1517,7 @@ static int __net_init mctp_routes_net_init(struct net *net)
 	struct netns_mctp *ns = &net->mctp;
 
 	INIT_LIST_HEAD(&ns->routes);
-	INIT_HLIST_HEAD(&ns->binds);
+	hash_init(ns->binds);
 	mutex_init(&ns->bind_lock);
 	INIT_HLIST_HEAD(&ns->keys);
 	spin_lock_init(&ns->keys_lock);

-- 
2.43.0


