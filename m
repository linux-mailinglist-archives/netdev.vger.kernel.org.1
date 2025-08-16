Return-Path: <netdev+bounces-214333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DD8B29059
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 21:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99E197B9F1B
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 19:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812C7212575;
	Sat, 16 Aug 2025 19:52:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1395BAF0;
	Sat, 16 Aug 2025 19:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755373964; cv=none; b=iRpCR5gO+czCHZh4OSetpp/G2hxBoZTPQar9Q7K5oatio6TOEDEEs8hnE+yaAuV1PJ8G1TSN0xoKf29xtu+9jtXyNjsCvHTmAKcW+NkXFdKgQ1A8xbBAeuiIfgoiL4kQvDRYOTy+/Yx0xOiuJ7bO4XzEvYQxHzm7BLun1msp5Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755373964; c=relaxed/simple;
	bh=bXsn+pmUzY2vpqOVcdxEgxEgCsqCA8jPJGApuiEhCVA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eAn9hBCABvwJeFIZ07068ggKeWpjVwp+LC77is6C8dSwKEnmT6VIPjSrBCcCEClu/SHyN2E97SejPt6MhmvHGO/vgEvhgYA/yxW4Ey+vhinvrepWyiHlu4rr3NUrBiidfOgJBN0wzMVPT3tRzmC+wHYBGmTKiVLjGxoiKYJFmU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1unMx7-000000006zG-3Px6;
	Sat, 16 Aug 2025 19:52:33 +0000
Date: Sat, 16 Aug 2025 20:52:30 +0100
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
Subject: [PATCH RFC net-next 08/23] net: dsa: lantiq_gswip: store switch API
 version in priv
Message-ID: <aKDhfn-92oPzDcYY@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Store the switch API version in struct gswip_priv to prepare supporting
newer features such as 4096 VLANs and per-port configurable learning.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq_gswip.c | 13 ++++++-------
 drivers/net/dsa/lantiq_gswip.h |  1 +
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index a66466bac1a8..16b92af9ff23 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -1882,7 +1882,6 @@ static int gswip_probe(struct platform_device *pdev)
 	struct gswip_priv *priv;
 	int err;
 	int i;
-	u32 version;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -1915,10 +1914,10 @@ static int gswip_probe(struct platform_device *pdev)
 	priv->ds->phylink_mac_ops = &gswip_phylink_mac_ops;
 	priv->dev = dev;
 	mutex_init(&priv->pce_table_lock);
-	version = gswip_switch_r(priv, GSWIP_VERSION);
+	priv->version = gswip_switch_r(priv, GSWIP_VERSION);
 
 	np = dev->of_node;
-	switch (version) {
+	switch (priv->version) {
 	case GSWIP_VERSION_2_0:
 	case GSWIP_VERSION_2_1:
 		if (!of_device_is_compatible(np, "lantiq,xrx200-gswip"))
@@ -1932,13 +1931,13 @@ static int gswip_probe(struct platform_device *pdev)
 		break;
 	default:
 		return dev_err_probe(dev, -ENOENT,
-				     "unknown GSWIP version: 0x%x\n", version);
+				     "unknown GSWIP version: 0x%x\n", priv->version);
 	}
 
 	/* bring up the mdio bus */
 	gphy_fw_np = of_get_compatible_child(dev->of_node, "lantiq,gphy-fw");
 	if (gphy_fw_np) {
-		err = gswip_gphy_fw_list(priv, gphy_fw_np, version);
+		err = gswip_gphy_fw_list(priv, gphy_fw_np, priv->version);
 		of_node_put(gphy_fw_np);
 		if (err)
 			return dev_err_probe(dev, err,
@@ -1965,8 +1964,8 @@ static int gswip_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, priv);
 
 	dev_info(dev, "probed GSWIP version %lx mod %lx\n",
-		 (version & GSWIP_VERSION_REV_MASK) >> GSWIP_VERSION_REV_SHIFT,
-		 (version & GSWIP_VERSION_MOD_MASK) >> GSWIP_VERSION_MOD_SHIFT);
+		 (priv->version & GSWIP_VERSION_REV_MASK) >> GSWIP_VERSION_REV_SHIFT,
+		 (priv->version & GSWIP_VERSION_MOD_MASK) >> GSWIP_VERSION_MOD_SHIFT);
 	return 0;
 
 disable_switch:
diff --git a/drivers/net/dsa/lantiq_gswip.h b/drivers/net/dsa/lantiq_gswip.h
index c68848fb1c2d..433b65b047dd 100644
--- a/drivers/net/dsa/lantiq_gswip.h
+++ b/drivers/net/dsa/lantiq_gswip.h
@@ -260,6 +260,7 @@ struct gswip_priv {
 	int num_gphy_fw;
 	struct gswip_gphy_fw *gphy_fw;
 	u32 port_vlan_filter;
+	u32 version;
 	struct mutex pce_table_lock;
 };
 
-- 
2.50.1

