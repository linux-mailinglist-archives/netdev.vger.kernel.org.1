Return-Path: <netdev+bounces-256571-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cO/xOinZgmnkcwMAu9opvQ
	(envelope-from <netdev+bounces-256571-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 06:29:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E1EE1F71
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 06:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C1AC306BC95
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 05:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DE037A4B5;
	Wed,  4 Feb 2026 05:26:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6DA35E548;
	Wed,  4 Feb 2026 05:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770182803; cv=none; b=q7CVWZSnFokWmQwnenBVl89hegPbTlSggBS3lCwIaCwXIFAXj5hxwk3jQeasNT7qMP6SCEFKA+z7471Zpob/U21MSmjiOX2nn+0LM1Zr9Uv1F6a/lJ2o2kpWy7m2u8RHLCTYVC3Ubg0DF/4LenI5rmfqUfYtGCWglqLRz7FjRSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770182803; c=relaxed/simple;
	bh=J3dX5F3ZiK1SpSJ+nrfRy7k8oQkQE4tDxcff2zzXXEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=MCQ4J1tGnhyIpyWKzQMkFH14x6CCW/eGNmMUprPH/ZwL3TQ21Hu5X49OntcCQaJiIQrCRI5gr9mv57Hq/kNofHIopSuQH9/hWH49GXSjdhT3symHpxXHetr3/7HsHHSggSuQy51GRax6x+xDl7hMuO1ktPOiCnPQEfrkqwaR/rY=
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
Date: Wed, 4 Feb 2026 13:26:34 +0800
Subject: [PATCH net-next v4 08/15] net: ftgmac100: Move NCSI probe code
 into a helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260204-ftgmac-cleanup-v4-8-b7f379939b76@aspeedtech.com>
References: <20260204-ftgmac-cleanup-v4-0-b7f379939b76@aspeedtech.com>
In-Reply-To: <20260204-ftgmac-cleanup-v4-0-b7f379939b76@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>, Simon Horman
	<horms@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770182790; l=3399;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=tSDLCPN7Gy5XtUmczxDf2SPRsE7s0Ws9LgjKXnfvqC4=;
 b=VgCgqTEOmUg2vbFBODrpsiettORswZAjRojrgQEoZgUF3eoShTJBYOYev9vUGVuLX6IvEslfy
 o+uDdtAvRtoDgO6fjfEkd0XEH6iVBIFeYkq8IKCeP8pJ5T5rk8nckx5
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[aspeedtech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256571-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.978];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,aspeedtech.com:mid,aspeedtech.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 63E1EE1F71
X-Rspamd-Action: no action

From: Andrew Lunn <andrew@lunn.ch>

To help reduce the complexity of the probe function move the NCSI
probe code into a helper. No functional change intended.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 71 ++++++++++++++++++++------------
 1 file changed, 44 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index e511d6d5f7c2..1e52c4785b49 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1839,6 +1839,47 @@ static bool ftgmac100_has_child_node(struct device_node *np, const char *name)
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
+		err = PTR_ERR(phydev);
+		goto err_register_ndev;
+	}
+	err = phy_connect_direct(netdev, phydev, ftgmac100_adjust_link,
+				 PHY_INTERFACE_MODE_RMII);
+	if (err) {
+		dev_err(&pdev->dev, "Connecting PHY failed\n");
+		goto err_register_phy;
+	}
+
+	return 0;
+err_register_phy:
+	fixed_phy_unregister(phydev);
+err_register_ndev:
+	if (priv->ndev)
+		ncsi_unregister_dev(priv->ndev);
+	return err;
+}
+
 static int ftgmac100_probe(struct platform_device *pdev)
 {
 	const struct ftgmac100_match_data *match_data;
@@ -1846,7 +1887,6 @@ static int ftgmac100_probe(struct platform_device *pdev)
 	struct resource *res;
 	int irq;
 	struct net_device *netdev;
-	struct phy_device *phydev;
 	struct ftgmac100 *priv;
 	struct device_node *np;
 	int err = 0;
@@ -1928,32 +1968,9 @@ static int ftgmac100_probe(struct platform_device *pdev)
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


