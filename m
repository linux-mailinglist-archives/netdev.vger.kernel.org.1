Return-Path: <netdev+bounces-144859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D399C893C
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 12:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88ED52849CA
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AACB1F940C;
	Thu, 14 Nov 2024 11:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="QHRkZ6LE"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FE618B49F
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 11:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731584936; cv=none; b=SDnwTfMYV41r5ZE92T6Oh6OSlCpznudYjyI5bfnNT4qqThkVA1Wa6ltTAjSRCJY34aHt1JIh7mUmk1+ugAMFfXg7cMCdfQRl+5AUP19nibyrls03AKsFyYVl9KerMeZhbSEZ4cy+gpKBBkRiqJmsSU+bLbPaTWRCTlibiLchcg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731584936; c=relaxed/simple;
	bh=GuaZVsTPlYWXRZLYXPADU6inSCOlZEV8AQQ/hDH/XrI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n2CUoM8UHRuXVLD3BY+Nmpt/UcR/UM+DO2yd+4RJbQ8Jx0nHVP/IX4W3CqhjT6+tyXSCpBuohUWy3fbNM3XxPghDmnAbrgV6rbi/Fk0MS4iVVeloRjTesu/Tx6URrhtabPGw5+jW256XYcGSgOPf2o4NKfvNVnpzKRnR0Y5eGus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=QHRkZ6LE; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEAoP4M007490;
	Thu, 14 Nov 2024 03:48:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=yFkNc43UupPprKIWhS
	atg3NsfBJo/FH/R8OGZrPVU5s=; b=QHRkZ6LETYceQI0zyReQezFXpn4YtJM10D
	YAc4033+5uE0skHFGJWu0lF2HjPpfQBuyYV0dgeC3MX6YKvWWAtLE0FyoJkvYQHf
	gzQIgdrZ4C7sUoBkcnuX33yVjfqKKlzsQ//NdEQ2klxcjeH51PSZkSlGXUfHR+vk
	U8puqMIOzAfy3ElCsM7p3MvxBeVxnGv611i8VrRmFOcwcgcK0poH5YRXkzvr9b73
	7UOi3JqF2ewvY25WMauy22NtYj5v6VcYsufgadIFpPoqVYr8UCDdavrW00L6ZThq
	Sdtp+uWAXJ2C5E2ocZCjByg/7iLkiwVXDrbtu+pLkWuL1RHjhQiw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42wbt5hq93-18
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 14 Nov 2024 03:48:40 -0800 (PST)
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server id
 15.2.1544.11; Thu, 14 Nov 2024 11:48:36 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Pavan Chebbi
	<pavan.chebbi@broadcom.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni
	<pabeni@redhat.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Jakub Kicinski
	<kuba@kernel.org>
CC: Richard Cochran <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Vadim Fedorenko <vadfed@meta.com>,
        Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v2] bnxt_en: optimize gettimex64
Date: Thu, 14 Nov 2024 03:48:20 -0800
Message-ID: <20241114114820.1411660-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: cvnbVuIPMuHdssz5bOQEqoZ-iREmI9FN
X-Proofpoint-ORIG-GUID: cvnbVuIPMuHdssz5bOQEqoZ-iREmI9FN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

Current implementation of gettimex64() makes at least 3 PCIe reads to
get current PHC time. It takes at least 2.2us to get this value back to
userspace. At the same time there is cached value of upper bits of PHC
available for packet timestamps already. This patch reuses cached value
to speed up reading of PHC time.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
v1 -> v2:
* move cycles extension to a helper function and reuse it for both
  timestamp extension and gettimex64() function

I did some benchmarks on host with Broadcom Thor NIC trying to build
histogram of time spent to call clock_gettime() to query PTP device
over million iterations.
With current implementation the result is (long tail is cut):

2200ns: 902624
2300ns: 87404
2400ns: 4025
2500ns: 1307
2600ns: 581
2700ns: 261
2800ns: 104
2900ns: 36
3000ns: 32
3100ns: 24
3200ns: 16
3300ns: 29
3400ns: 29
3500ns: 23

