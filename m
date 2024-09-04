Return-Path: <netdev+bounces-125012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC11296B94D
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 12:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 654161F275E2
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 10:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF371D015E;
	Wed,  4 Sep 2024 10:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qjj53/Xq"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ABE17BECC;
	Wed,  4 Sep 2024 10:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725447131; cv=none; b=piqKKIPNonxxPeZvTUyXK6Qk5mPYBPEuz1xMA+WOqspAxjfFc4Httxhf8uIPl27AuMF1cJ1kdKeKa0MgdWSUvnTSFJCVu+317X7hI/J8oqcxdKnhm6z5Qtxi+bG1uI4EQxXaC8SfCRlIHDjVqVXSs5Cz4pg7fgiIa8UjxG++po8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725447131; c=relaxed/simple;
	bh=qUIvq8+8mH0Ay7lE1OzlE8+UO1ME8OWsMhIGtU2OuBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LTt0ZWafzDMLguezVNV3v/zI9mHQvlxI5sGWZaf118Sr+MtKGujFcz0KAI3VMbTgey08cSevEKWMnW1QmvJAztxYhw0aCWkR/x4sUAxk6H3AiSQU6ebxMjdkoV6d30IJZGRiuptTVkIHAsflXt+9IkAjS+lXApZcc38vSqwC2fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qjj53/Xq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725447127;
	bh=qUIvq8+8mH0Ay7lE1OzlE8+UO1ME8OWsMhIGtU2OuBI=;
	h=From:To:Cc:Subject:Date:From;
	b=qjj53/Xq9aUcJ9Q9cx2J+sViOaxf42qdRVEz857CAxqGy8Qwf6SayvwToa2F0o6eA
	 +Va2+9eIfthbJ2jWTMI86o10rInIbSRxqbBxPHZT0dglMMzZhEoTVUXv+cLM4Vt4J+
	 M6J3p/h4EysqgBk6keVJqisNhwlsxpWo0zfVZQ8dyD+8LUBelPbxIwXy3Om6nbJwCb
	 BdUiCDF5Du8deJ3Pruht7n0bepuxYpUf6e7NEpcLSwNTe5uT5vdl02GiH5r8rToFiG
	 krIlg2QiTGZABRJXwPi/rLlJRiL9pysD1hYzbRfZqSNY/U0YNj6ZUQrU/odzJU8iqY
	 0koSUr0YprRTQ==
Received: from pan.lan (unknown [IPv6:2a00:23c6:c32f:9100::16d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: martyn)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1720917E0FCA;
	Wed,  4 Sep 2024 12:52:07 +0200 (CEST)
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
Subject: [PATCH net-next v3] net: enetc: Replace ifdef with IS_ENABLED
Date: Wed,  4 Sep 2024 11:51:41 +0100
Message-ID: <20240904105143.2444106-1-martyn.welch@collabora.com>
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

Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---

Changes since v1:
  - Switched from preprocessor conditionals to normal C conditionals.

Changes since v2:
  - Reworked enetc_ethtool.c changes to fit around changes merged in
    net-next.

 drivers/net/ethernet/freescale/enetc/enetc.c  | 34 +++++++++----------
 drivers/net/ethernet/freescale/enetc/enetc.h  |  9 ++---
 .../ethernet/freescale/enetc/enetc_ethtool.c  | 12 ++++---
 3 files changed, 27 insertions(+), 28 deletions(-)

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


