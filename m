Return-Path: <netdev+bounces-176605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA17A6B08D
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 23:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43A6D17D559
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 22:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB3E22C33A;
	Thu, 20 Mar 2025 22:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MRYYPRdy"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB7522B8CF
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 22:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742508717; cv=none; b=FW/eE5kz/xx0sEQ13YFzyALBR51r7ADyyjNfg7zXHx/c3GZ57CYY1JAWuqkxN1XaOKa705vtJV+mJHMsI/NSV0g2TmutvleI0tKuz8TjTg05kJUFng7dxm3a2rSSXvLmak4geLl5rKF60ckVoNVnVuUXD/ZDCDbvpIl6DwBk0Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742508717; c=relaxed/simple;
	bh=qFpjXR41VhLk1bRbOPw8+0MNudmg1SDOK4lfjATa/iE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=JJ8/LhbiZticc3JccrbA5qn+S4x3ie8Vot0m3l+VtJWjKeFmH1jFjTCLUqTSWB7agCtNI9lkAGJ++b2mBmCeDd7lBOX+w81+1zYafUosQCQOyW+h0KKNP8gDoADDUWEQHvqF+iANhgWwmaWm7m4IryO5TwRAg6uA6MzVUkd3ZcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=MRYYPRdy; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ChKjIakwJND4vOY0HyYOFQnBjQelfpLov4gGDNWana8=; b=MRYYPRdyTwUz3nT4aAgnzm0Y2k
	kVDyf+2rnB58GjD2Bzo5h1hwIUtvpN9zS8jDV8rlJa/HyFN3ILfN+IyxfusH8JPfsu4HAh3oDtgQI
	NnLNEyEPztmLX1MeZrXQCkv9q0cQQ9m9WmETsy8Op3y0MoQs2AuIH+bSYft1XWfJHAK9GQGgCx5FH
	4V/2VUotn4nz3LJ8zatUSd9R0HDdSf7dylORraDcjozSw/3fz4KTsFo1cJrBb0lJVmovUIPxfSb3E
	DeYyK6KkLmcBoz6peqBWOArcHr1n8/YTckvZmYc7mZpwN26RIfyWDjv/CrXNAWttM2Zr3/Sa29fOI
	PK5W/Apg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:59052 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tvO7A-0008Eb-1P;
	Thu, 20 Mar 2025 22:11:48 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tvO6p-008Vjz-Qy; Thu, 20 Mar 2025 22:11:27 +0000
In-Reply-To: <Z9ySeo61VYTClIJJ@shell.armlinux.org.uk>
References: <Z9ySeo61VYTClIJJ@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 5/5] net: stmmac: block PHY RXC clock-stop
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tvO6p-008Vjz-Qy@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 20 Mar 2025 22:11:27 +0000

The DesignWare core requires the receive clock to be running during
certain operations. Ensure that we block PHY RXC clock-stop during
these operations.

This is a best-efforts change - not everywhere can be covered by this
because of net's core locking, which means we can't access the MDIO
bus to configure the PHY to disable RXC clock-stop in certain areas.
These are marked with FIXME comments.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 860f800cd014..a4f2c98e851a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3484,9 +3484,18 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
 	if (priv->hw->phylink_pcs)
 		phylink_pcs_pre_init(priv->phylink, priv->hw->phylink_pcs);
 
+	/* Note that clk_rx_i must be running for reset to complete. This
+	 * clock may also be required when setting the MAC address.
+	 *
+	 * Block the receive clock stop for LPI mode at the PHY in case
+	 * the link is established with EEE mode active.
+	 */
+	phylink_rx_clk_stop_block(priv->phylink);
+
 	/* DMA initialization and SW reset */
 	ret = stmmac_init_dma_engine(priv);
 	if (ret < 0) {
+		phylink_rx_clk_stop_unblock(priv->phylink);
 		netdev_err(priv->dev, "%s: DMA engine initialization failed\n",
 			   __func__);
 		return ret;
@@ -3494,6 +3503,7 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
 
 	/* Copy the MAC addr into the HW  */
 	stmmac_set_umac_addr(priv, priv->hw, dev->dev_addr, 0);
+	phylink_rx_clk_stop_unblock(priv->phylink);
 
 	/* PS and related bits will be programmed according to the speed */
 	if (priv->hw->pcs) {
@@ -3604,7 +3614,9 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
 	/* Start the ball rolling... */
 	stmmac_start_all_dma(priv);
 
+	phylink_rx_clk_stop_block(priv->phylink);
 	stmmac_set_hw_vlan_mode(priv, priv->hw);
+	phylink_rx_clk_stop_unblock(priv->phylink);
 
 	return 0;
 }
@@ -5888,6 +5900,9 @@ static void stmmac_tx_timeout(struct net_device *dev, unsigned int txqueue)
  *  whenever multicast addresses must be enabled/disabled.
  *  Return value:
  *  void.
+ *
+ *  FIXME: This may need RXC to be running, but it may be called with BH
+ *  disabled, which means we can't call phylink_rx_clk_stop*().
  */
 static void stmmac_set_rx_mode(struct net_device *dev)
 {
@@ -6020,7 +6035,9 @@ static int stmmac_set_features(struct net_device *netdev,
 	else
 		priv->hw->hw_vlan_en = false;
 
+	phylink_rx_clk_stop_block(priv->phylink);
 	stmmac_set_hw_vlan_mode(priv, priv->hw);
+	phylink_rx_clk_stop_unblock(priv->phylink);
 
 	return 0;
 }
@@ -6304,7 +6321,9 @@ static int stmmac_set_mac_address(struct net_device *ndev, void *addr)
 	if (ret)
 		goto set_mac_error;
 
+	phylink_rx_clk_stop_block(priv->phylink);
 	stmmac_set_umac_addr(priv, priv->hw, ndev->dev_addr, 0);
+	phylink_rx_clk_stop_unblock(priv->phylink);
 
 set_mac_error:
 	pm_runtime_put(priv->device);
@@ -6660,6 +6679,9 @@ static int stmmac_vlan_update(struct stmmac_priv *priv, bool is_double)
 	return stmmac_update_vlan_hash(priv, priv->hw, hash, pmatch, is_double);
 }
 
+/* FIXME: This may need RXC to be running, but it may be called with BH
+ * disabled, which means we can't call phylink_rx_clk_stop*().
+ */
 static int stmmac_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid)
 {
 	struct stmmac_priv *priv = netdev_priv(ndev);
@@ -6691,6 +6713,9 @@ static int stmmac_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid
 	return ret;
 }
 
+/* FIXME: This may need RXC to be running, but it may be called with BH
+ * disabled, which means we can't call phylink_rx_clk_stop*().
+ */
 static int stmmac_vlan_rx_kill_vid(struct net_device *ndev, __be16 proto, u16 vid)
 {
 	struct stmmac_priv *priv = netdev_priv(ndev);
@@ -7951,9 +7976,11 @@ int stmmac_resume(struct device *dev)
 
 	stmmac_hw_setup(ndev, false);
 	stmmac_init_coalesce(priv);
+	phylink_rx_clk_stop_block(priv->phylink);
 	stmmac_set_rx_mode(ndev);
 
 	stmmac_restore_hw_vlan_rx_fltr(priv, ndev, priv->hw);
+	phylink_rx_clk_stop_unblock(priv->phylink);
 
 	stmmac_enable_all_queues(priv);
 	stmmac_enable_all_dma_irq(priv);
-- 
2.30.2


