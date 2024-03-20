Return-Path: <netdev+bounces-80826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE21288133E
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 15:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23A57B2468C
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 14:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC2C3D54C;
	Wed, 20 Mar 2024 14:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="eovJXPpN"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6652E3E5
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 14:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710944577; cv=none; b=RtqHMLdSIg2/yP7O8XLpGAn0DMjclea0cBS+poY3Rl65zW1mrfOXXVMSs5vYD0YQ4Mm4u0MIsIeTsd8CDeyzy/QX6Oj/h4pkOu6JEFVi7h3mLSGUjKPpeEOKOSGa0WVCUE4h1N8w1depdF5D+6Ad5MJDpCQvcotyt15qks4fdRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710944577; c=relaxed/simple;
	bh=4pHNFg6IZLf+QQ5BKPfsurCv7sztr9Yjdfgk6yDW0ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzWk8/xlpn6u/z5FqXMJLR2LiARH8vbbYXgUEk86XFOrXsnQQZYn/kjT2+jzw/drjnLienW6myDTCGi4AT3T9k/F5y0qzF7heJGDgwgPgJ+YOHFJxBDJF1DgADJvH+dolVTwe3CUa6t1aDcnsiw40er/di6OyV4H62BkZlpoZlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=eovJXPpN; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rwJ7Pp35gOtY8PmdXG3OQD+UoTpEvKDj8lAsWi01PaM=; b=eovJXPpNp+IVaAv3TANkNj/oUr
	xYZ+5Z+MoFTWN6GfShG5XxYtaLULfikvrKDjVeIx15FfGiDMgYIS17AOPzq9OObeEi/3vr/dVzs4n
	Zh4xxGYBrYGkM6UuxYpZnzPLDe2K6Or09PXSqdhxGd2B8lTvdrvTBN76/QnwbvDgwHQ3bxeUO1RSa
	mdGG2jQqpIgNQR9bWZo/WHOQdnE2Gnj8BCr15d/vqWE0MdvhjIBm3ocWUOzfxPtb8iyFRxKOWGKmm
	A7OQ/xxZ1gTBJMNo8IneqwYyJZuJia/XwCSyyO9GIvzSrVG09kUz7r72O3fRrfKWqAiud2DJLS5zc
	VNYgt3vg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58460)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rmwpx-0006bn-2s;
	Wed, 20 Mar 2024 14:22:38 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rmwpt-0002jx-Ex; Wed, 20 Mar 2024 14:22:33 +0000
Date: Wed, 20 Mar 2024 14:22:33 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Yanteng Si <siyanteng@loongson.cn>, andrew@lunn.ch,
	hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	Jose.Abreu@synopsys.com, chenhuacai@loongson.cn,
	guyinggang@loongson.cn, netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v8 09/11] net: stmmac: dwmac-loongson: Fix half
 duplex
Message-ID: <ZfrxKfZ9TBQXHh2g@shell.armlinux.org.uk>
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <3382be108772ce56fe3e9bb99c9c53b7e9cd6bad.1706601050.git.siyanteng@loongson.cn>
 <dp4fhkephitylrf6a3rygjeftqf4mwrlgcdasstrq2osans3zd@zyt6lc7nu2e3>
 <vostvybxawyhzmcnabnh7hsc7kk6vdxfdzqu4rkuqv6sdm7cuw@fd2y2o7di5am>
 <88c8f5a4-16c1-498b-9a2a-9ba04a9b0215@loongson.cn>
 <ZfF+IAWbe1rwx3Xs@shell.armlinux.org.uk>
 <cd8be3b1-fcfa-4836-9d28-ced735169615@loongson.cn>
 <em3r6w7ydvjxualqifjurtrrfpztpil564t5k5b4kxv4f6ddrd@4weteqhekyae>
 <Zfq8TNrt0KxW/IWh@shell.armlinux.org.uk>
 <ZfrblN+OxODjZzfx@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfrblN+OxODjZzfx@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Mar 20, 2024 at 12:50:28PM +0000, Russell King (Oracle) wrote:
> On Wed, Mar 20, 2024 at 10:37:00AM +0000, Russell King (Oracle) wrote:
> > I was thinking:
> > 
> > 	stmmac_mac_phylink_get_caps(priv);
> > 
> > 	if (priv->plat->mac_capabilities)
> > 		priv->phylink_config.mac_capabilities &=
> > 			priv->plat->mac_capabilities;
> > 
> > In other words, if a platform sets plat->mac_capabilities, then it is
> > providing the capabilities that it supports, and those need to reduce
> > the capabilities provided by the MAC.
> 
> To further expand on this given the additional discussion, here's a
> patch that amagamates the ideas so far - however, it doesn't
> implement everything.
> 
> I think an additional step would be to provide a function that does all
> the mac capability calculations, something like:

