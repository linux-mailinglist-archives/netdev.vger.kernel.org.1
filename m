Return-Path: <netdev+bounces-80801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B968811E3
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 13:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83B291C20CB9
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 12:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4339D3FE4C;
	Wed, 20 Mar 2024 12:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YwJkDJxH"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFF73FE36
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 12:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710939051; cv=none; b=faEKMtmWXNZVM1y7wuVapzD2fPrDmn8HdjwpfxjEMrocfvOOcUZ/eQEp2LLY6BSSbhZWNAbmAkHTI2ma2R+jblg/eBX+HQCMxLEQW3Wgr8So2miLhCONFQvByDHzXwb5dvWUp2Iu8EVWY6f5DPEBbiPvYGawvO/J3a7uBxcegwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710939051; c=relaxed/simple;
	bh=o/DlsuK21OQ13HqSeY49PWKGu2i8favQ6uv9s0HvEkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhrnG7JAe231+kz+yfvyQTyAO2AudmhOMMwsPfCY2HU24ZEw/zzOfiI6c477mXtgKQSr+s+8oytFs3YPjnShiHmxotH01Wr72Hv2CNZuV+cAFzhw5bIDVcA8if9sZ9jlSb9sZkmx32NJohbrWkvjo7GSVHS0LFllNU/s79IQCQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=YwJkDJxH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qQCPn2d5r6hKCuujvuYO0dGiajsvT0uq9w1k7Q8OsdA=; b=YwJkDJxHCZgF+r8EScsJwjZw68
	MdEonQqIoNqbb2q3ptWS5wa3T9P9cGWnxPztw+WGczIIY1V2QXWn2itGQKBwE7QOFs7jnKaXRJdOD
	IyRcnho2kioA/xBMbethFH67cij9tdq4EFVBHhT7qLcIDDnWcuL8K6nodVZGjb30/E1K5Q+VK8UyX
	zthHHUxGx2PsH6NagB7zxK3TNqoETAgDEjEq56ZPByFthcVF9xfwDJApEYkgsh+qDWY5MU6Ww0Gno
	CG1bpSo8/UjipdSRYjeDBh/Is7ckdnEQc4FEv4lg7twTBVBG+wLBnj+Xbe2JCLI2gm8207ODGU1fS
	muDDHUEw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42376)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rmvOp-0006Xr-2N;
	Wed, 20 Mar 2024 12:50:31 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rmvOm-0002gY-5o; Wed, 20 Mar 2024 12:50:28 +0000
Date: Wed, 20 Mar 2024 12:50:28 +0000
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
Message-ID: <ZfrblN+OxODjZzfx@shell.armlinux.org.uk>
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <3382be108772ce56fe3e9bb99c9c53b7e9cd6bad.1706601050.git.siyanteng@loongson.cn>
 <dp4fhkephitylrf6a3rygjeftqf4mwrlgcdasstrq2osans3zd@zyt6lc7nu2e3>
 <vostvybxawyhzmcnabnh7hsc7kk6vdxfdzqu4rkuqv6sdm7cuw@fd2y2o7di5am>
 <88c8f5a4-16c1-498b-9a2a-9ba04a9b0215@loongson.cn>
 <ZfF+IAWbe1rwx3Xs@shell.armlinux.org.uk>
 <cd8be3b1-fcfa-4836-9d28-ced735169615@loongson.cn>
 <em3r6w7ydvjxualqifjurtrrfpztpil564t5k5b4kxv4f6ddrd@4weteqhekyae>
 <Zfq8TNrt0KxW/IWh@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zfq8TNrt0KxW/IWh@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Mar 20, 2024 at 10:37:00AM +0000, Russell King (Oracle) wrote:
> I was thinking:
> 
> 	stmmac_mac_phylink_get_caps(priv);
> 
> 	if (priv->plat->mac_capabilities)
> 		priv->phylink_config.mac_capabilities &=
> 			priv->plat->mac_capabilities;
> 
> In other words, if a platform sets plat->mac_capabilities, then it is
> providing the capabilities that it supports, and those need to reduce
> the capabilities provided by the MAC.

To further expand on this given the additional discussion, here's a
patch that amagamates the ideas so far - however, it doesn't
implement everything.

I think an additional step would be to provide a function that does all
the mac capability calculations, something like:

static void stmmac_calculate_mac_capabilities(struct stmmac_priv *priv)
{
	struct phylink_config cfg;

	/* do everything with cfg.mac_capabilities that is currently in
	 * stmmac_phy_setup()
	 */

	/* this must be done with rtnl held if the device is open */
	priv->phylink_config.mac_capabilities = cfg.mac_capabilities;
}

and that needs to be called from both stmmac_reinit_queues() and
stmmac_phy_setup().

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
index 24cd80490d19..5e8cffc49f1f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1240,15 +1240,25 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
 						MAC_10FD | MAC_100FD |
 						MAC_1000FD;
 
-	stmmac_set_half_duplex(priv);
+	/* Merge in the MAC capabilities */
+	priv->phylink_config.mac_capabilities |=
+					priv->hw->phylink_mac_capabilities;
 
-	/* Get the MAC specific capabilities */
-	stmmac_mac_phylink_get_caps(priv);
+	stmmac_set_half_duplex(priv);
 
 	max_speed = priv->plat->max_speed;
 	if (max_speed)
 		phylink_limit_mac_speed(&priv->phylink_config, max_speed);
 
+	/* If the platform supplies MAC capabilities, calculate the union
+	 * of the MAC and platform capabilities to give the whole-system
+	 * capabilities. This intetionally can not add additional capabilities
+	 * so if this is populated, it must list everything that is supported.
+	 */
+	if (priv->plat->phylink_mac_capabilities)
+		priv->phylink_config.mac_capabilities &=
+					priv->plat->phylink_mac_capabilities;
+
 	fwnode = priv->plat->port_node;
 	if (!fwnode)
 		fwnode = dev_fwnode(priv->device);
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

