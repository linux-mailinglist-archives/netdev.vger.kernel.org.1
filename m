Return-Path: <netdev+bounces-234537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5592EC22D06
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 01:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC1D93B967F
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 00:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB7B1F1538;
	Fri, 31 Oct 2025 00:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IwCMT4Fn"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96FA1A0BD6
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 00:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761871601; cv=none; b=jFg8UuWXOG1yCRatPo4ntqXMRlZ1KyyPnGpIEb4COIfUtOonNBkH4lcq0vJK7gC8YPlPTJYsOCAFPwbea99LrwM9qs/L6UH1SEzwLBMgZgJ9s6UNhg0FNn2zDS4zO8T6NzsDcaJwco+A16JTfUXAsKSb6mg8gZpYk2Ym8kGKxSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761871601; c=relaxed/simple;
	bh=Kpcp758ztmwT1AWA4mviGzmtKiB5C2k/fWloZ90hG8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fpTRRYXWPDfZuYInzaLuMqLahcZ1vZxRNEDwJk6EXJiXFMJoceDtNHaIxq8bNhaLAT99lorUbyD3DLEfVGoFTL/rNRkalXwgLNdFSEf7GIefrY18OUphnY/9G5p0Fq357BSekTcPSQwsKoG0vJG3hzi2wAEXRHoN/owuCCzK5EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IwCMT4Fn; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761871596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ufcm34/fxLSDGGMNv1fcJ1U8/oL1slrMlaZI5947FEg=;
	b=IwCMT4FnAeqY0Uk8s3RKkBtVNwWX1gZC4etPU9W02DtQgrwnAbAAvUksph4gke9Ijd3HNQ
	OejyiKrF4hygY+ndqA7QB6ITZGD5JWaTA5/lV4QUhmNXNaYT/HZ7d41RDDN5NQIBej26U4
	OmhljL1O0DJWsNLAlGS/vbvce3EBVwI=
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
Subject: [PATCH net-next 5/7] net: thunderx: convert to use ndo_hwtstamp callbacks
Date: Fri, 31 Oct 2025 00:46:05 +0000
Message-ID: <20251031004607.1983544-6-vadim.fedorenko@linux.dev>
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

The driver implemented SIOCSHWTSTAMP ioctl command only, but it also
stores configuration in private data, so it's possible to report it back
to users. Implement both ndo_hwtstamp_set and ndo_hwtstamp_get
callbacks.

Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 .../net/ethernet/cavium/thunder/nicvf_main.c  | 45 ++++++++++---------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index 1be2dc40a1a6..0b6e30a8feb0 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -1899,18 +1899,18 @@ static int nicvf_xdp(struct net_device *netdev, struct netdev_bpf *xdp)
 	}
 }
 
-static int nicvf_config_hwtstamp(struct net_device *netdev, struct ifreq *ifr)
+static int nicvf_hwtstamp_set(struct net_device *netdev,
+			      struct kernel_hwtstamp_config *config,
+			      struct netlink_ext_ack *extack)
 {
-	struct hwtstamp_config config;
 	struct nicvf *nic = netdev_priv(netdev);
 
-	if (!nic->ptp_clock)
+	if (!nic->ptp_clock) {
+		NL_SET_ERR_MSG_MOD(extack, "HW timestamping is not supported");
 		return -ENODEV;
+	}
 
-	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
-		return -EFAULT;
-
-	switch (config.tx_type) {
+	switch (config->tx_type) {
 	case HWTSTAMP_TX_OFF:
 	case HWTSTAMP_TX_ON:
 		break;
@@ -1918,7 +1918,7 @@ static int nicvf_config_hwtstamp(struct net_device *netdev, struct ifreq *ifr)
 		return -ERANGE;
 	}
 
-	switch (config.rx_filter) {
+	switch (config->rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
 		nic->hw_rx_tstamp = false;
 		break;
@@ -1937,7 +1937,7 @@ static int nicvf_config_hwtstamp(struct net_device *netdev, struct ifreq *ifr)
 	case HWTSTAMP_FILTER_PTP_V2_SYNC:
 	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
 		nic->hw_rx_tstamp = true;
-		config.rx_filter = HWTSTAMP_FILTER_ALL;
+		config->rx_filter = HWTSTAMP_FILTER_ALL;
 		break;
 	default:
 		return -ERANGE;
@@ -1946,20 +1946,24 @@ static int nicvf_config_hwtstamp(struct net_device *netdev, struct ifreq *ifr)
 	if (netif_running(netdev))
 		nicvf_config_hw_rx_tstamp(nic, nic->hw_rx_tstamp);
 
-	if (copy_to_user(ifr->ifr_data, &config, sizeof(config)))
-		return -EFAULT;
-
 	return 0;
 }
 
-static int nicvf_ioctl(struct net_device *netdev, struct ifreq *req, int cmd)
+static int nicvf_hwtstamp_get(struct net_device *netdev,
+			      struct kernel_hwtstamp_config *config)
 {
-	switch (cmd) {
-	case SIOCSHWTSTAMP:
-		return nicvf_config_hwtstamp(netdev, req);
-	default:
-		return -EOPNOTSUPP;
-	}
+	struct nicvf *nic = netdev_priv(netdev);
+
+	if (!nic->ptp_clock)
+		return -ENODEV;
+
+	/* TX timestamping is technically always on */
+	config->tx_type = HWTSTAMP_TX_ON;
+	config->rx_filter = nic->hw_rx_tstamp ?
+			    HWTSTAMP_FILTER_ALL :
+			    HWTSTAMP_FILTER_NONE;
+
+	return 0;
 }
 
 static void __nicvf_set_rx_mode_task(u8 mode, struct xcast_addr_list *mc_addrs,
@@ -2081,8 +2085,9 @@ static const struct net_device_ops nicvf_netdev_ops = {
 	.ndo_fix_features       = nicvf_fix_features,
 	.ndo_set_features       = nicvf_set_features,
 	.ndo_bpf		= nicvf_xdp,
-	.ndo_eth_ioctl           = nicvf_ioctl,
 	.ndo_set_rx_mode        = nicvf_set_rx_mode,
+	.ndo_hwtstamp_get	= nicvf_hwtstamp_get,
+	.ndo_hwtstamp_set	= nicvf_hwtstamp_set,
 };
 
 static int nicvf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
-- 
2.47.3


