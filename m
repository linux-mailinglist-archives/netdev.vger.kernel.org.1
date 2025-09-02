Return-Path: <netdev+bounces-219373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D976B410D8
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 01:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F214189F357
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6762B27FD49;
	Tue,  2 Sep 2025 23:36:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7469627FD72;
	Tue,  2 Sep 2025 23:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756856192; cv=none; b=Ipsot5dY56zCnRDt3XQ0hR4MPTU49rimUUzK7T9LFJcWDPm+e9hEzTXZvnGRNbHe8B5nK0mcOgOHRatBjwcgeDK3oWVSQeVe2zwyxA7r0UmgV06Uf0Hj5qV5F5L5OJcKDA8lS+0hxqJka++lgmchiFySHIDT68FaOsAd1JrH7qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756856192; c=relaxed/simple;
	bh=QyV7zRqGf/Cods92Nyjkn7Q+43zQI1GpE39BoFbYpDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSeytibImEXqmwxAC9GrUX2V4Dj586uEEsMDlleW7VINPkolxDDMrwWjBjmiQwylXIIhcc/phenNKacS12ZpXKBn7neVF6iO+63FFn+4fX8fhO/1W4CuCqfO46i7qtSlZdD+lzxgd9qRyxUHiLnTgwgHyxB6tOa0U6s25cbxudc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1utaY5-000000001Iu-44fF;
	Tue, 02 Sep 2025 23:36:26 +0000
Date: Wed, 3 Sep 2025 00:36:22 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
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
Subject: [RFC PATCH net-next 4/6] net: dsa: lantiq_gswip: replace *_mask()
 functions with regmap API
Message-ID: <09e2fb66a9b4a35057c89160de4beb312f13b688.1756855069.git.daniel@makrotopia.org>
References: <cover.1756855069.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756855069.git.daniel@makrotopia.org>

Use coccinelle to replace all uses of *_mask() with an equivalent call
to regmap_write_bits().

// Replace gswip_switch_mask with regmap_write_bits
@@
expression priv, clear, set, offset;
@@
- gswip_switch_mask(priv, clear, set, offset)
+ regmap_write_bits(priv->gswip, offset, clear | set, set)

// Replace gswip_mdio_mask with regmap_write_bits
@@
expression priv, clear, set, offset;
@@
- gswip_mdio_mask(priv, clear, set, offset)
+ regmap_write_bits(priv->mdio, offset, clear | set, set)

// Replace gswip_mii_mask with regmap_write_bits
@@
expression priv, clear, set, offset;
@@
- gswip_mii_mask(priv, clear, set, offset)
+ regmap_write_bits(priv->mii, offset, clear | set, set)

Remove the new unused *_mask() functions.
This naive approach will be further optmized manually in the next commit.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq/lantiq_gswip.c | 148 +++++++++++---------------
 1 file changed, 63 insertions(+), 85 deletions(-)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
index 7ba562f02b57..1fd18b3899b7 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
@@ -111,18 +111,6 @@ static const struct gswip_rmon_cnt_desc gswip_rmon_cnt[] = {
 	MIB_DESC(2, 0x0E, "TxGoodBytes"),
 };
 
-static void gswip_switch_mask(struct gswip_priv *priv, u32 clear, u32 set,
-			      u32 offset)
-{
-	int ret;
-
-	ret = regmap_write_bits(priv->gswip, offset, clear | set, set);
-	if (ret) {
-		WARN_ON_ONCE(1);
-		dev_err(priv->dev, "failed to update switch register\n");
-	}
-}
-
 static u32 gswip_switch_r_timeout(struct gswip_priv *priv, u32 offset,
 				  u32 cleared)
 {
@@ -132,30 +120,6 @@ static u32 gswip_switch_r_timeout(struct gswip_priv *priv, u32 offset,
 					!(val & cleared), 20, 50000);
 }
 
