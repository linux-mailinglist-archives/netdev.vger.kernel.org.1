Return-Path: <netdev+bounces-255742-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMQWN5FLgGne5wIAu9opvQ
	(envelope-from <netdev+bounces-255742-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 08:00:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFD0C8FEF
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 08:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 75C8E300C7EF
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 06:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892D630DD2F;
	Mon,  2 Feb 2026 06:58:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE2E3112C0;
	Mon,  2 Feb 2026 06:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770015505; cv=none; b=Jyqiks3DyuurOOyJdomisFMLzDZcCRZM52hmHMZRUgnsXqjuxzzoypv1C8DZHYyI0zFugoZ77xdu542FDkuucRP8UljbckJ+/Cl36D9xmn1vAldYNoxq769e7LU3N+eQ3S/Pt00Vo1OqzNeVS+mLurGuQGrUlT2Z+UNRO/koqf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770015505; c=relaxed/simple;
	bh=oFLod5/eCtcLJc4LaF0R/Qx43O0Yen3fiT9Qo2Fs5hg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=rdo6WFJGUQKGykcS3y81ciQuJ3goO5r17oEFqxU+E+f+dE3zU07OXW5gx3n9If+3rDCEuUFo+NW+J+rmA++47Hy9L9jByBv409gVtAIdqhVn360Y1pj6Xn5gI9T5yf8ZB9NfiOXgq2csLNyivkKQkhaJsNAOeRonf2ZqBbCRfdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 2 Feb
 2026 14:57:01 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 2 Feb 2026 14:57:01 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Mon, 2 Feb 2026 14:57:05 +0800
Subject: [PATCH net-next v3 11/15] net: ftgmac100: Move DT probe into a
 helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260202-ftgmac-cleanup-v3-11-6a6a8d45280a@aspeedtech.com>
References: <20260202-ftgmac-cleanup-v3-0-6a6a8d45280a@aspeedtech.com>
In-Reply-To: <20260202-ftgmac-cleanup-v3-0-6a6a8d45280a@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>, Simon Horman
	<horms@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770015420; l=3722;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=McZ0I9AK7nogEIoCH3TqWS3BP8+jYuWEkFAmsFCLwq8=;
 b=OifrRU2JWEZ1G9tYpIbLzgyt/tnmlbhXYamXiglb0D2MAd2N3iLj8XYaYSyA274lKLzT9IkAd
 q0Pm9+9T/CNAoLCbdkOw5WPcL08muEC1GaZxWPZ890hQzOgPVZmqwhY
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
	TAGGED_FROM(0.00)[bounces-255742-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lunn.ch:email,aspeedtech.com:mid,aspeedtech.com:email]
X-Rspamd-Queue-Id: 0AFD0C8FEF
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
index 4c7430088c63..eac0eddff641 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1872,6 +1872,58 @@ static int ftgmac100_probe_ncsi(struct net_device *netdev,
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
@@ -1967,41 +2019,10 @@ static int ftgmac100_probe(struct platform_device *pdev)
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


