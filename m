Return-Path: <netdev+bounces-207967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89479B092D6
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 19:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FC72A46302
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFC02FD88F;
	Thu, 17 Jul 2025 17:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="lCEh4H3p"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFDD2FD582
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 17:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752772206; cv=none; b=K2m9F2XXYXPV1Nn85t2JUYIXo6QN2OaY+irCig0xHsxcyfVzBcxfe6g6I4gKIWPIpTg6YfgOULu2EDqTn57z/r/dsbwVVrlNLg1LnuUs+anvJeJ1O6dS3aPM8Rkkdc25eqPdh71wltN4YuZUVGBRzsYKTvnDtpu+p0Bp4QKMqvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752772206; c=relaxed/simple;
	bh=383e1Itj4NH4DQYoj38CFtYNTVHSEuP8k+bVqUgp1QM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nK/VNys5hLv/d1ClEIpoGrgIumfVJj6NACgW78SaFao84tUOpfk/lrw3CV5zqILLRj03E4IEB0gZNRyN2Id06RgGTiBkpyphsfXZHlxklpkdvqXlP8nD88owT2PECtrYy2W3ODBF7ZTfAvNI6gRTiNGr8f7ZzULmO4nMLVv/NOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=lCEh4H3p; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H9eP1a019899;
	Thu, 17 Jul 2025 10:09:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=CuPend5vIjNX0fG+JRDW5Fgl2
	PMssktbHAN3G8LgdkQ=; b=lCEh4H3pdQ0DT6uWdK7X5Eexyzs9gvW+ll1D42Osl
	IQ2YHdlOf3IggVRwworLHnx+tKUBu5KCVkP2o6MmNkYIR2LAVAT5QOvoyCRw3pM2
	rEBPNAzJf2j0yTpwcq9YlDIUFDrKEuVMeKFDy6nC4J3wsK3CLia1HJpCvmqqAl6Q
	U0ma/RVpDA3++4LS+UiSpkbLJqzfPTvoBOul7+lbOD4AZOQ+Wi/G+YaBjsS9lqHg
	C0skU9BOH9x2wXMryKg0XVlzjj0wC1/REBtCDOi5vAiVnXp3+P6BpNWGj8+axAYH
	6POlHlpVA5EgreUi8pAzq2pGx9pZ1kDcrIjWeiAJP7HhA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47xvpc96sf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 10:09:54 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 17 Jul 2025 10:09:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 17 Jul 2025 10:09:45 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 01B8A3F7044;
	Thu, 17 Jul 2025 10:09:40 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>,
        <jerinj@marvell.com>, <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH v3 03/11] octeontx2-af: Extend debugfs support for cn20k NIX
Date: Thu, 17 Jul 2025 22:37:35 +0530
Message-ID: <1752772063-6160-4-git-send-email-sbhatta@marvell.com>
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
X-Authority-Analysis: v=2.4 cv=U8ySDfru c=1 sm=1 tr=0 ts=68792e62 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=ZDkL3GSSROxAqMaEkRoA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: h09NWUBey51zZWp4KQAVegqPpCb0FGNW
X-Proofpoint-ORIG-GUID: h09NWUBey51zZWp4KQAVegqPpCb0FGNW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE1MiBTYWx0ZWRfX3eJbqvMBe4Ty /i0bW5WzlOfkCDfp+SwWMI7nuabH9yCuu6xjSFG+rqonuB2SuWEZifI4ChVRBmFRykoqqA78YDk Foy3bJQb1Fr+XWSj63+n94x+40yl8GQLOFUfnHyWwwG+HVZkpQJ41srQgLz7i2j68UcZn40iumI
 XH5O4LSUmoVKr9RXGH4We+eKHzLUiiD2wx2lMcVtIEcQcjDlZFl861xzeX8EPtYfhpamIO0XsWT DgN91LM+cztZDGVh9BLsfX0pDzMs3F/2QShbGxJYSAJ7RZz43yd6H3Zq/Kayy6VYyT0Jb+FEt7m CMAlncIOyQYU234a6364k9VOsQC2b/tIn6rAyt5ykWe10097OnvXq8UPvPEen+ElIjyFki9TUzp
 zmc821q27FS2nYU+7GOiuE76CM1xKZfOxMOCviOpyYTjh9ehpCjTqk97lrNodsutS317vSPE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01

