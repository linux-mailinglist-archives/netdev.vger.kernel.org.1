Return-Path: <netdev+bounces-192835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A84C8AC1553
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 22:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4CA61C00388
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 20:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07E72BFC80;
	Thu, 22 May 2025 20:07:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAC42222A7;
	Thu, 22 May 2025 20:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747944433; cv=none; b=QxEMkHmfXZPXjsj/LsBKHpOUhecrxX14Gy4vq8gupjWkiZ8SJOR4tm5yBgPQ2JnwLfe7EJ8e44oCbLw70/QKBJp+W+5nwaMDq8W8LNtyHYOJkUYn+2heZQwX5i8ZQp3dSaItRmseV2e0mg+K3p1Ep8LjdydUad3jRziyduUfC6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747944433; c=relaxed/simple;
	bh=xEjEb10uzGTqQiQP3ijydh9JxPOpaufneqCh/lN4bNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WQyQGXGAMvOJ9/4EUmTSoyGtwmIx5mvSwb9AhnW7AVmntWl+aqKqe0VeQm/NsMGxTAqtT1PZgYMbQbjX9NnkZwrLCoiAE4/G9DHWIofK808lFBaIysFSqROAu2raVr4BqsKEh9G2YYWij2PcfMJZEuhsjue6jOvX2npVUjTJjeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DAEA954D7B3;
	Thu, 22 May 2025 22:00:10 +0200 (CEST)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: bridge@lists.linux.dev
Cc: netdev@vger.kernel.org,
	openwrt-devel@lists.openwrt.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Ivan Vecera <ivecera@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jonathan Corbet <corbet@lwn.net>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>,
	Markus Stockhausen <markus.stockhausen@gmx.de>,
	Jan Hoffmann <jan.christian.hoffmann@gmail.com>,
	Birger Koblitz <git@birger-koblitz.de>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH net-next 1/5] net: bridge: mcast: explicitly track active state
Date: Thu, 22 May 2025 21:17:03 +0200
Message-ID: <20250522195952.29265-2-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250522195952.29265-1-linus.luessing@c0d3.blue>
References: <20250522195952.29265-1-linus.luessing@c0d3.blue>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Combining and tracking the active state into new, per protocol family
variables.

For one thing this slightly reduces the work and checks in fast path
for multicast payload traffic. For another this is in preparation to
be able to notify DSA/switchdev on the (in)applicability of multicast
snooping on multicast payload traffic. Especially on vanishing IGMP/MLD
queriers.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/bridge/br_device.c    |   5 +-
 net/bridge/br_input.c     |   2 +-
 net/bridge/br_multicast.c | 179 +++++++++++++++++++++++++++++++++++---
 net/bridge/br_private.h   |  33 ++-----
 4 files changed, 180 insertions(+), 39 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index a818fdc22da9..315ed3d33406 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -102,7 +102,7 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 
 		mdst = br_mdb_entry_skb_get(brmctx, skb, vid);
 		if ((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
-		    br_multicast_querier_exists(brmctx, eth_hdr(skb), mdst))
+		    br_multicast_snooping_active(brmctx, eth_hdr(skb), mdst))
 			br_multicast_flood(mdst, skb, brmctx, false, true);
 		else
 			br_flood(br, skb, BR_PKT_MULTICAST, false, true, vid);
@@ -168,7 +168,10 @@ static int br_dev_open(struct net_device *dev)
 	netdev_update_features(dev);
 	netif_start_queue(dev);
 	br_stp_enable_bridge(br);
+
+	spin_lock_bh(&br->multicast_lock);
 	br_multicast_open(br);
