Return-Path: <netdev+bounces-148471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DD89E1C8E
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 13:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D2E284DDF
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 12:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BD71F4717;
	Tue,  3 Dec 2024 12:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NWEUoUA5"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0111F130D;
	Tue,  3 Dec 2024 12:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733229819; cv=none; b=fs/LeYJPlgthD77k9X53AAkpj6bdA5cGeg49Sf1vTPbaXm0TMBw/EPAKZYDV/pH1CjvPCiMWHWAy4vsD26z5WKbJ3+d6v92HkEGpegNvwGoYLc6uqbiRnxi5kzxNYapVeLJ+Q1GC2iUZ+wRAAbsfwOwWSkH5aUhGaxvbUDKjV5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733229819; c=relaxed/simple;
	bh=UcbVoZHAlJYm+CdnABP2AfaMA7c5zjeZ8lX7ghuxZv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vz92U+GA6b5UruuggaQ1r/XysFBhjPEcnHm4Lq5iOkQKHxGXC1oh/E4OUVpzhmMHDdh3Ly7F3J7biXeSvM6qCCC6GqjOXMW1DlJnnbRuVapAR3KAmk/FAnftwBkpqYM1r641etHQvRkVCBDPVxeRcEB0Rp8C4eXqFVIHDeeH6t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NWEUoUA5; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 27420E0014;
	Tue,  3 Dec 2024 12:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733229815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WBCqYYv3YXd5ENSbBD2+uchIXFYD+CKhJvuWxfPM7Xk=;
	b=NWEUoUA5RouWcr1xNFFyfJa84MrnUceEEs7jv6Dz3Mc72h3Vf0I2h4+H/uMA94Uqv7RtdS
	eUq8zTe/FZfiA0ZPe35qpSKqW7WH2G/LCFR9dazxkxdB+UiwtV/9nZmmPoN8Gs52fnBRhF
	KZFT2Q68jau98Q0k0Je3LF1MhiXV12e3s25Rn/arQtsffRLZqi4s5q0mYGMx6D83IriZ4S
	68Vb3x+cxsUfXg+fDz8TpFJU6qvKFamyDz40mqo93h3p14geaz6Yo6LaA6EOUcbD1dPaJR
	vY7VSsqUZDM67/hSP2oqSzHxvrqs50ZHbS+lGSoMaMhDGkHC68syLhyASj9teA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Simon Horman <horms@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH net-next v3 08/10] net: freescale: ucc_geth: Move the serdes configuration around
Date: Tue,  3 Dec 2024 13:43:19 +0100
Message-ID: <20241203124323.155866-9-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241203124323.155866-1-maxime.chevallier@bootlin.com>
References: <20241203124323.155866-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

The uec_configure_serdes() function deals with serialized linkmodes
settings. It's used during the link bringup sequence. It is planned to
be used during the phylink conversion for mac configuration, but it
needs to me moved around in the process. To make the phylink port
clearer, this commit moves the function without any feature change.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V3: No changes

 drivers/net/ethernet/freescale/ucc_geth.c | 93 +++++++++++------------
 1 file changed, 46 insertions(+), 47 deletions(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index 81aefe291d80..f6dd36dc03fe 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -1512,6 +1512,52 @@ static void ugeth_activate(struct ucc_geth_private *ugeth)
 	__netdev_watchdog_up(ugeth->ndev);
 }
 
