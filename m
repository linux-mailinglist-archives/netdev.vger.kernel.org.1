Return-Path: <netdev+bounces-214328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35299B29050
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 21:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 790E67B8763
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 19:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF62E216E32;
	Sat, 16 Aug 2025 19:51:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3BF216E1B;
	Sat, 16 Aug 2025 19:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755373901; cv=none; b=Esr9AjEph1zVMdOEmSIPfHpZqvoU1ujWhDzSk/ahE6LGNxDSv8/2OwMBcMVbIMmQaLtQe3oW8zEYdTx9Ai/btdHWLz/SExLxOUFQs/H6w4gZtj+0IT7M6MD8WRF4HhyAAtf4G5i7XkBLxpQVF1FQbbdl4ZkAH2mh5hUFQXEFKE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755373901; c=relaxed/simple;
	bh=dAXSlmBkAbhSCU+xiOSeJbiDN64HNWpCdP3cZeWxtpk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nwjqvcP690yNXasFgAsn0eybVn+yeHEtSWywBdI8rFD0u14Yop4DCqWvR1pBPmEDCdR79267umHEodcBZdYstvVFI1atJ77TMUZMCDCIUR2wNhxiS+2504zYiusvMH27Nl8FSJVdzQ84EUGrLvdAABEO1d1Mta90UQGatWX9pDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1unMw8-000000006xI-2ESf;
	Sat, 16 Aug 2025 19:51:32 +0000
Date: Sat, 16 Aug 2025 20:51:29 +0100
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
Subject: [PATCH RFC net-next 03/23] net: dsa: lantiq_gswip: prepare for more
 CPU port options
