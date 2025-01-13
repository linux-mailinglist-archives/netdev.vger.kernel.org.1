Return-Path: <netdev+bounces-157584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB17A0AEDA
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 06:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A20F1166F3C
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 05:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0401231A2C;
	Mon, 13 Jan 2025 05:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDmg6CEO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D69230D3E;
	Mon, 13 Jan 2025 05:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736746829; cv=none; b=CmDjZ+F6Mp0gPj3TDWU8axRhzjE4kdJMHVfnixHdBD6PBOlaTwLRKTzspO8IHJWz9doAbplun7SoXdPcBYGYEcU2JZeoA03bWz6WCgypO0hUqPnec6ajD41ikAaPEQ6je5B3qOSQOOXiP8/tu0woLdQfTMqpV0sEGNv7mopFiPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736746829; c=relaxed/simple;
	bh=4m1E63LsxQwGq2W9c7d+meXAs2CvrElfIIgO8UnS36Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oKfbBtRJ2ZXz+B/F/Uh7Fdi0Gi4BbbEwcW4I3uyJVgLJzj9By4JSt3LxNNgoIhK7IFb+LclSWEkgeaQCqakX/D16K1JpjxJtUZMaXN/LnaswhFkXEGJ9T3AjQhwrtP0I6gyzw7CDnoKWbfsSEiv+0NdaoXtOzLbRYjBHdeNvszg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDmg6CEO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 313D6C4CEE3;
	Mon, 13 Jan 2025 05:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736746829;
	bh=4m1E63LsxQwGq2W9c7d+meXAs2CvrElfIIgO8UnS36Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IDmg6CEO8/EIjr9rzJsX2CT/BsIN/xTBXrYDQutakRTbYClCExpM5Gtfr347Nvpcd
	 SeE+stcTfYqwuy4oc0ZLn/ap5y+3xUX1eSQauf7f4FlgvAoe/bz7jRbQgPSnKP5XVr
	 QSnB6demdqiJvOt8ObE9gv0dR2aEs2bPu5GO8Hd8kWYknhFzhDeb0/l45RRbN7K9aV
	 7X4sBJo1pzGyuE6k6tDAbQXUn9MDFDNOv67DAbKsFbUEUI8wR/bcPZZNLacIIGHrws
	 IUVOc54RxUQQ5qlMjG21TZjrwm6qkfFS6QpIGVI9dGOODLrpcLG/8eEH+Cn6pO3+M8
	 Peu2Dp+DRXtDQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F80DC02183;
	Mon, 13 Jan 2025 05:40:29 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Mon, 13 Jan 2025 06:40:13 +0100
Subject: [PATCH net-next 2/2] net: phy: dp83822: Add support for changing
 the transmit amplitude voltage
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-dp83822-tx-swing-v1-2-7ed5a9d80010@liebherr.com>
References: <20250113-dp83822-tx-swing-v1-0-7ed5a9d80010@liebherr.com>
In-Reply-To: <20250113-dp83822-tx-swing-v1-0-7ed5a9d80010@liebherr.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736746828; l=3137;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=Js90gzAB4QuC7WswX0cokUbCfUb0Ln86Q2F24a7ti1c=;
 b=PKEKhj/u5oyszmPvrqXVgeZm60wrbUHIjDqyQKCL7WKkHlVo6JOgV7UoG0EqwopmFs7TPibd3
 yp9vGFIIMruBrG7JrFhRxi55ICV8Ak3CVBtDgXfL3TpBjCGBB6QBZj9
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Add support for changing the transmit amplitude voltage in 100BASE-TX mode.
Add support for configuration via DT.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 drivers/net/phy/dp83822.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index 4262bc31503b20640f19596449325d8a5938e20c..cc2ee9add648bc5f72dd92c7813ceec5e4b6db53 100644
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
@@ -197,6 +201,12 @@ struct dp83822_private {
 	bool set_gpio2_clk_out;
 	u32 gpio2_clk_out;
 	bool led_pin_enable[DP83822_MAX_LED_PINS];
+	int tx_amplitude_100base_tx_index;
+};
+
+static const u32 tx_amplitude_100base_tx[] = {
+	1600, 1633, 1667, 1700, 1733, 1767, 1800, 1833,
+	1867, 1900, 1933, 1967, 2000, 2033, 2067, 2100,
 };
 
 static int dp83822_config_wol(struct phy_device *phydev,
@@ -522,6 +532,12 @@ static int dp83822_config_init(struct phy_device *phydev)
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
@@ -780,6 +796,8 @@ static int dp83822_of_init(struct phy_device *phydev)
 	struct dp83822_private *dp83822 = phydev->priv;
 	struct device *dev = &phydev->mdio.dev;
 	const char *of_val;
+	u32 val;
+	int i;
 
 	/* Signal detection for the PHY is only enabled if the FX_EN and the
 	 * SD_EN pins are strapped. Signal detection can only enabled if FX_EN
@@ -815,6 +833,23 @@ static int dp83822_of_init(struct phy_device *phydev)
 		dp83822->set_gpio2_clk_out = true;
 	}
 
+	dp83822->tx_amplitude_100base_tx_index = -1;
+	if (!device_property_read_u32(dev, "ti,tx-amplitude-100base-tx-millivolt", &val)) {
+		for (i = 0; i < ARRAY_SIZE(tx_amplitude_100base_tx); i++) {
+			if (tx_amplitude_100base_tx[i] == val) {
+				dp83822->tx_amplitude_100base_tx_index = i;
+				break;
+			}
+		}
+
+		if (dp83822->tx_amplitude_100base_tx_index < 0) {
+			phydev_err(phydev,
+				   "Invalid value for ti,tx-amplitude-100base-tx-millivolt property (%u)\n",
+				   val);
+			return -EINVAL;
+		}
+	}
+
 	return dp83822_of_init_leds(phydev);
 }
 

-- 
2.39.5



