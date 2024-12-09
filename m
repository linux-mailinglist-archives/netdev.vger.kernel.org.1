Return-Path: <netdev+bounces-150070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9F89E8CEB
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 09:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51B221886A24
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 08:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF8A2156FD;
	Mon,  9 Dec 2024 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTPoOeDh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A021721519F;
	Mon,  9 Dec 2024 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733731309; cv=none; b=se+XdQep62hmEtcnSC/BjMhQyUhCATB33DRsBtMPohnM2uG1gYv9lxnjzo9EWyofGLPuKsP9yywswB5YuQS0xKYV1Xj//yteu9NePU819nopX9EvhB8NKcUUAfy8PebjN2k1muJfRF+uOFlQjDSvIG/4SnaOZWjZNfqRCD7/oYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733731309; c=relaxed/simple;
	bh=XMmsY6vSywq5pqojbybHw6MFnu5EFPSgpxQ+Chp+LZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sdJGyzUCFKhchKrHoxeMk9ZmLvnyhhRcAJBm3qJyF87O1Zzza1KypA2REi7QfUatigR8tplOKTMWy55J4XdfH4rOLYAFxZQg8iNB8rW54X96ZKUo5RcZNzXaA/M57KNdpOmU/xx3gAC5WBVUFubH7Gb2bEgVJROHCGhzzFEZ7pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTPoOeDh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 157E5C4CEE0;
	Mon,  9 Dec 2024 08:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733731309;
	bh=XMmsY6vSywq5pqojbybHw6MFnu5EFPSgpxQ+Chp+LZY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LTPoOeDhnR1KhMv0Dpi/svrxQ+/zkMHw8PQWgUThHmobmgYemRKBBqATf8hbEWyK2
	 qa9j19QZv4RTW/cI52ZCzDDh379U6Y24WSQeDvenWIhir8fLlG7emurMBmXyAS3137
	 IVhCEwp+wdqgbZOXgLVb1UWwUdoFRwJ8LaRTskF/3xirAOoOKJ27ICbo7mBnsOPsCt
	 oMemvZc/8SckKNhDuvYimxGrtn4rW1hBkdbRrHKd16HkjcPbN548Jjn9p9INkRhPhD
	 tzC8Bqp3IOmCvwvcgLYX30M8qbzr7ECZNX1qUpe8dJrL6CpZpJ8m+6G2qBV/XW7Q4A
	 QAcuNlS1EzHjw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031D2E77181;
	Mon,  9 Dec 2024 08:01:49 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Mon, 09 Dec 2024 09:01:28 +0100
Subject: [PATCH net-next 2/2] net: phy: dp83822: Add support for GPIO2
 clock output
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-dp83822-gpio2-clk-out-v1-2-fd3c8af59ff5@liebherr.com>
References: <20241209-dp83822-gpio2-clk-out-v1-0-fd3c8af59ff5@liebherr.com>
In-Reply-To: <20241209-dp83822-gpio2-clk-out-v1-0-fd3c8af59ff5@liebherr.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733731307; l=3387;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=+5oy5JM7MjH9Hc6sWExhve+FSfnhs7DrBAy0XVFi3K0=;
 b=+yNF54o5d7WetSzBSMyi2D3Yu8++eOTV7qlp5Qh6orhx4nd62W0nJAAlri4PPOHUcZxsmkceO
 QNwWYW8By2vCrs8aD5406iLjqMsQX8jcR7VGFbkphVln8vd8VkDIi5z
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

The GPIO2 pin on the DP83822 can be configured as clock output. Add support
for configuration via DT.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 drivers/net/phy/dp83822.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index cf8b6d0bfaa9812eee98c612c0d4259d87da7572..2abb066c3b8fe701c551c278ba31a08f9cb3fc15 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -14,6 +14,8 @@
 #include <linux/netdevice.h>
 #include <linux/bitfield.h>
 
+#include <dt-bindings/net/ti-dp83822.h>
+
 #define DP83822_PHY_ID	        0x2000a240
 #define DP83825S_PHY_ID		0x2000a140
 #define DP83825I_PHY_ID		0x2000a150
