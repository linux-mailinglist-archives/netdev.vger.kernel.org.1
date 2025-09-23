Return-Path: <netdev+bounces-225694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA17CB970A5
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 19:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A72D3BA3FA
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 17:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85943283C9E;
	Tue, 23 Sep 2025 17:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Pu6EW2ZA"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3632765E8
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758648815; cv=none; b=Kr3rEUTvnLpS0oGciWfm+7YvBcGg4A5z/kFuQ13pa08VvpRckZICETdNYhnAKJPoPELzn98a9xuPaosLkoPTCG+qkVIRc860EWmtUAA98uSQep8N5O+0T/91VAlzoY2uI62aUIfuUcA/xOOHBQanWz6oa2J7MEyu52cwy+YhxRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758648815; c=relaxed/simple;
	bh=P+Fp0bkc+KhZZ+i86ovQCjYihf9HT3M7JtK7ar40U3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZXxEcDOe41CelBACes9XV+K1Oj3N2jxrhdXKvMlw0R0hgEr4PymrXevxTEihYHB8az17XrQz8pINMG7qwO7A2KCaZwUFg0SJvzw8iIZ978wOTZOPO0HgyMCkd4Q5B3sJ2cfik6ZT0/9JuXdBwlGi0ZUb9nX99OVR+JTWJ/YbAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Pu6EW2ZA; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758648809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XcCpgFUP0o7P8eWwINyxEFynb6nAoMsBLI5Olh+liAc=;
	b=Pu6EW2ZAzjgVBQD0BzhGxgngKTiFdAQF8oX+X/kD9j9dYab5XZt5NoAjpU/vmE/xd187WU
	d26H7bG76lGPFqLhIqwLu2dbjR7sOoZDdLAi9Cd2UkevFtVdc4/po8tpE09nTN6MAI01H7
	2L8FqG4a5Dlqa92FOcZGYGY3YXkUe0w=
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
Subject: [PATCH net-next v2 2/4] bnxt_en: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
Date: Tue, 23 Sep 2025 17:33:08 +0000
Message-ID: <20250923173310.139623-3-vadim.fedorenko@linux.dev>
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

Convert bnxt dirver to use new timestamping configuration API.

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
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


