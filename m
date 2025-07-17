Return-Path: <netdev+bounces-207968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1395AB092CF
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 19:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B3451C43760
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD022FE31B;
	Thu, 17 Jul 2025 17:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="brOhP/oU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153032FD888
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 17:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752772207; cv=none; b=AOsYGHFPe3LfE2vVBO8EX7gSvJwpkSdv+LObBhBkTDLv2LG4/l91VJYzUj0TG7OzlRQ1otgnCYRbCbm72c5bDxyZKWFPVeMM9e41BZ5NjXfzT/zVRwj43SxgXET7Pf0QDhlHBbZGnQoSyORlvQQ5u1NbNY1V+EMi/ChExCRbeDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752772207; c=relaxed/simple;
	bh=VlxBIxvZITJmpeWEvtcKMzI/cx6TpiDRAAYNQ8UF89k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dBUx+gWM5JVVlpfRDU3kHuT65htqFYNtmO8CW5LwzOqxQzEzEwWGagY1b7+ytEcAT9biLr723aFg8dfZ3dhxrzmHS3ZnspyencTXLDLocEwMuzKAEqZLJlGNLn4/vsGc8vahlN0pFj0BBALixUTY2UfNPNmBs6ihe1eASlcSAQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=brOhP/oU; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H9eP1f019899;
	Thu, 17 Jul 2025 10:09:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=YVeU2j48kGnReeoskcJxgl+sh
	sacmCURaY4dQR0ghEM=; b=brOhP/oUoF4eLJSnk9CEfvB9jPT/ngBG8nNMAr/us
	zct5zVLaoHkbRAbCDOI2MA24LO74VZlEIdT0f+7ISgWtBmlRZQEaI+jKv2WDzYWv
	Z1KyBGcrKzCcBW64M9xoV4w+nw8kh6hnRSCqtf+fBBj2DIXCyT+WVXyJyFW/rcIu
	0OJ9gLcXzXJQE40vHLE/z94LxNOUkXFxYEQgA/2fRPgWw8NsXglNKFq4SUEtfAHF
	KeKskp/LItgd6cvZIbP9N6zXNzLnTnDMBCFdO8TOdF2A/HzGiphakz09jnNB0bh/
	kuJU+ZePbIIhgtYZEhi549faZjmkMB7V4+YhmZ3WwfH3Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47xvpc96sf-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 10:09:57 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 17 Jul 2025 10:09:50 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 17 Jul 2025 10:09:50 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 9170E3F7044;
	Thu, 17 Jul 2025 10:09:45 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>,
        <jerinj@marvell.com>, <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH v3 04/11] octeontx2-af: Add cn20k NPA block contexts
Date: Thu, 17 Jul 2025 22:37:36 +0530
Message-ID: <1752772063-6160-5-git-send-email-sbhatta@marvell.com>
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
X-Authority-Analysis: v=2.4 cv=U8ySDfru c=1 sm=1 tr=0 ts=68792e65 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=93rZ_s6btrDCt65eblEA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: HAZKYMGVUoq2tsZbyzlyVG559jAkebfh
X-Proofpoint-ORIG-GUID: HAZKYMGVUoq2tsZbyzlyVG559jAkebfh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE1MiBTYWx0ZWRfX51fCPHcbINm7 CB4k72qNHt8nKPDvTYjF0nujnYUwzsFjkdQr2oz3rY5jSSSy0xxSXMJMCR5dJO9PY75NPQdxUch gYoX70kpVcABvx0jEQsrG71ig/Hr8SsdGDuEz1jVmmz+nXuJkZlu2RNJ/tVJGixUFRrr0x2PQXG
 NKs0Ee8c22t4bgaZQocjk31pX+GvBymRiBV39IenfR3WtARZKajZzcVyGgdKvCpWMG/vOH6r+Ve gNscMz54vJVjFozN4LAydqtee68YkVoehXLB4Bn44I0W5ZgsDYAqNg2kVYF51EtnLF2xr5HEY2+ YEHzBVQoXHbpE/cpkh4+NmGG8cJmn8L1feUudM4zdByaY/H0PDf5B9rz1/iqhSjr9Hgy/zUk229
 D2iGHasq9NAMs9OBLTgvAoDoe050YZOPi3PcmQ8+WOGZzFJijgb+k4Lkqj/j/+7o8NaoAKqN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01

From: Linu Cherian <lcherian@marvell.com>

New CN20K silicon has NPA hardware context structures different from
previous silicons. Add NPA aura and pool context definitions for cn20k.
Extend NPA context handling support to cn20k.

Signed-off-by: Linu Cherian <lcherian@marvell.com>
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/Makefile    |   3 +-
 .../ethernet/marvell/octeontx2/af/cn20k/npa.c |  21 +++
 .../marvell/octeontx2/af/cn20k/struct.h       | 130 ++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  35 +++++
 4 files changed, 188 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/Makefile b/drivers/net/ethernet/marvell/octeontx2/af/Makefile
