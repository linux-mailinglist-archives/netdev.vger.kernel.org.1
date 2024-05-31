Return-Path: <netdev+bounces-99873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3928D6CE1
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 01:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5BC328711E
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 23:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6A612FB26;
	Fri, 31 May 2024 23:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kM4aBSbe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA0C839E2;
	Fri, 31 May 2024 23:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717198526; cv=none; b=nysY+djdQqN86EEwujI6SVz6y/I9d6bMBxanjT6QfZT2bzrIgD37Dlve0Nl/zYtdKp9AvmdoNgP4q33gyCABaEiq7Lpbz467wkn47P391xLgPo9d6Z9q+DfqiJfSYSuOkUDZgKHT990gVlE21xhfKJDnsaK8rlgc+KjGsqXVJ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717198526; c=relaxed/simple;
	bh=yjMKDi2mlJXGwm4mF/dX3TyydqwW0M56oZq8IfzIOkk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J9j8/RV3JN3yzUI9jBwwdPlWMPevHdaDvoVrndbFds15Qvj8p8/EIOZw7+/U0aboGYLxjSFFHauuJp04nUQ11Y0gi3+M6Qe85BiR67NlyGVdH5vIDiJa4BZnzY0tCB9z3ew8mjvlaDainlY6m3GXXZNpBEjIv1/d6svPSELMSQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kM4aBSbe; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-354cd8da8b9so2341689f8f.0;
        Fri, 31 May 2024 16:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717198522; x=1717803322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tU8+I8hHiW5cb39j4MGgMH/Z3VAo01Hmdc4GAMWx2VM=;
        b=kM4aBSbe5v+gsuYpPYvGQGlvVii/fFyLVS2gWRp0tAzmLQN34TLCwnvZFsUZuR3Gzk
         NtnvY5tm7V0DQN1tX4y5bs4Zokk+ASwfLUX3BmvhnQy/cz4p23isM6sdDxCvR3Rw+Kys
         Djz1Zf4lZMeZLu8Pdn48KpD5tn5X7QmNGwHseqMlmcMxXHUuYmPLHysMH7KocB9/97+n
         r0DaZsSW8AydKezxoZY2N50/kxLDsx2TjDPVpp8RLGKyCh4UOLN8OFS1lolhupKkgU5/
         WnUzFxkZC4S+1AQO3y/EG4cpT5ctGFJIx1UbQHBwsL+GYSA5KOP+DBJ2GKRPB9XY6ofJ
         BCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717198522; x=1717803322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tU8+I8hHiW5cb39j4MGgMH/Z3VAo01Hmdc4GAMWx2VM=;
        b=Y/ja0dVRSupliKsctzncYYy5IlpIu3cPUrSdHrwnBY5UCUU0MuVlGGJKi01DEi2PGD
         3eCGgI498izyQjeolgC4BSKKpQdziqsA6wkPPSyA+x31ZIN6L11ECRu0kS6ZWj+0MBWs
         cANqjMpt7/MqU7NQKopxBJDbTfqS1GYgfnwH6PP2m7i+4kyeztsFUn+B5PdS21QiZR08
         /wff+r0083gq1ab307MjmwXiksTkDsNxsuu0yy9VvhJR9HiLXSrMQn6BmbvI+r79xzlH
         1w9iwZXQMB84tQuBLRniKFGoye/BEXGrGQHElmEfWvYQwi6+giw7ysm9we+riJPK1+7N
         2yZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9Al6G8ngz2DJekkVFF8IP1IJaYUJ6prtRa/rQ5Kp6+ZyzDprJ5kSXwMAU2e8lbt8zPKzv+c3hCy5AintagBzII64vOGBdwA2t5p9JeG/2QnEEZNMi/lYP3Wg5LgmV9YFg3Ud/
X-Gm-Message-State: AOJu0Yyx8XgPYHNOqTcpeJFr+wHxlrXPsNvuY1aNZumPAIGWaiqsN1qG
	l3OYciNyKXha+HYhRn17dNB+EaAHamk1ojGc3/nQ+hmUOMmekqWT
X-Google-Smtp-Source: AGHT+IEgEfl8FBkPjCN1xeBqvp8ttXzSctiyV3QnoUHI0x9gpW7rZM1YUMFQ3LL1XX9kg/JXuaJGvQ==
X-Received: by 2002:a5d:484e:0:b0:355:38e:c391 with SMTP id ffacd0b85a97d-35e0f30ae25mr2516351f8f.51.1717198522209;
        Fri, 31 May 2024 16:35:22 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-35dd04c9d78sm2779599f8f.27.2024.05.31.16.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 16:35:21 -0700 (PDT)
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
Subject: [net-next PATCH v3 2/2] net: phy: aquantia: add support for PHY LEDs
Date: Sat,  1 Jun 2024 01:35:03 +0200
Message-ID: <20240531233505.24903-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240531233505.24903-1-ansuelsmth@gmail.com>
References: <20240531233505.24903-1-ansuelsmth@gmail.com>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
Changes v3:
- Add Reviewed-by tag
- Use AQR_MAX_LEDS for every ops
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
index 000000000000..0516ac02c3f8
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
+	if (index >= AQR_MAX_LEDS)
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


