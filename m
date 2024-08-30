Return-Path: <netdev+bounces-123790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 468E0966865
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 19:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 059AF2816C1
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 17:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DB11B81B1;
	Fri, 30 Aug 2024 17:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NTctW4pv"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0E614A4EA;
	Fri, 30 Aug 2024 17:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725040281; cv=none; b=COdYk5wVV5rlJsIeWXYl2K/4GivWj9xTs4cjiSRvu/Q9AjMNmEUikzvEGST87ul7v1Zu+WmEElXQijCjPzjN/GPtYEFTn1Xj36hGOTu33icfxy2UQN7+Pq0JDYUoVnO6X9yfpsCInEWEqDQ8z0x6BVrD9yLC+O+em8PI8cHHN3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725040281; c=relaxed/simple;
	bh=HmM31MGwOTZmhh9rNokr+Zlh5nRbX/y5mVw4jppcrwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=szvbkSAzRiuq+vuK4gf/1swvU7doMzOLQpa0y939b38FIJgCNqq6IhtUTWbc80yNqw26iCwjnamDqJ1VJt7fk9ff871K9eNblF+scEwWDorzudi5EJTZKmRfMHoVaImH3zlSW4dh0fY6m2mIcvDx5FW5gxQ8EO89jw7ySQAa30o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NTctW4pv; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725040272;
	bh=HmM31MGwOTZmhh9rNokr+Zlh5nRbX/y5mVw4jppcrwQ=;
	h=From:To:Cc:Subject:Date:From;
	b=NTctW4pv1uy6hoNcbQQOW1sIcqjNBdDdCUyZLJTezkOxd5KtaP3/xZ8XwVPCldwc8
	 I+D7TScuUSYaNJY7npEABc2xxcR+wEuYcapySkG5GnZf5FLQnkP8JpwD8XBS6KAizD
	 oW6FxTBePGq7RGjfzR/JZLfeWAGGHGWjJI6U5pWGFyBftJNDaUQpY/GaDwdqjik6vJ
	 19cW83oOuOi12WKUiMYKbY3+XS0gIJUXSdKRFO7u4kcI0RjA8Uoo/3YehZtQvWTLPE
	 bhEflwjcGpDJxmVuiN2fMyY5P0XlhqDLVYsquGXWcjY0mkZ2zfMuLw7tdMiEZXJ7Ze
	 On9rLXlF+ROIw==
Received: from pan.lan (unknown [IPv6:2a00:23c6:c32f:9100::16d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: martyn)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 06C4B17E10C2;
	Fri, 30 Aug 2024 19:51:11 +0200 (CEST)
From: Martyn Welch <martyn.welch@collabora.com>
To: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: kernel@collabora.com,
	Martyn Welch <martyn.welch@collabora.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: enetc: Replace ifdef with IS_ENABLED
Date: Fri, 30 Aug 2024 18:50:50 +0100
Message-ID: <20240830175052.1463711-1-martyn.welch@collabora.com>
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
module.

Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c         | 8 ++++----
 drivers/net/ethernet/freescale/enetc/enetc.h         | 4 ++--
 drivers/net/ethernet/freescale/enetc/enetc_ethtool.c | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 5c45f42232d3..276bc96dd1ef 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -977,7 +977,7 @@ static int enetc_refill_rx_ring(struct enetc_bdr *rx_ring, const int buff_cnt)
 	return j;
 }
 
-#ifdef CONFIG_FSL_ENETC_PTP_CLOCK
+#if IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)
 static void enetc_get_rx_tstamp(struct net_device *ndev,
 				union enetc_rx_bd *rxbd,
 				struct sk_buff *skb)
@@ -1041,7 +1041,7 @@ static void enetc_get_offloads(struct enetc_bdr *rx_ring,
 		__vlan_hwaccel_put_tag(skb, tpid, le16_to_cpu(rxbd->r.vlan_opt));
 	}
 
-#ifdef CONFIG_FSL_ENETC_PTP_CLOCK
+#if IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)
 	if (priv->active_offloads & ENETC_F_RX_TSTAMP)
 		enetc_get_rx_tstamp(rx_ring->ndev, rxbd, skb);
 #endif
@@ -2882,7 +2882,7 @@ void enetc_set_features(struct net_device *ndev, netdev_features_t features)
 }
 EXPORT_SYMBOL_GPL(enetc_set_features);
 
-#ifdef CONFIG_FSL_ENETC_PTP_CLOCK
+#if IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)
 static int enetc_hwtstamp_set(struct net_device *ndev, struct ifreq *ifr)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
@@ -2956,7 +2956,7 @@ static int enetc_hwtstamp_get(struct net_device *ndev, struct ifreq *ifr)
 int enetc_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-#ifdef CONFIG_FSL_ENETC_PTP_CLOCK
+#if IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)
 	if (cmd == SIOCSHWTSTAMP)
 		return enetc_hwtstamp_set(ndev, rq);
 	if (cmd == SIOCGHWTSTAMP)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index a9c2ff22431c..b527bb3d51b4 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -184,7 +184,7 @@ static inline union enetc_rx_bd *enetc_rxbd(struct enetc_bdr *rx_ring, int i)
 {
 	int hw_idx = i;
 
-#ifdef CONFIG_FSL_ENETC_PTP_CLOCK
+#if IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)
 	if (rx_ring->ext_en)
 		hw_idx = 2 * i;
 #endif
@@ -199,7 +199,7 @@ static inline void enetc_rxbd_next(struct enetc_bdr *rx_ring,
 
 	new_rxbd++;
 
-#ifdef CONFIG_FSL_ENETC_PTP_CLOCK
+#if IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)
 	if (rx_ring->ext_en)
 		new_rxbd++;
 #endif
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 5e684b23c5f5..d6fdec2220ce 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -853,7 +853,7 @@ static int enetc_get_ts_info(struct net_device *ndev,
 		info->phc_index = -1;
 	}
 
-#ifdef CONFIG_FSL_ENETC_PTP_CLOCK
+#if IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)
 	info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
 				SOF_TIMESTAMPING_RX_HARDWARE |
 				SOF_TIMESTAMPING_RAW_HARDWARE |
-- 
2.45.2


