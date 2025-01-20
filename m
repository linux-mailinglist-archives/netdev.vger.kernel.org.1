Return-Path: <netdev+bounces-159780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66039A16DC4
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 14:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB7001888F0F
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 13:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28D31E2619;
	Mon, 20 Jan 2025 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKyr/zR4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC35E1E25E5;
	Mon, 20 Jan 2025 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737381030; cv=none; b=ECUQCqVv62g8HxRC6yy448D/aXGcRWy4C84YQnc/8EenQI5R5O7mVGvKL//sdvLWVJupT+1ANirDqBu1V1mNWPdT2QcPQ756ARMIkVUGJz1VEwSAcXOomKvBMcONZ25WWGDFEdMFFbZs/lGc2uFMQAaVRHq5Jbta8+hMZxOeGYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737381030; c=relaxed/simple;
	bh=iE/bcwku4KTw3/iRUxcBK9x9PA9J1U2krhjU61zQY4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sA2jBsWtiJXt9Vd5sjiHYxk0fQOuv38A7eYjEhInbYAY6k50LCLdVX7wXTokrAHM5LRr+leaiEKLIjsKQp83KbNlgAoLtv8bD6IOEem64cG+dY0ssworU5N7xKRMFoPJqqXZje4QCUOAdWTCnfNfh5ulEGqsGBKWW3FJxwKYplI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKyr/zR4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3ED1AC4CEE9;
	Mon, 20 Jan 2025 13:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737381030;
	bh=iE/bcwku4KTw3/iRUxcBK9x9PA9J1U2krhjU61zQY4s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nKyr/zR4MgdQsHzVaAi1eT6GU6kzeHrPXcHK03UIiiA8OskMYqztY/4jjmITrnttz
	 pp3s+JppgbQiRZAW07vfcO6PyUSwQZqELGhEbgbWNNlgW/J21iVZwVWiazBgIBAh6x
	 dAfjWaRH5sr67vuKy3e1aTtP0QYHGIZgJvVlLCKaVkeXUX/8fG58oe46ZpFAclb5MX
	 hBRB6BemJwIepHV3IVfI+9R5jjw0UeBzpFS128+Ztls+DGqUczj1IHm9oKcWPsM354
	 hbnq3sUwV08VEjDIP9g2hJFyN5s0vFmXe+Mgoykd6Wkq7BmHLBLirV7WyyDEfQycp8
	 rU2/6N9QWe21g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3040DC02182;
	Mon, 20 Jan 2025 13:50:30 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Mon, 20 Jan 2025 14:50:23 +0100
Subject: [PATCH net-next v2 3/3] net: phy: dp83822: Add support for
 changing the transmit amplitude voltage
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250120-dp83822-tx-swing-v2-3-07c99dc42627@liebherr.com>
References: <20250120-dp83822-tx-swing-v2-0-07c99dc42627@liebherr.com>
In-Reply-To: <20250120-dp83822-tx-swing-v2-0-07c99dc42627@liebherr.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737381028; l=3492;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=i7JK4ez08mIrB/fvCWOiiy6f3mWMVK6RC5dLYH/FlCk=;
 b=S/2O6vcc8bP/dacaUOWDYebuPHZGwfVOeZxhsnjym5v4Sfg3FdSWqCDKBgrsvMuetE+yZHA0R
 xctx5ih/nBjAqmwmPDG0syV8TJHAy1XKwTRh3XAXgz8MiybtYnzMjm1
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Add support for changing the transmit amplitude voltage in 100BASE-TX mode.
Modifying it can be necessary to compensate losses on the PCB and
connector, so the voltages measured on the RJ45 pins are conforming.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 drivers/net/phy/dp83822.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index 6599feca1967d705331d6e354205a2485ea962f2..dd5aaf1b2c61ee31c521f83aa1dccb6d3f5aae15 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -31,6 +31,7 @@
 #define MII_DP83822_RCSR	0x17
 #define MII_DP83822_RESET_CTRL	0x1f
 #define MII_DP83822_MLEDCR	0x25
