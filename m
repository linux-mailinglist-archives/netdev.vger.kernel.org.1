Return-Path: <netdev+bounces-198017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75609ADAD2D
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 12:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA6F73A3495
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 10:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6D12882CE;
	Mon, 16 Jun 2025 10:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Sb8NJi1j"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F3527EFE3
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 10:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750069011; cv=none; b=rs9SkRlvdV9wtoqba4ka/r/l5Rl9nNTruSVK8o1XPhAuwS7usMK7iStuFCz5Q1CYq6WkOF/6Aem4UucfH8BoEGmYotbeg3YvZtJtwuNTVVfQqxs2SA0RZFopSiXw60Bqi7I1cUOflmA2knZGII2yCFANb0yVLZkuDRHMjN96eKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750069011; c=relaxed/simple;
	bh=4UyQyagznv5a8AdPMkk3M8qiCLhXFxBIk9H5VUaWGnw=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=YXjQc2/te2nOCpim8hlHK3pAo4a0y1DJ3HHCLIItDwXbW6Lw8Wf3RL66NvaB5ARzKDhZoXshJzE28RS1Zn7770mET2vJOlJ0TXU7+/g/4Wc7uLIz6mVB4GFs8ZN+dRqSRWG8sSV4tKsbiWIfdPdw6senAUF+eVvJHgiEAEcbK/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Sb8NJi1j; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=i+lsTaU7RwEBcehbNbGo3qJpxDvpz1hEP91DuwXf27E=; b=Sb8NJi1j1wgs7rxo26V4o5kf62
	XTTZPvRGMz8tmy+BNl0LNU+jR41N5229OcAza2loD1++lP9ssFHKFKoPo9cDBCiODeDUmT6v5TXD7
	RC1cClZmi45lb0pQQ85lQCmL/i72Lr91HkhgbwPwuh877xuPG9+bLXjk3DWadQJ+MeIivlXl74mO+
	4SQH2H/FxhwF+SY0++A9sHDFgaOdaLCzRiDGSnNWszpUByb9OLJqurxK0f4Ci76vWyo3jAaVwZiFy
	zWs9xxah18W+hXTLSPeCrKVJ+U0Qh7yttPkRDFPP3WOTujyjTlC9uroa2TjWwXzgRFfHCKt/VGEQF
	NxtcwG0g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50820 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uR6tO-0003aw-14;
	Mon, 16 Jun 2025 11:16:42 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uR6sj-004Ku5-HR; Mon, 16 Jun 2025 11:16:01 +0100
In-Reply-To: <aE_u8mCkUXEWTzJe@shell.armlinux.org.uk>
References: <aE_u8mCkUXEWTzJe@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 3/3] net: stmmac: rk: remove unnecessary clk_mac
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uR6sj-004Ku5-HR@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 16 Jun 2025 11:16:01 +0100

The stmmac platform code already gets the "stmmaceth" clock, so there
is no need for drivers to get it. Use the stored pointer in struct
plat_stmmacenet_data instead of getting and storing our own pointer.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 7ee101a6cfcf..79b92130a03f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -80,7 +80,6 @@ struct rk_priv_data {
 
 	struct clk_bulk_data *clks;
 	int num_clks;
-	struct clk *clk_mac;
 	struct clk *clk_phy;
 
 	struct reset_control *phy_reset;
@@ -1408,16 +1407,10 @@ static int rk_gmac_clk_init(struct plat_stmmacenet_data *plat)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get clocks\n");
 
-	/* "stmmaceth" will be enabled by the core */
-	bsp_priv->clk_mac = devm_clk_get(dev, "stmmaceth");
-	ret = PTR_ERR_OR_ZERO(bsp_priv->clk_mac);
-	if (ret)
-		return dev_err_probe(dev, ret, "Cannot get stmmaceth clock\n");
-
 	if (bsp_priv->clock_input) {
 		dev_info(dev, "clock input from PHY\n");
 	} else if (phy_iface == PHY_INTERFACE_MODE_RMII) {
-		clk_set_rate(bsp_priv->clk_mac, 50000000);
+		clk_set_rate(plat->stmmac_clk, 50000000);
 	}
 
 	if (plat->phy_node && bsp_priv->integrated_phy) {
-- 
2.30.2