Message-ID: <aKDhQSBX4Pl6n14b@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The MaxLinear GSW1xx series of switches support using either the
(R)(G)MII interface on port 5 or the SGMII interface on port 4 to be
used as CPU port. Prepare for supporting them by defining a mask of
allowed CPU ports instead of a single port.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq_gswip.c | 79 +++++++++++++++++++++-------------
 1 file changed, 50 insertions(+), 29 deletions(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index eb38caaa46af..001790292f6f 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -256,7 +256,7 @@
 
 struct gswip_hw_info {
 	int max_ports;
-	int cpu_port;
+	unsigned int allowed_cpu_ports;
 	void (*phylink_get_caps)(struct dsa_switch *ds, int port,
 				 struct phylink_config *config);
 };
@@ -658,7 +658,6 @@ static int gswip_add_single_port_br(struct gswip_priv *priv, int port, bool add)
 {
 	struct gswip_pce_table_entry vlan_active = {0,};
 	struct gswip_pce_table_entry vlan_mapping = {0,};
-	unsigned int cpu_port = priv->hw_info->cpu_port;
 	int err;
 
 	vlan_active.index = port + 1;
@@ -678,7 +677,7 @@ static int gswip_add_single_port_br(struct gswip_priv *priv, int port, bool add)
 	vlan_mapping.index = port + 1;
 	vlan_mapping.table = GSWIP_TABLE_VLAN_MAPPING;
 	vlan_mapping.val[0] = 0 /* vid */;
-	vlan_mapping.val[1] = BIT(port) | BIT(cpu_port);
+	vlan_mapping.val[1] = BIT(port) | dsa_cpu_ports(priv->ds);
 	vlan_mapping.val[2] = 0;
 	err = gswip_pce_table_entry_write(priv, &vlan_mapping);
 	if (err) {
@@ -808,10 +807,10 @@ static int gswip_port_vlan_filtering(struct dsa_switch *ds, int port,
 
 static int gswip_setup(struct dsa_switch *ds)
 {
+	unsigned int cpu_ports = dsa_cpu_ports(ds);
 	struct gswip_priv *priv = ds->priv;
-	unsigned int cpu_port = priv->hw_info->cpu_port;
-	int i;
-	int err;
+	struct dsa_port *cpu_dp;
+	int err, i;
 
 	gswip_switch_w(priv, GSWIP_SWRES_R0, GSWIP_SWRES);
 	usleep_range(5000, 10000);
@@ -833,9 +832,9 @@ static int gswip_setup(struct dsa_switch *ds)
 	}
 
 	/* Default unknown Broadcast/Multicast/Unicast port maps */
-	gswip_switch_w(priv, BIT(cpu_port), GSWIP_PCE_PMAP1);
-	gswip_switch_w(priv, BIT(cpu_port), GSWIP_PCE_PMAP2);
-	gswip_switch_w(priv, BIT(cpu_port), GSWIP_PCE_PMAP3);
+	gswip_switch_w(priv, cpu_ports, GSWIP_PCE_PMAP1);
+	gswip_switch_w(priv, cpu_ports, GSWIP_PCE_PMAP2);
+	gswip_switch_w(priv, cpu_ports, GSWIP_PCE_PMAP3);
 
 	/* Deactivate MDIO PHY auto polling. Some PHYs as the AR8030 have an
 	 * interoperability problem with this auto polling mechanism because
@@ -864,13 +863,15 @@ static int gswip_setup(struct dsa_switch *ds)
 				   GSWIP_MII_CFG_EN | GSWIP_MII_CFG_ISOLATE,
 				   0, i);
 
-	/* enable special tag insertion on cpu port */
-	gswip_switch_mask(priv, 0, GSWIP_FDMA_PCTRL_STEN,
-			  GSWIP_FDMA_PCTRLp(cpu_port));
+	dsa_switch_for_each_cpu_port(cpu_dp, ds) {
+		/* enable special tag insertion on cpu port */
+		gswip_switch_mask(priv, 0, GSWIP_FDMA_PCTRL_STEN,
+				  GSWIP_FDMA_PCTRLp(cpu_dp->index));
 
-	/* accept special tag in ingress direction */
-	gswip_switch_mask(priv, 0, GSWIP_PCE_PCTRL_0_INGRESS,
-			  GSWIP_PCE_PCTRL_0p(cpu_port));
+		/* accept special tag in ingress direction */
+		gswip_switch_mask(priv, 0, GSWIP_PCE_PCTRL_0_INGRESS,
+				  GSWIP_PCE_PCTRL_0p(cpu_dp->index));
+	}
 
 	gswip_switch_mask(priv, 0, GSWIP_BM_QUEUE_GCTRL_GL_MOD,
 			  GSWIP_BM_QUEUE_GCTRL);
@@ -966,7 +967,6 @@ static int gswip_vlan_add_unaware(struct gswip_priv *priv,
 {
 	struct gswip_pce_table_entry vlan_mapping = {0,};
 	unsigned int max_ports = priv->hw_info->max_ports;
-	unsigned int cpu_port = priv->hw_info->cpu_port;
 	bool active_vlan_created = false;
 	int idx = -1;
 	int i;
@@ -1006,7 +1006,7 @@ static int gswip_vlan_add_unaware(struct gswip_priv *priv,
 	}
 
 	/* Update the VLAN mapping entry and write it to the switch */
-	vlan_mapping.val[1] |= BIT(cpu_port);
+	vlan_mapping.val[1] |= dsa_cpu_ports(priv->ds);
 	vlan_mapping.val[1] |= BIT(port);
 	err = gswip_pce_table_entry_write(priv, &vlan_mapping);
 	if (err) {
@@ -1028,7 +1028,7 @@ static int gswip_vlan_add_aware(struct gswip_priv *priv,
 {
 	struct gswip_pce_table_entry vlan_mapping = {0,};
 	unsigned int max_ports = priv->hw_info->max_ports;
-	unsigned int cpu_port = priv->hw_info->cpu_port;
+	unsigned int cpu_ports = dsa_cpu_ports(priv->ds);
 	bool active_vlan_created = false;
 	int idx = -1;
 	int fid = -1;
@@ -1075,8 +1075,8 @@ static int gswip_vlan_add_aware(struct gswip_priv *priv,
 
 	vlan_mapping.val[0] = vid;
 	/* Update the VLAN mapping entry and write it to the switch */
-	vlan_mapping.val[1] |= BIT(cpu_port);
-	vlan_mapping.val[2] |= BIT(cpu_port);
+	vlan_mapping.val[1] |= cpu_ports;
+	vlan_mapping.val[2] |= cpu_ports;
 	vlan_mapping.val[1] |= BIT(port);
 	if (untagged)
 		vlan_mapping.val[2] &= ~BIT(port);
@@ -1103,7 +1103,6 @@ static int gswip_vlan_remove(struct gswip_priv *priv,
 {
 	struct gswip_pce_table_entry vlan_mapping = {0,};
 	unsigned int max_ports = priv->hw_info->max_ports;
-	unsigned int cpu_port = priv->hw_info->cpu_port;
 	int idx = -1;
 	int i;
 	int err;
@@ -1139,7 +1138,7 @@ static int gswip_vlan_remove(struct gswip_priv *priv,
 	}
 
 	/* In case all ports are removed from the bridge, remove the VLAN */
-	if ((vlan_mapping.val[1] & ~BIT(cpu_port)) == 0) {
+	if (!(vlan_mapping.val[1] & ~dsa_cpu_ports(priv->ds))) {
 		err = gswip_vlan_active_remove(priv, idx);
 		if (err) {
 			dev_err(priv->dev, "failed to write active VLAN: %d\n",
@@ -2090,6 +2089,30 @@ static int gswip_gphy_fw_list(struct gswip_priv *priv,
 	return err;
 }
 
+static int gswip_validate_cpu_port(struct dsa_switch *ds)
+{
+	struct gswip_priv *priv = ds->priv;
+	struct dsa_port *cpu_dp;
+	int cpu_port = -1;
+
+	dsa_switch_for_each_cpu_port(cpu_dp, ds) {
+		if (cpu_port != -1)
+			return dev_err_probe(ds->dev, -EINVAL,
+					     "only a single CPU port is supported\n");
+
+		cpu_port = cpu_dp->index;
+	}
+
+	if (cpu_port == -1)
+		return dev_err_probe(ds->dev, -EINVAL, "no CPU port defined\n");
+
+	if (BIT(cpu_port) & ~priv->hw_info->allowed_cpu_ports)
+		return dev_err_probe(ds->dev, -EINVAL,
+				     "unsupported CPU port defined\n");
+
+	return 0;
+}
+
 static int gswip_probe(struct platform_device *pdev)
 {
 	struct device_node *np, *gphy_fw_np;
@@ -2172,12 +2195,10 @@ static int gswip_probe(struct platform_device *pdev)
 		dev_err_probe(dev, err, "dsa switch registration failed\n");
 		goto gphy_fw_remove;
 	}
-	if (!dsa_is_cpu_port(priv->ds, priv->hw_info->cpu_port)) {
-		err = dev_err_probe(dev, -EINVAL,
-				    "wrong CPU port defined, HW only supports port: %i\n",
-				    priv->hw_info->cpu_port);
+
+	err = gswip_validate_cpu_port(priv->ds);
+	if (err)
 		goto disable_switch;
-	}
 
 	platform_set_drvdata(pdev, priv);
 
@@ -2226,13 +2247,13 @@ static void gswip_shutdown(struct platform_device *pdev)
 
 static const struct gswip_hw_info gswip_xrx200 = {
 	.max_ports = 7,
-	.cpu_port = 6,
+	.allowed_cpu_ports = BIT(6),
 	.phylink_get_caps = gswip_xrx200_phylink_get_caps,
 };
 
 static const struct gswip_hw_info gswip_xrx300 = {
 	.max_ports = 7,
-	.cpu_port = 6,
+	.allowed_cpu_ports = BIT(6),
 	.phylink_get_caps = gswip_xrx300_phylink_get_caps,
 };
 
-- 
2.50.1

