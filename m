Return-Path: <netdev+bounces-136283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1A39A12F3
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 21:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91DC428705C
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 19:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A22210C38;
	Wed, 16 Oct 2024 19:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="D6Js3+/q"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23EF18C332
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 19:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729108386; cv=none; b=ikgz9+uFpFWAnWk8TMFQ59pYQtOavHAvZ0tIjwgUduHxpNvLjwvpbBuCGT7Yzcr56hVoqcY6MnnGNqMzUsAFOSZ8C8/j6hi9LnAr3JLlQ3VMnQiE7mBrJaT3DzY99DQGMDjfduHQdmxKr0wPKxhjaplwe9jqqJ/LRNaWSX8nOZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729108386; c=relaxed/simple;
	bh=PVD3vQBvqK3yLV3/HxgWt7ydAM539Sp7SNNNn+o9hDA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BM4hxPankA1QMXlD5N5Q/ukSfZLOMF6WwuFHADtg3pp5DI+Bt01DLRZqLP6gWy4rJ8qX85xOBdvSMNqNKw3YwBYYIA6yeENJqMpuhWbdHsPOpsYvpPcbT/tzAoFMpdrLr6rxI0AKtZGL23U0Eok9dLe9zHr35Mag77zokFBIusw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=D6Js3+/q; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 49GJExwf001898;
	Wed, 16 Oct 2024 12:52:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=xhjzJOuUjX/89ayE12
	VVoPfaePWkJjHVwYk1b1mwHvo=; b=D6Js3+/q/MML7akXOQm1KMKcCkJz/hEMXc
	XTB7smSa4tijRAbNJCp81Q2uIaHUkbCpYMqsSAUbUKSZkQ45lJm+SnWHGxQSjL+k
	5zPmR0M6oI9toNEmDMdHo8qQbHgfFzP0TmxY7pqhMuWOLqM2cRRCvK6g+OB+nb8K
	XjWdDqbuitiCWKS/6pTpAwL8w84obPQkaSm+KyFal2SKh9DU2TtthRHJ8/0eMdtB
	jo9dQW6SzZN8Cen0Y6UpvHSfbGckDnjmz8LxSddqdk7BYYaP3HCdmGuVqhBThBYn
	Ohl/Oa2pEGZoepvuhFkrWWzvAqdDuS2KV8k5TPKFBrnDzoxc2KaQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 42a8wm4gd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 16 Oct 2024 12:52:47 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server id
 15.2.1544.11; Wed, 16 Oct 2024 19:52:44 +0000
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
Subject: [PATCH net v2] bnxt_en: replace ptp_lock with irqsave variant
Date: Wed, 16 Oct 2024 12:52:34 -0700
Message-ID: <20241016195234.2622004-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Fo_Bz-qd4t32taxx8rz6tkP3GOVT61aP
X-Proofpoint-ORIG-GUID: Fo_Bz-qd4t32taxx8rz6tkP3GOVT61aP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

In netpoll configuration the completion processing can happen in hard
irq context which will break with spin_lock_bh() for fullfilling RX
timestamp in case of all packets timestamping. Replace it with
spin_lock_irqsave() variant.

Fixes: 7f5515d19cd7 ("bnxt_en: Get the RX packet timestamp")
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
v1 -> v2:
- use insigned long for flags
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 22 +++---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 70 +++++++++++--------
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h | 12 ++--
 3 files changed, 63 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6e422e24750a..99d025b69079 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2254,10 +2254,11 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 
 			if (!bnxt_get_rx_ts_p5(bp, &ts, cmpl_ts)) {
 				struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
+				unsigned long flags;
 
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
+				unsigned long flags;
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
+		unsigned long flags;
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
+			unsigned long flags;
+
+			spin_lock_irqsave(&ptp->ptp_lock, flags);
 			set_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
-			spin_unlock_bh(&ptp->ptp_lock);
+			spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 		} else {
 			set_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
 		}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index 37d42423459c..fa514be87650 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -62,13 +62,14 @@ static int bnxt_ptp_settime(struct ptp_clock_info *ptp_info,
 	struct bnxt_ptp_cfg *ptp = container_of(ptp_info, struct bnxt_ptp_cfg,
 						ptp_info);
 	u64 ns = timespec64_to_ns(ts);
+	unsigned long flags;
 
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
+	unsigned long flags;
 
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
+	unsigned long flags;
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
+	unsigned long flags;
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
+	unsigned long flags;
 
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
+	unsigned long flags;
 
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
+	unsigned long flags;
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
+	unsigned long flags;
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
+	unsigned long flags;
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
+	unsigned long flags;
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
+	unsigned long flags;
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
+	unsigned long flags;
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
+		unsigned long flags;
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
index a9a2f9a18c9c..f322466ecad3 100644
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
+	unsigned long flags;					\
+								\
+	spin_lock_irqsave(&(ptp)->ptp_lock, flags);		\
+	(dst) = (src);						\
+	spin_unlock_irqrestore(&(ptp)->ptp_lock, flags);	\
 } while (0)
 #else
 #define BNXT_READ_TIME64(ptp, dst, src)		\
-- 
2.43.5


