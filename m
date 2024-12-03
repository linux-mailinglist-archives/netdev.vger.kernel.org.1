Return-Path: <netdev+bounces-148464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E649E1C74
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 13:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30D29284A29
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 12:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59B31EBFFB;
	Tue,  3 Dec 2024 12:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aWdJRXg1"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C87F1EB9EF;
	Tue,  3 Dec 2024 12:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733229812; cv=none; b=auE5mgiURdkXJkUqoyYpvsyJVvsZpecF68vL3ygdbvPGI2oRbPoMY+BDelcTsbuAO4kiq7URFHb6/doZuJwzWuL2b3YWHY0Uu0BRSLxd7BGAifd8jHdC9l3iFjgt0kBp14pNRBVdFgbnBdN9m3SX0lIZGM8VqywRaczf3ZXkHyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733229812; c=relaxed/simple;
	bh=RDRWFO8FAKxs5V+akUJuUVJeLeitR8MFJOfvu4K+OFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apePQxxXaQLtVsA0oUDxCOJ2A0ZaOLYlcWI8VSofp2C3/Txw3I0jH9X1j2bqRUsJuFV4rM5A2OjafCXWqcreSEx6o9Ipz48262tFC3MzIQHxMpS3A/I6/rWnM3RYDq56Oi03NUckOLgv/iK+5YssA4wS0NAiBU4R/sPnZvX+5dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aWdJRXg1; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9C32CE0005;
	Tue,  3 Dec 2024 12:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733229807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GQHlIb4Gfh8EqQ2vSbSyZTfbQITqF3RlPmf5reSnDvM=;
	b=aWdJRXg1SUHhrQsmh6B9K24oj+/v22dZ9v4dFk6aeC96LNTXaL5ikt4H50Cz8z2CLi4PwR
	7U9RhzNA9QkLvyB5pAWVPGy2boNtJMg76SlA6Hd1OzYyHb8UgnTU+j5YX2hXV/UHPLZ/VN
	bsgATAR89BPXreycmPjzzE2IPCm/GRho22ia0KjvUP0kZlZLb9CicfftKT6i4ObnmIC7y7
	k96Qeplcol8lVrolJRpcpJXvFSbyNOy4RAnr/UTBF/qFcgREykjnRPNCErL48Be5MhgiHK
	WcK7TPGMUBmtpO8NhmpfNiR0EQa1hJmWBPhAx9dtF3VOs4gMpKZhr/yHsxZ/Mw==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Simon Horman <horms@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH net-next v3 01/10] net: freescale: ucc_geth: Drop support for the "interface" DT property
Date: Tue,  3 Dec 2024 13:43:12 +0100
Message-ID: <20241203124323.155866-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241203124323.155866-1-maxime.chevallier@bootlin.com>
References: <20241203124323.155866-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

In april 2007, ucc_geth was converted to phylib with :

commit 728de4c927a3 ("ucc_geth: migrate ucc_geth to phylib").

In that commit, the device-tree property "interface", that could be used to
retrieve the PHY interface mode was deprecated.

DTS files that still used that property were converted along the way, in
the following commit, also dating from april 2007 :

commit 0fd8c47cccb1 ("[POWERPC] Replace undocumented interface properties in dts files")

17 years later, there's no users of that property left and I hope it's
safe to say we can remove support from that in the ucc_geth driver,
making the probe() function a bit simpler.

Should there be any users that have a DT that was generated when 2.6.21 was
cutting-edge, print an error message with hints on how to convert the
devicetree if the 'interface' property is found.

