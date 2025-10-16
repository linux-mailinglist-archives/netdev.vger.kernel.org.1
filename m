Return-Path: <netdev+bounces-230119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CF3BE4381
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 17:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FF87421A33
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 15:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CAC34AB09;
	Thu, 16 Oct 2025 15:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U/DCXHsB"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CA5346A06
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 15:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628428; cv=none; b=EWN2VBxt8FIvtKIcnHPYWd499WlqBSYUwSovQgfHU8NiAUM4yP+/N5wKJywrzlJ97+rmYK7liZTIHAqn2VVBCqB3qYV6gwyc6QfuJ1XVoLVFz5J9myKpUkhTLlLj7YgHl02a8fygom51pVfAz8S55R1oUGU+cNt0Ji15RsOjASU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628428; c=relaxed/simple;
	bh=nU+1AdiWD+lp88coYlypaw2xsWTfqiTrS+zoU8nT40k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LpCLDR9/HDEWAqqIGm4J8cgGqB/vXn49KBXYqGt1JWBkaHHnT2IiKQzXU5nMBbs+j52ARXUOiwNE7Q+ePRBpQsigeli+7sP7mXSrcs9KdEpuYZb3KgOQkH83HL7UKHaRvmKbvxe+VqVYcPzJwqVdWHJLNHgOnEdxwv3GGpZwMB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U/DCXHsB; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760628424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EdTPYbXwDfJU9vRUxXz3+0YIH5ybEPVQauVkggBtiWY=;
	b=U/DCXHsBcsfJpgUYUN7kEVhLEhUpAtB5UmzBLdG6WrZEf6W9j4B2+DP7jp+vrBL+iu+rax
	MyllAzfLO9mTuMGwXv3TrMQja9f41/3Unku7OrgR2JeD7TDNngM4eGjRQhwNzOrAiYUzqC
	MVxLpVw7SWPvHCrYaJFrVMAUFofmc6A=
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
Subject: [PATCH net-next v3 3/7] amd-xgbe: convert to ndo_hwtstamp callbacks
Date: Thu, 16 Oct 2025 15:25:11 +0000
Message-ID: <20251016152515.3510991-4-vadim.fedorenko@linux.dev>
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

Convert driver to use .ndo_hwtstamp_get()/.ndo_hwtstamp_set() callbacks.
.ndo_eth_ioctl() becomes empty function, remove it.

Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
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


