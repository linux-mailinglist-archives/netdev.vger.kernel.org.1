Return-Path: <netdev+bounces-127902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E91976FA3
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 19:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7B811F262F4
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 17:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0101D189526;
	Thu, 12 Sep 2024 17:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="puXsQxor"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD63B1B1402;
	Thu, 12 Sep 2024 17:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726162676; cv=none; b=TG1mVj+Z+EzGrIIiA3FIggS6Ohc/+zKKyqVXGsq/QGVXIjQC9fTOFLZsy4WHEPmyRR6okwpj61D++nqU+JreewePeB2F32pg5haPOGW23gbRvH5UB7S5/ebXfmKr9pGrnbqjBtP9ObsXJXN+9WELEGRUMtdy7ybvNZJDkmitHA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726162676; c=relaxed/simple;
	bh=B8EL+9+b+t9SUXyOoAFdFBITc2Oye2+Mb9NUh5olAl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nyz6P0Dk0Xfzp5hmK8C+ITd8inHT+4F2uFH2KE9ZMWP7dIOUC7cAWSSWNqB6MkghECkwEtInV9xC9KVCyMXXEmGjUW9vomDGKy/gApQf/UwMgkOYRmPRaBU/LJT6sHOuPGogG+SyDLKVMxlY8HWXVwalZTnjgVOEcHQUT7rGJwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=puXsQxor; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726162672;
	bh=B8EL+9+b+t9SUXyOoAFdFBITc2Oye2+Mb9NUh5olAl4=;
	h=From:To:Cc:Subject:Date:From;
	b=puXsQxor0x/43rdISwlqcirvH9yJqkzSvK0YUU9NdVxld6IUhFFcp4aH5xGC6ub2V
	 CrPd4VIlAxAOA+D5ZNesrgx9LcNpcVolUE+glSIt+W9QiDp7rt7BvDgHpVAj+9zYi6
	 H0YU0liKQOG+Ud9Mu1CkX6EgTc03ij+bIxBmZTXfP/vPeEFEwPI0Bhi69N8Lt4kNe2
	 j3EQDrfLD4gyFpYapGXkd/cDIGLiWCyV9rS0ejHvcVOHMzhpl9Rwmt8j0pYi1GG2W2
	 rqp63gYfY75ZRPIHjLgg4vRSbImIO3oLah9cvraBpvyDKCueb0yoyAh1ocnFc7TTwI
	 Huy2cRy8zxN/Q==
Received: from pan.lan (unknown [IPv6:2a00:23c6:c32f:9100::16d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: martyn)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5784B17E1063;
	Thu, 12 Sep 2024 19:37:52 +0200 (CEST)
From: Martyn Welch <martyn.welch@collabora.com>
To: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: kernel@collabora.com,
	Martyn Welch <martyn.welch@collabora.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4] net: enetc: Replace ifdef with IS_ENABLED
Date: Thu, 12 Sep 2024 18:37:40 +0100
Message-ID: <20240912173742.484549-1-martyn.welch@collabora.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The enetc driver uses ifdefs when checking whether
CONFIG_FSL_ENETC_PTP_CLOCK is enabled in a number of places. This works
if the driver is built-in but fails if the driver is available as a
kernel module. Replace the instances of ifdef with use of the IS_ENABLED
macro, that will evaluate as true when this feature is built as a kernel
module and follows the kernel's coding style.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
---

Changes since v1:
  - Switched from preprocessor conditionals to normal C conditionals.

Changes since v2:
  - Reworked enetc_ethtool.c changes to fit around changes merged in
    net-next.

Changes since v3:
  - Correction of SOB ordering.
  - Removal of unneeded `__maybe_unused` tags.

drivers/net/ethernet/freescale/enetc/enetc.c  | 22 ++++++++-----------
 drivers/net/ethernet/freescale/enetc/enetc.h  |  9 +++-----
 .../ethernet/freescale/enetc/enetc_ethtool.c  | 12 ++++++----
 3 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 5c45f42232d3..66e3e982882a 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -977,7 +977,6 @@ static int enetc_refill_rx_ring(struct enetc_bdr *rx_ring, const int buff_cnt)
 	return j;
 }
 
-#ifdef CONFIG_FSL_ENETC_PTP_CLOCK
 static void enetc_get_rx_tstamp(struct net_device *ndev,
 				union enetc_rx_bd *rxbd,
 				struct sk_buff *skb)
