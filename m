Return-Path: <netdev+bounces-222907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA13B56EAE
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 05:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3ACD16D620
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 03:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DE1230BCB;
	Mon, 15 Sep 2025 03:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VE1uJAkc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f100.google.com (mail-io1-f100.google.com [209.85.166.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244C621ADCB
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 03:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757905562; cv=none; b=UfD21bTRPVWOgpyeaGCGcRpCHK9do3cPg7LLqfzTOwyoDk3ZDW1A9xTG+0VQZTxVj3m1i6vPFzNqF9W6GdL+55SvuoMVCo3dY7fS9YOw7iLynhWBSVNavSnzz3YQR2dbklIkz1tNIW9f1ddhENxl4gMNeG01opxkUyUqceNF3Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757905562; c=relaxed/simple;
	bh=NfhWBmsRylLfhsJLrn1x00pHioL0uNyYIuPdbD6/0ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QAfR57CmfFGqjSkkWbsfBCiQa69plLMyBHExoRefwoDk5WffELnNud+2ty9g0kGskPw4NT80KMXOlQjWD3ke1tU09IL9vHE4pG1aCKGqG+j7Glk5tAL6pKzgLGU1MIcv9azaVaz5sfqB+huWyDfwyIJFePw4/wU8RbrPYrqkBDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VE1uJAkc; arc=none smtp.client-ip=209.85.166.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f100.google.com with SMTP id ca18e2360f4ac-88432e1af6dso321903739f.2
        for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 20:06:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757905560; x=1758510360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DJd0/kKLycxMmQkqbPHraxdypl0eRMdFsjzgQpNiWX0=;
        b=EjV5IhiMoi7NNaLKTKICPZ87xb8GMRaBEHnsOP5N969xyXk5V0MC1n4+QwY/JYYXtB
         aLiOE2vVLIe0oKJwaVZn/l08Pj39+ATk8o6PGBvhHboAzTobt+ZesYFziu8dzJE+RNEN
         luTvmVb/tkLAPfHEq0yJvZnjsvebLYeBVK3SmMhi1xuy0zgxSNkrYRr89BC0d/6Z+1I/
         005Tf2m+90aGF7vpOAJ+Nz/wemmphse06LwS45Kw4n4K/Tyy/bXXS78i0WPX0VHQ2kna
         +bGJm8p+XRJHYNNWDE05lpG4WJ3b1IJJAg+U/CwkJo19UTwX6a2l0a9hRVYd1vhKjzv7
         ybHw==
X-Gm-Message-State: AOJu0Yy3vh/2b94gGhG6tlyVURlfs2QtCl832k866L6hh9eEM+opIETm
	plr9b+ZkqAGcDOP5z71mRPgy+GW+O05NNZkwGG1Kh6+gjW6cDhrzGC+Ulnq8XyS1cg1T/tBqrQJ
	i3OLv9fGibmUwOy9L0nbz/9pubxYkgXRFnsgdAgei8QyGxJYXR/gawEg/3kjV7N2L4gHokH9IRI
	Szh0FEqLDOhOG++Xrj5sot2hRVdZ1dwkDmh+gaKw2SQWErSJH1V766ebxA7+BxH3DvJAK9DZ1oJ
	VDR3ZpfoxE=
X-Gm-Gg: ASbGncs4Gbw3HOBFzs6Rgzb2zbxbA/+AKKFoKCybVuIccGqRgEMXhh/FyxELmbBi5YC
	dWVxwFjPJajCNZnAA9F7NvXPd2iZwnGkduUr00EkeqCGXUUdHHGoZOxmNG0RHDmxQ9CIvP7/7gh
	1w2nih7r4H0hep66LUY/78b5yjGUkH9nxDgS6Opb/ONJ/bDEGMkoKqoJjaPiYwkvQiU5faMpqtR
	kAc61383Oxn6vd7ne0Q05ynwVdpXAJUH0vzAmBHv4d8pYOLgBEVrA0EGpmAtuYHgxQUI0Goge8a
	NAaatrPu4HstpD3V2k9acMnmR/GRZ3yJCDMcdORr6gohccRP4OKDLAjtK5le2/j6bewqF8d6aGG
	H2zUQxLV7J5zIwvZoiDK4cVwQScJf05Y3lrWafgzhHkOT+bFp8NpVub0cfRmh7kOR+7sdgRy/wP
	8=
X-Google-Smtp-Source: AGHT+IH4rH3MIqlvyT8m/nCRZrgeCtdcCVS6TPXf6uZGpRkciKi1pkWMDdwJ1QWtdunmVPIiMJ267jOtw4ta
X-Received: by 2002:a05:6602:3409:b0:887:5799:7ab0 with SMTP id ca18e2360f4ac-89034be430cmr1207011139f.16.1757905560235;
        Sun, 14 Sep 2025 20:06:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id ca18e2360f4ac-893793eb0e6sm3163139f.15.2025.09.14.20.05.59
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Sep 2025 20:06:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b4c928089fdso5039101a12.0
        for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 20:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757905558; x=1758510358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJd0/kKLycxMmQkqbPHraxdypl0eRMdFsjzgQpNiWX0=;
        b=VE1uJAkcuTl/jaWiK4vXFlvWwC+9JggnDYGYE9/bJbuX1xJ0KoErhuyYVvO6i2jUQ0
         udUJC8vNjv3LeC3groq80Y4/Y5FW9/xSJDSsTu4x9E0PPvOB6A9ODJuxA2zxOUyUFujf
         vFfsqVZbjwcfleDbgmEBlpY5vJbthpY2TYlzk=
X-Received: by 2002:a17:903:1b68:b0:264:f3ed:ee10 with SMTP id d9443c01a7336-264f3edf620mr38819725ad.11.1757905558095;
        Sun, 14 Sep 2025 20:05:58 -0700 (PDT)
X-Received: by 2002:a17:903:1b68:b0:264:f3ed:ee10 with SMTP id d9443c01a7336-264f3edf620mr38819465ad.11.1757905557667;
        Sun, 14 Sep 2025 20:05:57 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b0219f9sm112723575ad.123.2025.09.14.20.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 20:05:56 -0700 (PDT)
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
Subject: [PATCH net-next 07/11] bnxt_en: Add err_qpc backing store handling
Date: Sun, 14 Sep 2025 20:05:01 -0700
Message-ID: <20250915030505.1803478-8-michael.chan@broadcom.com>
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
index 97165624acf5..dba3966c1ebd 100644
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


