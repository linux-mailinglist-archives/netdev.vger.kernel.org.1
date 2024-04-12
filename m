Return-Path: <netdev+bounces-87447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0775A8A322F
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 17:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA1F1C22F6C
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 15:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606B214A0AA;
	Fri, 12 Apr 2024 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gSqFdq3q"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29C114A09C
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 15:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934949; cv=none; b=VpXH1w/UL7baO5uxZewgHoGIwOlqhtCZl6fqtHvXAfHmYwUjvCMPtB/e6Gl/IEYiOgPfuCTM1Z7yqJu8xJcEb7FAOOMObgXzXS3zFnVm78s2VlyGMfTGWDINCH1DUxFNeFDuZ+ckn7wogky19UF+/KWQzSRRfgIyUFkE06k06rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934949; c=relaxed/simple;
	bh=OhP2jYcyy2q4McUL/JJi8yf0xMPsSHxIutTypmSxUOI=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=R+fBiJji6hTEOcAzc6td0xrD/xy14jiZM3ZpSMI58RcDE4v8uN0YUIUMVbmqW51PDTYRb7PPPWimMFkigantt2l8yUqCbK2Oag4l50+91e1ykd+9qmSyin7Udq61BxZVcm4fOdFr6DKnklXeO5FM4i4oZlJLrmk5qULa1Tr8V1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=gSqFdq3q; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iLBmZbfe4DoF7UWAPFfgMKaAmUU8Vkt6g5EtBivGTbU=; b=gSqFdq3qlGYhWPudR5FCA0hXpR
	tUw3vAY1FhzQXMOSNGNBaVliGDcAiMQNnlkb5vVanz+Al6/qZBs+eOXuJD/FhdaZ/zNQWr4hEOuCU
	QSMTy0MOzXs9uGB/KNKv1SvdsZLQNtf5+msENR08AyNTDG9Pu9vvax7BXh5kgFIORhIowr3BxAG+U
	2UTUSA1CF9/1aKZNYFq+bobV7JKXGXUrfVpxDH8B9Du52ZgCz7E69loo9CtMicougQpCDl3Cy+Is/
	eDFOttpv0ScAhG0lnLnoz5G3dksZfC0UMVdZl6Y3l0aEyPNIv24sHPHux59wp/TqJjYFbKmEg9O7D
	k4CvuX/g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:53978 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rvIcn-0002d4-32;
	Fri, 12 Apr 2024 16:15:34 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rvIco-006bQu-Fq; Fri, 12 Apr 2024 16:15:34 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	 Vladimir Oltean <olteanv@gmail.com>
Cc: "Ar__n__ __NAL" <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next] net: dsa: mt7530: provide own phylink MAC operations
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rvIco-006bQu-Fq@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 12 Apr 2024 16:15:34 +0100

Convert mt753x to provide its own phylink MAC operations, thus avoiding
the shim layer in DSA's port.c

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mt7530.c | 46 +++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index c0d0bce0b594..84eec7de9b03 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2850,28 +2850,34 @@ mt7531_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
 }
 
 static struct phylink_pcs *
