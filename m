Return-Path: <netdev+bounces-230120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F70BE4384
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 17:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 00E424FB6EB
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 15:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F85134AAEE;
	Thu, 16 Oct 2025 15:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hp26bfBz"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE51B346A06
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 15:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628437; cv=none; b=O9MzhlJyabVRS+AUpAnJuYr2Ae1+YKftzjB+9AXvUEGzBya+UuD3nzhqX2Hmkzjk7jU3tVEW/p1MWDvWKS/0JAqyczzAGZzuA7ATttIMQn6/hcWoDt/wq55EfGtKaouTw3Dw8ibWusp57GOV8aOumYsUBYQDzRHQOVKE9V5F17Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628437; c=relaxed/simple;
	bh=yYyafokdHaWw+nqVc7vUKpR1k2gJn5qUajv04SijW6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tv1DYPvJOYpzPqt63SvfAPRpowKLGVlAxBBqaOkykA8/0CePf5M/TnoMp2CdAKr0UWFg+7Yqzl+yuYK1T7N9YetAeqEWPJ7ZxhY4L/SGVH/ErLSwv0U2EhG2BbIYwwpOicaYh6wtkX0amICH6l9vkAAvKcyAYlL8K6PemTBkVpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hp26bfBz; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760628431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R5CJ8GxIqvejILasy+EIS4gXlkzK6y/KyF1JCnZBQds=;
	b=hp26bfBzjaKpI30rhsjO5CYr7bx8c8utiJM0qFuq89WeR8Cibw8pWafUk5hSx/USwtK7F5
	Cv2KojhdQXmGegLQ8uP4pklXwP+cjzuIbK91xeESruoE3zWIS6uSoufr0Z75lu+K3yarHU
	BxyKK9oDvpt/9rTFhjwJcR4HuO1TV00=
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
Subject: [PATCH net-next v3 4/7] net: atlantic: convert to ndo_hwtstamp API
Date: Thu, 16 Oct 2025 15:25:12 +0000
Message-ID: <20251016152515.3510991-5-vadim.fedorenko@linux.dev>
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

Convert driver to .ndo_hwtstamp_get()/.ndo_hwtstamp_set() callbacks.
.ndo_eth_ioctl() becomes empty so remove it. Also simplify code with no
functional changes.

Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 .../net/ethernet/aquantia/atlantic/aq_main.c  | 66 +++++--------------
 .../net/ethernet/aquantia/atlantic/aq_ptp.c   |  6 +-
 .../net/ethernet/aquantia/atlantic/aq_ptp.h   |  8 +--
 3 files changed, 22 insertions(+), 58 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_main.c b/drivers/net/ethernet/aquantia/atlantic/aq_main.c
index b565189e5913..4ef4fe64b8ac 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_main.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_main.c
@@ -258,10 +258,15 @@ static void aq_ndev_set_multicast_settings(struct net_device *ndev)
 	(void)aq_nic_set_multicast_list(aq_nic, ndev);
 }
 
