Return-Path: <netdev+bounces-152899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5569F63E3
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 11:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93A3B161167
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 10:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F60219D072;
	Wed, 18 Dec 2024 10:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="aq6NQhLr"
X-Original-To: netdev@vger.kernel.org
Received: from va-1-31.ptr.blmpb.com (va-1-31.ptr.blmpb.com [209.127.230.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D726C19CD01
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 10:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734519203; cv=none; b=GhiaIFD5CDf65C9Thx1sPhh2TUzxiLCkuFa2cA4LktapSgE+XxXDRyvLvN4DCoRN5ScOEzg3l100gitcpJOtvFJ9tQj4Wbb+mU2+aba1xqPJ/VXzZvcTHuO5/gYSsQ+wSxr3Bq9Vc85VbxcFiGcATR+MuwAavqIHsioU0I4PLZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734519203; c=relaxed/simple;
	bh=3V40DimdwjyK0CkAei4Ea9L8gC+M8AHj4ZEALo6TYcQ=;
	h=Cc:Subject:To:Content-Type:Date:Mime-Version:Message-Id:
	 References:In-Reply-To:From; b=nEVsQeFuktZlYJ33Qk5ft997oZKFl3zfp4uJFvE5LjpH7cu9NAvJiav2Ol7ADB11NsKuClkDN90j81jQXzT/yfQ/XGVcSqEKZlajnW7oS40HHBcsiqHNEI1omipq/JLPH7gyY03DRFhtBq8ZAQijGIZYlQpao1khFanw6fdqGWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=aq6NQhLr; arc=none smtp.client-ip=209.127.230.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1734519057; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Ppa5g8Lk1Z9jDR5oalLwq2lRa/WdcNc09oZaFQSC4Us=;
 b=aq6NQhLrHGWidmEefx6wKi6n+Mue/WeFbz6yNDTZojESH0LSUUwHAO+b5Y7hS7+sphyFk8
 nC4a3YY1mXqjGHAQwA2cukolqg/BaA5KIdsSakOgRJV2gbw6CRYviWoooeCSuINd4ygiL5
 94gl589NLY4LPUkjDxY4AhpbiqW0boXu7CgbVwns7MIV1Cm9gfNQIFM3NZmGqOggNCxV2n
 ygVbefdFfjlNAOrsaKKskDmAUiQHIGV+nbTnTRs2ZesI1Ay0YVIkZv5tLiYZSXsRxjidVI
 f6Z4ISMgmcvyBGbpHb/yttCx9EIcUsDNTA0jzgB5bKP3ET38aDDu/Uqw2bkcCw==
Cc: <andrew+netdev@lunn.ch>, <kuba@kernel.org>, <pabeni@redhat.com>, 
	<edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>
Subject: [PATCH v1 14/16] net-next/yunsilicon: add ndo_get_stats64
X-Original-From: Xin Tian <tianx@yunsilicon.com>
To: <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26762a90f+6e4427+vger.kernel.org+tianx@yunsilicon.com>
Date: Wed, 18 Dec 2024 18:50:54 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20241218105053.2237645-15-tianx@yunsilicon.com>
X-Mailer: git-send-email 2.25.1
References: <20241218105023.2237645-1-tianx@yunsilicon.com>
In-Reply-To: <20241218105023.2237645-1-tianx@yunsilicon.com>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Wed, 18 Dec 2024 18:50:54 +0800
From: "Xin Tian" <tianx@yunsilicon.com>

Support nic stats

 
Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
Co-developed-by: Lei Yan <Jacky@yunsilicon.com>
Signed-off-by: Xin Tian <tianx@yunsilicon.com>
---
 .../net/ethernet/yunsilicon/xsc/net/Makefile  |  2 +-
 .../net/ethernet/yunsilicon/xsc/net/main.c    | 24 ++++++++++-
 .../net/ethernet/yunsilicon/xsc/net/xsc_eth.h |  3 ++
 .../ethernet/yunsilicon/xsc/net/xsc_eth_rx.c  |  4 ++
 .../yunsilicon/xsc/net/xsc_eth_stats.c        | 42 +++++++++++++++++++
 .../yunsilicon/xsc/net/xsc_eth_stats.h        | 33 +++++++++++++++
 .../ethernet/yunsilicon/xsc/net/xsc_eth_tx.c  |  5 +++
 .../ethernet/yunsilicon/xsc/net/xsc_queue.h   |  2 +
 8 files changed, 112 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_stats.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_stats.h

diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/Makefile b/drivers/net/ethernet/yunsilicon/xsc/net/Makefile
index 7cfc2aaa2..e1cfa3cdf 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/Makefile
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/Makefile
@@ -6,4 +6,4 @@ ccflags-y += -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
 
 obj-$(CONFIG_YUNSILICON_XSC_ETH) += xsc_eth.o
 
-xsc_eth-y := main.o xsc_eth_wq.o xsc_eth_txrx.o xsc_eth_tx.o xsc_eth_rx.o
+xsc_eth-y := main.o xsc_eth_wq.o xsc_eth_txrx.o xsc_eth_tx.o xsc_eth_rx.o xsc_eth_stats.o
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/main.c b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
index 338e308a6..0c6e949b5 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/main.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
@@ -541,12 +541,15 @@ static int xsc_eth_open_qp_sq(struct xsc_channel *c,
 	struct xsc_core_device *xdev  = adapter->xdev;
 	u8 q_log_size = psq_param->sq_attr.q_log_size;
 	u8 ele_log_size = psq_param->sq_attr.ele_log_size;
+	struct xsc_stats *stats = adapter->stats;
+	struct xsc_channel_stats *channel_stats = &stats->channel_stats[c->chl_idx];
 	struct xsc_create_qp_mbox_in *in;
 	struct xsc_modify_raw_qp_mbox_in *modify_in;
 	int hw_npages;
 	int inlen;
 	int ret;
 
+	psq->stats = &channel_stats->sq[sq_idx];
 	psq_param->wq.db_numa_node = cpu_to_node(c->cpu);
 
 	ret = xsc_eth_wq_cyc_create(xdev, &psq_param->wq,
@@ -845,10 +848,13 @@ static int xsc_eth_alloc_rq(struct xsc_channel *c,
 	struct page_pool_params pagepool_params = { 0 };
 	u32 pool_size = 1 << q_log_size;
 	u8 ele_log_size = prq_param->rq_attr.ele_log_size;
+	struct xsc_stats *stats = c->adapter->stats;
+	struct xsc_channel_stats *channel_stats = &stats->channel_stats[c->chl_idx];
 	int wq_sz;
 	int i, f;
 	int ret = 0;
 
+	prq->stats = &channel_stats->rq;
 	prq_param->wq.db_numa_node = cpu_to_node(c->cpu);
 
 	ret = xsc_eth_wq_cyc_create(c->adapter->xdev, &prq_param->wq,
@@ -1634,6 +1640,13 @@ static int xsc_eth_close(struct net_device *netdev)
 	return ret;
 }
 
+static void xsc_eth_get_stats(struct net_device *netdev, struct rtnl_link_stats64 *stats)
+{
+	struct xsc_adapter *adapter = netdev_priv(netdev);
+
+	xsc_eth_fold_sw_stats64(adapter, stats);
+}
+
 static int xsc_eth_set_hw_mtu(struct xsc_core_device *xdev, u16 mtu, u16 rx_buf_sz)
 {
 	struct xsc_set_mtu_mbox_in in;
@@ -1663,6 +1676,7 @@ static const struct net_device_ops xsc_netdev_ops = {
 	.ndo_open		= xsc_eth_open,
 	.ndo_stop		= xsc_eth_close,
 	.ndo_start_xmit		= xsc_eth_xmit_start,
+	.ndo_get_stats64	= xsc_eth_get_stats,
 };
 
 static void xsc_eth_build_nic_netdev(struct xsc_adapter *adapter)
@@ -1872,16 +1886,22 @@ static void *xsc_eth_add(struct xsc_core_device *xdev)
 		goto err_cleanup_netdev;
 	}
 
+	adapter->stats = kvzalloc(sizeof(*adapter->stats), GFP_KERNEL);
+	if (!adapter->stats)
+		goto err_detach;
+
 	err = register_netdev(netdev);
 	if (err) {
 		xsc_core_warn(xdev, "register_netdev failed, err=%d\n", err);
-		goto err_detach;
+		goto err_free_stats;
 	}
 
 	xdev->netdev = (void *)netdev;
 
 	return adapter;
 
+err_free_stats:
+	kfree(adapter->stats);
 err_detach:
 	xsc_eth_detach(xdev, adapter);
 err_cleanup_netdev:
@@ -1908,7 +1928,7 @@ static void xsc_eth_remove(struct xsc_core_device *xdev, void *context)
 	xsc_core_info(adapter->xdev, "remove netdev %s entry\n", adapter->netdev->name);
 
 	unregister_netdev(adapter->netdev);
-
+	kfree(adapter->stats);
 	free_netdev(adapter->netdev);
 
 	xdev->netdev = NULL;
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
index 3e5614eb1..45d8a8cbe 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
@@ -9,6 +9,7 @@
 #include <linux/udp.h>
 #include "common/xsc_device.h"
 #include "xsc_eth_common.h"
+#include "xsc_eth_stats.h"
 
 #define XSC_INVALID_LKEY	0x100
 
@@ -48,6 +49,8 @@ struct xsc_adapter {
 
 	u32	status;
 	struct mutex	status_lock; // protect status
+
+	struct xsc_stats *stats;
 };
 
 #endif /* XSC_ETH_H */
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c
index 9926423c9..bbc8add75 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c
@@ -176,6 +176,10 @@ static inline void xsc_complete_rx_cqe(struct xsc_rq *rq,
 				       struct sk_buff *skb,
 				       struct xsc_wqe_frag_info *wi)
 {
+	struct xsc_rq_stats *stats = rq->stats;
+
+	stats->packets++;
+	stats->bytes += cqe_bcnt;
 	xsc_build_rx_skb(cqe, cqe_bcnt, rq, skb, wi);
 }
 
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_stats.c b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_stats.c
new file mode 100644
index 000000000..10a014237
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_stats.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#include "xsc_eth_stats.h"
+#include "xsc_eth.h"
+
+static inline int xsc_get_netdev_max_channels(struct xsc_adapter *adapter)
+{
+	struct net_device *netdev = adapter->netdev;
+
+	return min_t(unsigned int, netdev->num_rx_queues,
+		     netdev->num_tx_queues);
+}
+
+static inline int xsc_get_netdev_max_tc(struct xsc_adapter *adapter)
+{
+	return adapter->nic_param.num_tc;
+}
+
+void xsc_eth_fold_sw_stats64(struct xsc_adapter *adapter, struct rtnl_link_stats64 *s)
+{
+	int i, j;
+
+	for (i = 0; i < xsc_get_netdev_max_channels(adapter); i++) {
+		struct xsc_channel_stats *channel_stats = &adapter->stats->channel_stats[i];
+		struct xsc_rq_stats *rq_stats = &channel_stats->rq;
+
+		s->rx_packets   += rq_stats->packets;
+		s->rx_bytes     += rq_stats->bytes;
+
+		for (j = 0; j < xsc_get_netdev_max_tc(adapter); j++) {
+			struct xsc_sq_stats *sq_stats = &channel_stats->sq[j];
+
+			s->tx_packets    += sq_stats->packets;
+			s->tx_bytes      += sq_stats->bytes;
+			s->tx_dropped    += sq_stats->dropped;
+		}
+	}
+}
+
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_stats.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_stats.h
new file mode 100644
index 000000000..8e97b5507
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_stats.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef XSC_EN_STATS_H
+#define XSC_EN_STATS_H
+
+#include "xsc_eth_common.h"
+
+struct xsc_rq_stats {
+	u64 packets;
+	u64 bytes;
+};
+
+struct xsc_sq_stats {
+	u64 packets;
+	u64 bytes;
+	u64 dropped;
+};
+
+struct xsc_channel_stats {
+	struct xsc_sq_stats sq[XSC_MAX_NUM_TC];
+	struct xsc_rq_stats rq;
+} ____cacheline_aligned_in_smp;
+
+struct xsc_stats {
+	struct xsc_channel_stats channel_stats[XSC_ETH_MAX_NUM_CHANNELS];
+};
+
+void xsc_eth_fold_sw_stats64(struct xsc_adapter *adapter, struct rtnl_link_stats64 *s);
+
+#endif /* XSC_EN_STATS_H */
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_tx.c b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_tx.c
index 67e68485e..2aee1d97c 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_tx.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_tx.c
@@ -201,6 +201,7 @@ static uint32_t xsc_eth_xmit_frame(struct sk_buff *skb,
 	struct xsc_send_wqe_ctrl_seg *cseg;
 	struct xsc_wqe_data_seg *dseg;
 	struct xsc_tx_wqe_info *wi;
+	struct xsc_sq_stats *stats = sq->stats;
 	struct xsc_core_device *xdev = sq->cq.xdev;
 	u16 ds_cnt;
 	u16 mss, ihs, headlen;
@@ -219,11 +220,13 @@ static uint32_t xsc_eth_xmit_frame(struct sk_buff *skb,
 		mss       = skb_shinfo(skb)->gso_size;
 		ihs       = xsc_tx_get_gso_ihs(sq, skb);
 		num_bytes = skb->len;
+		stats->packets += skb_shinfo(skb)->gso_segs;
 	} else {
 		opcode    = XSC_OPCODE_RAW;
 		mss       = 0;
 		ihs       = 0;
 		num_bytes = skb->len;
+		stats->packets++;
 	}
 
 	/*linear data in skb*/
@@ -261,10 +264,12 @@ static uint32_t xsc_eth_xmit_frame(struct sk_buff *skb,
 
 	xsc_txwqe_complete(sq, skb, opcode, ds_cnt, num_wqebbs, num_bytes,
 			   num_dma, wi);
+	stats->bytes     += num_bytes;
 
 	return NETDEV_TX_OK;
 
 err_drop:
+	stats->dropped++;
 	dev_kfree_skb_any(skb);
 
 	return NETDEV_TX_OK;
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h
index a6f0ec807..43f947f43 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h
@@ -156,6 +156,7 @@ struct xsc_rq {
 
 	unsigned long	state;
 	struct work_struct  recover_work;
+	struct xsc_rq_stats *stats;
 
 	u32 hw_mtu;
 	u32 frags_sz;
@@ -204,6 +205,7 @@ struct xsc_sq {
 	/* read only */
 	struct xsc_wq_cyc         wq;
 	u32                        dma_fifo_mask;
+	struct xsc_sq_stats     *stats;
 	struct {
 		struct xsc_sq_dma         *dma_fifo;
 		struct xsc_tx_wqe_info    *wqe_info;
-- 
2.43.0

