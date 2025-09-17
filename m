Return-Path: <netdev+bounces-223847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC56BB7D81D
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71C0C2A7D42
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 04:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351BA30217C;
	Wed, 17 Sep 2025 04:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Xww/vbzS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CE02F6562
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 04:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758082171; cv=none; b=frd/Rc1nEsV0DOrs4mwB8zVDTU7UD2HVYFKrkemovf4m4ZH1nsn3AGx+B+zzIO+jdDDQ3ADqV8xp+4ESfAeMV170+N+VJDm1BfrWFG77+3BUNGtpPQY1Hj/L4MofvbBQdzSsOq71+cU0wEq+Tgex7rrty+4+gmcMlncIv+ahGUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758082171; c=relaxed/simple;
	bh=N9tVLWwoGcPriKnJIrQ5jDZxThxdXi6EQe8k7pR81Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gzSrgMRKl8he/cs/te8QRudDDj66+bprBp0EAHGt2+w4oEQm9+jYdUFv+e6DVMV4WYDOAfsdBmaUhX9PTK23XJRiqbCE0k5ZcIKNBCF1UaeSyMCo6YZKqhJ8PSChTQ79GX5niphdZaa2bGsBDaG716PgPax7KUn5/VY+7ngu9Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Xww/vbzS; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2677a4d4ce3so27968495ad.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:09:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758082169; x=1758686969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+iK/eBiau6XhMFOo/vOebtNS6WLCuxIq7o51IrElmk=;
        b=OTDjYDP2gENeyqFjiJZC4phdEPhOEUpxL1SqaCfsq58U5mvvgR0XuhSLeObcc2Y5wW
         HxX53BvuiWRd6GvSPt/l4QSSEzglvdIz+LdHBe8Kz4PwdbdCmjCIGbmb2bIO0v2IJDbN
         X1SZK5RklN2yHmNscaLw+25ohUNI5n5pKaRMGcqgzPHLhY95yMeRmh1e4kZYSKKMT7fT
         FM1yUnA+gBb+c1viI8K6cXRJVwLCo8WozdJLQiRhuQmwD7DKLN1tIhpAYg4oKCWOUHXr
         bJj32Vq5XpfHzydiG8cidXtNS0y+AfWGVvm9V6QE74KiOexJ0snOwT340Pf5wzCIB7Yw
         t4gQ==
X-Gm-Message-State: AOJu0Yyorv8TLo1ajBQull4JRFMaAo9iE0dg2FgzqVVdUb7CXgAm0V2t
	m4k4J1ItdvWirpHBJYlYZxGAHU65Kbi3t6i9rmDxXznju5WQmkmHtDU3SZdqpNAELHlTM7jwmsb
	3mgY2A9LR6Q/OWlVt3t9QJAt075puXT6i72zUPDcPh6UOHvZ+H1dNd8qMSxYYI2CuKFFaz/3gAg
	VKF1+CTfjc656ycbACzjvRQBTlYRwGBdphRg07IFTLbVweWeZnqDCvpzKcYpXKEMA+vhCt4WXZL
	zct9GhtpFM=
X-Gm-Gg: ASbGnctMlrVwMKLTlp6SsgoXNwjSZt2/eRrgDj1Pmw7EWfOZilqxeNmKmXohak0YVBK
	k8sJZiStTxUZneRxEpb2I5LH3tTNy8BUX+qo2E0GTAIDq6rgkNrZFvp92mMQnkNFkXogAj43p7j
	YLBgKnGhK3OALnzE769KvDx0vh1Yqw1b4wg2qE9TQSjQExfEWnlE5i+jSU7xfiCba3MozcBGfUG
	f8hU5EmXRZwMZJkeWHraogRSUyKjG36VR6pPxvH9qZI0IiiNvUGwhScp+QOUOh4Rg4AnCwFv/hE
	wrjZabizAIlqiwElCRJuUi9cLZtul22Sj6t9RlqzE2IGyhRjJtOo93Y0kQsowUoAt6/kfNgL/5x
	msDJFAL0h2DRQgxgA58yCSNUtCSN7Isx8zWoVTXTG6o7TlLzITbOLBtgZVlyXmT+rR3iRZ4yp+n
	ND+Q==
X-Google-Smtp-Source: AGHT+IHBBB8CJziCpTTlnwsqk8dT80VfJeVfastkjQ5ESF0f0jZCARYzKmhBKTA2LhB+kn8jfYHN/urvd8k/
X-Received: by 2002:a17:903:1252:b0:266:7871:37dc with SMTP id d9443c01a7336-268137fd12emr9296725ad.36.1758082169009;
        Tue, 16 Sep 2025 21:09:29 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-25c36bc2b59sm17156335ad.6.2025.09.16.21.09.28
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Sep 2025 21:09:29 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32ec67fcb88so860088a91.3
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758082167; x=1758686967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+iK/eBiau6XhMFOo/vOebtNS6WLCuxIq7o51IrElmk=;
        b=Xww/vbzSUZ7914g/QlBdyIBTgz9baL7NcBW7KQJdBjei/tOOVbnqTfHvjM3ineWmJW
         xuyIY1BplpYLhOiKnxg4nT9n7ejUkiPJgiv8RpIEjC1mk7POecLohSkwJylbiz+uW6rY
         jDxH/bCKHHalCnQtFlSFyPp8euPJsA2E3wTS8=
