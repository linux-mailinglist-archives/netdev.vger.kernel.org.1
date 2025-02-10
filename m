Return-Path: <netdev+bounces-164589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC23A2E634
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 09:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39AA43AA01E
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 08:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FCC1BD9E6;
	Mon, 10 Feb 2025 08:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZS524Df"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E186C8F49;
	Mon, 10 Feb 2025 08:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739175541; cv=none; b=trPPzWO16lk+r2je1HSHO7KgzM/NlM5jS2VvVyzs8zqm5x41XQBWtv9wb2rwgphQ7msyaKRhkB4Zq+yAOiLH/ZyYCeKt2LQ2EbENQ6Il6oakqVUpHItx2aQqeQN6WSuhbdRibJexmUbMY0Rg6+wkZGDuNdearrDkyn/ABFCzh+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739175541; c=relaxed/simple;
	bh=2zKlO57BI/hqDmk2lfcG+mUezBeRMlbKplQmymRcZoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Sot6AOTQEkbBlsEoRLK1pgEDR1teCAX+PkZlQV7uyondLV7CVfztWgO7532L0dro62WGxO4XjnCX0bUar9YbZLYBVVUJ8tNwKItpVu48dC5N0WOR17D3H+yhEOh6D7tQVoKlONhzrtEiOrYAlzlzA4Kwq/xYkx05YyVhfyjbnes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZS524Df; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5de47cf9329so4596138a12.3;
        Mon, 10 Feb 2025 00:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739175538; x=1739780338; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+NKax8PlRtLg5fy3LXkuGdU569UYM7F0wCxl3VmiqFA=;
        b=cZS524DfFAAY5VWyrk9W1YeveQ/XqpwCcrjziqBRfC324idbj3RNMXm+YSNrqOc/PE
         X0XEhF45IaDyXAGDzRt37qsIRHNFKGmuQDoOPkgughFQ2jq2X0Pqr97Z99Me7oPnZ3Gt
         pgskMc2SaEQKDxcedMCZNgFlL8cGJ6BIP5HuqlDvGOUEofYLveldvhvWfcRNnoxGmAIV
         yAmHjGjIHUVIQni94iloFt+JHxqnOmx7BpaUg6ldDFmNGYyadEUpWEsxFc6xDR5v2b+T
         +kXkXynSOxMqKwJbcp0yiFkfvnRpRRTZvf8zHd+kJfmvQy2svu4LsmyCv5E4ufQ5FatQ
         vM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739175538; x=1739780338;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+NKax8PlRtLg5fy3LXkuGdU569UYM7F0wCxl3VmiqFA=;
        b=U+2gM/LVsG4uL9oNlbU4vYSPYG94j0FuHUVb2lGT6BR9Qfpkihm9lR3Xm835R5ChcP
         OlFaJUB5Iy5s3cGZPCUYHhQbf5vc8AYLaZbmtq9iMOngFZabC8fRIeNx/UDHUVeeSjIi
         VXCO2XbqqPJQsPjIUO3LSLkHTLTGWcBRqdWV/KFKltpJQwZqnLQYBCEGdV7xqV76IY7X
         Bb46PimhS894KjLi4/vvzouze1RYO5wucKNySYh/hRDoCRLmvnzfiDxKSt+LNShxoIaC
         CeEjnkZhEfCsgmpY62epgHNMcT3dupV5paXCtcLdkb+zGGmAva0f2EjsjK4esbNLg9VV
         2QFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdWErhkDsaNC73iDzmFmG311jmrroQM8JA9UDDB7GQIwfTAgVqaDkDRnUaEOGrYao/Npdir0KausmT6rs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjcVwCXHdFH6YUGcRIWg+x3ZOuIn71MsFAf8uSV2oAmocf4KUx
	39U71jvD9lrET4JdCmeQIYXwDfXj9z5i6GvGzOJMHmCQMskMr5dCE7ZBSw==
X-Gm-Gg: ASbGncuIQEX4bbMa87yavpX/fxNEQK7tKvTH8wax0dGzYu25m19uWhFng/M3urQ4VN9
	l2wfjrewc88aNRrCq7Uzm2b8RWGmTFTXTsqf3oWGa8rGuxTBCP/GfM7ljIMnYruIpjG6iKk9ToY
	EWsXzoVv7Vq4WLZRuHPAY3c4lMUrIjPkypOc9KNu/DZP6n6L3+30bm729p7myc64Hc3F8XhfUBW
	QK/sj4KsU6kqLT1zAIiSPtyl6bjgxfqfLzqNKDYNJ6x5t1ursmIpzyx4RHx3t5M0hsptD2Vj6gL
	PGG88pdaH5N+BUngNQ==
