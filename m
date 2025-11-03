Return-Path: <netdev+bounces-235209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CF8C2D78E
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 18:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BC5C234AA5F
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 17:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AE731B132;
	Mon,  3 Nov 2025 17:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IX7/AUkR"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36A8262FC0
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 17:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762190956; cv=none; b=dX7WV66xp8slrpLgXAvXushbWN71h5AwTe2NfooVGZhyuWzE7JahB9j8t2nyzenPMvO3W+FY1VLdHK0trd1WOFP4ZETsJSo/bHrlm82lERYj6uludv71v2RttHU8HI1v0Ry4CO/8fEvm6ndbXT+9OlZhBFkKpwmTnKjMXNaAIpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762190956; c=relaxed/simple;
	bh=YKRErWORwKVAsnTNpZ7p+RW0AifiGZBQfL10YsJFYcU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tR0Q1sFkUO4+btaNhTzsh6hMgxy9fRAzGIB8jgmqt231IkmrTmAfcIvyKMLeG0TqO4KLTsz4FGj35v5DV2OJO//dH5i0w3aNkSIkKznP9oYNTTR4irIgzfQWgk6T39+vclwEEy/NJraFrFuLWCXCNTFVWvx/q/E6WXILdRurC/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IX7/AUkR; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762190950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mIKfryWxBTrEGxJa+672W4q/8gnF2VG+91IZ460u3cg=;
	b=IX7/AUkRsNAKsjouaDcdAZvJJPV9lLWbl8ZLtyFL6v7SLt4KlCYxdvlDZx0BY0RfFq1e+i
	AgOLNzWjv0c+3tT07qlDrTVo2/vhjy6xapxSInYFWjnGsQJUALlzRGBdRPcsKC5q1ILSgR
	XZKXhyLeznMRRdLKdbmifYgeZ/sKNd8=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: netdev@vger.kernel.org,
	Kory Maincent <kory.maincent@bootlin.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [PATCH net-next v2] ti: netcp: convert to ndo_hwtstamp callbacks
Date: Mon,  3 Nov 2025 17:29:02 +0000
Message-ID: <20251103172902.3538392-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Convert TI NetCP driver to use ndo_hwtstamp_get()/ndo_hwtstamp_set()
callbacks. The logic is slightly changed, because I believe the original
logic was not really correct. Config reading part is using the very
first module to get the configuration instead of iterating over all of
them and keep the last one as the configuration is supposed to be identical
for all modules. HW timestamp config set path is now trying to configure
all modules, but in case of error from one module it adds extack
message. This way the configuration will be as synchronized as possible.

There are only 2 modules using netcp core infrastructure, and both use
the very same function to configure HW timestamping, so no actual
difference in behavior is expected.

Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
v1 -> v2:
- avoid changing logic and hiding errors. keep the call failing after
  the first error
---
 drivers/net/ethernet/ti/netcp.h       |  5 ++
 drivers/net/ethernet/ti/netcp_core.c  | 58 +++++++++++++++++++++
 drivers/net/ethernet/ti/netcp_ethss.c | 72 +++++++++++++++------------
 3 files changed, 103 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/ti/netcp.h b/drivers/net/ethernet/ti/netcp.h
index 7007eb8bed36..b9cbd3b4a8a2 100644
--- a/drivers/net/ethernet/ti/netcp.h
+++ b/drivers/net/ethernet/ti/netcp.h
@@ -207,6 +207,11 @@ struct netcp_module {
 	int	(*del_vid)(void *intf_priv, int vid);
 	int	(*ioctl)(void *intf_priv, struct ifreq *req, int cmd);
 	int	(*set_rx_mode)(void *intf_priv, bool promisc);
+	int	(*hwtstamp_get)(void *intf_priv,
+				struct kernel_hwtstamp_config *cfg);
+	int	(*hwtstamp_set)(void *intf_priv,
+				struct kernel_hwtstamp_config *cfg,
+				struct netlink_ext_ack *extack);
 
 	/* used internally */
 	struct list_head	module_list;
diff --git a/drivers/net/ethernet/ti/netcp_core.c b/drivers/net/ethernet/ti/netcp_core.c
index 857820657bac..cee2686a4893 100644
--- a/drivers/net/ethernet/ti/netcp_core.c
+++ b/drivers/net/ethernet/ti/netcp_core.c
@@ -1781,6 +1781,62 @@ static int netcp_ndo_stop(struct net_device *ndev)
 	return 0;
 }
 
