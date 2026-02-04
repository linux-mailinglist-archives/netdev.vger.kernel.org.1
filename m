Return-Path: <netdev+bounces-256572-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEh4NN3ZgmnkcwMAu9opvQ
	(envelope-from <netdev+bounces-256572-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 06:32:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 171FFE1FCA
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 06:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BD40314FDCA
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 05:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B1437BE74;
	Wed,  4 Feb 2026 05:26:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A7437AA79;
	Wed,  4 Feb 2026 05:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770182804; cv=none; b=WKL7A6CPf/GE0K5SJ6FUrhlJR+IuqSuS3zBjUKf1w6y+SRD6caCDcQu0GNRcndG4Bs0mkF637L6AoWxkLnWGNz6oNfN8NIeYjrPVjdzcdOjdCV/qs6hMLkgHV210x66Bd3oPMrxRwN+ibVfQm9Rv5DQJWA+lkoHcAGL0nhXkwC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770182804; c=relaxed/simple;
	bh=iriX92M1zIHCRmd88EI1TS6+DwLwGb9Rr2XR0fkU3Ys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ohY2KL9hsZVlexHwgEkggIWj/OvAVJekzw5O2qpGFAZBUyjUEe0lSE1ReMOmEUUcpoUGvgMmolai7LScbEilZ450M0eTXiwYLtt63atR+Pjx0D3Ea5O20JlxmrjBjrPPhEMNuGaLpnptdbHrfjmZvSRwXo/fr+YEH7em/i19soE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 4 Feb
 2026 13:26:31 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 4 Feb 2026 13:26:31 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Wed, 4 Feb 2026 13:26:35 +0800
Subject: [PATCH net-next v4 09/15] net: ftgmac100: Always register the MDIO
 bus when it exists
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260204-ftgmac-cleanup-v4-9-b7f379939b76@aspeedtech.com>
References: <20260204-ftgmac-cleanup-v4-0-b7f379939b76@aspeedtech.com>
In-Reply-To: <20260204-ftgmac-cleanup-v4-0-b7f379939b76@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>, Simon Horman
	<horms@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770182790; l=3611;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=p3/DDR8AqAz/x6dmOVmUzbO5NrzREzPYAMKBbE/SR3w=;
 b=CUMC8lsFUTx2H89UwaT5jyfaPTpiipbiHvrXvfc52SbotT+WLXXGdbUTm2QDbq33Sy1608lHG
 hqUxcI6KUT8DYRc+PFxNm4/y3lv4VLDymmN5xUlfd8fdPcdvYBeyEzF
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[aspeedtech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256572-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacky_chou@aspeedtech.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.976];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,aspeedtech.com:mid,aspeedtech.com:email,lunn.ch:email]
X-Rspamd-Queue-Id: 171FFE1FCA
X-Rspamd-Action: no action

From: Andrew Lunn <andrew@lunn.ch>

Both the Aspeed 2400 and 2500 and the original faraday version of the
MAC have MDIO bus controllers as part of the MAC. Since it exists,
always registering it makes the code simpler, and causes no harm. If
there is no mdio node in device tree, of_mdiobus_register() will fall
back to mdiobus_register(), making it safe.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 40 ++++++++++++--------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 1e52c4785b49..7d6e7f2ae969 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1967,32 +1967,28 @@ static int ftgmac100_probe(struct platform_device *pdev)
 		priv->txdes0_edotr_mask = BIT(15);
 	}
 
+	if (priv->mac_id == FTGMAC100_FARADAY ||
+	    priv->mac_id == FTGMAC100_AST2400 ||
+	    priv->mac_id == FTGMAC100_AST2500) {
+		err = ftgmac100_setup_mdio(netdev);
+		if (err)
+			return err;
+	}
+
 	if (np && of_get_property(np, "use-ncsi", NULL)) {
 		err = ftgmac100_probe_ncsi(netdev, priv, pdev);
 		if (err)
-			goto err_setup_mdio;
+			goto err;
 	} else if (np && (of_phy_is_fixed_link(np) ||
 			  of_get_property(np, "phy-handle", NULL))) {
 		struct phy_device *phy;
 
-		/* Support "mdio"/"phy" child nodes for ast2400/2500 with
-		 * an embedded MDIO controller. Automatically scan the DTS for
-		 * available PHYs and register them.
-		 */
-		if (of_get_property(np, "phy-handle", NULL) &&
-		    (priv->mac_id == FTGMAC100_AST2400 ||
-		     priv->mac_id == FTGMAC100_AST2500)) {
-			err = ftgmac100_setup_mdio(netdev);
-			if (err)
-				goto err_setup_mdio;
-		}
-
 		phy = of_phy_get_and_connect(priv->netdev, np,
 					     &ftgmac100_adjust_link);
 		if (!phy) {
 			dev_err(&pdev->dev, "Failed to connect to phy\n");
 			err = -EINVAL;
-			goto err_phy_connect;
+			goto err;
 		}
 
 		/* Indicate that we support PAUSE frames (see comment in
@@ -2009,14 +2005,11 @@ static int ftgmac100_probe(struct platform_device *pdev)
 		 * PHYs.
 		 */
 		priv->use_ncsi = false;
-		err = ftgmac100_setup_mdio(netdev);
-		if (err)
-			goto err_setup_mdio;
 
 		err = ftgmac100_mii_probe(netdev);
 		if (err) {
 			dev_err(priv->dev, "MII probe failed!\n");
-			goto err_ncsi_dev;
+			goto err;
 		}
 
 	}
@@ -2024,13 +2017,13 @@ static int ftgmac100_probe(struct platform_device *pdev)
 	priv->rst = devm_reset_control_get_optional_exclusive(priv->dev, NULL);
 	if (IS_ERR(priv->rst)) {
 		err = PTR_ERR(priv->rst);
-		goto err_phy_connect;
+		goto err;
 	}
 
 	if (priv->is_aspeed) {
 		err = ftgmac100_setup_clk(priv);
 		if (err)
-			goto err_phy_connect;
+			goto err;
 
 		/* Disable ast2600 problematic HW arbitration */
 		if (priv->mac_id == FTGMAC100_AST2600)
@@ -2066,21 +2059,18 @@ static int ftgmac100_probe(struct platform_device *pdev)
 	err = register_netdev(netdev);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to register netdev\n");
-		goto err_register_netdev;
+		goto err;
 	}
 
 	netdev_info(netdev, "irq %d, mapped at %p\n", netdev->irq, priv->base);
 
 	return 0;
 
-err_register_netdev:
-err_phy_connect:
+err:
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


