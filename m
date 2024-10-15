Return-Path: <netdev+bounces-135850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 277E299F69B
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 20:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CEC81F2464D
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 18:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679301B6D08;
	Tue, 15 Oct 2024 18:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="NPOeCBRa"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6341A1F6695
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 18:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729018425; cv=none; b=epbfowcDxb7q20oafy29Q6UW4VJ/kTKNgHPrjBhCffstjFT2phzE675pPkhySDvo4l799f3qfY4+8lJMp1kyNE7LNJDHQoA+nS0Ui7sNxEoKQqeQL9fsu/DfDemNjk/GAzjvsUECkcF8z2kL8xracLqn7hfi1CAhlzouXXTZ9Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729018425; c=relaxed/simple;
	bh=LP0llIjm3FnSKLf1YIVOjbPCtWiuce7UzcruKETxN0Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ot0Ba4MmEAugRpZ67EsN6RppIs1sPCwTGa+SHZVVoBWB+S/DmxEjLkwwPEN3UtwdAsw+9xcrqfnViJoTvujCjilYY8BYdEatGncRhd72gRHxZK/X/uw6dsgArkOjuH3j7b35erpxGpCDhQIXcY1lVpyi5r05amu7NZBWCctJCJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=NPOeCBRa; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FINg7G000392;
	Tue, 15 Oct 2024 11:53:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=UO4OFj24RrdMBEV4UC
	w/prglpRJlfQD3epg0dnC9EYA=; b=NPOeCBRaj2FqaeiCZ93DEQ22B/+z1TIdyp
	seDKePP5kfvjS9s7HPzlLp/6cgxclY9Z3O/WG7GHDMFj5zfXt+JyM3BfrximP8X1
	LlXnsiO3zoW4FUh8vkfBog3h1D/YnEOXMByDdh8K+Q+gUwm5V53mfXrW/nrujbsO
	YYUpXcnUOy4NIOYxHmqrurQ4NmqRJcn9Oggar8X1lZYThxEGYTh9peiWE80Km+Q7
	5XrjGpWvN7+6ppPvjvbEt9mb4Oy+wjrcumk+I0Zg/E8JEgi2+9xwaIWEZNKWILqS
	eLaopaSMGsM+eyDxS4XEqcvcaQrtHromKIbkV8uWsKWj7Wsfh2Mg==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4291qk3c78-19
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 15 Oct 2024 11:53:28 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server id
 15.2.1544.11; Tue, 15 Oct 2024 18:53:26 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Michael Chan <michael.chan@broadcom.com>,
        Edwin Peer
	<edwin.peer@broadcom.com>,
        Pavan Chebbi <pavan.chebbi@broadcom.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, Richard Cochran <richardcochran@gmail.com>,
        "Vadim
 Fedorenko" <vadfed@meta.com>
Subject: [PATCH net] bnxt_en: replace ptp_lock with irqsave variant
Date: Tue, 15 Oct 2024 11:53:10 -0700
Message-ID: <20241015185310.608328-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: hoOT7zR59ZJhhrQhtKDi4yGuqQAt2Hbm
X-Proofpoint-GUID: hoOT7zR59ZJhhrQhtKDi4yGuqQAt2Hbm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01

In netpoll configuration the completion processing can happen in hard
irq context which will break with spin_lock_bh() for fullfilling RX
timestamp in case of all packets timestamping. Replace it with
spin_lock_irqsave() variant.

