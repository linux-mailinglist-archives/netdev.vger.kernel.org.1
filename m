Return-Path: <netdev+bounces-104665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E091490DEB6
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 23:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C314B20F0F
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 21:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1F2178377;
	Tue, 18 Jun 2024 21:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="N5DCtC8L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A36178398
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 21:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718747649; cv=none; b=sUqCRHSbG6r18lb0mC/Z6PTGVhsaQzAmAyK0mYhIulS7JIjoByF1Xnnc4+2qUCp5pTJk4L3h9NKqT/vFB+9wG5zEhTSXgPBwOxD2BhSZBM0e+1AvfTAVYprdvfId1ZaH0iMnynX5CCexSred0V1wMCQFJBFhI3wJ+DQzwR8127I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718747649; c=relaxed/simple;
	bh=+WoYcRKwrwRMsAF6lZgs6+YhWdTkpWugaDtErByjN0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nwhHnv6cd8U86IGgvW5yViRS9IVWekEox7EoZaekfVggHQFGQdYaaND9eBYqPlgnp+I7B4DcZ4DYuwq6QD7ltHFBOQuCOGy1MtsVdJLAkdhvgR6u3l+5FhNPXGjiuJBgs3m6gJwN15UkqTVMupecuw1r+7Pc6Wq5qDj7Rp7xZdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=N5DCtC8L; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-681ad26f4a5so3701069a12.2
        for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 14:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1718747647; x=1719352447; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nh2EdTHRV2/ZXV9BvlnEEE8BTfysxEPbzv9r8Spa8yA=;
        b=N5DCtC8LAgZRF9u8FnFmcmQG/hWnIKYDxBfdnDctQa4yarIsgA+yWLgb/KWwlMvGE7
         Fg3A13vFuwvOGU2zi/WCPjAxx0TrAUhx1UGGBMMiY1nFKCEeIk/kAGv9Ab1VWdej3Vq4
         NFUwAEyoJKL89u6I3GBBGzShq7zbe1mjuLBpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718747647; x=1719352447;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nh2EdTHRV2/ZXV9BvlnEEE8BTfysxEPbzv9r8Spa8yA=;
        b=uq9OvME1DG9yY45LxQtZf+h6rwDgfGbcUflJF5PnPzWMJEwJNAfyJ9znOHNJR1G6dB
         3ipvfmAV8qcY8C/i8bgcGeld9k7T5mX9/WMHU/SLTvRBR0QNKgdwpBqvzlMR1eEAV30j
         sfG7YbpSq3XLMzjFu8+pSFvTyMTH3ND96NQoRSipLa2nLRgxOe//ho+ILIccybLmShNf
         jnp99XSVw1PTXFVOCCKcLp9nqij4BUIUeLu1avDnCp5rElTcpNPU29Ff2JmPajrft+uS
         vOuetcvE9UK9qWXJRBcH9tyiimqRhrgPMIXI3aTPMP4okK7pu5mOJCRBggBq556Ywf2G
         l5Xg==
X-Gm-Message-State: AOJu0YwOMiT51ArwN3764TEvY7ybN7vCoUPSG6lll0XRPKinxiCWu85I
	FeH8kIUvpG7aEanoDi4V+XaK1OYGj3/ZlVz2vyQLI9o8UcAiHJs1mvR97hIkEi3JP9xBMCPUeUM
	=
X-Google-Smtp-Source: AGHT+IEZkMzhc6zfV033ZLNJplt2s6w0xYxQNN6Seb9DARVO+ip4XPDa5GQ32PdCdSsySBIGMIycFA==
X-Received: by 2002:a17:90a:fa17:b0:2c7:af6f:5e52 with SMTP id 98e67ed59e1d1-2c7b5c82617mr978730a91.19.1718747646264;
        Tue, 18 Jun 2024 14:54:06 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c45cbd05sm11501990a91.19.2024.06.18.14.54.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2024 14:54:04 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net 1/3] bnxt_en: Update firmware interface to 1.10.3.44
Date: Tue, 18 Jun 2024 14:53:11 -0700
Message-ID: <20240618215313.29631-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20240618215313.29631-1-michael.chan@broadcom.com>
References: <20240618215313.29631-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f7a0d6061b311ea3"

--000000000000f7a0d6061b311ea3
Content-Transfer-Encoding: 8bit

The relevant change is the max_tso_segs value returned by firmware
in the HWRM_FUNC_QCAPS response.  This value will be used in the next
patch to cap the TSO segments.

Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h | 311 ++++++++++--------
 1 file changed, 178 insertions(+), 133 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
