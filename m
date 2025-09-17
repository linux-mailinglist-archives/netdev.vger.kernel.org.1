Return-Path: <netdev+bounces-223846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16458B7DB21
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5287E2A7F69
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 04:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD483302176;
	Wed, 17 Sep 2025 04:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fIXcQktr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f99.google.com (mail-io1-f99.google.com [209.85.166.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC8030216D
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 04:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758082170; cv=none; b=GTUB+WXwuJAwZ+Y8hSW32oR3W/6Ii7Fn55t4bQxmcRW8UrnWRN9vC+J74W+J1vuhc6/xyfBoj44J6XvKuPHHta88FeEI/GoGUBKyKGiRmqt/KHBx4OavvnHU5e+X7g3ujHYTeX9JIXNJDj/78ozr6f/3A0/nBQN57ip0V+C/UpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758082170; c=relaxed/simple;
	bh=yv2OKb3anP1ZQ8ro/Pla3Gdf1M77nGMZzLYP7F6wfFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=joLy/rKN3uqEWwAu9X0wOwOX7NXrA73bWgd8CHDBVI6lzEk8mu4X1Y7hJgvBgViZjBs6yY6BGn4u3LAgf2FdvCBysSW4APEqBvtZ9TKFLc2xPhSxm4qGSFEh/IB7kVmDWmCqI1A0R+CayF6QGwA0kAUfGEvJaot2pUYr+RMIoK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fIXcQktr; arc=none smtp.client-ip=209.85.166.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f99.google.com with SMTP id ca18e2360f4ac-88432e27c77so164811639f.2
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758082168; x=1758686968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WoomCPCq0tyHvMQbaaXakUhAPVtSapuHHp1N2CHOpTU=;
        b=rbJRRve+IBeVaaskpyOhXxspeyaT4S4E/Ywpz1/syVwA3Eg4YyF5JyxpFDWgy2Q5z5
         ksMh8HOloLcxeDMnjmRKc9mhWxjtYKd4Pq30lQRrAJnXoq95b5T7Uq3amtA2p+ChMTj6
         eZbMl+pXJhxOwweY8YCyIoixwAsKohHVG7UlapSQMxEnAgYPgIV7PGkat7L63spIi329
         RgKIzQHMHH3li+GcKT+c4Le/T3B1Z+n2UG+M+FNV+tsyKPcZbSbUXCZkzrLPRfIenbMg
         F29WmMEj42WOEhpCqkxaTOjEwBRIQGAAjshgvVXUSv+iHoadbcSSxnqLG2HPJ8wmPceb
         77zw==
X-Gm-Message-State: AOJu0YzCt+1z8pThu96MFfoopmVHAEDVwYHpnlczGuApl5dnBmMipvD6
	YRVcIH7KSYOnjfM4b5Ie1HSgvQK4zksQVQZQyTCIaF0O5P9leVjzeZxmYdiTZs0OeZRXGFkNEya
	Pb/C2de0QZiTg6llMGE8HOSKQk95FHGT7Ex1TbGEeAHMmz+Icm7CIrfouZpoJWXfix6Id5tpofl
	xVHQZLsSSLMg5qZQZgaF2l2L9yax1SB9cIdJyx3jkATk9SZCvPiq+JWk1KicV6T2AqbpoS77rh2
	E4WfcIbZKE=
X-Gm-Gg: ASbGnctB40f9hLLzivKSZEhgqLjAMiTL+co20r3NDnpzSirslW2lFlhCOg4tKno2Up9
	QSzwXI0Ku22Wo0GBjD/XTsexT8nYgyNk4s0Pd+rSkJR1KH5rqQF2hVdss8trG2unnIj1VfBeTMe
	d+65IqOlpGgAPyjk7Enbe0n+MkV2j6FLEZSTa9f+hdIjPjtfHCFULn9CxSkGsSCMgvay1wUVc74
	NPJ+kFOXu9VGrZTx2oWcs+ojL1l3c0b4TY9Ia9lpW76iH8yq12xsCdb9jMz7CCkjiCG5I+0nrZV
	JjaP/O6xWeY6/vucCJzc++YVVqQ4q8MomHLE0DfNnU9uRuAmlMqMeLVjOZxTE4CWyXrXCa8KRgd
	bPQZAHnmMg2oPpVO0rgWVvtjacpPCTJQuBMsaSZ8Ebo2grXSG+6g5zywTgdgfyKx0JZh9HEU2hi
	Kl9w==
X-Google-Smtp-Source: AGHT+IGUbaSSMr9HbuqW0NG/Whc6eJd1Vqx4WeO37cDLp2PB13MGdBXJg5yrs6KBRmlfg4VaMOaSW5W6wIO6
X-Received: by 2002:a05:6602:13d2:b0:893:dd5e:abc0 with SMTP id ca18e2360f4ac-89d1959e42amr159419539f.4.1758082168059;
        Tue, 16 Sep 2025 21:09:28 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-5121be6c80dsm712706173.21.2025.09.16.21.09.26
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Sep 2025 21:09:28 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-329c76f70cbso5366076a91.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758082165; x=1758686965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WoomCPCq0tyHvMQbaaXakUhAPVtSapuHHp1N2CHOpTU=;
        b=fIXcQktrcl1rHD0RgKO2CKTngCfxH+Ghfr+AAXqJXrz5RcusmnhrkVY+QP3nA6CFEv
         0aamRcA+VC93ZCcFz9YFgavhCT/tZq4ZllBd9bF331EOMClCBz4WM14bxchbATRmtYp8
         83PqUm8j5Dbz3yLcd5VBhCOPE4nBbmVok0Tdc=
X-Received: by 2002:a17:90b:268b:b0:32e:32e4:9775 with SMTP id 98e67ed59e1d1-32ee3ed1932mr954323a91.12.1758082165245;
        Tue, 16 Sep 2025 21:09:25 -0700 (PDT)
X-Received: by 2002:a17:90b:268b:b0:32e:32e4:9775 with SMTP id 98e67ed59e1d1-32ee3ed1932mr954299a91.12.1758082164758;
        Tue, 16 Sep 2025 21:09:24 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ee223f2ecsm558562a91.18.2025.09.16.21.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 21:09:24 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Shruti Parab <shruti.parab@broadcom.com>,
	Hongguang Gao <hongguang.gao@broadcom.com>
Subject: [PATCH net-next v2 05/10] bnxt_en: Add fw log trace support for 5731X/5741X chips
Date: Tue, 16 Sep 2025 21:08:34 -0700
Message-ID: <20250917040839.1924698-6-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20250917040839.1924698-1-michael.chan@broadcom.com>
References: <20250917040839.1924698-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Shruti Parab <shruti.parab@broadcom.com>

These older chips now support the fw log traces via backing store
qcaps_v2. No other backing store memory types are supported besides
the fw trace types.

Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Shruti Parab <shruti.parab@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          | 9 +++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          | 3 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c | 3 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.h | 1 +
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index b4732276f0ca..481395691a9d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -265,6 +265,7 @@ const u16 bnxt_bstore_to_trace[] = {
 	[BNXT_CTX_CA1]		= DBG_LOG_BUFFER_FLUSH_REQ_TYPE_CA1_TRACE,
 	[BNXT_CTX_CA2]		= DBG_LOG_BUFFER_FLUSH_REQ_TYPE_CA2_TRACE,
 	[BNXT_CTX_RIGP1]	= DBG_LOG_BUFFER_FLUSH_REQ_TYPE_RIGP1_TRACE,
+	[BNXT_CTX_KONG]		= DBG_LOG_BUFFER_FLUSH_REQ_TYPE_AFM_KONG_HWRM_TRACE,
 };
 
 static struct workqueue_struct *bnxt_pf_wq;
@@ -9158,7 +9159,7 @@ static int bnxt_backing_store_cfg_v2(struct bnxt *bp)
 	int rc = 0;
 	u16 type;
 
-	for (type = BNXT_CTX_SRT; type <= BNXT_CTX_RIGP1; type++) {
+	for (type = BNXT_CTX_SRT; type <= BNXT_CTX_KONG; type++) {
 		ctxm = &ctx->ctx_arr[type];
 		if (!bnxt_bs_trace_avail(bp, type))
 			continue;
@@ -9309,6 +9310,10 @@ static int bnxt_alloc_ctx_mem(struct bnxt *bp)
 	if (!ctx || (ctx->flags & BNXT_CTX_FLAG_INITED))
 		return 0;
 
+	ena = 0;
+	if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
+		goto skip_legacy;
+
 	ctxm = &ctx->ctx_arr[BNXT_CTX_QP];
 	l2_qps = ctxm->qp_l2_entries;
 	qp1_qps = ctxm->qp_qp1_entries;
@@ -9317,7 +9322,6 @@ static int bnxt_alloc_ctx_mem(struct bnxt *bp)
 	ctxm = &ctx->ctx_arr[BNXT_CTX_SRQ];
 	srqs = ctxm->srq_l2_entries;
 	max_srqs = ctxm->max_entries;
-	ena = 0;
 	if ((bp->flags & BNXT_FLAG_ROCE_CAP) && !is_kdump_kernel()) {
 		pg_lvl = 2;
 		if (BNXT_SW_RES_LMT(bp)) {
@@ -9411,6 +9415,7 @@ static int bnxt_alloc_ctx_mem(struct bnxt *bp)
 		ena |= FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_SP << i;
 	ena |= FUNC_BACKING_STORE_CFG_REQ_DFLT_ENABLES;
 
+skip_legacy:
 	if (bp->fw_cap & BNXT_FW_CAP_BACKING_STORE_V2)
 		rc = bnxt_backing_store_cfg_v2(bp);
 	else
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 1bb2a5de88cd..37c3f6507250 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1968,10 +1968,11 @@ struct bnxt_ctx_mem_type {
 #define BNXT_CTX_CA1	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_CA1_TRACE
 #define BNXT_CTX_CA2	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_CA2_TRACE
 #define BNXT_CTX_RIGP1	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_RIGP1_TRACE
+#define BNXT_CTX_KONG	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_AFM_KONG_HWRM_TRACE
 
 #define BNXT_CTX_MAX	(BNXT_CTX_TIM + 1)
 #define BNXT_CTX_L2_MAX	(BNXT_CTX_FTQM + 1)
-#define BNXT_CTX_V2_MAX	(BNXT_CTX_RIGP1 + 1)
+#define BNXT_CTX_V2_MAX	(BNXT_CTX_KONG + 1)
 #define BNXT_CTX_INV	((u16)-1)
 
 struct bnxt_ctx_mem_info {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
index 18d6c94d5cb8..a0a37216efb3 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
@@ -36,6 +36,7 @@ static const u16 bnxt_bstore_to_seg_id[] = {
 	[BNXT_CTX_CA1]			= BNXT_CTX_MEM_SEG_CA1,
 	[BNXT_CTX_CA2]			= BNXT_CTX_MEM_SEG_CA2,
 	[BNXT_CTX_RIGP1]		= BNXT_CTX_MEM_SEG_RIGP1,
+	[BNXT_CTX_KONG]			= BNXT_CTX_MEM_SEG_KONG,
 };
 
 static int bnxt_dbg_hwrm_log_buffer_flush(struct bnxt *bp, u16 type, u32 flags,
@@ -359,7 +360,7 @@ static u32 bnxt_get_ctx_coredump(struct bnxt *bp, void *buf, u32 offset,
 
 	if (buf)
 		buf += offset;
-	for (type = 0 ; type <= BNXT_CTX_RIGP1; type++) {
+	for (type = 0; type <= BNXT_CTX_KONG; type++) {
 		struct bnxt_ctx_mem_type *ctxm = &ctx->ctx_arr[type];
 		bool trace = bnxt_bs_trace_avail(bp, type);
 		u32 seg_id = bnxt_bstore_to_seg_id[type];
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.h
index d1cd6387f3ab..8d0f58c74cc3 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.h
@@ -102,6 +102,7 @@ struct bnxt_driver_segment_record {
 #define BNXT_CTX_MEM_SEG_CA1	0x9
 #define BNXT_CTX_MEM_SEG_CA2	0xa
 #define BNXT_CTX_MEM_SEG_RIGP1	0xb
+#define BNXT_CTX_MEM_SEG_KONG	0xd
 
 #define BNXT_CRASH_DUMP_LEN	(8 << 20)
 
-- 
2.51.0