With that property gone, we can greatly simplify the parsing of the
phy-interface-mode from the devicetree by using of_get_phy_mode(),
allowing the removal of the open-coded parsing in the driver.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V3 :  Return an error code on failure. I kept Andrew's R'd-by though,
let me know if I should drop it.

 drivers/net/ethernet/freescale/ucc_geth.c | 63 +++++------------------
 1 file changed, 12 insertions(+), 51 deletions(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index 6663c1768089..b023a1a1dc5c 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -3469,32 +3469,6 @@ static int ucc_geth_resume(struct platform_device *ofdev)
 #define ucc_geth_resume NULL
 #endif
 
-static phy_interface_t to_phy_interface(const char *phy_connection_type)
-{
-	if (strcasecmp(phy_connection_type, "mii") == 0)
-		return PHY_INTERFACE_MODE_MII;
-	if (strcasecmp(phy_connection_type, "gmii") == 0)
-		return PHY_INTERFACE_MODE_GMII;
-	if (strcasecmp(phy_connection_type, "tbi") == 0)
-		return PHY_INTERFACE_MODE_TBI;
-	if (strcasecmp(phy_connection_type, "rmii") == 0)
-		return PHY_INTERFACE_MODE_RMII;
-	if (strcasecmp(phy_connection_type, "rgmii") == 0)
-		return PHY_INTERFACE_MODE_RGMII;
-	if (strcasecmp(phy_connection_type, "rgmii-id") == 0)
-		return PHY_INTERFACE_MODE_RGMII_ID;
-	if (strcasecmp(phy_connection_type, "rgmii-txid") == 0)
-		return PHY_INTERFACE_MODE_RGMII_TXID;
-	if (strcasecmp(phy_connection_type, "rgmii-rxid") == 0)
-		return PHY_INTERFACE_MODE_RGMII_RXID;
-	if (strcasecmp(phy_connection_type, "rtbi") == 0)
-		return PHY_INTERFACE_MODE_RTBI;
-	if (strcasecmp(phy_connection_type, "sgmii") == 0)
-		return PHY_INTERFACE_MODE_SGMII;
-
-	return PHY_INTERFACE_MODE_MII;
-}
-
 static int ucc_geth_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
 	struct ucc_geth_private *ugeth = netdev_priv(dev);
@@ -3564,19 +3538,6 @@ static int ucc_geth_probe(struct platform_device* ofdev)
 	int err, ucc_num, max_speed = 0;
 	const unsigned int *prop;
 	phy_interface_t phy_interface;
-	static const int enet_to_speed[] = {
-		SPEED_10, SPEED_10, SPEED_10,
-		SPEED_100, SPEED_100, SPEED_100,
-		SPEED_1000, SPEED_1000, SPEED_1000, SPEED_1000,
-	};
-	static const phy_interface_t enet_to_phy_interface[] = {
-		PHY_INTERFACE_MODE_MII, PHY_INTERFACE_MODE_RMII,
-		PHY_INTERFACE_MODE_RGMII, PHY_INTERFACE_MODE_MII,
-		PHY_INTERFACE_MODE_RMII, PHY_INTERFACE_MODE_RGMII,
-		PHY_INTERFACE_MODE_GMII, PHY_INTERFACE_MODE_RGMII,
-		PHY_INTERFACE_MODE_TBI, PHY_INTERFACE_MODE_RTBI,
-		PHY_INTERFACE_MODE_SGMII,
-	};
 
 	ugeth_vdbg("%s: IN", __func__);
 
@@ -3627,18 +3588,18 @@ static int ucc_geth_probe(struct platform_device* ofdev)
 	/* Find the TBI PHY node.  If it's not there, we don't support SGMII */
 	ug_info->tbi_node = of_parse_phandle(np, "tbi-handle", 0);
 
-	/* get the phy interface type, or default to MII */
-	prop = of_get_property(np, "phy-connection-type", NULL);
-	if (!prop) {
-		/* handle interface property present in old trees */
-		prop = of_get_property(ug_info->phy_node, "interface", NULL);
-		if (prop != NULL) {
-			phy_interface = enet_to_phy_interface[*prop];
-			max_speed = enet_to_speed[*prop];
-		} else
-			phy_interface = PHY_INTERFACE_MODE_MII;
-	} else {
-		phy_interface = to_phy_interface((const char *)prop);
+	prop = of_get_property(ug_info->phy_node, "interface", NULL);
+	if (prop) {
+		dev_err(&ofdev->dev,
+			"Device-tree property 'interface' is no longer supported. Please use 'phy-connection-type' instead.");
+		err = -EINVAL;
+		goto err_deregister_fixed_link;
+	}
+
+	err = of_get_phy_mode(np, &phy_interface);
+	if (err) {
+		dev_err(&ofdev->dev, "Invalid phy-connection-type");
+		goto err_deregister_fixed_link;
 	}
 
 	/* get speed, or derive from PHY interface */
-- 
2.47.0


