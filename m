Return-Path: <netdev+bounces-218170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88555B3B680
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 10:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D762981F96
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 08:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9158B2C08BB;
	Fri, 29 Aug 2025 08:57:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A6C2701D1;
	Fri, 29 Aug 2025 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756457868; cv=none; b=LHy/KifY+C32evGy3wwLcDd2qAGAXExQGLDXpdym941hn377Npks0QYntuUScZY1FGeuxA9YPXuU7OdOfcgtj2Ua1svvLimQBg1Jri/w7PsFO7J5MPWwUBjbcEKMyRBtw26fp/y2Ki4q+VyxPqN/rheXI/zD0MgKyNp3Ssnn91c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756457868; c=relaxed/simple;
	bh=5k0gEYVhfBeLd8xxoqdFRX8s4nSQjtv+QkQ6CPrvUAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vAHrfKnv658SBRlNubgeIm9kmn/Ap7LGpPdpN3NxIKM0QfVKdLRGVm11DCmhi0d7VJB76EXzKs4DdQXD/KDV3jtNMZ3sqlt8KK9s7yAVspt/nhthBNGPSSI/zLMB41RXoVTy5OirVJzotSFLSaL7bfMDty0EJ0YvJyBjEPjZoq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A5D6A54F6C2;
	Fri, 29 Aug 2025 10:57:42 +0200 (CEST)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: bridge@lists.linux.dev
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH 6/9] net: bridge: mcast: use combined active state in fast/data path
Date: Fri, 29 Aug 2025 10:53:47 +0200
Message-ID: <20250829085724.24230-7-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250829085724.24230-1-linus.luessing@c0d3.blue>
References: <20250829085724.24230-1-linus.luessing@c0d3.blue>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

As the multicast active state variable is now always up to date and
functionally equivalent to our manual, extensive checks in fast path
we can just use this state variable in fast path, too. This allows to
save some CPU cycles for every multicast packet in the fast/data path.

