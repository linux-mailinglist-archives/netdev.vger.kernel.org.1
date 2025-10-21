Return-Path: <netdev+bounces-231177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC963BF5FD2
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 13:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F1614F9EBF
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 11:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D432F3C3D;
	Tue, 21 Oct 2025 11:17:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A7B2F3C1A;
	Tue, 21 Oct 2025 11:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761045443; cv=none; b=TPR++PxEOvvqmC8swNSeWkTBEAJcIz+szSmfIyvhxf188dgA4/jhJMas+A4QyercV6qNWyo22oLKhSzKo4pKJ/GtI00KyRz+H6Sw1DC03LL+S5vVSJH4QiXItuJi7sFWIUokXSqeIC52L595J4bOo4RqmpJWhL8Ts1ND8BV8JSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761045443; c=relaxed/simple;
	bh=N9H1S3R0pYsr5biq+VuX1KezEmcoiky2weckzpSLs5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTcCQq73IXcCG/5DD+THHlhD+M/h2HCMHDtA2aij2aLIs0VM62eB7fm/atLXsN6iZJs5vZITAu2YCSRlZqE18RcyCqn34OyJi18NnsxI9dLZio7ytJ6/0c8V395Y0JkFp671Ta9+2rloQAGdIbPBIgE8NlvkmRv29359xL2FmiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vBAMf-0000000019M-3G2C;
	Tue, 21 Oct 2025 11:17:17 +0000
Date: Tue, 21 Oct 2025 12:17:14 +0100
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
Subject: [PATCH net-next v5 6/7] net: dsa: lantiq_gswip: optimize
 regmap_write_bits() statements
Message-ID: <fce2f964b22fe3efc234c664b1e50de28dddf512.1761045000.git.daniel@makrotopia.org>
References: <cover.1761045000.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761045000.git.daniel@makrotopia.org>

Further optimize the previous naive conversion of the *_mask() accessor
functions to regmap_write_bits by manually removing redundant mask
operands.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: optimize more of the regmap_write_bits() calls

 drivers/net/dsa/lantiq/lantiq_gswip.c | 33 ++++++++++++---------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
index 71dfddd62d9f..248323524166 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
@@ -276,7 +276,7 @@ static int gswip_pce_table_entry_read(struct gswip_priv *priv,
 	regmap_write_bits(priv->gswip, GSWIP_PCE_TBL_CTRL,
 			  GSWIP_PCE_TBL_CTRL_ADDR_MASK |
 			  GSWIP_PCE_TBL_CTRL_OPMOD_MASK |
-			  tbl->table | addr_mode | GSWIP_PCE_TBL_CTRL_BAS,
+			  GSWIP_PCE_TBL_CTRL_BAS,
 			  tbl->table | addr_mode | GSWIP_PCE_TBL_CTRL_BAS);
 
 	err = gswip_switch_r_timeout(priv, GSWIP_PCE_TBL_CTRL,
@@ -337,8 +337,7 @@ static int gswip_pce_table_entry_write(struct gswip_priv *priv,
 	regmap_write(priv->gswip, GSWIP_PCE_TBL_ADDR, tbl->index);
 	regmap_write_bits(priv->gswip, GSWIP_PCE_TBL_CTRL,
 			  GSWIP_PCE_TBL_CTRL_ADDR_MASK |
-			  GSWIP_PCE_TBL_CTRL_OPMOD_MASK |
-			  tbl->table | addr_mode,
+			  GSWIP_PCE_TBL_CTRL_OPMOD_MASK,
 			  tbl->table | addr_mode);
 
 	for (i = 0; i < ARRAY_SIZE(tbl->key); i++)
@@ -349,8 +348,7 @@ static int gswip_pce_table_entry_write(struct gswip_priv *priv,
 
 	regmap_write_bits(priv->gswip, GSWIP_PCE_TBL_CTRL,
 			  GSWIP_PCE_TBL_CTRL_ADDR_MASK |
-			  GSWIP_PCE_TBL_CTRL_OPMOD_MASK |
-			  tbl->table | addr_mode,
+			  GSWIP_PCE_TBL_CTRL_OPMOD_MASK,
 			  tbl->table | addr_mode);
 
 	regmap_write(priv->gswip, GSWIP_PCE_TBL_MASK, tbl->mask);
@@ -439,7 +437,7 @@ static int gswip_port_enable(struct dsa_switch *ds, int port,
 			mdio_phy = phydev->mdio.addr & GSWIP_MDIO_PHY_ADDR_MASK;
 
 		regmap_write_bits(priv->mdio, GSWIP_MDIO_PHYp(port),
-				  GSWIP_MDIO_PHY_ADDR_MASK | mdio_phy,
+				  GSWIP_MDIO_PHY_ADDR_MASK,
 				  mdio_phy);
 	}
 
@@ -542,8 +540,7 @@ static void gswip_port_commit_pvid(struct gswip_priv *priv, int port)
 
 	vinr = idx ? GSWIP_PCE_VCTRL_VINR_ALL : GSWIP_PCE_VCTRL_VINR_TAGGED;
 	regmap_write_bits(priv->gswip, GSWIP_PCE_VCTRL(port),
-			  GSWIP_PCE_VCTRL_VINR |
-			  FIELD_PREP(GSWIP_PCE_VCTRL_VINR, vinr),
+			  GSWIP_PCE_VCTRL_VINR,
 			  FIELD_PREP(GSWIP_PCE_VCTRL_VINR, vinr));
 
 	/* Note that in GSWIP 2.2 VLAN mode the VID needs to be programmed
@@ -642,7 +639,7 @@ static int gswip_setup(struct dsa_switch *ds)
 	regmap_write(priv->mdio, GSWIP_MDIO_MDC_CFG0, 0x0);
 
 	/* Configure the MDIO Clock 2.5 MHz */
-	regmap_write_bits(priv->mdio, GSWIP_MDIO_MDC_CFG1, 0xff | 0x09, 0x09);
+	regmap_write_bits(priv->mdio, GSWIP_MDIO_MDC_CFG1, 0xff, 0x09);
 
 	/* bring up the mdio bus */
 	err = gswip_mdio(priv);
@@ -1084,7 +1081,7 @@ static void gswip_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 	regmap_set_bits(priv->gswip, GSWIP_SDMA_PCTRLp(port),
 			GSWIP_SDMA_PCTRL_EN);
 	regmap_write_bits(priv->gswip, GSWIP_PCE_PCTRL_0p(port),
-			  GSWIP_PCE_PCTRL_0_PSTATE_MASK | stp_state,
+			  GSWIP_PCE_PCTRL_0_PSTATE_MASK,
 			  stp_state);
 }
 
@@ -1315,7 +1312,7 @@ static void gswip_port_set_link(struct gswip_priv *priv, int port, bool link)
 		mdio_phy = GSWIP_MDIO_PHY_LINK_DOWN;
 
 	regmap_write_bits(priv->mdio, GSWIP_MDIO_PHYp(port),
-			  GSWIP_MDIO_PHY_LINK_MASK | mdio_phy, mdio_phy);
+			  GSWIP_MDIO_PHY_LINK_MASK, mdio_phy);
 }
 
 static void gswip_port_set_speed(struct gswip_priv *priv, int port, int speed,
@@ -1356,10 +1353,10 @@ static void gswip_port_set_speed(struct gswip_priv *priv, int port, int speed,
 	}
 
 	regmap_write_bits(priv->mdio, GSWIP_MDIO_PHYp(port),
-			  GSWIP_MDIO_PHY_SPEED_MASK | mdio_phy, mdio_phy);
+			  GSWIP_MDIO_PHY_SPEED_MASK, mdio_phy);
 	gswip_mii_mask_cfg(priv, GSWIP_MII_CFG_RATE_MASK, mii_cfg, port);
 	regmap_write_bits(priv->gswip, GSWIP_MAC_CTRL_0p(port),
-			  GSWIP_MAC_CTRL_0_GMII_MASK | mac_ctrl_0, mac_ctrl_0);
+			  GSWIP_MAC_CTRL_0_GMII_MASK, mac_ctrl_0);
 }
 
 static void gswip_port_set_duplex(struct gswip_priv *priv, int port, int duplex)
