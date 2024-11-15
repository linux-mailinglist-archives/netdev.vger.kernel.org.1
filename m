Return-Path: <netdev+bounces-145317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 030559CED5D
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 16:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0613282836
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 15:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D65D1D5145;
	Fri, 15 Nov 2024 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AdplqSCY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA7A1D54DA
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 15:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731683791; cv=none; b=hK01FVC638xLfT+hnxAqbxy8ic/qR0vKKmYBwcc+8aDrO+GWMb8ATGWHkxnALcee65+TTWgZFLS+hRK1kSyecErNl8TpKN1qPxivvhzXlIim3LqmKd83gYeL+VsUyWRMy6f2Vabtg4jsNNkXGC4NLaTgMW8o8BvVACBIJ6lIj3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731683791; c=relaxed/simple;
	bh=IqUNAIv8TiknVMMxzjfRiCU5qPzAawv9mH6wDF1Hi4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jyxq7NJe6TKXpUkVTdbjmH2c+eHzJ3uz6Pqpud5arMKwicXGMjefo2ThqN06fUv6tgn0IUJWxjzpPg6MaUZ8mtUBf0+KMvLmOOfU7JWZR0fWpaJ838fvDF8vGJVYJatCBswB9K+wbGKWd7wH48vheRR9c572ogSPjKVWSyQh140=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AdplqSCY; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20cbcd71012so22597295ad.3
        for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 07:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731683789; x=1732288589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hvZDY10EQVQYhsFfOou1y+B0mEE3kCZdG5fXkJraFs=;
        b=AdplqSCYBeuT0sJpDWKUs1zcC+Lq4TOwILZhKAOcsTlxvDlHrJAcFwFMk8ja/UOKSL
         spYf4BSXGBq2a6HmVAt6096PBKcuZjiqwzSkBsJ19CbhgYPESXoJqRDGu8HrtUbxHGRN
         MdZ0JIuvzK4N8MXO/0K/AJDASQ5tQs5NHBPUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731683789; x=1732288589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hvZDY10EQVQYhsFfOou1y+B0mEE3kCZdG5fXkJraFs=;
        b=NGBISwn6otZMGfxaVBfS8hoWUweaSF0cmBFD2aWSQ3HHrqV2U8eOblJQtiQIf58U8f
         f2Y44ygMumtEOB8pT8t6jSNff2wcE5Gt15oEfsEhjo64PwUm+2IaEJojcW9ZT8aV7SPe
         WMU2Pj1/yu0NdRH0ns0509v6pdzLNpu2f2nB86rs7Gh7TSzs0nup5OWVLxoG5EVHtMYk
         Y97wg7TSGa8FOqV1TLpKSek4oka7axk2DAxMxM5d5H8OJKLnxtNf1MMgsSeBjRkd1Qti
         Sy9kqleAReb9xTQaV26lRaKHNa/N9Fd6tKClIhRKFnpj75M0LgcGX7uUJjds1qtHoep8
         /hYA==
X-Gm-Message-State: AOJu0Yz4vFE/g7uBjdMto2jeMqrDdEsh0Ux9vtGRq+w3KENJJFv7SzK2
	Tab8B+nEWwxNvMA83reYnUKWX+omFo81BvK8RDgW2bSGmkFgAZp6J1+x6YaQ5Q==
X-Google-Smtp-Source: AGHT+IG6QnG6131BmwgDaJ92P51sjsiYOmHZDwXAPy/w32tt4kkoFZ/zI3kT52ksyKwCZA+xRpqq2g==
X-Received: by 2002:a17:902:e885:b0:211:ce91:63ea with SMTP id d9443c01a7336-211d0d81156mr40182175ad.15.1731683788667;
        Fri, 15 Nov 2024 07:16:28 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0eca26fsm13357925ad.106.2024.11.15.07.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:16:28 -0800 (PST)
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
Subject: [PATCH net-next v2 11/11] bnxt_en: Add FW trace coredump segments to the coredump
Date: Fri, 15 Nov 2024 07:14:37 -0800
Message-ID: <20241115151438.550106-12-michael.chan@broadcom.com>
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

