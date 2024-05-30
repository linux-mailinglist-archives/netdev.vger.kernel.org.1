Return-Path: <netdev+bounces-99603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3ACB8D5759
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 02:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96B4B283B09
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 00:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFF87483;
	Fri, 31 May 2024 00:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9ymvS95"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C77211C;
	Fri, 31 May 2024 00:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717116639; cv=none; b=civgZSMmdxTMHS8jcHs0am0FyKNiVowv9hFLHEYzaCRwROe979fwCXylOR4wZfd2Rp1Zybgif1qwCk2aUictvAiNK8lHFW3YJkoyd0mD9T9dyduzA3n5d5kwdGP+us37vPRojOK7pNtF5EIoximWrqZeCjTPXDyuE+CezvWZx8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717116639; c=relaxed/simple;
	bh=onuwuvENVCtNHWu8XCs4vv6O1mZKno2paCmRnfkN2xQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ruu9SPAzAeRqvl5ge9QYWVQ+75C1bXIf2VVohQKUe4xG4kdAuCrf88sOK2HRy3Z91ird0xbfX6mZOyWOIvZMnC7oA8cEsIPZ1Vm75jCPdv9p2jNXyEDpIRdSZLiFN0UDloSjC3LmtbxGvuFiaIqgMcqlDfZyG906tRxpm+UhySA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9ymvS95; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4202cea9a2fso14783145e9.3;
        Thu, 30 May 2024 17:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717116636; x=1717721436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mCAmW2qrRsxZlUwi0zvsDbZO9ACbl7sZDK6XgFcx6CE=;
        b=e9ymvS95gDbSOXsUnj7kC31bRWyBSD2FDKet4KhUZGYI6rGlQ85GvppQBJuKzFenFT
         nYoJIr3JckpfSUxiMmmrd98lRkKvthrTZteqtSNul47Z1jj+zvmiK+zJzlYm+JI4UbJf
         s2WOEq1KDWK5f3SKxhpa28pq6rtu4Q9mAZBvcqNNQEU2mjeOVwGNkaOK6R13J72dHs3s
         RdEFGvnZ/V3k+XyQKtlJKGzCpvZnPSFkslB0OL2VMGhtspYClTPdTVqsx6JpA5McoBed
         ZRVe8kNGDZ+0TtUjNMMk9tmVqgcBJuysVTTn15Ab5FkoO6blgz97NmdReXJ1cBgn2hyI
         7e1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717116636; x=1717721436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCAmW2qrRsxZlUwi0zvsDbZO9ACbl7sZDK6XgFcx6CE=;
        b=PsPqh0oFFixxRnhdmQPNoZ73RWGKH3ZQcfURiO40X0WLBu+oyr6KCIdAntPlp7FanV
         zxc/0SmREaFJxr7eT6j8p7kKsl/xt6/LBEA0wzWxzomGytGXuRlTFSSFVI6F2Fzs+LDc
         EDDjAhLe1A4+tz9qc9cdB0ZVIivi7t/ZCqNWukyNOhDhNCfqEYmfpzXPyfZbAySXgewI
         046g+4DenBszyQ9anAJyNCUjQYumKrYYxmWJOp7cEq/pjq9kWwM0KwQwtp9B9KHthtVP
         uElg1LLllnu2Pwp+OJCpZ8k30Tl/v4kyk83RV+mNwmMP9AH1iP3w8eQkRniVRvmwbPbO
         r2hg==
X-Forwarded-Encrypted: i=1; AJvYcCWKK3dJUgUhA+Wx+CvU7N+9xmLEV1RiRa1O+N8hgFvMTiU5Nzlr24Nc1D8l90DdqyorItgjN8mjvOP7n0u7kapd0EiIX+fQcKvpN+NmsSgd1XDBqDOFhO2c/B25cH5BGK+cUn1Q
X-Gm-Message-State: AOJu0YwrYuosEeidT4I9arl41VnE9obRTIRYRDInn1zM9kr/vD5FJzmH
	Acg0lFCmP++FIq661ukHev3+j8Rz2zTZcB6RRfuGkS1dgTXgwv3k
