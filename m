Return-Path: <netdev+bounces-183207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E117A8B676
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D745A5A004F
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 10:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B3F2356C3;
	Wed, 16 Apr 2025 10:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ev55wIti"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F675236430
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 10:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744798226; cv=none; b=h9JZrGgVcOO5MjYWZbb1jerzXR/gsh/rigSCpZ8kJbalSJotLd56s1NwMSh5JuIK/GYKSSwmwZJIpAHqdqM5l/qPOq3H7U699r2sq6gGQM5KNf12p9/LXMFaFN5iGP3mxNtYHgyPtL+fYWCdwP2sTwh2zqBAOinmQ8NPJ+hfssk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744798226; c=relaxed/simple;
	bh=UcUGcOK+S4LsFTHnlbRzxrJbrmT2OLrU0stB78O8tp0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=e5hau6cIpEuaHAz4ggFPe3S6KVUV5tbyYFo69LifCGk7q6X5rdp5q2eiyxqI1nWw8gkyoAxbARLRIEnRCSEAd9jE6CMja3wVHMxJ2VFiyex0Yv0qcepVYucIZTIFTCAG+BKCDdH7UBsxG+frj6zjh+1Yx3OcXnMEvKAiF8DPoyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ev55wIti; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qiJY99ai7mGDr2FC9ZGU82aOrwFyMKWX9y0r6QczlqM=; b=ev55wIti9sjkf3oCexLnb5YgA9
	R5WFBviTDjeT1r6A31bJxkwq2J1FXwdT8bKtrzAfM4VxqH5iklJwHzIr9gDt72WD8RECSkQYy1dwb
	OnHHcSXJ6qjXAOjIYix1PyTsgxLw0eXKiKRtSyDy/jPcIcKFtEFPHJqqeAFpsc3EyULQxhek18hIK
	Nr8Yijxe1F+TxA3GO5kOFBNH3SKhpelPQPQmCs4RFzPdhzgbt8GJRIVrZYfEV6cvg9Yh0+ZqhHCjk
	tpz6i4XvzAoJOT/VrmWWJ5SpFFiTq+MSfw5RGcFaONxXrsgCMIANsSve0Os43g0YmH68rbZSHtTQx
	8pwGmbfw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:33274 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u4zic-00011J-2A;
	Wed, 16 Apr 2025 11:10:10 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u4zi1-000xHh-57; Wed, 16 Apr 2025 11:09:33 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH net-next] net: stmmac: dwc-qos: use PHY clock-stop capability
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u4zi1-000xHh-57@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 16 Apr 2025 11:09:33 +0100

Use the PHY clock-stop capability when programming the MAC LPI mode,
which allows the transmit clock to the PHY to be gated. Tested on the
Jetson Xavier NX platform.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
index 583b5c071cd1..fa900b4991d0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
@@ -252,7 +252,8 @@ static int tegra_eqos_probe(struct platform_device *pdev,
 	plat_dat->fix_mac_speed = tegra_eqos_fix_speed;
 	plat_dat->set_clk_tx_rate = stmmac_set_clk_tx_rate;
 	plat_dat->bsp_priv = eqos;
-	plat_dat->flags |= STMMAC_FLAG_SPH_DISABLE;
+	plat_dat->flags |= STMMAC_FLAG_SPH_DISABLE |
+			   STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP;
 
 	return 0;
 
-- 
2.30.2


