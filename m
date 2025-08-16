Return-Path: <netdev+bounces-214337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2942BB29066
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 21:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66EB6AE6F9A
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 19:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836DD21CC68;
	Sat, 16 Aug 2025 19:53:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AB7219A67;
	Sat, 16 Aug 2025 19:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755374028; cv=none; b=BPwVMnu0OWaZKnl/+YdqcNdA/4dkcanPLo/tXLWxtzcrnhSiUvyQmfk2qJX2zsWFJMBpnKqnTC7eVhboInLd+D+T8zqcST7547vWf4IJOT9bu2FTOZRVR9WgMG+ud5h7Aqdi9qa14K8G42pp/XjDn1olB+ArhXGC3Sv9B6WWwZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755374028; c=relaxed/simple;
	bh=R4e5sikzTcaj2bOC3rEAHKFYHm1TMGn0ZlrzOik0ZKA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MZGmfcM87Y68xt5F3dljKVOCQ3v2i4q4AsVgEWhfgfkabmsXNJYzJZ/B3prxk4OvE1XTjyTNkAhH7acEq1mUtPxiQVcDGNDNZUIhQ1xXrcuIgFr3dI9DU1awI1h9u4r+2WZ1em9mvy/Zo8WanxPK+htgKR6wsgsl4oijaWDzTII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1unMyD-0000000071k-0hdh;
	Sat, 16 Aug 2025 19:53:41 +0000
Date: Sat, 16 Aug 2025 20:53:37 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hauke Mehrtens <hauke@hauke-m.de>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Arkadi Sharshevsky <arkadis@mellanox.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
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
Subject: [PATCH RFC net-next 12/23] net: dsa: lantiq_gswip: support 4k VLANs
 on API 2.2 or later
