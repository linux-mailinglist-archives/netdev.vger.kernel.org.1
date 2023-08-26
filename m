Return-Path: <netdev+bounces-30835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B55789309
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 03:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 447191C209A8
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 01:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF5B387;
	Sat, 26 Aug 2023 01:21:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C358A3D9F
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 01:21:39 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0A226BB
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 18:21:38 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68c3b9f8333so356970b3a.1
        for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 18:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20221208.gappssmtp.com; s=20221208; t=1693012897; x=1693617697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ug+VHH1fshXaj8Eqs7Sa6txOl4TNISUDe76JMvqnZcw=;
        b=qavmCd6cWRybNFEN5NxN1FRoff2w7/6P5mtOTUcqhlOT3kMP14sNoPrhquv2WGOpVH
         HYl51Dm8l+w4D9bCyuE60MhkiDnZy0WC/8CJo8D+mDmg4Q5p327EpoMaWEvsjIiCWTiN
         Xfm1tKTD6D5ettAyYuC00KGVokTDYQat5ynOSW7LzexpzXCFi5a9EyjRrertSO7mtiqS
         4DNmKBHlxb0j/74fKMGxyoG//GZBByL1OgrfSHJl3GY8pUl/jjSKHWmj4cWimKmPThXY
         OLWkjK7VyaNZqBRsnRShj1/a84Aw212SOUwH9xLcMaMEABPv+LyR4vF/Z5nPlBCPlWlS
         IQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693012897; x=1693617697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ug+VHH1fshXaj8Eqs7Sa6txOl4TNISUDe76JMvqnZcw=;
        b=BhBvRMsdqCiZmrpYtI81VS075XO6j+4l5YudtFi/RhnJMbY6k/1WKLrUG0VEG4lpHb
         bFAOsaXpAPGJLDY7Ola2nj+zByZlmileDFtOXnKTbNGjasA+QipkiEhMFAjpJF3244Nh
         N7i2tyIM6+eJJXDkh3I4EN4jg8DR5Az7uMYs4AibwYUnQlO/K2Iugcacghc/BHmQtCoA
         IYVeNYhhXiyAY002b2uJowPio6i3o74N2PuD7dgvaCMNZ33DKlFZkciXwWNpQU5n2WBA
         RE8uKMQinT9Flzqgjyn0KH+4vmE0q127Uh7dFFWR+dNfIh2Of/C5PXFd2Fs2F7U/QiWx
         4ZcQ==
X-Gm-Message-State: AOJu0YyKTa6mXdEc6EptNDMOcOQyuVBm2C6Iqj2gXif35fzLUM5nu4hA
	GdlJkje23ggvUFPD1TobC/wOZA==
X-Google-Smtp-Source: AGHT+IELAnNcy8C9BhsWs5nsYI2ET2z89/+WMDH+x3SCMJLLpriQcSpsi8WHS2LoNkqH14d3cPA1XA==
X-Received: by 2002:a05:6a00:2808:b0:68a:6e26:a918 with SMTP id bl8-20020a056a00280800b0068a6e26a918mr16000890pfb.8.1693012897619;
        Fri, 25 Aug 2023 18:21:37 -0700 (PDT)
