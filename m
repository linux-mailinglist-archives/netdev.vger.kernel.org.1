Return-Path: <netdev+bounces-230116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3C3BE4375
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 17:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B1EF4E1D2D
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 15:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5A0346A12;
	Thu, 16 Oct 2025 15:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tD4wxDbj"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452222D374F
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628427; cv=none; b=FalkAnJ8lK8VugHaKpANgCIeSqbWlaSgcJMdh0CNSALNuOvSBcRQvzh+E0vliUdFX1bYuxJAWdxHKI2v4zDXDBhlNgc4ML90pblmWus5WDjDOqIUfO14Cox/ZRxwhl3JM1ftv7mdSIFW1kiGaG5xDMPRpVw7ic2fDwZb2QINlSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628427; c=relaxed/simple;
	bh=gCV1qEf/8Xms9ns50Cm2J5fPPmwd0SMYyH4KtxX9HdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HobC2m8pE11JsuWCh2grLI1Sm8uIwLmwqEubRDC2p9TABu+OPl+BXTGTKPVDoHC7mVxFCIG/8X/b/JKJ5nfyuWcCTSIVEGkVd1uPd+0NLcgNY35w7zvJYPOC4CFXYQEFqJdTDvUva0Qub5c7JihkoRp6RfA0GARqBM42gPfgIH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tD4wxDbj; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760628423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u48e8fB3LeiGAMkN7laiJMz4vIL211yx1rUVUlmkyzQ=;
	b=tD4wxDbjaq31kKS3ZlFmtNMYzw1WEWMBZTD7egXfizWrX82HKwAXkN/FmYumqHh/T3Srlz
	t1/aBRozEMg3x0jY0gjkSwsuTdxCirVriBhpGUnjrBL/4cMban2mGs6AnqQyfqTQRp73CX
	NlQm0xln3xiikHXgPPgyc3VCv82FSow=
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
Subject: [PATCH net-next v3 2/7] ti: icssg: convert to ndo_hwtstamp API
Date: Thu, 16 Oct 2025 15:25:10 +0000
Message-ID: <20251016152515.3510991-3-vadim.fedorenko@linux.dev>
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

Convert driver to use .ndo_hwtstamp_get()/.ndo_hwtstamp_set() API.
.ndo_eth_ioctl() implementation becomes pure phy_do_ioctl(), remove
it from common module, remove exported symbol and replace ndo callback.

Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/ethernet/ti/icssg/icssg_common.c  | 47 ++++++-------------
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  |  4 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  6 ++-
 .../net/ethernet/ti/icssg/icssg_prueth_sr1.c  |  4 +-
 4 files changed, 26 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 57e5f1c88f50..0eed29d6187a 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -1223,15 +1223,13 @@ void icssg_ndo_tx_timeout(struct net_device *ndev, unsigned int txqueue)
 }
 EXPORT_SYMBOL_GPL(icssg_ndo_tx_timeout);
 
