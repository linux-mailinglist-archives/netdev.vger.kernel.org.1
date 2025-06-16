Return-Path: <netdev+bounces-198266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDE4ADBBB0
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 23:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB7503AA6FC
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 21:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558B1212F89;
	Mon, 16 Jun 2025 21:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Tk68rq9H"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A02C1E89C
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 21:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750108027; cv=none; b=THLpYwK+HqDvdCZKVFKw7XnupuIdIQrYnRimY9eMvk4/rm8rYNxhGrigzzItUCpNROK50GwsGV8Z5x8UIZx1PndIobwDSAfuO5e494LnhXPmu0pve6FjIkINzk+ienLlajSMWlzAq2kqGt6RsUHlrckBwZW8kud0Agw7xooO/Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750108027; c=relaxed/simple;
	bh=k83PCFAZInh5FwWWo/PhC5C/8IgVYKkAg1tPEJ6+Fyw=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=SF3uutyFiAc4CRMk6KK4ZXvQ19C8uGFsRyJN4wMGmgHSKUkmLKxjyp/ruCYsqpDLsTMdzShh4eceEi9usRCD2V5AuQUP52UTCnwZ7Ygj6sVH9kMFjWP++y1r9GynzhMp5aHCKjn4t5hpcBBQ0v56jkVw7Uu6sSZFIn0a6JdC26I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Tk68rq9H; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5HK7OaVp0TjYPgWKg6AXOdVH8aRtHfxReV5dlUnGC6E=; b=Tk68rq9H+KaChngKJ0QD67osy4
	w9KFNxZ0Feeh9u2QD7iIna981ocDOaw9iFpFjEdWP4V4k4r7ip4RvL/yZVyQ2PjhHyQQDBsxCrGB/
	LQt+zg0qC3skTIdkitvQ+GMhU8kY0C3Zhp+walESCi5gdGLOkX5oZcdS/rZZUnqBnn4Dl1ksHPsBS
	54QxSg/yxnECwJBfUa7ddFYA9SXyKgCZOe4FcoTKcEzHDyN30HAF86FP0RI/CNZJ8vH5GEPwpcZZp
	sXOGkbEH3nhSlzPdtL5Zf9E/2q82tJvc7DnteekFeE/f+0ALDMUfqPHmBuuo1J5h54tOAua+F5jCF
	TU4TM/XA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:43774 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uRH2f-0004Ge-1b;
	Mon, 16 Jun 2025 22:06:57 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uRH21-004UyG-50; Mon, 16 Jun 2025 22:06:17 +0100
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
Subject: [PATCH net-next 1/4] net: stmmac: visconti: re-arrange speed decode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uRH21-004UyG-50@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 16 Jun 2025 22:06:17 +0100

Re-arrange the speed decode in visconti_eth_set_clk_tx_rate() to be
more readable by first checking to see if we're using RGMII or RMII
and then decoding the speed, rather than decoding the speed and then
testing the interface mode.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../ethernet/stmicro/stmmac/dwmac-visconti.c  | 44 +++++++++++--------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
index 5e6ac82a89b9..ef86f9dce791 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
@@ -57,30 +57,38 @@ static int visconti_eth_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
 					phy_interface_t interface, int speed)
 {
 	struct visconti_eth *dwmac = bsp_priv;
-	struct net_device *netdev = dev_get_drvdata(dwmac->dev);
 	unsigned int val, clk_sel_val = 0;
 
-	switch (speed) {
-	case SPEED_1000:
-		if (dwmac->phy_intf_sel == ETHER_CONFIG_INTF_RGMII)
+	if (dwmac->phy_intf_sel == ETHER_CONFIG_INTF_RGMII) {
+		switch (speed) {
+		case SPEED_1000:
 			clk_sel_val = ETHER_CLK_SEL_FREQ_SEL_125M;
-		break;
-	case SPEED_100:
-		if (dwmac->phy_intf_sel == ETHER_CONFIG_INTF_RGMII)
+			break;
+
+		case SPEED_100:
 			clk_sel_val = ETHER_CLK_SEL_FREQ_SEL_25M;
-		if (dwmac->phy_intf_sel == ETHER_CONFIG_INTF_RMII)
-			clk_sel_val = ETHER_CLK_SEL_DIV_SEL_2;
-		break;
-	case SPEED_10:
-		if (dwmac->phy_intf_sel == ETHER_CONFIG_INTF_RGMII)
+			break;
+
+		case SPEED_10:
 			clk_sel_val = ETHER_CLK_SEL_FREQ_SEL_2P5M;
-		if (dwmac->phy_intf_sel == ETHER_CONFIG_INTF_RMII)
+			break;
+
+		default:
+			return -EINVAL;
+		}
+	} else if (dwmac->phy_intf_sel == ETHER_CONFIG_INTF_RMII) {
+		switch (speed) {
+		case SPEED_100:
+			clk_sel_val = ETHER_CLK_SEL_DIV_SEL_2;
+			break;
+
+		case SPEED_10:
 			clk_sel_val = ETHER_CLK_SEL_DIV_SEL_20;
-		break;
-	default:
-		/* No bit control */
-		netdev_err(netdev, "Unsupported speed request (%d)", speed);
-		return -EINVAL;
+			break;
+
+		default:
+			return -EINVAL;
+		}
 	}
 
 	/* Stop internal clock */
-- 
2.30.2


