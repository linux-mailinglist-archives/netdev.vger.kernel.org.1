Return-Path: <netdev+bounces-212339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13682B1F725
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 01:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A16A84E0369
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 23:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADD6224225;
	Sat,  9 Aug 2025 23:01:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9EE186294;
	Sat,  9 Aug 2025 23:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754780506; cv=none; b=Ah44hAwUPZVydf9fOdUrw6U2dSqX3gDYOcCZacLoEOlsC9C/in23oFXruSpZ0qG6tTMD17ZWtrN9XjKfL4RvP7txcMoTKteZ+PpTFCvS2QAsIMGvU1EK4Ct7ciG5q5aXlz/GVqjWAtgPxZtUgOny+LLRR+7GAdjvci2L7nuzWH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754780506; c=relaxed/simple;
	bh=CjJsvcst6MRZmo+FQY5M+ytxwUkRquRR0/OqVbCuUKY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=R/Y/CTUWILbQ1lVZqHAdVzHgbaaXHWau1jkd6oxgWUrem3q1TFeT68I7CtkRp9dPnc8IHQeIQunVApOxJp8HOsU5M7hWwZPb4KYYUVgDE2CIZ2g3nu2g5i1IdWE3lmJe/2cJbUbX1X3VMC7YrJypavjOhPTrPQDdqWWJasfNXd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uksAA-000000002Cb-2BOp;
	Sat, 09 Aug 2025 22:35:42 +0000
Date: Sat, 9 Aug 2025 23:35:28 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Arkadi Sharshevsky <arkadis@mellanox.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH/RFC net] net: dsa: lantiq_gswip: honor dsa_db passed to
 port_fdb_{add,del}
