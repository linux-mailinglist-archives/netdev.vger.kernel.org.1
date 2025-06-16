Return-Path: <netdev+bounces-198267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7EFADBBB2
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 23:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E06313AF18C
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 21:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53018214818;
	Mon, 16 Jun 2025 21:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ov0fxDhm"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A0A1E89C
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 21:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750108034; cv=none; b=edYZDaITda+XTbXhkAj5VoBL69lk50cXauBdf/dbPWuHQw08eOzfO6y8ZeY9m4jlbe6nGMI+QdlVYDFnehzMhgQ8c75CILmyyrxY7rekBuv4Rralo811YehXkE/qMUz9UInqANj9KqLpECH8tncgKzpOn40LqHW7DxNrDjczcO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750108034; c=relaxed/simple;
	bh=0dNDHHC0EQhRlOQmI06LjIrWi8Fbx8OLO4FhO1y3l9E=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=nDydnWjh9XNexnZ64R/4qn2avIt7fhfPE5vpLsrX8zQh073DF8uYDEvnsD/dAI5ybiJQ4moUqrf8feMvDmcZAWwIp1EHwN/Y/Er6ORuZa2+cLltr6O7uzgravNMdh5i/bSeoi77uIBzTntxZgB3Dsgm/NdLgGWIP/h2v705wA94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ov0fxDhm; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dxsrAg54BDPUoWOTh34lObpoeyszGT90sFygSRlocmo=; b=ov0fxDhmCwmNxTg/MGXYEZIWvb
	pkozhIu9suju9ow8/A07/I5CcG9ahAe13kDxtI8rhiRgjtpDubrO+wrdJh34IptHZPnBWKxpaEGJ7
	7eGxJxlt5dEhBgucBiLmRJTPa15XA+nsaJtkMX9LtrOFEUDMtx1+m2pVocYhmFO1uCbuCTd2dPyAH
	+Wtz2RNUFOiA6OAzLOTiVAhsZ6FItJwkO1qQsN2S6KKf15xQja1WeqEKeWsBKupXgsDrakKmm54yQ
	L3gKnL9hlUa0ffVEP+W1ZhMiVimWWTpPE4ba6JayL/0W6sR5u/21J8D8CUKGnhZf9Dy/gAKaALWJa
	RRcApiDA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41064 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uRH2l-0004Gr-0B;
	Mon, 16 Jun 2025 22:07:03 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uRH26-004UyM-9G; Mon, 16 Jun 2025 22:06:22 +0100
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
Subject: [PATCH net-next 2/4] net: stmmac: visconti: reorganise
 visconti_eth_set_clk_tx_rate()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uRH26-004UyM-9G@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 16 Jun 2025 22:06:22 +0100

Rather than testing dwmac->phy_intf_sel several times for the same
values in this function, group the code together. The only part
which was common was stopping the internal clock before programming
the clock setting.

This further improves the readability of this function.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../ethernet/stmicro/stmmac/dwmac-visconti.c  | 51 +++++++++++--------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
index ef86f9dce791..c2aaac4a5ac1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
@@ -76,6 +76,22 @@ static int visconti_eth_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
 		default:
 			return -EINVAL;
 		}
