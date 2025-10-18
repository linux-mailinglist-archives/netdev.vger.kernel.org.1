Return-Path: <netdev+bounces-230655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6352BEC572
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 04:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72BF16E8710
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 02:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F79225779;
	Sat, 18 Oct 2025 02:33:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADAB221F24;
	Sat, 18 Oct 2025 02:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760754810; cv=none; b=nMPS2vFd61m34NmiRvF+h9ftBm362JMB9jPaaG9Gkn0/zBoBm0AAgt4+q2aV0lQ5Y4B615i9e52GypW+6crOhWWXJSAtnTeyK+WY8VwMz91U83463ykGZ2dVsn/KJ+iKlX9inhieEF1epgywCSXPEbwexHbeyFvpvahPduSyFbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760754810; c=relaxed/simple;
	bh=MXPowuplFqcB8snzP8QdyLKCXOi8F2q7eH6JFO/sRVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRl1SxrWxtlq6k1RtTnMpn54x+m+bt7jA2+46u5SWGLah5kNg+t5yfa/thoM9p+8+V30A0oh5hBGVSb1OrN8E6eO9uvGXPFO+V5++PqaendfH//EqO0LDmOH6UixyC0vNTrJI/yYA7lclizwhbPLl91eR/n4RNhFNIv/SFnMlHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1v9wl2-000000002Gf-0WGl;
	Sat, 18 Oct 2025 02:33:24 +0000
Date: Sat, 18 Oct 2025 03:33:20 +0100
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
Subject: [PATCH net-net v2 6/7] net: dsa: lantiq_gswip: optimize
 regmap_write_bits() statements
Message-ID: <b3991d09fc5c55adbf1858d0e697b2c62fbe1ba1.1760753833.git.daniel@makrotopia.org>
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

Further optimize the previous naive conversion of the *_mask() accessor
functions to regmap_write_bits by manually removing redundant mask
operands.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: optimize more of the regmap_write_bits() calls
 drivers/net/dsa/lantiq/lantiq_gswip.c | 33 ++++++++++++---------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
