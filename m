Return-Path: <netdev+bounces-108045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC2091DA99
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 10:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A22401F22C8D
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 08:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A752313D899;
	Mon,  1 Jul 2024 08:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QqSNhPO9"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5BE7E0F0;
	Mon,  1 Jul 2024 08:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823850; cv=none; b=cb44uCCGOtA/A6nGgARKuRpAIXZMA+i2l9038yq1qO3ciPC5H/0GTnb33YfGWlNPWBVYHCrbDnzj1DN40LKtGCnJxZ0XtgCjUiKmrJg9F+B0LpBYOxJ9+Qx4uNRWoXKgQbTQ0t6AcovxSoaJF3SIO45IDyHuIGnAfwIJGij8ZEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823850; c=relaxed/simple;
	bh=1ZHhzaXO/qyzrVPK875CXBdCiwYG+tNpCoZ7YYPtqxg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ip+0FILhfwqKxW6Y4hl/+M6us4wfdkQFAQ2sSIB2tCMpJtwttLG8X+Xwu5r16jwf9BkmvKote4C0WXVxBRKE2yA7KATk1STT+dUOvxEBkM04xsGOzZOjRIZrfD2+reCyKpkWIMVjDAC2Pq/WYq5Y4tjnkM32AKUPwhUGSjMzw8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QqSNhPO9; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5EBC4C000D;
	Mon,  1 Jul 2024 08:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719823846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MZphmPMPCyxcl1+lMlccveFAU5GvuISteHDMC4X9nDA=;
	b=QqSNhPO9khOguffGObeAEmjOC0bBH4YUUUOiCo54Ppji21mL/3bO6EgRqVEWdVWWBHIOhX
	WyKMXBopdn9a/20l7v+ix2UxUPut8KdWEo45aYPQ/hoV1oOk7VkDKBD2BkoG9m/2eIMVZi
	6wXKXJlNecX7SPRRKfjg0QdfSWPwQFReNdiYmGHIRdWz3Fnauuq0HrD0rom4i65g/G4oQv
	AKxJarvVZYUuZKhxzds7o2oK3CrylSNt1B2esiCw3iRugkLa2LHQLeKLB0xQ4DSnvsLqRf
	O7mo3LXGlCY9JAjPaywDdEt9x6tWJeebEfcwUHqeL53glk6foyugo6yA0KHlaA==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Mon, 01 Jul 2024 10:51:06 +0200
Subject: [PATCH net-next 4/6] net: phy: dp83869: Support 1000Base-X and
 100Base-FX SFP modules
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-b4-dp83869-sfp-v1-4-a71d6d0ad5f8@bootlin.com>
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

The DP83869HM PHY transceiver can be configured in RGMII-1000Base-X mode to
interface an RGMII MAC with a copper direct-attach (DAC) or fiber SFP
module. SFP upstream ops are needed to notify the DP83869 driver of SFP
module insertions and let it configure the PHY appropriately.

Add relevant SFP callbacks to the DP83869 driver to support 1000Base-X and
100Base-FX modules.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/net/phy/dp83869.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
index 579cf6f84e030..a3ccaad738b28 100644
--- a/drivers/net/phy/dp83869.c
+++ b/drivers/net/phy/dp83869.c
@@ -10,6 +10,8 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/phy.h>
+#include <linux/phylink.h>
+#include <linux/sfp.h>
 #include <linux/delay.h>
 #include <linux/bitfield.h>
 
@@ -843,6 +845,62 @@ static int dp83869_config_init(struct phy_device *phydev)
 	return ret;
 }
 
+static int dp83869_module_insert(void *upstream, const struct sfp_eeprom_id *id)
+{
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(phy_support);
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(sfp_support);
+	DECLARE_PHY_INTERFACE_MASK(interfaces);
+	struct phy_device *phydev = upstream;
+	struct dp83869_private *dp83869;
+	phy_interface_t interface;
+
+	linkmode_zero(phy_support);
+	phylink_set(phy_support, 1000baseX_Full);
+	phylink_set(phy_support, 100baseFX_Full);
+	phylink_set(phy_support, FIBRE);
+
+	linkmode_zero(sfp_support);
+	sfp_parse_support(phydev->sfp_bus, id, sfp_support, interfaces);
+
+	linkmode_and(sfp_support, phy_support, sfp_support);
+
+	if (linkmode_empty(sfp_support)) {
+		dev_err(&phydev->mdio.dev, "incompatible SFP module inserted\n");
+		return -EINVAL;
+	}
+
+	interface = sfp_select_interface(phydev->sfp_bus, sfp_support);
+
+	dev_info(&phydev->mdio.dev, "%s SFP compatible link mode: %s\n", __func__,
+		 phy_modes(interface));
+
+	dp83869 = phydev->priv;
+
+	switch (interface) {
+	case PHY_INTERFACE_MODE_100BASEX:
+		dp83869->mode = DP83869_RGMII_100_BASE;
+		phydev->port = PORT_FIBRE;
+		break;
+	case PHY_INTERFACE_MODE_1000BASEX:
+		dp83869->mode = DP83869_RGMII_1000_BASE;
+		phydev->port = PORT_FIBRE;
+		break;
+	default:
+		dev_err(&phydev->mdio.dev,
+			"incompatible PHY-to-SFP module link mode %s!\n",
+			phy_modes(interface));
+		return -EINVAL;
+	}
+
+	return dp83869_configure_mode(phydev, dp83869);
+}
+
+static const struct sfp_upstream_ops dp83869_sfp_ops = {
+	.attach = phy_sfp_attach,
+	.detach = phy_sfp_detach,
+	.module_insert = dp83869_module_insert,
+};
+
 static int dp83869_probe(struct phy_device *phydev)
 {
 	struct dp83869_private *dp83869;
@@ -859,6 +917,10 @@ static int dp83869_probe(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	ret = phy_sfp_probe(phydev, &dp83869_sfp_ops);
+	if (ret)
+		return ret;
+
 	if (dp83869->mode == DP83869_RGMII_100_BASE ||
 	    dp83869->mode == DP83869_RGMII_1000_BASE)
 		phydev->port = PORT_FIBRE;

-- 
2.45.2


