Return-Path: <netdev+bounces-218179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BA1B3B6A2
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 11:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43AA93AB1C4
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 09:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B4C2E427C;
	Fri, 29 Aug 2025 09:04:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF7A2DCF6F;
	Fri, 29 Aug 2025 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756458292; cv=none; b=hNhxhmxh12zQzR3BSh+FYwW/vK9uYGaHWZm9/mv4nbwX9QylZCV5BVf4LfOwh6M5v5i5hL0FHwF7QNi2unk1+ZmNmmaSJXFrM9iWiSkM9vg1qa/0T0dQK3fnU/IR47joOa1gvf8OnpZojvwVosNSNS72qcGqYx8fRltlqd2EO3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756458292; c=relaxed/simple;
	bh=aNcFr2dAW7sNkmQoscRhRn0JZ3avd2DELg+pkBK4jmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PolLF3n95Gy+wVTXqIS2tpW9HH406ZSvzBzl2Al/XgVNlburFUgoYhOvKCFMxvA9Ijc01GAdlE/uhFMNrcNYU8MvJDKTr1Wkpo8XCtLMvoqbTw0n6VnfU2G7m5cQGaktfp8l1K6s32In2ZkG/FbpFGGeOY6WTgz8f54SA0FGt0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F01AC54F66C;
	Fri, 29 Aug 2025 10:57:33 +0200 (CEST)
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
Subject: [PATCH 1/9] net: bridge: mcast: track active state, IGMP/MLD querier appearance
Date: Fri, 29 Aug 2025 10:53:42 +0200
Message-ID: <20250829085724.24230-2-linus.luessing@c0d3.blue>
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

This is the first step to track in dedicated, per protocol family
variables if we can actively and safely use multicast snooping.
To later use these in the fast/data path instead of performing
all these checks for every packet and to later notify DSA/switchdev
about this state.

This toggles these new variables to true after a Maximum Response Delay
(default: 10 seconds) if a new IGMP or MLD querier has appeared. This
can be triggered either through receiving an IGMP/MLD query from another
host or by a user enabling our own IGMP/MLD querier.

This is the first of several requirements, similar to what
br_multicast_querier_exists() already checks so far, to be able to
reliably receive IGMP/MLD reports, which in turn are needed to build
a complete multicast database.

No functional change for the fast/data path yet.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/bridge/br_multicast.c | 91 +++++++++++++++++++++++++++++++++++++--
 net/bridge/br_private.h   |  2 +
 2 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 22d12e545966..5cc713adcf9b 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1069,6 +1069,65 @@ static struct sk_buff *br_ip4_multicast_alloc_query(struct net_bridge_mcast *brm
 	return skb;
 }
 
+static bool br_ip4_multicast_querier_exists(struct net_bridge_mcast *brmctx)
+{
+	return __br_multicast_querier_exists(brmctx, &brmctx->ip4_other_query, false);
+}
+
+#if IS_ENABLED(CONFIG_IPV6)
+static bool br_ip6_multicast_querier_exists(struct net_bridge_mcast *brmctx)
+{
+	return __br_multicast_querier_exists(brmctx, &brmctx->ip6_other_query, true);
+}
+#endif
+
+static void br_ip4_multicast_update_active(struct net_bridge_mcast *brmctx,
+					   bool force_inactive)
+{
+	if (force_inactive)
+		brmctx->ip4_active = false;
+	else
+		brmctx->ip4_active = br_ip4_multicast_querier_exists(brmctx);
+}
+
+static void br_ip6_multicast_update_active(struct net_bridge_mcast *brmctx,
+					   bool force_inactive)
+{
+#if IS_ENABLED(CONFIG_IPV6)
+	if (force_inactive)
+		brmctx->ip6_active = false;
+	else
+		brmctx->ip6_active = br_ip6_multicast_querier_exists(brmctx);
+#endif
+}
+
+/**
+ * br_multicast_update_active() - update mcast active state
+ * @brmctx: the bridge multicast context to check
+ *
+ * This (potentially) updates the IPv4/IPv6 multicast active state. And by
+ * that enables or disables snooping of multicast payload traffic in fast
+ * path.
+ *
+ * The multicast active state is set, per protocol family, if:
+ *
+ * - an IGMP/MLD querier is present
+ *
+ * And is unset otherwise.
+ *
+ * This function should be called by anything that changes one of the
+ * above prerequisites.
+ */
+static void br_multicast_update_active(struct net_bridge_mcast *brmctx)
+{
+	bool force_inactive = false;
+
+	lockdep_assert_held_once(&brmctx->br->multicast_lock);
+
+	br_ip4_multicast_update_active(brmctx, force_inactive);
+	br_ip6_multicast_update_active(brmctx, force_inactive);
+}
+
 #if IS_ENABLED(CONFIG_IPV6)
 static struct sk_buff *br_ip6_multicast_alloc_query(struct net_bridge_mcast *brmctx,
 						    struct net_bridge_mcast_port *pmctx,
@@ -1762,10 +1821,34 @@ static void br_ip6_multicast_querier_expired(struct timer_list *t)
 }
 #endif
 