+	spin_unlock_bh(&br->multicast_lock);
 
 	if (br_opt_get(br, BROPT_MULTICAST_ENABLED))
 		br_multicast_join_snoopers(br);
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 232133a0fd21..0c632655d66c 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -187,7 +187,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 	case BR_PKT_MULTICAST:
 		mdst = br_mdb_entry_skb_get(brmctx, skb, vid);
 		if ((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
-		    br_multicast_querier_exists(brmctx, eth_hdr(skb), mdst)) {
+		    br_multicast_snooping_active(brmctx, eth_hdr(skb), mdst)) {
 			if ((mdst && mdst->host_joined) ||
 			    br_multicast_is_router(brmctx, skb)) {
 				local_rcv = true;
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index dcbf058de1e3..b66d2173e321 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1069,6 +1069,125 @@ static struct sk_buff *br_ip4_multicast_alloc_query(struct net_bridge_mcast *brm
 	return skb;
 }
 
+static bool
+__br_multicast_querier_exists(struct net_bridge_mcast *brmctx,
+			      struct bridge_mcast_other_query *querier,
+			      const bool is_ipv6)
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
+static bool br_multicast_querier_exists(struct net_bridge_mcast *brmctx,
+					struct ethhdr *eth,
+					const struct net_bridge_mdb_entry *mdb)
+{
+	switch (eth->h_proto) {
+	case (htons(ETH_P_IP)):
+		return __br_multicast_querier_exists(brmctx,
+			&brmctx->ip4_other_query, false);
+#if IS_ENABLED(CONFIG_IPV6)
+	case (htons(ETH_P_IPV6)):
+		return __br_multicast_querier_exists(brmctx,
+			&brmctx->ip6_other_query, true);
+#endif
+	default:
+		return !!mdb && br_group_is_l2(&mdb->addr);
+	}
+}
+
+static bool br_ip4_multicast_check_active(struct net_bridge_mcast *brmctx,
+					  bool *active)
+{
+	if (!__br_multicast_querier_exists(brmctx, &brmctx->ip4_other_query,
+					   false))
+		*active = false;
+
+	if (brmctx->ip4_active == *active)
+		return false;
+
+	return true;
+}
+
+static int br_ip6_multicast_check_active(struct net_bridge_mcast *brmctx,
+					 bool *active)
+{
+#if IS_ENABLED(CONFIG_IPV6)
+	if (!__br_multicast_querier_exists(brmctx, &brmctx->ip6_other_query,
+					   true))
+		*active = false;
+
+	if (brmctx->ip6_active == *active)
+		return false;
+
+	return true;
+#elif
+	*active = false;
+	return false;
+#endif
+}
+
+/**
+ * __br_multicast_update_active() - update mcast active state
+ * @brmctx: the bridge multicast context to check
+ * @force_inactive: forcefully deactivate mcast active state
+ * @extack: netlink extended ACK structure
+ *
+ * This (potentially) updates the IPv4/IPv6 multicast active state. And by
+ * that enables or disables snooping of multicast payload traffic in fast
+ * path.
+ *
+ * The multicast active state is set, per protocol family, if:
+ *
+ * - an IGMP/MLD querier is present
+ * - for own IPv6 MLD querier: an IPv6 address is configured on the bridge
+ *
+ * And is unset otherwise.
+ *
+ * This function should be called by anything that changes one of the
+ * above prerequisites.
+ *
+ * Return: 0 on success, a negative value otherwise.
+ */
+static int __br_multicast_update_active(struct net_bridge_mcast *brmctx,
+					bool force_inactive,
+					struct netlink_ext_ack *extack)
+{
+	bool ip4_active, ip6_active, ip4_changed, ip6_changed;
+	int ret = 0;
+
+	lockdep_assert_held_once(&brmctx->br->multicast_lock);
+
+	ip4_active = !force_inactive;
+	ip6_active = !force_inactive;
+	ip4_changed = br_ip4_multicast_check_active(brmctx, &ip4_active);
+	ip6_changed = br_ip6_multicast_check_active(brmctx, &ip6_active);
+
+	if (ip4_changed)
+		brmctx->ip4_active = ip4_active;
+	if (ip6_changed)
+		brmctx->ip6_active = ip6_active;
+
+	return ret;
+}
+
+static int br_multicast_update_active(struct net_bridge_mcast *brmctx,
+				      struct netlink_ext_ack *extack)
+{
+	return __br_multicast_update_active(brmctx, false, extack);
+}
+
 #if IS_ENABLED(CONFIG_IPV6)
 static struct sk_buff *br_ip6_multicast_alloc_query(struct net_bridge_mcast *brmctx,
 						    struct net_bridge_mcast_port *pmctx,
@@ -1147,10 +1266,12 @@ static struct sk_buff *br_ip6_multicast_alloc_query(struct net_bridge_mcast *brm
 			       &ip6h->daddr, 0, &ip6h->saddr)) {
 		kfree_skb(skb);
 		br_opt_toggle(brmctx->br, BROPT_HAS_IPV6_ADDR, false);
+		br_multicast_update_active(brmctx, NULL);
 		return NULL;
 	}
 
 	br_opt_toggle(brmctx->br, BROPT_HAS_IPV6_ADDR, true);
+	br_multicast_update_active(brmctx, NULL);
 	ipv6_eth_mc_map(&ip6h->daddr, eth->h_dest);
 
 	hopopt = (u8 *)(ip6h + 1);
@@ -1762,10 +1883,28 @@ static void br_ip6_multicast_querier_expired(struct timer_list *t)
 }
 #endif
 
-static void br_multicast_query_delay_expired(struct timer_list *t)
+static void br_ip4_multicast_query_delay_expired(struct timer_list *t)
 {
+	struct net_bridge_mcast *brmctx = from_timer(brmctx, t,
+						     ip4_other_query.delay_timer);
+
+	spin_lock(&brmctx->br->multicast_lock);
+	br_multicast_update_active(brmctx, NULL);
+	spin_unlock(&brmctx->br->multicast_lock);
 }
 
+#if IS_ENABLED(CONFIG_IPV6)
+static void br_ip6_multicast_query_delay_expired(struct timer_list *t)
+{
+	struct net_bridge_mcast *brmctx = from_timer(brmctx, t,
+						     ip6_other_query.delay_timer);
+
+	spin_lock(&brmctx->br->multicast_lock);
+	br_multicast_update_active(brmctx, NULL);
+	spin_unlock(&brmctx->br->multicast_lock);
+}
+#endif
+
 static void br_multicast_select_own_querier(struct net_bridge_mcast *brmctx,
 					    struct br_ip *ip,
 					    struct sk_buff *skb)
@@ -3981,16 +4120,13 @@ static void br_multicast_query_expired(struct net_bridge_mcast *brmctx,
 				       struct bridge_mcast_own_query *query,
 				       struct bridge_mcast_querier *querier)
 {
-	spin_lock(&brmctx->br->multicast_lock);
 	if (br_multicast_ctx_vlan_disabled(brmctx))
-		goto out;
+		return;
 
 	if (query->startup_sent < brmctx->multicast_startup_query_count)
 		query->startup_sent++;
 
 	br_multicast_send_query(brmctx, NULL, query);
-out:
-	spin_unlock(&brmctx->br->multicast_lock);
 }
 
 static void br_ip4_multicast_query_expired(struct timer_list *t)
@@ -3998,8 +4134,11 @@ static void br_ip4_multicast_query_expired(struct timer_list *t)
 	struct net_bridge_mcast *brmctx = from_timer(brmctx, t,
 						     ip4_own_query.timer);
 
+	spin_lock(&brmctx->br->multicast_lock);
 	br_multicast_query_expired(brmctx, &brmctx->ip4_own_query,
 				   &brmctx->ip4_querier);
+	br_multicast_update_active(brmctx, NULL);
+	spin_unlock(&brmctx->br->multicast_lock);
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
@@ -4008,8 +4147,11 @@ static void br_ip6_multicast_query_expired(struct timer_list *t)
 	struct net_bridge_mcast *brmctx = from_timer(brmctx, t,
 						     ip6_own_query.timer);
 
+	spin_lock(&brmctx->br->multicast_lock);
 	br_multicast_query_expired(brmctx, &brmctx->ip6_own_query,
 				   &brmctx->ip6_querier);
+	br_multicast_update_active(brmctx, NULL);
+	spin_unlock(&brmctx->br->multicast_lock);
 }
 #endif
 
@@ -4044,11 +4186,13 @@ void br_multicast_ctx_init(struct net_bridge *br,
 	brmctx->multicast_membership_interval = 260 * HZ;
 
 	brmctx->ip4_querier.port_ifidx = 0;
+	brmctx->ip4_active = 0;
 	seqcount_spinlock_init(&brmctx->ip4_querier.seq, &br->multicast_lock);
 	brmctx->multicast_igmp_version = 2;
 #if IS_ENABLED(CONFIG_IPV6)
 	brmctx->multicast_mld_version = 1;
 	brmctx->ip6_querier.port_ifidx = 0;
+	brmctx->ip6_active = 0;
 	seqcount_spinlock_init(&brmctx->ip6_querier.seq, &br->multicast_lock);
 #endif
 
@@ -4057,7 +4201,7 @@ void br_multicast_ctx_init(struct net_bridge *br,
 	timer_setup(&brmctx->ip4_other_query.timer,
 		    br_ip4_multicast_querier_expired, 0);
 	timer_setup(&brmctx->ip4_other_query.delay_timer,
-		    br_multicast_query_delay_expired, 0);
+		    br_ip4_multicast_query_delay_expired, 0);
 	timer_setup(&brmctx->ip4_own_query.timer,
 		    br_ip4_multicast_query_expired, 0);
 #if IS_ENABLED(CONFIG_IPV6)
@@ -4066,7 +4210,7 @@ void br_multicast_ctx_init(struct net_bridge *br,
 	timer_setup(&brmctx->ip6_other_query.timer,
 		    br_ip6_multicast_querier_expired, 0);
 	timer_setup(&brmctx->ip6_other_query.delay_timer,
-		    br_multicast_query_delay_expired, 0);
+		    br_ip6_multicast_query_delay_expired, 0);
 	timer_setup(&brmctx->ip6_own_query.timer,
 		    br_ip6_multicast_query_expired, 0);
 #endif
@@ -4171,6 +4315,8 @@ static void __br_multicast_open(struct net_bridge_mcast *brmctx)
 #if IS_ENABLED(CONFIG_IPV6)
 	__br_multicast_open_query(brmctx->br, &brmctx->ip6_own_query);
 #endif
+
+	br_multicast_update_active(brmctx, NULL);
 }
 
 void br_multicast_open(struct net_bridge *br)
@@ -4209,6 +4355,10 @@ static void __br_multicast_stop(struct net_bridge_mcast *brmctx)
 	timer_delete_sync(&brmctx->ip6_other_query.delay_timer);
 	timer_delete_sync(&brmctx->ip6_own_query.timer);
 #endif
+
+	spin_lock_bh(&brmctx->br->multicast_lock);
+	__br_multicast_update_active(brmctx, true, NULL);
+	spin_unlock_bh(&brmctx->br->multicast_lock);
 }
 
 void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan, bool on)
