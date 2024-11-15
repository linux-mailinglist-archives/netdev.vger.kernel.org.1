Return-Path: <netdev+bounces-145311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF549CF08D
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 16:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A984B3126D
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 15:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95851D516F;
	Fri, 15 Nov 2024 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="e2cz86/E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367DB1D5160
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731683782; cv=none; b=EVoDkXcXlGeh7kINal+IBEhNHDtNUnHjMkfFNqJbgVi7QB9cnB/57YPvS6FWwatGTfSH0aSKSgS3pFNJMeGM0m8BDnVkSp1reDhzdgFun5SxNyiTOeQR25RwSWB6rRSmEFKzhZ/uSPrpKtY2uvk1ljsJjf7spEpLf1T8PSMDfNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731683782; c=relaxed/simple;
	bh=5CxTAwREzf51+Iq1z2c4FkIRBEimFiRap24OasETLXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c314ZAhr/lJlHKa+1wPOEKh7nGV2dbh2fLQUPd5UyASbEd/AuuSg3/GEDTPvNXWQbZi7BREPdr91Xj/kZ7UYxmhQaq5uxTny+rVUgNrjBlwpiLCrgWTOYuPt6j7FNg/HVhQ21RxUvkdtdThoJbis5lOt8MLXx+vK0eageHJk3jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=e2cz86/E; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21116b187c4so16616115ad.3
        for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 07:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731683780; x=1732288580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8UQ9hdSvscAsYixVXiexQJrKM4zc8TVPKTwRW0ePBo=;
        b=e2cz86/ECcJyVmp5I2T5toAU3dUgYQvg7ux9NGJxQaI1ukYmO8XztsF8B04Wnn7f1q
         NWkBYgwKQoey/arGQsc77kegZoBe27AMiB5aClfAr5y9eouQ1aDee7MF7FUEFmmpi5wg
         psoAwFZBamEnxNMeDIsiKKqMOM08j/egC2E+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731683780; x=1732288580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o8UQ9hdSvscAsYixVXiexQJrKM4zc8TVPKTwRW0ePBo=;
        b=MCQk7/qad0CQseDpmyzAZqWhBc1n6dW0UcvDOZ4IWpdsEowCMwg0F6MPNVwV7xC0aq
         Ua1o7xL7q1U5XFYRacoMykuhsm7/Qh6xHmoTDZmF9i5miHCvs9lz6gOkemvpUuCM6Ln9
         /FzPEj179+iAOm6P/Tm6f3b+HnSw3sf1wYo30q+ltoS22L9cItaGOW+n8ELCcE9Rchej
         ol9p3bnzRNeYZybppiSAToSECdJovu1OewbRzDQhb0RBTOAdlcolYgxnsbLFY86P+NyW
         gBP0Nb0b0zayUpBlHAGlb8cQCSwMT003WR9VsEGLMr4iuQtE/7Rqf6cVjz7uTUiaBbaT
         oRLw==
X-Gm-Message-State: AOJu0Ywh817KYVM6A74qWtOOTXiazveubmlSmtlQMdWgjgFkaTqhwSdn
	yeaJbQr06DVr0QIGWLrxjeRVbdak1DGoYN+9jS6Qu7pBachcl/Q1uZcpwoeJ+w==
X-Google-Smtp-Source: AGHT+IHP52Rx9yD3jfQ3kYehnKAm26i1+VzfRQer9jAtpvdyvUIA7vaZBOatRIz5QKZ/lrTD68pM6w==
X-Received: by 2002:a17:902:f683:b0:20c:ac9a:d751 with SMTP id d9443c01a7336-211d0d85bf6mr50610075ad.32.1731683780566;
        Fri, 15 Nov 2024 07:16:20 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0eca26fsm13357925ad.106.2024.11.15.07.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:16:19 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	andrew.gospodarek@broadcom.com,
	shruti.parab@broadcom.com,
	hongguang.gao@broadcom.com
