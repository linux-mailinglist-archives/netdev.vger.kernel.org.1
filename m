Return-Path: <netdev+bounces-164073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD582A2C8AB
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 17:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A1BB169213
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 16:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29E518DB29;
	Fri,  7 Feb 2025 16:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7BouLx2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EFF18DB20;
	Fri,  7 Feb 2025 16:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738945469; cv=none; b=nAALL8DfbvMxGjx3+oukkv9map8ZKQkPn1fFIDDZVPkU/OfcTmQsMPLZlMhuWOuMNf2toPSouh6XQ8tLjUjGTNGudLNJC6e3W/+5kXs1Lq0RHdgHUrnjWjAua3T7e8mgVt8mVfhv0OXjb/PvOq0jcj8EHFQeeP2jicq0mFAlasI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738945469; c=relaxed/simple;
	bh=Mfl554gavsur5Qo4HGrRZwQ0sMXAPKO4vNS4ja3WcaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iZR+BwzKKTFDzS8LXox6YM3hq2GyCWW4DWuOa8AsQTZj12MVoyYzlyaBSQTnr4g3xL6tQmRE8GV16vsQBeKYJlAkWJxdFEvWsCuIzy9DSoTZvtuB/EXGuIgSHswFzanO4R2RnHkxBmIkz7XiH52IZRPI8rNzwHGHG4+WjUCUKWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7BouLx2; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43626213fffso20528295e9.1;
        Fri, 07 Feb 2025 08:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738945465; x=1739550265; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QkvTHaJ58Kil6DvQOZ0TAxY1NBvZAngIuJQZq/3aUMg=;
        b=i7BouLx2TW5GHhPQqim9c3lxUABXRo1eVJU4nVA2xwoRyKWadggPpVHdaM0We7jg3o
         LP96l9I3B3fRO1abqvNs0SAbCJOfq5QaDVaPPISJ8bBMRdlEMT16sDTQy+IWBeNglzR2
         yziHE+aUZyYENHLd+6ndA4huY4gInftvaBac3ktKU+2hlFS9zTTYb4BxQMqbxSTFh0I+
         R8xWqEzAMvlNL5bVlgCinURFdKWkZ8Z1S1OVBqdU38OECvtV6MLaBON5KGEsPvMz2GL3
         fHxxx5oxpU62rnLsheI3S3OoSYxdh34Zn7YX0pD0kVEgtIxtQ6XcYKF9+wiRoxBSwF3O
         HVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738945465; x=1739550265;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QkvTHaJ58Kil6DvQOZ0TAxY1NBvZAngIuJQZq/3aUMg=;
        b=GS0isikbwCsVT8GlTujsmA6uX5lQSh+uDVOt2SpkD+lLeEN7PKMAxm7S/tb/QElvzi
         /qjtTr4nOqudIevKNXRjOyqHNVVRBh/T/rBVk1bBRcaQsFAuLV3QY7KgshBG6OLEiSns
         7+JNwR/uOB2v7a7T5CdugaDmJJSa+37KjOU71LH0U8ybxFguuO/x0A1TOznK+lm3rdkb
         fzyZ5XvrWwpmDVq93cR/j5LmxH90YEgGARMl8NQ8n0DrfYrOv4GXCoHXgD54FzyidxjD
         E9G1fjkNHBNPBO4GXdEtvz/u1hYuVlxmMyup02AeRDBkUEIcxxseaouJ74fOF0UiEsj5
         RYvA==
X-Forwarded-Encrypted: i=1; AJvYcCWpoh5DA97UEiMpsV4KoVo/5oNZMJ/0CSXZdD6plrtwcyTKKl3bqCYoBSKTVytlJGeAHyd0wkHTJuLzVFc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx70gh8LdGSNa4X3L7VHJyPxjxok/Wy6oDkGOpokIeCxOolmTMn
	DVv8nJUJlr/bvnyWtENrqAbhCWr9p7tsKBb+TlkNKoA1B30H8+8evLIcbA==
