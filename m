Return-Path: <netdev+bounces-95814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B708C378B
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 18:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6825228124D
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 16:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730E34A99C;
	Sun, 12 May 2024 16:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CjbM3iYz"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB49C17C95
	for <netdev@vger.kernel.org>; Sun, 12 May 2024 16:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715531377; cv=none; b=amtFbQPbTndoa3QujjIFuVXywK+ZXv8RD6Wr8zb5aDj3SSgeSfWpeS2TbHNizEr3Jg+iNVBUEhDesb0mo6M7yWjFi8MWbavCCd9xX4WGaUd4/nhbO5wiYWVJi5SWo5t3QyiJio9Q4jtKp7ZhnaVS1ghtKojsNxHfeSjAGaewEQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715531377; c=relaxed/simple;
	bh=eqVeXq/r9uO36O9cofOeEjKg7wD8KsZRswAaZjzVoUg=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=qeAXfuWhK0eZ8M88IsR5quujAJbLZg2/q7j3G0xhClwqEmd3vaKJcbpwjtu5Kya1JdmTRHSbBx/ffiCMgSb5ZwIClB7QDVQuJUNvhY3NB8M9pXHIv0g2tQyglUr4d4cYNGz8Ozrrm9Rdcresbt/uriuFV42bThvVSFQzDdLjHCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=CjbM3iYz; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JXJApZIqGDSjIC4jAhYXtd0NI6qqcuRNs9Dj/v6o4gA=; b=CjbM3iYzpc1mDoQIqzn9GeKrdo
	kR3C6FSclbeXg0QoU5Hv1buTLl7bJ3+8yBpuOkv3oJlwyw9B5+/gF9HnQkTk5/ObP7/VITmlvE7Lk
	HhRxiUKO+BNYaRMVQ2QNu8lzIy6n8Wbi3l6igbBYMrIwFmi7CLFN7LsuUGfO0FiV2aGlc2eFhUFZ6
	LgEele/0cfEvNo/iHsSDnWxa45DlHEB+q7bwbvj9Zxa+ul2oFPN094rR3e+LBU5whpqipL3ZmmO87
	z6O3bzdpXVC1Pe9J4idw3qblLUKsVwEOIyA2hAbM+wC8yGL/Qzj07qbFMfa5LYRjthxuSg1LgpGR3
	L3LLTIhg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41678 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1s6C4h-0000uI-0b;
	Sun, 12 May 2024 17:29:23 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1s6C4i-00Ck6n-Oe; Sun, 12 May 2024 17:29:24 +0100
In-Reply-To: <ZkDuJAx7atDXjf5m@shell.armlinux.org.uk>
References: <ZkDuJAx7atDXjf5m@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH RFC net-next 6/6] net: stmmac: remove old pcs interrupt
 functions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1s6C4i-00Ck6n-Oe@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sun, 12 May 2024 17:29:24 +0100

Remove the old pcs interrupt functions which are no longer required and
the now unused pcs_speed, pcs_duplex and pcs_link members of
struct stmmac_extra_stats.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/common.h  |  3 --
 .../ethernet/stmicro/stmmac/dwmac1000_core.c  | 35 +------------------
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c | 35 +------------------
 3 files changed, 2 insertions(+), 71 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 82d0d897019c..1fac8d31121a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -191,9 +191,6 @@ struct stmmac_extra_stats {
 	unsigned long irq_pcs_ane_n;
 	unsigned long irq_pcs_link_n;
 	unsigned long irq_rgmii_n;
-	unsigned long pcs_link;
-	unsigned long pcs_duplex;
-	unsigned long pcs_speed;
 	/* debug register */
 	unsigned long mtl_tx_status_fifo_full;
 	unsigned long mtl_tx_fifo_not_empty;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index 05143fa7aa6c..adb872d5719f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -262,39 +262,6 @@ static void dwmac1000_pmt(struct mac_device_info *hw, unsigned long mode)
 	writel(pmt, ioaddr + GMAC_PMT);
 }
 
