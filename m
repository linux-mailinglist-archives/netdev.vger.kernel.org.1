Return-Path: <netdev+bounces-207220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4813FB064CF
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 19:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2BD1AA5D77
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 17:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B469027FB1E;
	Tue, 15 Jul 2025 17:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="cCrmj2qu"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C997127A448
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752598963; cv=none; b=OUqwwRo+gEI1aPPkTONGP4LFckg0wHq1qclvMbIvmrNB2XcjnhV30+0jLlrIydtfC1KuSB4hD8XFfAdSNpkH03e4sC6MGsvfE25eUe5ncwqcteH+sW5YpyZRpo8u7if70nN8rZe7Rf23o0jWkcJdnuS8tnKTEIiw3MgDtgIMNYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752598963; c=relaxed/simple;
	bh=DefUHd6su02xFCpNhENEO0IC8piM/wAd6R4XsQxJAbk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LbrZZ7alzmKKIedJhiIiEWvz4ZugOkhSwDpbNw5YXee/19ZH5/oUtgveiqvGyxwkYlpxarw1wy8dHPOZ2eKwmPGPKvuvDRO9jwubLJ0zOaRmObtyLTXJQBvCSQv25G8+QwiZS71KcrJi2+dmE2Nb5mAtpWCNKvIvh5iBMUj80iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=cCrmj2qu reason="signature verification failed"; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FGUoLl019299;
	Tue, 15 Jul 2025 10:02:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=U1mmGQ/LE4gk/urEZhBatAW2A
	FhD8+ZvIsFxynKsTXA=; b=cCrmj2quD9OkyEkflkUeJfvkoR8RGSamr0HPfCuam
	cQckMDdnsFwiYNuroesL8ZhwhVFKi/BrQZ8YW2OlqmcVX0nHaGoINTsmVBX5v13Q
	CBcsq7c9reDPH3PNI/f1r/FJaGSzGL0JQvqY4oKQqdDzAtSsjif1lKChUi9rN4ZG
	NYai1CDHGbVtWCQ0wwnbqQzYVaMqg8UHBuBr8ehPh0MdiFx3ahy29emQb8+cblcH
	LYqoOvKZWrReb4niSCoR5+9fqcAfW5AIRoUmiZuGanAoCr1gGdLbWwxs982OhDEy
	4S5dRmTBTKeU9diBcoYp5lmdKoH26aDtM0aRySac75Bog==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47wajmtc89-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 10:02:33 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 15 Jul 2025 10:02:29 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 15 Jul 2025 10:02:29 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id D9B4E5B692E;
	Tue, 15 Jul 2025 10:02:24 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, pabeni4redhat.com@mx0a-0016f401.pphosted.com,
        <horms@kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>,
        <jerinj@marvell.com>, <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH v2 02/11] octeontx2-af: Add cn20k NIX block contexts
Date: Tue, 15 Jul 2025 22:31:55 +0530
Message-ID: <1752598924-32705-3-git-send-email-sbhatta@marvell.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE1NiBTYWx0ZWRfX0SiOnujURJVj HTHtuqolJxr233e8l6VQGQ4nLWjI0UYdbqJnqF9MEaQMX5BznKuklzbehxIn8YW2ujaTsvAetxM wljGsWM7X7Y6fBc7a0sV0lB3CgN57/BnsyjTbocKNmNzRiJCQxFQ3yccHa3gAdF2cgfwr2zXrDN
 eomIJ80B5IwSTghTUc+UIdAgPa8FCjmBjf+ilbdbyyrcKUQXVrge8ptJXUmfv9erFb0aO1DFGvh 7JGZJzwMigcfFOQSokXriqhcWI50I0UHVjWvT29EszsvYWnTPrlxQ4RZUzdFjk5AYeZUAvPG+bb dI9UQPOxC3UddwQW40YnmJjko3hVrYPRHB1rYmfFuwY/QZ5FoOxQ038QT7idOTHCnjKcfisTxQo
 6dj7PRlhFTSHmLOvHJH3vUR08380xciCV87UYCrhjR4F58zzO5oZnJOeZehGeowNzliEASIu
