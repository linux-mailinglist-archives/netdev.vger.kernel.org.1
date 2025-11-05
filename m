Return-Path: <netdev+bounces-235955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DE3C37664
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 19:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AA31188DE57
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 18:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BAF33FE24;
	Wed,  5 Nov 2025 18:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xB12u2go"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ABB33EB0D
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 18:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762368725; cv=none; b=phMKDmn3IUnXEEs7fWWNi7k2TYKtiKscr4zzRkrVLLJyTiiHHgqHO54djgA2oQ2UYH1Bfn5yv8xjEDzm1yghUsT1Sdxykmv5zOFX7Wq5wtK3/XrFW3M4sul8SYRC4JvliQ1ZhbI1Ly4OKwb+FTlI8FZkYIA91whn5uKumc28sbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762368725; c=relaxed/simple;
	bh=mEMqQ6nrpYZ8xYw19jtIwvbekPd7TT4N82UF6KYCYlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXm7q0uHH+Du7hKVH5+hVu19LRN/VzwdTFeQ5eRlE43/T5PuvaxKDUr8TyfwXnX4IYiLApemQbKn10Ru5t3NeMb/d/UKLuMu6fBM8WXIp9CS707VCLQJjgA0QyJjaWRvka3QilIo8gKMcfThXs+YnwlGiiXjQC/i/07tNAx8wI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xB12u2go; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762368719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rVP2l5u/BqGX4JSls2a/lX4LUXbM/CGG1cBXCO4426E=;
	b=xB12u2go5+jBU8D/qb3GP6Oms+nPOXiUYfGiA1cZrf1tRCk7bsqwwgTQmjfUDgTabfO1IU
	kmlfoznNqqnNAnSbzHK4l8eewd86tD54ACvkxT6rdva43iMUQOWtOoySDPdICQdq1JsDHF
	PkmyzfxoP/217bqxvwLxr5vUoUCDQFo=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Manish Chopra <manishc@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 2/2] qede: convert to use ndo_hwtstamp callbacks
Date: Wed,  5 Nov 2025 18:51:33 +0000
Message-ID: <20251105185133.3542054-3-vadim.fedorenko@linux.dev>
In-Reply-To: <20251105185133.3542054-1-vadim.fedorenko@linux.dev>
References: <20251105185133.3542054-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The driver implemented SIOCSHWTSTAMP ioctl cmd only, but it stores
configuration in private structure, so it can be reported back to users.
Implement both ndo_hwtstamp_set and ndo_hwtstamp_set callbacks.
ndo_hwtstamp_set implements a check of unsupported 1-step timestamping
and qede_ptp_cfg_filters() becomes void as it cannot fail anymore.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/ethernet/qlogic/qede/qede_main.c | 22 +------
 drivers/net/ethernet/qlogic/qede/qede_ptp.c  | 68 ++++++++++++--------
 drivers/net/ethernet/qlogic/qede/qede_ptp.h  |  6 +-
 3 files changed, 47 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c b/drivers/net/ethernet/qlogic/qede/qede_main.c
index b5d744d2586f..66ab1b9d65a1 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_main.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
@@ -506,25 +506,6 @@ static int qede_set_vf_trust(struct net_device *dev, int vfidx, bool setting)
 }
 #endif
 
