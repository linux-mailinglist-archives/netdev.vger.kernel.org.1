Return-Path: <netdev+bounces-96315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 902058C4F27
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 12:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD0461C20AF9
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 10:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A5213BAD4;
	Tue, 14 May 2024 09:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="gSDRA8DY"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44E057880;
	Tue, 14 May 2024 09:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715680497; cv=none; b=tHz78HGsgbcrvgdsNZFvUdbfInFGBA6wH1hQ7HDWzbQ4GV0AXOAfm22FsTb1D49srP5aZRfDuprKI1rNbZZryuU4VabWTHHPZY7G4Fai+KJSATAb3L8d0JhfkVnqW1oz1q29HK0ctC/LV08hn3gNUTCk1fRaXyVJGnbIdnxurK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715680497; c=relaxed/simple;
	bh=SWU9eJGp0nDkHzecYnWsEm41vVuSGEFjPjd5CGO8zmo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YFBZABi94QHESYE/ZcBqMVDcEhPdu/WH+r0WBsJbHsH7pebRg0xwiAVz+8lYYnpTx/L/amvon6reHGLxYzN+N8SZ7pnKWM449ZUA7M1tcCG93BkndgICcKlyC5KZWwACpEaAaqplnPTzaJNrIny9Jyr3lDICm07M2BSr5hpCQfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=gSDRA8DY; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44DM2R6M015103;
	Tue, 14 May 2024 02:54:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=BmoaEoZr
	iG5C6dHKm1JyIh4FH5w8ZIONptAD6Tr7ln8=; b=gSDRA8DYB8qZwgv1du9zOdXZ
	NuJgvYewZyzCDsejlaoGWxWiPBqZPz6e15YZC3q2LCWUrGLHsOApv5XeMmXCajSN
	ly5kuc0nJKmhg6V4eIDbTkDYB0QHqiTeazNsmqNBxmFPA2TFCcsHMddB5+Nms+vP
	nVpUJkHZEjGUVjnraa5o1v33nyqTRkw2idmzoWv5uq3XvySVul25w5o3IRoIniE/
	upb8++JEQhWnhpGph79ICNIDDtEbOBfLIvq58y/aLMWMKYN8qVaVueY0SNibCsxK
	cQW23hUKXnHhN7DpisdSY+C9aBvl1Gsxsd3GsluZQnYSxSVQn5YUA27PcOZVzA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3y3gf4kscy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 02:54:44 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 14 May 2024 02:54:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 14 May 2024 02:54:42 -0700
Received: from #hyd1583.marvell.com (unknown [10.29.37.44])
	by maili.marvell.com (Postfix) with ESMTP id BAD9F3F708F;
	Tue, 14 May 2024 02:54:38 -0700 (PDT)
From: Anshumali Gaur <agaur@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Anshumali Gaur <agaur@marvell.com>, Sunil Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>
Subject: [PATCH] octeontx2-af: Add debugfs support to dump NIX TM topology
Date: Tue, 14 May 2024 15:24:34 +0530
Message-ID: <20240514095434.31445-1-agaur@marvell.com>
X-Mailer: git-send-email 2.39.0.198.ga38d39a4c5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: KifXrx7ys_Hta-DXGU31rWEGL3yZCfeM
X-Proofpoint-GUID: KifXrx7ys_Hta-DXGU31rWEGL3yZCfeM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_04,2024-05-10_02,2023-05-22_02

This patch adds support to dump NIX transmit queue topology.
There are multiple levels of scheduling/shaping supported by
NIX and a packet traverses through multiple levels before sending
the packet out. At each level, there are set of scheduling/shaping
rules applied to a packet flow.

Each packet traverses through multiple levels
SQ->SMQ->Tl4->Tl3->TL2->Tl1 and these levels are mapped in a parent-child
relationship.

This patch dumps the debug information related to all TM Levels in
the following way.