-mt753x_phylink_mac_select_pcs(struct dsa_switch *ds, int port,
+mt753x_phylink_mac_select_pcs(struct phylink_config *config,
 			      phy_interface_t interface)
 {
-	struct mt7530_priv *priv = ds->priv;
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct mt7530_priv *priv = dp->ds->priv;
 
 	switch (interface) {
 	case PHY_INTERFACE_MODE_TRGMII:
-		return &priv->pcs[port].pcs;
+		return &priv->pcs[dp->index].pcs;
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_1000BASEX:
 	case PHY_INTERFACE_MODE_2500BASEX:
-		return priv->ports[port].sgmii_pcs;
+		return priv->ports[dp->index].sgmii_pcs;
 	default:
 		return NULL;
 	}
 }
 
 static void
-mt753x_phylink_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
+mt753x_phylink_mac_config(struct phylink_config *config, unsigned int mode,
 			  const struct phylink_link_state *state)
 {
-	struct mt7530_priv *priv = ds->priv;
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct dsa_switch *ds = dp->ds;
+	struct mt7530_priv *priv;
+	int port = dp->index;
+
+	priv = ds->priv;
 
 	if ((port == 5 || port == 6) && priv->info->mac_port_config)
 		priv->info->mac_port_config(ds, port, mode, state->interface);
@@ -2881,23 +2887,25 @@ mt753x_phylink_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
 		mt7530_set(priv, MT7530_PMCR_P(port), PMCR_EXT_PHY);
 }
 
-static void mt753x_phylink_mac_link_down(struct dsa_switch *ds, int port,
+static void mt753x_phylink_mac_link_down(struct phylink_config *config,
 					 unsigned int mode,
 					 phy_interface_t interface)
 {
-	struct mt7530_priv *priv = ds->priv;
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct mt7530_priv *priv = dp->ds->priv;
 
-	mt7530_clear(priv, MT7530_PMCR_P(port), PMCR_LINK_SETTINGS_MASK);
+	mt7530_clear(priv, MT7530_PMCR_P(dp->index), PMCR_LINK_SETTINGS_MASK);
 }
 
-static void mt753x_phylink_mac_link_up(struct dsa_switch *ds, int port,
+static void mt753x_phylink_mac_link_up(struct phylink_config *config,
+				       struct phy_device *phydev,
 				       unsigned int mode,
 				       phy_interface_t interface,
-				       struct phy_device *phydev,
 				       int speed, int duplex,
 				       bool tx_pause, bool rx_pause)
 {
-	struct mt7530_priv *priv = ds->priv;
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct mt7530_priv *priv = dp->ds->priv;
 	u32 mcr;
 
 	mcr = PMCR_RX_EN | PMCR_TX_EN | PMCR_FORCE_LNK;
@@ -2932,7 +2940,7 @@ static void mt753x_phylink_mac_link_up(struct dsa_switch *ds, int port,
 		}
 	}
 
-	mt7530_set(priv, MT7530_PMCR_P(port), mcr);
+	mt7530_set(priv, MT7530_PMCR_P(dp->index), mcr);
 }
 
 static void mt753x_phylink_get_caps(struct dsa_switch *ds, int port,
@@ -3152,16 +3160,19 @@ const struct dsa_switch_ops mt7530_switch_ops = {
 	.port_mirror_add	= mt753x_port_mirror_add,
 	.port_mirror_del	= mt753x_port_mirror_del,
 	.phylink_get_caps	= mt753x_phylink_get_caps,
-	.phylink_mac_select_pcs	= mt753x_phylink_mac_select_pcs,
-	.phylink_mac_config	= mt753x_phylink_mac_config,
-	.phylink_mac_link_down	= mt753x_phylink_mac_link_down,
-	.phylink_mac_link_up	= mt753x_phylink_mac_link_up,
 	.get_mac_eee		= mt753x_get_mac_eee,
 	.set_mac_eee		= mt753x_set_mac_eee,
 	.conduit_state_change	= mt753x_conduit_state_change,
 };
 EXPORT_SYMBOL_GPL(mt7530_switch_ops);
 
+static const struct phylink_mac_ops mt753x_phylink_mac_ops = {
+	.mac_select_pcs	= mt753x_phylink_mac_select_pcs,
+	.mac_config	= mt753x_phylink_mac_config,
+	.mac_link_down	= mt753x_phylink_mac_link_down,
+	.mac_link_up	= mt753x_phylink_mac_link_up,
+};
+
 const struct mt753x_info mt753x_table[] = {
 	[ID_MT7621] = {
 		.id = ID_MT7621,
@@ -3239,6 +3250,7 @@ mt7530_probe_common(struct mt7530_priv *priv)
 	priv->dev = dev;
 	priv->ds->priv = priv;
 	priv->ds->ops = &mt7530_switch_ops;
+	priv->ds->phylink_mac_ops = &mt753x_phylink_mac_ops;
 	mutex_init(&priv->reg_mutex);
 	dev_set_drvdata(dev, priv);
 
-- 
2.30.2


