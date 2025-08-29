Return-Path: <netdev+bounces-218173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E387B3B689
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 10:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 129DF17C7FA
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 08:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA962D29C8;
	Fri, 29 Aug 2025 08:57:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A202BE7AD;
	Fri, 29 Aug 2025 08:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756457870; cv=none; b=C4b1JReCoxdeJPumdBAd+XBxs/ggPF6Gno7RoEa2R3435soSeZlW3Vp7TTlQi5Wsc1YNx8ewiBbmh+gLAEyVJqryZ0LFWx4qUukEvRJtWoDUxbaQbSFKBZdbbuTQbHpfTRrBIfZ0Iu7/Imo5DfqkS3cdxbMJm9zZunDg3n8Kqbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756457870; c=relaxed/simple;
	bh=5tBY9R2qfz2tgyChHYNEpEVjcvXKbQ/eJbvbCi6oHOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SW+5cyUMdibaGImcli4W6UNd6CdnD67U3hvyYvqsJUmrFhD4QuiHtpuzdcftEoWEgLxY9t3v3ND4yCVYXZG+AZn5KmKkrrjVSURCqgG5VLk+tfarePnY7ubXISn7Mdyh9EFAtfQSM8R2BSnY9Yh5uRMqOKTBBnctcqKVzfiowX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3BEDE54F6D1;
	Fri, 29 Aug 2025 10:57:45 +0200 (CEST)
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
Subject: [PATCH 8/9] net: bridge: mcast: track active state, bridge up/down
Date: Fri, 29 Aug 2025 10:53:49 +0200
Message-ID: <20250829085724.24230-9-linus.luessing@c0d3.blue>
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

This is mainly for switchdev and DSA later: To ensure that we switch
to inactive before destroying a bridge interface. A switchdev/DSA driver
might have allocated resources after we switched to an enabled multicast
active state. This gives switchdev/DSA drivers a chance to free these
resources again when we destroy the bridge (later).

Putting it into the ndo_stop / bridge interface down part instead of the
ndo_uninit / bridge destroy part though for a better semantic match. If
the bridge interface is down / stopped then it is also inactive.

No functional change for the fast/data path.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 include/uapi/linux/if_link.h |  8 ++++----
 net/bridge/br_device.c       |  3 +++
 net/bridge/br_multicast.c    | 26 ++++++++++++++++++++++----
 3 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index ef686ea17afe..76d15a07344d 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -746,14 +746,14 @@ enum in6_addr_gen_mode {
  * @IFLA_BR_MCAST_ACTIVE_V4
  *   Bridge IPv4 mcast active state, read only.
  *
- *   1 if *IFLA_BR_MCAST_SNOOPING* is enabled and an IGMP querier is present,
- *   0 otherwise.
+ *   1 if *IFLA_BR_MCAST_SNOOPING* is enabled, an IGMP querier is present
+ *   and the bridge interface is up, 0 otherwise.
  *
  * @IFLA_BR_MCAST_ACTIVE_V6
  *   Bridge IPv6 mcast active state, read only.
  *
- *   1 if *IFLA_BR_MCAST_SNOOPING* is enabled and an MLD querier is present,
- *   0 otherwise.
+ *   1 if *IFLA_BR_MCAST_SNOOPING* is enabled, an MLD querier is present
+ *   and the bridge interface is up, 0 otherwise.
  */
 enum {
 	IFLA_BR_UNSPEC,
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 3cdf1c17108b..efb5d35c2dd4 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
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
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 53720337a1e3..09e23e4d8b74 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1145,6 +1145,7 @@ static void br_ip6_multicast_update_active(struct net_bridge_mcast *brmctx,
  *
  * The multicast active state is set, per protocol family, if:
  *
+ * - the bridge interface is up
  * - multicast snooping is enabled
  * - an IGMP/MLD querier is present
  * - for own IPv6 MLD querier: an IPv6 address is configured on the bridge
@@ -1160,6 +1161,9 @@ static void br_multicast_update_active(struct net_bridge_mcast *brmctx)
 
 	lockdep_assert_held_once(&brmctx->br->multicast_lock);
 
+	if (!netif_running(brmctx->br->dev))
+		force_inactive = true;
+
 	if (!br_opt_get(brmctx->br, BROPT_MULTICAST_ENABLED))
 		force_inactive = true;
 
@@ -4379,6 +4383,9 @@ static void __br_multicast_open(struct net_bridge_mcast *brmctx)
 #if IS_ENABLED(CONFIG_IPV6)
 	__br_multicast_open_query(brmctx->br, &brmctx->ip6_own_query);
 #endif
+
+	/* bridge interface is up, maybe set multicast state to active */
+	br_multicast_update_active(brmctx);
 }
 
 void br_multicast_open(struct net_bridge *br)
@@ -4417,6 +4424,11 @@ static void __br_multicast_stop(struct net_bridge_mcast *brmctx)
 	timer_delete_sync(&brmctx->ip6_other_query.delay_timer);
 	timer_delete_sync(&brmctx->ip6_own_query.timer);
 #endif
+
+	spin_lock_bh(&brmctx->br->multicast_lock);
+	/* bridge interface is down, set multicast state to inactive */
+	br_multicast_update_active(brmctx);
+	spin_unlock_bh(&brmctx->br->multicast_lock);
 }
 
 void br_multicast_update_vlan_mcast_ctx(struct net_bridge_vlan *v, u8 state)
@@ -4469,10 +4481,13 @@ void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan, bool on)
 		br_multicast_update_active(&vlan->br_mcast_ctx);
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
 
@@ -4534,10 +4549,13 @@ int br_multicast_toggle_vlan_snooping(struct net_bridge *br, bool on,
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
 			br_multicast_disable_port_ctx(&p->multicast_ctx);
-- 
2.50.1


