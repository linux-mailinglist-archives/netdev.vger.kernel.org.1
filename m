Return-Path: <netdev+bounces-246883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B913ACF21EE
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 08:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 14C76300461A
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 07:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8FC2C326B;
	Mon,  5 Jan 2026 07:09:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BDF29D267;
	Mon,  5 Jan 2026 07:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767596948; cv=none; b=u9CATXajnT/8mOmqgIyxFLqB6W9sxMG/xe8HSJEwpLlCGFubE+ssKZjyXK9xM8FaP2KnGEy57cxAfTUyE2A7I6SSuTw2YKZmASQ5tYVuITBRo4ygmrodXuwhHXH4aAX0GrSwddJIQ5906JXlr/JVpgK6oPwfC6/7SzqafCBtoN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767596948; c=relaxed/simple;
	bh=aeNbxYQZhKF93/cS/Wo89mQZiV8r+9sEAyrcYYIYDBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=o82XxhMEIyuoc8zVXIbclKX30vG1zmYKY6szJoktEO/55AZjVyDX7BB24+c2ED5nEa+x817aSV2mjGneAstnNHoiPQG2EZcm4j4X9JT46xestKrh0klJ0mpZUam4V+DEs/+ZC5GBfBdWhQemkA7vkZBAzKWmbYGvenasa/SXjb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 5 Jan
 2026 15:08:51 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 5 Jan 2026 15:08:51 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Mon, 5 Jan 2026 15:08:49 +0800
Subject: [PATCH 03/15] net: ftgmac100: Replace all
 of_device_is_compatible()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260105-ftgmac-cleanup-v1-3-b68e4a3d8fbe@aspeedtech.com>
References: <20260105-ftgmac-cleanup-v1-0-b68e4a3d8fbe@aspeedtech.com>
In-Reply-To: <20260105-ftgmac-cleanup-v1-0-b68e4a3d8fbe@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767596931; l=3084;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=UJLsdwLt7T2hWvC9KboP2Moda6q3Gub6OhFwobFTWb4=;
 b=fLC8wEYoJOfVzBHWdeJtodj7aHFAF2omdGCrRA8TZoGjs5jWkDPn0Jp9uHMIEUCaCXa3XmHpq
 y6xZgaU2na7DnollNtTeM4My/NQ/Gce0qhF+9WsMUj8p7HdISG8lD1V
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

From: Andrew Lunn <andrew@lunn.ch>

Now that the priv structure includes the MAC ID, make use of it
instead of the more expensive of_device_is_compatible().

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 104eb7b1f5bb..f07167cabf39 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1720,8 +1720,8 @@ static int ftgmac100_setup_mdio(struct net_device *netdev)
 	if (!priv->mii_bus)
 		return -EIO;
 
-	if (of_device_is_compatible(np, "aspeed,ast2400-mac") ||
-	    of_device_is_compatible(np, "aspeed,ast2500-mac")) {
+	if (priv->mac_id == FTGMAC100_AST2400 ||
+	    priv->mac_id == FTGMAC100_AST2500) {
 		/* The AST2600 has a separate MDIO controller */
 
 		/* For the AST2400 and AST2500 this driver only supports the
@@ -1926,9 +1926,9 @@ static int ftgmac100_probe(struct platform_device *pdev)
 	if (err)
 		goto err_phy_connect;
 
-	if (np && (of_device_is_compatible(np, "aspeed,ast2400-mac") ||
-		   of_device_is_compatible(np, "aspeed,ast2500-mac") ||
-		   of_device_is_compatible(np, "aspeed,ast2600-mac"))) {
+	if (priv->mac_id == FTGMAC100_AST2400 ||
+	    priv->mac_id == FTGMAC100_AST2500 ||
+	    priv->mac_id == FTGMAC100_AST2600) {
 		priv->rxdes0_edorr_mask = BIT(30);
 		priv->txdes0_edotr_mask = BIT(30);
 		priv->is_aspeed = true;
@@ -1973,8 +1973,8 @@ static int ftgmac100_probe(struct platform_device *pdev)
 		 * available PHYs and register them.
 		 */
 		if (of_get_property(np, "phy-handle", NULL) &&
-		    (of_device_is_compatible(np, "aspeed,ast2400-mac") ||
-		     of_device_is_compatible(np, "aspeed,ast2500-mac"))) {
+		    (priv->mac_id == FTGMAC100_AST2400 ||
+		     priv->mac_id == FTGMAC100_AST2500)) {
 			err = ftgmac100_setup_mdio(netdev);
 			if (err)
 				goto err_setup_mdio;
@@ -2026,7 +2026,7 @@ static int ftgmac100_probe(struct platform_device *pdev)
 			goto err_phy_connect;
 
 		/* Disable ast2600 problematic HW arbitration */
-		if (of_device_is_compatible(np, "aspeed,ast2600-mac"))
+		if (priv->mac_id == FTGMAC100_AST2600)
 			iowrite32(FTGMAC100_TM_DEFAULT,
 				  priv->base + FTGMAC100_OFFSET_TM);
 	}
@@ -2044,11 +2044,11 @@ static int ftgmac100_probe(struct platform_device *pdev)
 		netdev->hw_features |= NETIF_F_HW_VLAN_CTAG_FILTER;
 
 	/* AST2400  doesn't have working HW checksum generation */
-	if (np && (of_device_is_compatible(np, "aspeed,ast2400-mac")))
+	if (priv->mac_id == FTGMAC100_AST2400)
 		netdev->hw_features &= ~NETIF_F_HW_CSUM;
 
 	/* AST2600 tx checksum with NCSI is broken */
-	if (priv->use_ncsi && of_device_is_compatible(np, "aspeed,ast2600-mac"))
+	if (priv->use_ncsi && priv->mac_id == FTGMAC100_AST2600)
 		netdev->hw_features &= ~NETIF_F_HW_CSUM;
 
 	if (np && of_get_property(np, "no-hw-checksum", NULL))

-- 
2.34.1


