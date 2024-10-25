Return-Path: <netdev+bounces-139199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2E39B0F68
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 21:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 142341F24B1F
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 19:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F06520F3E1;
	Fri, 25 Oct 2024 19:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="K2cXklWT"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0FA1D8E10
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 19:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729885716; cv=none; b=Sv32d3XuYJmE0FgUuTLF6+swAnQf0WuyWqcB/gPbBs8zpIEQWOQvSJ7WanaQH2h7V48m2K8OXU3oRz2UFGqXfkEnWoXYNTspPeV8kETy2bKFCJlhJFBiCHYrEOtOD+bfzOMQry23gEi5WdGksF5wXmRFIFPQAFtzh5TlZkr7qBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729885716; c=relaxed/simple;
	bh=ArVZr8Y3oMn6A1cz5mme4hWWsamFUXlYt1oo08RPqbM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kBC9uvjT6t8461YQTmeEOGneZ96p2HNJFNMsdBU4Dv7+m3SFom3q+drK4S8sifiKFOo4SGEU4o+jcBHdam+WVEKF8JcayHtwvK2Ai1K09/aFYER1PQm1gZxJ8ki8BfQxvZOZX1cojW3JblLC5v3iMxmtztXiue+5xlVBjk8Ugjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=K2cXklWT; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PJ5LE5015903;
	Fri, 25 Oct 2024 12:48:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=dNSsaAm6PDB7nGLfQu
	wftEPbw9Ytu9Ek0EQgviPrWqc=; b=K2cXklWTo77B7HDkOqeJsT3Vm7myXrA8J2
	VBr/7WHUUhEoJ4cqudoQaDVMjkXFyvIpCZ3V7MRqnjRHcFOLbdF8zJ/93/C8cIAN
	UZsMd2TbFYGKUHgqKYZ8bGO4m5+bc8iBkQgClcvGgqwaMG+mIRs+IIvAgxLcycyx
	x9dbVKQI0/92HQuQ4mchzzyyxRXxlhgIiT1FRS26AqVwM3MIxGZeUPGO6TYiD8lq
	6u8x+8cTHTLgun2zr9lGzmZOcRSrHHmKskVLOa8YzaWrslzaEJKfHqktYWwdXiBT
	d1Bz9a4NkBtqC+hxzALQJ5IW2VCf/OgsdX1Wz0TqpeNWrD6avcpA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42gg1rrtnw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 25 Oct 2024 12:48:19 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server id
 15.2.1544.11; Fri, 25 Oct 2024 19:48:17 +0000
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
Subject: [PATCH net-next v2 1/2] bnxt_en: cache only 24 bits of hw counter
Date: Fri, 25 Oct 2024 12:47:52 -0700
Message-ID: <20241025194753.3070604-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: q_MrZaHGZp5usH1sM9f0NFNJNF0tvY8B
X-Proofpoint-ORIG-GUID: q_MrZaHGZp5usH1sM9f0NFNJNF0tvY8B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

This hardware can provide only 48 bits of cycle counter. We can leave
only 24 bits in the cache to extend RX timestamps from 32 bits to 48
bits. This make cache writes atomic even on 32 bit platforms and we can
simply use READ_ONCE()/WRITE_ONCE() pair and remove spinlock. The
configuration structure will be also reduced by 4 bytes.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c |  8 ++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h | 16 +---------------
 2 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index fa514be87650..c7e626b9098a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -106,7 +106,7 @@ static void bnxt_ptp_get_current_time(struct bnxt *bp)
 	if (!ptp)
 		return;
 	spin_lock_irqsave(&ptp->ptp_lock, flags);
-	WRITE_ONCE(ptp->old_time, ptp->current_time);
+	WRITE_ONCE(ptp->old_time, (u32)(ptp->current_time >> 24));
 	bnxt_refclk_read(bp, NULL, &ptp->current_time);
 	spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 }
@@ -174,7 +174,7 @@ void bnxt_ptp_update_current_time(struct bnxt *bp)
 	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
 
 	bnxt_refclk_read(ptp->bp, NULL, &ptp->current_time);
-	WRITE_ONCE(ptp->old_time, ptp->current_time);
+	WRITE_ONCE(ptp->old_time, (u32)(ptp->current_time >> 24));
 }
 
 static int bnxt_ptp_adjphc(struct bnxt_ptp_cfg *ptp, s64 delta)
@@ -813,7 +813,7 @@ int bnxt_get_rx_ts_p5(struct bnxt *bp, u64 *ts, u32 pkt_ts)
 	if (!ptp)
 		return -ENODEV;
 
-	BNXT_READ_TIME64(ptp, time, ptp->old_time);
+	time = (u64)(READ_ONCE(ptp->old_time) << 24);
 	*ts = (time & BNXT_HI_TIMER_MASK) | pkt_ts;
 	if (pkt_ts < (time & BNXT_LO_TIMER_MASK))
 		*ts += BNXT_LO_TIMER_MASK + 1;
@@ -1079,7 +1079,7 @@ int bnxt_ptp_init(struct bnxt *bp, bool phc_cfg)
 
 		spin_lock_irqsave(&ptp->ptp_lock, flags);
 		bnxt_refclk_read(bp, NULL, &ptp->current_time);
-		WRITE_ONCE(ptp->old_time, ptp->current_time);
+		WRITE_ONCE(ptp->old_time, (u32)(ptp->current_time >> 24));
 		spin_unlock_irqrestore(&ptp->ptp_lock, flags);
 		ptp_schedule_worker(ptp->ptp_clock, 0);
 	}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
index f322466ecad3..80046bd314db 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
@@ -106,10 +106,10 @@ struct bnxt_ptp_cfg {
 	/* serialize ts tx request queuing */
 	spinlock_t		ptp_tx_lock;
 	u64			current_time;
-	u64			old_time;
 	unsigned long		next_period;
 	unsigned long		next_overflow_check;
 	u32			cmult;
+	u32			old_time;
 	/* a 23b shift cyclecounter will overflow in ~36 mins.  Check overflow every 18 mins. */
 	#define BNXT_PHC_OVERFLOW_PERIOD	(18 * 60 * HZ)
 
@@ -145,20 +145,6 @@ struct bnxt_ptp_cfg {
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