index 25fafa287ada..f54fbd0e48f8 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
@@ -278,7 +278,7 @@ static int gswip_pce_table_entry_read(struct gswip_priv *priv,
 	regmap_write_bits(priv->gswip, GSWIP_PCE_TBL_CTRL,
 			  GSWIP_PCE_TBL_CTRL_ADDR_MASK |
 			  GSWIP_PCE_TBL_CTRL_OPMOD_MASK |
-			  tbl->table | addr_mode | GSWIP_PCE_TBL_CTRL_BAS,
+			  GSWIP_PCE_TBL_CTRL_BAS,
 			  tbl->table | addr_mode | GSWIP_PCE_TBL_CTRL_BAS);
 
 	err = gswip_switch_r_timeout(priv, GSWIP_PCE_TBL_CTRL,
@@ -342,8 +342,7 @@ static int gswip_pce_table_entry_write(struct gswip_priv *priv,
 	regmap_write(priv->gswip, GSWIP_PCE_TBL_ADDR, tbl->index);
 	regmap_write_bits(priv->gswip, GSWIP_PCE_TBL_CTRL,
 			  GSWIP_PCE_TBL_CTRL_ADDR_MASK |
-			  GSWIP_PCE_TBL_CTRL_OPMOD_MASK |
-			  tbl->table | addr_mode,
+			  GSWIP_PCE_TBL_CTRL_OPMOD_MASK,
 			  tbl->table | addr_mode);
 
 	for (i = 0; i < ARRAY_SIZE(tbl->key); i++)
@@ -354,8 +353,7 @@ static int gswip_pce_table_entry_write(struct gswip_priv *priv,
 
 	regmap_write_bits(priv->gswip, GSWIP_PCE_TBL_CTRL,
 			  GSWIP_PCE_TBL_CTRL_ADDR_MASK |
-			  GSWIP_PCE_TBL_CTRL_OPMOD_MASK |
-			  tbl->table | addr_mode,
+			  GSWIP_PCE_TBL_CTRL_OPMOD_MASK,
 			  tbl->table | addr_mode);
 
 	regmap_write(priv->gswip, GSWIP_PCE_TBL_MASK, tbl->mask);
@@ -444,7 +442,7 @@ static int gswip_port_enable(struct dsa_switch *ds, int port,
 			mdio_phy = phydev->mdio.addr & GSWIP_MDIO_PHY_ADDR_MASK;
 
 		regmap_write_bits(priv->mdio, GSWIP_MDIO_PHYp(port),
-				  GSWIP_MDIO_PHY_ADDR_MASK | mdio_phy,
+				  GSWIP_MDIO_PHY_ADDR_MASK,
 				  mdio_phy);
 	}
 
@@ -547,8 +545,7 @@ static void gswip_port_commit_pvid(struct gswip_priv *priv, int port)
 
 	vinr = idx ? GSWIP_PCE_VCTRL_VINR_ALL : GSWIP_PCE_VCTRL_VINR_TAGGED;
 	regmap_write_bits(priv->gswip, GSWIP_PCE_VCTRL(port),
-			  GSWIP_PCE_VCTRL_VINR |
-			  FIELD_PREP(GSWIP_PCE_VCTRL_VINR, vinr),
+			  GSWIP_PCE_VCTRL_VINR,
 			  FIELD_PREP(GSWIP_PCE_VCTRL_VINR, vinr));
 
 	/* Note that in GSWIP 2.2 VLAN mode the VID needs to be programmed
@@ -647,7 +644,7 @@ static int gswip_setup(struct dsa_switch *ds)
 	regmap_write(priv->mdio, GSWIP_MDIO_MDC_CFG0, 0x0);
 
 	/* Configure the MDIO Clock 2.5 MHz */
-	regmap_write_bits(priv->mdio, GSWIP_MDIO_MDC_CFG1, 0xff | 0x09, 0x09);
+	regmap_write_bits(priv->mdio, GSWIP_MDIO_MDC_CFG1, 0xff, 0x09);
 
 	/* bring up the mdio bus */
 	err = gswip_mdio(priv);
@@ -1089,7 +1086,7 @@ static void gswip_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 	regmap_set_bits(priv->gswip, GSWIP_SDMA_PCTRLp(port),
 			GSWIP_SDMA_PCTRL_EN);
 	regmap_write_bits(priv->gswip, GSWIP_PCE_PCTRL_0p(port),
-			  GSWIP_PCE_PCTRL_0_PSTATE_MASK | stp_state,
+			  GSWIP_PCE_PCTRL_0_PSTATE_MASK,
 			  stp_state);
 }
 
@@ -1320,7 +1317,7 @@ static void gswip_port_set_link(struct gswip_priv *priv, int port, bool link)
 		mdio_phy = GSWIP_MDIO_PHY_LINK_DOWN;
 
 	regmap_write_bits(priv->mdio, GSWIP_MDIO_PHYp(port),
-			  GSWIP_MDIO_PHY_LINK_MASK | mdio_phy, mdio_phy);
+			  GSWIP_MDIO_PHY_LINK_MASK, mdio_phy);
 }
 
 static void gswip_port_set_speed(struct gswip_priv *priv, int port, int speed,
@@ -1361,10 +1358,10 @@ static void gswip_port_set_speed(struct gswip_priv *priv, int port, int speed,
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
@@ -1380,9 +1377,9 @@ static void gswip_port_set_duplex(struct gswip_priv *priv, int port, int duplex)
 	}
 
 	regmap_write_bits(priv->gswip, GSWIP_MAC_CTRL_0p(port),
-			  GSWIP_MAC_CTRL_0_FDUP_MASK | mac_ctrl_0, mac_ctrl_0);
+			  GSWIP_MAC_CTRL_0_FDUP_MASK, mac_ctrl_0);
 	regmap_write_bits(priv->mdio, GSWIP_MDIO_PHYp(port),
-			  GSWIP_MDIO_PHY_FDUP_MASK | mdio_phy, mdio_phy);
+			  GSWIP_MDIO_PHY_FDUP_MASK, mdio_phy);
 }
 
 static void gswip_port_set_pause(struct gswip_priv *priv, int port,
@@ -1409,9 +1406,9 @@ static void gswip_port_set_pause(struct gswip_priv *priv, int port,
 	}
 
 	regmap_write_bits(priv->gswip, GSWIP_MAC_CTRL_0p(port),
-			  GSWIP_MAC_CTRL_0_FCON_MASK | mac_ctrl_0, mac_ctrl_0);
+			  GSWIP_MAC_CTRL_0_FCON_MASK, mac_ctrl_0);
 	regmap_write_bits(priv->mdio, GSWIP_MDIO_PHYp(port),
-			  GSWIP_MDIO_PHY_FCONTX_MASK | GSWIP_MDIO_PHY_FCONRX_MASK | mdio_phy,
+			  GSWIP_MDIO_PHY_FCONTX_MASK | GSWIP_MDIO_PHY_FCONRX_MASK,
 			  mdio_phy);
 }
 
@@ -1533,7 +1530,7 @@ static u32 gswip_bcm_ram_entry_read(struct gswip_priv *priv, u32 table,
 	regmap_write(priv->gswip, GSWIP_BM_RAM_ADDR, index);
 	regmap_write_bits(priv->gswip, GSWIP_BM_RAM_CTRL,
 			  GSWIP_BM_RAM_CTRL_ADDR_MASK | GSWIP_BM_RAM_CTRL_OPMOD |
-			  table | GSWIP_BM_RAM_CTRL_BAS,
+			  GSWIP_BM_RAM_CTRL_BAS,
 			  table | GSWIP_BM_RAM_CTRL_BAS);
 
 	err = gswip_switch_r_timeout(priv, GSWIP_BM_RAM_CTRL,
-- 
2.51.1.dirty

