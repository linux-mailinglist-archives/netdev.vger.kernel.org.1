Return-Path: <netdev+bounces-232798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1F3C08F1B
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 12:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 55E9C4E52C5
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 10:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC26B2F3C12;
	Sat, 25 Oct 2025 10:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ZGiak9Nj"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A2F2F39DC
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 10:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761388416; cv=none; b=BHr5mUK9MbF9A5LCek10qR9OSQKWKNDyWQKGHbDBzfKxT/f+RjyfbaZjGBLg7h3DiUfAV1h4OIztESh3P1ZqM1Jf/YWQbqjDLsbslfYG/mNkIXMLuc8cgCYcqQtIeMwLwTT2y/gzKlePgTtSxxRB6N09wgOruD2F5rTumZRKu40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761388416; c=relaxed/simple;
	bh=F713YDxVAwyp2R80q4o3Nv684Aoi8DR7q0Q1/BPn6B4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LbG0vmW2HxqNWfa6mZVm2H7o72G3uP+lLLrVhA9KLr3mWdvoFo1Vx7ksda2LTkWsBQIhZEgc+T5+QUp13qY+RhmIqYGkGUIH+Zs8FrCUe5De0OzTDs9QX4KywwOc5dpzbctcY7L8+J4I4qVUCalQj2BNloS7kY6c/a/6q8wApbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ZGiak9Nj; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59P9QbGj671045;
	Sat, 25 Oct 2025 03:33:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=4/Bl/OggTeAtUYlxgjtrgnqcf
	jPO5b2uiThI9O9hQhw=; b=ZGiak9NjjSKKT367iXbnarLeUIC+ixGtgvng/kMRP
	Lsm5AaggQM2lwxZ6HWHXF3OinNRis+YmuOGJOQSav7IXl433yzF8bp3GODsS6Gf7
	EeFrwAWWBsmokwIDiMQjO0uH6s2ORj7Gbz6Tow/2jNekqd04JHaHaSFT+c6m9jrB
	LXsdBTMCEO/5obCBLGQEUAdGKyYx1ZESL1CN2RYNgKBWVc/RpHIPN7Lds1yumyk6
	/mskRonvNVGcSwYSUdRPszZcJxWuNJZXBhaJnRQooE7Wczo1obL1SNfVaEyR7bTz
	WRP/OSkZ6jzmzPJIwk1W+tYYTGWbTNQkeS7iEWcsfpdJA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4a0uwh02u2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Oct 2025 03:33:20 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sat, 25 Oct 2025 03:33:29 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sat, 25 Oct 2025 03:33:29 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 524085B6921;
	Sat, 25 Oct 2025 03:33:15 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>,
        <jerinj@marvell.com>, <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <saikrishnag@marvell.com>, <netdev@vger.kernel.org>,
        Subbaraya Sundeep
	<sbhatta@marvell.com>
Subject: [net-next v4 02/11] octeontx2-af: Add cn20k NIX block contexts
Date: Sat, 25 Oct 2025 16:02:38 +0530
Message-ID: <1761388367-16579-3-git-send-email-sbhatta@marvell.com>
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
X-Authority-Analysis: v=2.4 cv=H6vWAuYi c=1 sm=1 tr=0 ts=68fca770 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=aMHbi5QbVTe31wRJEKwA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: H1R-aA3WPic8orl-4FbdmY4vNaf9EzkM
X-Proofpoint-GUID: H1R-aA3WPic8orl-4FbdmY4vNaf9EzkM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDA5NSBTYWx0ZWRfXy5nB1QemK/5A
 n+GhRkjcNKyFotis0E+QygkWjpWhlBWxgMP1V9GJ+IUCJxvRAbEjt3lVo/ZIOjVTU+cRdtWM1mI
 SpTGadPG6xYp9vhlNgIrW/GE1ebgX7UVXuwM/WRf+keTsdEhEKRIfah1HwbNaHrsLn3Igrgc7xs
 g1VvcpPdEPM3Thkiv1/8WEh0IHWl1INvmTGfQtVN31kCr9N1W29CfucsDkk30Zt6WRHjsKmLXzd
 a+iMxDDe8Iw+lestZ4uOoI76JcFrpAm2jAnp3XXB2uK7BQFxNkwc9de2WHKMMydTnTsbFfj7E2s
 EfGownpgiwG/+xeh/I+QicL15sZjuoFheCRodIsvhoCwpH40jqGzfRVMahP/fZDDeEjsHC8jGqt
 zkBMGfAaprR6XtsHQzfqtsYaIlcAUA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-25_03,2025-10-22_01,2025-03-28_01

