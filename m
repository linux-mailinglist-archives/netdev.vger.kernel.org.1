Return-Path: <netdev+bounces-165087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C343A305D6
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 09:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB28718837CA
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 08:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E511F03E6;
	Tue, 11 Feb 2025 08:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/Mp1Xrw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A1F1F03D4;
	Tue, 11 Feb 2025 08:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739262836; cv=none; b=XzI9SZEpyjEQxFUoQVwyArqheNo7uPPHi6vrNhwbcu5nVwbHTu490lAEBSmdjU7tloN+YAHTtVblOoUE9hzty6L/LKsVKGSzIdG3DiyRybJEFoFsJhIThCJzjoxzCLo/FRJPZdUiJgwZbhWKkA3sb9Yd5AduHThkpNt3hU74Cn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739262836; c=relaxed/simple;
	bh=dqTy84ZzsPlhQ7gRPsU3FpoArxfjAGj7SYVPEm9GMR4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=niWbuTD+zDuhQsIv+2hIuo3qOgYdaVmJt6si+sL7NReG5n2d3xXvlOKy6SQBywhjk1fQXEzRc047gvF9Q6XlNqXAtDsVJahHLX0FKuq3mrJqmiYfL/FzF5mTIU4r0Ts8At1Ai0VZpWwl3ZFds7OlWAJgLih+4ekB6YFhG91uEo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/Mp1Xrw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2E68C4CEE8;
	Tue, 11 Feb 2025 08:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739262835;
	bh=dqTy84ZzsPlhQ7gRPsU3FpoArxfjAGj7SYVPEm9GMR4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=K/Mp1Xrw5nwVVFvFoqF5f65OblTmY3+CTQLe+lKp0Fa8hyT3p+sA9iJJUWPcYjduC
	 B7QQT9pAig0IZJBeyuuibU/PLzPu95YxhO6cj5eTG4iGJxcCGAIS4Ts7KmDSBzODIG
	 ibJqjQXdG31aMd1Ojiqdd7ebhX/4h8bzcWouYm8k6CQS8le8hC2hqEh8GsSAtWkV++
	 X0L4cwb3S5nC0bhkgI0mobtM5nxvOIRImn9CbFHdADtE+qW3Tk07TCqVJ7SsbTtKXi
	 yLcCkevbZdhn6ag0u6BCUzDL1nUa3myTWlJmgBgO6/EacC9Sl47Qb3aMHR3b5oPIn1
	 Wq5OCk3Vl4gpg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45A8C0219D;
	Tue, 11 Feb 2025 08:33:55 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Tue, 11 Feb 2025 09:33:48 +0100
Subject: [PATCH net-next v4 2/3] net: phy: Add helper for getting tx
 amplitude gain
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-dp83822-tx-swing-v4-2-1e8ebd71ad54@liebherr.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739262831; l=4168;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=rkHlk2CzqTSrJQGoCX2wMldHNiCaKztaZdt09yvcqgc=;
 b=VQd9j96AQ8kCorAnx+eg2QTWTonJS6mQjcf2v8Tmb4zGeSpUidKooO25OiaBB0mR7o8Z/sCjP
 ul6iejQkwIiCjY0pVRMCFDmvf2B76U1H60PNiB4DhhY7ab6UClLCbbA
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
 drivers/net/phy/phy_device.c | 44 ++++++++++++++++++++++++++------------------
 include/linux/phy.h          |  4 ++++
 2 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 46713d27412b76077d2e51e29b8d84f4f8f0a86d..25ee085816b711c8a90ebf93001d892488935575 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3096,19 +3096,12 @@ void phy_get_pause(struct phy_device *phydev, bool *tx_pause, bool *rx_pause)
 EXPORT_SYMBOL(phy_get_pause);
 
 #if IS_ENABLED(CONFIG_OF_MDIO)
-static int phy_get_int_delay_property(struct device *dev, const char *name)
+static int phy_get_u32_property(struct device *dev, const char *name, u32 *val)
 {
-	s32 int_delay;
-	int ret;
-
-	ret = device_property_read_u32(dev, name, &int_delay);
-	if (ret)
-		return ret;
-
-	return int_delay;
+	return device_property_read_u32(dev, name, val);
 }
 #else
-static int phy_get_int_delay_property(struct device *dev, const char *name)
+static int phy_get_u32_property(struct device *dev, const char *name, u32 *val)
 {
 	return -EINVAL;
 }
@@ -3133,12 +3126,12 @@ static int phy_get_int_delay_property(struct device *dev, const char *name)
 s32 phy_get_internal_delay(struct phy_device *phydev, struct device *dev,
 			   const int *delay_values, int size, bool is_rx)
 {
-	s32 delay;
-	int i;
+	u32 delay;
+	int i, ret;
 
 	if (is_rx) {
-		delay = phy_get_int_delay_property(dev, "rx-internal-delay-ps");
-		if (delay < 0 && size == 0) {
+		ret = phy_get_u32_property(dev, "rx-internal-delay-ps", &delay);
+		if (ret < 0 && size == 0) {
 			if (phydev->interface == PHY_INTERFACE_MODE_RGMII_ID ||
 			    phydev->interface == PHY_INTERFACE_MODE_RGMII_RXID)
 				return 1;
@@ -3147,8 +3140,8 @@ s32 phy_get_internal_delay(struct phy_device *phydev, struct device *dev,
 		}
 
 	} else {
-		delay = phy_get_int_delay_property(dev, "tx-internal-delay-ps");
-		if (delay < 0 && size == 0) {
+		ret = phy_get_u32_property(dev, "tx-internal-delay-ps", &delay);
+		if (ret < 0 && size == 0) {
 			if (phydev->interface == PHY_INTERFACE_MODE_RGMII_ID ||
 			    phydev->interface == PHY_INTERFACE_MODE_RGMII_TXID)
 				return 1;
@@ -3157,8 +3150,8 @@ s32 phy_get_internal_delay(struct phy_device *phydev, struct device *dev,
 		}
 	}
 
-	if (delay < 0)
-		return delay;
+	if (ret < 0)
+		return ret;
 
 	if (size == 0)
 		return delay;
@@ -3193,6 +3186,21 @@ s32 phy_get_internal_delay(struct phy_device *phydev, struct device *dev,
 }
 EXPORT_SYMBOL(phy_get_internal_delay);
 
+int phy_get_tx_amplitude_gain(struct phy_device *phydev, struct device *dev,
+			      enum ethtool_link_mode_bit_indices linkmode,
+			      u32 *val)
+{
+	switch (linkmode) {
+	case ETHTOOL_LINK_MODE_100baseT_Full_BIT:
+		return phy_get_u32_property(dev,
+					    "tx-amplitude-100base-tx-percent",
+					    val);
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
index 19f076a71f9462cd37588a5da240a1d54df0fe0f..7c9da26145d30e6659bf6c664e77a63b5d668a5c 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2114,6 +2114,10 @@ void phy_get_pause(struct phy_device *phydev, bool *tx_pause, bool *rx_pause);
 s32 phy_get_internal_delay(struct phy_device *phydev, struct device *dev,
 			   const int *delay_values, int size, bool is_rx);
 
+int phy_get_tx_amplitude_gain(struct phy_device *phydev, struct device *dev,
+			      enum ethtool_link_mode_bit_indices linkmode,
+			      u32 *val);
+
 void phy_resolve_pause(unsigned long *local_adv, unsigned long *partner_adv,
 		       bool *tx_pause, bool *rx_pause);
 

-- 
2.39.5



