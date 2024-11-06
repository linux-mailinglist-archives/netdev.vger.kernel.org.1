Return-Path: <netdev+bounces-142531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 933379BF888
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 22:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 577F1283E6A
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 21:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E670020CCD6;
	Wed,  6 Nov 2024 21:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="OZFO5Gwv"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361A1209F3C
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 21:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730928781; cv=none; b=c8EVU7ue2gSKuayYQ76NAn+vdRU/5EwrJZqkpOUQoshnm9FerWo/sJSg3pQ2htpALP8RtpDUaX8hrLez39ucdPeIPuNXziY+ehb2GmqlIoM+ySCXVYHk2v9TEAG7GSeVXpDffsl6X+/L6UPIfuXdD48Sh0oOK87yh9QkX6YoXXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730928781; c=relaxed/simple;
	bh=2Amu2Pj2gFJZAacexpr19Oy9fcPKGJx7ekfHkqY8i74=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hB4xp2+HnIHgux1GGkjw5LZjkryElxgfacYtbpNB8oUHFCOXIcHFvXumGaVR+xE+OsPggKDC++EjcIyPQ8DHzeNKFkh67fJhPb6UldZSMhABinCyAlSm2R3sNWXoeh689+4lQXEFya7JCA2Y+vv6pR7UtTS1MbSC8maVq4c/y/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=OZFO5Gwv; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6JV6mT029177;
	Wed, 6 Nov 2024 13:32:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=jy0Ax4TxrdeaSdS03F
	rJpBN4VUcfej0lNaH12Bgs07M=; b=OZFO5Gwv9q5LfCZVJc4b+KqfkzUD0SkhC5
	T4rkZFxoPk4NXH7SaMDIIK5ACLOiMSJ7aeR+y18XT+jnTQaRCdVYVJwKkzAVHyO8
	W5C3Vk5X7JvwmVQD3DPjVgle41fkimDKH4RBh06fN2vsE3v+2hfiNoqiYArURgAy
	pgpigGL5udXJJcH3Lbl8sjOShZylM3m6eFHhLqD3rRkUsg70KwYF0E0USTRsnBzL
	0RHTpAb8GLOwwjJp9gyYvUp90aS1+uSnsUDXFT87puWdnMPpQcsYqsDzOTYUDP1k
	6abeIudgt3V/gjz04IVDhoI50S9XtwVxT9uYYPdD8J3YspjMNrKw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42r86b3ytp-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 06 Nov 2024 13:32:39 -0800 (PST)
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server id
 15.2.1544.11; Wed, 6 Nov 2024 21:32:37 +0000
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
Subject: [PATCH net-next] bnxt_en: add unlocked version of bnxt_refclk_read
Date: Wed, 6 Nov 2024 13:32:03 -0800
Message-ID: <20241106213203.3997563-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: MDWUj6QMB7pzHBVuFyk8PiJTW_w2nGE_
X-Proofpoint-GUID: MDWUj6QMB7pzHBVuFyk8PiJTW_w2nGE_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01

Serialization of PHC read with FW reset mechanism uses ptp_lock which
also protects timecounter updates. This means we cannot grab it when
called from bnxt_cc_read(). Let's move locking into different function.

Fixes: 6c0828d00f07 ("bnxt_en: replace PTP spinlock with seqlock")
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 29 ++++++++++++-------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index f74afdab4f7d..5395f125b601 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -73,19 +73,15 @@ static int bnxt_ptp_settime(struct ptp_clock_info *ptp_info,
 	return 0;
 }
 
-static int bnxt_refclk_read(struct bnxt *bp, struct ptp_system_timestamp *sts,
-			    u64 *ns)
+/* Caller holds ptp_lock */
+static int __bnxt_refclk_read(struct bnxt *bp, struct ptp_system_timestamp *sts,
+			      u64 *ns)
 {
 	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
 	u32 high_before, high_now, low;
-	unsigned long flags;
 
-	/* We have to serialize reg access and FW reset */
-	read_seqlock_excl_irqsave(&ptp->ptp_lock, flags);
-	if (test_bit(BNXT_STATE_IN_FW_RESET, &bp->state)) {
-		read_sequnlock_excl_irqrestore(&ptp->ptp_lock, flags);
+	if (test_bit(BNXT_STATE_IN_FW_RESET, &bp->state))
 		return -EIO;
-	}
 
 	high_before = readl(bp->bar0 + ptp->refclk_mapped_regs[1]);
 	ptp_read_system_prets(sts);
@@ -97,12 +93,25 @@ static int bnxt_refclk_read(struct bnxt *bp, struct ptp_system_timestamp *sts,
 		low = readl(bp->bar0 + ptp->refclk_mapped_regs[0]);
 		ptp_read_system_postts(sts);
 	}
-	read_sequnlock_excl_irqrestore(&ptp->ptp_lock, flags);
 	*ns = ((u64)high_now << 32) | low;
 
 	return 0;
 }
 
+static int bnxt_refclk_read(struct bnxt *bp, struct ptp_system_timestamp *sts,
+			    u64 *ns)
+{
+	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
+	unsigned long flags;
+	int rc;
+
+	/* We have to serialize reg access and FW reset */
+	read_seqlock_excl_irqsave(&ptp->ptp_lock, flags);
+	rc = __bnxt_refclk_read(bp, sts, ns);
+	read_sequnlock_excl_irqrestore(&ptp->ptp_lock, flags);
+	return rc;
+}
+
 static void bnxt_ptp_get_current_time(struct bnxt *bp)
 {
 	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
@@ -674,7 +683,7 @@ static u64 bnxt_cc_read(const struct cyclecounter *cc)
 	struct bnxt_ptp_cfg *ptp = container_of(cc, struct bnxt_ptp_cfg, cc);
 	u64 ns = 0;
 
-	bnxt_refclk_read(ptp->bp, NULL, &ns);
+	__bnxt_refclk_read(ptp->bp, NULL, &ns);
 	return ns;
 }
 
-- 
2.43.5


