Return-Path: <netdev+bounces-180068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1031A7F6F5
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CC6D163AFA
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 07:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7792638AA;
	Tue,  8 Apr 2025 07:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOxDV5va"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AC722173D;
	Tue,  8 Apr 2025 07:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744098340; cv=none; b=cyNBHrV4mI2WmMA2RCs0A7v63fkys4cCasEQUtudpJvyn9azxaIn6YdESj4H39cb9wyoVJNSCFah58G/XpUGImmXL+y83CqGNwq77DlvhVv0v+ekL6tFpPVhMwriVTTHSZRI7I/2kV2sIEf1duHbEDLIjD3H3xEtNunyqm3f704=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744098340; c=relaxed/simple;
	bh=YQ4zPBqKO+TbeflKF81WpWFVnmtHT3kG5mWSk4tlLrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lOnE2NIDqVbCQVcm3hciVBoEjj9489ic+AG4M1A7xPBO81+4GUF0ZhxZxCswSJ0MHRD9saiHsv6fwDnTbu+V61JcZCGNj9DvZJ4Pn0X1iixtjTDYlGfqAP4VkSB0kDsHANkVwVluYmjU69xYMfijF3h0iqR35DXyncgchMm7Nfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOxDV5va; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0BC0DC4CEEC;
	Tue,  8 Apr 2025 07:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744098340;
	bh=YQ4zPBqKO+TbeflKF81WpWFVnmtHT3kG5mWSk4tlLrM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rOxDV5vakHUpoBOuNi7NEhjByf9IG+nD+BdGQFkKxpBkDaaaH+OsCP/ZgEtYGpLGL
	 HFCbAemJxCMmUjAkJ2Th7HwmC51bmv7gSqmT4Z+2a9c0MEF6BfZbXU34TvrHwFsE42
	 cfby1zZACZdDNQywt39xO6zB2aIbSujrKb9wWQIB2J5Zm/9AwFz9CeC7QcoxK5gt3i
	 Wsw6UmM+VgbI43VredeREb5nIILY4tdnJQCWBCcSE5q9ePd4dtAC2KqZfBu+Sw/g6i
	 A5/vU2CDerzjXtFw1zoPBgsFEpelNyPrfLBRBw9LuARIKX2Tms13ptOzfMrwhdGnHt
	 S04xnWeG1yKhg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6F4C369A5;
	Tue,  8 Apr 2025 07:45:39 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Tue, 08 Apr 2025 09:45:33 +0200
Subject: [PATCH net-next v2 2/3] net: phy: Add helper for getting MAC
 termination resistance
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-dp83822-mac-impedance-v2-2-fefeba4a9804@liebherr.com>
References: <20250408-dp83822-mac-impedance-v2-0-fefeba4a9804@liebherr.com>
In-Reply-To: <20250408-dp83822-mac-impedance-v2-0-fefeba4a9804@liebherr.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744098338; l=1963;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=3rPSnMTtXUybCDZzRHxcQdj0rW3ShNxaNA2Hqxzp20o=;
 b=RzeHcv3bxb4pNq+oou9OTP8EPu91EcvX4bUD80IzWFxMsMqw06vIkTHvLevnaltX76Yo2Vzcw
 8eEEn1Yr9/xD5DcfxkUVa3A8JqvCmq0ZyIL6WzTlaMBB1o2McbWVFQf
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

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 drivers/net/phy/phy_device.c | 15 +++++++++++++++
 include/linux/phy.h          |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 675fbd225378796085cdc6c92ee2d7e9bff0b6f6..6bd888a7ad14f0e71670e43cf0dd7ecebc2b23b9 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2948,6 +2948,21 @@ int phy_get_tx_amplitude_gain(struct phy_device *phydev, struct device *dev,
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
index a2bfae80c44975db013760413867cebdf20c8216..63d237763f842e80d04bb534e32cd42110129e41 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2046,6 +2046,9 @@ int phy_get_tx_amplitude_gain(struct phy_device *phydev, struct device *dev,
 			      enum ethtool_link_mode_bit_indices linkmode,
 			      u32 *val);
 
+int phy_get_mac_termination(struct phy_device *phydev, struct device *dev,
+			    u32 *val);
+
 void phy_resolve_pause(unsigned long *local_adv, unsigned long *partner_adv,
 		       bool *tx_pause, bool *rx_pause);
 

-- 
2.39.5