index 57eeaa116116..244de500963e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/Makefile
+++ b/drivers/net/ethernet/marvell/octeontx2/af/Makefile
@@ -12,4 +12,5 @@ rvu_af-y := cgx.o rvu.o rvu_cgx.o rvu_npa.o rvu_nix.o \
 		  rvu_reg.o rvu_npc.o rvu_debugfs.o ptp.o rvu_npc_fs.o \
 		  rvu_cpt.o rvu_devlink.o rpm.o rvu_cn10k.o rvu_switch.o \
 		  rvu_sdp.o rvu_npc_hash.o mcs.o mcs_rvu_if.o mcs_cnf10kb.o \
-		  rvu_rep.o cn20k/mbox_init.o cn20k/nix.o cn20k/debugfs.o
+		  rvu_rep.o cn20k/mbox_init.o cn20k/nix.o cn20k/debugfs.o \
+		  cn20k/npa.o
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c
new file mode 100644
index 000000000000..fe8f926c8b75
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c
@@ -0,0 +1,21 @@
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
+int rvu_mbox_handler_npa_cn20k_aq_enq(struct rvu *rvu,
+				      struct npa_cn20k_aq_enq_req *req,
+				      struct npa_cn20k_aq_enq_rsp *rsp)
+{
+	return rvu_npa_aq_enq_inst(rvu, (struct npa_aq_enq_req *)req,
+				   (struct npa_aq_enq_rsp *)rsp);
+}
+EXPORT_SYMBOL(rvu_mbox_handler_npa_cn20k_aq_enq);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
index 92744ae44853..405ac85e6237 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
@@ -233,4 +233,134 @@ struct nix_cn20k_rq_ctx_s {
 	u64 reserved_960_1023           : 64;
 };
 
+struct npa_cn20k_aura_s {
+	u64 pool_addr;			/* W0 */
+	u64 ena                   : 1;  /* W1 */
+	u64 reserved_65           : 2;
+	u64 pool_caching          : 1;
+	u64 reserved_68           : 16;
+	u64 avg_con               : 9;
+	u64 reserved_93           : 1;
+	u64 pool_drop_ena         : 1;
+	u64 aura_drop_ena         : 1;
+	u64 bp_ena                : 1;
+	u64 reserved_97_103       : 7;
+	u64 aura_drop             : 8;
+	u64 shift                 : 6;
+	u64 reserved_118_119      : 2;
+	u64 avg_level             : 8;
+	u64 count                 : 36; /* W2 */
+	u64 reserved_164_167      : 4;
+	u64 bpid                  : 12;
+	u64 reserved_180_191      : 12;
+	u64 limit                 : 36; /* W3 */
+	u64 reserved_228_231      : 4;
+	u64 bp                    : 7;
+	u64 reserved_239_243      : 5;
+	u64 fc_ena                : 1;
+	u64 fc_up_crossing        : 1;
+	u64 fc_stype              : 2;
+	u64 fc_hyst_bits          : 4;
+	u64 reserved_252_255      : 4;
+	u64 fc_addr;			/* W4 */
+	u64 pool_drop             : 8;  /* W5 */
+	u64 update_time           : 16;
+	u64 err_int               : 8;
+	u64 err_int_ena           : 8;
+	u64 thresh_int            : 1;
+	u64 thresh_int_ena        : 1;
+	u64 thresh_up             : 1;
+	u64 reserved_363          : 1;
+	u64 thresh_qint_idx       : 7;
+	u64 reserved_371          : 1;
+	u64 err_qint_idx          : 7;
+	u64 reserved_379_383      : 5;
+	u64 thresh                : 36; /* W6*/
+	u64 rsvd_423_420          : 4;
+	u64 fc_msh_dst            : 11;
+	u64 reserved_435_438      : 4;
+	u64 op_dpc_ena            : 1;
+	u64 op_dpc_set            : 5;
+	u64 reserved_445_445      : 1;
+	u64 stream_ctx            : 1;
+	u64 unified_ctx           : 1;
+	u64 reserved_448_511;		/* W7 */
+};
+
+struct npa_cn20k_pool_s {
+	u64 stack_base;			/* W0 */
+	u64 ena                   : 1;
+	u64 nat_align             : 1;
+	u64 reserved_66_67        : 2;
+	u64 stack_caching         : 1;
+	u64 reserved_69_87        : 19;
+	u64 buf_offset            : 12;
+	u64 reserved_100_103      : 4;
+	u64 buf_size              : 12;
+	u64 reserved_116_119      : 4;
+	u64 ref_cnt_prof          : 3;
+	u64 reserved_123_127      : 5;
+	u64 stack_max_pages       : 32;
+	u64 stack_pages           : 32;
+	uint64_t bp_0             : 7;
+	uint64_t bp_1             : 7;
+	uint64_t bp_2             : 7;
+	uint64_t bp_3             : 7;
+	uint64_t bp_4             : 7;
+	uint64_t bp_5             : 7;
+	uint64_t bp_6             : 7;
+	uint64_t bp_7             : 7;
+	uint64_t bp_ena_0         : 1;
+	uint64_t bp_ena_1         : 1;
+	uint64_t bp_ena_2         : 1;
+	uint64_t bp_ena_3         : 1;
+	uint64_t bp_ena_4         : 1;
+	uint64_t bp_ena_5         : 1;
+	uint64_t bp_ena_6         : 1;
+	uint64_t bp_ena_7         : 1;
+	u64 stack_offset          : 4;
+	u64 reserved_260_263      : 4;
+	u64 shift                 : 6;
+	u64 reserved_270_271      : 2;
+	u64 avg_level             : 8;
+	u64 avg_con               : 9;
+	u64 fc_ena                : 1;
+	u64 fc_stype              : 2;
+	u64 fc_hyst_bits          : 4;
+	u64 fc_up_crossing        : 1;
+	u64 reserved_297_299      : 3;
+	u64 update_time           : 16;
+	u64 reserved_316_319      : 4;
+	u64 fc_addr;			/* W5 */
+	u64 ptr_start;			/* W6 */
+	u64 ptr_end;			/* W7 */
+	u64 bpid_0                : 12;
+	u64 reserved_524_535      : 12;
+	u64 err_int               : 8;
+	u64 err_int_ena           : 8;
+	u64 thresh_int            : 1;
+	u64 thresh_int_ena        : 1;
+	u64 thresh_up             : 1;
+	u64 reserved_555          : 1;
+	u64 thresh_qint_idx       : 7;
+	u64 reserved_563          : 1;
+	u64 err_qint_idx          : 7;
+	u64 reserved_571_575      : 5;
+	u64 thresh                : 36;
+	u64 rsvd_612_615	  : 4;
+	u64 fc_msh_dst		  : 11;
+	u64 reserved_627_630      : 4;
+	u64 op_dpc_ena            : 1;
+	u64 op_dpc_set            : 5;
+	u64 reserved_637_637      : 1;
+	u64 stream_ctx            : 1;
+	u64 reserved_639          : 1;
+	u64 reserved_640_703;		/* W10 */
+	u64 reserved_704_767;		/* W11 */
+	u64 reserved_768_831;		/* W12 */
+	u64 reserved_832_895;		/* W13 */
+	u64 reserved_896_959;		/* W14 */
+	u64 reserved_960_1023;		/* W15 */
+};
+
 #endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 544efd4817c1..682924da1d9e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -203,6 +203,8 @@ M(NPA_LF_ALLOC,		0x400, npa_lf_alloc,				\
 M(NPA_LF_FREE,		0x401, npa_lf_free, msg_req, msg_rsp)		\
 M(NPA_AQ_ENQ,		0x402, npa_aq_enq, npa_aq_enq_req, npa_aq_enq_rsp)   \
 M(NPA_HWCTX_DISABLE,	0x403, npa_hwctx_disable, hwctx_disable_req, msg_rsp)\