X-Google-Smtp-Source: AGHT+IF5CGWQN8C3qS9HUHtID8TK6Tq+wUg591OWYkIYc/6kJ/evLF1sQ9wQc1RhMJ+/i4rBq3ozYw==
X-Received: by 2002:a05:6402:3907:b0:5db:f5e9:6745 with SMTP id 4fb4d7f45d1cf-5de44e5e000mr14307249a12.0.1739175537793;
        Mon, 10 Feb 2025 00:18:57 -0800 (PST)
Received: from [127.0.1.1] ([2a00:79c0:61c:fe00:303:6c5b:4b07:6715])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de45f626d5sm6238372a12.80.2025.02.10.00.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 00:18:57 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
Date: Mon, 10 Feb 2025 09:18:04 +0100
Subject: [PATCH net-next v3] net: phy: marvell-88q2xxx: Add support for PHY
 LEDs on 88q2xxx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-marvell-88q2xxx-leds-v3-1-f0880fde07dc@gmail.com>
X-B4-Tracking: v=1; b=H4sIADu2qWcC/3XNzQ7CIBAE4FdpOIthFyrWk+9hPGBZW5L+KDQE0
 /TdJVz0oMfJZL5ZWSDvKLBTtTJP0QU3TznIXcXa3kwdcWdzZihQASLw0fhIw8CPxyemlPhANvB
 DY5SQ+lZDrVmePjzdXSrshU208InSwq656V1YZv8qfxFKn+laAIjfdAQOHJG0lqpR0OK5G40b9
 u08FjDiB0Gh/yCYESuEVKQbgsZ+I9u2vQHUfHTTBwEAAA==
X-Change-ID: 20241221-marvell-88q2xxx-leds-69a4037b5157
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
 Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
 Stefan Eichenberger <eichest@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2

Marvell 88Q2XXX devices support up to two configurable Light Emitting
Diode (LED). Add minimal LED controller driver supporting the most common
uses with the 'netdev' trigger.

Reviewed-by: Stefan Eichenberger <eichest@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
Changes in v3:
- Moved enabling of LED0 to mv88q2xxx_config_init
- Link to v2: https://lore.kernel.org/r/20250207-marvell-88q2xxx-leds-v2-1-d0034e79e19d@gmail.com

Changes in v2:
- Renamed MDIO_MMD_PCS_MV_LED_FUNC_CTRL_GPIO_MASK to
  MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LED_1_MASK (Stefan)
- Renamed MDIO_MMD_PCS_MV_LED_FUNC_CTRL_TX_EN_MASK to
  MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LED_0_MASK (Stefan)
- Added comment for disabling tx disable feature (Stefan)
- Added defines for all led functions (Andrew)
- Move enabling of led0 function from mv88q2xxx_probe to
  mv88q222x_config_init. When the hardware reset pin is connected to a GPIO
  for example and we bring the interface down and up again, the content
  of the register MDIO_MMD_PCS_MV_RESET_CTRL is resetted to default.
  This means LED function is disabled and can't be enabled again.
- Link to v1: https://lore.kernel.org/r/20250110-marvell-88q2xxx-leds-v1-1-22e7734941c2@gmail.com
---
 drivers/net/phy/marvell-88q2xxx.c | 178 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 178 insertions(+)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index a3996471a1c9a5d4060d5d19ce44aa70e902a83f..d3e416dfe99a018757591e109110f340a11bf9a2 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -8,6 +8,7 @@
  */
 #include <linux/ethtool_netlink.h>
 #include <linux/marvell_phy.h>
+#include <linux/of.h>
 #include <linux/phy.h>
 #include <linux/hwmon.h>
 
@@ -27,6 +28,9 @@
 #define MDIO_MMD_AN_MV_STAT2_100BT1		0x2000
 #define MDIO_MMD_AN_MV_STAT2_1000BT1		0x4000
 
+#define MDIO_MMD_PCS_MV_RESET_CTRL		32768
+#define MDIO_MMD_PCS_MV_RESET_CTRL_TX_DISABLE	0x8
+
 #define MDIO_MMD_PCS_MV_INT_EN			32784
 #define MDIO_MMD_PCS_MV_INT_EN_LINK_UP		0x0040
 #define MDIO_MMD_PCS_MV_INT_EN_LINK_DOWN	0x0080
@@ -40,6 +44,22 @@
 #define MDIO_MMD_PCS_MV_GPIO_INT_CTRL			32787
 #define MDIO_MMD_PCS_MV_GPIO_INT_CTRL_TRI_DIS		0x0800
 
