Return-Path: <netdev+bounces-185055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4C4A98678
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 11:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 578581B65421
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 09:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BC4262FF7;
	Wed, 23 Apr 2025 09:52:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F14244664;
	Wed, 23 Apr 2025 09:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745401957; cv=none; b=cIbdEI5RzCZSnYUcSiG/JLeI3hkcUHctTq6Yq16n8uUXls0WtDj9c7ZXgQBUIFbYvfZsd70wo3t+QxRZOHxkhr3rKdX+JB8x9D93FCbtEg4nQh+jeKw/5Z3MjsyWAft0ePGpqQSfZL53bVTXmXC2iiJrFEU2g3c0hb6QMI2pOpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745401957; c=relaxed/simple;
	bh=eng0Kl1y21wM6mLTFLHDhzUYy9jCSvV0putd8xHi5Ro=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jDbKiqwulQ4ESDEHGE+W00JjKaDWi96HevHA7Kbb+6O6DYkgdVdj5cQJkQy9s7wz2b7RCDcotlbxe9JzHlPlAYTrCFWB7qzbNvnkk+T+vkXE/d5UWl/6qlBCNdlBW+EaZug/PiBx2Q7eyLoT9i5y3uj837MsNNyXvVDXixnEYAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB64B2B;
	Wed, 23 Apr 2025 02:52:29 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DC8F3F59E;
	Wed, 23 Apr 2025 02:52:32 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Corentin Labbe <clabbe.montjoie@gmail.com>,
	Yixun Lan <dlan@gentoo.org>,
	Maxime Ripard <mripard@kernel.org>,
	netdev@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next] net: stmmac: sun8i: drop unneeded default syscon value
Date: Wed, 23 Apr 2025 10:52:22 +0100
Message-Id: <20250423095222.1517507-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For some odd reason we are very picky about the value of the EMAC clock
register from the syscon block, insisting on a certain reset value and
only doing read-modify-write operations on that register, even though we
pretty much know the register layout.
This already led to a basically redundant variant entry for the H6, which
only differs by that value. We will have the same situation with the new
A523 SoC, which again is compatible to the A64, but has a different syscon
reset value.

Drop any assumptions about that value, and set or clear the bits that we
want to program, from scratch (starting with a value of 0). For the
remove() implementation, we just turn on the POWERDOWN bit, and deselect
the internal PHY, which mimics the existing code.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
Hi,

if anyone can shed some light on why we had this value and its handling
in the first place, I would be grateful. I don't really get its purpose,
and especially the warning message about the reset value seems odd.
I briefly tested this on A523, H3, H6, but would be glad to see more
testing on this.