X-Proofpoint-GUID: 4EsW-uz-P0-b_HIqQbQrb1xLXRM7rtI1
X-Authority-Analysis: v=2.4 cv=W+c4VQWk c=1 sm=1 tr=0 ts=687689a9 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=SXiblbWTzmw2bBs4Lg4A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 4EsW-uz-P0-b_HIqQbQrb1xLXRM7rtI1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_02,2025-03-28_01

New CN20K silicon has NIX hardware context structures different from
previous silicons. Add NIX send and completion queue context
definitions for cn20k. Extend NIX context handling support to cn20k.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/Makefile    |   2 +-
 .../ethernet/marvell/octeontx2/af/cn20k/nix.c |  20 ++
 .../marvell/octeontx2/af/cn20k/struct.h       | 196 ++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  38 ++++
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   3 +
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  10 +-
 6 files changed, 266 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/nix.c

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/Makefile b/drivers/net/ethernet/marvell/octeontx2/af/Makefile
index 532813d8d028..cb77b978eda5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/Makefile
+++ b/drivers/net/ethernet/marvell/octeontx2/af/Makefile
@@ -12,4 +12,4 @@ rvu_af-y := cgx.o rvu.o rvu_cgx.o rvu_npa.o rvu_nix.o \
 		  rvu_reg.o rvu_npc.o rvu_debugfs.o ptp.o rvu_npc_fs.o \
 		  rvu_cpt.o rvu_devlink.o rpm.o rvu_cn10k.o rvu_switch.o \
 		  rvu_sdp.o rvu_npc_hash.o mcs.o mcs_rvu_if.o mcs_cnf10kb.o \
