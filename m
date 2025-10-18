Return-Path: <netdev+bounces-230654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 324CFBEC569
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 04:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97F1B1AA75FD
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 02:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C26321FF26;
	Sat, 18 Oct 2025 02:33:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E9C2747B;
	Sat, 18 Oct 2025 02:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760754804; cv=none; b=tSQG3oc/usJmesxSYlXK9l5D99z61i60Snr22xFuq6gmCEx8CH2Lah8kjB+dui0+67lYI9/Vdq2PuZkJmYd88TUoujCldLpkdWqjDiYS9Lw915RMoomkDMxqnUtF4QwUktrVn7M0I5QSjKCvrwzXULT+6BHAH2yEWvE3cMs4h84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760754804; c=relaxed/simple;
	bh=et6r6n/3oXz5DXYpqhV3oI3Yckdb8ZiQorXgwkY6gn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mr9XHKud6ZqQjfdhpiRO4z6pnksEwxPTCjKLwO0ZjzIFHH+aa67lefKdf2DNdZWThufM9b85bZR6bU41BxlNru9f8sKAfhTE+DcQv7ig009jBQw5CCUZybotZ3k4Ibg4ORWI4nInZduGu65YCPfJmQVAJCqeV52/CSZWEl5S2TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1v9wku-000000002GI-3DIa;
	Sat, 18 Oct 2025 02:33:16 +0000
Date: Sat, 18 Oct 2025 03:33:13 +0100
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
Subject: [PATCH net-net v2 5/7] net: dsa: lantiq_gswip: replace *_mask()
 functions with regmap API
Message-ID: <9e28b82257ee8706232c5523235bbfd441add3af.1760753833.git.daniel@makrotopia.org>
References: <cover.1760753833.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1760753833.git.daniel@makrotopia.org>

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
 drivers/net/dsa/lantiq/lantiq_gswip.c | 140 +++++++++++++-------------
 1 file changed, 70 insertions(+), 70 deletions(-)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
index 41e59f56a2e9..25fafa287ada 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
@@ -111,12 +111,6 @@ static const struct gswip_rmon_cnt_desc gswip_rmon_cnt[] = {
 	MIB_DESC(2, 0x0E, "TxGoodBytes"),
 };
 
-static void gswip_switch_mask(struct gswip_priv *priv, u32 clear, u32 set,
-			      u32 offset)
-{
-	regmap_write_bits(priv->gswip, offset, clear | set, set);
-}
-
 static u32 gswip_switch_r_timeout(struct gswip_priv *priv, u32 offset,
 				  u32 cleared)
 {
@@ -126,18 +120,6 @@ static u32 gswip_switch_r_timeout(struct gswip_priv *priv, u32 offset,
 					!(val & cleared), 20, 50000);
 }
 
