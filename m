Return-Path: <netdev+bounces-250387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C9CD29EE5
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 03:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7FEC7301D888
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 02:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83548334C25;
	Fri, 16 Jan 2026 02:10:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C49338F20;
	Fri, 16 Jan 2026 02:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768529405; cv=none; b=hL3jEh8Uy1XseU0ybsIMYxiE0oOaIHHpzXgXDLhJaiCpZFT+iKKIrkdNP/iIGpti2VWJul9q5ul3SiHBuSOzQ3fE0TOzLfIL7mqdPI0QG89zA5xo2nJ6K9VjXpQQfaNNxRpYcl+9xmr2ZRSKXwxghJ3Bl8bUSdYzi8rRkajqscI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768529405; c=relaxed/simple;
	bh=d9aiaUKT+SF2C1xDFYAlMbp+rT/1oiUBLwArsg5vnEA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fYixqVU/ljOUusWTN1n8u3YUkJOOWCDu3Reg0mjuQ6AUPjt6UeZ1Um8I2GUzEf7ewQoHyh/trULfhgHNJukDPbYtH9JImC7xQFA1VrRxBuEExTPq0p0SqY3XvBnR2cTT3pYYR6kmejfwLATPQD93AAKDnno4iT1S9AkiGwT3rGI=
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
Date: Fri, 16 Jan 2026 10:09:19 +0800
Subject: [PATCH net-next v2 08/15] net: ftgmac100: Move NCSI probe code
 into a helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260116-ftgmac-cleanup-v2-8-81f41f01f2a8@aspeedtech.com>
References: <20260116-ftgmac-cleanup-v2-0-81f41f01f2a8@aspeedtech.com>
In-Reply-To: <20260116-ftgmac-cleanup-v2-0-81f41f01f2a8@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>, Simon Horman
	<horms@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768529355; l=3233;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=PWRfmKe6YTLsSE6Y3HPpHPyzMAq4PFGJ6scrfjyi5Sc=;
 b=hk72WiTdc1NgqBiLPUvZmNOAJaejC5SHa2s8vlJ0GSVR0Y2ZM1scOWs8cHSLU77HzwIfNnVHt
 3AvPQPe95lfBYqvBomv/dZClV8uJOTHiymZXJc2loLhMvxHCjB11dta
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

From: Andrew Lunn <andrew@lunn.ch>

To help reduce the complexity of the probe function move the NCSI
probe code into a helper. No functional change intended.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 63 ++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 3bccf34cc8a4..f1cb5dc37919 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1837,6 +1837,39 @@ static bool ftgmac100_has_child_node(struct device_node *np, const char *name)
 	return ret;
 }
 
+static int ftgmac100_probe_ncsi(struct net_device *netdev,
+				struct ftgmac100 *priv,
+				struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct phy_device *phydev;
+	int err;
+
+	if (!IS_ENABLED(CONFIG_NET_NCSI)) {
+		dev_err(&pdev->dev, "NCSI stack not enabled\n");
+		return -EINVAL;
+	}
+
+	dev_info(&pdev->dev, "Using NCSI interface\n");
+	priv->use_ncsi = true;
+	priv->ndev = ncsi_register_dev(netdev, ftgmac100_ncsi_handler);
+	if (!priv->ndev)
+		return -EINVAL;
+
+	phydev = fixed_phy_register(&ncsi_phy_status, np);
+	if (IS_ERR(phydev)) {
+		dev_err(&pdev->dev, "failed to register fixed PHY device\n");
+		return PTR_ERR(phydev);
+	}
+	err = phy_connect_direct(netdev, phydev, ftgmac100_adjust_link,
+				 PHY_INTERFACE_MODE_RMII);
+	if (err) {
+		dev_err(&pdev->dev, "Connecting PHY failed\n");
+		fixed_phy_unregister(phydev);
+	}
+	return err;
+}
+
 static int ftgmac100_probe(struct platform_device *pdev)
 {
 	const struct ftgmac100_match_data *match_data;
@@ -1844,7 +1877,6 @@ static int ftgmac100_probe(struct platform_device *pdev)
 	struct resource *res;
 	int irq;
 	struct net_device *netdev;
-	struct phy_device *phydev;
 	struct ftgmac100 *priv;
 	struct device_node *np;
 	int err = 0;
@@ -1926,32 +1958,9 @@ static int ftgmac100_probe(struct platform_device *pdev)
 	}
 
 	if (np && of_get_property(np, "use-ncsi", NULL)) {
-		if (!IS_ENABLED(CONFIG_NET_NCSI)) {
-			dev_err(&pdev->dev, "NCSI stack not enabled\n");
-			err = -EINVAL;
-			goto err_phy_connect;
-		}
-
-		dev_info(&pdev->dev, "Using NCSI interface\n");
-		priv->use_ncsi = true;
-		priv->ndev = ncsi_register_dev(netdev, ftgmac100_ncsi_handler);
-		if (!priv->ndev) {
-			err = -EINVAL;
-			goto err_phy_connect;
-		}
-
-		phydev = fixed_phy_register(&ncsi_phy_status, np);
-		if (IS_ERR(phydev)) {
-			dev_err(&pdev->dev, "failed to register fixed PHY device\n");
-			err = PTR_ERR(phydev);
-			goto err_phy_connect;
-		}
-		err = phy_connect_direct(netdev, phydev, ftgmac100_adjust_link,
-					 PHY_INTERFACE_MODE_RMII);
-		if (err) {
-			dev_err(&pdev->dev, "Connecting PHY failed\n");
-			goto err_phy_connect;
-		}
+		err = ftgmac100_probe_ncsi(netdev, priv, pdev);
+		if (err)
+			goto err_setup_mdio;
 	} else if (np && (of_phy_is_fixed_link(np) ||
 			  of_get_property(np, "phy-handle", NULL))) {
 		struct phy_device *phy;

-- 
2.34.1


