Return-Path: <netdev+bounces-183416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFEBA909BE
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 19:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70B607ABA5B
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 17:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4CA21885A;
	Wed, 16 Apr 2025 17:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqwVnAu1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D809217739;
	Wed, 16 Apr 2025 17:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744823700; cv=none; b=szrMidPzs0L3gO59dcuRzBUktgEZIz8EA+hxzOWKqJbt9zQ/Ji3cXD9FZ7J8+J9OdqzK/Ae46TGHHk8/QmxXGFZeFwmKsR355uiF36NUdMuXnJIz+vCCR3b+Thzq1K4a7XPYsB4do26jiSQmJXBi6DhhNoEJd1eBGWYl3pSeiOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744823700; c=relaxed/simple;
	bh=goePd7zMNr7BemvNLAfHe6YmAcUBAYJT6AWRUnM94sw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dfh6jY9P0Fb/dle2igld2COAhtjjaMSWayS1bnCq8qI0WOLe1oaCWU1+rqruTsOrAFmLTuc+EBmJ6BegpBw8ci0DnpKQEWOF4DOL4xOoDdQ9rOkGUXHnkDr66I7tKxKvj4PWrAM0RAeFOZlpPU9PVZCum5YoWS79g/6W487J80A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqwVnAu1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BCBA9C4CEEE;
	Wed, 16 Apr 2025 17:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744823699;
	bh=goePd7zMNr7BemvNLAfHe6YmAcUBAYJT6AWRUnM94sw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jqwVnAu1fvuILmnr+yAQrOXnAAIowEa5lzhvoReGoJ0NNDiFtDVhYjFH4sM4CJFSD
	 jnYrxPy4BAgxcpG/I6etC2/JT4CV2z7oYPPXpYr82ioZKDmpTHBgQosdJOSndC+kej
	 Qvm7pxfJ1nVXyObyn4N7FF1HM6KSvmM4fPx56848NjiaAkpR+uNE66ln/h2vW0Oid1
	 M/g7Epe9ypBDVEwpMeWvVI4Hzlk1qHQJOYnuSosVe7khxGubJvLB76WsooIy6C8Fs4
	 q3tVStl28HW86IRhznC7NAXZ3XviHk/+aMZWLNwyohGVmZFHXCvW3f+HVWej15KDVj
	 /8t8QTKkL+osw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBE3C369BA;
	Wed, 16 Apr 2025 17:14:59 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Wed, 16 Apr 2025 19:14:50 +0200
Subject: [PATCH net-next v3 4/4] net: phy: dp83822: Add support for
 changing the MAC termination
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-dp83822-mac-impedance-v3-4-028ac426cddb@liebherr.com>
References: <20250416-dp83822-mac-impedance-v3-0-028ac426cddb@liebherr.com>
In-Reply-To: <20250416-dp83822-mac-impedance-v3-0-028ac426cddb@liebherr.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Andrew Davis <afd@ti.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744823698; l=3207;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=aUB5dQ6e7my0jObP7hS6jVNZ0SSji5tioyizzZyZ9Wo=;
 b=HVfJ/PMe7SX0eZJKufHILN7AgzuaTJja2DNEup344W4GrcWoMxNqv3A7aYOtREJCSY97U8Tdb
 ZkSIfbvU2/tAgWtVHw+Dgdj1LZxOt2tcD9uouwo12ww3xX2Vm/7m9b4
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

The dp83822 provides the possibility to set the resistance value of the
the MAC termination. Modifying the resistance to an appropriate value can
reduce signal reflections and therefore improve signal quality.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 drivers/net/phy/dp83822.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index 14f36154963841dff98be5af4dfbd2760325c13d..490c9f4e5d4e4dc866ef99f426f7497b5e1b49b4 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -33,6 +33,7 @@
 #define MII_DP83822_MLEDCR	0x25
 #define MII_DP83822_LDCTRL	0x403
 #define MII_DP83822_LEDCFG1	0x460
+#define MII_DP83822_IOCTRL	0x461
 #define MII_DP83822_IOCTRL1	0x462
 #define MII_DP83822_IOCTRL2	0x463
 #define MII_DP83822_GENCFG	0x465
@@ -118,6 +119,9 @@
 #define DP83822_LEDCFG1_LED1_CTRL	GENMASK(11, 8)
 #define DP83822_LEDCFG1_LED3_CTRL	GENMASK(7, 4)
 
+/* IOCTRL bits */
+#define DP83822_IOCTRL_MAC_IMPEDANCE_CTRL	GENMASK(4, 1)
+
 /* IOCTRL1 bits */
 #define DP83822_IOCTRL1_GPIO3_CTRL		GENMASK(10, 8)
 #define DP83822_IOCTRL1_GPIO3_CTRL_LED3		BIT(0)
@@ -202,6 +206,7 @@ struct dp83822_private {
 	u32 gpio2_clk_out;
 	bool led_pin_enable[DP83822_MAX_LED_PINS];
 	int tx_amplitude_100base_tx_index;
+	int mac_termination_index;
 };
 
 static int dp83822_config_wol(struct phy_device *phydev,
@@ -533,6 +538,12 @@ static int dp83822_config_init(struct phy_device *phydev)
 			       FIELD_PREP(DP83822_100BASE_TX_LINE_DRIVER_SWING,
 					  dp83822->tx_amplitude_100base_tx_index));
 
+	if (dp83822->mac_termination_index >= 0)
+		phy_modify_mmd(phydev, MDIO_MMD_VEND2, MII_DP83822_IOCTRL,
+			       DP83822_IOCTRL_MAC_IMPEDANCE_CTRL,
+			       FIELD_PREP(DP83822_IOCTRL_MAC_IMPEDANCE_CTRL,
+					  dp83822->mac_termination_index));
+
 	err = dp83822_config_init_leds(phydev);
 	if (err)
 		return err;
@@ -736,6 +747,10 @@ static const u32 tx_amplitude_100base_tx_gain[] = {
 	93, 95, 97, 98, 100, 102, 103, 105,
 };
 
+static const u32 mac_termination[] = {
+	99, 91, 84, 78, 73, 69, 65, 61, 58, 55, 53, 50, 48, 46, 44, 43,
+};
+
 static int dp83822_of_init_leds(struct phy_device *phydev)
 {
 	struct device_node *node = phydev->mdio.dev.of_node;
@@ -852,6 +867,23 @@ static int dp83822_of_init(struct phy_device *phydev)
 		}
 	}
 
+	ret = phy_get_mac_termination(phydev, dev, &val);
+	if (!ret) {
+		for (i = 0; i < ARRAY_SIZE(mac_termination); i++) {
+			if (mac_termination[i] == val) {
+				dp83822->mac_termination_index = i;
+				break;
+			}
+		}
+
+		if (dp83822->mac_termination_index < 0) {
+			phydev_err(phydev,
+				   "Invalid value for mac-termination-ohms property (%u)\n",
+				   val);
+			return -EINVAL;
+		}
+	}
+
 	return dp83822_of_init_leds(phydev);
 }
 
@@ -931,6 +963,7 @@ static int dp8382x_probe(struct phy_device *phydev)
 		return -ENOMEM;
 
 	dp83822->tx_amplitude_100base_tx_index = -1;
+	dp83822->mac_termination_index = -1;
 	phydev->priv = dp83822;
 
 	return 0;

-- 
2.39.5