Cheers,
Andre

 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 47 ++-----------------
 1 file changed, 4 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 85723a78793ab..0f8d29763a909 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -31,10 +31,6 @@
  */
 
 /* struct emac_variant - Describe dwmac-sun8i hardware variant
- * @default_syscon_value:	The default value of the EMAC register in syscon
- *				This value is used for disabling properly EMAC
- *				and used as a good starting value in case of the
- *				boot process(uboot) leave some stuff.
  * @syscon_field		reg_field for the syscon's gmac register
  * @soc_has_internal_phy:	Does the MAC embed an internal PHY
  * @support_mii:		Does the MAC handle MII
@@ -48,7 +44,6 @@
  *				value of zero indicates this is not supported.
  */
 struct emac_variant {
-	u32 default_syscon_value;
 	const struct reg_field *syscon_field;
 	bool soc_has_internal_phy;
 	bool support_mii;
@@ -94,7 +89,6 @@ static const struct reg_field sun8i_ccu_reg_field = {
 };
 
 static const struct emac_variant emac_variant_h3 = {
-	.default_syscon_value = 0x58000,
 	.syscon_field = &sun8i_syscon_reg_field,
 	.soc_has_internal_phy = true,
 	.support_mii = true,
@@ -105,14 +99,12 @@ static const struct emac_variant emac_variant_h3 = {
 };
 
 static const struct emac_variant emac_variant_v3s = {
-	.default_syscon_value = 0x38000,
 	.syscon_field = &sun8i_syscon_reg_field,
 	.soc_has_internal_phy = true,
 	.support_mii = true
 };
 
 static const struct emac_variant emac_variant_a83t = {
-	.default_syscon_value = 0,
 	.syscon_field = &sun8i_syscon_reg_field,
 	.soc_has_internal_phy = false,
 	.support_mii = true,
@@ -122,7 +114,6 @@ static const struct emac_variant emac_variant_a83t = {
 };
 
 static const struct emac_variant emac_variant_r40 = {
-	.default_syscon_value = 0,
 	.syscon_field = &sun8i_ccu_reg_field,
 	.support_mii = true,
 	.support_rgmii = true,
@@ -130,7 +121,6 @@ static const struct emac_variant emac_variant_r40 = {
 };
 
 static const struct emac_variant emac_variant_a64 = {
-	.default_syscon_value = 0,
 	.syscon_field = &sun8i_syscon_reg_field,
 	.soc_has_internal_phy = false,
 	.support_mii = true,
@@ -141,7 +131,6 @@ static const struct emac_variant emac_variant_a64 = {
 };
 
 static const struct emac_variant emac_variant_h6 = {
-	.default_syscon_value = 0x50000,
 	.syscon_field = &sun8i_syscon_reg_field,
 	/* The "Internal PHY" of H6 is not on the die. It's on the
 	 * co-packaged AC200 chip instead.
@@ -933,25 +922,11 @@ static int sun8i_dwmac_set_syscon(struct device *dev,
 	struct sunxi_priv_data *gmac = plat->bsp_priv;
 	struct device_node *node = dev->of_node;
 	int ret;
-	u32 reg, val;
-
-	ret = regmap_field_read(gmac->regmap_field, &val);
-	if (ret) {
-		dev_err(dev, "Fail to read from regmap field.\n");
-		return ret;
-	}
-
-	reg = gmac->variant->default_syscon_value;
-	if (reg != val)
-		dev_warn(dev,
-			 "Current syscon value is not the default %x (expect %x)\n",
-			 val, reg);
+	u32 reg = 0, val;
 
 	if (gmac->variant->soc_has_internal_phy) {
 		if (of_property_read_bool(node, "allwinner,leds-active-low"))
 			reg |= H3_EPHY_LED_POL;
-		else
-			reg &= ~H3_EPHY_LED_POL;
 
 		/* Force EPHY xtal frequency to 24MHz. */
 		reg |= H3_EPHY_CLK_SEL;
@@ -965,11 +940,6 @@ static int sun8i_dwmac_set_syscon(struct device *dev,
 		 * address. No need to mask it again.
 		 */
 		reg |= 1 << H3_EPHY_ADDR_SHIFT;
-	} else {
-		/* For SoCs without internal PHY the PHY selection bit should be
-		 * set to 0 (external PHY).
-		 */
-		reg &= ~H3_EPHY_SELECT;
 	}
 
 	if (!of_property_read_u32(node, "allwinner,tx-delay-ps", &val)) {
@@ -980,8 +950,6 @@ static int sun8i_dwmac_set_syscon(struct device *dev,
 		val /= 100;
 		dev_dbg(dev, "set tx-delay to %x\n", val);
 		if (val <= gmac->variant->tx_delay_max) {
-			reg &= ~(gmac->variant->tx_delay_max <<
-				 SYSCON_ETXDC_SHIFT);
 			reg |= (val << SYSCON_ETXDC_SHIFT);
 		} else {
 			dev_err(dev, "Invalid TX clock delay: %d\n",
@@ -998,8 +966,6 @@ static int sun8i_dwmac_set_syscon(struct device *dev,
 		val /= 100;
 		dev_dbg(dev, "set rx-delay to %x\n", val);
 		if (val <= gmac->variant->rx_delay_max) {
-			reg &= ~(gmac->variant->rx_delay_max <<
-				 SYSCON_ERXDC_SHIFT);
 			reg |= (val << SYSCON_ERXDC_SHIFT);
 		} else {
 			dev_err(dev, "Invalid RX clock delay: %d\n",
@@ -1008,11 +974,6 @@ static int sun8i_dwmac_set_syscon(struct device *dev,
 		}
 	}
 
-	/* Clear interface mode bits */
-	reg &= ~(SYSCON_ETCS_MASK | SYSCON_EPIT);
-	if (gmac->variant->support_rmii)
-		reg &= ~SYSCON_RMII_EN;
-
 	switch (plat->mac_interface) {
 	case PHY_INTERFACE_MODE_MII:
 		/* default */
@@ -1039,9 +1000,9 @@ static int sun8i_dwmac_set_syscon(struct device *dev,
 
 static void sun8i_dwmac_unset_syscon(struct sunxi_priv_data *gmac)
 {
-	u32 reg = gmac->variant->default_syscon_value;
-
-	regmap_field_write(gmac->regmap_field, reg);
+	if (gmac->variant->soc_has_internal_phy)
+		regmap_field_write(gmac->regmap_field,
+				   (H3_EPHY_SHUTDOWN | H3_EPHY_SELECT));
 }
 
 static void sun8i_dwmac_exit(struct platform_device *pdev, void *priv)
-- 
2.25.1


