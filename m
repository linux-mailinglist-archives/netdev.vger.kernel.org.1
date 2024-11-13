Return-Path: <netdev+bounces-144318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC519C68CE
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 06:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 432C51F21F7B
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 05:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC0E176AAE;
	Wed, 13 Nov 2024 05:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Un4X+DS7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AC417C22E
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 05:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731476399; cv=none; b=Y552+QPHtbUXHrQdn2YpMQ5m/GhFj9SUCyL82UKrPQTSVGG1gJwZysRiRO19T1mAYNPE2T0zNWluTRJfmsIWjbRbCM+Bvk4B5saaAhn+XEwJZQY3TudcUo0C8gpHNe2B+smXj1AetOjpD9xeVB1+guARrb8igvdCTBSTktjab80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731476399; c=relaxed/simple;
	bh=XfS7yQZzw2tyb+KDfwUMibufdhtqSILIsH5my5ENvi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eso1aDTNTFlCLdq5Ldl95fevxPQmapnlsxr2bWw9+kKfxE45gAPItlPSco4SWqjuNv2KmWUmnhypjnNW8QHj664DLRnG83jVp0GbJskk16VqhdvBR5e7iMf2YksxTF+Cp69nWsDO0aatTWLrPAp6HXsm37NTLEcDj2ctjdJKHtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Un4X+DS7; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-460ad98b043so3188321cf.1
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 21:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731476396; x=1732081196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IN2FC8eaVBMz8jzqHpmhy39+1EIFsz9YNLVu7HrNRI0=;
        b=Un4X+DS7e7MfHIn4Y23DFz8aYf+BVs0ZcvaGgEizUEGZzXjCe9xhgb+XKm4mh7+9dy
         rmcDUfeWDXWnt5uGrhqBGQKZhWFSmWnsIU24PHBsAnxyXQj5amNGWi3Ezf8TfWy3Tghz
         QNdBnHFoaxQFYGz0DYHovqH/ZsDBs87z9+NSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731476396; x=1732081196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IN2FC8eaVBMz8jzqHpmhy39+1EIFsz9YNLVu7HrNRI0=;
        b=SqgNPybk1EPoAb5TZ7Ec1YQQZGP68x4GCQPPVNBLjsIhiniu/+G8Xkh5ZsBNd4R3iU
         sumaUmFw0JYh4eDU0Jf+KBStO1P/vEE5beCqQqFnY0t1yrHc7nfNKZAGhcbHga2jDZwH
         ZkiLU1WW0VEhLrdU+w87PrHLh9+bLzOAUGC+mWCgWM/BMmrs+FpHCJs2hsgUUM/90bRl
         pdOaVPD8tLOYuqez+ID5xZQkj6NDPJRCCqVIAk3B0908P519k+HNBZUkBX/TzOXF/RlE
         9c211r0lhYZvn3DHA9eLyFVLuf3KbuCSjbQyAmk53qRSP8Y5ru3KPjB3HZ79QwvNZxtP
         BZeA==
X-Gm-Message-State: AOJu0YwZnN7Y/ybLrsXuU1bu/3E5BfH7hjiK12485UQosGcevBD55EWE
	tz6saPQILrgwtRhKehHqvz0lDtysXXbnM48DpT6LVvBwt6VCqp6c+PJ2Av4Ocw==
X-Google-Smtp-Source: AGHT+IFHHbXdr6bszTZ9RKqd5EJ/CahDgGKEnQRtYf41PUVGju6RZ8ey0DPZrXHx6Ng9IoditAutLg==
X-Received: by 2002:ac8:5fd4:0:b0:45f:890c:5f49 with SMTP id d75a77b69052e-46309ba8d5bmr285182741cf.24.1731476396446;
        Tue, 12 Nov 2024 21:39:56 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff5e14f9sm83457491cf.86.2024.11.12.21.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 21:39:55 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	andrew.gospodarek@broadcom.com,
	hongguang.gao@broadcom.com,
	shruti.parab@broadcom.com
Subject: [PATCH net-next 05/11] bnxt_en: Allocate backing store memory for FW trace logs
Date: Tue, 12 Nov 2024 21:36:43 -0800
Message-ID: <20241113053649.405407-6-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20241113053649.405407-1-michael.chan@broadcom.com>
References: <20241113053649.405407-1-michael.chan@broadcom.com>
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
index 7355db3e060c..fb315acf5a4b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2462,6 +2462,15 @@ static bool bnxt_auto_speed_updated(struct bnxt_link_info *link_info)
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
@@ -8742,16 +8751,34 @@ static int bnxt_backing_store_cfg_v2(struct bnxt *bp, u32 ena)
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
@@ -8774,7 +8801,7 @@ static void bnxt_free_one_ctx_mem(struct bnxt *bp,
 
 	ctxm->last = 0;
 
-	if (ctxm->mem_valid && !force)
+	if (ctxm->mem_valid && !force && (ctxm->flags & BNXT_CTX_MEM_PERSIST))
 		return;
 
 	ctx_pg = ctxm->pg_info;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 5fcb5a980bdf..409882c4ac7f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1880,6 +1880,13 @@ struct bnxt_ctx_mem_type {
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
@@ -1920,21 +1927,30 @@ struct bnxt_ctx_mem_type {
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
@@ -2792,6 +2808,7 @@ int bnxt_alloc_rx_data(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 		       u16 prod, gfp_t gfp);
 void bnxt_reuse_rx_data(struct bnxt_rx_ring_info *rxr, u16 cons, void *data);
 u32 bnxt_fw_health_readl(struct bnxt *bp, int reg_idx);
+bool bnxt_bs_trace_avail(struct bnxt *bp, u16 type);
 void bnxt_set_tpa_flags(struct bnxt *bp);
 void bnxt_set_ring_params(struct bnxt *);
 int bnxt_set_rx_skb_mode(struct bnxt *bp, bool page_mode);
-- 
2.30.1