Here's the complete patch:

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index a6fefe675ef1..a1e144b99213 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -605,6 +605,7 @@ struct mac_device_info {
 	unsigned int pmt;
 	unsigned int ps;
 	unsigned int xlgmac;
+	u32 phylink_mac_capabilities;
 	unsigned int num_vlan;
 	u32 vlan_filter[32];
 	bool vlan_fail_q_en;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 6b6d0de09619..2e4da6ac5173 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -68,11 +68,6 @@ static void dwmac4_core_init(struct mac_device_info *hw,
 		init_waitqueue_head(&priv->tstamp_busy_wait);
 }
 
-static void dwmac4_phylink_get_caps(struct stmmac_priv *priv)
-{
-	priv->phylink_config.mac_capabilities |= MAC_2500FD;
-}
-
 static void dwmac4_rx_queue_enable(struct mac_device_info *hw,
 				   u8 mode, u32 queue)
 {
@@ -1165,7 +1160,6 @@ static void dwmac4_set_hw_vlan_mode(struct mac_device_info *hw)
 
 const struct stmmac_ops dwmac4_ops = {
 	.core_init = dwmac4_core_init,
-	.phylink_get_caps = dwmac4_phylink_get_caps,
 	.set_mac = stmmac_set_mac,
 	.rx_ipc = dwmac4_rx_ipc_enable,
 	.rx_queue_enable = dwmac4_rx_queue_enable,
@@ -1210,7 +1204,6 @@ const struct stmmac_ops dwmac4_ops = {
 
 const struct stmmac_ops dwmac410_ops = {
 	.core_init = dwmac4_core_init,
-	.phylink_get_caps = dwmac4_phylink_get_caps,
 	.set_mac = stmmac_dwmac4_set_mac,
 	.rx_ipc = dwmac4_rx_ipc_enable,
 	.rx_queue_enable = dwmac4_rx_queue_enable,
@@ -1259,7 +1252,6 @@ const struct stmmac_ops dwmac410_ops = {
 
 const struct stmmac_ops dwmac510_ops = {
 	.core_init = dwmac4_core_init,
-	.phylink_get_caps = dwmac4_phylink_get_caps,
 	.set_mac = stmmac_dwmac4_set_mac,
 	.rx_ipc = dwmac4_rx_ipc_enable,
 	.rx_queue_enable = dwmac4_rx_queue_enable,
@@ -1372,5 +1364,7 @@ int dwmac4_setup(struct stmmac_priv *priv)
 	mac->mii.clk_csr_mask = GENMASK(11, 8);
 	mac->num_vlan = dwmac4_get_num_vlan(priv->ioaddr);
 
+	mac->phylink_mac_capabilities |= MAC_2500FD;
+
 	return 0;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 1af2f89a0504..f3daa284012b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -47,14 +47,6 @@ static void dwxgmac2_core_init(struct mac_device_info *hw,
 	writel(XGMAC_INT_DEFAULT_EN, ioaddr + XGMAC_INT_EN);
 }
 
-static void xgmac_phylink_get_caps(struct stmmac_priv *priv)
-{
-	priv->phylink_config.mac_capabilities |= MAC_2500FD | MAC_5000FD |
-						 MAC_10000FD | MAC_25000FD |
-						 MAC_40000FD | MAC_50000FD |
-						 MAC_100000FD;
-}
-
 static void dwxgmac2_set_mac(void __iomem *ioaddr, bool enable)
 {
 	u32 tx = readl(ioaddr + XGMAC_TX_CONFIG);
@@ -1516,7 +1508,6 @@ static void dwxgmac3_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *
 
 const struct stmmac_ops dwxgmac210_ops = {
 	.core_init = dwxgmac2_core_init,
-	.phylink_get_caps = xgmac_phylink_get_caps,
 	.set_mac = dwxgmac2_set_mac,
 	.rx_ipc = dwxgmac2_rx_ipc,
 	.rx_queue_enable = dwxgmac2_rx_queue_enable,
@@ -1577,7 +1568,6 @@ static void dwxlgmac2_rx_queue_enable(struct mac_device_info *hw, u8 mode,
 
 const struct stmmac_ops dwxlgmac2_ops = {
 	.core_init = dwxgmac2_core_init,
-	.phylink_get_caps = xgmac_phylink_get_caps,
 	.set_mac = dwxgmac2_set_mac,
 	.rx_ipc = dwxgmac2_rx_ipc,
 	.rx_queue_enable = dwxlgmac2_rx_queue_enable,
@@ -1656,6 +1646,11 @@ int dwxgmac2_setup(struct stmmac_priv *priv)
 	mac->mii.clk_csr_shift = 19;
 	mac->mii.clk_csr_mask = GENMASK(21, 19);
 
+	mac->phylink_mac_capabilities = MAC_2500FD | MAC_5000FD |
+					MAC_10000FD | MAC_25000FD |
+					MAC_40000FD | MAC_50000FD |
+					MAC_100000FD;
+
 	return 0;
 }
 
@@ -1693,5 +1688,10 @@ int dwxlgmac2_setup(struct stmmac_priv *priv)
 	mac->mii.clk_csr_shift = 19;
 	mac->mii.clk_csr_mask = GENMASK(21, 19);
 
+	mac->phylink_mac_capabilities = MAC_2500FD | MAC_5000FD |
+					MAC_10000FD | MAC_25000FD |
+					MAC_40000FD | MAC_50000FD |
+					MAC_100000FD;
+
 	return 0;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 7be04b54738b..7370cd963569 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -308,8 +308,6 @@ struct stmmac_est;
 struct stmmac_ops {
 	/* MAC core initialization */
 	void (*core_init)(struct mac_device_info *hw, struct net_device *dev);
-	/* Get phylink capabilities */
-	void (*phylink_get_caps)(struct stmmac_priv *priv);
 	/* Enable the MAC RX/TX */
 	void (*set_mac)(void __iomem *ioaddr, bool enable);
 	/* Enable and verify that the IPC module is supported */
@@ -430,8 +428,6 @@ struct stmmac_ops {
 
 #define stmmac_core_init(__priv, __args...) \
 	stmmac_do_void_callback(__priv, mac, core_init, __args)
-#define stmmac_mac_phylink_get_caps(__priv) \
-	stmmac_do_void_callback(__priv, mac, phylink_get_caps, __priv)
 #define stmmac_mac_set(__priv, __args...) \
 	stmmac_do_void_callback(__priv, mac, set_mac, __args)
 #define stmmac_rx_ipc(__priv, __args...) \
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 24cd80490d19..278532290f0c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1198,15 +1198,33 @@ static int stmmac_init_phy(struct net_device *dev)
 	return ret;
 }
 
-static void stmmac_set_half_duplex(struct stmmac_priv *priv)
+static void stmmac_set_mac_capabilties(struct stmmac_priv *priv)
 {
+	struct phylink_config cfg;
+
+	cfg.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+			       MAC_10FD | MAC_100FD | MAC_1000FD |
+			       priv->hw->phylink_mac_capabilities;
+
 	/* Half-Duplex can only work with single tx queue */
 	if (priv->plat->tx_queues_to_use > 1)
-		priv->phylink_config.mac_capabilities &=
-			~(MAC_10HD | MAC_100HD | MAC_1000HD);
+		cfg.mac_capabilities &= ~(MAC_10HD | MAC_100HD | MAC_1000HD);
 	else
-		priv->phylink_config.mac_capabilities |=
-			(MAC_10HD | MAC_100HD | MAC_1000HD);
+		cfg.mac_capabilities |= MAC_10HD | MAC_100HD | MAC_1000HD;
+
+	max_speed = priv->plat->max_speed;
+	if (max_speed)
+		phylink_limit_mac_speed(&cfg, max_speed);
+
+	/* If the platform supplies MAC capabilities, calculate the union
+	 * of the MAC and platform capabilities to give the whole-system
+	 * capabilities. This intetionally can not add additional capabilities
+	 * so if this is populated, it must list everything that is supported.
+	 */
+	if (priv->plat->phylink_mac_capabilities)
+		cfg.mac_capabilities &= priv->plat->phylink_mac_capabilities;
+
+	priv->phylink_config.mac_capabilities = cfg.mac_capabilities;
 }
 
 static int stmmac_phy_setup(struct stmmac_priv *priv)
@@ -1236,18 +1254,7 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
 		xpcs_get_interfaces(priv->hw->xpcs,
 				    priv->phylink_config.supported_interfaces);
 
-	priv->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
-						MAC_10FD | MAC_100FD |
-						MAC_1000FD;
-
-	stmmac_set_half_duplex(priv);
-
-	/* Get the MAC specific capabilities */
-	stmmac_mac_phylink_get_caps(priv);
-
-	max_speed = priv->plat->max_speed;
-	if (max_speed)
-		phylink_limit_mac_speed(&priv->phylink_config, max_speed);
+	stmmac_set_mac_capabilties(priv);
 
 	fwnode = priv->plat->port_node;
 	if (!fwnode)
@@ -7355,7 +7362,7 @@ int stmmac_reinit_queues(struct net_device *dev, u32 rx_cnt, u32 tx_cnt)
 			priv->rss.table[i] = ethtool_rxfh_indir_default(i,
 									rx_cnt);
 
-	stmmac_set_half_duplex(priv);
+	stmmac_set_mac_capabilties(priv);
 	stmmac_napi_add(dev);
 
 	if (netif_running(dev))
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index dfa1828cd756..fe3f64df17ac 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -272,6 +272,7 @@ struct plat_stmmacenet_data {
 	u8 tx_sched_algorithm;
 	struct stmmac_rxq_cfg rx_queues_cfg[MTL_MAX_RX_QUEUES];
 	struct stmmac_txq_cfg tx_queues_cfg[MTL_MAX_TX_QUEUES];
+	u32 phylink_mac_capabilities;
 	void (*fix_mac_speed)(void *priv, unsigned int speed, unsigned int mode);
 	int (*fix_soc_reset)(void *priv, void __iomem *ioaddr);
 	int (*serdes_powerup)(struct net_device *ndev, void *priv);
-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