Received: from localhost (fwdproxy-prn-007.fbsv.net. [2a03:2880:ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id r30-20020a638f5e000000b005641bbe783bsm2280510pgn.11.2023.08.25.18.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 18:21:37 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org,
	netdev@vger.kernel.org,
	Mina Almasry <almasrymina@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 10/11] netdev/bnxt: add data pool and use it in BNXT driver
Date: Fri, 25 Aug 2023 18:19:53 -0700
Message-Id: <20230826011954.1801099-11-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230826011954.1801099-1-dw@davidwei.uk>
References: <20230826011954.1801099-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: David Wei <davidhwei@meta.com>

This patch adds a thin wrapper called data pool that wraps the existing
page pool and the newly added ZC pool.

There is one struct netdev_rx_queue per logical RX queue. This patch
adds ZC ifq, page pool, and uarg (set during skb construction) to a
netdev_rx_queue. The data pool wrapper uses the ZC pool if an ifq is
present, otherwise using the page pool.

The BNXT driver is modified to use data pool in order to support ZC RX.
A setup function bnxt_zc_rx is added that is called on XDP_SETUP_ZC_RX
XDP command which sets fields in netdev_rx_queue. Calls to get/put bufs
from the page pool are related w/ the data pool.

Signed-off-by: David Wei <davidhwei@meta.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 59 ++++++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  4 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  3 +
 include/linux/netdevice.h                     |  4 +
 include/net/data_pool.h                       | 96 +++++++++++++++++++
 5 files changed, 149 insertions(+), 17 deletions(-)
 create mode 100644 include/net/data_pool.h

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 48f584f78561..5c1dabaf07f9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -57,6 +57,7 @@
 #include <net/page_pool.h>
 #include <linux/align.h>
 #include <net/netdev_queues.h>
+#include <net/data_pool.h>
 
 #include "bnxt_hsi.h"
 #include "bnxt.h"
@@ -724,7 +725,7 @@ static void bnxt_tx_int(struct bnxt *bp, struct bnxt_napi *bnapi, int nr_pkts)
 
 	__netif_txq_completed_wake(txq, nr_pkts, tx_bytes,
 				   bnxt_tx_avail(bp, txr), bp->tx_wake_thresh,
-				   READ_ONCE(txr->dev_state) != BNXT_DEV_STATE_CLOSING);
+				   READ_ONCE(txr->dev_state) == BNXT_DEV_STATE_CLOSING);
 }
 
 static struct page *__bnxt_alloc_rx_64k_page(struct bnxt *bp, dma_addr_t *mapping,
@@ -738,13 +739,7 @@ static struct page *__bnxt_alloc_rx_64k_page(struct bnxt *bp, dma_addr_t *mappin
 	if (!page)
 		return NULL;
 
-	*mapping = dma_map_page_attrs(&bp->pdev->dev, page, offset,
-				      BNXT_RX_PAGE_SIZE, DMA_FROM_DEVICE,
-				      DMA_ATTR_WEAK_ORDERING);
-	if (dma_mapping_error(&bp->pdev->dev, *mapping)) {
-		page_pool_recycle_direct(rxr->page_pool, page);
-		return NULL;
-	}
+	*mapping = page_pool_get_dma_addr(page);
 
 	if (page_offset)
 		*page_offset = offset;
@@ -757,19 +752,14 @@ static struct page *__bnxt_alloc_rx_page(struct bnxt *bp, dma_addr_t *mapping,
 					 struct bnxt_rx_ring_info *rxr,
 					 gfp_t gfp)
 {
-	struct device *dev = &bp->pdev->dev;
 	struct page *page;
 
-	page = page_pool_dev_alloc_pages(rxr->page_pool);
+	page = data_pool_alloc_page(rxr->rx_queue);
 	if (!page)
 		return NULL;
 
-	*mapping = dma_map_page_attrs(dev, page, 0, PAGE_SIZE, bp->rx_dir,
-				      DMA_ATTR_WEAK_ORDERING);
-	if (dma_mapping_error(dev, *mapping)) {
-		page_pool_recycle_direct(rxr->page_pool, page);
-		return NULL;
-	}
+	*mapping = data_pool_get_dma_addr(rxr->rx_queue, page);
+
 	return page;
 }
 
@@ -1787,6 +1777,8 @@ static void bnxt_deliver_skb(struct bnxt *bp, struct bnxt_napi *bnapi,
 		return;
 	}
 	skb_record_rx_queue(skb, bnapi->index);
+	if (bnapi->rx_ring->rx_queue->zc_ifq)
+		skb_zcopy_init(skb, bnapi->rx_ring->rx_queue->zc_uarg);
 	skb_mark_for_recycle(skb);
 	napi_gro_receive(&bnapi->napi, skb);
 }
@@ -3016,7 +3008,7 @@ static void bnxt_free_one_rx_ring_skbs(struct bnxt *bp, int ring_nr)
 		rx_agg_buf->page = NULL;
 		__clear_bit(i, rxr->rx_agg_bmap);
 
-		page_pool_recycle_direct(rxr->page_pool, page);
+		data_pool_put_page(rxr->rx_queue, page);
 	}
 
 skip_rx_agg_free:
@@ -3225,6 +3217,8 @@ static void bnxt_free_rx_rings(struct bnxt *bp)
 
 		page_pool_destroy(rxr->page_pool);
 		rxr->page_pool = NULL;
+		rxr->rx_queue->page_pool = NULL;
+		rxr->rx_queue->zc_ifq = NULL;
 
 		kfree(rxr->rx_agg_bmap);
 		rxr->rx_agg_bmap = NULL;
@@ -3251,12 +3245,16 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 	pp.dma_dir = DMA_BIDIRECTIONAL;
 	if (PAGE_SIZE > BNXT_RX_PAGE_SIZE)
 		pp.flags |= PP_FLAG_PAGE_FRAG;
+	pp.flags |= PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
+	pp.max_len = PAGE_SIZE;
 
 	rxr->page_pool = page_pool_create(&pp);
+	data_pool_set_page_pool(bp->dev, rxr->bnapi->index, rxr->page_pool);
 	if (IS_ERR(rxr->page_pool)) {
 		int err = PTR_ERR(rxr->page_pool);
 
 		rxr->page_pool = NULL;
+		data_pool_set_page_pool(bp->dev, rxr->bnapi->index, NULL);
 		return err;
 	}
 	return 0;
@@ -4620,6 +4618,8 @@ static int bnxt_alloc_mem(struct bnxt *bp, bool irq_re_init)
 				rxr->rx_agg_ring_struct.ring_mem.flags =
 					BNXT_RMEM_RING_PTE_FLAG;
 			}
+
+			rxr->rx_queue = data_pool_get_rx_queue(bp->dev, bp->bnapi[i]->index);
 			rxr->bnapi = bp->bnapi[i];
 			bp->bnapi[i]->rx_ring = &bp->rx_ring[i];
 		}
@@ -13904,6 +13904,31 @@ void bnxt_print_device_info(struct bnxt *bp)
 	pcie_print_link_status(bp->pdev);
 }
 
