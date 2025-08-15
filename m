Return-Path: <netdev+bounces-214091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA100B283D6
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 18:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FAC01CE676E
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 16:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408AF2D060A;
	Fri, 15 Aug 2025 16:33:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB3918A6A7;
	Fri, 15 Aug 2025 16:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755275626; cv=none; b=fSuv/ZJQ79YDKq3tssl5Xtm0QpjnCZsG1X2XlnloRLlKTX+ZOA5UiLnmMGACy/Tx/rdcuRKuNDE6zlEdx4NnmB4eNSliXSUiJRkAysaMVwqZxH1WuSDugdt9jhryfXa8UvoQYdIvCPGpdwJutM76cp8Ax4M8vOCL9r6wIiPCwvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755275626; c=relaxed/simple;
	bh=cttYmNpvGa2vfZwJG+RBwBiD7fskirXU5EhHWmKa6wo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KcQ+alz2R0WSDs5OUwZNBfigStuWQi5oVDmRSvTRt7ttdkJ77faymK9BGNVOKWXFN38yf3JtF4iOOi+3TJMM9UPtKabcr79dBkvOnDy5D52VZmperr0y+WECxba3+Rj9ZRP+5ZMagZfvzxFQEddkAiRXVs4puCYOKiIZTcgz4Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1umxMu-000000002dj-31es;
	Fri, 15 Aug 2025 16:33:28 +0000
Date: Fri, 15 Aug 2025 17:33:22 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Xu Liang <lxu@maxlinear.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] net: phy: mxl-86110: add basic support for
 led_brightness_set op
Message-ID: <aJ9hUhVfzyvJK8Rt@pidgin.makrotopia.org>
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
The PHY also supports adjusting the brightness PWM level using a global
value affecting all LEDs connected to that PHY. This is not yet supported.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/mxl-86110.c | 53 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/mxl-86110.c b/drivers/net/phy/mxl-86110.c
index ff2a3a22bd5b..60c69c445e80 100644
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
@@ -394,6 +401,7 @@ static int mxl86110_led_hw_control_set(struct phy_device *phydev, u8 index,
 				       unsigned long rules)
 {
 	u16 val = 0;
+	int ret;
 
 	if (index >= MXL86110_MAX_LEDS)
 		return -EINVAL;
@@ -423,8 +431,50 @@ static int mxl86110_led_hw_control_set(struct phy_device *phydev, u8 index,
 	    rules & BIT(TRIGGER_NETDEV_RX))
 		val |= MXL86110_LEDX_CFG_BLINK;
 
-	return mxl86110_write_extended_reg(phydev,
+	ret = mxl86110_write_extended_reg(phydev,
 					  MXL86110_LED0_CFG_REG + index, val);
+	if (ret)
+		return ret;
+
+	phy_lock_mdio_bus(phydev);
+
+	ret =  __mxl86110_modify_extended_reg(phydev,
+					      MXL86110_COM_EXT_LED_GEN_CFG,
+					      MXL86110_COM_EXT_LED_GEN_CFG_LFE(index),
+					      0);
+
+	phy_unlock_mdio_bus(phydev);
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
+	phy_lock_mdio_bus(phydev);
+
+	ret = __mxl86110_modify_extended_reg(phydev,
+					     MXL86110_COM_EXT_LED_GEN_CFG,
+					     mask, set);
+
+	phy_unlock_mdio_bus(phydev);
+
+	return ret;
 }
 
 /**
@@ -596,6 +646,7 @@ static struct phy_driver mxl_phy_drvs[] = {
 		.config_init		= mxl86110_config_init,
 		.get_wol		= mxl86110_get_wol,
 		.set_wol		= mxl86110_set_wol,
+		.led_brightness_set	= mxl86110_led_brightness_set,
 		.led_hw_is_supported	= mxl86110_led_hw_is_supported,
 		.led_hw_control_get     = mxl86110_led_hw_control_get,
 		.led_hw_control_set     = mxl86110_led_hw_control_set,
-- 
2.50.1