-#if IS_REACHABLE(CONFIG_PTP_1588_CLOCK)
-static int aq_ndev_config_hwtstamp(struct aq_nic_s *aq_nic,
-				   struct hwtstamp_config *config)
+static int aq_ndev_hwtstamp_set(struct net_device *netdev,
+				struct kernel_hwtstamp_config *config,
+				struct netlink_ext_ack *extack)
 {
+	struct aq_nic_s *aq_nic = netdev_priv(netdev);
+
+	if (!IS_REACHABLE(CONFIG_PTP_1588_CLOCK) || !aq_nic->aq_ptp)
+		return -EOPNOTSUPP;
+
 	switch (config->tx_type) {
 	case HWTSTAMP_TX_OFF:
 	case HWTSTAMP_TX_ON:
@@ -290,59 +295,17 @@ static int aq_ndev_config_hwtstamp(struct aq_nic_s *aq_nic,
 
 	return aq_ptp_hwtstamp_config_set(aq_nic->aq_ptp, config);
 }
-#endif
-
-static int aq_ndev_hwtstamp_set(struct aq_nic_s *aq_nic, struct ifreq *ifr)
-{
-	struct hwtstamp_config config;
-#if IS_REACHABLE(CONFIG_PTP_1588_CLOCK)
-	int ret_val;
-#endif
-
-	if (!aq_nic->aq_ptp)
-		return -EOPNOTSUPP;
-
-	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
-		return -EFAULT;
-#if IS_REACHABLE(CONFIG_PTP_1588_CLOCK)
-	ret_val = aq_ndev_config_hwtstamp(aq_nic, &config);
-	if (ret_val)
-		return ret_val;
-#endif
-
-	return copy_to_user(ifr->ifr_data, &config, sizeof(config)) ?
-	       -EFAULT : 0;
-}
 
-#if IS_REACHABLE(CONFIG_PTP_1588_CLOCK)
-static int aq_ndev_hwtstamp_get(struct aq_nic_s *aq_nic, struct ifreq *ifr)
+static int aq_ndev_hwtstamp_get(struct net_device *netdev,
+				struct kernel_hwtstamp_config *config)
 {
-	struct hwtstamp_config config;
+	struct aq_nic_s *aq_nic = netdev_priv(netdev);
 
 	if (!aq_nic->aq_ptp)
 		return -EOPNOTSUPP;
 
-	aq_ptp_hwtstamp_config_get(aq_nic->aq_ptp, &config);
-	return copy_to_user(ifr->ifr_data, &config, sizeof(config)) ?
-	       -EFAULT : 0;
-}
-#endif
-
-static int aq_ndev_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
-{
-	struct aq_nic_s *aq_nic = netdev_priv(netdev);
-
-	switch (cmd) {
-	case SIOCSHWTSTAMP:
-		return aq_ndev_hwtstamp_set(aq_nic, ifr);
-
-#if IS_REACHABLE(CONFIG_PTP_1588_CLOCK)
-	case SIOCGHWTSTAMP:
-		return aq_ndev_hwtstamp_get(aq_nic, ifr);
-#endif
-	}
-
-	return -EOPNOTSUPP;
+	aq_ptp_hwtstamp_config_get(aq_nic->aq_ptp, config);
+	return 0;
 }
 
 static int aq_ndo_vlan_rx_add_vid(struct net_device *ndev, __be16 proto,
@@ -500,12 +463,13 @@ static const struct net_device_ops aq_ndev_ops = {
 	.ndo_set_mac_address = aq_ndev_set_mac_address,
 	.ndo_set_features = aq_ndev_set_features,
 	.ndo_fix_features = aq_ndev_fix_features,
-	.ndo_eth_ioctl = aq_ndev_ioctl,
 	.ndo_vlan_rx_add_vid = aq_ndo_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid = aq_ndo_vlan_rx_kill_vid,
 	.ndo_setup_tc = aq_ndo_setup_tc,
 	.ndo_bpf = aq_xdp,
 	.ndo_xdp_xmit = aq_xdp_xmit,
+	.ndo_hwtstamp_get = aq_ndev_hwtstamp_get,
+	.ndo_hwtstamp_set = aq_ndev_hwtstamp_set,
 };
 
 static int __init aq_ndev_init_module(void)
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
index 5acb3e16b567..0fa0f891c0e0 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
@@ -51,7 +51,7 @@ struct ptp_tx_timeout {
 
 struct aq_ptp_s {
 	struct aq_nic_s *aq_nic;
-	struct hwtstamp_config hwtstamp_config;
+	struct kernel_hwtstamp_config hwtstamp_config;
 	spinlock_t ptp_lock;
 	spinlock_t ptp_ring_lock;
 	struct ptp_clock *ptp_clock;
@@ -567,7 +567,7 @@ static void aq_ptp_rx_hwtstamp(struct aq_ptp_s *aq_ptp, struct skb_shared_hwtsta
 }
 
 void aq_ptp_hwtstamp_config_get(struct aq_ptp_s *aq_ptp,
-				struct hwtstamp_config *config)
+				struct kernel_hwtstamp_config *config)
 {
 	*config = aq_ptp->hwtstamp_config;
 }
@@ -588,7 +588,7 @@ static void aq_ptp_prepare_filters(struct aq_ptp_s *aq_ptp)
 }
 
 int aq_ptp_hwtstamp_config_set(struct aq_ptp_s *aq_ptp,
-			       struct hwtstamp_config *config)
+			       struct kernel_hwtstamp_config *config)
 {
 	struct aq_nic_s *aq_nic = aq_ptp->aq_nic;
 	const struct aq_hw_ops *hw_ops;
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.h b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.h
index 210b723f2207..5e643ec7cc06 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.h
@@ -60,9 +60,9 @@ void aq_ptp_tx_hwtstamp(struct aq_nic_s *aq_nic, u64 timestamp);
 
 /* Must be to check available of PTP before call */
 void aq_ptp_hwtstamp_config_get(struct aq_ptp_s *aq_ptp,
-				struct hwtstamp_config *config);
+				struct kernel_hwtstamp_config *config);
 int aq_ptp_hwtstamp_config_set(struct aq_ptp_s *aq_ptp,
-			       struct hwtstamp_config *config);
+			       struct kernel_hwtstamp_config *config);
 
 /* Return either ring is belong to PTP or not*/
 bool aq_ptp_ring(struct aq_nic_s *aq_nic, struct aq_ring_s *ring);
@@ -130,9 +130,9 @@ static inline int aq_ptp_xmit(struct aq_nic_s *aq_nic, struct sk_buff *skb)
 
 static inline void aq_ptp_tx_hwtstamp(struct aq_nic_s *aq_nic, u64 timestamp) {}
 static inline void aq_ptp_hwtstamp_config_get(struct aq_ptp_s *aq_ptp,
-					      struct hwtstamp_config *config) {}
+					      struct kernel_hwtstamp_config *config) {}
 static inline int aq_ptp_hwtstamp_config_set(struct aq_ptp_s *aq_ptp,
-					     struct hwtstamp_config *config)
+					     struct kernel_hwtstamp_config *config)
 {
 	return 0;
 }
-- 
2.47.3


