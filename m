Return-Path: <netdev+bounces-140118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C8B9B547B
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2621F21EC0
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B442076B3;
	Tue, 29 Oct 2024 20:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="NDTXWLzt"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2602B1DC06B
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 20:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730235322; cv=none; b=GRGjx7HIsYa2PL5rp1Vfzh+zjH7oJHpWPI64Nk2Gd6tRamH8Z1UAMoD5cUhz4M1hO1NThea8dM2sqoReRTNLE2skJa5VTXWNnITaIOtdY9d7C0q9mSAiJoNBMU475JfvydLmzjM8gqj2LphlPuWVU402qFIoe5vXKsNS08LCdbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730235322; c=relaxed/simple;
	bh=7hbLSMwT5GYPfmo28vSt1HrCLcIu7Id0Wqh+BjQV810=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AdlvzdRAPTlwBYNac0R2TPQFvPTOJgplW54T1WSgUKQEh1aFyk63Z3upfVf55Hu9vvsytkreBWYWBk6UblcAdR8PsA2l2HLxFxc93GKxyujp5LRdM9T2DxUC0SHgCr1wdu1bdCWKQuoDq7Y7jRQb4Nw6IwT65I8nC9AZwHK3Wsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=NDTXWLzt; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TIfFsj022703;
	Tue, 29 Oct 2024 13:55:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=W8lqgIWDleDMEZ/T6/
	sfDi03QonPQ4gvbCLT4XJ4N2Q=; b=NDTXWLzt99HIDnJlqJ4JDg74vapTdIYT3y
	wSqV5QrIB8dFdgqEOdMOWC3lgG2xLknDEEKQUb9wC0izi5uYhqQFPo9FI+wIrNSU
	atOuB9FsTqy0ZYMEBqoLV2Hy0YFkhVvwEEVjVpKGlqeLWaR4A97QGz+HKm4lraLx
	3B6zCon+0yfd/8vt2+wgMoSW52p3SBasIZ6qO9MueXONphLCKGZZwgS+Fz3kk7jF
	Fxq5GHk8oj3YdqxEoRrsgyB225tuiYmKsLvH8lRmt25DgUfw+SwoyseKKHjeIOcw
	LNhT//XSe6KyMUuBK2VHumWo3nFwoOJv+mO2OTMwwzde1/Vrud2Q==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42jx3pmmsj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 29 Oct 2024 13:55:00 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server id
 15.2.1544.11; Tue, 29 Oct 2024 20:54:59 +0000
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
Subject: [PATCH net-next v4 1/2] bnxt_en: cache only 24 bits of hw counter
Date: Tue, 29 Oct 2024 13:54:52 -0700
Message-ID: <20241029205453.2290688-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: sQnqKTSjK_Dzp3LpcZwugmVshMTAsL97
X-Proofpoint-ORIG-GUID: sQnqKTSjK_Dzp3LpcZwugmVshMTAsL97
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

This hardware can provide only 48 bits of cycle counter. We can leave
only 24 bits in the cache to extend RX timestamps from 32 bits to 48
bits. Lower 8 bits of the cached value will be used to check for
roll-over while extending to full 48 bits.
This change makes cache writes atomic even on 32 bit platforms and we
can simply use READ_ONCE()/WRITE_ONCE() pair and remove spinlock. The
configuration structure will be also reduced by 4 bytes.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c |  8 ++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h | 18 +++---------------
 2 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index fa514be87650..820c7e83e586 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -106,7 +106,7 @@ static void bnxt_ptp_get_current_time(struct bnxt *bp)
 	if (!ptp)
 		return;
 	spin_lock_irqsave(&ptp->ptp_lock, flags);
-	WRITE_ONCE(ptp->old_time, ptp->current_time);
+	WRITE_ONCE(ptp->old_time, (u32)(ptp->current_time >> BNXT_HI_TIMER_SHIFT));
 	bnxt_refclk_read(bp, NULL, &ptp->current_time);
 	spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 }