Example:
$ echo <nixlf> > /sys/kernel/debug/octeontx2/nix/tm_tree
$ cat /sys/kernel/debug/octeontx2/nix/tm_tree

A more desriptive set of registers at each level can be dumped
in the following way.

Example:
$ echo <nixlf> > /sys/kernel/debug/octeontx2/nix/tm_topo
$ cat /sys/kernel/debug/octeontx2/nix/tm_topo

Signed-off-by: Anshumali Gaur <agaur@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   1 +
 .../marvell/octeontx2/af/rvu_debugfs.c        | 370 ++++++++++++++++++
 .../ethernet/marvell/octeontx2/af/rvu_reg.h   |   7 +
 3 files changed, 378 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 35834687e40f..3063a84a45ef 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -76,6 +76,7 @@ struct rvu_debugfs {
 	struct dump_ctx nix_cq_ctx;
 	struct dump_ctx nix_rq_ctx;
 	struct dump_ctx nix_sq_ctx;
+	struct dump_ctx nix_tm_ctx;
 	struct cpt_ctx cpt_ctx[MAX_CPT_BLKS];
 	int npa_qsize_id;
 	int nix_qsize_id;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 881d704644fb..2f9bf5ec46d4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -1603,6 +1603,372 @@ static void print_nix_cn10k_sq_ctx(struct seq_file *m,
 		   (u64)sq_ctx->dropped_pkts);
 }
 
