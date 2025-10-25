Return-Path: <netdev+bounces-232799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D87E6C08F24
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 12:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7861B4E5A71
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 10:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471C42F532F;
	Sat, 25 Oct 2025 10:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BzC7L35t"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A2D2F4A18
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 10:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761388420; cv=none; b=NWCLJJYEQ8lNIwWjGSFSgQkMeh/BhkokkjjNyxRzyiUxoib8cLvmk2iOJgaKj/G+EUSdqlEiVzFleEUQFj3bbzVZ8cLoSrtaugaqHsIVL5G4QOkaOWrYhsuBuNLsx6Pv7AVG3SEfw41yTJF/hsi5AuaR+q1SBBAajBZnVdOqkSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761388420; c=relaxed/simple;
	bh=Afx+/xkzxVOsdvuDL/Gwccev7FnBla3wpM5JrNUuvfA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lqShK/wA7S5PP5yLSH3GN/A4nR+XRvovcoXMvzwCvzYU5/K+nAfKIcyspZdH7U9+WwuqY+C5wn41TAA9JmjXDZQDBCl9PT/kjybFOrBZv4oqaIVinESKKtor6IjjQDHU47EfLYRk2CpCAsoJzYDK7D8kPcVPnnMwLCpZaMZkkek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=BzC7L35t; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59P6exa8505568;
	Sat, 25 Oct 2025 03:33:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=AYLs461dvWcM2UEfhlP8o3yR1
	xYIykmmMoAvHX99V6c=; b=BzC7L35tzARcZQG0PZNhHcKfmCm6i5TTLjcgKkWu3
	dgJJ3SETgh/xUrWE1e1bRYuYayYzP1YHOutUsOIG/uG0Qm9imLjLsmz36A1Qv4bi
	Bfm0bU24ypk6T5qBrBsVrUEmHMjix6aMPfezvKJ4fd92Pb2tWEAkW32XOgvlEiXE
	eoW+eCi/Bl99OZFY8EmY0g8oGOs7Qws6wu2OApnIh6by+xx4Jq+ORqzmZW16pq7A
	iJYbS50TYrBOD2qSMSLw1XwVpDq1N7CrmooHB9Tl+rpAxf5JVfNKIwBsD5BbB6hH
	FsEnQeEkBqS2DK5X/dc3bFhgyhO80SyuWYA9U+naxTLvA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4a0nm3rjyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Oct 2025 03:33:30 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sat, 25 Oct 2025 03:33:39 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sat, 25 Oct 2025 03:33:39 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 445405B6921;
	Sat, 25 Oct 2025 03:33:25 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>,
        <jerinj@marvell.com>, <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <saikrishnag@marvell.com>, <netdev@vger.kernel.org>,
        Subbaraya Sundeep
	<sbhatta@marvell.com>
Subject: [net-next v4 04/11] octeontx2-af: Add cn20k NPA block contexts
Date: Sat, 25 Oct 2025 16:02:40 +0530
Message-ID: <1761388367-16579-5-git-send-email-sbhatta@marvell.com>
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
X-Proofpoint-GUID: 5vhiWxkFpRkfUJqbgyXPCc_5WPKIstTW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDA5NSBTYWx0ZWRfX0rh8QjMp3GwF
 Dgr578tyY5ZV4JXJQ33g7bK1GLFYNBYDi5QEaFbnZ3uPU9LzrytW+zkF/Eluevzjj9JRkmsRq5d
 eWt/qn7tf9nchT/Ev4oPsr9dbh2mbl9wbe5ARzTO2J74rGZRO9akayiuuA78LY4a0zq8JX4mkSa
 9iiZS8juJu1GKNrfrLYBj6SWJulJzyLr9fmuQSvbRTmiCOgcFEhqfKLPnMaL6U5k6WZPSxLgdrU
 K5jmM59+Jqg/J2xrFFJGV+kHMXQ9kcfQCj4pOBGw95/0cKc6FbMlbUTpjkHR2xIGsT7XndX1csL
 XpFQiCjTu9qYy3rIKfRGv/i9pKSmnGUcN1uB+8ey0Y5U98TQ7CgLoU0h1PRPXBzmBweOr/+WY3Y
 +sikd+T1YweQNkqQLkbTaX9QOsffcw==
X-Proofpoint-ORIG-GUID: 5vhiWxkFpRkfUJqbgyXPCc_5WPKIstTW
X-Authority-Analysis: v=2.4 cv=bpJBxUai c=1 sm=1 tr=0 ts=68fca77a cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=93rZ_s6btrDCt65eblEA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-25_03,2025-10-22_01,2025-03-28_01

From: Linu Cherian <lcherian@marvell.com>

New CN20K silicon has NPA hardware context structures different from
previous silicons. Add NPA aura and pool context definitions for cn20k.
Extend NPA context handling support to cn20k.

Signed-off-by: Linu Cherian <lcherian@marvell.com>
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/Makefile    |   3 +-
 .../ethernet/marvell/octeontx2/af/cn20k/npa.c |  21 +++
 .../marvell/octeontx2/af/cn20k/struct.h       | 135 ++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  35 +++++
 4 files changed, 193 insertions(+), 1 deletion(-)
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
index ff8f0d1809c8..763f6cabd7c2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
@@ -242,4 +242,139 @@ struct nix_cn20k_rq_ctx_s {
 
 static_assert(sizeof(struct nix_cn20k_rq_ctx_s) == NIX_MAX_CTX_SIZE);
 
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
+	u64 padding[8];
+};
+
+static_assert(sizeof(struct npa_cn20k_aura_s) == NIX_MAX_CTX_SIZE);
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
+static_assert(sizeof(struct npa_cn20k_pool_s) == NIX_MAX_CTX_SIZE);
+
 #endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 01086c52e78d..a3e273126e4e 100644
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
@@ -834,6 +836,39 @@ struct npa_aq_enq_rsp {
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
2.48.1


