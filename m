Return-Path: <netdev+bounces-257419-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJMXF7dZhWnNAQQAu9opvQ
	(envelope-from <netdev+bounces-257419-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 04:02:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03125F97FE
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 04:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC52C303AF05
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 03:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D26A2BE657;
	Fri,  6 Feb 2026 03:01:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7102BDC03;
	Fri,  6 Feb 2026 03:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770346901; cv=none; b=kkeQL4u5Ye5jJrwFCD0JCdMxzcnWV7fh95dzy77Om7PIyPJ4ePIkT4mRg5AUUeCSMPehUs7e6OPYjneFXug5x293bowaHnLGRqQJjvQabcXnzmInbvWwwRs3BuOAnHnVg2NMt8ytpctG4C44c82Z0Nde2o6qN/xv1CVVD/Vt92U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770346901; c=relaxed/simple;
	bh=vaXBTLkB4Z2pRlYzMhVUcT8igRLyx9ydo/WCecReO9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iLZtQf70CEplZEi9+oZfZMeos38oUWIVESWpNwBWo4GVYjuKcwSmwTI498yEO+ueblf+WiU47m2YXDj/0KspzfHZpwetJ+RsSXgYYlkeFBi6+jNd4mQZs9lNu8ZHXVOPCbQPQUBtlvbxnnZiQ/DV8yPz0rHVdbGt7lOycODH5a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C67D654CD34;
	Fri,  6 Feb 2026 04:01:38 +0100 (CET)
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
Subject: [PATCH net-next v2 03/14] net: bridge: mcast: avoid sleeping on bridge-down
Date: Fri,  6 Feb 2026 03:52:09 +0100
Message-ID: <20260206030123.5430-4-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260206030123.5430-1-linus.luessing@c0d3.blue>
References: <20260206030123.5430-1-linus.luessing@c0d3.blue>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257419-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[c0d3.blue];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.980];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linus.luessing@c0d3.blue,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,blackwall.org,nvidia.com,lunn.ch,kernel.org,redhat.com,google.com,davemloft.net,fomichev.me,gmail.com,c0d3.blue];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,c0d3.blue:mid,c0d3.blue:email]
X-Rspamd-Queue-Id: 03125F97FE
X-Rspamd-Action: no action

We later want to use the multicast lock when setting the bridge
interface up or down, to be able to atomically both check all conditions
to toggle the multicast active state and to subsequently toggle it.
While most variables we check / contexts we check from are serialized
(toggled variables through netlink/sysfs) the timer_pending() check is
not and might run in parallel.

However so far we are not allowed to spinlock __br_multicast_stop() as
its call to timer_delete_sync() might sleep. Therefore replacing the
sleeping variant with the non-sleeping one. It is sufficient to only
wait for any timer callback to finish when we are freeing the multicast
context.

Using the timer_shutdown() instead of the timer_delete() variant also
allows us to detect that we are stopping from within the according timer
callbacks, to retain the promise of the previous timer_delete_sync()
calls that no multicast state is changed after these
timer_{delete,shutdown}*() calls. And more importantly that we are not
inadvertently rearming timers.

This new check also makes the netif_running() check redundant/obsolete
in these contexts.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/bridge/br_device.c    |   4 ++
 net/bridge/br_multicast.c | 108 ++++++++++++++++++++++++++------------
 net/bridge/br_private.h   |   5 ++
 net/bridge/br_vlan.c      |   5 ++
 4 files changed, 87 insertions(+), 35 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index a818fdc22da9..d9d1227d5708 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -168,7 +168,9 @@ static int br_dev_open(struct net_device *dev)
 	netdev_update_features(dev);
 	netif_start_queue(dev);
 	br_stp_enable_bridge(br);
+	spin_lock_bh(&br->multicast_lock);
 	br_multicast_open(br);
+	spin_unlock_bh(&br->multicast_lock);
 
 	if (br_opt_get(br, BROPT_MULTICAST_ENABLED))
 		br_multicast_join_snoopers(br);
@@ -191,7 +193,9 @@ static int br_dev_stop(struct net_device *dev)
 	struct net_bridge *br = netdev_priv(dev);
 
 	br_stp_disable_bridge(br);
+	spin_lock_bh(&br->multicast_lock);
 	br_multicast_stop(br);
+	spin_unlock_bh(&br->multicast_lock);
 
 	if (br_opt_get(br, BROPT_MULTICAST_ENABLED))
 		br_multicast_leave_snoopers(br);
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index dccae08b4f4c..f5a368dd20a3 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1665,6 +1665,14 @@ static void br_multicast_router_expired(struct net_bridge_mcast_port *pmctx,
 	spin_unlock(&br->multicast_lock);
 }
 
