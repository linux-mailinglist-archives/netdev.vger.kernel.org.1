Return-Path: <netdev+bounces-229810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBBDBE0F31
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 00:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 976065041CF
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 22:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF3E3093CE;
	Wed, 15 Oct 2025 22:33:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EB430E849;
	Wed, 15 Oct 2025 22:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567587; cv=none; b=cYQa5AENgmeCT+ADsK6TEBPhQ3Qozn+7xxKySMk3vLpvRwC+5xicjdpHHxf3NDTDkXBfMw8WWBSDw8ziSN0sZmv3Ou2R4m5LC5jmhwQxtUpbUhvGxr7i3Ql6L7uWHWHerE82NFKX9qDjCl6zsxbdJeJefDb//scX8mZ6CbIqW1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567587; c=relaxed/simple;
	bh=5uGUhoeLDDjoubEihAHKJx1uoA3bgc8l2z6IzQxE4Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4HOZk0PU2J2msUfeVbW/W9CuaGDd7lYnNWGCF4hEW7WYL80kJRKEoyE648GcwNL0bGXxQuohO6+MBFPB3f8x5puJlu38lbbbFydzU+IfvjgJAy2AkKBxYEJGg7mrI/xGYEZk5yuFPRuy3X9rO13rgGz6u4vaqqrRcr7PmOnYAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1v9A3J-000000006W1-2U2Y;
	Wed, 15 Oct 2025 22:33:01 +0000
Date: Wed, 15 Oct 2025 23:32:58 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next 06/11] net: dsa: lantiq_gswip: permit dynamic
 changes to VLAN filtering state
Message-ID: <c58759074fb699581336dc2c2c6bf106257b134e.1760566491.git.daniel@makrotopia.org>
References: <cover.1760566491.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1760566491.git.daniel@makrotopia.org>

From: Vladimir Oltean <vladimir.oltean@nxp.com>

The driver should now tolerate these changes, now that the PVID is
automatically recalculated on a VLAN awareness state change.

The VLAN-unaware PVID must be installed to hardware even if the
joined bridge is currently VLAN-aware. Otherwise, when the bridge VLAN
filtering state dynamically changes to VLAN-unaware later, this PVID
will be missing.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq/lantiq_gswip.c | 38 +++++++++------------------
 drivers/net/dsa/lantiq/lantiq_gswip.h |  1 -
 2 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
index 30cff623bec0..58fdd54094d6 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
@@ -590,16 +590,8 @@ static int gswip_port_vlan_filtering(struct dsa_switch *ds, int port,
 				     bool vlan_filtering,
 				     struct netlink_ext_ack *extack)
 {
-	struct net_device *bridge = dsa_port_bridge_dev_get(dsa_to_port(ds, port));
 	struct gswip_priv *priv = ds->priv;
 
-	/* Do not allow changing the VLAN filtering options while in bridge */
-	if (bridge && !!(priv->port_vlan_filter & BIT(port)) != vlan_filtering) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Dynamic toggling of vlan_filtering not supported");
-		return -EIO;
-	}
-
 	if (vlan_filtering) {
 		/* Use tag based VLAN */
 		gswip_switch_mask(priv,
@@ -927,18 +919,15 @@ static int gswip_port_bridge_join(struct dsa_switch *ds, int port,
 	struct gswip_priv *priv = ds->priv;
 	int err;
 
-	/* When the bridge uses VLAN filtering we have to configure VLAN
-	 * specific bridges. No bridge is configured here.
+	/* Set up the VLAN for VLAN-unaware bridging for this port, and remove
+	 * it from the "single-port bridge" through which it was operating as
+	 * standalone.
 	 */
-	if (!br_vlan_enabled(br)) {
-		err = gswip_vlan_add(priv, br, port, GSWIP_VLAN_UNAWARE_PVID,
-				     true, true, false);
-		if (err)
-			return err;
-		priv->port_vlan_filter &= ~BIT(port);
-	} else {
-		priv->port_vlan_filter |= BIT(port);
-	}
+	err = gswip_vlan_add(priv, br, port, GSWIP_VLAN_UNAWARE_PVID,
+			     true, true, false);
+	if (err)
+		return err;
+
 	return gswip_add_single_port_br(priv, port, false);
 }
 
@@ -948,14 +937,11 @@ static void gswip_port_bridge_leave(struct dsa_switch *ds, int port,
 	struct net_device *br = bridge.dev;
 	struct gswip_priv *priv = ds->priv;
 
-	gswip_add_single_port_br(priv, port, true);
-
-	/* When the bridge uses VLAN filtering we have to configure VLAN
-	 * specific bridges. No bridge is configured here.
+	/* Add the port back to the "single-port bridge", and remove it from
+	 * the VLAN-unaware PVID created for this bridge.
 	 */
-	if (!br_vlan_enabled(br))
-		gswip_vlan_remove(priv, br, port, GSWIP_VLAN_UNAWARE_PVID, true,
-				  false);
+	gswip_add_single_port_br(priv, port, true);
+	gswip_vlan_remove(priv, br, port, GSWIP_VLAN_UNAWARE_PVID, true, false);
 }
 
 static int gswip_port_vlan_prepare(struct dsa_switch *ds, int port,
diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.h b/drivers/net/dsa/lantiq/lantiq_gswip.h
index 6aae1ff2f130..4590a1a7dbd9 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.h
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.h
@@ -270,7 +270,6 @@ struct gswip_priv {
 	struct gswip_vlan vlans[64];
 	int num_gphy_fw;
 	struct gswip_gphy_fw *gphy_fw;
-	u32 port_vlan_filter;
 	struct mutex pce_table_lock;
 	u16 version;
 };
-- 
2.51.0