+#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL			32790
+#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LED_1_MASK	GENMASK(7, 4)
+#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LED_0_MASK	GENMASK(3, 0)
+#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK		0x0 /* Link established */
+#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_RX_TX	0x1 /* Link established, blink for rx or tx activity */
+#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_1000BT1	0x2 /* Blink 3x for 1000BT1 link established */
+#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_RX_TX_ON		0x3 /* Receive or transmit activity */
+#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_RX_TX		0x4 /* Blink on receive or transmit activity */
+#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_TX		0x5 /* Transmit activity */
+#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_COPPER	0x6 /* Copper Link established */
+#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_1000BT1_ON	0x7 /* 1000BT1 link established */
+#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_FORCE_OFF		0x8 /* Force off */
+#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_FORCE_ON		0x9 /* Force on */
+#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_FORCE_HIGHZ	0xa /* Force Hi-Z */
+#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_FORCE_BLINK	0xb /* Force blink */
+
 #define MDIO_MMD_PCS_MV_TEMP_SENSOR1			32833
 #define MDIO_MMD_PCS_MV_TEMP_SENSOR1_RAW_INT		0x0001
 #define MDIO_MMD_PCS_MV_TEMP_SENSOR1_INT		0x0040
@@ -95,8 +115,12 @@
 
 #define MDIO_MMD_PCS_MV_TDR_OFF_CUTOFF			65246
 
