Return-Path: <netdev+bounces-235154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26007C2CB1F
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 16:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 088F718898FF
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 15:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D0031C56E;
	Mon,  3 Nov 2025 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KvjPemyT"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF518314B7A
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 15:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182656; cv=none; b=C7hCh/k9KOj5+yr2dr6oxrdPGgoLTAMSUcXHwifEGuSuKc3Y/JR1ARog2SMlq8Q888li25nUzKXO1vOQS38mURo5ukw+JudwgIAPqlFAhxN9EC+a0nczhWgGsgI+1vDxa4oxQdw5uyUkAj6xHEwzDJ6Xdefztq9PnheM/U1OfII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182656; c=relaxed/simple;
	bh=IidYPd89wgbo1KTEiWpMuDi9sHyXcKGVPGn23S57wcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LW7eZWz5y9h4IC4v4G+VWtw2vWuDyQFB0EmIHjv2G17YIqpOBgR1UBU+/lHLsY7XvRl+XIn0VqL0IQ2z9SesMn38PB3rO6NcAW7op6KO99VGgIe4rEhA4eptAOiUyOjrYrgjBuECTC13KBWeIptbVXDSh0a7rDS8JeabpdF5Q3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KvjPemyT; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762182651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dx/KcmsxnkeJdah6VzbpslQn+yn8sGVTxrIik7Svxh8=;
	b=KvjPemyTeFZ8KsGw3ZC+R+Z78OPcNZTK5lIexGgGLgGG+VbzE4zoAipebCEpP5zU1bypc6
	IwixgZ6smWehGWrypRp06JPQ+VJGqMO9JVPS1M6qQM0R1g5JVxuWR8Iz01PSIZgEx57j5/
	HDHuV9B5T1sNBKbjntNIkdJq5o0MOws=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Manish Chopra <manishc@marvell.com>,
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
Subject: [PATCH net-next v2 6/7] net: pch_gbe: convert to use ndo_hwtstamp callbacks
Date: Mon,  3 Nov 2025 15:09:51 +0000
Message-ID: <20251103150952.3538205-7-vadim.fedorenko@linux.dev>
In-Reply-To: <20251103150952.3538205-1-vadim.fedorenko@linux.dev>
References: <20251103150952.3538205-1-vadim.fedorenko@linux.dev>
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
 .../ethernet/oki-semi/pch_gbe/pch_gbe_main.c  | 38 +++++++++++--------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
index e5a6f59af0b6..62f05f4569b1 100644
--- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
+++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
@@ -198,23 +198,21 @@ pch_tx_timestamp(struct pch_gbe_adapter *adapter, struct sk_buff *skb)
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
@@ -223,17 +221,17 @@ static int hwtstamp_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
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


