Return-Path: <netdev+bounces-192834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2165AC154D
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 22:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC2CB167198
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 20:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040642BF3EB;
	Thu, 22 May 2025 20:07:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0194E205ABA;
	Thu, 22 May 2025 20:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747944432; cv=none; b=TlHqrTWWKcpACAJaBu53SIjDVbJkOiEEz8ieUNZZSI+j09S9ffaDQFIwWlVlwE0rkegcWujtzwftaum7fNXRjY+DpKhOLTmPQpk67wUfLV/ILS0Js/cd+Q2PLjliA3vZrSeT0QkauVsq8UnwJ2VTzRQksLcdIrPiWF8a1g6FYJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747944432; c=relaxed/simple;
	bh=MfyhvWwk+ZdZvfOBo/EVjnY5vkPIZsIGtuQ8bygKPT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQxxOcY5hL2aNe3Xy6etvslHXtPp1+zzTxpC6eTNswkgC4cIFJ2rX01FTa9Z0aXAUeY96I1PnfdcNRUomwEJHY6YL1kz3y7rOPrDJdfsv3bc9Lwfd4MvkUAPGU2FMYfxWqL0cyCHQBjLw/EHPHDahvRfZY6SuvrZo3t+nggKGHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EC8D054E731;
	Thu, 22 May 2025 22:00:14 +0200 (CEST)
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
Subject: [PATCH net-next 4/5] net: bridge: switchdev: notify on mcast active changes
Date: Thu, 22 May 2025 21:17:06 +0200
Message-ID: <20250522195952.29265-5-linus.luessing@c0d3.blue>
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

Let the bridge notify switchdev if the multicast
active state toggles. So that switch drivers can act on it
accordingly, especially to avoid packetloss.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 Documentation/networking/switchdev.rst |  8 +++----
 include/net/switchdev.h                | 10 ++++++++
 net/bridge/br_multicast.c              | 33 ++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/switchdev.rst b/Documentation/networking/switchdev.rst
index 2966b7122f05..130f7a36fc73 100644
--- a/Documentation/networking/switchdev.rst
+++ b/Documentation/networking/switchdev.rst
@@ -558,7 +558,7 @@ Because IGMP snooping can be turned on/off at runtime, the switchdev driver
 must be able to reconfigure the underlying hardware on the fly to honor the
 toggling of that option and behave appropriately.
 
-A switchdev driver can also refuse to support dynamic toggling of the multicast
-snooping knob at runtime and require the destruction of the bridge device(s)
-and creation of a new bridge device(s) with a different multicast snooping
-value.
+A switchdev driver must also be able to react to vanishing or appearing
+IGMP/MLD queriers. If no querier is present then, even if IGMP/MLD snooping
+is enabled, the switch must treat this as if IGMP/MLD snooping were disabled.
+The SWITCHDEV_ATTR_ID_BRIDGE_MC_ACTIVE notification allows to track this.
diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 8346b0d29542..abcc34a81e00 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -27,6 +27,7 @@ enum switchdev_attr_id {
 	SWITCHDEV_ATTR_ID_BRIDGE_VLAN_FILTERING,
 	SWITCHDEV_ATTR_ID_BRIDGE_VLAN_PROTOCOL,
 	SWITCHDEV_ATTR_ID_BRIDGE_MC_DISABLED,
+	SWITCHDEV_ATTR_ID_BRIDGE_MC_ACTIVE,
 	SWITCHDEV_ATTR_ID_BRIDGE_MROUTER,
 	SWITCHDEV_ATTR_ID_BRIDGE_MST,
 	SWITCHDEV_ATTR_ID_MRP_PORT_ROLE,
@@ -43,6 +44,14 @@ struct switchdev_brport_flags {
 	unsigned long mask;
 };
 
+struct switchdev_mc_active {
+	short vid;
+	u8 ip4:1,
+	   ip6:1,
+	   ip4_changed:1,
+	   ip6_changed:1;
+};
+
 struct switchdev_vlan_msti {
 	u16 vid;
 	u16 msti;
@@ -64,6 +73,7 @@ struct switchdev_attr {
 		u16 vlan_protocol;			/* BRIDGE_VLAN_PROTOCOL */
 		bool mst;				/* BRIDGE_MST */
 		bool mc_disabled;			/* MC_DISABLED */
+		struct switchdev_mc_active mc_active;	/* MC_ACTIVE */
 		u8 mrp_port_role;			/* MRP_PORT_ROLE */
 		struct switchdev_vlan_msti vlan_msti;	/* VLAN_MSTI */
 	} u;
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 0bbaa21c1479..aec106f9c17d 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1138,6 +1138,27 @@ static int br_ip6_multicast_check_active(struct net_bridge_mcast *brmctx,
 #endif
 }
 
+static int br_multicast_notify_active(struct net_bridge_mcast *brmctx,
+				      bool ip4_active, bool ip6_active,
+				      bool ip4_changed, bool ip6_changed,
+				      struct netlink_ext_ack *extack)
+{
+	struct switchdev_attr attr = {
+		.orig_dev = brmctx->br->dev,
+		.id = SWITCHDEV_ATTR_ID_BRIDGE_MC_ACTIVE,
+		.flags = SWITCHDEV_F_DEFER,
+		.u.mc_active = {
+			.vid = brmctx->vlan ? brmctx->vlan->vid : -1,
+			.ip4 = ip4_active,
+			.ip6 = ip6_active,
+			.ip4_changed = ip4_changed,
+			.ip6_changed = ip6_changed,
+		},
+	};
+
+	return switchdev_port_attr_set(brmctx->br->dev, &attr, extack);
+}
+
 /**
  * __br_multicast_update_active() - update mcast active state
  * @brmctx: the bridge multicast context to check
@@ -1159,6 +1180,8 @@ static int br_ip6_multicast_check_active(struct net_bridge_mcast *brmctx,
  * This function should be called by anything that changes one of the
  * above prerequisites.
  *
+ * Any multicast active state toggling is further notified to switchdev.
+ *
  * Return: 0 on success, a negative value otherwise.
  */
 static int __br_multicast_update_active(struct net_bridge_mcast *brmctx,
@@ -1182,11 +1205,21 @@ static int __br_multicast_update_active(struct net_bridge_mcast *brmctx,
 	ip4_changed = br_ip4_multicast_check_active(brmctx, &ip4_active);
 	ip6_changed = br_ip6_multicast_check_active(brmctx, &ip6_active);
 
+	if (!ip4_changed && !ip6_changed)
+		goto out;
+
+	ret = br_multicast_notify_active(brmctx, ip4_active, ip6_active,
+					 ip4_changed, ip6_changed,
+					 extack);
+	if (ret && ret != -EOPNOTSUPP)
+		goto out;
+
 	if (ip4_changed)
 		brmctx->ip4_active = ip4_active;
 	if (ip6_changed)
 		brmctx->ip6_active = ip6_active;
 
+out:
 	return ret;
 }
 
-- 
2.49.0


