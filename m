Return-Path: <netdev+bounces-255739-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNGCFklLgGne5wIAu9opvQ
	(envelope-from <netdev+bounces-255739-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 07:59:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 835D6C8FC3
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 07:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE1933003720
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 06:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CD430F812;
	Mon,  2 Feb 2026 06:58:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DEC30EF84;
	Mon,  2 Feb 2026 06:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770015500; cv=none; b=irIXjGPBBrjMBoAqDVq4MUXbCrLVQ9KoR5kE0sktdOB5Yj6A8Pj2MXoUboXPLUmT5e+9xa8wmzxbPE/O6mERB20pg88R5fIQq0OcSyMi9Sm7aIuZA26plVyZ6uX/0/t8ex74imiI2i5MUKEjDGCsdsMj7HmQyTGAbOMYOADWXxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770015500; c=relaxed/simple;
	bh=8d3EE6sOJwUfL4OUiPuDwsXaq+4QaYfiFan31T7cIX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nNq09y4Z9ar6Xg6WXbSJnqeL2df8/mbw1LzHy44ja1fbKKdQNOoQWfLTRlNNgjZCUgFxnVO/n+3iP6TC//GxQZ2mnhDLD+z5eNhly9bqo4UCMnjWTvi1BfGdRPwsx06FAK6XUHD4aJW6EZLD/Rsd4wCIeg79nkAV0943z3K6OwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 2 Feb
 2026 14:57:00 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 2 Feb 2026 14:57:00 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Mon, 2 Feb 2026 14:57:02 +0800
Subject: [PATCH net-next v3 08/15] net: ftgmac100: Move NCSI probe code
 into a helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260202-ftgmac-cleanup-v3-8-6a6a8d45280a@aspeedtech.com>
References: <20260202-ftgmac-cleanup-v3-0-6a6a8d45280a@aspeedtech.com>
In-Reply-To: <20260202-ftgmac-cleanup-v3-0-6a6a8d45280a@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>, Simon Horman
	<horms@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770015420; l=3233;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=esbPpcq45s+GQmLXKfVpYucwKfgmnwfq/x9GxcOWAq4=;
 b=hEaclajCJNqiQwp/HND+T3+LqsuEyJBBBntI79E4N/L9zMS+zVDSmMEBXeSDLh0pKcVR7o/vW
 awir4YMWTPeAqvp2HuuHjbub/lJdfQh3IEDKUFmuB3WxAKwvd7MfCON
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[aspeedtech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255739-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,aspeedtech.com:mid,aspeedtech.com:email]
X-Rspamd-Queue-Id: 835D6C8FC3
X-Rspamd-Action: no action

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
index e511d6d5f7c2..9d8256d4d368 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1839,6 +1839,39 @@ static bool ftgmac100_has_child_node(struct device_node *np, const char *name)
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
@@ -1846,7 +1879,6 @@ static int ftgmac100_probe(struct platform_device *pdev)
 	struct resource *res;
 	int irq;
 	struct net_device *netdev;
-	struct phy_device *phydev;
 	struct ftgmac100 *priv;
 	struct device_node *np;
 	int err = 0;
@@ -1928,32 +1960,9 @@ static int ftgmac100_probe(struct platform_device *pdev)
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