-		  rvu_rep.o cn20k/mbox_init.o
+		  rvu_rep.o cn20k/mbox_init.o cn20k/nix.o
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/nix.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/nix.c
new file mode 100644
index 000000000000..aa2016fd1bba
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/nix.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell RVU Admin Function driver
+ *
+ * Copyright (C) 2024 Marvell.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "struct.h"
+#include "../rvu.h"
+
+int rvu_mbox_handler_nix_cn20k_aq_enq(struct rvu *rvu,
+				      struct nix_cn20k_aq_enq_req *req,
+				      struct nix_cn20k_aq_enq_rsp *rsp)
+{
+	return rvu_nix_aq_enq_inst(rvu, (struct nix_aq_enq_req *)req,
+				  (struct nix_aq_enq_rsp *)rsp);
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
index 76ce3ec6da9c..92744ae44853 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
@@ -37,4 +37,200 @@ enum rvu_af_cn20k_int_vec_e {
 	RVU_AF_CN20K_INT_VEC_PFAF1_MBOX1	= 0x9,
 	RVU_AF_CN20K_INT_VEC_CNT		= 0xa,
 };
+
+struct nix_cn20k_sq_ctx_s {
+	u64 ena                         :  1; /* W0 */
+	u64 qint_idx                    :  6;
+	u64 substream                   : 20;
+	u64 sdp_mcast                   :  1;
+	u64 cq                          : 20;
+	u64 sqe_way_mask                : 16;
+	u64 smq                         : 11; /* W1 */
+	u64 cq_ena                      :  1;
+	u64 xoff                        :  1;
+	u64 sso_ena                     :  1;
+	u64 smq_rr_weight               : 14;
+	u64 default_chan                : 12;
+	u64 sqb_count                   : 16;
+	u64 reserved_120_120            :  1;
+	u64 smq_rr_count_lb             :  7;
+	u64 smq_rr_count_ub             : 25; /* W2 */
+	u64 sqb_aura                    : 20;
+	u64 sq_int                      :  8;
+	u64 sq_int_ena                  :  8;
+	u64 sqe_stype                   :  2;
+	u64 reserved_191_191            :  1;
+	u64 max_sqe_size                :  2; /* W3 */
+	u64 cq_limit                    :  8;
+	u64 lmt_dis                     :  1;
+	u64 mnq_dis                     :  1;
+	u64 smq_next_sq                 : 20;
+	u64 smq_lso_segnum              :  8;
+	u64 tail_offset                 :  6;
+	u64 smenq_offset                :  6;
+	u64 head_offset                 :  6;
+	u64 smenq_next_sqb_vld          :  1;
+	u64 smq_pend                    :  1;
+	u64 smq_next_sq_vld             :  1;
+	u64 reserved_253_255            :  3;
+	u64 next_sqb                    : 64; /* W4 */
+	u64 tail_sqb                    : 64; /* W5 */
+	u64 smenq_sqb                   : 64; /* W6 */
+	u64 smenq_next_sqb              : 64; /* W7 */
+	u64 head_sqb                    : 64; /* W8 */
+	u64 reserved_576_583            :  8; /* W9 */
+	u64 vfi_lso_total               : 18;
+	u64 vfi_lso_sizem1              :  3;
+	u64 vfi_lso_sb                  :  8;
+	u64 vfi_lso_mps                 : 14;
+	u64 vfi_lso_vlan0_ins_ena       :  1;
+	u64 vfi_lso_vlan1_ins_ena       :  1;
+	u64 vfi_lso_vld                 :  1;
+	u64 reserved_630_639            : 10;
+	u64 scm_lso_rem                 : 18; /* W10 */
+	u64 reserved_658_703            : 46;
+	u64 octs                        : 48; /* W11 */
+	u64 reserved_752_767            : 16;
+	u64 pkts                        : 48; /* W12 */
+	u64 reserved_816_831            : 16;
+	u64 aged_drop_octs              : 32; /* W13 */
+	u64 aged_drop_pkts              : 32;
+	u64 dropped_octs                : 48; /* W14 */
+	u64 reserved_944_959            : 16;
+	u64 dropped_pkts                : 48; /* W15 */
+	u64 reserved_1008_1023          : 16;
+};
+
+struct nix_cn20k_cq_ctx_s {
+	u64 base                        : 64; /* W0 */
+	u64 lbp_ena                     :  1; /* W1 */
+	u64 lbpid_low                   :  3;
+	u64 bp_ena                      :  1;
+	u64 lbpid_med                   :  3;
+	u64 bpid                        :  9;
+	u64 lbpid_high                  :  3;
+	u64 qint_idx                    :  7;
+	u64 cq_err                      :  1;
+	u64 cint_idx                    :  7;
+	u64 avg_con                     :  9;
+	u64 wrptr                       : 20;
+	u64 tail                        : 20; /* W2 */
+	u64 head                        : 20;
+	u64 avg_level                   :  8;
+	u64 update_time                 : 16;
+	u64 bp                          :  8; /* W3 */
+	u64 drop                        :  8;
+	u64 drop_ena                    :  1;
+	u64 ena                         :  1;
+	u64 cpt_drop_err_en             :  1;
+	u64 reserved_211_211            :  1;
+	u64 msh_dst                     : 11;
+	u64 msh_valid                   :  1;
+	u64 stash_thresh                :  4;
+	u64 lbp_frac                    :  4;
+	u64 caching                     :  1;
+	u64 stashing                    :  1;
+	u64 reserved_234_235            :  2;
+	u64 qsize                       :  4;
+	u64 cq_err_int                  :  8;
+	u64 cq_err_int_ena              :  8;
+	u64 bpid_ext                    :  2; /* W4 */
+	u64 reserved_258_259            :  2;
+	u64 lbpid_ext                   :  2;
+	u64 reserved_262_319            : 58;
+	u64 reserved_320_383            : 64; /* W5 */
+	u64 reserved_384_447            : 64; /* W6 */
+	u64 reserved_448_511            : 64; /* W7 */
+};
+
+struct nix_cn20k_rq_ctx_s {
+	u64 ena                         :  1;
+	u64 sso_ena                     :  1;
+	u64 ipsech_ena                  :  1;
+	u64 ena_wqwd                    :  1;
+	u64 cq                          : 20;
+	u64 reserved_24_34              : 11;
+	u64 port_il4_dis                :  1;
+	u64 port_ol4_dis                :  1;
+	u64 lenerr_dis                  :  1;
+	u64 csum_il4_dis                :  1;
+	u64 csum_ol4_dis                :  1;
+	u64 len_il4_dis                 :  1;
+	u64 len_il3_dis                 :  1;
+	u64 len_ol4_dis                 :  1;
+	u64 len_ol3_dis                 :  1;
+	u64 wqe_aura                    : 20;
+	u64 spb_aura                    : 20;
+	u64 lpb_aura                    : 20;
+	u64 sso_grp                     : 10;
+	u64 sso_tt                      :  2;
+	u64 pb_caching                  :  2;
+	u64 wqe_caching                 :  1;
+	u64 xqe_drop_ena                :  1;
+	u64 spb_drop_ena                :  1;
+	u64 lpb_drop_ena                :  1;
+	u64 pb_stashing                 :  1;
+	u64 ipsecd_drop_en              :  1;
+	u64 chi_ena                     :  1;
+	u64 reserved_125_127            :  3;
+	u64 band_prof_id_l              : 10;
+	u64 sso_fc_ena                  :  1;
+	u64 policer_ena                 :  1;
+	u64 spb_sizem1                  :  6;
+	u64 wqe_skip                    :  2;
+	u64 spb_high_sizem1             :  3;
+	u64 spb_ena                     :  1;
+	u64 lpb_sizem1                  : 12;
+	u64 first_skip                  :  7;
+	u64 reserved_171_171            :  1;
+	u64 later_skip                  :  6;
+	u64 xqe_imm_size                :  6;
+	u64 band_prof_id_h              :  4;
+	u64 reserved_188_189            :  2;
+	u64 xqe_imm_copy                :  1;
+	u64 xqe_hdr_split               :  1;
+	u64 xqe_drop                    :  8;
+	u64 xqe_pass                    :  8;
+	u64 wqe_pool_drop               :  8;
+	u64 wqe_pool_pass               :  8;
+	u64 spb_aura_drop               :  8;
+	u64 spb_aura_pass               :  8;
+	u64 spb_pool_drop               :  8;
+	u64 spb_pool_pass               :  8;
+	u64 lpb_aura_drop               :  8;
+	u64 lpb_aura_pass               :  8;
+	u64 lpb_pool_drop               :  8;
+	u64 lpb_pool_pass               :  8;
+	u64 reserved_288_291            :  4;
+	u64 rq_int                      :  8;
+	u64 rq_int_ena                  :  8;
+	u64 qint_idx                    :  7;
+	u64 reserved_315_319            :  5;
+	u64 ltag                        : 24;
+	u64 good_utag                   :  8;
+	u64 bad_utag                    :  8;
+	u64 flow_tagw                   :  6;
+	u64 ipsec_vwqe                  :  1;
+	u64 vwqe_ena                    :  1;
+	u64 vtime_wait                  :  8;
+	u64 max_vsize_exp               :  4;
+	u64 vwqe_skip                   :  2;
+	u64 reserved_382_383            :  2;
+	u64 octs                        : 48;
+	u64 reserved_432_447            : 16;
+	u64 pkts                        : 48;
+	u64 reserved_496_511            : 16;
+	u64 drop_octs                   : 48;
+	u64 reserved_560_575            : 16;
+	u64 drop_pkts                   : 48;
+	u64 reserved_624_639            : 16;
+	u64 re_pkts                     : 48;
+	u64 reserved_688_703            : 16;
+	u64 reserved_704_767            : 64;
+	u64 reserved_768_831            : 64;
+	u64 reserved_832_895            : 64;
+	u64 reserved_896_959            : 64;
+	u64 reserved_960_1023           : 64;
+};
+
 #endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 0bc0dc79868b..544efd4817c1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -336,6 +336,8 @@ M(NIX_MCAST_GRP_UPDATE, 0x802d, nix_mcast_grp_update,				\
 				nix_mcast_grp_update_req,			\
 				nix_mcast_grp_update_rsp)			\
 M(NIX_LF_STATS, 0x802e, nix_lf_stats, nix_stats_req, nix_stats_rsp)	\
