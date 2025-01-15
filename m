Return-Path: <netdev+bounces-158644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B176A12CE2
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 21:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FEC33A6B4D
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 20:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9C61D9A70;
	Wed, 15 Jan 2025 20:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ICr/SyY5"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185281D95A1
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 20:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736973811; cv=none; b=HO/lcJuONwoZGjTDXaYOiy0cUGRyh0u7em6D6AmOq1Ushyx0j3mno/5zK7jKP0OM7ZqJtP6zfukXDfVjZOsV2JBfTG/bL+bW3w7W0v9OIxgf+B+fYSnv8+5XlnQn4GnDAhOSyQzCghzGc+IwJRDsqQXCl0rJhZ8hFQfgAulVrmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736973811; c=relaxed/simple;
	bh=jmgwXL4v4DSCoxEKA4zoBQj8FkPLxB+IHI6yxRnIBXs=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=U3wlX8BDZQKuBiRRx8yokF/MyDcbcvtDFGdDcSOmEqd9eo0/Q3w1AXb8qAFQHLJsGFx99itL73CVdLayolNV+bqCZHwT5O/gG6kEGWvdE1ffuh5gGqsA5einBk7TXWvK7RhDG4+CROPMNNU5y/s/UoGrv1QyuYHhTihDGyDZG0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ICr/SyY5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TAYZrYSblciwbxJa3f2NqFq3GWQXee0diVDZL6k/hFg=; b=ICr/SyY5ZKcYHQNM6qug8vRZ9A
	cHVeBYw4sN29Mkx8HnT4Vb73oNMlgji1dXZd75m5Ll/4tWsMVCsd/3FTMPvorNJMQ8WU1S8fol3j7
	b1SDZhMBBFPQh4lrfA+2YyMLKkrdXNGTSLsshyrq+o3AySATp2c/fTpV+nqc1L5HiSB9CD7vFFNOq
	szDeKj4mPGqLEaSa4cm6R8AcTG1lytkGUzRO2zNbhLuI59WCEeoMJyiY1eTj9hYuSbatr2P11ek9c
	XGoNOGp2ZJuWPu4LQoilz6fxkSvWhraRClXSk0RTC82ImD1awOzU9vc1TsNt/CPTWjzKGEYhs0iL+
	zJvMnriw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:56054 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tYAEU-0001kC-0u;
	Wed, 15 Jan 2025 20:43:22 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tYAEB-0014QB-4s; Wed, 15 Jan 2025 20:43:03 +0000
In-Reply-To: <Z4gdtOaGsBhQCZXn@shell.armlinux.org.uk>
References: <Z4gdtOaGsBhQCZXn@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com
Subject: [PATCH net-next 8/9] net: lan743x: convert to phylink managed EEE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tYAEB-0014QB-4s@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 15 Jan 2025 20:43:03 +0000

Convert lan743x to phylink managed EEE:
- Set the lpi_capabilties.
- Move the call to lan743x_mac_eee_enable() into the enable/disable
  tx_lpi functions.
- Ensure that EEEEN is clear during probe.
- Move the setting of the LPI timer into mac_enable_tx_lpi().
- Move reading of LPI timer to phylink initialisation to set the
  default timer value.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/microchip/lan743x_ethtool.c  | 21 ---------
 drivers/net/ethernet/microchip/lan743x_main.c | 44 ++++++++++++++++---
 drivers/net/ethernet/microchip/lan743x_main.h |  1 -
 3 files changed, 38 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_ethtool.c b/drivers/net/ethernet/microchip/lan743x_ethtool.c
index 1a1cbd034eda..1459acfb1e61 100644
--- a/drivers/net/ethernet/microchip/lan743x_ethtool.c
+++ b/drivers/net/ethernet/microchip/lan743x_ethtool.c
@@ -1055,9 +1055,6 @@ static int lan743x_ethtool_get_eee(struct net_device *netdev,
 {
 	struct lan743x_adapter *adapter = netdev_priv(netdev);
 
-	eee->tx_lpi_timer = lan743x_csr_read(adapter,
-					     MAC_EEE_TX_LPI_REQ_DLY_CNT);
-
 	return phylink_ethtool_get_eee(adapter->phylink, eee);
 }
 
@@ -1065,24 +1062,6 @@ static int lan743x_ethtool_set_eee(struct net_device *netdev,
 				   struct ethtool_keee *eee)
 {
 	struct lan743x_adapter *adapter = netdev_priv(netdev);
-	u32 tx_lpi_timer;
-
-	tx_lpi_timer = lan743x_csr_read(adapter, MAC_EEE_TX_LPI_REQ_DLY_CNT);
-	if (tx_lpi_timer != eee->tx_lpi_timer) {
-		u32 mac_cr = lan743x_csr_read(adapter, MAC_CR);
-
-		/* Software should only change this field when Energy Efficient
-		 * Ethernet Enable (EEEEN) is cleared.
-		 * This function will trigger an autonegotiation restart and
-		 * eee will be reenabled during link up if eee was negotiated.
-		 */
-		lan743x_mac_eee_enable(adapter, false);
-		lan743x_csr_write(adapter, MAC_EEE_TX_LPI_REQ_DLY_CNT,
-				  eee->tx_lpi_timer);
-
-		if (mac_cr & MAC_CR_EEE_EN_)
-			lan743x_mac_eee_enable(adapter, true);
-	}
 
 	return phylink_ethtool_set_eee(adapter->phylink, eee);
 }
diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 8d7ad021ac70..23760b613d3e 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -2966,7 +2966,7 @@ static int lan743x_phylink_2500basex_config(struct lan743x_adapter *adapter)
 	return lan743x_pcs_power_reset(adapter);
 }
 
