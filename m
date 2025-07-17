Return-Path: <netdev+bounces-207966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BB1B092D4
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 19:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 962117BD343
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6722FD5B9;
	Thu, 17 Jul 2025 17:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="eTmIruCx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAE31F872D
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 17:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752772204; cv=none; b=d002qlVHLJC2dA4TR2IUzHty2yE9ur/Ecgf5WcG/X1MegoYLS/x2FmNGkG5aE6ucJ91QITABhAu2re7IM8X1B/1CMtk2T73tk0GYJBq6unomk6WEuiSLc0iYryD6GDAIIPKyDeE8xX+1gIb580xwZ9cRqEmBLuETO7pUwWFgqIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752772204; c=relaxed/simple;
	bh=v95XWQivcFTU97pA7EME/tmz6B+75iI2aTWTgLCxYJE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TEmlKaYYebE/WUdwB3e9z8AveHDcdxoBiQY7TqvKdmdeT6nJF+8YL4J+BdpmgoXhJDq8AI5ANE+GMaO/eIDBMykd33+54e1E/I9iwzyTA/SVSHG71ve9eO9gtjNtw5uEbZ11VZ7qGW9wz/2FMPcRTWscFRYJjo2HWovYHcVU+VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=eTmIruCx; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H9e599019407;
	Thu, 17 Jul 2025 10:09:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=/pxkjQnudQAoaevAb4ipBdqGj
	+rCynmcNobWSGv7uGA=; b=eTmIruCx0pA8AvJF0riNSYO79Ln0PB8h5D7e1sLEo
	M7eu57OPHUOsf1k4WqLmXnz+1lPAZpHlQE7aaVTiw5MB3hccMNzq/IfhcAzFF1k2
	Mq64LPlPe9+VDv9m6Do+uYLUpx8sYb5dKbWzD+gTrJMO7VKkwzXx8nUVIg/Q+3Pu
	o6wr8ALgfxOeDYRgtSRQ/e0Pc6udRp6TnYTTKCKrC13plCuwasCpVQwIxDBIg/zz
	sq3jfeJcvq5CjuwhZGDpVaJq5IPn3gi6vHYgslp+TUpkd4YbcMwA1lPUtv0MTr9N
	2ha8QwjrdVRHqUyVyuIB4nHy4f5zIxvFcCdpH2d++yYuA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47xvpc96ry-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 10:09:55 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 17 Jul 2025 10:09:54 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 17 Jul 2025 10:09:54 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 2A8B63F7044;
	Thu, 17 Jul 2025 10:09:49 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>,
        <jerinj@marvell.com>, <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH v3 05/11] octeontx2-af: Extend debugfs support for cn20k NPA
Date: Thu, 17 Jul 2025 22:37:37 +0530
Message-ID: <1752772063-6160-6-git-send-email-sbhatta@marvell.com>
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
X-Authority-Analysis: v=2.4 cv=U8ySDfru c=1 sm=1 tr=0 ts=68792e63 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=kt4yuNSx9aKLEnRRmMIA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: cmiS0UgDpmfzxo9uG3S0OfoYV_ZIJ6cx
X-Proofpoint-ORIG-GUID: cmiS0UgDpmfzxo9uG3S0OfoYV_ZIJ6cx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE1MiBTYWx0ZWRfX1TJGV2ROfOO+ 7sj/8nbnb5g+MbvSdiTPkd6ZsnVXTepUSqvHHI58VW4NI07S3PlS/j2rZNjBiXSkA/fmYoMJjHu vB4j2wTR1HNmpWDVN6d9WSYi5RrbTuVmGIFCn+FgZr533OLunm6rnKEGG6y+gs93NnfQNzUgm2E
 QVxXpLNFzz8LdZysAEXt5gQRD9AmcTecC6d5zDC3OGSJO0UUB5VbY9/omEQnTJQOpbmTJvApuCy 1JgdBfvj2/HYSpK+uWPB4Wh7L65xfKk4gEwMwH3IBSnBw/r0eFPKTi/r0RKmThKMzSjzkBr1WYe dU2+bwlB8xvSUJl4Q4Onn3VcnIxLLp4+o3SbusxoK68Me5pxN3uZ5mpSWUBsfDwn19OUGJJFfTS
 dMHvuqNZWjQXaWSQSDy9uS/9CuOeHNhnCWyXOuGWZ00TvTU2kq/sIFJC7sqPJmEc+4FmsizR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01

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