@@ -4234,10 +4384,13 @@ void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan, bool on)
 		vlan->priv_flags ^= BR_VLFLAG_MCAST_ENABLED;
 		spin_unlock_bh(&br->multicast_lock);
 
-		if (on)
+		if (on) {
+			spin_lock_bh(&br->multicast_lock);
 			__br_multicast_open(&vlan->br_mcast_ctx);
-		else
+			spin_unlock_bh(&br->multicast_lock);
+		} else {
 			__br_multicast_stop(&vlan->br_mcast_ctx);
+		}
 	} else {
 		struct net_bridge_mcast *brmctx;
 
@@ -4298,10 +4451,13 @@ int br_multicast_toggle_vlan_snooping(struct net_bridge *br, bool on,
 	br_opt_toggle(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED, on);
 
 	/* disable/enable non-vlan mcast contexts based on vlan snooping */
-	if (on)
+	if (on) {
 		__br_multicast_stop(&br->multicast_ctx);
-	else
+	} else {
+		spin_lock_bh(&br->multicast_lock);
 		__br_multicast_open(&br->multicast_ctx);
+		spin_unlock_bh(&br->multicast_lock);
+	}
 	list_for_each_entry(p, &br->port_list, list) {
 		if (on)
 			br_multicast_disable_port(p);
@@ -4663,6 +4819,7 @@ int br_multicast_set_querier(struct net_bridge_mcast *brmctx, unsigned long val)
 #endif
 
 unlock:
+	br_multicast_update_active(brmctx, NULL);
 	spin_unlock_bh(&brmctx->br->multicast_lock);
 
 	return 0;
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index d5b3c5936a79..3d05895a437f 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -158,12 +158,14 @@ struct net_bridge_mcast {
 	struct bridge_mcast_other_query	ip4_other_query;
 	struct bridge_mcast_own_query	ip4_own_query;
 	struct bridge_mcast_querier	ip4_querier;
+	bool				ip4_active;
 #if IS_ENABLED(CONFIG_IPV6)
 	struct hlist_head		ip6_mc_router_list;
 	struct timer_list		ip6_mc_router_timer;
 	struct bridge_mcast_other_query	ip6_other_query;
 	struct bridge_mcast_own_query	ip6_own_query;
 	struct bridge_mcast_querier	ip6_querier;
+	bool				ip6_active;
 #endif /* IS_ENABLED(CONFIG_IPV6) */
 #endif /* CONFIG_BRIDGE_IGMP_SNOOPING */
 };
@@ -1144,37 +1146,16 @@ br_multicast_is_router(struct net_bridge_mcast *brmctx, struct sk_buff *skb)
 }
 
 static inline bool
-__br_multicast_querier_exists(struct net_bridge_mcast *brmctx,
-			      struct bridge_mcast_other_query *querier,
-			      const bool is_ipv6)
-{
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
+br_multicast_snooping_active(struct net_bridge_mcast *brmctx,
+			     struct ethhdr *eth,
+			     const struct net_bridge_mdb_entry *mdb)
 {
 	switch (eth->h_proto) {
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
-- 
2.49.0


