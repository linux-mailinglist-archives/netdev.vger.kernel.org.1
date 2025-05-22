Return-Path: <netdev+bounces-192827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 770D4AC1528
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 22:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD3651C011EA
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 20:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DE51891AA;
	Thu, 22 May 2025 20:00:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE64148827;
	Thu, 22 May 2025 20:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747944023; cv=none; b=boQ7ysrKwvbWLveaI/t7lzYQMOv48yxO4WSY9/e8/1+3hREYzk46+jmMB2Uf09VEprGAjOUbkF02TdAS+7MD6/K2yzX0BE1isdOb6DbTK/3YqHIu2u83IDEOe5OfFJd9XmK2x9e4e3XK/RknJE0lFgeMKbU9N3mt0t5Vbl4z90w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747944023; c=relaxed/simple;
	bh=yLDbXO/gSmkNEDZIFZ98m8PJwn3LOwfLyLA3H+5I8X8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kIVUbEMVU0puFP2RBgE2/6c5kxn6TY+fOPwC880QaBiV/Jli6ReDqgtn7eIQZxLXRNNofomrupUwbFONyfLMCRtJ0FviioLsxRfA7/jjsbsNBBpsktZY0hu6gXfMePsRcamrcO6MB9RxckDz7Z3JJuRvHx22yhvYGWbr5Uzoo5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 31D5E54E733;
	Thu, 22 May 2025 22:00:16 +0200 (CEST)
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
Subject: [PATCH net-next 5/5] net: dsa: forward bridge/switchdev mcast active notification
Date: Thu, 22 May 2025 21:17:07 +0200
Message-ID: <20250522195952.29265-6-linus.luessing@c0d3.blue>
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

Add a new "port_mdb_active()" handler to the DSA API. This allows DSA
drivers to receive the multicast active notification from the
bridge. So that switch drivers can act on it accordingly, especially
to avoid packetloss.

The switchdev notifier "handled" attribute is propagated, too, so that a
DSA based switch driver can decide whether it wants to act on the event
for each port individually or only on the first one, on behalf of all
others.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 Documentation/networking/dsa/dsa.rst |  9 +++++++++
 include/net/dsa.h                    |  5 +++++
 net/dsa/port.c                       | 19 +++++++++++++++++++
 net/dsa/port.h                       |  3 +++
 net/dsa/switch.c                     | 13 +++++++++++++
 net/dsa/switch.h                     | 11 ++++++++++-
 net/dsa/user.c                       | 21 ++++++++++++++++++++-
 7 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/dsa/dsa.rst b/Documentation/networking/dsa/dsa.rst
index 7b2e69cd7ef0..0b0be619be04 100644
--- a/Documentation/networking/dsa/dsa.rst
+++ b/Documentation/networking/dsa/dsa.rst
@@ -1025,6 +1025,15 @@ Bridge VLAN filtering
   the specified MAC address from the specified VLAN ID if it was mapped into
   this port forwarding database.
 
+- ``port_mdb_active``: bridge layer function invoked when the bridge starts (or
+  stops) to actively apply multicast snooping to multicast payload, i.e. when
+  multicast snooping is enabled and a multicast querier is present on the link
+  for a particular protocol family (or not). A switch should (by default) ensure:
+  To flood multicast packets for the given protocol family if multicast snooping
+  is inactive - to avoid multicast (and consequently also IPv6 unicast, which
+  depends on multicast for NDP) packet loss. And should (by default) avoid
+  forwarding to an active port if there is no listener or multicast router on it.
+
 Link aggregation
 ----------------
 
