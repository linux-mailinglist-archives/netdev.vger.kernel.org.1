Return-Path: <netdev+bounces-139625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7C59B39C7
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 19:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E88B1C22073
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 18:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BC71DFDB1;
	Mon, 28 Oct 2024 18:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="EYqMGquK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B05F1DFE03
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 18:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730141878; cv=none; b=ZQo8HZ++7Mbctq7/sAenjcAzFXSgWYTBXTUtgEKiYh/Vc4N+D+GoO73SbPyIvsqKQagn+RDlbjGl0PpdXEwKMj5KET0KVxp3t1UxxnHzm4oA5Lh9rQzNueEcUpJUyIj2+QryYLNAveRZmi/PvDKNkGeXi3IEmMOb6/T2o7ZYD7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730141878; c=relaxed/simple;
	bh=0gX0LnKuJ/NX4wwERuBq+5xSFvDbn8YTjRCAKP0YkAg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=feDeImyWRDmOkXj6Bwd1OV/2E2ALvV4OwoqsbFy0T+pcjqxgJUyYpXolumoQ24Bn9wdTHMKf6ho40yLyltZZ62pO0NZ08PD78dRnAT7uOmLf0meIMwh1aVDbcBpIu+KBc7Shi24RpOA5tVDIAEMmkCeK46C6bQbP1pLFnIifc1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=EYqMGquK; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SImcPR021869;
	Mon, 28 Oct 2024 11:57:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=mae+YG/JczWdEFfkEv
	fI31j08Bf4XKpEzpp3e/RWsMQ=; b=EYqMGquKhdzVoSATMz7bqi0tOQvE4SoceN
	AvlqqMAtJtYvukM1jFL17CC7JwWpIRaklcKViQRj/W97727zqQL+bJ4WPM49RPUI
	zu5qQOEODXyqlaJlvcOhsHSnB9d52j3YJxkBfKy75Osd947I3ft/ja/LKkjmrgvF
	3nIpO7zmyY/dhJRDeXgeu/e1bQhYwquozfklykP7nbOgXUUhT0zYq4+XIMNt5oGC
	091pzNLwKc/H3P30x0r41YD8oc6H9VNgvZSmYHpG0fG1pRA9AFDIL/U85u1l9SMn
	GvmOuAcA2faM+e7R10stmr4ztONB5meMiPvlN0g3DK5cYVtxHXoA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42j8wt3n1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 28 Oct 2024 11:57:33 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server id
 15.2.1544.11; Mon, 28 Oct 2024 18:57:31 +0000
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
Subject: [PATCH net-next v3 1/2] bnxt_en: cache only 24 bits of hw counter
Date: Mon, 28 Oct 2024 11:57:22 -0700
Message-ID: <20241028185723.4065146-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: N-maloUvRsR49SXxY3NAPvgOk8aLa-2P
X-Proofpoint-ORIG-GUID: N-maloUvRsR49SXxY3NAPvgOk8aLa-2P
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
v2 -> v3:
* define BNXT_HI_TIMER_SHIFT for shift
* add comment explaining that 8 bits of cahced value will be used to
  check for roll-over
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


