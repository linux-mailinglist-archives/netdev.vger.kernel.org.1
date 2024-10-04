Return-Path: <netdev+bounces-132147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E89A9908EA
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 18:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E7311C216CF
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEF41C7617;
	Fri,  4 Oct 2024 16:18:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BF515B0FF;
	Fri,  4 Oct 2024 16:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728058706; cv=none; b=SmdqjtKVxlIZjLv9i1Ppz1Uw/0w8x3g8T43w3x+ljoSF5VgESvsAt8ZVkQCCVaD4/b8Ka34c6uEeBFam8UQDnmYwoPfn7NPlWHLCcIyYRrp347NMh/XS33YNbn9CND4uwkvhB4NWOTerSEBMjZ83ra/KJ2Ojnk3PqwMcicx9CPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728058706; c=relaxed/simple;
	bh=PpHYk2KaX/9Gc97XfWCiL7TotuqilTQ5H0gfnF0vKPs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgW3d9UVstLzfa+i6EU9VX6xkiVCvyZ2MCDhh4y6gs0Hs0Zwe/f4uDNBt4N8qc5VGrwUWnpA0N1/zCBgiw8eUyT97ux7fB388vcXm0bkUO0yYq1W1UzNo0hdOclKZqJixVE3NUD+8WXhgyIdkSX5sj0AlSuXKifvtHwTAM0xa0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1swl0V-000000008Sy-3KfO;
	Fri, 04 Oct 2024 16:18:19 +0000
Date: Fri, 4 Oct 2024 17:18:16 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Robert Marko <robimarko@gmail.com>,
	=?utf-8?B?UGF3ZcWC?= Owoc <frut3k7@gmail.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 2/2] net: phy: aquantia: allow forcing order of
 MDI pairs
Message-ID: <9ed760ff87d5fc456f31e407ead548bbb754497d.1728058550.git.daniel@makrotopia.org>
References: <7ccf25d6d7859f1ce9983c81a2051cfdfb0e0a99.1728058550.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ccf25d6d7859f1ce9983c81a2051cfdfb0e0a99.1728058550.git.daniel@makrotopia.org>

Despite supporting Auto MDI-X, it looks like Aquantia only supports
swapping pair (1,2) with pair (3,6) like it used to be for MDI-X on
100MBit/s networks.

When all 4 pairs are in use (for 1000MBit/s or faster) the link does not
come up with pair order is not configured correctly, either using
MDI_CFG pin or using the "PMA Receive Reserved Vendor Provisioning 1"
register.

Normally, the order of MDI pairs being either ABCD or DCBA is configured
by pulling the MDI_CFG pin.

However, some hardware designs require overriding the value configured
by that bootstrap pin. The PHY allows doing that by setting a bit in
"PMA Receive Reserved Vendor Provisioning 1" register which allows
ignoring the state of the MDI_CFG pin and another bit configuring
whether the order of MDI pairs should be normal (ABCD) or reverse
(DCBA). Pair polarity is not affected and remains identical in both
settings.

Introduce property "marvell,mdi-cfg-order" which allows forcing either
normal or reverse order of the MDI pairs from DT.

If the property isn't present, the behavior is unchanged and MDI pair
order configuration is untouched (ie. either the result of MDI_CFG pin
pull-up/pull-down, or pair order override already configured by the
bootloader before Linux is started).

Forcing normal pair order is required on the Adtran SDG-8733A Wi-Fi 7
residential gateway.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v3: use u32 'marvell,mdi-cfg-order' instead of two mutually exclusive
    properties as suggested
v2: add missing 'static' keyword, improve commit description

 drivers/net/phy/aquantia/aquantia_main.c | 33 ++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 4d156d406bab..dcad3fa1ddc3 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/bitfield.h>
+#include <linux/of.h>
 #include <linux/phy.h>
 
 #include "aquantia.h"
@@ -71,6 +72,11 @@
 #define MDIO_AN_TX_VEND_INT_MASK2		0xd401
 #define MDIO_AN_TX_VEND_INT_MASK2_LINK		BIT(0)
 
+#define PMAPMD_RSVD_VEND_PROV			0xe400
+#define PMAPMD_RSVD_VEND_PROV_MDI_CONF		GENMASK(1, 0)
+#define PMAPMD_RSVD_VEND_PROV_MDI_REVERSE	BIT(0)
+#define PMAPMD_RSVD_VEND_PROV_MDI_FORCE		BIT(1)
+
 #define MDIO_AN_RX_LP_STAT1			0xe820
 #define MDIO_AN_RX_LP_STAT1_1000BASET_FULL	BIT(15)
 #define MDIO_AN_RX_LP_STAT1_1000BASET_HALF	BIT(14)
@@ -485,6 +491,29 @@ static void aqr107_chip_info(struct phy_device *phydev)
 		   fw_major, fw_minor, build_id, prov_id);
 }
 
+static int aqr107_config_mdi(struct phy_device *phydev)
+{
+	struct device_node *np = phydev->mdio.dev.of_node;
+	u32 mdi_conf;
+	int ret;
+
+	ret = of_property_read_u32(np, "marvell,mdi-cfg-order", &mdi_conf);
+
+	/* Do nothing in case property "marvell,mdi-cfg-order" is not present */
+	if (ret == -ENOENT)
+		return 0;
+
+	if (ret)
+		return ret;
+
+	if (mdi_conf & ~PMAPMD_RSVD_VEND_PROV_MDI_REVERSE)
+		return -EINVAL;
+
+	return phy_modify_mmd(phydev, MDIO_MMD_PMAPMD, PMAPMD_RSVD_VEND_PROV,
+			      PMAPMD_RSVD_VEND_PROV_MDI_CONF,
+			      mdi_conf | PMAPMD_RSVD_VEND_PROV_MDI_FORCE);
+}
+
 static int aqr107_config_init(struct phy_device *phydev)
 {
 	struct aqr107_priv *priv = phydev->priv;
@@ -514,6 +543,10 @@ static int aqr107_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	ret = aqr107_config_mdi(phydev);
+	if (ret)
+		return ret;
+
 	/* Restore LED polarity state after reset */
 	for_each_set_bit(led_active_low, &priv->leds_active_low, AQR_MAX_LEDS) {
 		ret = aqr_phy_led_active_low_set(phydev, led_active_low, true);
-- 
2.46.2

