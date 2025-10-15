Return-Path: <netdev+bounces-229808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCD8BE0F0D
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 00:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDAAB1A22671
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 22:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0ADA30DEA3;
	Wed, 15 Oct 2025 22:32:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A45230DD23;
	Wed, 15 Oct 2025 22:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567569; cv=none; b=qljuJKsP98Au7l44aYJXTOOrLaEcDRdOgpH7xgi6tbazS6hp3fT2fNqT/AjSr6fEuIsiafQpPcfXC4QujCofZdiL/FXOnejLOTqsmBfxAZz2OAp7e7Xu961CXdU/DNr68ZSX9sqCowFl7GmN8HavtTOWrtLT2CsTsO6+N6jHPu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567569; c=relaxed/simple;
	bh=eaf3eoV7n8HxG7X3tAFDvc8QVrG6j3F90sKRY1iV2T4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JokOcBWyNrX1+1GQUGSJqsTQwWU8XJqiqFnL+K2TburU01+cmUIChVcaAWKkfHZWARtj3QlyFG5A0UTL6NPy0MbNrncA/EN1Arskrap8ybj32ojOO7BGBKA+nXNQWk5Afgtt/kNBhEyXeXusV2g0DuEBJ/t9709zt2JsxECmkaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1v9A32-000000006VP-2to0;
	Wed, 15 Oct 2025 22:32:44 +0000
Date: Wed, 15 Oct 2025 23:32:41 +0100
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
Subject: [PATCH net-next 04/11] net: dsa: lantiq_gswip: merge
 gswip_vlan_add_unaware() and gswip_vlan_add_aware()
Message-ID: <2be190701d4c17038ce4b8047f9fb0bdf8abdf6e.1760566491.git.daniel@makrotopia.org>
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

The two functions largely duplicate functionality. The differences
consist in:

- the "fid" passed to gswip_vlan_active_create(). The unaware variant
  always passes -1, the aware variant passes fid = priv->vlans[i].fid,
  where i is an index into priv->vlans[] for which priv->vlans[i].bridge
  is equal to the given bridge.

- the "vid" is not passed to gswip_vlan_add_unaware(). It is implicitly
  GSWIP_VLAN_UNAWARE_PVID (zero).

- The "untagged" is not passed to gswip_vlan_add_unaware(). It is
  implicitly true. Also, the CPU port must not be a tag member of the
  PVID used for VLAN-unaware bridging.

- The "pvid" is not passed to gswip_vlan_add_unaware(). It is implicitly
  true.

- The GSWIP_PCE_DEFPVID(port) register is written by the aware variant
  with an "idx", but with a hardcoded 0 by the unaware variant.

Merge the two functions into a single unified function without any
functional changes.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq/lantiq_gswip.c | 94 +++++----------------------
 1 file changed, 17 insertions(+), 77 deletions(-)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
index e41d67ea89c5..6cbcb54a5ed0 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
@@ -750,86 +750,25 @@ static int gswip_vlan_active_remove(struct gswip_priv *priv, int idx)
 	return err;
 }
 
