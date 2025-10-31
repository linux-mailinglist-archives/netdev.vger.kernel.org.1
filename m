Return-Path: <netdev+bounces-234538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C87C9C22D0F
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 01:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88CC13A0573
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 00:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E091FDA89;
	Fri, 31 Oct 2025 00:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pTlq8m7F"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2A72AD13
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 00:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761871603; cv=none; b=O3TRyIAH6Unu7WufoaXha+13MSGKdj2T+qpiRtqQ0LV93MJvax4lhLf/Vyk1eKZ1SoXlqRXKtRbuAsU/RKQZV5dce2Z9u+2MMgegE8hBBSuVdxN1AgMPk5cxLJAhsEFxRNIDCjV9HLvf6STviTwlBj5ITQlbAmf3iXTu8v7+Gkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761871603; c=relaxed/simple;
	bh=6ObGsY7Q4mB3NrmrSx2ow/1t3ZfSEgu6AO/v0bO7MeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IgX5CaXg1S/4/ze/DCKaccV6a5JJlQni3l+UcXgiAllqUNoC9d2RSdETxxF5uzWIgfO8FMYzPa1teXNPy5b8nMUgk5TZ1kMSRctCBiNtuE6QIw1VDgPD/CHCKfnkLAUzXJrSf63MwFPBGYBZzltHOcpXPajWZt/0U64w8kZcZ70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pTlq8m7F; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761871599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FdXSw7y+tJwtEnUY1bUYezsC1HyGh3pjufJt1lWDKVg=;
	b=pTlq8m7FAsvLVyz4krKbchHJ0NU5FE+R5WQSR13ckbEKsC5uEdB4LKOVk31e8XfnS5BhDg
	yQomAnUMHX6oRoEUeqI2GwnhOD5oQEMecLtSIKiubaTbsgj7Q32fnVYPwDKZa2exBgqTnF
	1WadY5XibFr4noMxOjp+jozCdfxwQTw=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 6/7] net: pch_gbe: convert to use ndo_hwtstamp callbacks
Date: Fri, 31 Oct 2025 00:46:06 +0000
Message-ID: <20251031004607.1983544-7-vadim.fedorenko@linux.dev>
In-Reply-To: <20251031004607.1983544-1-vadim.fedorenko@linux.dev>
References: <20251031004607.1983544-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The driver implemented SIOCSHWTSTAMP ioctl command only, but it stores
configuration in the private data, so it is possible to report it back
to users. Implement both ndo_hwtstamp_set and ndo_hwtstamp_get
callbacks. To properly report RX filter type, store it in hwts_rx_en
instead of using this field as a simple flag. The logic didn't change
because receive path used this field as boolean flag.

Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 .../ethernet/oki-semi/pch_gbe/pch_gbe_main.c  | 40 +++++++++++--------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
index e5a6f59af0b6..4049137abc40 100644
--- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
+++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
@@ -198,42 +198,40 @@ pch_tx_timestamp(struct pch_gbe_adapter *adapter, struct sk_buff *skb)
 	pch_ch_event_write(pdev, TX_SNAPSHOT_LOCKED);
 }
 
-static int hwtstamp_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
+static int pch_gbe_hwtstamp_set(struct net_device *netdev,
+				struct kernel_hwtstamp_config *cfg,
+				struct netlink_ext_ack *extack)
 {
-	struct hwtstamp_config cfg;
 	struct pch_gbe_adapter *adapter = netdev_priv(netdev);
 	struct pci_dev *pdev;
 	u8 station[20];
 
-	if (copy_from_user(&cfg, ifr->ifr_data, sizeof(cfg)))
-		return -EFAULT;
-
 	/* Get ieee1588's dev information */
 	pdev = adapter->ptp_pdev;
 
-	if (cfg.tx_type != HWTSTAMP_TX_OFF && cfg.tx_type != HWTSTAMP_TX_ON)
+	if (cfg->tx_type != HWTSTAMP_TX_OFF && cfg->tx_type != HWTSTAMP_TX_ON)
 		return -ERANGE;
 
-	switch (cfg.rx_filter) {
+	switch (cfg->rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
 		adapter->hwts_rx_en = 0;
 		break;
 	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
-		adapter->hwts_rx_en = 0;
+		adapter->hwts_rx_en = cfg->rx_filter;
 		pch_ch_control_write(pdev, SLAVE_MODE | CAP_MODE0);
 		break;
 	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
-		adapter->hwts_rx_en = 1;
+		adapter->hwts_rx_en = cfg->rx_filter;
 		pch_ch_control_write(pdev, MASTER_MODE | CAP_MODE0);
 		break;
 	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
-		adapter->hwts_rx_en = 1;
+		adapter->hwts_rx_en = cfg->rx_filter;
 		pch_ch_control_write(pdev, V2_MODE | CAP_MODE2);
 		strcpy(station, PTP_L4_MULTICAST_SA);
 		pch_set_station_address(station, pdev);
 		break;
 	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
-		adapter->hwts_rx_en = 1;
+		adapter->hwts_rx_en = cfg->rx_filter;
 		pch_ch_control_write(pdev, V2_MODE | CAP_MODE2);
 		strcpy(station, PTP_L2_MULTICAST_SA);
 		pch_set_station_address(station, pdev);
@@ -242,12 +240,23 @@ static int hwtstamp_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
 		return -ERANGE;
 	}
 
-	adapter->hwts_tx_en = cfg.tx_type == HWTSTAMP_TX_ON;
+	adapter->hwts_tx_en = cfg->tx_type == HWTSTAMP_TX_ON;
 
 	/* Clear out any old time stamps. */
 	pch_ch_event_write(pdev, TX_SNAPSHOT_LOCKED | RX_SNAPSHOT_LOCKED);
 
-	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
+	return 0;
+}
+
+static int pch_gbe_hwtstamp_get(struct net_device *netdev,
+				struct kernel_hwtstamp_config *cfg)
+{
+	struct pch_gbe_adapter *adapter = netdev_priv(netdev);
+
+	cfg->tx_type = adapter->hwts_tx_en ? HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
+	cfg->rx_filter = adapter->hwts_rx_en;
+
+	return 0;
 }
 
 static inline void pch_gbe_mac_load_mac_addr(struct pch_gbe_hw *hw)
@@ -2234,9 +2243,6 @@ static int pch_gbe_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
 
 	netdev_dbg(netdev, "cmd : 0x%04x\n", cmd);
 
-	if (cmd == SIOCSHWTSTAMP)
-		return hwtstamp_ioctl(netdev, ifr, cmd);
-
 	return generic_mii_ioctl(&adapter->mii, if_mii(ifr), cmd, NULL);
 }
 
@@ -2328,6 +2334,8 @@ static const struct net_device_ops pch_gbe_netdev_ops = {
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	.ndo_poll_controller = pch_gbe_netpoll,
 #endif
+	.ndo_hwtstamp_get = pch_gbe_hwtstamp_get,
+	.ndo_hwtstamp_set = pch_gbe_hwtstamp_set,
 };
 
 static pci_ers_result_t pch_gbe_io_error_detected(struct pci_dev *pdev,
-- 
2.47.3


