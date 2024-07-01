Return-Path: <netdev+bounces-108043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CA091DA90
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 10:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4BCE1C21D42
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 08:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C3F13777F;
	Mon,  1 Jul 2024 08:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aBOg2sMg"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C973483CD4;
	Mon,  1 Jul 2024 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823849; cv=none; b=prSzhFbqfBpZ2EvdB1//jbkaS/VNmTUPVTzTKA4QpmFIQ64Cp+CiekMIRr2FjZauYxhK8U5vLZsF+yRckD049RDUTEsMEI7PLKgC2KAqxOAkNG5tfWr5dICtXd8+EXGo1p4ikSKf5YVYEvaEsDwuM72rOa2WCgWJUMutjobn6kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823849; c=relaxed/simple;
	bh=dM26KV7IcWU1eKc3ESLM8nCREge6dZZhQTJUDCMgjeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=REWi/jRbQ8Cc9JBpcgUe+a2dwPmWzCLMYjESdvI8T+ZP8bamF5GYofLxl/Qn59FKtDz6LsXMjmjYME7dBWkE1Ee5VRp2ups39oafUjoiqJ4fkJx/tVT8+CrxQ4ZNuqYc9wQwkhmTJkuMqZygzmuFZ/CX5co5zNqiDKJPAGbLmPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aBOg2sMg; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A6F59C000E;
	Mon,  1 Jul 2024 08:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719823846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4KWTM28xCttexEfryGnrAJQCAdQ+fe99PoCf6yYBGvY=;
	b=aBOg2sMgmPAEG0asW8W5yHv8Xb1IdQEA/Rn1gjlHKZ0weyL8Lu+s7dqhAdWsb8nCREb2ij
	JbTqMpGtE2g0Kf5fbPo5KAESyjWoAquk+2qtczQCOSe+CB1lQRoa9k0JYQ8JH/DPYOYk7w
	Qtb3M4xBHLqP1waFMn7tKtRzyLOWBfwyZ2ikEaNr+xW9FJLwP8CyawsY+pFl+uA5eABFvk
	S3oNXYuBiGvDiu0tXZM6unX+EuERe8Gi4djl6psPxyEzUrpeaSriM8k+RkxkrX5bCM3F3+
	kPEeislca4RvFM6K7p2r8zDN9wjGySgRyxwamWrk9VUFzfOQc3Sz3oWWAtiD8w==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Mon, 01 Jul 2024 10:51:05 +0200
Subject: [PATCH net-next 3/6] net: phy: dp83869: Ensure that the
 FORCE_LINK_GOOD bit is cleared
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-b4-dp83869-sfp-v1-3-a71d6d0ad5f8@bootlin.com>
References: <20240701-b4-dp83869-sfp-v1-0-a71d6d0ad5f8@bootlin.com>
In-Reply-To: <20240701-b4-dp83869-sfp-v1-0-a71d6d0ad5f8@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.0
X-GND-Sasl: romain.gantois@bootlin.com

This bit is located in the PHY_CONTROL register and should be cleared on
reset. However, this is not always the case, which can cause unexpected
behavior such as link up being incorrectly reported as good when the
DP83869 is brought up directly in RGMII-SGMII bridge mode.

Make sure that this bit is cleared for all operational modes.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/net/phy/dp83869.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
index 6bb9bb1c0e962..579cf6f84e030 100644
--- a/drivers/net/phy/dp83869.c
+++ b/drivers/net/phy/dp83869.c
@@ -713,17 +713,20 @@ static int dp83869_configure_mode(struct phy_device *phydev,
 	if (ret)
 		return ret;
 
-	phy_ctrl_val = (dp83869->rx_fifo_depth << DP83869_RX_FIFO_SHIFT |
+	/* The FORCE_LINK_GOOD bit 10 in the PHYCTRL register should be
+	 * unset after a hardware reset but it is not. make sure it is
+	 * cleared so that the PHY can function properly.
+	 * Also configure TX/RX FIFO depth for modes that require it.
+	 */
+	ret = phy_write(phydev, MII_DP83869_PHYCTRL,
+			dp83869->rx_fifo_depth << DP83869_RX_FIFO_SHIFT |
 			dp83869->tx_fifo_depth << DP83869_TX_FIFO_SHIFT |
 			DP83869_PHY_CTRL_DEFAULT);
+	if (ret)
+		return ret;
 
 	switch (dp83869->mode) {
 	case DP83869_RGMII_COPPER_ETHERNET:
-		ret = phy_write(phydev, MII_DP83869_PHYCTRL,
-				phy_ctrl_val);
-		if (ret)
-			return ret;
-
 		ret = phy_write(phydev, MII_CTRL1000, DP83869_CFG1_DEFAULT);
 		if (ret)
 			return ret;
@@ -746,28 +749,14 @@ static int dp83869_configure_mode(struct phy_device *phydev,
 
 		break;
 	case DP83869_1000M_MEDIA_CONVERT:
-		ret = phy_write(phydev, MII_DP83869_PHYCTRL,
-				phy_ctrl_val);
-		if (ret)
-			return ret;
-
 		ret = phy_write_mmd(phydev, DP83869_DEVADDR,
 				    DP83869_FX_CTRL, DP83869_FX_CTRL_DEFAULT);
 		if (ret)
 			return ret;
 		break;
 	case DP83869_100M_MEDIA_CONVERT:
-		ret = phy_write(phydev, MII_DP83869_PHYCTRL,
-				phy_ctrl_val);
-		if (ret)
-			return ret;
 		break;
 	case DP83869_SGMII_COPPER_ETHERNET:
-		ret = phy_write(phydev, MII_DP83869_PHYCTRL,
-				phy_ctrl_val);
-		if (ret)
-			return ret;
-
 		ret = phy_write(phydev, MII_CTRL1000, DP83869_CFG1_DEFAULT);
 		if (ret)
 			return ret;

-- 
2.45.2