-static int gswip_vlan_add_unaware(struct gswip_priv *priv,
-				  struct net_device *bridge, int port)
-{
-	struct gswip_pce_table_entry vlan_mapping = {0,};
-	unsigned int max_ports = priv->hw_info->max_ports;
-	bool active_vlan_created = false;
-	int idx = -1;
-	int i;
-	int err;
-
-	/* Check if there is already a page for this bridge */
-	for (i = max_ports; i < ARRAY_SIZE(priv->vlans); i++) {
-		if (priv->vlans[i].bridge == bridge) {
-			idx = i;
-			break;
-		}
-	}
-
-	/* If this bridge is not programmed yet, add a Active VLAN table
-	 * entry in a free slot and prepare the VLAN mapping table entry.
-	 */
-	if (idx == -1) {
-		idx = gswip_vlan_active_create(priv, bridge, -1,
-					       GSWIP_VLAN_UNAWARE_PVID);
-		if (idx < 0)
-			return idx;
-		active_vlan_created = true;
-
-		vlan_mapping.index = idx;
-		vlan_mapping.table = GSWIP_TABLE_VLAN_MAPPING;
-		/* VLAN ID byte, maps to the VLAN ID of vlan active table */
-		vlan_mapping.val[0] = GSWIP_VLAN_UNAWARE_PVID;
-	} else {
-		/* Read the existing VLAN mapping entry from the switch */
-		vlan_mapping.index = idx;
-		vlan_mapping.table = GSWIP_TABLE_VLAN_MAPPING;
-		err = gswip_pce_table_entry_read(priv, &vlan_mapping);
-		if (err) {
-			dev_err(priv->dev, "failed to read VLAN mapping: %d\n",
-				err);
-			return err;
-		}
-	}
-
-	/* Update the VLAN mapping entry and write it to the switch */
-	vlan_mapping.val[1] |= dsa_cpu_ports(priv->ds);
-	vlan_mapping.val[1] |= BIT(port);
-	err = gswip_pce_table_entry_write(priv, &vlan_mapping);
-	if (err) {
-		dev_err(priv->dev, "failed to write VLAN mapping: %d\n", err);
-		/* In case an Active VLAN was creaetd delete it again */
-		if (active_vlan_created)
-			gswip_vlan_active_remove(priv, idx);
-		return err;
-	}
-
-	gswip_switch_w(priv, 0, GSWIP_PCE_DEFPVID(port));
-	return 0;
-}
-
-static int gswip_vlan_add_aware(struct gswip_priv *priv,
-				struct net_device *bridge, int port,
-				u16 vid, bool untagged,
-				bool pvid)
+static int gswip_vlan_add(struct gswip_priv *priv, struct net_device *bridge,
+			  int port, u16 vid, bool untagged, bool pvid,
+			  bool vlan_aware)
 {
 	struct gswip_pce_table_entry vlan_mapping = {0,};
 	unsigned int max_ports = priv->hw_info->max_ports;
 	unsigned int cpu_ports = dsa_cpu_ports(priv->ds);
 	bool active_vlan_created = false;
-	int idx = -1;
-	int fid = -1;
-	int i;
-	int err;
+	int fid = -1, idx = -1;
+	int i, err;
 
 	/* Check if there is already a page for this bridge */
 	for (i = max_ports; i < ARRAY_SIZE(priv->vlans); i++) {
 		if (priv->vlans[i].bridge == bridge) {
-			if (fid != -1 && fid != priv->vlans[i].fid)
-				dev_err(priv->dev, "one bridge with multiple flow ids\n");
-			fid = priv->vlans[i].fid;
+			if (vlan_aware) {
+				if (fid != -1 && fid != priv->vlans[i].fid)
+					dev_err(priv->dev, "one bridge with multiple flow ids\n");
+				fid = priv->vlans[i].fid;
+			}
 			if (priv->vlans[i].vid == vid) {
 				idx = i;
 				break;
@@ -864,8 +803,9 @@ static int gswip_vlan_add_aware(struct gswip_priv *priv,
 	vlan_mapping.val[0] = vid;
 	/* Update the VLAN mapping entry and write it to the switch */
 	vlan_mapping.val[1] |= cpu_ports;
-	vlan_mapping.val[2] |= cpu_ports;
 	vlan_mapping.val[1] |= BIT(port);
+	if (vlan_aware)
+		vlan_mapping.val[2] |= cpu_ports;
 	if (untagged)
 		vlan_mapping.val[2] &= ~BIT(port);
 	else
@@ -879,8 +819,7 @@ static int gswip_vlan_add_aware(struct gswip_priv *priv,
 		return err;
 	}
 
-	if (pvid)
-		gswip_switch_w(priv, idx, GSWIP_PCE_DEFPVID(port));
+	gswip_switch_w(priv, vlan_aware ? idx : 0, GSWIP_PCE_DEFPVID(port));
 
 	return 0;
 }
@@ -955,7 +894,8 @@ static int gswip_port_bridge_join(struct dsa_switch *ds, int port,
 	 * specific bridges. No bridge is configured here.
 	 */
 	if (!br_vlan_enabled(br)) {
-		err = gswip_vlan_add_unaware(priv, br, port);
+		err = gswip_vlan_add(priv, br, port, GSWIP_VLAN_UNAWARE_PVID,
+				     true, true, false);
 		if (err)
 			return err;
 		priv->port_vlan_filter &= ~BIT(port);
@@ -1049,8 +989,8 @@ static int gswip_port_vlan_add(struct dsa_switch *ds, int port,
 	if (dsa_is_cpu_port(ds, port))
 		return 0;
 
-	return gswip_vlan_add_aware(priv, bridge, port, vlan->vid,
-				    untagged, pvid);
+	return gswip_vlan_add(priv, bridge, port, vlan->vid, untagged, pvid,
+			      true);
 }
 
 static int gswip_port_vlan_del(struct dsa_switch *ds, int port,
-- 
2.51.0

