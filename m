Return-Path: <netdev+bounces-157191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A14A094B5
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 16:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E22713A5FE6
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 15:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C35B211466;
	Fri, 10 Jan 2025 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frorn55t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7A3211295;
	Fri, 10 Jan 2025 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736521830; cv=none; b=I8Fb+O9QxdHThBKt65o+DcX74buZZR9mz/34NQHYN2Eik2tKzbD8kNzfLEl4voXcHf1SU4dMrWFBdbB//H/oSvx2mzzTeCEQCJ63qgs2+uRxOEb995Ng8SvBeugbQWNibnQaglE5mRsx3U7tX4VmdLKA2W6nzRZGEJ33wQaZ02g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736521830; c=relaxed/simple;
	bh=kBtl7uT8CS0A/3FQfgqRqLKLLIgEoRypHpe0pFUO/Ig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=j29xY5Xq1bnRuso0GOEpCL56B0Iqlh6W1Rh8zAxife/H3ifoZPAfx2vSp0Pfc0rIsTvJgAAti5fUdNTALpkJma1ux3jc3RDFvLvbrJVY+mTq/d0oih9ZeF9/gPZ3GWERY+UOBY4LcdeRGmmJ8oMdc1vAKIyc5dWPxTHfAFZzP78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frorn55t; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43618283dedso21542605e9.3;
        Fri, 10 Jan 2025 07:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736521827; x=1737126627; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rrr2KuNOMWQbGCuFChJzePeH9IgtGR4XUrcIYviFjaQ=;
        b=frorn55t821mxulim4HVNMnzej2mfs20YYDgZg97RWOEQccsP4HiaMBxfhhiwABs0l
         9sHtH0A5JIQXu3Ks6MZbJvAHnh+IbHATELsPqkrPFBVf2frebglSdVdI7mjuS0IFneaD
         BW3eD/3+nlNnSY6npg3PwT92t4cjlkkGo20l2tMTDjtRIHcnd+TwNH5/s2RLghfPc48S
         p81h+KmxvdR29PzRaOyLysn+7W7izmofA0DbQHeZNeDbJNv5guixidlKAawYRANN3aI3
         jti/eqX5QcByr02ouHeZpxn2TsCXyPrFt9KdEuumiKPxqWIgTNxrUvcLcetQCsJrYcz8
         eoSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736521827; x=1737126627;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rrr2KuNOMWQbGCuFChJzePeH9IgtGR4XUrcIYviFjaQ=;
        b=EmgyTHavBjBsMJY2VYL13EDeK13hX2hvnzARBojPl8AznCDh8tMUIGHfmOmlRJC8xg
         crpgCjnpCQWMnr6/pXoum2oQQ40vWeBVser6WWgXZlfowunrxmFnKEJ/m/tIT8XCq5Ta
         AXELOHm4q+OcvSrhSjeZzrAjTsO5mX4XhD48TeBFOYAG6Z6OfDkaGteB3EVOWXnFz3NO
         nxZRKEwHeBq0q+50AWHFCOy6Daz8Zfd7w/DQSRcz6G6va94dJmQzpo9bYPkKkt7o+hdf
         QakormGy4kFSNNgUZosV7DMGMvMHlNnEf2ZsgmMFwUKYZAfPcTCY07OB0UtrYCIjXlt9
         eFrg==
X-Forwarded-Encrypted: i=1; AJvYcCWgPInbn4WBjrTLXH7WawKVpvWgFVcOt1dPwtpcpvJ04Su2h55Uv3y+pfp4/+91n+KYEgSRgQ4pzznFY0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwazwMyma4BLVkIDlEs0JGsc1CuLEcL9jB20SXKERYmGCvYDxev
	+IR85Xw7MdKWGR9Cqt9O9TxotaNzyKbYKOiMnp72Yuuf0DhqAQn0
X-Gm-Gg: ASbGncu7ZzgT5QLtflh1iunrJI/OyPQD0z2kMx3OfMcKkNXIl7UDe/xwJOcjX1c15/A
	vW4jRsW/u0lJ3lIG8ZzYMJZ1gwDy8QW840A461wIQQNDDEUZQzGW0oSRiw4vgLTzLXdZnXdahDS
	EYjY2D6phopy/a68JhuJwZ5kPY5gnAz+DaO1CPns+8Qvt+5tA1Be//LzI8xoDa/fqK/YSpm9DZJ
	Cso/70dwB4FMe/jx4Cdng08yidW1GkApuV/CqFyETeSyfSmV+DJLU9ZqIQ=
X-Google-Smtp-Source: AGHT+IFaXp/cN47vzxc7btkObg72jSd/KMKmUoEBpTJQApo14I1jarTeFXpRHAn10na2lhyS9nQ7xw==
X-Received: by 2002:a05:600c:5117:b0:434:fe62:28c1 with SMTP id 5b1f17b1804b1-436e26cfe5bmr103411715e9.18.1736521826434;
        Fri, 10 Jan 2025 07:10:26 -0800 (PST)
Received: from [127.0.1.1] ([2a00:79c0:6a1:e700:303:6c5b:4b07:6715])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2ddcb5bsm90931235e9.23.2025.01.10.07.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 07:10:25 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
Date: Fri, 10 Jan 2025 16:10:04 +0100
Subject: [PATCH] net: phy: marvell-88q2xxx: Add support for PHY LEDs on
 88q2xxx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-marvell-88q2xxx-leds-v1-1-22e7734941c2@gmail.com>