@@ -174,7 +174,7 @@ void bnxt_ptp_update_current_time(struct bnxt *bp)
 	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
 
 	bnxt_refclk_read(ptp->bp, NULL, &ptp->current_time);
-	WRITE_ONCE(ptp->old_time, ptp->current_time);
+	WRITE_ONCE(ptp->old_time, (u32)(ptp->current_time >> BNXT_HI_TIMER_SHIFT));
 }
 
 static int bnxt_ptp_adjphc(struct bnxt_ptp_cfg *ptp, s64 delta)
@@ -813,7 +813,7 @@ int bnxt_get_rx_ts_p5(struct bnxt *bp, u64 *ts, u32 pkt_ts)
 	if (!ptp)
 		return -ENODEV;
 
-	BNXT_READ_TIME64(ptp, time, ptp->old_time);
+	time = (u64)(READ_ONCE(ptp->old_time) << BNXT_HI_TIMER_SHIFT);
 	*ts = (time & BNXT_HI_TIMER_MASK) | pkt_ts;
 	if (pkt_ts < (time & BNXT_LO_TIMER_MASK))
 		*ts += BNXT_LO_TIMER_MASK + 1;
@@ -1079,7 +1079,7 @@ int bnxt_ptp_init(struct bnxt *bp, bool phc_cfg)
 
 		spin_lock_irqsave(&ptp->ptp_lock, flags);
 		bnxt_refclk_read(bp, NULL, &ptp->current_time);
-		WRITE_ONCE(ptp->old_time, ptp->current_time);
+		WRITE_ONCE(ptp->old_time, (u32)(ptp->current_time >> BNXT_HI_TIMER_SHIFT));
 		spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 		ptp_schedule_worker(ptp->ptp_clock, 0);
 	}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
index f322466ecad3..3ac5cbc1c5c4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
@@ -21,6 +21,7 @@
 #define BNXT_DEVCLK_FREQ	1000000
 #define BNXT_LO_TIMER_MASK	0x0000ffffffffUL
 #define BNXT_HI_TIMER_MASK	0xffff00000000UL
+#define BNXT_HI_TIMER_SHIFT	24
 
 #define BNXT_PTP_DFLT_TX_TMO	1000 /* ms */
 #define BNXT_PTP_QTS_TIMEOUT	1000
@@ -106,10 +107,11 @@ struct bnxt_ptp_cfg {
 	/* serialize ts tx request queuing */
 	spinlock_t		ptp_tx_lock;
 	u64			current_time;
-	u64			old_time;
 	unsigned long		next_period;
 	unsigned long		next_overflow_check;
 	u32			cmult;
+	/* cache of upper 24 bits of cyclecoutner. 8 bits are used to check for roll-over */
+	u32			old_time;
 	/* a 23b shift cyclecounter will overflow in ~36 mins.  Check overflow every 18 mins. */
 	#define BNXT_PHC_OVERFLOW_PERIOD	(18 * 60 * HZ)
 
@@ -145,20 +147,6 @@ struct bnxt_ptp_cfg {
 	struct bnxt_ptp_stats	stats;
 };
 
-#if BITS_PER_LONG == 32
-#define BNXT_READ_TIME64(ptp, dst, src)				\
-do {								\
-	unsigned long flags;					\
-								\
-	spin_lock_irqsave(&(ptp)->ptp_lock, flags);		\
-	(dst) = (src);						\
-	spin_unlock_irqrestore(&(ptp)->ptp_lock, flags);	\
-} while (0)
-#else
-#define BNXT_READ_TIME64(ptp, dst, src)		\
-	((dst) = READ_ONCE(src))
-#endif
-
 #define BNXT_PTP_INC_TX_AVAIL(ptp)		\
 do {						\
 	spin_lock_bh(&(ptp)->ptp_tx_lock);	\
-- 
2.43.5


