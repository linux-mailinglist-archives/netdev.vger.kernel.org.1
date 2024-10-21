Return-Path: <netdev+bounces-137351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 524E69A58F7
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 04:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06A931F21761
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 02:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0722364A9;
	Mon, 21 Oct 2024 02:37:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C449A347C7;
	Mon, 21 Oct 2024 02:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729478234; cv=none; b=SN/6GmaCo0nbCrxVtvkJxpG1jOXoXmeW/yu6ioerrwwXHiDPdtbyVovdvRov/R6h0Qi9/vaoAsbGO5V3o4LOp/JqKj8aK+zCw0hakEWgZEy+VoJbUYmJQWqg79lmlZiND1ldQ8i0bEcOuo1psZoEDzQfFxxABt5TbE1pCkpZ70k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729478234; c=relaxed/simple;
	bh=bSRcaN2Fqz933WcAN1VArM7AvR0/LUyyI9z3HrbUVlw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nw5Y22/BJvGj9HiFttE8qxODsO7P379fsDCrMFXQrEVcKVr1mXVMz0zMxbD5TJGhM4EXlCrDT09n8uMCiP0FGX+CJr4rnFXuH2BXR3hXiBIAz3RcN6Sdn1qK4IIIVhGFZbL4oA8E7tmaV6M5WAWAFKVRSt8is0mI2edGr/bua/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 21 Oct
 2024 10:37:05 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 21 Oct 2024 10:37:05 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <jacky_chou@aspeedtech.com>
Subject: [net v2] net: ftgmac100: refactor getting phy device handle
Date: Mon, 21 Oct 2024 10:37:05 +0800
Message-ID: <20241021023705.2953048-1-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The ftgmac100 supports NC-SI mode, dedicated PHY and fixed-link
PHY. The dedicated PHY is using the phy_handle property to get
phy device handle and the fixed-link phy is using the fixed-link
property to register a fixed-link phy device.

In of_phy_get_and_connect function, it help driver to get and register
these PHYs handle.
Therefore, here refactors this part by using of_phy_get_and_connect.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
v2:
  - enable mac asym pause support for fixed-link PHY
  - remove fixes information
---
 drivers/net/ethernet/faraday/ftgmac100.c | 28 +++++-------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 0b61f548fd18..8f4093f6d289 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1918,35 +1918,17 @@ static int ftgmac100_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "Connecting PHY failed\n");
 			goto err_phy_connect;
 		}
-	} else if (np && of_phy_is_fixed_link(np)) {
-		struct phy_device *phy;
-
-		err = of_phy_register_fixed_link(np);
-		if (err) {
-			dev_err(&pdev->dev, "Failed to register fixed PHY\n");
-			goto err_phy_connect;
-		}
-
-		phy = of_phy_get_and_connect(priv->netdev, np,
-					     &ftgmac100_adjust_link);
-		if (!phy) {
-			dev_err(&pdev->dev, "Failed to connect to fixed PHY\n");
-			of_phy_deregister_fixed_link(np);
-			err = -EINVAL;
-			goto err_phy_connect;
-		}
-
-		/* Display what we found */
-		phy_attached_info(phy);
-	} else if (np && of_get_property(np, "phy-handle", NULL)) {
+	} else if (np && (of_phy_is_fixed_link(np) ||
+			  of_get_property(np, "phy-handle", NULL))) {
 		struct phy_device *phy;
 
 		/* Support "mdio"/"phy" child nodes for ast2400/2500 with
 		 * an embedded MDIO controller. Automatically scan the DTS for
 		 * available PHYs and register them.
 		 */
-		if (of_device_is_compatible(np, "aspeed,ast2400-mac") ||
-		    of_device_is_compatible(np, "aspeed,ast2500-mac")) {
+		if (of_get_property(np, "phy-handle", NULL) &&
+		    (of_device_is_compatible(np, "aspeed,ast2400-mac") ||
+		     of_device_is_compatible(np, "aspeed,ast2500-mac"))) {
 			err = ftgmac100_setup_mdio(netdev);
 			if (err)
 				goto err_setup_mdio;
-- 
2.25.1