-static void br_multicast_query_delay_expired(struct timer_list *t)
+static void br_ip4_multicast_query_delay_expired(struct timer_list *t)
 {
+	struct net_bridge_mcast *brmctx = timer_container_of(brmctx, t,
+							     ip4_other_query.delay_timer);
+
+	spin_lock(&brmctx->br->multicast_lock);
+	/* an own or other IGMP querier appeared some seconds ago and all
+	 * reports should have arrived by now, maybe set multicast state to active
+	 */
+	br_multicast_update_active(brmctx);
+	spin_unlock(&brmctx->br->multicast_lock);
 }
 
+#if IS_ENABLED(CONFIG_IPV6)
+static void br_ip6_multicast_query_delay_expired(struct timer_list *t)
+{
+	struct net_bridge_mcast *brmctx = timer_container_of(brmctx, t,
+							     ip6_other_query.delay_timer);
+
+	spin_lock(&brmctx->br->multicast_lock);
+	/* an own or other MLD querier appeared some seconds ago and all
+	 * reports should have arrived, maybe set multicast state to active
+	 */
+	br_multicast_update_active(brmctx);
+	spin_unlock(&brmctx->br->multicast_lock);
+}
+#endif
+
 static void br_multicast_select_own_querier(struct net_bridge_mcast *brmctx,
 					    struct br_ip *ip,
 					    struct sk_buff *skb)
@@ -4112,11 +4195,13 @@ void br_multicast_ctx_init(struct net_bridge *br,
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
 
@@ -4125,7 +4210,7 @@ void br_multicast_ctx_init(struct net_bridge *br,
 	timer_setup(&brmctx->ip4_other_query.timer,
 		    br_ip4_multicast_querier_expired, 0);
 	timer_setup(&brmctx->ip4_other_query.delay_timer,
-		    br_multicast_query_delay_expired, 0);
+		    br_ip4_multicast_query_delay_expired, 0);
 	timer_setup(&brmctx->ip4_own_query.timer,
 		    br_ip4_multicast_query_expired, 0);
 #if IS_ENABLED(CONFIG_IPV6)
@@ -4134,7 +4219,7 @@ void br_multicast_ctx_init(struct net_bridge *br,
 	timer_setup(&brmctx->ip6_other_query.timer,
 		    br_ip6_multicast_querier_expired, 0);
 	timer_setup(&brmctx->ip6_other_query.delay_timer,
-		    br_multicast_query_delay_expired, 0);
+		    br_ip6_multicast_query_delay_expired, 0);
 	timer_setup(&brmctx->ip6_own_query.timer,
 		    br_ip6_multicast_query_expired, 0);
 #endif
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 8de0904b9627..f83c24def595 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -160,12 +160,14 @@ struct net_bridge_mcast {
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
-- 
2.50.1


