Return-Path: <netdev+bounces-225692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F1CB9709F
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 19:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2FB019C5F46
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 17:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DED27E05A;
	Tue, 23 Sep 2025 17:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oxEpz6eA"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37138189
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758648813; cv=none; b=owwrToesT0rYMvyCxOed9ndGqLwaF7Ko84i7qEBPa/tmjv7YCXrbvzuGwaoBgKv7tPk8+WL13b9D6S/UGHVCuH3dMfaTjefIk9eMCMLh03QLvy8caIWNltlxGVU/Q2RyGAVznHHryqD2KVqPi2wQC5pF4lcTj33sSF4eTNhsVsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758648813; c=relaxed/simple;
	bh=5EpUoK2cW6ZTDCbBYN8qkw7YIdhLP/ZM955kFiYYclI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r6MBymHx7ybxO57L+ogWGlVfnotb4pEg88EU7/oZTrem7wJpt5o3l19elm6HLAi9KD8bBl9juD9ll8j1vZetQOVnQIWxN9GxR8+vlPV6TjhXa95apM2y0XCBNs0LHiEW6sC/QWJBAL13HjxYFkttr39nBkO5K6z7qS33/mL4/n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oxEpz6eA; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758648808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m/YtGKS3Wcj6BagdtENiruk/hTDVb0LTuBjfrBLIrYw=;
	b=oxEpz6eALq9w7R3DPQB4SxHZZHkpuBNVbFpV6gJspiv6Q3lVQ8NuCFQeqs3gaI9CWu4vBM
	aVV1IAdomb5EkWtd0IO6zwGiC+EaXuTFi+ejc7YM/RQYtsRaQZYmqhkWi7eoIjJtZmnXDh
	gbVY0+bd06LjoW83UPnHN7q7JmoRxpg=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: netdev@vger.kernel.org
Subject: [PATCH net-next v2 1/4] tg3: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
Date: Tue, 23 Sep 2025 17:33:07 +0000
Message-ID: <20250923173310.139623-2-vadim.fedorenko@linux.dev>
In-Reply-To: <20250923173310.139623-1-vadim.fedorenko@linux.dev>
References: <20250923173310.139623-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Convert tg3 driver to new timestamping configuration API.

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/ethernet/broadcom/tg3.c | 66 +++++++++++++----------------
 1 file changed, 29 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index b4dc93a48718..7f00ec7fd7b9 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -13929,22 +13929,20 @@ static void tg3_self_test(struct net_device *dev, struct ethtool_test *etest,
 
 }
 
