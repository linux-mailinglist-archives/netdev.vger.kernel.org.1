Return-Path: <netdev+bounces-225332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1898B92543
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 19:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51EC3178664
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 17:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2616831282B;
	Mon, 22 Sep 2025 17:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W5FngfM5"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6EF3128A2
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758560425; cv=none; b=HI34KQNIpzoChlvEXaJVyaybE9BGGe6wiPlEbqzqJsWmchxe6UAOVwXmnMnLmykwkfTnvriSD2z4IPqSffk4MZPb0ElZclBcG1YA04Rpjijj5rVHB05Q88t0lcQFkjhLFDXAzvnInFnYga/+trKjfetUER4wpqVb1zA+BfgCvwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758560425; c=relaxed/simple;
	bh=+rJFPdo1MdlTRw9rEs9nyWIZgg/G6JKdVlgzwXu53mE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OURQ5ABU8a0dspB7k70TaNROeb/e09xCnla9VMmjpCH3gkC1vACFpN6eRT3pUvPj/e4aPgBVzLjpkuekVoNDGjYaAbfYsQ5QB6ocv6jVitAR1d2rVSXlXi+tL74+cx50DnV6yeDIkqs1jVujYMsyqNwh5sVQvqD2GhiYT3Gd6uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W5FngfM5; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758560420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jr0joCwNNGHMlc+guTbcoFGAI7/Afif8Mcim7sIGiLQ=;
	b=W5FngfM5qECkluQhbOxPy8dkQQxffQBid7tovPBOz5U4YQXtbbcjVXTsU29ssO5n0UETSs
	xFuHdSvkAAJ96TXF0K8kDfxXwbGyBiFdn1tKcbYCIkedEOdyqgDJBmfg9vUa2OXlJ8Ud0N
	uNqerinDL9LZi/NE7jznSPNft+GPn5Q=
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
Subject: [PATCH net-next 1/4] tg3: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
Date: Mon, 22 Sep 2025 16:51:15 +0000
Message-ID: <20250922165118.10057-2-vadim.fedorenko@linux.dev>
In-Reply-To: <20250922165118.10057-1-vadim.fedorenko@linux.dev>
References: <20250922165118.10057-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Convert tg3 driver to new timestamping configuration API.

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


