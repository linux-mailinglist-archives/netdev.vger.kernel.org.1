Return-Path: <netdev+bounces-144319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B579C68CF
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 06:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA1712842A8
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 05:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7569A1779BD;
	Wed, 13 Nov 2024 05:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FkrSTIJ+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE30B176AA5
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 05:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731476401; cv=none; b=lGiaruS67PrBtmYiDOp2IVZ5t0NgEGYJAbMhUBIlORKJXx5+5slFnIsqUhSWN4WrpE5mGetFOEzI5Is3ZD4Lms102J0DjgM/MExrByMlXJ19rLteg1Z7YDbz2QNtMlbUuAEGMmv01SbGNh7jeDll+zgAgt3gSQmh8qCN+w3iRjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731476401; c=relaxed/simple;
	bh=FF6KTJQhtCZ27xQId3HWMkaX/0KPvwHhTS9VZ559OoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=saYyeVbqwL6It5zXvndS+Ja0GCCn5QO+OI++JU2JQDRhwBJEYrX6I0PTFH+pfVQU9mcctdBIca8jgh50a8qfCdw7WRzqPIYCta3axYiw3hKxgx7rSE8NoWzH/I2XLxveqDN5cjkhM6rNXQxxduXxpyOevzDZWRt+yzYKcwycwF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FkrSTIJ+; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-460c0f9c13eso3468161cf.0
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 21:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731476398; x=1732081198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjk6nWye+31ddxI1Nb9Oai037GmTxaNdXMo4q/XQv0o=;
        b=FkrSTIJ+Vb+/eOu1u372MdZcRxpBJcnnYQwp85RYqyek06PLqhvbAVoZctAr6KiDs+
         vtJBgMSOx5BoL0Ukrwki2SnjYwipM8sBsN3wWnrdNqzmCgDBLJuFejowMouxj+QOf4qj
         FD8RVu/kJg/RUKXnoVwCFMnYI9x4S8upto5ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731476398; x=1732081198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wjk6nWye+31ddxI1Nb9Oai037GmTxaNdXMo4q/XQv0o=;
        b=rTzjDI5RX7jYcW16pxbPmuJnHTZAwxMeKK0kJNOYvrA8zF2EyXmIkfdIcxRAxe76ou
         lWOv1zX1F8tP/CuUMQSTIfIY1c9StKOUJdaDqp7CpA/7YQF0CpkVqS4QFfjnDJstwrRV
         ewVAX1PvYh587RfEjd7srVbgCG4PaHpLPXvAcuHTD78G0KT0Z+IQRbXKEjBnbMYPjs/M
         IiQJHIrN4x74ZSSDK8YERMTIqwCA5GTpEehyqK8iAFr1jpXeoTNOxlUVnvqnrth82I8U
         5lNrY5mhcPwLzhpyHhmRxM0+GbBcp+SrZIKsurAlc1yrkZpqUHanAr6g53BekCS+B/cN
         R7dw==
X-Gm-Message-State: AOJu0YwStFzmNIUjlhlZHPTmrsup5ptmpq5Pv8wNhj7/KnCjqhwta1rB
	VQUqHAwGUQuN6B92/V9R9XKx3xq/OxZj6f8OsyVbLFBP8YxaoAZYXxFEnXsUjA==
X-Google-Smtp-Source: AGHT+IGyOcbXL7tiLvUZJb/FGEg8c4aIv/MQbJY8uCBj02ZyU7++qDr3eB0SRtDS9mBO2wqW2QMLfQ==
X-Received: by 2002:a05:622a:5519:b0:460:854f:a1c with SMTP id d75a77b69052e-4630864e551mr266063561cf.27.1731476398592;
        Tue, 12 Nov 2024 21:39:58 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff5e14f9sm83457491cf.86.2024.11.12.21.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 21:39:58 -0800 (PST)
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
Subject: [PATCH net-next 06/11] bnxt_en: Manage the FW trace context memory
Date: Tue, 12 Nov 2024 21:36:44 -0800
Message-ID: <20241113053649.405407-7-michael.chan@broadcom.com>
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

