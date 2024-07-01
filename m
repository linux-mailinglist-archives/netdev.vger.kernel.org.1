Return-Path: <netdev+bounces-108042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4377B91DA8F
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 10:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAF091F22D49
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 08:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A3812BF3A;
	Mon,  1 Jul 2024 08:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DJ7gTZLQ"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C977A86131;
	Mon,  1 Jul 2024 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823849; cv=none; b=T2CHgwrN8RL3ZvY7CP/mGkTAqXk2X6lvNRYwWvnRGHyf4OtVXQHVtyAGaXEhWHkFzpHo1yJ5CkBcTzXCOYFPZFMOwDuYPsHHFBTX+hdGbgqSVQorI4zV9rwT0qkU4K4Q8L+1G+/zQpxVlwpgOp1S9fxEveTGnPFWpxQGPRYA9OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823849; c=relaxed/simple;
	bh=XCkunF4AkoYqkk7iGvEclPs05+M/NfpaS+34vYEgKWQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mAh008UanuZbTD57iLBAFgGOU7PN3g7HMyva9LPRpCa73lSUzSElTem+IHnp09Bc+/pnAQDqWbsKO3bVbMG69+ZYtm3KLVhqogip0mmynq9GjGlIzuWDUFom6f21L/ly4KiZC/vRnpQvd8KKnTHW6yM9Rva2x9P3HUUbITfsMKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DJ7gTZLQ; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 602F2C0011;
	Mon,  1 Jul 2024 08:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719823844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ew3JaznEZxurg8VWcTWT0iqBhrJFxR4lf44/wyJRZV4=;
	b=DJ7gTZLQTxh8TCadSbqg5H1e9BFo/cx8I+wCnN0Nw9EnX7oHelxZZaEPoCIWV4ogQCf7KR
	6GDj2HjMp0pxBTt5iDI4CYTvUWCQ22Bn0LVooDGzazpWgwsCHriD6Pi1Rg0L4rkefmIL7T
	j9Mqord/KHqPxBBzo0qmMWqPwTBt/Iy8pxwo53QnWusHH+k9yB7oUYigQHcm3hZhFasai2
	ckg5veS8kR5Q9cYjynYbdsdJ45GaFMAkMs0hDkuMYOMBEayW3wOZQN9Evr2zC5Ldsqf2pk
	Cn1C0q8G3NBzopIl+fHGAZz8uhnXFrduoqA+TGX0mCM8U36CON18mvX+aAtMww==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Mon, 01 Jul 2024 10:51:03 +0200
Subject: [PATCH net-next 1/6] net: phy: dp83869: Disable autonegotiation in
 RGMII/1000Base-X mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-b4-dp83869-sfp-v1-1-a71d6d0ad5f8@bootlin.com>
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

Currently, the DP83869 driver only disables autonegotiation in fiber
configurations for 100Base-FX mode. However, the DP83869 PHY does not
support autonegotiation in any of its fiber modes.

Disable autonegotiation for all fiber modes.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/net/phy/dp83869.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
index d7aaefb5226b6..f6b05e3a3173e 100644
--- a/drivers/net/phy/dp83869.c
+++ b/drivers/net/phy/dp83869.c
@@ -647,6 +647,21 @@ static int dp83869_configure_fiber(struct phy_device *phydev,
 	linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, phydev->supported);
 	linkmode_set_bit(ADVERTISED_FIBRE, phydev->advertising);
 
+	/* Auto neg is not supported in 100/1000base FX modes */
+	bmcr = phy_read(phydev, MII_BMCR);
+	if (bmcr < 0)
+		return bmcr;
+
+	phydev->autoneg = AUTONEG_DISABLE;
+	linkmode_clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, phydev->supported);
+	linkmode_clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, phydev->advertising);
+
+	if (bmcr & BMCR_ANENABLE) {
+		ret =  phy_modify(phydev, MII_BMCR, BMCR_ANENABLE, 0);
+		if (ret < 0)
+			return ret;
+	}
+
 	if (dp83869->mode == DP83869_RGMII_1000_BASE) {
 		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
 				 phydev->supported);
@@ -655,21 +670,6 @@ static int dp83869_configure_fiber(struct phy_device *phydev,
 				 phydev->supported);
 		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseFX_Half_BIT,
 				 phydev->supported);
-
-		/* Auto neg is not supported in 100base FX mode */
-		bmcr = phy_read(phydev, MII_BMCR);
-		if (bmcr < 0)
-			return bmcr;
-
-		phydev->autoneg = AUTONEG_DISABLE;
-		linkmode_clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, phydev->supported);
-		linkmode_clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, phydev->advertising);
-
-		if (bmcr & BMCR_ANENABLE) {
-			ret =  phy_modify(phydev, MII_BMCR, BMCR_ANENABLE, 0);
-			if (ret < 0)
-				return ret;
-		}
 	}
 
 	/* Update advertising from supported */

-- 
2.45.2


