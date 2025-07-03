Return-Path: <netdev+bounces-203679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D50AF6C1A
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 09:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BC904E1A96
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 07:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D34299A85;
	Thu,  3 Jul 2025 07:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="MeWaz+N6"
X-Original-To: netdev@vger.kernel.org
Received: from sg-1-13.ptr.blmpb.com (sg-1-13.ptr.blmpb.com [118.26.132.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD61190679
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 07:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751529269; cv=none; b=NKF8hNjejTgpfbUnrAf5jrFVO5UG/SWPb/76kPEvHePwJIUqac0clv4sUKnfPHSz2837/jFyLZJYj1tboYvH5TnVgalKWu/2qTM1ruQD592dp9I/plv9CArM5JdYf6xC1KnM5vGYi5y1X2/m3vMQ6eqoKXnP3Z8fN7RcVxYjt5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751529269; c=relaxed/simple;
	bh=AnVCARI1rD2MdTR5RdhbfZqdJKvrqfHUncSN1IoWVWM=;
	h=Message-Id:Cc:From:Subject:Mime-Version:Content-Type:To:Date:
	 References:In-Reply-To; b=CCpEjmLqRSBmaiyXeAevVRNlScnEBjxUTnHm3/I0qgw3LRCijXC8DFcfGdwSOmV97YhFNAh1pGlQLLIXjvbgeX9LifY/0IDbomMBptPwsYYozvFuKHVAQuzRkF/KyCiMuwEWyncuut3BltOR1kGEzfzsUW/ITc+mQFAxQ829xX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=MeWaz+N6; arc=none smtp.client-ip=118.26.132.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1751529260; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=SB3xm1zy/p2CY3C8K4woaxM7eQfJhmhxe98o0wQMVSM=;
 b=MeWaz+N6slCbMQvulNDFoHiFfvnKevyf9gfmf1MzOhDwgksAP4QUDrSm8rBYzHnpc8VslG
 g585/ZhKNkaKg17HQQ5jsKA7qt85+yI1WKKEAziVGO9U+rhh21EFHKhGplpQzRKQiLQJKQ
 6ZnpZmjgR4UxSlO84mZVXp+XW9V+K40wuiMZTuBqPbTee9xI8DOoU4P5ZwHwZDlotFQPte
 d6YsDLBbm6C59QIupX36GLXsQvu3r2ycktCUdk88/2wBZgjPiLiz0dPVJP6hk38PsQNrLR
 VAhSaEpGOtmUPaPRM177781B5FbzvGZ8EDr1Q4c61IVUSuKVjxN4Hu44GMQHdA==
Message-Id: <20250703075416.3488773-15-tianx@yunsilicon.com>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Thu, 03 Jul 2025 15:54:18 +0800
X-Mailer: git-send-email 2.25.1
Cc: <leon@kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <jacky@yunsilicon.com>, 
	<horms@kernel.org>, <parthiban.veerasooran@microchip.com>, 
	<masahiroy@kernel.org>, <kalesh-anakkur.purayil@broadcom.com>, 
	<geert+renesas@glider.be>, <pabeni@redhat.com>, <geert@linux-m68k.org>
From: "Xin Tian" <tianx@yunsilicon.com>
Subject: [PATCH net-next v12 14/14] xsc: add ndo_get_stats64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Original-From: Xin Tian <tianx@yunsilicon.com>
X-Lms-Return-Path: <lba+26866372a+beeb24+vger.kernel.org+tianx@yunsilicon.com>
To: <netdev@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Date: Thu, 03 Jul 2025 15:54:18 +0800
References: <20250703075341.3488773-1-tianx@yunsilicon.com>
In-Reply-To: <20250703075341.3488773-1-tianx@yunsilicon.com>

Added basic network interface statistics.

Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
Co-developed-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Xin Tian <tianx@yunsilicon.com>
---
 .../net/ethernet/yunsilicon/xsc/net/Makefile  |  2 +-
 .../net/ethernet/yunsilicon/xsc/net/main.c    | 31 ++++++++++++-
 .../net/ethernet/yunsilicon/xsc/net/xsc_eth.h |  3 ++
 .../ethernet/yunsilicon/xsc/net/xsc_eth_rx.c  |  4 ++
 .../yunsilicon/xsc/net/xsc_eth_stats.c        | 46 +++++++++++++++++++
 .../yunsilicon/xsc/net/xsc_eth_stats.h        | 34 ++++++++++++++
 .../ethernet/yunsilicon/xsc/net/xsc_eth_tx.c  |  5 ++
 .../ethernet/yunsilicon/xsc/net/xsc_queue.h   |  2 +
 8 files changed, 124 insertions(+), 3 deletions(-)
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
index 3341d3cf1..35dce2ecd 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/main.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
@@ -559,15 +559,20 @@ static int xsc_eth_open_qp_sq(struct xsc_channel *c,
 	u8 ele_log_size = psq_param->sq_attr.ele_log_size;
 	u8 q_log_size = psq_param->sq_attr.q_log_size;
 	struct xsc_modify_raw_qp_mbox_in *modify_in;
+	struct xsc_channel_stats *channel_stats;
 	struct xsc_create_qp_mbox_in *in;
 	struct xsc_core_device *xdev;
 	struct xsc_adapter *adapter;
+	struct xsc_stats *stats;
 	unsigned int hw_npages;
 	int inlen;
 	int ret;
 
 	adapter = c->adapter;
 	xdev  = adapter->xdev;
+	stats = adapter->stats;
+	channel_stats = &stats->channel_stats[c->chl_idx];
+	psq->stats = &channel_stats->sq[sq_idx];
 	psq_param->wq.db_numa_node = cpu_to_node(c->cpu);
 
 	ret = xsc_eth_wq_cyc_create(xdev, &psq_param->wq,
@@ -868,11 +873,16 @@ static int xsc_eth_alloc_rq(struct xsc_channel *c,
 	u8 q_log_size = prq_param->rq_attr.q_log_size;
 	struct page_pool_params pagepool_params = {0};
 	struct xsc_adapter *adapter = c->adapter;
+	struct xsc_channel_stats *channel_stats;
 	u32 pool_size = 1 << q_log_size;
+	struct xsc_stats *stats;
 	int ret = 0;
 	u32 wq_sz;
 	int i, f;
 
+	stats = c->adapter->stats;
+	channel_stats = &stats->channel_stats[c->chl_idx];
+	prq->stats = &channel_stats->rq;
 	prq_param->wq.db_numa_node = cpu_to_node(c->cpu);
 
 	ret = xsc_eth_wq_cyc_create(c->adapter->xdev, &prq_param->wq,
@@ -1653,6 +1663,14 @@ static int xsc_eth_close(struct net_device *netdev)
 	return ret;
 }
 
+static void xsc_eth_get_stats(struct net_device *netdev,
+			      struct rtnl_link_stats64 *stats)
+{
+	struct xsc_adapter *adapter = netdev_priv(netdev);
+
+	xsc_eth_fold_sw_stats64(adapter, stats);
+}
+
 static int xsc_eth_set_hw_mtu(struct xsc_core_device *xdev,
 			      u16 mtu, u16 rx_buf_sz)
 {
@@ -1684,6 +1702,7 @@ static const struct net_device_ops xsc_netdev_ops = {
 	.ndo_open		= xsc_eth_open,
 	.ndo_stop		= xsc_eth_close,
 	.ndo_start_xmit		= xsc_eth_xmit_start,
+	.ndo_get_stats64	= xsc_eth_get_stats,
 };
 
 static void xsc_eth_build_nic_netdev(struct xsc_adapter *adapter)
@@ -1897,14 +1916,22 @@ static int xsc_eth_probe(struct auxiliary_device *adev,
 		goto err_nic_cleanup;
 	}
 
+	adapter->stats = kvzalloc(sizeof(*adapter->stats), GFP_KERNEL);
+	if (!adapter->stats) {
+		err = -ENOMEM;
+		goto err_detach;
+	}
+
 	err = register_netdev(netdev);
 	if (err) {
 		netdev_err(netdev, "register_netdev failed, err=%d\n", err);
-		goto err_detach;
+		goto err_free_stats;
 	}
 
 	return 0;
 
+err_free_stats:
+	kvfree(adapter->stats);
 err_detach:
 	xsc_eth_detach(xdev, adapter);
 err_nic_cleanup:
@@ -1929,7 +1956,7 @@ static void xsc_eth_remove(struct auxiliary_device *adev)
 		return;
 
 	unregister_netdev(adapter->netdev);
-
+	kvfree(adapter->stats);
 	free_netdev(adapter->netdev);
 
 	xdev->eth_priv = NULL;
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
index 61354b892..5c46d8050 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
@@ -10,6 +10,7 @@
 
 #include "common/xsc_device.h"
 #include "xsc_eth_common.h"
+#include "xsc_eth_stats.h"
 
 #define XSC_INVALID_LKEY	0x100
 
@@ -47,6 +48,8 @@ struct xsc_adapter {
 
 	u32			status;
 	struct mutex		status_lock; /*protect status */
+
+	struct xsc_stats	*stats;
 };
 
 static inline struct net_device *xsc_dev_to_netdev(struct xsc_core_device *xdev)
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c
index 212e55d78..fa8e644e0 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c
@@ -155,6 +155,10 @@ static void xsc_complete_rx_cqe(struct xsc_rq *rq,
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
index 000000000..38bab39b9
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_stats.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#include "xsc_eth_stats.h"
+#include "xsc_eth.h"
+
+static int xsc_get_netdev_max_channels(struct xsc_adapter *adapter)
+{
+	struct net_device *netdev = adapter->netdev;
+
+	return min_t(unsigned int, netdev->num_rx_queues,
+		     netdev->num_tx_queues);
+}
+
+static int xsc_get_netdev_max_tc(struct xsc_adapter *adapter)
+{
+	return adapter->nic_param.num_tc;
+}
+
+void xsc_eth_fold_sw_stats64(struct xsc_adapter *adapter,
+			     struct rtnl_link_stats64 *s)
+{
+	int i, j;
+
+	for (i = 0; i < xsc_get_netdev_max_channels(adapter); i++) {
+		struct xsc_channel_stats *channel_stats;
+		struct xsc_rq_stats *rq_stats;
+
+		channel_stats = &adapter->stats->channel_stats[i];
+		rq_stats = &channel_stats->rq;
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
index 000000000..1828f4608
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_stats.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef __XSC_EN_STATS_H
+#define __XSC_EN_STATS_H
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
+void xsc_eth_fold_sw_stats64(struct xsc_adapter *adapter,
+			     struct rtnl_link_stats64 *s);
+
+#endif /* XSC_EN_STATS_H */
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_tx.c b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_tx.c
index 1237433b1..ddfc3702f 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_tx.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_tx.c
@@ -221,6 +221,7 @@ static uint32_t xsc_eth_xmit_frame(struct sk_buff *skb,
 				   u16 pi)
 {
 	struct xsc_core_device *xdev = sq->cq.xdev;
+	struct xsc_sq_stats *stats = sq->stats;
 	struct xsc_send_wqe_ctrl_seg *cseg;
 	struct xsc_wqe_data_seg *dseg;
 	struct xsc_tx_wqe_info *wi;
@@ -242,11 +243,13 @@ static uint32_t xsc_eth_xmit_frame(struct sk_buff *skb,
 		ihs		= xsc_tx_get_gso_ihs(sq, skb);
 		num_bytes	= skb->len +
 				  (skb_shinfo(skb)->gso_segs - 1) * ihs;
+		stats->packets	+= skb_shinfo(skb)->gso_segs;
 	} else {
 		opcode		= XSC_OPCODE_RAW;
 		mss		= 0;
 		ihs		= 0;
 		num_bytes	= skb->len;
+		stats->packets++;
 	}
 
 	/*linear data in skb*/
@@ -284,10 +287,12 @@ static uint32_t xsc_eth_xmit_frame(struct sk_buff *skb,
 
 	xsc_txwqe_complete(sq, skb, opcode, ds_cnt, num_wqebbs, num_bytes,
 			   num_dma, wi);
+	stats->bytes     += num_bytes;
 
 	return NETDEV_TX_OK;
 
 err_drop:
+	stats->dropped++;
 	dev_kfree_skb_any(skb);
 
 	return NETDEV_TX_OK;
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h
index 4601eec3b..d063398ed 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h
@@ -124,6 +124,7 @@ struct xsc_rq {
 
 	unsigned long	state;
 	struct work_struct  recover_work;
+	struct xsc_rq_stats *stats;
 
 	u32 hw_mtu;
 	u32 frags_sz;
@@ -171,6 +172,7 @@ struct xsc_sq {
 	/* read only */
 	struct xsc_wq_cyc         wq;
 	u32                        dma_fifo_mask;
+	struct xsc_sq_stats     *stats;
 	struct {
 		struct xsc_sq_dma         *dma_fifo;
 		struct xsc_tx_wqe_info    *wqe_info;
-- 
2.43.0