+#define MII_DP83822_LDCTRL	0x403
 #define MII_DP83822_LEDCFG1	0x460
 #define MII_DP83822_IOCTRL1	0x462
 #define MII_DP83822_IOCTRL2	0x463
@@ -123,6 +124,9 @@
 #define DP83822_IOCTRL1_GPIO1_CTRL		GENMASK(2, 0)
 #define DP83822_IOCTRL1_GPIO1_CTRL_LED_1	BIT(0)
 
+/* LDCTRL bits */
+#define DP83822_100BASE_TX_LINE_DRIVER_SWING	GENMASK(7, 4)
+
 /* IOCTRL2 bits */
 #define DP83822_IOCTRL2_GPIO2_CLK_SRC		GENMASK(6, 4)
 #define DP83822_IOCTRL2_GPIO2_CTRL		GENMASK(2, 0)
@@ -197,6 +201,7 @@ struct dp83822_private {
 	bool set_gpio2_clk_out;
 	u32 gpio2_clk_out;
 	bool led_pin_enable[DP83822_MAX_LED_PINS];
+	int tx_amplitude_100base_tx_index;
 };
 
 static int dp83822_config_wol(struct phy_device *phydev,
@@ -522,6 +527,12 @@ static int dp83822_config_init(struct phy_device *phydev)
 			       FIELD_PREP(DP83822_IOCTRL2_GPIO2_CLK_SRC,
 					  dp83822->gpio2_clk_out));
 
+	if (dp83822->tx_amplitude_100base_tx_index >= 0)
+		phy_modify_mmd(phydev, MDIO_MMD_VEND2, MII_DP83822_LDCTRL,
+			       DP83822_100BASE_TX_LINE_DRIVER_SWING,
+			       FIELD_PREP(DP83822_100BASE_TX_LINE_DRIVER_SWING,
+					  dp83822->tx_amplitude_100base_tx_index));
+
 	err = dp83822_config_init_leds(phydev);
 	if (err)
 		return err;
@@ -720,6 +731,11 @@ static int dp83822_phy_reset(struct phy_device *phydev)
 }
 
 #ifdef CONFIG_OF_MDIO
+static const u32 tx_amplitude_100base_tx_gain[] = {
+	800, 816, 833, 850, 866, 1767, 883, 916,
+	933, 950, 966, 983, 1000, 1016, 1033, 1050,
+};
+
 static int dp83822_of_init_leds(struct phy_device *phydev)
 {
 	struct device_node *node = phydev->mdio.dev.of_node;
@@ -780,6 +796,8 @@ static int dp83822_of_init(struct phy_device *phydev)
 	struct dp83822_private *dp83822 = phydev->priv;
 	struct device *dev = &phydev->mdio.dev;
 	const char *of_val;
+	s32 val;
+	int i;
 
 	/* Signal detection for the PHY is only enabled if the FX_EN and the
 	 * SD_EN pins are strapped. Signal detection can only enabled if FX_EN
@@ -815,6 +833,25 @@ static int dp83822_of_init(struct phy_device *phydev)
 		dp83822->set_gpio2_clk_out = true;
 	}
 
+	dp83822->tx_amplitude_100base_tx_index = -1;
+	val = phy_get_tx_amplitude_gain(phydev, dev,
+					ETHTOOL_LINK_MODE_100baseT_Full_BIT);
+	if (val > 0) {
+		for (i = 0; i < ARRAY_SIZE(tx_amplitude_100base_tx_gain); i++) {
+			if (tx_amplitude_100base_tx_gain[i] == val) {
+				dp83822->tx_amplitude_100base_tx_index = i;
+				break;
+			}
+		}
+
+		if (dp83822->tx_amplitude_100base_tx_index < 0) {
+			phydev_err(phydev,
+				   "Invalid value for tx-amplitude-100base-tx-gain-milli property (%u)\n",
+				   val);
+			return -EINVAL;
+		}
+	}
+
 	return dp83822_of_init_leds(phydev);
 }
 

-- 
2.39.5



