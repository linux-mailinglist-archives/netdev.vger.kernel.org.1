Return-Path: <netdev+bounces-183412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D869DA909B4
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 19:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5C3F7ABD89
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 17:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEC4217651;
	Wed, 16 Apr 2025 17:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NL9JNhNT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0133F2165EA;
	Wed, 16 Apr 2025 17:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744823700; cv=none; b=T00YmATsXuFENsq2oUFbqFWq/1h4icqPF2x/UABVOmku58Paw0kjNKm/xwZd7+2GfAifW4fbi0gVrkRlgyaKnkkC7hXmgR5mduS1P/WFlxR62NUu/LVNfiGL4CR7FcA1HAzW9kFoegjimi2DmOy2pGet6W8Lj7hZKjZPE1mWEWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744823700; c=relaxed/simple;
	bh=JLUFW7xVWi5uAyw4AeqyqswOikhB6O7KFDradTNh2Q0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LIZFu32k4DLFp7mWsOTk/9w1yifty2gywLVwfSJYP7wqVOe2dI4VTcpffp85TVIBshCnjqzgT5LrqqS0dJxPouvOpZ25f3+3kT1FpVDScnXEYadBit/2Gg0+vg33zI/1J6cs5PxJGmiqdi5oQpBido9gXQU8Enq16PeN6c6SviI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NL9JNhNT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7CBFC4CEF5;
	Wed, 16 Apr 2025 17:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744823699;
	bh=JLUFW7xVWi5uAyw4AeqyqswOikhB6O7KFDradTNh2Q0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NL9JNhNTZnALJIA7V2MHslvyr3ctAS4AXhJDDL5jP17Xg5DGakUmULSTDMJFO5X+D
	 0JxL6aupXqBehDkA6Z0sCuJUwUxsTJRvd66wTHfJOp1dQLv7Xpmum5rcIa2SHV32OU
	 UQYaE30V1cdmUEq9igkX8DamkJU6tmpMXPIoREuwrOD/BNrS6VKUsnpTetmvinSO9R
	 CcmsHkneqQQUv52aApi9vtsDPa+NSPKQVeRoP6kjvSA6AyyyFykX40Hwq5RBPjVF9K
	 rutsiX++UNTIkHhdUwTc9iKmbU9kXXGcrMxqU5mpkaaaRtr97WP3xL15wGeSQexlJT
	 2i5Xq+kcPDkhg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4ECC369C9;
	Wed, 16 Apr 2025 17:14:59 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Wed, 16 Apr 2025 19:14:49 +0200
Subject: [PATCH net-next v3 3/4] net: phy: Add helper for getting MAC
 termination resistance
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-dp83822-mac-impedance-v3-3-028ac426cddb@liebherr.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744823698; l=2028;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=/Fzsr/MDdwggR68hmMYpD2e1XBjCEnFaHjMzV6fLczs=;
 b=CArExZsnBMLPb47XmDpyue2G8JsTUSRt+ct01dNLMn9+fQlppo5ZA3VG3+QSLD9R2bGDNg3zh
 arH3MAWbODaCUlyke20Yqo7v34abi0g/xTIN6zuCPdBPJfsfprSFmvF
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Add helper which returns the MAC termination resistance value. Modifying
the resistance to an appropriate value can reduce signal reflections and
therefore improve signal quality.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 drivers/net/phy/phy_device.c | 15 +++++++++++++++
 include/linux/phy.h          |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index cc6c209fe702293c25e619899a699a53638f0f66..f85c172c446c56e1da1d13baa18c581f2213dcc5 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2975,6 +2975,21 @@ int phy_get_tx_amplitude_gain(struct phy_device *phydev, struct device *dev,
 }
 EXPORT_SYMBOL_GPL(phy_get_tx_amplitude_gain);
 
+/**
+ * phy_get_mac_termination - stores MAC termination in @val
+ * @phydev: phy_device struct
+ * @dev: pointer to the devices device struct
+ * @val: MAC termination
+ *
+ * Returns: 0 on success, < 0 on failure
+ */
+int phy_get_mac_termination(struct phy_device *phydev, struct device *dev,
+			    u32 *val)
+{
+	return phy_get_u32_property(dev, "mac-termination-ohms", val);
+}
+EXPORT_SYMBOL_GPL(phy_get_mac_termination);
+
 static int phy_led_set_brightness(struct led_classdev *led_cdev,
 				  enum led_brightness value)
 {
diff --git a/include/linux/phy.h b/include/linux/phy.h
index fb755358d965b728d502bfc1c0d6e5a6b779f1ef..066a28a4b64b25a7c6033a3bb1e3bc48b20c96dc 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2040,6 +2040,9 @@ int phy_get_tx_amplitude_gain(struct phy_device *phydev, struct device *dev,
 			      enum ethtool_link_mode_bit_indices linkmode,
 			      u32 *val);
 
+int phy_get_mac_termination(struct phy_device *phydev, struct device *dev,
+			    u32 *val);
+
 void phy_resolve_pause(unsigned long *local_adv, unsigned long *partner_adv,
 		       bool *tx_pause, bool *rx_pause);
 

-- 
2.39.5