-static void gswip_mdio_mask(struct gswip_priv *priv, u32 clear, u32 set,
-			    u32 offset)
-{
-	regmap_write_bits(priv->mdio, offset, clear | set, set);
-}
-
-static void gswip_mii_mask(struct gswip_priv *priv, u32 clear, u32 set,
-			   u32 offset)
-{
-	regmap_write_bits(priv->mii, offset, clear | set, set);
-}
-
 static void gswip_mii_mask_cfg(struct gswip_priv *priv, u32 clear, u32 set,
 			       int port)
 {
@@ -149,7 +131,8 @@ static void gswip_mii_mask_cfg(struct gswip_priv *priv, u32 clear, u32 set,
 
 	reg_port = port + priv->hw_info->mii_port_reg_offset;
 
-	gswip_mii_mask(priv, clear, set, GSWIP_MII_CFGp(reg_port));
+	regmap_write_bits(priv->mii, GSWIP_MII_CFGp(reg_port), clear | set,
+			  set);
 }
 
 static void gswip_mii_mask_pcdu(struct gswip_priv *priv, u32 clear, u32 set,
@@ -165,13 +148,16 @@ static void gswip_mii_mask_pcdu(struct gswip_priv *priv, u32 clear, u32 set,
 
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
@@ -289,10 +275,11 @@ static int gswip_pce_table_entry_read(struct gswip_priv *priv,
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
@@ -353,10 +340,11 @@ static int gswip_pce_table_entry_write(struct gswip_priv *priv,
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
@@ -364,10 +352,11 @@ static int gswip_pce_table_entry_write(struct gswip_priv *priv,
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
 
@@ -454,8 +443,9 @@ static int gswip_port_enable(struct dsa_switch *ds, int port,
 		if (phydev)
 			mdio_phy = phydev->mdio.addr & GSWIP_MDIO_PHY_ADDR_MASK;
 
-		gswip_mdio_mask(priv, GSWIP_MDIO_PHY_ADDR_MASK, mdio_phy,
-				GSWIP_MDIO_PHYp(port));
+		regmap_write_bits(priv->mdio, GSWIP_MDIO_PHYp(port),
+				  GSWIP_MDIO_PHY_ADDR_MASK | mdio_phy,
+				  mdio_phy);
 	}
 
 	/* RMON Counter Enable for port */
@@ -485,9 +475,11 @@ static int gswip_pce_load_microcode(struct gswip_priv *priv)
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
@@ -554,9 +546,10 @@ static void gswip_port_commit_pvid(struct gswip_priv *priv, int port)
 	}
 
 	vinr = idx ? GSWIP_PCE_VCTRL_VINR_ALL : GSWIP_PCE_VCTRL_VINR_TAGGED;
-	gswip_switch_mask(priv, GSWIP_PCE_VCTRL_VINR,
+	regmap_write_bits(priv->gswip, GSWIP_PCE_VCTRL(port),
+			  GSWIP_PCE_VCTRL_VINR |
 			  FIELD_PREP(GSWIP_PCE_VCTRL_VINR, vinr),
-			  GSWIP_PCE_VCTRL(port));
+			  FIELD_PREP(GSWIP_PCE_VCTRL_VINR, vinr));
 
 	/* Note that in GSWIP 2.2 VLAN mode the VID needs to be programmed
 	 * directly instead of referencing the index in the Active VLAN Tablet.
@@ -574,20 +567,27 @@ static int gswip_port_vlan_filtering(struct dsa_switch *ds, int port,
 
 	if (vlan_filtering) {
 		/* Use tag based VLAN */
-		gswip_switch_mask(priv,
-				  GSWIP_PCE_VCTRL_VSR,
-				  GSWIP_PCE_VCTRL_UVR | GSWIP_PCE_VCTRL_VIMR |
-				  GSWIP_PCE_VCTRL_VEMR | GSWIP_PCE_VCTRL_VID0,
-				  GSWIP_PCE_VCTRL(port));
+		regmap_write_bits(priv->gswip, GSWIP_PCE_VCTRL(port),
+				  GSWIP_PCE_VCTRL_VSR |
+				  GSWIP_PCE_VCTRL_UVR |
+				  GSWIP_PCE_VCTRL_VIMR |
+				  GSWIP_PCE_VCTRL_VEMR |
+				  GSWIP_PCE_VCTRL_VID0,
+				  GSWIP_PCE_VCTRL_UVR |
+				  GSWIP_PCE_VCTRL_VIMR |
+				  GSWIP_PCE_VCTRL_VEMR |
+				  GSWIP_PCE_VCTRL_VID0);
 		regmap_clear_bits(priv->gswip, GSWIP_PCE_PCTRL_0p(port),
 				  GSWIP_PCE_PCTRL_0_TVM);
 	} else {
 		/* Use port based VLAN */
-		gswip_switch_mask(priv,
-				  GSWIP_PCE_VCTRL_UVR | GSWIP_PCE_VCTRL_VIMR |
-				  GSWIP_PCE_VCTRL_VEMR | GSWIP_PCE_VCTRL_VID0,
+		regmap_write_bits(priv->gswip, GSWIP_PCE_VCTRL(port),
+				  GSWIP_PCE_VCTRL_UVR |
+				  GSWIP_PCE_VCTRL_VIMR |
+				  GSWIP_PCE_VCTRL_VEMR |
+				  GSWIP_PCE_VCTRL_VID0 |
 				  GSWIP_PCE_VCTRL_VSR,
-				  GSWIP_PCE_VCTRL(port));
+				  GSWIP_PCE_VCTRL_VSR);
 		regmap_set_bits(priv->gswip, GSWIP_PCE_PCTRL_0p(port),
 				GSWIP_PCE_PCTRL_0_TVM);
 	}
@@ -647,7 +647,7 @@ static int gswip_setup(struct dsa_switch *ds)
 	regmap_write(priv->mdio, GSWIP_MDIO_MDC_CFG0, 0x0);
 
 	/* Configure the MDIO Clock 2.5 MHz */
-	gswip_mdio_mask(priv, 0xff, 0x09, GSWIP_MDIO_MDC_CFG1);
+	regmap_write_bits(priv->mdio, GSWIP_MDIO_MDC_CFG1, 0xff | 0x09, 0x09);
 
 	/* bring up the mdio bus */
 	err = gswip_mdio(priv);
@@ -1088,8 +1088,9 @@ static void gswip_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 
 	regmap_set_bits(priv->gswip, GSWIP_SDMA_PCTRLp(port),
 			GSWIP_SDMA_PCTRL_EN);
-	gswip_switch_mask(priv, GSWIP_PCE_PCTRL_0_PSTATE_MASK, stp_state,
-			  GSWIP_PCE_PCTRL_0p(port));
+	regmap_write_bits(priv->gswip, GSWIP_PCE_PCTRL_0p(port),
+			  GSWIP_PCE_PCTRL_0_PSTATE_MASK | stp_state,
+			  stp_state);
 }
 
 static int gswip_port_fdb(struct dsa_switch *ds, int port,
@@ -1318,8 +1319,8 @@ static void gswip_port_set_link(struct gswip_priv *priv, int port, bool link)
 	else
 		mdio_phy = GSWIP_MDIO_PHY_LINK_DOWN;
 
-	gswip_mdio_mask(priv, GSWIP_MDIO_PHY_LINK_MASK, mdio_phy,
-			GSWIP_MDIO_PHYp(port));
+	regmap_write_bits(priv->mdio, GSWIP_MDIO_PHYp(port),
+			  GSWIP_MDIO_PHY_LINK_MASK | mdio_phy, mdio_phy);
 }
 
 static void gswip_port_set_speed(struct gswip_priv *priv, int port, int speed,
@@ -1359,11 +1360,11 @@ static void gswip_port_set_speed(struct gswip_priv *priv, int port, int speed,
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
@@ -1378,10 +1379,10 @@ static void gswip_port_set_duplex(struct gswip_priv *priv, int port, int duplex)
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
@@ -1407,12 +1408,11 @@ static void gswip_port_set_pause(struct gswip_priv *priv, int port,
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
@@ -1531,10 +1531,10 @@ static u32 gswip_bcm_ram_entry_read(struct gswip_priv *priv, u32 table,
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
2.51.1.dirty