-static void gswip_mdio_mask(struct gswip_priv *priv, u32 clear, u32 set,
-			    u32 offset)
-{
-	int ret;
-
-	ret = regmap_write_bits(priv->mdio, offset, clear | set, set);
-	if (ret) {
-		WARN_ON_ONCE(1);
-		dev_err(priv->dev, "failed to update mdio register\n");
-	}
-}
-
-static void gswip_mii_mask(struct gswip_priv *priv, u32 clear, u32 set,
-			   u32 offset)
-{
-	int ret;
-
-	ret = regmap_write_bits(priv->mii, offset, clear | set, set);
-	if (ret) {
-		WARN_ON_ONCE(1);
-		dev_err(priv->dev, "failed to update mdio register\n");
-	}
-}
-
 static void gswip_mii_mask_cfg(struct gswip_priv *priv, u32 clear, u32 set,
 			       int port)
 {
@@ -167,7 +131,8 @@ static void gswip_mii_mask_cfg(struct gswip_priv *priv, u32 clear, u32 set,
 
 	reg_port = port + priv->hw_info->mii_port_reg_offset;
 
-	gswip_mii_mask(priv, clear, set, GSWIP_MII_CFGp(reg_port));
+	regmap_write_bits(priv->mii, GSWIP_MII_CFGp(reg_port), clear | set,
+			  set);
 }
 
 static void gswip_mii_mask_pcdu(struct gswip_priv *priv, u32 clear, u32 set,
@@ -183,13 +148,16 @@ static void gswip_mii_mask_pcdu(struct gswip_priv *priv, u32 clear, u32 set,
 
 	switch (reg_port) {
 	case 0:
-		gswip_mii_mask(priv, clear, set, GSWIP_MII_PCDU0);
+		regmap_write_bits(priv->mii, GSWIP_MII_PCDU0, clear | set,
+				  set);
 		break;
 	case 1:
-		gswip_mii_mask(priv, clear, set, GSWIP_MII_PCDU1);
+		regmap_write_bits(priv->mii, GSWIP_MII_PCDU1, clear | set,
+				  set);
 		break;
 	case 5:
-		gswip_mii_mask(priv, clear, set, GSWIP_MII_PCDU5);
+		regmap_write_bits(priv->mii, GSWIP_MII_PCDU5, clear | set,
+				  set);
 		break;
 	}
 }
@@ -307,10 +275,11 @@ static int gswip_pce_table_entry_read(struct gswip_priv *priv,
 	}
 
 	regmap_write(priv->gswip, GSWIP_PCE_TBL_ADDR, tbl->index);
-	gswip_switch_mask(priv, GSWIP_PCE_TBL_CTRL_ADDR_MASK |
-				GSWIP_PCE_TBL_CTRL_OPMOD_MASK,
+	regmap_write_bits(priv->gswip, GSWIP_PCE_TBL_CTRL,
+			  GSWIP_PCE_TBL_CTRL_ADDR_MASK |
+			  GSWIP_PCE_TBL_CTRL_OPMOD_MASK |
 			  tbl->table | addr_mode | GSWIP_PCE_TBL_CTRL_BAS,
-			  GSWIP_PCE_TBL_CTRL);
+			  tbl->table | addr_mode | GSWIP_PCE_TBL_CTRL_BAS);
 
 	err = gswip_switch_r_timeout(priv, GSWIP_PCE_TBL_CTRL,
 				     GSWIP_PCE_TBL_CTRL_BAS);
@@ -371,10 +340,11 @@ static int gswip_pce_table_entry_write(struct gswip_priv *priv,
 	}
 
 	regmap_write(priv->gswip, GSWIP_PCE_TBL_ADDR, tbl->index);
-	gswip_switch_mask(priv, GSWIP_PCE_TBL_CTRL_ADDR_MASK |
-				GSWIP_PCE_TBL_CTRL_OPMOD_MASK,
+	regmap_write_bits(priv->gswip, GSWIP_PCE_TBL_CTRL,
+			  GSWIP_PCE_TBL_CTRL_ADDR_MASK |
+			  GSWIP_PCE_TBL_CTRL_OPMOD_MASK |
 			  tbl->table | addr_mode,
-			  GSWIP_PCE_TBL_CTRL);
+			  tbl->table | addr_mode);
 
 	for (i = 0; i < ARRAY_SIZE(tbl->key); i++)
 		regmap_write(priv->gswip, GSWIP_PCE_TBL_KEY(i), tbl->key[i]);
@@ -382,10 +352,11 @@ static int gswip_pce_table_entry_write(struct gswip_priv *priv,
 	for (i = 0; i < ARRAY_SIZE(tbl->val); i++)
 		regmap_write(priv->gswip, GSWIP_PCE_TBL_VAL(i), tbl->val[i]);
 
-	gswip_switch_mask(priv, GSWIP_PCE_TBL_CTRL_ADDR_MASK |
-				GSWIP_PCE_TBL_CTRL_OPMOD_MASK,
+	regmap_write_bits(priv->gswip, GSWIP_PCE_TBL_CTRL,
+			  GSWIP_PCE_TBL_CTRL_ADDR_MASK |
+			  GSWIP_PCE_TBL_CTRL_OPMOD_MASK |
 			  tbl->table | addr_mode,
-			  GSWIP_PCE_TBL_CTRL);
+			  tbl->table | addr_mode);
 
 	regmap_write(priv->gswip, GSWIP_PCE_TBL_MASK, tbl->mask);
 
@@ -463,8 +434,9 @@ static int gswip_port_enable(struct dsa_switch *ds, int port,
 		if (phydev)
 			mdio_phy = phydev->mdio.addr & GSWIP_MDIO_PHY_ADDR_MASK;
 
-		gswip_mdio_mask(priv, GSWIP_MDIO_PHY_ADDR_MASK, mdio_phy,
-				GSWIP_MDIO_PHYp(port));
+		regmap_write_bits(priv->mdio, GSWIP_MDIO_PHYp(port),
+				  GSWIP_MDIO_PHY_ADDR_MASK | mdio_phy,
+				  mdio_phy);
 	}
 
 	/* RMON Counter Enable for port */
@@ -494,9 +466,11 @@ static int gswip_pce_load_microcode(struct gswip_priv *priv)
 	int i;
 	int err;
 
-	gswip_switch_mask(priv, GSWIP_PCE_TBL_CTRL_ADDR_MASK |
-				GSWIP_PCE_TBL_CTRL_OPMOD_MASK,
-			  GSWIP_PCE_TBL_CTRL_OPMOD_ADWR, GSWIP_PCE_TBL_CTRL);
+	regmap_write_bits(priv->gswip, GSWIP_PCE_TBL_CTRL,
+			  GSWIP_PCE_TBL_CTRL_ADDR_MASK |
+			  GSWIP_PCE_TBL_CTRL_OPMOD_MASK |
+			  GSWIP_PCE_TBL_CTRL_OPMOD_ADWR,
+			  GSWIP_PCE_TBL_CTRL_OPMOD_ADWR);
 	regmap_write(priv->gswip, GSWIP_PCE_TBL_MASK, 0);
 
 	for (i = 0; i < priv->hw_info->pce_microcode_size; i++) {
@@ -542,20 +516,24 @@ static int gswip_port_vlan_filtering(struct dsa_switch *ds, int port,
 
 	if (vlan_filtering) {
 		/* Use tag based VLAN */
-		gswip_switch_mask(priv,
-				  GSWIP_PCE_VCTRL_VSR,
-				  GSWIP_PCE_VCTRL_UVR | GSWIP_PCE_VCTRL_VIMR |
+		regmap_write_bits(priv->gswip, GSWIP_PCE_VCTRL(port),
+				  GSWIP_PCE_VCTRL_VSR |
+				  GSWIP_PCE_VCTRL_UVR |
+				  GSWIP_PCE_VCTRL_VIMR |
 				  GSWIP_PCE_VCTRL_VEMR,
-				  GSWIP_PCE_VCTRL(port));
+				  GSWIP_PCE_VCTRL_UVR |
+				  GSWIP_PCE_VCTRL_VIMR |
+				  GSWIP_PCE_VCTRL_VEMR);
 		regmap_clear_bits(priv->gswip, GSWIP_PCE_PCTRL_0p(port),
 				  GSWIP_PCE_PCTRL_0_TVM);
 	} else {
 		/* Use port based VLAN */
-		gswip_switch_mask(priv,
-				  GSWIP_PCE_VCTRL_UVR | GSWIP_PCE_VCTRL_VIMR |
-				  GSWIP_PCE_VCTRL_VEMR,
+		regmap_write_bits(priv->gswip, GSWIP_PCE_VCTRL(port),
+				  GSWIP_PCE_VCTRL_UVR |
+				  GSWIP_PCE_VCTRL_VIMR |
+				  GSWIP_PCE_VCTRL_VEMR |
 				  GSWIP_PCE_VCTRL_VSR,
-				  GSWIP_PCE_VCTRL(port));
+				  GSWIP_PCE_VCTRL_VSR);
 		regmap_set_bits(priv->gswip, GSWIP_PCE_PCTRL_0p(port),
 				GSWIP_PCE_PCTRL_0_TVM);
 	}
@@ -613,7 +591,7 @@ static int gswip_setup(struct dsa_switch *ds)
 	regmap_write(priv->mdio, GSWIP_MDIO_MDC_CFG0, 0x0);
 
 	/* Configure the MDIO Clock 2.5 MHz */
-	gswip_mdio_mask(priv, 0xff, 0x09, GSWIP_MDIO_MDC_CFG1);
+	regmap_write_bits(priv->mdio, GSWIP_MDIO_MDC_CFG1, 0xff | 0x09, 0x09);
 
 	/* bring up the mdio bus */
 	err = gswip_mdio(priv);
@@ -1117,8 +1095,9 @@ static void gswip_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 
 	regmap_set_bits(priv->gswip, GSWIP_SDMA_PCTRLp(port),
 			GSWIP_SDMA_PCTRL_EN);
-	gswip_switch_mask(priv, GSWIP_PCE_PCTRL_0_PSTATE_MASK, stp_state,
-			  GSWIP_PCE_PCTRL_0p(port));
+	regmap_write_bits(priv->gswip, GSWIP_PCE_PCTRL_0p(port),
+			  GSWIP_PCE_PCTRL_0_PSTATE_MASK | stp_state,
+			  stp_state);
 }
 
 static int gswip_port_fdb(struct dsa_switch *ds, int port,
@@ -1344,8 +1323,8 @@ static void gswip_port_set_link(struct gswip_priv *priv, int port, bool link)
 	else
 		mdio_phy = GSWIP_MDIO_PHY_LINK_DOWN;
 
-	gswip_mdio_mask(priv, GSWIP_MDIO_PHY_LINK_MASK, mdio_phy,
-			GSWIP_MDIO_PHYp(port));
+	regmap_write_bits(priv->mdio, GSWIP_MDIO_PHYp(port),
+			  GSWIP_MDIO_PHY_LINK_MASK | mdio_phy, mdio_phy);
 }
 
 static void gswip_port_set_speed(struct gswip_priv *priv, int port, int speed,
@@ -1385,11 +1364,11 @@ static void gswip_port_set_speed(struct gswip_priv *priv, int port, int speed,
 		break;
 	}
 
-	gswip_mdio_mask(priv, GSWIP_MDIO_PHY_SPEED_MASK, mdio_phy,
-			GSWIP_MDIO_PHYp(port));
+	regmap_write_bits(priv->mdio, GSWIP_MDIO_PHYp(port),
+			  GSWIP_MDIO_PHY_SPEED_MASK | mdio_phy, mdio_phy);
 	gswip_mii_mask_cfg(priv, GSWIP_MII_CFG_RATE_MASK, mii_cfg, port);
-	gswip_switch_mask(priv, GSWIP_MAC_CTRL_0_GMII_MASK, mac_ctrl_0,
-			  GSWIP_MAC_CTRL_0p(port));
+	regmap_write_bits(priv->gswip, GSWIP_MAC_CTRL_0p(port),
+			  GSWIP_MAC_CTRL_0_GMII_MASK | mac_ctrl_0, mac_ctrl_0);
 }
 
 static void gswip_port_set_duplex(struct gswip_priv *priv, int port, int duplex)
@@ -1404,10 +1383,10 @@ static void gswip_port_set_duplex(struct gswip_priv *priv, int port, int duplex)
 		mdio_phy = GSWIP_MDIO_PHY_FDUP_DIS;
 	}
 
-	gswip_switch_mask(priv, GSWIP_MAC_CTRL_0_FDUP_MASK, mac_ctrl_0,
-			  GSWIP_MAC_CTRL_0p(port));
-	gswip_mdio_mask(priv, GSWIP_MDIO_PHY_FDUP_MASK, mdio_phy,
-			GSWIP_MDIO_PHYp(port));
+	regmap_write_bits(priv->gswip, GSWIP_MAC_CTRL_0p(port),
+			  GSWIP_MAC_CTRL_0_FDUP_MASK | mac_ctrl_0, mac_ctrl_0);
+	regmap_write_bits(priv->mdio, GSWIP_MDIO_PHYp(port),
+			  GSWIP_MDIO_PHY_FDUP_MASK | mdio_phy, mdio_phy);
 }
 
 static void gswip_port_set_pause(struct gswip_priv *priv, int port,
@@ -1433,12 +1412,11 @@ static void gswip_port_set_pause(struct gswip_priv *priv, int port,
 			   GSWIP_MDIO_PHY_FCONRX_DIS;
 	}
 
-	gswip_switch_mask(priv, GSWIP_MAC_CTRL_0_FCON_MASK,
-			  mac_ctrl_0, GSWIP_MAC_CTRL_0p(port));
-	gswip_mdio_mask(priv,
-			GSWIP_MDIO_PHY_FCONTX_MASK |
-			GSWIP_MDIO_PHY_FCONRX_MASK,
-			mdio_phy, GSWIP_MDIO_PHYp(port));
+	regmap_write_bits(priv->gswip, GSWIP_MAC_CTRL_0p(port),
+			  GSWIP_MAC_CTRL_0_FCON_MASK | mac_ctrl_0, mac_ctrl_0);
+	regmap_write_bits(priv->mdio, GSWIP_MDIO_PHYp(port),
+			  GSWIP_MDIO_PHY_FCONTX_MASK | GSWIP_MDIO_PHY_FCONRX_MASK | mdio_phy,
+			  mdio_phy);
 }
 
 static void gswip_phylink_mac_config(struct phylink_config *config,
@@ -1557,10 +1535,10 @@ static u32 gswip_bcm_ram_entry_read(struct gswip_priv *priv, u32 table,
 	int err;
 
 	regmap_write(priv->gswip, GSWIP_BM_RAM_ADDR, index);
-	gswip_switch_mask(priv, GSWIP_BM_RAM_CTRL_ADDR_MASK |
-				GSWIP_BM_RAM_CTRL_OPMOD,
-			      table | GSWIP_BM_RAM_CTRL_BAS,
-			      GSWIP_BM_RAM_CTRL);
+	regmap_write_bits(priv->gswip, GSWIP_BM_RAM_CTRL,
+			  GSWIP_BM_RAM_CTRL_ADDR_MASK | GSWIP_BM_RAM_CTRL_OPMOD |
+			  table | GSWIP_BM_RAM_CTRL_BAS,
+			  table | GSWIP_BM_RAM_CTRL_BAS);
 
 	err = gswip_switch_r_timeout(priv, GSWIP_BM_RAM_CTRL,
 				     GSWIP_BM_RAM_CTRL_BAS);
-- 
2.51.0

