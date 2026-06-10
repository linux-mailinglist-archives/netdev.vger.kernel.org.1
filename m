Return-Path: <netdev+bounces-297824-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5WE2CkzCKWp8cwMAu9opvQ
	(envelope-from <netdev+bounces-297824-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 22:00:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F95866CA7A
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 22:00:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297824-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297824-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 925023294C8D
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 19:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48C237B402;
	Wed, 10 Jun 2026 19:56:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3470376BC1;
	Wed, 10 Jun 2026 19:55:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121360; cv=none; b=sXvwOle+7kSaRp8y+09wcXKsc5Q5cnWbX2PsYGLWBncUwuSQZkYOfjYd/cJrip/mIFN7wdRYmrS5G48GPcEoCgVJ//tim9f5K8F9qX1RCDHJy1ACyILSQAUr3KyGpU7k0xw3mdSL8H8VR88JxZOxYjm4/BoZKT81qQ9rVbCLTzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121360; c=relaxed/simple;
	bh=M34K+H6PS/+UImUa2StkI8d73zKhJIbgQ8TrLCK22QI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zpk9h2vONGQbxzpmsOB1AnWxmY2VDGOrvo0xUw6ySUU0k3LVf9pv/MxErheYKK0gwluLF/2k/X6hbvTIQSTzMKKq3iJq5Hvg4VrucstS/xb1rauRKd5Ifs6AnTZR3QBn5m4VzGrntTDn8kQJMJI9eb1JqLgmFE8QStMWmuVyJuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wXP1k-000000000FL-1mWO;
	Wed, 10 Jun 2026 19:55:52 +0000
Date: Wed, 10 Jun 2026 20:55:49 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next 3/8] net: dsa: mt7530: replace mt7530_write with
 regmap_write
Message-ID: <6cc536db495f5a2514a6db89d877eab611242074.1781119435.git.daniel@makrotopia.org>
References: <cover.1781119435.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781119435.git.daniel@makrotopia.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297824-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:chester.a.unal@arinc9.com,m:daniel@makrotopia.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[arinc9.com,makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,armlinux.org.uk,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,makrotopia.org:email,makrotopia.org:mid,makrotopia.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6F95866CA7A

Replace all mt7530_write() calls with direct regmap_write() calls
and remove the wrapper function. The per-call error logging is
dropped -- regmap has its own tracing infrastructure.

Generated using the following semantic patch:

@@
expression priv, reg, val;
@@
-mt7530_write(priv, reg, val)
+regmap_write(priv->regmap, reg, val)

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/mt7530.c | 126 ++++++++++++++++++---------------------
 1 file changed, 59 insertions(+), 67 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 9ccc848195cf..ce4efcf1b3e6 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -150,16 +150,6 @@ core_clear(struct mt7530_priv *priv, u32 reg, u32 val)
 	core_rmw(priv, reg, val, 0);
 }
 
-static void
-mt7530_write(struct mt7530_priv *priv, u32 reg, u32 val)
-{
-	int ret;
-
-	ret = regmap_write(priv->regmap, reg, val);
-	if (ret < 0)
-		dev_err(priv->dev,
-			"failed to write mt7530 register\n");
-}
 
 static u32
 mt7530_read(struct mt7530_priv *priv, u32 reg)
@@ -212,7 +202,7 @@ mt7530_fdb_cmd(struct mt7530_priv *priv, enum mt7530_fdb_cmd cmd, u32 *rsp)
 
 	/* Set the command operating upon the MAC address entries */
 	val = ATC_BUSY | ATC_MAT(0) | cmd;
