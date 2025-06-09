Return-Path: <netdev+bounces-195772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A15AD2302
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 17:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58BC73A58CD
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 15:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBA41B6D06;
	Mon,  9 Jun 2025 15:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="QO3MduV8"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05D714A4E0
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 15:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749484444; cv=none; b=jf4DPTGqYKqeUjH8VIXpctDo6TVdNn5cq8ZUduCV1dRH+8mvNFUTPmVkY6UUrk9reJJ4PPhfIJG6DEHiHBsPGm/hl7SszxTMIFCiUelj46Dk4a54s0vO2gf9VMNUHr33fABtKcKQRxlIqcN/bYMQVCf0/qtaoB02+LOMr9iNBIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749484444; c=relaxed/simple;
	bh=Nei+d/vEAIwLjgYuT7wv2o9nq9/Gj2FTNUmX3nqlpVk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LHKcyXMFS/uepB53p5Wk+rAfzMo1pXAGYCfiaBv+HQ17q5jSRJTFDU1GnTtgFAKJmDw7yFMYo8jsp+LS60B/K51DsqXcPaJVvPjenx86Rakw46y+Ir++pzzZXPtDoqeT2qrkeTipxlK0ab1JmeKU1+hyFWLxqKXV4pxlpBv5Xik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=QO3MduV8; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55998SH7028900;
	Mon, 9 Jun 2025 08:53:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=jCKugdmLgaS3G4yIm3akrRoRH4xVYCbSM9Wgm8HIVDU=; b=QO3
	MduV86rwgDgJTOH3uHbFc2jcUD1UzjqFqnaU64FajXWuMHwyaxtSzFDdFpvS5PSv
	LJSSlNzOWrZ/Qlg4tH+pFpm6uygtKMGr7NtekdoPMGADNpMXjcsSss2KJd+X+z1a
	BwA3XSnbVpBfCLxrH9I2GH0vrrVey0ceiiZ+eYqLo9/eKTJSt954EiuCH/j9MOMF
	xeTH02aaMJrtw5YnAWdCNVqIKNhigTfKfGzlDR7jpQ17srVArhHTHXblZeTcoVaK
	LuDrny0qNndDCeTkqSAGBRrJGAEodgL99GAryQJr3k9qaZkMr0OkkgAOtKTWjBwm
	pTNA85Qpaab5dFdwkWg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 475vq80qaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Jun 2025 08:53:49 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 9 Jun 2025 08:53:48 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 9 Jun 2025 08:53:48 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 157E93F7075;
	Mon,  9 Jun 2025 08:53:43 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <bbhushan2@marvell.com>, <lcherian@marvell.com>,
        <jerinj@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH] octeontx2-pf: Avoid typecasts by simplifying otx2_atomic64_add macro
Date: Mon, 9 Jun 2025 21:23:41 +0530
Message-ID: <1749484421-3607-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: oBvDnwt1UbwHpHfM13HPjKBpZEKeB6xN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDExNyBTYWx0ZWRfXxn7/qcfps4gt N12vD2sOELSTo+tjhumEj6EB71gNxMKmbUaTdxKJx7p6K8G6AIywcdHAeIwyd1BmZk+wIS8ymVQ 46ENpTPsIt/u2uDJMipahc39OKoQtM3HzHPdyaTGVrOXV+s/QgIWHPZdbHOK3pQJeP9SGin/59b
 asH3oZWJ/ArOl9NJBrc9pGy0AcOXb6xaU0fQWQ52Gqc4BHJJJu6IxDwHgbmnDzGfcfjX6qJAoZm tSjiAQQdtSGEc62ohrjdmfG+mDtlFBeUvZClUz1sEtUzuGwCMcciTA66uIttlpNPI2OgQsxxbRH zxaS0O4FC7adgNb6c48pVdJCI3aSPTZHsqyVEmdT8+xQVYDiJTXAM16Ea7nCRJEG5mYtzhdIzWb
 Z3f2arh5WQWPbQnDmzW+/gqyGwLHAsApSYa7nPYgdUfYAFYBjHuSWg0CeuLrYew7L/sB+NuY
X-Authority-Analysis: v=2.4 cv=Rp3FLDmK c=1 sm=1 tr=0 ts=6847038d cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=nbtXUd6tBmknE0Z8AP4A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: oBvDnwt1UbwHpHfM13HPjKBpZEKeB6xN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_06,2025-06-09_01,2025-03-28_01

Just because otx2_atomic64_add is using u64 pointer as argument
all callers has to typecast __iomem void pointers which inturn
causing sparse warnings. Fix those by changing otx2_atomic64_add
argument to void pointer.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/nic/otx2_common.c    | 17 +++++++++--------
 .../net/ethernet/marvell/octeontx2/nic/otx2_common.h    | 11 ++++++++---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c    |  4 ++--
 drivers/net/ethernet/marvell/octeontx2/nic/qos_sq.c     |  5 +++--
 4 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 6f57258..713928d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -28,12 +28,12 @@ static void otx2_nix_rq_op_stats(struct queue_stats *stats,
 				 struct otx2_nic *pfvf, int qidx)
 {
 	u64 incr = (u64)qidx << 32;
-	u64 *ptr;
+	void __iomem *ptr;
 
-	ptr = (u64 *)otx2_get_regaddr(pfvf, NIX_LF_RQ_OP_OCTS);
+	ptr = otx2_get_regaddr(pfvf, NIX_LF_RQ_OP_OCTS);
 	stats->bytes = otx2_atomic64_add(incr, ptr);
 
-	ptr = (u64 *)otx2_get_regaddr(pfvf, NIX_LF_RQ_OP_PKTS);
+	ptr = otx2_get_regaddr(pfvf, NIX_LF_RQ_OP_PKTS);
 	stats->pkts = otx2_atomic64_add(incr, ptr);
 }
 
