Return-Path: <netdev+bounces-135372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 836E099DA1D
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 01:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E941F1F21319
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 23:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9B11D5AC7;
	Mon, 14 Oct 2024 23:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="RvbrB5Ap"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAEE231C94
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 23:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728948620; cv=none; b=CvWnylxNppzuf9Db1JrNzGIUlAqvLDOT21D/hpAbSlwunAFN1Z+BajtkleUrHx91vH/HtDgqs48RdVAKBTDa7E5dBrw9AG+bjFo/VjkbjwvFixOLNM0fJ/IETT/dITQZ5+sfaw9bsjI4UtEwYDyxmMuqvtXILvbxejykXGZ5+mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728948620; c=relaxed/simple;
	bh=8z7ASGq3teEGAnmVY64EhKR0mBbI9FS7/x9q+5ubdA8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hbJSiM00p5hbmKJRNiSFUw/JmhcbN/t/oT1SG7E6zRX4wnLwAnIvuU7ofhz+sYAy+wIy7Oak+5060YbbuS0A2kIy56DUvlapxqDQ0yJDPAMA2VXy/2S8Nevep1UwgTpf0TQDe5H49USKqvaBK4oNq2InQMJbW7nMJpfhMAcG8/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=RvbrB5Ap; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49ENTep1007664;
	Mon, 14 Oct 2024 16:29:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=2fOPYQv1css2gZ0elp
	B3qpkR8L97fVPGR0pXSRmECaI=; b=RvbrB5ApQmHDuItn74IHn7mldRu/KFZdKY
	ImjI1AoIiWlwZOkxw/BoD4MFe664ZBE5ln6Ne3SqKneFkIDL/tWmE5ZAbVAxs/1M
	CS0gIEUKYhdj0tMcqZk2r0tf8rVyKJwa6xJZDjUvggjnT8Zl8V/TwHTlofU86Zhw
	ahWr2ShH0VNYlZ7fb83OofENzu4obfw7afz9uvlD7zpPDv5U3Pb/7V0f4yRiVBwx
	XHJ8kkN4M5+uC2gXp4/t9H44MZrQ8trno/4uG1BROP5xVDenJrXUfOdTZlenGKiF
	dbDDTXCgs0+CtIrBgVGUUQIzZytMLrOQQt8BsnF/TXPtGFfIZn3A==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 428c4srqfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 14 Oct 2024 16:29:57 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server id
 15.2.1544.11; Mon, 14 Oct 2024 23:29:54 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Michael Chan <michael.chan@broadcom.com>,
        Vadim Fedorenko
	<vadim.fedorenko@linux.dev>,
        Jakub Kicinski <kuba@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, Vadim Fedorenko <vadfed@meta.com>
Subject: [PATCH net-next] bnxt_en: replace PTP spinlock with seqlock
Date: Mon, 14 Oct 2024 16:29:47 -0700
Message-ID: <20241014232947.4059941-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 1GuoLigwu-5M1bQw-B-kbh5oxmaoqbFz
X-Proofpoint-ORIG-GUID: 1GuoLigwu-5M1bQw-B-kbh5oxmaoqbFz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

We can see high contention on ptp_lock while doing RX timestamping
on high packet rates over several queues. Spinlock is not effecient
to protect timecounter for RX timestamps when reads are the most
usual operations and writes are only occasional. It's better to use
seqlock in such cases.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 30 +++-----
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 76 +++++++++----------
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h | 26 +++++--
 3 files changed, 67 insertions(+), 65 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6e422e24750a..0c1a52681822 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2255,9 +2255,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 			if (!bnxt_get_rx_ts_p5(bp, &ts, cmpl_ts)) {
 				struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
 
-				spin_lock_bh(&ptp->ptp_lock);
-				ns = timecounter_cyc2time(&ptp->tc, ts);
-				spin_unlock_bh(&ptp->ptp_lock);
+				ns = bnxt_timecounter_cyc2time(ptp, ts);
 				memset(skb_hwtstamps(skb), 0,
 				       sizeof(*skb_hwtstamps(skb)));
 				skb_hwtstamps(skb)->hwtstamp = ns_to_ktime(ns);
@@ -2757,17 +2755,18 @@ static int bnxt_async_event_process(struct bnxt *bp,
 		case ASYNC_EVENT_CMPL_PHC_UPDATE_EVENT_DATA1_FLAGS_PHC_RTC_UPDATE:
 			if (BNXT_PTP_USE_RTC(bp)) {
 				struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
+				unsigned long flags;
 				u64 ns;
 
 				if (!ptp)
 					goto async_event_process_exit;
 
-				spin_lock_bh(&ptp->ptp_lock);
+				write_seqlock_irqsave(&ptp->ptp_lock, flags);
 				bnxt_ptp_update_current_time(bp);
 				ns = (((u64)BNXT_EVENT_PHC_RTC_UPDATE(data1) <<
 				       BNXT_PHC_BITS) | ptp->current_time);
 				bnxt_ptp_rtc_timecounter_init(ptp, ns);
-				spin_unlock_bh(&ptp->ptp_lock);
+				write_sequnlock_irqrestore(&ptp->ptp_lock, flags);
 			}
 			break;
 		}
@@ -13493,13 +13492,9 @@ static void bnxt_force_fw_reset(struct bnxt *bp)
 	    test_bit(BNXT_STATE_IN_FW_RESET, &bp->state))
 		return;
 