-	mt7530_write(priv, MT7530_ATC, val);
+	regmap_write(priv->regmap, MT7530_ATC, val);
 
 	INIT_MT7530_DUMMY_POLL(&p, priv, MT7530_ATC);
 	ret = readx_poll_timeout(mt7530_mii_poll, &p, val,
@@ -288,7 +278,7 @@ mt7530_fdb_write(struct mt7530_priv *priv, u16 vid,
 
 	/* Write array into the ARL table */
 	for (i = 0; i < 3; i++)
-		mt7530_write(priv, MT7530_ATA1 + (i * 4), reg[i]);
+		regmap_write(priv->regmap, MT7530_ATA1 + (i * 4), reg[i]);
 }
 
 /* Set up switch core clock for MT7530 */
@@ -406,27 +396,27 @@ mt7531_pll_setup(struct mt7530_priv *priv)
 	/* Step 1 : Disable MT7531 COREPLL */
 	val = mt7530_read(priv, MT7531_PLLGP_EN);
 	val &= ~EN_COREPLL;
-	mt7530_write(priv, MT7531_PLLGP_EN, val);
+	regmap_write(priv->regmap, MT7531_PLLGP_EN, val);
 
 	/* Step 2: switch to XTAL output */
 	val = mt7530_read(priv, MT7531_PLLGP_EN);
 	val |= SW_CLKSW;
-	mt7530_write(priv, MT7531_PLLGP_EN, val);
+	regmap_write(priv->regmap, MT7531_PLLGP_EN, val);
 
 	val = mt7530_read(priv, MT7531_PLLGP_CR0);
 	val &= ~RG_COREPLL_EN;
-	mt7530_write(priv, MT7531_PLLGP_CR0, val);
+	regmap_write(priv->regmap, MT7531_PLLGP_CR0, val);
 
 	/* Step 3: disable PLLGP and enable program PLLGP */
 	val = mt7530_read(priv, MT7531_PLLGP_EN);
 	val |= SW_PLLGP;
-	mt7530_write(priv, MT7531_PLLGP_EN, val);
+	regmap_write(priv->regmap, MT7531_PLLGP_EN, val);
 
 	/* Step 4: program COREPLL output frequency to 500MHz */
 	val = mt7530_read(priv, MT7531_PLLGP_CR0);
 	val &= ~RG_COREPLL_POSDIV_M;
 	val |= 2 << RG_COREPLL_POSDIV_S;
-	mt7530_write(priv, MT7531_PLLGP_CR0, val);
+	regmap_write(priv->regmap, MT7531_PLLGP_CR0, val);
 	usleep_range(25, 35);
 
 	switch (xtal) {
@@ -434,42 +424,42 @@ mt7531_pll_setup(struct mt7530_priv *priv)
 		val = mt7530_read(priv, MT7531_PLLGP_CR0);
 		val &= ~RG_COREPLL_SDM_PCW_M;
 		val |= 0x140000 << RG_COREPLL_SDM_PCW_S;
-		mt7530_write(priv, MT7531_PLLGP_CR0, val);
+		regmap_write(priv->regmap, MT7531_PLLGP_CR0, val);
 		break;
 	case MT7531_XTAL_FSEL_40MHZ:
 		val = mt7530_read(priv, MT7531_PLLGP_CR0);
 		val &= ~RG_COREPLL_SDM_PCW_M;
 		val |= 0x190000 << RG_COREPLL_SDM_PCW_S;
-		mt7530_write(priv, MT7531_PLLGP_CR0, val);
+		regmap_write(priv->regmap, MT7531_PLLGP_CR0, val);
 		break;
 	}
 
 	/* Set feedback divide ratio update signal to high */
 	val = mt7530_read(priv, MT7531_PLLGP_CR0);
 	val |= RG_COREPLL_SDM_PCW_CHG;
-	mt7530_write(priv, MT7531_PLLGP_CR0, val);
+	regmap_write(priv->regmap, MT7531_PLLGP_CR0, val);
 	/* Wait for at least 16 XTAL clocks */
 	usleep_range(10, 20);
 
 	/* Step 5: set feedback divide ratio update signal to low */
 	val = mt7530_read(priv, MT7531_PLLGP_CR0);
 	val &= ~RG_COREPLL_SDM_PCW_CHG;
-	mt7530_write(priv, MT7531_PLLGP_CR0, val);
+	regmap_write(priv->regmap, MT7531_PLLGP_CR0, val);
 
 	/* Enable 325M clock for SGMII */
-	mt7530_write(priv, MT7531_ANA_PLLGP_CR5, 0xad0000);
+	regmap_write(priv->regmap, MT7531_ANA_PLLGP_CR5, 0xad0000);
 
 	/* Enable 250SSC clock for RGMII */
-	mt7530_write(priv, MT7531_ANA_PLLGP_CR2, 0x4f40000);
+	regmap_write(priv->regmap, MT7531_ANA_PLLGP_CR2, 0x4f40000);
 
 	/* Step 6: Enable MT7531 PLL */
 	val = mt7530_read(priv, MT7531_PLLGP_CR0);
 	val |= RG_COREPLL_EN;
-	mt7530_write(priv, MT7531_PLLGP_CR0, val);
+	regmap_write(priv->regmap, MT7531_PLLGP_CR0, val);
 
 	val = mt7530_read(priv, MT7531_PLLGP_EN);
 	val |= EN_COREPLL;
-	mt7530_write(priv, MT7531_PLLGP_EN, val);
+	regmap_write(priv->regmap, MT7531_PLLGP_EN, val);
 	usleep_range(25, 35);
 }
 