@@ -41,12 +41,12 @@ static void otx2_nix_sq_op_stats(struct queue_stats *stats,
 				 struct otx2_nic *pfvf, int qidx)
 {
 	u64 incr = (u64)qidx << 32;
-	u64 *ptr;
+	void __iomem *ptr;
 
-	ptr = (u64 *)otx2_get_regaddr(pfvf, NIX_LF_SQ_OP_OCTS);
+	ptr = otx2_get_regaddr(pfvf, NIX_LF_SQ_OP_OCTS);
 	stats->bytes = otx2_atomic64_add(incr, ptr);
 
-	ptr = (u64 *)otx2_get_regaddr(pfvf, NIX_LF_SQ_OP_PKTS);
+	ptr = otx2_get_regaddr(pfvf, NIX_LF_SQ_OP_PKTS);
 	stats->pkts = otx2_atomic64_add(incr, ptr);
 }
 
@@ -860,9 +860,10 @@ void otx2_sqb_flush(struct otx2_nic *pfvf)
 {
 	int qidx, sqe_tail, sqe_head;
 	struct otx2_snd_queue *sq;
-	u64 incr, *ptr, val;
+	void __iomem *ptr;
+	u64 incr, val;
 
-	ptr = (u64 *)otx2_get_regaddr(pfvf, NIX_LF_SQ_OP_STATUS);
+	ptr = otx2_get_regaddr(pfvf, NIX_LF_SQ_OP_STATUS);
 	for (qidx = 0; qidx < otx2_get_total_tx_queues(pfvf); qidx++) {
 		sq = &pfvf->qset.sq[qidx];
 		if (!sq->sqb_ptrs)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index ca0e6ab1..a2a7fc9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -730,8 +730,9 @@ static inline void otx2_write128(u64 lo, u64 hi, void __iomem *addr)
 			 ::[x0]"r"(lo), [x1]"r"(hi), [p1]"r"(addr));
 }
 
-static inline u64 otx2_atomic64_add(u64 incr, u64 *ptr)
+static inline u64 otx2_atomic64_add(u64 incr, void __iomem *addr)
 {
+	u64 __iomem *ptr = addr;
 	u64 result;
 
 	__asm__ volatile(".cpu   generic+lse\n"
@@ -744,7 +745,11 @@ static inline u64 otx2_atomic64_add(u64 incr, u64 *ptr)
 
 #else
 #define otx2_write128(lo, hi, addr)		writeq((hi) | (lo), addr)
-#define otx2_atomic64_add(incr, ptr)		({ *ptr += incr; })
+
+static inline u64 otx2_atomic64_add(u64 incr, void __iomem *addr)
+{
+	return 0;
+}
 #endif
 
 static inline void __cn10k_aura_freeptr(struct otx2_nic *pfvf, u64 aura,
@@ -794,7 +799,7 @@ static inline void cn10k_aura_freeptr(void *dev, int aura, u64 buf)
 /* Alloc pointer from pool/aura */
 static inline u64 otx2_aura_allocptr(struct otx2_nic *pfvf, int aura)
 {
-	u64 *ptr = (__force u64 *)otx2_get_regaddr(pfvf, NPA_LF_AURA_OP_ALLOCX(0));
+	void __iomem *ptr = otx2_get_regaddr(pfvf, NPA_LF_AURA_OP_ALLOCX(0));
 	u64 incr = (u64)aura | BIT_ULL(63);
 
 	return otx2_atomic64_add(incr, ptr);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 83deebc..07da4d6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1322,8 +1322,8 @@ static irqreturn_t otx2_q_intr_handler(int irq, void *data)
 {
 	struct otx2_nic *pf = data;
 	struct otx2_snd_queue *sq;
-	u64 val, *ptr;
-	u64 qidx = 0;
+	void __iomem *ptr;
+	u64 val, qidx = 0;
 
 	/* CQ */
 	for (qidx = 0; qidx < pf->qset.cq_cnt; qidx++) {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos_sq.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos_sq.c
index 58d572c..2872ada 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/qos_sq.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos_sq.c
@@ -151,9 +151,10 @@ static void otx2_qos_sq_free_sqbs(struct otx2_nic *pfvf, int qidx)
 static void otx2_qos_sqb_flush(struct otx2_nic *pfvf, int qidx)
 {
 	int sqe_tail, sqe_head;
-	u64 incr, *ptr, val;
+	void __iomem *ptr;
+	u64 incr, val;
 
-	ptr = (__force u64 *)otx2_get_regaddr(pfvf, NIX_LF_SQ_OP_STATUS);
+	ptr = otx2_get_regaddr(pfvf, NIX_LF_SQ_OP_STATUS);
 	incr = (u64)qidx << 32;
 	val = otx2_atomic64_add(incr, ptr);
 	sqe_head = (val >> 20) & 0x3F;
-- 
2.7.4


