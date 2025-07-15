Return-Path: <netdev+bounces-207225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34758B064D4
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 19:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A2534E6B94
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 17:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9688727A455;
	Tue, 15 Jul 2025 17:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="aPC/dmZZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B704427381D
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 17:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752598985; cv=none; b=B5dFTnIe3I5VJC7iQKQt2DkNrx+YXhgdev9pQ7eqbCkTJDeeC+9InqjMuXv5hdR4pJUQrig9bq8oqkfDLT7rafCHX3Wd9+ho8HISTNIanMkLGe2/DM0RxeCywLaKtCLO4XrEh5nfcYigFr1VzD9y0jPEV9skhvQJPdAgUCkJJ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752598985; c=relaxed/simple;
	bh=ABDGueaEDGVAhgwzPSv1So1IS+Qn2x3B9eo/fjNOQtM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JLW96AV94rYDaihWC0BSixoqpqmW5FvBg+OotkXQSHJFPcVA8MzDaR2KDlPwx3EMtxRFzCQfY0hK4azlkyLueaDJ62u5uXhp5sEtZQOkYn+PLHJHa/XfdBafiFfFaqpFrNySU57/Fc3mBkphpIQUq7lreomol+H/KU4lNGNzvAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=aPC/dmZZ reason="signature verification failed"; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FGUoLr019299;
	Tue, 15 Jul 2025 10:02:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=nZw5aXeJQ8FflwN3AZiUFj3gY
	TUIsySCc37HvxCarTM=; b=aPC/dmZZk/jIlZfPwUuudWozbL7GgGvMqc+ytJbY1
	k4WpJXQLSR6R24eGAeQ29axk55EE9qaNFBU0R7ihcbjRTEMz7KhORYW8MuSn7OtB
	7qqt+4WnPAvdFEf+QmvImuNGCTVvMpscWDf4RIlUYJrsefC0lP083N9th//6lMQt
	ISXRCbBvVQpM5rjX3bK2byFsdhq8mFTx+VyIlgJRPmuKVVtfK86PfKebg7LFh7qW
	mjOMUZ/K014JFORc/DXjxTyjPqd/o5PWNKfllfnqwiw0ryXNoRwhq8MLKId9zdgt
	zaodaJ2qskrDGG8a3UdTz3e1X4RSWut6BZLBBfeF07PGA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47wajmtcam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 10:02:54 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 15 Jul 2025 10:02:53 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 15 Jul 2025 10:02:52 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 8DD2F5B692F;
	Tue, 15 Jul 2025 10:02:48 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, pabeni4redhat.com@mx0a-0016f401.pphosted.com,
        <horms@kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>,
        <jerinj@marvell.com>, <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH v2 07/11] octeontx2-pf: Initialize cn20k specific aura and pool contexts
Date: Tue, 15 Jul 2025 22:32:00 +0530
Message-ID: <1752598924-32705-8-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1752598924-32705-1-git-send-email-sbhatta@marvell.com>
References: <1752598924-32705-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE1NiBTYWx0ZWRfXwDafLAbJSIaj neyPasRG6I79zmssCB/3PSoM3G4Govqc27P45LXDPpzWWxyR2yV3w6VXi8AhOjtXeHz/WWPhxLH j7rpnsPiLnhuDaQFE1+/08OzhZ3LnlfeUpM91jJk9SniZA3GdTZmMgy6/Q+4OrpLqJvk4HCwiBs
 wrnF08KhLp/TVORXCh6BwJm3U0rmR8HM9tP6lzqd4Jtm3UU4jR6bxK+xG0jlqKq5Wbw4BPWMPuy IM50tfCVNFjgpadCLOf6WWLdD02J6O1EV1XF7v1GEK1zH2PTMR2vkuFrJkyPcMzlM+SHSLcqyMl Ziu5k3iFK9xX0IMTk5fqVcFjvTUk23YZKOsGvs8OFLcdqleKUI5G8QPVcJIDKmFc3oUVI+aWHXR
 5Xafn2gWgAnnjzFmQEqLjto+XnDIrVfpIamAIPDKaoEBKfXQ8Iwwn84PrhG7Kt/FuAAwXtlS
X-Proofpoint-GUID: 6PaYhFzSirFyIWdWJrQxdfku90L6C9SA
X-Authority-Analysis: v=2.4 cv=W+c4VQWk c=1 sm=1 tr=0 ts=687689be cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=o_oeuxXBfXPkz0o_jD8A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 6PaYhFzSirFyIWdWJrQxdfku90L6C9SA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_02,2025-03-28_01

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


