Return-Path: <netdev+bounces-130944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C918A98C237
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DDE12812B4
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 16:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9321CB537;
	Tue,  1 Oct 2024 16:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="EgH33QkH"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266BF1CB511
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727798687; cv=none; b=pMFKXiaZ0g4kDeXMeWJDfepgYsT84gUfhyAD6u6vMZkLJsKoNo4lamD3ujWK3+tAIABbmQ5djlQy45ndkl+AMoB478sEI1DJCfbx6cWYPyAfVBc3l5qfxerPXlEnM6GYdS9UoVQ+Y5o4RIb0zWonVcyKavcf+6HzT4N+ZROAhmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727798687; c=relaxed/simple;
	bh=fmp6WfoAQd6GwGJXzvkEWv5KgLVufywlKFHJi5t7lPg=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=I/Qz840OgEGk3fpkoO21EnQE7+89NqPYPHAn3S3E98q1M6MOJuvqMic0rduPSDRrZkKmrpxYz7oYtud+xzQhKsN5NS78wUlu1DRf3fF7iiruwVKVCY3K/CxDsuE3gnjiw7olj1nTG/tN5LSnHgasYKiOtV8KNU9LzCKbhTDtfG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=EgH33QkH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kxwhMe4NsG80DGdXhpv3SmTACDemHuSUJShVS/ADG7A=; b=EgH33QkHuhpC91678DmoZAYLCu
	A0ZAZ9dY4B2sLxq/FXdw0/+vb66d7FzSqWR63WDgKsYCMXzIF6NG4VbpIfUNiR6MwFzFmiO3snvY3
	m/odOaprkEevli1nSmjKSL1sqBTfMDBx3Qaiaq0OVsmYaWh9D4gmgI7e8+VlE5M4EQEWyxW+8C/gm
	fgvBLJ/A5G0IZAlFRPvLFgqiHB7pDRrFiX4nw/tVrSm7hFP3DhU4tuzIcAbbbyiiKFylhC6IbLksq
	sJYmcDSEjg2LXpA7L50jrKIAQQfjq5r7o78oRtcZAFXy4i57eNCn74DIsUqB1M6orOVlmqgE9oDYv
	WGK2F8hA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54716 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1svfMX-00066B-1H;
	Tue, 01 Oct 2024 17:04:32 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1svfMV-005ZIR-FE; Tue, 01 Oct 2024 17:04:31 +0100
In-Reply-To: <ZvwdKIp3oYSenGdH@shell.armlinux.org.uk>
References: <ZvwdKIp3oYSenGdH@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 05/10] net: wangxun: txgbe: use phylink_pcs
 internally
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1svfMV-005ZIR-FE@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 01 Oct 2024 17:04:31 +0100

Use xpcs_create_pcs_mdiodev() to create the XPCS instance, storing
and using the phylink_pcs pointer internally, rather than dw_xpcs.
Use xpcs_destroy_pcs() to destroy the XPCS instance when we've
finished with it.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 18 +++++++++---------
 .../net/ethernet/wangxun/txgbe/txgbe_type.h    |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index 67b61afdde96..3dd89dafe7c7 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -122,7 +122,7 @@ static int txgbe_pcs_write(struct mii_bus *bus, int addr, int devnum, int regnum
 static int txgbe_mdio_pcs_init(struct txgbe *txgbe)
 {
 	struct mii_bus *mii_bus;
-	struct dw_xpcs *xpcs;
+	struct phylink_pcs *pcs;
 	struct pci_dev *pdev;
 	struct wx *wx;
 	int ret = 0;
@@ -147,11 +147,11 @@ static int txgbe_mdio_pcs_init(struct txgbe *txgbe)
 	if (ret)
 		return ret;
 
-	xpcs = xpcs_create_mdiodev(mii_bus, 0, PHY_INTERFACE_MODE_10GBASER);
-	if (IS_ERR(xpcs))
-		return PTR_ERR(xpcs);
+	pcs = xpcs_create_pcs_mdiodev(mii_bus, 0);
+	if (IS_ERR(pcs))
+		return PTR_ERR(pcs);
 
-	txgbe->xpcs = xpcs;
+	txgbe->pcs = pcs;
 
 	return 0;
 }
@@ -163,7 +163,7 @@ static struct phylink_pcs *txgbe_phylink_mac_select(struct phylink_config *confi
 	struct txgbe *txgbe = wx->priv;
 
 	if (interface == PHY_INTERFACE_MODE_10GBASER)
-		return &txgbe->xpcs->pcs;
+		return txgbe->pcs;
 
 	return NULL;
 }
@@ -302,7 +302,7 @@ irqreturn_t txgbe_link_irq_handler(int irq, void *data)
 	status = rd32(wx, TXGBE_CFG_PORT_ST);
 	up = !!(status & TXGBE_CFG_PORT_ST_LINK_UP);
 
-	phylink_pcs_change(&txgbe->xpcs->pcs, up);
+	phylink_pcs_change(txgbe->pcs, up);
 
 	return IRQ_HANDLED;
 }
@@ -778,7 +778,7 @@ int txgbe_init_phy(struct txgbe *txgbe)
 err_destroy_phylink:
 	phylink_destroy(wx->phylink);
 err_destroy_xpcs:
-	xpcs_destroy(txgbe->xpcs);
+	xpcs_destroy_pcs(txgbe->pcs);
 err_unregister_swnode:
 	software_node_unregister_node_group(txgbe->nodes.group);
 
@@ -798,6 +798,6 @@ void txgbe_remove_phy(struct txgbe *txgbe)
 	clkdev_drop(txgbe->clock);
 	clk_unregister(txgbe->clk);
 	phylink_destroy(txgbe->wx->phylink);
-	xpcs_destroy(txgbe->xpcs);
+	xpcs_destroy_pcs(txgbe->pcs);
 	software_node_unregister_node_group(txgbe->nodes.group);
 }
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 959102c4c379..cc3a7b62fe9e 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -329,7 +329,7 @@ struct txgbe {
 	struct wx *wx;
 	struct txgbe_nodes nodes;
 	struct txgbe_irq misc;
-	struct dw_xpcs *xpcs;
+	struct phylink_pcs *pcs;
 	struct platform_device *sfp_dev;
 	struct platform_device *i2c_dev;
 	struct clk_lookup *clock;
-- 
2.30.2