+M(NPA_CN20K_AQ_ENQ,	0x404, npa_cn20k_aq_enq, npa_cn20k_aq_enq_req,	\
+				npa_cn20k_aq_enq_rsp)			\
 /* SSO/SSOW mbox IDs (range 0x600 - 0x7FF) */				\
 /* TIM mbox IDs (range 0x800 - 0x9FF) */				\
 /* CPT mbox IDs (range 0xA00 - 0xBFF) */				\
@@ -829,6 +831,39 @@ struct npa_aq_enq_rsp {
 	};
 };
 
+struct npa_cn20k_aq_enq_req {
+	struct mbox_msghdr hdr;
+	u32 aura_id;
+	u8 ctype;
+	u8 op;
+	union {
+		/* Valid when op == WRITE/INIT and ctype == AURA.
+		 * LF fills the pool_id in aura.pool_addr. AF will translate
+		 * the pool_id to pool context pointer.
+		 */
+		struct npa_cn20k_aura_s aura;
+		/* Valid when op == WRITE/INIT and ctype == POOL */
+		struct npa_cn20k_pool_s pool;
+	};
+	/* Mask data when op == WRITE (1=write, 0=don't write) */
+	union {
+		/* Valid when op == WRITE and ctype == AURA */
+		struct npa_cn20k_aura_s aura_mask;
+		/* Valid when op == WRITE and ctype == POOL */
+		struct npa_cn20k_pool_s pool_mask;
+	};
+};
+
+struct npa_cn20k_aq_enq_rsp {
+	struct mbox_msghdr hdr;
+	union {
+		/* Valid when op == READ and ctype == AURA */
+		struct npa_cn20k_aura_s aura;
+		/* Valid when op == READ and ctype == POOL */
+		struct npa_cn20k_pool_s pool;
+	};
+};
+
 /* Disable all contexts of type 'ctype' */
 struct hwctx_disable_req {
 	struct mbox_msghdr hdr;
-- 
2.34.1


