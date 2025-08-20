Return-Path: <netdev+bounces-215245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAF3B2DC25
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 14:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07478726386
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 12:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36892E7179;
	Wed, 20 Aug 2025 12:11:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EF5254B09;
	Wed, 20 Aug 2025 12:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755691893; cv=none; b=nqAbPrfdoVyxR9wBV8TnpElkE3+fhbyJdvYvsJvrnXx9FhTqpdoXWbzULflQ95zAE9PDwmupg1xZcoClYO6oKDpeUlqYBvQhV55d3ixY5uP4na08yA+CXc6U2+q+nU2oLoidvEHHD1/vbQUu3waTC9Uu4g8LenDW+NRp2FD3f2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755691893; c=relaxed/simple;
	bh=NyH0GZuEbHC8l+Dh828rlG5rXAsq+P5yRXv6rhlnOKQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kQFak6sZPuHUls2nXp52y6ZhqwRtMAuBeG5MVU+TQ0mrtbG7ec7ZcNlXePPpx6MN1U3xNJzDyfEer7ApHFjkleMWIRNx86WFjC2cZAsZuRhfPEM++Ed6u6cejSfrT4BYVDGX4wAOtK4zB0wAv3cCD8hDTEiw+mpoocF0BcL615o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uohez-0000000009m-3Bxn;
	Wed, 20 Aug 2025 12:11:21 +0000
Date: Wed, 20 Aug 2025 13:11:12 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Xu Liang <lxu@maxlinear.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 1/3] net: phy: mxl-86110: add basic support for
 led_brightness_set op
Message-ID: <a63f1487c3d36fc150fa3a920cd3ab19feb9b9f9.1755691622.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add support for forcing each connected LED to be always on or always off
by implementing the led_brightness_set() op.
This is done by modifying the COM_EXT_LED_GEN_CFG register to enable
force-mode and forcing the LED either on or off.
When calling the led_hw_control_set() force-mode is again disabled for
that LED.
Implement mxl86110_modify_extended_reg() locked helper instead of
manually acquiring and releasing the MDIO bus lock for single
__mxl86110_modify_extended_reg() calls.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v3: no changes
v2: introduce mxl86110_modify_extended_reg() helper

 drivers/net/phy/mxl-86110.c | 68 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/mxl-86110.c b/drivers/net/phy/mxl-86110.c
index ff2a3a22bd5b..31832018655f 100644
--- a/drivers/net/phy/mxl-86110.c
+++ b/drivers/net/phy/mxl-86110.c
@@ -71,6 +71,13 @@
 
 #define MXL86110_MAX_LEDS	3
 /* LED registers and defines */
+#define MXL86110_COM_EXT_LED_GEN_CFG			0xA00B
+# define MXL86110_COM_EXT_LED_GEN_CFG_LFE(x)		BIT(2 + 3 * (x))
+# define MXL86110_COM_EXT_LED_GEN_CFG_LFM(x)		({ typeof(x) _x = (x); \
+							  GENMASK(1 + (3 * (_x)), \
+								 3 * (_x)); })
+#  define MXL86110_COM_EXT_LED_GEN_CFG_LFME(x)		BIT(3 * (x))
+
 #define MXL86110_LED0_CFG_REG 0xA00C
 #define MXL86110_LED1_CFG_REG 0xA00D
 #define MXL86110_LED2_CFG_REG 0xA00E
@@ -235,6 +242,29 @@ static int mxl86110_read_extended_reg(struct phy_device *phydev, u16 regnum)
 	return ret;
 }
 
+/**
+ * mxl86110_modify_extended_reg() - modify bits of a PHY's extended register
+ * @phydev: pointer to the PHY device structure
+ * @regnum: register number to write
+ * @mask: bit mask of bits to clear
+ * @set: bit mask of bits to set
+ *
+ * Note: register value = (old register value & ~mask) | set.
+ *
+ * Return: 0 or negative error code
+ */
+static int mxl86110_modify_extended_reg(struct phy_device *phydev,
+					u16 regnum, u16 mask, u16 set)
+{
+	int ret;
+
+	phy_lock_mdio_bus(phydev);
+	ret = __mxl86110_modify_extended_reg(phydev, regnum, mask, set);
+	phy_unlock_mdio_bus(phydev);
+
+	return ret;
+}
+
 /**
  * mxl86110_get_wol() - report if wake-on-lan is enabled
  * @phydev: pointer to the phy_device
@@ -394,6 +424,7 @@ static int mxl86110_led_hw_control_set(struct phy_device *phydev, u8 index,
 				       unsigned long rules)
 {
 	u16 val = 0;
+	int ret;
 
 	if (index >= MXL86110_MAX_LEDS)
 		return -EINVAL;
@@ -423,8 +454,42 @@ static int mxl86110_led_hw_control_set(struct phy_device *phydev, u8 index,
 	    rules & BIT(TRIGGER_NETDEV_RX))
 		val |= MXL86110_LEDX_CFG_BLINK;
 
-	return mxl86110_write_extended_reg(phydev,
+	ret = mxl86110_write_extended_reg(phydev,
 					  MXL86110_LED0_CFG_REG + index, val);
+	if (ret)
+		return ret;
+
+	ret = mxl86110_modify_extended_reg(phydev,
+					   MXL86110_COM_EXT_LED_GEN_CFG,
+					   MXL86110_COM_EXT_LED_GEN_CFG_LFE(index),
+					   0);
+
+	return ret;
+}
+
+static int mxl86110_led_brightness_set(struct phy_device *phydev,
+				       u8 index, enum led_brightness value)
+{
+	u16 mask, set;
+	int ret;
+
+	if (index >= MXL86110_MAX_LEDS)
+		return -EINVAL;
+
+	/* force manual control */
+	set = MXL86110_COM_EXT_LED_GEN_CFG_LFE(index);
+	/* clear previous force mode */
+	mask = MXL86110_COM_EXT_LED_GEN_CFG_LFM(index);
+
+	/* force LED to be permanently on */
+	if (value != LED_OFF)
+		set |= MXL86110_COM_EXT_LED_GEN_CFG_LFME(index);
+
+	ret = mxl86110_modify_extended_reg(phydev,
+					   MXL86110_COM_EXT_LED_GEN_CFG,
+					   mask, set);
+
+	return ret;
 }
 
 /**
@@ -596,6 +661,7 @@ static struct phy_driver mxl_phy_drvs[] = {
 		.config_init		= mxl86110_config_init,
 		.get_wol		= mxl86110_get_wol,
 		.set_wol		= mxl86110_set_wol,
+		.led_brightness_set	= mxl86110_led_brightness_set,
 		.led_hw_is_supported	= mxl86110_led_hw_is_supported,
 		.led_hw_control_get     = mxl86110_led_hw_control_get,
 		.led_hw_control_set     = mxl86110_led_hw_control_set,
-- 
2.50.1