@@ -1375,9 +1372,9 @@ static void gswip_port_set_duplex(struct gswip_priv *priv, int port, int duplex)
 	}
 
 	regmap_write_bits(priv->gswip, GSWIP_MAC_CTRL_0p(port),
-			  GSWIP_MAC_CTRL_0_FDUP_MASK | mac_ctrl_0, mac_ctrl_0);
+			  GSWIP_MAC_CTRL_0_FDUP_MASK, mac_ctrl_0);
 	regmap_write_bits(priv->mdio, GSWIP_MDIO_PHYp(port),
-			  GSWIP_MDIO_PHY_FDUP_MASK | mdio_phy, mdio_phy);
+			  GSWIP_MDIO_PHY_FDUP_MASK, mdio_phy);
 }
 
 static void gswip_port_set_pause(struct gswip_priv *priv, int port,
@@ -1404,9 +1401,9 @@ static void gswip_port_set_pause(struct gswip_priv *priv, int port,
 	}
 
 	regmap_write_bits(priv->gswip, GSWIP_MAC_CTRL_0p(port),
-			  GSWIP_MAC_CTRL_0_FCON_MASK | mac_ctrl_0, mac_ctrl_0);
+			  GSWIP_MAC_CTRL_0_FCON_MASK, mac_ctrl_0);
 	regmap_write_bits(priv->mdio, GSWIP_MDIO_PHYp(port),
-			  GSWIP_MDIO_PHY_FCONTX_MASK | GSWIP_MDIO_PHY_FCONRX_MASK | mdio_phy,
+			  GSWIP_MDIO_PHY_FCONTX_MASK | GSWIP_MDIO_PHY_FCONRX_MASK,
 			  mdio_phy);
 }
 
@@ -1528,7 +1525,7 @@ static u32 gswip_bcm_ram_entry_read(struct gswip_priv *priv, u32 table,
 	regmap_write(priv->gswip, GSWIP_BM_RAM_ADDR, index);
 	regmap_write_bits(priv->gswip, GSWIP_BM_RAM_CTRL,
 			  GSWIP_BM_RAM_CTRL_ADDR_MASK | GSWIP_BM_RAM_CTRL_OPMOD |
-			  table | GSWIP_BM_RAM_CTRL_BAS,
+			  GSWIP_BM_RAM_CTRL_BAS,
 			  table | GSWIP_BM_RAM_CTRL_BAS);
 
 	err = gswip_switch_r_timeout(priv, GSWIP_BM_RAM_CTRL,
-- 
2.51.1

