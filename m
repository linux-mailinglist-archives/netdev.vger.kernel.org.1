Return-Path: <netdev+bounces-158463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FADBA11F2D
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 11:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D3407A1C66
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 10:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA011E7C16;
	Wed, 15 Jan 2025 10:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="ghss7DjW"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-56.ptr.blmpb.com (va-2-56.ptr.blmpb.com [209.127.231.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A211E7C3A
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 10:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736936609; cv=none; b=k5rUgT8c3Y6Z3hT8g1CzjCUxhRD8YPxitu4BWyUSRstefBuKVtlY485DT9TCwuzgLdteeh+LL1qni3JD7fXFsd7urUs4vMeIOEX39NLK0pEbYUrZpFFJbtAgPdemuMM5APwxQQPg5ETrWcYemgrdL61r8ge+5wd+w0Q9v/6QC0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736936609; c=relaxed/simple;
	bh=Fc9DEh/u4Wzu9h2qZ8jbFoJBfr5tzKaZQimdjN0doRI=;
	h=From:Content-Type:Cc:Mime-Version:In-Reply-To:To:Date:Message-Id:
	 References:Subject; b=geRivWVOnJARkysTwAcR/HFF05c6snVT4QvycEcSuNQjOeNAoQ2wbxJf5YCc6fVblaZ3HHlAUaSzMVB9tRkDyXP2DENMq3dYlZhm0nlS6BQI65Oy6lkiWNDoeu95HE8Y3R/HX/h6wzNCfpI+7aR8Mro7fQkuVo9a7SEB/1+8bjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=ghss7DjW; arc=none smtp.client-ip=209.127.231.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1736936598; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=zklnxPzs4QAv1sMQHOpImMDddpLpFTq4keBMZO3gh9Y=;
 b=ghss7DjW65n2EHMV0u5D8QKcoUovIDsXHE/J74oeIwDWS5n+RCnYZv5BBJRklOiSlYOK0J
 QW5rBn+f3D9xg01idMjlTYgghX/FyRhDdkeuxUtJIlH511KNxpBdMOIeac84CU8fK0lI92
 bqfsMKB+8M0XctEYtKgx4G0r7Au5bZ9uq68A6zo1VCouMmkZDGUOwv0ztgvPA0osOsF0NG
 oKVdqu1TxUlFLsheMIjUnXWKWR76PkHB5cMXdfY1h5g6Eti+VQFKOJ08l7VNeSSD/UxDWv
 aZUUS2BLJVdb6aTExHRtlAjdwjsOHxd9lvYtybOMAzlyuA2hF+eeTU9TOOkV0g==
From: "Xin Tian" <tianx@yunsilicon.com>
X-Original-From: Xin Tian <tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
X-Mailer: git-send-email 2.25.1
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Wed, 15 Jan 2025 18:23:15 +0800
Cc: <leon@kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20250115102242.3541496-1-tianx@yunsilicon.com>
Content-Transfer-Encoding: 7bit
To: <netdev@vger.kernel.org>
Date: Wed, 15 Jan 2025 18:23:15 +0800
Message-Id: <20250115102314.3541496-15-tianx@yunsilicon.com>
References: <20250115102242.3541496-1-tianx@yunsilicon.com>
Subject: [PATCH v3 14/14] net-next/yunsilicon: add ndo_get_stats64
X-Lms-Return-Path: <lba+267878c94+22a9f8+vger.kernel.org+tianx@yunsilicon.com>

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
index b52f0db29..d2269794f 100644
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
@@ -840,10 +843,13 @@ static int xsc_eth_alloc_rq(struct xsc_channel *c,
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
@@ -1613,6 +1619,13 @@ static int xsc_eth_close(struct net_device *netdev)
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
@@ -1643,6 +1656,7 @@ static const struct net_device_ops xsc_netdev_ops = {
 	.ndo_open		= xsc_eth_open,
 	.ndo_stop		= xsc_eth_close,
 	.ndo_start_xmit		= xsc_eth_xmit_start,
+	.ndo_get_stats64	= xsc_eth_get_stats,
 };
 
 static void xsc_eth_build_nic_netdev(struct xsc_adapter *adapter)
@@ -1851,14 +1865,20 @@ static int xsc_eth_probe(struct auxiliary_device *adev,
 		goto err_nic_cleanup;
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
 
 	return 0;
 
+err_free_stats:
+	kfree(adapter->stats);
 err_detach:
 	xsc_eth_detach(xdev, adapter);
 err_nic_cleanup:
@@ -1885,7 +1905,7 @@ static void xsc_eth_remove(struct auxiliary_device *adev)
 	}
 
 	unregister_netdev(adapter->netdev);
-
+	kfree(adapter->stats);
 	free_netdev(adapter->netdev);
 
 	xdev->eth_priv = NULL;
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
index bd9c4e1c0..a24e05c26 100644
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