@@ -1001,7 +1000,6 @@ static void enetc_get_rx_tstamp(struct net_device *ndev,
 		shhwtstamps->hwtstamp = ns_to_ktime(tstamp);
 	}
 }
-#endif
 
 static void enetc_get_offloads(struct enetc_bdr *rx_ring,
 			       union enetc_rx_bd *rxbd, struct sk_buff *skb)
@@ -1041,10 +1039,9 @@ static void enetc_get_offloads(struct enetc_bdr *rx_ring,
 		__vlan_hwaccel_put_tag(skb, tpid, le16_to_cpu(rxbd->r.vlan_opt));
 	}
 
-#ifdef CONFIG_FSL_ENETC_PTP_CLOCK
-	if (priv->active_offloads & ENETC_F_RX_TSTAMP)
+	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK) &&
+	    (priv->active_offloads & ENETC_F_RX_TSTAMP))
 		enetc_get_rx_tstamp(rx_ring->ndev, rxbd, skb);
-#endif
 }
 
 /* This gets called during the non-XDP NAPI poll cycle as well as on XDP_PASS,
@@ -2882,7 +2879,6 @@ void enetc_set_features(struct net_device *ndev, netdev_features_t features)
 }
 EXPORT_SYMBOL_GPL(enetc_set_features);
 
-#ifdef CONFIG_FSL_ENETC_PTP_CLOCK
 static int enetc_hwtstamp_set(struct net_device *ndev, struct ifreq *ifr)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
@@ -2951,17 +2947,17 @@ static int enetc_hwtstamp_get(struct net_device *ndev, struct ifreq *ifr)
 	return copy_to_user(ifr->ifr_data, &config, sizeof(config)) ?
 	       -EFAULT : 0;
 }
-#endif
 
 int enetc_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-#ifdef CONFIG_FSL_ENETC_PTP_CLOCK
-	if (cmd == SIOCSHWTSTAMP)
-		return enetc_hwtstamp_set(ndev, rq);
-	if (cmd == SIOCGHWTSTAMP)
-		return enetc_hwtstamp_get(ndev, rq);
-#endif
+
+	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)) {
+		if (cmd == SIOCSHWTSTAMP)
+			return enetc_hwtstamp_set(ndev, rq);
+		if (cmd == SIOCGHWTSTAMP)
+			return enetc_hwtstamp_get(ndev, rq);
+	}
 
 	if (!priv->phylink)
 		return -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index a9c2ff22431c..97524dfa234c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -184,10 +184,9 @@ static inline union enetc_rx_bd *enetc_rxbd(struct enetc_bdr *rx_ring, int i)
 {
 	int hw_idx = i;
 
-#ifdef CONFIG_FSL_ENETC_PTP_CLOCK
-	if (rx_ring->ext_en)
+	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK) && rx_ring->ext_en)
 		hw_idx = 2 * i;
-#endif
+
 	return &(((union enetc_rx_bd *)rx_ring->bd_base)[hw_idx]);
 }
 
@@ -199,10 +198,8 @@ static inline void enetc_rxbd_next(struct enetc_bdr *rx_ring,
 
 	new_rxbd++;
 
-#ifdef CONFIG_FSL_ENETC_PTP_CLOCK
-	if (rx_ring->ext_en)
+	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK) && rx_ring->ext_en)
 		new_rxbd++;
-#endif
 
 	if (unlikely(++new_index == rx_ring->bd_count)) {
 		new_rxbd = rx_ring->bd_base;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 47c478e08d44..2563eb8ac7b6 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -851,7 +851,12 @@ static int enetc_get_ts_info(struct net_device *ndev,
 		symbol_put(enetc_phc_index);
 	}
 
-#ifdef CONFIG_FSL_ENETC_PTP_CLOCK
+	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)) {
+		info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;
+
+		return 0;
+	}
+
 	info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
 				SOF_TIMESTAMPING_RX_HARDWARE |
 				SOF_TIMESTAMPING_RAW_HARDWARE |
@@ -860,11 +865,10 @@ static int enetc_get_ts_info(struct net_device *ndev,
 	info->tx_types = (1 << HWTSTAMP_TX_OFF) |
 			 (1 << HWTSTAMP_TX_ON) |
 			 (1 << HWTSTAMP_TX_ONESTEP_SYNC);
+
 	info->rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
 			   (1 << HWTSTAMP_FILTER_ALL);
-#else
-	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;
-#endif
+
 	return 0;
 }
 
-- 
2.45.2


