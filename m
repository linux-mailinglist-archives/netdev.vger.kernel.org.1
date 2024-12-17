Return-Path: <netdev+bounces-152522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFF19F473C
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 10:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D72F1891393
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 09:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67141D2B13;
	Tue, 17 Dec 2024 09:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcT82dsu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75021D63F5;
	Tue, 17 Dec 2024 09:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734426969; cv=none; b=G8EsW0Cycxf0CWPbkPD2E00on++RhknRcfS9pX3n9KjFNLoCy7x1cTT8GQ06WzFwULD5dQ+Mucb1GxKWSNDs277cVm6q8bcqJ+Xo5BYvWQyjRCSCylvvlOOWMhb5VccgtBwyU5iSt2A0hKHnOsU5JECbg8iP+cuOUtPuGJpk9ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734426969; c=relaxed/simple;
	bh=UlK4igwsovlXplWPOzkyx5uMbHBS1NJ0tkJg/4GsC7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=h2I5zXYjKH/etfMoRAYfX/9+LFickEmLyYQ4ozyYnL+U2mWXmnI5boHFkR/mcReDVl0eyG6SyxwYUoF6lT1kcH8eg4hfqcK18aAduVlIO6l9OZb8684mpA8K/yYQkI7ry4S1xHQBLI4ddAFpr4tDEjyuH+qKnS/YTNBeYiFVU2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcT82dsu; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3862b364538so2889795f8f.1;
        Tue, 17 Dec 2024 01:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734426966; x=1735031766; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wF7MbNgMPrt1mOlfKpiRgfiGd0cEWIHduNdpx2uBOzU=;
        b=TcT82dsupvxhyOsJ8gF+MzXI+7EsrJEk/HaWgPWFb96+5nShYZ/Vj3P+zvaBJd85Dz
         VD0BPzbIxihabosZgvEGg1wJyiq2HxoBKszsNrjKuNkoooj+yPGYnUarbRyQQw4+tk7P
         IlOq9RucNim+ZyyJE1rDeqmxa/QLFY8RPSmCLmIRHskiA12mfl8T/fNVVS9H5RtMs1Kt
         11RTufT2UcIlQa6aejFsroynyDjSRy/JQLqzXTunoHbMwK6Sgwis7VXuBQODG7t1LQx2
         P+c5vF+o5x/ucXy73MMKC4s4obWSd3H+IEBJZDdUoLfo2LO0pZpSAFTWIHjHkxUR3IQv
         SuDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734426966; x=1735031766;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wF7MbNgMPrt1mOlfKpiRgfiGd0cEWIHduNdpx2uBOzU=;
        b=HF69/7D52g7oM58UvH3u/Hwljze/4TxRd47mXpEMNhSFLGorNqqoMNhwOME04CGNok
         tclXIcQmxVQY1y3vbWqs6fIpBGwnC8Gaamz6vhke6d039veNNB3lkuM8pQhICM8ti8Ak
         osX8SQiwGoUEf9u5iNAoFhm0+9FFu1s8Weu3LirBw4oakusYyEokWx2/NDU3lkhR8Uyx
         QjSy42zHu76VPgHex37ry2CE+I4cBRA4zlGctSgp8UNy9JX1SoY7pm0OoenbY/czxtBD
         x8feCO24hqoJNIauHLZYk5rEtUzpr6s8ZpjbrGWHzXI9MWVCfPfclxGBFhAzEe0T3viA
         Znww==
X-Forwarded-Encrypted: i=1; AJvYcCUmNZKQfNYTI9BwuGE1UEpyt8aKkAiTErFSuHmE1ex4+Liw1aLT6VdTFTUeNzms83TJuXCpJ26Mn1a3Wwk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl7yOxumdVcxVjJoNCghZGsfNbIPwv3nk/+9ptbPKcBlmB180M
	+V1V93ffQ0/jp9xpyeOX79OT0StVF+53izh175LbuSEOX0txzuPncqzOqoOA