-static int emac_set_ts_config(struct net_device *ndev, struct ifreq *ifr)
+int icssg_ndo_set_ts_config(struct net_device *ndev,
+			    struct kernel_hwtstamp_config *config,
+			    struct netlink_ext_ack *extack)
 {
 	struct prueth_emac *emac = netdev_priv(ndev);
-	struct hwtstamp_config config;
 
-	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
-		return -EFAULT;
-
-	switch (config.tx_type) {
+	switch (config->tx_type) {
 	case HWTSTAMP_TX_OFF:
 		emac->tx_ts_enabled = 0;
 		break;
@@ -1242,7 +1240,7 @@ static int emac_set_ts_config(struct net_device *ndev, struct ifreq *ifr)
 		return -ERANGE;
 	}
 
-	switch (config.rx_filter) {
+	switch (config->rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
 		emac->rx_ts_enabled = 0;
 		break;
@@ -1262,43 +1260,28 @@ static int emac_set_ts_config(struct net_device *ndev, struct ifreq *ifr)
 	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
 	case HWTSTAMP_FILTER_NTP_ALL:
 		emac->rx_ts_enabled = 1;
-		config.rx_filter = HWTSTAMP_FILTER_ALL;
+		config->rx_filter = HWTSTAMP_FILTER_ALL;
 		break;
 	default:
 		return -ERANGE;
 	}
 
-	return copy_to_user(ifr->ifr_data, &config, sizeof(config)) ?
-		-EFAULT : 0;
+	return 0;
 }
+EXPORT_SYMBOL_GPL(icssg_ndo_set_ts_config);
 
-static int emac_get_ts_config(struct net_device *ndev, struct ifreq *ifr)
+int icssg_ndo_get_ts_config(struct net_device *ndev,
+			    struct kernel_hwtstamp_config *config)
 {
 	struct prueth_emac *emac = netdev_priv(ndev);
-	struct hwtstamp_config config;
-
-	config.flags = 0;
-	config.tx_type = emac->tx_ts_enabled ? HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
-	config.rx_filter = emac->rx_ts_enabled ? HWTSTAMP_FILTER_ALL : HWTSTAMP_FILTER_NONE;
-
-	return copy_to_user(ifr->ifr_data, &config, sizeof(config)) ?
-			    -EFAULT : 0;
-}
 
-int icssg_ndo_ioctl(struct net_device *ndev, struct ifreq *ifr, int cmd)
-{
-	switch (cmd) {
-	case SIOCGHWTSTAMP:
-		return emac_get_ts_config(ndev, ifr);
-	case SIOCSHWTSTAMP:
-		return emac_set_ts_config(ndev, ifr);
-	default:
-		break;
-	}
+	config->flags = 0;
+	config->tx_type = emac->tx_ts_enabled ? HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
+	config->rx_filter = emac->rx_ts_enabled ? HWTSTAMP_FILTER_ALL : HWTSTAMP_FILTER_NONE;
 
-	return phy_do_ioctl(ndev, ifr, cmd);
+	return 0;
 }
-EXPORT_SYMBOL_GPL(icssg_ndo_ioctl);
+EXPORT_SYMBOL_GPL(icssg_ndo_get_ts_config);
 
 void icssg_ndo_get_stats64(struct net_device *ndev,
 			   struct rtnl_link_stats64 *stats)
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index e42d0fdefee1..1c1f4394ff1f 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1168,7 +1168,7 @@ static const struct net_device_ops emac_netdev_ops = {
 	.ndo_validate_addr = eth_validate_addr,
 	.ndo_tx_timeout = icssg_ndo_tx_timeout,
 	.ndo_set_rx_mode = emac_ndo_set_rx_mode,
-	.ndo_eth_ioctl = icssg_ndo_ioctl,
+	.ndo_eth_ioctl = phy_do_ioctl,
 	.ndo_get_stats64 = icssg_ndo_get_stats64,
 	.ndo_get_phys_port_name = icssg_ndo_get_phys_port_name,
 	.ndo_fix_features = emac_ndo_fix_features,
@@ -1176,6 +1176,8 @@ static const struct net_device_ops emac_netdev_ops = {
 	.ndo_vlan_rx_kill_vid = emac_ndo_vlan_rx_del_vid,
 	.ndo_bpf = emac_ndo_bpf,
 	.ndo_xdp_xmit = emac_xdp_xmit,
+	.ndo_hwtstamp_get = icssg_ndo_get_ts_config,
+	.ndo_hwtstamp_set = icssg_ndo_set_ts_config,
 };
 
 static int prueth_netdev_init(struct prueth *prueth,
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index ca8a22a4a5da..f0fa9688d9a0 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -479,7 +479,11 @@ void prueth_reset_tx_chan(struct prueth_emac *emac, int ch_num,
 void prueth_reset_rx_chan(struct prueth_rx_chn *chn,
 			  int num_flows, bool disable);
 void icssg_ndo_tx_timeout(struct net_device *ndev, unsigned int txqueue);
-int icssg_ndo_ioctl(struct net_device *ndev, struct ifreq *ifr, int cmd);
+int icssg_ndo_get_ts_config(struct net_device *ndev,
+			    struct kernel_hwtstamp_config *config);
+int icssg_ndo_set_ts_config(struct net_device *ndev,
+			    struct kernel_hwtstamp_config *config,
+			    struct netlink_ext_ack *extack);
 void icssg_ndo_get_stats64(struct net_device *ndev,
 			   struct rtnl_link_stats64 *stats);
 int icssg_ndo_get_phys_port_name(struct net_device *ndev, char *name,
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
index 5e225310c9de..2a8c8847a6bd 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
@@ -747,9 +747,11 @@ static const struct net_device_ops emac_netdev_ops = {
 	.ndo_validate_addr = eth_validate_addr,
 	.ndo_tx_timeout = icssg_ndo_tx_timeout,
 	.ndo_set_rx_mode = emac_ndo_set_rx_mode_sr1,
-	.ndo_eth_ioctl = icssg_ndo_ioctl,
+	.ndo_eth_ioctl = phy_do_ioctl,
 	.ndo_get_stats64 = icssg_ndo_get_stats64,
 	.ndo_get_phys_port_name = icssg_ndo_get_phys_port_name,
+	.ndo_hwtstamp_get = icssg_ndo_get_ts_config,
+	.ndo_hwtstamp_set = icssg_ndo_set_ts_config,
 };
 
 static int prueth_netdev_init(struct prueth *prueth,
-- 
2.47.3


