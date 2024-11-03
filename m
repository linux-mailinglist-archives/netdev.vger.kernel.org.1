Return-Path: <netdev+bounces-141349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8E49BA862
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 22:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC6A01F2178C
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 21:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C593718A6B0;
	Sun,  3 Nov 2024 21:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="b6Bt6qSm"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C018B16087B
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 21:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730670701; cv=none; b=MiADwyo7l2nC0MIfb1x78VVgMeT/9o1aP/c/wXM5uA6Ihxsfm5yn3H6hG2JsKt3PRGYd40Lh0dfM8zqVxtItX3kkqkVljm6RmutvFfv5xvkaI4RiLt6ztCXlOmMnNy4dAtVt/1dNHLDWrgw1s+0zbqW4LZu40J3dGEpD80MdlBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730670701; c=relaxed/simple;
	bh=OZSEYdZsQjl83TD5jm3UIASnjHLQRLAc3aDtwazahys=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uMD7g3me/WGFj3GrUvz2tutxNU76IGMJiYaEYmoQcwLvxVvqGMBF4s+FV5mVYpGEvjhztOmeR4IH7pDwGohyLNR7GfPpV1LOG1xiT7rj4s1CBjNbJnFV3GbJD+UCw4wYPCPZbdpadewGyrbFBJRgkNSN0Zvir9a8L0P82e7A0J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=b6Bt6qSm; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A3JOWNE010169;
	Sun, 3 Nov 2024 13:51:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=wmuK0/mhaKwX7Qajlx
	HVn5mVu84EWbZMxmJ9z/neJ/Q=; b=b6Bt6qSmOfLnyKLuLJfn+4gmQsfLxltwUJ
	Jo7dTTpAtre8JGLEl2cYdg9Hn9DbYLUKD6thdnX8c09kWG+X2lS9gFxnlbGBEkgM
	e8IU/fVaYVvKEhYkTs9FFSDMKlBffyqYfNqY24opHATC+H7x/nGKX4SdG5Y7dRqs
	ZbqTsVecXhl8LDhYDS9ICdOQ16b9HnEYL83d5cgH1OAZWJWEC1caF41mRhZrE+kG
	D4u1zjQ/bTR6Sbdwqim52Ul4baOq4t75Ma3KRx97SHSghEtPffbyVRxqZ+D9wHFR
	mKX5BY4jNH16a+4ZAuSre2xTW6eGe21I8UoyYFsWHJfboo1Q28HQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42npm6n8b6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 03 Nov 2024 13:51:19 -0800 (PST)
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server id
 15.2.1544.11; Sun, 3 Nov 2024 21:51:16 +0000
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
Subject: [PATCH net-next v5 1/2] bnxt_en: cache only 24 bits of hw counter
Date: Sun, 3 Nov 2024 13:51:07 -0800
Message-ID: <20241103215108.557531-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: eZn0VqFHhjnnIJQL9ol2Phe88AMQEfIg
X-Proofpoint-ORIG-GUID: eZn0VqFHhjnnIJQL9ol2Phe88AMQEfIg
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

Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
v5:
- adjust misplaced u64 cast
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c |  8 ++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h | 18 +++---------------
 2 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index fa514be87650..ccf0ab304ed9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -106,7 +106,7 @@ static void bnxt_ptp_get_current_time(struct bnxt *bp)
 	if (!ptp)
 		return;
 	spin_lock_irqsave(&ptp->ptp_lock, flags);
-	WRITE_ONCE(ptp->old_time, ptp->current_time);
+	WRITE_ONCE(ptp->old_time, ptp->current_time >> BNXT_HI_TIMER_SHIFT);
 	bnxt_refclk_read(bp, NULL, &ptp->current_time);
 	spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 }
@@ -174,7 +174,7 @@ void bnxt_ptp_update_current_time(struct bnxt *bp)
 	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
 
 	bnxt_refclk_read(ptp->bp, NULL, &ptp->current_time);
-	WRITE_ONCE(ptp->old_time, ptp->current_time);
+	WRITE_ONCE(ptp->old_time, ptp->current_time >> BNXT_HI_TIMER_SHIFT);
 }
 
 static int bnxt_ptp_adjphc(struct bnxt_ptp_cfg *ptp, s64 delta)
@@ -813,7 +813,7 @@ int bnxt_get_rx_ts_p5(struct bnxt *bp, u64 *ts, u32 pkt_ts)
 	if (!ptp)
 		return -ENODEV;
 
-	BNXT_READ_TIME64(ptp, time, ptp->old_time);
+	time = (u64)READ_ONCE(ptp->old_time) << BNXT_HI_TIMER_SHIFT;
 	*ts = (time & BNXT_HI_TIMER_MASK) | pkt_ts;
 	if (pkt_ts < (time & BNXT_LO_TIMER_MASK))
 		*ts += BNXT_LO_TIMER_MASK + 1;
@@ -1079,7 +1079,7 @@ int bnxt_ptp_init(struct bnxt *bp, bool phc_cfg)
 
 		spin_lock_irqsave(&ptp->ptp_lock, flags);
 		bnxt_refclk_read(bp, NULL, &ptp->current_time);
-		WRITE_ONCE(ptp->old_time, ptp->current_time);
+		WRITE_ONCE(ptp->old_time, ptp->current_time >> BNXT_HI_TIMER_SHIFT);
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