X-Gm-Gg: ASbGncvUEbvfd1Lq/9z90VH6aQ1TAyqaFbg3DsU4U0Ne/dBYFhjtcHoUet0kjp3LMmx
	rVq6Ras9OA+kYnvSBMDvBxYRtrjJo3lJ0k80IY2lEJBtTBlnca1eSLnHVNY74bO6zA41M6/e30K
	WlnYEGz+TdqH5LQ/WxZSpklbabkeRRJZMgMAC0zVi2tK+y2ca0y7MTZFwbWMIDAl5sBLWtGQ8rj
	ujeSlUtJa98/qoOBe73JqTRf9DEpzMvQBeFGL6/kgYqPKom3tvNa/Bm24M=
X-Google-Smtp-Source: AGHT+IHUPyZNCvEd9MXiLxLhFJFcfP9D4xU2wc6CKh2oNRCnatbAychFklnAPPcc3ahD8hAw2J8A3Q==
X-Received: by 2002:a5d:584f:0:b0:386:3958:2ec5 with SMTP id ffacd0b85a97d-388db294b60mr2124663f8f.28.1734426965633;
        Tue, 17 Dec 2024 01:16:05 -0800 (PST)
Received: from [127.0.1.1] ([2a00:79c0:674:2500:224:9bff:fe22:6dd6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c801ac68sm10507103f8f.51.2024.12.17.01.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 01:16:04 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
Date: Tue, 17 Dec 2024 10:16:03 +0100
Subject: [PATCH net-next] net: phy: dp83822: Add support for PHY LEDs on
 DP83822
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-dp83822-leds-v1-1-800b24461013@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFJBYWcC/x3MSwqEQAxF0a1Ixgas+MWtiAM1r9uAlFIlIoh77
 6KHZ3DvQxHBEKnPHgq4LNruE1ye0bJO/gs2TSYppHLiatajKzsR3qCR51kxtVJpKw2l5Aj42P3
 fDeRxssd90vi+P/k89FFoAAAA
X-Change-ID: 20241215-dp83822-leds-bbdea724d726
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2

The DP83822 supports up to three configurable Light Emitting Diode (LED)
pins: LED_0, LED_1 (GPIO1), COL (GPIO2) and RX_D3 (GPIO3). Several
functions can be multiplexed onto the LEDs for different modes of
operation. LED_0 and COL (GPIO2) use the MLED function. MLED can be routed
to only one of these two pins at a time. Add minimal LED controller driver
supporting the most common uses with the 'netdev' trigger.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/net/phy/dp83822.c | 271 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 269 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index 334c17a68edd7c2a0f707b3ccafaa7a870818fbe..66651dbbd944fe1469057e9ef2f2057aedfb9e29 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -30,6 +30,9 @@
 #define MII_DP83822_FCSCR	0x14
 #define MII_DP83822_RCSR	0x17
 #define MII_DP83822_RESET_CTRL	0x1f
+#define MII_DP83822_MLEDCR	0x25
+#define MII_DP83822_LEDCFG1	0x460
+#define MII_DP83822_IOCTRL1	0x462
 #define MII_DP83822_IOCTRL2	0x463
 #define MII_DP83822_GENCFG	0x465
 #define MII_DP83822_SOR1	0x467
@@ -105,10 +108,26 @@
 #define DP83822_RX_CLK_SHIFT	BIT(12)
 #define DP83822_TX_CLK_SHIFT	BIT(11)
 
+/* MLEDCR bits */
+#define DP83822_MLEDCR_CFG		GENMASK(6, 3)
+#define DP83822_MLEDCR_ROUTE		GENMASK(1, 0)
+#define DP83822_MLEDCR_ROUTE_LED_0	DP83822_MLEDCR_ROUTE
+
+/* LEDCFG1 bits */
+#define DP83822_LEDCFG1_LED1_CTRL	GENMASK(11, 8)
+#define DP83822_LEDCFG1_LED3_CTRL	GENMASK(7, 4)
+
+/* IOCTRL1 bits */
+#define DP83822_IOCTRL1_GPIO3_CTRL		GENMASK(10, 8)
+#define DP83822_IOCTRL1_GPIO3_CTRL_LED3		BIT(0)
+#define DP83822_IOCTRL1_GPIO1_CTRL		GENMASK(2, 0)
+#define DP83822_IOCTRL1_GPIO1_CTRL_LED_1	BIT(0)
+
 /* IOCTRL2 bits */
 #define DP83822_IOCTRL2_GPIO2_CLK_SRC		GENMASK(6, 4)
 #define DP83822_IOCTRL2_GPIO2_CTRL		GENMASK(2, 0)
 #define DP83822_IOCTRL2_GPIO2_CTRL_CLK_REF	GENMASK(1, 0)
+#define DP83822_IOCTRL2_GPIO2_CTRL_MLED		BIT(0)
 
 #define DP83822_CLK_SRC_MAC_IF			0x0
 #define DP83822_CLK_SRC_XI			0x1
@@ -117,6 +136,22 @@
 #define DP83822_CLK_SRC_FREE_RUNNING		0x6
 #define DP83822_CLK_SRC_RECOVERED		0x7
 
+#define DP83822_LED_FN_LINK		0x0 /* Link established */
+#define DP83822_LED_FN_RX_TX		0x1 /* Receive or Transmit activity */
+#define DP83822_LED_FN_TX		0x2 /* Transmit activity */
+#define DP83822_LED_FN_RX		0x3 /* Receive activity */
+#define DP83822_LED_FN_COLLISION	0x4 /* Collision detected */
+#define DP83822_LED_FN_LINK_100_BTX	0x5 /* 100 BTX link established */
+#define DP83822_LED_FN_LINK_10_BT	0x6 /* 10BT link established */
+#define DP83822_LED_FN_FULL_DUPLEX	0x7 /* Full duplex */
+#define DP83822_LED_FN_LINK_RX_TX	0x8 /* Link established, blink for rx or tx activity */
+#define DP83822_LED_FN_ACTIVE_STRETCH	0x9 /* Active Stretch Signal */
+#define DP83822_LED_FN_MII_LINK		0xa /* MII LINK (100BT+FD) */
+#define DP83822_LED_FN_LPI_MODE		0xb /* LPI Mode (EEE) */
+#define DP83822_LED_FN_RX_TX_ERR	0xc /* TX/RX MII Error */
+#define DP83822_LED_FN_LINK_LOST	0xd /* Link Lost */
+#define DP83822_LED_FN_PRBS_ERR		0xe /* Blink for PRBS error */
+
 /* SOR1 mode */
 #define DP83822_STRAP_MODE1	0
 #define DP83822_STRAP_MODE2	BIT(0)
@@ -145,6 +180,12 @@
 					ADVERTISED_FIBRE | \
 					ADVERTISED_Pause | ADVERTISED_Asym_Pause)
 
+#define DP83822_MAX_LED_PINS		4
+
+#define DP83822_LED_INDEX_LED_0		0
+#define DP83822_LED_INDEX_LED_1_GPIO1	1
+#define DP83822_LED_INDEX_COL_GPIO2	2
+#define DP83822_LED_INDEX_RX_D3_GPIO3	3
 struct dp83822_private {
 	bool fx_signal_det_low;
 	int fx_enabled;
@@ -154,6 +195,7 @@ struct dp83822_private {
 	struct ethtool_wolinfo wol;
 	bool set_gpio2_clk_out;
 	u32 gpio2_clk_out;
+	bool led_pin_enable[DP83822_MAX_LED_PINS];
 };
 
 static int dp83822_config_wol(struct phy_device *phydev,
@@ -418,6 +460,48 @@ static int dp83822_read_status(struct phy_device *phydev)
 	return 0;
 }
 
+static int dp83822_config_init_leds(struct phy_device *phydev)
+{
+	struct dp83822_private *dp83822 = phydev->priv;
+	int ret;
+
+	if (dp83822->led_pin_enable[DP83822_LED_INDEX_LED_0]) {
+		ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, MII_DP83822_MLEDCR,
+				     DP83822_MLEDCR_ROUTE,
+				     FIELD_PREP(DP83822_MLEDCR_ROUTE,
+						DP83822_MLEDCR_ROUTE_LED_0));
+		if (ret)
+			return ret;
+	} else if (dp83822->led_pin_enable[DP83822_LED_INDEX_COL_GPIO2]) {
+		ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, MII_DP83822_IOCTRL2,
+				     DP83822_IOCTRL2_GPIO2_CTRL,
+				     FIELD_PREP(DP83822_IOCTRL2_GPIO2_CTRL,
+						DP83822_IOCTRL2_GPIO2_CTRL_MLED));
+		if (ret)
+			return ret;
+	}
+
+	if (dp83822->led_pin_enable[DP83822_LED_INDEX_LED_1_GPIO1]) {
+		ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, MII_DP83822_IOCTRL1,
+				     DP83822_IOCTRL1_GPIO1_CTRL,
+				     FIELD_PREP(DP83822_IOCTRL1_GPIO1_CTRL,
+						DP83822_IOCTRL1_GPIO1_CTRL_LED_1));
+		if (ret)
+			return ret;
+	}
+
+	if (dp83822->led_pin_enable[DP83822_LED_INDEX_RX_D3_GPIO3]) {
+		ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, MII_DP83822_IOCTRL1,
+				     DP83822_IOCTRL1_GPIO3_CTRL,
+				     FIELD_PREP(DP83822_IOCTRL1_GPIO3_CTRL,
+						DP83822_IOCTRL1_GPIO3_CTRL_LED3));
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int dp83822_config_init(struct phy_device *phydev)
 {
 	struct dp83822_private *dp83822 = phydev->priv;
@@ -437,6 +521,10 @@ static int dp83822_config_init(struct phy_device *phydev)
 			       FIELD_PREP(DP83822_IOCTRL2_GPIO2_CLK_SRC,
 					  dp83822->gpio2_clk_out));
 