The FW trace memory pages will be added to the ethtool -w coredump
in later patches.  In addition to the raw data, the driver has to
add a header to provide the head and tail information on each FW
trace log segment when creating the coredump.  The FW sends an async
message to the driver after DMAing a chunk of logs to the context
memory to indicate the last offset containing the tail of the logs.
The driver needs to keep track of that.

Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
Signed-off-by: Shruti Parab <shruti.parab@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 66 +++++++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 22 ++++++++
 2 files changed, 88 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index fb315acf5a4b..b14d48ba5a32 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -245,6 +245,21 @@ static const u16 bnxt_async_events_arr[] = {
 	ASYNC_EVENT_CMPL_EVENT_ID_PPS_TIMESTAMP,
 	ASYNC_EVENT_CMPL_EVENT_ID_ERROR_REPORT,
 	ASYNC_EVENT_CMPL_EVENT_ID_PHC_UPDATE,
+	ASYNC_EVENT_CMPL_EVENT_ID_DBG_BUF_PRODUCER,
+};
+
+const u16 bnxt_bstore_to_trace[] = {
+	[BNXT_CTX_SRT]		= DBG_LOG_BUFFER_FLUSH_REQ_TYPE_SRT_TRACE,
+	[BNXT_CTX_SRT2]		= DBG_LOG_BUFFER_FLUSH_REQ_TYPE_SRT2_TRACE,
+	[BNXT_CTX_CRT]		= DBG_LOG_BUFFER_FLUSH_REQ_TYPE_CRT_TRACE,
+	[BNXT_CTX_CRT2]		= DBG_LOG_BUFFER_FLUSH_REQ_TYPE_CRT2_TRACE,
+	[BNXT_CTX_RIGP0]	= DBG_LOG_BUFFER_FLUSH_REQ_TYPE_RIGP0_TRACE,
+	[BNXT_CTX_L2HWRM]	= DBG_LOG_BUFFER_FLUSH_REQ_TYPE_L2_HWRM_TRACE,
+	[BNXT_CTX_REHWRM]	= DBG_LOG_BUFFER_FLUSH_REQ_TYPE_ROCE_HWRM_TRACE,
+	[BNXT_CTX_CA0]		= DBG_LOG_BUFFER_FLUSH_REQ_TYPE_CA0_TRACE,
+	[BNXT_CTX_CA1]		= DBG_LOG_BUFFER_FLUSH_REQ_TYPE_CA1_TRACE,
+	[BNXT_CTX_CA2]		= DBG_LOG_BUFFER_FLUSH_REQ_TYPE_CA2_TRACE,
+	[BNXT_CTX_RIGP1]	= DBG_LOG_BUFFER_FLUSH_REQ_TYPE_RIGP1_TRACE,
 };
 
 static struct workqueue_struct *bnxt_pf_wq;
@@ -2471,6 +2486,49 @@ bool bnxt_bs_trace_avail(struct bnxt *bp, u16 type)
 		 (flags & BNXT_CTX_MEM_FW_BIN_TRACE));
 }
 
