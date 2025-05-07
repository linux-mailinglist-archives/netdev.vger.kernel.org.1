Return-Path: <netdev+bounces-188596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A20AADC4B
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 12:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99ECE174E11
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 10:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAA821323C;
	Wed,  7 May 2025 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="PJukL21H";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="apQx9sLT"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A585A19005E;
	Wed,  7 May 2025 10:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746612832; cv=none; b=iuGPfTGFoYcblkVD+BBL8zqR/orNvSMnQL2LQXQrg7/9olvj1CDlzmKPz6e2k6HhS78ievgAH3bWqUT8uy1DIqaQGPLbnjpiS1Qeso8vsdLA4t11oEZQmlPLg4j+8LRex29oUFSvvMFSNQEx0CHRuIOd1NGcF5N4Mo9xrDA0PNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746612832; c=relaxed/simple;
	bh=EyX/Mfgx9DJFijYb8LH9cno25hqdEVzRVGFUsht9c44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U5fpdndZmYmIQ/6sAf0RrrT2T9754hsz9EBDkSOIVxqYuvG0kT/f5xJ0awiDtJktjo7AaNJtocPK67zWuSoQSlQ7SyZVAPaAn6BqBi/pfkuq8O6axyk0u5qX3H6r0l4/7p7LrWVCUlo2xewDxTG1dzaffKAVw/jZ4kIj1RsbndY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=PJukL21H; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=apQx9sLT reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1746612830; x=1778148830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nTUgw/NsKVrlq46UbUfZSveiUQFgTqQLDbL8IHNtIwg=;
  b=PJukL21H5YfWC4wSO6pC2vzzVRCh0gVgadRvE2C7R6G87/cSbg3TKK+v
   qGxIJq/YSYFjWSWYaCy1GHTegDQ8ZpASZDD5C0uB8lTe1PRigOwYRJtgG
   x4cRWI6VygljnuAZ0vzHwW83JeCJdaTb34UEoyKn0cl/xtqqV5s576g4r
   uLi9Mo2tZc9b0LNbfae+/WmlKbTaPTrZDtW5jGZ6THIdOG4s0S24rX89g
   B4DVH9x5R2t2+lEHdzSw0Sg36oS3RSi/nAbeO7eamVmi7dn532Otp397Y
   bOGhybY++v4x8k1o7BGdtB1YHQ2z88eevskdAlW9FaGKWecW+UKXKXQqH
   w==;
X-CSE-ConnectionGUID: iwkbd1vqRcC/jGcwat3QSw==
X-CSE-MsgGUID: TSqWF4NWTyWKvt5vnXAFLw==
X-IronPort-AV: E=Sophos;i="6.15,269,1739833200"; 
   d="scan'208";a="43932322"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 07 May 2025 12:13:46 +0200
X-CheckPoint: {681B325A-4F-C7E25413-F4312D34}
X-MAIL-CPID: 6FECBB341059D6AFABBE2E76BC7F2240_4
X-Control-Analysis: str=0001.0A00639A.681B325D.0072,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 67FD8163680;
	Wed,  7 May 2025 12:13:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1746612822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nTUgw/NsKVrlq46UbUfZSveiUQFgTqQLDbL8IHNtIwg=;
	b=apQx9sLT5TOcRsEM7dUiDN7pEd/X5knwiNuULbwNAQXvnt1KmilGIeMqMeTLb2Ghz1Bf/g
	hz0bFSOEt5I9+BHyX9bQrmwS+PP98UnY4a+cd4hLstNZn/m2+7G16/4yqdBHQntcbtDpYV
	fUVZaPa/+nSOHJmyZQQJqcz/AIV3NsdVuG6J1GXAgfQiSeYJUl1jCuDJoJEFwKSpbjy6s6
	crANJgZJU9t8c2G1Zq1TBErJyDSfJrD0qJSAMZ0GUhzbFm2cxI/nNbliiVh7CI2T7I6K6B
	u4b37/EG9/Nu3VyulhIdDBHhZ6Xpw8wwuOEXJ/M3lBxsa45s6CK4aozw7X6gEg==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH net-next v2 2/2] net: phy: dp83867: use 2ns delay if not specified in DTB
Date: Wed,  7 May 2025 12:13:21 +0200
Message-ID: <e2509b248a11ee29ea408a50c231da4c1fa0863b.1746612711.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <8a286207cd11b460bb0dbd27931de3626b9d7575.1746612711.git.matthias.schiffer@ew.tq-group.com>
References: <8a286207cd11b460bb0dbd27931de3626b9d7575.1746612711.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Most PHY drivers default to a 2ns delay if internal delay is requested
and no value is specified. Having a default value makes sense, as it
allows a Device Tree to only care about board design (whether there are
delays on the PCB or not), and not whether the delay is added on the MAC
or the PHY side when needed.

Whether the delays are actually applied is controlled by the
DP83867_RGMII_*_CLK_DELAY_EN flags, so the behavior is only changed in
configurations that would previously be rejected with -EINVAL.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2: no changes

 drivers/net/phy/dp83867.c | 44 ++++-----------------------------------
 1 file changed, 4 insertions(+), 40 deletions(-)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index e5b0c1b7be13f..deeefb9625664 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -106,10 +106,8 @@
 /* RGMIIDCTL bits */
 #define DP83867_RGMII_TX_CLK_DELAY_MAX		0xf
 #define DP83867_RGMII_TX_CLK_DELAY_SHIFT	4
