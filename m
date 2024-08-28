Return-Path: <netdev+bounces-122971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A8E96350B
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 00:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 641A4286E4A
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 22:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943BB1AE03A;
	Wed, 28 Aug 2024 22:52:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCC515A858;
	Wed, 28 Aug 2024 22:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724885540; cv=none; b=lPa9L1GHGoFDHiPPqmEOKQumP1ZbrGkgD/AbXrTWnscqQH76GgMvQ7R0G5OTFJyemGAmBt/PkK+QSVWrxWDMVLVz05+MAKpwOxq0SAvARazXu8/TLUpPofn+XDMSf6GUSYDzRDJCQYZ7a0EvB94+VIKYXvlAfv/c1rXVRPhNemI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724885540; c=relaxed/simple;
	bh=4l/+74vOGyqtNgvEECRUDnLwQprClbg6AXJ6IFo5N7A=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpyelMEGxdyCi2UbTdBgrGn9TDgvW3OW3iLkLVkNwfVi4v7dq7SNi0AL23hVB8TGt1lPvY6Wr0Y0+/GPWTqCCtbN6T2ZI0Ygdrf/G3lmJTDwMlffyON3ec80M2Ag/MDRj+ufIgX2i29YrCAhXZ536+j2I9xTVPFgnDd8PV/QThw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1sjRWO-000000000NG-3ZNT;
	Wed, 28 Aug 2024 22:52:12 +0000
Date: Wed, 28 Aug 2024 23:52:09 +0100
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
	Robert Marko <robimarko@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Russell King <rmk+kernel@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/2] net: phy: aquantia: allow forcing order of
 MDI pairs
Message-ID: <e56a9065f50cd90d33da7fe50bf01989adc65d26.1724885333.git.daniel@makrotopia.org>
References: <1cdfd174d3ac541f3968dfe9bd14d5b6b28e4ac6.1724885333.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cdfd174d3ac541f3968dfe9bd14d5b6b28e4ac6.1724885333.git.daniel@makrotopia.org>

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

Introduce two mutually exclusive boolean properties which allow forcing
either normal or reverse order of the MDI pairs from DT.

If none of the two new properties is present, the behavior is unchanged
and MDI pair order configuration is untouched (ie. either the result of
MDI_CFG pin pull-up/pull-down, or pair order override already configured
by the bootloader before Linux is started).

Forcing normal pair order is required on the Adtran SDG-8733A Wi-Fi 7
residential gateway.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: add missing 'static' keyword, improve commit description

 drivers/net/phy/aquantia/aquantia_main.c | 35 ++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index e982e9ce44a59..32fdd203fcf05 100644
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
@@ -474,6 +480,31 @@ static void aqr107_chip_info(struct phy_device *phydev)
 		   fw_major, fw_minor, build_id, prov_id);
 }
 
+static int aqr107_config_mdi(struct phy_device *phydev)
+{
+	struct device_node *np = phydev->mdio.dev.of_node;
+	bool force_normal, force_reverse;
+
+	force_normal = of_property_read_bool(np, "marvell,force-mdi-order-normal");
+	force_reverse = of_property_read_bool(np, "marvell,force-mdi-order-reverse");
+
+	if (force_normal && force_reverse)
+		return -EINVAL;
+
+	if (force_normal)
+		return phy_modify_mmd(phydev, MDIO_MMD_PMAPMD, PMAPMD_RSVD_VEND_PROV,
+				      PMAPMD_RSVD_VEND_PROV_MDI_CONF,
+				      PMAPMD_RSVD_VEND_PROV_MDI_FORCE);
+
+	if (force_reverse)
+		return phy_modify_mmd(phydev, MDIO_MMD_PMAPMD, PMAPMD_RSVD_VEND_PROV,
+				      PMAPMD_RSVD_VEND_PROV_MDI_CONF,
+				      PMAPMD_RSVD_VEND_PROV_MDI_REVERSE |
+				      PMAPMD_RSVD_VEND_PROV_MDI_FORCE);
+
+	return 0;
+}
+
 static int aqr107_config_init(struct phy_device *phydev)
 {
 	struct aqr107_priv *priv = phydev->priv;
@@ -503,6 +534,10 @@ static int aqr107_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	ret = aqr107_config_mdi(phydev);
+	if (ret)
+		return ret;
+
 	/* Restore LED polarity state after reset */
 	for_each_set_bit(led_active_low, &priv->leds_active_low, AQR_MAX_LEDS) {
 		ret = aqr_phy_led_active_low_set(phydev, index, led_active_low);
-- 
2.46.0

