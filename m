Return-Path: <netdev+bounces-16600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4C874DFDC
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 22:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05A311C208DC
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 20:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36481156CA;
	Mon, 10 Jul 2023 20:56:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2D214A93
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 20:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B3AC433CA;
	Mon, 10 Jul 2023 20:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689022585;
	bh=JHIezJ5TKteznOV0CqqRfuk2kryDOMEgMOVpYrxqQOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LXSEaMr9NnsPlDbJ730kgn6IVeHYcX8tWkef9LUMlSdjydHT+3x/MomfTOLR8mSRh
	 23otXcV38w2Pb0AIEJr7y9BSQaD06a5mFRD3yk1KCA+P2dLl+hTTJMnkBSoiQ5JPOv
	 +MssZiIRijceBfHEdSyoyN7QRr6kQcBAA7a/G83k0RjN/z/EymFvcOUjbmpJ1oiCcS
	 NvNuo3V3uOUi7tr/s/+F8mOaDQiF2hV4yFnukjMTFrcWIPTC27DshjNYnDCiHd0uDA
	 lA13Pa4C+ze1ONkhhF8J3f6eJ/mipMATYjo9Rhk6bvVK74v7uOPHQG3450RAooqf/f
	 NGpu+M/wywfkw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	michael.chan@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/3] eth: bnxt: move and rename reset helpers
Date: Mon, 10 Jul 2023 13:56:09 -0700
Message-ID: <20230710205611.1198878-2-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230710205611.1198878-1-kuba@kernel.org>
References: <20230710205611.1198878-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the reset helpers, subsequent patches will need some
of them on the Tx path.

While at it rename bnxt_sched_reset(), on more recent chips
it schedules a queue reset, instead of a fuller reset.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 72 +++++++++++------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index e5b54e6025be..568bcf1c9928 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -293,6 +293,38 @@ static void bnxt_db_cq(struct bnxt *bp, struct bnxt_db_info *db, u32 idx)
 		BNXT_DB_CQ(db, idx);
 }
 
+static void bnxt_queue_fw_reset_work(struct bnxt *bp, unsigned long delay)
+{
+	if (!(test_bit(BNXT_STATE_IN_FW_RESET, &bp->state)))
+		return;
+
+	if (BNXT_PF(bp))
+		queue_delayed_work(bnxt_pf_wq, &bp->fw_reset_task, delay);
+	else
+		schedule_delayed_work(&bp->fw_reset_task, delay);
+}
+
+static void bnxt_queue_sp_work(struct bnxt *bp)
+{
+	if (BNXT_PF(bp))
+		queue_work(bnxt_pf_wq, &bp->sp_task);
+	else
+		schedule_work(&bp->sp_task);
+}
+
+static void bnxt_sched_reset_rxr(struct bnxt *bp, struct bnxt_rx_ring_info *rxr)
+{
+	if (!rxr->bnapi->in_reset) {
+		rxr->bnapi->in_reset = true;
+		if (bp->flags & BNXT_FLAG_CHIP_P5)
+			set_bit(BNXT_RESET_TASK_SP_EVENT, &bp->sp_event);
+		else
+			set_bit(BNXT_RST_RING_SP_EVENT, &bp->sp_event);
+		bnxt_queue_sp_work(bp);
+	}
+	rxr->rx_next_cons = 0xffff;
+}
+
 const u16 bnxt_lhint_arr[] = {
 	TX_BD_FLAGS_LHINT_512_AND_SMALLER,
 	TX_BD_FLAGS_LHINT_512_TO_1023,
@@ -1234,38 +1266,6 @@ static int bnxt_discard_rx(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	return 0;
 }
 
-static void bnxt_queue_fw_reset_work(struct bnxt *bp, unsigned long delay)
-{
-	if (!(test_bit(BNXT_STATE_IN_FW_RESET, &bp->state)))
-		return;
-
-	if (BNXT_PF(bp))
-		queue_delayed_work(bnxt_pf_wq, &bp->fw_reset_task, delay);
-	else
-		schedule_delayed_work(&bp->fw_reset_task, delay);
-}
-
-static void bnxt_queue_sp_work(struct bnxt *bp)
-{
-	if (BNXT_PF(bp))
-		queue_work(bnxt_pf_wq, &bp->sp_task);
-	else
-		schedule_work(&bp->sp_task);
-}
-
-static void bnxt_sched_reset(struct bnxt *bp, struct bnxt_rx_ring_info *rxr)
-{
-	if (!rxr->bnapi->in_reset) {
-		rxr->bnapi->in_reset = true;
-		if (bp->flags & BNXT_FLAG_CHIP_P5)
-			set_bit(BNXT_RESET_TASK_SP_EVENT, &bp->sp_event);
-		else
-			set_bit(BNXT_RST_RING_SP_EVENT, &bp->sp_event);
-		bnxt_queue_sp_work(bp);
-	}
-	rxr->rx_next_cons = 0xffff;
-}
-
 static u16 bnxt_alloc_agg_idx(struct bnxt_rx_ring_info *rxr, u16 agg_id)
 {
 	struct bnxt_tpa_idx_map *map = rxr->rx_tpa_idx_map;
@@ -1320,7 +1320,7 @@ static void bnxt_tpa_start(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 		netdev_warn(bp->dev, "TPA cons %x, expected cons %x, error code %x\n",
 			    cons, rxr->rx_next_cons,
 			    TPA_START_ERROR_CODE(tpa_start1));
-		bnxt_sched_reset(bp, rxr);
+		bnxt_sched_reset_rxr(bp, rxr);
 		return;
 	}
 	/* Store cfa_code in tpa_info to use in tpa_end
@@ -1844,7 +1844,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 		if (rxr->rx_next_cons != 0xffff)
 			netdev_warn(bp->dev, "RX cons %x != expected cons %x\n",
 				    cons, rxr->rx_next_cons);
-		bnxt_sched_reset(bp, rxr);
+		bnxt_sched_reset_rxr(bp, rxr);
 		if (rc1)
 			return rc1;
 		goto next_rx_no_prod_no_len;
@@ -1882,7 +1882,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 			    !(bp->fw_cap & BNXT_FW_CAP_RING_MONITOR)) {
 				netdev_warn_once(bp->dev, "RX buffer error %x\n",
 						 rx_err);
-				bnxt_sched_reset(bp, rxr);
+				bnxt_sched_reset_rxr(bp, rxr);
 			}
 		}
 		goto next_rx_no_len;
@@ -2329,7 +2329,7 @@ static int bnxt_async_event_process(struct bnxt *bp,
 			goto async_event_process_exit;
 		}
 		rxr = bp->bnapi[grp_idx]->rx_ring;
-		bnxt_sched_reset(bp, rxr);
+		bnxt_sched_reset_rxr(bp, rxr);
 		goto async_event_process_exit;
 	}
 	case ASYNC_EVENT_CMPL_EVENT_ID_ECHO_REQUEST: {
-- 
2.41.0


