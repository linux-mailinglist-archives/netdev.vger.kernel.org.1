Return-Path: <netdev+bounces-207223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53932B064D2
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 19:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB27E567485
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 17:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B1C27FB07;
	Tue, 15 Jul 2025 17:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="S7fmB9iN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA97E27B4F7
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 17:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752598973; cv=none; b=XE0z7DKleIhLHt6YIK6NZYWRvEl7ORVfLKe29qunMH+E4uPHZ2e0NG8q+TTrygZS1XYNTG2RTw+4SneIP1e/a5H9s/HAGhV0BpWfo24kxYPliaxv8fFr/bDeViMpyQmLInG4UzpVXYX7bK2R30j016XpEHqO73U5pesjdy418Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752598973; c=relaxed/simple;
	bh=v95XWQivcFTU97pA7EME/tmz6B+75iI2aTWTgLCxYJE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ytle1v2ujOKQR1505SS28z8tMy2HeYF6OqFzdcjtNWrpBJ+fEApbRNz4ZKh5NsD+FLSLFNA1xKH5n1KujjwI2DFHOpg0yVY3Y3Kv4mmumBfTm60DfxmoRJ0ewM0syf6Mu/hHmE2K4RxjbETa9MSuWnq0TKTZZKGupl9wOIJNPu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=S7fmB9iN reason="signature verification failed"; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F3oPFw009030;
	Tue, 15 Jul 2025 10:02:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=/pxkjQnudQAoaevAb4ipBdqGj
	+rCynmcNobWSGv7uGA=; b=S7fmB9iN394g4FJf6Zwhz5qy3MzJy5O/xYM4ZJUEo
	Bzo7SwinaKsCQD9s2u0udlUPO5yJkRYUTYZnajSauImHhcfiPHiuhyCCcvtZzf9q
	eMODaxNOBNEbZzETbgOcCnHgGxFkSD6d7iHvX43TnHSC5fhjdRcUC3S90RThvLOD
	TmGv3o4gioJ7aaksR+Qrw9ky1Tvrb4klcHtrPF9m08bl7GSZLZFlP6+qQbAoxCPB
	ahavomKdKfySmx2WdKQG/1hMX2wcr0Wk/M0zXpU3UjyncA3SZoWiOsVNRMXUWNkf
	Ej/xHhDoYpUUwEMEaoet3wOtiYiwC+emCNhb43A7ygahQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47wbm52bbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 10:02:44 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 15 Jul 2025 10:02:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 15 Jul 2025 10:02:42 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 21FBB5B692F;
	Tue, 15 Jul 2025 10:02:38 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, pabeni4redhat.com@mx0b-0016f401.pphosted.com,
        <horms@kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>,
        <jerinj@marvell.com>, <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH v2 05/11] octeontx2-af: Extend debugfs support for cn20k NPA
Date: Tue, 15 Jul 2025 22:31:58 +0530
Message-ID: <1752598924-32705-6-git-send-email-sbhatta@marvell.com>
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
X-Authority-Analysis: v=2.4 cv=M7tNKzws c=1 sm=1 tr=0 ts=687689b4 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=kt4yuNSx9aKLEnRRmMIA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: d2w16Fgv9ephgCUxAe5Sc54UBtQLIH3V
X-Proofpoint-ORIG-GUID: d2w16Fgv9ephgCUxAe5Sc54UBtQLIH3V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE1NiBTYWx0ZWRfX+64fG3BEr7TL 7UL6mxS8mMp2wW1ODlayzVIEA7t4zTzT0MGEzgBiwtYGi/zP47nRGpoC/JaQRuJaRUCOVWQ/uqa WjvvbOQL8PQwQLecAu/mVTocpvfCoyjUYsaBguUG2vMei4GppQP2WZdaxusdADj0IdBrkXBsd4y
 YEGpVIMHtCoZgVQ03923ZYUiGOyW+cffEsnh6dza5sK3yiAkTbmaP6WFQTgSpm6GatVn7TYRtrp uDvwfpEI2AHM/BF/HpajHt5CeHvoCdl1WsGFFONd4ue9+Qv0hnmf+CG0osdQA92jpmvkNQK/+Xp J8/4j8/Qrkv9IuhNJ/yV6H0dCR+4eoK29SbAAYxdu2QiX5aj2sNueR1KK5JhwG0A7GzfuqeCJB9
 8qySPAJA4JowhZ/sZFxql7h5rdbe3GoCwQcgOwipjSG6ad1nMe+45PAQej5rXrfVs24+k9cf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_02,2025-03-28_01

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