The FW trace coredump segments are very similar to the context
memory segments in the previous patch.  The main difference is
to call HWRM_DBG_LOG_BUFFER_FLUSH to flush the FW data to host
memory and to include an additional record in the coredump that
contains the head and tail information of the trace data.

Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
Signed-off-by: Shruti Parab <shruti.parab@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v2: Fix seg length calculation
---
 .../ethernet/broadcom/bnxt/bnxt_coredump.c    | 75 +++++++++++++++++--
 .../ethernet/broadcom/bnxt/bnxt_coredump.h    | 21 ++++++
 2 files changed, 90 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
index ff92443db01b..7236d8e548ab 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
@@ -25,8 +25,40 @@ static const u16 bnxt_bstore_to_seg_id[] = {
 	[BNXT_CTX_FTQM]			= BNXT_CTX_MEM_SEG_FTQM,
 	[BNXT_CTX_MRAV]			= BNXT_CTX_MEM_SEG_MRAV,
 	[BNXT_CTX_TIM]			= BNXT_CTX_MEM_SEG_TIM,
+	[BNXT_CTX_SRT]			= BNXT_CTX_MEM_SEG_SRT,
+	[BNXT_CTX_SRT2]			= BNXT_CTX_MEM_SEG_SRT2,
+	[BNXT_CTX_CRT]			= BNXT_CTX_MEM_SEG_CRT,
+	[BNXT_CTX_CRT2]			= BNXT_CTX_MEM_SEG_CRT2,
+	[BNXT_CTX_RIGP0]		= BNXT_CTX_MEM_SEG_RIGP0,
+	[BNXT_CTX_L2HWRM]		= BNXT_CTX_MEM_SEG_L2HWRM,
+	[BNXT_CTX_REHWRM]		= BNXT_CTX_MEM_SEG_REHWRM,
+	[BNXT_CTX_CA0]			= BNXT_CTX_MEM_SEG_CA0,
+	[BNXT_CTX_CA1]			= BNXT_CTX_MEM_SEG_CA1,
+	[BNXT_CTX_CA2]			= BNXT_CTX_MEM_SEG_CA2,
+	[BNXT_CTX_RIGP1]		= BNXT_CTX_MEM_SEG_RIGP1,
 };
 