X-Received: by 2002:a17:90b:2885:b0:32e:6156:356d with SMTP id 98e67ed59e1d1-32ee3f64939mr868167a91.26.1758082167019;
        Tue, 16 Sep 2025 21:09:27 -0700 (PDT)
X-Received: by 2002:a17:90b:2885:b0:32e:6156:356d with SMTP id 98e67ed59e1d1-32ee3f64939mr868154a91.26.1758082166490;
        Tue, 16 Sep 2025 21:09:26 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ee223f2ecsm558562a91.18.2025.09.16.21.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 21:09:25 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Shruti Parab <shruti.parab@broadcom.com>
Subject: [PATCH net-next v2 06/10] bnxt_en: Add err_qpc backing store handling
Date: Tue, 16 Sep 2025 21:08:35 -0700
Message-ID: <20250917040839.1924698-7-michael.chan@broadcom.com>
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

From: Kashyap Desai <kashyap.desai@broadcom.com>

New backing store component err_qpc is added to the existing host
logging interface for FW traces.

Allocate the backing store memory if this memory type is supported.
Copy this memory when collecting the coredump.

Reviewed-by: Shruti Parab <shruti.parab@broadcom.com>
Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          | 3 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          | 3 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c | 3 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.h | 1 +
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 481395691a9d..bdf8502d3131 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -266,6 +266,7 @@ const u16 bnxt_bstore_to_trace[] = {
 	[BNXT_CTX_CA2]		= DBG_LOG_BUFFER_FLUSH_REQ_TYPE_CA2_TRACE,
 	[BNXT_CTX_RIGP1]	= DBG_LOG_BUFFER_FLUSH_REQ_TYPE_RIGP1_TRACE,
 	[BNXT_CTX_KONG]		= DBG_LOG_BUFFER_FLUSH_REQ_TYPE_AFM_KONG_HWRM_TRACE,
+	[BNXT_CTX_QPC]		= DBG_LOG_BUFFER_FLUSH_REQ_TYPE_ERR_QPC_TRACE,
 };
 
 static struct workqueue_struct *bnxt_pf_wq;
@@ -9159,7 +9160,7 @@ static int bnxt_backing_store_cfg_v2(struct bnxt *bp)
 	int rc = 0;
 	u16 type;
 
-	for (type = BNXT_CTX_SRT; type <= BNXT_CTX_KONG; type++) {
+	for (type = BNXT_CTX_SRT; type <= BNXT_CTX_QPC; type++) {
 		ctxm = &ctx->ctx_arr[type];
 		if (!bnxt_bs_trace_avail(bp, type))
 			continue;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 37c3f6507250..57a1af40cc19 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1969,10 +1969,11 @@ struct bnxt_ctx_mem_type {
 #define BNXT_CTX_CA2	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_CA2_TRACE
 #define BNXT_CTX_RIGP1	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_RIGP1_TRACE
 #define BNXT_CTX_KONG	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_AFM_KONG_HWRM_TRACE
+#define BNXT_CTX_QPC	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_ERR_QPC_TRACE
 
 #define BNXT_CTX_MAX	(BNXT_CTX_TIM + 1)
 #define BNXT_CTX_L2_MAX	(BNXT_CTX_FTQM + 1)
-#define BNXT_CTX_V2_MAX	(BNXT_CTX_KONG + 1)
+#define BNXT_CTX_V2_MAX (BNXT_CTX_QPC + 1)
 #define BNXT_CTX_INV	((u16)-1)
 
 struct bnxt_ctx_mem_info {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
index a0a37216efb3..0181ab1f2dfd 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
@@ -37,6 +37,7 @@ static const u16 bnxt_bstore_to_seg_id[] = {
 	[BNXT_CTX_CA2]			= BNXT_CTX_MEM_SEG_CA2,
 	[BNXT_CTX_RIGP1]		= BNXT_CTX_MEM_SEG_RIGP1,
 	[BNXT_CTX_KONG]			= BNXT_CTX_MEM_SEG_KONG,
+	[BNXT_CTX_QPC]			= BNXT_CTX_MEM_SEG_QPC,
 };
 
 static int bnxt_dbg_hwrm_log_buffer_flush(struct bnxt *bp, u16 type, u32 flags,
@@ -360,7 +361,7 @@ static u32 bnxt_get_ctx_coredump(struct bnxt *bp, void *buf, u32 offset,
 
 	if (buf)
 		buf += offset;
-	for (type = 0; type <= BNXT_CTX_KONG; type++) {
+	for (type = 0; type < BNXT_CTX_V2_MAX; type++) {
 		struct bnxt_ctx_mem_type *ctxm = &ctx->ctx_arr[type];
 		bool trace = bnxt_bs_trace_avail(bp, type);
 		u32 seg_id = bnxt_bstore_to_seg_id[type];
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.h
index 8d0f58c74cc3..c087df88154a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.h
@@ -102,6 +102,7 @@ struct bnxt_driver_segment_record {
 #define BNXT_CTX_MEM_SEG_CA1	0x9
 #define BNXT_CTX_MEM_SEG_CA2	0xa
 #define BNXT_CTX_MEM_SEG_RIGP1	0xb
+#define BNXT_CTX_MEM_SEG_QPC	0xc
 #define BNXT_CTX_MEM_SEG_KONG	0xd
 
 #define BNXT_CRASH_DUMP_LEN	(8 << 20)
-- 
2.51.0


