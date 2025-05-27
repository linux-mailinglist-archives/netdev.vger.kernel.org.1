Return-Path: <netdev+bounces-193601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E459AC4BE9
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 12:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3907417AB21
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 10:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14C61FCCF8;
	Tue, 27 May 2025 10:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="DENc/0TK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B611D63C0
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 10:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748340214; cv=none; b=mrW9uIbkSa/5p6476AHCbc9s1W0Y7v46Wt+kcgkI50qpsMcnAilIacc9EVy6ygZO0TP4jbjHOgIlB9toHFWlsdYGzKle+2YiRi0p3eTYhs68zO+gj2nq5ELwrBjGkjdqbAnGPsHHx5iya1tMF+GUr0nx0RVInJBE+ewBB9VIu+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748340214; c=relaxed/simple;
	bh=ck8d01FzR1STMRoRro7VpTlhnOExSgAeMk6VU6hN2BA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rTXqmSZ7C8SuYQI54aoci0biCnsuAZ7UJN7CAp9G0WCJbzT0p5/Yhx9TvNOk3GCSQMPoz+cXSxYnPrIwBYtNj+pci4aBAP2sFZWysIsI1ucXIboxgvGgFn279jNyPsKLe0j6FQF2mUG1oXpm/kPgX0MGy3aT41zB07IzqNRZq3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=DENc/0TK; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QNX8gt005905;
	Tue, 27 May 2025 03:03:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=PG6xewhCAGX/orwwdZIx+RmPdGP0b8ILfMvvtz32G5U=; b=DEN
	c/0TK+58DL2XkW9JRkVX5SRdqcXTmOysGWhIVnQSJ6hnwGHKWrK/iGdyRtoHf0IE
	ongAcwtFKTbfo30ICqzThMlfBJ29dKPqy3vVqglNLDIBqPcjWkdyVnaM5jNLppw8
	KMppv4HfTsr9r/LwSg9BOwaRXLKZMLm48dJgYumH8IEiyiM2+opVmvF9widSwG+h
	Thbj32af9WW9cedrfZM4AVrKnSwHi4KBo/mMKYsZoyHhzy8JygTvxgdROGHje5qC
	a8NDF/ZKOxhe79eEObdtzCOjHpDsPg6fq6U3t13lSYFJOV0XQ6dprlz7nq/bkswo
	imrHcSLkjIuSVcj4tww==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46w21290gc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 03:03:08 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 May 2025 03:03:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 May 2025 03:03:07 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 57E933F707C;
	Tue, 27 May 2025 03:03:02 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <saikrishnag@marvell.com>, <gakula@marvell.com>, <hkelam@marvell.com>,
        <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <bbhushan2@marvell.com>, <jerinj@marvell.com>
CC: <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net v2 PATCH] octeontx2-pf: Avoid typecasts by simplifying otx2_atomic64_add macro
Date: Tue, 27 May 2025 15:33:00 +0530
Message-ID: <1748340180-32124-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=H6zbw/Yi c=1 sm=1 tr=0 ts=68358ddc cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=o4o-tUPnGTgOOChweZgA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: aKFR0x0wHkXfCeGSp-5m1ETT6bGuH69m
X-Proofpoint-ORIG-GUID: aKFR0x0wHkXfCeGSp-5m1ETT6bGuH69m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA4MiBTYWx0ZWRfX6XPqWc6N1YYz zxgw35nvTawvpotAFxtLyTMHEjHCSsiKsqLRL83VPwGPK8NPtVMUEydsLPdwX7CKPaFZiXBSp4y oLTuk8x9plynb1RY5/dooNgppkL1E1r0eA4zUOGPfV79bvhrJWkg1s8deXAL1GLvw5YCn6B12m+
 PQgUFz3UQCvMHkqcKEiBk4Rb1GAMYtx2qql1R+8ne7mnhNSspmyCbGdxHr4ppKBacZlDgj32L9X HLxVurlFYe478RoC3X6TSb2++1QBnM37PQn9sIstc4r7rLy7ds8asfjPJKYdqLHtvhCX9UftN+M ZqqJ03e5nPx2zTsw3EVR4G6/HUs9kipcEsGHUJs132BaeLkdHs+KLIarcGpxGvEBFmhJJoq+GRT
 mBM4m5D69CcYyTlug9HonlRVXqdNNTsZ9xDVzI0lYiqIQpL0xBdXWjRoaTum2caYPI6CjRKE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_05,2025-05-26_02,2025-03-28_01

Just because otx2_atomic64_add is using u64 pointer as argument
all callers has to typecast __iomem void pointers which inturn
causing sparse warnings. Fix those by changing otx2_atomic64_add
argument to void pointer.

Fixes: caa2da34fd25 ("octeontx2-pf: Initialize and config queues")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
v2:
 Fixed x86 build error of void pointer dereference reported by
 kernel test robot

 .../net/ethernet/marvell/octeontx2/nic/otx2_common.c    | 17 +++++++++--------
 .../net/ethernet/marvell/octeontx2/nic/otx2_common.h    |  7 ++++---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c    |  4 ++--
 drivers/net/ethernet/marvell/octeontx2/nic/qos_sq.c     |  5 +++--
 4 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 84cd029..e5be021 100644
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
index d6b4b74..7058c8b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -733,8 +733,9 @@ static inline void otx2_write128(u64 lo, u64 hi, void __iomem *addr)
 			 ::[x0]"r"(lo), [x1]"r"(hi), [p1]"r"(addr));
 }
 
-static inline u64 otx2_atomic64_add(u64 incr, u64 *ptr)
+static inline u64 otx2_atomic64_add(u64 incr, void __iomem *addr)
 {
+	u64 __iomem *ptr = addr;
 	u64 result;
 
 	__asm__ volatile(".cpu   generic+lse\n"
@@ -747,7 +748,7 @@ static inline u64 otx2_atomic64_add(u64 incr, u64 *ptr)
 
 #else
 #define otx2_write128(lo, hi, addr)		writeq((hi) | (lo), addr)
-#define otx2_atomic64_add(incr, ptr)		({ *ptr += incr; })
+#define otx2_atomic64_add(incr, ptr)		({ *((u64 *)ptr) += incr; })
 #endif
 
 static inline void __cn10k_aura_freeptr(struct otx2_nic *pfvf, u64 aura,
@@ -797,7 +798,7 @@ static inline void cn10k_aura_freeptr(void *dev, int aura, u64 buf)
 /* Alloc pointer from pool/aura */
 static inline u64 otx2_aura_allocptr(struct otx2_nic *pfvf, int aura)
 {
-	u64 *ptr = (__force u64 *)otx2_get_regaddr(pfvf, NPA_LF_AURA_OP_ALLOCX(0));
+	void __iomem *ptr = otx2_get_regaddr(pfvf, NPA_LF_AURA_OP_ALLOCX(0));
 	u64 incr = (u64)aura | BIT_ULL(63);
 
 	return otx2_atomic64_add(incr, ptr);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index cfed9ec..b303a03 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1305,8 +1305,8 @@ static irqreturn_t otx2_q_intr_handler(int irq, void *data)
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
index c5dbae0..d3ae390 100644
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