+static int bnxt_dbg_hwrm_log_buffer_flush(struct bnxt *bp, u16 type, u32 flags,
+					  u32 *offset)
+{
+	struct hwrm_dbg_log_buffer_flush_output *resp;
+	struct hwrm_dbg_log_buffer_flush_input *req;
+	int rc;
+
+	rc = hwrm_req_init(bp, req, HWRM_DBG_LOG_BUFFER_FLUSH);
+	if (rc)
+		return rc;
+
+	req->flags = cpu_to_le32(flags);
+	req->type = cpu_to_le16(type);
+	resp = hwrm_req_hold(bp, req);
+	rc = hwrm_req_send(bp, req);
+	if (!rc)
+		*offset = le32_to_cpu(resp->current_buffer_offset);
+	hwrm_req_drop(bp, req);
+	return rc;
+}
+
 static int bnxt_hwrm_dbg_dma_data(struct bnxt *bp, void *msg,
 				  struct bnxt_hwrm_dbg_dma_info *info)
 {
@@ -279,9 +311,29 @@ bnxt_fill_coredump_record(struct bnxt *bp, struct bnxt_coredump_record *record,
 	record->ioctl_high_version = 0;
 }
 
+static void bnxt_fill_drv_seg_record(struct bnxt *bp,
+				     struct bnxt_driver_segment_record *record,
+				     struct bnxt_ctx_mem_type *ctxm, u16 type)
+{
+	struct bnxt_bs_trace_info *bs_trace = &bp->bs_trace[type];
+	u32 offset = 0;
+	int rc = 0;
+
+	rc = bnxt_dbg_hwrm_log_buffer_flush(bp, type, 0, &offset);
+	if (rc)
+		return;
+
+	bnxt_bs_trace_check_wrap(bs_trace, offset);
+	record->max_entries = cpu_to_le32(ctxm->max_entries);
+	record->entry_size = cpu_to_le32(ctxm->entry_size);
+	record->offset = cpu_to_le32(bs_trace->last_offset);
+	record->wrapped = bs_trace->wrapped;
+}
+
 static u32 bnxt_get_ctx_coredump(struct bnxt *bp, void *buf, u32 offset,
 				 u32 *segs)
 {
+	struct bnxt_driver_segment_record record = {};
 	struct bnxt_coredump_segment_hdr seg_hdr;
 	struct bnxt_ctx_mem_info *ctx = bp->ctx;
 	u32 comp_id = BNXT_DRV_COMP_ID;
@@ -295,22 +347,33 @@ static u32 bnxt_get_ctx_coredump(struct bnxt *bp, void *buf, u32 offset,
 
 	if (buf)
 		buf += offset;
-	for (type = 0 ; type <= BNXT_CTX_TIM; type++) {
+	for (type = 0 ; type <= BNXT_CTX_RIGP1; type++) {
 		struct bnxt_ctx_mem_type *ctxm = &ctx->ctx_arr[type];
+		bool trace = bnxt_bs_trace_avail(bp, type);
 		u32 seg_id = bnxt_bstore_to_seg_id[type];
-		size_t seg_len;
+		size_t seg_len, extra_hlen = 0;
 
-		if (!ctxm->entry_size || !ctxm->pg_info || !seg_id)
+		if (!ctxm->mem_valid || !seg_id)
 			continue;
 
+		if (trace)
+			extra_hlen = BNXT_SEG_RCD_LEN;
 		if (buf)
-			data = buf + BNXT_SEG_HDR_LEN;
-		seg_len = bnxt_copy_ctx_mem(bp, ctxm, data, 0);
+			data = buf + BNXT_SEG_HDR_LEN + extra_hlen;
+		seg_len = bnxt_copy_ctx_mem(bp, ctxm, data, 0) + extra_hlen;
 		if (buf) {
 			bnxt_fill_coredump_seg_hdr(bp, &seg_hdr, NULL, seg_len,
 						   0, 0, 0, comp_id, seg_id);
 			memcpy(buf, &seg_hdr, BNXT_SEG_HDR_LEN);
-			buf += BNXT_SEG_HDR_LEN + seg_len;
+			buf += BNXT_SEG_HDR_LEN;
+			if (trace) {
+				u16 trace_type = bnxt_bstore_to_trace[type];
+
+				bnxt_fill_drv_seg_record(bp, &record, ctxm,
+							 trace_type);
+				memcpy(buf, &record, BNXT_SEG_RCD_LEN);
+			}
+			buf += seg_len;
 		}
 		len += BNXT_SEG_HDR_LEN + seg_len;
 		*segs += 1;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.h
index 3a6084a51be8..d1cd6387f3ab 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.h
@@ -68,6 +68,14 @@ struct bnxt_coredump_record {
 	__le16 rsvd3[313];
 };
 
+struct bnxt_driver_segment_record {
+	__le32 max_entries;
+	__le32 entry_size;
+	__le32 offset;
+	__u8 wrapped:1;
+	__u8 unused[3];
+};
+
 #define BNXT_VER_GET_COMP_ID	2
 #define BNXT_DRV_COMP_ID	0xd
 
@@ -83,12 +91,25 @@ struct bnxt_coredump_record {
 #define BNXT_CTX_MEM_SEG_MRAV	(BNXT_CTX_MEM_SEG_ID_START + BNXT_CTX_MRAV)
 #define BNXT_CTX_MEM_SEG_TIM	(BNXT_CTX_MEM_SEG_ID_START + BNXT_CTX_TIM)
 
+#define BNXT_CTX_MEM_SEG_SRT	0x1
+#define BNXT_CTX_MEM_SEG_SRT2	0x2
+#define BNXT_CTX_MEM_SEG_CRT	0x3
+#define BNXT_CTX_MEM_SEG_CRT2	0x4
+#define BNXT_CTX_MEM_SEG_RIGP0	0x5
+#define BNXT_CTX_MEM_SEG_L2HWRM	0x6
+#define BNXT_CTX_MEM_SEG_REHWRM	0x7
+#define BNXT_CTX_MEM_SEG_CA0	0x8
+#define BNXT_CTX_MEM_SEG_CA1	0x9
+#define BNXT_CTX_MEM_SEG_CA2	0xa
+#define BNXT_CTX_MEM_SEG_RIGP1	0xb
+
 #define BNXT_CRASH_DUMP_LEN	(8 << 20)
 
 #define COREDUMP_LIST_BUF_LEN		2048
 #define COREDUMP_RETRIEVE_BUF_LEN	4096
 
 #define BNXT_SEG_HDR_LEN	sizeof(struct bnxt_coredump_segment_hdr)
+#define BNXT_SEG_RCD_LEN	sizeof(struct bnxt_driver_segment_record)
 
 struct bnxt_coredump {
 	void		*data;
-- 
2.30.1


