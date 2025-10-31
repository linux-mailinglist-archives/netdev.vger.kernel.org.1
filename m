Return-Path: <netdev+bounces-234539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5DDC22D15
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 01:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 453A53A3D0A
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 00:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCBC20B21E;
	Fri, 31 Oct 2025 00:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tIIe5nHJ"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8A220298D
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 00:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761871605; cv=none; b=kDSARDwktA6DzRMAlf0YtbA4hACY/mKxttdFojAs7FBmmaPRLRfAEqNkt3NSVgPsFXudYAKoa0vxaHzHJwbCcD2KWC/613BFL7zhg3SFH13PP+dbQvr1Cs+a1JP3f07uTN773tIuBV5odaxEtz8AvfR8JAOItIB8qJW+JSmd7KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761871605; c=relaxed/simple;
	bh=MnHENfCqBkIXEgM7bxiJqSebg+JV+ktBiW27IUOQunQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mk+zAyfqwJsHaUSB0wACpbLCTtpOP8UrQdZR+iYRUGY1wt8sIV7Pe21P6d/IdmWCPY9lmLJ/zmJrxDmf9rDUR7Qt83sLCjm4S4gz/rv3qvukf8yNp8L9XJwyxQKgywHzT2vqsgsKQ1NQU8MHAFiY9ff3WIfgnpw8YCAWpKSxAt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tIIe5nHJ; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761871600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wbOBQC6OXsC8yYQ/n7plcezWGQeLGRAvgXU0EFFJFf8=;
	b=tIIe5nHJ7QQCkTilXLcnxjLlN6tJEaLaFgvVXlppO9Ixa9Zzc1FJ1rwhZ1VMnx5v3xMqSc
	4q/uU/D9t0sgtk562Xf2tzeDYoNN16JG0nQc8Gf/52bSiwYDD6GQk4eqewR6UVyZZbLoOq
	lFvsH5vO0TwxdjnJQHG1aSy1DQWeaqU=
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
Subject: [PATCH net-next 7/7] qede: convert to use ndo_hwtstamp callbacks
Date: Fri, 31 Oct 2025 00:46:07 +0000
Message-ID: <20251031004607.1983544-8-vadim.fedorenko@linux.dev>
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

The driver implemented SIOCSHWTSTAMP ioctl cmd only, but it stores
configuration in private structure, so it can be reported back to users.
Implement both ndo_hwtstamp_set and ndo_hwtstamp_set callbacks.

Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/ethernet/qlogic/qede/qede_main.c | 22 +--------
 drivers/net/ethernet/qlogic/qede/qede_ptp.c  | 47 ++++++++++++++------
 drivers/net/ethernet/qlogic/qede/qede_ptp.h  |  6 ++-
 3 files changed, 40 insertions(+), 35 deletions(-)

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
index a38f1e72c62b..b65e9f46ac52 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_ptp.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_ptp.c
@@ -290,35 +290,54 @@ static int qede_ptp_cfg_filters(struct qede_dev *edev)
 	return 0;
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
 
 	ptp->hw_ts_ioctl_called = 1;
-	ptp->tx_type = config.tx_type;
-	ptp->rx_filter = config.rx_filter;
+	ptp->tx_type = config->tx_type;
+	ptp->rx_filter = config->rx_filter;
 
 	rc = qede_ptp_cfg_filters(edev);
-	if (rc)
+	if (rc) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "One-step timestamping is not supported");
 		return rc;
+	}
+
+	config->rx_filter = ptp->rx_filter;
 
-	config.rx_filter = ptp->rx_filter;
+	return 0;
+}
 
-	return copy_to_user(ifr->ifr_data, &config,
-			    sizeof(config)) ? -EFAULT : 0;
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


