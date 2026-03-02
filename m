Return-Path: <netdev+bounces-262506-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAh/Hz4jpWm14AUAu9opvQ
	(envelope-from <netdev+bounces-262506-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 06:42:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EC38F1D32B3
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 06:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 549BE302F405
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 05:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCE434F25E;
	Mon,  2 Mar 2026 05:41:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D80231A555;
	Mon,  2 Mar 2026 05:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772430062; cv=none; b=gdbQsK7OopZYLm1hvs203KD3taBWyIzAK1tB4qR1WFfJhxEnzeQbVXT1cKWFbtbQSyIMtYMk81mPg4g846fxqrsCH2azHhe7B8xYkVJi2IhUsCg0KPnK+u7FDDTmVt20dGbgnZhPCWIhMCBg7d7IBr5BPYHRUhgmRLsTspu2lpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772430062; c=relaxed/simple;
	bh=i/iWHXwkq65V9aBHtj3ovzHTCgNp7Fl6leBmNTOUJHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZhSZuQvRgHO/FGE5jYiK8Cd6E8LISuSdZW9/e1SaihQnqzPXhmrxY07W/SsRrS0G+dilh80GFa/EO66sQcO8Jwu0fEvwMSxfvlSmojy7vWhRPqcT/D5TerOxp0PntkdARtRe/QkyPacu9u6pnEupYzcnSE8QosuYFrRteOyxQUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3CE3D54CC66;
	Mon,  2 Mar 2026 06:40:58 +0100 (CET)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: bridge@lists.linux.dev
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
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
	shuah@kernel.org,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH net-next v3 13/14] net: bridge: mcast: use combined active state in fast/data path
Date: Mon,  2 Mar 2026 06:40:07 +0100
Message-ID: <20260302054008.21638-14-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260302054008.21638-1-linus.luessing@c0d3.blue>
References: <20260302054008.21638-1-linus.luessing@c0d3.blue>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262506-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[c0d3.blue];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.952];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linus.luessing@c0d3.blue,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,blackwall.org,nvidia.com,lunn.ch,kernel.org,redhat.com,google.com,davemloft.net,fomichev.me,gmail.com,c0d3.blue];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,c0d3.blue:mid,c0d3.blue:email]
X-Rspamd-Queue-Id: EC38F1D32B3
X-Rspamd-Action: no action

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
 net/bridge/br_device.c    |  3 ++-
 net/bridge/br_input.c     |  3 ++-
 net/bridge/br_multicast.c | 41 ++++++++++++++++++++++++++++++++++-----
 net/bridge/br_private.h   | 38 ++++++++----------------------------
 4 files changed, 48 insertions(+), 37 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index ee01122f466f..1ac363826b4c 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -102,7 +102,8 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 
 		mdst = br_mdb_entry_skb_get(brmctx, skb, vid);
 		if ((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
-		    br_multicast_querier_exists(brmctx, eth_hdr(skb), mdst))
+		    br_multicast_snooping_active(brmctx, eth_hdr(skb)->h_proto,
+						 mdst))
 			br_multicast_flood(mdst, skb, brmctx, false, true);
 		else
 			br_flood(br, skb, BR_PKT_MULTICAST, false, true, vid);
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 1405f1061a54..e79963e3d05f 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -187,7 +187,8 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 	case BR_PKT_MULTICAST:
 		mdst = br_mdb_entry_skb_get(brmctx, skb, vid);
 		if ((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
-		    br_multicast_querier_exists(brmctx, eth_hdr(skb), mdst)) {
+		    br_multicast_snooping_active(brmctx, eth_hdr(skb)->h_proto,
+						 mdst)) {
 			if ((mdst && mdst->host_joined) ||
 			    br_multicast_is_router(brmctx, skb) ||
 			    br->dev->flags & IFF_ALLMULTI) {
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 715a0e0aa5ad..4a1005bb68f1 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1067,6 +1067,26 @@ static struct sk_buff *br_ip4_multicast_alloc_query(struct net_bridge_mcast *brm
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
@@ -1079,6 +1099,21 @@ static bool br_ip6_multicast_querier_exists(struct net_bridge_mcast *brmctx)
 }
 #endif
 
+static bool
+br_multicast_querier_exists(struct net_bridge_mcast *brmctx, u16 proto)
+{
+	switch (proto) {
+	case ETH_P_IP:
+		return br_ip4_multicast_querier_exists(brmctx);
+#if IS_ENABLED(CONFIG_IPV6)
+	case ETH_P_IPV6:
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
@@ -5132,7 +5167,6 @@ bool br_multicast_has_querier_anywhere(struct net_device *dev, int proto)
 {
 	struct net_bridge *br;
 	struct net_bridge_port *port;
-	struct ethhdr eth;
 	bool ret = false;
 
 	rcu_read_lock();
@@ -5145,10 +5179,7 @@ bool br_multicast_has_querier_anywhere(struct net_device *dev, int proto)
 
 	br = port->br;
 
-	memset(&eth, 0, sizeof(eth));
-	eth.h_proto = htons(proto);
-
-	ret = br_multicast_querier_exists(&br->multicast_ctx, &eth, NULL);
+	ret = br_multicast_querier_exists(&br->multicast_ctx, proto);
 
 unlock:
 	rcu_read_unlock();
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 8150ecc2c919..75684f8079f2 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1159,37 +1159,15 @@ br_multicast_is_router(struct net_bridge_mcast *brmctx, struct sk_buff *skb)
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
+		return READ_ONCE(brmctx->ip4_active);
 #if IS_ENABLED(CONFIG_IPV6)
 	case (htons(ETH_P_IPV6)):
-		return __br_multicast_querier_exists(brmctx,
-			&brmctx->ip6_other_query, true);
+		return READ_ONCE(brmctx->ip6_active);
 #endif
 	default:
 		return !!mdb && br_group_is_l2(&mdb->addr);
@@ -1448,9 +1426,9 @@ static inline bool br_multicast_is_router(struct net_bridge_mcast *brmctx,
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
2.51.0