X-Google-Smtp-Source: AGHT+IH/5yv8dmxla3/yPc+53hm77sEyKxgYeCvGirIo6LmD1zFBqb0dgPfB6x//Oh72GSKOgh6q2A==
X-Received: by 2002:a05:600c:4314:b0:421:2ddf:aec4 with SMTP id 5b1f17b1804b1-4212e09b9b9mr2593715e9.30.1717116635714;
        Thu, 30 May 2024 17:50:35 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4212279b4c7sm64327125e9.0.2024.05.30.17.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 17:50:35 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robimarko@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	=?UTF-8?q?Pawe=C5=82=20Owoc?= <frut3k7@gmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [net-next PATCH v2 2/2] net: phy: aquantia: add support for PHY LEDs
Date: Thu, 30 May 2024 23:20:31 +0200
Message-ID: <20240530212043.9006-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240530212043.9006-1-ansuelsmth@gmail.com>
References: <20240530212043.9006-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Golle <daniel@makrotopia.org>

Aquantia Ethernet PHYs got 3 LED output pins which are typically used
to indicate link status and activity.
Add a minimal LED controller driver supporting the most common uses
with the 'netdev' trigger as well as software-driven forced control of
the LEDs.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
[ rework indentation, fix checkpatch error and improve some functions ]
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v2:
- Out of RFC

 drivers/net/phy/aquantia/Makefile        |   2 +-
 drivers/net/phy/aquantia/aquantia.h      |  40 ++++++
 drivers/net/phy/aquantia/aquantia_leds.c | 150 +++++++++++++++++++++++
 drivers/net/phy/aquantia/aquantia_main.c |  63 +++++++++-
 4 files changed, 252 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/phy/aquantia/aquantia_leds.c

diff --git a/drivers/net/phy/aquantia/Makefile b/drivers/net/phy/aquantia/Makefile
index aa77fb63c8ec..c6c4d494ee2a 100644
--- a/drivers/net/phy/aquantia/Makefile
+++ b/drivers/net/phy/aquantia/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-aquantia-objs			+= aquantia_main.o aquantia_firmware.o
+aquantia-objs			+= aquantia_main.o aquantia_firmware.o aquantia_leds.o
 ifdef CONFIG_HWMON
 aquantia-objs			+= aquantia_hwmon.o
 endif
diff --git a/drivers/net/phy/aquantia/aquantia.h b/drivers/net/phy/aquantia/aquantia.h
index c79b33d95628..c0e1fd9d7152 100644
--- a/drivers/net/phy/aquantia/aquantia.h
+++ b/drivers/net/phy/aquantia/aquantia.h
@@ -63,6 +63,28 @@
 #define VEND1_GLOBAL_CONTROL2_UP_RUN_STALL_OVD	BIT(6)
 #define VEND1_GLOBAL_CONTROL2_UP_RUN_STALL	BIT(0)
 
+#define VEND1_GLOBAL_LED_PROV			0xc430
+#define AQR_LED_PROV(x)				(VEND1_GLOBAL_LED_PROV + (x))
+#define VEND1_GLOBAL_LED_PROV_LINK2500		BIT(14)
+#define VEND1_GLOBAL_LED_PROV_LINK5000		BIT(15)
+#define VEND1_GLOBAL_LED_PROV_FORCE_ON		BIT(8)
+#define VEND1_GLOBAL_LED_PROV_LINK10000		BIT(7)
+#define VEND1_GLOBAL_LED_PROV_LINK1000		BIT(6)
+#define VEND1_GLOBAL_LED_PROV_LINK100		BIT(5)
+#define VEND1_GLOBAL_LED_PROV_RX_ACT		BIT(3)
+#define VEND1_GLOBAL_LED_PROV_TX_ACT		BIT(2)
+#define VEND1_GLOBAL_LED_PROV_ACT_STRETCH	GENMASK(0, 1)
+
+#define VEND1_GLOBAL_LED_PROV_LINK_MASK		(VEND1_GLOBAL_LED_PROV_LINK100 | \
+						 VEND1_GLOBAL_LED_PROV_LINK1000 | \
+						 VEND1_GLOBAL_LED_PROV_LINK10000 | \
+						 VEND1_GLOBAL_LED_PROV_LINK5000 | \
+						 VEND1_GLOBAL_LED_PROV_LINK2500)
+
+#define VEND1_GLOBAL_LED_DRIVE			0xc438
+#define VEND1_GLOBAL_LED_DRIVE_VDD		BIT(1)
+#define AQR_LED_DRIVE(x)			(VEND1_GLOBAL_LED_DRIVE + (x))
+
 #define VEND1_THERMAL_PROV_HIGH_TEMP_FAIL	0xc421
 #define VEND1_THERMAL_PROV_LOW_TEMP_FAIL	0xc422
 #define VEND1_THERMAL_PROV_HIGH_TEMP_WARN	0xc423