Subject: [PATCH net-next v2 05/11] bnxt_en: Allocate backing store memory for FW trace logs
Date: Fri, 15 Nov 2024 07:14:31 -0800
Message-ID: <20241115151438.550106-6-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20241115151438.550106-1-michael.chan@broadcom.com>
References: <20241115151438.550106-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shruti Parab <shruti.parab@broadcom.com>

Allocate the new FW trace log backing store context memory types
if they are supported by the FW.  FW debug logs are DMA'ed to the host
backing store memory when the on-chip buffers are full.  If host
memory cannot be allocated for these memory types, the driver
will not abort.

Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
Signed-off-by: Shruti Parab <shruti.parab@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 43 ++++++++++++++++++-----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 27 +++++++++++---
 2 files changed, 57 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 02a8d568857b..c7e7cb98f03b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2461,6 +2461,15 @@ static bool bnxt_auto_speed_updated(struct bnxt_link_info *link_info)
 	return false;
 }
 
+bool bnxt_bs_trace_avail(struct bnxt *bp, u16 type)
+{
+	u32 flags = bp->ctx->ctx_arr[type].flags;
+
+	return (flags & BNXT_CTX_MEM_TYPE_VALID) &&
+		((flags & BNXT_CTX_MEM_FW_TRACE) ||
+		 (flags & BNXT_CTX_MEM_FW_BIN_TRACE));
+}
+
 #define BNXT_EVENT_THERMAL_CURRENT_TEMP(data2)				\
 	((data2) &							\
 	  ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA2_CURRENT_TEMP_MASK)
