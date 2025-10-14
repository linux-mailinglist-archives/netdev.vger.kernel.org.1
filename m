Return-Path: <netdev+bounces-229402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F30DBBDBB32
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 00:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83463503BEF
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 22:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131A930E0F3;
	Tue, 14 Oct 2025 22:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rbbnbOPB"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D54A30E0E1
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 22:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760481912; cv=none; b=jqlrBXDhjvfaXj5FQbPlRhg/PU8M7mA0VZVcDSo1NfuI2OAlR7DomJ9QJthdC9tX36bgKCYVyh043J+IZ8rTlVPRhha6mKjZwQKt1ZZcZW2lUDwYOBFfDFSDk1ZDckDLqUvX+4zaIUoxpvUszDGu05pDjj6YY+I2DV0cH7N7xnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760481912; c=relaxed/simple;
	bh=4NG9Htk1GpOI46dcEfovdMbs32W7tUBdC7TC6aiE3Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YymoYxzxb+pOvf0Roo2Vl4bfegy5Ui5h/Ebh7eEDk+aocqR5CuQ1zGh+XK19MCx8ZvN+dtmwuuvCWr32xIjc8/QqWTYtgez27ZeMEW2+m7Lrr5jFvwjVQzOym8WtI0rrfU1nTAx5ydW7B2YEcf/qOo/synQ5QK9dfFZkx6hY65o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rbbnbOPB; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760481908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0URge+g5fQn3HMy2oQmsnD03+4HFmUsxA0K5zCUVeic=;
	b=rbbnbOPBxidcT0ievDRrsdINmzVayxOcttPPUcoEea+Dmpine3mPSytlFc1NtbLR8DpubP
	VAHcTf+ypVV8RCXUxiBDMC/u8DSOCA8agPmliAhSw6bM1g7NGBU4wk9T1ENtc3EbeUgFna
	ltOvyYPvIPyUc4mI48obtzyKmWq+uhc=
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
Subject: [PATCH net-next v2 5/7] cxgb4: convert to ndo_hwtstamp API
Date: Tue, 14 Oct 2025 22:42:14 +0000
Message-ID: <20251014224216.8163-6-vadim.fedorenko@linux.dev>
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

Convert to use .ndo_hwtstamp_get()/.ndo_hwtstamp_set() callbacks.

Though I'm not quite sure it worked properly before the conversion.

Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h    |   2 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   | 154 +++++++++---------
 2 files changed, 79 insertions(+), 77 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
