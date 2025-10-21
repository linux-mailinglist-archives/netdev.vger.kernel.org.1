Return-Path: <netdev+bounces-231173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C9ABF5FA7
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 13:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2ACF0351668
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 11:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02897239E70;
	Tue, 21 Oct 2025 11:17:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934E82AE68;
	Tue, 21 Oct 2025 11:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761045420; cv=none; b=L+1eMo+IkVOmtdQAMHwQDoPOeEv24MzXBOSc9rR3daMapRcEEXrf+Kpw1PGc0lGy14Tc595Rox+P304ymwiuFaacWqRlyO8ASZrBWMoTN6g3o3Oora76eKW9EzcuRAayMkir3KYvUPs7PFIeBQ/05aA1M3P4QIvx7QYAMKxfrfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761045420; c=relaxed/simple;
	bh=P65JI1dSg3ttWFrLpISsk43jVx/h/tFafAhEh/WMPNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBongNXxtP8GZPElJ+QK2MNa4NUjYWkWi5QgF6jgzvNup/tVJ6+5BcYrjPRHeJ1pDCtnFK4cO1F1qJzPbZg1VPAYH0QIcKiS3qLh0DHKaTdmap/bRcl6RkRSdWza2le3LNo2Mg2/uenGfjUW/cnLooNW7bBuA3P07jvxwcxuHBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vBAMI-0000000018T-0N24;
	Tue, 21 Oct 2025 11:16:54 +0000
Date: Tue, 21 Oct 2025 12:16:50 +0100
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
Subject: [PATCH net-next v5 3/7] net: dsa: lantiq_gswip: convert trivial
 accessor uses to regmap
Message-ID: <48a60f386b1bd487c410b1f5fb25ba50ceddc6f7.1761045000.git.daniel@makrotopia.org>
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

Use coccinelle semantic patch to convert all trivial uses of the register
accessor functions to use the regmap API directly.

// Replace gswip_switch_w with regmap_write
@@
expression priv, val, offset;
@@
- gswip_switch_w(priv, val, offset)
+ regmap_write(priv->gswip, offset, val)

// Replace gswip_mdio_w with regmap_write
@@
expression priv, val, offset;
@@
- gswip_mdio_w(priv, val, offset)
+ regmap_write(priv->mdio, offset, val)

// Replace gswip_switch_r in simple assignment - only for u32
@@
expression priv, offset;
u32 var;
@@
- var = gswip_switch_r(priv, offset)
+ regmap_read(priv->gswip, offset, &var)

// Replace gswip_switch_mask with regmap_set_bits when clear is 0
@@
expression priv, set, offset;
@@
- gswip_switch_mask(priv, 0, set, offset)
+ regmap_set_bits(priv->gswip, offset, set)

// Replace gswip_mdio_mask with regmap_set_bits when clear is 0
@@
expression priv, set, offset;
@@
- gswip_mdio_mask(priv, 0, set, offset)
+ regmap_set_bits(priv->mdio, offset, set)

// Replace gswip_switch_mask with regmap_clear_bits when set is 0
@@
expression priv, clear, offset;
@@
- gswip_switch_mask(priv, clear, 0, offset)
+ regmap_clear_bits(priv->gswip, offset, clear)

// Replace gswip_mdio_mask with regmap_clear_bits when set is 0
@@
expression priv, clear, offset;
@@
- gswip_mdio_mask(priv, clear, 0, offset)
+ regmap_clear_bits(priv->mdio, offset, clear)

Remove gswip_switch_w() and gswip_mdio_w() functions as they now no
longer have any users.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq/lantiq_gswip.c | 160 ++++++++++++--------------
 1 file changed, 76 insertions(+), 84 deletions(-)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
index 8a448e1f5eef..e58320eaf9da 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
@@ -120,11 +120,6 @@ static u32 gswip_switch_r(struct gswip_priv *priv, u32 offset)
 	return val;
 }
 