+static void bnxt_bs_trace_init(struct bnxt *bp, struct bnxt_ctx_mem_type *ctxm)
+{
+	u32 mem_size, pages, rem_bytes, magic_byte_offset;
+	u16 trace_type = bnxt_bstore_to_trace[ctxm->type];
+	struct bnxt_ctx_pg_info *ctx_pg = ctxm->pg_info;
+	struct bnxt_ring_mem_info *rmem, *rmem_pg_tbl;
+	struct bnxt_bs_trace_info *bs_trace;
+	int last_pg;
+
+	if (ctxm->instance_bmap && ctxm->instance_bmap > 1)
+		return;
+
+	mem_size = ctxm->max_entries * ctxm->entry_size;
+	rem_bytes = mem_size % BNXT_PAGE_SIZE;
+	pages = DIV_ROUND_UP(mem_size, BNXT_PAGE_SIZE);
+
+	last_pg = (pages - 1) & (MAX_CTX_PAGES - 1);
+	magic_byte_offset = (rem_bytes ? rem_bytes : BNXT_PAGE_SIZE) - 1;
+
+	rmem = &ctx_pg[0].ring_mem;
+	bs_trace = &bp->bs_trace[trace_type];
+	bs_trace->ctx_type = ctxm->type;
+	bs_trace->trace_type = trace_type;
+	if (pages > MAX_CTX_PAGES) {
+		int last_pg_dir = rmem->nr_pages - 1;
+
+		rmem_pg_tbl = &ctx_pg[0].ctx_pg_tbl[last_pg_dir]->ring_mem;
+		bs_trace->magic_byte = rmem_pg_tbl->pg_arr[last_pg];
+	} else {
+		bs_trace->magic_byte = rmem->pg_arr[last_pg];
+	}
+	bs_trace->magic_byte += magic_byte_offset;
+	*bs_trace->magic_byte = BNXT_TRACE_BUF_MAGIC_BYTE;
+}
+
+#define BNXT_EVENT_BUF_PRODUCER_TYPE(data1)				\
+	(((data1) & ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_MASK) >>\
+	 ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_SFT)
+
+#define BNXT_EVENT_BUF_PRODUCER_OFFSET(data2)				\
+	(((data2) & ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA2_CURRENT_BUFFER_OFFSET_MASK) >>\
+	 ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA2_CURRENT_BUFFER_OFFSET_SFT)
+
 #define BNXT_EVENT_THERMAL_CURRENT_TEMP(data2)				\
 	((data2) &							\
 	  ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA2_CURRENT_TEMP_MASK)
@@ -2787,6 +2845,13 @@ static int bnxt_async_event_process(struct bnxt *bp,
 		hwrm_update_token(bp, seq_id, BNXT_HWRM_DEFERRED);
 		goto async_event_process_exit;
 	}
+	case ASYNC_EVENT_CMPL_EVENT_ID_DBG_BUF_PRODUCER: {
+		u16 type = (u16)BNXT_EVENT_BUF_PRODUCER_TYPE(data1);
+		u32 offset =  BNXT_EVENT_BUF_PRODUCER_OFFSET(data2);
+
+		bnxt_bs_trace_check_wrap(&bp->bs_trace[type], offset);
+		goto async_event_process_exit;
+	}
 	default:
 		goto async_event_process_exit;
 	}
@@ -8767,6 +8832,7 @@ static int bnxt_backing_store_cfg_v2(struct bnxt *bp, u32 ena)
 					    type);
 				continue;
 			}
+			bnxt_bs_trace_init(bp, ctxm);
 			last_type = type;
 		}
 	}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 409882c4ac7f..d3697e531d67 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2111,6 +2111,26 @@ enum board_idx {
 	NETXTREME_E_P7_VF,
 };
 
+#define BNXT_TRACE_BUF_MAGIC_BYTE ((u8)0xbc)
+#define BNXT_TRACE_MAX 11
+
+struct bnxt_bs_trace_info {
+	u8 *magic_byte;
+	u32 last_offset;
+	u8 wrapped:1;
+	u16 ctx_type;
+	u16 trace_type;
+};
+
+static inline void bnxt_bs_trace_check_wrap(struct bnxt_bs_trace_info *bs_trace,
+					    u32 offset)
+{
+	if (!bs_trace->wrapped &&
+	    *bs_trace->magic_byte != BNXT_TRACE_BUF_MAGIC_BYTE)
+		bs_trace->wrapped = 1;
+	bs_trace->last_offset = offset;
+}
+
 struct bnxt {
 	void __iomem		*bar0;
 	void __iomem		*bar1;
@@ -2667,6 +2687,7 @@ struct bnxt {
 
 	struct bnxt_ctx_pg_info	*fw_crash_mem;
 	u32			fw_crash_len;
+	struct bnxt_bs_trace_info bs_trace[BNXT_TRACE_MAX];
 };
 
 #define BNXT_NUM_RX_RING_STATS			8
@@ -2802,6 +2823,7 @@ static inline bool bnxt_sriov_cfg(struct bnxt *bp)
 #endif
 }
 
+extern const u16 bnxt_bstore_to_trace[];
 extern const u16 bnxt_lhint_arr[];
 
 int bnxt_alloc_rx_data(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
-- 
2.30.1


