Return-Path: <netdev+bounces-139624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FFC9B39C5
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 19:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B82A28591A
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 18:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4F61DFE1B;
	Mon, 28 Oct 2024 18:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="MBzusP3X"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18811DF98C
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 18:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730141877; cv=none; b=dtB6mH2yiTeRBzK92x/dUAXS66JnQmUHbxVqrj7sb7yBA+uiFYTwSoiMdyYMUN5WkPDirRTCdthQnkMPQ6nT+IBf4h6667NjeEi19hEQv6lWgtrXKW34hpX3ULL55OkkCw5nRsqhDMVBPCdd660q1zRYlxtY1HCiQ+8vZfg0aRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730141877; c=relaxed/simple;
	bh=cE6CZjXkKR+uoX7Fp4/TBvNqs0vH81VgT395I3Bupko=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j6SpZBEnmzfHrFD8m+02jaUh98p5kN6eCFl4q7WD682g/dl7QowqQHkpuPdRj+rbzdIwpo8hZCrXZCPvV+okMcuYpO2d5MmfvqrV2GzwJABZAomW1glh1WRxyLi58v1g7hoo/H9M5FqCvxatfIopaUxgvTqGFJi6qqi1+nCWGss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=MBzusP3X; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SIlvxg032701;
	Mon, 28 Oct 2024 11:57:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=oQOanxiPiC8gconlQJCrLEnb6x8oc6aghxCI2EwG89c=; b=MBzusP3XJdly
	TPOsvhzXUulcsq8USgJ7nac47GTVv6y/s500d7YZP3WjoRoapjPxquM2EVz7BHUo
	XbyAFttte2hD6Dmg/AXqg/+JflCNtKW7utjyJMNijrVkQF3m0OdEwcLeVuYjMlMa
	Sc6BAvOkmcS4S+stkeS6XoDAJ22KcG3aEGoUrNOoV6fNLRECrsk214cNcuF9jY7T
	mSYumfdZtChodxzY+tB+ce5526f0Mwgh/lGkthWZOynh8i5KrBbk3jrukiZvsWdf
	W4gv0vRFEynP8YrNedUlebCRW77wkJA7AeLIExlHkw46DlNCrpo49Q0N2c39+APV
	ZtUXlIarWw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42jbbcjnk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 28 Oct 2024 11:57:35 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server id
 15.2.1544.11; Mon, 28 Oct 2024 18:57:33 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Michael Chan
	<michael.chan@broadcom.com>,
        Pavan Chebbi <pavan.chebbi@broadcom.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        "Richard
 Cochran" <richardcochran@gmail.com>,
        Vadim Fedorenko <vadfed@meta.com>
Subject: [PATCH net-next v3 2/2] bnxt_en: replace PTP spinlock with seqlock
Date: Mon, 28 Oct 2024 11:57:23 -0700
Message-ID: <20241028185723.4065146-2-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241028185723.4065146-1-vadfed@meta.com>
References: <20241028185723.4065146-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: uJwzwcInAXfSGrq0qs_SVrYYkKMCD9ce
X-Proofpoint-ORIG-GUID: uJwzwcInAXfSGrq0qs_SVrYYkKMCD9ce
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01

