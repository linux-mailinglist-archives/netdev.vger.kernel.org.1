Return-Path: <netdev+bounces-21996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BA9765980
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 19:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0836D282333
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 17:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE61A27140;
	Thu, 27 Jul 2023 17:05:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AF927124
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 17:05:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D266C433C9;
	Thu, 27 Jul 2023 17:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690477508;
	bh=N3FdRCgfdEUizNY8ckqGduEUcuFJqiS9KxHKvWKtcXU=;
	h=From:To:Cc:Subject:Date:From;
	b=hkSo8aaQW2cBSDwiTQSiIX9uD6grVjoafWqOglkeVK4bVjeOS7BWeDOE1NNC6hpG3
	 wAm5sLs9sGLuL9+074z6Gc7gfovNkf2OWpK63qwpRbXYwfFejWxoCnFhrnC05CDB7B
	 w0JSV2Yqxm0Hizbcq6Sz8nVS11wLSrJlJHlS4r79xNWhi9dCjvuaoa3q6gYdP/Pbp6
	 RPPmzKKJTJfL4eiOLxYJjukO/ccwrckYP6Z7FSahECxHjvBmD3T12/XjcOyeCszS0J
	 TfhCUnACXMgZvdbVf9Hy8MO206imgmQzzsguYLAbaY2LVCGwkfXhb5N82jdTxvOQsK
	 NprzyRE23G0+A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	michael.chan@broadcom.com,
	gospo@broadcom.com
Subject: [PATCH net] bnxt: don't handle XDP in netpoll
Date: Thu, 27 Jul 2023 10:05:05 -0700
Message-ID: <20230727170505.1298325-1-kuba@kernel.org>
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

Fixes: 322b87ca55f2 ("bnxt_en: add page_pool support")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: michael.chan@broadcom.com
CC: gospo@broadcom.com

Side note - having to plumb the "budget" everywhere really makes
me wonder if we shouldn't have had those APIs accept a pointer
to napi_struct instead :S
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 19 +++++++++++--------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  6 +++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  3 ++-
 4 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index a3bbd13c070f..fe1d645c39d0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -687,7 +687,8 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
-static void bnxt_tx_int(struct bnxt *bp, struct bnxt_napi *bnapi, int nr_pkts)
+static void bnxt_tx_int(struct bnxt *bp, struct bnxt_napi *bnapi, int nr_pkts,
+			int budget)
 {
 	struct bnxt_tx_ring_info *txr = bnapi->tx_ring;
 	struct netdev_queue *txq = netdev_get_tx_queue(bp->dev, txr->txq_index);
@@ -2595,10 +2596,11 @@ static int __bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	return rx_pkts;
 }
 
-static void __bnxt_poll_work_done(struct bnxt *bp, struct bnxt_napi *bnapi)
+static void __bnxt_poll_work_done(struct bnxt *bp, struct bnxt_napi *bnapi,
+				  int budget)
 {
 	if (bnapi->tx_pkts && !bnapi->tx_fault) {
-		bnapi->tx_int(bp, bnapi, bnapi->tx_pkts);
+		bnapi->tx_int(bp, bnapi, bnapi->tx_pkts, budget);
 		bnapi->tx_pkts = 0;
 	}
 
@@ -2629,7 +2631,7 @@ static int bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	 */
 	bnxt_db_cq(bp, &cpr->cp_db, cpr->cp_raw_cons);
 
-	__bnxt_poll_work_done(bp, bnapi);
+	__bnxt_poll_work_done(bp, bnapi, budget);
 	return rx_pkts;
 }
 
@@ -2760,7 +2762,7 @@ static int __bnxt_poll_cqs(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
 }
 
 static void __bnxt_poll_cqs_done(struct bnxt *bp, struct bnxt_napi *bnapi,
-				 u64 dbr_type)
+				 u64 dbr_type, int budget)
 {
 	struct bnxt_cp_ring_info *cpr = &bnapi->cp_ring;
 	int i;
@@ -2776,7 +2778,7 @@ static void __bnxt_poll_cqs_done(struct bnxt *bp, struct bnxt_napi *bnapi,
 			cpr2->had_work_done = 0;
 		}
 	}
