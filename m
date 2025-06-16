Return-Path: <netdev+bounces-198268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2742ADBBB4
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 23:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F2D4188EDFD
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 21:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DAC2139B5;
	Mon, 16 Jun 2025 21:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="o3vcwMCF"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52AF1E89C
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 21:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750108038; cv=none; b=FcpQQyVkllQIfow7nxMaemkfk2sHpN5pZIlPAlUq/xF5vIMreVvfpPPlKUZtrpswFi8l4PIqjeVSiINp0D9+g+w8YNTo0aorhyzaWODYMKBP69/+FndLkrhR4yw834bJzmu0CCcQIvey3Ki+ceAisEz6eKD3Si9r8ZBsZ5Ap9NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750108038; c=relaxed/simple;
	bh=KbV8GADvLwNS1+IiLDCAJmaB94d3TtOLkXrw95XVLvY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=uYDodx3tZuwqSwDnSlxVCVvJt6NO6HNT3wYrM1EDnoW7ZXR0oC4m2/cGVaKR4XswnNty6sJsV1Y828vfXi9s4a17Wcwt7zpeqMznBdcqs7wo0MIWjTk6pJZUmoNlAZhUZC66SFf8sOzrp6gSPVNbh1IccVYEJXxt+GnFBfCaG10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=o3vcwMCF; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=usS8eSGq09XLP07GR4QpRxtU219wXTyDk0hJf9XtFIU=; b=o3vcwMCFnedGLDnmq/PMDZqR4t
	wT43Kc8QNUlkXwWVzuDyEujY3e801pdzB1IMFEdRKEfuDSaMd6WU1MzOs3Dj/+LkduSCMoJhvJdJS
	xNExyNFtuQYG07YC5LZp88lMCHvM63/cg5d2+iop4uvNpZUS8/p27Ym/LPqcY2H33fXg0fGQgMYlc
	yRaZnRaIPmg9kLWVoW9qpOaWeT8Lcm7NX8/LgRQQdlVLWtmQWN79TCOa5KuWv6oWk4FiAIKBRUeUh
	rusmTPONu9x+a2p1hAbZPB/629eJmdsTcC9qQGncItb9dYEt+FNRqHDmKW/WBobypQbMjsEONaIRd
	yBOYttFg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41072 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uRH2q-0004H6-0U;
	Mon, 16 Jun 2025 22:07:08 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uRH2B-004UyS-Ch; Mon, 16 Jun 2025 22:06:27 +0100
In-Reply-To: <aFCHJWXSLbUoogi6@shell.armlinux.org.uk>
References: <aFCHJWXSLbUoogi6@shell.armlinux.org.uk>
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
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 3/4] net: stmmac: visconti: clean up code formatting
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uRH2B-004UyS-Ch@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 16 Jun 2025 22:06:27 +0100

