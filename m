Return-Path: <netdev+bounces-154517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B963B9FE533
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 11:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53D513A220D
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 10:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E352B9B9;
	Mon, 30 Dec 2024 10:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="jOo2nfIm"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-44.ptr.blmpb.com (va-2-44.ptr.blmpb.com [209.127.231.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF4C1A7046
	for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 10:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735553753; cv=none; b=ccQbCsxmetwvenKnnf1WO2DqoAsOXGO4pG00R8gZqtYziNdOgDlMWMYSuyCV+2mDMENI9OT7kqgCdTBEfaZWhTbN9IXlNMw12lObCXfdU4aZnfryrN9awJ5GvdCLH1aRfX+2Mlkzke82u4qtUvwrh/86T0kGleux+UTcCZGU+4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735553753; c=relaxed/simple;
	bh=Vu3EUi604mUFSGLDONdrWlpvxgo/iaXI9h1znxbzT44=;
	h=Subject:In-Reply-To:Cc:From:Mime-Version:Message-Id:References:
	 Content-Type:To:Date; b=ONA4myrf0I3UiExWVqRc2Yq43oD7sMkWi2EOK5SUUEXSYbPb7novHa5wOH/2VNCm1cSnOIEQvNg4fBV4LInKLfyQp+GijfxzClh36aWbODTSiYcwnE3OzLI9CBNs6eGXaQdCUFVAtqAlSUstu4DtRjag4LnEtn+BVfmLWsla3yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=jOo2nfIm; arc=none smtp.client-ip=209.127.231.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1735553746; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=i9h44KzkaRycHLTAdZlrGpUoUCLa4K3ziZ/krWFl658=;
 b=jOo2nfImG0VTabCf7U9kZdpLw3gjJV9g9FDiqX3VOFY/vSNTIPfnPHR9EAQObjWn+JrCrU
 vJlndBi/6LQO4icEfQFWiDZ/eLABNPPTeEncM0d2/F6qrMQyNBfZyGh+RCcdhFcOvAy6+o
 Zu41bzjF5KjRvdOjEcfknAtXKHrzOIdcJ84COOm9cDdeJRqJrG5o3sNtN9Q/iD4wQhE9V5
 yAYIGeMUoOSVd8yxpHJazfij3L6Wtj/N0FMQQO0+mAkHt8iKDUJCd1/cF4HvuVwUV1iD6b
 xPABewklgxvW+DmiH+E4E6VaVljhqCvAmKeaFlP1jFlpNAB8U8zLqi8aHmjE9w==
Subject: [PATCH v2 14/14] net-next/yunsilicon: add ndo_get_stats64
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Mon, 30 Dec 2024 18:15:43 +0800
X-Original-From: Xin Tian <tianx@yunsilicon.com>
In-Reply-To: <20241230101513.3836531-1-tianx@yunsilicon.com>
X-Mailer: git-send-email 2.25.1
X-Lms-Return-Path: <lba+2677272d0+90fb10+vger.kernel.org+tianx@yunsilicon.com>
Content-Transfer-Encoding: 7bit
Cc: <andrew+netdev@lunn.ch>, <kuba@kernel.org>, <pabeni@redhat.com>, 
	<edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>
From: "Xin Tian" <tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-Id: <20241230101542.3836531-15-tianx@yunsilicon.com>
References: <20241230101513.3836531-1-tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
To: <netdev@vger.kernel.org>
Date: Mon, 30 Dec 2024 18:15:44 +0800

Support nic stats

Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
Co-developed-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Lei Yan <jacky@yunsilicon.com>
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
index af1c9566a..4d24372fd 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/main.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
@@ -537,12 +537,15 @@ static int xsc_eth_open_qp_sq(struct xsc_channel *c,
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
@@ -836,10 +839,13 @@ static int xsc_eth_alloc_rq(struct xsc_channel *c,
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
@@ -1609,6 +1615,13 @@ static int xsc_eth_close(struct net_device *netdev)
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
@@ -1639,6 +1652,7 @@ static const struct net_device_ops xsc_netdev_ops = {
 	.ndo_open		= xsc_eth_open,
 	.ndo_stop		= xsc_eth_close,
 	.ndo_start_xmit		= xsc_eth_xmit_start,
+	.ndo_get_stats64	= xsc_eth_get_stats,
 };
 
 static void xsc_eth_build_nic_netdev(struct xsc_adapter *adapter)
@@ -1844,16 +1858,22 @@ static void *xsc_eth_add(struct xsc_core_device *xdev)
 		goto err_cleanup_netdev;
 	}
 
+	adapter->stats = kvzalloc(sizeof(*adapter->stats), GFP_KERNEL);
+	if (!adapter->stats)
+		goto err_detach;
+
 	err = register_netdev(netdev);
 	if (err) {
 		netdev_err(netdev, "register_netdev failed, err=%d\n", err);
-		goto err_detach;
+		goto err_free_stats;
 	}
 
 	xdev->netdev = netdev;
 
 	return adapter;
 
+err_free_stats:
+	kfree(adapter->stats);
 err_detach:
 	xsc_eth_detach(xdev, adapter);
 err_cleanup_netdev:
@@ -1878,7 +1898,7 @@ static void xsc_eth_remove(struct xsc_core_device *xdev, void *context)
 	}
 
 	unregister_netdev(adapter->netdev);
-
+	kfree(adapter->stats);
 	free_netdev(adapter->netdev);
 
 	xdev->netdev = NULL;
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
index 87e2a72d3..650f92c48 100644
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
 
 #endif /* __XSC_ETH_H */
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c
index a4428e629..83cf31239 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c
@@ -139,6 +139,10 @@ static void xsc_complete_rx_cqe(struct xsc_rq *rq,
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
index 000000000..9fe0e831b
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
index 000000000..10b2aa69b
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_stats.h
@@ -0,0 +1,33 @@
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
+void xsc_eth_fold_sw_stats64(struct xsc_adapter *adapter, struct rtnl_link_stats64 *s);
+
+#endif /* XSC_EN_STATS_H */
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_tx.c b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_tx.c
index af5236966..51cdac6cf 100644
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
index 967d46e7e..0d342e846 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h
@@ -129,6 +129,7 @@ struct xsc_rq {
 
 	unsigned long	state;
 	struct work_struct  recover_work;
+	struct xsc_rq_stats *stats;
 
 	u32 hw_mtu;
 	u32 frags_sz;
@@ -177,6 +178,7 @@ struct xsc_sq {
 	/* read only */
 	struct xsc_wq_cyc         wq;
 	u32                        dma_fifo_mask;
+	struct xsc_sq_stats     *stats;
 	struct {
 		struct xsc_sq_dma         *dma_fifo;
 		struct xsc_tx_wqe_info    *wqe_info;
-- 
2.43.0

