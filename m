Return-Path: <netdev+bounces-216114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3679B32193
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 19:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 498271BA8521
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 17:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CC531283D;
	Fri, 22 Aug 2025 17:38:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27289313532;
	Fri, 22 Aug 2025 17:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755884322; cv=none; b=HyL5nz2sCKQwi76rk2ap65mmYieksD8c+LL5rEvdz4+iZtRneFhgTkP9HR0o99JQxGAwSgfaHt1bb4t4S8gJQhzPAxgFyym2aZZSBogIks6wDFYVSaxXhflOBrw3Ao7nHVEI7tKNrmOH7gBCQxvGAADEhWcs5GEVDZ8nYpU3KBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755884322; c=relaxed/simple;
	bh=YxJznOfzoDDtGzKL/zjx4TwDlOBV9PI+N1TcX3Cqffk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CFv4qoWtwaLNOFXK5uL79aOxDY33D28qUYTHwOqyi2cAxiGmYGwxs0rTcl1ldQlqWcp2LglAkdds5Pn4uZoIaOlqdzc04T7K2YX7hXf/QTAEFAZCnYfmsksf1J4wQDxJ0DFRDCJKKv3i3/EvKqTSQc4F4fFSIxKy2nSmn2MeN4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1upVig-0000000077W-38uw;
	Fri, 22 Aug 2025 17:38:30 +0000
Date: Fri, 22 Aug 2025 18:38:27 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Xu Liang <lxu@maxlinear.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] net: phy: mxl-86110: add basic support for
 led_brightness_set op
Message-ID: <58eeefc8c24e06cd2110d3cefbd4236b1a4f44a2.1755884175.git.daniel@makrotopia.org>
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
v4: make register macros more readable
v3: no changes
v2: introduce mxl86110_modify_extended_reg() helper

 drivers/net/phy/mxl-86110.c | 67 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/mxl-86110.c b/drivers/net/phy/mxl-86110.c
index ff2a3a22bd5b..9ef2a8d7f514 100644
--- a/drivers/net/phy/mxl-86110.c
+++ b/drivers/net/phy/mxl-86110.c
@@ -71,6 +71,11 @@
 
 #define MXL86110_MAX_LEDS	3
 /* LED registers and defines */
+#define MXL86110_COM_EXT_LED_GEN_CFG			0xA00B
+# define MXL86110_COM_EXT_LED_GEN_CFG_LFM(x)		((BIT(0) | BIT(1)) << (3 * (x)))
+#  define MXL86110_COM_EXT_LED_GEN_CFG_LFME(x)		(BIT(0) << (3 * (x)))
+# define MXL86110_COM_EXT_LED_GEN_CFG_LFE(x)		(BIT(2) << (3 * (x)))
+
 #define MXL86110_LED0_CFG_REG 0xA00C
 #define MXL86110_LED1_CFG_REG 0xA00D
 #define MXL86110_LED2_CFG_REG 0xA00E
@@ -235,6 +240,29 @@ static int mxl86110_read_extended_reg(struct phy_device *phydev, u16 regnum)
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
@@ -394,6 +422,7 @@ static int mxl86110_led_hw_control_set(struct phy_device *phydev, u8 index,
 				       unsigned long rules)
 {
 	u16 val = 0;
+	int ret;
 
 	if (index >= MXL86110_MAX_LEDS)
 		return -EINVAL;
@@ -423,8 +452,43 @@ static int mxl86110_led_hw_control_set(struct phy_device *phydev, u8 index,
 	    rules & BIT(TRIGGER_NETDEV_RX))
 		val |= MXL86110_LEDX_CFG_BLINK;
 
-	return mxl86110_write_extended_reg(phydev,
+	ret = mxl86110_write_extended_reg(phydev,
 					  MXL86110_LED0_CFG_REG + index, val);
+	if (ret)
+		return ret;
+
+	/* clear manual control bit */
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
@@ -596,6 +660,7 @@ static struct phy_driver mxl_phy_drvs[] = {
 		.config_init		= mxl86110_config_init,
 		.get_wol		= mxl86110_get_wol,
 		.set_wol		= mxl86110_set_wol,
+		.led_brightness_set	= mxl86110_led_brightness_set,
 		.led_hw_is_supported	= mxl86110_led_hw_is_supported,
 		.led_hw_control_get     = mxl86110_led_hw_control_get,
 		.led_hw_control_set     = mxl86110_led_hw_control_set,
-- 
2.50.1

