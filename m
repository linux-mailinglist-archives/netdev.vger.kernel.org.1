Return-Path: <netdev+bounces-124558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E70969FCA
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33017B24DD4
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A629F44C8F;
	Tue,  3 Sep 2024 14:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nUvqVBXw"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD8B3A267;
	Tue,  3 Sep 2024 14:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725372273; cv=none; b=JnJ1aArchxvrQvsLVNaLRq8dks7sGdNpXAy/27HcAiTiUedh83jTN8xJu56m2AVKIHxJ8sQLT5YZ8vZ6KGxO4n3cAD6gULkUhh8ZjtqRkcW5kWw6TKrbvvUvdjLxqIcTeU2KkbRsdaM4NRaBvPOkZzBBWcKtD16OdCwuSkzsKf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725372273; c=relaxed/simple;
	bh=8pE0BwCHOCAkAcsyNe0irerqGkO/4TqYM8/fwq3F82I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EACFzJdZUa7L6rC4ZPjXpxwT8FJPeCetdWcOvWAvo9Fdu6XDr8+jlpTafhFmAQ2uVlgQbV4lWzzA1I0oOLNz/k0OjTETq2HQH18RqfW4QaSLyzZvyRJtNj9sCrukMsxo2ByVepSKTzY4eB+D9UPEQNfhekxQS7JPLoevZ3vUMSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nUvqVBXw; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725372269;
	bh=8pE0BwCHOCAkAcsyNe0irerqGkO/4TqYM8/fwq3F82I=;
	h=From:To:Cc:Subject:Date:From;
	b=nUvqVBXwUQdToqJbR/6tZM7N04qfY35fiflKcJO/vGvLvzrm6ak0YIydGewPIeah6
	 a1aYGrAWzkOKQ4lXrieLtNgZC+7lUIabtnwknuF2BEncvn9q+AZmIKIrlbZZIOj3f4
	 wuIdPwdBTSQu92CuVACxZk28d8G9Ks+MNHeJbsrxh2RHzyYmC9yZJyBZYZnZdQQqIY
	 y05S9t9QjKNDmC+bWcDpI27lZKOtvK+Fv6r+r05ZovcgQTTNLxdxf1LMYzEb0t+2Jt
	 4aD189nPojk0ow7ao6LHf4uftnCVuRjL95bQOFNfXFl6ld66Z2DdDJS+DloluKANtz
	 fAhFHryJhg3wA==
Received: from pan.lan (unknown [IPv6:2a00:23c6:c32f:9100::16d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: martyn)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DF35317E10A9;
	Tue,  3 Sep 2024 16:04:28 +0200 (CEST)
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
Subject: [PATCH v2] net: enetc: Replace ifdef with IS_ENABLED
Date: Tue,  3 Sep 2024 15:04:18 +0100
Message-ID: <20240903140420.2150707-1-martyn.welch@collabora.com>
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
if the driver is compiled in but fails if the driver is available as a
kernel module. Replace the instances of ifdef with use of the IS_ENABLED
macro, that will evaluate as true when this feature is built as a kernel
module and follows the kernel's coding style.

Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
---

Changes since v1:
  - Switched from preprocessor conditionals to normal C conditionals.

 drivers/net/ethernet/freescale/enetc/enetc.c  | 34 ++++++++---------
 drivers/net/ethernet/freescale/enetc/enetc.h  |  9 ++---
 .../ethernet/freescale/enetc/enetc_ethtool.c  | 37 ++++++++++---------
 3 files changed, 38 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 5c45f42232d3..361464a5b6c4 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -977,10 +977,9 @@ static int enetc_refill_rx_ring(struct enetc_bdr *rx_ring, const int buff_cnt)
 	return j;
 }
 
-#ifdef CONFIG_FSL_ENETC_PTP_CLOCK
-static void enetc_get_rx_tstamp(struct net_device *ndev,
-				union enetc_rx_bd *rxbd,
-				struct sk_buff *skb)
+static void __maybe_unused enetc_get_rx_tstamp(struct net_device *ndev,
+					       union enetc_rx_bd *rxbd,
+					       struct sk_buff *skb)
 {
 	struct skb_shared_hwtstamps *shhwtstamps = skb_hwtstamps(skb);
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
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
@@ -2882,8 +2879,8 @@ void enetc_set_features(struct net_device *ndev, netdev_features_t features)
 }
 EXPORT_SYMBOL_GPL(enetc_set_features);
 
-#ifdef CONFIG_FSL_ENETC_PTP_CLOCK
-static int enetc_hwtstamp_set(struct net_device *ndev, struct ifreq *ifr)
+static int __maybe_unused enetc_hwtstamp_set(struct net_device *ndev,
+					     struct ifreq *ifr)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	int err, new_offloads = priv->active_offloads;
@@ -2931,7 +2928,8 @@ static int enetc_hwtstamp_set(struct net_device *ndev, struct ifreq *ifr)
 	       -EFAULT : 0;
 }
 
-static int enetc_hwtstamp_get(struct net_device *ndev, struct ifreq *ifr)
+static int __maybe_unused enetc_hwtstamp_get(struct net_device *ndev,
+					     struct ifreq *ifr)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct hwtstamp_config config;
@@ -2951,17 +2949,17 @@ static int enetc_hwtstamp_get(struct net_device *ndev, struct ifreq *ifr)
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
index 5e684b23c5f5..a9402c1907bf 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -853,24 +853,25 @@ static int enetc_get_ts_info(struct net_device *ndev,
 		info->phc_index = -1;
 	}
 
-#ifdef CONFIG_FSL_ENETC_PTP_CLOCK
-	info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
-				SOF_TIMESTAMPING_RX_HARDWARE |
-				SOF_TIMESTAMPING_RAW_HARDWARE |
-				SOF_TIMESTAMPING_TX_SOFTWARE |
-				SOF_TIMESTAMPING_RX_SOFTWARE |
-				SOF_TIMESTAMPING_SOFTWARE;
-
-	info->tx_types = (1 << HWTSTAMP_TX_OFF) |
-			 (1 << HWTSTAMP_TX_ON) |
-			 (1 << HWTSTAMP_TX_ONESTEP_SYNC);
-	info->rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
-			   (1 << HWTSTAMP_FILTER_ALL);
-#else
-	info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
-				SOF_TIMESTAMPING_TX_SOFTWARE |
-				SOF_TIMESTAMPING_SOFTWARE;
-#endif
+	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)) {
+		info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
+					SOF_TIMESTAMPING_RX_HARDWARE |
+					SOF_TIMESTAMPING_RAW_HARDWARE |
+					SOF_TIMESTAMPING_TX_SOFTWARE |
+					SOF_TIMESTAMPING_RX_SOFTWARE |
+					SOF_TIMESTAMPING_SOFTWARE;
+
+		info->tx_types = (1 << HWTSTAMP_TX_OFF) |
+				 (1 << HWTSTAMP_TX_ON) |
+				 (1 << HWTSTAMP_TX_ONESTEP_SYNC);
+		info->rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
+				   (1 << HWTSTAMP_FILTER_ALL);
+	} else {
+		info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
+					SOF_TIMESTAMPING_TX_SOFTWARE |
+					SOF_TIMESTAMPING_SOFTWARE;
+	}
+
 	return 0;
 }
 
-- 
2.45.2