-	if (ptp) {
-		spin_lock_bh(&ptp->ptp_lock);
-		set_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
-		spin_unlock_bh(&ptp->ptp_lock);
-	} else {
-		set_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
-	}
+	set_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
+	/* Make sure TS reader can see RESET bit set */
+	smp_mb__after_atomic();
 	bnxt_fw_reset_close(bp);
 	wait_dsecs = fw_health->master_func_wait_dsecs;
 	if (fw_health->primary) {
@@ -13560,13 +13555,10 @@ void bnxt_fw_reset(struct bnxt *bp)
 		struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
 		int n = 0, tmo;
 
-		if (ptp) {
-			spin_lock_bh(&ptp->ptp_lock);
-			set_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
-			spin_unlock_bh(&ptp->ptp_lock);
-		} else {
-			set_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
-		}
+		set_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
+		/* Make sure TS reader can see RESET bit set */
+		smp_mb__after_atomic();
+
 		if (bp->pf.active_vfs &&
 		    !test_bit(BNXT_STATE_FW_FATAL_COND, &bp->state))
 			n = bnxt_get_registered_vfs(bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index 37d42423459c..ee4287519c50 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -62,23 +62,25 @@ static int bnxt_ptp_settime(struct ptp_clock_info *ptp_info,
 	struct bnxt_ptp_cfg *ptp = container_of(ptp_info, struct bnxt_ptp_cfg,
 						ptp_info);
 	u64 ns = timespec64_to_ns(ts);
+	unsigned long flags;
 
 	if (BNXT_PTP_USE_RTC(ptp->bp))
 		return bnxt_ptp_cfg_settime(ptp->bp, ns);
 
-	spin_lock_bh(&ptp->ptp_lock);
+	write_seqlock_irqsave(&ptp->ptp_lock, flags);
 	timecounter_init(&ptp->tc, &ptp->cc, ns);
-	spin_unlock_bh(&ptp->ptp_lock);
+	write_sequnlock_irqrestore(&ptp->ptp_lock, flags);
 	return 0;
 }
 
-/* Caller holds ptp_lock */
 static int bnxt_refclk_read(struct bnxt *bp, struct ptp_system_timestamp *sts,
 			    u64 *ns)
 {
 	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
 	u32 high_before, high_now, low;
 
+	/* Make sure the RESET bit is set */
+	smp_mb__before_atomic();
 	if (test_bit(BNXT_STATE_IN_FW_RESET, &bp->state))
 		return -EIO;
 
@@ -100,13 +102,14 @@ static int bnxt_refclk_read(struct bnxt *bp, struct ptp_system_timestamp *sts,
 static void bnxt_ptp_get_current_time(struct bnxt *bp)
 {
 	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
+	unsigned long flags;
 
 	if (!ptp)
 		return;
-	spin_lock_bh(&ptp->ptp_lock);
+	write_seqlock_irqsave(&ptp->ptp_lock, flags);
 	WRITE_ONCE(ptp->old_time, ptp->current_time);
 	bnxt_refclk_read(bp, NULL, &ptp->current_time);
-	spin_unlock_bh(&ptp->ptp_lock);
+	write_sequnlock_irqrestore(&ptp->ptp_lock, flags);
 }
 
 static int bnxt_hwrm_port_ts_query(struct bnxt *bp, u32 flags, u64 *ts,
@@ -152,20 +155,16 @@ static int bnxt_ptp_gettimex(struct ptp_clock_info *ptp_info,
 	u64 ns, cycles;
 	int rc;
 
-	spin_lock_bh(&ptp->ptp_lock);
 	rc = bnxt_refclk_read(ptp->bp, sts, &cycles);
-	if (rc) {
-		spin_unlock_bh(&ptp->ptp_lock);
+	if (rc)
 		return rc;
-	}
-	ns = timecounter_cyc2time(&ptp->tc, cycles);
-	spin_unlock_bh(&ptp->ptp_lock);
+
+	ns = bnxt_timecounter_cyc2time(ptp, cycles);
 	*ts = ns_to_timespec64(ns);
 
 	return 0;
 }
 
-/* Caller holds ptp_lock */
 void bnxt_ptp_update_current_time(struct bnxt *bp)
 {
 	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
@@ -177,6 +176,7 @@ void bnxt_ptp_update_current_time(struct bnxt *bp)
 static int bnxt_ptp_adjphc(struct bnxt_ptp_cfg *ptp, s64 delta)
 {
 	struct hwrm_port_mac_cfg_input *req;
+	unsigned long flags;
 	int rc;
 
 	rc = hwrm_req_init(ptp->bp, req, HWRM_PORT_MAC_CFG);
@@ -190,9 +190,9 @@ static int bnxt_ptp_adjphc(struct bnxt_ptp_cfg *ptp, s64 delta)
 	if (rc) {
 		netdev_err(ptp->bp->dev, "ptp adjphc failed. rc = %x\n", rc);
 	} else {
-		spin_lock_bh(&ptp->ptp_lock);
+		write_seqlock_irqsave(&ptp->ptp_lock, flags);
 		bnxt_ptp_update_current_time(ptp->bp);
-		spin_unlock_bh(&ptp->ptp_lock);
+		write_sequnlock_irqrestore(&ptp->ptp_lock, flags);
 	}
 
 	return rc;
@@ -202,13 +202,14 @@ static int bnxt_ptp_adjtime(struct ptp_clock_info *ptp_info, s64 delta)
 {
 	struct bnxt_ptp_cfg *ptp = container_of(ptp_info, struct bnxt_ptp_cfg,
 						ptp_info);
+	unsigned long flags;
 
 	if (BNXT_PTP_USE_RTC(ptp->bp))
 		return bnxt_ptp_adjphc(ptp, delta);
 
-	spin_lock_bh(&ptp->ptp_lock);
+	write_seqlock_irqsave(&ptp->ptp_lock, flags);
 	timecounter_adjtime(&ptp->tc, delta);
-	spin_unlock_bh(&ptp->ptp_lock);
+	write_sequnlock_irqrestore(&ptp->ptp_lock, flags);
 	return 0;
 }
 
@@ -236,14 +237,15 @@ static int bnxt_ptp_adjfine(struct ptp_clock_info *ptp_info, long scaled_ppm)
 	struct bnxt_ptp_cfg *ptp = container_of(ptp_info, struct bnxt_ptp_cfg,
 						ptp_info);
 	struct bnxt *bp = ptp->bp;
+	unsigned long flags;
 
 	if (!BNXT_MH(bp))
 		return bnxt_ptp_adjfine_rtc(bp, scaled_ppm);
 
-	spin_lock_bh(&ptp->ptp_lock);
+	write_seqlock_irqsave(&ptp->ptp_lock, flags);
 	timecounter_read(&ptp->tc);
 	ptp->cc.mult = adjust_by_scaled_ppm(ptp->cmult, scaled_ppm);
-	spin_unlock_bh(&ptp->ptp_lock);
+	write_sequnlock_irqrestore(&ptp->ptp_lock, flags);
 	return 0;
 }
 
@@ -254,9 +256,7 @@ void bnxt_ptp_pps_event(struct bnxt *bp, u32 data1, u32 data2)
 	u64 ns, pps_ts;
 
 	pps_ts = EVENT_PPS_TS(data2, data1);
-	spin_lock_bh(&ptp->ptp_lock);
-	ns = timecounter_cyc2time(&ptp->tc, pps_ts);
-	spin_unlock_bh(&ptp->ptp_lock);
+	ns = bnxt_timecounter_cyc2time(ptp, pps_ts);
 
 	switch (EVENT_DATA2_PPS_EVENT_TYPE(data2)) {
 	case ASYNC_EVENT_CMPL_PPS_TIMESTAMP_EVENT_DATA2_EVENT_TYPE_INTERNAL:
@@ -395,14 +395,11 @@ static int bnxt_get_target_cycles(struct bnxt_ptp_cfg *ptp, u64 target_ns,
 	u64 nsec_now, nsec_delta;
 	int rc;
 
-	spin_lock_bh(&ptp->ptp_lock);
 	rc = bnxt_refclk_read(ptp->bp, NULL, &cycles_now);
-	if (rc) {
-		spin_unlock_bh(&ptp->ptp_lock);
+	if (rc)
 		return rc;
-	}
-	nsec_now = timecounter_cyc2time(&ptp->tc, cycles_now);
-	spin_unlock_bh(&ptp->ptp_lock);
+
+	nsec_now = bnxt_timecounter_cyc2time(ptp, cycles_now);
 
 	nsec_delta = target_ns - nsec_now;
 	*cycles_delta = div64_u64(nsec_delta << ptp->cc.shift, ptp->cc.mult);
@@ -702,9 +699,7 @@ static int bnxt_stamp_tx_skb(struct bnxt *bp, int slot)
 				     tmo, slot);
 	if (!rc) {
 		memset(&timestamp, 0, sizeof(timestamp));
-		spin_lock_bh(&ptp->ptp_lock);
-		ns = timecounter_cyc2time(&ptp->tc, ts);
-		spin_unlock_bh(&ptp->ptp_lock);
+		ns = bnxt_timecounter_cyc2time(ptp, ts);
 		timestamp.hwtstamp = ns_to_ktime(ns);
 		skb_tstamp_tx(txts_req->tx_skb, &timestamp);
 		ptp->stats.ts_pkts++;
@@ -730,6 +725,7 @@ static long bnxt_ptp_ts_aux_work(struct ptp_clock_info *ptp_info)
 	unsigned long now = jiffies;
 	struct bnxt *bp = ptp->bp;
 	u16 cons = ptp->txts_cons;
+	unsigned long flags;
 	u32 num_requests;
 	int rc = 0;
 
@@ -757,9 +753,9 @@ static long bnxt_ptp_ts_aux_work(struct ptp_clock_info *ptp_info)
 	bnxt_ptp_get_current_time(bp);
 	ptp->next_period = now + HZ;
 	if (time_after_eq(now, ptp->next_overflow_check)) {
-		spin_lock_bh(&ptp->ptp_lock);
+		write_seqlock_irqsave(&ptp->ptp_lock, flags);
 		timecounter_read(&ptp->tc);
-		spin_unlock_bh(&ptp->ptp_lock);
+		write_sequnlock_irqrestore(&ptp->ptp_lock, flags);
 		ptp->next_overflow_check = now + BNXT_PHC_OVERFLOW_PERIOD;
 	}
 	if (rc == -EAGAIN)
@@ -833,9 +829,7 @@ void bnxt_tx_ts_cmp(struct bnxt *bp, struct bnxt_napi *bnapi,
 				   le32_to_cpu(tscmp->tx_ts_cmp_flags_type),
 				   le32_to_cpu(tscmp->tx_ts_cmp_errors_v));
 		} else {
-			spin_lock_bh(&ptp->ptp_lock);
-			ns = timecounter_cyc2time(&ptp->tc, ts);
-			spin_unlock_bh(&ptp->ptp_lock);
+			ns = bnxt_timecounter_cyc2time(ptp, ts);
 			timestamp.hwtstamp = ns_to_ktime(ns);
 			skb_tstamp_tx(tx_buf->skb, &timestamp);
 		}
@@ -975,6 +969,7 @@ void bnxt_ptp_rtc_timecounter_init(struct bnxt_ptp_cfg *ptp, u64 ns)
 int bnxt_ptp_init_rtc(struct bnxt *bp, bool phc_cfg)
 {
 	struct timespec64 tsp;
+	unsigned long flags;
 	u64 ns;
 	int rc;
 
@@ -993,9 +988,9 @@ int bnxt_ptp_init_rtc(struct bnxt *bp, bool phc_cfg)
 		if (rc)
 			return rc;
 	}
-	spin_lock_bh(&bp->ptp_cfg->ptp_lock);
+	write_seqlock_irqsave(&bp->ptp_cfg->ptp_lock, flags);
 	bnxt_ptp_rtc_timecounter_init(bp->ptp_cfg, ns);
-	spin_unlock_bh(&bp->ptp_cfg->ptp_lock);
+	write_sequnlock_irqrestore(&bp->ptp_cfg->ptp_lock, flags);
 
 	return 0;
 }
@@ -1015,6 +1010,7 @@ static void bnxt_ptp_free(struct bnxt *bp)
 int bnxt_ptp_init(struct bnxt *bp, bool phc_cfg)
 {
 	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
+	unsigned long flags;
 	int rc;
 
 	if (!ptp)
@@ -1030,7 +1026,7 @@ int bnxt_ptp_init(struct bnxt *bp, bool phc_cfg)
 	bnxt_ptp_free(bp);
 
 	WRITE_ONCE(ptp->tx_avail, BNXT_MAX_TX_TS);
-	spin_lock_init(&ptp->ptp_lock);
+	seqlock_init(&ptp->ptp_lock);
 	spin_lock_init(&ptp->ptp_tx_lock);
 
 	if (BNXT_PTP_USE_RTC(bp)) {
@@ -1063,10 +1059,10 @@ int bnxt_ptp_init(struct bnxt *bp, bool phc_cfg)
 	atomic64_set(&ptp->stats.ts_err, 0);
 
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
-		spin_lock_bh(&ptp->ptp_lock);
+		write_seqlock_irqsave(&ptp->ptp_lock, flags);
 		bnxt_refclk_read(bp, NULL, &ptp->current_time);
 		WRITE_ONCE(ptp->old_time, ptp->current_time);
-		spin_unlock_bh(&ptp->ptp_lock);
+		write_sequnlock_irqrestore(&ptp->ptp_lock, flags);
 		ptp_schedule_worker(ptp->ptp_clock, 0);
 	}
 	ptp->txts_tmo = BNXT_PTP_DFLT_TX_TMO;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
index a9a2f9a18c9c..103eff803a3b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
@@ -102,7 +102,7 @@ struct bnxt_ptp_cfg {
 	struct timecounter	tc;
 	struct bnxt_pps		pps_info;
 	/* serialize timecounter access */
-	spinlock_t		ptp_lock;
+	seqlock_t		ptp_lock;
 	/* serialize ts tx request queuing */
 	spinlock_t		ptp_tx_lock;
 	u64			current_time;
@@ -146,11 +146,13 @@ struct bnxt_ptp_cfg {
 };
 
 #if BITS_PER_LONG == 32
-#define BNXT_READ_TIME64(ptp, dst, src)		\
-do {						\
-	spin_lock_bh(&(ptp)->ptp_lock);		\
-	(dst) = (src);				\
-	spin_unlock_bh(&(ptp)->ptp_lock);	\
+#define BNXT_READ_TIME64(ptp, dst, src)			\
+do {							\
+	unsigned int seq;				\
+	do {						\
+		seq = read_seqbegin(&(ptp)->ptp_lock);	\
+		(dst) = (src);				\
+	while (read_seqretry(&(ptp)->ptp_lock, seq);	\
 } while (0)
 #else
 #define BNXT_READ_TIME64(ptp, dst, src)		\
@@ -180,4 +182,16 @@ void bnxt_ptp_rtc_timecounter_init(struct bnxt_ptp_cfg *ptp, u64 ns);
 int bnxt_ptp_init_rtc(struct bnxt *bp, bool phc_cfg);
 int bnxt_ptp_init(struct bnxt *bp, bool phc_cfg);
 void bnxt_ptp_clear(struct bnxt *bp);
+static inline u64 bnxt_timecounter_cyc2time(struct bnxt_ptp_cfg *ptp, u64 ts)
+{
+	unsigned int seq;
+	u64 ns;
+
+	do {
+		seq = read_seqbegin(&ptp->ptp_lock);
+		ns = timecounter_cyc2time(&ptp->tc, ts);
+	} while (read_seqretry(&ptp->ptp_lock, seq));
+
+	return ns;
+}
 #endif
-- 
2.43.5


