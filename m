Return-Path: <netdev+bounces-162524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD7FA272E4
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A15797A4139
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AA32165E0;
	Tue,  4 Feb 2025 13:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLLWCeQ0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A0C2163AB;
	Tue,  4 Feb 2025 13:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738674569; cv=none; b=qLzGo/i3MQ4iUoECD41ow4D3riAeqhXYJyw71or7hdV6vscyIqFbhlT+DaQyICOaq5UZg0aB5qHmCxWqQZ13btL7LOm59fp7tLYKj1BtAYhUagWHxcAMrvuOieqFq9Oix8ZObPCVOh7xz4lonE9nF3YtDYESlmq/98+UF5NiNRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738674569; c=relaxed/simple;
	bh=KLae2ThirBF8TRBJ/rCd9Z9cMdAlcIVZqzjerutX23o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qViqdKw4klCZS/6HUdHkHYQxVjC60Pz0BQ/MCax+igTE9/Utl2mwctnPMb3NU9ywCH5v3z+cuE8Fp0OFfrqkeFWFi94+eMxFrC+19BbchUq2oSebxj9BnBSUCXnMbu924TVuJXxaSp0751Fl0K+JBE6wrm3EzwMvYFJjcv3TpUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLLWCeQ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5EF20C4CEE2;
	Tue,  4 Feb 2025 13:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738674569;
	bh=KLae2ThirBF8TRBJ/rCd9Z9cMdAlcIVZqzjerutX23o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CLLWCeQ0pXUgkM75LPYOq087THiJWiKylgDZwxNJ4aa4Idzlicxy3OIkr0OKp0ue4
	 KXdRRg/L3l78g3Ogq+r8SLYR8scTK0lNDJlUuVg1FVcMkVAxehHX8lpXnokjTK9W4v
	 /b2QY0Y0AhY8FWqmLE5ldbV1fu2l6ZKr+x0CL3XJdU19JAEUJ3JQoA644pJvDadm4o
	 FrtNplz5wLhG6ru4MFzhcl2BlE3+3FjfCrSvRmLpXEnSl6fkGasvR+KC08V+3E5ICO
	 G0InZld2TYL+yM+Fq86uIs1Wkis6U07DH1Mc7FCU4pODnmjK3x3ZgxZCJAcRw6Z1me
	 l2h0ZzeCsSzaQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B266C02198;
	Tue,  4 Feb 2025 13:09:29 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Tue, 04 Feb 2025 14:09:16 +0100
Subject: [PATCH net-next v3 2/3] net: phy: Add helper for getting tx
 amplitude gain
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-dp83822-tx-swing-v3-2-9798e96500d9@liebherr.com>
References: <20250204-dp83822-tx-swing-v3-0-9798e96500d9@liebherr.com>
In-Reply-To: <20250204-dp83822-tx-swing-v3-0-9798e96500d9@liebherr.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738674559; l=3497;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=0ZejZPUcrUp9FjaaOS61NLofdR8KGQDK6c94FOz0qR0=;
 b=tyWeKjO7KKimMTL+LAdI0N09QHgYnuWEkOX2aE2dbGXfu5J63N5wuibIEmYaz6N1JPEikXRrX
 7s3XXNYOo9NB1dDB+GXebLO7yhFmYAFldpRyxJv7QUxhfJKc409cxcT
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
index 46713d27412b76077d2e51e29b8d84f4f8f0a86d..c42e3e22eba6f7508cefa3568ccb4629cedce6b2 100644
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
+		return phy_get_u32_property(dev, "tx-amplitude-100base-tx-percent");
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



