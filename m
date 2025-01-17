Return-Path: <netdev+bounces-159447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD759A15854
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 20:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF2D1169450
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 19:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577711A9B4D;
	Fri, 17 Jan 2025 19:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtN87nwj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327631A841B
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 19:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737143300; cv=none; b=NbHSoXkJnvRz5C+fvxqaOastA6bEDQo09IPZAQDsXkpVQ6c3hY2ZxzXHrU8l9Oo8ffwSoJDw5Rgr39g2tkad6h8x9pVxIOm7G8iDj8srJFW4QybQOu1hN/J9ImIcmcs7C1KhItJXTiGCkcgLymMzVTzlUe6g+cqUyhtd9Y/7GuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737143300; c=relaxed/simple;
	bh=5ZJjyVHRgYH4LL4KGXuoxxv53AM948WrrpGnSYWiMg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yflbdckcv/+/vwA3ue98zvqg17RGaGpmxMGPtfTOGTA+42ZPfBduisx7i0RD+dMZMlHu6uywzaQP8vBNt+FSZcGtiJhwrdkddVWcBWmyHeG/ZxOHG6UPE3Cq8jbRnFpj3mVvEW85Fhl3AsTtatijvZsJ2UACzIBPtHnV2luI6/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtN87nwj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5899FC4CEE3;
	Fri, 17 Jan 2025 19:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737143299;
	bh=5ZJjyVHRgYH4LL4KGXuoxxv53AM948WrrpGnSYWiMg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RtN87nwjlOjIwPfrPpn99we9EYl6c4GxWUkXpYCUQf+ymvUaNMV0wlMMOKba+oxir
	 NV12NYPGw6emShFkyuFWfd8abd7WAdwGrtp9XZmESF7CdFdh27Ta0UYT+k/nKn/mCt
	 pflGTrNdSNPFihGD2Uuz5sufv52Oa0vQi8l1AsZCT6Om3mbnfuJgTGtPU3zM0L2cH+
	 syYx5xwFZdtU9RQNrGfCqiJL/4VGMD6S4oWUjs3Kvo4vxw8n1TbWc1ZwKF34K+V5pg
	 9GOIn82OVdIa3wQcYsb0AW2Z6sRrX5q91l4GvLUSa2r/KxKTsSD6825iH4ElZMwQKY
	 9g0vjZdc8vJ6Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	ap420073@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/6] net: move HDS config from ethtool state
