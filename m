Return-Path: <netdev+bounces-225333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96680B92546
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 19:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A32D3AD47A
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 17:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56493128CD;
	Mon, 22 Sep 2025 17:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FnqiU751"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840AB2EAB61
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 17:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758560425; cv=none; b=u/TJ3c/nE4Kj2Vv2CIXlT1Q9hZA+uUZlJlNDdc/LedLFLdRnIZbaLSQlPYf4Z9gV4+aCkoxlAGXSh8zwuFYlfvbt4mQ50NAIW8ZM+Rjt/0fUeCAPber2i75LRz2ws2bcE8SKgmyRjDdOFjtY/s8al318K8qMqX+GKWPTS/wVpsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758560425; c=relaxed/simple;
	bh=HUknuTP+3j6KJbHvUtuiTnVu8M0xW5jEM+pCL00sv7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pYx02+o8l4ozINdIDS+HmRI/WD8hyB4xvT6SnYwm++c3uHrsTIY2fdpiOgxB7M96D6JSiDMsMLwto/TQ+QeBgW7OMZLcl28KnM4MP+Em1VQU3TBay0Y0kSupz1HyFq3sIUQVSpaxwGjOdSE0yQIcHQZyjPAVbITRosOKJ8SZV7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FnqiU751; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758560421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bqM8wHzKHioaArKIcrimetAoawZJxBfS5kfNORyFNZs=;
	b=FnqiU751BPmzRSHkPh5S+Ys0i2VdKhNnlogp040yyLJMQWuhZqzmzvYM2+7iAV3Fnd7CVk
	Ar2qyyt5x0L5k2gBbJQML4BF0q/3WhgvFgyJSULC39D6C6Uvd/YT1np8JprUsLNdHi6kNM
	b/FX8sibNEZsOU6vAtxPjobTQOLy3+o=
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
Subject: [PATCH net-next 2/4] bnxt_en: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
Date: Mon, 22 Sep 2025 16:51:16 +0000
Message-ID: <20250922165118.10057-3-vadim.fedorenko@linux.dev>
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

Convert bnxt dirver to use new timestamping configuration API.

Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  8 ++---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 35 +++++++++----------
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h |  7 ++--
 3 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d59612d1e176..1d0e0e7362bd 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -13278,12 +13278,6 @@ static int bnxt_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 		return bnxt_hwrm_port_phy_write(bp, mdio->phy_id, mdio->reg_num,
 						mdio->val_in);
 
-	case SIOCSHWTSTAMP:
-		return bnxt_hwtstamp_set(dev, ifr);
-
-	case SIOCGHWTSTAMP:
-		return bnxt_hwtstamp_get(dev, ifr);
-
 	default:
 		/* do nothing */
 		break;
@@ -15806,6 +15800,8 @@ static const struct net_device_ops bnxt_netdev_ops = {
 	.ndo_xdp_xmit		= bnxt_xdp_xmit,
 	.ndo_bridge_getlink	= bnxt_bridge_getlink,
 	.ndo_bridge_setlink	= bnxt_bridge_setlink,
+	.ndo_hwtstamp_get	= bnxt_hwtstamp_get,
+	.ndo_hwtstamp_set	= bnxt_hwtstamp_set,
 };
 
 static void bnxt_get_queue_stats_rx(struct net_device *dev, int i,
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index ca660e6d28a4..db81cf6d5289 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -560,10 +560,11 @@ static int bnxt_hwrm_ptp_cfg(struct bnxt *bp)
 	return bnxt_ptp_cfg_tstamp_filters(bp);
 }
 