-static void gswip_switch_w(struct gswip_priv *priv, u32 val, u32 offset)
-{
-	regmap_write(priv->gswip, offset, val);
-}
-
 static void gswip_switch_mask(struct gswip_priv *priv, u32 clear, u32 set,
 			      u32 offset)
 {
@@ -149,11 +144,6 @@ static u32 gswip_mdio_r(struct gswip_priv *priv, u32 offset)
 	return val;
 }
 
-static void gswip_mdio_w(struct gswip_priv *priv, u32 val, u32 offset)
-{
-	regmap_write(priv->mdio, offset, val);
-}
-
 static void gswip_mdio_mask(struct gswip_priv *priv, u32 clear, u32 set,
 			    u32 offset)
 {
@@ -223,11 +213,11 @@ static int gswip_mdio_wr(struct mii_bus *bus, int addr, int reg, u16 val)
 		return err;
 	}
 
-	gswip_mdio_w(priv, val, GSWIP_MDIO_WRITE);
-	gswip_mdio_w(priv, GSWIP_MDIO_CTRL_BUSY | GSWIP_MDIO_CTRL_WR |
-		((addr & GSWIP_MDIO_CTRL_PHYAD_MASK) << GSWIP_MDIO_CTRL_PHYAD_SHIFT) |
-		(reg & GSWIP_MDIO_CTRL_REGAD_MASK),
-		GSWIP_MDIO_CTRL);
+	regmap_write(priv->mdio, GSWIP_MDIO_WRITE, val);
+	regmap_write(priv->mdio, GSWIP_MDIO_CTRL,
+		     GSWIP_MDIO_CTRL_BUSY | GSWIP_MDIO_CTRL_WR |
+		     ((addr & GSWIP_MDIO_CTRL_PHYAD_MASK) << GSWIP_MDIO_CTRL_PHYAD_SHIFT) |
+		     (reg & GSWIP_MDIO_CTRL_REGAD_MASK));
 
 	return 0;
 }
@@ -243,10 +233,10 @@ static int gswip_mdio_rd(struct mii_bus *bus, int addr, int reg)
 		return err;
 	}
 
