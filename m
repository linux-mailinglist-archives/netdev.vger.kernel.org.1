Return-Path: <netdev+bounces-120559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1715B959C4C
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 14:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7D1F1F22392
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 12:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8771917C7;
	Wed, 21 Aug 2024 12:47:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BD4185E6E;
	Wed, 21 Aug 2024 12:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244422; cv=none; b=Pc5Y0OLAQcza18j/Y1fV4hKdTi5YH7jKZDgbmFfy0xoNRAAwJz3MUVMWPxOt2GY7KP/qLgYtIObosLxQawihn29B2kTAk0CL4xPHpdLOe10DBQ8cR/PcZuw5CqjkFR0UavFhE0yLMNFHZ6ZPJgQRL8Wc6Efk4Co+HW5VDl+ojVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244422; c=relaxed/simple;
	bh=8lB0f/AIws6nqX8d2Tf4G6sbvMI/o8S5byYYDUqtML4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0cxIboXaAOdlHAzNgPMBFHAI2bAwcWSS9ILxDk8BNtPdzk8IyuY056Mih6L1RoFVol5Pw45+M6SmoAvZuNHRS1UQBWjmet8BJt4ocMOd11fqy+2aYyFUu2wQyBAE11Y8CUAfcriYNk4C83Kq1RC7pLs/TK2ZYsFOuWnjhUtL5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1sgkjl-000000003Wh-47Ay;
	Wed, 21 Aug 2024 12:46:54 +0000
Date: Wed, 21 Aug 2024 13:46:50 +0100
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
	Russell King <rmk+kernel@armlinux.org.uk>,
	Chad Monroe <chad.monroe@adtran.com>,
	John Crispin <john@phrozen.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] net: phy: aquantia: allow forcing order of MDI
 pairs
Message-ID: <ed46220cc4c52d630fc481c8148fc749242c368d.1724244281.git.daniel@makrotopia.org>
References: <5173302f9f1a52d7487e1fb54966673c448d6928.1724244281.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5173302f9f1a52d7487e1fb54966673c448d6928.1724244281.git.daniel@makrotopia.org>

Normally, the MDI reversal configuration is taken from the MDI_CFG pin.
However, some hardware designs require overriding the value configured
by that bootstrap pin. The PHY allows doing that by setting a bit which
allows ignoring the state of the MDI_CFG pin and configuring whether
the order of MDI pairs should be normal (ABCD) or reverse (DCBA).

Introduce two boolean properties which allow forcing either normal or
reverse order of the MDI pairs from DT.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/aquantia/aquantia_main.c | 35 ++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index e982e9ce44a59..33a6eb55d99d4 100644
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
 
+int aqr107_config_mdi(struct phy_device *phydev)
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

