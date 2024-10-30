Return-Path: <netdev+bounces-140310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C97379B5E44
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 09:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80FC31F244FC
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 08:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111B41E1C1C;
	Wed, 30 Oct 2024 08:52:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C101D6194
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 08:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730278367; cv=none; b=o1juQ/QVsBzdXCk9ksc5xNsNHVtAVqr8MaijQOYM3H1fOldR8PdV5tIQa8q6x5st3gfDSmYUXWs2K9BIKAu9gicjN5wv2BPSyNOEZwOKaRxAlh/jIrtDSngCCw8jj3bX06Bi4PDbLEl8N9qa2L7T2KaMVc2g0hbaTmMFzDsuYmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730278367; c=relaxed/simple;
	bh=v7/nbc54GkOXJi2BxdMmj3tHMVBcVs/Y/X/RgkcMj0o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T7PGdW6+5tEkPyq8BEoPR2kS2WRxAhbRGNqAg0NyhT51ef9uPEiUd9p3ZQLG0MuqrxNR1sO67BtKBogATrv5tyuNh2T9pg4BHlsA2fqP401AtRSZa+dyzhwo9Kx/z68SgnfiRA20qktm18/ETTFNSV6BmEqamNNkXh4b8nIkAj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1t64RH-0001yk-6A; Wed, 30 Oct 2024 09:52:27 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t64RF-001APC-1t;
	Wed, 30 Oct 2024 09:52:25 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t64RF-00B2p4-1g;
	Wed, 30 Oct 2024 09:52:25 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	havasi@efr.de
Subject: [PATCH net-next v1] net: macb: avoid redundant lookup for "mdio" child node in MDIO setup
Date: Wed, 30 Oct 2024 09:52:24 +0100
Message-Id: <20241030085224.2632426-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Pass the "mdio" child node directly to `macb_mdiobus_register` to avoid
performing the node lookup twice.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/ethernet/cadence/macb_main.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index ebe886b988917..daa416fb1724e 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -915,20 +915,15 @@ static int macb_mii_probe(struct net_device *dev)
 	return 0;
 }

-static int macb_mdiobus_register(struct macb *bp)
+static int macb_mdiobus_register(struct macb *bp, struct device_node *mdio_np)
 {
 	struct device_node *child, *np = bp->pdev->dev.of_node;

 	/* If we have a child named mdio, probe it instead of looking for PHYs
 	 * directly under the MAC node
 	 */
-	child = of_get_child_by_name(np, "mdio");
-	if (child) {
-		int ret = of_mdiobus_register(bp->mii_bus, child);
-
-		of_node_put(child);
-		return ret;
-	}
+	if (mdio_np)
+		return of_mdiobus_register(bp->mii_bus, mdio_np);

 	/* Only create the PHY from the device tree if at least one PHY is
 	 * described. Otherwise scan the entire MDIO bus. We do this to support
@@ -950,17 +945,15 @@ static int macb_mdiobus_register(struct macb *bp)

 static int macb_mii_init(struct macb *bp)
 {
-	struct device_node *child, *np = bp->pdev->dev.of_node;
+	struct device_node *mdio_np, *np = bp->pdev->dev.of_node;
 	int err = -ENXIO;

 	/* With fixed-link, we don't need to register the MDIO bus,
 	 * except if we have a child named "mdio" in the device tree.
 	 * In that case, some devices may be attached to the MACB's MDIO bus.
 	 */
-	child = of_get_child_by_name(np, "mdio");
-	if (child)
-		of_node_put(child);
-	else if (of_phy_is_fixed_link(np))
+	mdio_np = of_get_child_by_name(np, "mdio");
+	if (!mdio_np && of_phy_is_fixed_link(np))
 		return macb_mii_probe(bp->dev);

 	/* Enable management port */
@@ -984,7 +977,7 @@ static int macb_mii_init(struct macb *bp)

 	dev_set_drvdata(&bp->dev->dev, bp->mii_bus);

-	err = macb_mdiobus_register(bp);
+	err = macb_mdiobus_register(bp, mdio_np);
 	if (err)
 		goto err_out_free_mdiobus;

@@ -999,6 +992,8 @@ static int macb_mii_init(struct macb *bp)
 err_out_free_mdiobus:
 	mdiobus_free(bp->mii_bus);
 err_out:
+	of_node_put(mdio_np);
+
 	return err;
 }

--
2.39.5