Date: Fri, 17 Jan 2025 11:48:10 -0800
Message-ID: <20250117194815.1514410-2-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250117194815.1514410-1-kuba@kernel.org>
References: <20250117194815.1514410-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Separate the HDS config from the ethtool state struct.
The HDS config contains just simple parameters, not state.
Having it as a separate struct will make it easier to clone / copy
and also long term potentially make it per-queue.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/ethtool.h                           |  4 ----
 include/linux/netdevice.h                         |  3 +++
 include/net/netdev_queues.h                       | 10 ++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         |  4 ++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  5 +++--
 drivers/net/netdevsim/ethtool.c                   |  9 +++++----
 drivers/net/netdevsim/netdev.c                    | 10 +++++-----
 net/core/dev.c                                    | 10 ++++++++--
 net/core/devmem.c                                 |  4 ++--
 net/ethtool/rings.c                               |  8 +++++---
 10 files changed, 43 insertions(+), 24 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index e4136b0df892..ddae13cfd9ca 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1164,16 +1164,12 @@ int ethtool_virtdev_set_link_ksettings(struct net_device *dev,
  * @rss_ctx:		XArray of custom RSS contexts
  * @rss_lock:		Protects entries in @rss_ctx.  May be taken from
  *			within RTNL.
- * @hds_thresh:		HDS Threshold value.
- * @hds_config:		HDS value from userspace.
  * @wol_enabled:	Wake-on-LAN is enabled
  * @module_fw_flash_in_progress: Module firmware flashing is in progress.
  */
 struct ethtool_netdev_state {
 	struct xarray		rss_ctx;
 	struct mutex		rss_lock;
-	u32			hds_thresh;
-	u8			hds_config;
 	unsigned		wol_enabled:1;
 	unsigned		module_fw_flash_in_progress:1;
 };
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 8308d9c75918..173a8b3a9eb2 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -63,6 +63,7 @@ struct dsa_port;
 struct ip_tunnel_parm_kern;
 struct macsec_context;
 struct macsec_ops;
+struct netdev_config;
 struct netdev_name_node;
 struct sd_flow_limit;
 struct sfp_bus;
@@ -2410,6 +2411,8 @@ struct net_device {
 	const struct udp_tunnel_nic_info	*udp_tunnel_nic_info;
 	struct udp_tunnel_nic	*udp_tunnel_nic;
 
+	/** @cfg: net_device queue-related configuration */
+	struct netdev_config	*cfg;
 	struct ethtool_netdev_state *ethtool;
 
 	/* protected by rtnl_lock */
diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index 5ca019d294ca..b02bb9f109d5 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -4,6 +4,16 @@
 
 #include <linux/netdevice.h>
 
+/**
+ * struct netdev_config - queue-related configuration for a netdev
+ * @hds_thresh:		HDS Threshold value.
+ * @hds_config:		HDS value from userspace.
+ */
+struct netdev_config {
+	u32	hds_thresh;
+	u8	hds_config;
+};
+
 /* See the netdev.yaml spec for definition of each statistic */
 struct netdev_queue_stats_rx {
 	u64 bytes;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 748c9b1ea701..0998b20578b4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4610,7 +4610,7 @@ void bnxt_set_tpa_flags(struct bnxt *bp)
 static void bnxt_init_ring_params(struct bnxt *bp)
 {
 	bp->rx_copybreak = BNXT_DEFAULT_RX_COPYBREAK;
-	bp->dev->ethtool->hds_thresh = BNXT_DEFAULT_RX_COPYBREAK;
+	bp->dev->cfg->hds_thresh = BNXT_DEFAULT_RX_COPYBREAK;
 }
 
 /* bp->rx_ring_size, bp->tx_ring_size, dev->mtu, BNXT_FLAG_{G|L}RO flags must
@@ -6585,7 +6585,7 @@ static void bnxt_hwrm_update_rss_hash_cfg(struct bnxt *bp)
 
 static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 {
-	u16 hds_thresh = (u16)bp->dev->ethtool->hds_thresh;
+	u16 hds_thresh = (u16)bp->dev->cfg->hds_thresh;
 	struct hwrm_vnic_plcmodes_cfg_input *req;
 	int rc;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 65a20931c579..0a6d47d4d66b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -24,6 +24,7 @@
 #include <linux/ptp_clock_kernel.h>
 #include <linux/net_tstamp.h>
 #include <linux/timecounter.h>
+#include <net/netdev_queues.h>
 #include <net/netlink.h>
 #include "bnxt_hsi.h"
 #include "bnxt.h"
@@ -834,7 +835,7 @@ static void bnxt_get_ringparam(struct net_device *dev,
 	ering->rx_jumbo_pending = bp->rx_agg_ring_size;
 	ering->tx_pending = bp->tx_ring_size;
 
-	kernel_ering->hds_thresh = dev->ethtool->hds_thresh;
+	kernel_ering->hds_thresh = dev->cfg->hds_thresh;
 	kernel_ering->hds_thresh_max = BNXT_HDS_THRESHOLD_MAX;
 }
 
@@ -852,7 +853,7 @@ static int bnxt_set_ringparam(struct net_device *dev,
 	    (ering->tx_pending < BNXT_MIN_TX_DESC_CNT))
 		return -EINVAL;
 
-	hds_config_mod = tcp_data_split != dev->ethtool->hds_config;
+	hds_config_mod = tcp_data_split != dev->cfg->hds_config;
 	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_DISABLED && hds_config_mod)
 		return -EINVAL;
 
diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
index 12163635b759..189793debdb7 100644
--- a/drivers/net/netdevsim/ethtool.c
+++ b/drivers/net/netdevsim/ethtool.c
@@ -3,6 +3,7 @@
 
 #include <linux/debugfs.h>
 #include <linux/random.h>
+#include <net/netdev_queues.h>
 
 #include "netdevsim.h"
 
@@ -71,8 +72,8 @@ static void nsim_get_ringparam(struct net_device *dev,
 	struct netdevsim *ns = netdev_priv(dev);
 
 	memcpy(ring, &ns->ethtool.ring, sizeof(ns->ethtool.ring));
-	kernel_ring->tcp_data_split = dev->ethtool->hds_config;
-	kernel_ring->hds_thresh = dev->ethtool->hds_thresh;
+	kernel_ring->tcp_data_split = dev->cfg->hds_config;
+	kernel_ring->hds_thresh = dev->cfg->hds_thresh;
 	kernel_ring->hds_thresh_max = NSIM_HDS_THRESHOLD_MAX;
 
 	if (kernel_ring->tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_UNKNOWN)
@@ -190,8 +191,8 @@ static void nsim_ethtool_ring_init(struct netdevsim *ns)
 	ns->ethtool.ring.rx_mini_max_pending = 4096;
 	ns->ethtool.ring.tx_max_pending = 4096;
 
-	ns->netdev->ethtool->hds_config = ETHTOOL_TCP_DATA_SPLIT_UNKNOWN;
-	ns->netdev->ethtool->hds_thresh = 0;
+	ns->netdev->cfg->hds_config = ETHTOOL_TCP_DATA_SPLIT_UNKNOWN;
+	ns->netdev->cfg->hds_thresh = 0;
 }
 
 void nsim_ethtool_init(struct netdevsim *ns)
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index f92b05ccdca9..42f247cbdcee 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -55,10 +55,10 @@ static int nsim_forward_skb(struct net_device *dev, struct sk_buff *skb,
 static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct netdevsim *ns = netdev_priv(dev);
-	struct ethtool_netdev_state *ethtool;
 	struct net_device *peer_dev;
 	unsigned int len = skb->len;
 	struct netdevsim *peer_ns;
+	struct netdev_config *cfg;
 	struct nsim_rq *rq;
 	int rxq;
 
@@ -76,11 +76,11 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		rxq = rxq % peer_dev->num_rx_queues;
 	rq = peer_ns->rq[rxq];
 
-	ethtool = peer_dev->ethtool;
+	cfg = peer_dev->cfg;
 	if (skb_is_nonlinear(skb) &&
-	    (ethtool->hds_config != ETHTOOL_TCP_DATA_SPLIT_ENABLED ||
-	     (ethtool->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
-	      ethtool->hds_thresh > len)))
+	    (cfg->hds_config != ETHTOOL_TCP_DATA_SPLIT_ENABLED ||
+	     (cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
+	      cfg->hds_thresh > len)))
 		skb_linearize(skb);
 
 	skb_tx_timestamp(skb);
diff --git a/net/core/dev.c b/net/core/dev.c
index fe5f5855593d..5bcf44e3bc6c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -106,6 +106,7 @@
 #include <net/dst.h>
 #include <net/dst_metadata.h>
 #include <net/gro.h>
+#include <net/netdev_queues.h>
 #include <net/pkt_sched.h>
 #include <net/pkt_cls.h>
 #include <net/checksum.h>
@@ -9716,7 +9717,7 @@ int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
 	if (!dev->netdev_ops->ndo_bpf)
 		return -EOPNOTSUPP;
 
-	if (dev->ethtool->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
+	if (dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
 	    bpf->command == XDP_SETUP_PROG &&
 	    bpf->prog && !bpf->prog->aux->xdp_has_frags) {
 		NL_SET_ERR_MSG(bpf->extack,
@@ -9761,7 +9762,7 @@ static int dev_xdp_install(struct net_device *dev, enum bpf_xdp_mode mode,
 	struct netdev_bpf xdp;
 	int err;
 
-	if (dev->ethtool->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
+	if (dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
 	    prog && !prog->aux->xdp_has_frags) {
 		NL_SET_ERR_MSG(extack, "unable to install XDP to device using tcp-data-split");
 		return -EBUSY;
@@ -11539,6 +11540,10 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 	if (!dev->ethtool)
 		goto free_all;
 
+	dev->cfg = kzalloc(sizeof(*dev->cfg), GFP_KERNEL_ACCOUNT);
+	if (!dev->cfg)
+		goto free_all;
+
 	napi_config_sz = array_size(maxqs, sizeof(*dev->napi_config));
 	dev->napi_config = kvzalloc(napi_config_sz, GFP_KERNEL_ACCOUNT);
 	if (!dev->napi_config)
@@ -11595,6 +11600,7 @@ void free_netdev(struct net_device *dev)
 
 	mutex_destroy(&dev->lock);
 
+	kfree(dev->cfg);
 	kfree(dev->ethtool);
 	netif_free_tx_queues(dev);
 	netif_free_rx_queues(dev);
diff --git a/net/core/devmem.c b/net/core/devmem.c
index c971b8aceac8..3bba3f018df0 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -141,12 +141,12 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 		return -ERANGE;
 	}
 
-	if (dev->ethtool->hds_config != ETHTOOL_TCP_DATA_SPLIT_ENABLED) {
+	if (dev->cfg->hds_config != ETHTOOL_TCP_DATA_SPLIT_ENABLED) {
 		NL_SET_ERR_MSG(extack, "tcp-data-split is disabled");
 		return -EINVAL;
 	}
 
-	if (dev->ethtool->hds_thresh) {
+	if (dev->cfg->hds_thresh) {
 		NL_SET_ERR_MSG(extack, "hds-thresh is not zero");
 		return -EINVAL;
 	}
diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
index d8cd4e4d7762..7a3c2a2dff12 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <net/netdev_queues.h>
+
 #include "netlink.h"
 #include "common.h"
 
@@ -219,7 +221,7 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 
 	dev->ethtool_ops->get_ringparam(dev, &ringparam,
 					&kernel_ringparam, info->extack);
-	kernel_ringparam.tcp_data_split = dev->ethtool->hds_config;
+	kernel_ringparam.tcp_data_split = dev->cfg->hds_config;
 
 	ethnl_update_u32(&ringparam.rx_pending, tb[ETHTOOL_A_RINGS_RX], &mod);
 	ethnl_update_u32(&ringparam.rx_mini_pending,
@@ -295,8 +297,8 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 	ret = dev->ethtool_ops->set_ringparam(dev, &ringparam,
 					      &kernel_ringparam, info->extack);
 	if (!ret) {
-		dev->ethtool->hds_config = kernel_ringparam.tcp_data_split;
-		dev->ethtool->hds_thresh = kernel_ringparam.hds_thresh;
+		dev->cfg->hds_config = kernel_ringparam.tcp_data_split;
+		dev->cfg->hds_thresh = kernel_ringparam.hds_thresh;
 	}
 
 	return ret < 0 ? ret : 1;
-- 
2.48.1


