Return-Path: <netdev+bounces-230118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1D2BE437B
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 17:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95496401786
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 15:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD24734AAFC;
	Thu, 16 Oct 2025 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CDZlWuTt"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FDD34575D
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628428; cv=none; b=GwboqI1SJOTDQH3YlpkbJ39t3sKyya8677VuC/RK1rNyUz10HjPkUwhjDcDV4mvgEfDO1fiD8+QGvx/+6CvhRfCjerB2KEKZ8vybF40y0zmMDJje61fkUjIflalNrOGBl9MXlQRX5LMjo8IxnzFWphEoNR5EFtjeyi1vKaasFro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628428; c=relaxed/simple;
	bh=d8vxjs5D0HAwNMZbb0vxY1waT8UIH8Mc2Eyy7UDNZ3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hUbb41q6ss3hK/cWe3Vu0dBuKfbL6kAllzBs6TCtChVxu0yKCgGevPE+mw/ncjLKP1G1JFakRdkG/L2FbaUbsHPoChgAf6JNGiiHs5jBREUmj6xh8WAfS9PMk371wVPBgIqn9jrVAmPMapCCL6B+C7Xp2xQFKium5b9OWyEuusc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CDZlWuTt; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760628422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z2BPxfqLmeYHCAUJ3okUNNiUDmEsl5m9E5HV6C4SLfY=;
	b=CDZlWuTtBjHNOED9OO8MRPGwnyE1nvwpzWoeA1jpjlSBrfXDKj07WuOw1r9FBq06hYc6LT
	OdkylcNS9WCOLYKZY0GuRkX7O+aMvUNrrVJU8PK6LRueCcJM+X5r0eMDJo/P8BlaSrEiRa
	2pAvNyMUwCrdx1NtHlIgNfkxa9zc1Mo=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Egor Pomozov <epomozov@marvell.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Dimitris Michailidis <dmichail@fungible.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next v3 1/7] net: ti: am65-cpsw: move hw timestamping to ndo callback
