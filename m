Return-Path: <netdev+bounces-170171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5883BA478E5
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 10:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1E037A262E
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 09:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AE72248B4;
	Thu, 27 Feb 2025 09:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gL7xQh5u"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5DC225762
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 09:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740647852; cv=none; b=ql8xvsB4Z3Q8xcl1m+c2dQErEHuWh4lpY+TUkNzfd9oqZhcbkLWErdn5Ym1uRcnnBVn6A5oaGrNWpvBeVjTpel/PTMhAzs+xqlXu8uiZciGTxa8L90JJfd2qbdydmhIh6CYW6Wg2KJ7eh1joTn+dj90F3qUGzye+DayO+T8pLWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740647852; c=relaxed/simple;
	bh=q8ceYHTreIMQfm6WnOcrS/0YLBgvr1x7BEs3xV3YNZU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=c5sDa+hhBWYieK2nu4I+L3o1gVYv0qOwQ+hglUQADJQfwPIcMwpWeM8iMGl7ReI63xYYrY906vwfp/vwk5aX65jXiJrYXtvtLu4wRLYUYoHwOeCEA7wdM1DyiIj6/BxH8wqL0qOJJ5+BkqdRdsgOG6+vGfd0We3TtA+ZWgfOGNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=gL7xQh5u; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=d0ZbMy4p+KTtbwsU/BR1wCC/2lakW8Pk7WJBqfnp+Fc=; b=gL7xQh5uQB8sVK9zwRoUrMfQrE
	TS6a7qQ7LjwLDqPHwUgbLpD8ahhwwHfl6sn1WxRPBEZxMlqvNg5rGEq8Y9I4afJSfJcFRyL6rIE/U
	N7qey8YHNIdyatVyJPdtVzC35TZXWZbPzta6l/W8TbLYdpnSxAsj2nfMhNPPdlCBaDfbajgrgaZQw
	sF3qB2XMdNU2qkNdLlYNKceIdf4xrjzupOqQZdozGL2a5YpKmAHm+rHRS+pOiNLMAZQtM/dX3dee6
	SmYZD9+vGi/WikR0Vsi+9bbicQ/mM169h2ryEoz5f42+X4kD7UdKj/0O6+g7iBJghsqTcJU48Q/sY
	JqDzVN1w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38316 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tna1E-0006dl-21;
	Thu, 27 Feb 2025 09:17:24 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tna0u-0052tH-KQ; Thu, 27 Feb 2025 09:17:04 +0000
In-Reply-To: <Z8AtX-wyPal1auVO@shell.armlinux.org.uk>
References: <Z8AtX-wyPal1auVO@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 09/11] net: stmmac: ipq806x: switch to use
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
Message-Id: <E1tna0u-0052tH-KQ@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 27 Feb 2025 09:17:04 +0000

Switch from using the fix_mac_speed() hook to set_clk_tx_rate() to
manage the transmit clock.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c
index 7f4b9c1cc32b..0a9c137cc4e6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c
@@ -260,11 +260,12 @@ static int ipq806x_gmac_of_parse(struct ipq806x_gmac *gmac)
 	return PTR_ERR_OR_ZERO(gmac->qsgmii_csr);
 }
 
-static void ipq806x_gmac_fix_mac_speed(void *priv, int speed, unsigned int mode)
+static int ipq806x_gmac_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
+					phy_interface_t interface, int speed)
 {
-	struct ipq806x_gmac *gmac = priv;
+	struct ipq806x_gmac *gmac = bsp_priv;
 
-	ipq806x_gmac_set_speed(gmac, speed);
+	return ipq806x_gmac_set_speed(gmac, speed);
 }
 
 static int
@@ -478,7 +479,7 @@ static int ipq806x_gmac_probe(struct platform_device *pdev)
 
 	plat_dat->has_gmac = true;
 	plat_dat->bsp_priv = gmac;
-	plat_dat->fix_mac_speed = ipq806x_gmac_fix_mac_speed;
+	plat_dat->set_clk_tx_rate = ipq806x_gmac_set_clk_tx_rate;
 	plat_dat->multicast_filter_bins = 0;
 	plat_dat->tx_fifo_size = 8192;
 	plat_dat->rx_fifo_size = 8192;
-- 
2.30.2