Optimized version on the very same machine and NIC gives next values:

900ns: 865436
1000ns: 128630
1100ns: 2671
1200ns: 727
1300ns: 397
1400ns: 178
1500ns: 92
1600ns: 16
1700ns: 15
1800ns: 11
1900ns: 6
2000ns: 20
2100ns: 11

That means pct(99) improved from 2300ns to 1000ns.
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 32 +++++++++++++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h | 11 +++++++
 2 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index 91e7e08fabb1..075ccd589845 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -112,6 +112,28 @@ static int bnxt_refclk_read(struct bnxt *bp, struct ptp_system_timestamp *sts,
 	return rc;
 }
 
+static int bnxt_refclk_read_low(struct bnxt *bp, struct ptp_system_timestamp *sts,
+				u32 *low)
+{
+	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
+	unsigned long flags;
+
+	/* We have to serialize reg access and FW reset */
+	read_seqlock_excl_irqsave(&ptp->ptp_lock, flags);
+
+	if (test_bit(BNXT_STATE_IN_FW_RESET, &bp->state)) {
+		read_sequnlock_excl_irqrestore(&ptp->ptp_lock, flags);
+		return -EIO;
+	}
+
+	ptp_read_system_prets(sts);
+	*low = readl(bp->bar0 + ptp->refclk_mapped_regs[0]);
+	ptp_read_system_postts(sts);
+
+	read_sequnlock_excl_irqrestore(&ptp->ptp_lock, flags);
+	return 0;
+}
+
 static void bnxt_ptp_get_current_time(struct bnxt *bp)
 {
 	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
@@ -163,12 +185,14 @@ static int bnxt_ptp_gettimex(struct ptp_clock_info *ptp_info,
 	struct bnxt_ptp_cfg *ptp = container_of(ptp_info, struct bnxt_ptp_cfg,
 						ptp_info);
 	u64 ns, cycles;
+	u32 low;
 	int rc;
 
-	rc = bnxt_refclk_read(ptp->bp, sts, &cycles);
+	rc = bnxt_refclk_read_low(ptp->bp, sts, &low);
 	if (rc)
 		return rc;
 
+	cycles = bnxt_extend_cycles_32b_to_48b(ptp, low);
 	ns = bnxt_timecounter_cyc2time(ptp, cycles);
 	*ts = ns_to_timespec64(ns);
 
@@ -801,15 +825,11 @@ void bnxt_get_tx_ts_p5(struct bnxt *bp, struct sk_buff *skb, u16 prod)
 int bnxt_get_rx_ts_p5(struct bnxt *bp, u64 *ts, u32 pkt_ts)
 {
 	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
-	u64 time;
 
 	if (!ptp)
 		return -ENODEV;
 
-	time = (u64)READ_ONCE(ptp->old_time) << BNXT_HI_TIMER_SHIFT;
-	*ts = (time & BNXT_HI_TIMER_MASK) | pkt_ts;
-	if (pkt_ts < (time & BNXT_LO_TIMER_MASK))
-		*ts += BNXT_LO_TIMER_MASK + 1;
+	*ts = bnxt_extend_cycles_32b_to_48b(ptp, pkt_ts);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
index 4df4c2f373e0..c7851f8c971c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
@@ -182,4 +182,15 @@ static inline u64 bnxt_timecounter_cyc2time(struct bnxt_ptp_cfg *ptp, u64 ts)
 
 	return ns;
 }
+
+static inline u64 bnxt_extend_cycles_32b_to_48b(struct bnxt_ptp_cfg *ptp, u32 ts)
+{
+	u64 time, cycles;
+
+	time = (u64)READ_ONCE(ptp->old_time) << BNXT_HI_TIMER_SHIFT;
+	cycles = (time & BNXT_HI_TIMER_MASK) | ts;
+	if (ts < (time & BNXT_LO_TIMER_MASK))
+		cycles += BNXT_LO_TIMER_MASK + 1;
+	return cycles;
+}
 #endif
-- 
2.43.5