@@ -8744,16 +8753,34 @@ static int bnxt_backing_store_cfg_v2(struct bnxt *bp, u32 ena)
 {
 	struct bnxt_ctx_mem_info *ctx = bp->ctx;
 	struct bnxt_ctx_mem_type *ctxm;
-	u16 last_type;
+	u16 last_type = BNXT_CTX_INV;
 	int rc = 0;
 	u16 type;
 
-	if (!ena)
-		return 0;
-	else if (ena & FUNC_BACKING_STORE_CFG_REQ_ENABLES_TIM)
-		last_type = BNXT_CTX_MAX - 1;
-	else
-		last_type = BNXT_CTX_L2_MAX - 1;
+	for (type = BNXT_CTX_SRT; type <= BNXT_CTX_RIGP1; type++) {
+		ctxm = &ctx->ctx_arr[type];
+		if (!bnxt_bs_trace_avail(bp, type))
+			continue;
+		if (!ctxm->mem_valid) {
+			rc = bnxt_setup_ctxm_pg_tbls(bp, ctxm,
+						     ctxm->max_entries, 1);
+			if (rc) {
+				netdev_warn(bp->dev, "Unable to setup ctx page for type:0x%x.\n",
+					    type);
+				continue;
+			}
+			last_type = type;
+		}
+	}
+
+	if (last_type == BNXT_CTX_INV) {
+		if (!ena)
+			return 0;
+		else if (ena & FUNC_BACKING_STORE_CFG_REQ_ENABLES_TIM)
+			last_type = BNXT_CTX_MAX - 1;
+		else
+			last_type = BNXT_CTX_L2_MAX - 1;
+	}
 	ctx->ctx_arr[last_type].last = 1;
 
 	for (type = 0 ; type < BNXT_CTX_V2_MAX; type++) {
@@ -8776,7 +8803,7 @@ static void bnxt_free_one_ctx_mem(struct bnxt *bp,
 
 	ctxm->last = 0;
 
-	if (ctxm->mem_valid && !force)
+	if (ctxm->mem_valid && !force && (ctxm->flags & BNXT_CTX_MEM_PERSIST))
 		return;
 
 	ctx_pg = ctxm->pg_info;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index a092ed3c2248..d02860e7ea1c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1881,6 +1881,13 @@ struct bnxt_ctx_mem_type {
 	u16	entry_size;
 	u32	flags;
 #define BNXT_CTX_MEM_TYPE_VALID FUNC_BACKING_STORE_QCAPS_V2_RESP_FLAGS_TYPE_VALID
+#define BNXT_CTX_MEM_FW_TRACE		\
+	FUNC_BACKING_STORE_QCAPS_V2_RESP_FLAGS_FW_DBG_TRACE
+#define BNXT_CTX_MEM_FW_BIN_TRACE	\
+	FUNC_BACKING_STORE_QCAPS_V2_RESP_FLAGS_FW_BIN_DBG_TRACE
+#define BNXT_CTX_MEM_PERSIST		\
+	FUNC_BACKING_STORE_QCAPS_V2_RESP_FLAGS_NEXT_BS_OFFSET
+
 	u32	instance_bmap;
 	u8	init_value;
 	u8	entry_multiple;
@@ -1921,21 +1928,30 @@ struct bnxt_ctx_mem_type {
 #define BNXT_CTX_FTQM	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_FP_TQM_RING
 #define BNXT_CTX_MRAV	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_MRAV
 #define BNXT_CTX_TIM	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_TIM
-#define BNXT_CTX_TKC	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_TKC
-#define BNXT_CTX_RKC	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_RKC
+#define BNXT_CTX_TCK	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_TX_CK
+#define BNXT_CTX_RCK	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_RX_CK
 #define BNXT_CTX_MTQM	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_MP_TQM_RING
 #define BNXT_CTX_SQDBS	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_SQ_DB_SHADOW
 #define BNXT_CTX_RQDBS	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_RQ_DB_SHADOW
 #define BNXT_CTX_SRQDBS	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_SRQ_DB_SHADOW
 #define BNXT_CTX_CQDBS	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_CQ_DB_SHADOW
-#define BNXT_CTX_QTKC	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_QUIC_TKC
-#define BNXT_CTX_QRKC	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_QUIC_RKC
 #define BNXT_CTX_TBLSC	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_TBL_SCOPE
 #define BNXT_CTX_XPAR	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_XID_PARTITION
+#define BNXT_CTX_SRT	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_SRT_TRACE
+#define BNXT_CTX_SRT2	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_SRT2_TRACE
+#define BNXT_CTX_CRT	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_CRT_TRACE
+#define BNXT_CTX_CRT2	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_CRT2_TRACE
+#define BNXT_CTX_RIGP0	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_RIGP0_TRACE
+#define BNXT_CTX_L2HWRM	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_L2_HWRM_TRACE
+#define BNXT_CTX_REHWRM	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_ROCE_HWRM_TRACE
+#define BNXT_CTX_CA0	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_CA0_TRACE
+#define BNXT_CTX_CA1	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_CA1_TRACE
+#define BNXT_CTX_CA2	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_CA2_TRACE
+#define BNXT_CTX_RIGP1	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_RIGP1_TRACE
 
 #define BNXT_CTX_MAX	(BNXT_CTX_TIM + 1)
 #define BNXT_CTX_L2_MAX	(BNXT_CTX_FTQM + 1)
-#define BNXT_CTX_V2_MAX	(BNXT_CTX_XPAR + 1)
+#define BNXT_CTX_V2_MAX	(BNXT_CTX_RIGP1 + 1)
 #define BNXT_CTX_INV	((u16)-1)
 
 struct bnxt_ctx_mem_info {
@@ -2793,6 +2809,7 @@ int bnxt_alloc_rx_data(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 		       u16 prod, gfp_t gfp);
 void bnxt_reuse_rx_data(struct bnxt_rx_ring_info *rxr, u16 cons, void *data);
 u32 bnxt_fw_health_readl(struct bnxt *bp, int reg_idx);
+bool bnxt_bs_trace_avail(struct bnxt *bp, u16 type);
 void bnxt_set_tpa_flags(struct bnxt *bp);
 void bnxt_set_ring_params(struct bnxt *);
 int bnxt_set_rx_skb_mode(struct bnxt *bp, bool page_mode);
-- 
2.30.1