New CN20K silicon has NIX hardware context structures different from
previous silicons. Add NIX send and completion queue context
definitions for cn20k. Extend NIX context handling support to cn20k.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/Makefile    |   2 +-
 .../ethernet/marvell/octeontx2/af/cn20k/nix.c |  20 ++
 .../marvell/octeontx2/af/cn20k/struct.h       | 205 ++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  38 ++++
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  15 +-
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  10 +-
 6 files changed, 286 insertions(+), 4 deletions(-)
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
index 76ce3ec6da9c..ff8f0d1809c8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
@@ -8,6 +8,8 @@
 #ifndef STRUCT_H
 #define STRUCT_H
 
+#define NIX_MAX_CTX_SIZE		128
+
 /*
  * CN20k RVU PF MBOX Interrupt Vector Enumeration
  *
@@ -37,4 +39,207 @@ enum rvu_af_cn20k_int_vec_e {
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
+static_assert(sizeof(struct nix_cn20k_sq_ctx_s) == NIX_MAX_CTX_SIZE);
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
+	u64 padding[8];
+};
+
+static_assert(sizeof(struct nix_cn20k_sq_ctx_s) == NIX_MAX_CTX_SIZE);
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
+static_assert(sizeof(struct nix_cn20k_rq_ctx_s) == NIX_MAX_CTX_SIZE);
+
 #endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 933073cd2280..01086c52e78d 100644
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
@@ -940,6 +942,42 @@ struct nix_lf_free_req {
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
index b58283341923..e85dac2c806d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -498,6 +498,14 @@ struct channel_fwdata {
 	u8 reserved[RVU_CHANL_INFO_RESERVED];
 };
 
+struct altaf_intr_notify {
+	unsigned long flr_pf_bmap[2];
+	unsigned long flr_vf_bmap[2];
+	unsigned long gint_paddr;
+	unsigned long gint_iova_addr;
+	unsigned long reserved[6];
+};
+
 struct rvu_fwdata {
 #define RVU_FWDATA_HEADER_MAGIC	0xCFDA	/* Custom Firmware Data*/
 #define RVU_FWDATA_VERSION	0x0001
@@ -517,7 +525,8 @@ struct rvu_fwdata {
 	u32 ptp_ext_clk_rate;
 	u32 ptp_ext_tstamp;
 	struct channel_fwdata channel_data;
-#define FWDATA_RESERVED_MEM 958
+	struct altaf_intr_notify altaf_intr_info;
+#define FWDATA_RESERVED_MEM 946
 	u64 reserved[FWDATA_RESERVED_MEM];
 #define CGX_MAX         9
 #define CGX_LMACS_MAX   4
@@ -648,6 +657,7 @@ struct rvu {
 
 	struct mutex		mbox_lock; /* Serialize mbox up and down msgs */
 	u16			rep_pcifunc;
+	bool			altaf_ready;
 	int			rep_cnt;
 	u16			*rep2pfvf_map;
 	u8			rep_mode;
@@ -1032,6 +1042,9 @@ void rvu_nix_flr_free_bpids(struct rvu *rvu, u16 pcifunc);
 int rvu_alloc_cint_qint_mem(struct rvu *rvu, struct rvu_pfvf *pfvf,
 			    int blkaddr, int nixlf);
 void rvu_block_bcast_xon(struct rvu *rvu, int blkaddr);
+int rvu_nix_aq_enq_inst(struct rvu *rvu, struct nix_aq_enq_req *req,
+			struct nix_aq_enq_rsp *rsp);
+
 /* NPC APIs */
 void rvu_npc_freemem(struct rvu *rvu);
 int rvu_npc_get_pkind(struct rvu *rvu, u16 pf);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 26dc0fbeafa6..d156d124f079 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -1019,6 +1019,12 @@ static void nix_get_aq_req_smq(struct rvu *rvu, struct nix_aq_enq_req *req,
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
@@ -1323,8 +1329,8 @@ static int rvu_nix_verify_aq_ctx(struct rvu *rvu, struct nix_hw *nix_hw,
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
2.48.1


