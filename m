Return-Path: <netdev+bounces-250390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D90D29F9A
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 03:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9322330E6302
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 02:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5093385B5;
	Fri, 16 Jan 2026 02:10:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A21337BB0;
	Fri, 16 Jan 2026 02:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768529419; cv=none; b=U/rD4ZV9mt+HieQ+1vkOsNMh0VUcxq4mn6+qQ0OeOhlYYg6xitKIjOrbYnqZR048rU9lWsB4XTZdJ0T6yHGPpctjE4Ov6dlXeC1myPMUoPiSxbKWCMMUf5WYvkVGBGW4u/rTp0LGZPYTRdntdDGdCjq4gWRCWQUo4O5pSqMp2Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768529419; c=relaxed/simple;
	bh=r+r3eupNaSJOZI65jGhNKLCMIGci+uvguSrj4QWnPgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=irshk4mynjMWTo/x35xN4b+gaDmtx0FGgek3RW1UlQoMQCwCTai5H0teFjCc2jd+lpO3+hOMMYj7UTkqN/MtVP6Thhpzvo+Bbx+CMZ8GhL+/sIrO4SwS2dNiTawyHcysijkAsdq4/DyRUaJ28NgIG+Auz6Ed9mS0u64tkswHKxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 16 Jan
 2026 10:09:16 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 16 Jan 2026 10:09:16 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Fri, 16 Jan 2026 10:09:22 +0800
Subject: [PATCH net-next v2 11/15] net: ftgmac100: Move DT probe into a
 helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260116-ftgmac-cleanup-v2-11-81f41f01f2a8@aspeedtech.com>
References: <20260116-ftgmac-cleanup-v2-0-81f41f01f2a8@aspeedtech.com>
In-Reply-To: <20260116-ftgmac-cleanup-v2-0-81f41f01f2a8@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>, Simon Horman
	<horms@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768529355; l=4071;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=tVopXV5DNmT07+98loUzJrFCfmalZhQi/WEZSI7l9e4=;
 b=XmRCAZoJiK/LDzVHb9aLf2e7q8ovTzBkXnNXJHHBzaFch3dSepUIFdCepKUxAtKccZ8TsKtnb
 8wD+Yd7ON5wCg85VYxxIq+snHUGx0NPuxdUSdf+eshXIYM4gSmoP1NZ
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

From: Andrew Lunn <andrew@lunn.ch>

By moving all the DT probe code into a helper, the complex if else if
else structure can be simplified. No functional change intended.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 89 +++++++++++++++++++-------------
 1 file changed, 54 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index f5e69abb1fcf..71ea7062446e 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1870,6 +1870,58 @@ static int ftgmac100_probe_ncsi(struct net_device *netdev,
 	return err;
 }
 
+static int ftgmac100_probe_dt(struct net_device *netdev,
+			      struct platform_device *pdev,
+			      struct ftgmac100 *priv,
+			      struct device_node *np)
+{
+	struct phy_device *phy;
+	int err;
+
+	if (of_get_property(np, "use-ncsi", NULL))
+		return ftgmac100_probe_ncsi(netdev, priv, pdev);
+
+	if (of_phy_is_fixed_link(np) ||
+	    of_get_property(np, "phy-handle", NULL)) {
+		/* Support "mdio"/"phy" child nodes for ast2400/2500
+		 * with an embedded MDIO controller. Automatically
+		 * scan the DTS for available PHYs and register
+		 * them. 2600 has an independent MDIO controller, not
+		 * part of the MAC.
+		 */
+		phy = of_phy_get_and_connect(priv->netdev, np,
+					     &ftgmac100_adjust_link);
+		if (!phy) {
+			dev_err(&pdev->dev, "Failed to connect to phy\n");
+			return -EINVAL;
+		}
+
+		/* Indicate that we support PAUSE frames (see comment in
+		 * Documentation/networking/phy.rst)
+		 */
+		phy_support_asym_pause(phy);
+
+		/* Display what we found */
+		phy_attached_info(phy);
+		return 0;
+	}
+
+	if (!ftgmac100_has_child_node(np, "mdio")) {
+		/* Support legacy ASPEED devicetree descriptions that
+		 * decribe a MAC with an embedded MDIO controller but
+		 * have no "mdio" child node. Automatically scan the
+		 * MDIO bus for available PHYs.
+		 */
+		err = ftgmac100_mii_probe(netdev);
+		if (err) {
+			dev_err(priv->dev, "MII probe failed!\n");
+			return err;
+		}
+	}
+
+	return 0;
+}
+
 static int ftgmac100_probe(struct platform_device *pdev)
 {
 	const struct ftgmac100_match_data *match_data;
@@ -1965,41 +2017,10 @@ static int ftgmac100_probe(struct platform_device *pdev)
 			goto err_phy_connect;
 	}
 
-	if (np && of_get_property(np, "use-ncsi", NULL)) {
-		err = ftgmac100_probe_ncsi(netdev, priv, pdev);
+	if (np) {
+		err = ftgmac100_probe_dt(netdev, pdev, priv, np);
 		if (err)
-			goto err_setup_mdio;
-	} else if (np && (of_phy_is_fixed_link(np) ||
-			  of_get_property(np, "phy-handle", NULL))) {
-		struct phy_device *phy;
-
-		phy = of_phy_get_and_connect(priv->netdev, np,
-					     &ftgmac100_adjust_link);
-		if (!phy) {
-			dev_err(&pdev->dev, "Failed to connect to phy\n");
-			err = -EINVAL;
 			goto err_phy_connect;
-		}
-
-		/* Indicate that we support PAUSE frames (see comment in
-		 * Documentation/networking/phy.rst)
-		 */
-		phy_support_asym_pause(phy);
-
-		/* Display what we found */
-		phy_attached_info(phy);
-	} else if (np && !ftgmac100_has_child_node(np, "mdio")) {
-		/* Support legacy ASPEED devicetree descriptions that decribe a
-		 * MAC with an embedded MDIO controller but have no "mdio"
-		 * child node. Automatically scan the MDIO bus for available
-		 * PHYs.
-		 */
-		err = ftgmac100_mii_probe(netdev);
-		if (err) {
-			dev_err(priv->dev, "MII probe failed!\n");
-			goto err_ncsi_dev;
-		}
-
 	}
 
 	priv->rst = devm_reset_control_get_optional_exclusive(priv->dev, NULL);
@@ -2057,11 +2078,9 @@ static int ftgmac100_probe(struct platform_device *pdev)
 err_register_netdev:
 err_phy_connect:
 	ftgmac100_phy_disconnect(netdev);
-err_ncsi_dev:
 	if (priv->ndev)
 		ncsi_unregister_dev(priv->ndev);
 	ftgmac100_destroy_mdio(netdev);
-err_setup_mdio:
 	return err;
 }
 

-- 
2.34.1