Ensure that code is wrapped prior to column 80, and shorten the
needlessly long "clk_sel_val" to just "clk_sel".

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../ethernet/stmicro/stmmac/dwmac-visconti.c  | 35 +++++++++++--------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
index c2aaac4a5ac1..db82b522c248 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
@@ -57,20 +57,20 @@ static int visconti_eth_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
 					phy_interface_t interface, int speed)
 {
 	struct visconti_eth *dwmac = bsp_priv;
-	unsigned int val, clk_sel_val = 0;
+	unsigned int val, clk_sel = 0;
 
 	if (dwmac->phy_intf_sel == ETHER_CONFIG_INTF_RGMII) {
 		switch (speed) {
 		case SPEED_1000:
-			clk_sel_val = ETHER_CLK_SEL_FREQ_SEL_125M;
+			clk_sel = ETHER_CLK_SEL_FREQ_SEL_125M;
 			break;
 
 		case SPEED_100:
-			clk_sel_val = ETHER_CLK_SEL_FREQ_SEL_25M;
+			clk_sel = ETHER_CLK_SEL_FREQ_SEL_25M;
 			break;
 
 		case SPEED_10:
-			clk_sel_val = ETHER_CLK_SEL_FREQ_SEL_2P5M;
+			clk_sel = ETHER_CLK_SEL_FREQ_SEL_2P5M;
 			break;
 
 		default:
@@ -79,12 +79,13 @@ static int visconti_eth_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
 
 		/* Stop internal clock */
 		val = readl(dwmac->reg + REG_ETHER_CLOCK_SEL);
-		val &= ~(ETHER_CLK_SEL_RMII_CLK_EN | ETHER_CLK_SEL_RX_TX_CLK_EN);
+		val &= ~(ETHER_CLK_SEL_RMII_CLK_EN |
+			 ETHER_CLK_SEL_RX_TX_CLK_EN);
 		val |= ETHER_CLK_SEL_TX_O_E_N_IN;
 		writel(val, dwmac->reg + REG_ETHER_CLOCK_SEL);
 
 		/* Set Clock-Mux, Start clock, Set TX_O direction */
-		val = clk_sel_val | ETHER_CLK_SEL_RX_CLK_EXT_SEL_RXC;
+		val = clk_sel | ETHER_CLK_SEL_RX_CLK_EXT_SEL_RXC;
 		writel(val, dwmac->reg + REG_ETHER_CLOCK_SEL);
 
 		val |= ETHER_CLK_SEL_RX_TX_CLK_EN;
@@ -95,11 +96,11 @@ static int visconti_eth_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
 	} else if (dwmac->phy_intf_sel == ETHER_CONFIG_INTF_RMII) {
 		switch (speed) {
 		case SPEED_100:
-			clk_sel_val = ETHER_CLK_SEL_DIV_SEL_2;
+			clk_sel = ETHER_CLK_SEL_DIV_SEL_2;
 			break;
 
 		case SPEED_10:
-			clk_sel_val = ETHER_CLK_SEL_DIV_SEL_20;
+			clk_sel = ETHER_CLK_SEL_DIV_SEL_20;
 			break;
 
 		default:
@@ -108,14 +109,16 @@ static int visconti_eth_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
 
 		/* Stop internal clock */
 		val = readl(dwmac->reg + REG_ETHER_CLOCK_SEL);
-		val &= ~(ETHER_CLK_SEL_RMII_CLK_EN | ETHER_CLK_SEL_RX_TX_CLK_EN);
+		val &= ~(ETHER_CLK_SEL_RMII_CLK_EN |
+			 ETHER_CLK_SEL_RX_TX_CLK_EN);
 		val |= ETHER_CLK_SEL_TX_O_E_N_IN;
 		writel(val, dwmac->reg + REG_ETHER_CLOCK_SEL);
 
 		/* Set Clock-Mux, Start clock, Set TX_O direction */
-		val = clk_sel_val | ETHER_CLK_SEL_RX_CLK_EXT_SEL_DIV |
-			ETHER_CLK_SEL_TX_CLK_EXT_SEL_DIV | ETHER_CLK_SEL_TX_O_E_N_IN |
-			ETHER_CLK_SEL_RMII_CLK_SEL_RX_C;
+		val = clk_sel | ETHER_CLK_SEL_RX_CLK_EXT_SEL_DIV |
+		      ETHER_CLK_SEL_TX_CLK_EXT_SEL_DIV |
+		      ETHER_CLK_SEL_TX_O_E_N_IN |
+		      ETHER_CLK_SEL_RMII_CLK_SEL_RX_C;
 		writel(val, dwmac->reg + REG_ETHER_CLOCK_SEL);
 
 		val |= ETHER_CLK_SEL_RMII_CLK_RST;
@@ -126,13 +129,15 @@ static int visconti_eth_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
 	} else {
 		/* Stop internal clock */
 		val = readl(dwmac->reg + REG_ETHER_CLOCK_SEL);
-		val &= ~(ETHER_CLK_SEL_RMII_CLK_EN | ETHER_CLK_SEL_RX_TX_CLK_EN);
+		val &= ~(ETHER_CLK_SEL_RMII_CLK_EN |
+			 ETHER_CLK_SEL_RX_TX_CLK_EN);
 		val |= ETHER_CLK_SEL_TX_O_E_N_IN;
 		writel(val, dwmac->reg + REG_ETHER_CLOCK_SEL);
 
 		/* Set Clock-Mux, Start clock, Set TX_O direction */
-		val = clk_sel_val | ETHER_CLK_SEL_RX_CLK_EXT_SEL_RXC |
-			ETHER_CLK_SEL_TX_CLK_EXT_SEL_TXC | ETHER_CLK_SEL_TX_O_E_N_IN;
+		val = ETHER_CLK_SEL_RX_CLK_EXT_SEL_RXC |
+		      ETHER_CLK_SEL_TX_CLK_EXT_SEL_TXC |
+		      ETHER_CLK_SEL_TX_O_E_N_IN;
 		writel(val, dwmac->reg + REG_ETHER_CLOCK_SEL);
 
 		val |= ETHER_CLK_SEL_RX_TX_CLK_EN;
-- 
2.30.2