-static int tg3_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
+static int tg3_hwtstamp_set(struct net_device *dev,
+			    struct kernel_hwtstamp_config *stmpconf,
+			    struct netlink_ext_ack *extack)
 {
 	struct tg3 *tp = netdev_priv(dev);
-	struct hwtstamp_config stmpconf;
 
 	if (!tg3_flag(tp, PTP_CAPABLE))
 		return -EOPNOTSUPP;
 
-	if (copy_from_user(&stmpconf, ifr->ifr_data, sizeof(stmpconf)))
-		return -EFAULT;
-
-	if (stmpconf.tx_type != HWTSTAMP_TX_ON &&
-	    stmpconf.tx_type != HWTSTAMP_TX_OFF)
+	if (stmpconf->tx_type != HWTSTAMP_TX_ON &&
+	    stmpconf->tx_type != HWTSTAMP_TX_OFF)
 		return -ERANGE;
 
-	switch (stmpconf.rx_filter) {
+	switch (stmpconf->rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
 		tp->rxptpctl = 0;
 		break;
@@ -14004,74 +14002,72 @@ static int tg3_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 		tw32(TG3_RX_PTP_CTL,
 		     tp->rxptpctl | TG3_RX_PTP_CTL_HWTS_INTERLOCK);
 
-	if (stmpconf.tx_type == HWTSTAMP_TX_ON)
+	if (stmpconf->tx_type == HWTSTAMP_TX_ON)
 		tg3_flag_set(tp, TX_TSTAMP_EN);
 	else
 		tg3_flag_clear(tp, TX_TSTAMP_EN);
 
-	return copy_to_user(ifr->ifr_data, &stmpconf, sizeof(stmpconf)) ?
-		-EFAULT : 0;
+	return 0;
 }
 
-static int tg3_hwtstamp_get(struct net_device *dev, struct ifreq *ifr)
+static int tg3_hwtstamp_get(struct net_device *dev,
+			    struct kernel_hwtstamp_config *stmpconf)
 {
 	struct tg3 *tp = netdev_priv(dev);
-	struct hwtstamp_config stmpconf;
 
 	if (!tg3_flag(tp, PTP_CAPABLE))
 		return -EOPNOTSUPP;
 
-	stmpconf.flags = 0;
-	stmpconf.tx_type = (tg3_flag(tp, TX_TSTAMP_EN) ?
-			    HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF);
+	stmpconf->flags = 0;
+	stmpconf->tx_type = tg3_flag(tp, TX_TSTAMP_EN) ?
+			    HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
 
 	switch (tp->rxptpctl) {
 	case 0:
-		stmpconf.rx_filter = HWTSTAMP_FILTER_NONE;
+		stmpconf->rx_filter = HWTSTAMP_FILTER_NONE;
 		break;
 	case TG3_RX_PTP_CTL_RX_PTP_V1_EN | TG3_RX_PTP_CTL_ALL_V1_EVENTS:
-		stmpconf.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
+		stmpconf->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
 		break;
 	case TG3_RX_PTP_CTL_RX_PTP_V1_EN | TG3_RX_PTP_CTL_SYNC_EVNT:
-		stmpconf.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_SYNC;
+		stmpconf->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_SYNC;
 		break;
 	case TG3_RX_PTP_CTL_RX_PTP_V1_EN | TG3_RX_PTP_CTL_DELAY_REQ:
-		stmpconf.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ;
+		stmpconf->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ;
 		break;
 	case TG3_RX_PTP_CTL_RX_PTP_V2_EN | TG3_RX_PTP_CTL_ALL_V2_EVENTS:
-		stmpconf.rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
+		stmpconf->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
 		break;
 	case TG3_RX_PTP_CTL_RX_PTP_V2_L2_EN | TG3_RX_PTP_CTL_ALL_V2_EVENTS:
-		stmpconf.rx_filter = HWTSTAMP_FILTER_PTP_V2_L2_EVENT;
+		stmpconf->rx_filter = HWTSTAMP_FILTER_PTP_V2_L2_EVENT;
 		break;
 	case TG3_RX_PTP_CTL_RX_PTP_V2_L4_EN | TG3_RX_PTP_CTL_ALL_V2_EVENTS:
-		stmpconf.rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_EVENT;
+		stmpconf->rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_EVENT;
 		break;
 	case TG3_RX_PTP_CTL_RX_PTP_V2_EN | TG3_RX_PTP_CTL_SYNC_EVNT:
-		stmpconf.rx_filter = HWTSTAMP_FILTER_PTP_V2_SYNC;
+		stmpconf->rx_filter = HWTSTAMP_FILTER_PTP_V2_SYNC;
 		break;
 	case TG3_RX_PTP_CTL_RX_PTP_V2_L2_EN | TG3_RX_PTP_CTL_SYNC_EVNT:
-		stmpconf.rx_filter = HWTSTAMP_FILTER_PTP_V2_L2_SYNC;
+		stmpconf->rx_filter = HWTSTAMP_FILTER_PTP_V2_L2_SYNC;
 		break;
 	case TG3_RX_PTP_CTL_RX_PTP_V2_L4_EN | TG3_RX_PTP_CTL_SYNC_EVNT:
-		stmpconf.rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_SYNC;
+		stmpconf->rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_SYNC;
 		break;
 	case TG3_RX_PTP_CTL_RX_PTP_V2_EN | TG3_RX_PTP_CTL_DELAY_REQ:
-		stmpconf.rx_filter = HWTSTAMP_FILTER_PTP_V2_DELAY_REQ;
+		stmpconf->rx_filter = HWTSTAMP_FILTER_PTP_V2_DELAY_REQ;
 		break;
 	case TG3_RX_PTP_CTL_RX_PTP_V2_L2_EN | TG3_RX_PTP_CTL_DELAY_REQ:
-		stmpconf.rx_filter = HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ;
+		stmpconf->rx_filter = HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ;
 		break;
 	case TG3_RX_PTP_CTL_RX_PTP_V2_L4_EN | TG3_RX_PTP_CTL_DELAY_REQ:
-		stmpconf.rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ;
+		stmpconf->rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ;
 		break;
 	default:
 		WARN_ON_ONCE(1);
 		return -ERANGE;
 	}
 
-	return copy_to_user(ifr->ifr_data, &stmpconf, sizeof(stmpconf)) ?
-		-EFAULT : 0;
+	return 0;
 }
 
 static int tg3_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
@@ -14126,12 +14122,6 @@ static int tg3_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 
 		return err;
 
-	case SIOCSHWTSTAMP:
-		return tg3_hwtstamp_set(dev, ifr);
-
-	case SIOCGHWTSTAMP:
-		return tg3_hwtstamp_get(dev, ifr);
-
 	default:
 		/* do nothing */
 		break;
@@ -14407,6 +14397,8 @@ static const struct net_device_ops tg3_netdev_ops = {
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	.ndo_poll_controller	= tg3_poll_controller,
 #endif
+	.ndo_hwtstamp_get	= tg3_hwtstamp_get,
+	.ndo_hwtstamp_set	= tg3_hwtstamp_set,
 };
 
 static void tg3_get_eeprom_size(struct tg3 *tp)
-- 
2.47.3


