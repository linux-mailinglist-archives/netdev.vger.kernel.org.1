Return-Path: <netdev+bounces-221317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 126D8B501F1
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 17:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C890A4E281A
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 15:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949EE2BE657;
	Tue,  9 Sep 2025 15:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="G1YABSDu"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3DE2797B5
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 15:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757433265; cv=none; b=T1eTzy78GJRYVh9gGzTZ9cTfd0IIqGk2B2+Iut+4Hzyre97D/WKuX24O1X1iUaoCuzuEIowaN44oUpIHdPyE7VrEk2sUj2ibvgGx3Pk3WS7GA3Pk8QDO+eWTQcnYacXlDN0fZgNWGGX45XK7GLAZDoAGSh5oQiQ2wJfYd7U1g6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757433265; c=relaxed/simple;
	bh=h2l9qGEEpHC9CO91It801g5/33lmIey0vJNW8GgjVZ8=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=cLDzCmhY1lAEFjNtG8AxABzC89L6IsxVYww5tLBDTHJO5CdYmBHdcCuJx1WvxSt4MHiqdNjiUf7E+3CvQyt/WnSuTrjDBpOMKo+4UXZaT6bR5FOS6JDUkL80Qr7CWUYzswDcrO2KDylFFBjy8l/oAi5+lnCcVKufYJoCw80zY78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=G1YABSDu; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=W2tyPj55H9MQ8kwggHT+s8YzFXmBWHiBW64cPrku9as=; b=G1YABSDuRV/hzOrgl2arLN8vUY
	r/j8C9Vh55rJVM9plobhjWAe+hL/C74Ha5yQbRPag7NZUsz5HLMv7mqor9nYC9gQoRpN83L4mJFeb
	AaxqBZtvMPrRQw0UtUgFAAmDgsPLvkSIYBGSRal2XinrY5lPv2HQrublh9VIBTyWILMbQ/Nc3TbX8
	APLnuHnsC77/bRqBRcA9+18JYxEqbC7CFT82CvV+67RE+YSJ+bSH70YbrIhVR6UNfu9xFPPjWi1Xe
	oq68lDlRItDqM+jyusCWh+07Pomt17m83WZ/O1dxoDFYq9NJjazMOsnAOg3m+r4MZNjcqC8n/ANq+
	RjkdUCdA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:49956 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uw0fg-000000008QV-2BSv;
	Tue, 09 Sep 2025 16:54:16 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uw0ff-00000004IQJ-3AMp;
	Tue, 09 Sep 2025 16:54:15 +0100
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
Subject: [PATCH net-next] net: stmmac: dwc-qos: use PHY WoL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uw0ff-00000004IQJ-3AMp@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 09 Sep 2025 16:54:15 +0100

Mark Tegra platforms to use PHY's wake-on-Lan capabilities rather than
the stmmac wake-on-Lan.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
This is the last patch that is needed to WoL on the Jetson Xavier NX
to be functional - the only patch that hasn't been through netdev
is the DT patch that's being merged through a different route. Once
all patches come together (in other words, at the next -rc1), then
WoL will be functional on this platform.

 drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
index 6c363f9b0ce2..e8539cad4602 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
@@ -261,7 +261,8 @@ static int tegra_eqos_probe(struct platform_device *pdev,
 	plat_dat->set_clk_tx_rate = stmmac_set_clk_tx_rate;
 	plat_dat->bsp_priv = eqos;
 	plat_dat->flags |= STMMAC_FLAG_SPH_DISABLE |
-			   STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP;
+			   STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP |
+			   STMMAC_FLAG_USE_PHY_WOL;
 
 	return 0;
 
-- 
2.47.3