-	gswip_mdio_w(priv, GSWIP_MDIO_CTRL_BUSY | GSWIP_MDIO_CTRL_RD |
-		((addr & GSWIP_MDIO_CTRL_PHYAD_MASK) << GSWIP_MDIO_CTRL_PHYAD_SHIFT) |
-		(reg & GSWIP_MDIO_CTRL_REGAD_MASK),
-		GSWIP_MDIO_CTRL);
+	regmap_write(priv->mdio, GSWIP_MDIO_CTRL,
+		     GSWIP_MDIO_CTRL_BUSY | GSWIP_MDIO_CTRL_RD |
+		     ((addr & GSWIP_MDIO_CTRL_PHYAD_MASK) << GSWIP_MDIO_CTRL_PHYAD_SHIFT) |
+		     (reg & GSWIP_MDIO_CTRL_REGAD_MASK));
 
 	err = gswip_mdio_poll(priv);
 	if (err) {
@@ -310,7 +300,7 @@ static int gswip_pce_table_entry_read(struct gswip_priv *priv,
 		return err;
 	}
 
-	gswip_switch_w(priv, tbl->index, GSWIP_PCE_TBL_ADDR);
+	regmap_write(priv->gswip, GSWIP_PCE_TBL_ADDR, tbl->index);
 	gswip_switch_mask(priv, GSWIP_PCE_TBL_CTRL_ADDR_MASK |
 				GSWIP_PCE_TBL_CTRL_OPMOD_MASK,
 			  tbl->table | addr_mode | GSWIP_PCE_TBL_CTRL_BAS,
@@ -360,24 +350,24 @@ static int gswip_pce_table_entry_write(struct gswip_priv *priv,
 		return err;
 	}
 
-	gswip_switch_w(priv, tbl->index, GSWIP_PCE_TBL_ADDR);
+	regmap_write(priv->gswip, GSWIP_PCE_TBL_ADDR, tbl->index);
 	gswip_switch_mask(priv, GSWIP_PCE_TBL_CTRL_ADDR_MASK |
 				GSWIP_PCE_TBL_CTRL_OPMOD_MASK,
 			  tbl->table | addr_mode,
 			  GSWIP_PCE_TBL_CTRL);
 
 	for (i = 0; i < ARRAY_SIZE(tbl->key); i++)
-		gswip_switch_w(priv, tbl->key[i], GSWIP_PCE_TBL_KEY(i));
+		regmap_write(priv->gswip, GSWIP_PCE_TBL_KEY(i), tbl->key[i]);
 
 	for (i = 0; i < ARRAY_SIZE(tbl->val); i++)
-		gswip_switch_w(priv, tbl->val[i], GSWIP_PCE_TBL_VAL(i));
+		regmap_write(priv->gswip, GSWIP_PCE_TBL_VAL(i), tbl->val[i]);
 
 	gswip_switch_mask(priv, GSWIP_PCE_TBL_CTRL_ADDR_MASK |
 				GSWIP_PCE_TBL_CTRL_OPMOD_MASK,
 			  tbl->table | addr_mode,
 			  GSWIP_PCE_TBL_CTRL);
 
-	gswip_switch_w(priv, tbl->mask, GSWIP_PCE_TBL_MASK);
+	regmap_write(priv->gswip, GSWIP_PCE_TBL_MASK, tbl->mask);
 
 	crtl = gswip_switch_r(priv, GSWIP_PCE_TBL_CTRL);
 	crtl &= ~(GSWIP_PCE_TBL_CTRL_TYPE | GSWIP_PCE_TBL_CTRL_VLD |
@@ -388,7 +378,7 @@ static int gswip_pce_table_entry_write(struct gswip_priv *priv,
 		crtl |= GSWIP_PCE_TBL_CTRL_VLD;
 	crtl |= (tbl->gmap << 7) & GSWIP_PCE_TBL_CTRL_GMAP_MASK;
 	crtl |= GSWIP_PCE_TBL_CTRL_BAS;
-	gswip_switch_w(priv, crtl, GSWIP_PCE_TBL_CTRL);
+	regmap_write(priv->gswip, GSWIP_PCE_TBL_CTRL, crtl);
 
 	err = gswip_switch_r_timeout(priv, GSWIP_PCE_TBL_CTRL,
 				     GSWIP_PCE_TBL_CTRL_BAS);
@@ -467,14 +457,13 @@ static int gswip_port_enable(struct dsa_switch *ds, int port,
 	}
 
 	/* RMON Counter Enable for port */
-	gswip_switch_w(priv, GSWIP_BM_PCFG_CNTEN, GSWIP_BM_PCFGp(port));
+	regmap_write(priv->gswip, GSWIP_BM_PCFGp(port), GSWIP_BM_PCFG_CNTEN);
 
 	/* enable port fetch/store dma & VLAN Modification */
-	gswip_switch_mask(priv, 0, GSWIP_FDMA_PCTRL_EN |
-				   GSWIP_FDMA_PCTRL_VLANMOD_BOTH,
-			 GSWIP_FDMA_PCTRLp(port));
-	gswip_switch_mask(priv, 0, GSWIP_SDMA_PCTRL_EN,
-			  GSWIP_SDMA_PCTRLp(port));
+	regmap_set_bits(priv->gswip, GSWIP_FDMA_PCTRLp(port),
+			GSWIP_FDMA_PCTRL_EN | GSWIP_FDMA_PCTRL_VLANMOD_BOTH);
+	regmap_set_bits(priv->gswip, GSWIP_SDMA_PCTRLp(port),
+			GSWIP_SDMA_PCTRL_EN);
 
 	return 0;
 }
@@ -483,10 +472,10 @@ static void gswip_port_disable(struct dsa_switch *ds, int port)
 {
 	struct gswip_priv *priv = ds->priv;
 
-	gswip_switch_mask(priv, GSWIP_FDMA_PCTRL_EN, 0,
-			  GSWIP_FDMA_PCTRLp(port));
-	gswip_switch_mask(priv, GSWIP_SDMA_PCTRL_EN, 0,
-			  GSWIP_SDMA_PCTRLp(port));
+	regmap_clear_bits(priv->gswip, GSWIP_FDMA_PCTRLp(port),
+			  GSWIP_FDMA_PCTRL_EN);
+	regmap_clear_bits(priv->gswip, GSWIP_SDMA_PCTRLp(port),
+			  GSWIP_SDMA_PCTRL_EN);
 }
 
 static int gswip_pce_load_microcode(struct gswip_priv *priv)
@@ -497,22 +486,22 @@ static int gswip_pce_load_microcode(struct gswip_priv *priv)
 	gswip_switch_mask(priv, GSWIP_PCE_TBL_CTRL_ADDR_MASK |
 				GSWIP_PCE_TBL_CTRL_OPMOD_MASK,
 			  GSWIP_PCE_TBL_CTRL_OPMOD_ADWR, GSWIP_PCE_TBL_CTRL);
-	gswip_switch_w(priv, 0, GSWIP_PCE_TBL_MASK);
+	regmap_write(priv->gswip, GSWIP_PCE_TBL_MASK, 0);
 
 	for (i = 0; i < priv->hw_info->pce_microcode_size; i++) {
-		gswip_switch_w(priv, i, GSWIP_PCE_TBL_ADDR);
-		gswip_switch_w(priv, (*priv->hw_info->pce_microcode)[i].val_0,
-			       GSWIP_PCE_TBL_VAL(0));
-		gswip_switch_w(priv, (*priv->hw_info->pce_microcode)[i].val_1,
-			       GSWIP_PCE_TBL_VAL(1));
-		gswip_switch_w(priv, (*priv->hw_info->pce_microcode)[i].val_2,
-			       GSWIP_PCE_TBL_VAL(2));
-		gswip_switch_w(priv, (*priv->hw_info->pce_microcode)[i].val_3,
-			       GSWIP_PCE_TBL_VAL(3));
+		regmap_write(priv->gswip, GSWIP_PCE_TBL_ADDR, i);
+		regmap_write(priv->gswip, GSWIP_PCE_TBL_VAL(0),
+			     (*priv->hw_info->pce_microcode)[i].val_0);
+		regmap_write(priv->gswip, GSWIP_PCE_TBL_VAL(1),
+			     (*priv->hw_info->pce_microcode)[i].val_1);
+		regmap_write(priv->gswip, GSWIP_PCE_TBL_VAL(2),
+			     (*priv->hw_info->pce_microcode)[i].val_2);
+		regmap_write(priv->gswip, GSWIP_PCE_TBL_VAL(3),
+			     (*priv->hw_info->pce_microcode)[i].val_3);
 
 		/* start the table access: */
-		gswip_switch_mask(priv, 0, GSWIP_PCE_TBL_CTRL_BAS,
-				  GSWIP_PCE_TBL_CTRL);
+		regmap_set_bits(priv->gswip, GSWIP_PCE_TBL_CTRL,
+				GSWIP_PCE_TBL_CTRL_BAS);
 		err = gswip_switch_r_timeout(priv, GSWIP_PCE_TBL_CTRL,
 					     GSWIP_PCE_TBL_CTRL_BAS);
 		if (err)
@@ -520,8 +509,8 @@ static int gswip_pce_load_microcode(struct gswip_priv *priv)
 	}
 
 	/* tell the switch that the microcode is loaded */
-	gswip_switch_mask(priv, 0, GSWIP_PCE_GCTRL_0_MC_VALID,
-			  GSWIP_PCE_GCTRL_0);
+	regmap_set_bits(priv->gswip, GSWIP_PCE_GCTRL_0,
+			GSWIP_PCE_GCTRL_0_MC_VALID);
 
 	return 0;
 }
@@ -572,7 +561,7 @@ static void gswip_port_commit_pvid(struct gswip_priv *priv, int port)
 	 * However, without the VLANMD bit (9) in PCE_GCTRL_1 (0x457) even
 	 * GSWIP 2.2 and newer hardware maintain the GSWIP 2.1 behavior.
 	 */
-	gswip_switch_w(priv, idx, GSWIP_PCE_DEFPVID(port));
+	regmap_write(priv->gswip, GSWIP_PCE_DEFPVID(port), idx);
 }
 
 static int gswip_port_vlan_filtering(struct dsa_switch *ds, int port,
@@ -588,8 +577,8 @@ static int gswip_port_vlan_filtering(struct dsa_switch *ds, int port,
 				  GSWIP_PCE_VCTRL_UVR | GSWIP_PCE_VCTRL_VIMR |
 				  GSWIP_PCE_VCTRL_VEMR | GSWIP_PCE_VCTRL_VID0,
 				  GSWIP_PCE_VCTRL(port));
-		gswip_switch_mask(priv, GSWIP_PCE_PCTRL_0_TVM, 0,
-				  GSWIP_PCE_PCTRL_0p(port));
+		regmap_clear_bits(priv->gswip, GSWIP_PCE_PCTRL_0p(port),
+				  GSWIP_PCE_PCTRL_0_TVM);
 	} else {
 		/* Use port based VLAN */
 		gswip_switch_mask(priv,
@@ -597,8 +586,8 @@ static int gswip_port_vlan_filtering(struct dsa_switch *ds, int port,
 				  GSWIP_PCE_VCTRL_VEMR | GSWIP_PCE_VCTRL_VID0,
 				  GSWIP_PCE_VCTRL_VSR,
 				  GSWIP_PCE_VCTRL(port));
-		gswip_switch_mask(priv, 0, GSWIP_PCE_PCTRL_0_TVM,
-				  GSWIP_PCE_PCTRL_0p(port));
+		regmap_set_bits(priv->gswip, GSWIP_PCE_PCTRL_0p(port),
+				GSWIP_PCE_PCTRL_0_TVM);
 	}
 
 	gswip_port_commit_pvid(priv, port);
@@ -613,9 +602,9 @@ static int gswip_setup(struct dsa_switch *ds)
 	struct dsa_port *cpu_dp;
 	int err, i;
 
-	gswip_switch_w(priv, GSWIP_SWRES_R0, GSWIP_SWRES);
+	regmap_write(priv->gswip, GSWIP_SWRES, GSWIP_SWRES_R0);
 	usleep_range(5000, 10000);
-	gswip_switch_w(priv, 0, GSWIP_SWRES);
+	regmap_write(priv->gswip, GSWIP_SWRES, 0);
 
 	/* disable port fetch/store dma on all ports */
 	for (i = 0; i < priv->hw_info->max_ports; i++) {
@@ -624,7 +613,7 @@ static int gswip_setup(struct dsa_switch *ds)
 	}
 
 	/* enable Switch */
-	gswip_mdio_mask(priv, 0, GSWIP_MDIO_GLOB_ENABLE, GSWIP_MDIO_GLOB);
+	regmap_set_bits(priv->mdio, GSWIP_MDIO_GLOB, GSWIP_MDIO_GLOB_ENABLE);
 
 	err = gswip_pce_load_microcode(priv);
 	if (err) {
@@ -633,9 +622,9 @@ static int gswip_setup(struct dsa_switch *ds)
 	}
 
 	/* Default unknown Broadcast/Multicast/Unicast port maps */
-	gswip_switch_w(priv, cpu_ports, GSWIP_PCE_PMAP1);
-	gswip_switch_w(priv, cpu_ports, GSWIP_PCE_PMAP2);
-	gswip_switch_w(priv, cpu_ports, GSWIP_PCE_PMAP3);
+	regmap_write(priv->gswip, GSWIP_PCE_PMAP1, cpu_ports);
+	regmap_write(priv->gswip, GSWIP_PCE_PMAP2, cpu_ports);
+	regmap_write(priv->gswip, GSWIP_PCE_PMAP3, cpu_ports);
 
 	/* Deactivate MDIO PHY auto polling. Some PHYs as the AR8030 have an
 	 * interoperability problem with this auto polling mechanism because
@@ -653,7 +642,7 @@ static int gswip_setup(struct dsa_switch *ds)
 	 * Testing shows that when PHY auto polling is disabled these problems
 	 * go away.
 	 */
-	gswip_mdio_w(priv, 0x0, GSWIP_MDIO_MDC_CFG0);
+	regmap_write(priv->mdio, GSWIP_MDIO_MDC_CFG0, 0x0);
 
 	/* Configure the MDIO Clock 2.5 MHz */
 	gswip_mdio_mask(priv, 0xff, 0x09, GSWIP_MDIO_MDC_CFG1);
@@ -673,22 +662,25 @@ static int gswip_setup(struct dsa_switch *ds)
 
 	dsa_switch_for_each_cpu_port(cpu_dp, ds) {
 		/* enable special tag insertion on cpu port */
-		gswip_switch_mask(priv, 0, GSWIP_FDMA_PCTRL_STEN,
-				  GSWIP_FDMA_PCTRLp(cpu_dp->index));
+		regmap_set_bits(priv->gswip, GSWIP_FDMA_PCTRLp(cpu_dp->index),
+				GSWIP_FDMA_PCTRL_STEN);
 
 		/* accept special tag in ingress direction */
-		gswip_switch_mask(priv, 0, GSWIP_PCE_PCTRL_0_INGRESS,
-				  GSWIP_PCE_PCTRL_0p(cpu_dp->index));
+		regmap_set_bits(priv->gswip,
+				GSWIP_PCE_PCTRL_0p(cpu_dp->index),
+				GSWIP_PCE_PCTRL_0_INGRESS);
 	}
 
-	gswip_switch_mask(priv, 0, GSWIP_BM_QUEUE_GCTRL_GL_MOD,
-			  GSWIP_BM_QUEUE_GCTRL);
+	regmap_set_bits(priv->gswip, GSWIP_BM_QUEUE_GCTRL,
+			GSWIP_BM_QUEUE_GCTRL_GL_MOD);
 
 	/* VLAN aware Switching */
-	gswip_switch_mask(priv, 0, GSWIP_PCE_GCTRL_0_VLAN, GSWIP_PCE_GCTRL_0);
+	regmap_set_bits(priv->gswip, GSWIP_PCE_GCTRL_0,
+			GSWIP_PCE_GCTRL_0_VLAN);
 
 	/* Flush MAC Table */
-	gswip_switch_mask(priv, 0, GSWIP_PCE_GCTRL_0_MTFL, GSWIP_PCE_GCTRL_0);
+	regmap_set_bits(priv->gswip, GSWIP_PCE_GCTRL_0,
+			GSWIP_PCE_GCTRL_0_MTFL);
 
 	err = gswip_switch_r_timeout(priv, GSWIP_PCE_GCTRL_0,
 				     GSWIP_PCE_GCTRL_0_MTFL);
@@ -1074,8 +1066,8 @@ static void gswip_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 
 	switch (state) {
 	case BR_STATE_DISABLED:
-		gswip_switch_mask(priv, GSWIP_SDMA_PCTRL_EN, 0,
-				  GSWIP_SDMA_PCTRLp(port));
+		regmap_clear_bits(priv->gswip, GSWIP_SDMA_PCTRLp(port),
+				  GSWIP_SDMA_PCTRL_EN);
 		return;
 	case BR_STATE_BLOCKING:
 	case BR_STATE_LISTENING:
@@ -1092,8 +1084,8 @@ static void gswip_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 		return;
 	}
 
-	gswip_switch_mask(priv, 0, GSWIP_SDMA_PCTRL_EN,
-			  GSWIP_SDMA_PCTRLp(port));
+	regmap_set_bits(priv->gswip, GSWIP_SDMA_PCTRLp(port),
+			GSWIP_SDMA_PCTRL_EN);
 	gswip_switch_mask(priv, GSWIP_PCE_PCTRL_0_PSTATE_MASK, stp_state,
 			  GSWIP_PCE_PCTRL_0p(port));
 }
@@ -1222,19 +1214,19 @@ static int gswip_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 	 */
 	if (dsa_is_cpu_port(ds, port)) {
 		new_mtu += 8;
-		gswip_switch_w(priv, VLAN_ETH_HLEN + new_mtu + ETH_FCS_LEN,
-			       GSWIP_MAC_FLEN);
+		regmap_write(priv->gswip, GSWIP_MAC_FLEN,
+			     VLAN_ETH_HLEN + new_mtu + ETH_FCS_LEN);
 	}
 
 	/* Enable MLEN for ports with non-standard MTUs, including the special
 	 * header on the CPU port added above.
 	 */
 	if (new_mtu != ETH_DATA_LEN)
-		gswip_switch_mask(priv, 0, GSWIP_MAC_CTRL_2_MLEN,
-				  GSWIP_MAC_CTRL_2p(port));
+		regmap_set_bits(priv->gswip, GSWIP_MAC_CTRL_2p(port),
+				GSWIP_MAC_CTRL_2_MLEN);
 	else
-		gswip_switch_mask(priv, GSWIP_MAC_CTRL_2_MLEN, 0,
-				  GSWIP_MAC_CTRL_2p(port));
+		regmap_clear_bits(priv->gswip, GSWIP_MAC_CTRL_2p(port),
+				  GSWIP_MAC_CTRL_2_MLEN);
 
 	return 0;
 }