+static void print_tm_tree(struct seq_file *m,
+			  struct nix_aq_enq_rsp *rsp, u64 sq)
+{
+	struct nix_sq_ctx_s *sq_ctx = &rsp->sq;
+	struct nix_hw *nix_hw = m->private;
+	struct rvu *rvu = nix_hw->rvu;
+	u16 p1, p2, p3, p4, schq;
+	int blkaddr;
+	u64 cfg;
+
+	blkaddr = nix_hw->blkaddr;
+	schq = sq_ctx->smq;
+
+	cfg = rvu_read64(rvu, blkaddr, NIX_AF_MDQX_PARENT(schq));
+	p1 = FIELD_GET(NIX_AF_MDQ_PARENT_MASK, cfg);
+
+	cfg = rvu_read64(rvu, blkaddr, NIX_AF_TL4X_PARENT(p1));
+	p2 = FIELD_GET(NIX_AF_TL4_PARENT_MASK, cfg);
+
+	cfg = rvu_read64(rvu, blkaddr, NIX_AF_TL3X_PARENT(p2));
+	p3 = FIELD_GET(NIX_AF_TL3_PARENT_MASK, cfg);
+
+	cfg = rvu_read64(rvu, blkaddr, NIX_AF_TL2X_PARENT(p3));
+	p4 = FIELD_GET(NIX_AF_TL2_PARENT_MASK, cfg);
+	seq_printf(m,
+		   "SQ(%llu) -> SMQ(%u) -> TL4(%u) -> TL3(%u) -> TL2(%u) -> TL1(%u)\n",
+		   sq, schq, p1, p2, p3, p4);
+}
+
+/*dumps given tm_tree registers*/
+static int rvu_dbg_nix_tm_tree_display(struct seq_file *m, void *unused)
+{
+	int qidx, nixlf, rc, id, max_id = 0;
+	struct nix_hw *nix_hw = m->private;
+	struct rvu *rvu = nix_hw->rvu;
+	struct nix_aq_enq_req aq_req;
+	struct nix_aq_enq_rsp rsp;
+	struct rvu_pfvf *pfvf;
+	u16 pcifunc;
+
+	nixlf = rvu->rvu_dbg.nix_tm_ctx.lf;
+	id = rvu->rvu_dbg.nix_tm_ctx.id;
+
+	if (!rvu_dbg_is_valid_lf(rvu, nix_hw->blkaddr, nixlf, &pcifunc))
+		return -EINVAL;
+
+	pfvf = rvu_get_pfvf(rvu, pcifunc);
+	max_id = pfvf->sq_ctx->qsize;
+
+	memset(&aq_req, 0, sizeof(struct nix_aq_enq_req));
+	aq_req.hdr.pcifunc = pcifunc;
+	aq_req.ctype = NIX_AQ_CTYPE_SQ;
+	aq_req.op = NIX_AQ_INSTOP_READ;
+	seq_printf(m, "pcifunc is 0x%x\n", pcifunc);
+	for (qidx = id; qidx < max_id; qidx++) {
+		aq_req.qidx = qidx;
+		rc = rvu_mbox_handler_nix_aq_enq(rvu, &aq_req, &rsp);
+
+			/* Skip SQ's if not initialized */
+			if (!test_bit(qidx, pfvf->sq_bmap))
+				continue;
+
+		if (rc) {
+			seq_printf(m, "Failed to read SQ(%d) context\n",
+				   aq_req.qidx);
+			continue;
+		}
+		print_tm_tree(m, &rsp, aq_req.qidx);
+	}
+	return 0;
+}
+
+static ssize_t rvu_dbg_nix_tm_tree_write(struct file *filp,
+					 const char __user *buffer,
+					 size_t count, loff_t *ppos)
+{
+	struct seq_file *m = filp->private_data;
+	struct nix_hw *nix_hw = m->private;
+	struct rvu *rvu = nix_hw->rvu;
+	struct rvu_pfvf *pfvf;
+	u16 pcifunc;
+	u64 nixlf;
+	int ret;
+
+	ret = kstrtoull_from_user(buffer, count, 10, &nixlf);
+	if (ret)
+		return ret;
+
+	if (!rvu_dbg_is_valid_lf(rvu, nix_hw->blkaddr, nixlf, &pcifunc)) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	pfvf = rvu_get_pfvf(rvu, pcifunc);
+	if (!pfvf->sq_ctx) {
+		dev_warn(rvu->dev, "SQ context is not initialized\n");
+		ret = -EINVAL;
+		goto done;
+	}
+	rvu->rvu_dbg.nix_tm_ctx.lf = nixlf;
+done:
+	return ret ? ret : count;
+}
+
+RVU_DEBUG_SEQ_FOPS(nix_tm_tree, nix_tm_tree_display, nix_tm_tree_write);
+
+static void print_tm_topo(struct seq_file *m, u64 schq, u32 lvl)
+{
+	struct nix_hw *nix_hw = m->private;
+	struct rvu *rvu = nix_hw->rvu;
+	int blkaddr, link, link_level;
+	struct rvu_hwinfo *hw;
+
+	hw = rvu->hw;
+	blkaddr = nix_hw->blkaddr;
+	if (lvl == NIX_TXSCH_LVL_MDQ) {
+		seq_printf(m, "NIX_AF_SMQ[%llu]_CFG =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr, NIX_AF_SMQX_CFG(schq)));
+		seq_printf(m, "NIX_AF_SMQ[%llu]_STATUS =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr, NIX_AF_SMQX_STATUS(schq)));
+		seq_printf(m, "NIX_AF_MDQ[%llu]_OUT_MD_COUNT =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr,
+				      NIX_AF_MDQX_OUT_MD_COUNT(schq)));
+		seq_printf(m, "NIX_AF_MDQ[%llu]_SCHEDULE =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr,
+				      NIX_AF_MDQX_SCHEDULE(schq)));
+		seq_printf(m, "NIX_AF_MDQ[%llu]_SHAPE =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr, NIX_AF_MDQX_SHAPE(schq)));
+		seq_printf(m, "NIX_AF_MDQ[%llu]_CIR =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr, NIX_AF_MDQX_CIR(schq)));
+		seq_printf(m, "NIX_AF_MDQ[%llu]_PIR =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr, NIX_AF_MDQX_PIR(schq)));
+		seq_printf(m, "NIX_AF_MDQ[%llu]_SW_XOFF =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr, NIX_AF_MDQX_SW_XOFF(schq)));
+		seq_printf(m, "NIX_AF_MDQ[%llu]_PARENT =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr, NIX_AF_MDQX_PARENT(schq)));
+		seq_puts(m, "\n");
+	}
+
+	if (lvl == NIX_TXSCH_LVL_TL4) {
+		seq_printf(m, "NIX_AF_TL4[%llu]_SDP_LINK_CFG =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr,
+				      NIX_AF_TL4X_SDP_LINK_CFG(schq)));
+		seq_printf(m, "NIX_AF_TL4[%llu]_SCHEDULE =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr,
+				      NIX_AF_TL4X_SCHEDULE(schq)));
+		seq_printf(m, "NIX_AF_TL4[%llu]_SHAPE =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr, NIX_AF_TL4X_SHAPE(schq)));
+		seq_printf(m, "NIX_AF_TL4[%llu]_CIR =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr, NIX_AF_TL4X_CIR(schq)));
+		seq_printf(m, "NIX_AF_TL4[%llu]_PIR =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr, NIX_AF_TL4X_PIR(schq)));
+		seq_printf(m, "NIX_AF_TL4[%llu]_SW_XOFF =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr, NIX_AF_TL4X_SW_XOFF(schq)));
+		seq_printf(m, "NIX_AF_TL4[%llu]_TOPOLOGY =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr,
+				      NIX_AF_TL4X_TOPOLOGY(schq)));
+		seq_printf(m, "NIX_AF_TL4[%llu]_PARENT =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr, NIX_AF_TL4X_PARENT(schq)));
+		seq_printf(m, "NIX_AF_TL4[%llu]_MD_DEBUG0 =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr,
+				      NIX_AF_TL4X_MD_DEBUG0(schq)));
+		seq_printf(m, "NIX_AF_TL4[%llu]_MD_DEBUG1 =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr,
+				      NIX_AF_TL4X_MD_DEBUG1(schq)));
+		seq_puts(m, "\n");
+	}
+
+	if (lvl == NIX_TXSCH_LVL_TL3) {
+		seq_printf(m, "NIX_AF_TL3[%llu]_SCHEDULE =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr,
+				      NIX_AF_TL3X_SCHEDULE(schq)));
+		seq_printf(m, "NIX_AF_TL3[%llu]_SHAPE =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr, NIX_AF_TL3X_SHAPE(schq)));
+		seq_printf(m, "NIX_AF_TL3[%llu]_CIR =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr, NIX_AF_TL3X_CIR(schq)));
+		seq_printf(m, "NIX_AF_TL3[%llu]_PIR =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr, NIX_AF_TL3X_PIR(schq)));
+		seq_printf(m, "NIX_AF_TL3[%llu]_SW_XOFF =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr, NIX_AF_TL3X_SW_XOFF(schq)));
+		seq_printf(m, "NIX_AF_TL3[%llu]_TOPOLOGY =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr,
+				      NIX_AF_TL3X_TOPOLOGY(schq)));
+		seq_printf(m, "NIX_AF_TL3[%llu]_PARENT =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr, NIX_AF_TL3X_PARENT(schq)));
+		seq_printf(m, "NIX_AF_TL3[%llu]_MD_DEBUG0 =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr,
+				      NIX_AF_TL3X_MD_DEBUG0(schq)));
+		seq_printf(m, "NIX_AF_TL3[%llu]_MD_DEBUG1 =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr,
+				      NIX_AF_TL3X_MD_DEBUG1(schq)));
+
+		link_level = rvu_read64(rvu, blkaddr, NIX_AF_PSE_CHANNEL_LEVEL)
+				& 0x01 ? NIX_TXSCH_LVL_TL3 : NIX_TXSCH_LVL_TL2;
+		if (lvl == link_level) {
+			seq_printf(m,
+				   "NIX_AF_TL3_TL2[%llu]_BP_STATUS =0x%llx\n",
+				   schq, rvu_read64(rvu, blkaddr,
+				   NIX_AF_TL3_TL2X_BP_STATUS(schq)));
+			for (link = 0; link < hw->cgx_links; link++)
+				seq_printf(m,
+					   "NIX_AF_TL3_TL2[%llu]_LINK[%d]_CFG =0x%llx\n",
+					   schq, link,
+					   rvu_read64(rvu, blkaddr,
+						      NIX_AF_TL3_TL2X_LINKX_CFG(schq, link)));
+		}
+		seq_puts(m, "\n");
+	}
+
+	if (lvl == NIX_TXSCH_LVL_TL2) {
+		seq_printf(m, "NIX_AF_TL2[%llu]_SHAPE =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr, NIX_AF_TL2X_SHAPE(schq)));
+		seq_printf(m, "NIX_AF_TL2[%llu]_CIR =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr, NIX_AF_TL2X_CIR(schq)));
+		seq_printf(m, "NIX_AF_TL2[%llu]_PIR =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr, NIX_AF_TL2X_PIR(schq)));
+		seq_printf(m, "NIX_AF_TL2[%llu]_SW_XOFF =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr, NIX_AF_TL2X_SW_XOFF(schq)));
+		seq_printf(m, "NIX_AF_TL2[%llu]_TOPOLOGY =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr,
+				      NIX_AF_TL2X_TOPOLOGY(schq)));
+		seq_printf(m, "NIX_AF_TL2[%llu]_PARENT =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr, NIX_AF_TL2X_PARENT(schq)));
+		seq_printf(m, "NIX_AF_TL2[%llu]_MD_DEBUG0 =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr,
+				      NIX_AF_TL2X_MD_DEBUG0(schq)));
+		seq_printf(m, "NIX_AF_TL2[%llu]_MD_DEBUG1 =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr,
+				      NIX_AF_TL2X_MD_DEBUG1(schq)));
+
+		link_level = rvu_read64(rvu, blkaddr, NIX_AF_PSE_CHANNEL_LEVEL)
+				& 0x01 ? NIX_TXSCH_LVL_TL3 : NIX_TXSCH_LVL_TL2;
+		if (lvl == link_level) {
+			seq_printf(m,
+				   "NIX_AF_TL3_TL2[%llu]_BP_STATUS =0x%llx\n",
+				   schq, rvu_read64(rvu, blkaddr,
+				   NIX_AF_TL3_TL2X_BP_STATUS(schq)));
+			for (link = 0; link < hw->cgx_links; link++)
+				seq_printf(m,
+					   "NIX_AF_TL3_TL2[%llu]_LINK[%d]_CFG =0x%llx\n",
+					   schq, link, rvu_read64(rvu, blkaddr,
+					   NIX_AF_TL3_TL2X_LINKX_CFG(schq, link)));
+		}
+		seq_puts(m, "\n");
+	}
+
+	if (lvl == NIX_TXSCH_LVL_TL1) {
+		seq_printf(m, "NIX_AF_TX_LINK[%llu]_NORM_CREDIT =0x%llx\n",
+			   schq,
+			   rvu_read64(rvu, blkaddr,
+				      NIX_AF_TX_LINKX_NORM_CREDIT(schq)));
+		seq_printf(m, "NIX_AF_TX_LINK[%llu]_HW_XOFF =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr,
+				      NIX_AF_TX_LINKX_HW_XOFF(schq)));
+		seq_printf(m, "NIX_AF_TL1[%llu]_SCHEDULE =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr,
+				      NIX_AF_TL1X_SCHEDULE(schq)));
+		seq_printf(m, "NIX_AF_TL1[%llu]_SHAPE =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr, NIX_AF_TL1X_SHAPE(schq)));
+		seq_printf(m, "NIX_AF_TL1[%llu]_CIR =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr, NIX_AF_TL1X_CIR(schq)));
+		seq_printf(m, "NIX_AF_TL1[%llu]_SW_XOFF =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr, NIX_AF_TL1X_SW_XOFF(schq)));
+		seq_printf(m, "NIX_AF_TL1[%llu]_TOPOLOGY =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr,
+				      NIX_AF_TL1X_TOPOLOGY(schq)));
+		seq_printf(m, "NIX_AF_TL1[%llu]_MD_DEBUG0 =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr,
+				      NIX_AF_TL1X_MD_DEBUG0(schq)));
+		seq_printf(m, "NIX_AF_TL1[%llu]_MD_DEBUG1 =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr,
+				      NIX_AF_TL1X_MD_DEBUG1(schq)));
+		seq_printf(m, "NIX_AF_TL1[%llu]_DROPPED_PACKETS =0x%llx\n",
+			   schq,
+			   rvu_read64(rvu, blkaddr,
+				      NIX_AF_TL1X_DROPPED_PACKETS(schq)));
+		seq_printf(m, "NIX_AF_TL1[%llu]_DROPPED_BYTES =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr,
+				      NIX_AF_TL1X_DROPPED_BYTES(schq)));
+		seq_printf(m, "NIX_AF_TL1[%llu]_RED_PACKETS =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr,
+				      NIX_AF_TL1X_RED_PACKETS(schq)));
+		seq_printf(m, "NIX_AF_TL1[%llu]_RED_BYTES =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr,
+				      NIX_AF_TL1X_RED_BYTES(schq)));
+		seq_printf(m, "NIX_AF_TL1[%llu]_YELLOW_PACKETS =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr,
+				      NIX_AF_TL1X_YELLOW_PACKETS(schq)));
+		seq_printf(m, "NIX_AF_TL1[%llu]_YELLOW_BYTES =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr,
+				      NIX_AF_TL1X_YELLOW_BYTES(schq)));
+		seq_printf(m, "NIX_AF_TL1[%llu]_GREEN_PACKETS =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr,
+				      NIX_AF_TL1X_GREEN_PACKETS(schq)));
+		seq_printf(m, "NIX_AF_TL1[%llu]_GREEN_BYTES =0x%llx\n", schq,
+			   rvu_read64(rvu, blkaddr,
+				      NIX_AF_TL1X_GREEN_BYTES(schq)));
+		seq_puts(m, "\n");
+	}
+}
+
+/*dumps given tm_topo registers*/
+static int rvu_dbg_nix_tm_topo_display(struct seq_file *m, void *unused)
+{
+	struct nix_hw *nix_hw = m->private;
+	struct rvu *rvu = nix_hw->rvu;
+	struct nix_aq_enq_req aq_req;
+	struct nix_txsch *txsch;
+	int nixlf, lvl, schq;
+	u16 pcifunc;
+
+	nixlf = rvu->rvu_dbg.nix_tm_ctx.lf;
+
+	if (!rvu_dbg_is_valid_lf(rvu, nix_hw->blkaddr, nixlf, &pcifunc))
+		return -EINVAL;
+
+	memset(&aq_req, 0, sizeof(struct nix_aq_enq_req));
+	aq_req.hdr.pcifunc = pcifunc;
+	aq_req.ctype = NIX_AQ_CTYPE_SQ;
+	aq_req.op = NIX_AQ_INSTOP_READ;
+	seq_printf(m, "pcifunc is 0x%x\n", pcifunc);
+
+	for (lvl = 0; lvl < NIX_TXSCH_LVL_CNT; lvl++) {
+		txsch = &nix_hw->txsch[lvl];
+			for (schq = 0; schq < txsch->schq.max; schq++) {
+				if (TXSCH_MAP_FUNC(txsch->pfvf_map[schq]) == pcifunc)
+					print_tm_topo(m, schq, lvl);
+		}
+	}
+	return 0;
+}
+
+static ssize_t rvu_dbg_nix_tm_topo_write(struct file *filp,
+					 const char __user *buffer,
+					 size_t count, loff_t *ppos)
+{
+	struct seq_file *m = filp->private_data;
+	struct nix_hw *nix_hw = m->private;
+	struct rvu *rvu = nix_hw->rvu;
+	struct rvu_pfvf *pfvf;
+	u16 pcifunc;
+	u64 nixlf;
+	int ret;
+
+	ret = kstrtoull_from_user(buffer, count, 10, &nixlf);
+	if (ret)
+		return ret;
+
+	if (!rvu_dbg_is_valid_lf(rvu, nix_hw->blkaddr, nixlf, &pcifunc)) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	pfvf = rvu_get_pfvf(rvu, pcifunc);
+	if (!pfvf->sq_ctx) {
+		dev_warn(rvu->dev, "SQ context is not initialized\n");
+		ret = -EINVAL;
+		goto done;
+	}
+	rvu->rvu_dbg.nix_tm_ctx.lf = nixlf;
+done:
+	return ret ? ret : count;
+}
+
+RVU_DEBUG_SEQ_FOPS(nix_tm_topo, nix_tm_topo_display, nix_tm_topo_write);
+
 /* Dumps given nix_sq's context */
 static void print_nix_sq_ctx(struct seq_file *m, struct nix_aq_enq_rsp *rsp)
 {
@@ -2349,6 +2715,10 @@ static void rvu_dbg_nix_init(struct rvu *rvu, int blkaddr)
 		nix_hw = &rvu->hw->nix[1];
 	}
 
