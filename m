Return-Path: <netdev+bounces-246891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C061ECF2242
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 08:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66D9D30213D3
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 07:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FC22D7DF2;
	Mon,  5 Jan 2026 07:09:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6E32D7DE1;
	Mon,  5 Jan 2026 07:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767596965; cv=none; b=SHcvKk0n4Wxh2TU+soCh4RFOJe1mdmKISooZNqPNZDrabeXU3qVf6QhmByxJLAASsWiigcR+8ab/hDjuCaCVziRtEBqGkRS/wL68MHABryswoxy5iR9+NRPB4jaETtxq45SdEJEW+7wM1qscQOQGm7cr0TE7iAePlQCoBAS/vbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767596965; c=relaxed/simple;
	bh=oS1ETupMifkYoBdYv45Gyidm3cob0zIsPfWZyWftMuQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Kp6mhxPXsWR9rwmq+RmTfi6oDHVlV/sMZmT9UrIIFvTMpZG7XqWdXHyJnlHyTtlQEddwomnMEERhzpTKKFdL5Da1u76DyYpjlCbH9+Wus0Lwi2elfpUCbJseUoIppnLnY85GCshiJpa11UiEkwekB5BZSFyF9jO96FJOOLaAJx0=
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
Date: Mon, 5 Jan 2026 15:08:57 +0800
Subject: [PATCH 11/15] net: ftgmac100: Move DT probe into a helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260105-ftgmac-cleanup-v1-11-b68e4a3d8fbe@aspeedtech.com>
References: <20260105-ftgmac-cleanup-v1-0-b68e4a3d8fbe@aspeedtech.com>
In-Reply-To: <20260105-ftgmac-cleanup-v1-0-b68e4a3d8fbe@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767596931; l=4025;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=AgmOg+fS71mT31byJzXNyMALPBqZdv0OZINj3HLBaBs=;
 b=DLXtOEfMrqEWFCWsQ1WBJwiYFbXuDINrw6wW9aHId4qWcc2KnB1iLZsy9uwNY3JRRhRFi40Jq
 wpHmtCMYAkUDByQEyShQcpbgcPi61xuLKRGpgtVByIbN9T3Rxrq6T+w
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

From: Andrew Lunn <andrew@lunn.ch>

By moving all the DT probe code into a helper, the complex if else if
else structure can be simplified. No functional change intended.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 89 +++++++++++++++++++-------------
 1 file changed, 54 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index cc01cf616229..d30b0b050648 100644
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
@@ -1966,41 +2018,10 @@ static int ftgmac100_probe(struct platform_device *pdev)
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
@@ -2058,11 +2079,9 @@ static int ftgmac100_probe(struct platform_device *pdev)
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


