Return-Path: <netdev+bounces-122124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 768CE95FF97
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 05:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8AEE1C22076
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 03:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFD317C79;
	Tue, 27 Aug 2024 03:05:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB57517543;
	Tue, 27 Aug 2024 03:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724727918; cv=none; b=WBZ0eTXZS30hVY5W3251wPKXE6qCy8WByhoqN0TJnP6QaQSUDghRNZj1RhaPPNWr2a1ANYD88UKVwVZXNmWEef6gQcaf6LyCcwXcbcvWl0DyWWkgmm8g0FbEcXp23XdJRxtk7+qgCW70aq0jyncSJm920dNcFOm6CTkjoJy0LHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724727918; c=relaxed/simple;
	bh=TaLGGeK1zzfzdVeKlIjAMTEwsD0xRl6mZk/vMHriXWg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rFYEGyMWN8zXjo6Iyk8TFDn7MsuW2dIrGD7P58ATLMH0lBdFTeOjKVUu2WJHk/NspvrZ+PX5YI7Xdmp1XJa8q3hJiN4wOcpS0t4ULqI2OJhR+wCwp9mATzR7PkuureHHtqyR09ko0M9EPwAA+OPP6ei2TEUJL0NgRBi0TZEGXOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 27 Aug
 2024 11:05:13 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 27 Aug 2024 11:05:13 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <jacky_chou@aspeedtech.com>,
	<u.kleine-koenig@pengutronix.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3] net: ftgmac100: Get link speed and duplex for NC-SI
Date: Tue, 27 Aug 2024 11:05:13 +0800
Message-ID: <20240827030513.481469-1-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The ethtool of this driver uses the phy API of ethtool
to get the link information from PHY driver.
Because the NC-SI is forced on 100Mbps and full duplex,
the driver connect a fixed-link phy driver for NC-SI.
The ethtool will get the link information from the
fixed-link phy driver.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
v3:
  - Add fixed-link phy device unregister in
    ftgmac100_phy_disconnect().
  - Adjust header and variable sorting.
v2:
  - use static for struct fixed_phy_status ncsi_phy_status
  - Stop phy device at net_device stop when using NC-SI.
  - Start phy device at net_device start when using NC-SI.
---
 drivers/net/ethernet/faraday/ftgmac100.c | 28 ++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index fddfd1dd5070..444671b8bbe2 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -24,6 +24,7 @@
 #include <linux/crc32.h>
 #include <linux/if_vlan.h>
 #include <linux/of_net.h>
+#include <linux/phy_fixed.h>
 #include <net/ip.h>
 #include <net/ncsi.h>
 
@@ -50,6 +51,15 @@
 #define FTGMAC_100MHZ		100000000
 #define FTGMAC_25MHZ		25000000
 
+/* For NC-SI to register a fixed-link phy device */
+static struct fixed_phy_status ncsi_phy_status = {
+	.link = 1,
+	.speed = SPEED_100,
+	.duplex = DUPLEX_FULL,
+	.pause = 0,
+	.asym_pause = 0
+};
+
 struct ftgmac100 {
 	/* Registers */
 	struct resource *res;
@@ -1531,7 +1541,8 @@ static int ftgmac100_open(struct net_device *netdev)
 	if (netdev->phydev) {
 		/* If we have a PHY, start polling */
 		phy_start(netdev->phydev);
-	} else if (priv->use_ncsi) {
+	}
+	if (priv->use_ncsi) {
 		/* If using NC-SI, set our carrier on and start the stack */
 		netif_carrier_on(netdev);
 
@@ -1544,6 +1555,7 @@ static int ftgmac100_open(struct net_device *netdev)
 	return 0;
 
  err_ncsi:
+	phy_stop(netdev->phydev);
 	napi_disable(&priv->napi);
 	netif_stop_queue(netdev);
  err_alloc:
@@ -1577,7 +1589,7 @@ static int ftgmac100_stop(struct net_device *netdev)
 	netif_napi_del(&priv->napi);
 	if (netdev->phydev)
 		phy_stop(netdev->phydev);
-	else if (priv->use_ncsi)
+	if (priv->use_ncsi)
 		ncsi_stop_dev(priv->ndev);
 
 	ftgmac100_stop_hw(priv);
@@ -1715,6 +1727,9 @@ static void ftgmac100_phy_disconnect(struct net_device *netdev)
 	phy_disconnect(netdev->phydev);
 	if (of_phy_is_fixed_link(priv->dev->of_node))
 		of_phy_deregister_fixed_link(priv->dev->of_node);
+
+	if (priv->use_ncsi)
+		fixed_phy_unregister(netdev->phydev);
 }
 
 static void ftgmac100_destroy_mdio(struct net_device *netdev)
@@ -1792,6 +1807,7 @@ static int ftgmac100_probe(struct platform_device *pdev)
 	struct resource *res;
 	int irq;
 	struct net_device *netdev;
+	struct phy_device *phydev;
 	struct ftgmac100 *priv;
 	struct device_node *np;
 	int err = 0;
@@ -1879,6 +1895,14 @@ static int ftgmac100_probe(struct platform_device *pdev)
 			err = -EINVAL;
 			goto err_phy_connect;
 		}
+
+		phydev = fixed_phy_register(PHY_POLL, &ncsi_phy_status, NULL);
+		err = phy_connect_direct(netdev, phydev, ftgmac100_adjust_link,
+					 PHY_INTERFACE_MODE_MII);
+		if (err) {
+			dev_err(&pdev->dev, "Connecting PHY failed\n");
+			goto err_phy_connect;
+		}
 	} else if (np && of_phy_is_fixed_link(np)) {
 		struct phy_device *phy;
 
-- 
2.25.1