+M(NIX_CN20K_AQ_ENQ,	0x802f, nix_cn20k_aq_enq, nix_cn20k_aq_enq_req,		\
+				nix_cn20k_aq_enq_rsp)				\
 /* MCS mbox IDs (range 0xA000 - 0xBFFF) */					\
 M(MCS_ALLOC_RESOURCES,	0xa000, mcs_alloc_resources, mcs_alloc_rsrc_req,	\
 				mcs_alloc_rsrc_rsp)				\
@@ -935,6 +937,42 @@ struct nix_lf_free_req {
 	u64 flags;
 };
 
+/* CN20K NIX AQ enqueue msg */
+struct nix_cn20k_aq_enq_req {
+	struct mbox_msghdr hdr;
+	u32  qidx;
+	u8 ctype;
+	u8 op;
+	union {
+		struct nix_cn20k_rq_ctx_s rq;
+		struct nix_cn20k_sq_ctx_s sq;
+		struct nix_cn20k_cq_ctx_s cq;
+		struct nix_rsse_s   rss;
+		struct nix_rx_mce_s mce;
+		struct nix_bandprof_s prof;
+	};
+	union {
+		struct nix_cn20k_rq_ctx_s rq_mask;
+		struct nix_cn20k_sq_ctx_s sq_mask;
+		struct nix_cn20k_cq_ctx_s cq_mask;
+		struct nix_rsse_s   rss_mask;
+		struct nix_rx_mce_s mce_mask;
+		struct nix_bandprof_s prof_mask;
+	};
+};
+
+struct nix_cn20k_aq_enq_rsp {
+	struct mbox_msghdr hdr;
+	union {
+		struct nix_cn20k_rq_ctx_s rq;
+		struct nix_cn20k_sq_ctx_s sq;
+		struct nix_cn20k_cq_ctx_s cq;
+		struct nix_rsse_s   rss;
+		struct nix_rx_mce_s mce;
+		struct nix_bandprof_s prof;
+	};
+};
+
 /* CN10K NIX AQ enqueue msg */
 struct nix_cn10k_aq_enq_req {
 	struct mbox_msghdr hdr;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 7ee1fdeb5295..5a7487422bd5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -1017,6 +1017,9 @@ int rvu_nix_mcast_update_mcam_entry(struct rvu *rvu, u16 pcifunc,
 void rvu_nix_flr_free_bpids(struct rvu *rvu, u16 pcifunc);
 int rvu_alloc_cint_qint_mem(struct rvu *rvu, struct rvu_pfvf *pfvf,
 			    int blkaddr, int nixlf);
+int rvu_nix_aq_enq_inst(struct rvu *rvu, struct nix_aq_enq_req *req,
+			struct nix_aq_enq_rsp *rsp);
+
 /* NPC APIs */
 void rvu_npc_freemem(struct rvu *rvu);
 int rvu_npc_get_pkind(struct rvu *rvu, u16 pf);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 48d44911b663..47a64c4c5b7e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -1021,6 +1021,12 @@ static void nix_get_aq_req_smq(struct rvu *rvu, struct nix_aq_enq_req *req,
 {
 	struct nix_cn10k_aq_enq_req *aq_req;
 
+	if (is_cn20k(rvu->pdev)) {
+		*smq = ((struct nix_cn20k_aq_enq_req *)req)->sq.smq;
+		*smq_mask = ((struct nix_cn20k_aq_enq_req *)req)->sq_mask.smq;
+		return;
+	}
+
 	if (!is_rvu_otx2(rvu)) {
 		aq_req = (struct nix_cn10k_aq_enq_req *)req;
 		*smq = aq_req->sq.smq;
@@ -1325,8 +1331,8 @@ static int rvu_nix_verify_aq_ctx(struct rvu *rvu, struct nix_hw *nix_hw,
 	return 0;
 }
 
-static int rvu_nix_aq_enq_inst(struct rvu *rvu, struct nix_aq_enq_req *req,
-			       struct nix_aq_enq_rsp *rsp)
+int rvu_nix_aq_enq_inst(struct rvu *rvu, struct nix_aq_enq_req *req,
+			struct nix_aq_enq_rsp *rsp)
 {
 	struct nix_hw *nix_hw;
 	int err, retries = 5;
-- 
2.34.1


