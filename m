Return-Path: <netdev+bounces-222906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EACB56EB5
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 05:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17B9C3BDE4A
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 03:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE43202C46;
	Mon, 15 Sep 2025 03:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZN8BQYgS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f225.google.com (mail-vk1-f225.google.com [209.85.221.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B1322758F
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 03:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757905561; cv=none; b=YEWKUM1CX2DLqVrr+rjOFFGbUgfGN/LLY9j/zs5y3bdmHq79OqVLWsFll+pxaDfPzQwZJSSyvC1I/uqtIA2ZoZj4c0u6gIRUyNf0GfQouFYvfgCETmm1rsoGKsuhRAyfzqC9uyk7Xe8tJiGVQhEBGcEVCCF+4u2cUm/EFIPzfMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757905561; c=relaxed/simple;
	bh=gHH2WDwaB13JwokSk/XJLxfbXlPyzoGFWtqS6S+Aij0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EFOtilzmPzw4zfFccwSn0gYM4MrQ1DGcZ4gnTNMZqNfWnjybof0rYGSl8OiMvBQAiewBobSoWmbmN/0JYw+NIpucoUN37oY0LEZ6QvHR2+LeourSSD4Li2ZmAimFEPqrUFtH++mmt8tSBv/kMROm4JKV/63UhUO55yDYavim/0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZN8BQYgS; arc=none smtp.client-ip=209.85.221.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f225.google.com with SMTP id 71dfb90a1353d-544a2339775so1253484e0c.0
        for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 20:05:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757905559; x=1758510359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i3Xn4pR79VwIYCmA8/ZYkb6JXEU9qioKe+gGt38Dp30=;
        b=XEp9GvxYxCcQl+mgjt6XdOnSs8NnZndqJIOK8LJqy2ZEOckC9xc5boTZ4edldk+aSK
         HQ5YbnyKfeUXAos73AIPKj6MU/PAvnzU6T71mwwW20u2xkrTLKf6zfhmPsUYbBGiaFJq
         0B3OSEeqdHcl1fPyYjiELFXbAo+DM7eVwnjTurOA9CDi0+pkpy+s6DWf4Bo4he+SZzPo
         F6RG7PDMRKVDpu8ONNwEwy15ynS9V/8Dz+y5EDBge7ayjymx8OiSSoH+4eKcS6Mqb4Ib
         KJQ4v1QrVRgUkfZuwK76VCp3eq3LrngjYvlrzf6MlyJ+awc61d33csVWeSfZOvywH6x6
         eEeA==
X-Gm-Message-State: AOJu0Yz1DCwdpFA1uL3sowskh8JYT5qsRBbcQ6G8WWWCvJBHHH/MYCgJ
	hgZVi+zckCmwp39xe2CaG8x064kKyOhi2HVS8Pezk9dKh9j5atkwGH8NjAtsd+2CJxdPp3Xjpoi
	guwTS/klIob5tAQES2Fn0v2nFbwz1QXZnexyqiTME5Vcgb1mppXbZr0PFusicwWICF5LvssYrUL
	YR0f4rvW/2FT0yLDvACIpDx4CUiE36mykiKpiDOtSQ3SQ6ODs1pF8AjLv/au49krRIBb3YGqDIB
	/4pcU95XsI=
X-Gm-Gg: ASbGncvFNG1k8PwJIlRiyK0TQMZhKnZ8vtQgxwQEPowkF1WwDuhjEQccpxC1K3sRJM0
	iayiWCMY2J2bGGzxW5i8Re31aZAT3VQ051uYqW3QseDn9DLsd6gmkSN8IWxtCz+N8s7qy/JuXTp
	oTW7jMZwQ5H5avOUny1TjdgfXPiDMZwI2W/27iTg4yvNCVcS1dYLQMFOAQ+SXTRIFb0uDUOwOh+
	QB2JKmxtjIEYCGUN7TTsQZ02ALR9VW4hrlDYf79R0sYK2U05Z4h6JsP+LQqUhsQZ0zHkFlrue6J
	yRzbXE6VuYHH/44Fdjz18CiYaoFsYKlonQWncs1WyftRWedDMYXHPniUVEDNIMRiMKhxTP2vUrp
	b020eOKf5tV/5DlQHQ7xjaZXZJwfBFLYzki5mh+PzMqXpjmIhwlsAUNz7/6pXjULKNUvmeK1jQm
	46QA==
X-Google-Smtp-Source: AGHT+IFejH2ge43kFy9CKW7VKHpeTmWsVY3qVK/kE0pI0UJhqGia7et9r1BVSlAWFl4B07eSFMZwjMndpx7X
X-Received: by 2002:a05:6122:469f:b0:544:93b6:a096 with SMTP id 71dfb90a1353d-54a16baae54mr3088965e0c.8.1757905558775;
        Sun, 14 Sep 2025 20:05:58 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-54a0d3b6711sm1203988e0c.5.2025.09.14.20.05.57
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Sep 2025 20:05:58 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-25177b75e38so43045185ad.0
        for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 20:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757905556; x=1758510356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3Xn4pR79VwIYCmA8/ZYkb6JXEU9qioKe+gGt38Dp30=;
        b=ZN8BQYgSH6SarByMRGJwKabfjFINb04TK73ZnwR1gUdE8oQBmtIS2UcrUJyJ8KvDvf
         VP8z5+tnJrGf4RRx0txuniZxY3MQ/VrnSP2hTqc3AvcavbdN6vJuVNMoAV66fp6ncV0G
         2G7R7BT00kk0S5TnWnMGMTrJ4ZhXEHYvxerWk=
X-Received: by 2002:a17:903:2f06:b0:24e:229e:204e with SMTP id d9443c01a7336-25d25291ccdmr132441945ad.16.1757905556584;
        Sun, 14 Sep 2025 20:05:56 -0700 (PDT)
X-Received: by 2002:a17:903:2f06:b0:24e:229e:204e with SMTP id d9443c01a7336-25d25291ccdmr132441545ad.16.1757905555998;
        Sun, 14 Sep 2025 20:05:55 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b0219f9sm112723575ad.123.2025.09.14.20.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 20:05:55 -0700 (PDT)
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
Subject: [PATCH net-next 06/11] bnxt_en: Add fw log trace support for 5731X/5741X chips
Date: Sun, 14 Sep 2025 20:05:00 -0700
Message-ID: <20250915030505.1803478-7-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20250915030505.1803478-1-michael.chan@broadcom.com>
References: <20250915030505.1803478-1-michael.chan@broadcom.com>
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
index 09cc58288e67..97165624acf5 100644
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


