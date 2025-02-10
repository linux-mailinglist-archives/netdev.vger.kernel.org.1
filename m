Return-Path: <netdev+bounces-164776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF51A2F060
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 15:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C96787A3540
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 14:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F692253B0;
	Mon, 10 Feb 2025 14:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QztgoZXC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250971F8BDE;
	Mon, 10 Feb 2025 14:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739199227; cv=none; b=s9/ZKDF0FsUTIqtkTRYNi9seZcC0xcIUyIdzCKjakwXEgtXDqY6j0tzYJd3sBkM2dGdBuQyZ8Jygu5nl/jA2QiEj/+M7qElOXSlDeSDxdV6gDXp5tH1SU6wJWvn6wkitfmqZgA0AQvhi+vi+7ZsfcVjtxpeIVnkeaCG4V0QaeWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739199227; c=relaxed/simple;
	bh=13mvoAlAV+ZCf+dvUjfLXvNnk8OlIbrhT2Yuhnsy4+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lYMHMX0GzlH0BmIvs6XCxm+haH4hkKh38j2aBeJHyG0fzmTvrhOFHeKn3it7kRuzdr8846WB54cPK5eEqZIWWc2RCYgctq8/m0hwOdjxg+wMj3HlmdXPQSaTGYFbrGxdY01cm0q6tVWNOTWyDacCfWKkD167922cF/JQHmutsfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QztgoZXC; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa68b513abcso852201766b.0;
        Mon, 10 Feb 2025 06:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739199222; x=1739804022; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9O6cs8g0eT0iePfQgRP4o09rF75YcSqCAYidZN9+yQ4=;
        b=QztgoZXCrITuTvoO5mqx2z7Ur5PH9fl/bMNr17lDSgXL3QvWb7fIUB07OGhqxUVNlK
         DOp8LiITmNKU9OqcOFJtWdi0WlSYCztEgx2xPY47AsUNn+PtVQTjnpfzeUpHIVAl8QC5
         3aj6L6110XcVxLMvZQHuGTEdzf8Ib7GqK2KgXcOj4Y035RGUqoK3Qb1cx7oj7tj8j5JW
         6xMvn7MLTRDvbCFvRaswzKkoLCJ4Lvr7MNHnmTco/LvD/zV0XWEaRebccpUr+5aPww5m
         ccCfJtoTV1q6mUdvXhD1SSa8GTURpjXHzMBoRhFJ+cTSUvRpr4OrzbG55PbAZGyGw2Ji
         E47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739199222; x=1739804022;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9O6cs8g0eT0iePfQgRP4o09rF75YcSqCAYidZN9+yQ4=;
        b=NA/ZMJmUj+gmZRkf1+L46WV5G9+QoMv08eWLh77Wp660Zp7SUUcEcJ5nGWW9tmN9rf
         FbVN7kp5jDB3LcB/D8vxUeNQrKFxOF6aZtsGFYTT1xHyyWdzJ5YMfozatw3RH3CTubtM
         yZUzl6b+fky0i5+YrV78wkeKXiZ0Qyo0op7K8ZDORGLmrv0nb12tase8BnNErEVJue+7
         Qd5EubCTwm7y9UlhpcjxYRgUzbFvbo0gJbnadmvAcMaRLNbsMS1Kp3Ek1jnfrrHbCsGF
         JKEUHRX4CVsxVjO0uNfI67d6ZPFK5Hp8JP4i6lzoolqtIrzrU1BUKVOYfL3ukFpz/mGk
         V4jA==
X-Forwarded-Encrypted: i=1; AJvYcCUnnFbyP3xPIemwBuerL+q1Frv3s2+xSw1OPEgk62kWGQzbB+DXCAi898b6AAbnJw4onlKQ+cf+Zmg4FJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyFM92LsraU1iJF0eBbc2Zr2qWE3/zmiBwqdODs9sYeE+r/ZfK
	UC4LgtqgwpU8zntTRAkiAGmHaV7NOIL5feJ0hn+YUfmxnLCQsYOK
X-Gm-Gg: ASbGncs1/OmRbmZwf+iKok/0fwrMwtsVYO/MgJ57JWh6FaDcYPPL2PeyoEHIHqm3svn
	omtxjW208HsBiaL8CpkX2QCAiUkrMA45FHe9X92YrWPST3waSzWD9wbYdsHtWiP/5Ru+bJwEulm
	DgkfU7siXlCNyhChI0AbtRYihAD1rT6vVPIY6EG7CwuayJlQdQLXfw0JZanz4+xsKIlY2oRPHCG
	kptVHfYVwZf/la6hk86nbOjVjhFZHH9ZM5/BH7HmdVyed1YqSLJgQYcZm8qFcts/9TcqvPh+ayU
	qhgBpIsm7tt/w7tj+g==