+int bnxt_zc_rx(struct bnxt *bp, struct netdev_bpf *xdp)
+{
+	if (xdp->zc_rx.queue_id >= bp->rx_nr_rings)
+		return -EINVAL;
+
+	bnxt_rtnl_lock_sp(bp);
+	if (netif_running(bp->dev)) {
+		struct netdev_rx_queue *rxq;
+		int rc;
+
+		bnxt_ulp_stop(bp);
+		bnxt_close_nic(bp, true, false);
+
+		rxq = data_pool_get_rx_queue(bp->dev, xdp->zc_rx.queue_id);
+		rxq->queue_id = xdp->zc_rx.queue_id;
+		rxq->zc_ifq = xdp->zc_rx.ifq;
+		rxq->zc_uarg = xdp->zc_rx.uarg;
+
+		rc = bnxt_open_nic(bp, true, false);
+		bnxt_ulp_start(bp, rc);
+	}
+	bnxt_rtnl_unlock_sp(bp);
+	return 0;
+}
+
 static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct net_device *dev;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 9fd85ebd8ae8..554c0abc0d44 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -949,6 +949,7 @@ struct bnxt_rx_ring_info {
 	struct bnxt_ring_struct	rx_agg_ring_struct;
 	struct xdp_rxq_info	xdp_rxq;
 	struct page_pool	*page_pool;
+	struct netdev_rx_queue	*rx_queue;
 };
 
 struct bnxt_rx_sw_stats {
@@ -2454,4 +2455,7 @@ int bnxt_get_port_parent_id(struct net_device *dev,
 void bnxt_dim_work(struct work_struct *work);
 int bnxt_hwrm_set_ring_coal(struct bnxt *bp, struct bnxt_napi *bnapi);
 void bnxt_print_device_info(struct bnxt *bp);
+
+int bnxt_zc_rx(struct bnxt *bp, struct netdev_bpf *xdp);
+
 #endif
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 4efa5fe6972b..1387f0e1fff5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -455,6 +455,9 @@ int bnxt_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 	case XDP_SETUP_PROG:
 		rc = bnxt_xdp_set(bp, xdp->prog);
 		break;
+	case XDP_SETUP_ZC_RX:
+		return bnxt_zc_rx(bp, xdp);
+		break;
 	default:
 		rc = -EINVAL;
 		break;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index bf133cbee721..994237e92cbc 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -789,6 +789,10 @@ struct netdev_rx_queue {
 	struct kobject			kobj;
 	struct net_device		*dev;
 	netdevice_tracker		dev_tracker;
+	unsigned int			queue_id;
+	struct page_pool		*page_pool;
+	struct io_zc_rx_ifq		*zc_ifq;
+	struct ubuf_info		*zc_uarg;
 
 #ifdef CONFIG_XDP_SOCKETS
 	struct xsk_buff_pool            *pool;
diff --git a/include/net/data_pool.h b/include/net/data_pool.h
new file mode 100644
index 000000000000..84c96aa1c542
--- /dev/null
+++ b/include/net/data_pool.h
@@ -0,0 +1,96 @@
+#ifndef _DATA_POOL_H
+#define _DATA_POOL_H
+
+#include <linux/io_uring.h>
+#include <linux/io_uring_types.h>
+#include <linux/mm_types.h>
+#include <linux/netdevice.h>
+
+static inline struct netdev_rx_queue *
+data_pool_get_rx_queue(struct net_device *dev, unsigned int q_idx)
+{
+	if (q_idx >= dev->num_rx_queues)
+		return NULL;
+	return __netif_get_rx_queue(dev, q_idx);
+}
+
+static inline int data_pool_set_page_pool(struct net_device *dev,
+					  unsigned int q_idx,
+					  struct page_pool *pool)
+{
+	struct netdev_rx_queue *rxq;
+
+	rxq = data_pool_get_rx_queue(dev, q_idx);
+	if (!rxq)
+		return -EINVAL;
+
+	rxq->page_pool = pool;
+	return 0;
+}
+
+static inline int data_pool_set_zc_ifq(struct net_device *dev,
+					unsigned int q_idx,
+					struct io_zc_rx_ifq *ifq)
+{
+	struct netdev_rx_queue *rxq;
+
+	rxq = data_pool_get_rx_queue(dev, q_idx);
+	if (!rxq)
+		return -EINVAL;
+
+	rxq->zc_ifq = ifq;
+	return 0;
+}
+
+static inline struct page *data_pool_alloc_page(struct netdev_rx_queue *rxq)
+{
+	if (rxq->zc_ifq) {
+		struct io_zc_rx_buf *buf;
+		buf = io_zc_rx_get_buf(rxq->zc_ifq);
+		if (!buf)
+			return NULL;
+		return buf->page;
+	} else {
+		return page_pool_dev_alloc_pages(rxq->page_pool);
+	}
+}
+
+static inline void data_pool_fragment_page(struct netdev_rx_queue *rxq,
+					   struct page *page,
+					   unsigned long bias)
+{
+	if (rxq->zc_ifq) {
+		struct io_zc_rx_buf *buf;
+		buf = io_zc_rx_buf_from_page(rxq->zc_ifq, page);
+		atomic_set(&buf->refcount, bias);
+	} else {
+		page_pool_fragment_page(page, bias);
+	}
+}
+
+static inline void data_pool_put_page(struct netdev_rx_queue *rxq,
+				      struct page *page)
+{
+	if (rxq->zc_ifq) {
+		struct io_zc_rx_buf *buf;
+		buf = io_zc_rx_buf_from_page(rxq->zc_ifq, page);
+		io_zc_rx_put_buf(rxq->zc_ifq, buf);
+	} else {
+		WARN_ON_ONCE(page->pp_magic != PP_SIGNATURE);
+		page_pool_recycle_direct(rxq->page_pool, page);
+	}
+}
+
+static inline dma_addr_t data_pool_get_dma_addr(struct netdev_rx_queue *rxq,
+						struct page *page)
+{
+	if (rxq->zc_ifq) {
+		struct io_zc_rx_buf *buf;
+		buf = io_zc_rx_buf_from_page(rxq->zc_ifq, page);
+		return io_zc_rx_buf_dma(buf);
+	} else {
+		return page_pool_get_dma_addr(page);
+	}
+}
+
+#endif
-- 
2.39.3


