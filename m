Return-Path: <netdev+bounces-159779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3BDA16DC1
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 14:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D49241888DE1
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 13:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6FE1E2615;
	Mon, 20 Jan 2025 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bna1RtY8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3071E25E4;
	Mon, 20 Jan 2025 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737381030; cv=none; b=OvSa+73vPq9Zy9UPeTtoaChrs+T99RJvWwry9KycTNQof67bJkGCUhTlvtwCcbqAC5up5HMLFAKoYDnGbnmpLvMKXnb/mXrLqkuU2Grygs50+seZQ1bjJTgQxl22Li7os7Lt90aKp17VWbpageq3ZkDS5ZWp0xDyNrDIobmSmY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737381030; c=relaxed/simple;
	bh=5QUzy70Aht17qVvxw78UZoTUeK4o09d7iHlDFj0Xk4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ah+3zp0FdSQDBmaHCnGu9NHo3VU7xeuPlbrPCqOOWUU191efMY9dncggQLkVRzTIIMtz9psxGCnEfmcHCh8Z5nbtWW+M72FifZKKJukNYlJiVzC2f83999Epcaue9WekpgDEafpEHRlrUMbQ1Wi1UwXVqLmYR9ErXveuGV0qDGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bna1RtY8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D0E8C4CEE1;
	Mon, 20 Jan 2025 13:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737381030;
	bh=5QUzy70Aht17qVvxw78UZoTUeK4o09d7iHlDFj0Xk4Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Bna1RtY8XugYTApM+IpYh8J6Ss2Bk88HY0kgX+FvO3qE434NIxPtGsWloFGeXYkgI
	 T7jgpT9N0KisCmxPt/xCV6ZJhKUymgmXiVivLs05dFWu9niQnku5KjjzyOZ0GY0DTw
	 JKEDUSEOA2Lx36tTN/ep+KxfLDXEziTvkSS+p6rbSEkw9kvWea7A5IQ3ovvNFXWiUQ
	 3RKvmcUBCxEp7HxZOJgmp9qCDi0h4cqixean/GmKY9CA7xQjArTiUF/L+OaYYILdUu
	 Tutda+fyPmfK3a43eO/9dTvs2r/J07iAcjBVtfJfCr82nx5NGQsFJdWrlIJBwFoqF7
	 bY59ifDlOWtdg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219B8C02181;
	Mon, 20 Jan 2025 13:50:30 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Mon, 20 Jan 2025 14:50:22 +0100
Subject: [PATCH net-next v2 2/3] net: phy: Add helper for getting tx
 amplitude gain
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250120-dp83822-tx-swing-v2-2-07c99dc42627@liebherr.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737381028; l=3500;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=4NxnBs1iNWySfnRdwhDBtFEJqfO2yBjZ3zEEArurays=;
 b=Y6WsBzg2QbyamQ/T3MAMpH2WeREOUw1kk/Yl0CNEGrJYmxlphtQKiDbmsmabmGMCO9W2nM/Hy
 AU4VmKAOJGPBXUyEI7y0eSQQhd/X/YVi4gAVywmW8gSvjQJG1gF68E5
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Add helper which returns the tx amplitude gain defined in device tree.
Modifying it can be necessary to compensate losses on the PCB and
connector, so the voltages measured on the RJ45 pins are conforming.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 drivers/net/phy/phy_device.c | 20 ++++++++++++++++----
 include/linux/phy.h          |  3 +++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 46713d27412b76077d2e51e29b8d84f4f8f0a86d..7bc48f9493ceda21311748a3efa0a222dc0683dc 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3096,7 +3096,7 @@ void phy_get_pause(struct phy_device *phydev, bool *tx_pause, bool *rx_pause)
 EXPORT_SYMBOL(phy_get_pause);
 
 #if IS_ENABLED(CONFIG_OF_MDIO)
-static int phy_get_int_delay_property(struct device *dev, const char *name)
+static int phy_get_u32_property(struct device *dev, const char *name)
 {
 	s32 int_delay;
 	int ret;
@@ -3108,7 +3108,7 @@ static int phy_get_int_delay_property(struct device *dev, const char *name)
 	return int_delay;
 }
 #else
-static int phy_get_int_delay_property(struct device *dev, const char *name)
+static int phy_get_u32_property(struct device *dev, const char *name)
 {
 	return -EINVAL;
 }
@@ -3137,7 +3137,7 @@ s32 phy_get_internal_delay(struct phy_device *phydev, struct device *dev,
 	int i;
 
 	if (is_rx) {
-		delay = phy_get_int_delay_property(dev, "rx-internal-delay-ps");
+		delay = phy_get_u32_property(dev, "rx-internal-delay-ps");
 		if (delay < 0 && size == 0) {
 			if (phydev->interface == PHY_INTERFACE_MODE_RGMII_ID ||
 			    phydev->interface == PHY_INTERFACE_MODE_RGMII_RXID)
@@ -3147,7 +3147,7 @@ s32 phy_get_internal_delay(struct phy_device *phydev, struct device *dev,
 		}
 
 	} else {
-		delay = phy_get_int_delay_property(dev, "tx-internal-delay-ps");
+		delay = phy_get_u32_property(dev, "tx-internal-delay-ps");
 		if (delay < 0 && size == 0) {
 			if (phydev->interface == PHY_INTERFACE_MODE_RGMII_ID ||
 			    phydev->interface == PHY_INTERFACE_MODE_RGMII_TXID)
@@ -3193,6 +3193,18 @@ s32 phy_get_internal_delay(struct phy_device *phydev, struct device *dev,
 }
 EXPORT_SYMBOL(phy_get_internal_delay);
 
+s32 phy_get_tx_amplitude_gain(struct phy_device *phydev, struct device *dev,
+			      enum ethtool_link_mode_bit_indices linkmode)
+{
+	switch (linkmode) {
+	case ETHTOOL_LINK_MODE_100baseT_Full_BIT:
+		return phy_get_u32_property(dev, "tx-amplitude-100base-tx-gain-milli");
+	default:
+		return -EINVAL;
+	}
+}
+EXPORT_SYMBOL(phy_get_tx_amplitude_gain);
+
 static int phy_led_set_brightness(struct led_classdev *led_cdev,
 				  enum led_brightness value)
 {
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 19f076a71f9462cd37588a5da240a1d54df0fe0f..abdd768b7acece3db9ffb0f9de7d20cf86e72bc7 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2114,6 +2114,9 @@ void phy_get_pause(struct phy_device *phydev, bool *tx_pause, bool *rx_pause);
 s32 phy_get_internal_delay(struct phy_device *phydev, struct device *dev,
 			   const int *delay_values, int size, bool is_rx);
 
+s32 phy_get_tx_amplitude_gain(struct phy_device *phydev, struct device *dev,
+			      enum ethtool_link_mode_bit_indices linkmode);
+
 void phy_resolve_pause(unsigned long *local_adv, unsigned long *partner_adv,
 		       bool *tx_pause, bool *rx_pause);
 

-- 
2.39.5



