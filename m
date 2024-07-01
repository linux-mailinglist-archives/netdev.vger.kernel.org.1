Return-Path: <netdev+bounces-108046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA9891DA9C
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 10:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C84691F22E48
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 08:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7742114D6E4;
	Mon,  1 Jul 2024 08:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bcI/U9nZ"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB5783CD2;
	Mon,  1 Jul 2024 08:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823851; cv=none; b=GL/Ju/xKTd3D/edGqmjLCRhHIfRj0lxrDQlp4tYK49KVFVVcBFTWVZei4vAuIb+kfjq0Pd+TKlf5GJMopIfnBEgMmhZWlcrVzGKGcu4/M2EeW0V2WWaAssFfHiUjogMhPk5RPj2MMtcNB3OQghhF9lbSYxfIY0fMJC/1zJ662yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823851; c=relaxed/simple;
	bh=Qbzsv+o+10uVgBolMErJzFgza2Cclektj/sx8Hrkgpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r+T+xxUrECOJbjbkX4CQicm4jkbMy/6/RYZ8dDt5p1ZE5PO7Pi+nRBJLEbQF6bkD+oiA09sBu4SOhez9lGgPchiRtv2K9CNce1l8azcaHQL2w599/0M9oI2a2cmPEMEP61GzCFVTE8gQBm5EwKHH6yX3QdREgBvsKji7gZjIi8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bcI/U9nZ; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 02216C0010;
	Mon,  1 Jul 2024 08:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719823847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e+k+cQVeC5+oHnw/gxWDOFgR0fNAUfcW0a0uGgqAPu8=;
	b=bcI/U9nZdbhD1hLyYm9NRhCL1N33tiP1M1Fisl0bNhgiVQsnZjwprHoKMdJZaFGQRNpsHz
	dLEBHD8mRobvrZi2sLNa4gZl7N80RgNDFpkfTx8+snQ6H6Etzg7+xqmQMVpJSdfpV3emDu
	NHQW2jtKpy8R9xIGAvR8/PML77bek/964OMVuciD5FhwgXAZGUeCLY+fwON0P33wrTtIRG
	Nzc2kQ9DY2WsSY+yU+9wZAX0b0QMgG1XaqwKDyWq1YsDHtDhs1b9+V968+YqS8jwuo9gOa
	uAYKPhOirS0z1EHHFGzu0ZfiYpXkD3Wc9fwMfYz0I+JQy2XzaGbk0QkjzpRTjg==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Mon, 01 Jul 2024 10:51:07 +0200
Subject: [PATCH net-next 5/6] net: phy: dp83869: Support SGMII SFP modules
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-b4-dp83869-sfp-v1-5-a71d6d0ad5f8@bootlin.com>
References: <20240701-b4-dp83869-sfp-v1-0-a71d6d0ad5f8@bootlin.com>
In-Reply-To: <20240701-b4-dp83869-sfp-v1-0-a71d6d0ad5f8@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.0
X-GND-Sasl: romain.gantois@bootlin.com

The DP83869HM PHY transceiver can be configured in RGMII-SGMII bridge mode
to interface an RGMII MAC with a standard SFP module containing an
integrated PHY. Additional SFP upstream ops are needed to notify the
DP83869 driver of SFP PHY detection so that it can initialize it.

Add relevant SFP callbacks to the DP83869 driver to support SGMII
modules.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/net/phy/dp83869.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
index a3ccaad738b28..a07ec1be84baf 100644
--- a/drivers/net/phy/dp83869.c
+++ b/drivers/net/phy/dp83869.c
@@ -153,6 +153,8 @@ struct dp83869_private {
 	bool rxctrl_strap_quirk;
 	int clk_output_sel;
 	int mode;
+	/* PHY in a downstream SFP module */
+	struct phy_device *mod_phy;
 };
 
 static int dp83869_read_status(struct phy_device *phydev)
@@ -845,6 +847,93 @@ static int dp83869_config_init(struct phy_device *phydev)
 	return ret;
 }
 
