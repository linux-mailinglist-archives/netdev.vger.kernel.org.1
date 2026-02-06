Return-Path: <netdev+bounces-257420-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AKBOGRahWnNAQQAu9opvQ
	(envelope-from <netdev+bounces-257420-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 04:05:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5C1F986D
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 04:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58C4730515E7
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 03:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FCE2C0F90;
	Fri,  6 Feb 2026 03:01:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F212B2C0296;
	Fri,  6 Feb 2026 03:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770346902; cv=none; b=ah27GQaYHP3FLOBVNCb/FEYJ+0kyV4+CU+MgZUlGU5tNCd53NfhiCeSzOfLVvfTHGVodMggV2+bkzTTI3S1ZIpkE+dPiLbPgrVb9wLclpz+ZaYGRqIzT4X8NZoxMcPlf1uTQxh9LMKymZXWr80LsxGoMamYrsRFu2gwsyjDjiaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770346902; c=relaxed/simple;
	bh=kVnU6LvcqcZqte6YJ6dvQptVsfkAonGMRkCUq5g1HL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KXQTZdV+8GyGOsXLc3DBcEdD9SqViqLncIYw46L2fQstuKMlJyh47uFme4fnS41NJwKwSlumfLvia4toTzfoJie9+Ua97ESuHLnDICZbyU7VFGuKKQlqBxffYmloAYJSNhypg26y3ehlDR3yUeLovO8J4vpAw3yC9fpY9YaphnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DCC4354CD37;
	Fri,  6 Feb 2026 04:01:39 +0100 (CET)
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
Subject: [PATCH net-next v2 04/14] net: bridge: mcast: track active state, IGMP/MLD querier appearance
Date: Fri,  6 Feb 2026 03:52:10 +0100
Message-ID: <20260206030123.5430-5-linus.luessing@c0d3.blue>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257420-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.977];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linus.luessing@c0d3.blue,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,blackwall.org,nvidia.com,lunn.ch,kernel.org,redhat.com,google.com,davemloft.net,fomichev.me,gmail.com,c0d3.blue];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[c0d3.blue:mid,c0d3.blue:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B5C1F986D
X-Rspamd-Action: no action

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
 net/bridge/br_multicast.c | 109 ++++++++++++++++++++++++++++++++++++--
 net/bridge/br_private.h   |   2 +
 2 files changed, 108 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index f5a368dd20a3..d5c623dce7eb 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1069,6 +1069,81 @@ static struct sk_buff *br_ip4_multicast_alloc_query(struct net_bridge_mcast *brm
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
+static void br_multicast_notify_active(struct net_bridge_mcast *brmctx,
+				       bool ip4_active_old, bool ip6_active_old)
+{
+	if (brmctx->ip4_active == ip4_active_old &&
+	    brmctx->ip6_active == ip6_active_old)
+		return;
+
+	br_info(brmctx->br, "mc_active changed, vid: %i: v4: %i->%i, v6: %i->%i\n",
+		brmctx->vlan ? brmctx->vlan->vid : -1,
+		ip4_active_old, brmctx->ip4_active,
+		ip6_active_old, brmctx->ip6_active);
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
+	bool ip4_active_old = brmctx->ip4_active, ip6_active_old = brmctx->ip6_active;
+	bool force_inactive = false;
+
+	lockdep_assert_held_once(&brmctx->br->multicast_lock);
+
+	br_ip4_multicast_update_active(brmctx, force_inactive);
+	br_ip6_multicast_update_active(brmctx, force_inactive);
+
+	br_multicast_notify_active(brmctx, ip4_active_old, ip6_active_old);
+}
+
 #if IS_ENABLED(CONFIG_IPV6)
 static struct sk_buff *br_ip6_multicast_alloc_query(struct net_bridge_mcast *brmctx,
 						    struct net_bridge_mcast_port *pmctx,
@@ -1772,10 +1847,36 @@ static void br_ip6_multicast_querier_expired(struct timer_list *t)
 }
 #endif
 
-static void br_multicast_query_delay_expired(struct timer_list *t)
+static void br_ip4_multicast_query_delay_expired(struct timer_list *t)
 {
+	struct net_bridge_mcast *brmctx = timer_container_of(brmctx, t,
+							     ip4_other_query.delay_timer);
+
+	spin_lock(&brmctx->br->multicast_lock);
+	if (!br_multicast_stopping(brmctx->br, t))
+		/* an own or other IGMP querier appeared some seconds ago and all
+		 * reports should have arrived by now, maybe set multicast state to active
+		 */
+		br_multicast_update_active(brmctx);
+	spin_unlock(&brmctx->br->multicast_lock);
 }
 
+#if IS_ENABLED(CONFIG_IPV6)
+static void br_ip6_multicast_query_delay_expired(struct timer_list *t)
+{
+	struct net_bridge_mcast *brmctx = timer_container_of(brmctx, t,
+							     ip6_other_query.delay_timer);
+
+	spin_lock(&brmctx->br->multicast_lock);
+	if (!br_multicast_stopping(brmctx->br, t))
+		/* an own or other MLD querier appeared some seconds ago and all
+		 * reports should have arrived, maybe set multicast state to active
+		 */
+		br_multicast_update_active(brmctx);
+	spin_unlock(&brmctx->br->multicast_lock);
+}
+#endif
+
 static void br_multicast_select_own_querier(struct net_bridge_mcast *brmctx,
 					    struct br_ip *ip,
 					    struct sk_buff *skb)
@@ -4124,11 +4225,13 @@ void br_multicast_ctx_init(struct net_bridge *br,
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
 
@@ -4241,12 +4344,12 @@ void br_multicast_reset_timer_cbs(struct net_bridge_mcast *brmctx)
 
 	brmctx->ip4_mc_router_timer.function = br_ip4_multicast_local_router_expired;
 	brmctx->ip4_other_query.timer.function = br_ip4_multicast_querier_expired;
-	brmctx->ip4_other_query.delay_timer.function = br_multicast_query_delay_expired;
+	brmctx->ip4_other_query.delay_timer.function = br_ip4_multicast_query_delay_expired;
 	brmctx->ip4_own_query.timer.function = br_ip4_multicast_query_expired;
 #if IS_ENABLED(CONFIG_IPV6)
 	brmctx->ip6_mc_router_timer.function = br_ip6_multicast_local_router_expired;
 	brmctx->ip6_other_query.timer.function = br_ip6_multicast_querier_expired;
-	brmctx->ip6_other_query.delay_timer.function = br_multicast_query_delay_expired;
+	brmctx->ip6_other_query.delay_timer.function = br_ip6_multicast_query_delay_expired;
 	brmctx->ip6_own_query.timer.function = br_ip6_multicast_query_expired;
 #endif
 }
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index a181a27aa559..4cc59abdb8e1 100644
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
2.51.0


