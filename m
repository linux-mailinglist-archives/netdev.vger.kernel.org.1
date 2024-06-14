Return-Path: <netdev+bounces-103690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 666F3909128
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 19:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E29621F21A7F
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 17:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9483E1974EA;
	Fri, 14 Jun 2024 17:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ggnqrTeb"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E55816D339;
	Fri, 14 Jun 2024 17:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718385322; cv=none; b=oHdjbPilSw8XQSHpBQp8vJfJ8m1GYgxEMlc/8VuwEQ09eX2q7pLz23ORHFzNbmcC4W7K8bP6yy98KDoAV/4do8NEKMngoS+figRxfWEDK4BfbUlNNFceM9zokyPrEZyeASfQb8UtRu95tdcSfF7zFCs1H8N5uUq1Fpd6/aC5FqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718385322; c=relaxed/simple;
	bh=E4kWCwpi97nUrP5r8szVoHd7Nv9FJpe1nSWH5e9Auuc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UskkSSa0OfFfq3RYqXmnK6md6kzMA3STfS4umDktI26rMitfehmeVgjcFfmj+MmD/HU+uTVlS24iEPOlhbKdK18eSLSYozP0LkqgTSd4dWfUXuriZg1pFPyWUE+Kl/4vJT9XWEnUlst5CFbF3re3ezrZgoAPJSsPegGXWUw1uA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ggnqrTeb; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718385320; x=1749921320;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E4kWCwpi97nUrP5r8szVoHd7Nv9FJpe1nSWH5e9Auuc=;
  b=ggnqrTebbmgtWhRumWFEhYvndMlH/jskhGlwdJoFOJ98lSg3RZUV9MIu
   DNXmXBQr0BQFJK5wrcItRS24TwBSvjc1FculfIl90EbYaRLuGUSot/0l1
   yDuXrvXQ+zxu1H0D1GGTsCp1taEZ/Zir3MIHRn2rELhzOkTnJ/4NvQfAB
   RTIN4TTjffZHT0irg/JKBLurnB4FpE7CcEE2Hycv7KGHonIk4xGdYbAmv
   xENcYSIvuBDpLUs/80gRMSQhXiYfX5+eVNmOP3OcwQgHntb47Ewd5ZPvT
   3t+7c5HDOK573GpyCmKhUKrhllV1H2X8fzwTmf1VoJqIk2qe9sruVSyrl
   A==;
X-CSE-ConnectionGUID: oTu+8oZpRNSsGgyH6m3d9w==
X-CSE-MsgGUID: zpD7oSHaQluYeCHGlndR3g==
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="28220421"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jun 2024 10:15:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 14 Jun 2024 10:15:14 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 14 Jun 2024 10:15:09 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<bryan.whitehead@microchip.com>, <andrew@lunn.ch>, <linux@armlinux.org.uk>,
	<sbauer@blackbox.su>, <hmehrtens@maxlinear.com>, <lxu@maxlinear.com>,
	<hkallweit1@gmail.com>, <edumazet@google.com>, <pabeni@redhat.com>,
	<wojciech.drewek@intel.com>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH net V5 3/3] net: phy: mxl-gpy: Remove interrupt mask clearing from config_init
Date: Fri, 14 Jun 2024 22:41:57 +0530
Message-ID: <20240614171157.190871-4-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240614171157.190871-1-Raju.Lakkaraju@microchip.com>
References: <20240614171157.190871-1-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

When the system resumes from sleep, the phy_init_hw() function invokes
config_init(), which clears all interrupt masks and causes wake events to be
lost in subsequent wake sequences. Remove interrupt mask clearing from
config_init() and preserve relevant masks in config_intr().

Fixes: 7d901a1e878a ("net: phy: add Maxlinear GPY115/21x/24x driver")
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
Change List:
------------
V4 -> V5:
  - No change
V3 -> V4:
  - No change
V0 -> V3:
  - Address the https://lore.kernel.org/lkml/4a565d54-f468-4e32-8a2c-102c1203f72c@lunn.ch/T/
    review comments

 drivers/net/phy/mxl-gpy.c | 58 +++++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 20 deletions(-)

diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
index b2d36a3a96f1..e5f8ac4b4604 100644
--- a/drivers/net/phy/mxl-gpy.c
+++ b/drivers/net/phy/mxl-gpy.c
@@ -107,6 +107,7 @@ struct gpy_priv {
 
 	u8 fw_major;
 	u8 fw_minor;
+	u32 wolopts;
 
 	/* It takes 3 seconds to fully switch out of loopback mode before
 	 * it can safely re-enter loopback mode. Record the time when
@@ -221,6 +222,15 @@ static int gpy_hwmon_register(struct phy_device *phydev)
 }
 #endif
 
+static int gpy_ack_interrupt(struct phy_device *phydev)
+{
+	int ret;
+
+	/* Clear all pending interrupts */
+	ret = phy_read(phydev, PHY_ISTAT);
+	return ret < 0 ? ret : 0;
+}
+
 static int gpy_mbox_read(struct phy_device *phydev, u32 addr)
 {
 	struct gpy_priv *priv = phydev->priv;
@@ -262,16 +272,8 @@ static int gpy_mbox_read(struct phy_device *phydev, u32 addr)
 
 static int gpy_config_init(struct phy_device *phydev)
 {
-	int ret;
-
-	/* Mask all interrupts */
-	ret = phy_write(phydev, PHY_IMASK, 0);
-	if (ret)
-		return ret;
-
-	/* Clear all pending interrupts */
-	ret = phy_read(phydev, PHY_ISTAT);
-	return ret < 0 ? ret : 0;
+	/* Nothing to configure. Configuration Requirement Placeholder */
+	return 0;
 }
 
 static int gpy21x_config_init(struct phy_device *phydev)
@@ -627,11 +629,23 @@ static int gpy_read_status(struct phy_device *phydev)
 
 static int gpy_config_intr(struct phy_device *phydev)
 {
+	struct gpy_priv *priv = phydev->priv;
 	u16 mask = 0;
+	int ret;
+
+	ret = gpy_ack_interrupt(phydev);
+	if (ret)
+		return ret;
 
 	if (phydev->interrupts == PHY_INTERRUPT_ENABLED)
 		mask = PHY_IMASK_MASK;
 
+	if (priv->wolopts & WAKE_MAGIC)
+		mask |= PHY_IMASK_WOL;
+
+	if (priv->wolopts & WAKE_PHY)
+		mask |= PHY_IMASK_LSTC;
+
 	return phy_write(phydev, PHY_IMASK, mask);
 }
 
@@ -678,6 +692,7 @@ static int gpy_set_wol(struct phy_device *phydev,
 		       struct ethtool_wolinfo *wol)
 {
 	struct net_device *attach_dev = phydev->attached_dev;
+	struct gpy_priv *priv = phydev->priv;
 	int ret;
 
 	if (wol->wolopts & WAKE_MAGIC) {
@@ -725,6 +740,8 @@ static int gpy_set_wol(struct phy_device *phydev,
 		ret = phy_read(phydev, PHY_ISTAT);
 		if (ret < 0)
 			return ret;
+
+		priv->wolopts |= WAKE_MAGIC;
 	} else {
 		/* Disable magic packet matching */
 		ret = phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2,
@@ -732,6 +749,13 @@ static int gpy_set_wol(struct phy_device *phydev,
 					 WOL_EN);
 		if (ret < 0)
 			return ret;
+
+		/* Disable the WOL interrupt */
+		ret = phy_clear_bits(phydev, PHY_IMASK, PHY_IMASK_WOL);
+		if (ret < 0)
+			return ret;
+
+		priv->wolopts &= ~WAKE_MAGIC;
 	}
 
 	if (wol->wolopts & WAKE_PHY) {
@@ -748,9 +772,11 @@ static int gpy_set_wol(struct phy_device *phydev,
 		if (ret & (PHY_IMASK_MASK & ~PHY_IMASK_LSTC))
 			phy_trigger_machine(phydev);
 
+		priv->wolopts |= WAKE_PHY;
 		return 0;
 	}
 
+	priv->wolopts &= ~WAKE_PHY;
 	/* Disable the link state change interrupt */
 	return phy_clear_bits(phydev, PHY_IMASK, PHY_IMASK_LSTC);
 }
@@ -758,18 +784,10 @@ static int gpy_set_wol(struct phy_device *phydev,
 static void gpy_get_wol(struct phy_device *phydev,
 			struct ethtool_wolinfo *wol)
 {
-	int ret;
+	struct gpy_priv *priv = phydev->priv;
 
 	wol->supported = WAKE_MAGIC | WAKE_PHY;
-	wol->wolopts = 0;
-
-	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, VPSPEC2_WOL_CTL);
-	if (ret & WOL_EN)
-		wol->wolopts |= WAKE_MAGIC;
-
-	ret = phy_read(phydev, PHY_IMASK);
-	if (ret & PHY_IMASK_LSTC)
-		wol->wolopts |= WAKE_PHY;
+	wol->wolopts = priv->wolopts;
 }
 
 static int gpy_loopback(struct phy_device *phydev, bool enable)
-- 
2.34.1


