Return-Path: <netdev+bounces-151322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E6D9EE1AA
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 09:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DF622834F3
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 08:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6800020E02C;
	Thu, 12 Dec 2024 08:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXx7OBxc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301D820DD79;
	Thu, 12 Dec 2024 08:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733993057; cv=none; b=VTllN4GYB5VbePtHA810tPIweHyHHEgYfml30z5dosQ/t6DjS8pKna2QIFx5yY3D8kWure5YJGI0XX+ABtS/l/+NfniswBI9sySjOL5dWjLoJpETSiTbxW2BKcprj/xj0esDtkf3rlpHlKrgO5XBlkCiWks78Evk4dO1BEkwC7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733993057; c=relaxed/simple;
	bh=QA5JVwPUGPpNQHXJ2rFyBx16z4DecAsSGIJ5SdiPhIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jPZRoIg5tyH81G3MRwBE9c8ifGDU0BhJNs+TRb3QOUxhjlVm3kL7UDd/PTOBk+NZT1ynvIs/F8/8gyVGZ/D/0eFkIcAXEiOAQHnnIuY7sQWl19xl8dzZWKF/1PeP4QTOH7Yt1H6njSwkchKpg8Z27gUXkGse8nZ/jEQ5+8BLPx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXx7OBxc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6F34C4CED4;
	Thu, 12 Dec 2024 08:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733993056;
	bh=QA5JVwPUGPpNQHXJ2rFyBx16z4DecAsSGIJ5SdiPhIU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DXx7OBxcFAyGwAyRhLgo/2WPVggJV+blEmpGZqLDnaxKLLDkfWp1hM6b3CRCwWAE6
	 KTyjyUAOV8YiDOLstlQkhyPkEqZdmq+rpqs5eENokxoT4uZC/8jpjfjDTyRT88axyw
	 +mso+XWEeTa/8QTbRBKFuCIKRnl+3rLok93bI92CJSVzCDBm5/PNX2V5skMg2be/Z2
	 XEaiLmRXH/+zoCuQxZx28tOwC3OCCWrsJa5AgH+IuUzdxz1xE7T3hZbgpFh6iiZhm9
	 XnfRuilNHW9IBenrmZAanudr6nz6B5sFHI01WDuIoovPHCPAbAFiAdoun+yHfJnBMx
	 8OJDKD6UoUEVA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6902E77183;
	Thu, 12 Dec 2024 08:44:16 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Thu, 12 Dec 2024 09:44:07 +0100
Subject: [PATCH net-next v3 2/2] net: phy: dp83822: Add support for GPIO2
 clock output
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-dp83822-gpio2-clk-out-v3-2-e4af23490f44@liebherr.com>
References: <20241212-dp83822-gpio2-clk-out-v3-0-e4af23490f44@liebherr.com>
In-Reply-To: <20241212-dp83822-gpio2-clk-out-v3-0-e4af23490f44@liebherr.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733993055; l=3688;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=8vNC532plUP4IGqLwiYlEq3xWmFx4qwBlb44h2NCtjU=;
 b=H0BtmX5BYZhsh3jBWob2FmLYnNpPWjJQvO+YL2bnCAL1YocLdEAo65UsDEOoEK5ZYYQJMtK85
 tKih3uXcaMyDOW0PikNMliMYKI17ldxDc/YXBPMvnJTe8l21dso5Mvy
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
 drivers/net/phy/dp83822.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index 25ee09c48027c86b7d8f4acb5cbe2e157c56a85a..334c17a68edd7c2a0f707b3ccafaa7a870818fbe 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -30,6 +30,7 @@
 #define MII_DP83822_FCSCR	0x14
 #define MII_DP83822_RCSR	0x17
 #define MII_DP83822_RESET_CTRL	0x1f
+#define MII_DP83822_IOCTRL2	0x463
 #define MII_DP83822_GENCFG	0x465
 #define MII_DP83822_SOR1	0x467
 
