Return-Path: <netdev+bounces-207971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 772C7B092E1
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 19:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27E365A3734
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A032FE317;
	Thu, 17 Jul 2025 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="NP1NrjYR"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF172FE31C
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 17:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752772214; cv=none; b=d4NeHDECrwuKWnqd2Pwy1IkmxUoXng5NJ06FA3jPB9uU9JYA/9X5hp46UYo729LgPNhOs98GZCpS8iTguzZFek/l6HoX8AevpQu0d35ZgLYUzUfJL3PlsAuoi8g0qBxivWatanVxmLfE69AAwwC6cWtTEat7ulVLES6BGLjrgPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752772214; c=relaxed/simple;
	bh=ABDGueaEDGVAhgwzPSv1So1IS+Qn2x3B9eo/fjNOQtM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WhQWdpTiU+GO7bgyw505RsTCbICou73gx2I02/iVr3qRFaGoW1295XFjvZPcbyp1khiTABAW/fRpzd9u8eg/1zPcqfreYlpw2BgWve9Ue3Ab638d9fK7mUgM1XjSsmZoqOAI/lgQsYyy5QB+aAizRag1f/DhRiiQR/7Ino22YA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=NP1NrjYR; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H9e40a023361;
	Thu, 17 Jul 2025 10:10:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=nZw5aXeJQ8FflwN3AZiUFj3gY
	TUIsySCc37HvxCarTM=; b=NP1NrjYRKzMHkwNiCfmc1FyN3TCW0WH+g3oYbSY07
	IKD6EcmF/+zbyudfkWa3aVrqO+73vBrEyyaBZC2iuDf6G90psRV32LcoMUGzooH4
	nC1ZHlx0Ra24VNCUCiW8gqIaOakI92aA5i0JnsHNPiN57MSAMf43i78fGDlv38Ei
	nRUJye/3GqE44a/ikq+uuh3pbDGTRLcBG4eb73xJbWD55aHPzjtwqEv9Lg16c0Wu
	UMopxH4tRzqEh+X/Sn8R9POiDIZaU5ElXJhdy+SDoz62/jzHCTjnP62nJxYhiiPl
	f8l6hFSUTFPgXvwUUWOpKo09/lab22g3XQ1lkPM0UwnWA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47xxptrycy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 10:10:04 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 17 Jul 2025 10:10:03 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 17 Jul 2025 10:10:03 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 516653F7044;
	Thu, 17 Jul 2025 10:09:59 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>,
        <jerinj@marvell.com>, <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH v3 07/11] octeontx2-pf: Initialize cn20k specific aura and pool contexts
Date: Thu, 17 Jul 2025 22:37:39 +0530
Message-ID: <1752772063-6160-8-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1752772063-6160-1-git-send-email-sbhatta@marvell.com>
References: <1752772063-6160-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Z73sHGRA c=1 sm=1 tr=0 ts=68792e6c cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=o_oeuxXBfXPkz0o_jD8A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: eiTzidQJzLuU7OywAvNGyWJc8dKRWzo8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE1MiBTYWx0ZWRfXwrvs9KQLd55N WBkgjxN0Ood2lsAEBEs/znogJkGGJi4rJexVXhd/oDB2W7tsIDMGV7XRtTZD4qAXoXkXOk6K0Fa xzjCnUh6XpKzwfFPailaXf+46X0+xyF15EUBT3fspoKpp+nSzFMfjaADJpBB29FTu/Dc9mR6uZw
 RC3phuEa/4aj1vIjiV1Bi92jTAJjS0iYeIAf2YENwGEpKhUrfmi/4s81i0LZQ5gXl4RLHasZs9O nVky3huZTb6F4z14Eh9y8ef3i/YI2yqTCT2lwOJ1GoVPjXpabT8GZz4bqJGnyG7SMpZFxvN9n9d iJ8KhF/2vNG4EVwkcL0qGBqHzj4XBvvpCddj8iNF5TKyG5vbQjm8SDGj3K0gHmysCu3i1/jQVym
 vgLfkLpy3UvM3E5PsrTeXCc1jGTkmauDNQ2TfaQUZvz92P7ic/FFYHI4Wl8GV4zUMje1MutQ
X-Proofpoint-ORIG-GUID: eiTzidQJzLuU7OywAvNGyWJc8dKRWzo8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01

From: Linu Cherian <lcherian@marvell.com>

With new CN20K NPA pool and aura contexts supported in AF
driver this patch modifies PF driver to use new NPA contexts.
Implement new hw_ops for intializing aura and pool contexts
for all the silicons.

