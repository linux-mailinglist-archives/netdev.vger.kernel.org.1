Return-Path: <netdev+bounces-115256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DF2945A01
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 10:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A1F2B237C3
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 08:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCE41C3787;
	Fri,  2 Aug 2024 08:33:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176A01C378A;
	Fri,  2 Aug 2024 08:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722587625; cv=none; b=svlKIanPbgBkmXPGsdrzRkCoEgtzJDgutl37YAt3USWKGOUbe8ZGSRCNSSD7mrja/dWhH3UaNSdvtWvEuxAMvN+W9viYz8awV12xvRAqQYtNOMQ8AvdsY9Q/QIIOlpDcpJMxSStn5au5htB1FVHuwVYbWJmLKbCDZtqzk+ExlnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722587625; c=relaxed/simple;
	bh=xhJCUY1IAZpwb5N/801Lqr7qkyKYMhiKioef15/Bbqo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sz3JQmnUQWg1QnF25KQU5SCaTPZwkEDnPT5b9OBWN9qgUJrHxKTEf2RbGnSr3IHIbNh8OoK2E6OyfE64EBe+zBp+kF/ulhKLJYA6Sfha/xEl5NBXmo7iLWwhxK+g0iK5CtzEjnjmBuphGapKqlYmzwnfQ/iKvugJ+FfgitW1fys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 2 Aug
 2024 16:33:32 +0800
Received: from twmbx01.aspeed.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 2 Aug 2024 16:33:32 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <jacky_chou@aspeedtech.com>,
	<u.kleine-koenig@pengutronix.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] net: ftgmac100: Get link speed and duplex for NC-SI
Date: Fri, 2 Aug 2024 16:33:32 +0800
Message-ID: <20240802083332.2471281-1-jacky_chou@aspeedtech.com>
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
the driver connects a fixed-link phy driver for NC-SI.
The ethtool will get the link information from the
fixed-link phy driver.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 37 ++++++++++++++----------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index fddfd1dd5070..0c820997ef88 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -26,6 +26,7 @@
 #include <linux/of_net.h>
 #include <net/ip.h>
 #include <net/ncsi.h>
+#include <linux/phy_fixed.h>
 
 #include "ftgmac100.h"
 
@@ -50,6 +51,15 @@
 #define FTGMAC_100MHZ		100000000
 #define FTGMAC_25MHZ		25000000
 
+/* For NC-SI to register a fixed-link phy device */
+struct fixed_phy_status ncsi_phy_status = {
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
@@ -1492,19 +1502,8 @@ static int ftgmac100_open(struct net_device *netdev)
 		return err;
 	}
 
-	/* When using NC-SI we force the speed to 100Mbit/s full duplex,
-	 *
-	 * Otherwise we leave it set to 0 (no link), the link
-	 * message from the PHY layer will handle setting it up to
-	 * something else if needed.
-	 */
-	if (priv->use_ncsi) {
-		priv->cur_duplex = DUPLEX_FULL;
-		priv->cur_speed = SPEED_100;
-	} else {
-		priv->cur_duplex = 0;
-		priv->cur_speed = 0;
-	}
+	priv->cur_duplex = 0;
+	priv->cur_speed = 0;
 
 	/* Reset the hardware */
 	err = ftgmac100_reset_and_config_mac(priv);
@@ -1532,9 +1531,6 @@ static int ftgmac100_open(struct net_device *netdev)
 		/* If we have a PHY, start polling */
 		phy_start(netdev->phydev);
 	} else if (priv->use_ncsi) {
-		/* If using NC-SI, set our carrier on and start the stack */
-		netif_carrier_on(netdev);
-
 		/* Start the NCSI device */
 		err = ncsi_start_dev(priv->ndev);
 		if (err)
@@ -1794,6 +1790,7 @@ static int ftgmac100_probe(struct platform_device *pdev)
 	struct net_device *netdev;
 	struct ftgmac100 *priv;
 	struct device_node *np;
+	struct phy_device *phydev;
 	int err = 0;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1879,6 +1876,14 @@ static int ftgmac100_probe(struct platform_device *pdev)
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


