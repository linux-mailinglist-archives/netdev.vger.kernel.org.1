Return-Path: <netdev+bounces-166437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C96A35FF2
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76CF216B938
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 14:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02389265CCE;
	Fri, 14 Feb 2025 14:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adb5Ho2Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AD125A35E;
	Fri, 14 Feb 2025 14:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739542466; cv=none; b=u2RKX2RYgF52MaGuaTyb3Ez3qIXS8f4h/ss9PeDPTi31ErqyBZlRRMx1MMu0AomqUzEz1tyVIDm8O47JbskjaNb2QLLzkEOhZyZ57jJLiknmLk37Zw/4QM2PA7es3xb44zkQ28C0TOhMHELaTDzzeWRqE1v8HSdgjmExaRWZ3IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739542466; c=relaxed/simple;
	bh=4hda1p+a5q+D3wxkdOPEhpRLy2WV8wre68Pgg03Lmzk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DARxSS27gqxi4wReIUi4d5iy/k0HJSDNayUj47uq3aTXjdAUdWfNagnyaWGpW4MBbQaX829hQQVVlHVvmjhC+O2CbxBhE54df9wdhQ2MdsBxWDhM0gCd+fXZiUapzUgmmdRq2tkviu7AfG6KdTnkbcF4fKd+31TSEzgBXvejKLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adb5Ho2Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66DBEC4CEDF;
	Fri, 14 Feb 2025 14:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739542466;
	bh=4hda1p+a5q+D3wxkdOPEhpRLy2WV8wre68Pgg03Lmzk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=adb5Ho2YMrFyefbykaKTUNuDL4tohprIlgC5svMStCZSPIdEC8YN0BpshqRGjohlA
	 LWcDafU6GvWJNl1S2CBas6uoURB2N+vTWWDJr+LPviiMtF2KMm2Vw3wvvfqs5cUWZH
	 p8oJNF07/ev2WMdmMci/5yecQMg9UL9pM3gngTzgHeF7QYvnrPHIW7NcLxHaWa83IW
	 WoCfsdO7ed2JFJiniyhOhgd99za6kh6PL2NLILjXbh0ysoZq7Ac/DAccOK9enSC7dZ
	 +6OrjzTS+glP2TuKH6mCdzcNgWPq0sADf5lVN5zj3rybgz5P+uDoo2oKfcYUmX87Xd
	 eaoN9Po1YtXDw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D84C021A7;
	Fri, 14 Feb 2025 14:14:26 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Fri, 14 Feb 2025 15:14:10 +0100
Subject: [PATCH net-next v5 2/3] net: phy: Add helper for getting tx
 amplitude gain
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-dp83822-tx-swing-v5-2-02ca72620599@liebherr.com>
References: <20250214-dp83822-tx-swing-v5-0-02ca72620599@liebherr.com>
In-Reply-To: <20250214-dp83822-tx-swing-v5-0-02ca72620599@liebherr.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739542465; l=4484;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=dj7XjLsD1vcv58mbznpKHLLZxlHxYB7Mj8UF6IH59YQ=;
 b=Aejaq9OY2Odwpc2y8jo8Bh7r8uRC4Z4WNGMWvnnFLn2N7YGbSvNaZMntwtqhsN3Gwa52ckmIq
 wjNFtQaTu9uDJUQL4DQ+87NYB1DPVM7rf1x6TKgp9mCEzSPHyZ1/ZrF
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
 drivers/net/phy/phy_device.c | 53 +++++++++++++++++++++++++++++---------------
 include/linux/phy.h          |  4 ++++
 2 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 9b06ba92f2ed207ec1e254ad3d1c8111933f4181..4223742e3b0c16d782f790c2fcf9e7dbdd32ba2d 100644
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
+	int i, ret;
+	u32 delay;
 
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
@@ -3193,6 +3186,30 @@ s32 phy_get_internal_delay(struct phy_device *phydev, struct device *dev,
 }
 EXPORT_SYMBOL(phy_get_internal_delay);
 
+/**
+ * phy_get_tx_amplitude_gain - stores tx amplitude gain in @val
+ * @phydev: phy_device struct
+ * @dev: pointer to the devices device struct
+ * @linkmode: linkmode for which the tx amplitude gain should be retrieved
+ * @val: tx amplitude gain
+ *
+ * Returns: 0 on success, < 0 on failure
+ */
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
+EXPORT_SYMBOL_GPL(phy_get_tx_amplitude_gain);
+
 static int phy_led_set_brightness(struct led_classdev *led_cdev,
 				  enum led_brightness value)
 {
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 64982eba71d1eab504307cc83b9c5bbe6886ed29..ffd0eb7f7425ba3dfebbeb966c1fd83783586e08 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2124,6 +2124,10 @@ void phy_get_pause(struct phy_device *phydev, bool *tx_pause, bool *rx_pause);
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



