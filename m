Return-Path: <netdev+bounces-137785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFA09A9D3A
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 10:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED73C2825B6
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 08:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2BB18E76B;
	Tue, 22 Oct 2024 08:42:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13A827735;
	Tue, 22 Oct 2024 08:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729586549; cv=none; b=QeTsXekl3TCS/ZrbDvTHS5jbnBrhTEuzi3szqR6xNQwuxzkqh0ZHRTIsPardgc+ntPKJoKCjSHwuv10H7oaWPT9V6A1lqirM8WFLw5aMVMJ9/H41/chwLw/8I7JC8uJqplF/rRh5wVq0higCmSBHkaqKvHO3a/HWybLtISrqcsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729586549; c=relaxed/simple;
	bh=jeZ6zyjyG4JjH7bRKxJjdLbzqF9T2Glt5wDSp7mSkBE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E6jx0/Beq+DPB+P9JH5DXXC8gij+EAtcRb6pOFGU1z6KnBbQ151Biv8QLSejEQ94MW42O3ypuEuWBhUTtpgF+hbrh+bnOjt/B3dQcAsxOYjOEoc49BnRNT+DWTBLAi1y6MSJU6U4Fw5BtBudUqCns3RP4w6UJAWIAT9HJo+dzXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 22 Oct
 2024 16:42:14 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 22 Oct 2024 16:42:14 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <u.kleine-koenig@baylibre.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jacky_chou@aspeedtech.com>
Subject: [net-next v3] net: ftgmac100: refactor getting phy device handle
Date: Tue, 22 Oct 2024 16:42:14 +0800
Message-ID: <20241022084214.1261174-1-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Consolidate the handling of dedicated PHY and fixed-link phy by taking
advantage of logic in of_phy_get_and_connect() which handles both of
these cases, rather than open coding the same logic in ftgmac100_probe().

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
v2:
  - enable mac asym pause support for fixed-link PHY
  - remove fixes information
v3:
  - Adjust the commit message
---
 drivers/net/ethernet/faraday/ftgmac100.c | 28 +++++-------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 10c1a2f11000..17ec35e75a65 100644
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