+	err = dp83822_config_init_leds(phydev);
+	if (err)
+		return err;
+
 	if (phy_interface_is_rgmii(phydev)) {
 		rx_int_delay = phy_get_internal_delay(phydev, dev, NULL, 0,
 						      true);
@@ -631,6 +719,56 @@ static int dp83822_phy_reset(struct phy_device *phydev)
 }
 
 #ifdef CONFIG_OF_MDIO
+static int dp83822_of_init_leds(struct phy_device *phydev)
+{
+	struct device_node *node = phydev->mdio.dev.of_node;
+	struct dp83822_private *dp83822 = phydev->priv;
+	struct device_node *leds;
+	u32 index;
+	int err;
+
+	if (!node)
+		return 0;
+
+	leds = of_get_child_by_name(node, "leds");
+	if (!leds)
+		return 0;
+
+	for_each_available_child_of_node_scoped(leds, led) {
+		err = of_property_read_u32(led, "reg", &index);
+		if (err)
+			return err;
+
+		if (index <= DP83822_LED_INDEX_RX_D3_GPIO3)
+			dp83822->led_pin_enable[index] = true;
+		else
+			return -EINVAL;
+	}
+
+	/* LED_0 and COL(GPIO2) use the MLED function. MLED can be routed to
+	 * only one of these two pins at a time.
+	 */
+	if (dp83822->led_pin_enable[DP83822_LED_INDEX_LED_0] &&
+	    dp83822->led_pin_enable[DP83822_LED_INDEX_COL_GPIO2]) {
+		phydev_err(phydev, "LED_0 and COL(GPIO2) cannot be used as LED output at the same time\n");
+		return -EINVAL;
+	}
+
+	if (dp83822->led_pin_enable[DP83822_LED_INDEX_COL_GPIO2] &&
+	    dp83822->set_gpio2_clk_out) {
+		phydev_err(phydev, "COL(GPIO2) cannot be used as LED outout, already used as clock output\n");
+		return -EINVAL;
+	}
+
+	if (dp83822->led_pin_enable[DP83822_LED_INDEX_RX_D3_GPIO3] &&
+	    phydev->interface != PHY_INTERFACE_MODE_RMII) {
+		phydev_err(phydev, "RX_D3 can only be used as LED output when in RMII mode\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int dp83822_of_init(struct phy_device *phydev)
 {
 	struct dp83822_private *dp83822 = phydev->priv;
@@ -671,7 +809,7 @@ static int dp83822_of_init(struct phy_device *phydev)
 		dp83822->set_gpio2_clk_out = true;
 	}
 
-	return 0;
+	return dp83822_of_init_leds(phydev);
 }
 
 static int dp83826_to_dac_minus_one_regval(int percent)
@@ -769,7 +907,9 @@ static int dp83822_probe(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	dp83822_of_init(phydev);
+	ret = dp83822_of_init(phydev);
+	if (ret)
+		return ret;
 
 	if (dp83822->fx_enabled)
 		phydev->port = PORT_FIBRE;
@@ -816,6 +956,130 @@ static int dp83822_resume(struct phy_device *phydev)
 	return 0;
 }
 
+static int dp83822_led_mode(u8 index, unsigned long rules)
+{
+	switch (rules) {
+	case BIT(TRIGGER_NETDEV_LINK):
+		return DP83822_LED_FN_LINK;
+	case BIT(TRIGGER_NETDEV_LINK_10):
+		return DP83822_LED_FN_LINK_10_BT;
+	case BIT(TRIGGER_NETDEV_LINK_100):
+		return DP83822_LED_FN_LINK_100_BTX;
+	case BIT(TRIGGER_NETDEV_FULL_DUPLEX):
+		return DP83822_LED_FN_FULL_DUPLEX;
+	case BIT(TRIGGER_NETDEV_TX):
+		return DP83822_LED_FN_TX;
+	case BIT(TRIGGER_NETDEV_RX):
+		return DP83822_LED_FN_RX;
+	case BIT(TRIGGER_NETDEV_TX) | BIT(TRIGGER_NETDEV_RX):
+		return DP83822_LED_FN_RX_TX;
+	case BIT(TRIGGER_NETDEV_TX_ERR) | BIT(TRIGGER_NETDEV_RX_ERR):
+		return DP83822_LED_FN_RX_TX_ERR;
+	case BIT(TRIGGER_NETDEV_LINK) | BIT(TRIGGER_NETDEV_TX) | BIT(TRIGGER_NETDEV_RX):
+		return DP83822_LED_FN_LINK_RX_TX;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int dp83822_led_hw_is_supported(struct phy_device *phydev, u8 index,
+				       unsigned long rules)
+{
+	int mode;
+
+	mode = dp83822_led_mode(index, rules);
+	if (mode < 0)
+		return mode;
+
+	return 0;
+}
+
+static int dp83822_led_hw_control_set(struct phy_device *phydev, u8 index,
+				      unsigned long rules)
+{
+	int mode;
+
+	mode = dp83822_led_mode(index, rules);
+	if (mode < 0)
+		return mode;
+
+	if (index == DP83822_LED_INDEX_LED_0 || index == DP83822_LED_INDEX_COL_GPIO2)
+		return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
+				      MII_DP83822_MLEDCR, DP83822_MLEDCR_CFG,
+				      FIELD_PREP(DP83822_MLEDCR_CFG, mode));
+	else if (index == DP83822_LED_INDEX_LED_1_GPIO1)
+		return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
+				      MII_DP83822_LEDCFG1,
+				      DP83822_LEDCFG1_LED1_CTRL,
+				      FIELD_PREP(DP83822_LEDCFG1_LED1_CTRL,
+						 mode));
+	else
+		return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
+				      MII_DP83822_LEDCFG1,
+				      DP83822_LEDCFG1_LED3_CTRL,
+				      FIELD_PREP(DP83822_LEDCFG1_LED3_CTRL,
+						 mode));
+}
+
+static int dp83822_led_hw_control_get(struct phy_device *phydev, u8 index,
+				      unsigned long *rules)
+{
+	int val;
+
+	if (index == DP83822_LED_INDEX_LED_0 || DP83822_LED_INDEX_COL_GPIO2) {
+		val = phy_read_mmd(phydev, MDIO_MMD_VEND2, MII_DP83822_MLEDCR);
+		if (val < 0)
+			return val;
+
+		val = FIELD_GET(DP83822_MLEDCR_CFG, val);
+	} else {
+		val = phy_read_mmd(phydev, MDIO_MMD_VEND2, MII_DP83822_LEDCFG1);
+		if (val < 0)
+			return val;
+
+		if (index == DP83822_LED_INDEX_LED_1_GPIO1)
+			val = FIELD_GET(DP83822_LEDCFG1_LED1_CTRL, val);
+		else
+			val = FIELD_GET(DP83822_LEDCFG1_LED3_CTRL, val);
+	}
+
+	switch (val) {
+	case DP83822_LED_FN_LINK:
+		*rules = BIT(TRIGGER_NETDEV_LINK);
+		break;
+	case DP83822_LED_FN_LINK_10_BT:
+		*rules = BIT(TRIGGER_NETDEV_LINK_10);
+		break;
+	case DP83822_LED_FN_LINK_100_BTX:
+		*rules = BIT(TRIGGER_NETDEV_LINK_100);
+		break;
+	case DP83822_LED_FN_FULL_DUPLEX:
+		*rules = BIT(TRIGGER_NETDEV_FULL_DUPLEX);
+		break;
+	case DP83822_LED_FN_TX:
+		*rules = BIT(TRIGGER_NETDEV_TX);
+		break;
+	case DP83822_LED_FN_RX:
+		*rules = BIT(TRIGGER_NETDEV_RX);
+		break;
+	case DP83822_LED_FN_RX_TX:
+		*rules = BIT(TRIGGER_NETDEV_TX) | BIT(TRIGGER_NETDEV_RX);
+		break;
+	case DP83822_LED_FN_RX_TX_ERR:
+		*rules = BIT(TRIGGER_NETDEV_TX_ERR) | BIT(TRIGGER_NETDEV_RX_ERR);
+		break;
+	case DP83822_LED_FN_LINK_RX_TX:
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
 #define DP83822_PHY_DRIVER(_id, _name)				\
 	{							\
 		PHY_ID_MATCH_MODEL(_id),			\
@@ -831,6 +1095,9 @@ static int dp83822_resume(struct phy_device *phydev)
 		.handle_interrupt = dp83822_handle_interrupt,	\
 		.suspend = dp83822_suspend,			\
 		.resume = dp83822_resume,			\
+		.led_hw_is_supported = dp83822_led_hw_is_supported,	\
+		.led_hw_control_set = dp83822_led_hw_control_set,	\
+		.led_hw_control_get = dp83822_led_hw_control_get,	\
 	}
 
 #define DP83825_PHY_DRIVER(_id, _name)				\

---
base-commit: a14a429069bb1a18eb9fe63d68fcaa77dffe0e23
change-id: 20241215-dp83822-leds-bbdea724d726

Best regards,
-- 
Dimitri Fedrau <dima.fedrau@gmail.com>


