Return-Path: <netdev+bounces-120791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BF895ABCE
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 05:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 671C128E9CD
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 03:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AB11804F;
	Thu, 22 Aug 2024 03:19:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE771BC39;
	Thu, 22 Aug 2024 03:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724296790; cv=none; b=ff5t+sOV1kbq3iEQcuM8UjEeuab3ngqQXFtfXK44oeJR2RrutKN5+8HiLvv3345VG51WTY1RsdJOY7i8PLrEguqNZUarclk3H+z/rBt+KLLi83KQjF7zMmHHXozqwJcZJyeez4TUlkk3kz7WOZ36fMy35+Q4ciSiSm5d/Z79+BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724296790; c=relaxed/simple;
	bh=KlBfVspWQBCwsLVDL8wG1sm5iD6wTaJYoKmptrLRRfY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hIupbthYDplKYl/cQ3T3rhVkDEJLuZCtENhTYewjp5L8nZcBLtGpLXwKTkLKRKRyOMc2lMeNE/Jnid4xIT9QH649oRuxCy4un5/uWiwDpPPORy6pBczgW/WDqwnoottG1+GWu+svMfUQFifRG0YmnMUnk8iU6EhRcPv6knJP2m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 22 Aug
 2024 11:19:45 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 22 Aug 2024 11:19:45 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <jacky_chou@aspeedtech.com>,
	<u.kleine-koenig@pengutronix.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2] net: ftgmac100: Get link speed and duplex for NC-SI
Date: Thu, 22 Aug 2024 11:19:45 +0800
Message-ID: <20240822031945.3102130-1-jacky_chou@aspeedtech.com>
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
v2:
  - use static for struct fixed_phy_status ncsi_phy_status
  - Stop phy device at net_device stop when using NC-SI.
  - Start phy device at net_device start when using NC-SI.
---
 drivers/net/ethernet/faraday/ftgmac100.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index fddfd1dd5070..93862b027be0 100644
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
 
@@ -1577,7 +1588,7 @@ static int ftgmac100_stop(struct net_device *netdev)
 	netif_napi_del(&priv->napi);
 	if (netdev->phydev)
 		phy_stop(netdev->phydev);
-	else if (priv->use_ncsi)
+	if (priv->use_ncsi)
 		ncsi_stop_dev(priv->ndev);
 
 	ftgmac100_stop_hw(priv);
@@ -1794,6 +1805,7 @@ static int ftgmac100_probe(struct platform_device *pdev)
 	struct net_device *netdev;
 	struct ftgmac100 *priv;
 	struct device_node *np;
+	struct phy_device *phydev;
 	int err = 0;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1879,6 +1891,14 @@ static int ftgmac100_probe(struct platform_device *pdev)
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