Next to using brmctx->ip4_active / brmctx->ip6_active in fast path this
mostly just moves some code around to not expose it via br_private.h
anymore. While at it now also passing the ethernet protocol number
directly, instead of a pointer into the ethernet header.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/bridge/br_device.c    |  2 +-
 net/bridge/br_input.c     |  2 +-
 net/bridge/br_multicast.c | 40 ++++++++++++++++++++++++++++++++++-----
 net/bridge/br_private.h   | 38 ++++++++-----------------------------
 4 files changed, 45 insertions(+), 37 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index a818fdc22da9..3cdf1c17108b 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -102,7 +102,7 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 
 		mdst = br_mdb_entry_skb_get(brmctx, skb, vid);
 		if ((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
-		    br_multicast_querier_exists(brmctx, eth_hdr(skb), mdst))
+		    br_multicast_snooping_active(brmctx, eth_hdr(skb)->h_proto, mdst))
 			br_multicast_flood(mdst, skb, brmctx, false, true);
 		else
 			br_flood(br, skb, BR_PKT_MULTICAST, false, true, vid);
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 5f6ac9bf1527..dfd49b309683 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -187,7 +187,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 	case BR_PKT_MULTICAST:
 		mdst = br_mdb_entry_skb_get(brmctx, skb, vid);
 		if ((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
-		    br_multicast_querier_exists(brmctx, eth_hdr(skb), mdst)) {
+		    br_multicast_snooping_active(brmctx, eth_hdr(skb)->h_proto, mdst)) {
 			if ((mdst && mdst->host_joined) ||
 			    br_multicast_is_router(brmctx, skb) ||
 			    br->dev->flags & IFF_ALLMULTI) {
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 13840f8f2e5f..54163c74b9a9 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1069,6 +1069,26 @@ static struct sk_buff *br_ip4_multicast_alloc_query(struct net_bridge_mcast *brm
 	return skb;
 }
 
+static bool
+__br_multicast_querier_exists(struct net_bridge_mcast *brmctx,
+			      struct bridge_mcast_other_query *querier,
+			      bool is_ipv6)
+{
+	bool own_querier_enabled;
+
+	if (brmctx->multicast_querier) {
+		if (is_ipv6 && !br_opt_get(brmctx->br, BROPT_HAS_IPV6_ADDR))
+			own_querier_enabled = false;
+		else
+			own_querier_enabled = true;
+	} else {
+		own_querier_enabled = false;
+	}
+
+	return !timer_pending(&querier->delay_timer) &&
+	       (own_querier_enabled || timer_pending(&querier->timer));
+}
+
 static bool br_ip4_multicast_querier_exists(struct net_bridge_mcast *brmctx)
 {
 	return __br_multicast_querier_exists(brmctx, &brmctx->ip4_other_query, false);
@@ -1081,6 +1101,20 @@ static bool br_ip6_multicast_querier_exists(struct net_bridge_mcast *brmctx)
 }
 #endif
 
+static bool br_multicast_querier_exists(struct net_bridge_mcast *brmctx, int proto)
+{
+	switch (proto) {
+	case (ETH_P_IP):
+		return br_ip4_multicast_querier_exists(brmctx);
+#if IS_ENABLED(CONFIG_IPV6)
+	case (ETH_P_IPV6):
+		return br_ip6_multicast_querier_exists(brmctx);
+#endif
+	default:
+		return false;
+	}
+}
+
 static void br_ip4_multicast_update_active(struct net_bridge_mcast *brmctx,
 					   bool force_inactive)
 {
@@ -5013,7 +5047,6 @@ bool br_multicast_has_querier_anywhere(struct net_device *dev, int proto)
 {
 	struct net_bridge *br;
 	struct net_bridge_port *port;
-	struct ethhdr eth;
 	bool ret = false;
 
 	rcu_read_lock();
@@ -5026,10 +5059,7 @@ bool br_multicast_has_querier_anywhere(struct net_device *dev, int proto)
 
 	br = port->br;
 
-	memset(&eth, 0, sizeof(eth));
-	eth.h_proto = htons(proto);
-
-	ret = br_multicast_querier_exists(&br->multicast_ctx, &eth, NULL);
+	ret = br_multicast_querier_exists(&br->multicast_ctx, proto);
 
 unlock:
 	rcu_read_unlock();
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index f83c24def595..05650af596ab 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1154,37 +1154,15 @@ br_multicast_is_router(struct net_bridge_mcast *brmctx, struct sk_buff *skb)
 }
 
 static inline bool
-__br_multicast_querier_exists(struct net_bridge_mcast *brmctx,
-			      struct bridge_mcast_other_query *querier,
-			      const bool is_ipv6)
+br_multicast_snooping_active(struct net_bridge_mcast *brmctx, __be16 eth_proto,
+			     const struct net_bridge_mdb_entry *mdb)
 {
-	bool own_querier_enabled;
-
-	if (brmctx->multicast_querier) {
-		if (is_ipv6 && !br_opt_get(brmctx->br, BROPT_HAS_IPV6_ADDR))
-			own_querier_enabled = false;
-		else
-			own_querier_enabled = true;
-	} else {
-		own_querier_enabled = false;
-	}
-
-	return !timer_pending(&querier->delay_timer) &&
-	       (own_querier_enabled || timer_pending(&querier->timer));
-}
-
-static inline bool br_multicast_querier_exists(struct net_bridge_mcast *brmctx,
-					       struct ethhdr *eth,
-					       const struct net_bridge_mdb_entry *mdb)
-{
-	switch (eth->h_proto) {
+	switch (eth_proto) {
 	case (htons(ETH_P_IP)):
-		return __br_multicast_querier_exists(brmctx,
-			&brmctx->ip4_other_query, false);
+		return brmctx->ip4_active;
 #if IS_ENABLED(CONFIG_IPV6)
 	case (htons(ETH_P_IPV6)):
-		return __br_multicast_querier_exists(brmctx,
-			&brmctx->ip6_other_query, true);
+		return brmctx->ip6_active;
 #endif
 	default:
 		return !!mdb && br_group_is_l2(&mdb->addr);
@@ -1439,9 +1417,9 @@ static inline bool br_multicast_is_router(struct net_bridge_mcast *brmctx,
 	return false;
 }
 
-static inline bool br_multicast_querier_exists(struct net_bridge_mcast *brmctx,
-					       struct ethhdr *eth,
-					       const struct net_bridge_mdb_entry *mdb)
+static inline bool
+br_multicast_snooping_active(struct net_bridge_mcast *brmctx, __be16 eth_proto,
+			     const struct net_bridge_mdb_entry *mdb)
 {
 	return false;
 }
-- 
2.50.1