-static int qede_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
-{
-	struct qede_dev *edev = netdev_priv(dev);
-
-	if (!netif_running(dev))
-		return -EAGAIN;
-
-	switch (cmd) {
-	case SIOCSHWTSTAMP:
-		return qede_ptp_hw_ts(edev, ifr);
-	default:
-		DP_VERBOSE(edev, QED_MSG_DEBUG,
-			   "default IOCTL cmd 0x%x\n", cmd);
-		return -EOPNOTSUPP;
-	}
-
-	return 0;
-}
-
 static void qede_fp_sb_dump(struct qede_dev *edev, struct qede_fastpath *fp)
 {
 	char *p_sb = (char *)fp->sb_info->sb_virt;
@@ -717,7 +698,6 @@ static const struct net_device_ops qede_netdev_ops = {
 	.ndo_set_mac_address	= qede_set_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_change_mtu		= qede_change_mtu,
-	.ndo_eth_ioctl		= qede_ioctl,
 	.ndo_tx_timeout		= qede_tx_timeout,
 #ifdef CONFIG_QED_SRIOV
 	.ndo_set_vf_mac		= qede_set_vf_mac,
@@ -742,6 +722,8 @@ static const struct net_device_ops qede_netdev_ops = {
 #endif
 	.ndo_xdp_xmit		= qede_xdp_transmit,
 	.ndo_setup_tc		= qede_setup_tc_offload,
+	.ndo_hwtstamp_get	= qede_hwtstamp_get,
+	.ndo_hwtstamp_set	= qede_hwtstamp_set,
 };
 
 static const struct net_device_ops qede_netdev_vf_ops = {
diff --git a/drivers/net/ethernet/qlogic/qede/qede_ptp.c b/drivers/net/ethernet/qlogic/qede/qede_ptp.c
index a38f1e72c62b..28e059080cea 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_ptp.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_ptp.c
@@ -199,18 +199,15 @@ static u64 qede_ptp_read_cc(struct cyclecounter *cc)
 	return phc_cycles;
 }
 
-static int qede_ptp_cfg_filters(struct qede_dev *edev)
+static void qede_ptp_cfg_filters(struct qede_dev *edev)
 {
 	enum qed_ptp_hwtstamp_tx_type tx_type = QED_PTP_HWTSTAMP_TX_ON;
 	enum qed_ptp_filter_type rx_filter = QED_PTP_FILTER_NONE;
 	struct qede_ptp *ptp = edev->ptp;
 
-	if (!ptp)
-		return -EIO;
-
 	if (!ptp->hw_ts_ioctl_called) {
 		DP_INFO(edev, "TS IOCTL not called\n");
-		return 0;
+		return;
 	}
 
 	switch (ptp->tx_type) {
@@ -223,11 +220,6 @@ static int qede_ptp_cfg_filters(struct qede_dev *edev)
 		clear_bit(QEDE_FLAGS_TX_TIMESTAMPING_EN, &edev->flags);
 		tx_type = QED_PTP_HWTSTAMP_TX_OFF;
 		break;
-
-	case HWTSTAMP_TX_ONESTEP_SYNC:
-	case HWTSTAMP_TX_ONESTEP_P2P:
-		DP_ERR(edev, "One-step timestamping is not supported\n");
-		return -ERANGE;
 	}
 
 	spin_lock_bh(&ptp->lock);
@@ -286,39 +278,59 @@ static int qede_ptp_cfg_filters(struct qede_dev *edev)
 	ptp->ops->cfg_filters(edev->cdev, rx_filter, tx_type);
 
 	spin_unlock_bh(&ptp->lock);
-
-	return 0;
 }
 
-int qede_ptp_hw_ts(struct qede_dev *edev, struct ifreq *ifr)
+int qede_hwtstamp_set(struct net_device *netdev,
+		      struct kernel_hwtstamp_config *config,
+		      struct netlink_ext_ack *extack)
 {
-	struct hwtstamp_config config;
+	struct qede_dev *edev = netdev_priv(netdev);
 	struct qede_ptp *ptp;
 	int rc;
 
 	ptp = edev->ptp;
-	if (!ptp)
+	if (!ptp) {
+		NL_SET_ERR_MSG_MOD(extack, "HW timestamping is not supported");
 		return -EIO;
-
-	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
-		return -EFAULT;
+	}
 
 	DP_VERBOSE(edev, QED_MSG_DEBUG,
-		   "HWTSTAMP IOCTL: Requested tx_type = %d, requested rx_filters = %d\n",
-		   config.tx_type, config.rx_filter);
+		   "HWTSTAMP SET: Requested tx_type = %d, requested rx_filters = %d\n",
+		   config->tx_type, config->rx_filter);
+
+	switch (config->tx_type) {
+	case HWTSTAMP_TX_ONESTEP_SYNC:
+	case HWTSTAMP_TX_ONESTEP_P2P:
+		NL_SET_ERR_MSG_MOD(extack,
+				   "One-step timestamping is not supported");
+		return -ERANGE;
+	}
 
 	ptp->hw_ts_ioctl_called = 1;
-	ptp->tx_type = config.tx_type;
-	ptp->rx_filter = config.rx_filter;
+	ptp->tx_type = config->tx_type;
+	ptp->rx_filter = config->rx_filter;
 
-	rc = qede_ptp_cfg_filters(edev);
-	if (rc)
-		return rc;
+	qede_ptp_cfg_filters(edev);
 
-	config.rx_filter = ptp->rx_filter;
+	config->rx_filter = ptp->rx_filter;
 
-	return copy_to_user(ifr->ifr_data, &config,
-			    sizeof(config)) ? -EFAULT : 0;
+	return 0;
+}
+
+int qede_hwtstamp_get(struct net_device *netdev,
+		      struct kernel_hwtstamp_config *config)
+{
+	struct qede_dev *edev = netdev_priv(netdev);
+	struct qede_ptp *ptp;
+
+	ptp = edev->ptp;
+	if (!ptp)
+		return -EIO;
+
+	config->tx_type = ptp->tx_type;
+	config->rx_filter = ptp->rx_filter;
+
+	return 0;
 }
 
 int qede_ptp_get_ts_info(struct qede_dev *edev, struct kernel_ethtool_ts_info *info)
diff --git a/drivers/net/ethernet/qlogic/qede/qede_ptp.h b/drivers/net/ethernet/qlogic/qede/qede_ptp.h
index adafc894797e..88f168395812 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_ptp.h
+++ b/drivers/net/ethernet/qlogic/qede/qede_ptp.h
@@ -14,7 +14,11 @@
 
 void qede_ptp_rx_ts(struct qede_dev *edev, struct sk_buff *skb);
 void qede_ptp_tx_ts(struct qede_dev *edev, struct sk_buff *skb);
-int qede_ptp_hw_ts(struct qede_dev *edev, struct ifreq *req);
+int qede_hwtstamp_get(struct net_device *netdev,
+		      struct kernel_hwtstamp_config *config);
+int qede_hwtstamp_set(struct net_device *netdev,
+		      struct kernel_hwtstamp_config *config,
+		      struct netlink_ext_ack *extack);
 void qede_ptp_disable(struct qede_dev *edev);
 int qede_ptp_enable(struct qede_dev *edev);
 int qede_ptp_get_ts_info(struct qede_dev *edev, struct kernel_ethtool_ts_info *ts);
-- 
2.47.3