-int bnxt_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
+int bnxt_hwtstamp_set(struct net_device *dev,
+		      struct kernel_hwtstamp_config *stmpconf,
+		      struct netlink_ext_ack *extack)
 {
 	struct bnxt *bp = netdev_priv(dev);
-	struct hwtstamp_config stmpconf;
 	struct bnxt_ptp_cfg *ptp;
 	u16 old_rxctl;
 	int old_rx_filter, rc;
@@ -573,17 +574,14 @@ int bnxt_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 	if (!ptp)
 		return -EOPNOTSUPP;
 
-	if (copy_from_user(&stmpconf, ifr->ifr_data, sizeof(stmpconf)))
-		return -EFAULT;
-
-	if (stmpconf.tx_type != HWTSTAMP_TX_ON &&
-	    stmpconf.tx_type != HWTSTAMP_TX_OFF)
+	if (stmpconf->tx_type != HWTSTAMP_TX_ON &&
+	    stmpconf->tx_type != HWTSTAMP_TX_OFF)
 		return -ERANGE;
 
 	old_rx_filter = ptp->rx_filter;
 	old_rxctl = ptp->rxctl;
 	old_tx_tstamp_en = ptp->tx_tstamp_en;
-	switch (stmpconf.rx_filter) {
+	switch (stmpconf->rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
 		ptp->rxctl = 0;
 		ptp->rx_filter = HWTSTAMP_FILTER_NONE;
@@ -616,7 +614,7 @@ int bnxt_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 		return -ERANGE;
 	}
 
-	if (stmpconf.tx_type == HWTSTAMP_TX_ON)
+	if (stmpconf->tx_type == HWTSTAMP_TX_ON)
 		ptp->tx_tstamp_en = 1;
 	else
 		ptp->tx_tstamp_en = 0;
@@ -625,9 +623,8 @@ int bnxt_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 	if (rc)
 		goto ts_set_err;
 
-	stmpconf.rx_filter = ptp->rx_filter;
-	return copy_to_user(ifr->ifr_data, &stmpconf, sizeof(stmpconf)) ?
-		-EFAULT : 0;
+	stmpconf->rx_filter = ptp->rx_filter;
+	return 0;
 
 ts_set_err:
 	ptp->rx_filter = old_rx_filter;
@@ -636,22 +633,22 @@ int bnxt_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 	return rc;
 }
 
-int bnxt_hwtstamp_get(struct net_device *dev, struct ifreq *ifr)
+int bnxt_hwtstamp_get(struct net_device *dev,
+		      struct kernel_hwtstamp_config *stmpconf)
 {
 	struct bnxt *bp = netdev_priv(dev);
-	struct hwtstamp_config stmpconf;
 	struct bnxt_ptp_cfg *ptp;
 
 	ptp = bp->ptp_cfg;
 	if (!ptp)
 		return -EOPNOTSUPP;
 
-	stmpconf.flags = 0;
-	stmpconf.tx_type = ptp->tx_tstamp_en ? HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
+	stmpconf->flags = 0;
+	stmpconf->tx_type = ptp->tx_tstamp_en ? HWTSTAMP_TX_ON
+					      : HWTSTAMP_TX_OFF;
 
-	stmpconf.rx_filter = ptp->rx_filter;
-	return copy_to_user(ifr->ifr_data, &stmpconf, sizeof(stmpconf)) ?
-		-EFAULT : 0;
+	stmpconf->rx_filter = ptp->rx_filter;
+	return 0;
 }
 
 static int bnxt_map_regs(struct bnxt *bp, u32 *reg_arr, int count, int reg_win)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
index 0481161d26ef..8cc2fae47644 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
@@ -160,8 +160,11 @@ void bnxt_ptp_update_current_time(struct bnxt *bp);
 void bnxt_ptp_pps_event(struct bnxt *bp, u32 data1, u32 data2);
 int bnxt_ptp_cfg_tstamp_filters(struct bnxt *bp);
 void bnxt_ptp_reapply_pps(struct bnxt *bp);
-int bnxt_hwtstamp_set(struct net_device *dev, struct ifreq *ifr);
-int bnxt_hwtstamp_get(struct net_device *dev, struct ifreq *ifr);
+int bnxt_hwtstamp_set(struct net_device *dev,
+		      struct kernel_hwtstamp_config *stmpconf,
+		      struct netlink_ext_ack *extack);
+int bnxt_hwtstamp_get(struct net_device *dev,
+		      struct kernel_hwtstamp_config *stmpconf);
 void bnxt_ptp_free_txts_skbs(struct bnxt_ptp_cfg *ptp);
 int bnxt_ptp_get_txts_prod(struct bnxt_ptp_cfg *ptp, u16 *prod);
 void bnxt_get_tx_ts_p5(struct bnxt *bp, struct sk_buff *skb, u16 prod);
-- 
2.47.3


