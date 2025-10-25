Return-Path: <netdev+bounces-232800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6030CC08F2A
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 12:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3D7D1B240A5
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 10:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58702F3C1A;
	Sat, 25 Oct 2025 10:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="D4yWgkYG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317282F39AF
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 10:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761388425; cv=none; b=pdWgfeKThpVgREG2hUjLitcUSEFMwnYe2tbIFg3Fgk2wunyEtUYr0ceWkVJRdebtY7BGk37r5aG3x3zeVDF7zsRw8W+uAaZ9FsbdgXDroCGl0igIBI1gf0sgNxZS9YWGM6h3P9+Ug6XG+nka/xncbfLdMasTNjSrhqJ75uA6CFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761388425; c=relaxed/simple;
	bh=fK+rr0TUr3i8ARlo8eb8YNWOU6xQGjwpn91a3rarmfo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TQREfWpB8A71aJvWzwNP0CU3PecnLb9HYSNRCToH6tzcHejqB2rTMAGHpqFCzJI80dIX4hMm3N4qKkFj8hra4btPN32pikb5oxDcyLYQkRU6ZKsuuhmQpH5PsvnUuEj1iupxVe2zY+fNPTHYoxlrpc2N0+LMQBHGHzUUHcSKmtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=D4yWgkYG; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59P80O1e646474;
	Sat, 25 Oct 2025 03:33:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=qB2oZtXM9TKZPT1mySxGAwa7P
	yequ5rPH/+wmoQFScE=; b=D4yWgkYGMRUQhvWJpbzF9H1WhHG1wYWeXpROOdXrp
	8Gr7K3rKVTKAQV2ZE860ium4QCVPyR6cliGtTLuD4XWakKT9gdVETdhmbFGxJp1R
	SH7hj3x7F4yEc0wF/fMs0tChGMXB+Ij/2YpmyAtn7OvI4LLlXHHvjLHaTbRc65Tt
	DxJZ7qMxTHO/e1kqQmo9xLZgkHXWzC1/J9zDsMkeTKlpnKPCylH5DeWLa/KiiUBe
	VGd1eOQpbbgI+Y+HyXqL3NVgeIjlgDz+LTodEsqBcQvitGkVGBaOYfIyjwlbvkoT
	katdsgDkoyxsxG+NqAE4l+vtEsPPYCNxc/S1RTBbheOYA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4a0nm3rjyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Oct 2025 03:33:36 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sat, 25 Oct 2025 03:33:48 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sat, 25 Oct 2025 03:33:47 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 3BC315B6921;
	Sat, 25 Oct 2025 03:33:29 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>,
        <jerinj@marvell.com>, <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <saikrishnag@marvell.com>, <netdev@vger.kernel.org>,
        Subbaraya Sundeep
	<sbhatta@marvell.com>
Subject: [net-next v4 05/11] octeontx2-af: Extend debugfs support for cn20k NPA
Date: Sat, 25 Oct 2025 16:02:41 +0530
Message-ID: <1761388367-16579-6-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1761388367-16579-1-git-send-email-sbhatta@marvell.com>
References: <1761388367-16579-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: B4M41HZ2cZ0K1qWFL0jzElgauizbjxkZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDA5NSBTYWx0ZWRfX3NpmYQbA3tBv
 JmGc5AUmdHAkJBm4qn5z9MG7t3HE58AyS17jEDlA3Zo/IxfCbgvsCM9NWmVEmCHYjIKwKHg9U7v
 MMkYcD/H5Ru34YflzDmXbP8rnA0F+wDCVT6IBf6R1Ucmdu2LBeNt/tUIeX4c/ABNzpyyzRvg8Xt
 EELQ8lAm3jSXis5Un+aKsJr+Hf6LMJNaQqrjXKh1BWoel3JX7p0tV+qc7sF0Xfp19vuMRZH8/t8
 x8r71Ws87hUJr9P+JHCHgnxGEdFP0HYdRm+KmMi/dM49u2963M1pRMKnoq4NmDcHwmGvOyB26e2
 lrb/Cu+YBUjqIt+NWZaUFFJkEFXCGN0U5+RrLsgje+av63DE8UTwEqVlhxinHk4GySufD2L5HNg
 8cWMc8M8vwIR0BfOn93IUlMiwq0WOg==
X-Proofpoint-ORIG-GUID: B4M41HZ2cZ0K1qWFL0jzElgauizbjxkZ
X-Authority-Analysis: v=2.4 cv=bpJBxUai c=1 sm=1 tr=0 ts=68fca780 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=kt4yuNSx9aKLEnRRmMIA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-25_03,2025-10-22_01,2025-03-28_01

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
index 50b1bd1d2c86..498968bf4cf5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
@@ -132,3 +132,87 @@ void print_nix_cn20k_cq_ctx(struct seq_file *m,
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
index eeca8cef7964..c55a0f15380d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -1103,6 +1103,11 @@ static void print_npa_aura_ctx(struct seq_file *m, struct npa_aq_enq_rsp *rsp)
 	struct npa_aura_s *aura = &rsp->aura;
 	struct rvu *rvu = m->private;
 
+	if (is_cn20k(rvu->pdev)) {
+		print_npa_cn20k_aura_ctx(m, (struct npa_cn20k_aq_enq_rsp *)rsp);
+		return;
+	}
+
 	seq_printf(m, "W0: Pool addr\t\t%llx\n", aura->pool_addr);
 
 	seq_printf(m, "W1: ena\t\t\t%d\nW1: pool caching\t%d\n",
@@ -1151,6 +1156,11 @@ static void print_npa_pool_ctx(struct seq_file *m, struct npa_aq_enq_rsp *rsp)
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
2.48.1