Date: Thu, 16 Oct 2025 15:25:09 +0000
Message-ID: <20251016152515.3510991-2-vadim.fedorenko@linux.dev>
In-Reply-To: <20251016152515.3510991-1-vadim.fedorenko@linux.dev>
References: <20251016152515.3510991-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Migrate driver to new API for HW timestamping.

Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 44 +++++++++++-------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 110eb2da8dbc..d5f358ec9820 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -1788,28 +1788,28 @@ static int am65_cpsw_nuss_ndo_slave_set_mac_address(struct net_device *ndev,
 }
 
 static int am65_cpsw_nuss_hwtstamp_set(struct net_device *ndev,
-				       struct ifreq *ifr)
+				       struct kernel_hwtstamp_config *cfg,
+				       struct netlink_ext_ack *extack)
 {
 	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
 	u32 ts_ctrl, seq_id, ts_ctrl_ltype2, ts_vlan_ltype;
-	struct hwtstamp_config cfg;
 
-	if (!IS_ENABLED(CONFIG_TI_K3_AM65_CPTS))
+	if (!IS_ENABLED(CONFIG_TI_K3_AM65_CPTS)) {
+		NL_SET_ERR_MSG(extack, "Time stamping is not supported");
 		return -EOPNOTSUPP;
-
-	if (copy_from_user(&cfg, ifr->ifr_data, sizeof(cfg)))
-		return -EFAULT;
+	}
 
 	/* TX HW timestamp */
-	switch (cfg.tx_type) {
+	switch (cfg->tx_type) {
 	case HWTSTAMP_TX_OFF:
 	case HWTSTAMP_TX_ON:
 		break;
 	default:
+		NL_SET_ERR_MSG(extack, "TX mode is not supported");
 		return -ERANGE;
 	}
 
-	switch (cfg.rx_filter) {
+	switch (cfg->rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
 		port->rx_ts_enabled = false;
 		break;
@@ -1826,17 +1826,19 @@ static int am65_cpsw_nuss_hwtstamp_set(struct net_device *ndev,
 	case HWTSTAMP_FILTER_PTP_V2_SYNC:
 	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
 		port->rx_ts_enabled = true;
-		cfg.rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT | HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
+		cfg->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT | HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
 		break;
 	case HWTSTAMP_FILTER_ALL:
 	case HWTSTAMP_FILTER_SOME:
 	case HWTSTAMP_FILTER_NTP_ALL:
+		NL_SET_ERR_MSG(extack, "RX filter is not supported");
 		return -EOPNOTSUPP;
 	default:
+		NL_SET_ERR_MSG(extack, "RX filter is not supported");
 		return -ERANGE;
 	}
 
-	port->tx_ts_enabled = (cfg.tx_type == HWTSTAMP_TX_ON);
+	port->tx_ts_enabled = (cfg->tx_type == HWTSTAMP_TX_ON);
 
 	/* cfg TX timestamp */
 	seq_id = (AM65_CPSW_TS_SEQ_ID_OFFSET <<
@@ -1872,25 +1874,24 @@ static int am65_cpsw_nuss_hwtstamp_set(struct net_device *ndev,
 	       AM65_CPSW_PORTN_REG_TS_CTL_LTYPE2);
 	writel(ts_ctrl, port->port_base + AM65_CPSW_PORTN_REG_TS_CTL);
 
-	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
+	return 0;
 }
 
 static int am65_cpsw_nuss_hwtstamp_get(struct net_device *ndev,
-				       struct ifreq *ifr)
+				       struct kernel_hwtstamp_config *cfg)
 {
 	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
-	struct hwtstamp_config cfg;
 
 	if (!IS_ENABLED(CONFIG_TI_K3_AM65_CPTS))
 		return -EOPNOTSUPP;
 
-	cfg.flags = 0;
-	cfg.tx_type = port->tx_ts_enabled ?
+	cfg->flags = 0;
+	cfg->tx_type = port->tx_ts_enabled ?
 		      HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
-	cfg.rx_filter = port->rx_ts_enabled ? HWTSTAMP_FILTER_PTP_V2_EVENT |
+	cfg->rx_filter = port->rx_ts_enabled ? HWTSTAMP_FILTER_PTP_V2_EVENT |
 			HWTSTAMP_FILTER_PTP_V1_L4_EVENT : HWTSTAMP_FILTER_NONE;
 
-	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
+	return 0;
 }
 
 static int am65_cpsw_nuss_ndo_slave_ioctl(struct net_device *ndev,
@@ -1901,13 +1902,6 @@ static int am65_cpsw_nuss_ndo_slave_ioctl(struct net_device *ndev,
 	if (!netif_running(ndev))
 		return -EINVAL;
 
-	switch (cmd) {
-	case SIOCSHWTSTAMP:
-		return am65_cpsw_nuss_hwtstamp_set(ndev, req);
-	case SIOCGHWTSTAMP:
-		return am65_cpsw_nuss_hwtstamp_get(ndev, req);
-	}
-
 	return phylink_mii_ioctl(port->slave.phylink, req, cmd);
 }
 
@@ -1991,6 +1985,8 @@ static const struct net_device_ops am65_cpsw_nuss_netdev_ops = {
 	.ndo_set_tx_maxrate	= am65_cpsw_qos_ndo_tx_p0_set_maxrate,
 	.ndo_bpf		= am65_cpsw_ndo_bpf,
 	.ndo_xdp_xmit		= am65_cpsw_ndo_xdp_xmit,
+	.ndo_hwtstamp_get       = am65_cpsw_nuss_hwtstamp_get,
+	.ndo_hwtstamp_set       = am65_cpsw_nuss_hwtstamp_set,
 };
 
 static void am65_cpsw_disable_phy(struct phy *phy)
-- 
2.47.3