X-Gm-Gg: ASbGncs2MPROnk3nbLkiWlcsHOHyAwRmJms306Lw471z778HGSZE9+4GtyD4QNj599v
	a/6dl/n/KHeSYNaKpiEc2lNug5rgxGQETSbL7ihbQp0cfC5PUY+BKJkH3QozrQxZE4CS+rpCGwV
	iu7jiMQB1lVzvOM8jZWsPQMW+nauniaTfEiXgUjooLggr+MHOrvfs214/5KtcedJF3T1dggHVO1
	m44B6hYjVGDVHkWhXBYc7SbVwEzaGYc3AxciK2OIOguCulvGd//ZvFIgVZ2uFHkT+E0qcvOT3n/
	t4uy5lxkcxTxP9IiX/U=
X-Google-Smtp-Source: AGHT+IEr9U7WwqNJaxoj85RTASZNqtolco90RuxJ3DsXZx3ZHAQtRhqirgvkEP2a7COQj58dFRHHtA==
X-Received: by 2002:a5d:59ac:0:b0:38c:5da8:5f88 with SMTP id ffacd0b85a97d-38dc9ba7969mr2434225f8f.28.1738945464483;
        Fri, 07 Feb 2025 08:24:24 -0800 (PST)
Received: from [127.0.1.1] ([2a00:79c0:611:dd00:45fb:7d1a:5e4d:9727])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dcd34a39esm1675049f8f.30.2025.02.07.08.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 08:24:23 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
Date: Fri, 07 Feb 2025 17:24:20 +0100
Subject: [PATCH net-next v2] net: phy: marvell-88q2xxx: Add support for PHY
 LEDs on 88q2xxx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-marvell-88q2xxx-leds-v2-1-d0034e79e19d@gmail.com>
X-B4-Tracking: v=1; b=H4sIALMzpmcC/22NQQ6CMBBFr0JmbU1nKBZdeQ/DosIITUrRljQ1h
 LvbsHb58vLf3yBysBzhVm0QONloF1+AThX0k/EjCzsUBpKkkAjFbEJi50TbfijnLBwPUVyuRsl
 aPxtsNJTpO/DL5iP7AM+r8JxX6IqZbFyX8D3+Eh6+pBuJKP+nEwoURKx1ra4Ke7qPs7Hu3C8zd
 Pu+/wCMpoyNwgAAAA==
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

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
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
 drivers/net/phy/marvell-88q2xxx.c | 175 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 175 insertions(+)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index a3996471a1c9a5d4060d5d19ce44aa70e902a83f..2d5ea3e1b26219bb1e050222347c2688903e2430 100644
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
@@ -740,15 +764,62 @@ static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
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
@@ -829,6 +900,15 @@ static int mv88q222x_config_init(struct phy_device *phydev)
 			return ret;
 	}
 
+	/* Enable LED function and disable TX disable feature on LED/TX_ENABLE */
+	if (priv->enable_led0) {
+		ret = phy_clear_bits_mmd(phydev, MDIO_MMD_PCS,
+					 MDIO_MMD_PCS_MV_RESET_CTRL,
+					 MDIO_MMD_PCS_MV_RESET_CTRL_TX_DISABLE);
+		if (ret < 0)
+			return ret;
+	}
+
 	if (phydev->c45_ids.device_ids[MDIO_MMD_PMAPMD] == PHY_ID_88Q2220_REVB0)
 		return mv88q222x_revb0_config_init(phydev);
 	else
@@ -918,6 +998,98 @@ static int mv88q222x_cable_test_get_status(struct phy_device *phydev,
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
@@ -953,6 +1125,9 @@ static struct phy_driver mv88q2xxx_driver[] = {
 		.get_sqi_max		= mv88q2xxx_get_sqi_max,
 		.suspend		= mv88q2xxx_suspend,
 		.resume			= mv88q2xxx_resume,
+		.led_hw_is_supported	= mv88q2xxx_led_hw_is_supported,
+		.led_hw_control_set	= mv88q2xxx_led_hw_control_set,
+		.led_hw_control_get	= mv88q2xxx_led_hw_control_get,
 	},
 };
 

---
base-commit: f84db3bc8abc2141839cdb9454061633a4ce1db7
change-id: 20241221-marvell-88q2xxx-leds-69a4037b5157

Best regards,
-- 
Dimitri Fedrau <dima.fedrau@gmail.com>