+
+		/* Stop internal clock */
+		val = readl(dwmac->reg + REG_ETHER_CLOCK_SEL);
+		val &= ~(ETHER_CLK_SEL_RMII_CLK_EN | ETHER_CLK_SEL_RX_TX_CLK_EN);
+		val |= ETHER_CLK_SEL_TX_O_E_N_IN;
+		writel(val, dwmac->reg + REG_ETHER_CLOCK_SEL);
+
+		/* Set Clock-Mux, Start clock, Set TX_O direction */
+		val = clk_sel_val | ETHER_CLK_SEL_RX_CLK_EXT_SEL_RXC;
+		writel(val, dwmac->reg + REG_ETHER_CLOCK_SEL);
+
+		val |= ETHER_CLK_SEL_RX_TX_CLK_EN;
+		writel(val, dwmac->reg + REG_ETHER_CLOCK_SEL);
+
+		val &= ~ETHER_CLK_SEL_TX_O_E_N_IN;
+		writel(val, dwmac->reg + REG_ETHER_CLOCK_SEL);
 	} else if (dwmac->phy_intf_sel == ETHER_CONFIG_INTF_RMII) {
 		switch (speed) {
 		case SPEED_100:
@@ -89,27 +105,14 @@ static int visconti_eth_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
 		default:
 			return -EINVAL;
 		}
-	}
-
-	/* Stop internal clock */
-	val = readl(dwmac->reg + REG_ETHER_CLOCK_SEL);
-	val &= ~(ETHER_CLK_SEL_RMII_CLK_EN | ETHER_CLK_SEL_RX_TX_CLK_EN);
-	val |= ETHER_CLK_SEL_TX_O_E_N_IN;
-	writel(val, dwmac->reg + REG_ETHER_CLOCK_SEL);
 
-	/* Set Clock-Mux, Start clock, Set TX_O direction */
-	switch (dwmac->phy_intf_sel) {
-	case ETHER_CONFIG_INTF_RGMII:
-		val = clk_sel_val | ETHER_CLK_SEL_RX_CLK_EXT_SEL_RXC;
-		writel(val, dwmac->reg + REG_ETHER_CLOCK_SEL);
-
-		val |= ETHER_CLK_SEL_RX_TX_CLK_EN;
+		/* Stop internal clock */
+		val = readl(dwmac->reg + REG_ETHER_CLOCK_SEL);
+		val &= ~(ETHER_CLK_SEL_RMII_CLK_EN | ETHER_CLK_SEL_RX_TX_CLK_EN);
+		val |= ETHER_CLK_SEL_TX_O_E_N_IN;
 		writel(val, dwmac->reg + REG_ETHER_CLOCK_SEL);
 
-		val &= ~ETHER_CLK_SEL_TX_O_E_N_IN;
-		writel(val, dwmac->reg + REG_ETHER_CLOCK_SEL);
-		break;
-	case ETHER_CONFIG_INTF_RMII:
+		/* Set Clock-Mux, Start clock, Set TX_O direction */
 		val = clk_sel_val | ETHER_CLK_SEL_RX_CLK_EXT_SEL_DIV |
 			ETHER_CLK_SEL_TX_CLK_EXT_SEL_DIV | ETHER_CLK_SEL_TX_O_E_N_IN |
 			ETHER_CLK_SEL_RMII_CLK_SEL_RX_C;
@@ -120,16 +123,20 @@ static int visconti_eth_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
 
 		val |= ETHER_CLK_SEL_RMII_CLK_EN | ETHER_CLK_SEL_RX_TX_CLK_EN;
 		writel(val, dwmac->reg + REG_ETHER_CLOCK_SEL);
-		break;
-	case ETHER_CONFIG_INTF_MII:
-	default:
+	} else {
+		/* Stop internal clock */
+		val = readl(dwmac->reg + REG_ETHER_CLOCK_SEL);
+		val &= ~(ETHER_CLK_SEL_RMII_CLK_EN | ETHER_CLK_SEL_RX_TX_CLK_EN);
+		val |= ETHER_CLK_SEL_TX_O_E_N_IN;
+		writel(val, dwmac->reg + REG_ETHER_CLOCK_SEL);
+
+		/* Set Clock-Mux, Start clock, Set TX_O direction */
 		val = clk_sel_val | ETHER_CLK_SEL_RX_CLK_EXT_SEL_RXC |
 			ETHER_CLK_SEL_TX_CLK_EXT_SEL_TXC | ETHER_CLK_SEL_TX_O_E_N_IN;
 		writel(val, dwmac->reg + REG_ETHER_CLOCK_SEL);
 
 		val |= ETHER_CLK_SEL_RX_TX_CLK_EN;
 		writel(val, dwmac->reg + REG_ETHER_CLOCK_SEL);
-		break;
 	}
 
 	return 0;
-- 
2.30.2