+static void dp83869_sfp_phy_change(struct phy_device *phydev, bool up)
+{
+	/* phylink uses this to populate its own structs from phy_device fields
+	 * we don't actually need this callback but if we don't implement it
+	 * the phy core will crash
+	 */
+}
+
+static int dp83869_connect_phy(void *upstream, struct phy_device *phy)
+{
+	struct phy_device *phydev = upstream;
+	struct dp83869_private *dp83869;
+
+	dp83869 = phydev->priv;
+
+	if (dp83869->mode != DP83869_RGMII_SGMII_BRIDGE)
+		return 0;
+
+	if (!phy->drv) {
+		dev_warn(&phy->mdio.dev, "No driver bound to SFP module phy!\n");
+		return 0;
+	}
+
+	phy_support_asym_pause(phy);
+	linkmode_set_bit(PHY_INTERFACE_MODE_SGMII, phy->host_interfaces);
+	phy->interface = PHY_INTERFACE_MODE_SGMII;
+	phy->port = PORT_TP;
+
+	phy->speed = SPEED_UNKNOWN;
+	phy->duplex = DUPLEX_UNKNOWN;
+	phy->pause = MLO_PAUSE_NONE;
+	phy->interrupts = PHY_INTERRUPT_DISABLED;
+	phy->irq = PHY_POLL;
+	phy->phy_link_change = &dp83869_sfp_phy_change;
+	phy->state = PHY_READY;
+
+	dp83869->mod_phy = phy;
+
+	return 0;
+}
+
+static void dp83869_disconnect_phy(void *upstream)
+{
+	struct phy_device *phydev = upstream;
+	struct dp83869_private *dp83869;
+
+	dp83869 = phydev->priv;
+	dp83869->mod_phy = NULL;
+}
+
+static int dp83869_module_start(void *upstream)
+{
+	struct phy_device *phydev = upstream;
+	struct dp83869_private *dp83869;
+	struct phy_device *mod_phy;
+	int ret;
+
+	dp83869 = phydev->priv;
+	mod_phy = dp83869->mod_phy;
+	if (!mod_phy)
+		return 0;
+
+	ret = phy_init_hw(mod_phy);
+	if (ret) {
+		dev_err(&mod_phy->mdio.dev, "Failed to initialize PHY hardware: error %d", ret);
+		return ret;
+	}
+
+	phy_start(mod_phy);
+
+	return 0;
+}
+
+static void dp83869_module_stop(void *upstream)
+{
+	struct phy_device *phydev = upstream;
+	struct dp83869_private *dp83869;
+	struct phy_device *mod_phy;
+
+	dp83869 = phydev->priv;
+	mod_phy = dp83869->mod_phy;
+	if (!mod_phy)
+		return;
+
+	phy_stop(mod_phy);
+}
+
 static int dp83869_module_insert(void *upstream, const struct sfp_eeprom_id *id)
 {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(phy_support);
@@ -858,6 +947,13 @@ static int dp83869_module_insert(void *upstream, const struct sfp_eeprom_id *id)
 	phylink_set(phy_support, 1000baseX_Full);
 	phylink_set(phy_support, 100baseFX_Full);
 	phylink_set(phy_support, FIBRE);
+	phylink_set(phy_support, 10baseT_Full);
+	phylink_set(phy_support, 100baseT_Full);
+	phylink_set(phy_support, 1000baseT_Full);
+	phylink_set(phy_support, Autoneg);
+	phylink_set(phy_support, Pause);
+	phylink_set(phy_support, Asym_Pause);
+	phylink_set(phy_support, TP);
 
 	linkmode_zero(sfp_support);
 	sfp_parse_support(phydev->sfp_bus, id, sfp_support, interfaces);
@@ -877,6 +973,10 @@ static int dp83869_module_insert(void *upstream, const struct sfp_eeprom_id *id)
 	dp83869 = phydev->priv;
 
 	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+		dp83869->mode = DP83869_RGMII_SGMII_BRIDGE;
+		phydev->port = PORT_TP;
+		break;
 	case PHY_INTERFACE_MODE_100BASEX:
 		dp83869->mode = DP83869_RGMII_100_BASE;
 		phydev->port = PORT_FIBRE;
@@ -899,6 +999,10 @@ static const struct sfp_upstream_ops dp83869_sfp_ops = {
 	.attach = phy_sfp_attach,
 	.detach = phy_sfp_detach,
 	.module_insert = dp83869_module_insert,
+	.module_start = dp83869_module_start,
+	.module_stop = dp83869_module_stop,
+	.connect_phy = dp83869_connect_phy,
+	.disconnect_phy = dp83869_disconnect_phy,
 };
 
 static int dp83869_probe(struct phy_device *phydev)

-- 
2.45.2