Message-ID: <aJfNMLNoi1VOsPrN@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commit c9eb3e0f8701 ("net: dsa: Add support for learning FDB through
notification") added a dev_close() call "to indicate inconsistent
situation" when we could not delete an FDB entry from the port. In case
of the lantiq_gswip driver this is problematic on standalone ports for
which all calls to either .port_fdb_add() or .port_fdb_del() would just
always return -EINVAL as adding or removing FDB entries is currently
only supported for ports which are a member of a bridge.

As since commit c26933639b54 ("net: dsa: request drivers to perform FDB
isolation") the dsa_db is passed to the .port_fdb_add() or
.port_fdb_del() calls we can use that to set the FID accordingly,
similar to how it was for bridge ports, and to FID 0 for standalone
ports. In order for FID 0 to work at all we also need to set bit 1 in
val[1], so always set it.

This solution was found in a downstream driver provided by MaxLinear
(which is the current owner of the former Lantiq switch IP) under
GPL-2.0. Import the implementation and the copyright headers from that
driver.

Fixes: c9eb3e0f8701 ("net: dsa: Add support for learning FDB through notification")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq_gswip.c | 55 ++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index 6eb3140d4044..fed86b2d78fc 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -2,9 +2,11 @@
 /*
  * Lantiq / Intel GSWIP switch driver for VRX200, xRX300 and xRX330 SoCs
  *
- * Copyright (C) 2010 Lantiq Deutschland
- * Copyright (C) 2012 John Crispin <john@phrozen.org>
+ * Copyright (C) 2023 - 2024 MaxLinear Inc.
+ * Copyright (C) 2022 Snap One, LLC.  All rights reserved.
  * Copyright (C) 2017 - 2019 Hauke Mehrtens <hauke@hauke-m.de>
+ * Copyright (C) 2012 John Crispin <john@phrozen.org>
+ * Copyright (C) 2010 Lantiq Deutschland
  *
  * The VLAN and bridge model the GSWIP hardware uses does not directly
  * matches the model DSA uses.
@@ -239,6 +241,7 @@
 #define  GSWIP_TABLE_MAC_BRIDGE_KEY3_FID	GENMASK(5, 0)	/* Filtering identifier */
 #define  GSWIP_TABLE_MAC_BRIDGE_VAL0_PORT	GENMASK(7, 4)	/* Port on learned entries */
 #define  GSWIP_TABLE_MAC_BRIDGE_VAL1_STATIC	BIT(0)		/* Static, non-aging entry */
+#define  GSWIP_TABLE_MAC_BRIDGE_VAL1_VALID	BIT(1)		/* Valid bit */
 
 #define XRX200_GPHY_FW_ALIGN	(16 * 1024)
 
@@ -1349,30 +1352,37 @@ static void gswip_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 }
 
 static int gswip_port_fdb(struct dsa_switch *ds, int port,
-			  const unsigned char *addr, u16 vid, bool add)
+			  const unsigned char *addr, u16 vid, struct dsa_db db,
+			  bool add)
 {
-	struct net_device *bridge = dsa_port_bridge_dev_get(dsa_to_port(ds, port));
 	struct gswip_priv *priv = ds->priv;
 	struct gswip_pce_table_entry mac_bridge = {0,};
-	unsigned int max_ports = priv->hw_info->max_ports;
 	int fid = -1;
-	int i;
 	int err;
+	int i;
 
-	if (!bridge)
-		return -EINVAL;
-
-	for (i = max_ports; i < ARRAY_SIZE(priv->vlans); i++) {
-		if (priv->vlans[i].bridge == bridge) {
-			fid = priv->vlans[i].fid;
-			break;
+	switch (db.type) {
+	case DSA_DB_BRIDGE:
+		for (i = 0; i < ARRAY_SIZE(priv->vlans); i++) {
+			if (priv->vlans[i].bridge == db.bridge.dev) {
+				fid = priv->vlans[i].fid;
+				break;
+			}
 		}
-	}
-
-	if (fid == -1) {
-		dev_err(priv->dev, "no FID found for bridge %s\n",
-			bridge->name);
-		return -EINVAL;
+		if (fid == -1) {
+			dev_err(priv->dev, "Port %d not part of a bridge\n", port);
+			return -EINVAL;
+		}
+		break;
+	case DSA_DB_PORT:
+		if (dsa_is_cpu_port(ds, port) &&
+			dsa_fdb_present_in_other_db(ds, port, addr, vid, db))
+			return 0;
+		/* FID of a standalone / single port bridge */
+		fid = 0;
+		break;
+	default:
+		return -EOPNOTSUPP;
 	}
 
 	mac_bridge.table = GSWIP_TABLE_MAC_BRIDGE;
@@ -1382,7 +1392,8 @@ static int gswip_port_fdb(struct dsa_switch *ds, int port,
 	mac_bridge.key[2] = addr[1] | (addr[0] << 8);
 	mac_bridge.key[3] = FIELD_PREP(GSWIP_TABLE_MAC_BRIDGE_KEY3_FID, fid);
 	mac_bridge.val[0] = add ? BIT(port) : 0; /* port map */
-	mac_bridge.val[1] = GSWIP_TABLE_MAC_BRIDGE_VAL1_STATIC;
+	mac_bridge.val[1] = add ? (GSWIP_TABLE_MAC_BRIDGE_VAL1_STATIC |
+				   GSWIP_TABLE_MAC_BRIDGE_VAL1_VALID) : 0;
 	mac_bridge.valid = add;
 
 	err = gswip_pce_table_entry_write(priv, &mac_bridge);
@@ -1396,14 +1407,14 @@ static int gswip_port_fdb_add(struct dsa_switch *ds, int port,
 			      const unsigned char *addr, u16 vid,
 			      struct dsa_db db)
 {
-	return gswip_port_fdb(ds, port, addr, vid, true);
+	return gswip_port_fdb(ds, port, addr, vid, db, true);
 }
 
 static int gswip_port_fdb_del(struct dsa_switch *ds, int port,
 			      const unsigned char *addr, u16 vid,
 			      struct dsa_db db)
 {
-	return gswip_port_fdb(ds, port, addr, vid, false);
+	return gswip_port_fdb(ds, port, addr, vid, db, false);
 }
 
 static int gswip_port_fdb_dump(struct dsa_switch *ds, int port,
-- 
2.50.1