We can see high contention on ptp_lock while doing RX timestamping
on high packet rates over several queues. Spinlock is not effecient
to protect timecounter for RX timestamps when reads are the most
usual operations and writes are only occasional. It's better to use
seqlock in such cases.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
v3:
- remove unused variable
v2:
- use read_excl lock to serialize reg access with FW reset
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 19 +++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 73 ++++++-------------
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h | 14 +++-
 3 files changed, 46 insertions(+), 60 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6dd6541d8619..a7eabef6e7ea 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2254,11 +2254,8 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 
 			if (!bnxt_get_rx_ts_p5(bp, &ts, cmpl_ts)) {
 				struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
-				unsigned long flags;
 
-				spin_lock_irqsave(&ptp->ptp_lock, flags);
-				ns = timecounter_cyc2time(&ptp->tc, ts);
-				spin_unlock_irqrestore(&ptp->ptp_lock, flags);
+				ns = bnxt_timecounter_cyc2time(ptp, ts);
 				memset(skb_hwtstamps(skb), 0,
 				       sizeof(*skb_hwtstamps(skb)));
 				skb_hwtstamps(skb)->hwtstamp = ns_to_ktime(ns);
@@ -2764,12 +2761,12 @@ static int bnxt_async_event_process(struct bnxt *bp,
 				if (!ptp)
 					goto async_event_process_exit;
 
-				spin_lock_irqsave(&ptp->ptp_lock, flags);
 				bnxt_ptp_update_current_time(bp);
 				ns = (((u64)BNXT_EVENT_PHC_RTC_UPDATE(data1) <<
 				       BNXT_PHC_BITS) | ptp->current_time);
+				write_seqlock_irqsave(&ptp->ptp_lock, flags);
 				bnxt_ptp_rtc_timecounter_init(ptp, ns);
-				spin_unlock_irqrestore(&ptp->ptp_lock, flags);
+				write_sequnlock_irqrestore(&ptp->ptp_lock, flags);
 			}
 			break;
 		}
@@ -13496,12 +13493,13 @@ static void bnxt_force_fw_reset(struct bnxt *bp)
 	    test_bit(BNXT_STATE_IN_FW_RESET, &bp->state))
 		return;
 
+	/* we have to serialize with bnxt_refclk_read()*/
 	if (ptp) {
 		unsigned long flags;
 
-		spin_lock_irqsave(&ptp->ptp_lock, flags);
+		write_seqlock_irqsave(&ptp->ptp_lock, flags);
 		set_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
-		spin_unlock_irqrestore(&ptp->ptp_lock, flags);
+		write_sequnlock_irqrestore(&ptp->ptp_lock, flags);
 	} else {
 		set_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
 	}
@@ -13565,12 +13563,13 @@ void bnxt_fw_reset(struct bnxt *bp)
 		struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
 		int n = 0, tmo;
 
+		/* we have to serialize with bnxt_refclk_read()*/
 		if (ptp) {
 			unsigned long flags;
 
-			spin_lock_irqsave(&ptp->ptp_lock, flags);
+			write_seqlock_irqsave(&ptp->ptp_lock, flags);
 			set_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
-			spin_unlock_irqrestore(&ptp->ptp_lock, flags);
+			write_sequnlock_irqrestore(&ptp->ptp_lock, flags);
 		} else {
 			set_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
 		}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index 820c7e83e586..5ab52f7a282d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -67,19 +67,21 @@ static int bnxt_ptp_settime(struct ptp_clock_info *ptp_info,
 	if (BNXT_PTP_USE_RTC(ptp->bp))
 		return bnxt_ptp_cfg_settime(ptp->bp, ns);
 
-	spin_lock_irqsave(&ptp->ptp_lock, flags);
+	write_seqlock_irqsave(&ptp->ptp_lock, flags);
 	timecounter_init(&ptp->tc, &ptp->cc, ns);
-	spin_unlock_irqrestore(&ptp->ptp_lock, flags);
+	write_sequnlock_irqrestore(&ptp->ptp_lock, flags);
 	return 0;
 }
 