Message-ID: <aKDhwYPptuC94u-f@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dynamically allocate vlans array depending on the switch API version.
Versions less than 2.2 support 64 VLANs, versions 2.2 or later support
4096 VLANs.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq_gswip.c | 73 +++++++++++++++++++++++-----------
 drivers/net/dsa/lantiq_gswip.h |  4 +-
 2 files changed, 52 insertions(+), 25 deletions(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index cc8a65c173c9..5a5e85b1b32f 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -657,6 +657,11 @@ static int gswip_setup(struct dsa_switch *ds)
 	gswip_switch_mask(priv, 0, GSWIP_BM_QUEUE_GCTRL_GL_MOD,
 			  GSWIP_BM_QUEUE_GCTRL);
 
+	if (GSWIP_VERSION_GE(priv, GSWIP_VERSION_2_2))
+		/* Enable VLANMD 2.2 for 4k VLANs entries */
+		gswip_switch_mask(priv, 0, GSWIP_PCE_GCTRL_1_VLANMD,
+				  GSWIP_PCE_GCTRL_1);
+
 	/* VLAN aware Switching */
 	gswip_switch_mask(priv, 0, GSWIP_PCE_GCTRL_0_VLAN, GSWIP_PCE_GCTRL_0);
 
@@ -700,8 +705,8 @@ static int gswip_vlan_active_create(struct gswip_priv *priv,
 	int i;
 
 	/* Look for a free slot */
-	for (i = max_ports; i < ARRAY_SIZE(priv->vlans); i++) {
-		if (!priv->vlans[i].bridge) {
+	for (i = max_ports; i < priv->num_vlans; i++) {
+		if (!(*priv->vlans)[i].bridge) {
 			idx = i;
 			break;
 		}
@@ -725,9 +730,9 @@ static int gswip_vlan_active_create(struct gswip_priv *priv,
 		return err;
 	}
 
-	priv->vlans[idx].bridge = bridge;
-	priv->vlans[idx].vid = vid;
-	priv->vlans[idx].fid = fid;
+	(*priv->vlans)[idx].bridge = bridge;
+	(*priv->vlans)[idx].vid = vid;
+	(*priv->vlans)[idx].fid = fid;
 
 	return idx;
 }
@@ -743,7 +748,7 @@ static int gswip_vlan_active_remove(struct gswip_priv *priv, int idx)
 	err = gswip_pce_table_entry_write(priv, &vlan_active);
 	if (err)
 		dev_err(priv->dev, "failed to delete active VLAN: %d\n", err);
-	priv->vlans[idx].bridge = NULL;
+	(*priv->vlans)[idx].bridge = NULL;
 
 	return err;
 }
@@ -759,8 +764,8 @@ static int gswip_vlan_add_unaware(struct gswip_priv *priv,
 	int err;
 
 	/* Check if there is already a page for this bridge */
-	for (i = max_ports; i < ARRAY_SIZE(priv->vlans); i++) {
-		if (priv->vlans[i].bridge == bridge) {
+	for (i = max_ports; i < priv->num_vlans; i++) {
+		if ((*priv->vlans)[i].bridge == bridge) {
 			idx = i;
 			break;
 		}
@@ -822,12 +827,12 @@ static int gswip_vlan_add_aware(struct gswip_priv *priv,
 	int err;
 
 	/* Check if there is already a page for this bridge */
-	for (i = max_ports; i < ARRAY_SIZE(priv->vlans); i++) {
-		if (priv->vlans[i].bridge == bridge) {
-			if (fid != -1 && fid != priv->vlans[i].fid)
+	for (i = max_ports; i < priv->num_vlans; i++) {
+		if ((*priv->vlans)[i].bridge == bridge) {
+			if (fid != -1 && fid != (*priv->vlans)[i].fid)
 				dev_err(priv->dev, "one bridge with multiple flow ids\n");
-			fid = priv->vlans[i].fid;
-			if (priv->vlans[i].vid == vid) {
+			fid = (*priv->vlans)[i].fid;
+			if ((*priv->vlans)[i].vid == vid) {
 				idx = i;
 				break;
 			}
@@ -894,9 +899,9 @@ static int gswip_vlan_remove(struct gswip_priv *priv,
 	int err;
 
 	/* Check if there is already a page for this bridge */
-	for (i = max_ports; i < ARRAY_SIZE(priv->vlans); i++) {
-		if (priv->vlans[i].bridge == bridge &&
-		    (!vlan_aware || priv->vlans[i].vid == vid)) {
+	for (i = max_ports; i < priv->num_vlans; i++) {
+		if ((*priv->vlans)[i].bridge == bridge &&
+		    (!vlan_aware || (*priv->vlans)[i].vid == vid)) {
 			idx = i;
 			break;
 		}
@@ -993,9 +998,9 @@ static int gswip_port_vlan_prepare(struct dsa_switch *ds, int port,
 		return -EOPNOTSUPP;
 
 	/* Check if there is already a page for this VLAN */
-	for (i = max_ports; i < ARRAY_SIZE(priv->vlans); i++) {
-		if (priv->vlans[i].bridge == bridge &&
-		    priv->vlans[i].vid == vlan->vid) {
+	for (i = max_ports; i < priv->num_vlans; i++) {
+		if ((*priv->vlans)[i].bridge == bridge &&
+		    (*priv->vlans)[i].vid == vlan->vid) {
 			idx = i;
 			break;
 		}
@@ -1007,8 +1012,8 @@ static int gswip_port_vlan_prepare(struct dsa_switch *ds, int port,
 	 */
 	if (idx == -1) {
 		/* Look for a free slot */
-		for (; pos < ARRAY_SIZE(priv->vlans); pos++) {
-			if (!priv->vlans[pos].bridge) {
+		for (; pos < priv->num_vlans; pos++) {
+			if (!(*priv->vlans)[pos].bridge) {
 				idx = pos;
 				pos++;
 				break;
@@ -1149,9 +1154,9 @@ static int gswip_port_fdb(struct dsa_switch *ds, int port,
 
 	switch (db.type) {
 	case DSA_DB_BRIDGE:
-		for (i = 0; i < ARRAY_SIZE(priv->vlans); i++) {
-			if (priv->vlans[i].bridge == db.bridge.dev) {
-				fid = priv->vlans[i].fid;
+		for (i = 0; i < priv->num_vlans; i++) {
+			if ((*priv->vlans)[i].bridge == db.bridge.dev) {
+				fid = (*priv->vlans)[i].fid;
 				break;
 			}
 		}
@@ -1948,6 +1953,22 @@ static int gswip_validate_cpu_port(struct dsa_switch *ds)
 	return 0;
 }
 
+static int gswip_allocate_vlans(struct gswip_priv *priv)
+{
+	if (GSWIP_VERSION_GE(priv, GSWIP_VERSION_2_2))
+		priv->num_vlans = 4096;
+	else
+		priv->num_vlans = 64;
+
+	priv->vlans = devm_kcalloc(priv->dev, priv->num_vlans,
+				   sizeof((*priv->vlans)[0]), GFP_KERNEL);
+	if (!priv->vlans)
+		return dev_err_probe(priv->dev, -ENOMEM,
+				     "VLAN allocation failed\n");
+
+	return 0;
+}
+
 static int gswip_probe(struct platform_device *pdev)
 {
 	struct device_node *np, *gphy_fw_np;
@@ -2024,6 +2045,10 @@ static int gswip_probe(struct platform_device *pdev)
 		goto gphy_fw_remove;
 	}
 
+	err = gswip_allocate_vlans(priv);
+	if (err)
+		goto gphy_fw_remove;
+
 	err = dsa_register_switch(priv->ds);
 	if (err) {
 		dev_err_probe(dev, err, "dsa switch registration failed\n");
diff --git a/drivers/net/dsa/lantiq_gswip.h b/drivers/net/dsa/lantiq_gswip.h
index 5c21618ca6f0..00a786d374b1 100644
--- a/drivers/net/dsa/lantiq_gswip.h
+++ b/drivers/net/dsa/lantiq_gswip.h
@@ -142,6 +142,7 @@
 #define GSWIP_PCE_GCTRL_1		0x457
 #define  GSWIP_PCE_GCTRL_1_MAC_GLOCK	BIT(2)	/* MAC Address table lock */
 #define  GSWIP_PCE_GCTRL_1_MAC_GLOCK_MOD	BIT(3) /* Mac address table lock forwarding mode */
+#define  GSWIP_PCE_GCTRL_1_VLANMD	BIT(9)	/* VLAN MODE */
 #define GSWIP_PCE_PCTRL_0p(p)		(0x480 + ((p) * 0xA))
 #define  GSWIP_PCE_PCTRL_0_TVM		BIT(5)	/* Transparent VLAN mode */
 #define  GSWIP_PCE_PCTRL_0_VREP		BIT(6)	/* VLAN Replace Mode */
@@ -269,7 +270,8 @@ struct gswip_priv {
 	struct dsa_switch *ds;
 	struct device *dev;
 	struct regmap *rcu_regmap;
-	struct gswip_vlan vlans[64];
+	struct gswip_vlan (*vlans)[];
+	unsigned int num_vlans;
 	int num_gphy_fw;
 	struct gswip_gphy_fw *gphy_fw;
 	u32 port_vlan_filter;
-- 
2.50.1

