Return-Path: <netdev+bounces-212165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E1DB1E82E
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 14:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBB00620AB7
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 12:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBFF277017;
	Fri,  8 Aug 2025 12:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PakCq/0P"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521A526B74F
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 12:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754655454; cv=none; b=AhNaEE9uXdCXkbSCoBdze9SQu11WRbv6vK2+JdzyMhvKIhEm3A4C/J3YM38VtcGjMLS3sfOIO6afiFgHkBFZinRDOY9bc34yRJh7xLAU6EpANfbdVXlJ31ksQHXa2dRHdwMw5pVkDlMnJlGTgeDZG749cW2tQNXNofiT1faM2A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754655454; c=relaxed/simple;
	bh=mpVwnsW7H7OYLDLHf1JvMHRIl7lPFPFEEY9Tcq3fBHE=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=GKpJCyB90hpUD+buBv05UhLSTNSH2DghQIqtbD+Ub5JcX+NiMcxfbkN4TzwXYguBi4PkctMIsV1wvz0xTwSFN50z5dqG8ONx1/UWVVU9v5JOdut+/g6TCjqExTL244DIwuIlga19FBpeH2U3wdx+JMrgoGI72fNvBfbMnELY0tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=PakCq/0P; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dUde5XvOXmf2RTKh7B+1y5/eHwJoJtelhNB3+mdvsF0=; b=PakCq/0PE4evWx1HnXkJq2A2Xv
	mFxfci1awEsJ83kmoNA7/M81AME3hOmD2jlxlyLUsW8gXmtVNP7jaGEI2RJgmChS7/vfa+KLSDNno
	xaHpN28FwfKvAmwPxTdZFrPGxYQAlx6WLPuFO+k2CW8D0KpbfEdk+TFoF5xex+P/b1CkGb1X4/ng4
	GGq9hlVAev7TKQQtEx80LJ/9RuQ/F7q63phLQYYpP/v04H2ti615cA0jLRU3Uqs0P4wP97uKSDXJa
	+gRwv1LVk5GAAtSoh+uQKdbyHDpIlcGwY4ZB59aQRPzpCmqR4VvK4AyToMxDgwVuXQeQCSgOqXxdh
	3w4PT5dw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41678 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1ukM2B-0007Zd-02;
	Fri, 08 Aug 2025 13:17:19 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1ukM1S-0086qo-PC; Fri, 08 Aug 2025 13:16:34 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	David Wu <david.wu@rock-chips.com>,
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
Subject: [PATCH net v2] net: stmmac: rk: put the PHY clock on remove
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ukM1S-0086qo-PC@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 08 Aug 2025 13:16:34 +0100

The PHY clock (bsp_priv->clk_phy) is obtained using of_clk_get(), which
doesn't take part in the devm release. Therefore, when a device is
unbound, this clock needs to be explicitly put. Fix this.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Spotted this resource leak while making other changes to dwmac-rk.
Would be great if the dwmac-rk maintainers can test it.

v2: fix build error

 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 79b92130a03f..f6687c2f30f6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1765,11 +1765,15 @@ static int rk_gmac_probe(struct platform_device *pdev)
 
 static void rk_gmac_remove(struct platform_device *pdev)
 {
-	struct rk_priv_data *bsp_priv = get_stmmac_bsp_priv(&pdev->dev);
+	struct stmmac_priv *priv = netdev_priv(platform_get_drvdata(pdev));
+	struct rk_priv_data *bsp_priv = priv->plat->bsp_priv;
 
 	stmmac_dvr_remove(&pdev->dev);
 
 	rk_gmac_powerdown(bsp_priv);
+
+	if (priv->plat->phy_node && bsp_priv->integrated_phy)
+		clk_put(bsp_priv->clk_phy);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.30.2