-#define DP83867_RGMII_TX_CLK_DELAY_INV	(DP83867_RGMII_TX_CLK_DELAY_MAX + 1)
 #define DP83867_RGMII_RX_CLK_DELAY_MAX		0xf
 #define DP83867_RGMII_RX_CLK_DELAY_SHIFT	0
-#define DP83867_RGMII_RX_CLK_DELAY_INV	(DP83867_RGMII_RX_CLK_DELAY_MAX + 1)
 
 /* IO_MUX_CFG bits */
 #define DP83867_IO_MUX_CFG_IO_IMPEDANCE_MASK	0x1f
@@ -501,29 +499,6 @@ static int dp83867_config_port_mirroring(struct phy_device *phydev)
 	return 0;
 }
 
-static int dp83867_verify_rgmii_cfg(struct phy_device *phydev)
-{
-	struct dp83867_private *dp83867 = phydev->priv;
-
-	/* RX delay *must* be specified if internal delay of RX is used. */
-	if ((phydev->interface == PHY_INTERFACE_MODE_RGMII_ID ||
-	     phydev->interface == PHY_INTERFACE_MODE_RGMII_RXID) &&
-	     dp83867->rx_id_delay == DP83867_RGMII_RX_CLK_DELAY_INV) {
-		phydev_err(phydev, "ti,rx-internal-delay must be specified\n");
-		return -EINVAL;
-	}
-
-	/* TX delay *must* be specified if internal delay of TX is used. */
-	if ((phydev->interface == PHY_INTERFACE_MODE_RGMII_ID ||
-	     phydev->interface == PHY_INTERFACE_MODE_RGMII_TXID) &&
-	     dp83867->tx_id_delay == DP83867_RGMII_TX_CLK_DELAY_INV) {
-		phydev_err(phydev, "ti,tx-internal-delay must be specified\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 #if IS_ENABLED(CONFIG_OF_MDIO)
 static int dp83867_of_init_io_impedance(struct phy_device *phydev)
 {
@@ -607,7 +582,7 @@ static int dp83867_of_init(struct phy_device *phydev)
 	dp83867->sgmii_ref_clk_en = of_property_read_bool(of_node,
 							  "ti,sgmii-ref-clock-output-enable");
 
-	dp83867->rx_id_delay = DP83867_RGMII_RX_CLK_DELAY_INV;
+	dp83867->rx_id_delay = DP83867_RGMIIDCTL_2_00_NS;
 	ret = of_property_read_u32(of_node, "ti,rx-internal-delay",
 				   &dp83867->rx_id_delay);
 	if (!ret && dp83867->rx_id_delay > DP83867_RGMII_RX_CLK_DELAY_MAX) {
@@ -617,7 +592,7 @@ static int dp83867_of_init(struct phy_device *phydev)
 		return -EINVAL;
 	}
 
-	dp83867->tx_id_delay = DP83867_RGMII_TX_CLK_DELAY_INV;
+	dp83867->tx_id_delay = DP83867_RGMIIDCTL_2_00_NS;
 	ret = of_property_read_u32(of_node, "ti,tx-internal-delay",
 				   &dp83867->tx_id_delay);
 	if (!ret && dp83867->tx_id_delay > DP83867_RGMII_TX_CLK_DELAY_MAX) {
@@ -737,7 +712,6 @@ static int dp83867_config_init(struct phy_device *phydev)
 {
 	struct dp83867_private *dp83867 = phydev->priv;
 	int ret, val, bs;
-	u16 delay;
 
 	/* Force speed optimization for the PHY even if it strapped */
 	ret = phy_modify(phydev, DP83867_CFG2, DP83867_DOWNSHIFT_EN,
@@ -745,10 +719,6 @@ static int dp83867_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	ret = dp83867_verify_rgmii_cfg(phydev);
-	if (ret)
-		return ret;
-
 	/* RX_DV/RX_CTRL strapped in mode 1 or mode 2 workaround */
 	if (dp83867->rxctrl_strap_quirk)
 		phy_clear_bits_mmd(phydev, DP83867_DEVADDR, DP83867_CFG4,
@@ -827,15 +797,9 @@ static int dp83867_config_init(struct phy_device *phydev)
 
 		phy_write_mmd(phydev, DP83867_DEVADDR, DP83867_RGMIICTL, val);
 
-		delay = 0;
-		if (dp83867->rx_id_delay != DP83867_RGMII_RX_CLK_DELAY_INV)
-			delay |= dp83867->rx_id_delay;
-		if (dp83867->tx_id_delay != DP83867_RGMII_TX_CLK_DELAY_INV)
-			delay |= dp83867->tx_id_delay <<
-				 DP83867_RGMII_TX_CLK_DELAY_SHIFT;
-
 		phy_write_mmd(phydev, DP83867_DEVADDR, DP83867_RGMIIDCTL,
-			      delay);
+			      dp83867->rx_id_delay |
+			      (dp83867->tx_id_delay << DP83867_RGMII_TX_CLK_DELAY_SHIFT));
 	}
 
 	/* If specified, set io impedance */
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


