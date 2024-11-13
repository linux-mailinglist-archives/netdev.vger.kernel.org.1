Return-Path: <netdev+bounces-144324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5176F9C68D4
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 06:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26A7FB23F31
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 05:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E198185935;
	Wed, 13 Nov 2024 05:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CtVPyGcg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A863417BEA4
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 05:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731476414; cv=none; b=Gxh28B9IRu+TzxRjh9IjQWDIgpaQemsweQmD0h5zkBMjUHA3dP3WKI27Q3osbfIAKzPgVYGm0g1vpWKXLjBnv6HCXqTb09SZHEHtc3DeoUwyHphQ8otz66lXnMUMuN+4m1aSqEnD1CSTErv4AUma9W/+lw57BpZxyWqUe8wDteU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731476414; c=relaxed/simple;
	bh=TM6Bsmka1pmcx+z/3Usuu1s9EjR4rr/wXk0HQk9t7TY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UmnbEJE2+pbCvxX4RShsioDirkF24xEmeoXgb3XCfFtc6NSv1TFb1ieFdx1npjlzqtRSZoeIdP3TRWDxEbzPqF9iYgnsYELzTKStEOqkXIIKT9TXP50YaSKsmrC36HNkKR37Ghc8TkIlEM8FzqkYhDmnv8QGmWMT9nhLsR92ftY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CtVPyGcg; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-460ab1bc2aeso43121571cf.3
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 21:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731476412; x=1732081212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOTEcdvU4shcCVkiFNFegBPZvxbRtOq49YbxhFJvszs=;
        b=CtVPyGcg7lM3hSTY0OwxKqs25M2rDdtmgzgCUJ2aFlWE052iKHXiN7cfcyNoJd7onz
         raHYxq2QId/G6ZsVOSLuSto+te1LTWaIoMe0HV3kAOdWepBwiV+Teq5T122mWAc6jvSl
         1oG5B2gLLAGwwmwMmKBXlmQFYgW+72K6lGpOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731476412; x=1732081212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOTEcdvU4shcCVkiFNFegBPZvxbRtOq49YbxhFJvszs=;
        b=l02DuoXSn/wQUolFS1xpoHYHu0ceceu6bmnBgc4mNMOVq7j7uv3znlqO4GXaaUTChe
         OtHbBvs595Sv9uBBrBsrboBD4kgbRMHAd5VYIvr6TL0KGK72YmGU4uzuMKcCjEQSiU+1
         yW1CgVhPmJHROo9PV1TTEOe4StjOqCodveE+Z8tazPlvcYn41Q+M0muDCLnU/ZmfhDBZ
         rp7ELcXSlxOdZAu/UCeiJiC8nRxxyfRRdDImhRiy5JpcppUDovJUe12VIwJd3+ozH0zX
         jskfNpjdcMktZkBLDp/w81DieR1+DMnFXqCF3Stkg5hFQTMEKrQ3A6rRkjm6QcxD79Jj
         vOSg==
X-Gm-Message-State: AOJu0Ywczt71LP/WSVuhGEdDSVwpNbDe0nVjX+G9O0XRd1d6+nNuGr+Y
	6N9w2Yl3yQyjc7rfukoyR3Lg71MJayNW8qLuofdYspIQmW6MisrVLoRHTBF27A==
X-Google-Smtp-Source: AGHT+IHe44yjCMVukcrNxOePSiqBy7rRG/hFmrV6bTaAEwnhe4Nerq4PJpS/kreicH+XFRWoADvn1Q==
X-Received: by 2002:a05:622a:1a27:b0:462:ea22:33bb with SMTP id d75a77b69052e-463093f01e4mr238655281cf.38.1731476411750;
        Tue, 12 Nov 2024 21:40:11 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff5e14f9sm83457491cf.86.2024.11.12.21.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 21:40:11 -0800 (PST)
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
Subject: [PATCH net-next 11/11] bnxt_en: Add FW trace coredump segments to the coredump
Date: Tue, 12 Nov 2024 21:36:49 -0800
Message-ID: <20241113053649.405407-12-michael.chan@broadcom.com>
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

The FW trace coredump segments are very similar to the context
memory segments in the previous patch.  The main difference is
to call HWRM_DBG_LOG_BUFFER_FLUSH to flush the FW data to host
memory and to include an additional record in the coredump that
contains the head and tail information of the trace data.

Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
Signed-off-by: Shruti Parab <shruti.parab@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 .../ethernet/broadcom/bnxt/bnxt_coredump.c    | 77 +++++++++++++++++--
 .../ethernet/broadcom/bnxt/bnxt_coredump.h    | 21 +++++
 2 files changed, 92 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
index ff92443db01b..2f248869b7b9 100644
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
@@ -279,10 +311,30 @@ bnxt_fill_coredump_record(struct bnxt *bp, struct bnxt_coredump_record *record,
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
 	struct bnxt_coredump_segment_hdr seg_hdr;
+	struct bnxt_driver_segment_record record;
 	struct bnxt_ctx_mem_info *ctx = bp->ctx;
 	u32 comp_id = BNXT_DRV_COMP_ID;
 	void *data = NULL;
@@ -295,24 +347,37 @@ static u32 bnxt_get_ctx_coredump(struct bnxt *bp, void *buf, u32 offset,
 
 	if (buf)
 		buf += offset;
-	for (type = 0 ; type <= BNXT_CTX_TIM; type++) {
+	for (type = 0 ; type <= BNXT_CTX_RIGP1; type++) {
 		struct bnxt_ctx_mem_type *ctxm = &ctx->ctx_arr[type];
+		bool trace = bnxt_bs_trace_avail(bp, type);
 		u32 seg_id = bnxt_bstore_to_seg_id[type];
-		size_t seg_len;
+		size_t seg_len, hdr_len;
 
-		if (!ctxm->entry_size || !ctxm->pg_info || !seg_id)
+		if (!ctxm->mem_valid || !seg_id)
 			continue;
 
+		hdr_len = BNXT_SEG_HDR_LEN;
+		if (trace)
+			hdr_len += BNXT_SEG_RCD_LEN;
 		if (buf)
-			data = buf + BNXT_SEG_HDR_LEN;
+			data = buf + hdr_len;
 		seg_len = bnxt_copy_ctx_mem(bp, ctxm, data, 0);
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
+				buf += BNXT_SEG_RCD_LEN;
+			}
+			buf += seg_len;
 		}
-		len += BNXT_SEG_HDR_LEN + seg_len;
+		len += hdr_len + seg_len;
 		*segs += 1;
 	}
 	return len;
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


