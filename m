Return-Path: <netdev+bounces-232938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A14ACC09FD8
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 22:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 270881AA1997
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 20:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186DA2F83CF;
	Sat, 25 Oct 2025 20:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DrHfgI7i"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C9E2236E0
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 20:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761425345; cv=none; b=VpOWCJ4MJIi37EIuL5LUoMI/agRgxktaoR6PUH00a+NpLmx+djkrhF4TgsQYGhngBepyNEnt6NqLNCC3O6i/qle+F8B3JBFQ8zmZt1sw315t8xaLrG1g5VCS1uAiD+M7JOrdfKUllDdzt2aReJN0IgfRWtb0y+E6h8/v2E+2M4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761425345; c=relaxed/simple;
	bh=XJ6+tuJ3N/r1xl3DHl2X1hO2gGU/tJ6flQmBncYKEag=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=JPq+o5K9jANonfr070JV7dh0TQrSnsNBHmELdhlbtWmKue3+D/0aeCfLfOltmbN4F00IloKGATIhM8sWBP2XlH66ANWehVR8jhtzv12tKu+uSxRDwukwE6i2Big2GcZ8cZR3W9GhbbZL8WLaEYzmcWA2SU+jav6FWLN7jPxtX6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DrHfgI7i; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MNOZmw3HtaFRWdz6EHC2zGJXiMWEH1txyyxtpZBUbwg=; b=DrHfgI7iFyFCBXadB9ayVD+w8O
	Ku2BQXwwaKJU44bL1yHL3lRcOFkd74UuUPYiHGDndhg41VUAPFimnBwMSSrwm1TaqkVY1ctn+GiSH
	pfwjoyWVd/EhYiZcDErmc1+9vpXy3KEuDyu8Dfw802Eb+87ZwnWdeJauUOUwbaauiM8zz37imOKcT
	lAsly1fNFCB0/XTwABTNh6DPdIasnm9boNYdL+B7ugING3Z1hWW8IIGlKZQx8wVMuSRAOuq8Qa1Be
	TamWi88Es3gwCI1Y5rGHIfzqZ4MjDvr8De1Z7lDE8tFuFPHVT87n0/ea1MjdKh5gOjK+OGx1LhTdC
	b815BCsg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41846 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vClC1-000000000Pv-0BZ2;
	Sat, 25 Oct 2025 21:48:53 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vClC0-0000000BcbV-0zYp;
	Sat, 25 Oct 2025 21:48:52 +0100
In-Reply-To: <aP03aQLADMg-J_4W@shell.armlinux.org.uk>
References: <aP03aQLADMg-J_4W@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"Alexis Lothor__" <alexis.lothore@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Furong Xu <0x1207@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: [PATCH net-next 2/3] net: stmmac: report PCS configuration changes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vClC0-0000000BcbV-0zYp@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sat, 25 Oct 2025 21:48:52 +0100

Report if/when qcom-ethqos changes the PCS configuration. With phylink
now setting the PCS configuration, there should be no need for drivers
to change this.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
index cda93894168e..e42a98162c2b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
@@ -109,6 +109,7 @@ static inline void dwmac_ctrl_ane(void __iomem *ioaddr, u32 reg, bool ane,
 				  bool srgmi_ral)
 {
 	u32 value = readl(ioaddr + GMAC_AN_CTRL(reg));
+	u32 old = value;
 
 	/* Enable and restart the Auto-Negotiation */
 	if (ane)
@@ -122,6 +123,10 @@ static inline void dwmac_ctrl_ane(void __iomem *ioaddr, u32 reg, bool ane,
 	if (srgmi_ral)
 		value |= GMAC_AN_CTRL_SGMRAL;
 
+	if (old != value)
+		pr_warn("dwmac: PCS configuration changed from phylink by glue, please report: 0x%08x -> 0x%08x\n",
+			old, value);
+
 	writel(value, ioaddr + GMAC_AN_CTRL(reg));
 }
 #endif /* __STMMAC_PCS_H__ */
-- 
2.47.3