@@ -478,8 +468,8 @@ mt7530_mib_reset(struct dsa_switch *ds)
 {
 	struct mt7530_priv *priv = ds->priv;
 
-	mt7530_write(priv, MT7530_MIB_CCR, CCR_MIB_FLUSH);
-	mt7530_write(priv, MT7530_MIB_CCR, CCR_MIB_ACTIVATE);
+	regmap_write(priv->regmap, MT7530_MIB_CCR, CCR_MIB_FLUSH);
+	regmap_write(priv->regmap, MT7530_MIB_CCR, CCR_MIB_ACTIVATE);
 }
 
 static int mt7530_phy_read_c22(struct mt7530_priv *priv, int port, int regnum)
@@ -526,7 +516,7 @@ mt7531_ind_c45_phy_read(struct mt7530_priv *priv, int port, int devad,
 
 	reg = MT7531_MDIO_CL45_ADDR | MT7531_MDIO_PHY_ADDR(port) |
 	      MT7531_MDIO_DEV_ADDR(devad) | regnum;
-	mt7530_write(priv, MT7531_PHY_IAC, reg | MT7531_PHY_ACS_ST);
+	regmap_write(priv->regmap, MT7531_PHY_IAC, reg | MT7531_PHY_ACS_ST);
 
 	ret = readx_poll_timeout(mt7530_mii_poll, &p, val,
 				 !(val & MT7531_PHY_ACS_ST), 20, 100000);
@@ -537,7 +527,7 @@ mt7531_ind_c45_phy_read(struct mt7530_priv *priv, int port, int devad,
 
 	reg = MT7531_MDIO_CL45_READ | MT7531_MDIO_PHY_ADDR(port) |
 	      MT7531_MDIO_DEV_ADDR(devad);
-	mt7530_write(priv, MT7531_PHY_IAC, reg | MT7531_PHY_ACS_ST);
+	regmap_write(priv->regmap, MT7531_PHY_IAC, reg | MT7531_PHY_ACS_ST);
 
 	ret = readx_poll_timeout(mt7530_mii_poll, &p, val,
 				 !(val & MT7531_PHY_ACS_ST), 20, 100000);
@@ -574,7 +564,7 @@ mt7531_ind_c45_phy_write(struct mt7530_priv *priv, int port, int devad,
 
 	reg = MT7531_MDIO_CL45_ADDR | MT7531_MDIO_PHY_ADDR(port) |
 	      MT7531_MDIO_DEV_ADDR(devad) | regnum;
-	mt7530_write(priv, MT7531_PHY_IAC, reg | MT7531_PHY_ACS_ST);
+	regmap_write(priv->regmap, MT7531_PHY_IAC, reg | MT7531_PHY_ACS_ST);
 
 	ret = readx_poll_timeout(mt7530_mii_poll, &p, val,
 				 !(val & MT7531_PHY_ACS_ST), 20, 100000);
@@ -585,7 +575,7 @@ mt7531_ind_c45_phy_write(struct mt7530_priv *priv, int port, int devad,
 
 	reg = MT7531_MDIO_CL45_WRITE | MT7531_MDIO_PHY_ADDR(port) |
 	      MT7531_MDIO_DEV_ADDR(devad) | data;
-	mt7530_write(priv, MT7531_PHY_IAC, reg | MT7531_PHY_ACS_ST);
+	regmap_write(priv->regmap, MT7531_PHY_IAC, reg | MT7531_PHY_ACS_ST);
 
 	ret = readx_poll_timeout(mt7530_mii_poll, &p, val,
 				 !(val & MT7531_PHY_ACS_ST), 20, 100000);
@@ -621,7 +611,7 @@ mt7531_ind_c22_phy_read(struct mt7530_priv *priv, int port, int regnum)
 	val = MT7531_MDIO_CL22_READ | MT7531_MDIO_PHY_ADDR(port) |
 	      MT7531_MDIO_REG_ADDR(regnum);
 
-	mt7530_write(priv, MT7531_PHY_IAC, val | MT7531_PHY_ACS_ST);
+	regmap_write(priv->regmap, MT7531_PHY_IAC, val | MT7531_PHY_ACS_ST);
 
 	ret = readx_poll_timeout(mt7530_mii_poll, &p, val,
 				 !(val & MT7531_PHY_ACS_ST), 20, 100000);
@@ -659,7 +649,7 @@ mt7531_ind_c22_phy_write(struct mt7530_priv *priv, int port, int regnum,
 	reg = MT7531_MDIO_CL22_WRITE | MT7531_MDIO_PHY_ADDR(port) |
 	      MT7531_MDIO_REG_ADDR(regnum) | data;
 
-	mt7530_write(priv, MT7531_PHY_IAC, reg | MT7531_PHY_ACS_ST);
+	regmap_write(priv->regmap, MT7531_PHY_IAC, reg | MT7531_PHY_ACS_ST);
 
 	ret = readx_poll_timeout(mt7530_mii_poll, &p, reg,
 				 !(reg & MT7531_PHY_ACS_ST), 20, 100000);
@@ -1012,7 +1002,8 @@ mt7530_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
 		}
 	}
 
-	mt7530_write(priv, MT7530_AAC, AGE_CNT(age_count) | AGE_UNIT(age_unit));
+	regmap_write(priv->regmap, MT7530_AAC,
+		     AGE_CNT(age_count) | AGE_UNIT(age_unit));
 
 	return 0;
 }
@@ -1050,7 +1041,7 @@ static void mt7530_setup_port5(struct dsa_switch *ds, phy_interface_t interface)
 	/* MUX_PHY_P4: P4 -> P5 -> SoC MAC */
 	case MUX_PHY_P4:
 		/* Setup the MAC by default for the cpu port */
-		mt7530_write(priv, MT753X_PMCR_P(5), 0x56300);
+		regmap_write(priv->regmap, MT753X_PMCR_P(5), 0x56300);
 		break;
 
 	/* GMAC5: P5 -> SoC MAC or external PHY */
@@ -1064,7 +1055,8 @@ static void mt7530_setup_port5(struct dsa_switch *ds, phy_interface_t interface)
 		val |= MT7530_P5_RGMII_MODE;
 
 		/* P5 RGMII RX Clock Control: delay setting for 1000M */
-		mt7530_write(priv, MT7530_P5RGMIIRXCR, CSR_RGMII_EDGE_ALIGN);
+		regmap_write(priv->regmap, MT7530_P5RGMIIRXCR,
+			     CSR_RGMII_EDGE_ALIGN);
 
 		/* Don't set delay in DSA mode */
 		if (!dsa_is_dsa_port(priv->ds, 5) &&
@@ -1073,15 +1065,15 @@ static void mt7530_setup_port5(struct dsa_switch *ds, phy_interface_t interface)
 			tx_delay = 4; /* n * 0.5 ns */
 
 		/* P5 RGMII TX Clock Control: delay x */
-		mt7530_write(priv, MT7530_P5RGMIITXCR,
+		regmap_write(priv->regmap, MT7530_P5RGMIITXCR,
 			     CSR_RGMII_TXC_CFG(0x10 + tx_delay));
 
 		/* reduce P5 RGMII Tx driving, 8mA */
-		mt7530_write(priv, MT7530_IO_DRV_CR,
+		regmap_write(priv->regmap, MT7530_IO_DRV_CR,
 			     P5_IO_CLK_DRV(1) | P5_IO_DATA_DRV(1));
 	}
 
-	mt7530_write(priv, MT753X_MTRAP, val);
+	regmap_write(priv->regmap, MT753X_MTRAP, val);
 
 	dev_dbg(ds->dev, "Setup P5, HWTRAP=0x%x, mode=%s, phy-mode=%s\n", val,
 		mt7530_p5_mode_str(priv->p5_mode), phy_modes(interface));
@@ -1303,8 +1295,7 @@ mt753x_cpu_port_enable(struct dsa_switch *ds, int port)
 	struct mt7530_priv *priv = ds->priv;
 
 	/* Enable Mediatek header mode on the cpu port */
-	mt7530_write(priv, MT7530_PVC_P(port),
-		     PORT_SPEC_TAG);
+	regmap_write(priv->regmap, MT7530_PVC_P(port), PORT_SPEC_TAG);
 
 	/* Enable flooding on the CPU port */
 	mt7530_set(priv, MT753X_MFC, BC_FFP(BIT(port)) | UNM_FFP(BIT(port)) |
@@ -1321,7 +1312,7 @@ mt753x_cpu_port_enable(struct dsa_switch *ds, int port)
 	/* CPU port gets connected to all user ports of
 	 * the switch.
 	 */
-	mt7530_write(priv, MT7530_PCR_P(port),
+	regmap_write(priv->regmap, MT7530_PCR_P(port),
 		     PCR_MATRIX(dsa_user_ports(priv->ds)));
 
 	/* Set to fallback mode for independent VLAN learning */
@@ -1421,7 +1412,7 @@ mt7530_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 		val |= MAX_RX_PKT_LEN_JUMBO;
 	}
 
-	mt7530_write(priv, MT7530_GMACCR, val);
+	regmap_write(priv->regmap, MT7530_GMACCR, val);
 
 	return 0;
 }
@@ -1587,7 +1578,7 @@ mt7530_vlan_cmd(struct mt7530_priv *priv, enum mt7530_vlan_cmd cmd, u16 vid)
 	int ret;
 
 	val = VTCR_BUSY | VTCR_FUNC(cmd) | vid;
-	mt7530_write(priv, MT7530_VTCR, val);
+	regmap_write(priv->regmap, MT7530_VTCR, val);
 
 	INIT_MT7530_DUMMY_POLL(&p, priv, MT7530_VTCR);
 	ret = readx_poll_timeout(mt7530_mii_poll, &p, val,
@@ -1616,8 +1607,8 @@ mt7530_setup_vlan0(struct mt7530_priv *priv)
 	 */
 	val = IVL_MAC | EG_CON | PORT_MEM(MT7530_ALL_MEMBERS) | FID(FID_BRIDGED) |
 	      VLAN_VALID;
-	mt7530_write(priv, MT7530_VAWD1, val);
-	mt7530_write(priv, MT7530_VAWD2, 0);
+	regmap_write(priv->regmap, MT7530_VAWD1, val);
+	regmap_write(priv->regmap, MT7530_VAWD2, 0);
 
 	return mt7530_vlan_cmd(priv, MT7530_VTCR_WR_VID, 0);
 }
@@ -1887,7 +1878,7 @@ mt7530_hw_vlan_add(struct mt7530_priv *priv,
 	 */
 	val = IVL_MAC | VTAG_EN | PORT_MEM(new_members) | FID(FID_BRIDGED) |
 	      VLAN_VALID;
-	mt7530_write(priv, MT7530_VAWD1, val);
+	regmap_write(priv->regmap, MT7530_VAWD1, val);
 
 	/* Decide whether adding tag or not for those outgoing packets from the
 	 * port inside the VLAN.
@@ -1926,10 +1917,10 @@ mt7530_hw_vlan_del(struct mt7530_priv *priv,
 	if (new_members) {
 		val = IVL_MAC | VTAG_EN | PORT_MEM(new_members) |
 		      VLAN_VALID;
-		mt7530_write(priv, MT7530_VAWD1, val);
+		regmap_write(priv->regmap, MT7530_VAWD1, val);
 	} else {
-		mt7530_write(priv, MT7530_VAWD1, 0);
-		mt7530_write(priv, MT7530_VAWD2, 0);
+		regmap_write(priv->regmap, MT7530_VAWD1, 0);
+		regmap_write(priv->regmap, MT7530_VAWD2, 0);
 	}
 }
 
@@ -2070,7 +2061,7 @@ static int mt753x_port_mirror_add(struct dsa_switch *ds, int port,
 	val |= MT753X_MIRROR_EN(priv->id);
 	val &= ~MT753X_MIRROR_PORT_MASK(priv->id);
 	val |= MT753X_MIRROR_PORT_SET(priv->id, mirror->to_local_port);
-	mt7530_write(priv, MT753X_MIRROR_REG(priv->id), val);
+	regmap_write(priv->regmap, MT753X_MIRROR_REG(priv->id), val);
 
 	val = mt7530_read(priv, MT7530_PCR_P(port));
 	if (ingress) {
@@ -2080,7 +2071,7 @@ static int mt753x_port_mirror_add(struct dsa_switch *ds, int port,
 		val |= PORT_TX_MIR;
 		priv->mirror_tx |= BIT(port);
 	}
-	mt7530_write(priv, MT7530_PCR_P(port), val);
+	regmap_write(priv->regmap, MT7530_PCR_P(port), val);
 
 	return 0;
 }
@@ -2099,12 +2090,12 @@ static void mt753x_port_mirror_del(struct dsa_switch *ds, int port,
 		val &= ~PORT_TX_MIR;
 		priv->mirror_tx &= ~BIT(port);
 	}
-	mt7530_write(priv, MT7530_PCR_P(port), val);
+	regmap_write(priv->regmap, MT7530_PCR_P(port), val);
 
 	if (!priv->mirror_rx && !priv->mirror_tx) {
 		val = mt7530_read(priv, MT753X_MIRROR_REG(priv->id));
 		val &= ~MT753X_MIRROR_EN(priv->id);
-		mt7530_write(priv, MT753X_MIRROR_REG(priv->id), val);
+		regmap_write(priv->regmap, MT753X_MIRROR_REG(priv->id), val);
 	}
 }
 
@@ -2202,9 +2193,9 @@ mt7530_setup_gpio(struct mt7530_priv *priv)
 	if (!gc)
 		return -ENOMEM;
 
-	mt7530_write(priv, MT7530_LED_GPIO_OE, 0);
-	mt7530_write(priv, MT7530_LED_GPIO_DIR, 0);
-	mt7530_write(priv, MT7530_LED_IO_MODE, 0);
+	regmap_write(priv->regmap, MT7530_LED_GPIO_OE, 0);
+	regmap_write(priv->regmap, MT7530_LED_GPIO_DIR, 0);
+	regmap_write(priv->regmap, MT7530_LED_IO_MODE, 0);
 
 	gc->label = "mt7530";
 	gc->parent = dev;
@@ -2462,13 +2453,12 @@ mt7530_setup(struct dsa_switch *ds)
 	}
 
 	/* Reset the switch through internal reset */
-	mt7530_write(priv, MT7530_SYS_CTRL,
-		     SYS_CTRL_PHY_RST | SYS_CTRL_SW_RST |
-		     SYS_CTRL_REG_RST);
+	regmap_write(priv->regmap, MT7530_SYS_CTRL,
+		     SYS_CTRL_PHY_RST | SYS_CTRL_SW_RST | SYS_CTRL_REG_RST);
 
 	/* Lower Tx driving for TRGMII path */
 	for (i = 0; i < NUM_TRGMII_CTRL; i++)
-		mt7530_write(priv, MT7530_TRGMII_TD_ODT(i),
+		regmap_write(priv->regmap, MT7530_TRGMII_TD_ODT(i),
 			     TD_DM_DRVP(8) | TD_DM_DRVN(8));
 
 	for (i = 0; i < NUM_TRGMII_CTRL; i++)
@@ -2647,7 +2637,7 @@ mt7531_setup_common(struct dsa_switch *ds)
 
 	/* Enable Special Tag for rx frames */
 	if (priv->id == ID_EN7581 || priv->id == ID_AN7583)
-		mt7530_write(priv, MT753X_CPORT_SPTAG_CFG,
+		regmap_write(priv->regmap, MT753X_CPORT_SPTAG_CFG,
 			     CPORT_SW2FE_STAG_EN | CPORT_FE2SW_STAG_EN);
 
 	/* Flush the FDB table */
@@ -2705,10 +2695,12 @@ mt7531_setup(struct dsa_switch *ds)
 
 	/* Force link down on all ports before internal reset */
 	for (i = 0; i < priv->ds->num_ports; i++)
-		mt7530_write(priv, MT753X_PMCR_P(i), MT7531_FORCE_MODE_LNK);
+		regmap_write(priv->regmap, MT753X_PMCR_P(i),
+			     MT7531_FORCE_MODE_LNK);
 
 	/* Reset the switch through internal reset */
-	mt7530_write(priv, MT7530_SYS_CTRL, SYS_CTRL_SW_RST | SYS_CTRL_REG_RST);
+	regmap_write(priv->regmap, MT7530_SYS_CTRL,
+		     SYS_CTRL_SW_RST | SYS_CTRL_REG_RST);
 
 	if (!priv->p5_sgmii) {
 		mt7531_pll_setup(priv);
@@ -2917,7 +2909,7 @@ static void mt7531_rgmii_setup(struct mt7530_priv *priv,
 		}
 	}
 
-	mt7530_write(priv, MT7531_CLKGEN_CTRL, val);
+	regmap_write(priv->regmap, MT7531_CLKGEN_CTRL, val);
 }
 
 static void
@@ -3254,7 +3246,7 @@ static int mt753x_tc_setup_qdisc_tbf(struct dsa_switch *ds, int port,
 		      FIELD_PREP(ERLCR_EXP_MASK, tick) |
 		      ERLCR_TBF_MODE_MASK |
 		      FIELD_PREP(ERLCR_MANT_MASK, 0xf);
-		mt7530_write(priv, MT753X_ERLCR_P(port), val);
+		regmap_write(priv->regmap, MT753X_ERLCR_P(port), val);
 		break;
 	}
 	default:
@@ -3296,7 +3288,7 @@ static int mt7988_setup(struct dsa_switch *ds)
 			   FIELD_PREP(AN7583_CSR_ETHER_AFE_PWD, 0));
 
 	/* Reset the switch PHYs */
-	mt7530_write(priv, MT7530_SYS_CTRL, SYS_CTRL_PHY_RST);
+	regmap_write(priv->regmap, MT7530_SYS_CTRL, SYS_CTRL_PHY_RST);
 
 	return mt7531_setup_common(ds);
 }
-- 
2.54.0