@@ -104,6 +105,18 @@
 #define DP83822_RX_CLK_SHIFT	BIT(12)
 #define DP83822_TX_CLK_SHIFT	BIT(11)
 
+/* IOCTRL2 bits */
+#define DP83822_IOCTRL2_GPIO2_CLK_SRC		GENMASK(6, 4)
+#define DP83822_IOCTRL2_GPIO2_CTRL		GENMASK(2, 0)
+#define DP83822_IOCTRL2_GPIO2_CTRL_CLK_REF	GENMASK(1, 0)
+
+#define DP83822_CLK_SRC_MAC_IF			0x0
+#define DP83822_CLK_SRC_XI			0x1
+#define DP83822_CLK_SRC_INT_REF			0x2
+#define DP83822_CLK_SRC_RMII_MASTER_MODE_REF	0x4
+#define DP83822_CLK_SRC_FREE_RUNNING		0x6
+#define DP83822_CLK_SRC_RECOVERED		0x7
+
 /* SOR1 mode */
 #define DP83822_STRAP_MODE1	0
 #define DP83822_STRAP_MODE2	BIT(0)
@@ -139,6 +152,8 @@ struct dp83822_private {
 	u8 cfg_dac_minus;
 	u8 cfg_dac_plus;
 	struct ethtool_wolinfo wol;
+	bool set_gpio2_clk_out;
+	u32 gpio2_clk_out;
 };
 
 static int dp83822_config_wol(struct phy_device *phydev,
@@ -413,6 +428,15 @@ static int dp83822_config_init(struct phy_device *phydev)
 	int err = 0;
 	int bmcr;
 
+	if (dp83822->set_gpio2_clk_out)
+		phy_modify_mmd(phydev, MDIO_MMD_VEND2, MII_DP83822_IOCTRL2,
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
@@ -611,6 +635,7 @@ static int dp83822_of_init(struct phy_device *phydev)
 {
 	struct dp83822_private *dp83822 = phydev->priv;
 	struct device *dev = &phydev->mdio.dev;
+	const char *of_val;
 
 	/* Signal detection for the PHY is only enabled if the FX_EN and the
 	 * SD_EN pins are strapped. Signal detection can only enabled if FX_EN
@@ -623,6 +648,29 @@ static int dp83822_of_init(struct phy_device *phydev)
 		dp83822->fx_enabled = device_property_present(dev,
 							      "ti,fiber-mode");
 
+	if (!device_property_read_string(dev, "ti,gpio2-clk-out", &of_val)) {
+		if (strcmp(of_val, "mac-if") == 0) {
+			dp83822->gpio2_clk_out = DP83822_CLK_SRC_MAC_IF;
+		} else if (strcmp(of_val, "xi") == 0) {
+			dp83822->gpio2_clk_out = DP83822_CLK_SRC_XI;
+		} else if (strcmp(of_val, "int-ref") == 0) {
+			dp83822->gpio2_clk_out = DP83822_CLK_SRC_INT_REF;
+		} else if (strcmp(of_val, "rmii-master-mode-ref") == 0) {
+			dp83822->gpio2_clk_out = DP83822_CLK_SRC_RMII_MASTER_MODE_REF;
+		} else if (strcmp(of_val, "free-running") == 0) {
+			dp83822->gpio2_clk_out = DP83822_CLK_SRC_FREE_RUNNING;
+		} else if (strcmp(of_val, "recovered") == 0) {
+			dp83822->gpio2_clk_out = DP83822_CLK_SRC_RECOVERED;
+		} else {
+			phydev_err(phydev,
+				   "Invalid value for ti,gpio2-clk-out property (%s)\n",
+				   of_val);
+			return -EINVAL;
+		}
+
+		dp83822->set_gpio2_clk_out = true;
+	}
+
 	return 0;
 }
 

-- 
2.39.5



