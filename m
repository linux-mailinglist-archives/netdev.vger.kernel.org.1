Return-Path: <netdev+bounces-236292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC958C3A943
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 12:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0683F463E5D
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 11:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0AC30EF8F;
	Thu,  6 Nov 2025 11:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="kg1cyJic"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE0530E0E3
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 11:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428238; cv=none; b=U/ZjFb5Kn9CPBk7LHA11uXaYU7Yzlimitv8kGAIYRym1B9CYeGLjPgIM0VcfOFGUi6HVBFHDKAl4iceGtOJJTun2QKDttVepsWFA+Zcch903U+RifYPaDonPbXbRM1eI3U5YKMUH46wqDJzOVSOEpuc57Ebfiw0qKwg3pnrxvhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428238; c=relaxed/simple;
	bh=kYYxWxjIaf2qRK1OFFYqhF6tjHcJXDKkMQd0oNmk5wc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=t61qpeETz+/5/peQ0xTKo5M3MeL1TNu3C6dWZS8bppk4GqDDQM8TAhFaAQKPI8g8tZNwaXlJTPTyqV6IbzJL5OdRAKexnVhc6Hh1a1lUFiXGdF9d8+HSNV+VtV193NiyYwao7zGiuoAdjZNt95I7n4w51chKWdHxP5Fh6s1c4q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=kg1cyJic; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SdMM7KkXcfysHjh2oOZyk9CSNG82qeeBAIml5f+qIcw=; b=kg1cyJicC3zE2o3HFvYFpRxC7H
	G96xRdmqleIdbP4gB1OikZ2YjqRLrJb6/W5ay8oAy5Pg/T+Q3LZerXacKxmHn39rTDjE/TFjpZW68
	u3ForGr8eIRgOev4Z7DLyYxHKqV6PCJJp2MhwgGjdLdhnJ1+2SLGmi3kfdSvXd+QDyfdqi2WnCLl/
	HvyzoB5FXFXxICaY2tglnocCY+6+TXN/EIIaQCthFZjOr362zmQoUbapn0eDYqQswqaY11MoS8leS
	BE0GUNq84He377qCsZHwr5cXz0vfM/+U0uee7ctJaDFjETEsZUHOCwHvcJ5JAp0+fUcKww9fQmR32
	xDikETyA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:48252 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vGy5k-000000004wR-23Q9;
	Thu, 06 Nov 2025 11:23:48 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vGy5j-0000000DhQh-2e0x;
	Thu, 06 Nov 2025 11:23:47 +0000
In-Reply-To: <aQyEs4DAZRWpAz32@shell.armlinux.org.uk>
References: <aQyEs4DAZRWpAz32@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH net-next 8/9] net: stmmac: sti: use stmmac_get_phy_intf_sel()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vGy5j-0000000DhQh-2e0x@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 06 Nov 2025 11:23:47 +0000

Use stmmac_get_phy_intf_sel() to decode the PHY interface mode to the
phy_intf_sel value, validate the result and use that to set the
control register to select the operating mode for the DWMAC core.

Note that when an unsupported interface mode is used, the array would
decode this to PHY_INTF_SEL_GMII_MII, so preserve this behaviour.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-sti.c   | 22 ++++++++-----------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
index c97535824be0..593e154b5957 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
@@ -77,10 +77,9 @@
  *	001-RGMII
  *	010-SGMII
  *	100-RMII
- * These are the DW MAC phy_intf_sel values
+ * These are the DW MAC phy_intf_sel values.
  */
 #define MII_PHY_SEL_MASK	GENMASK(4, 2)
-#define MII_PHY_SEL_VAL(val)	FIELD_PREP_CONST(MII_PHY_SEL_MASK, val)
 
 struct sti_dwmac {
 	phy_interface_t interface;	/* MII interface */
@@ -99,15 +98,6 @@ struct sti_dwmac_of_data {
 	void (*fix_retime_src)(void *priv, int speed, unsigned int mode);
 };
 
-static u8 phy_intf_sels[] = {
-	[PHY_INTERFACE_MODE_MII] = PHY_INTF_SEL_GMII_MII,
-	[PHY_INTERFACE_MODE_GMII] = PHY_INTF_SEL_GMII_MII,
-	[PHY_INTERFACE_MODE_RGMII] = PHY_INTF_SEL_RGMII,
-	[PHY_INTERFACE_MODE_RGMII_ID] = PHY_INTF_SEL_RGMII,
-	[PHY_INTERFACE_MODE_SGMII] = PHY_INTF_SEL_SGMII,
-	[PHY_INTERFACE_MODE_RMII] = PHY_INTF_SEL_RMII,
-};
-
 enum {
 	TX_RETIME_SRC_NA = 0,
 	TX_RETIME_SRC_TXCLK = 1,
@@ -160,13 +150,19 @@ static int sti_dwmac_set_mode(struct sti_dwmac *dwmac)
 {
 	struct regmap *regmap = dwmac->regmap;
 	u32 reg = dwmac->ctrl_reg;
-	u8 phy_intf_sel;
+	int phy_intf_sel;
 	u32 val;
 
 	if (dwmac->gmac_en)
 		regmap_update_bits(regmap, reg, EN_MASK, EN);
 
-	phy_intf_sel = phy_intf_sels[dwmac->interface];
+	phy_intf_sel = stmmac_get_phy_intf_sel(dwmac->interface);
+	if (phy_intf_sel != PHY_INTF_SEL_GMII_MII &&
+	    phy_intf_sel != PHY_INTF_SEL_RGMII &&
+	    phy_intf_sel != PHY_INTF_SEL_SGMII &&
+	    phy_intf_sel != PHY_INTF_SEL_RMII)
+		phy_intf_sel = PHY_INTF_SEL_GMII_MII;
+
 	regmap_update_bits(regmap, reg, MII_PHY_SEL_MASK,
 			   FIELD_PREP(MII_PHY_SEL_MASK, phy_intf_sel));
 
-- 
2.47.3