-	__bnxt_poll_work_done(bp, bnapi);
+	__bnxt_poll_work_done(bp, bnapi, budget);
 }
 
 static int bnxt_poll_p5(struct napi_struct *napi, int budget)
@@ -2806,7 +2808,8 @@ static int bnxt_poll_p5(struct napi_struct *napi, int budget)
 			if (cpr->has_more_work)
 				break;
 
-			__bnxt_poll_cqs_done(bp, bnapi, DBR_TYPE_CQ_ARMALL);
+			__bnxt_poll_cqs_done(bp, bnapi, DBR_TYPE_CQ_ARMALL,
+					     budget);
 			cpr->cp_raw_cons = raw_cons;
 			if (napi_complete_done(napi, work_done))
 				BNXT_DB_NQ_ARM_P5(&cpr->cp_db,
@@ -2836,7 +2839,7 @@ static int bnxt_poll_p5(struct napi_struct *napi, int budget)
 		}
 		raw_cons = NEXT_RAW_CMP(raw_cons);
 	}
-	__bnxt_poll_cqs_done(bp, bnapi, DBR_TYPE_CQ);
+	__bnxt_poll_cqs_done(bp, bnapi, DBR_TYPE_CQ, budget);
 	if (raw_cons != cpr->cp_raw_cons) {
 		cpr->cp_raw_cons = raw_cons;
 		BNXT_DB_NQ_P5(&cpr->cp_db, raw_cons);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 9d16757e27fe..bd44a5701e5f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1005,7 +1005,7 @@ struct bnxt_napi {
 	struct bnxt_tx_ring_info	*tx_ring;
 
 	void			(*tx_int)(struct bnxt *, struct bnxt_napi *,
-					  int);
+					  int tx_pkts, int budget);
 	int			tx_pkts;
 	u8			events;
 	u8			tx_fault:1;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 5b6fbdc4dc40..33b7eddfbf41 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -125,7 +125,8 @@ static void __bnxt_xmit_xdp_redirect(struct bnxt *bp,
 	dma_unmap_len_set(tx_buf, len, 0);
 }
 
-void bnxt_tx_int_xdp(struct bnxt *bp, struct bnxt_napi *bnapi, int nr_pkts)
+void bnxt_tx_int_xdp(struct bnxt *bp, struct bnxt_napi *bnapi, int nr_pkts,
+		     int budget)
 {
 	struct bnxt_tx_ring_info *txr = bnapi->tx_ring;
 	struct bnxt_rx_ring_info *rxr = bnapi->rx_ring;
@@ -135,6 +136,9 @@ void bnxt_tx_int_xdp(struct bnxt *bp, struct bnxt_napi *bnapi, int nr_pkts)
 	u16 last_tx_cons = tx_cons;
 	int i, j, frags;
 
+	if (!budget)
+		return;
+
 	for (i = 0; i < nr_pkts; i++) {
 		tx_buf = &txr->tx_buf_ring[tx_cons];
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
index ea430d6961df..3ab47ae2f26d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
@@ -16,7 +16,8 @@ struct bnxt_sw_tx_bd *bnxt_xmit_bd(struct bnxt *bp,
 				   struct bnxt_tx_ring_info *txr,
 				   dma_addr_t mapping, u32 len,
 				   struct xdp_buff *xdp);
-void bnxt_tx_int_xdp(struct bnxt *bp, struct bnxt_napi *bnapi, int nr_pkts);
+void bnxt_tx_int_xdp(struct bnxt *bp, struct bnxt_napi *bnapi, int nr_pkts,
+		     int budget);
 bool bnxt_rx_xdp(struct bnxt *bp, struct bnxt_rx_ring_info *rxr, u16 cons,
 		 struct xdp_buff xdp, struct page *page, u8 **data_ptr,
 		 unsigned int *len, u8 *event);
-- 
2.41.0


