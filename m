Return-Path: <netdev+bounces-134511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9B6999ECA
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 10:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0903D1C21564
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 08:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D5B20A5C8;
	Fri, 11 Oct 2024 08:16:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ADCEBE;
	Fri, 11 Oct 2024 08:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728634604; cv=none; b=s2lTuVLGomjwEPhVa2WDuSLNYHyaGuEB2Tp1cFSdjVMf1JGQ3gSfLgbeTvn3xf3xPiV8IO7vNuRfBbWie76pisPC5oTqndtHMis01nlJpzqtkTAR8ab/OfekV82GKpz5LRget3Ae4F+Dipzvt7IDMOGDmpbjp24JBazf5QfkIwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728634604; c=relaxed/simple;
	bh=9NFy8zb1XFyzlyIt1YrbNfZyf/HjeHWS98MHeLqWWRU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QvCnwpkh2JTAZBxVoRMVFpyGRR8Luap8s1vT643eecTpqtzGCultrSONfdj9YqXb4qXC4MxOl1B3+HDMXQ/87OC7lAcGFCjDZ8SS4qWQtKtfiuMAzZeR2/mJ0MoyGpjnd5rTu7v18Wrno8y6lOtqRuWJ4lX1yt260DtKGz0LqDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 11 Oct
 2024 16:16:33 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 11 Oct 2024 16:16:33 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <jacky_chou@aspeedtech.com>, <jacob.e.keller@intel.com>,
	<rentao.bupt@gmail.com>, <f.fainelli@gmail.com>, <andrew@lunn.ch>,
	<andrew@aj.id.au>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [net] net: ftgmac100: refactor getting phy device handle
Date: Fri, 11 Oct 2024 16:16:33 +0800
Message-ID: <20241011081633.2171603-1-jacky_chou@aspeedtech.com>
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

Fixes: 38561ded50d0 ("net: ftgmac100: support fixed link")
Fixes: 39bfab8844a0 ("net: ftgmac100: Add support for DT phy-handle property")
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 31 ++++++------------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 0b61f548fd18..ae0235a7a74e 100644
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
@@ -1963,7 +1945,8 @@ static int ftgmac100_probe(struct platform_device *pdev)
 		/* Indicate that we support PAUSE frames (see comment in
 		 * Documentation/networking/phy.rst)
 		 */
-		phy_support_asym_pause(phy);
+		if (of_get_property(np, "phy-handle", NULL))
+			phy_support_asym_pause(phy);
 
 		/* Display what we found */
 		phy_attached_info(phy);
-- 
2.25.1


