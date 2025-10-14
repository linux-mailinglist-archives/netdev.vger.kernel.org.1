Return-Path: <netdev+bounces-229401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BE6BDBB26
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 00:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 986663E5FD2
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 22:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C741C30DECB;
	Tue, 14 Oct 2025 22:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eOoYIGX9"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9507A30CDB8
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 22:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760481885; cv=none; b=ugZcF+u1qibn+Y7UL4q9tjh/gEnn+ryeEPCArenD9tNgbOwRQsFEFb0aKEl34EV7WPLyjQ3gjN0FrMhKfUzvIIX01eeHomLEHObzovoAJBXoGMfxarzzzlLhlSTqEZJI8pdaVWiqZfmvOJjjT3yP7DSVULV5ylSBSU4cu9wCKOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760481885; c=relaxed/simple;
	bh=kPFWeIVJHmjgwbCS3W1rTJ0fWkunYSUIc/xBpAfeCHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVcSBwWBy9qMBn62ORh2mRbevsarD4vBWE706k9buvP3e3wcqjs6cl6af5VaImGmHkWoLpiIfFgLPHzCaDRxKbF2Wr9OKKz51z689g+bZo7I8Y1bOzSu2Uk893HLn2JPyKWr9F5WhWarxi1j1y03UHUdrnG3j0Q7Iagco7h223U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eOoYIGX9; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760481881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nMFHKI6GQ8Thw8jdx3XowrWr2CenLBelY55MpRZyuzg=;
	b=eOoYIGX9m/jvCGeESV+FHE01N+yYb9ZXet1WCp4d5lXHs+0r6c7QNwvtOgB83PgtKVZ5SS
	Y9HaxHMa8JXEtFXbbI8v+SjC4Skb51RMWb8x5q/6d3SQYcgD2NX6/5REpcF3s0wa0uy0Zk
	9VKwSnk8L1HZkSsY+dQo2ys3Dae4fSQ=
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
Subject: [PATCH net-next v2 3/7] amd-xgbe: convert to ndo_hwtstamp callbacks
Date: Tue, 14 Oct 2025 22:42:12 +0000
Message-ID: <20251014224216.8163-4-vadim.fedorenko@linux.dev>
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

Convert driver to use .ndo_hwtstamp_get()/.ndo_hwtstamp_set() callbacks.
.ndo_eth_ioctl() becomes empty function, remove it.

Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c      | 24 ++--------------
 drivers/net/ethernet/amd/xgbe/xgbe-hwtstamp.c | 28 +++++++++----------
 drivers/net/ethernet/amd/xgbe/xgbe.h          | 11 ++++----
 3 files changed, 21 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index f0989aa01855..16160e19e07a 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -1755,27 +1755,6 @@ static int xgbe_set_mac_address(struct net_device *netdev, void *addr)
 	return 0;
 }
 
