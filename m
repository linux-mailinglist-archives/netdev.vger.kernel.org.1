Return-Path: <netdev+bounces-155749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B37A039B4
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 09:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E1103A5235
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 08:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481891DFE29;
	Tue,  7 Jan 2025 08:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXBXcena"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CC41802AB;
	Tue,  7 Jan 2025 08:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736238193; cv=none; b=PnGqq1uyTbS28aPiaMe3lEGGpcWLBOCaEGpboyvq6iNvQHpQNBwDMeluPkbVMvfhHbI625kcMVwbfyN+264PEYBJkSWxkJNsiHUgcY3iphq2NsGFr4IHnLInGiEbgKyjaJOQmL+D+FPC87F4Q9yEFIXncrs5Y/Th//d6VCh/9Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736238193; c=relaxed/simple;
	bh=Qc/Jhi/8Co9OPxJ392bFR2K7J8hBcjAnp8+K3sz2tvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=B09howzFhQiz8BxG1kdpmchkEdVIcm8j+EA9o0BbZz3rUW+25WAD6bYw2pony3Bakau7Ln4bYu+IjicJKYvUZpWpGldizFahXB7/blsgtL930WmLjgqEUa9GoAD6Mjy9x2Pwnls3Wdd5xHtaEAtuob5L8eYBl+OCq4gOABhtK6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXBXcena; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3862b364538so8697570f8f.1;
        Tue, 07 Jan 2025 00:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736238189; x=1736842989; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YBLbqN14KX+JL6O9BzGZFmVZB6dSplvCg1UH/WS05Sc=;
        b=EXBXcenaLQrKOVmRxDgNHL9wcIlSQ7UafRIag3v6BgiiJNhYtQOtXQwyS2LDVNogiM
         w/wX/1W5UOo7W+xnfsbgodenmvaTxr3/73GDiyzAbIGz+CZgmGP9pW7UCXMzBK5VHY4L
         OAdGDK/3evzhqm5w45skS+FtZmQUSFY5ifIrH295cYOjPiDPv0Fh9Af15FTELmf6tvbN
         is3o/aLbwVfM1Zlr6TnIMZH/AKOAn2KgvRgkhib3aauzpLFCyN5B1rhuIkDsi9dnzoui
         nok2ysTQiAVkERUBHMMY1TMtfW8suddf0DA/3GCSJPfwpfmyLVfYKQ9hAr4G+0W+6IqR
         HSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736238189; x=1736842989;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YBLbqN14KX+JL6O9BzGZFmVZB6dSplvCg1UH/WS05Sc=;
        b=cT5ogL5VS6E27tSPysr5c0n2VP1b1QMgrfheXliPgdGYQIbTttYMv95748mCzQx5ML
         1wLcRvPGX+K1aGzXXWZNVIJQOLYfW3x2A6pHbyprcq3RG0elD+Cy6IjdDLPMh4Eanj53
         xCf4t9h0+jc3JsAr9xVAJvg7fVfOP56L4yTiwbM2IY8gYq2dMHRdqZ+FxKgbSpUUn6uX
         yoWprA4XTsoEfHs1hVnVp/tZFQwo93Z2YoGgxR5zHwOZk77gu7XH0pMAgCFrNS4Wxkv+
         H6SScbx5xcZTL2yyxVvMQ50FpXijpr0OloGDE6pZTHQ2Pq71a2/1KurBugxIaOS3B5+x
         Akkg==
X-Forwarded-Encrypted: i=1; AJvYcCXl5EAn/MRJXm/2tpNfaNzHZcrSsP1NdtYERWL+riGVasl44Hb6ky9hZMbCetvzHBMIR6jhsSa3d6LxbzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPDjFxQn6UoxzdFD1sIBsHlyDJrZBlT8nYQzJdP6WItPoaakbK
	b0crs0nd6SWnSgoX+QTISIIOkUZ9QC7NWxpGTxCvl5lkz30kDBvf
X-Gm-Gg: ASbGncuvIYo+m0vwOBXjThliHyyrlZ4oNZfhoTB+8+C1VbCiRcj5534qTzvscS51c9G
	eKs7xIYjIKqATWQcmvJVo+MqErs3QuUmGms7gXgk4KftxmBP2jN5vWdEN0ZazdTAZUv1q11dqcN
	2eAvfAOOsd9tCiRsfqpMdI3isxctBTavInyE3W9e3wpraLUN0ggr48XvYm6KOs0hVmAyGJNKoGu
	vsZb6xPjmOq22i/ovZqJXUI6VBnjL8z8vYKDTcO0QcV1/WuBd+drihIwXs=
X-Google-Smtp-Source: AGHT+IGY99+oKTOkfWBpyy2/wovncOBVaeeFR+iv8uTRMhp2/vK6jbAKfecUXThK82iYod66X0w05w==
X-Received: by 2002:a05:6000:1886:b0:386:3bde:9849 with SMTP id ffacd0b85a97d-38a7912c989mr1492684f8f.12.1736238189013;
        Tue, 07 Jan 2025 00:23:09 -0800 (PST)
