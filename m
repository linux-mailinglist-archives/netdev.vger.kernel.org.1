Return-Path: <netdev+bounces-193854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED2EAC60CE
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 06:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 279C14A3D1C
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 04:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429F61EB5FA;
	Wed, 28 May 2025 04:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hE4shbq9"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EF3148838
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 04:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748407263; cv=none; b=pGFWRtqNeANj/YhU95CZhJxYaliLQpFFG+CPr+xMDWiM+DmRZu/7XlTy6uKKG9bUmVJCFKVaj+aDdqHO+J3xjfgPTjBG7z23bAbjags1VOCmkxFPaTMXYiJgj7+SPKtgxB1hux2R9w5xOkYkAFdSIUISICMk1m6WakHzmJDhJ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748407263; c=relaxed/simple;
	bh=3m8JkK0/7qk/llp5WMDwTiQsSNlpZolHOMKlTO6ziB8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G23NcdNlZJBCPPreKwXcP1g/hQwuLSS9yhGy0LQ1dMDwDr8na7mp6u4S/k73um2BEOvuiIoMjVH5GEylkp34XoDrzBPLW55ypuHE4PE3BDZahMTQICC+2pnZcZVp7OI9yi2x6yR8P5P+iJWL40nLw3tYBxxlmTb7rfysWN18iDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hE4shbq9; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S4TOk1014440;
	Tue, 27 May 2025 21:40:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=jCiDQOBAV690EMQv9+FkbM4YUafSFV3PLsYNAHE0mcw=; b=hE4
	shbq95ih/wAzgc1TCTdvdeAWT0T2byz6sBt/8cLag9zxX0NQwWlbKkO36qtUQJIT
	xxZl6MJGeFdw+lsU+MRlNtomOtnMrgxzmzbGqeksV07c914g6tKVbM+N3tsf03XT
	IRFgIOHkbfc9BUJVvenrn3Ycy2n1AdR7gERT0GMC+59UE4d8xiHtu4gndVIbzleM
	Lz6HFyMBRSEKKGHQ5ygZQQvNeHQD9WQ6WJFvauPXrNGWPpFn3gQreZNSjd+inXxj
	/M5Vytv6thERUG/Lzqin3EF0o04oCYsz4a/QEuFBvVxV3QvSU2trMySKCIWJJ5tl
	/Z0SUlSCutHBRrN/lGA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46wq820fkg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 21:40:49 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 May 2025 21:40:48 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 May 2025 21:40:48 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 36B045B6936;
	Tue, 27 May 2025 21:40:43 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <saikrishnag@marvell.com>, <gakula@marvell.com>, <hkelam@marvell.com>,
        <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <bbhushan2@marvell.com>, <jerinj@marvell.com>
CC: <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net v3 PATCH] octeontx2-pf: Avoid typecasts by simplifying otx2_atomic64_add macro
Date: Wed, 28 May 2025 10:10:42 +0530
Message-ID: <1748407242-21290-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: UntBvxi9bE2OgRNdV2UuoJYlOnyl-Gm4
X-Authority-Analysis: v=2.4 cv=EfnIQOmC c=1 sm=1 tr=0 ts=683693d1 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=ypN9OtqOHaDlPD0HzP8A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDAzOSBTYWx0ZWRfX2upQpeNVTLpS 7B/4gxiy1obXdi+bOiS0zGVsEIZt8hHUKTI5FOsvjxqz7MzoKRPgbiAGHslT2+zPH4CzSSQRAkV iYvUiD4wv9i7x4FHUOSLQ0jPSnOGnyWQiZmHNqc+YDVwEtwER61+F1ZLwxC0zWhuVtXKMKqR3mA
 yKWuIpHaEVcLUXKwlTxQyIlLwfXRg9WtmW/9AXVi0IeIm4qALwuh+M16CQ8ogWwUy7RyRNZSLKL A4j/xoaoX0P3MpD/XigvSOOQkXdQcgWvEHTw6O7pS90rbjTSFqHhgdDZfEhlIFcIkOBClEXV9Kp yazXFjkrB3P5AzHcHktJjU++lcLS7MXJ2tl3IAqzGq/E9Ec23fXm0X/Iuf81BXv9cCS0dvxTrfB
 z9CwOio2/Mw008ejrU8sT9xeCNZ7vJmIpuLcoSylR2vjI7n3O2l0RDHFEkXz3IF/kpINr6eB
X-Proofpoint-GUID: UntBvxi9bE2OgRNdV2UuoJYlOnyl-Gm4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_02,2025-05-27_01,2025-03-28_01

Just because otx2_atomic64_add is using u64 pointer as argument
all callers has to typecast __iomem void pointers which inturn
causing sparse warnings. Fix those by changing otx2_atomic64_add
argument to void pointer.

Fixes: caa2da34fd25 ("octeontx2-pf: Initialize and config queues")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
v3:
 Make otx2_atomic64_add as nop for architectures other than ARM64
 to fix sparse warnings
v2:
 Fixed x86 build error of void pointer dereference reported by
 kernel test robot

 .../net/ethernet/marvell/octeontx2/nic/otx2_common.c    | 17 +++++++++--------
 .../net/ethernet/marvell/octeontx2/nic/otx2_common.h    | 11 ++++++++---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c    |  4 ++--
 drivers/net/ethernet/marvell/octeontx2/nic/qos_sq.c     |  5 +++--
 4 files changed, 22 insertions(+), 15 deletions(-)

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
index d6b4b74..c4a0b45 100644
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
@@ -747,7 +748,11 @@ static inline u64 otx2_atomic64_add(u64 incr, u64 *ptr)
 
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
@@ -797,7 +802,7 @@ static inline void cn10k_aura_freeptr(void *dev, int aura, u64 buf)
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