+static bool br_multicast_stopping(struct net_bridge *br,
+				  struct timer_list *timer)
+{
+	lockdep_assert_held_once(&br->multicast_lock);
+
+	return !timer->function;
+}
+
 static void br_ip4_multicast_router_expired(struct timer_list *t)
 {
 	struct net_bridge_mcast_port *pmctx = timer_container_of(pmctx, t,
@@ -1700,7 +1708,8 @@ static void br_multicast_local_router_expired(struct net_bridge_mcast *brmctx,
 					      struct timer_list *timer)
 {
 	spin_lock(&brmctx->br->multicast_lock);
-	if (brmctx->multicast_router == MDB_RTR_TYPE_DISABLED ||
+	if (br_multicast_stopping(brmctx->br, timer) ||
+	    brmctx->multicast_router == MDB_RTR_TYPE_DISABLED ||
 	    brmctx->multicast_router == MDB_RTR_TYPE_PERM ||
 	    br_ip4_multicast_is_router(brmctx) ||
 	    br_ip6_multicast_is_router(brmctx))
@@ -1730,10 +1739,11 @@ static void br_ip6_multicast_local_router_expired(struct timer_list *t)
 #endif
 
 static void br_multicast_querier_expired(struct net_bridge_mcast *brmctx,
-					 struct bridge_mcast_own_query *query)
+					 struct bridge_mcast_own_query *query,
+					 struct timer_list *timer)
 {
 	spin_lock(&brmctx->br->multicast_lock);
-	if (!netif_running(brmctx->br->dev) ||
+	if (br_multicast_stopping(brmctx->br, timer) ||
 	    br_multicast_ctx_vlan_global_disabled(brmctx) ||
 	    !br_opt_get(brmctx->br, BROPT_MULTICAST_ENABLED))
 		goto out;
@@ -1749,7 +1759,7 @@ static void br_ip4_multicast_querier_expired(struct timer_list *t)
 	struct net_bridge_mcast *brmctx = timer_container_of(brmctx, t,
 							     ip4_other_query.timer);
 
-	br_multicast_querier_expired(brmctx, &brmctx->ip4_own_query);
+	br_multicast_querier_expired(brmctx, &brmctx->ip4_own_query, t);
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
@@ -1758,7 +1768,7 @@ static void br_ip6_multicast_querier_expired(struct timer_list *t)
 	struct net_bridge_mcast *brmctx = timer_container_of(brmctx, t,
 							     ip6_other_query.timer);
 
-	br_multicast_querier_expired(brmctx, &brmctx->ip6_own_query);
+	br_multicast_querier_expired(brmctx, &brmctx->ip6_own_query, t);
 }
 #endif
 
@@ -4049,10 +4059,12 @@ int br_multicast_rcv(struct net_bridge_mcast **brmctx,
 }
 
 static void br_multicast_query_expired(struct net_bridge_mcast *brmctx,
-				       struct bridge_mcast_own_query *query)
+				       struct bridge_mcast_own_query *query,
+				       struct timer_list *timer)
 {
 	spin_lock(&brmctx->br->multicast_lock);
-	if (br_multicast_ctx_vlan_disabled(brmctx))
+	if (br_multicast_stopping(brmctx->br, timer) ||
+	    br_multicast_ctx_vlan_disabled(brmctx))
 		goto out;
 
 	if (query->startup_sent < brmctx->multicast_startup_query_count)
@@ -4068,7 +4080,7 @@ static void br_ip4_multicast_query_expired(struct timer_list *t)
 	struct net_bridge_mcast *brmctx = timer_container_of(brmctx, t,
 							     ip4_own_query.timer);
 
-	br_multicast_query_expired(brmctx, &brmctx->ip4_own_query);
+	br_multicast_query_expired(brmctx, &brmctx->ip4_own_query, t);
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
@@ -4077,7 +4089,7 @@ static void br_ip6_multicast_query_expired(struct timer_list *t)
 	struct net_bridge_mcast *brmctx = timer_container_of(brmctx, t,
 							     ip6_own_query.timer);
 
-	br_multicast_query_expired(brmctx, &brmctx->ip6_own_query);
+	br_multicast_query_expired(brmctx, &brmctx->ip6_own_query, t);
 }
 #endif
 
@@ -4120,29 +4132,30 @@ void br_multicast_ctx_init(struct net_bridge *br,
 	seqcount_spinlock_init(&brmctx->ip6_querier.seq, &br->multicast_lock);
 #endif
 
-	timer_setup(&brmctx->ip4_mc_router_timer,
-		    br_ip4_multicast_local_router_expired, 0);
-	timer_setup(&brmctx->ip4_other_query.timer,
-		    br_ip4_multicast_querier_expired, 0);
-	timer_setup(&brmctx->ip4_other_query.delay_timer,
-		    br_multicast_query_delay_expired, 0);
-	timer_setup(&brmctx->ip4_own_query.timer,
-		    br_ip4_multicast_query_expired, 0);
+	timer_setup(&brmctx->ip4_mc_router_timer, NULL, 0);
+	timer_setup(&brmctx->ip4_other_query.timer, NULL, 0);
+	timer_setup(&brmctx->ip4_other_query.delay_timer, NULL, 0);
+	timer_setup(&brmctx->ip4_own_query.timer, NULL, 0);
 #if IS_ENABLED(CONFIG_IPV6)
-	timer_setup(&brmctx->ip6_mc_router_timer,
-		    br_ip6_multicast_local_router_expired, 0);
-	timer_setup(&brmctx->ip6_other_query.timer,
-		    br_ip6_multicast_querier_expired, 0);
-	timer_setup(&brmctx->ip6_other_query.delay_timer,
-		    br_multicast_query_delay_expired, 0);
-	timer_setup(&brmctx->ip6_own_query.timer,
-		    br_ip6_multicast_query_expired, 0);
+	timer_setup(&brmctx->ip6_mc_router_timer, NULL, 0);
+	timer_setup(&brmctx->ip6_other_query.timer, NULL, 0);
+	timer_setup(&brmctx->ip6_other_query.delay_timer, NULL, 0);
+	timer_setup(&brmctx->ip6_own_query.timer, NULL, 0);
 #endif
 }
 
 void br_multicast_ctx_deinit(struct net_bridge_mcast *brmctx)
 {
-	__br_multicast_stop(brmctx);
+	timer_shutdown_sync(&brmctx->ip4_mc_router_timer);
+	timer_shutdown_sync(&brmctx->ip4_other_query.timer);
+	timer_shutdown_sync(&brmctx->ip4_other_query.delay_timer);
+	timer_shutdown_sync(&brmctx->ip4_own_query.timer);
+#if IS_ENABLED(CONFIG_IPV6)
+	timer_shutdown_sync(&brmctx->ip6_mc_router_timer);
+	timer_shutdown_sync(&brmctx->ip6_other_query.timer);
+	timer_shutdown_sync(&brmctx->ip6_other_query.delay_timer);
+	timer_shutdown_sync(&brmctx->ip6_own_query.timer);
+#endif
 }
 
 void br_multicast_init(struct net_bridge *br)
@@ -4222,9 +4235,27 @@ void br_multicast_leave_snoopers(struct net_bridge *br)
 	br_ip6_multicast_leave_snoopers(br);
 }
 
+void br_multicast_reset_timer_cbs(struct net_bridge_mcast *brmctx)
+{
+	lockdep_assert_held_once(&brmctx->br->multicast_lock);
+
+	brmctx->ip4_mc_router_timer.function = br_ip4_multicast_local_router_expired;
+	brmctx->ip4_other_query.timer.function = br_ip4_multicast_querier_expired;
+	brmctx->ip4_other_query.delay_timer.function = br_multicast_query_delay_expired;
+	brmctx->ip4_own_query.timer.function = br_ip4_multicast_query_expired;
+#if IS_ENABLED(CONFIG_IPV6)
+	brmctx->ip6_mc_router_timer.function = br_ip6_multicast_local_router_expired;
+	brmctx->ip6_other_query.timer.function = br_ip6_multicast_querier_expired;
+	brmctx->ip6_other_query.delay_timer.function = br_multicast_query_delay_expired;
+	brmctx->ip6_own_query.timer.function = br_ip6_multicast_query_expired;
+#endif
+}
+
 static void __br_multicast_open_query(struct net_bridge *br,
 				      struct bridge_mcast_own_query *query)
 {
+	lockdep_assert_held_once(&br->multicast_lock);
+
 	query->startup_sent = 0;
 
 	if (!br_opt_get(br, BROPT_MULTICAST_ENABLED))
@@ -4235,6 +4266,8 @@ static void __br_multicast_open_query(struct net_bridge *br,
 
 static void __br_multicast_open(struct net_bridge_mcast *brmctx)
 {
+	br_multicast_reset_timer_cbs(brmctx);
+
 	__br_multicast_open_query(brmctx->br, &brmctx->ip4_own_query);
 #if IS_ENABLED(CONFIG_IPV6)
 	__br_multicast_open_query(brmctx->br, &brmctx->ip6_own_query);
@@ -4267,15 +4300,17 @@ void br_multicast_open(struct net_bridge *br)
 
 static void __br_multicast_stop(struct net_bridge_mcast *brmctx)
 {
-	timer_delete_sync(&brmctx->ip4_mc_router_timer);
-	timer_delete_sync(&brmctx->ip4_other_query.timer);
-	timer_delete_sync(&brmctx->ip4_other_query.delay_timer);
-	timer_delete_sync(&brmctx->ip4_own_query.timer);
+	lockdep_assert_held_once(&brmctx->br->multicast_lock);
+
+	timer_shutdown(&brmctx->ip4_mc_router_timer);
+	timer_shutdown(&brmctx->ip4_other_query.timer);
+	timer_shutdown(&brmctx->ip4_other_query.delay_timer);
+	timer_shutdown(&brmctx->ip4_own_query.timer);
 #if IS_ENABLED(CONFIG_IPV6)
-	timer_delete_sync(&brmctx->ip6_mc_router_timer);
-	timer_delete_sync(&brmctx->ip6_other_query.timer);
-	timer_delete_sync(&brmctx->ip6_other_query.delay_timer);
-	timer_delete_sync(&brmctx->ip6_own_query.timer);
+	timer_shutdown(&brmctx->ip6_mc_router_timer);
+	timer_shutdown(&brmctx->ip6_other_query.timer);
+	timer_shutdown(&brmctx->ip6_other_query.delay_timer);
+	timer_shutdown(&brmctx->ip6_own_query.timer);
 #endif
 }
 
@@ -4326,12 +4361,12 @@ void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan, bool on)
 
 		spin_lock_bh(&br->multicast_lock);
 		vlan->priv_flags ^= BR_VLFLAG_MCAST_ENABLED;
-		spin_unlock_bh(&br->multicast_lock);
 
 		if (on)
 			__br_multicast_open(&vlan->br_mcast_ctx);
 		else
 			__br_multicast_stop(&vlan->br_mcast_ctx);
+		spin_unlock_bh(&br->multicast_lock);
 	} else {
 		struct net_bridge_mcast *brmctx;
 
@@ -4389,6 +4424,7 @@ int br_multicast_toggle_vlan_snooping(struct net_bridge *br, bool on,
 	if (!vg)
 		return 0;
 
+	spin_lock_bh(&br->multicast_lock);
 	br_opt_toggle(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED, on);
 
 	/* disable/enable non-vlan mcast contexts based on vlan snooping */
@@ -4396,6 +4432,8 @@ int br_multicast_toggle_vlan_snooping(struct net_bridge *br, bool on,
 		__br_multicast_stop(&br->multicast_ctx);
 	else
 		__br_multicast_open(&br->multicast_ctx);
+	spin_unlock_bh(&br->multicast_lock);
+
 	list_for_each_entry(p, &br->port_list, list) {
 		if (on)
 			br_multicast_disable_port_ctx(&p->multicast_ctx);
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 4ab6a1f58116..a181a27aa559 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -976,6 +976,7 @@ void br_multicast_disable_port(struct net_bridge_port *port);
 void br_multicast_init(struct net_bridge *br);
 void br_multicast_join_snoopers(struct net_bridge *br);
 void br_multicast_leave_snoopers(struct net_bridge *br);
+void br_multicast_reset_timer_cbs(struct net_bridge_mcast *brmctx);
 void br_multicast_open(struct net_bridge *br);
 void br_multicast_stop(struct net_bridge *br);
 void br_multicast_dev_del(struct net_bridge *br);
@@ -1416,6 +1417,10 @@ static inline void br_multicast_leave_snoopers(struct net_bridge *br)
 {
 }
 
+static inline void br_multicast_reset_timer_cbs(struct net_bridge_mcast *brmctx)
+{
+}
+
 static inline void br_multicast_open(struct net_bridge *br)
 {
 }
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index ce72b837ff8e..7b46aa517c28 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -325,7 +325,12 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 flags,
 			if (err && err != -EOPNOTSUPP)
 				goto out;
 		}
+
 		br_multicast_ctx_init(br, v, &v->br_mcast_ctx);
+
+		spin_lock_bh(&br->multicast_lock);
+		br_multicast_reset_timer_cbs(&v->br_mcast_ctx);
+		spin_unlock_bh(&br->multicast_lock);
 		v->priv_flags |= BR_VLFLAG_GLOBAL_MCAST_ENABLED;
 	}
 
-- 
2.51.0


