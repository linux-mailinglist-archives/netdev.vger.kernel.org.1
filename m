Return-Path: <netdev+bounces-257445-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6C6QDdldhWmfAgQAu9opvQ
	(envelope-from <netdev+bounces-257445-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 04:19:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 826F3F9A1A
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 04:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 64E933013FCB
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 03:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55CF30E827;
	Fri,  6 Feb 2026 03:17:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4371E33A70F;
	Fri,  6 Feb 2026 03:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770347876; cv=none; b=GN6PcxYwEXEZ23LIIYnlzH5+4+L/RMzIEtM7hYCm3USyK/6qXNFbGEy6iVwAwaBbxWZ4IoQLZkgJaH0yl5yUvWIADJGipEi6YyuJ8Z1euC+VVDlxFnaVlaoTakj2s51BT68XtIOb9RZ/ygTWifNQCFPV7RK/UyGrAhZhx6GOzSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770347876; c=relaxed/simple;
	bh=SFd9fj77BibhBkdQDezvuWhWXH2DxQ9DRn8c7rnsi0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Jq41gYUIuwt00SHlvHgsaZp2fXqt1bFdtcTrLN9Tm+h3m9unWDklbc5JBl1dmWt6R/1/gqpL4vzPBNXFc2rR73rohwj35JYeJkccOzMrxD+VxvOJ7K3z+BHwnRtmBzX5j+n1H8a/aZTQ+i7vbHRzxr6I2dBs8yvybyyQUmQUeWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 6 Feb
 2026 11:17:46 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 6 Feb 2026 11:17:46 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Fri, 6 Feb 2026 11:17:51 +0800
Subject: [PATCH net-next v5 11/15] net: ftgmac100: Move DT probe into a
 helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260206-ftgmac-cleanup-v5-11-ad28a9067ea7@aspeedtech.com>
References: <20260206-ftgmac-cleanup-v5-0-ad28a9067ea7@aspeedtech.com>
In-Reply-To: <20260206-ftgmac-cleanup-v5-0-ad28a9067ea7@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>, Simon Horman
	<horms@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770347864; l=3722;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=7o3Grdwedb8a9iXtcWUwowbRbDphr2VvIKjMaSv1qKc=;
 b=yfmi9qLQSEZF75vPMCvZWib4rIvzNxaybCjsr1s0EZhqyDOckAn19K1HccRoCaO4iptkIWVCt
 zM5LuYCzRatC8HEXzH36QR2sia/pryjwn+ouzQp37LGzJ/ROyq+AJ5u
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[aspeedtech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257445-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,aspeedtech.com:mid,aspeedtech.com:email,lunn.ch:email]
X-Rspamd-Queue-Id: 826F3F9A1A
X-Rspamd-Action: no action

From: Andrew Lunn <andrew@lunn.ch>

By moving all the DT probe code into a helper, the complex if else if
else structure can be simplified. No functional change intended.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 87 ++++++++++++++++++++------------
 1 file changed, 54 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index ee886ed03587..ad1203b8de0b 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1886,6 +1886,58 @@ static int ftgmac100_probe_ncsi(struct net_device *netdev,
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
@@ -1981,41 +2033,10 @@ static int ftgmac100_probe(struct platform_device *pdev)
 			return err;
 	}
 
-	if (np && of_get_property(np, "use-ncsi", NULL)) {
-		err = ftgmac100_probe_ncsi(netdev, priv, pdev);
+	if (np) {
+		err = ftgmac100_probe_dt(netdev, pdev, priv, np);
 		if (err)
 			goto err;
-	} else if (np && (of_phy_is_fixed_link(np) ||
-			  of_get_property(np, "phy-handle", NULL))) {
-		struct phy_device *phy;
-
-		phy = of_phy_get_and_connect(priv->netdev, np,
-					     &ftgmac100_adjust_link);
-		if (!phy) {
-			dev_err(&pdev->dev, "Failed to connect to phy\n");
-			err = -EINVAL;
-			goto err;
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
-			goto err;
-		}
-
 	}
 
 	priv->rst = devm_reset_control_get_optional_exclusive(priv->dev, NULL);

-- 
2.34.1