+/* Initialize TBI PHY interface for communicating with the
+ * SERDES lynx PHY on the chip.  We communicate with this PHY
+ * through the MDIO bus on each controller, treating it as a
+ * "normal" PHY at the address found in the UTBIPA register.  We assume
+ * that the UTBIPA register is valid.  Either the MDIO bus code will set
+ * it to a value that doesn't conflict with other PHYs on the bus, or the
+ * value doesn't matter, as there are no other PHYs on the bus.
+ */
+static void uec_configure_serdes(struct net_device *dev)
+{
+	struct ucc_geth_private *ugeth = netdev_priv(dev);
+	struct ucc_geth_info *ug_info = ugeth->ug_info;
+	struct phy_device *tbiphy;
+
+	if (!ug_info->tbi_node) {
+		dev_warn(&dev->dev, "SGMII mode requires that the device tree specify a tbi-handle\n");
+		return;
+	}
+
+	tbiphy = of_phy_find_device(ug_info->tbi_node);
+	if (!tbiphy) {
+		dev_err(&dev->dev, "error: Could not get TBI device\n");
+		return;
+	}
+
+	/*
+	 * If the link is already up, we must already be ok, and don't need to
+	 * configure and reset the TBI<->SerDes link.  Maybe U-Boot configured
+	 * everything for us?  Resetting it takes the link down and requires
+	 * several seconds for it to come back.
+	 */
+	if (phy_read(tbiphy, ENET_TBI_MII_SR) & TBISR_LSTATUS) {
+		put_device(&tbiphy->mdio.dev);
+		return;
+	}
+
+	/* Single clk mode, mii mode off(for serdes communication) */
+	phy_write(tbiphy, ENET_TBI_MII_ANA, TBIANA_SETTINGS);
+
+	phy_write(tbiphy, ENET_TBI_MII_TBICON, TBICON_CLK_SELECT);
+
+	phy_write(tbiphy, ENET_TBI_MII_CR, TBICR_SETTINGS);
+
+	put_device(&tbiphy->mdio.dev);
+}
+
 static void ugeth_link_up(struct ucc_geth_private *ugeth,
 			  struct phy_device *phy,
 			  phy_interface_t interface, int speed, int duplex)
@@ -1619,53 +1665,6 @@ static void adjust_link(struct net_device *dev)
 		ugeth_link_down(ugeth);
 }
 
-/* Initialize TBI PHY interface for communicating with the
- * SERDES lynx PHY on the chip.  We communicate with this PHY
- * through the MDIO bus on each controller, treating it as a
- * "normal" PHY at the address found in the UTBIPA register.  We assume
- * that the UTBIPA register is valid.  Either the MDIO bus code will set
- * it to a value that doesn't conflict with other PHYs on the bus, or the
- * value doesn't matter, as there are no other PHYs on the bus.
- */
-static void uec_configure_serdes(struct net_device *dev)
-{
-	struct ucc_geth_private *ugeth = netdev_priv(dev);
-	struct ucc_geth_info *ug_info = ugeth->ug_info;
-	struct phy_device *tbiphy;
-
-	if (!ug_info->tbi_node) {
-		dev_warn(&dev->dev, "SGMII mode requires that the device "
-			"tree specify a tbi-handle\n");
-		return;
-	}
-
-	tbiphy = of_phy_find_device(ug_info->tbi_node);
-	if (!tbiphy) {
-		dev_err(&dev->dev, "error: Could not get TBI device\n");
-		return;
-	}
-
-	/*
-	 * If the link is already up, we must already be ok, and don't need to
-	 * configure and reset the TBI<->SerDes link.  Maybe U-Boot configured
-	 * everything for us?  Resetting it takes the link down and requires
-	 * several seconds for it to come back.
-	 */
-	if (phy_read(tbiphy, ENET_TBI_MII_SR) & TBISR_LSTATUS) {
-		put_device(&tbiphy->mdio.dev);
-		return;
-	}
-
-	/* Single clk mode, mii mode off(for serdes communication) */
-	phy_write(tbiphy, ENET_TBI_MII_ANA, TBIANA_SETTINGS);
-
-	phy_write(tbiphy, ENET_TBI_MII_TBICON, TBICON_CLK_SELECT);
-
-	phy_write(tbiphy, ENET_TBI_MII_CR, TBICR_SETTINGS);
-
-	put_device(&tbiphy->mdio.dev);
-}
-
 /* Configure the PHY for dev.
  * returns 0 if success.  -1 if failure
  */
-- 
2.47.0