-void lan743x_mac_eee_enable(struct lan743x_adapter *adapter, bool enable)
+static void lan743x_mac_eee_enable(struct lan743x_adapter *adapter, bool enable)
 {
 	u32 mac_cr;
 
@@ -3027,10 +3027,8 @@ static void lan743x_phylink_mac_link_down(struct phylink_config *config,
 					  phy_interface_t interface)
 {
 	struct net_device *netdev = to_net_dev(config->dev);
-	struct lan743x_adapter *adapter = netdev_priv(netdev);
 
 	netif_tx_stop_all_queues(netdev);
-	lan743x_mac_eee_enable(adapter, false);
 }
 
 static void lan743x_phylink_mac_link_up(struct phylink_config *config,
@@ -3072,16 +3070,40 @@ static void lan743x_phylink_mac_link_up(struct phylink_config *config,
 					  cap & FLOW_CTRL_TX,
 					  cap & FLOW_CTRL_RX);
 
-	if (phydev)
-		lan743x_mac_eee_enable(adapter, phydev->enable_tx_lpi);
-
 	netif_tx_wake_all_queues(netdev);
 }
 
+static void lan743x_mac_disable_tx_lpi(struct phylink_config *config)
+{
+	struct net_device *netdev = to_net_dev(config->dev);
+	struct lan743x_adapter *adapter = netdev_priv(netdev);
+
+	lan743x_mac_eee_enable(adapter, false);
+}
+
+static int lan743x_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
+				     bool tx_clk_stop)
+{
+	struct net_device *netdev = to_net_dev(config->dev);
+	struct lan743x_adapter *adapter = netdev_priv(netdev);
+
+	/* Software should only change this field when Energy Efficient
+	 * Ethernet Enable (EEEEN) is cleared. We ensure that by clearing
+	 * EEEEN during probe, and phylink itself guarantees that
+	 * mac_disable_tx_lpi() will have been previously called.
+	 */
+	lan743x_csr_write(adapter, MAC_EEE_TX_LPI_REQ_DLY_CNT, timer);
+	lan743x_mac_eee_enable(adapter, true);
+
+	return 0;
+}
+
 static const struct phylink_mac_ops lan743x_phylink_mac_ops = {
 	.mac_config = lan743x_phylink_mac_config,
 	.mac_link_down = lan743x_phylink_mac_link_down,
 	.mac_link_up = lan743x_phylink_mac_link_up,
+	.mac_disable_tx_lpi = lan743x_mac_disable_tx_lpi,
+	.mac_enable_tx_lpi = lan743x_mac_enable_tx_lpi,
 };
 
 static int lan743x_phylink_create(struct lan743x_adapter *adapter)
@@ -3095,6 +3117,9 @@ static int lan743x_phylink_create(struct lan743x_adapter *adapter)
 
 	adapter->phylink_config.mac_capabilities = MAC_ASYM_PAUSE |
 		MAC_SYM_PAUSE | MAC_10 | MAC_100 | MAC_1000FD;
+	adapter->phylink_config.lpi_capabilities = MAC_100FD | MAC_1000FD;
+	adapter->phylink_config.lpi_timer_default =
+		lan743x_csr_read(adapter, MAC_EEE_TX_LPI_REQ_DLY_CNT);
 
 	lan743x_phy_interface_select(adapter);
 
@@ -3120,6 +3145,10 @@ static int lan743x_phylink_create(struct lan743x_adapter *adapter)
 		phy_interface_set_rgmii(adapter->phylink_config.supported_interfaces);
 	}
 
+	memcpy(adapter->phylink_config.lpi_interfaces,
+	       adapter->phylink_config.supported_interfaces,
+	       sizeof(adapter->phylink_config.lpi_interfaces));
+
 	pl = phylink_create(&adapter->phylink_config, NULL,
 			    adapter->phy_interface, &lan743x_phylink_mac_ops);
 
@@ -3517,6 +3546,9 @@ static int lan743x_hardware_init(struct lan743x_adapter *adapter,
 		spin_lock_init(&tx->ring_lock);
 	}
 
+	/* Ensure EEEEN is clear */
+	lan743x_mac_eee_enable(adapter, false);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index 8ef897c114d3..7f73d66854be 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -1206,6 +1206,5 @@ void lan743x_hs_syslock_release(struct lan743x_adapter *adapter);
 void lan743x_mac_flow_ctrl_set_enables(struct lan743x_adapter *adapter,
 				       bool tx_enable, bool rx_enable);
 int lan743x_sgmii_read(struct lan743x_adapter *adapter, u8 mmd, u16 addr);
-void lan743x_mac_eee_enable(struct lan743x_adapter *adapter, bool enable);
 
 #endif /* _LAN743X_H */
-- 
2.30.2


