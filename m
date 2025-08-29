Return-Path: <netdev+bounces-218174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B87B3B68C
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 10:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A608466D80
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 08:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6846F2D3EDD;
	Fri, 29 Aug 2025 08:57:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F362C3271;
	Fri, 29 Aug 2025 08:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756457872; cv=none; b=e00g3JBAeKQgtOapD97/XBGaLWPxDOeUKYveVRBQ61qlWgUd/LZyZ/gwBSHrpptpmV3S/ZeEc9Ncp+G8Xjd8WA9+EgKC7gtkf/af4IfsLAYGTuVUryWjA5YnE/MCT6CYfUvnlGKWiTm4FkKj1UmBt2yypDSQoKhygxDZN+3IEV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756457872; c=relaxed/simple;
	bh=XF9aiog0YNLpl5STE1KJ16Lm0Irt3eXp+klTmcIRsnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ujs0YAIAHjaGS8aUhQqQyAAArATn9RkC/DprV5a5ocxJjvo7Dje3Y8ALoIMs2fbY9cHxQsf6mXQVXSb8CG77Z0KrYVPxJNYb3WpYBWjbm7AU/YEuX9G1vscQqUBdpYm/lkQK25EHqEKz/WrKsCR3MDsbSMwyR8yn1Am5YEldACg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8120054F65B;
	Fri, 29 Aug 2025 10:57:46 +0200 (CEST)
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
Subject: [PATCH 9/9] net: bridge: mcast: add inactive state assertions
Date: Fri, 29 Aug 2025 10:53:50 +0200
Message-ID: <20250829085724.24230-10-linus.luessing@c0d3.blue>
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

To avoid packetloss and as it is very hard from a user's perspective to
debug multicast snooping related issues it is even more crucial to properly
switch from an active to an inactive multicast snooping state than the
other way around.

Therefore adding a few kernel warnings if any of our assertions to be in
an inactive state would fail.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/bridge/br_multicast.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 09e23e4d8b74..46161e707fc5 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1383,10 +1383,29 @@ static struct sk_buff *br_multicast_alloc_query(struct net_bridge_mcast *brmctx,
 	return NULL;
 }
 
+static void br_ip4_multicast_assert_inactive(struct net_bridge_mcast *brmctx)
+{
+	WARN_ON(br_multicast_snooping_active(brmctx, htons(ETH_P_IP), NULL));
+}
+
+static void br_ip6_multicast_assert_inactive(struct net_bridge_mcast *brmctx)
+{
+	WARN_ON(br_multicast_snooping_active(brmctx, htons(ETH_P_IPV6), NULL));
+}
+
+static void br_multicast_assert_inactive(struct net_bridge_mcast *brmctx)
+{
+	br_ip4_multicast_assert_inactive(brmctx);
+	br_ip6_multicast_assert_inactive(brmctx);
+}
+
 static void br_multicast_toggle_enabled(struct net_bridge *br, bool on)
 {
 	br_opt_toggle(br, BROPT_MULTICAST_ENABLED, on);
 	br_multicast_update_active(&br->multicast_ctx);
+
+	if (!on)
+		br_multicast_assert_inactive(&br->multicast_ctx);
 }
 
 struct net_bridge_mdb_entry *br_multicast_new_group(struct net_bridge *br,
@@ -1846,7 +1865,6 @@ static void br_ip6_multicast_local_router_expired(struct timer_list *t)
 static void br_multicast_querier_expired(struct net_bridge_mcast *brmctx,
 					 struct bridge_mcast_own_query *query)
 {
-	spin_lock(&brmctx->br->multicast_lock);
 	if (!netif_running(brmctx->br->dev) ||
 	    br_multicast_ctx_vlan_global_disabled(brmctx) ||
 	    !br_opt_get(brmctx->br, BROPT_MULTICAST_ENABLED))
@@ -1859,7 +1877,6 @@ static void br_multicast_querier_expired(struct net_bridge_mcast *brmctx,
 	 * if our own querier is disabled, too
 	 */
 	br_multicast_update_active(brmctx);
-	spin_unlock(&brmctx->br->multicast_lock);
 }
 
 static void br_ip4_multicast_querier_expired(struct timer_list *t)
@@ -1867,7 +1884,12 @@ static void br_ip4_multicast_querier_expired(struct timer_list *t)
 	struct net_bridge_mcast *brmctx = timer_container_of(brmctx, t,
 							     ip4_other_query.timer);
 
+	spin_lock(&brmctx->br->multicast_lock);
 	br_multicast_querier_expired(brmctx, &brmctx->ip4_own_query);
+
+	if (!brmctx->multicast_querier)
+		br_ip4_multicast_assert_inactive(brmctx);
+	spin_unlock(&brmctx->br->multicast_lock);
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
@@ -1876,7 +1898,12 @@ static void br_ip6_multicast_querier_expired(struct timer_list *t)
 	struct net_bridge_mcast *brmctx = timer_container_of(brmctx, t,
 							     ip6_other_query.timer);
 
+	spin_lock(&brmctx->br->multicast_lock);
 	br_multicast_querier_expired(brmctx, &brmctx->ip6_own_query);
+
+	if (!brmctx->multicast_querier)
+		br_ip6_multicast_assert_inactive(brmctx);
+	spin_unlock(&brmctx->br->multicast_lock);
 }
 #endif
 
@@ -4428,6 +4455,7 @@ static void __br_multicast_stop(struct net_bridge_mcast *brmctx)
 	spin_lock_bh(&brmctx->br->multicast_lock);
 	/* bridge interface is down, set multicast state to inactive */
 	br_multicast_update_active(brmctx);
+	br_multicast_assert_inactive(brmctx);
 	spin_unlock_bh(&brmctx->br->multicast_lock);
 }
 
@@ -4479,6 +4507,8 @@ void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan, bool on)
 		spin_lock_bh(&br->multicast_lock);
 		vlan->priv_flags ^= BR_VLFLAG_MCAST_ENABLED;
 		br_multicast_update_active(&vlan->br_mcast_ctx);
+		if (!on)
+			br_multicast_assert_inactive(&vlan->br_mcast_ctx);
 		spin_unlock_bh(&br->multicast_lock);
 
 		if (on) {
@@ -4503,6 +4533,8 @@ void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan, bool on)
 		else
 			__br_multicast_disable_port_ctx(&vlan->port_mcast_ctx);
 		br_multicast_update_active(brmctx);
+		if (!on)
+			br_multicast_assert_inactive(brmctx);
 		spin_unlock_bh(&br->multicast_lock);
 	}
 }
-- 
2.50.1


