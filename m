Return-Path: <netdev+bounces-206435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAA9B031C3
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 17:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC73E189683D
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 15:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153A62820D6;
	Sun, 13 Jul 2025 15:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="I/wFbb+C"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA4F27A93A
	for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 15:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752420713; cv=none; b=igsJkADK2/QNu68LQ2vi0R1j6+sVOUS6nUzjwa8gJ6dOXQG90MoHZHrkfr00+aWvFlJH+uPyUKy/7vakAXPeG17fZ9yoIksslHtwCvUFX2D3+NMoAosjCgprbKQm6EdZARtnK04H+GhF9TiAcW0Bb/TIEJuGJyMWepWqDKhSUH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752420713; c=relaxed/simple;
	bh=v95XWQivcFTU97pA7EME/tmz6B+75iI2aTWTgLCxYJE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nCxKGPqfrmIcPBBUqTMZp7n6ROH9yLpqcRmD2vPhykvs9d95pETn0XHVrGqKZDiGIDmYx8i0ZgFo+gx7z6JxHz9lTcVYOCGHM/MYaOJl/oPbydmFoTseFPrmwsQrCzXJB1v5wwbSxBGQHvvP+n6BWKG54wCrZYSW/Gu9U8nKcQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=I/wFbb+C; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DEnKRO016395;
	Sun, 13 Jul 2025 08:31:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=/pxkjQnudQAoaevAb4ipBdqGj
	+rCynmcNobWSGv7uGA=; b=I/wFbb+CDfKQp6rcUsa82WmTGDZTp/lxkZMhA4wjd
	fJ/kgYuiL98RnLOBfvC8lZGkqmjjeFPlpH6mLL0lHfS89g0OyV7LvQOKmaHK9V0x
	7IjX6KbBVokLdCjBXSKik84JTebqFX8ozajcxjX8u+HNbW7fFdtE6CotK5t3lgin
	vdY6Agk5YDxBPLjQo6EbCS0dJX+qsHrx9E9JKxyg6nJ7bXynK+kNxHAFMJIw6/3t
	jqo9uz1yrhQvQEhnGSLWxiHK/TV4SHR7y0pcRVUzxyM9pb122IPsSt/HnEDNcgOd
	TqvMj++apeF0Lsg0QQaNvSwMIMxfl+tjmdbdsGuB9Khzw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47v1dpgvcn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Jul 2025 08:31:43 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 13 Jul 2025 08:31:41 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 13 Jul 2025 08:31:41 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 71BF45B6941;
	Sun, 13 Jul 2025 08:31:38 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>,
        <jerinj@marvell.com>, <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH 05/11] octeontx2-af: Extend debugfs support for cn20k NPA
Date: Sun, 13 Jul 2025 21:01:03 +0530
Message-ID: <1752420669-2908-6-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1752420669-2908-1-git-send-email-sbhatta@marvell.com>
References: <1752420669-2908-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEzMDEwOCBTYWx0ZWRfX1iKuGOl91KVf Cr+VdkkvQYXFSXBy1CG1rBtN/o2DDGKOe8yvYd4WXOt9XQpBMfnBkHqcTxvk2z7fv1tu8UWj+xH 8kaDjjydI3RodkLJ3vDUCWESc+4oiQFX8yxUuQLhk2Tk007UJmKVMVDUK2EaDkmpUlx7Stog3Dm
 1kzxAecHDAvOZWo7iIBS9i+p3gG80luqpLmjINBX0LyA0bBQYd5PousqwZGzEfi9BmlClT2oPf0 oXZDt4fjNPf5lzdDRL26Gxv/vB1Qd2stnYiyzzDa9tOJR0ymLlRwTpZn2yCHsGdRNL0kqgcS+AH 7K4YrLSqHGkdqLrSFBNLMbX0rbR6csN+TKgCcckH8KUjVtwCzSVCXGjTDgfOM4uOJ+WkOo9popx
 kgOBs9ZiiHzkkckw2JYOmisB8c1POt2VzbarIPSuc2ZVoZJKFHTq7DPVzCF1dpDMMObueNSG
X-Authority-Analysis: v=2.4 cv=Y8j4sgeN c=1 sm=1 tr=0 ts=6873d15f cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=kt4yuNSx9aKLEnRRmMIA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: fTkEIlLkvihtW42XG34HRhR_phXP7SXX
X-Proofpoint-GUID: fTkEIlLkvihtW42XG34HRhR_phXP7SXX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-13_01,2025-07-09_01,2025-03-28_01