@@ -125,6 +147,8 @@
 #define VEND1_GLOBAL_INT_VEND_MASK_GLOBAL2	BIT(1)
 #define VEND1_GLOBAL_INT_VEND_MASK_GLOBAL3	BIT(0)
 
+#define AQR_MAX_LEDS				3
+
 struct aqr107_hw_stat {
 	const char *name;
 	int reg;
@@ -149,6 +173,7 @@ static const struct aqr107_hw_stat aqr107_hw_stats[] = {
 
 struct aqr107_priv {
 	u64 sgmii_stats[AQR107_SGMII_STAT_SZ];
+	unsigned long leds_active_low;
 };
 
 #if IS_REACHABLE(CONFIG_HWMON)
@@ -158,3 +183,18 @@ static inline int aqr_hwmon_probe(struct phy_device *phydev) { return 0; }
 #endif
 
 int aqr_firmware_load(struct phy_device *phydev);
+
+int aqr_phy_led_blink_set(struct phy_device *phydev, u8 index,
+			  unsigned long *delay_on,
+			  unsigned long *delay_off);
+int aqr_phy_led_brightness_set(struct phy_device *phydev,
+			       u8 index, enum led_brightness value);
+int aqr_phy_led_hw_is_supported(struct phy_device *phydev, u8 index,
+				unsigned long rules);
+int aqr_phy_led_hw_control_get(struct phy_device *phydev, u8 index,
+			       unsigned long *rules);
+int aqr_phy_led_hw_control_set(struct phy_device *phydev, u8 index,
+			       unsigned long rules);
+int aqr_phy_led_active_low_set(struct phy_device *phydev, int index, bool enable);
+int aqr_phy_led_polarity_set(struct phy_device *phydev, int index,
+			     unsigned long modes);
diff --git a/drivers/net/phy/aquantia/aquantia_leds.c b/drivers/net/phy/aquantia/aquantia_leds.c
new file mode 100644
index 000000000000..47bcc6d70945
--- /dev/null
+++ b/drivers/net/phy/aquantia/aquantia_leds.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+/* LED driver for Aquantia PHY
+ *
+ * Author: Daniel Golle <daniel@makrotopia.org>
+ */
+
+#include <linux/phy.h>
+
+#include "aquantia.h"
+
+int aqr_phy_led_brightness_set(struct phy_device *phydev,
+			       u8 index, enum led_brightness value)
+{
+	if (index > 2)
+		return -EINVAL;
+
+	return phy_modify_mmd(phydev, MDIO_MMD_VEND1, AQR_LED_PROV(index),
+			      VEND1_GLOBAL_LED_PROV_LINK_MASK |
+			      VEND1_GLOBAL_LED_PROV_FORCE_ON |
+			      VEND1_GLOBAL_LED_PROV_RX_ACT |
+			      VEND1_GLOBAL_LED_PROV_TX_ACT,
+			      value ? VEND1_GLOBAL_LED_PROV_FORCE_ON : 0);
+}
+
+static const unsigned long supported_triggers = (BIT(TRIGGER_NETDEV_LINK) |
+						 BIT(TRIGGER_NETDEV_LINK_100) |
+						 BIT(TRIGGER_NETDEV_LINK_1000) |
+						 BIT(TRIGGER_NETDEV_LINK_2500) |
+						 BIT(TRIGGER_NETDEV_LINK_5000) |
+						 BIT(TRIGGER_NETDEV_LINK_10000)  |
+						 BIT(TRIGGER_NETDEV_RX) |
+						 BIT(TRIGGER_NETDEV_TX));
+
+int aqr_phy_led_hw_is_supported(struct phy_device *phydev, u8 index,
+				unsigned long rules)
+{
+	if (index >= AQR_MAX_LEDS)
+		return -EINVAL;
+
+	/* All combinations of the supported triggers are allowed */
+	if (rules & ~supported_triggers)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+int aqr_phy_led_hw_control_get(struct phy_device *phydev, u8 index,
+			       unsigned long *rules)
+{
+	int val;
+
+	if (index >= AQR_MAX_LEDS)
+		return -EINVAL;
+
+	val = phy_read_mmd(phydev, MDIO_MMD_VEND1, AQR_LED_PROV(index));
+	if (val < 0)
+		return val;
+
+	*rules = 0;
+	if (val & VEND1_GLOBAL_LED_PROV_LINK100)
+		*rules |= BIT(TRIGGER_NETDEV_LINK_100);
+
+	if (val & VEND1_GLOBAL_LED_PROV_LINK1000)
+		*rules |= BIT(TRIGGER_NETDEV_LINK_1000);
+
+	if (val & VEND1_GLOBAL_LED_PROV_LINK2500)
+		*rules |= BIT(TRIGGER_NETDEV_LINK_2500);
+
+	if (val & VEND1_GLOBAL_LED_PROV_LINK5000)
+		*rules |= BIT(TRIGGER_NETDEV_LINK_5000);
+
+	if (val & VEND1_GLOBAL_LED_PROV_LINK10000)
+		*rules |= BIT(TRIGGER_NETDEV_LINK_10000);
+
+	if (val & VEND1_GLOBAL_LED_PROV_RX_ACT)
+		*rules |= BIT(TRIGGER_NETDEV_RX);
+
+	if (val & VEND1_GLOBAL_LED_PROV_TX_ACT)
+		*rules |= BIT(TRIGGER_NETDEV_TX);
+
+	return 0;
+}
+
+int aqr_phy_led_hw_control_set(struct phy_device *phydev, u8 index,
+			       unsigned long rules)
+{
+	u16 val = 0;
+
+	if (index >= AQR_MAX_LEDS)
+		return -EINVAL;
+
+	if (rules & (BIT(TRIGGER_NETDEV_LINK_100) | BIT(TRIGGER_NETDEV_LINK)))
+		val |= VEND1_GLOBAL_LED_PROV_LINK100;
+
+	if (rules & (BIT(TRIGGER_NETDEV_LINK_1000) | BIT(TRIGGER_NETDEV_LINK)))
+		val |= VEND1_GLOBAL_LED_PROV_LINK1000;
+
+	if (rules & (BIT(TRIGGER_NETDEV_LINK_2500) | BIT(TRIGGER_NETDEV_LINK)))
+		val |= VEND1_GLOBAL_LED_PROV_LINK2500;
+
+	if (rules & (BIT(TRIGGER_NETDEV_LINK_5000) | BIT(TRIGGER_NETDEV_LINK)))
+		val |= VEND1_GLOBAL_LED_PROV_LINK5000;
+
+	if (rules & (BIT(TRIGGER_NETDEV_LINK_10000) | BIT(TRIGGER_NETDEV_LINK)))
+		val |= VEND1_GLOBAL_LED_PROV_LINK10000;
+
+	if (rules & BIT(TRIGGER_NETDEV_RX))
+		val |= VEND1_GLOBAL_LED_PROV_RX_ACT;
+
+	if (rules & BIT(TRIGGER_NETDEV_TX))
+		val |= VEND1_GLOBAL_LED_PROV_TX_ACT;
+
+	return phy_modify_mmd(phydev, MDIO_MMD_VEND1, AQR_LED_PROV(index),
+			      VEND1_GLOBAL_LED_PROV_LINK_MASK |
+			      VEND1_GLOBAL_LED_PROV_FORCE_ON |
+			      VEND1_GLOBAL_LED_PROV_RX_ACT |
+			      VEND1_GLOBAL_LED_PROV_TX_ACT, val);
+}
+
+int aqr_phy_led_active_low_set(struct phy_device *phydev, int index, bool enable)
+{
+	return phy_modify_mmd(phydev, MDIO_MMD_VEND1, AQR_LED_DRIVE(index),
+			      VEND1_GLOBAL_LED_DRIVE_VDD, enable);
+}
+
+int aqr_phy_led_polarity_set(struct phy_device *phydev, int index, unsigned long modes)
+{
+	struct aqr107_priv *priv = phydev->priv;
+	bool active_low = false;
+	u32 mode;
+
+	if (index >= AQR_MAX_LEDS)
+		return -EINVAL;
+
+	for_each_set_bit(mode, &modes, __PHY_LED_MODES_NUM) {
+		switch (mode) {
+		case PHY_LED_ACTIVE_LOW:
+			active_low = true;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	/* Save LED driver vdd state to restore on SW reset */
+	if (active_low)
+		priv->leds_active_low |= BIT(index);
+
+	return aqr_phy_led_active_low_set(phydev, index, active_low);
+}
diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 252123d12efb..6c14355744b7 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -475,7 +475,9 @@ static void aqr107_chip_info(struct phy_device *phydev)
 
 static int aqr107_config_init(struct phy_device *phydev)
 {
-	int ret;
+	struct aqr107_priv *priv = phydev->priv;
+	u32 led_active_low;
+	int ret, index = 0;
 
 	/* Check that the PHY interface type is compatible */
 	if (phydev->interface != PHY_INTERFACE_MODE_SGMII &&
@@ -496,7 +498,19 @@ static int aqr107_config_init(struct phy_device *phydev)
 	if (!ret)
 		aqr107_chip_info(phydev);
 
-	return aqr107_set_downshift(phydev, MDIO_AN_VEND_PROV_DOWNSHIFT_DFLT);
+	ret = aqr107_set_downshift(phydev, MDIO_AN_VEND_PROV_DOWNSHIFT_DFLT);
+	if (ret)
+		return ret;
+
+	/* Restore LED polarity state after reset */
+	for_each_set_bit(led_active_low, &priv->leds_active_low, AQR_MAX_LEDS) {
+		ret = aqr_phy_led_active_low_set(phydev, index, led_active_low);
+		if (ret)
+			return ret;
+		index++;
+	}
+
+	return 0;
 }
 
 static int aqcs109_config_init(struct phy_device *phydev)
@@ -786,6 +800,11 @@ static struct phy_driver aqr_driver[] = {
 	.get_strings	= aqr107_get_strings,
 	.get_stats	= aqr107_get_stats,
 	.link_change_notify = aqr107_link_change_notify,
+	.led_brightness_set = aqr_phy_led_brightness_set,
+	.led_hw_is_supported = aqr_phy_led_hw_is_supported,
+	.led_hw_control_set = aqr_phy_led_hw_control_set,
+	.led_hw_control_get = aqr_phy_led_hw_control_get,
+	.led_polarity_set = aqr_phy_led_polarity_set,
 },
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQCS109),
@@ -805,6 +824,11 @@ static struct phy_driver aqr_driver[] = {
 	.get_strings	= aqr107_get_strings,
 	.get_stats	= aqr107_get_stats,
 	.link_change_notify = aqr107_link_change_notify,
+	.led_brightness_set = aqr_phy_led_brightness_set,
+	.led_hw_is_supported = aqr_phy_led_hw_is_supported,
+	.led_hw_control_set = aqr_phy_led_hw_control_set,
+	.led_hw_control_get = aqr_phy_led_hw_control_get,
+	.led_polarity_set = aqr_phy_led_polarity_set,
 },
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR111),
@@ -824,6 +848,11 @@ static struct phy_driver aqr_driver[] = {
 	.get_strings	= aqr107_get_strings,
 	.get_stats	= aqr107_get_stats,
 	.link_change_notify = aqr107_link_change_notify,
+	.led_brightness_set = aqr_phy_led_brightness_set,
+	.led_hw_is_supported = aqr_phy_led_hw_is_supported,
+	.led_hw_control_set = aqr_phy_led_hw_control_set,
+	.led_hw_control_get = aqr_phy_led_hw_control_get,
+	.led_polarity_set = aqr_phy_led_polarity_set,
 },
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR111B0),
@@ -843,6 +872,11 @@ static struct phy_driver aqr_driver[] = {
 	.get_strings	= aqr107_get_strings,
 	.get_stats	= aqr107_get_stats,
 	.link_change_notify = aqr107_link_change_notify,
+	.led_brightness_set = aqr_phy_led_brightness_set,
+	.led_hw_is_supported = aqr_phy_led_hw_is_supported,
+	.led_hw_control_set = aqr_phy_led_hw_control_set,
+	.led_hw_control_get = aqr_phy_led_hw_control_get,
+	.led_polarity_set = aqr_phy_led_polarity_set,
 },
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR405),
@@ -869,6 +903,11 @@ static struct phy_driver aqr_driver[] = {
 	.get_strings	= aqr107_get_strings,
 	.get_stats	= aqr107_get_stats,
 	.link_change_notify = aqr107_link_change_notify,
+	.led_brightness_set = aqr_phy_led_brightness_set,
+	.led_hw_is_supported = aqr_phy_led_hw_is_supported,
+	.led_hw_control_set = aqr_phy_led_hw_control_set,
+	.led_hw_control_get = aqr_phy_led_hw_control_get,
+	.led_polarity_set = aqr_phy_led_polarity_set,
 },
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR412),
@@ -906,6 +945,11 @@ static struct phy_driver aqr_driver[] = {
 	.get_strings    = aqr107_get_strings,
 	.get_stats      = aqr107_get_stats,
 	.link_change_notify = aqr107_link_change_notify,
+	.led_brightness_set = aqr_phy_led_brightness_set,
+	.led_hw_is_supported = aqr_phy_led_hw_is_supported,
+	.led_hw_control_set = aqr_phy_led_hw_control_set,
+	.led_hw_control_get = aqr_phy_led_hw_control_get,
+	.led_polarity_set = aqr_phy_led_polarity_set,
 },
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR113C),
@@ -925,6 +969,11 @@ static struct phy_driver aqr_driver[] = {
 	.get_strings    = aqr107_get_strings,
 	.get_stats      = aqr107_get_stats,
 	.link_change_notify = aqr107_link_change_notify,
+	.led_brightness_set = aqr_phy_led_brightness_set,
+	.led_hw_is_supported = aqr_phy_led_hw_is_supported,
+	.led_hw_control_set = aqr_phy_led_hw_control_set,
+	.led_hw_control_get = aqr_phy_led_hw_control_get,
+	.led_polarity_set = aqr_phy_led_polarity_set,
 },
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR114C),
@@ -944,6 +993,11 @@ static struct phy_driver aqr_driver[] = {
 	.get_strings    = aqr107_get_strings,
 	.get_stats      = aqr107_get_stats,
 	.link_change_notify = aqr107_link_change_notify,
+	.led_brightness_set = aqr_phy_led_brightness_set,
+	.led_hw_is_supported = aqr_phy_led_hw_is_supported,
+	.led_hw_control_set = aqr_phy_led_hw_control_set,
+	.led_hw_control_get = aqr_phy_led_hw_control_get,
+	.led_polarity_set = aqr_phy_led_polarity_set,
 },
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR813),
@@ -963,6 +1017,11 @@ static struct phy_driver aqr_driver[] = {
 	.get_strings	= aqr107_get_strings,
 	.get_stats	= aqr107_get_stats,
 	.link_change_notify = aqr107_link_change_notify,
+	.led_brightness_set = aqr_phy_led_brightness_set,
+	.led_hw_is_supported = aqr_phy_led_hw_is_supported,
+	.led_hw_control_set = aqr_phy_led_hw_control_set,
+	.led_hw_control_get = aqr_phy_led_hw_control_get,
+	.led_polarity_set = aqr_phy_led_polarity_set,
 },
 };
 
-- 
2.43.0