@@ -33,6 +35,7 @@
 #define MII_DP83822_RCSR	0x17
 #define MII_DP83822_RESET_CTRL	0x1f
 #define MII_DP83822_GENCFG	0x465
+#define MII_DP83822_IOCTRL2	0x463
 #define MII_DP83822_SOR1	0x467
 
 /* DP83826 specific registers */
@@ -106,6 +109,11 @@
 #define DP83822_RX_CLK_SHIFT	BIT(12)
 #define DP83822_TX_CLK_SHIFT	BIT(11)
 
+/* IOCTRL2 bits */
+#define DP83822_IOCTRL2_GPIO2_CLK_SRC		GENMASK(6, 4)
+#define DP83822_IOCTRL2_GPIO2_CTRL		GENMASK(2, 0)
+#define DP83822_IOCTRL2_GPIO2_CTRL_CLK_REF	GENMASK(1, 0)
+
 /* SOR1 mode */
 #define DP83822_STRAP_MODE1	0
 #define DP83822_STRAP_MODE2	BIT(0)
@@ -141,6 +149,8 @@ struct dp83822_private {
 	u8 cfg_dac_minus;
 	u8 cfg_dac_plus;
 	struct ethtool_wolinfo wol;
+	bool set_gpio2_clk_out;
+	u32 gpio2_clk_out;
 };
 
 static int dp83822_config_wol(struct phy_device *phydev,
@@ -415,6 +425,15 @@ static int dp83822_config_init(struct phy_device *phydev)
 	int err = 0;
 	int bmcr;
 
+	if (dp83822->set_gpio2_clk_out)
+		phy_modify_mmd(phydev, DP83822_DEVADDR, MII_DP83822_IOCTRL2,
+			       DP83822_IOCTRL2_GPIO2_CTRL |
+			       DP83822_IOCTRL2_GPIO2_CLK_SRC,
+			       FIELD_PREP(DP83822_IOCTRL2_GPIO2_CTRL,
+					  DP83822_IOCTRL2_GPIO2_CTRL_CLK_REF) |
+			       FIELD_PREP(DP83822_IOCTRL2_GPIO2_CLK_SRC,
+					  dp83822->gpio2_clk_out));
+
 	if (phy_interface_is_rgmii(phydev)) {
 		rx_int_delay = phy_get_internal_delay(phydev, dev, NULL, 0,
 						      true);
@@ -613,6 +632,7 @@ static int dp83822_of_init(struct phy_device *phydev)
 {
 	struct dp83822_private *dp83822 = phydev->priv;
 	struct device *dev = &phydev->mdio.dev;
+	int ret;
 
 	/* Signal detection for the PHY is only enabled if the FX_EN and the
 	 * SD_EN pins are strapped. Signal detection can only enabled if FX_EN
@@ -625,6 +645,30 @@ static int dp83822_of_init(struct phy_device *phydev)
 		dp83822->fx_enabled = device_property_present(dev,
 							      "ti,fiber-mode");
 
+	ret = of_property_read_u32(dev->of_node, "ti,gpio2-clk-out",
+				   &dp83822->gpio2_clk_out);
+	if (!ret) {
+		dp83822->set_gpio2_clk_out = true;
+		switch (dp83822->gpio2_clk_out) {
+		case DP83822_CLK_SRC_MAC_IF:
+			break;
+		case DP83822_CLK_SRC_XI:
+			break;
+		case DP83822_CLK_SRC_INT_REF:
+			break;
+		case DP83822_CLK_SRC_RMII_MASTER_MODE_REF:
+			break;
+		case DP83822_CLK_SRC_FREE_RUNNING:
+			break;
+		case DP83822_CLK_SRC_RECOVERED:
+			break;
+		default:
+			phydev_err(phydev, "ti,gpio2-clk-out value %u not valid\n",
+				   dp83822->gpio2_clk_out);
+			return -EINVAL;
+		}
+	}
+
 	return 0;
 }
 

-- 
2.39.5