-static int xgbe_ioctl(struct net_device *netdev, struct ifreq *ifreq, int cmd)
-{
-	struct xgbe_prv_data *pdata = netdev_priv(netdev);
-	int ret;
-
-	switch (cmd) {
-	case SIOCGHWTSTAMP:
-		ret = xgbe_get_hwtstamp_settings(pdata, ifreq);
-		break;
-
-	case SIOCSHWTSTAMP:
-		ret = xgbe_set_hwtstamp_settings(pdata, ifreq);
-		break;
-
-	default:
-		ret = -EOPNOTSUPP;
-	}
-
-	return ret;
-}
-
 static int xgbe_change_mtu(struct net_device *netdev, int mtu)
 {
 	struct xgbe_prv_data *pdata = netdev_priv(netdev);
@@ -2021,7 +2000,6 @@ static const struct net_device_ops xgbe_netdev_ops = {
 	.ndo_set_rx_mode	= xgbe_set_rx_mode,
 	.ndo_set_mac_address	= xgbe_set_mac_address,
 	.ndo_validate_addr	= eth_validate_addr,
-	.ndo_eth_ioctl		= xgbe_ioctl,
 	.ndo_change_mtu		= xgbe_change_mtu,
 	.ndo_tx_timeout		= xgbe_tx_timeout,
 	.ndo_get_stats64	= xgbe_get_stats64,
@@ -2034,6 +2012,8 @@ static const struct net_device_ops xgbe_netdev_ops = {
 	.ndo_fix_features	= xgbe_fix_features,
 	.ndo_set_features	= xgbe_set_features,
 	.ndo_features_check	= xgbe_features_check,
+	.ndo_hwtstamp_get	= xgbe_get_hwtstamp_settings,
+	.ndo_hwtstamp_set	= xgbe_set_hwtstamp_settings,
 };
 
 const struct net_device_ops *xgbe_get_netdev_ops(void)
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-hwtstamp.c b/drivers/net/ethernet/amd/xgbe/xgbe-hwtstamp.c
index bc52e5ec6420..0127988e10be 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-hwtstamp.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-hwtstamp.c
@@ -157,26 +157,24 @@ void xgbe_tx_tstamp(struct work_struct *work)
 	spin_unlock_irqrestore(&pdata->tstamp_lock, flags);
 }
 
-int xgbe_get_hwtstamp_settings(struct xgbe_prv_data *pdata, struct ifreq *ifreq)
+int xgbe_get_hwtstamp_settings(struct net_device *netdev,
+			       struct kernel_hwtstamp_config *config)
 {
-	if (copy_to_user(ifreq->ifr_data, &pdata->tstamp_config,
-			 sizeof(pdata->tstamp_config)))
-		return -EFAULT;
+	struct xgbe_prv_data *pdata = netdev_priv(netdev);
+
+	*config = pdata->tstamp_config;
 
 	return 0;
 }
 
-int xgbe_set_hwtstamp_settings(struct xgbe_prv_data *pdata, struct ifreq *ifreq)
+int xgbe_set_hwtstamp_settings(struct net_device *netdev,
+			       struct kernel_hwtstamp_config *config,
+			       struct netlink_ext_ack *extack)
 {
-	struct hwtstamp_config config;
-	unsigned int mac_tscr;
-
-	if (copy_from_user(&config, ifreq->ifr_data, sizeof(config)))
-		return -EFAULT;
-
-	mac_tscr = 0;
+	struct xgbe_prv_data *pdata = netdev_priv(netdev);
+	unsigned int mac_tscr = 0;
 
-	switch (config.tx_type) {
+	switch (config->tx_type) {
 	case HWTSTAMP_TX_OFF:
 		break;
 
@@ -188,7 +186,7 @@ int xgbe_set_hwtstamp_settings(struct xgbe_prv_data *pdata, struct ifreq *ifreq)
 		return -ERANGE;
 	}
 
-	switch (config.rx_filter) {
+	switch (config->rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
 		break;
 
@@ -290,7 +288,7 @@ int xgbe_set_hwtstamp_settings(struct xgbe_prv_data *pdata, struct ifreq *ifreq)
 
 	xgbe_config_tstamp(pdata, mac_tscr);
 
-	memcpy(&pdata->tstamp_config, &config, sizeof(config));
+	pdata->tstamp_config = *config;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index e8bbb6805901..381f72a33d1a 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -1146,7 +1146,7 @@ struct xgbe_prv_data {
 	spinlock_t tstamp_lock;
 	struct ptp_clock_info ptp_clock_info;
 	struct ptp_clock *ptp_clock;
-	struct hwtstamp_config tstamp_config;
+	struct kernel_hwtstamp_config tstamp_config;
 	unsigned int tstamp_addend;
 	struct work_struct tx_tstamp_work;
 	struct sk_buff *tx_tstamp_skb;
@@ -1307,10 +1307,11 @@ void xgbe_update_tstamp_addend(struct xgbe_prv_data *pdata,
 void xgbe_set_tstamp_time(struct xgbe_prv_data *pdata, unsigned int sec,
 			  unsigned int nsec);
 void xgbe_tx_tstamp(struct work_struct *work);
-int xgbe_get_hwtstamp_settings(struct xgbe_prv_data *pdata,
-			       struct ifreq *ifreq);
-int xgbe_set_hwtstamp_settings(struct xgbe_prv_data *pdata,
-			       struct ifreq *ifreq);
+int xgbe_get_hwtstamp_settings(struct net_device *netdev,
+			       struct kernel_hwtstamp_config *config);
+int xgbe_set_hwtstamp_settings(struct net_device *netdev,
+			       struct kernel_hwtstamp_config *config,
+			       struct netlink_ext_ack *extack);
 void xgbe_prep_tx_tstamp(struct xgbe_prv_data *pdata,
 			 struct sk_buff *skb,
 			 struct xgbe_packet_data *packet);
-- 
2.47.3