X-Google-Smtp-Source: AGHT+IH5hMffHi8RlX9hZ+jmLfweWcfos++aSnrsB4KqQRunyvO0H1+p9SFBA5utgLb+koFOHF7C0Q==
X-Received: by 2002:a17:907:94ca:b0:ab2:b5f1:568c with SMTP id a640c23a62f3a-ab789b937c7mr1507148366b.28.1739199222106;
        Mon, 10 Feb 2025 06:53:42 -0800 (PST)
Received: from [127.0.1.1] ([2a00:79c0:61c:fe00:303:6c5b:4b07:6715])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab772f893e9sm895901266b.65.2025.02.10.06.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 06:53:41 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
Date: Mon, 10 Feb 2025 15:53:40 +0100
Subject: [PATCH net-next v4] net: phy: marvell-88q2xxx: Add support for PHY
 LEDs on 88q2xxx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-marvell-88q2xxx-leds-v4-1-3a0900dc121f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPMSqmcC/3XOTQrCMBAF4KtI1kZmJqlpXXkPcVGbqQb6o0kJk
 dK7G7pRRJePx3xvZhHYOw7isJmF5+iCG4cc9HYjmls9XFk6m7MgII1EKPvaR+46WZYPSinJjm2
 Q+6rWoMylwMKIfHr33Lq0sicx8CQHTpM45+bmwjT657oXce0zXQAi/KYjSpREbIzSlcaGjte+d
 t2uGfsVjPRGCMwfhDJiAZRmUzFW9htRH8jfT1RGWihLaC2Dsc0nsizLC6+7Nn1MAQAA
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
Changes in v4:
- Fix early return in mv88q2xxx_config_init when phy_interrupt_is_valid
- Sorry for the mess and not waiting 24 hours!
- Link to v3: https://lore.kernel.org/r/20250210-marvell-88q2xxx-leds-v3-1-f0880fde07dc@gmail.com

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
 drivers/net/phy/marvell-88q2xxx.c | 189 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 185 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index a3996471a1c9a5d4060d5d19ce44aa70e902a83f..bad5e7b2357da067bfd1ec6bd1307c42f5dc5c91 100644
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
@@ -469,10 +496,22 @@ static int mv88q2xxx_config_init(struct phy_device *phydev)
 	/* Configure interrupt with default settings, output is driven low for
 	 * active interrupt and high for inactive.
 	 */
-	if (phy_interrupt_is_valid(phydev))
-		return phy_set_bits_mmd(phydev, MDIO_MMD_PCS,
-					MDIO_MMD_PCS_MV_GPIO_INT_CTRL,
-					MDIO_MMD_PCS_MV_GPIO_INT_CTRL_TRI_DIS);
+	if (phy_interrupt_is_valid(phydev)) {
+		ret = phy_set_bits_mmd(phydev, MDIO_MMD_PCS,
+				       MDIO_MMD_PCS_MV_GPIO_INT_CTRL,
+				       MDIO_MMD_PCS_MV_GPIO_INT_CTRL_TRI_DIS);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Enable LED function and disable TX disable feature on LED/TX_ENABLE */
+	if (priv->enable_led0) {
+		ret = phy_clear_bits_mmd(phydev, MDIO_MMD_PCS,
+					 MDIO_MMD_PCS_MV_RESET_CTRL,
+					 MDIO_MMD_PCS_MV_RESET_CTRL_TX_DISABLE);
+		if (ret < 0)
+			return ret;
+	}
 
 	return 0;
 }
@@ -740,15 +779,62 @@ static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
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
@@ -918,6 +1004,98 @@ static int mv88q222x_cable_test_get_status(struct phy_device *phydev,
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
@@ -953,6 +1131,9 @@ static struct phy_driver mv88q2xxx_driver[] = {
 		.get_sqi_max		= mv88q2xxx_get_sqi_max,
 		.suspend		= mv88q2xxx_suspend,
 		.resume			= mv88q2xxx_resume,
+		.led_hw_is_supported	= mv88q2xxx_led_hw_is_supported,
+		.led_hw_control_set	= mv88q2xxx_led_hw_control_set,
+		.led_hw_control_get	= mv88q2xxx_led_hw_control_get,
 	},
 };
 

---
base-commit: 54800986355a5429cde03ae0f322b0afec055568
change-id: 20241221-marvell-88q2xxx-leds-69a4037b5157

Best regards,
-- 
Dimitri Fedrau <dima.fedrau@gmail.com>


