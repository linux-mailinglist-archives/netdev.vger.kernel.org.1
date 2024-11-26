Return-Path: <netdev+bounces-147437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4569D97B2
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 13:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ED10B26E91
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 12:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526F31D45E5;
	Tue, 26 Nov 2024 12:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Cx5g/fhu"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA96D1D47C7
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 12:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732625657; cv=none; b=K2AjtKrulSxXD7nwexmkt7dhyxnx2vJJ/KtFwFChL57iKANy3OZAKuVg0UNHYkp7BN6EgBg5t3Jf+WNvvnsCLKUM63yQ+4xMk+2Rl/rMfPkq0rJoXb8MhCqjHebzlvBTktBDizprmyIvqUQiRNM3Vvwqxc0IErggtoa1VBCNgR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732625657; c=relaxed/simple;
	bh=+v8Dz6PYr9n53JYVuNeFhTAlr8QyEzt6AA6RSIHcAtg=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=bbyBx1PAbVW3JqNKqdZF+xeCHYBEyCYo1vndXl6IkQjwbZxk/91XVzcRVUiB7Jn7TqAbxQSZr3g/Arj/yVZ/viKqYPuC62JL5WtNEhwFCm2+75e7M+4t9QnxvedUNkPc25li9yf56b0aJd1UQwn7vwbsiZLli4UiNK+izYMRvJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Cx5g/fhu; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1H0Jhuk4wsGwV0F/kdOytsbVMrr30yenbxsl+LLwQAE=; b=Cx5g/fhuHz00mFVpsGDXaU8o9e
	yG0RE38xqwrwF4Kuc8v7RktfvEIWhJMgmoI+8Lg7Q7sqb+fT+ywO7TcqlBg0UQxxRBzmMTNpuhjOS
	umTcFP7TD0pD1a1BJ9YLUxA9jnGd05wGjvSX9MvqZ7/jZm4yC4hxAb9Vqb0J/imhaUKfzD7ySuXjX
	5Acn9M6HAIpaY9Tc7QUMq6I/hnQw0u1k5cthj/6NOBl5jq8JEZdISnQtECrRy8k630tO7BFd1frhY
	3Pmq9oLVgdr4dd6b3K++rLBYSjiBm3Zpy9yEC5SoFzASjXl+sWY+AMxHM7FBVcGeDNWSgJ8gCI4Vf
	9lzgHx6A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50156 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tFv4u-0006yc-2K;
	Tue, 26 Nov 2024 12:54:05 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tFv4t-005yjW-IY; Tue, 26 Nov 2024 12:54:03 +0000
In-Reply-To: <Z0XEWGqLJ8okNSIr@shell.armlinux.org.uk>
References: <Z0XEWGqLJ8okNSIr@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com
Subject: [PATCH RFC net-next 22/23] net: stmmac: convert to use
 phy_eee_rx_clock_stop()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tFv4t-005yjW-IY@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 26 Nov 2024 12:54:03 +0000

Convert stmmac to use phy_eee_rx_clock_stop() to set the PHY receive
clock stop in LPI setting, rather than calling the legacy
phy_init_eee() function.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7924808fec08..66a43a9aa469 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1083,9 +1083,9 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 
 	stmmac_mac_set(priv, priv->ioaddr, true);
 	if (phy && priv->dma_cap.eee) {
-		priv->eee_active = phy->enable_tx_lpi &&
-			phy_init_eee(phy, !(priv->plat->flags &
-				STMMAC_FLAG_RX_CLK_RUNS_IN_LPI)) >= 0;
+		phy_eee_rx_clock_stop(phy, !(priv->plat->flags &
+					     STMMAC_FLAG_RX_CLK_RUNS_IN_LPI));
+		priv->eee_active = phy->enable_tx_lpi;
 		priv->eee_enabled = stmmac_eee_init(priv);
 		priv->tx_lpi_timer = phy->eee_cfg.tx_lpi_timer;
 		stmmac_set_eee_pls(priv, priv->hw, true);
-- 
2.30.2


