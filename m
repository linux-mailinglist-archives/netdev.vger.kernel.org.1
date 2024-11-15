Return-Path: <netdev+bounces-145312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 249189CED28
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 16:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA3F0282A16
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 15:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5341D54C2;
	Fri, 15 Nov 2024 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VZJ8OLkT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A7B1D516A
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731683784; cv=none; b=OSGAnSlVSnyZNw4ibbalDjdGO5K0PPTxC6G9lUY0LiltlOFJHzY090sYnxMqTfNFRZ9RTI1y88iIOi1v5Q+rbn8mEGmT/EWUtmG3oBM4eX1r01XJuCfbwjw8FByvVXcTHIQ/khb/kglK/Nk/GqY58ExjgqFTJv45FCNE6jeK/Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731683784; c=relaxed/simple;
	bh=6JYXar9nJqGM+hQMFvySLeA0LLoApmYvzmyUBedamgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9AgOYN+a21fgs82rEinT5ubamFeg698MxYjInEYmuuL7NfADRMQ+kCZj5QxofkYXtzFelvXQdGnRiZXA6OrCujFHmUVxiYIpWVrSt+rJ83tbkNTHYTfzRX3rQePR6epB+ppv9ndsYo32gQGnkV0TLSqhTrY634UEVLlVMMOqAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VZJ8OLkT; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20caccadbeeso9499005ad.2
        for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 07:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731683782; x=1732288582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4KOIMNUmwPXJSVvVOcIPpnj4gejXC1bx3BrDaUsLiU=;
        b=VZJ8OLkTRs7zOGzwVsB8hCW6ubz7rs/y9jlbPssE8MqxL3gXBw4++UJoWG9cMw4agE
         uhYrqERLnAYjGo9TFrLbn5vdtj1vnoPZH9JBE9aVYgNdqS4TxcwjaRr71v5076jBfC5N
         ExTf3Ng6Sd/hphEo7Ss8ZwZ8gja6lP0YsiHFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731683782; x=1732288582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4KOIMNUmwPXJSVvVOcIPpnj4gejXC1bx3BrDaUsLiU=;
        b=HtiO6QF37NUsZBn8arnLpzAzIFBca7KsxPtNT/3TdEfOJkpF0XlT3firneqo722gsH
         8RPb0apKIan60rMqvWa5KPZHcBq8HmABN2YWYBpxI8nLFUswro0/56wiGVZx8ivFbUqp
         QZ5PBKig+ShqOQxFv8I7uqvkFTsQ7s8Y8u/ohmlTXftowx3ObPkybH7Ee7EgBu8CT3J/
         VPm0A5k2u8EG/0JKdnt4ufY9E53h+NiXfCRj8fFdUYgYbm2yG4dogNoS+FDXuxNARfyd
         rNOmeEx3FmJlvXLV9YOVPmnIWBBVBzNV0EmyYN6YqhlOpkot0NcwBOu+xCcYYhR916Cq
         bpFw==
X-Gm-Message-State: AOJu0YxXjaFag9tOWFi4q9VYw+wp3dDgnCbN630kBj6l2vOe5tNflcUZ
	ua1+nH6tIpAjl4tObqD2UoGrQZCeyzKB+xoxXL0y2i8i72jfeJx6MF6uF2C2+A==
X-Google-Smtp-Source: AGHT+IGEBy441nyGD+pm3PDxUSfxKGHmx3QWkeFZ5Or+j3/z7kE0eJ9WAHvonjTYXCcE1WDN4Xc03w==
X-Received: by 2002:a17:903:22c3:b0:20c:7ee8:fc3c with SMTP id d9443c01a7336-211d0d70eedmr37675215ad.22.1731683781807;
        Fri, 15 Nov 2024 07:16:21 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0eca26fsm13357925ad.106.2024.11.15.07.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:16:21 -0800 (PST)
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
Subject: [PATCH net-next v2 06/11] bnxt_en: Manage the FW trace context memory
Date: Fri, 15 Nov 2024 07:14:32 -0800
Message-ID: <20241115151438.550106-7-michael.chan@broadcom.com>
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
v2: Use the shortened strings
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 67 +++++++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 22 ++++++++
 2 files changed, 89 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c7e7cb98f03b..07510df4497b 100644
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
@@ -2470,6 +2485,50 @@ bool bnxt_bs_trace_avail(struct bnxt *bp, u16 type)
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
+	(((data2) &							\
+	  ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA2_CURR_OFF_MASK) >>\
+	 ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA2_CURR_OFF_SFT)
+
 #define BNXT_EVENT_THERMAL_CURRENT_TEMP(data2)				\
 	((data2) &							\
 	  ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA2_CURRENT_TEMP_MASK)
@@ -2786,6 +2845,13 @@ static int bnxt_async_event_process(struct bnxt *bp,
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
@@ -8769,6 +8835,7 @@ static int bnxt_backing_store_cfg_v2(struct bnxt *bp, u32 ena)
 					    type);
 				continue;
 			}
+			bnxt_bs_trace_init(bp, ctxm);
 			last_type = type;
 		}
 	}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index d02860e7ea1c..4ebee79fbe52 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2112,6 +2112,26 @@ enum board_idx {
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
@@ -2668,6 +2688,7 @@ struct bnxt {
 
 	struct bnxt_ctx_pg_info	*fw_crash_mem;
 	u32			fw_crash_len;
+	struct bnxt_bs_trace_info bs_trace[BNXT_TRACE_MAX];
 };
 
 #define BNXT_NUM_RX_RING_STATS			8
@@ -2803,6 +2824,7 @@ static inline bool bnxt_sriov_cfg(struct bnxt *bp)
 #endif
 }
 
+extern const u16 bnxt_bstore_to_trace[];
 extern const u16 bnxt_lhint_arr[];
 
 int bnxt_alloc_rx_data(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
-- 
2.30.1