Signed-off-by: Linu Cherian <lcherian@marvell.com>
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 .../ethernet/marvell/octeontx2/nic/cn10k.c    |   4 +
 .../ethernet/marvell/octeontx2/nic/cn20k.c    | 178 ++++++++++++++++--
 .../marvell/octeontx2/nic/otx2_common.c       |  14 ++
 .../marvell/octeontx2/nic/otx2_common.h       |  10 +
 4 files changed, 195 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
index bec7d5b4d7cc..cab157aac251 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
@@ -15,6 +15,8 @@ static struct dev_hw_ops	otx2_hw_ops = {
 	.aura_freeptr = otx2_aura_freeptr,
 	.refill_pool_ptrs = otx2_refill_pool_ptrs,
 	.pfaf_mbox_intr_handler = otx2_pfaf_mbox_intr_handler,
+	.aura_aq_init = otx2_aura_aq_init,
+	.pool_aq_init = otx2_pool_aq_init,
 };
 
 static struct dev_hw_ops cn10k_hw_ops = {
@@ -23,6 +25,8 @@ static struct dev_hw_ops cn10k_hw_ops = {
 	.aura_freeptr = cn10k_aura_freeptr,
 	.refill_pool_ptrs = cn10k_refill_pool_ptrs,
 	.pfaf_mbox_intr_handler = otx2_pfaf_mbox_intr_handler,
+	.aura_aq_init = otx2_aura_aq_init,
+	.pool_aq_init = otx2_pool_aq_init,
 };
 
 void otx2_init_hw_ops(struct otx2_nic *pfvf)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
index ec8cde98076d..037548f36940 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
@@ -10,17 +10,6 @@
 #include "otx2_struct.h"
 #include "cn10k.h"
 
-static struct dev_hw_ops cn20k_hw_ops = {
-	.pfaf_mbox_intr_handler = cn20k_pfaf_mbox_intr_handler,
-	.vfaf_mbox_intr_handler = cn20k_vfaf_mbox_intr_handler,
-	.pfvf_mbox_intr_handler = cn20k_pfvf_mbox_intr_handler,
-};
-
-void cn20k_init(struct otx2_nic *pfvf)
-{
-	pfvf->hw_ops = &cn20k_hw_ops;
-}
-EXPORT_SYMBOL(cn20k_init);
 /* CN20K mbox AF => PFx irq handler */
 irqreturn_t cn20k_pfaf_mbox_intr_handler(int irq, void *pf_irq)
 {
@@ -250,3 +239,170 @@ int cn20k_register_pfvf_mbox_intr(struct otx2_nic *pf, int numvfs)
 
 	return 0;
 }
+
+#define RQ_BP_LVL_AURA   (255 - ((85 * 256) / 100)) /* BP when 85% is full */
+
+static int cn20k_aura_aq_init(struct otx2_nic *pfvf, int aura_id,
+			      int pool_id, int numptrs)
+{
+	struct npa_cn20k_aq_enq_req *aq;
+	struct otx2_pool *pool;
+	int err;
+
+	pool = &pfvf->qset.pool[pool_id];
+
+	/* Allocate memory for HW to update Aura count.
+	 * Alloc one cache line, so that it fits all FC_STYPE modes.
+	 */
+	if (!pool->fc_addr) {
+		err = qmem_alloc(pfvf->dev, &pool->fc_addr, 1, OTX2_ALIGN);
+		if (err)
+			return err;
+	}
+
+	/* Initialize this aura's context via AF */
+	aq = otx2_mbox_alloc_msg_npa_cn20k_aq_enq(&pfvf->mbox);
+	if (!aq) {
+		/* Shared mbox memory buffer is full, flush it and retry */
+		err = otx2_sync_mbox_msg(&pfvf->mbox);
+		if (err)
+			return err;
+		aq = otx2_mbox_alloc_msg_npa_cn20k_aq_enq(&pfvf->mbox);
+		if (!aq)
+			return -ENOMEM;
+	}
+
+	aq->aura_id = aura_id;
+
+	/* Will be filled by AF with correct pool context address */
+	aq->aura.pool_addr = pool_id;
+	aq->aura.pool_caching = 1;
+	aq->aura.shift = ilog2(numptrs) - 8;
+	aq->aura.count = numptrs;
+	aq->aura.limit = numptrs;
+	aq->aura.avg_level = 255;
+	aq->aura.ena = 1;
+	aq->aura.fc_ena = 1;
+	aq->aura.fc_addr = pool->fc_addr->iova;
+	aq->aura.fc_hyst_bits = 0; /* Store count on all updates */
+
+	/* Enable backpressure for RQ aura */
+	if (aura_id < pfvf->hw.rqpool_cnt && !is_otx2_lbkvf(pfvf->pdev)) {
+		aq->aura.bp_ena = 0;
+		/* If NIX1 LF is attached then specify NIX1_RX.
+		 *
+		 * Below NPA_AURA_S[BP_ENA] is set according to the
+		 * NPA_BPINTF_E enumeration given as:
+		 * 0x0 + a*0x1 where 'a' is 0 for NIX0_RX and 1 for NIX1_RX so
+		 * NIX0_RX is 0x0 + 0*0x1 = 0
+		 * NIX1_RX is 0x0 + 1*0x1 = 1
+		 * But in HRM it is given that
+		 * "NPA_AURA_S[BP_ENA](w1[33:32]) - Enable aura backpressure to
+		 * NIX-RX based on [BP] level. One bit per NIX-RX; index
+		 * enumerated by NPA_BPINTF_E."
+		 */
+		if (pfvf->nix_blkaddr == BLKADDR_NIX1)
+			aq->aura.bp_ena = 1;
+#ifdef CONFIG_DCB
+		aq->aura.bpid = pfvf->bpid[pfvf->queue_to_pfc_map[aura_id]];
+#else
+		aq->aura.bpid = pfvf->bpid[0];
+#endif
+
+		/* Set backpressure level for RQ's Aura */
+		aq->aura.bp = RQ_BP_LVL_AURA;
+	}
+
+	/* Fill AQ info */
+	aq->ctype = NPA_AQ_CTYPE_AURA;
+	aq->op = NPA_AQ_INSTOP_INIT;
+
+	return 0;
+}
+
+static int cn20k_pool_aq_init(struct otx2_nic *pfvf, u16 pool_id,
+			      int stack_pages, int numptrs, int buf_size,
+			      int type)
+{
+	struct page_pool_params pp_params = { 0 };
+	struct npa_cn20k_aq_enq_req *aq;
+	struct otx2_pool *pool;
+	int err, sz;
+
+	pool = &pfvf->qset.pool[pool_id];
+	/* Alloc memory for stack which is used to store buffer pointers */
+	err = qmem_alloc(pfvf->dev, &pool->stack,
+			 stack_pages, pfvf->hw.stack_pg_bytes);
+	if (err)
+		return err;
+
+	pool->rbsize = buf_size;
+
+	/* Initialize this pool's context via AF */
+	aq = otx2_mbox_alloc_msg_npa_cn20k_aq_enq(&pfvf->mbox);
+	if (!aq) {
+		/* Shared mbox memory buffer is full, flush it and retry */
+		err = otx2_sync_mbox_msg(&pfvf->mbox);
+		if (err) {
+			qmem_free(pfvf->dev, pool->stack);
+			return err;
+		}
+		aq = otx2_mbox_alloc_msg_npa_cn20k_aq_enq(&pfvf->mbox);
+		if (!aq) {
+			qmem_free(pfvf->dev, pool->stack);
+			return -ENOMEM;
+		}
+	}
+
+	aq->aura_id = pool_id;
+	aq->pool.stack_base = pool->stack->iova;
+	aq->pool.stack_caching = 1;
+	aq->pool.ena = 1;
+	aq->pool.buf_size = buf_size / 128;
+	aq->pool.stack_max_pages = stack_pages;
+	aq->pool.shift = ilog2(numptrs) - 8;
+	aq->pool.ptr_start = 0;
+	aq->pool.ptr_end = ~0ULL;
+
+	/* Fill AQ info */
+	aq->ctype = NPA_AQ_CTYPE_POOL;
+	aq->op = NPA_AQ_INSTOP_INIT;
+
+	if (type != AURA_NIX_RQ) {
+		pool->page_pool = NULL;
+		return 0;
+	}
+
+	sz = ALIGN(ALIGN(SKB_DATA_ALIGN(buf_size), OTX2_ALIGN), PAGE_SIZE);
+	pp_params.order = (sz / PAGE_SIZE) - 1;
+	pp_params.flags = PP_FLAG_DMA_MAP;
+	pp_params.pool_size = min(OTX2_PAGE_POOL_SZ, numptrs);
+	pp_params.nid = NUMA_NO_NODE;
+	pp_params.dev = pfvf->dev;
+	pp_params.dma_dir = DMA_FROM_DEVICE;
+	pool->page_pool = page_pool_create(&pp_params);
+	if (IS_ERR(pool->page_pool)) {
+		netdev_err(pfvf->netdev, "Creation of page pool failed\n");
+		return PTR_ERR(pool->page_pool);
+	}
+
+	return 0;
+}
+
+static struct dev_hw_ops cn20k_hw_ops = {
+	.pfaf_mbox_intr_handler = cn20k_pfaf_mbox_intr_handler,
+	.vfaf_mbox_intr_handler = cn20k_vfaf_mbox_intr_handler,
+	.pfvf_mbox_intr_handler = cn20k_pfvf_mbox_intr_handler,
+	.sq_aq_init = cn10k_sq_aq_init,
+	.sqe_flush = cn10k_sqe_flush,
+	.aura_freeptr = cn10k_aura_freeptr,
+	.refill_pool_ptrs = cn10k_refill_pool_ptrs,
+	.aura_aq_init = cn20k_aura_aq_init,
+	.pool_aq_init = cn20k_pool_aq_init,
+};
+
+void cn20k_init(struct otx2_nic *pfvf)
+{
+	pfvf->hw_ops = &cn20k_hw_ops;
+}
+EXPORT_SYMBOL(cn20k_init);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index f674729124e6..ad57ded39bd1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -1366,6 +1366,13 @@ void otx2_aura_pool_free(struct otx2_nic *pfvf)
 
 int otx2_aura_init(struct otx2_nic *pfvf, int aura_id,
 		   int pool_id, int numptrs)
+{
+	return pfvf->hw_ops->aura_aq_init(pfvf, aura_id, pool_id,
+					  numptrs);
+}
+
+int otx2_aura_aq_init(struct otx2_nic *pfvf, int aura_id,
+		      int pool_id, int numptrs)
 {
 	struct npa_aq_enq_req *aq;
 	struct otx2_pool *pool;
@@ -1443,6 +1450,13 @@ int otx2_aura_init(struct otx2_nic *pfvf, int aura_id,
 
 int otx2_pool_init(struct otx2_nic *pfvf, u16 pool_id,
 		   int stack_pages, int numptrs, int buf_size, int type)
+{
+	return pfvf->hw_ops->pool_aq_init(pfvf, pool_id, stack_pages, numptrs,
+					  buf_size, type);
+}
+
+int otx2_pool_aq_init(struct otx2_nic *pfvf, u16 pool_id,
+		      int stack_pages, int numptrs, int buf_size, int type)
 {
 	struct page_pool_params pp_params = { 0 };
 	struct xsk_buff_pool *xsk_pool;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index e3765b73c434..b587ff931820 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -14,6 +14,7 @@
 #include <linux/net_tstamp.h>
 #include <linux/ptp_clock_kernel.h>
 #include <linux/timecounter.h>
+#include <linux/soc/marvell/silicons.h>
 #include <linux/soc/marvell/octeontx2/asm.h>
 #include <net/macsec.h>
 #include <net/pkt_cls.h>
@@ -374,6 +375,11 @@ struct dev_hw_ops {
 	irqreturn_t (*pfaf_mbox_intr_handler)(int irq, void *pf_irq);
 	irqreturn_t (*vfaf_mbox_intr_handler)(int irq, void *pf_irq);
 	irqreturn_t (*pfvf_mbox_intr_handler)(int irq, void *pf_irq);
+	int	(*aura_aq_init)(struct otx2_nic *pfvf, int aura_id,
+				int pool_id, int numptrs);
+	int	(*pool_aq_init)(struct otx2_nic *pfvf, u16 pool_id,
+				int stack_pages, int numptrs, int buf_size,
+				int type);
 };
 
 #define CN10K_MCS_SA_PER_SC	4
@@ -1058,6 +1064,10 @@ irqreturn_t otx2_cq_intr_handler(int irq, void *cq_irq);
 int otx2_rq_init(struct otx2_nic *pfvf, u16 qidx, u16 lpb_aura);
 int otx2_cq_init(struct otx2_nic *pfvf, u16 qidx);
 int otx2_set_hw_capabilities(struct otx2_nic *pfvf);
+int otx2_aura_aq_init(struct otx2_nic *pfvf, int aura_id,
+		      int pool_id, int numptrs);
+int otx2_pool_aq_init(struct otx2_nic *pfvf, u16 pool_id,
+		      int stack_pages, int numptrs, int buf_size, int type);
 
 /* RSS configuration APIs*/
 int otx2_rss_init(struct otx2_nic *pfvf);
-- 
2.34.1