diff --git a/include/net/dsa.h b/include/net/dsa.h
index a0a9481c52c2..edc0e6821ba2 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -1080,6 +1080,11 @@ struct dsa_switch_ops {
 	int	(*port_mdb_del)(struct dsa_switch *ds, int port,
 				const struct switchdev_obj_port_mdb *mdb,
 				struct dsa_db db);
+	int	(*port_mdb_active)(struct dsa_switch *ds, int port,
+				   const struct switchdev_mc_active mc_active,
+				   struct netlink_ext_ack *extack,
+				   bool handled);
+
 	/*
 	 * RXNFC
 	 */
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 5c9d1798e830..a1e692d9122e 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -1290,6 +1290,25 @@ int dsa_port_bridge_host_mdb_del(const struct dsa_port *dp,
 	return dsa_port_host_mdb_del(dp, mdb, db);
 }
 
+int dsa_port_bridge_mdb_active(const struct dsa_port *dp,
+			       const struct switchdev_mc_active mc_active,
+			       struct netlink_ext_ack *extack,
+			       bool handled)
+{
+	struct dsa_switch *ds = dp->ds;
+	struct dsa_notifier_mdb_active_info info = {
+		.dp = dp,
+		.mc_active = mc_active,
+		.extack = extack,
+		.handled = handled,
+	};
+
+	if (!ds->ops->port_mdb_active)
+		return -EOPNOTSUPP;
+
+	return dsa_port_notify(dp, DSA_NOTIFIER_MDB_ACTIVE, &info);
+}
+
 int dsa_port_vlan_add(struct dsa_port *dp,
 		      const struct switchdev_obj_port_vlan *vlan,
 		      struct netlink_ext_ack *extack)
diff --git a/net/dsa/port.h b/net/dsa/port.h
index 6bc3291573c0..0e92815e7de2 100644
--- a/net/dsa/port.h
+++ b/net/dsa/port.h
@@ -75,6 +75,9 @@ int dsa_port_bridge_host_mdb_add(const struct dsa_port *dp,
 				 const struct switchdev_obj_port_mdb *mdb);
 int dsa_port_bridge_host_mdb_del(const struct dsa_port *dp,
 				 const struct switchdev_obj_port_mdb *mdb);
+int dsa_port_bridge_mdb_active(const struct dsa_port *dp,
+			       const struct switchdev_mc_active mc_active,
+			       struct netlink_ext_ack *extack, bool handled);
 int dsa_port_pre_bridge_flags(const struct dsa_port *dp,
 			      struct switchdev_brport_flags flags,
 			      struct netlink_ext_ack *extack);
diff --git a/net/dsa/switch.c b/net/dsa/switch.c
index 3d2feeea897b..5b30dfe4bebd 100644
--- a/net/dsa/switch.c
+++ b/net/dsa/switch.c
@@ -652,6 +652,16 @@ static int dsa_switch_host_mdb_del(struct dsa_switch *ds,
 	return err;
 }
 
+static int dsa_switch_mdb_active(struct dsa_switch *ds,
+				 struct dsa_notifier_mdb_active_info *info)
+{
+	if (!ds->ops->port_mdb_active)
+		return -EOPNOTSUPP;
+
+	return ds->ops->port_mdb_active(ds, info->dp->index, info->mc_active,
+					info->extack, info->handled);
+}
+
 /* Port VLANs match on the targeted port and on all DSA ports */
 static bool dsa_port_vlan_match(struct dsa_port *dp,
 				struct dsa_notifier_vlan_info *info)
@@ -1026,6 +1036,9 @@ static int dsa_switch_event(struct notifier_block *nb,
 	case DSA_NOTIFIER_HOST_MDB_DEL:
 		err = dsa_switch_host_mdb_del(ds, info);
 		break;
+	case DSA_NOTIFIER_MDB_ACTIVE:
+		err = dsa_switch_mdb_active(ds, info);
+		break;
 	case DSA_NOTIFIER_VLAN_ADD:
 		err = dsa_switch_vlan_add(ds, info);
 		break;
diff --git a/net/dsa/switch.h b/net/dsa/switch.h
index be0a2749cd97..69a5004e48c8 100644
--- a/net/dsa/switch.h
+++ b/net/dsa/switch.h
@@ -24,6 +24,7 @@ enum {
 	DSA_NOTIFIER_MDB_DEL,
 	DSA_NOTIFIER_HOST_MDB_ADD,
 	DSA_NOTIFIER_HOST_MDB_DEL,
+	DSA_NOTIFIER_MDB_ACTIVE,
 	DSA_NOTIFIER_VLAN_ADD,
 	DSA_NOTIFIER_VLAN_DEL,
 	DSA_NOTIFIER_HOST_VLAN_ADD,
@@ -66,13 +67,21 @@ struct dsa_notifier_lag_fdb_info {
 	struct dsa_db db;
 };
 
-/* DSA_NOTIFIER_MDB_* */
+/* DSA_NOTIFIER_MDB_{ADD,DEL} */
 struct dsa_notifier_mdb_info {
 	const struct dsa_port *dp;
 	const struct switchdev_obj_port_mdb *mdb;
 	struct dsa_db db;
 };
 
+/* DSA_NOTIFIER_MDB_ACTIVE */
+struct dsa_notifier_mdb_active_info {
+	const struct dsa_port *dp;
+	const struct switchdev_mc_active mc_active;
+	struct netlink_ext_ack *extack;
+	int handled;
+};
+
 /* DSA_NOTIFIER_LAG_* */
 struct dsa_notifier_lag_info {
 	const struct dsa_port *dp;
diff --git a/net/dsa/user.c b/net/dsa/user.c
index 804dc7dac4f2..231b92d6e7b9 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -603,7 +603,7 @@ static int dsa_user_port_attr_set(struct net_device *dev, const void *ctx,
 	struct dsa_port *dp = dsa_user_to_port(dev);
 	int ret;
 
-	if (ctx && ctx != dp)
+	if (ctx && ctx != dp && attr->id != SWITCHDEV_ATTR_ID_BRIDGE_MC_ACTIVE)
 		return 0;
 
 	switch (attr->id) {
@@ -657,6 +657,15 @@ static int dsa_user_port_attr_set(struct net_device *dev, const void *ctx,
 
 		ret = dsa_port_vlan_msti(dp, &attr->u.vlan_msti);
 		break;
+	case SWITCHDEV_ATTR_ID_BRIDGE_MC_ACTIVE:
+		const bool *handled = ctx;
+
+		if (!dsa_port_offloads_bridge_dev(dp, attr->orig_dev))
+			return -EOPNOTSUPP;
+
+		ret = dsa_port_bridge_mdb_active(dp, attr->u.mc_active, extack,
+						 *handled);
+		break;
 	default:
 		ret = -EOPNOTSUPP;
 		break;
@@ -3758,6 +3767,11 @@ static int dsa_user_switchdev_event(struct notifier_block *unused,
 
 	switch (event) {
 	case SWITCHDEV_PORT_ATTR_SET:
+		struct switchdev_notifier_port_attr_info *item = ptr;
+
+		if (item && item->attr->id == SWITCHDEV_ATTR_ID_BRIDGE_MC_ACTIVE)
+			item->info.ctx = &item->handled;
+
 		err = switchdev_handle_port_attr_set(dev, ptr,
 						     dsa_user_dev_check,
 						     dsa_user_port_attr_set);
@@ -3796,6 +3810,11 @@ static int dsa_user_switchdev_blocking_event(struct notifier_block *unused,
 							    dsa_user_port_obj_del);
 		return notifier_from_errno(err);
 	case SWITCHDEV_PORT_ATTR_SET:
+		struct switchdev_notifier_port_attr_info *item = ptr;
+
+		if (item && item->attr->id == SWITCHDEV_ATTR_ID_BRIDGE_MC_ACTIVE)
+			item->info.ctx = &item->handled;
+
 		err = switchdev_handle_port_attr_set(dev, ptr,
 						     dsa_user_dev_check,
 						     dsa_user_port_attr_set);
-- 
2.49.0