index 0d85198fb03d..f20f4bc58492 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
@@ -674,7 +674,7 @@ struct port_info {
 	struct cxgb_fcoe fcoe;
 #endif /* CONFIG_CHELSIO_T4_FCOE */
 	bool rxtstamp;  /* Enable TS */
-	struct hwtstamp_config tstamp_config;
+	struct kernel_hwtstamp_config tstamp_config;
 	bool ptp_enable;
 	struct sched_table *sched_tbl;
 	u32 eth_flags;
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 392723ef14e5..7e2283c95b97 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -3042,12 +3042,87 @@ static void cxgb_get_stats(struct net_device *dev,
 		ns->rx_length_errors + stats.rx_len_err + ns->rx_fifo_errors;
 }
 
+static int cxgb_hwtstamp_get(struct net_device *dev,
+			     struct kernel_hwtstamp_config *config)
+{
+	struct port_info *pi = netdev_priv(dev);
+
+	*config = pi->tstamp_config;
+	return 0;
+}
+
+static int cxgb_hwtstamp_set(struct net_device *dev,
+			     struct kernel_hwtstamp_config *config,
+			     struct netlink_ext_ack *extack)
+{
+	struct port_info *pi = netdev_priv(dev);
+	struct adapter *adapter = pi->adapter;
+
+	if (is_t4(adapter->params.chip)) {
+		/* For T4 Adapters */
+		switch (config->rx_filter) {
+		case HWTSTAMP_FILTER_NONE:
+			pi->rxtstamp = false;
+			break;
+		case HWTSTAMP_FILTER_ALL:
+			pi->rxtstamp = true;
+			break;
+		default:
+			return -ERANGE;
+		}
+		pi->tstamp_config = *config;
+		return 0;
+	}
+
+	switch (config->tx_type) {
+	case HWTSTAMP_TX_OFF:
+	case HWTSTAMP_TX_ON:
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	switch (config->rx_filter) {
+	case HWTSTAMP_FILTER_NONE:
+		pi->rxtstamp = false;
+		break;
+	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
+		cxgb4_ptprx_timestamping(pi, pi->port_id, PTP_TS_L4);
+		break;
+	case HWTSTAMP_FILTER_PTP_V2_EVENT:
+		cxgb4_ptprx_timestamping(pi, pi->port_id, PTP_TS_L2_L4);
+		break;
+	case HWTSTAMP_FILTER_ALL:
+	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
+		pi->rxtstamp = true;
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	if (config->tx_type == HWTSTAMP_TX_OFF &&
+	    config->rx_filter == HWTSTAMP_FILTER_NONE) {
+		if (cxgb4_ptp_txtype(adapter, pi->port_id) >= 0)
+			pi->ptp_enable = false;
+	}
+
+	if (config->rx_filter != HWTSTAMP_FILTER_NONE) {
+		if (cxgb4_ptp_redirect_rx_packet(adapter, pi) >= 0)
+			pi->ptp_enable = true;
+	}
+	pi->tstamp_config = *config;
+	return 0;
+}
+
 static int cxgb_ioctl(struct net_device *dev, struct ifreq *req, int cmd)
 {
 	unsigned int mbox;
 	int ret = 0, prtad, devad;
 	struct port_info *pi = netdev_priv(dev);
-	struct adapter *adapter = pi->adapter;
 	struct mii_ioctl_data *data = (struct mii_ioctl_data *)&req->ifr_data;
 
 	switch (cmd) {
@@ -3076,81 +3151,6 @@ static int cxgb_ioctl(struct net_device *dev, struct ifreq *req, int cmd)
 			ret = t4_mdio_wr(pi->adapter, mbox, prtad, devad,
 					 data->reg_num, data->val_in);
 		break;
-	case SIOCGHWTSTAMP:
-		return copy_to_user(req->ifr_data, &pi->tstamp_config,
-				    sizeof(pi->tstamp_config)) ?
-			-EFAULT : 0;
-	case SIOCSHWTSTAMP:
-		if (copy_from_user(&pi->tstamp_config, req->ifr_data,
-				   sizeof(pi->tstamp_config)))
-			return -EFAULT;
-
-		if (!is_t4(adapter->params.chip)) {
-			switch (pi->tstamp_config.tx_type) {
-			case HWTSTAMP_TX_OFF:
-			case HWTSTAMP_TX_ON:
-				break;
-			default:
-				return -ERANGE;
-			}
-
-			switch (pi->tstamp_config.rx_filter) {
-			case HWTSTAMP_FILTER_NONE:
-				pi->rxtstamp = false;
-				break;
-			case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
-			case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
-				cxgb4_ptprx_timestamping(pi, pi->port_id,
-							 PTP_TS_L4);
-				break;
-			case HWTSTAMP_FILTER_PTP_V2_EVENT:
-				cxgb4_ptprx_timestamping(pi, pi->port_id,
-							 PTP_TS_L2_L4);
-				break;
-			case HWTSTAMP_FILTER_ALL:
-			case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
-			case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
-			case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
-			case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
-				pi->rxtstamp = true;
-				break;
-			default:
-				pi->tstamp_config.rx_filter =
-					HWTSTAMP_FILTER_NONE;
-				return -ERANGE;
-			}
-
-			if ((pi->tstamp_config.tx_type == HWTSTAMP_TX_OFF) &&
-			    (pi->tstamp_config.rx_filter ==
-				HWTSTAMP_FILTER_NONE)) {
-				if (cxgb4_ptp_txtype(adapter, pi->port_id) >= 0)
-					pi->ptp_enable = false;
-			}
-
-			if (pi->tstamp_config.rx_filter !=
-				HWTSTAMP_FILTER_NONE) {
-				if (cxgb4_ptp_redirect_rx_packet(adapter,
-								 pi) >= 0)
-					pi->ptp_enable = true;
-			}
-		} else {
-			/* For T4 Adapters */
-			switch (pi->tstamp_config.rx_filter) {
-			case HWTSTAMP_FILTER_NONE:
-			pi->rxtstamp = false;
-			break;
-			case HWTSTAMP_FILTER_ALL:
-			pi->rxtstamp = true;
-			break;
-			default:
-			pi->tstamp_config.rx_filter =
-			HWTSTAMP_FILTER_NONE;
-			return -ERANGE;
-			}
-		}
-		return copy_to_user(req->ifr_data, &pi->tstamp_config,
-				    sizeof(pi->tstamp_config)) ?
-			-EFAULT : 0;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -3875,6 +3875,8 @@ static const struct net_device_ops cxgb4_netdev_ops = {
 	.ndo_setup_tc         = cxgb_setup_tc,
 	.ndo_features_check   = cxgb_features_check,
 	.ndo_fix_features     = cxgb_fix_features,
+	.ndo_hwtstamp_get     = cxgb_hwtstamp_get,
+	.ndo_hwtstamp_set     = cxgb_hwtstamp_set,
 };
 
 #ifdef CONFIG_PCI_IOV
-- 
2.47.3


