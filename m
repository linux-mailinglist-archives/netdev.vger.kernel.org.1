Return-Path: <netdev+bounces-99722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B05CB8D60AD
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 13:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06AF1C23D2C
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 11:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453F4156654;
	Fri, 31 May 2024 11:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mdiCJmxl"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B004D157470
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 11:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717154816; cv=none; b=f0dM+P3ik625GtGBzqc8upAkYthT/JebMNaALjOTxCG0rzdIENcHSi2zdEv0IN4r0UMmxI6Of/WlEas1UCBJrChfMZbcJQdFa5spAv4OUac+K4OK67x8nyp3SCDKQQZawAuqe6/k2lJ8Yv4xYLylW+8RX/SGJdQNhdjZka+HM6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717154816; c=relaxed/simple;
	bh=8m0fIfXK4dPQUpzZu5dp7KplyKq7P5AZBWKPdSQVZK8=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=WJwgZNZFsisdnXx57HEsT+Ke7nBlOuMIvZvbOPztncNGLdj9AJPMmTDmP2ENAElb04R9xsje1EeeA8xZcL6aezWHriW9FDPBZXlrcPIP/bO1H7p58qRJ5CAWtfNjxTMuRRjaGtgirHTXYxQ7HgZqKdIrsIu2uDLaqkFVhp08poM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mdiCJmxl; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nYV0iwaM4CrzqivMDUO7NpiYXQHAZmA2iACOt/v5Uqw=; b=mdiCJmxl5lFpKc42IfdPL7sG0Y
	yhaC0eybZDMUUz1JsIXzDRzvGNXhnX3j3BvEWhMqokJ1EsNURsoHOWml8TWUvmRgceh5DWkWctS4r
	CRxeeKrYZwaecnmmBs7Zn3otZIn21hXgeB5Esn3/KTODsfVfUQasQX+2sGn4oJN0wE8uVXiOqLYGA
	Fr1bSIx5dAvOO7YDjxWhP4YrGVdKeoWJWk9BHnllwbzWzumtrmQP49xgoSRMRXjCD58Re2hyxxOrI
	mbcHZ1cbGQk1Hk8KLzAAIsp/+i/nUS4cYH3S5q2+ahY6JeGGwih+BWekAN8GGgbixFkFJc6eB3xqL
	wSsQB7xA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:34888 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sD0P8-0008SZ-2T;
	Fri, 31 May 2024 12:26:38 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sD0PA-00EzCC-Qb; Fri, 31 May 2024 12:26:40 +0100
In-Reply-To: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
References: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Halaney <ahalaney@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH RFC net-next v2 6/8] net: stmmac: dwmac4: move PCS interrupt
 control
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sD0PA-00EzCC-Qb@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 31 May 2024 12:26:40 +0100

Control the PCS interrupt mask from the phylink pcs_enable() and
pcs_disable() methods rather than relying on driver variables.

This assumes that GMAC_INT_RGSMIIS, GMAC_INT_PCS_LINK and
GMAC_INT_PCS_ANE are all relevant to the PCS.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c | 29 +++++++++++++++++--
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index cb99cb69c52b..5cf2a6cb8f66 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -56,9 +56,6 @@ static void dwmac4_core_init(struct mac_device_info *hw,
 	/* Enable GMAC interrupts */
 	value = GMAC_INT_DEFAULT_ENABLE;
 
-	if (hw->pcs)
-		value |= GMAC_PCS_IRQ_DEFAULT;
-
 	/* Enable FPE interrupt */
 	if ((GMAC_HW_FEAT_FPESEL & readl(ioaddr + GMAC_HW_FEATURE3)) >> 26)
 		value |= GMAC_INT_FPE_EN;
@@ -770,6 +767,30 @@ static int dwmac4_mii_pcs_validate(struct phylink_pcs *pcs,
 	return 0;
 }
 
+static int dwmac4_mii_pcs_enable(struct phylink_pcs *pcs)
+{
+	struct mac_device_info *hw = phylink_pcs_to_mac_dev_info(pcs);
+	void __iomem *ioaddr = hw->pcsr;
+	u32 intr_enable;
+
+	intr_enable = readl(ioaddr + GMAC_INT_EN);
+	intr_enable |= GMAC_PCS_IRQ_DEFAULT;
+	writel(intr_enable, ioaddr + GMAC_INT_EN);
+
+	return 0;
+}
+
+static void dwmac4_mii_pcs_disable(struct phylink_pcs *pcs)
+{
+	struct mac_device_info *hw = phylink_pcs_to_mac_dev_info(pcs);
+	void __iomem *ioaddr = hw->pcsr;
+	u32 intr_enable;
+
+	intr_enable = readl(ioaddr + GMAC_INT_EN);
+	intr_enable &= ~GMAC_PCS_IRQ_DEFAULT;
+	writel(intr_enable, ioaddr + GMAC_INT_EN);
+}
+
 static int dwmac4_mii_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 				 phy_interface_t interface,
 				 const unsigned long *advertising,
@@ -817,6 +838,8 @@ static void dwmac4_mii_pcs_get_state(struct phylink_pcs *pcs,
 
 static const struct phylink_pcs_ops dwmac4_mii_pcs_ops = {
 	.pcs_validate = dwmac4_mii_pcs_validate,
+	.pcs_enable = dwmac4_mii_pcs_enable,
+	.pcs_disable = dwmac4_mii_pcs_disable,
 	.pcs_config = dwmac4_mii_pcs_config,
 	.pcs_get_state = dwmac4_mii_pcs_get_state,
 };
-- 
2.30.2


