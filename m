Return-Path: <netdev+bounces-238494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6A3C59B78
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 20:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 430954F30DD
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 19:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5486631B80A;
	Thu, 13 Nov 2025 19:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NH1A7Ozc"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B36F3101A8
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 19:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763061241; cv=none; b=EFl/FicSsmzBP1FfjsJsN3LPJjGKeHYov+DcXrmQ9qpFi/eiWgmsr25RfHSR5EnH1fgLAWvxt2dTPCA642m9fgbGidqS3ycrSMOsUkhulnyGg6q24iGtRK2sKauvHRZTlOKACsiYYJPeTSCW5JuI7Yyzi5/DN6dk+rYVIesnse4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763061241; c=relaxed/simple;
	bh=irLro1MM0H2vZnA/+W2mEBSo/830TmlP1v/0gFfOXAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n33bpLt7Smje09bQp/UIFO9l7fH5l+vDZTO9xcC49+R92km0cXfVdmfQKx+d960Rc4aqXloazI71tr1Rm+Kylk9z+6yPfQLhUKV/pwpYsw8rs3UT6y6rMtlbOnMjSf5h3HtupUnqZxxqj89R/YF/ZEca2xWPne0aiz3eWYrjCas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NH1A7Ozc; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763061237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X1B4lfiK2GmjWUyBV1QWkNatF02PMkYbO/NkjrjXsKU=;
	b=NH1A7Ozc5NtLLLm2a2Y8TLBb3teEzibjQlzKkPy+cNk4bbEfkPqWeI5hp+q9380oqiNkxx
	adzGzZPn1ZEPIxFSFDYrKJiV3Xi5eKMJdlXm+bnfJFJR/yw/SphsIN6n+VJjR1Fl4+zfJy
	hWjfOp4Nf8LQpKyTSLpsYI7hxdIyVgI=
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
Subject: [PATCH net-next v4 2/2] qede: convert to use ndo_hwtstamp callbacks
Date: Thu, 13 Nov 2025 19:13:25 +0000
Message-ID: <20251113191325.3929680-3-vadim.fedorenko@linux.dev>
In-Reply-To: <20251113191325.3929680-1-vadim.fedorenko@linux.dev>
References: <20251113191325.3929680-1-vadim.fedorenko@linux.dev>
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
 drivers/net/ethernet/qlogic/qede/qede_main.c | 22 +-----
 drivers/net/ethernet/qlogic/qede/qede_ptp.c  | 76 ++++++++++++--------
 drivers/net/ethernet/qlogic/qede/qede_ptp.h  |  6 +-
 3 files changed, 54 insertions(+), 50 deletions(-)

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
index a38f1e72c62b..702f0281663a 100644
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
@@ -286,39 +278,65 @@ static int qede_ptp_cfg_filters(struct qede_dev *edev)
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
-	int rc;
+
+	if (!netif_running(netdev)) {
+		NL_SET_ERR_MSG_MOD(extack, "Device is not running");
+		return -EAGAIN;
+	}
 
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
+	case HWTSTAMP_TX_ON:
+	case HWTSTAMP_TX_OFF:
+		break;
+	default:
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
+
+	config->rx_filter = ptp->rx_filter;
+
+	return 0;
+}
 
-	config.rx_filter = ptp->rx_filter;
+int qede_hwtstamp_get(struct net_device *netdev,
+		      struct kernel_hwtstamp_config *config)
+{
+	struct qede_dev *edev = netdev_priv(netdev);
+	struct qede_ptp *ptp;
 
-	return copy_to_user(ifr->ifr_data, &config,
-			    sizeof(config)) ? -EFAULT : 0;
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


