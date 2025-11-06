Return-Path: <netdev+bounces-236200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D911BC39B20
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 09:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2074E3BCAFB
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 08:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF7B3093C8;
	Thu,  6 Nov 2025 08:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ZtIhjNzr"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121043093C4
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 08:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419492; cv=none; b=ZYN1+bRG1Xd8wlZRRh1cJ16oULHBfTJk5wedtQofAvdMXemsggbBBce/OpxfZeXqAh2sBHMyCPHqDRktUsairfLxaS0Sk3j5fakyeI1kMTX3L1jANyTWzdggd8VDHDw6U1yrCpH+nOiJzrfUDrhCdNUD7RRHUxZQ8V2YTE4qOWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419492; c=relaxed/simple;
	bh=NJRk4gCpB7j348/R8UgFadtdX/MguD0HFdob0Myk4sc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=VHcemAdFjtPgl5kcGpSotFKmmC5rH5VESQnIr9C7Jki5gGyFss1n8J6mVeF1C9hrCmKnr2e5XglwAwUr2bXsJfv80iaD4FqDnuBJVYsnpNzvW1Bji9U7HRKasJ2NoMzCCIkEFkv6SEfdHBnbldnm7ZxwhPheHVL8IumcgZhavmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ZtIhjNzr; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=F6N99lrQWCcBVEeWi2m/1Xqc19M+JXMRguvcKgYbv0E=; b=ZtIhjNzrx5jf3ipjUKK11lNdEE
	JZyp3zoahC85NAn+ey2QkZ5wEGBP64baxDQA6XfgLrrBWBdQPpC+w3eMnXLAmwngFVVMiRLtrLi3Z
	xDybdLD9HKYguK4FicP7tkVi9fhUklhz/b5DLS25hjR52Anfl3ESm8Tebb1Jrj05BoSIq2TOTjvIz
	BADG9qb2SULRwL+6d6xQpKbJYHjpHS7uHSOf5yiG2FLUmLm/mZdknEyIhyz327nS3GKdeYd68Mge7
	/UflktOF5En9s9Q9YYRoCLbwokEj64GF/LzKOlJidrtARFfpViSGUg9UaHDrIxyGAjiRKI6ntyCeO
	po5n9Sig==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:58996 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vGvog-000000004ZS-0DUK;
	Thu, 06 Nov 2025 08:58:02 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vGvoe-0000000DWp8-37LQ;
	Thu, 06 Nov 2025 08:58:00 +0000
In-Reply-To: <aQxinH5WWcunfP7p@shell.armlinux.org.uk>
References: <aQxinH5WWcunfP7p@shell.armlinux.org.uk>
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
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 09/11] net: stmmac: ingenic: simplify x2000
 mac_set_mode()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vGvoe-0000000DWp8-37LQ@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 06 Nov 2025 08:58:00 +0000

As per the previous commit, we have validated that the phy_intf_sel
value is one that is permissible for this SoC, so there is no need to
handle invalid PHY interface modes. We can also apply the other
configuration based upon the phy_intf_sel value rather than the
PHY interface mode.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../ethernet/stmicro/stmmac/dwmac-ingenic.c   | 28 +++++--------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
index 7b2576fbb1e1..eb5744e0b9ea 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
@@ -122,39 +122,25 @@ static int x2000_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
 	struct ingenic_mac *mac = plat_dat->bsp_priv;
 	unsigned int val;
 
-	switch (plat_dat->phy_interface) {
-	case PHY_INTERFACE_MODE_RMII:
-		val = FIELD_PREP(MACPHYC_TX_SEL_MASK, MACPHYC_TX_SEL_ORIGIN) |
-			  FIELD_PREP(MACPHYC_RX_SEL_MASK, MACPHYC_RX_SEL_ORIGIN);
-		break;
-
-	case PHY_INTERFACE_MODE_RGMII:
-	case PHY_INTERFACE_MODE_RGMII_ID:
-	case PHY_INTERFACE_MODE_RGMII_TXID:
-	case PHY_INTERFACE_MODE_RGMII_RXID:
-		val = 0;
+	val = FIELD_PREP(MACPHYC_PHY_INFT_MASK, phy_intf_sel);
+
+	if (phy_intf_sel == PHY_INTF_SEL_RMII) {
+		val |= FIELD_PREP(MACPHYC_TX_SEL_MASK, MACPHYC_TX_SEL_ORIGIN) |
+		       FIELD_PREP(MACPHYC_RX_SEL_MASK, MACPHYC_RX_SEL_ORIGIN);
+	} else if (phy_intf_sel == PHY_INTF_SEL_RGMII) {
 		if (mac->tx_delay == 0)
 			val |= FIELD_PREP(MACPHYC_TX_SEL_MASK, MACPHYC_TX_SEL_ORIGIN);
 		else
 			val |= FIELD_PREP(MACPHYC_TX_SEL_MASK, MACPHYC_TX_SEL_DELAY) |
-				   FIELD_PREP(MACPHYC_TX_DELAY_MASK, (mac->tx_delay + 9750) / 19500 - 1);
+			       FIELD_PREP(MACPHYC_TX_DELAY_MASK, (mac->tx_delay + 9750) / 19500 - 1);
 
 		if (mac->rx_delay == 0)
 			val |= FIELD_PREP(MACPHYC_RX_SEL_MASK, MACPHYC_RX_SEL_ORIGIN);
 		else
 			val |= FIELD_PREP(MACPHYC_RX_SEL_MASK, MACPHYC_RX_SEL_DELAY) |
 				   FIELD_PREP(MACPHYC_RX_DELAY_MASK, (mac->rx_delay + 9750) / 19500 - 1);
-
-		break;
-
-	default:
-		dev_err(mac->dev, "Unsupported interface %s\n",
-			phy_modes(plat_dat->phy_interface));
-		return -EINVAL;
 	}
 
-	val |= FIELD_PREP(MACPHYC_PHY_INFT_MASK, phy_intf_sel);
-
 	/* Update MAC PHY control register */
 	return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, val);
 }
-- 
2.47.3


