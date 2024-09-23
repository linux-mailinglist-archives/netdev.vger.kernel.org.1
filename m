Return-Path: <netdev+bounces-129312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C7397ECBD
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 16:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F273B22564
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 14:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86356198A05;
	Mon, 23 Sep 2024 14:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dVNTWeAM"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC6219CC15
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 14:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727100100; cv=none; b=QRnyFHjSFCXuODc7Rfvi5kinlBf9wWiT96OJJMqwixMiUmhjCevpIkpauTvaP+IqoNm6ihxIEfaOabbkG+gtu2HovF/mktatxF/2G63z6Z7gG87z6n8v1FNdrMH9hDU3YIdIF2ukpE2qIqjouDBWhEUStbeNx3VpnEXcmVGLprY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727100100; c=relaxed/simple;
	bh=fmp6WfoAQd6GwGJXzvkEWv5KgLVufywlKFHJi5t7lPg=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=I5u8P2U4UWABcyJCYooUybclWxENpJRLfg6tLahigyoRMVk4UA5zy/Lm1+otHPgbEcmgVs+vCQ7sIX9ryGrpXq77KnGCCKRQFAmN6Nna1xbODVQiKDUqxdly1VjSsvJolA/v2Sgkfs9gmYrkujDcgibKzDqhSEdMooy8BzZ4NMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=dVNTWeAM; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kxwhMe4NsG80DGdXhpv3SmTACDemHuSUJShVS/ADG7A=; b=dVNTWeAMsY5SaK4KDbJOTSbWrt
	tIv2nKkLn7KicJaqPN0jIhxr4PLuO1a98qp1u035rUCjLVNYBBGvv9al1Zk0yC3RwauNdyhhueOki
	o+ti0CGgTX4JdAq2QkFckG5rrjBqzFck984OPtsKwg5aCqcyjIUxvYjmnueG3/ABYei8bfc4gbXqO
	HNZWSsgEMR2KpllT0dAsHwwRc5CvYu3IOUyuSPZX4JsJCQ74rSnj9Ikd8NefFmxF/EbeTmp8IqlT8
	vFNjKs3Zl7t8zqXc6BE7b5P4AKwJ0/7FdEZeozcmEDKTPqSuhgP+DFDz1iNGIXd+xsz6mlpvEty/Q
	0HjjZagg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:46898 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1ssjcw-0004IB-0c;
	Mon, 23 Sep 2024 15:01:21 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1ssjcu-005Ns3-98; Mon, 23 Sep 2024 15:01:20 +0100
In-Reply-To: <ZvF0er+vyciwy3Nx@shell.armlinux.org.uk>
References: <ZvF0er+vyciwy3Nx@shell.armlinux.org.uk>
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
Subject: [PATCH RFC net-next 05/10] net: wangxun: txgbe: use phylink_pcs
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
Message-Id: <E1ssjcu-005Ns3-98@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 23 Sep 2024 15:01:20 +0100

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