Received: from [127.0.1.1] ([2a00:79c0:61c:c00:6fa5:416c:9dba:f1b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366e210cecsm554561785e9.2.2025.01.07.00.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 00:23:07 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
Date: Tue, 07 Jan 2025 09:23:04 +0100
Subject: [PATCH net-next v2] net: phy: dp83822: Add support for PHY LEDs on
 DP83822
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-dp83822-leds-v2-1-5b260aad874f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAGfkfGcC/1WNQQqDMBBFr1Jm3SmZMVXpqvcoLtRMdUCjJCIW8
 e4N0k2Xj8d/f4coQSXC47JDkFWjTj4BXy/Q9rXvBNUlBjZsiemObi6zkhkHcRGbxkldsHUF55A
 mc5C3bmfuBV4W9LItUCXTa1ym8Dl/Vjr9L1n8J1dCwtKYhq3NyVD27MZah1s7jVAdx/EFavZO0
 7IAAAA=
X-Change-ID: 20241215-dp83822-leds-bbdea724d726
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2

The DP83822 supports up to three configurable Light Emitting Diode (LED)
pins: LED_0, LED_1 (GPIO1), COL (GPIO2) and RX_D3 (GPIO3). Several
functions can be multiplexed onto the LEDs for different modes of
operation. LED_0 and COL (GPIO2) use the MLED function. MLED can be routed
to only one of these two pins at a time. Add minimal LED controller driver
supporting the most common uses with the 'netdev' trigger.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
Changes in v2:
- Fix check in dp83822_led_hw_control_get: index == DP83822_LED_INDEX_COL_GPIO2
- Cleanup leds node in dp83822_of_init_leds(of_node_put)
- Link to v1: https://lore.kernel.org/r/20241217-dp83822-leds-v1-1-800b24461013@gmail.com
---
 drivers/net/phy/dp83822.c | 277 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 275 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index 334c17a68edd7c2a0f707b3ccafaa7a870818fbe..4262bc31503b20640f19596449325d8a5938e20c 100644
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
@@ -145,6 +180,13 @@
 					ADVERTISED_FIBRE | \
 					ADVERTISED_Pause | ADVERTISED_Asym_Pause)
 
+#define DP83822_MAX_LED_PINS		4
+
+#define DP83822_LED_INDEX_LED_0		0
+#define DP83822_LED_INDEX_LED_1_GPIO1	1
+#define DP83822_LED_INDEX_COL_GPIO2	2
+#define DP83822_LED_INDEX_RX_D3_GPIO3	3
+
 struct dp83822_private {
 	bool fx_signal_det_low;
 	int fx_enabled;
@@ -154,6 +196,7 @@ struct dp83822_private {
 	struct ethtool_wolinfo wol;
 	bool set_gpio2_clk_out;
 	u32 gpio2_clk_out;
+	bool led_pin_enable[DP83822_MAX_LED_PINS];
 };
 
 static int dp83822_config_wol(struct phy_device *phydev,
@@ -418,6 +461,48 @@ static int dp83822_read_status(struct phy_device *phydev)
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
@@ -437,6 +522,10 @@ static int dp83822_config_init(struct phy_device *phydev)
 			       FIELD_PREP(DP83822_IOCTRL2_GPIO2_CLK_SRC,
 					  dp83822->gpio2_clk_out));
 
+	err = dp83822_config_init_leds(phydev);
+	if (err)
+		return err;
+
 	if (phy_interface_is_rgmii(phydev)) {
 		rx_int_delay = phy_get_internal_delay(phydev, dev, NULL, 0,
 						      true);
@@ -631,6 +720,61 @@ static int dp83822_phy_reset(struct phy_device *phydev)
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
+		if (err) {
+			of_node_put(leds);
+			return err;
+		}
+
+		if (index <= DP83822_LED_INDEX_RX_D3_GPIO3) {
+			dp83822->led_pin_enable[index] = true;
+		} else {
+			of_node_put(leds);
+			return -EINVAL;
+		}
+	}
+
+	of_node_put(leds);
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
@@ -671,7 +815,7 @@ static int dp83822_of_init(struct phy_device *phydev)
 		dp83822->set_gpio2_clk_out = true;
 	}
 
-	return 0;
+	return dp83822_of_init_leds(phydev);
 }
 
 static int dp83826_to_dac_minus_one_regval(int percent)
@@ -769,7 +913,9 @@ static int dp83822_probe(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	dp83822_of_init(phydev);
+	ret = dp83822_of_init(phydev);
+	if (ret)
+		return ret;
 
 	if (dp83822->fx_enabled)
 		phydev->port = PORT_FIBRE;
@@ -816,6 +962,130 @@ static int dp83822_resume(struct phy_device *phydev)
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
+	if (index == DP83822_LED_INDEX_LED_0 || index == DP83822_LED_INDEX_COL_GPIO2) {
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
@@ -831,6 +1101,9 @@ static int dp83822_resume(struct phy_device *phydev)
 		.handle_interrupt = dp83822_handle_interrupt,	\
 		.suspend = dp83822_suspend,			\
 		.resume = dp83822_resume,			\
+		.led_hw_is_supported = dp83822_led_hw_is_supported,	\
+		.led_hw_control_set = dp83822_led_hw_control_set,	\
+		.led_hw_control_get = dp83822_led_hw_control_get,	\
 	}
 
 #define DP83825_PHY_DRIVER(_id, _name)				\

---
base-commit: 49afc040f4d707a4149a05180edc42bc590641a4
change-id: 20241215-dp83822-leds-bbdea724d726

Best regards,
-- 
Dimitri Fedrau <dima.fedrau@gmail.com>


