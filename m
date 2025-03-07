Return-Path: <netdev+bounces-172866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB01A5655D
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 11:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E27451899924
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 10:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42361211A07;
	Fri,  7 Mar 2025 10:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTX+Aqew"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124E020E700;
	Fri,  7 Mar 2025 10:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741343406; cv=none; b=UmIOB5TyxqkI00Zi1Z0N/AFN1veLiC4qO93pXG6ilqJGc0AaZ5NGbyIItV20pzusTgsWj6/LZSZYxnFdx1MVzLHc5zfN6Dt8zkG2s5R1gxdCZLI21T/fMFMeJUushq6wVBK46KcnH0uvtrsj5pmd9wJWnfTthrvrq+CcQPSoDBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741343406; c=relaxed/simple;
	bh=doW7RKw6mRzT+GNEHSidBFZ+p8Q/c2b9a7TUtoCXOMc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F6k8GYiEUrpuh2SROnDuiazWXiiFUqF2jWBPKXCgXvT9NB87J6YxRPIbecVdTCSezHzwFFepuJRnWwn1VZuG9OW3uJbXEBtBs9jDN1IU/qyVcnoVru5zy7hiLQe2+dN2d/vfIZCN664qbKSGdUhH5nLVOyP9wZH3nlonzO4faxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTX+Aqew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0384C4CEE7;
	Fri,  7 Mar 2025 10:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741343405;
	bh=doW7RKw6mRzT+GNEHSidBFZ+p8Q/c2b9a7TUtoCXOMc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KTX+AqewX3mbNRk22iYLOLrVUUXCttDMKR/okREJfVPcDahg7l+tGnpvClSw0S5KI
	 cTQfbik4WlU41Uf05l4og0bHp6VHwtei5ULzO6aNKX1uPhA2qXEIjdLucerNPJy858
	 XVqVhdS/50JhMwtlkpkjJI4DqkPkmRAd+z/mG5kbYMe5ocy7oFmEek4FKcE28+TEtz
	 T5W+VLsWUmJ98xmnQMYZwzzNy8+Khu9kag1tGt/to15Jb9ZO9ErqHl2U+C0fZygXRd
	 ZTPC5a5bft5oD5OX4++vhtNgXxKiIPdZfANyjNZ68A3ax6vSWsKfx6MThed5d/N1+u
	 jtZ/J01g91jSQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EDDC28B25;
	Fri,  7 Mar 2025 10:30:05 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Fri, 07 Mar 2025 11:30:02 +0100
Subject: [PATCH net-next 2/3] net: phy: Add helper for getting MAC series
 termination resistance
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-dp83822-mac-impedance-v1-2-bdd85a759b45@liebherr.com>
References: <20250307-dp83822-mac-impedance-v1-0-bdd85a759b45@liebherr.com>
In-Reply-To: <20250307-dp83822-mac-impedance-v1-0-bdd85a759b45@liebherr.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741343404; l=2019;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=WXDkCrvzATPSi65GNE8o3JjF1okiabDROoUJFOca/BU=;
 b=HsvITFP/0xYqQgKZ5aaR6H2UpueG8ibiadZdL3FDAk8+wWN5/uy2FE4Dx4vyvphHrYySYZWeO
 sEprLXq8I/gAy0Fm1Ol8lEjybCBk8GtLY/vikDlo0YyOKbWuZmg+beQ
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Add helper which returns the MAC series termination resistance value.
Modifying the resistance to an appropriate value can reduce signal
reflections and therefore improve signal quality.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 drivers/net/phy/phy_device.c | 15 +++++++++++++++
 include/linux/phy.h          |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index b2d32fbc8c8507f6280e4c3c671466f672c1cc8f..575583aa8b4d49bef796e96059e4f0dd56b351f9 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2975,6 +2975,21 @@ int phy_get_tx_amplitude_gain(struct phy_device *phydev, struct device *dev,
 }
 EXPORT_SYMBOL_GPL(phy_get_tx_amplitude_gain);
 
+/**
+ * phy_get_mac_series_termination - stores MAC series termination in @val
+ * @phydev: phy_device struct
+ * @dev: pointer to the devices device struct
+ * @val: MAC series termination
+ *
+ * Returns: 0 on success, < 0 on failure
+ */
+int phy_get_mac_series_termination(struct phy_device *phydev,
+				   struct device *dev, u32 *val)
+{
+	return phy_get_u32_property(dev, "mac-series-termination-ohms", val);
+}
+EXPORT_SYMBOL_GPL(phy_get_mac_series_termination);
+
 static int phy_led_set_brightness(struct led_classdev *led_cdev,
 				  enum led_brightness value)
 {
diff --git a/include/linux/phy.h b/include/linux/phy.h
index c4a6385faf41c3156d1a9086eaf5c746640cddbe..633899c4250c91a366849ee0c11d93feec48262f 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2052,6 +2052,9 @@ int phy_get_tx_amplitude_gain(struct phy_device *phydev, struct device *dev,
 			      enum ethtool_link_mode_bit_indices linkmode,
 			      u32 *val);
 
+int phy_get_mac_series_termination(struct phy_device *phydev,
+				   struct device *dev, u32 *val);
+
 void phy_resolve_pause(unsigned long *local_adv, unsigned long *partner_adv,
 		       bool *tx_pause, bool *rx_pause);
 

-- 
2.39.5



