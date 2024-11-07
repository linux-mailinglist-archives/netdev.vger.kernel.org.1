Return-Path: <netdev+bounces-143082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9169C1145
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 22:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C78161F246FF
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 21:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE96221830B;
	Thu,  7 Nov 2024 21:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="kg+8EJGU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208D9155398
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 21:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731016186; cv=none; b=pJeI9PgTqnY8AywwamTVzJp312Nc+4lpV930gVBw+R1XlkmsyBzT7MC/gbMTMVMSmu0pqtAgC7lVbo+QmpG1GjGKYFPCN5du3ZF0+3OClKzGcobSiOy5IoIWwnJv0prazD3lYsZYySabGi8zoqJVQk7L/8lLJBAigVWA43GlGT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731016186; c=relaxed/simple;
	bh=+iXJ8JKCamSq90vpd9jqRlvglq3ITWiUNlXjW2lre6Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HcKWJ6RQp1aorIKJyd4V7/E/5DAJgSACJv8GGZycsbib5Xrz9I3rrXJz9e6giH9qKLP5bx0n4JuPev1hMPeYLVq3Zk4rJFNDvIc9r+2uzIhDF8QdBbzewb1uC5wAPxROmAIoihGMmln3Lh99sVqh7pnTWaQgiR5iQk6eAOsxJeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=kg+8EJGU; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4A7KBrUg000886;
	Thu, 7 Nov 2024 13:49:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=OoDzaVXTpM6Wt4aFg7
	WL8/PT3rzopHpgtd6E0ZPLqDg=; b=kg+8EJGU5Lz8DoUDjHhYM9HCsIVlHVdDjQ
	QhrUbCZ/WudPGr/xakc47ds5uehDQG37GmNiOswUFB2SriVcXLMewVGc010r1Np5
	WaC8NNam6EY4kVoqgpLLr8TKLUcsU//JPHocmRDOn/omN6C6X8hanuoOqqTkEp2g
	ZSa0J5SDfolxrbhOMyojI/Fuq85YJUyQx65OoyM4A2icbyHbCffE210fHqtqbP2o
	6N+nDgIrb7kCWeAZCx3UH95NllAh9RLrqjEclCA+x7UvfyS2X1tWARJVrc3UBlL/
	b7KjfV5Pbkp8yywZy2BJgpjawxb/dzGFWx10GnSmnAp2On/0doTg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 42s12xjhey-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 07 Nov 2024 13:49:32 -0800 (PST)
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server id
 15.2.1544.11; Thu, 7 Nov 2024 21:49:24 +0000
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
Subject: [PATCH net-next v2] bnxt_en: add unlocked version of bnxt_refclk_read
Date: Thu, 7 Nov 2024 13:49:17 -0800
Message-ID: <20241107214917.2980976-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: E82OmzNGWewhpYWd_QNOj_CA1f1B_hHr
X-Proofpoint-GUID: E82OmzNGWewhpYWd_QNOj_CA1f1B_hHr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

Serialization of PHC read with FW reset mechanism uses ptp_lock which
also protects timecounter updates. This means we cannot grab it when
called from bnxt_cc_read(). Let's move locking into different function.

Fixes: 6c0828d00f07 ("bnxt_en: replace PTP spinlock with seqlock")
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
v1 -> v2:
* add lock around timecounter_init() in bnxt_ptp_timecounter_init()
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 35 +++++++++++++------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index f74afdab4f7d..91e7e08fabb1 100644
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
 
@@ -936,6 +945,7 @@ static bool bnxt_pps_config_ok(struct bnxt *bp)
 static void bnxt_ptp_timecounter_init(struct bnxt *bp, bool init_tc)
 {
 	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
+	unsigned long flags;
 
 	if (!ptp->ptp_clock) {
 		memset(&ptp->cc, 0, sizeof(ptp->cc));
@@ -952,8 +962,11 @@ static void bnxt_ptp_timecounter_init(struct bnxt *bp, bool init_tc)
 		}
 		ptp->next_overflow_check = jiffies + BNXT_PHC_OVERFLOW_PERIOD;
 	}
-	if (init_tc)
+	if (init_tc) {
+		write_seqlock_irqsave(&ptp->ptp_lock, flags);
 		timecounter_init(&ptp->tc, &ptp->cc, ktime_to_ns(ktime_get_real()));
+		write_sequnlock_irqrestore(&ptp->ptp_lock, flags);
+	}
 }
 
 /* Caller holds ptp_lock */
-- 
2.43.5