@@ -1536,7 +1528,7 @@ static u32 gswip_bcm_ram_entry_read(struct gswip_priv *priv, u32 table,
 	u32 result;
 	int err;
 
-	gswip_switch_w(priv, index, GSWIP_BM_RAM_ADDR);
+	regmap_write(priv->gswip, GSWIP_BM_RAM_ADDR, index);
 	gswip_switch_mask(priv, GSWIP_BM_RAM_CTRL_ADDR_MASK |
 				GSWIP_BM_RAM_CTRL_OPMOD,
 			      table | GSWIP_BM_RAM_CTRL_BAS,
@@ -1550,7 +1542,7 @@ static u32 gswip_bcm_ram_entry_read(struct gswip_priv *priv, u32 table,
 		return 0;
 	}
 
-	result = gswip_switch_r(priv, GSWIP_BM_RAM_VAL(0));
+	regmap_read(priv->gswip, GSWIP_BM_RAM_VAL(0), &result);
 	result |= gswip_switch_r(priv, GSWIP_BM_RAM_VAL(1)) << 16;
 
 	return result;
@@ -1952,7 +1944,7 @@ static int gswip_probe(struct platform_device *pdev)
 	priv->ds->phylink_mac_ops = &gswip_phylink_mac_ops;
 	priv->dev = dev;
 	mutex_init(&priv->pce_table_lock);
-	version = gswip_switch_r(priv, GSWIP_VERSION);
+	regmap_read(priv->gswip, GSWIP_VERSION, &version);
 
 	/* The hardware has the 'major/minor' version bytes in the wrong order
 	 * preventing numerical comparisons. Construct a 16-bit unsigned integer
@@ -2009,7 +2001,7 @@ static int gswip_probe(struct platform_device *pdev)
 	return 0;
 
 disable_switch:
-	gswip_mdio_mask(priv, GSWIP_MDIO_GLOB_ENABLE, 0, GSWIP_MDIO_GLOB);
+	regmap_clear_bits(priv->mdio, GSWIP_MDIO_GLOB, GSWIP_MDIO_GLOB_ENABLE);
 	dsa_unregister_switch(priv->ds);
 gphy_fw_remove:
 	for (i = 0; i < priv->num_gphy_fw; i++)
@@ -2026,7 +2018,7 @@ static void gswip_remove(struct platform_device *pdev)
 		return;
 
 	/* disable the switch */
-	gswip_mdio_mask(priv, GSWIP_MDIO_GLOB_ENABLE, 0, GSWIP_MDIO_GLOB);
+	regmap_clear_bits(priv->mdio, GSWIP_MDIO_GLOB, GSWIP_MDIO_GLOB_ENABLE);
 
 	dsa_unregister_switch(priv->ds);
 
-- 
2.51.1