Fixes: 7f5515d19cd7 ("bnxt_en: Get the RX packet timestamp")
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 22 +++---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 70 +++++++++++--------
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h | 12 ++--
 3 files changed, 63 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6e422e24750a..8d2fe091e03f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2254,10 +2254,11 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 
 			if (!bnxt_get_rx_ts_p5(bp, &ts, cmpl_ts)) {
 				struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
+				unsigned int flags;
 
-				spin_lock_bh(&ptp->ptp_lock);
+				spin_lock_irqsave(&ptp->ptp_lock, flags);
 				ns = timecounter_cyc2time(&ptp->tc, ts);
-				spin_unlock_bh(&ptp->ptp_lock);
+				spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 				memset(skb_hwtstamps(skb), 0,
 				       sizeof(*skb_hwtstamps(skb)));
 				skb_hwtstamps(skb)->hwtstamp = ns_to_ktime(ns);
@@ -2757,17 +2758,18 @@ static int bnxt_async_event_process(struct bnxt *bp,
 		case ASYNC_EVENT_CMPL_PHC_UPDATE_EVENT_DATA1_FLAGS_PHC_RTC_UPDATE:
 			if (BNXT_PTP_USE_RTC(bp)) {
 				struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
+				unsigned int flags;
 				u64 ns;
 
 				if (!ptp)
 					goto async_event_process_exit;
 
-				spin_lock_bh(&ptp->ptp_lock);
+				spin_lock_irqsave(&ptp->ptp_lock, flags);
 				bnxt_ptp_update_current_time(bp);
 				ns = (((u64)BNXT_EVENT_PHC_RTC_UPDATE(data1) <<
 				       BNXT_PHC_BITS) | ptp->current_time);
 				bnxt_ptp_rtc_timecounter_init(ptp, ns);
-				spin_unlock_bh(&ptp->ptp_lock);
+				spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 			}
 			break;
 		}
@@ -13494,9 +13496,11 @@ static void bnxt_force_fw_reset(struct bnxt *bp)
 		return;
 
 	if (ptp) {
-		spin_lock_bh(&ptp->ptp_lock);
+		unsigned int flags;
+
+		spin_lock_irqsave(&ptp->ptp_lock, flags);
 		set_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
-		spin_unlock_bh(&ptp->ptp_lock);
+		spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 	} else {
 		set_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
 	}
@@ -13561,9 +13565,11 @@ void bnxt_fw_reset(struct bnxt *bp)
 		int n = 0, tmo;
 
 		if (ptp) {
-			spin_lock_bh(&ptp->ptp_lock);
+			unsigned int flags;
+
+			spin_lock_irqsave(&ptp->ptp_lock, flags);
 			set_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
-			spin_unlock_bh(&ptp->ptp_lock);
+			spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 		} else {
 			set_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
 		}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index 37d42423459c..04f23c776793 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -62,13 +62,14 @@ static int bnxt_ptp_settime(struct ptp_clock_info *ptp_info,
 	struct bnxt_ptp_cfg *ptp = container_of(ptp_info, struct bnxt_ptp_cfg,
 						ptp_info);
 	u64 ns = timespec64_to_ns(ts);
+	unsigned int flags;
 
 	if (BNXT_PTP_USE_RTC(ptp->bp))
 		return bnxt_ptp_cfg_settime(ptp->bp, ns);
 
-	spin_lock_bh(&ptp->ptp_lock);
+	spin_lock_irqsave(&ptp->ptp_lock, flags);
 	timecounter_init(&ptp->tc, &ptp->cc, ns);
-	spin_unlock_bh(&ptp->ptp_lock);
+	spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 	return 0;
 }
 
@@ -100,13 +101,14 @@ static int bnxt_refclk_read(struct bnxt *bp, struct ptp_system_timestamp *sts,
 static void bnxt_ptp_get_current_time(struct bnxt *bp)
 {
 	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
+	unsigned int flags;
 
 	if (!ptp)
 		return;
-	spin_lock_bh(&ptp->ptp_lock);
+	spin_lock_irqsave(&ptp->ptp_lock, flags);
 	WRITE_ONCE(ptp->old_time, ptp->current_time);
 	bnxt_refclk_read(bp, NULL, &ptp->current_time);
-	spin_unlock_bh(&ptp->ptp_lock);
+	spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 }
 
 static int bnxt_hwrm_port_ts_query(struct bnxt *bp, u32 flags, u64 *ts,
@@ -149,17 +151,18 @@ static int bnxt_ptp_gettimex(struct ptp_clock_info *ptp_info,
 {
 	struct bnxt_ptp_cfg *ptp = container_of(ptp_info, struct bnxt_ptp_cfg,
 						ptp_info);
+	unsigned int flags;
 	u64 ns, cycles;
 	int rc;
 
-	spin_lock_bh(&ptp->ptp_lock);
+	spin_lock_irqsave(&ptp->ptp_lock, flags);
 	rc = bnxt_refclk_read(ptp->bp, sts, &cycles);
 	if (rc) {
-		spin_unlock_bh(&ptp->ptp_lock);
+		spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 		return rc;
 	}
 	ns = timecounter_cyc2time(&ptp->tc, cycles);
-	spin_unlock_bh(&ptp->ptp_lock);
+	spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 	*ts = ns_to_timespec64(ns);
 
 	return 0;
@@ -177,6 +180,7 @@ void bnxt_ptp_update_current_time(struct bnxt *bp)
 static int bnxt_ptp_adjphc(struct bnxt_ptp_cfg *ptp, s64 delta)
 {
 	struct hwrm_port_mac_cfg_input *req;
+	unsigned int flags;
 	int rc;
 
 	rc = hwrm_req_init(ptp->bp, req, HWRM_PORT_MAC_CFG);
@@ -190,9 +194,9 @@ static int bnxt_ptp_adjphc(struct bnxt_ptp_cfg *ptp, s64 delta)
 	if (rc) {
 		netdev_err(ptp->bp->dev, "ptp adjphc failed. rc = %x\n", rc);
 	} else {
-		spin_lock_bh(&ptp->ptp_lock);
+		spin_lock_irqsave(&ptp->ptp_lock, flags);
 		bnxt_ptp_update_current_time(ptp->bp);
-		spin_unlock_bh(&ptp->ptp_lock);
+		spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 	}
 
 	return rc;
@@ -202,13 +206,14 @@ static int bnxt_ptp_adjtime(struct ptp_clock_info *ptp_info, s64 delta)
 {
 	struct bnxt_ptp_cfg *ptp = container_of(ptp_info, struct bnxt_ptp_cfg,
 						ptp_info);
+	unsigned int flags;
 
 	if (BNXT_PTP_USE_RTC(ptp->bp))
 		return bnxt_ptp_adjphc(ptp, delta);
 
-	spin_lock_bh(&ptp->ptp_lock);
+	spin_lock_irqsave(&ptp->ptp_lock, flags);
 	timecounter_adjtime(&ptp->tc, delta);
-	spin_unlock_bh(&ptp->ptp_lock);
+	spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 	return 0;
 }
 
@@ -236,14 +241,15 @@ static int bnxt_ptp_adjfine(struct ptp_clock_info *ptp_info, long scaled_ppm)
 	struct bnxt_ptp_cfg *ptp = container_of(ptp_info, struct bnxt_ptp_cfg,
 						ptp_info);
 	struct bnxt *bp = ptp->bp;
+	unsigned int flags;
 
 	if (!BNXT_MH(bp))
 		return bnxt_ptp_adjfine_rtc(bp, scaled_ppm);
 
-	spin_lock_bh(&ptp->ptp_lock);
+	spin_lock_irqsave(&ptp->ptp_lock, flags);
 	timecounter_read(&ptp->tc);
 	ptp->cc.mult = adjust_by_scaled_ppm(ptp->cmult, scaled_ppm);
-	spin_unlock_bh(&ptp->ptp_lock);
+	spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 	return 0;
 }
 
@@ -251,12 +257,13 @@ void bnxt_ptp_pps_event(struct bnxt *bp, u32 data1, u32 data2)
 {
 	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
 	struct ptp_clock_event event;
+	unsigned int flags;
 	u64 ns, pps_ts;
 
 	pps_ts = EVENT_PPS_TS(data2, data1);
-	spin_lock_bh(&ptp->ptp_lock);
+	spin_lock_irqsave(&ptp->ptp_lock, flags);
 	ns = timecounter_cyc2time(&ptp->tc, pps_ts);
-	spin_unlock_bh(&ptp->ptp_lock);
+	spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 
 	switch (EVENT_DATA2_PPS_EVENT_TYPE(data2)) {
 	case ASYNC_EVENT_CMPL_PPS_TIMESTAMP_EVENT_DATA2_EVENT_TYPE_INTERNAL:
@@ -393,16 +400,17 @@ static int bnxt_get_target_cycles(struct bnxt_ptp_cfg *ptp, u64 target_ns,
 {
 	u64 cycles_now;
 	u64 nsec_now, nsec_delta;
+	unsigned int flags;
 	int rc;
 
-	spin_lock_bh(&ptp->ptp_lock);
+	spin_lock_irqsave(&ptp->ptp_lock, flags);
 	rc = bnxt_refclk_read(ptp->bp, NULL, &cycles_now);
 	if (rc) {
-		spin_unlock_bh(&ptp->ptp_lock);
+		spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 		return rc;
 	}
 	nsec_now = timecounter_cyc2time(&ptp->tc, cycles_now);
-	spin_unlock_bh(&ptp->ptp_lock);
+	spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 
 	nsec_delta = target_ns - nsec_now;
 	*cycles_delta = div64_u64(nsec_delta << ptp->cc.shift, ptp->cc.mult);
@@ -689,6 +697,7 @@ static int bnxt_stamp_tx_skb(struct bnxt *bp, int slot)
 	struct skb_shared_hwtstamps timestamp;
 	struct bnxt_ptp_tx_req *txts_req;
 	unsigned long now = jiffies;
+	unsigned int flags;
 	u64 ts = 0, ns = 0;
 	u32 tmo = 0;
 	int rc;
@@ -702,9 +711,9 @@ static int bnxt_stamp_tx_skb(struct bnxt *bp, int slot)
 				     tmo, slot);
 	if (!rc) {
 		memset(&timestamp, 0, sizeof(timestamp));
-		spin_lock_bh(&ptp->ptp_lock);
+		spin_lock_irqsave(&ptp->ptp_lock, flags);
 		ns = timecounter_cyc2time(&ptp->tc, ts);
-		spin_unlock_bh(&ptp->ptp_lock);
+		spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 		timestamp.hwtstamp = ns_to_ktime(ns);
 		skb_tstamp_tx(txts_req->tx_skb, &timestamp);
 		ptp->stats.ts_pkts++;
@@ -730,6 +739,7 @@ static long bnxt_ptp_ts_aux_work(struct ptp_clock_info *ptp_info)
 	unsigned long now = jiffies;
 	struct bnxt *bp = ptp->bp;
 	u16 cons = ptp->txts_cons;
+	unsigned int flags;
 	u32 num_requests;
 	int rc = 0;
 
@@ -757,9 +767,9 @@ static long bnxt_ptp_ts_aux_work(struct ptp_clock_info *ptp_info)
 	bnxt_ptp_get_current_time(bp);
 	ptp->next_period = now + HZ;
 	if (time_after_eq(now, ptp->next_overflow_check)) {
-		spin_lock_bh(&ptp->ptp_lock);
+		spin_lock_irqsave(&ptp->ptp_lock, flags);
 		timecounter_read(&ptp->tc);
-		spin_unlock_bh(&ptp->ptp_lock);
+		spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 		ptp->next_overflow_check = now + BNXT_PHC_OVERFLOW_PERIOD;
 	}
 	if (rc == -EAGAIN)
@@ -819,6 +829,7 @@ void bnxt_tx_ts_cmp(struct bnxt *bp, struct bnxt_napi *bnapi,
 	u32 opaque = tscmp->tx_ts_cmp_opaque;
 	struct bnxt_tx_ring_info *txr;
 	struct bnxt_sw_tx_bd *tx_buf;
+	unsigned int flags;
 	u64 ts, ns;
 	u16 cons;
 
@@ -833,9 +844,9 @@ void bnxt_tx_ts_cmp(struct bnxt *bp, struct bnxt_napi *bnapi,
 				   le32_to_cpu(tscmp->tx_ts_cmp_flags_type),
 				   le32_to_cpu(tscmp->tx_ts_cmp_errors_v));
 		} else {
-			spin_lock_bh(&ptp->ptp_lock);
+			spin_lock_irqsave(&ptp->ptp_lock, flags);
 			ns = timecounter_cyc2time(&ptp->tc, ts);
-			spin_unlock_bh(&ptp->ptp_lock);
+			spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 			timestamp.hwtstamp = ns_to_ktime(ns);
 			skb_tstamp_tx(tx_buf->skb, &timestamp);
 		}
@@ -975,6 +986,7 @@ void bnxt_ptp_rtc_timecounter_init(struct bnxt_ptp_cfg *ptp, u64 ns)
 int bnxt_ptp_init_rtc(struct bnxt *bp, bool phc_cfg)
 {
 	struct timespec64 tsp;
+	unsigned int flags;
 	u64 ns;
 	int rc;
 
@@ -993,9 +1005,9 @@ int bnxt_ptp_init_rtc(struct bnxt *bp, bool phc_cfg)
 		if (rc)
 			return rc;
 	}
-	spin_lock_bh(&bp->ptp_cfg->ptp_lock);
+	spin_lock_irqsave(&bp->ptp_cfg->ptp_lock, flags);
 	bnxt_ptp_rtc_timecounter_init(bp->ptp_cfg, ns);
-	spin_unlock_bh(&bp->ptp_cfg->ptp_lock);
+	spin_unlock_irqrestore(&bp->ptp_cfg->ptp_lock, flags);
 
 	return 0;
 }
@@ -1063,10 +1075,12 @@ int bnxt_ptp_init(struct bnxt *bp, bool phc_cfg)
 	atomic64_set(&ptp->stats.ts_err, 0);
 
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
-		spin_lock_bh(&ptp->ptp_lock);
+		unsigned int flags;
+
+		spin_lock_irqsave(&ptp->ptp_lock, flags);
 		bnxt_refclk_read(bp, NULL, &ptp->current_time);
 		WRITE_ONCE(ptp->old_time, ptp->current_time);
-		spin_unlock_bh(&ptp->ptp_lock);
+		spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 		ptp_schedule_worker(ptp->ptp_clock, 0);
 	}
 	ptp->txts_tmo = BNXT_PTP_DFLT_TX_TMO;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
index a9a2f9a18c9c..1120c650edcf 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
@@ -146,11 +146,13 @@ struct bnxt_ptp_cfg {
 };
 
 #if BITS_PER_LONG == 32
-#define BNXT_READ_TIME64(ptp, dst, src)		\
-do {						\
-	spin_lock_bh(&(ptp)->ptp_lock);		\
-	(dst) = (src);				\
-	spin_unlock_bh(&(ptp)->ptp_lock);	\
+#define BNXT_READ_TIME64(ptp, dst, src)				\
+do {								\
+	unsigned int flags;					\
+								\
+	spin_lock_irqsave(&(ptp)->ptp_lock, flags);		\
+	(dst) = (src);						\
+	spin_unlock_irqrestore(&(ptp)->ptp_lock, flags);	\
 } while (0)
 #else
 #define BNXT_READ_TIME64(ptp, dst, src)		\
-- 
2.43.5


