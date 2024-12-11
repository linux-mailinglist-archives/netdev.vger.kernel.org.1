Return-Path: <netdev+bounces-151020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EBF9EC67E
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 09:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3302A28411B
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 08:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42CA1D31A5;
	Wed, 11 Dec 2024 08:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifR7if7Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C7F1CBE8C;
	Wed, 11 Dec 2024 08:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904293; cv=none; b=I3Bt99oF3UieRgDEfr2+xrJBcm+KGGN+tFcHEXJNHwsDLGJpX+rPLzgQK9p8pmwSEsWlg0s3Zkyfo4YDi+iR9Za7g9R2GEVT/nS5pQAiocI54yR+OrzL0meCgTxmSBrU15/nutsQoL/hwXysebUzkNOS4Wl9sNn+SIhD2sv4fBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904293; c=relaxed/simple;
	bh=/SwR3WBX/5RiStwbhzSqQodMFhGLLTKGvjGqpDQMhcA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XKDbGrARxpv7CP4zgDxPGa5l7xcCaV1N+746ijqLVyv503t9qAdLfpUG9wCchkq0Y85cJYIxxBh3AFvnE7DO5DcPqHdbdqHWm6hmezuaHFNpS+3aOWCzV6IF++0Z5mpflotTmJABgqoE1SNQ9qZAQUdM1bD4jc8LaulLkeA3j80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifR7if7Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A002C4CEDF;
	Wed, 11 Dec 2024 08:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733904293;
	bh=/SwR3WBX/5RiStwbhzSqQodMFhGLLTKGvjGqpDQMhcA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ifR7if7Q4DWdlfzRgS5Rt+28t5UCXYo2/auU2HjmhTCQQE67UvMyEaxE9rhb7Mu+I
	 xeqLpMbU3NMRimERyvMd+/p3B2Lpq6FYtANnka481G70E8lWotYaqn8ld6Y4Kbmen0
	 5l7JOb7lHaaaUVyKjlxi9XXDUG3G7h788O7gkq0n+BzcnNvKYHx7wYyRZ/C31wCrtt
	 +lYcjoTeYOY1slRekeVb2jBbmesWG8nTvvdSuzeljeVLdlbvAHxvLGihek35yxCSPx
	 1pa/LN7ov4G9jArzkD58GtTZJGqlukpaHV7fWtepd9kGa1iX2ybVrbj5SGa5UWiFWa
	 8YiZ2jEwL+4pw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47949E77183;
	Wed, 11 Dec 2024 08:04:53 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Wed, 11 Dec 2024 09:04:40 +0100
Subject: [PATCH net-next v2 2/2] net: phy: dp83822: Add support for GPIO2
 clock output
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-dp83822-gpio2-clk-out-v2-2-614a54f6acab@liebherr.com>
References: <20241211-dp83822-gpio2-clk-out-v2-0-614a54f6acab@liebherr.com>
In-Reply-To: <20241211-dp83822-gpio2-clk-out-v2-0-614a54f6acab@liebherr.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733904292; l=3323;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=ocCCgiir9YwkF+ZSQqZS9864rONkKgcoc4c4WnPnqVY=;
 b=yv1U8A6QoIBwBBqKl4gSs2JSbfnbvmc98aZjStsY5+TxTQTke+7Ebc67gEeHDX/hUj8EcZK04
 Ps6bx+EPbexAPRquU4pgDp6wU31AMnTQtjN2QvhKgCRAu5H5DiDfufA
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
 drivers/net/phy/dp83822.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index 25ee09c48027c86b7d8f4acb5cbe2e157c56a85a..dc5595eae6cc74e5c77914d53772c5fad64c3e70 100644
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
@@ -30,6 +32,7 @@
 #define MII_DP83822_FCSCR	0x14
 #define MII_DP83822_RCSR	0x17
 #define MII_DP83822_RESET_CTRL	0x1f
+#define MII_DP83822_IOCTRL2	0x463
 #define MII_DP83822_GENCFG	0x465
 #define MII_DP83822_SOR1	0x467
 
@@ -104,6 +107,11 @@
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
@@ -139,6 +147,8 @@ struct dp83822_private {
 	u8 cfg_dac_minus;
 	u8 cfg_dac_plus;
 	struct ethtool_wolinfo wol;
+	bool set_gpio2_clk_out;
+	u32 gpio2_clk_out;
 };
 
 static int dp83822_config_wol(struct phy_device *phydev,
@@ -413,6 +423,15 @@ static int dp83822_config_init(struct phy_device *phydev)
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
@@ -611,6 +630,7 @@ static int dp83822_of_init(struct phy_device *phydev)
 {
 	struct dp83822_private *dp83822 = phydev->priv;
 	struct device *dev = &phydev->mdio.dev;
+	int ret;
 
 	/* Signal detection for the PHY is only enabled if the FX_EN and the
 	 * SD_EN pins are strapped. Signal detection can only enabled if FX_EN
@@ -623,6 +643,26 @@ static int dp83822_of_init(struct phy_device *phydev)
 		dp83822->fx_enabled = device_property_present(dev,
 							      "ti,fiber-mode");
 
+	ret = of_property_read_u32(dev->of_node, "ti,gpio2-clk-out",
+				   &dp83822->gpio2_clk_out);
+	if (!ret) {
+		switch (dp83822->gpio2_clk_out) {
+		case DP83822_CLK_SRC_MAC_IF:
+		case DP83822_CLK_SRC_XI:
+		case DP83822_CLK_SRC_INT_REF:
+		case DP83822_CLK_SRC_RMII_MASTER_MODE_REF:
+		case DP83822_CLK_SRC_FREE_RUNNING:
+		case DP83822_CLK_SRC_RECOVERED:
+			break;
+		default:
+			phydev_err(phydev, "ti,gpio2-clk-out value %u not valid\n",
+				   dp83822->gpio2_clk_out);
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