+static int netcp_ndo_hwtstamp_get(struct net_device *ndev,
+				  struct kernel_hwtstamp_config *config)
+{
+	struct netcp_intf *netcp = netdev_priv(ndev);
+	struct netcp_intf_modpriv *intf_modpriv;
+	struct netcp_module *module;
+	int err = -EOPNOTSUPP;
+
+	if (!netif_running(ndev))
+		return -EINVAL;
+
+	for_each_module(netcp, intf_modpriv) {
+		module = intf_modpriv->netcp_module;
+		if (!module->hwtstamp_get)
+			continue;
+
+		err = module->hwtstamp_get(intf_modpriv->module_priv, config);
+		break;
+	}
+
+	return err;
+}
+
+static int netcp_ndo_hwtstamp_set(struct net_device *ndev,
+				  struct kernel_hwtstamp_config *config,
+				  struct netlink_ext_ack *extack)
+{
+	struct netcp_intf *netcp = netdev_priv(ndev);
+	struct netcp_intf_modpriv *intf_modpriv;
+	struct netcp_module *module;
+	int ret = -1, err = -EOPNOTSUPP;
+
+	if (!netif_running(ndev))
+		return -EINVAL;
+
+	for_each_module(netcp, intf_modpriv) {
+		module = intf_modpriv->netcp_module;
+		if (!module->hwtstamp_set)
+			continue;
+
+		err = module->hwtstamp_set(intf_modpriv->module_priv, config,
+					   extack);
+		if ((err < 0) && (err != -EOPNOTSUPP)) {
+			NL_SET_ERR_MSG_WEAK_MOD(extack,
+						"At least one module failed to setup HW timestamps");
+			ret = err;
+			goto out;
+		}
+		if (err == 0)
+			ret = err;
+	}
+
+out:
+	return (ret == 0) ? 0 : err;
+}
+
 static int netcp_ndo_ioctl(struct net_device *ndev,
 			   struct ifreq *req, int cmd)
 {
@@ -1952,6 +2008,8 @@ static const struct net_device_ops netcp_netdev_ops = {
 	.ndo_tx_timeout		= netcp_ndo_tx_timeout,
 	.ndo_select_queue	= dev_pick_tx_zero,
 	.ndo_setup_tc		= netcp_setup_tc,
+	.ndo_hwtstamp_get	= netcp_ndo_hwtstamp_get,
+	.ndo_hwtstamp_set	= netcp_ndo_hwtstamp_set,
 };
 
 static int netcp_create_interface(struct netcp_device *netcp_device,
diff --git a/drivers/net/ethernet/ti/netcp_ethss.c b/drivers/net/ethernet/ti/netcp_ethss.c
index 55a1a96cd834..0ae44112812c 100644
--- a/drivers/net/ethernet/ti/netcp_ethss.c
+++ b/drivers/net/ethernet/ti/netcp_ethss.c
@@ -2591,20 +2591,26 @@ static int gbe_rxtstamp(struct gbe_intf *gbe_intf, struct netcp_packet *p_info)
 	return 0;
 }
 
-static int gbe_hwtstamp_get(struct gbe_intf *gbe_intf, struct ifreq *ifr)
+static int gbe_hwtstamp_get(void *intf_priv, struct kernel_hwtstamp_config *cfg)
 {
-	struct gbe_priv *gbe_dev = gbe_intf->gbe_dev;
-	struct cpts *cpts = gbe_dev->cpts;
-	struct hwtstamp_config cfg;
+	struct gbe_intf *gbe_intf = intf_priv;
+	struct gbe_priv *gbe_dev;
+	struct phy_device *phy;
+
+	gbe_dev = gbe_intf->gbe_dev;
 
-	if (!cpts)
+	if (!gbe_dev->cpts)
+		return -EOPNOTSUPP;
+
+	phy = gbe_intf->slave->phy;
+	if (phy_has_hwtstamp(phy))
 		return -EOPNOTSUPP;
 
-	cfg.flags = 0;
-	cfg.tx_type = gbe_dev->tx_ts_enabled ? HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
-	cfg.rx_filter = gbe_dev->rx_ts_enabled;
+	cfg->flags = 0;
+	cfg->tx_type = gbe_dev->tx_ts_enabled ? HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
+	cfg->rx_filter = gbe_dev->rx_ts_enabled;
 
-	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
+	return 0;
 }
 
 static void gbe_hwtstamp(struct gbe_intf *gbe_intf)
@@ -2637,19 +2643,23 @@ static void gbe_hwtstamp(struct gbe_intf *gbe_intf)
 	writel(ctl,    GBE_REG_ADDR(slave, port_regs, ts_ctl_ltype2));
 }
 
