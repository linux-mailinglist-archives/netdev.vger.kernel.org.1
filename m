Return-Path: <netdev+bounces-144963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E32FC9C8E83
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 16:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68FE71F28340
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 15:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A274D1A7275;
	Thu, 14 Nov 2024 15:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DFiaN64+"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7542E1A01B9;
	Thu, 14 Nov 2024 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598576; cv=none; b=IpN5YGG6hdN4kG92PdXtC1oI/0q7k69vMHaz3AEZFX6DrLvOQNgTuwMiK1UgJtFvH0YEfHMwBWxKIUzhoKRYRKuMt5TY55lUmLoTUOb8yfrKHub6hWvCkDBIsiCpn8KQY4ZMhrKXJaOO1+0vRXXO7sunAGWWIRJM1OEmnVgoa9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598576; c=relaxed/simple;
	bh=0UsaPE2Uh4SyaFc9Rflbhw3/kdxyOR6CEBmi99Vhh+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jWsR1z2kCzei3djAYtYxhLafzjpnW/9K8H58TB9zGfzqJ7OD/5rwMucQkudggDL4m0M+5GD1sgvOUZzaYH004LSTdQbDqD3BuR8CjmVKaTFDJ7aTAO9p5Nbb9Au9xaFR7UYspWw5yeZ6Y4fAgmtJN4v7klvhateMz7n1e6l+zW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DFiaN64+; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0D20A1BF207;
	Thu, 14 Nov 2024 15:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731598572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1dMKBG+AoRYWHAnDg3HglYfHqu6OSVERdBxJpGegsQM=;
	b=DFiaN64+rcortkHZ2MvYoDftQM3Z+rhQ8tXu9CzURnWE/b3pfpD2t5c3leJLl1dOAldhZa
	Wqz+Qf5jy7+3xL5uovFLZaQIO2TM8Lfzyp1gSIOFuVm5f0cldTiemjn6EZLmU9T4+4dedB
	3zbTxI+1KC3XRmGDPVlsSmgshTV/wZbIDmhIoeCIqOm0oGImmekvyfUR0+XF7t7gzQOKYe
	KHqOerpDE7jk/GvgWcYGkHb5AeYWGWslOGgBx6KxmPEDdX8AvZ57GrdJoa1nGU9EW8DQBF
	abzIHFolSmHqMbh06T3Z1dQPpQJHWjBzGNGqXEtd8Tzc6mNYxFlDlhm09DLvOQ==
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
	Herve Codina <herve.codina@bootlin.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH net-next v2 08/10] net: freescale: ucc_geth: Move the serdes configuration around
Date: Thu, 14 Nov 2024 16:35:59 +0100
Message-ID: <20241114153603.307872-9-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114153603.307872-1-maxime.chevallier@bootlin.com>
References: <20241114153603.307872-1-maxime.chevallier@bootlin.com>
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
V2: New patch

 drivers/net/ethernet/freescale/ucc_geth.c | 93 +++++++++++------------
 1 file changed, 46 insertions(+), 47 deletions(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index 57e8f0718dc7..15d05b270b6e 100644
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