-/* Caller holds ptp_lock */
 static int bnxt_refclk_read(struct bnxt *bp, struct ptp_system_timestamp *sts,
 			    u64 *ns)
 {
 	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
 	u32 high_before, high_now, low;
+	unsigned long flags;
 
+	/* We have to serialize reg access and FW reset */
+	read_seqlock_excl_irqsave(&ptp->ptp_lock, flags);
 	if (test_bit(BNXT_STATE_IN_FW_RESET, &bp->state))
 		return -EIO;
 
@@ -93,6 +95,7 @@ static int bnxt_refclk_read(struct bnxt *bp, struct ptp_system_timestamp *sts,
 		low = readl(bp->bar0 + ptp->refclk_mapped_regs[0]);
 		ptp_read_system_postts(sts);
 	}
+	read_sequnlock_excl_irqrestore(&ptp->ptp_lock, flags);
 	*ns = ((u64)high_now << 32) | low;
 
 	return 0;
@@ -101,14 +104,11 @@ static int bnxt_refclk_read(struct bnxt *bp, struct ptp_system_timestamp *sts,
 static void bnxt_ptp_get_current_time(struct bnxt *bp)
 {
 	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
-	unsigned long flags;
 
 	if (!ptp)
 		return;
-	spin_lock_irqsave(&ptp->ptp_lock, flags);
 	WRITE_ONCE(ptp->old_time, (u32)(ptp->current_time >> BNXT_HI_TIMER_SHIFT));
 	bnxt_refclk_read(bp, NULL, &ptp->current_time);
-	spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 }
 
 static int bnxt_hwrm_port_ts_query(struct bnxt *bp, u32 flags, u64 *ts,
@@ -151,24 +151,19 @@ static int bnxt_ptp_gettimex(struct ptp_clock_info *ptp_info,
 {
 	struct bnxt_ptp_cfg *ptp = container_of(ptp_info, struct bnxt_ptp_cfg,
 						ptp_info);
-	unsigned long flags;
 	u64 ns, cycles;
 	int rc;
 
-	spin_lock_irqsave(&ptp->ptp_lock, flags);
 	rc = bnxt_refclk_read(ptp->bp, sts, &cycles);
-	if (rc) {
-		spin_unlock_irqrestore(&ptp->ptp_lock, flags);
+	if (rc)
 		return rc;
-	}
-	ns = timecounter_cyc2time(&ptp->tc, cycles);
-	spin_unlock_irqrestore(&ptp->ptp_lock, flags);
+
+	ns = bnxt_timecounter_cyc2time(ptp, cycles);
 	*ts = ns_to_timespec64(ns);
 
 	return 0;
 }
 
-/* Caller holds ptp_lock */
 void bnxt_ptp_update_current_time(struct bnxt *bp)
 {
 	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
@@ -180,7 +175,6 @@ void bnxt_ptp_update_current_time(struct bnxt *bp)
 static int bnxt_ptp_adjphc(struct bnxt_ptp_cfg *ptp, s64 delta)
 {
 	struct hwrm_port_mac_cfg_input *req;
-	unsigned long flags;
 	int rc;
 
 	rc = hwrm_req_init(ptp->bp, req, HWRM_PORT_MAC_CFG);
@@ -194,9 +188,7 @@ static int bnxt_ptp_adjphc(struct bnxt_ptp_cfg *ptp, s64 delta)
 	if (rc) {
 		netdev_err(ptp->bp->dev, "ptp adjphc failed. rc = %x\n", rc);
 	} else {
-		spin_lock_irqsave(&ptp->ptp_lock, flags);
 		bnxt_ptp_update_current_time(ptp->bp);
-		spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 	}
 
 	return rc;
@@ -211,9 +203,9 @@ static int bnxt_ptp_adjtime(struct ptp_clock_info *ptp_info, s64 delta)
 	if (BNXT_PTP_USE_RTC(ptp->bp))
 		return bnxt_ptp_adjphc(ptp, delta);
 
-	spin_lock_irqsave(&ptp->ptp_lock, flags);
+	write_seqlock_irqsave(&ptp->ptp_lock, flags);
 	timecounter_adjtime(&ptp->tc, delta);
-	spin_unlock_irqrestore(&ptp->ptp_lock, flags);
+	write_sequnlock_irqrestore(&ptp->ptp_lock, flags);
 	return 0;
 }
 
@@ -246,10 +238,10 @@ static int bnxt_ptp_adjfine(struct ptp_clock_info *ptp_info, long scaled_ppm)
 	if (!BNXT_MH(bp))
 		return bnxt_ptp_adjfine_rtc(bp, scaled_ppm);
 
-	spin_lock_irqsave(&ptp->ptp_lock, flags);
+	write_seqlock_irqsave(&ptp->ptp_lock, flags);
 	timecounter_read(&ptp->tc);
 	ptp->cc.mult = adjust_by_scaled_ppm(ptp->cmult, scaled_ppm);
-	spin_unlock_irqrestore(&ptp->ptp_lock, flags);
+	write_sequnlock_irqrestore(&ptp->ptp_lock, flags);
 	return 0;
 }
 
@@ -257,13 +249,10 @@ void bnxt_ptp_pps_event(struct bnxt *bp, u32 data1, u32 data2)
 {
 	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
 	struct ptp_clock_event event;
-	unsigned long flags;
 	u64 ns, pps_ts;
 
 	pps_ts = EVENT_PPS_TS(data2, data1);
-	spin_lock_irqsave(&ptp->ptp_lock, flags);
-	ns = timecounter_cyc2time(&ptp->tc, pps_ts);
-	spin_unlock_irqrestore(&ptp->ptp_lock, flags);
+	ns = bnxt_timecounter_cyc2time(ptp, pps_ts);
 
 	switch (EVENT_DATA2_PPS_EVENT_TYPE(data2)) {
 	case ASYNC_EVENT_CMPL_PPS_TIMESTAMP_EVENT_DATA2_EVENT_TYPE_INTERNAL:
@@ -400,17 +389,13 @@ static int bnxt_get_target_cycles(struct bnxt_ptp_cfg *ptp, u64 target_ns,
 {
 	u64 cycles_now;
 	u64 nsec_now, nsec_delta;
-	unsigned long flags;
 	int rc;
 
-	spin_lock_irqsave(&ptp->ptp_lock, flags);
 	rc = bnxt_refclk_read(ptp->bp, NULL, &cycles_now);
-	if (rc) {
-		spin_unlock_irqrestore(&ptp->ptp_lock, flags);
+	if (rc)
 		return rc;
-	}
-	nsec_now = timecounter_cyc2time(&ptp->tc, cycles_now);
-	spin_unlock_irqrestore(&ptp->ptp_lock, flags);
+
+	nsec_now = bnxt_timecounter_cyc2time(ptp, cycles_now);
 
 	nsec_delta = target_ns - nsec_now;
 	*cycles_delta = div64_u64(nsec_delta << ptp->cc.shift, ptp->cc.mult);
@@ -697,7 +682,6 @@ static int bnxt_stamp_tx_skb(struct bnxt *bp, int slot)
 	struct skb_shared_hwtstamps timestamp;
 	struct bnxt_ptp_tx_req *txts_req;
 	unsigned long now = jiffies;
-	unsigned long flags;
 	u64 ts = 0, ns = 0;
 	u32 tmo = 0;
 	int rc;
@@ -711,9 +695,7 @@ static int bnxt_stamp_tx_skb(struct bnxt *bp, int slot)
 				     tmo, slot);
 	if (!rc) {
 		memset(&timestamp, 0, sizeof(timestamp));
-		spin_lock_irqsave(&ptp->ptp_lock, flags);
-		ns = timecounter_cyc2time(&ptp->tc, ts);
-		spin_unlock_irqrestore(&ptp->ptp_lock, flags);
+		ns = bnxt_timecounter_cyc2time(ptp, ts);
 		timestamp.hwtstamp = ns_to_ktime(ns);
 		skb_tstamp_tx(txts_req->tx_skb, &timestamp);
 		ptp->stats.ts_pkts++;
@@ -767,9 +749,9 @@ static long bnxt_ptp_ts_aux_work(struct ptp_clock_info *ptp_info)
 	bnxt_ptp_get_current_time(bp);
 	ptp->next_period = now + HZ;
 	if (time_after_eq(now, ptp->next_overflow_check)) {
-		spin_lock_irqsave(&ptp->ptp_lock, flags);
+		write_seqlock_irqsave(&ptp->ptp_lock, flags);
 		timecounter_read(&ptp->tc);
-		spin_unlock_irqrestore(&ptp->ptp_lock, flags);
+		write_sequnlock_irqrestore(&ptp->ptp_lock, flags);
 		ptp->next_overflow_check = now + BNXT_PHC_OVERFLOW_PERIOD;
 	}
 	if (rc == -EAGAIN)
@@ -829,7 +811,6 @@ void bnxt_tx_ts_cmp(struct bnxt *bp, struct bnxt_napi *bnapi,
 	u32 opaque = tscmp->tx_ts_cmp_opaque;
 	struct bnxt_tx_ring_info *txr;
 	struct bnxt_sw_tx_bd *tx_buf;
-	unsigned long flags;
 	u64 ts, ns;
 	u16 cons;
 
@@ -844,9 +825,7 @@ void bnxt_tx_ts_cmp(struct bnxt *bp, struct bnxt_napi *bnapi,
 				   le32_to_cpu(tscmp->tx_ts_cmp_flags_type),
 				   le32_to_cpu(tscmp->tx_ts_cmp_errors_v));
 		} else {
-			spin_lock_irqsave(&ptp->ptp_lock, flags);
-			ns = timecounter_cyc2time(&ptp->tc, ts);
-			spin_unlock_irqrestore(&ptp->ptp_lock, flags);
+			ns = bnxt_timecounter_cyc2time(ptp, ts);
 			timestamp.hwtstamp = ns_to_ktime(ns);
 			skb_tstamp_tx(tx_buf->skb, &timestamp);
 		}
@@ -1005,9 +984,9 @@ int bnxt_ptp_init_rtc(struct bnxt *bp, bool phc_cfg)
 		if (rc)
 			return rc;
 	}
-	spin_lock_irqsave(&bp->ptp_cfg->ptp_lock, flags);
+	write_seqlock_irqsave(&bp->ptp_cfg->ptp_lock, flags);
 	bnxt_ptp_rtc_timecounter_init(bp->ptp_cfg, ns);
-	spin_unlock_irqrestore(&bp->ptp_cfg->ptp_lock, flags);
+	write_sequnlock_irqrestore(&bp->ptp_cfg->ptp_lock, flags);
 
 	return 0;
 }
@@ -1042,7 +1021,7 @@ int bnxt_ptp_init(struct bnxt *bp, bool phc_cfg)
 	bnxt_ptp_free(bp);
 
 	WRITE_ONCE(ptp->tx_avail, BNXT_MAX_TX_TS);
-	spin_lock_init(&ptp->ptp_lock);
+	seqlock_init(&ptp->ptp_lock);
 	spin_lock_init(&ptp->ptp_tx_lock);
 
 	if (BNXT_PTP_USE_RTC(bp)) {
@@ -1075,12 +1054,8 @@ int bnxt_ptp_init(struct bnxt *bp, bool phc_cfg)
 	atomic64_set(&ptp->stats.ts_err, 0);
 
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&ptp->ptp_lock, flags);
 		bnxt_refclk_read(bp, NULL, &ptp->current_time);
 		WRITE_ONCE(ptp->old_time, (u32)(ptp->current_time >> BNXT_HI_TIMER_SHIFT));
-		spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 		ptp_schedule_worker(ptp->ptp_clock, 0);
 	}
 	ptp->txts_tmo = BNXT_PTP_DFLT_TX_TMO;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
index 3ac5cbc1c5c4..4df4c2f373e0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
@@ -103,7 +103,7 @@ struct bnxt_ptp_cfg {
 	struct timecounter	tc;
 	struct bnxt_pps		pps_info;
 	/* serialize timecounter access */
-	spinlock_t		ptp_lock;
+	seqlock_t		ptp_lock;
 	/* serialize ts tx request queuing */
 	spinlock_t		ptp_tx_lock;
 	u64			current_time;
@@ -170,4 +170,16 @@ void bnxt_ptp_rtc_timecounter_init(struct bnxt_ptp_cfg *ptp, u64 ns);
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