+	debugfs_create_file("tm_tree", 0600, rvu->rvu_dbg.nix, nix_hw,
+			    &rvu_dbg_nix_tm_tree_fops);
+	debugfs_create_file("tm_topo", 0600, rvu->rvu_dbg.nix, nix_hw,
+			    &rvu_dbg_nix_tm_topo_fops);
 	debugfs_create_file("sq_ctx", 0600, rvu->rvu_dbg.nix, nix_hw,
 			    &rvu_dbg_nix_sq_ctx_fops);
 	debugfs_create_file("rq_ctx", 0600, rvu->rvu_dbg.nix, nix_hw,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h
index 086f05c0376f..5ec92654e7ad 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h
@@ -429,6 +429,8 @@
 #define NIX_AF_RX_ACTIVE_CYCLES_PCX(a)	(0x4800 | (a) << 16)
 #define NIX_AF_LINKX_CFG(a)		(0x4010 | (a) << 17)
 #define NIX_AF_MDQX_IN_MD_COUNT(a)	(0x14e0 | (a) << 16)
+#define NIX_AF_SMQX_STATUS(a)		(0x730 | (a) << 16)
+#define NIX_AF_MDQX_OUT_MD_COUNT(a)	(0xdb0 | (a) << 16)
 
 #define NIX_PRIV_AF_INT_CFG		(0x8000000)
 #define NIX_PRIV_LFX_CFG		(0x8000010)
@@ -442,6 +444,11 @@
 #define NIX_CONST_MAX_BPIDS		GENMASK_ULL(23, 12)
 #define NIX_CONST_SDP_CHANS		GENMASK_ULL(11, 0)
 
+#define NIX_AF_MDQ_PARENT_MASK         GENMASK_ULL(24, 16)
+#define NIX_AF_TL4_PARENT_MASK         GENMASK_ULL(23, 16)
+#define NIX_AF_TL3_PARENT_MASK         GENMASK_ULL(23, 16)
+#define NIX_AF_TL2_PARENT_MASK         GENMASK_ULL(20, 16)
+
 /* SSO */
 #define SSO_AF_CONST			(0x1000)
 #define SSO_AF_CONST1			(0x1008)
-- 
2.39.0.198.ga38d39a4c5