Extend debugfs to display CN20K NIX send, receive and
completion queue contexts.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/Makefile    |   2 +-
 .../marvell/octeontx2/af/cn20k/debugfs.c      | 132 ++++++++++++++++++
 .../marvell/octeontx2/af/cn20k/debugfs.h      |  24 ++++
 .../marvell/octeontx2/af/rvu_debugfs.c        |  17 +++
 4 files changed, 174 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.h

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/Makefile b/drivers/net/ethernet/marvell/octeontx2/af/Makefile
index cb77b978eda5..57eeaa116116 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/Makefile
+++ b/drivers/net/ethernet/marvell/octeontx2/af/Makefile
@@ -12,4 +12,4 @@ rvu_af-y := cgx.o rvu.o rvu_cgx.o rvu_npa.o rvu_nix.o \
 		  rvu_reg.o rvu_npc.o rvu_debugfs.o ptp.o rvu_npc_fs.o \
 		  rvu_cpt.o rvu_devlink.o rpm.o rvu_cn10k.o rvu_switch.o \
 		  rvu_sdp.o rvu_npc_hash.o mcs.o mcs_rvu_if.o mcs_cnf10kb.o \
-		  rvu_rep.o cn20k/mbox_init.o cn20k/nix.o
+		  rvu_rep.o cn20k/mbox_init.o cn20k/nix.o cn20k/debugfs.o
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
new file mode 100644
index 000000000000..d39d8ea907ea
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell RVU Admin Function driver
+ *
+ * Copyright (C) 2024 Marvell.
+ *
+ */
+
+#include <linux/fs.h>
+#include <linux/debugfs.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "struct.h"
+#include "debugfs.h"
+
+void print_nix_cn20k_sq_ctx(struct seq_file *m,
+			    struct nix_cn20k_sq_ctx_s *sq_ctx)
+{
+	seq_printf(m, "W0: ena \t\t\t%d\nW0: qint_idx \t\t\t%d\n",
+		   sq_ctx->ena, sq_ctx->qint_idx);
+	seq_printf(m, "W0: substream \t\t\t0x%03x\nW0: sdp_mcast \t\t\t%d\n",
+		   sq_ctx->substream, sq_ctx->sdp_mcast);
+	seq_printf(m, "W0: cq \t\t\t\t%d\nW0: sqe_way_mask \t\t%d\n\n",
+		   sq_ctx->cq, sq_ctx->sqe_way_mask);
+
+	seq_printf(m, "W1: smq \t\t\t%d\nW1: cq_ena \t\t\t%d\nW1: xoff\t\t\t%d\n",
+		   sq_ctx->smq, sq_ctx->cq_ena, sq_ctx->xoff);
+	seq_printf(m, "W1: sso_ena \t\t\t%d\nW1: smq_rr_weight\t\t%d\n",
+		   sq_ctx->sso_ena, sq_ctx->smq_rr_weight);
+	seq_printf(m, "W1: default_chan\t\t%d\nW1: sqb_count\t\t\t%d\n\n",
+		   sq_ctx->default_chan, sq_ctx->sqb_count);
+
+	seq_printf(m, "W1: smq_rr_count_lb \t\t%d\n", sq_ctx->smq_rr_count_lb);
+	seq_printf(m, "W2: smq_rr_count_ub \t\t%d\n", sq_ctx->smq_rr_count_ub);
+	seq_printf(m, "W2: sqb_aura \t\t\t%d\nW2: sq_int \t\t\t%d\n",
+		   sq_ctx->sqb_aura, sq_ctx->sq_int);
+	seq_printf(m, "W2: sq_int_ena \t\t\t%d\nW2: sqe_stype \t\t\t%d\n",
+		   sq_ctx->sq_int_ena, sq_ctx->sqe_stype);
+
+	seq_printf(m, "W3: max_sqe_size\t\t%d\nW3: cq_limit\t\t\t%d\n",
+		   sq_ctx->max_sqe_size, sq_ctx->cq_limit);
+	seq_printf(m, "W3: lmt_dis \t\t\t%d\nW3: mnq_dis \t\t\t%d\n",
+		   sq_ctx->lmt_dis, sq_ctx->mnq_dis);
+	seq_printf(m, "W3: smq_next_sq\t\t\t%d\nW3: smq_lso_segnum\t\t%d\n",
+		   sq_ctx->smq_next_sq, sq_ctx->smq_lso_segnum);
+	seq_printf(m, "W3: tail_offset \t\t%d\nW3: smenq_offset\t\t%d\n",
+		   sq_ctx->tail_offset, sq_ctx->smenq_offset);
+	seq_printf(m, "W3: head_offset\t\t\t%d\nW3: smenq_next_sqb_vld\t\t%d\n\n",
+		   sq_ctx->head_offset, sq_ctx->smenq_next_sqb_vld);
+
+	seq_printf(m, "W3: smq_next_sq_vld\t\t%d\nW3: smq_pend\t\t\t%d\n",
+		   sq_ctx->smq_next_sq_vld, sq_ctx->smq_pend);
+	seq_printf(m, "W4: next_sqb \t\t\t%llx\n\n", sq_ctx->next_sqb);
+	seq_printf(m, "W5: tail_sqb \t\t\t%llx\n\n", sq_ctx->tail_sqb);
+	seq_printf(m, "W6: smenq_sqb \t\t\t%llx\n\n", sq_ctx->smenq_sqb);
+	seq_printf(m, "W7: smenq_next_sqb \t\t%llx\n\n",
+		   sq_ctx->smenq_next_sqb);
+
+	seq_printf(m, "W8: head_sqb\t\t\t%llx\n\n", sq_ctx->head_sqb);
+
+	seq_printf(m, "W9: vfi_lso_total\t\t%d\n", sq_ctx->vfi_lso_total);
+	seq_printf(m, "W9: vfi_lso_sizem1\t\t%d\nW9: vfi_lso_sb\t\t\t%d\n",
+		   sq_ctx->vfi_lso_sizem1, sq_ctx->vfi_lso_sb);
+	seq_printf(m, "W9: vfi_lso_mps\t\t\t%d\nW9: vfi_lso_vlan0_ins_ena\t%d\n",
+		   sq_ctx->vfi_lso_mps, sq_ctx->vfi_lso_vlan0_ins_ena);
+	seq_printf(m, "W9: vfi_lso_vlan1_ins_ena\t%d\nW9: vfi_lso_vld \t\t%d\n\n",
+		   sq_ctx->vfi_lso_vld, sq_ctx->vfi_lso_vlan1_ins_ena);
+
+	seq_printf(m, "W10: scm_lso_rem \t\t%llu\n\n",
+		   (u64)sq_ctx->scm_lso_rem);
+	seq_printf(m, "W11: octs \t\t\t%llu\n\n", (u64)sq_ctx->octs);
+	seq_printf(m, "W12: pkts \t\t\t%llu\n\n", (u64)sq_ctx->pkts);
+	seq_printf(m, "W13: aged_drop_octs \t\t\t%llu\n\n", (u64)sq_ctx->aged_drop_octs);
+	seq_printf(m, "W13: aged_drop_pkts \t\t\t%llu\n\n", (u64)sq_ctx->aged_drop_pkts);
+	seq_printf(m, "W14: dropped_octs \t\t%llu\n\n",
+		   (u64)sq_ctx->dropped_octs);
+	seq_printf(m, "W15: dropped_pkts \t\t%llu\n\n",
+		   (u64)sq_ctx->dropped_pkts);
+}
+
+void print_nix_cn20k_cq_ctx(struct seq_file *m,
+			    struct nix_cn20k_aq_enq_rsp *rsp)
+{
+	struct nix_cn20k_cq_ctx_s *cq_ctx = &rsp->cq;
+
+	seq_printf(m, "W0: base \t\t\t%llx\n\n", cq_ctx->base);
+
+	seq_printf(m, "W1: wrptr \t\t\t%llx\n", (u64)cq_ctx->wrptr);
+	seq_printf(m, "W1: avg_con \t\t\t%d\nW1: cint_idx \t\t\t%d\n",
+		   cq_ctx->avg_con, cq_ctx->cint_idx);
+	seq_printf(m, "W1: cq_err \t\t\t%d\nW1: qint_idx \t\t\t%d\n",
+		   cq_ctx->cq_err, cq_ctx->qint_idx);
+	seq_printf(m, "W1: bpid \t\t\t%d\nW1: bp_ena \t\t\t%d\n\n",
+		   cq_ctx->bpid, cq_ctx->bp_ena);
+
+	seq_printf(m, "W1: lbpid_high \t\t\t0x%03x\n", cq_ctx->lbpid_high);
+	seq_printf(m, "W1: lbpid_med \t\t\t0x%03x\n", cq_ctx->lbpid_med);
+	seq_printf(m, "W1: lbpid_low \t\t\t0x%03x\n", cq_ctx->lbpid_low);
+	seq_printf(m, "(W1: lbpid) \t\t\t0x%03x\n",
+		   cq_ctx->lbpid_high << 6 | cq_ctx->lbpid_med << 3 |
+		   cq_ctx->lbpid_low);
+	seq_printf(m, "W1: lbp_ena \t\t\t\t%d\n\n", cq_ctx->lbp_ena);
+
+	seq_printf(m, "W2: update_time \t\t%d\nW2:avg_level \t\t\t%d\n",
+		   cq_ctx->update_time, cq_ctx->avg_level);
+	seq_printf(m, "W2: head \t\t\t%d\nW2:tail \t\t\t%d\n\n",
+		   cq_ctx->head, cq_ctx->tail);
+
+	seq_printf(m, "W3: cq_err_int_ena \t\t%d\nW3:cq_err_int \t\t\t%d\n",
+		   cq_ctx->cq_err_int_ena, cq_ctx->cq_err_int);
+	seq_printf(m, "W3: qsize \t\t\t%d\nW3:stashing \t\t\t%d\n",
+		   cq_ctx->qsize, cq_ctx->stashing);
+
+	seq_printf(m, "W3: caching \t\t\t%d\n", cq_ctx->caching);
+	seq_printf(m, "W3: lbp_frac \t\t\t%d\n", cq_ctx->lbp_frac);
+	seq_printf(m, "W3: stash_thresh \t\t\t%d\n",
+		   cq_ctx->stash_thresh);
+
+	seq_printf(m, "W3: msh_valid \t\t\t%d\nW3:msh_dst \t\t\t%d\n",
+		   cq_ctx->msh_valid, cq_ctx->msh_dst);
+
+	seq_printf(m, "W3: cpt_drop_err_en \t\t\t%d\n",
+		   cq_ctx->cpt_drop_err_en);
+	seq_printf(m, "W3: ena \t\t\t%d\n",
+		   cq_ctx->ena);
+	seq_printf(m, "W3: drop_ena \t\t\t%d\nW3: drop \t\t\t%d\n",
+		   cq_ctx->drop_ena, cq_ctx->drop);
+	seq_printf(m, "W3: bp \t\t\t\t%d\n\n", cq_ctx->bp);
+
+	seq_printf(m, "W4: lbpid_ext \t\t\t\t%d\n\n", cq_ctx->lbpid_ext);
+	seq_printf(m, "W4: bpid_ext \t\t\t\t%d\n\n", cq_ctx->bpid_ext);
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.h
new file mode 100644
index 000000000000..9d3a98dc3000
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell OcteonTx2 CGX driver
+ *
+ * Copyright (C) 2024 Marvell.
+ *
+ */
+
+#ifndef DEBUFS_H
+#define DEBUFS_H
+
+#include <linux/fs.h>
+#include <linux/debugfs.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "struct.h"
+#include "../mbox.h"
+
+void print_nix_cn20k_sq_ctx(struct seq_file *m,
+			    struct nix_cn20k_sq_ctx_s *sq_ctx);
+void print_nix_cn20k_cq_ctx(struct seq_file *m,
+			    struct nix_cn20k_aq_enq_rsp *rsp);
+
+#endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 0c20642f81b9..3d7a4f923c04 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -21,6 +21,8 @@
 #include "rvu_npc_hash.h"
 #include "mcs.h"
 
+#include "cn20k/debugfs.h"
+
 #define DEBUGFS_DIR_NAME "octeontx2"
 
 enum {
@@ -1944,10 +1946,16 @@ static void print_nix_sq_ctx(struct seq_file *m, struct nix_aq_enq_rsp *rsp)
 	struct nix_hw *nix_hw = m->private;
 	struct rvu *rvu = nix_hw->rvu;
 
+	if (is_cn20k(rvu->pdev)) {
+		print_nix_cn20k_sq_ctx(m, (struct nix_cn20k_sq_ctx_s *)sq_ctx);
+		return;
+	}
+
 	if (!is_rvu_otx2(rvu)) {
 		print_nix_cn10k_sq_ctx(m, (struct nix_cn10k_sq_ctx_s *)sq_ctx);
 		return;
 	}
+
 	seq_printf(m, "W0: sqe_way_mask \t\t%d\nW0: cq \t\t\t\t%d\n",
 		   sq_ctx->sqe_way_mask, sq_ctx->cq);
 	seq_printf(m, "W0: sdp_mcast \t\t\t%d\nW0: substream \t\t\t0x%03x\n",
@@ -2160,6 +2168,11 @@ static void print_nix_cq_ctx(struct seq_file *m, struct nix_aq_enq_rsp *rsp)
 	struct nix_hw *nix_hw = m->private;
 	struct rvu *rvu = nix_hw->rvu;
 
+	if (is_cn20k(rvu->pdev)) {
+		print_nix_cn20k_cq_ctx(m, (struct nix_cn20k_aq_enq_rsp *)rsp);
+		return;
+	}
+
 	seq_printf(m, "W0: base \t\t\t%llx\n\n", cq_ctx->base);
 
 	seq_printf(m, "W1: wrptr \t\t\t%llx\n", (u64)cq_ctx->wrptr);
@@ -2189,6 +2202,7 @@ static void print_nix_cq_ctx(struct seq_file *m, struct nix_aq_enq_rsp *rsp)
 		   cq_ctx->cq_err_int_ena, cq_ctx->cq_err_int);
 	seq_printf(m, "W3: qsize \t\t\t%d\nW3:caching \t\t\t%d\n",
 		   cq_ctx->qsize, cq_ctx->caching);
+
 	seq_printf(m, "W3: substream \t\t\t0x%03x\nW3: ena \t\t\t%d\n",
 		   cq_ctx->substream, cq_ctx->ena);
 	if (!is_rvu_otx2(rvu)) {
@@ -3791,6 +3805,9 @@ static void rvu_dbg_cpt_init(struct rvu *rvu, int blkaddr)
 
 static const char *rvu_get_dbg_dir_name(struct rvu *rvu)
 {
+	if (is_cn20k(rvu->pdev))
+		return "cn20k";
+
 	if (!is_rvu_otx2(rvu))
 		return "cn10k";
 	else
-- 
2.34.1


