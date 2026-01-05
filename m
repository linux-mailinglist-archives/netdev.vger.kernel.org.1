Return-Path: <netdev+bounces-246886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C10CF2203
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 08:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0FCA53006E2E
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 07:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446DB2D7DE7;
	Mon,  5 Jan 2026 07:09:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624542D6E74;
	Mon,  5 Jan 2026 07:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767596955; cv=none; b=KdrT0HOgh/H892qSEJnn4Mdi+Drm/gXH9im1wJS0Xz7Jk9xMGR2bw1luVJCAYV4MTq1712US154XSTgSsWAiIofphcIzlC3jaj1M8BuBlWxmj610GKRwFOfy4ytU1O5sIFvhG079Tu9pETKfpp6qojgzPsT9wjAKZv+rnclN0AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767596955; c=relaxed/simple;
	bh=zKiDlGZhvRD4Q58rdnqreaNgsabL/Rc4LTDfiIWKAHk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cFlKJ1fkl4cAmaKq2+EclTT2GYGY+T4zN0OLNj3W83A+RYTM2Xm2fU9uehcv1Zcoss8neP9QvHYer+a2VewJNezMj/QVyzsqI5a6hO/auBG3E4QSXJFUGU5L12XcGYb/1uKhHObx/LBulol2TC5UoHm4wJp516KtTk2NcqAp56I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 5 Jan
 2026 15:08:52 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 5 Jan 2026 15:08:52 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Mon, 5 Jan 2026 15:08:52 +0800
Subject: [PATCH 06/15] net: ftgmac100: Use devm_clk_get_enabled
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260105-ftgmac-cleanup-v1-6-b68e4a3d8fbe@aspeedtech.com>
References: <20260105-ftgmac-cleanup-v1-0-b68e4a3d8fbe@aspeedtech.com>
In-Reply-To: <20260105-ftgmac-cleanup-v1-0-b68e4a3d8fbe@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767596931; l=2486;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=ZiFClAo6vNHqEPGbdzZcGUaqYyr6ia0x7kl4IA1ulNI=;
 b=1Dl9+t2FEvbVoH3Bcg01DilQDw8TKd4Zp5BWWgaKoi/6fpxymvy8SzrNKkmb+68qKRmeT4dhH
 PcNruC+SkS+AXny1aCaKlKhhSEC8zc18cD/9HYgskDNjDuLuQppCRkc
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

From: Andrew Lunn <andrew@lunn.ch>

Make use of devm_ methods to request and enable clocks to simplify
cleanup.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index c23d5d675c5f..3972076ffcf6 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1801,13 +1801,10 @@ static int ftgmac100_setup_clk(struct ftgmac100 *priv)
 	struct clk *clk;
 	int rc;
 
-	clk = devm_clk_get(priv->dev, NULL /* MACCLK */);
+	clk = devm_clk_get_enabled(priv->dev, NULL /* MACCLK */);
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 	priv->clk = clk;
-	rc = clk_prepare_enable(priv->clk);
-	if (rc)
-		return rc;
 
 	/* Aspeed specifies a 100MHz clock is required for up to
 	 * 1000Mbit link speeds. As NCSI is limited to 100Mbit, 25MHz
@@ -1816,21 +1813,15 @@ static int ftgmac100_setup_clk(struct ftgmac100 *priv)
 	rc = clk_set_rate(priv->clk, priv->use_ncsi ? FTGMAC_25MHZ :
 			  FTGMAC_100MHZ);
 	if (rc)
-		goto cleanup_clk;
+		return rc;
 
 	/* RCLK is for RMII, typically used for NCSI. Optional because it's not
 	 * necessary if it's the AST2400 MAC, or the MAC is configured for
 	 * RGMII, or the controller is not an ASPEED-based controller.
 	 */
-	priv->rclk = devm_clk_get_optional(priv->dev, "RCLK");
-	rc = clk_prepare_enable(priv->rclk);
-	if (!rc)
-		return 0;
+	priv->rclk = devm_clk_get_optional_enabled(priv->dev, "RCLK");
 
-cleanup_clk:
-	clk_disable_unprepare(priv->clk);
-
-	return rc;
+	return 0;
 }
 
 static bool ftgmac100_has_child_node(struct device_node *np, const char *name)
@@ -2065,8 +2056,6 @@ static int ftgmac100_probe(struct platform_device *pdev)
 	return 0;
 
 err_register_netdev:
-	clk_disable_unprepare(priv->rclk);
-	clk_disable_unprepare(priv->clk);
 err_phy_connect:
 	ftgmac100_phy_disconnect(netdev);
 err_ncsi_dev:
@@ -2089,9 +2078,6 @@ static void ftgmac100_remove(struct platform_device *pdev)
 		ncsi_unregister_dev(priv->ndev);
 	unregister_netdev(netdev);
 
-	clk_disable_unprepare(priv->rclk);
-	clk_disable_unprepare(priv->clk);
-
 	/* There's a small chance the reset task will have been re-queued,
 	 * during stop, make sure it's gone before we free the structure.
 	 */

-- 
2.34.1


