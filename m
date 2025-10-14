Return-Path: <netdev+bounces-229399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C47FDBDBB2C
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 00:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BDF31501A97
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 22:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A46730BB99;
	Tue, 14 Oct 2025 22:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MNk1my2T"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77822E7186
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 22:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760481883; cv=none; b=FNkCqZBa/dDg1AZBBGtoA9cC9qAkO9MxrHmsQ+KgDD16tlMUrPiQlcxbq6Vb/eRCgr7cTqUuqqTogFG2ASGSrA5QGOijWnsy5Rz0QR68hFv7OmSgUsZwdbMn3LgZfEFyYcsrjFoh1qzFo7zsVb80OiNN3FDB/DORGVt3J0I1z/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760481883; c=relaxed/simple;
	bh=YklhfVZ62mZNY1wh/jd1TPvVsUsmOECcl6WaUHYTgSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aN19jilkgkgnlf0Dl1FFOaDschpqHs4oeoDxnGoblz3g671ZmY3WYi6os3841OLb07NzLO+QyF3HdJU/mAi9w3f25RXNoerDCjl00M7OYzYmXyCBL2Y77KJf66iuzaTk3s9p3pIbS/k0pdhPlXjF1Yn6NOqMl6EAJP067kKBNY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MNk1my2T; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760481878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=15ND+ZB8TIRbTdw5ymRpcaIOPRmN0CXQ97o2UwUvCrM=;
	b=MNk1my2TKEW1JpS3ejTE8HzBtevWX9c4Kw36ddlKVezuMiO7tgvFGXNBUw9FEUwx5sRiCo
	8Fy8H0iM37NGxhLkBFtD32yTsQWB/AYxXg6h+zWM7WaJVAAwBbdqeiAI6f23lFmX4pqLcY
	EWiMlEwLFWeEaFEBAwx7c67PfjeIlKo=
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
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v2 1/7] net: ti: am65-cpsw: move hw timestamping to ndo callback
Date: Tue, 14 Oct 2025 22:42:10 +0000
Message-ID: <20251014224216.8163-2-vadim.fedorenko@linux.dev>
In-Reply-To: <20251014224216.8163-1-vadim.fedorenko@linux.dev>
References: <20251014224216.8163-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Migrate driver to new API for HW timestamping.

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