-static int gbe_hwtstamp_set(struct gbe_intf *gbe_intf, struct ifreq *ifr)
+static int gbe_hwtstamp_set(void *intf_priv, struct kernel_hwtstamp_config *cfg,
+			    struct netlink_ext_ack *extack)
 {
-	struct gbe_priv *gbe_dev = gbe_intf->gbe_dev;
-	struct cpts *cpts = gbe_dev->cpts;
-	struct hwtstamp_config cfg;
+	struct gbe_intf *gbe_intf = intf_priv;
+	struct gbe_priv *gbe_dev;
+	struct phy_device *phy;
 
-	if (!cpts)
+	gbe_dev = gbe_intf->gbe_dev;
+
+	if (!gbe_dev->cpts)
 		return -EOPNOTSUPP;
 
-	if (copy_from_user(&cfg, ifr->ifr_data, sizeof(cfg)))
-		return -EFAULT;
+	phy = gbe_intf->slave->phy;
+	if (phy_has_hwtstamp(phy))
+		return phy->mii_ts->hwtstamp(phy->mii_ts, cfg, extack);
 
-	switch (cfg.tx_type) {
+	switch (cfg->tx_type) {
 	case HWTSTAMP_TX_OFF:
 		gbe_dev->tx_ts_enabled = 0;
 		break;
@@ -2660,7 +2670,7 @@ static int gbe_hwtstamp_set(struct gbe_intf *gbe_intf, struct ifreq *ifr)
 		return -ERANGE;
 	}
 
-	switch (cfg.rx_filter) {
+	switch (cfg->rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
 		gbe_dev->rx_ts_enabled = HWTSTAMP_FILTER_NONE;
 		break;
@@ -2668,7 +2678,7 @@ static int gbe_hwtstamp_set(struct gbe_intf *gbe_intf, struct ifreq *ifr)
 	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
 	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
 		gbe_dev->rx_ts_enabled = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
-		cfg.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
+		cfg->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
 		break;
 	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
 	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
@@ -2680,7 +2690,7 @@ static int gbe_hwtstamp_set(struct gbe_intf *gbe_intf, struct ifreq *ifr)
 	case HWTSTAMP_FILTER_PTP_V2_SYNC:
 	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
 		gbe_dev->rx_ts_enabled = HWTSTAMP_FILTER_PTP_V2_EVENT;
-		cfg.rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
+		cfg->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
 		break;
 	default:
 		return -ERANGE;
@@ -2688,7 +2698,7 @@ static int gbe_hwtstamp_set(struct gbe_intf *gbe_intf, struct ifreq *ifr)
 
 	gbe_hwtstamp(gbe_intf);
 
-	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
+	return 0;
 }
 
 static void gbe_register_cpts(struct gbe_priv *gbe_dev)
@@ -2745,12 +2755,15 @@ static inline void gbe_unregister_cpts(struct gbe_priv *gbe_dev)
 {
 }
 
-static inline int gbe_hwtstamp_get(struct gbe_intf *gbe_intf, struct ifreq *req)
+static inline int gbe_hwtstamp_get(struct gbe_intf *gbe_intf,
+				   struct kernel_hwtstamp_config *cfg)
 {
 	return -EOPNOTSUPP;
 }
 
-static inline int gbe_hwtstamp_set(struct gbe_intf *gbe_intf, struct ifreq *req)
+static inline int gbe_hwtstamp_set(struct gbe_intf *gbe_intf,
+				   struct kernel_hwtstamp_config *cfg,
+				   struct netlink_ext_ack *extack)
 {
 	return -EOPNOTSUPP;
 }
@@ -2816,15 +2829,6 @@ static int gbe_ioctl(void *intf_priv, struct ifreq *req, int cmd)
 	struct gbe_intf *gbe_intf = intf_priv;
 	struct phy_device *phy = gbe_intf->slave->phy;
 
-	if (!phy_has_hwtstamp(phy)) {
-		switch (cmd) {
-		case SIOCGHWTSTAMP:
-			return gbe_hwtstamp_get(gbe_intf, req);
-		case SIOCSHWTSTAMP:
-			return gbe_hwtstamp_set(gbe_intf, req);
-		}
-	}
-
 	if (phy)
 		return phy_mii_ioctl(phy, req, cmd);
 
@@ -3824,6 +3828,8 @@ static struct netcp_module gbe_module = {
 	.add_vid	= gbe_add_vid,
 	.del_vid	= gbe_del_vid,
 	.ioctl		= gbe_ioctl,
+	.hwtstamp_get	= gbe_hwtstamp_get,
+	.hwtstamp_set	= gbe_hwtstamp_set,
 };
 
 static struct netcp_module xgbe_module = {
@@ -3841,6 +3847,8 @@ static struct netcp_module xgbe_module = {
 	.add_vid	= gbe_add_vid,
 	.del_vid	= gbe_del_vid,
 	.ioctl		= gbe_ioctl,
+	.hwtstamp_get	= gbe_hwtstamp_get,
+	.hwtstamp_set	= gbe_hwtstamp_set,
 };
 
 static int __init keystone_gbe_init(void)
-- 
2.47.3


