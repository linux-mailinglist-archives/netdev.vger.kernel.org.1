Return-Path: <netdev+bounces-22423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814AB767735
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 22:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AED2E1C2159F
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 20:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB161BB2D;
	Fri, 28 Jul 2023 20:50:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3128EDC
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 20:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC34C433C8;
	Fri, 28 Jul 2023 20:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690577423;
	bh=mJetauIm7YgP4p4w4frSD/Kn/xgYjOyYR0yg8n1nXsE=;
	h=From:To:Cc:Subject:Date:From;
	b=OEiyr+oSfE9g2b0qNfsjhedGUy1g5VlztejRhyWFFckZ6RVH1fZiySsXfyUyH/+Kh
	 qjYWdHnxNtSokbA7fOcnjgT/disVvwrAcKU/j1EEpZ8bxcbTGXMsOBueYbHUA+0Zdn
	 101t2d9UPlGQkyT6N+2RJha9c249JVZLmtZh+RhSGlTnlBWUe9hJqP+xMCOG+gt5tK
	 Q1oNzCnTg8i9/QT9Mc8v/edG/kUT9NemqPcgEf71e6JOOWEzhe2KuKxZAcLGAGJeLO
	 GcE2rqZFDof7QG1jq4ze0dPi57LDoNEbDlNjw7X70A4WRg69TDvOLe9k0TGGY5prZN
	 LTqyuC74sjZ1w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Andy Gospodarek <gospo@broadcom.com>,
	michael.chan@broadcom.com
Subject: [PATCH net v2] bnxt: don't handle XDP in netpoll
Date: Fri, 28 Jul 2023 13:50:20 -0700
Message-ID: <20230728205020.2784844-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similarly to other recently fixed drivers make sure we don't
try to access XDP or page pool APIs when NAPI budget is 0.
NAPI budget of 0 may mean that we are in netpoll.

This may result in running software IRQs in hard IRQ context,
leading to deadlocks or crashes.

To make sure bnapi->tx_pkts don't get wiped without handling
the events, move clearing the field into the handler itself.
Remember to clear tx_pkts after reset (bnxt_enable_napi())
as it's technically possible that netpoll will accumulate
some tx_pkts and then a reset will happen, leaving tx_pkts
out of sync with reality.

Fixes: 322b87ca55f2 ("bnxt_en: add page_pool support")
Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: michael.chan@broadcom.com

v2:
 - handle storing tx_pkts more carefully
 - now that we touch tx_pkts in the handlers don't pass nr_pkts as
   an arg, makes lines shorter
v1: https://lore.kernel.org/all/20230727170505.1298325-1-kuba@kernel.org/
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 26 +++++++++++--------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  8 +++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  2 +-
 4 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index e5b54e6025be..06b238bef9dd 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -633,12 +633,13 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
-static void bnxt_tx_int(struct bnxt *bp, struct bnxt_napi *bnapi, int nr_pkts)
+static void bnxt_tx_int(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
 {
 	struct bnxt_tx_ring_info *txr = bnapi->tx_ring;
 	struct netdev_queue *txq = netdev_get_tx_queue(bp->dev, txr->txq_index);
 	u16 cons = txr->tx_cons;
 	struct pci_dev *pdev = bp->pdev;
+	int nr_pkts = bnapi->tx_pkts;
 	int i;
 	unsigned int tx_bytes = 0;
 
@@ -688,6 +689,7 @@ static void bnxt_tx_int(struct bnxt *bp, struct bnxt_napi *bnapi, int nr_pkts)
 		dev_kfree_skb_any(skb);
 	}
 
+	bnapi->tx_pkts = 0;
 	WRITE_ONCE(txr->tx_cons, cons);
 
 	__netif_txq_completed_wake(txq, nr_pkts, tx_bytes,
@@ -2569,12 +2571,11 @@ static int __bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	return rx_pkts;
 }
 
-static void __bnxt_poll_work_done(struct bnxt *bp, struct bnxt_napi *bnapi)
+static void __bnxt_poll_work_done(struct bnxt *bp, struct bnxt_napi *bnapi,
+				  int budget)
 {
-	if (bnapi->tx_pkts) {
-		bnapi->tx_int(bp, bnapi, bnapi->tx_pkts);
-		bnapi->tx_pkts = 0;
-	}
+	if (bnapi->tx_pkts)
+		bnapi->tx_int(bp, bnapi, budget);
 
 	if ((bnapi->events & BNXT_RX_EVENT) && !(bnapi->in_reset)) {
 		struct bnxt_rx_ring_info *rxr = bnapi->rx_ring;
@@ -2603,7 +2604,7 @@ static int bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	 */
 	bnxt_db_cq(bp, &cpr->cp_db, cpr->cp_raw_cons);
 
-	__bnxt_poll_work_done(bp, bnapi);
+	__bnxt_poll_work_done(bp, bnapi, budget);
 	return rx_pkts;
 }
 
@@ -2734,7 +2735,7 @@ static int __bnxt_poll_cqs(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
 }
 
 static void __bnxt_poll_cqs_done(struct bnxt *bp, struct bnxt_napi *bnapi,
-				 u64 dbr_type)
+				 u64 dbr_type, int budget)
 {
 	struct bnxt_cp_ring_info *cpr = &bnapi->cp_ring;
 	int i;
@@ -2750,7 +2751,7 @@ static void __bnxt_poll_cqs_done(struct bnxt *bp, struct bnxt_napi *bnapi,
 			cpr2->had_work_done = 0;
 		}
 	}
-	__bnxt_poll_work_done(bp, bnapi);
+	__bnxt_poll_work_done(bp, bnapi, budget);
 }
 
 static int bnxt_poll_p5(struct napi_struct *napi, int budget)
