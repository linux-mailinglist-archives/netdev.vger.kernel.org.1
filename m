Return-Path: <netdev+bounces-150053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD769E8BEB
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 08:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1E9018849DE
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 07:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFAC214A65;
	Mon,  9 Dec 2024 07:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="GE4VSmA9"
X-Original-To: netdev@vger.kernel.org
Received: from lf-2-45.ptr.blmpb.com (lf-2-45.ptr.blmpb.com [101.36.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0A3214A67
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 07:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.36.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733728382; cv=none; b=m1N/RKe1NzkIBnSeXiH5PN3V7PgsPRJWFF0V+A1+GDiJcjHstmR+eObDxHVNoAaEE6B9okGMfY+8eZoYF4sPmDldHhJSnCy0gwn8AeV80ND6jjilN9hRm5mwbGtQxc+bqm9GFYnfpkADO765WYZGG3yOoZflHoeMQvLzc8BthuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733728382; c=relaxed/simple;
	bh=5/S6w+m19Ro8OeKSLiRKaajS+wtyDrr4gppntHNdcfU=;
	h=Cc:To:Subject:Mime-Version:Content-Type:From:Date:Message-Id; b=ppJESZEbMlEDK/8yEOS9I4I51m17oDdu6jbRYf1tJ+DOUzNTa4QnSHwujzppvCB3NGzRUMCzRmQyxN3SuBPP0g5xA5wN09yE4mPGhtzzu5Y/wVGJOJbCsFN4sdIO9bXTQGj8M0+F0cMVU3iAfkqugou/Lppmn01BGbNJBR/xqKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=GE4VSmA9; arc=none smtp.client-ip=101.36.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1733728289; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=5LaQ9RxM+Dy4mr9DtXBpiEzVqeBdskcC6UXLflQkynk=;
 b=GE4VSmA9btmhMidVivnk1Ojz3S81D8ozNTv9bIHtJ1RjxOMT4KDTWWwRixbzJzVlPJlm0i
 uZuzSjCjPi3K+Pl024iFzQhX4L867+fNXduiqF7gG4STLxqKwb3isbDhM5/4Ymq7+/uPuU
 MqjSY0trh3EFLt3CljxXL+MiF5UhZp7Z5CqrJSOAh8LQHNYw8XSkhjAZADOsu3PuKR9ozN
 jYQsHSUWPz+4D7dkUGU6UfTqy5GOoBobShLxD/OWAV/8ZnUI1PpeRO32agqzIZsXMRuQTV
 ZQvZwpENN1+/BYVvtv1Z2lotWUn6GoRW838kKIiNZb/59UUx+7jFgizXBd94gQ==
Cc: <weihg@yunsilicon.com>, <tianx@yunsilicon.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7bit
X-Original-From: Tian Xin <tianx@yunsilicon.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>
Subject: [PATCH 14/16] net-next/yunsilicon: add ndo_get_stats64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTP; Mon, 09 Dec 2024 15:11:27 +0800
X-Lms-Return-Path: <lba+267569820+bad0fd+vger.kernel.org+tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
From: "Tian Xin" <tianx@yunsilicon.com>
Date: Mon,  9 Dec 2024 15:10:59 +0800
Message-Id: <20241209071101.3392590-15-tianx@yunsilicon.com>

From: Xin Tian <tianx@yunsilicon.com>

Support nic stats

Signed-off-by: Xin Tian <tianx@yunsilicon.com>
Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
Signed-off-by: Lei Yan <jacky@yunsilicon.com>
---
 .../net/ethernet/yunsilicon/xsc/net/Makefile  |  2 +-
 .../net/ethernet/yunsilicon/xsc/net/main.c    | 22 +++++++++-
 .../net/ethernet/yunsilicon/xsc/net/xsc_eth.h |  3 ++
 .../ethernet/yunsilicon/xsc/net/xsc_eth_rx.c  |  4 ++
 .../yunsilicon/xsc/net/xsc_eth_stats.c        | 42 +++++++++++++++++++
 .../yunsilicon/xsc/net/xsc_eth_stats.h        | 33 +++++++++++++++
 .../ethernet/yunsilicon/xsc/net/xsc_eth_tx.c  |  5 +++
 .../ethernet/yunsilicon/xsc/net/xsc_queue.h   |  2 +
 8 files changed, 111 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_stats.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_stats.h

diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/Makefile b/drivers/net/ethernet/yunsilicon/xsc/net/Makefile
index bc24622c6..5cde370d3 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/Makefile
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/Makefile
@@ -6,4 +6,4 @@ ccflags-y += -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
 
 obj-$(CONFIG_YUNSILICON_XSC_ETH) += xsc_eth.o
 
-xsc_eth-y := main.o xsc_eth_wq.o xsc_eth_txrx.o xsc_eth_tx.o xsc_eth_rx.o
+xsc_eth-y := main.o xsc_eth_wq.o xsc_eth_txrx.o xsc_eth_tx.o xsc_eth_rx.o xsc_eth_stats.o
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/main.c b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
index 1af4e9948..a3b557cc5 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/main.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
@@ -540,12 +540,15 @@ static int xsc_eth_open_qp_sq(struct xsc_channel *c,
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
@@ -844,10 +847,13 @@ static int xsc_eth_alloc_rq(struct xsc_channel *c,
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
@@ -1655,10 +1661,18 @@ static int xsc_eth_close(struct net_device *netdev)
 	return ret;
 }
 
+static void xsc_eth_get_stats(struct net_device *netdev, struct rtnl_link_stats64 *stats)
+{
+	struct xsc_adapter *adapter = netdev_priv(netdev);
+
+	xsc_eth_fold_sw_stats64(adapter, stats);
+}
+
 static const struct net_device_ops xsc_netdev_ops = {
 	.ndo_open		= xsc_eth_open,
 	.ndo_stop		= xsc_eth_close,
 	.ndo_start_xmit		= xsc_eth_xmit_start,
+	.ndo_get_stats64	= xsc_eth_get_stats,
 };
 
 static void xsc_eth_build_nic_netdev(struct xsc_adapter *adapter)
@@ -1892,6 +1906,10 @@ static void *xsc_eth_add(struct xsc_core_device *xdev)
 		goto err_cleanup_netdev;
 	}
 
+	adapter->stats = kvzalloc(sizeof(*adapter->stats), GFP_KERNEL);
+	if (unlikely(!adapter->stats))
+		goto err_detach;
+
 	err = register_netdev(netdev);
 	if (err) {
 		xsc_core_warn(xdev, "register_netdev failed, err=%d\n", err);
@@ -1903,6 +1921,8 @@ static void *xsc_eth_add(struct xsc_core_device *xdev)
 	return adapter;
 
 err_reg_netdev:
+	kfree(adapter->stats);
+err_detach:
 	xsc_eth_detach(xdev, adapter);
 err_cleanup_netdev:
 	xsc_eth_nic_cleanup(adapter);
@@ -1928,7 +1948,7 @@ static void xsc_eth_remove(struct xsc_core_device *xdev, void *context)
 	xsc_core_info(adapter->xdev, "remove netdev %s entry\n", adapter->netdev->name);
 
 	unregister_netdev(adapter->netdev);
-
+	kfree(adapter->stats);
 	free_netdev(adapter->netdev);
 
 	xdev->netdev = NULL;
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
index de5d62732..96c1954ef 100644
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
index b4c8cc783..edbc6c141 100644
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
index 000000000..66aefb5ef
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_stats.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
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
index 000000000..3daaa2bdb
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_stats.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
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
index 3b8de94b5..afde30afa 100644
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
index f1a7a08da..2a6740896 100644
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

