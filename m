Return-Path: <netdev+bounces-192833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE53DAC1547
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 22:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF2351C002CB
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 20:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD8E2BF3C0;
	Thu, 22 May 2025 20:07:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E451EDA39;
	Thu, 22 May 2025 20:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747944432; cv=none; b=meAHmB8EJsdeNRmWKbduvlzUlYYXDlV/lc+ZKmQAqgmqqDrkLDm/OyuQzi0I7YzPW6SRCi14ZGcDVq+kS8PLJI0qYHUuThq1Kfm8SbTZ5GxU+th1xbUQ6TENYGS3iC4GPYWKTLiPdpJzuNRTzSu/PvimBrEFN1SgLeZwf2KmMb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747944432; c=relaxed/simple;
	bh=lmBoQ/gPJgZcboY70w1KOBKnRRGTwaPAWQ776rYMWU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V9t3hDaGpGAqOGE37ciOhEPe28zXLBhCVJNqPM8hVyom3nf9YYHGKa3l13QyPXprt44dtN6QyG2X+iMJv+gV5ExmyZiKmxzzufNgOaepcHZHQqC7thHJwhPzIdXbfCV/CCp9EjaV/Fzis9GNmlOfAOsLWq6/i97/eVzaOOTaJA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BF2BC54E72E;
	Thu, 22 May 2025 22:00:13 +0200 (CEST)
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
Subject: [PATCH net-next 3/5] net: bridge: mcast: check if snooping is enabled for active state
Date: Thu, 22 May 2025 21:17:05 +0200
Message-ID: <20250522195952.29265-4-linus.luessing@c0d3.blue>
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

To be able to use the upcoming SWITCHDEV_ATTR_ID_BRIDGE_MC_ACTIVE
as a potential replacement for SWITCHDEV_ATTR_ID_BRIDGE_MC_DISABLED
also check and toggle the active state if multicast snooping is enabled
or disabled. So that MC_ACTIVE not only checks the querier state, but
also if multicast snooping is enabled in general.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 include/uapi/linux/if_link.h |  6 ++++--
 net/bridge/br_multicast.c    | 35 +++++++++++++++++++++++++++++++++--
 2 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 41f6c461ab32..479d039477cb 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -746,12 +746,14 @@ enum in6_addr_gen_mode {
  * @IFLA_BR_MCAST_ACTIVE_V4
  *   Bridge IPv4 mcast active state, read only.
  *
- *   1 if an IGMP querier is present, 0 otherwise.
+ *   1 if *IFLA_BR_MCAST_SNOOPING* is enabled and an IGMP querier is present,
+ *   0 otherwise.
  *
  * @IFLA_BR_MCAST_ACTIVE_V6
  *   Bridge IPv4 mcast active state, read only.
  *
- *   1 if an MLD querier is present, 0 otherwise.
+ *   1 if *IFLA_BR_MCAST_SNOOPING* is enabled and an MLD querier is present,
+ *   0 otherwise.
  */
 enum {
 	IFLA_BR_UNSPEC,
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index b66d2173e321..0bbaa21c1479 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1150,6 +1150,7 @@ static int br_ip6_multicast_check_active(struct net_bridge_mcast *brmctx,
  *
  * The multicast active state is set, per protocol family, if:
  *
+ * - multicast snooping is enabled
  * - an IGMP/MLD querier is present
  * - for own IPv6 MLD querier: an IPv6 address is configured on the bridge
  *
@@ -1169,6 +1170,13 @@ static int __br_multicast_update_active(struct net_bridge_mcast *brmctx,
 
 	lockdep_assert_held_once(&brmctx->br->multicast_lock);
 
+	if (!br_opt_get(brmctx->br, BROPT_MULTICAST_ENABLED))
+		force_inactive = true;
+
+	if (br_opt_get(brmctx->br, BROPT_MCAST_VLAN_SNOOPING_ENABLED) &&
+	    br_multicast_ctx_vlan_disabled(brmctx))
+		force_inactive = true;
+
 	ip4_active = !force_inactive;
 	ip6_active = !force_inactive;
 	ip4_changed = br_ip4_multicast_check_active(brmctx, &ip4_active);
@@ -1396,6 +1404,22 @@ static struct sk_buff *br_multicast_alloc_query(struct net_bridge_mcast *brmctx,
 	return NULL;
 }
 
+static int br_multicast_toggle_enabled(struct net_bridge *br, bool on,
+				       struct netlink_ext_ack *extack)
+{
+	int err, old;
+
+	br_opt_toggle(br, BROPT_MULTICAST_ENABLED, on);
+
+	err = br_multicast_update_active(&br->multicast_ctx, extack);
+	if (err && err != -EOPNOTSUPP) {
+		br_opt_toggle(br, BROPT_MULTICAST_ENABLED, old);
+		return err;
+	}
+
+	return 0;
+}
+
 struct net_bridge_mdb_entry *br_multicast_new_group(struct net_bridge *br,
 						    struct br_ip *group)
 {
@@ -1409,7 +1433,7 @@ struct net_bridge_mdb_entry *br_multicast_new_group(struct net_bridge *br,
 	if (atomic_read(&br->mdb_hash_tbl.nelems) >= br->hash_max) {
 		trace_br_mdb_full(br->dev, group);
 		br_mc_disabled_update(br->dev, false, NULL);
-		br_opt_toggle(br, BROPT_MULTICAST_ENABLED, false);
+		br_multicast_toggle_enabled(br, false, NULL);
 		return ERR_PTR(-E2BIG);
 	}
 
@@ -4382,6 +4406,7 @@ void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan, bool on)
 
 		spin_lock_bh(&br->multicast_lock);
 		vlan->priv_flags ^= BR_VLFLAG_MCAST_ENABLED;
+		br_multicast_update_active(&vlan->br_mcast_ctx, NULL);
 		spin_unlock_bh(&br->multicast_lock);
 
 		if (on) {
@@ -4405,6 +4430,7 @@ void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan, bool on)
 			__br_multicast_enable_port_ctx(&vlan->port_mcast_ctx);
 		else
 			__br_multicast_disable_port_ctx(&vlan->port_mcast_ctx);
+		br_multicast_update_active(brmctx, NULL);
 		spin_unlock_bh(&br->multicast_lock);
 	}
 }
@@ -4728,7 +4754,12 @@ int br_multicast_toggle(struct net_bridge *br, unsigned long val,
 	if (err)
 		goto unlock;
 
-	br_opt_toggle(br, BROPT_MULTICAST_ENABLED, !!val);
+	err = br_multicast_toggle_enabled(br, !!val, extack);
+	if (err == -EOPNOTSUPP)
+		err = 0;
+	if (err)
+		goto unlock;
+
 	if (!br_opt_get(br, BROPT_MULTICAST_ENABLED)) {
 		change_snoopers = true;
 		goto unlock;
-- 
2.49.0


