Return-Path: <netdev+bounces-212020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17490B1D46E
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 10:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9AFB626EFF
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 08:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3121F8751;
	Thu,  7 Aug 2025 08:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gxgJ0PBl"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F64E155333
	for <netdev@vger.kernel.org>; Thu,  7 Aug 2025 08:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754556570; cv=none; b=h/kgjsMSW1kTDU2YqqJ4p+Tf25ywCOqdIZuKYYnrgkXRD3nowpCdxnspmrvK/dBrzcDldCLV6ii9Nkv5QG+iuX6R0GvrA8cWOQRd74tLOUzN7XOG+haeGzc8BiVjtwR0+wEDI/A1nhuLde5KD2KmrNCSTAst3BJJU5fnrIoxpiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754556570; c=relaxed/simple;
	bh=rEGynqCm6kJZfZcjUgMFu4dwJ2+yBIMtJYflVj7eQP4=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=YZY9UbZngGy5OXF9VvJODbtD6jZAOOI7/kDZJ8xCCqYZeuQXFEXjBJSyNjKQX9MOnB7dpq+pi5+QjNqRghr5EDVWmLSyHZRWph0yIW72Y51pRmFtCzOXG8SF8Xkd05RjWkzwUMrNEA3l7DArR9a4mC+C3j8Yum70fQtze1B5n0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=gxgJ0PBl; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yZsO/hEei+5L5Y+22LpoO6v7DoCgNeecYJmxyXCryiU=; b=gxgJ0PBlkRYoBwzq7HESSC5t0P
	8hK1G1SuXO/Bjya1bRhG3ZiOeeOgaRAgGVrl00t/vF2Zdo0V7ooG4msE13G89x2lLWjeZ1pg6QCOD
	lSEo6hGp+dRJPdx8cwYYx7vlgWRtoVIQVq4JOnY+2wpp+2hn3ax8XOHKEZeMOcLTJzOVn9km+e6zf
	flbC2/VmXBd2iph2EptG08xJ10A6u0Ic1rrrxd2ieInK9eo30d6TwAaYv5CoTsc2d5+YMo7A8ei9J
	/fLUjgLiXTQWIf8FJc6wguGJMieIXwno6QULcfSxRQuTtnuIMBz9CwsoJx6+yrwgSJlpN8ESjaQ+Q
	moA5ZVvw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44352 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1ujwJG-0005oy-2T;
	Thu, 07 Aug 2025 09:49:14 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1ujwIY-007qKa-Ka; Thu, 07 Aug 2025 09:48:30 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	David Wu <david.wu@rock-chips.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	David Wu <david.wu@rock-chips.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] net: stmmac: rk: put the PHY clock on remove
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ujwIY-007qKa-Ka@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 07 Aug 2025 09:48:30 +0100

The PHY clock (bsp_priv->clk_phy) is obtained using of_clk_get(), which
doesn't take part in the devm release. Therefore, when a device is
unbound, this clock needs to be explicitly put. Fix this.

Fixes: fecd4d7eef8b ("net: stmmac: dwmac-rk: Add integrated PHY support")
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Spotted this resource leak while making other changes to dwmac-rk.
Would be great if the dwmac-rk maintainers can test it.

 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 79b92130a03f..4a315c87c4d0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1770,6 +1770,9 @@ static void rk_gmac_remove(struct platform_device *pdev)
 	stmmac_dvr_remove(&pdev->dev);
 
 	rk_gmac_powerdown(bsp_priv);
+
+	if (plat->phy_node && bsp_priv->integrated_phy)
+		clk_put(bsp_priv->clk_phy);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.30.2