@@ -2780,7 +2781,8 @@ static int bnxt_poll_p5(struct napi_struct *napi, int budget)
 			if (cpr->has_more_work)
 				break;
 
-			__bnxt_poll_cqs_done(bp, bnapi, DBR_TYPE_CQ_ARMALL);
+			__bnxt_poll_cqs_done(bp, bnapi, DBR_TYPE_CQ_ARMALL,
+					     budget);
 			cpr->cp_raw_cons = raw_cons;
 			if (napi_complete_done(napi, work_done))
 				BNXT_DB_NQ_ARM_P5(&cpr->cp_db,
@@ -2810,7 +2812,7 @@ static int bnxt_poll_p5(struct napi_struct *napi, int budget)
 		}
 		raw_cons = NEXT_RAW_CMP(raw_cons);
 	}
-	__bnxt_poll_cqs_done(bp, bnapi, DBR_TYPE_CQ);
+	__bnxt_poll_cqs_done(bp, bnapi, DBR_TYPE_CQ, budget);
 	if (raw_cons != cpr->cp_raw_cons) {
 		cpr->cp_raw_cons = raw_cons;
 		BNXT_DB_NQ_P5(&cpr->cp_db, raw_cons);
@@ -9429,6 +9431,8 @@ static void bnxt_enable_napi(struct bnxt *bp)
 			cpr->sw_stats.rx.rx_resets++;
 		bnapi->in_reset = false;
 
+		bnapi->tx_pkts = 0;
+
 		if (bnapi->rx_ring) {
 			INIT_WORK(&cpr->dim.work, bnxt_dim_work);
 			cpr->dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 080e73496066..bb95c3dc5270 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1005,7 +1005,7 @@ struct bnxt_napi {
 	struct bnxt_tx_ring_info	*tx_ring;
 
 	void			(*tx_int)(struct bnxt *, struct bnxt_napi *,
-					  int);
+					  int budget);
 	int			tx_pkts;
 	u8			events;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 4efa5fe6972b..7f2f9a317d47 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -125,16 +125,20 @@ static void __bnxt_xmit_xdp_redirect(struct bnxt *bp,
 	dma_unmap_len_set(tx_buf, len, 0);
 }
 
-void bnxt_tx_int_xdp(struct bnxt *bp, struct bnxt_napi *bnapi, int nr_pkts)
+void bnxt_tx_int_xdp(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
 {
 	struct bnxt_tx_ring_info *txr = bnapi->tx_ring;
 	struct bnxt_rx_ring_info *rxr = bnapi->rx_ring;
 	bool rx_doorbell_needed = false;
+	int nr_pkts = bnapi->tx_pkts;
 	struct bnxt_sw_tx_bd *tx_buf;
 	u16 tx_cons = txr->tx_cons;
 	u16 last_tx_cons = tx_cons;
 	int i, j, frags;
 
+	if (!budget)
+		return;
+
 	for (i = 0; i < nr_pkts; i++) {
 		tx_buf = &txr->tx_buf_ring[tx_cons];
 
@@ -161,6 +165,8 @@ void bnxt_tx_int_xdp(struct bnxt *bp, struct bnxt_napi *bnapi, int nr_pkts)
 		}
 		tx_cons = NEXT_TX(tx_cons);
 	}
+
+	bnapi->tx_pkts = 0;
 	WRITE_ONCE(txr->tx_cons, tx_cons);
 	if (rx_doorbell_needed) {
 		tx_buf = &txr->tx_buf_ring[last_tx_cons];
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
index ea430d6961df..5e412c5655ba 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
@@ -16,7 +16,7 @@ struct bnxt_sw_tx_bd *bnxt_xmit_bd(struct bnxt *bp,
 				   struct bnxt_tx_ring_info *txr,
 				   dma_addr_t mapping, u32 len,
 				   struct xdp_buff *xdp);
-void bnxt_tx_int_xdp(struct bnxt *bp, struct bnxt_napi *bnapi, int nr_pkts);
+void bnxt_tx_int_xdp(struct bnxt *bp, struct bnxt_napi *bnapi, int budget);
 bool bnxt_rx_xdp(struct bnxt *bp, struct bnxt_rx_ring_info *rxr, u16 cons,
 		 struct xdp_buff xdp, struct page *page, u8 **data_ptr,
 		 unsigned int *len, u8 *event);
-- 
2.41.0


