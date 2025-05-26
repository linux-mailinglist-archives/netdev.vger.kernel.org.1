Return-Path: <netdev+bounces-193471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14322AC4288
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 17:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9064518885CC
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 15:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E87C211A0C;
	Mon, 26 May 2025 15:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Mu7BWgY0"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B440D2110E
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 15:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748274253; cv=none; b=ucN3ttnNdMHo36JipglNdYZmXqMgQcurvklHuyKPH2cu6yBxDX6Xr4HF3oiRJpCRg9BqqOC4HkDLoU7TWCQXty5BuhThSpGazYyvXUddPIMb4ygT8wxtt43FNZyWW55bYBzj2Sq5O/3B1vWkQU7e4NOd/YvvcIsKTW2KzY0ZD8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748274253; c=relaxed/simple;
	bh=cWpMFITew6VUYMXM3YA5+LI2nrUtXOVzZe+ee30BJCU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uLng3r1cODo825nZ/IbazS3+CH/gyluRQkpz7mf6FYWxZEfQVtybGKp6dxmRfywxq2rqrfCn5k5UFMzZ0Y2kbcHXNDvwQGSummtp1IInklXT0utGhzTKUYdFvXNGT2l8w5c1Z35GIvTYWKoZJEi738+XnxGzqouTXShds3kVTAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Mu7BWgY0; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QBOEOZ015289;
	Mon, 26 May 2025 08:44:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=ExDqM421FEkuaXhRXXY5OgitWDbYFq9VkkOz7YwuLXw=; b=Mu7
	BWgY0OI9nwzQ10h0NjvOvk+MrX77B9d9LJTOMmMP1kWd3w8No9pMnMkqIS8Xlzwr
	WqzLUhl01Jt2l+C5mxjT72texTVcdbfzCcOAG2Jtf5wPP7EYMN4INNDcNrG9mbMN
	vDv6VGF97e7jMCceIxhxBJxJ7A+OLPlS1da2cfuO6cUiMsr/SqSNY4+gHXHhU5fP
	3Hka33e7aKk111KQq/cEEzTZm6yIkoIfpjaMvqz9b3jLhuhpyegccZBmqwZb5hyA
	uXy5IP+CjeqHYQyn5Hhy/khpZe8Z2K86rRS70NmkM2kEPqoONJ1HoE1Roa/d2MNr
	yhnX/2AtL/ISgKr7Pow==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46vp9krk0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 May 2025 08:44:01 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 26 May 2025 08:44:00 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 26 May 2025 08:43:59 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 05F1E3F7061;
	Mon, 26 May 2025 08:43:54 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <saikrishnag@marvell.com>, <gakula@marvell.com>, <hkelam@marvell.com>,
        <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <bbhushan2@marvell.com>, <jerinj@marvell.com>
CC: <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net PATCH] octeontx2-pf: Avoid typecasts by simplifying otx2_atomic64_add macro
Date: Mon, 26 May 2025 21:13:52 +0530
Message-ID: <1748274232-20835-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=VYn3PEp9 c=1 sm=1 tr=0 ts=68348c41 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=jOSla0tn-kPexPMtcMgA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDEzMiBTYWx0ZWRfX/Gx3WoZsNN4E YQrqk/5sEOQ/ieZ4TMEH/NzNMxZZJa3EvqYBOqhXRGVyKBc1wlxDGEtu6B3ms4OLl2e75Xx/qn4 pipz8Vkw1+A9Or+smmmtIlKHTCVZQDuDKhwFtFjZ/TMKm5tWUOonqoKGQZoHCrVi55Q+icfQ0LJ
 zqFHnhdPqSKVMk2gIRSRATfAG9COzTsYFZhM9HqrI465hzCknE1KIGWpe0HVs4ScJtBcQprvEbo 7pk7iS20+C0Gfqxe30oInNdey7f3AKe/8pHuGeKgc6sIwNm88rYWrzpOMNFBdTDWAu1v0vhWFOX +6d6Tf69SlHLLDagwxc8IFoMoThHSHJT+cvwBSksQN1uNwkzZ6kXynoO6e9nUN/mZTd4D0nmDW8
 wS5W4hjJvz1cV1spgGxhU8krZWWw+FiPIuD1hvYnKROgYyvsADt3hnHAv5Qwe1FMufBckwam
X-Proofpoint-ORIG-GUID: EHPtUAH0x4_RhrfvfyZddKGtKQcDYwWd
X-Proofpoint-GUID: EHPtUAH0x4_RhrfvfyZddKGtKQcDYwWd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_08,2025-05-26_02,2025-03-28_01

Just because otx2_atomic64_add is using u64 pointer as argument
all callers has to typecast __iomem void pointers which inturn
causing sparse warnings. Fix those by changing otx2_atomic64_add
argument to void pointer.

Fixes: caa2da34fd25 ("octeontx2-pf: Initialize and config queues")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/nic/otx2_common.c    | 17 +++++++++--------
 .../net/ethernet/marvell/octeontx2/nic/otx2_common.h    |  5 +++--
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c    |  4 ++--
 drivers/net/ethernet/marvell/octeontx2/nic/qos_sq.c     |  5 +++--
 4 files changed, 17 insertions(+), 14 deletions(-)

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
index d6b4b74..c74e06e 100644
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


