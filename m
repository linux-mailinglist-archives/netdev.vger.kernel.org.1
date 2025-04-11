Return-Path: <netdev+bounces-181520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2617CA854CC
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 08:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0565B7AE631
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 06:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6531B27D79E;
	Fri, 11 Apr 2025 06:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="arWEuKKW"
X-Original-To: netdev@vger.kernel.org
Received: from sg-1-13.ptr.blmpb.com (sg-1-13.ptr.blmpb.com [118.26.132.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADDB27EC62
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 06:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744354422; cv=none; b=YiR1YaoKvKsfKsaOUiSSSAfPZalvu/GLOazCqkzgDQqfbSH11++W1gKtXWSDDYDYceeROx2v4S+UlUoPSCh37O+6rJpbz8zlmokyPzM7Cc2jsdU/jvmT2vkhjPenx6SQ2EdouMacwQXEY3A/nH8lmKNII733ur0j8AyUTRvD2Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744354422; c=relaxed/simple;
	bh=Q6gPisX3UtEzkNqzKt42a2Alnz7VFcJvcPtnPbdUtcE=;
	h=Subject:Date:To:Cc:Mime-Version:Content-Type:From:In-Reply-To:
	 Message-Id:References; b=Xw5qm9kslEPZwUMoXKrUReThr9JDFwx23wjKjbMU+inIVpd5tpXF3gR/oOcdX6fBrSqYfD/Dl4fuu0SnIPUQAEb3xtUwZUgXnrZfAPKoCDBSfVvdDFH5ktnY2ll8D7jgfQO7IZzJUEDsw3HtuGApS682wtaOiazcoyhxH9XRZe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=arWEuKKW; arc=none smtp.client-ip=118.26.132.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1744354413; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=BQKWxRJ1Va5Vl9erA6EE2YaI27Zua1TUuQgeKhSuqgo=;
 b=arWEuKKWONNGGjVdGrUJdSmvMLy7K6bjlbQFJw44Eb/IeVxEU5+P+8ACSqGw3swww3Ij7b
 INNIJfwLnoqpW7MihTWYNNuI287UhYpYh5AvqPQhQSrC5mbSvxQxIuPIH1jDuv4LYjxRTa
 gsJwTED5bEVFQ6FRnCXdiLvx4vglA1uYg1BVeyYTOCI2lxuOttJtDOOwXBbbBX3NlwzFam
 +i1hFyGEhPR+ohpXa39kTzvhIvubkvGjhjoEmQKhfoVOM+VP/Hn5f8l3sRQLSP5oiLRJHE
 f5Bco2C8F4vpSaq0Soon4D1wEJF7WUBV3kndAQTARP3d2H0w6VFsddrp7ovE5w==
Subject: [PATCH net-next v10 14/14] xsc: add ndo_get_stats64
Date: Fri, 11 Apr 2025 14:53:30 +0800
X-Mailer: git-send-email 2.25.1
To: <netdev@vger.kernel.org>
Cc: <leon@kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <jacky@yunsilicon.com>, 
	<horms@kernel.org>, <parthiban.veerasooran@microchip.com>, 
	<masahiroy@kernel.org>, <kalesh-anakkur.purayil@broadcom.com>, 
	<geert+renesas@glider.be>, <pabeni@redhat.com>, <geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
From: "Xin Tian" <tianx@yunsilicon.com>
In-Reply-To: <20250411065246.2303550-1-tianx@yunsilicon.com>
X-Lms-Return-Path: <lba+267f8bc6b+9bc85c+vger.kernel.org+tianx@yunsilicon.com>
X-Original-From: Xin Tian <tianx@yunsilicon.com>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Fri, 11 Apr 2025 14:53:30 +0800
Message-Id: <20250411065329.2303550-15-tianx@yunsilicon.com>
References: <20250411065246.2303550-1-tianx@yunsilicon.com>

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
index ec60546f9..3d9aaeb26 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/main.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
@@ -566,15 +566,20 @@ static int xsc_eth_open_qp_sq(struct xsc_channel *c,
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
@@ -875,11 +880,16 @@ static int xsc_eth_alloc_rq(struct xsc_channel *c,
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
@@ -1660,6 +1670,14 @@ static int xsc_eth_close(struct net_device *netdev)
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
@@ -1693,6 +1711,7 @@ static const struct net_device_ops xsc_netdev_ops = {
 	.ndo_open		= xsc_eth_open,
 	.ndo_stop		= xsc_eth_close,
 	.ndo_start_xmit		= xsc_eth_xmit_start,
+	.ndo_get_stats64	= xsc_eth_get_stats,
 };
 
 static void xsc_eth_build_nic_netdev(struct xsc_adapter *adapter)
@@ -1906,14 +1925,22 @@ static int xsc_eth_probe(struct auxiliary_device *adev,
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
@@ -1938,7 +1965,7 @@ static void xsc_eth_remove(struct auxiliary_device *adev)
 		return;
 
 	unregister_netdev(adapter->netdev);
-
+	kvfree(adapter->stats);
 	free_netdev(adapter->netdev);
 
 	xdev->eth_priv = NULL;
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
index 27fcfcda4..eef2cca36 100644
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
 
 #endif /* __XSC_ETH_H */
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c
index f6bbb5791..eea7ebd4e 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c
@@ -159,6 +159,10 @@ static void xsc_complete_rx_cqe(struct xsc_rq *rq,
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
index c25e76482..2af735cdb 100644
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
index 4c9f183fc..83fb13d8e 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h
@@ -132,6 +132,7 @@ struct xsc_rq {
 
 	unsigned long	state;
 	struct work_struct  recover_work;
+	struct xsc_rq_stats *stats;
 
 	u32 hw_mtu;
 	u32 frags_sz;
@@ -180,6 +181,7 @@ struct xsc_sq {
 	/* read only */
 	struct xsc_wq_cyc         wq;
 	u32                        dma_fifo_mask;
+	struct xsc_sq_stats     *stats;
 	struct {
 		struct xsc_sq_dma         *dma_fifo;
 		struct xsc_tx_wqe_info    *wqe_info;
-- 
2.43.0