X-B4-Tracking: v=1; b=H4sIAEs4gWcC/x3MSQqAMAxA0atI1gZsnL2KuKgaNVCnFkpBvLvF5
 Vv8/4BjK+ygSx6w7MXJeUSoNIFp08fKKHM0UEaFIlK4a+vZGGyam0IIaHh2WLW6yPJ6LFVZQ0w
 vy4uEf9sP7/sBxw9z42YAAAA=
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
 drivers/net/phy/marvell-88q2xxx.c | 161 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 161 insertions(+)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 5107f58338aff4ed6cfea4d91e37282d9bb60ba5..bef3357b9d279fca5d1f86ff0eaa0d45a699e3f9 100644
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
@@ -40,6 +44,15 @@
 #define MDIO_MMD_PCS_MV_GPIO_INT_CTRL			32787
 #define MDIO_MMD_PCS_MV_GPIO_INT_CTRL_TRI_DIS		0x0800
 
+#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL			32790
+#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_GPIO_MASK		GENMASK(7, 4)
+#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_TX_EN_MASK	GENMASK(3, 0)
+#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK		0x0 /* Link established */
+#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_RX_TX	0x1 /* Link established, blink for rx or tx activity */
+#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_RX_TX		0x4 /* Receive or Transmit activity */
+#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_TX		0x5 /* Transmit activity */
+#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_1000BT1	0x7 /* 1000BT1 link established */
+
 #define MDIO_MMD_PCS_MV_TEMP_SENSOR1			32833
 #define MDIO_MMD_PCS_MV_TEMP_SENSOR1_RAW_INT		0x0001
 #define MDIO_MMD_PCS_MV_TEMP_SENSOR1_INT		0x0040
@@ -95,6 +108,9 @@
 
 #define MDIO_MMD_PCS_MV_TDR_OFF_CUTOFF			65246
 
+#define MV88Q2XXX_LED_INDEX_TX_ENABLE	0
+#define MV88Q2XXX_LED_INDEX_GPIO	1
+
 struct mmd_val {
 	int devad;
 	u32 regnum;
@@ -741,8 +757,58 @@ static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
 }
 #endif
 
+#if IS_ENABLED(CONFIG_OF_MDIO)
+static int mv88q2xxx_leds_probe(struct phy_device *phydev)
+{
+	struct device_node *node = phydev->mdio.dev.of_node;
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
+			ret = phy_clear_bits_mmd(phydev, MDIO_MMD_PCS,
+						 MDIO_MMD_PCS_MV_RESET_CTRL,
+						 MDIO_MMD_PCS_MV_RESET_CTRL_TX_DISABLE);
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
+	int ret;
+
+	ret = mv88q2xxx_leds_probe(phydev);
+	if (ret)
+		return ret;
+
 	return mv88q2xxx_hwmon_probe(phydev);
 }
 
@@ -899,6 +965,98 @@ static int mv88q222x_cable_test_get_status(struct phy_device *phydev,
 	return 0;
 }
 
+static int mv88q2xxx_led_mode(u8 index, unsigned long rules)
+{
+	switch (rules) {
+	case BIT(TRIGGER_NETDEV_LINK):
+		return MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK;
+	case BIT(TRIGGER_NETDEV_LINK_1000):
+		return MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_1000BT1;
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
+				      MDIO_MMD_PCS_MV_LED_FUNC_CTRL_TX_EN_MASK,
+				      FIELD_PREP(MDIO_MMD_PCS_MV_LED_FUNC_CTRL_TX_EN_MASK,
+						 mode));
+	else
+		return phy_modify_mmd(phydev, MDIO_MMD_PCS,
+				      MDIO_MMD_PCS_MV_LED_FUNC_CTRL,
+				      MDIO_MMD_PCS_MV_LED_FUNC_CTRL_GPIO_MASK,
+				      FIELD_PREP(MDIO_MMD_PCS_MV_LED_FUNC_CTRL_GPIO_MASK,
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
+		val = FIELD_GET(MDIO_MMD_PCS_MV_LED_FUNC_CTRL_TX_EN_MASK, val);
+	else
+		val = FIELD_GET(MDIO_MMD_PCS_MV_LED_FUNC_CTRL_GPIO_MASK, val);
+
+	switch (val) {
+	case MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK:
+		*rules = BIT(TRIGGER_NETDEV_LINK);
+		break;
+	case MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_1000BT1:
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
@@ -934,6 +1092,9 @@ static struct phy_driver mv88q2xxx_driver[] = {
 		.get_sqi_max		= mv88q2xxx_get_sqi_max,
 		.suspend		= mv88q2xxx_suspend,
 		.resume			= mv88q2xxx_resume,
+		.led_hw_is_supported	= mv88q2xxx_led_hw_is_supported,
+		.led_hw_control_set	= mv88q2xxx_led_hw_control_set,
+		.led_hw_control_get	= mv88q2xxx_led_hw_control_get,
 	},
 };
 

---
base-commit: 3409aa9a349cc1d911c08eff3b265a4db48865c7
change-id: 20241221-marvell-88q2xxx-leds-69a4037b5157

Best regards,
-- 
Dimitri Fedrau <dima.fedrau@gmail.com>