-/* RGMII or SMII interface */
-static void dwmac1000_rgsmii(void __iomem *ioaddr, struct stmmac_extra_stats *x)
-{
-	u32 status;
-
-	status = readl(ioaddr + GMAC_RGSMIIIS);
-	x->irq_rgmii_n++;
-
-	/* Check the link status */
-	if (status & GMAC_RGSMIIIS_LNKSTS) {
-		int speed_value;
-
-		x->pcs_link = 1;
-
-		speed_value = ((status & GMAC_RGSMIIIS_SPEED) >>
-			       GMAC_RGSMIIIS_SPEED_SHIFT);
-		if (speed_value == GMAC_RGSMIIIS_SPEED_125)
-			x->pcs_speed = SPEED_1000;
-		else if (speed_value == GMAC_RGSMIIIS_SPEED_25)
-			x->pcs_speed = SPEED_100;
-		else
-			x->pcs_speed = SPEED_10;
-
-		x->pcs_duplex = (status & GMAC_RGSMIIIS_LNKMOD_MASK);
-
-		pr_info("Link is Up - %d/%s\n", (int)x->pcs_speed,
-			x->pcs_duplex ? "Full" : "Half");
-	} else {
-		x->pcs_link = 0;
-		pr_info("Link is Down\n");
-	}
-}
-
 static int dwmac1000_irq_status(struct mac_device_info *hw,
 				struct stmmac_extra_stats *x)
 {
@@ -338,7 +305,7 @@ static int dwmac1000_irq_status(struct mac_device_info *hw,
 
 	if (intr_status & PCS_RGSMIIIS_IRQ) {
 		phylink_pcs_change(&hw->mac_pcs, false);
-		dwmac1000_rgsmii(ioaddr, x);
+		x->irq_rgmii_n++;
 	}
 
 	return ret;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index e70cca85548a..a892d361a4e4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -753,39 +753,6 @@ static void dwmac4_flow_ctrl(struct mac_device_info *hw, unsigned int duplex,
 	}
 }
 
-/* RGMII or SMII interface */
-static void dwmac4_phystatus(void __iomem *ioaddr, struct stmmac_extra_stats *x)
-{
-	u32 status;
-
-	status = readl(ioaddr + GMAC_PHYIF_CONTROL_STATUS);
-	x->irq_rgmii_n++;
-
-	/* Check the link status */
-	if (status & GMAC_PHYIF_CTRLSTATUS_LNKSTS) {
-		int speed_value;
-
-		x->pcs_link = 1;
-
-		speed_value = ((status & GMAC_PHYIF_CTRLSTATUS_SPEED) >>
-			       GMAC_PHYIF_CTRLSTATUS_SPEED_SHIFT);
-		if (speed_value == GMAC_PHYIF_CTRLSTATUS_SPEED_125)
-			x->pcs_speed = SPEED_1000;
-		else if (speed_value == GMAC_PHYIF_CTRLSTATUS_SPEED_25)
-			x->pcs_speed = SPEED_100;
-		else
-			x->pcs_speed = SPEED_10;
-
-		x->pcs_duplex = (status & GMAC_PHYIF_CTRLSTATUS_LNKMOD_MASK);
-
-		pr_info("Link is Up - %d/%s\n", (int)x->pcs_speed,
-			x->pcs_duplex ? "Full" : "Half");
-	} else {
-		x->pcs_link = 0;
-		pr_info("Link is Down\n");
-	}
-}
-
 static int dwmac4_mii_pcs_validate(struct phylink_pcs *pcs,
 				   unsigned long *supported,
 				   const struct phylink_link_state *state)
@@ -930,7 +897,7 @@ static int dwmac4_irq_status(struct mac_device_info *hw,
 	dwmac_pcs_isr(ioaddr, GMAC_PCS_BASE, intr_status, x);
 	if (intr_status & PCS_RGSMIIIS_IRQ) {
 		phylink_pcs_change(&hw->mac_pcs, false);
-		dwmac4_phystatus(ioaddr, x);
+		x->irq_rgmii_n++;
 	}
 
 	return ret;
-- 
2.30.2