From: Linu Cherian <lcherian@marvell.com>

Extend debugfs to display CN20K NPA aura and pool contexts.

Signed-off-by: Linu Cherian <lcherian@marvell.com>
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 .../marvell/octeontx2/af/cn20k/debugfs.c      | 84 +++++++++++++++++++
 .../marvell/octeontx2/af/cn20k/debugfs.h      |  4 +
 .../marvell/octeontx2/af/rvu_debugfs.c        | 10 +++
 3 files changed, 98 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
index d39d8ea907ea..1a41a241bc07 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
@@ -130,3 +130,87 @@ void print_nix_cn20k_cq_ctx(struct seq_file *m,
 	seq_printf(m, "W4: lbpid_ext \t\t\t\t%d\n\n", cq_ctx->lbpid_ext);
 	seq_printf(m, "W4: bpid_ext \t\t\t\t%d\n\n", cq_ctx->bpid_ext);
 }
+
+void print_npa_cn20k_aura_ctx(struct seq_file *m,
+			      struct npa_cn20k_aq_enq_rsp *rsp)
+{
+	struct npa_cn20k_aura_s *aura = &rsp->aura;
+
+	seq_printf(m, "W0: Pool addr\t\t%llx\n", aura->pool_addr);
+
+	seq_printf(m, "W1: ena\t\t\t%d\nW1: pool caching\t%d\n",
+		   aura->ena, aura->pool_caching);
+	seq_printf(m, "W1: avg con\t\t%d\n", aura->avg_con);
+	seq_printf(m, "W1: pool drop ena\t%d\nW1: aura drop ena\t%d\n",
+		   aura->pool_drop_ena, aura->aura_drop_ena);
+	seq_printf(m, "W1: bp_ena\t\t%d\nW1: aura drop\t\t%d\n",
+		   aura->bp_ena, aura->aura_drop);
+	seq_printf(m, "W1: aura shift\t\t%d\nW1: avg_level\t\t%d\n",
+		   aura->shift, aura->avg_level);
+
+	seq_printf(m, "W2: count\t\t%llu\nW2: nix_bpid\t\t%d\n",
+		   (u64)aura->count, aura->bpid);
+
+	seq_printf(m, "W3: limit\t\t%llu\nW3: bp\t\t\t%d\nW3: fc_ena\t\t%d\n",
+		   (u64)aura->limit, aura->bp, aura->fc_ena);
+
+	seq_printf(m, "W3: fc_up_crossing\t%d\nW3: fc_stype\t\t%d\n",
+		   aura->fc_up_crossing, aura->fc_stype);
+	seq_printf(m, "W3: fc_hyst_bits\t%d\n", aura->fc_hyst_bits);
+
+	seq_printf(m, "W4: fc_addr\t\t%llx\n", aura->fc_addr);
+
+	seq_printf(m, "W5: pool_drop\t\t%d\nW5: update_time\t\t%d\n",
+		   aura->pool_drop, aura->update_time);
+	seq_printf(m, "W5: err_int \t\t%d\nW5: err_int_ena\t\t%d\n",
+		   aura->err_int, aura->err_int_ena);
+	seq_printf(m, "W5: thresh_int\t\t%d\nW5: thresh_int_ena \t%d\n",
+		   aura->thresh_int, aura->thresh_int_ena);
+	seq_printf(m, "W5: thresh_up\t\t%d\nW5: thresh_qint_idx\t%d\n",
+		   aura->thresh_up, aura->thresh_qint_idx);
+	seq_printf(m, "W5: err_qint_idx \t%d\n", aura->err_qint_idx);
+
+	seq_printf(m, "W6: thresh\t\t%llu\n", (u64)aura->thresh);
+	seq_printf(m, "W6: fc_msh_dst\t\t%d\n", aura->fc_msh_dst);
+}
+
+void print_npa_cn20k_pool_ctx(struct seq_file *m,
+			      struct npa_cn20k_aq_enq_rsp *rsp)
+{
+	struct npa_cn20k_pool_s *pool = &rsp->pool;
+
+	seq_printf(m, "W0: Stack base\t\t%llx\n", pool->stack_base);
+
+	seq_printf(m, "W1: ena \t\t%d\nW1: nat_align \t\t%d\n",
+		   pool->ena, pool->nat_align);
+	seq_printf(m, "W1: stack_caching\t%d\n",
+		   pool->stack_caching);
+	seq_printf(m, "W1: buf_offset\t\t%d\nW1: buf_size\t\t%d\n",
+		   pool->buf_offset, pool->buf_size);
+
+	seq_printf(m, "W2: stack_max_pages \t%d\nW2: stack_pages\t\t%d\n",
+		   pool->stack_max_pages, pool->stack_pages);
+
+	seq_printf(m, "W4: stack_offset\t%d\nW4: shift\t\t%d\nW4: avg_level\t\t%d\n",
+		   pool->stack_offset, pool->shift, pool->avg_level);
+	seq_printf(m, "W4: avg_con \t\t%d\nW4: fc_ena\t\t%d\nW4: fc_stype\t\t%d\n",
+		   pool->avg_con, pool->fc_ena, pool->fc_stype);
+	seq_printf(m, "W4: fc_hyst_bits\t%d\nW4: fc_up_crossing\t%d\n",
+		   pool->fc_hyst_bits, pool->fc_up_crossing);
+	seq_printf(m, "W4: update_time\t\t%d\n", pool->update_time);
+
+	seq_printf(m, "W5: fc_addr\t\t%llx\n", pool->fc_addr);
+
+	seq_printf(m, "W6: ptr_start\t\t%llx\n", pool->ptr_start);
+
+	seq_printf(m, "W7: ptr_end\t\t%llx\n", pool->ptr_end);
+
+	seq_printf(m, "W8: err_int\t\t%d\nW8: err_int_ena\t\t%d\n",
+		   pool->err_int, pool->err_int_ena);
+	seq_printf(m, "W8: thresh_int\t\t%d\n", pool->thresh_int);
+	seq_printf(m, "W8: thresh_int_ena\t%d\nW8: thresh_up\t\t%d\n",
+		   pool->thresh_int_ena, pool->thresh_up);
+	seq_printf(m, "W8: thresh_qint_idx\t%d\nW8: err_qint_idx\t%d\n",
+		   pool->thresh_qint_idx, pool->err_qint_idx);
+	seq_printf(m, "W8: fc_msh_dst\t\t%d\n", pool->fc_msh_dst);
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.h
index 9d3a98dc3000..a2e3a2cd6edb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.h
@@ -20,5 +20,9 @@ void print_nix_cn20k_sq_ctx(struct seq_file *m,
 			    struct nix_cn20k_sq_ctx_s *sq_ctx);
 void print_nix_cn20k_cq_ctx(struct seq_file *m,
 			    struct nix_cn20k_aq_enq_rsp *rsp);
+void print_npa_cn20k_aura_ctx(struct seq_file *m,
+			      struct npa_cn20k_aq_enq_rsp *rsp);
+void print_npa_cn20k_pool_ctx(struct seq_file *m,
+			      struct npa_cn20k_aq_enq_rsp *rsp);
 
 #endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 3d7a4f923c04..296012a2f3de 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -1038,6 +1038,11 @@ static void print_npa_aura_ctx(struct seq_file *m, struct npa_aq_enq_rsp *rsp)
 	struct npa_aura_s *aura = &rsp->aura;
 	struct rvu *rvu = m->private;
 
+	if (is_cn20k(rvu->pdev)) {
+		print_npa_cn20k_aura_ctx(m, (struct npa_cn20k_aq_enq_rsp *)rsp);
+		return;
+	}
+
 	seq_printf(m, "W0: Pool addr\t\t%llx\n", aura->pool_addr);
 
 	seq_printf(m, "W1: ena\t\t\t%d\nW1: pool caching\t%d\n",
@@ -1086,6 +1091,11 @@ static void print_npa_pool_ctx(struct seq_file *m, struct npa_aq_enq_rsp *rsp)
 	struct npa_pool_s *pool = &rsp->pool;
 	struct rvu *rvu = m->private;
 
+	if (is_cn20k(rvu->pdev)) {
+		print_npa_cn20k_pool_ctx(m, (struct npa_cn20k_aq_enq_rsp *)rsp);
+		return;
+	}
+
 	seq_printf(m, "W0: Stack base\t\t%llx\n", pool->stack_base);
 
 	seq_printf(m, "W1: ena \t\t%d\nW1: nat_align \t\t%d\n",
-- 
2.34.1