+#define MV88Q2XXX_LED_INDEX_TX_ENABLE	0
+#define MV88Q2XXX_LED_INDEX_GPIO	1
+
 struct mv88q2xxx_priv {
 	bool enable_temp;
+	bool enable_led0;
 };
 
 struct mmd_val {
@@ -460,6 +484,9 @@ static int mv88q2xxx_config_aneg(struct phy_device *phydev)
 
 static int mv88q2xxx_config_init(struct phy_device *phydev)
 {
+	struct mv88q2xxx_priv *priv = phydev->priv;
+	int ret;
+
 	/* The 88Q2XXX PHYs do have the extended ability register available, but
 	 * register MDIO_PMA_EXTABLE where they should signalize it does not
 	 * work according to specification. Therefore, we force it here.
@@ -474,6 +501,15 @@ static int mv88q2xxx_config_init(struct phy_device *phydev)
 					MDIO_MMD_PCS_MV_GPIO_INT_CTRL,
 					MDIO_MMD_PCS_MV_GPIO_INT_CTRL_TRI_DIS);
 
+	/* Enable LED function and disable TX disable feature on LED/TX_ENABLE */
+	if (priv->enable_led0) {
+		ret = phy_clear_bits_mmd(phydev, MDIO_MMD_PCS,
+					 MDIO_MMD_PCS_MV_RESET_CTRL,
+					 MDIO_MMD_PCS_MV_RESET_CTRL_TX_DISABLE);
+		if (ret < 0)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -740,15 +776,62 @@ static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
 }
 #endif
 
+#if IS_ENABLED(CONFIG_OF_MDIO)
+static int mv88q2xxx_leds_probe(struct phy_device *phydev)
+{
+	struct device_node *node = phydev->mdio.dev.of_node;
+	struct mv88q2xxx_priv *priv = phydev->priv;
+	struct device_node *leds;
+	int ret = 0;
+	u32 index;
+
+	if (!node)
+		return 0;
+
+	leds = of_get_child_by_name(node, "leds");
+	if (!leds)
+		return 0;
+
+	for_each_available_child_of_node_scoped(leds, led) {
+		ret = of_property_read_u32(led, "reg", &index);
+		if (ret)
+			goto exit;
+
+		if (index > MV88Q2XXX_LED_INDEX_GPIO) {
+			ret = -EINVAL;
+			goto exit;
+		}
+
+		if (index == MV88Q2XXX_LED_INDEX_TX_ENABLE)
+			priv->enable_led0 = true;
+	}
+
+exit:
+	of_node_put(leds);
+
+	return ret;
+}
+
+#else
+static int mv88q2xxx_leds_probe(struct phy_device *phydev)
+{
+	return 0;
+}
+#endif
+
 static int mv88q2xxx_probe(struct phy_device *phydev)
 {
 	struct mv88q2xxx_priv *priv;
+	int ret;
 
 	priv = devm_kzalloc(&phydev->mdio.dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
 	phydev->priv = priv;
+	ret = mv88q2xxx_leds_probe(phydev);
+	if (ret)
+		return ret;
 
 	return mv88q2xxx_hwmon_probe(phydev);
 }
@@ -918,6 +1001,98 @@ static int mv88q222x_cable_test_get_status(struct phy_device *phydev,
 	return 0;
 }
 
+static int mv88q2xxx_led_mode(u8 index, unsigned long rules)
+{
+	switch (rules) {
+	case BIT(TRIGGER_NETDEV_LINK):
+		return MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK;
+	case BIT(TRIGGER_NETDEV_LINK_1000):
+		return MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_1000BT1_ON;
+	case BIT(TRIGGER_NETDEV_TX):
+		return MDIO_MMD_PCS_MV_LED_FUNC_CTRL_TX;
+	case BIT(TRIGGER_NETDEV_TX) | BIT(TRIGGER_NETDEV_RX):
+		return MDIO_MMD_PCS_MV_LED_FUNC_CTRL_RX_TX;
+	case BIT(TRIGGER_NETDEV_LINK) | BIT(TRIGGER_NETDEV_TX) | BIT(TRIGGER_NETDEV_RX):
+		return MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_RX_TX;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int mv88q2xxx_led_hw_is_supported(struct phy_device *phydev, u8 index,
+					 unsigned long rules)
+{
+	int mode;
+
+	mode = mv88q2xxx_led_mode(index, rules);
+	if (mode < 0)
+		return mode;
+
+	return 0;
+}
+
+static int mv88q2xxx_led_hw_control_set(struct phy_device *phydev, u8 index,
+					unsigned long rules)
+{
+	int mode;
+
+	mode = mv88q2xxx_led_mode(index, rules);
+	if (mode < 0)
+		return mode;
+
+	if (index == MV88Q2XXX_LED_INDEX_TX_ENABLE)
+		return phy_modify_mmd(phydev, MDIO_MMD_PCS,
+				      MDIO_MMD_PCS_MV_LED_FUNC_CTRL,
+				      MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LED_0_MASK,
+				      FIELD_PREP(MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LED_0_MASK,
+						 mode));
+	else
+		return phy_modify_mmd(phydev, MDIO_MMD_PCS,
+				      MDIO_MMD_PCS_MV_LED_FUNC_CTRL,
+				      MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LED_1_MASK,
+				      FIELD_PREP(MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LED_1_MASK,
+						 mode));
+}
+
+static int mv88q2xxx_led_hw_control_get(struct phy_device *phydev, u8 index,
+					unsigned long *rules)
+{
+	int val;
+
+	val = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_MMD_PCS_MV_LED_FUNC_CTRL);
+	if (val < 0)
+		return val;
+
+	if (index == MV88Q2XXX_LED_INDEX_TX_ENABLE)
+		val = FIELD_GET(MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LED_0_MASK, val);
+	else
+		val = FIELD_GET(MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LED_1_MASK, val);
+
+	switch (val) {
+	case MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK:
+		*rules = BIT(TRIGGER_NETDEV_LINK);
+		break;
+	case MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_1000BT1_ON:
+		*rules = BIT(TRIGGER_NETDEV_LINK_1000);
+		break;
+	case MDIO_MMD_PCS_MV_LED_FUNC_CTRL_TX:
+		*rules = BIT(TRIGGER_NETDEV_TX);
+		break;
+	case MDIO_MMD_PCS_MV_LED_FUNC_CTRL_RX_TX:
+		*rules = BIT(TRIGGER_NETDEV_TX) | BIT(TRIGGER_NETDEV_RX);
+		break;
+	case MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_RX_TX:
+		*rules = BIT(TRIGGER_NETDEV_LINK) | BIT(TRIGGER_NETDEV_TX) |
+			 BIT(TRIGGER_NETDEV_RX);
+		break;
+	default:
+		*rules = 0;
+		break;
+	}
+
+	return 0;
+}
+
 static struct phy_driver mv88q2xxx_driver[] = {
 	{
 		.phy_id			= MARVELL_PHY_ID_88Q2110,
@@ -953,6 +1128,9 @@ static struct phy_driver mv88q2xxx_driver[] = {
 		.get_sqi_max		= mv88q2xxx_get_sqi_max,
 		.suspend		= mv88q2xxx_suspend,
 		.resume			= mv88q2xxx_resume,
+		.led_hw_is_supported	= mv88q2xxx_led_hw_is_supported,
+		.led_hw_control_set	= mv88q2xxx_led_hw_control_set,
+		.led_hw_control_get	= mv88q2xxx_led_hw_control_get,
 	},
 };
 

---
base-commit: 69d228c81eb2ab3824bf5fbdf75aba898a5a1f04
change-id: 20241221-marvell-88q2xxx-leds-69a4037b5157

Best regards,
-- 
Dimitri Fedrau <dima.fedrau@gmail.com>


