Return-Path: <netdev+bounces-165088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C7FA305DB
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 09:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1CF03A4F14
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 08:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869041F0E56;
	Tue, 11 Feb 2025 08:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5rxFpor"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5161F0E48;
	Tue, 11 Feb 2025 08:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739262837; cv=none; b=ZXFRiCarLZnlhruDDAWH74JwU/NSXdc7zSr1TM6Kr4x0ENDguSUu+lePxgTPa0U9OZxXHOLgB+ZQo7NnEGlGT+qdlV6vqUrEvMQr/ZSLApS4+8OttVDWkjjSwEEgeDh1dz4UBk2m8SvqZZomySNUDUOjPf9KXm390xytKSgj4Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739262837; c=relaxed/simple;
	bh=OoAMzDnzmRmO0ZesIeeusKyjpaxqRVifD0eRg6O/C+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C5jx7PsFakpLdB4mcU+4icw6OcvPuctj8guKH+0n82n96Oecx3KWxX55Z8ax7xsJ3DF3k4/GbvZL4qCRjq+I7f6PMoJTXCii8CjKZG8I/Nzjql+UeeTt5XzOf/2rm0IHOVY6BrN898ELijXPHBrJ0Pv9a3Br33MCJyMbwIC+wCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5rxFpor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB421C4CEFB;
	Tue, 11 Feb 2025 08:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739262836;
	bh=OoAMzDnzmRmO0ZesIeeusKyjpaxqRVifD0eRg6O/C+c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=L5rxFporFUw+vJQySmHodnelJKyCv/ibXsq1JVmxQYWiVRetIDX0gyxnNS92AveFF
	 N47TrkfRhBOvhiTZd2CxJYWLbxpwV0X6VaZiCexKXjg8dQ2U/umP+pKJCJSneaxHex
	 oicF1ulDLxKTPOzD0D0Jbd9nZXK0PLC3yu7pBlZnYPiB2goA5yFcHwEM7zNNs7ou0I
	 zj1xL4DWqDaxU2UcmuXTk7HuD36FwMmPqfqM5MwfzJx6oDezjQaJpTzd16OYhwljPl
	 3/sHT7sSEX1KbKzqQOQqlYn7gc7g+GeO91zMmmTQUmcBerymikavoauzR4gc9YoHQi
	 XzbtVVzghEwMw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734F6C0219D;
	Tue, 11 Feb 2025 08:33:56 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Tue, 11 Feb 2025 09:33:49 +0100
Subject: [PATCH net-next v4 3/3] net: phy: dp83822: Add support for
 changing the transmit amplitude voltage
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-dp83822-tx-swing-v4-3-1e8ebd71ad54@liebherr.com>
References: <20250211-dp83822-tx-swing-v4-0-1e8ebd71ad54@liebherr.com>
In-Reply-To: <20250211-dp83822-tx-swing-v4-0-1e8ebd71ad54@liebherr.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739262831; l=3488;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=Or6PDXKPMq4kk1AHxpqPQpxSNSkTyzooFMkd9jkPUKk=;
 b=xYqKd/7Ffvi2j2LFH5r9G4bvuHSZ6ADPQYa22iDmjbpIGIpdGaJhk3eEVm2gwfoG+gP+0BbPC
 XRcleH+EAYGCqstGUpWWGQzFdStLmZHcLfnnK/MNwqEHJaKKLg3V10a
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
 drivers/net/phy/dp83822.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index 6599feca1967d705331d6e354205a2485ea962f2..3662f3905d5ade8ad933608fcaeabb714a588418 100644
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
+	80, 82, 83, 85, 87, 88, 90, 92,
+	93, 95, 97, 98, 100, 102, 103, 105,
+};
+
 static int dp83822_of_init_leds(struct phy_device *phydev)
 {
 	struct device_node *node = phydev->mdio.dev.of_node;
@@ -780,6 +796,8 @@ static int dp83822_of_init(struct phy_device *phydev)
 	struct dp83822_private *dp83822 = phydev->priv;
 	struct device *dev = &phydev->mdio.dev;
 	const char *of_val;
+	int i, ret;
+	u32 val;
 
 	/* Signal detection for the PHY is only enabled if the FX_EN and the
 	 * SD_EN pins are strapped. Signal detection can only enabled if FX_EN
@@ -815,6 +833,26 @@ static int dp83822_of_init(struct phy_device *phydev)
 		dp83822->set_gpio2_clk_out = true;
 	}
 
+	dp83822->tx_amplitude_100base_tx_index = -1;
+	ret = phy_get_tx_amplitude_gain(phydev, dev,
+					ETHTOOL_LINK_MODE_100baseT_Full_BIT,
+					&val);
+	if (!ret) {
+		for (i = 0; i < ARRAY_SIZE(tx_amplitude_100base_tx_gain); i++) {
+			if (tx_amplitude_100base_tx_gain[i] == val) {
+				dp83822->tx_amplitude_100base_tx_index = i;
+				break;
+			}
+		}
+
+		if (dp83822->tx_amplitude_100base_tx_index < 0) {
+			phydev_err(phydev,
+				   "Invalid value for tx-amplitude-100base-tx-percent property (%u)\n",
+				   val);
+			return -EINVAL;
+		}
+	}
+
 	return dp83822_of_init_leds(phydev);
 }
 

-- 
2.39.5