index 06ea86c80be1..f219709f9563 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
@@ -2,7 +2,7 @@
  *
  * Copyright (c) 2014-2016 Broadcom Corporation
  * Copyright (c) 2014-2018 Broadcom Limited
- * Copyright (c) 2018-2023 Broadcom Inc.
+ * Copyright (c) 2018-2024 Broadcom Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -500,7 +500,11 @@ struct cmd_nums {
 	#define HWRM_TFC_IF_TBL_GET                       0x399UL
 	#define HWRM_TFC_TBL_SCOPE_CONFIG_GET             0x39aUL
 	#define HWRM_TFC_RESC_USAGE_QUERY                 0x39bUL
+	#define HWRM_QUEUE_PFCWD_TIMEOUT_QCAPS            0x39cUL
+	#define HWRM_QUEUE_PFCWD_TIMEOUT_CFG              0x39dUL
+	#define HWRM_QUEUE_PFCWD_TIMEOUT_QCFG             0x39eUL
 	#define HWRM_SV                                   0x400UL
+	#define HWRM_DBG_LOG_BUFFER_FLUSH                 0xff0fUL
 	#define HWRM_DBG_READ_DIRECT                      0xff10UL
 	#define HWRM_DBG_READ_INDIRECT                    0xff11UL
 	#define HWRM_DBG_WRITE_DIRECT                     0xff12UL
@@ -609,8 +613,8 @@ struct hwrm_err_output {
 #define HWRM_VERSION_MAJOR 1
 #define HWRM_VERSION_MINOR 10
 #define HWRM_VERSION_UPDATE 3
-#define HWRM_VERSION_RSVD 39
-#define HWRM_VERSION_STR "1.10.3.39"
+#define HWRM_VERSION_RSVD 44
+#define HWRM_VERSION_STR "1.10.3.44"
 
 /* hwrm_ver_get_input (size:192b/24B) */
 struct hwrm_ver_get_input {
@@ -664,6 +668,7 @@ struct hwrm_ver_get_output {
 	#define VER_GET_RESP_DEV_CAPS_CFG_CFA_TFLIB_SUPPORTED                      0x2000UL
 	#define VER_GET_RESP_DEV_CAPS_CFG_CFA_TRUFLOW_SUPPORTED                    0x4000UL
 	#define VER_GET_RESP_DEV_CAPS_CFG_SECURE_BOOT_CAPABLE                      0x8000UL
+	#define VER_GET_RESP_DEV_CAPS_CFG_SECURE_SOC_CAPABLE                       0x10000UL
 	u8	roce_fw_maj_8b;
 	u8	roce_fw_min_8b;
 	u8	roce_fw_bld_8b;
@@ -843,7 +848,9 @@ struct hwrm_async_event_cmpl {
 	#define ASYNC_EVENT_CMPL_EVENT_ID_HW_DOORBELL_RECOVERY_READ_ERROR 0x49UL
 	#define ASYNC_EVENT_CMPL_EVENT_ID_CTX_ERROR                       0x4aUL
 	#define ASYNC_EVENT_CMPL_EVENT_ID_UDCC_SESSION_CHANGE             0x4bUL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_MAX_RGTR_EVENT_ID               0x4cUL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_DBG_BUF_PRODUCER                0x4cUL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_PEER_MMAP_CHANGE                0x4dUL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_MAX_RGTR_EVENT_ID               0x4eUL
 	#define ASYNC_EVENT_CMPL_EVENT_ID_FW_TRACE_MSG                    0xfeUL
 	#define ASYNC_EVENT_CMPL_EVENT_ID_HWRM_ERROR                      0xffUL
 	#define ASYNC_EVENT_CMPL_EVENT_ID_LAST                           ASYNC_EVENT_CMPL_EVENT_ID_HWRM_ERROR
@@ -1326,13 +1333,13 @@ struct hwrm_async_event_cmpl_error_report_base {
 	u8	timestamp_lo;
 	__le16	timestamp_hi;
 	__le32	event_data1;
-	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_MASK                   0xffUL
-	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_SFT                    0
-	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_RESERVED                 0x0UL
-	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_PAUSE_STORM              0x1UL
-	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_INVALID_SIGNAL           0x2UL
-	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_NVM                      0x3UL
-	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_DOORBELL_DROP_THRESHOLD  0x4UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_MASK                        0xffUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_SFT                         0
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_RESERVED                      0x0UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_PAUSE_STORM                   0x1UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_INVALID_SIGNAL                0x2UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_NVM                           0x3UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_DOORBELL_DROP_THRESHOLD       0x4UL
 	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_THERMAL_THRESHOLD             0x5UL
 	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_DUAL_DATA_RATE_NOT_SUPPORTED  0x6UL
 	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_LAST                         ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_DUAL_DATA_RATE_NOT_SUPPORTED
@@ -1814,6 +1821,9 @@ struct hwrm_func_qcaps_output {
 	#define FUNC_QCAPS_RESP_FLAGS_EXT2_SW_MAX_RESOURCE_LIMITS_SUPPORTED      0x800000UL
 	#define FUNC_QCAPS_RESP_FLAGS_EXT2_TF_INGRESS_NIC_FLOW_SUPPORTED         0x1000000UL
 	#define FUNC_QCAPS_RESP_FLAGS_EXT2_LPBK_STATS_SUPPORTED                  0x2000000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_TF_EGRESS_NIC_FLOW_SUPPORTED          0x4000000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_MULTI_LOSSLESS_QUEUES_SUPPORTED       0x8000000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_PEER_MMAP_SUPPORTED                   0x10000000UL
 	__le16	tunnel_disable_flag;
 	#define FUNC_QCAPS_RESP_TUNNEL_DISABLE_FLAG_DISABLE_VXLAN      0x1UL
 	#define FUNC_QCAPS_RESP_TUNNEL_DISABLE_FLAG_DISABLE_NGE        0x2UL
@@ -1828,7 +1838,7 @@ struct hwrm_func_qcaps_output {
 	#define FUNC_QCAPS_RESP_XID_PARTITION_CAP_RX_CK     0x2UL
 	u8	device_serial_number[8];
 	__le16	ctxs_per_partition;
-	u8	unused_2[2];
+	__le16	max_tso_segs;
 	__le32	roce_vf_max_av;
 	__le32	roce_vf_max_cq;
 	__le32	roce_vf_max_mrw;
@@ -2449,6 +2459,7 @@ struct hwrm_func_drv_rgtr_input {
 	#define FUNC_DRV_RGTR_REQ_FLAGS_NPAR_1_2_SUPPORT                 0x200UL
 	#define FUNC_DRV_RGTR_REQ_FLAGS_ASYM_QUEUE_CFG_SUPPORT           0x400UL
 	#define FUNC_DRV_RGTR_REQ_FLAGS_TF_INGRESS_NIC_FLOW_MODE         0x800UL
+	#define FUNC_DRV_RGTR_REQ_FLAGS_TF_EGRESS_NIC_FLOW_MODE          0x1000UL
 	__le32	enables;
 	#define FUNC_DRV_RGTR_REQ_ENABLES_OS_TYPE             0x1UL
 	#define FUNC_DRV_RGTR_REQ_ENABLES_VER                 0x2UL
@@ -3660,22 +3671,24 @@ struct hwrm_func_backing_store_cfg_v2_input {
 	__le16	target_id;
 	__le64	resp_addr;
 	__le16	type;
-	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_QP            0x0UL
-	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_SRQ           0x1UL
-	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_CQ            0x2UL
-	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_VNIC          0x3UL
-	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_STAT          0x4UL
-	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_SP_TQM_RING   0x5UL
-	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_FP_TQM_RING   0x6UL
-	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_MRAV          0xeUL
-	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_TIM           0xfUL
-	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_MP_TQM_RING   0x15UL
-	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_SQ_DB_SHADOW  0x16UL
-	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_RQ_DB_SHADOW  0x17UL
-	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_SRQ_DB_SHADOW 0x18UL
-	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_CQ_DB_SHADOW  0x19UL
-	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_TBL_SCOPE     0x1cUL
-	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_XID_PARTITION 0x1dUL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_QP              0x0UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_SRQ             0x1UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_CQ              0x2UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_VNIC            0x3UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_STAT            0x4UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_SP_TQM_RING     0x5UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_FP_TQM_RING     0x6UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_MRAV            0xeUL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_TIM             0xfUL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_TX_CK           0x13UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_RX_CK           0x14UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_MP_TQM_RING     0x15UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_SQ_DB_SHADOW    0x16UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_RQ_DB_SHADOW    0x17UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_SRQ_DB_SHADOW   0x18UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_CQ_DB_SHADOW    0x19UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_TBL_SCOPE       0x1cUL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_XID_PARTITION   0x1dUL
 	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_SRT_TRACE       0x1eUL
 	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_SRT2_TRACE      0x1fUL
 	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_CRT_TRACE       0x20UL
@@ -3772,18 +3785,20 @@ struct hwrm_func_backing_store_qcfg_v2_output {
 	__le16	seq_id;
 	__le16	resp_len;
 	__le16	type;
-	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_QP            0x0UL
-	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_SRQ           0x1UL
-	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_CQ            0x2UL
-	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_VNIC          0x3UL
-	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_STAT          0x4UL
-	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_SP_TQM_RING   0x5UL
-	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_FP_TQM_RING   0x6UL
-	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_MRAV          0xeUL
-	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_TIM           0xfUL
-	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_MP_TQM_RING   0x15UL
-	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_TBL_SCOPE     0x1cUL
-	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_XID_PARTITION 0x1dUL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_QP              0x0UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_SRQ             0x1UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_CQ              0x2UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_VNIC            0x3UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_STAT            0x4UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_SP_TQM_RING     0x5UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_FP_TQM_RING     0x6UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_MRAV            0xeUL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_TIM             0xfUL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_TX_CK           0x13UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_RX_CK           0x14UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_MP_TQM_RING     0x15UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_TBL_SCOPE       0x1cUL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_XID_PARTITION   0x1dUL
 	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_SRT_TRACE       0x1eUL
 	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_SRT2_TRACE      0x1fUL
 	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_CRT_TRACE       0x20UL
@@ -3876,22 +3891,24 @@ struct hwrm_func_backing_store_qcaps_v2_input {
 	__le16	target_id;
 	__le64	resp_addr;
 	__le16	type;
-	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_QP            0x0UL
-	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_SRQ           0x1UL
-	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_CQ            0x2UL
-	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_VNIC          0x3UL
-	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_STAT          0x4UL
-	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_SP_TQM_RING   0x5UL
-	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_FP_TQM_RING   0x6UL
-	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_MRAV          0xeUL
-	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_TIM           0xfUL
-	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_MP_TQM_RING   0x15UL
-	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_SQ_DB_SHADOW  0x16UL
-	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_RQ_DB_SHADOW  0x17UL
-	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_SRQ_DB_SHADOW 0x18UL
-	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_CQ_DB_SHADOW  0x19UL
-	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_TBL_SCOPE     0x1cUL
-	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_XID_PARTITION 0x1dUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_QP              0x0UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_SRQ             0x1UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_CQ              0x2UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_VNIC            0x3UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_STAT            0x4UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_SP_TQM_RING     0x5UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_FP_TQM_RING     0x6UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_MRAV            0xeUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_TIM             0xfUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_TX_CK           0x13UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_RX_CK           0x14UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_MP_TQM_RING     0x15UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_SQ_DB_SHADOW    0x16UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_RQ_DB_SHADOW    0x17UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_SRQ_DB_SHADOW   0x18UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_CQ_DB_SHADOW    0x19UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_TBL_SCOPE       0x1cUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_XID_PARTITION   0x1dUL
 	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_SRT_TRACE       0x1eUL
 	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_SRT2_TRACE      0x1fUL
 	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_CRT_TRACE       0x20UL
@@ -3911,22 +3928,24 @@ struct hwrm_func_backing_store_qcaps_v2_output {
 	__le16	seq_id;
 	__le16	resp_len;
 	__le16	type;
-	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_QP            0x0UL
-	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_SRQ           0x1UL
-	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_CQ            0x2UL
-	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_VNIC          0x3UL
-	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_STAT          0x4UL
-	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_SP_TQM_RING   0x5UL
-	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_FP_TQM_RING   0x6UL
-	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_MRAV          0xeUL
-	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_TIM           0xfUL
-	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_MP_TQM_RING   0x15UL
-	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_SQ_DB_SHADOW  0x16UL
-	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_RQ_DB_SHADOW  0x17UL
-	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_SRQ_DB_SHADOW 0x18UL
-	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_CQ_DB_SHADOW  0x19UL
-	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_TBL_SCOPE     0x1cUL
-	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_XID_PARTITION 0x1dUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_QP              0x0UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_SRQ             0x1UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_CQ              0x2UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_VNIC            0x3UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_STAT            0x4UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_SP_TQM_RING     0x5UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_FP_TQM_RING     0x6UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_MRAV            0xeUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_TIM             0xfUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_TX_CK           0x13UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_RX_CK           0x14UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_MP_TQM_RING     0x15UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_SQ_DB_SHADOW    0x16UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_RQ_DB_SHADOW    0x17UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_SRQ_DB_SHADOW   0x18UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_CQ_DB_SHADOW    0x19UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_TBL_SCOPE       0x1cUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_XID_PARTITION   0x1dUL
 	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_SRT_TRACE       0x1eUL
 	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_SRT2_TRACE      0x1fUL
 	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_CRT_TRACE       0x20UL
@@ -4202,7 +4221,8 @@ struct hwrm_port_phy_cfg_input {
 	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_100GB_PAM4_112 0x3eaUL
 	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_200GB_PAM4_112 0x7d2UL
 	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_400GB_PAM4_112 0xfa2UL
-	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_LAST          PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_400GB_PAM4_112
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_800GB_PAM4_112 0x1f42UL
+	#define PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_LAST          PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_800GB_PAM4_112
 	__le16	auto_link_speeds2_mask;
 	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEEDS2_MASK_1GB                0x1UL
 	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEEDS2_MASK_10GB               0x2UL
@@ -4217,6 +4237,7 @@ struct hwrm_port_phy_cfg_input {
 	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEEDS2_MASK_100GB_PAM4_112     0x400UL
 	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEEDS2_MASK_200GB_PAM4_112     0x800UL
 	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEEDS2_MASK_400GB_PAM4_112     0x1000UL
+	#define PORT_PHY_CFG_REQ_AUTO_LINK_SPEEDS2_MASK_800GB_PAM4_112     0x2000UL
 	u8	unused_2[6];
 };
 
@@ -4292,6 +4313,7 @@ struct hwrm_port_phy_qcfg_output {
 	#define PORT_PHY_QCFG_RESP_LINK_SPEED_100GB 0x3e8UL
 	#define PORT_PHY_QCFG_RESP_LINK_SPEED_200GB 0x7d0UL
 	#define PORT_PHY_QCFG_RESP_LINK_SPEED_400GB 0xfa0UL
+	#define PORT_PHY_QCFG_RESP_LINK_SPEED_800GB 0x1f40UL
 	#define PORT_PHY_QCFG_RESP_LINK_SPEED_10MB  0xffffUL
 	#define PORT_PHY_QCFG_RESP_LINK_SPEED_LAST PORT_PHY_QCFG_RESP_LINK_SPEED_10MB
 	u8	duplex_cfg;
@@ -4451,7 +4473,13 @@ struct hwrm_port_phy_qcfg_output {
 	#define PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASESR4     0x35UL
 	#define PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASELR4     0x36UL
 	#define PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASEER4     0x37UL
-	#define PORT_PHY_QCFG_RESP_PHY_TYPE_LAST            PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASEER4
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_800G_BASECR8     0x38UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_800G_BASESR8     0x39UL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_800G_BASELR8     0x3aUL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_800G_BASEER8     0x3bUL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_800G_BASEFR8     0x3cUL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_800G_BASEDR8     0x3dUL
+	#define PORT_PHY_QCFG_RESP_PHY_TYPE_LAST            PORT_PHY_QCFG_RESP_PHY_TYPE_800G_BASEDR8
 	u8	media_type;
 	#define PORT_PHY_QCFG_RESP_MEDIA_TYPE_UNKNOWN 0x0UL
 	#define PORT_PHY_QCFG_RESP_MEDIA_TYPE_TP      0x1UL
@@ -5049,33 +5077,43 @@ struct hwrm_port_qstats_ext_output {
 	u8	valid;
 };
 
-/* hwrm_port_lpbk_qstats_input (size:128b/16B) */
+/* hwrm_port_lpbk_qstats_input (size:256b/32B) */
 struct hwrm_port_lpbk_qstats_input {
 	__le16	req_type;
 	__le16	cmpl_ring;
 	__le16	seq_id;
 	__le16	target_id;
 	__le64	resp_addr;
+	__le16	lpbk_stat_size;
+	u8	flags;
+	#define PORT_LPBK_QSTATS_REQ_FLAGS_COUNTER_MASK     0x1UL
+	u8	unused_0[5];
+	__le64	lpbk_stat_host_addr;
 };
 
-/* hwrm_port_lpbk_qstats_output (size:768b/96B) */
+/* hwrm_port_lpbk_qstats_output (size:128b/16B) */
 struct hwrm_port_lpbk_qstats_output {
 	__le16	error_code;
 	__le16	req_type;
 	__le16	seq_id;
 	__le16	resp_len;
+	__le16	lpbk_stat_size;
+	u8	unused_0[5];
+	u8	valid;
+};
+
+/* port_lpbk_stats (size:640b/80B) */
+struct port_lpbk_stats {
 	__le64	lpbk_ucast_frames;
 	__le64	lpbk_mcast_frames;
 	__le64	lpbk_bcast_frames;
 	__le64	lpbk_ucast_bytes;
 	__le64	lpbk_mcast_bytes;
 	__le64	lpbk_bcast_bytes;
-	__le64	tx_stat_discard;
-	__le64	tx_stat_error;
-	__le64	rx_stat_discard;
-	__le64	rx_stat_error;
-	u8	unused_0[7];
-	u8	valid;
+	__le64	lpbk_tx_discards;
+	__le64	lpbk_tx_errors;
+	__le64	lpbk_rx_discards;
+	__le64	lpbk_rx_errors;
 };
 
 /* hwrm_port_ecn_qstats_input (size:256b/32B) */
@@ -5140,13 +5178,15 @@ struct hwrm_port_clr_stats_output {
 	u8	valid;
 };
 
-/* hwrm_port_lpbk_clr_stats_input (size:128b/16B) */
+/* hwrm_port_lpbk_clr_stats_input (size:192b/24B) */
 struct hwrm_port_lpbk_clr_stats_input {
 	__le16	req_type;
 	__le16	cmpl_ring;
 	__le16	seq_id;
 	__le16	target_id;
 	__le64	resp_addr;
+	__le16	port_id;
+	u8	unused_0[6];
 };
 
 /* hwrm_port_lpbk_clr_stats_output (size:128b/16B) */
@@ -5287,10 +5327,11 @@ struct hwrm_port_phy_qcaps_output {
 	#define PORT_PHY_QCAPS_RESP_SUPPORTED_PAM4_SPEEDS_FORCE_MODE_100G     0x2UL
 	#define PORT_PHY_QCAPS_RESP_SUPPORTED_PAM4_SPEEDS_FORCE_MODE_200G     0x4UL
 	__le16	flags2;
-	#define PORT_PHY_QCAPS_RESP_FLAGS2_PAUSE_UNSUPPORTED       0x1UL
-	#define PORT_PHY_QCAPS_RESP_FLAGS2_PFC_UNSUPPORTED         0x2UL
-	#define PORT_PHY_QCAPS_RESP_FLAGS2_BANK_ADDR_SUPPORTED     0x4UL
-	#define PORT_PHY_QCAPS_RESP_FLAGS2_SPEEDS2_SUPPORTED       0x8UL
+	#define PORT_PHY_QCAPS_RESP_FLAGS2_PAUSE_UNSUPPORTED           0x1UL
+	#define PORT_PHY_QCAPS_RESP_FLAGS2_PFC_UNSUPPORTED             0x2UL
+	#define PORT_PHY_QCAPS_RESP_FLAGS2_BANK_ADDR_SUPPORTED         0x4UL
+	#define PORT_PHY_QCAPS_RESP_FLAGS2_SPEEDS2_SUPPORTED           0x8UL
+	#define PORT_PHY_QCAPS_RESP_FLAGS2_REMOTE_LPBK_UNSUPPORTED     0x10UL
 	u8	internal_port_cnt;
 	u8	unused_0;
 	__le16	supported_speeds2_force_mode;
@@ -7443,17 +7484,17 @@ struct hwrm_cfa_l2_filter_cfg_input {
 	__le16	target_id;
 	__le64	resp_addr;
 	__le32	flags;
-	#define CFA_L2_FILTER_CFG_REQ_FLAGS_PATH              0x1UL
-	#define CFA_L2_FILTER_CFG_REQ_FLAGS_PATH_TX             0x0UL
-	#define CFA_L2_FILTER_CFG_REQ_FLAGS_PATH_RX             0x1UL
-	#define CFA_L2_FILTER_CFG_REQ_FLAGS_PATH_LAST          CFA_L2_FILTER_CFG_REQ_FLAGS_PATH_RX
-	#define CFA_L2_FILTER_CFG_REQ_FLAGS_DROP              0x2UL
-	#define CFA_L2_FILTER_CFG_REQ_FLAGS_TRAFFIC_MASK      0xcUL
-	#define CFA_L2_FILTER_CFG_REQ_FLAGS_TRAFFIC_SFT       2
-	#define CFA_L2_FILTER_CFG_REQ_FLAGS_TRAFFIC_NO_ROCE_L2  (0x0UL << 2)
-	#define CFA_L2_FILTER_CFG_REQ_FLAGS_TRAFFIC_L2          (0x1UL << 2)
-	#define CFA_L2_FILTER_CFG_REQ_FLAGS_TRAFFIC_ROCE        (0x2UL << 2)
-	#define CFA_L2_FILTER_CFG_REQ_FLAGS_TRAFFIC_LAST       CFA_L2_FILTER_CFG_REQ_FLAGS_TRAFFIC_ROCE
+	#define CFA_L2_FILTER_CFG_REQ_FLAGS_PATH                0x1UL
+	#define CFA_L2_FILTER_CFG_REQ_FLAGS_PATH_TX               0x0UL
+	#define CFA_L2_FILTER_CFG_REQ_FLAGS_PATH_RX               0x1UL
+	#define CFA_L2_FILTER_CFG_REQ_FLAGS_PATH_LAST            CFA_L2_FILTER_CFG_REQ_FLAGS_PATH_RX
+	#define CFA_L2_FILTER_CFG_REQ_FLAGS_DROP                0x2UL
+	#define CFA_L2_FILTER_CFG_REQ_FLAGS_TRAFFIC_MASK        0xcUL
+	#define CFA_L2_FILTER_CFG_REQ_FLAGS_TRAFFIC_SFT         2
+	#define CFA_L2_FILTER_CFG_REQ_FLAGS_TRAFFIC_NO_ROCE_L2    (0x0UL << 2)
+	#define CFA_L2_FILTER_CFG_REQ_FLAGS_TRAFFIC_L2            (0x1UL << 2)
+	#define CFA_L2_FILTER_CFG_REQ_FLAGS_TRAFFIC_ROCE          (0x2UL << 2)
+	#define CFA_L2_FILTER_CFG_REQ_FLAGS_TRAFFIC_LAST         CFA_L2_FILTER_CFG_REQ_FLAGS_TRAFFIC_ROCE
 	#define CFA_L2_FILTER_CFG_REQ_FLAGS_REMAP_OP_MASK       0x30UL
 	#define CFA_L2_FILTER_CFG_REQ_FLAGS_REMAP_OP_SFT        4
 	#define CFA_L2_FILTER_CFG_REQ_FLAGS_REMAP_OP_NO_UPDATE    (0x0UL << 4)
@@ -8520,17 +8561,17 @@ struct hwrm_tunnel_dst_port_query_input {
 	__le16	target_id;
 	__le64	resp_addr;
 	u8	tunnel_type;
-	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_VXLAN        0x1UL
-	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_GENEVE       0x5UL
-	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_VXLAN_V4     0x9UL
-	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_IPGRE_V1     0xaUL
-	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_L2_ETYPE     0xbUL
-	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_VXLAN_GPE_V6 0xcUL
-	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_CUSTOM_GRE   0xdUL
-	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_ECPRI        0xeUL
-	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_SRV6         0xfUL
-	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_VXLAN_GPE    0x10UL
-	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_GRE          0x11UL
+	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_VXLAN              0x1UL
+	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_GENEVE             0x5UL
+	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_VXLAN_V4           0x9UL
+	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_IPGRE_V1           0xaUL
+	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_L2_ETYPE           0xbUL
+	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_VXLAN_GPE_V6       0xcUL
+	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_CUSTOM_GRE         0xdUL
+	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_ECPRI              0xeUL
+	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_SRV6               0xfUL
+	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_VXLAN_GPE          0x10UL
+	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_GRE                0x11UL
 	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_ULP_DYN_UPAR       0x12UL
 	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES01 0x13UL
 	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES02 0x14UL
@@ -8576,17 +8617,17 @@ struct hwrm_tunnel_dst_port_alloc_input {
 	__le16	target_id;
 	__le64	resp_addr;
 	u8	tunnel_type;
-	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_VXLAN        0x1UL
-	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_GENEVE       0x5UL
-	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_VXLAN_V4     0x9UL
-	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_IPGRE_V1     0xaUL
-	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_L2_ETYPE     0xbUL
-	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_VXLAN_GPE_V6 0xcUL
-	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_CUSTOM_GRE   0xdUL
-	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_ECPRI        0xeUL
-	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_SRV6         0xfUL
-	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_VXLAN_GPE    0x10UL
-	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_GRE          0x11UL
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_VXLAN              0x1UL
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_GENEVE             0x5UL
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_VXLAN_V4           0x9UL
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_IPGRE_V1           0xaUL
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_L2_ETYPE           0xbUL
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_VXLAN_GPE_V6       0xcUL
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_CUSTOM_GRE         0xdUL
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_ECPRI              0xeUL
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_SRV6               0xfUL
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_VXLAN_GPE          0x10UL
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_GRE                0x11UL
 	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_ULP_DYN_UPAR       0x12UL
 	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES01 0x13UL
 	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES02 0x14UL
@@ -8635,17 +8676,17 @@ struct hwrm_tunnel_dst_port_free_input {
 	__le16	target_id;
 	__le64	resp_addr;
 	u8	tunnel_type;
-	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_VXLAN        0x1UL
-	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_GENEVE       0x5UL
-	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_VXLAN_V4     0x9UL
-	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_IPGRE_V1     0xaUL
-	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_L2_ETYPE     0xbUL
-	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_VXLAN_GPE_V6 0xcUL
-	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_CUSTOM_GRE   0xdUL
-	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_ECPRI        0xeUL
-	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_SRV6         0xfUL
-	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_VXLAN_GPE    0x10UL
-	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_GRE          0x11UL
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_VXLAN              0x1UL
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_GENEVE             0x5UL
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_VXLAN_V4           0x9UL
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_IPGRE_V1           0xaUL
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_L2_ETYPE           0xbUL
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_VXLAN_GPE_V6       0xcUL
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_CUSTOM_GRE         0xdUL
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_ECPRI              0xeUL
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_SRV6               0xfUL
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_VXLAN_GPE          0x10UL
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_GRE                0x11UL
 	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_ULP_DYN_UPAR       0x12UL
 	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES01 0x13UL
 	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES02 0x14UL
@@ -9109,6 +9150,7 @@ struct hwrm_struct_hdr {
 	#define STRUCT_HDR_STRUCT_ID_LLDP_GENERIC       0x424UL
 	#define STRUCT_HDR_STRUCT_ID_LLDP_DEVICE        0x426UL
 	#define STRUCT_HDR_STRUCT_ID_POWER_BKUP         0x427UL
+	#define STRUCT_HDR_STRUCT_ID_PEER_MMAP          0x429UL
 	#define STRUCT_HDR_STRUCT_ID_AFM_OPAQUE         0x1UL
 	#define STRUCT_HDR_STRUCT_ID_PORT_DESCRIPTION   0xaUL
 	#define STRUCT_HDR_STRUCT_ID_RSS_V2             0x64UL
@@ -9758,6 +9800,9 @@ struct hwrm_dbg_coredump_initiate_input {
 	__le16	instance;
 	__le16	unused_0;
 	u8	seg_flags;
+	#define DBG_COREDUMP_INITIATE_REQ_SEG_FLAGS_LIVE_DATA                0x1UL
+	#define DBG_COREDUMP_INITIATE_REQ_SEG_FLAGS_CRASH_DATA               0x2UL
+	#define DBG_COREDUMP_INITIATE_REQ_SEG_FLAGS_COLLECT_CTX_L1_CACHE     0x4UL
 	u8	unused_1[7];
 };
 
@@ -10433,13 +10478,13 @@ struct hwrm_selftest_irq_output {
 
 /* dbc_dbc (size:64b/8B) */
 struct dbc_dbc {
-	u32	index;
+	__le32	index;
 	#define DBC_DBC_INDEX_MASK 0xffffffUL
 	#define DBC_DBC_INDEX_SFT  0
 	#define DBC_DBC_EPOCH      0x1000000UL
 	#define DBC_DBC_TOGGLE_MASK 0x6000000UL
 	#define DBC_DBC_TOGGLE_SFT 25
-	u32	type_path_xid;
+	__le32	type_path_xid;
 	#define DBC_DBC_XID_MASK          0xfffffUL
 	#define DBC_DBC_XID_SFT           0
 	#define DBC_DBC_PATH_MASK         0x3000000UL
-- 
2.30.1


--000000000000f7a0d6061b311ea3
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIGqKLEDRQZzzDQ5pN/8G0q0bBqSzFfAB
FyFGMHvqQYC6MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYx
ODIxNTQwN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAFRhTkxwm0cAIZvdzDquG3Y2kHFS9F5m08zpiRVVDHb76ZNHFR
mprWdPKIkoqlAZo4BKFSeVsK26W1tNu7ZL4wh7tjmJT3h7wd2ENNpQ5Ta0Wg1U08yMyuYZtNZ1HM
mmv6+w2lR32aJ7UFQVHpKbOz4akjT0Wi33fG+kVP5mH4YRsDByTdx1pYzzmKjbdvHZLtJl9jzF+i
JOthYVLGqyb09uAD3Xmvnvb7HP7WgbFDYCQGWOsbkDo4IJ+vCr9raWfIFcXWcRQHi4PppAgGbxvp
gawl7yPwSj+yLFrRG3F21a8nkRqRhBBjfuVlRqYfYmjgqoe7irvoSLEIb9jLY3D9
--000000000000f7a0d6061b311ea3--

