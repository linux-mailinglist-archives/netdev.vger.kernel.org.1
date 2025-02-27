Return-Path: <netdev+bounces-170173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBB1A478E7
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 10:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D9B9188B683
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 09:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EC8225762;
	Thu, 27 Feb 2025 09:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Cu0S5ynV"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271EA22759C
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 09:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740647865; cv=none; b=ZKimwA/3nrY+2F8x0Y+MajuHbrd3Yrk5Le4HNOspXANU+Qm5oFAt5bkJZfDtKbACT8UdUBl7MQN1EJLhtFrQeRLkDwlDHvN6FjLvBV7m2e0ImTnevtU9i6hjtCgYyeBXg3pED2WkluGR2nCkdpj0lygweYZFF60wi0kJ4xt/8oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740647865; c=relaxed/simple;
	bh=Gq5hb3GHoo9i/ZxiJ6CxfQszxyri2E0X71otFZ/sCx0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=jl7SKGLOBQEPvJtDsfSUyJH8gRzCmCEHadgGcqs57myIkQF2ENuI7QwzoaiA83ZULNiYU/cpdp8GNa5UhxdpLSm8v/2Fd2klLET9TiSgJhZYd0NVxdHL5pmmzHHQETy1elVz3Jz/jezTW7q5eFH29+jYeOQRctMS+cSw+LVkB/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Cu0S5ynV; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ufZqnl34vm+Pc3lq/GZFpFx8vvNtFX+vITx7KqbOkWc=; b=Cu0S5ynVTtTZxDgbsXX8fgD9Pf
	iCbv2qYrqpBlzm2jdjz8Lf2cwvZOvlriYf2nXoV65RT4m2GcPFqwxrBWj9tPGMnYLzRb40RTAErcv
	yrDjd51be6Xot7fWRCTUjhrFULrwoWHYpdCPihoOPmkZDuMyxl3QP7OGELscLIFPPl5fvaTRdSc5B
	uCZ8H83Kb8xkDCZmPiCJhg0FUQ3SHbVCNj4bqN/cp9iZ2TbUtBl6Xu0NL2OHRiwKMo4mZr6YTpyrU
	kkVtFRioqKVS55ri5MiPhJmvjEJCtQZJmoHpEPj6OsEjrCpwUpktLQOwOji8mtu52ojl6GcBoLRcD
	4vFlmDYg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:37578 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tna1O-0006eI-36;
	Thu, 27 Feb 2025 09:17:35 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tna14-0052tT-S4; Thu, 27 Feb 2025 09:17:14 +0000
In-Reply-To: <Z8AtX-wyPal1auVO@shell.armlinux.org.uk>
References: <Z8AtX-wyPal1auVO@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Drew Fustini <drew@pdp7.com>,
	Eric Dumazet <edumazet@google.com>,
	Fu Wei <wefu@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 11/11] net: stmmac: thead: switch to use
 set_clk_tx_rate() hook
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tna14-0052tT-S4@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 27 Feb 2025 09:17:14 +0000

Switch from using the fix_mac_speed() hook to set_clk_tx_rate() to
manage the transmit clock.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-thead.c  | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
index f9f2bd65959f..c72ee759aae5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
@@ -101,10 +101,11 @@ static int thead_dwmac_set_txclk_dir(struct plat_stmmacenet_data *plat)
 	return 0;
 }
 
-static void thead_dwmac_fix_speed(void *priv, int speed, unsigned int mode)
+static int thead_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
+				 phy_interface_t interface, int speed)
 {
+	struct thead_dwmac *dwmac = bsp_priv;
 	struct plat_stmmacenet_data *plat;
-	struct thead_dwmac *dwmac = priv;
 	unsigned long rate;
 	long tx_rate;
 	u32 div, reg;
@@ -114,7 +115,7 @@ static void thead_dwmac_fix_speed(void *priv, int speed, unsigned int mode)
 	switch (plat->mac_interface) {
 	/* For MII, rxc/txc is provided by phy */
 	case PHY_INTERFACE_MODE_MII:
-		return;
+		return 0;
 
 	case PHY_INTERFACE_MODE_RGMII:
 	case PHY_INTERFACE_MODE_RGMII_ID:
@@ -127,23 +128,24 @@ static void thead_dwmac_fix_speed(void *priv, int speed, unsigned int mode)
 		tx_rate = rgmii_clock(speed);
 		if (tx_rate < 0) {
 			dev_err(dwmac->dev, "invalid speed %d\n", speed);
-			return;
+			return tx_rate;
 		}
 
 		div = rate / tx_rate;
 		if (rate != tx_rate * div) {
 			dev_err(dwmac->dev, "invalid gmac rate %lu\n", rate);
-			return;
+			return -EINVAL;
 		}
 
 		reg = FIELD_PREP(GMAC_PLLCLK_DIV_EN, 1) |
 		      FIELD_PREP(GMAC_PLLCLK_DIV_NUM, div);
 		writel(reg, dwmac->apb_base + GMAC_PLLCLK_DIV);
-		break;
+		return 0;
+
 	default:
 		dev_err(dwmac->dev, "unsupported phy interface %d\n",
 			plat->mac_interface);
-		return;
+		return -EINVAL;
 	}
 }
 
@@ -235,7 +237,7 @@ static int thead_dwmac_probe(struct platform_device *pdev)
 	dwmac->plat = plat;
 	dwmac->apb_base = apb;
 	plat->bsp_priv = dwmac;
-	plat->fix_mac_speed = thead_dwmac_fix_speed;
+	plat->set_clk_tx_rate = thead_set_clk_tx_rate;
 	plat->init = thead_dwmac_init;
 
 	return devm_stmmac_pltfr_probe(pdev, plat, &stmmac_res);
-- 
2.30.2


