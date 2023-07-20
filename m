Return-Path: <netdev+bounces-19310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3369E75A3C1
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 03:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E14DD281BDF
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 01:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C686C631;
	Thu, 20 Jul 2023 01:05:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEC7649
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 01:05:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FF8C433CC;
	Thu, 20 Jul 2023 01:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689815108;
	bh=x/yJhFsPFpsrDwo1jqo8zIXIUG/Fl3+vZWxUrwy2ewQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZyZkm9X7DLtQWLpq5ZbmBZWqxcSsKkl5UiKTytsa51IpHdrnilQ/mFzhq/Q+HTA1F
	 TfAKQi4pTotPXayfgV5KnwvalDBXF4oIX6U66+0VmsRycd8iGwGVMPs9K/ixuza4Zl
	 L/3NUtyrZO7v27Zau++tgCHTrrF6TH38EL8k/OG3uot9U6CJHKLejuNgvr0Pg/CuQm
	 uWQ3MLKKgc+ey4iGo6gCk1ne/gV1d3D2sh6ikoPYhgJpbnGs24jySaNFwKVD83Bv6S
	 SsWRZZOZXP7ev0ds1qU67WbMyEbvSM1ImLXOirab3aZPjmGuSBfC6Iqb90Hh247lSD
	 i4+8goiWnr9nA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	michael.chan@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 3/3] eth: bnxt: handle invalid Tx completions more gracefully
Date: Wed, 19 Jul 2023 18:04:40 -0700
Message-ID: <20230720010440.1967136-4-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230720010440.1967136-1-kuba@kernel.org>
References: <20230720010440.1967136-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Invalid Tx completions should never happen (tm) but when they do
they crash the host, because driver blindly trusts that there is
a valid skb pointer on the ring.

The completions I've seen appear to be some form of FW / HW
miscalculation or staleness, they have typical (small) values
(<100), but they are most often higher than number of queued
descriptors. They usually happen after boot.

Instead of crashing, print a warning and schedule a reset.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
--
v2:
 - factor out the reset scheduling to a helper
 - add the check in XDP as well
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 25 ++++++++++++++++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  3 +++
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  4 +++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7b545d2a98b4..a3bbd13c070f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -331,6 +331,22 @@ static void bnxt_sched_reset_rxr(struct bnxt *bp, struct bnxt_rx_ring_info *rxr)
 	rxr->rx_next_cons = 0xffff;
 }
 
+void bnxt_sched_reset_txr(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+			  int idx)
+{
+	struct bnxt_napi *bnapi = txr->bnapi;
+
+	if (bnapi->tx_fault)
+		return;
+
+	netdev_err(bp->dev, "Invalid Tx completion (ring:%d tx_pkts:%d cons:%u prod:%u i:%d)",
+		   txr->txq_index, bnapi->tx_pkts,
+		   txr->tx_cons, txr->tx_prod, idx);
+	WARN_ON_ONCE(1);
+	bnapi->tx_fault = 1;
+	bnxt_queue_sp_work(bp, BNXT_RESET_TASK_SP_EVENT);
+}
+
 const u16 bnxt_lhint_arr[] = {
 	TX_BD_FLAGS_LHINT_512_AND_SMALLER,
 	TX_BD_FLAGS_LHINT_512_TO_1023,
@@ -690,6 +706,11 @@ static void bnxt_tx_int(struct bnxt *bp, struct bnxt_napi *bnapi, int nr_pkts)
 		skb = tx_buf->skb;
 		tx_buf->skb = NULL;
 
+		if (unlikely(!skb)) {
+			bnxt_sched_reset_txr(bp, txr, i);
+			return;
+		}
+
 		tx_bytes += skb->len;
 
 		if (tx_buf->is_push) {
@@ -2576,7 +2597,7 @@ static int __bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 
 static void __bnxt_poll_work_done(struct bnxt *bp, struct bnxt_napi *bnapi)
 {
-	if (bnapi->tx_pkts) {
+	if (bnapi->tx_pkts && !bnapi->tx_fault) {
 		bnapi->tx_int(bp, bnapi, bnapi->tx_pkts);
 		bnapi->tx_pkts = 0;
 	}
@@ -9429,6 +9450,8 @@ static void bnxt_enable_napi(struct bnxt *bp)
 		struct bnxt_napi *bnapi = bp->bnapi[i];
 		struct bnxt_cp_ring_info *cpr;
 
+		bnapi->tx_fault = 0;
+
 		cpr = &bnapi->cp_ring;
 		if (bnapi->in_reset)
 			cpr->sw_stats.rx.rx_resets++;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 080e73496066..9d16757e27fe 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1008,6 +1008,7 @@ struct bnxt_napi {
 					  int);
 	int			tx_pkts;
 	u8			events;
+	u8			tx_fault:1;
 
 	u32			flags;
 #define BNXT_NAPI_FLAG_XDP	0x1
@@ -2329,6 +2330,8 @@ int bnxt_get_avail_msix(struct bnxt *bp, int num);
 int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init);
 void bnxt_tx_disable(struct bnxt *bp);
 void bnxt_tx_enable(struct bnxt *bp);
+void bnxt_sched_reset_txr(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+			  int idx);
 void bnxt_report_link(struct bnxt *bp);
 int bnxt_update_link(struct bnxt *bp, bool chng_link_state);
 int bnxt_hwrm_set_pause(struct bnxt *);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 4efa5fe6972b..5b6fbdc4dc40 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -149,6 +149,7 @@ void bnxt_tx_int_xdp(struct bnxt *bp, struct bnxt_napi *bnapi, int nr_pkts)
 			tx_buf->action = 0;
 			tx_buf->xdpf = NULL;
 		} else if (tx_buf->action == XDP_TX) {
+			tx_buf->action = 0;
 			rx_doorbell_needed = true;
 			last_tx_cons = tx_cons;
 
@@ -158,6 +159,9 @@ void bnxt_tx_int_xdp(struct bnxt *bp, struct bnxt_napi *bnapi, int nr_pkts)
 				tx_buf = &txr->tx_buf_ring[tx_cons];
 				page_pool_recycle_direct(rxr->page_pool, tx_buf->page);
 			}
+		} else {
+			bnxt_sched_reset_txr(bp, txr, i);
+			return;
 		}
 		tx_cons = NEXT_TX(tx_cons);
 	}
-- 
2.41.0


