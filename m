Return-Path: <netdev+bounces-100930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BED458FC8CF
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 12:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68DC3282A1D
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 10:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D21619006D;
	Wed,  5 Jun 2024 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="aLxkiVqR"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B2D18FDDF;
	Wed,  5 Jun 2024 10:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717582799; cv=none; b=sSgTBHWwC4M9OuVBdFzFQAnsWULSwxXAjo5re/+zgYGMdLJmL1vT0gGQ33l9OGdchoNR+hlE6rLoWGh/G6cPF/gJ8I1XDt95lRPHVt8e3KeOQeCFZ1WF6dZPl8LKOZMFsMirT3z+Rl19SFBHmrkNUIdTStNAAuN9ihks83eqkU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717582799; c=relaxed/simple;
	bh=fvulcT5ydE4/+fPHuMlny3YejOv9UJqzp3ZviFsjn4U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BC6v5HS6QWfzDjhk0gV5Ff+zMll8HZpVBjoHGsApYqRcMWT7jZG0ERQSQ81XjGq1ncZd8l9bkdIYf1q42D3rAgMPQ+r6hp4TWFCfQWdcDq6nLTSYGiFb9JOAK9rdgCRm0jA60F9o7kPtTgtnaDoIh8Nw98/mqYo2Ln0No2n0OE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=aLxkiVqR; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1717582797; x=1749118797;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fvulcT5ydE4/+fPHuMlny3YejOv9UJqzp3ZviFsjn4U=;
  b=aLxkiVqRHLvT/CZlBT95XCWT3RCpn07So/34j+pVepSAh7pYojWKnNyc
   KdSvWmRMUnZDK4w4uCLsnhnH9DsHWEfTFldgc1XnY7dzI/Ru+0Xp7IFhU
   5YRqDl6D7bFmH1p3iP3i7PwSuM0+4JHKn9WIH1V0qc3CxOK5lFWnCQA/9
   56CRBV7r7aZnLCPBwYE2qVJibZlnLhCT2cDMq7mJsbr/woTpwDYO0DKVV
   7GSoFM2oIh3ztwvUvCn38j3NwdDrALSi6EGxbunFZAtjEx2zPXgjvZSbK
   iTNoQvpk3mBqX6K7YSPShM25NoeBJIKsJ4jVnfKqXkxsNr1Sgh96eqw1r
   g==;
X-CSE-ConnectionGUID: aaaIWFYxROaUetL+6c7EzQ==
X-CSE-MsgGUID: 9GNMuAq5Qk6fvOayVAujrA==
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="27005381"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Jun 2024 03:19:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 5 Jun 2024 03:19:16 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 5 Jun 2024 03:19:11 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<bryan.whitehead@microchip.com>, <andrew@lunn.ch>, <linux@armlinux.org.uk>,
	<sbauer@blackbox.su>, <hmehrtens@maxlinear.com>, <lxu@maxlinear.com>,
	<hkallweit1@gmail.com>, <edumazet@google.com>, <pabeni@redhat.com>,
	<UNGLinuxDriver@microchip.com>
Subject: [PATCH net V3 3/3] net: phy: mxl-gpy: Remove interrupt mask clearing from config_init
Date: Wed, 5 Jun 2024 15:46:11 +0530
Message-ID: <20240605101611.18791-4-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605101611.18791-1-Raju.Lakkaraju@microchip.com>
References: <20240605101611.18791-1-Raju.Lakkaraju@microchip.com>
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
config_init() and preserve relevant masks in config_intr()

Fixes: 7d901a1e878a ("net: phy: add Maxlinear GPY115/21x/24x driver")
Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
Change List:                                                                    
------------                                                                    
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


