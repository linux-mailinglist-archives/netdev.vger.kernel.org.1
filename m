Return-Path: <netdev+bounces-144314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAD19C68CA
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 06:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F021F242DF
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 05:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73100176AAD;
	Wed, 13 Nov 2024 05:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ApD7YE5p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD94175D56
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 05:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731476389; cv=none; b=cZ9IIxYd6hdZS6BtiNWZaQu2iG4l4vtEBFEqegkP7cBbBvJsl/6Dm9ialoVDcLrSsba2B+x1PGbSNs269l/ywx9eiiwk1CKCdl1bE8qCRCKYyixMHu1G2dzF9bkRTV0hRS7bmmCsBHm/SqTP/rDiyZYXkecV+rgseMc7+fU+Vrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731476389; c=relaxed/simple;
	bh=XacHuM8vKrBHgLgIfRVZ6M/qWY0dJzdArDQc3r6tVlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=phABSbhm3Yq5cMNCpPaYUwuGgJB3rQHDUFkz8hkvEaOmS/tgm0zHEBFl7Qme6CXfibqhoJKvSIDd4yk1dvGEULKFWIoGwzBng077rL3LGTZ5ZXfZ5Y4qOn/zlREHgrnltmftpvdEPs25Aj2YT1voMcB/QrjNEfrF50AU9uRyprw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ApD7YE5p; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4609d75e2f8so3099511cf.1
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 21:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731476386; x=1732081186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggb97B2ktUFXPM7KcwtCnbBpziFVzkFdrZnM9GfL95U=;
        b=ApD7YE5poF6pJVzQTEMPPvmW6Is38ajrDFxRkLKhOjHeygxBtYmRMKoEQQBpMO5On7
         scH70FYumTKf+OnrSvtbfczELPsaU3RPxM1xF834uoZJvqXK0ORuRCmqo2nhaE5AWkAa
         wm/Hh+ukmxf5yzZOHgZgzG5PP87Tei7TAjyOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731476386; x=1732081186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ggb97B2ktUFXPM7KcwtCnbBpziFVzkFdrZnM9GfL95U=;
        b=xLpsrxlhNw0fYMrFEqZAVn0LgPUBI0VAmqy6eWaYLPAsR4qkHwltT1FP6z82MnHRkF
         jFQD1RWICyo/8ql0BHY2UDzSrsPQc2MOkDeNCQMpdN8OJgaef2con44DJ8DLdyq3q75B
         gPi7zo3TYCJehSMvt46v1CI0g4eqEHUgd6+6TvKMlTyl4CI/BBqloPBnTunUdZOmmZaQ
         TdoR7Sa6sm7VMfUzNERzzNOr79l8VpOQP6gs/FJI/5U09eEyv+o/1vZsqgrn4T/Gct5v
         7TpZst4pAm6mhx1mlgi3+W8ZYGoHGBG+AGPdHQARaWIrWzpZUPZmaMxW9pbAUuD97pE5
         jNmg==
X-Gm-Message-State: AOJu0Yx3+NAQ2EzqJjj16zWgrHTxipkgSf/biHXIUeUK1Ahs0Qv/UBRg
	dSRsaqOsQkJagxSJnEF/FWzF3QPnBzzAfDH0oLNnscZan15VcK/hFB9x3l+aGg==
X-Google-Smtp-Source: AGHT+IGv9zOti9yfPMTWy02DLX5J87xT+c1f8Y3YrEbqkpk3IYbXl1x+jBIL0jIrYU6ILGJN1LCmAA==
X-Received: by 2002:a05:622a:4b0a:b0:461:43d4:fcb3 with SMTP id d75a77b69052e-46309ac630cmr293652401cf.13.1731476385879;
        Tue, 12 Nov 2024 21:39:45 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff5e14f9sm83457491cf.86.2024.11.12.21.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 21:39:45 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	andrew.gospodarek@broadcom.com,
	hongguang.gao@broadcom.com,
	shruti.parab@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next 01/11] bnxt_en: Update firmware interface spec to 1.10.3.85
Date: Tue, 12 Nov 2024 21:36:39 -0800
Message-ID: <20241113053649.405407-2-michael.chan@broadcom.com>
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

The major change is the new firmware command to flush the FW debug
logs to the host backing store context memory buffers.

Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h | 173 ++++++++++++++----
 1 file changed, 136 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
index f8ef6f1a1964..b3aeecac565e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
@@ -42,6 +42,10 @@ struct hwrm_resp_hdr {
 #define TLV_TYPE_MODIFY_ROCE_CC_GEN1             0x5UL
 #define TLV_TYPE_QUERY_ROCE_CC_GEN2              0x6UL
 #define TLV_TYPE_MODIFY_ROCE_CC_GEN2             0x7UL
+#define TLV_TYPE_QUERY_ROCE_CC_GEN1_EXT          0x8UL
+#define TLV_TYPE_MODIFY_ROCE_CC_GEN1_EXT         0x9UL
+#define TLV_TYPE_QUERY_ROCE_CC_GEN2_EXT          0xaUL
+#define TLV_TYPE_MODIFY_ROCE_CC_GEN2_EXT         0xbUL
 #define TLV_TYPE_ENGINE_CKV_ALIAS_ECC_PUBLIC_KEY 0x8001UL
 #define TLV_TYPE_ENGINE_CKV_IV                   0x8003UL
 #define TLV_TYPE_ENGINE_CKV_AUTH_TAG             0x8004UL
@@ -509,6 +513,7 @@ struct cmd_nums {
 	#define HWRM_TFC_IF_TBL_GET                       0x399UL
 	#define HWRM_TFC_TBL_SCOPE_CONFIG_GET             0x39aUL
 	#define HWRM_TFC_RESC_USAGE_QUERY                 0x39bUL
+	#define HWRM_TFC_GLOBAL_ID_FREE                   0x39cUL
 	#define HWRM_SV                                   0x400UL
 	#define HWRM_DBG_SERDES_TEST                      0xff0eUL
 	#define HWRM_DBG_LOG_BUFFER_FLUSH                 0xff0fUL
@@ -624,8 +629,8 @@ struct hwrm_err_output {
 #define HWRM_VERSION_MAJOR 1
 #define HWRM_VERSION_MINOR 10
 #define HWRM_VERSION_UPDATE 3
-#define HWRM_VERSION_RSVD 68
-#define HWRM_VERSION_STR "1.10.3.68"
+#define HWRM_VERSION_RSVD 85
+#define HWRM_VERSION_STR "1.10.3.85"
 
 /* hwrm_ver_get_input (size:192b/24B) */
 struct hwrm_ver_get_input {
@@ -1302,6 +1307,43 @@ struct hwrm_async_event_cmpl_error_report {
 	#define ASYNC_EVENT_CMPL_ERROR_REPORT_EVENT_DATA1_ERROR_TYPE_SFT 0
 };
 
+/* hwrm_async_event_cmpl_dbg_buf_producer (size:128b/16B) */
+struct hwrm_async_event_cmpl_dbg_buf_producer {
+	__le16	type;
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_TYPE_MASK            0x3fUL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_TYPE_SFT             0
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_TYPE_HWRM_ASYNC_EVENT  0x2eUL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_TYPE_LAST             ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_TYPE_HWRM_ASYNC_EVENT
+	__le16	event_id;
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_ID_DBG_BUF_PRODUCER 0x4cUL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_ID_LAST            ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_ID_DBG_BUF_PRODUCER
+	__le32	event_data2;
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA2_CURRENT_BUFFER_OFFSET_MASK 0xffffffffUL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA2_CURRENT_BUFFER_OFFSET_SFT 0
+	u8	opaque_v;
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_V          0x1UL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_OPAQUE_MASK 0xfeUL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_OPAQUE_SFT 1
+	u8	timestamp_lo;
+	__le16	timestamp_hi;
+	__le32	event_data1;
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_MASK               0xffffUL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_SFT                0
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_SRT_TRACE            0x0UL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_SRT2_TRACE           0x1UL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_CRT_TRACE            0x2UL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_CRT2_TRACE           0x3UL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_RIGP0_TRACE          0x4UL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_L2_HWRM_TRACE        0x5UL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_ROCE_HWRM_TRACE      0x6UL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_CA0_TRACE            0x7UL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_CA1_TRACE            0x8UL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_CA2_TRACE            0x9UL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_RIGP1_TRACE          0xaUL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_AFM_KONG_HWRM_TRACE  0xbUL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_LAST                ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_AFM_KONG_HWRM_TRACE
+};
+
 /* hwrm_async_event_cmpl_hwrm_error (size:128b/16B) */
 struct hwrm_async_event_cmpl_hwrm_error {
 	__le16	type;
@@ -1864,7 +1906,10 @@ struct hwrm_func_qcaps_output {
 	__le32	roce_vf_max_gid;
 	__le32	flags_ext3;
 	#define FUNC_QCAPS_RESP_FLAGS_EXT3_RM_RSV_WHILE_ALLOC_CAP     0x1UL
-	u8	unused_3[7];
+	#define FUNC_QCAPS_RESP_FLAGS_EXT3_REQUIRE_L2_FILTER          0x2UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT3_MAX_ROCE_VFS_SUPPORTED     0x4UL
+	__le16	max_roce_vfs;
+	u8	unused_3[5];
 	u8	valid;
 };
 
@@ -2253,17 +2298,18 @@ struct hwrm_func_cfg_input {
 	#define FUNC_CFG_REQ_FLAGS2_KTLS_KEY_CTX_ASSETS_TEST     0x1UL
 	#define FUNC_CFG_REQ_FLAGS2_QUIC_KEY_CTX_ASSETS_TEST     0x2UL
 	__le32	enables2;
-	#define FUNC_CFG_REQ_ENABLES2_KDNET                   0x1UL
-	#define FUNC_CFG_REQ_ENABLES2_DB_PAGE_SIZE            0x2UL
-	#define FUNC_CFG_REQ_ENABLES2_QUIC_TX_KEY_CTXS        0x4UL
-	#define FUNC_CFG_REQ_ENABLES2_QUIC_RX_KEY_CTXS        0x8UL
-	#define FUNC_CFG_REQ_ENABLES2_ROCE_MAX_AV_PER_VF      0x10UL
-	#define FUNC_CFG_REQ_ENABLES2_ROCE_MAX_CQ_PER_VF      0x20UL
-	#define FUNC_CFG_REQ_ENABLES2_ROCE_MAX_MRW_PER_VF     0x40UL
-	#define FUNC_CFG_REQ_ENABLES2_ROCE_MAX_QP_PER_VF      0x80UL
-	#define FUNC_CFG_REQ_ENABLES2_ROCE_MAX_SRQ_PER_VF     0x100UL
-	#define FUNC_CFG_REQ_ENABLES2_ROCE_MAX_GID_PER_VF     0x200UL
-	#define FUNC_CFG_REQ_ENABLES2_XID_PARTITION_CFG       0x400UL
+	#define FUNC_CFG_REQ_ENABLES2_KDNET                    0x1UL
+	#define FUNC_CFG_REQ_ENABLES2_DB_PAGE_SIZE             0x2UL
+	#define FUNC_CFG_REQ_ENABLES2_QUIC_TX_KEY_CTXS         0x4UL
+	#define FUNC_CFG_REQ_ENABLES2_QUIC_RX_KEY_CTXS         0x8UL
+	#define FUNC_CFG_REQ_ENABLES2_ROCE_MAX_AV_PER_VF       0x10UL
+	#define FUNC_CFG_REQ_ENABLES2_ROCE_MAX_CQ_PER_VF       0x20UL
+	#define FUNC_CFG_REQ_ENABLES2_ROCE_MAX_MRW_PER_VF      0x40UL
+	#define FUNC_CFG_REQ_ENABLES2_ROCE_MAX_QP_PER_VF       0x80UL
+	#define FUNC_CFG_REQ_ENABLES2_ROCE_MAX_SRQ_PER_VF      0x100UL
+	#define FUNC_CFG_REQ_ENABLES2_ROCE_MAX_GID_PER_VF      0x200UL
+	#define FUNC_CFG_REQ_ENABLES2_XID_PARTITION_CFG        0x400UL
+	#define FUNC_CFG_REQ_ENABLES2_PHYSICAL_SLOT_NUMBER     0x800UL
 	u8	port_kdnet_mode;
 	#define FUNC_CFG_REQ_PORT_KDNET_MODE_DISABLED 0x0UL
 	#define FUNC_CFG_REQ_PORT_KDNET_MODE_ENABLED  0x1UL
@@ -2281,7 +2327,7 @@ struct hwrm_func_cfg_input {
 	#define FUNC_CFG_REQ_DB_PAGE_SIZE_2MB   0x9UL
 	#define FUNC_CFG_REQ_DB_PAGE_SIZE_4MB   0xaUL
 	#define FUNC_CFG_REQ_DB_PAGE_SIZE_LAST FUNC_CFG_REQ_DB_PAGE_SIZE_4MB
-	u8	unused_1[2];
+	__le16	physical_slot_number;
 	__le32	num_ktls_tx_key_ctxs;
 	__le32	num_ktls_rx_key_ctxs;
 	__le32	num_quic_tx_key_ctxs;
@@ -3683,7 +3729,7 @@ struct hwrm_func_ptp_ext_qcfg_output {
 	u8	valid;
 };
 
-/* hwrm_func_backing_store_cfg_v2_input (size:448b/56B) */
+/* hwrm_func_backing_store_cfg_v2_input (size:512b/64B) */
 struct hwrm_func_backing_store_cfg_v2_input {
 	__le16	req_type;
 	__le16	cmpl_ring;
@@ -3721,6 +3767,7 @@ struct hwrm_func_backing_store_cfg_v2_input {
 	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_CA1_TRACE           0x27UL
 	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_CA2_TRACE           0x28UL
 	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_RIGP1_TRACE         0x29UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_AFM_KONG_HWRM_TRACE 0x2aUL
 	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_INVALID             0xffffUL
 	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_LAST               FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_INVALID
 	__le16	instance;
@@ -3752,6 +3799,9 @@ struct hwrm_func_backing_store_cfg_v2_input {
 	__le32	split_entry_1;
 	__le32	split_entry_2;
 	__le32	split_entry_3;
+	__le32	enables;
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_ENABLES_NEXT_BS_OFFSET     0x1UL
+	__le32	next_bs_offset;
 };
 
 /* hwrm_func_backing_store_cfg_v2_output (size:128b/16B) */
@@ -3802,6 +3852,7 @@ struct hwrm_func_backing_store_qcfg_v2_input {
 	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_CA1_TRACE           0x27UL
 	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_CA2_TRACE           0x28UL
 	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_RIGP1_TRACE         0x29UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_AFM_KONG_HWRM_TRACE 0x2aUL
 	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_INVALID             0xffffUL
 	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_LAST               FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_INVALID
 	__le16	instance;
@@ -3963,6 +4014,7 @@ struct hwrm_func_backing_store_qcaps_v2_input {
 	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_CA1_TRACE           0x27UL
 	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_CA2_TRACE           0x28UL
 	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_RIGP1_TRACE         0x29UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_AFM_KONG_HWRM_TRACE 0x2aUL
 	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_INVALID             0xffffUL
 	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_LAST               FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_INVALID
 	u8	rsvd[6];
@@ -4005,6 +4057,7 @@ struct hwrm_func_backing_store_qcaps_v2_output {
 	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_CA1_TRACE           0x27UL
 	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_CA2_TRACE           0x28UL
 	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_RIGP1_TRACE         0x29UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_AFM_KONG_HWRM_TRACE 0x2aUL
 	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_INVALID             0xffffUL
 	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_LAST               FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_INVALID
 	__le16	entry_size;
@@ -4014,6 +4067,8 @@ struct hwrm_func_backing_store_qcaps_v2_output {
 	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_FLAGS_DRIVER_MANAGED_MEMORY           0x4UL
 	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_FLAGS_ROCE_QP_PSEUDO_STATIC_ALLOC     0x8UL
 	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_FLAGS_FW_DBG_TRACE                    0x10UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_FLAGS_FW_BIN_DBG_TRACE                0x20UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_FLAGS_NEXT_BS_OFFSET                  0x40UL
 	__le32	instance_bit_map;
 	u8	ctx_init_value;
 	u8	ctx_init_offset;
@@ -4034,7 +4089,8 @@ struct hwrm_func_backing_store_qcaps_v2_output {
 	__le32	split_entry_1;
 	__le32	split_entry_2;
 	__le32	split_entry_3;
-	u8	rsvd3[3];
+	__le16	max_instance_count;
+	u8	rsvd3;
 	u8	valid;
 };
 
@@ -4535,11 +4591,12 @@ struct hwrm_port_phy_qcfg_output {
 	#define PORT_PHY_QCFG_RESP_PHY_TYPE_800G_BASEDR8     0x3dUL
 	#define PORT_PHY_QCFG_RESP_PHY_TYPE_LAST            PORT_PHY_QCFG_RESP_PHY_TYPE_800G_BASEDR8
 	u8	media_type;
-	#define PORT_PHY_QCFG_RESP_MEDIA_TYPE_UNKNOWN 0x0UL
-	#define PORT_PHY_QCFG_RESP_MEDIA_TYPE_TP      0x1UL
-	#define PORT_PHY_QCFG_RESP_MEDIA_TYPE_DAC     0x2UL
-	#define PORT_PHY_QCFG_RESP_MEDIA_TYPE_FIBRE   0x3UL
-	#define PORT_PHY_QCFG_RESP_MEDIA_TYPE_LAST   PORT_PHY_QCFG_RESP_MEDIA_TYPE_FIBRE
+	#define PORT_PHY_QCFG_RESP_MEDIA_TYPE_UNKNOWN   0x0UL
+	#define PORT_PHY_QCFG_RESP_MEDIA_TYPE_TP        0x1UL
+	#define PORT_PHY_QCFG_RESP_MEDIA_TYPE_DAC       0x2UL
+	#define PORT_PHY_QCFG_RESP_MEDIA_TYPE_FIBRE     0x3UL
+	#define PORT_PHY_QCFG_RESP_MEDIA_TYPE_BACKPLANE 0x4UL
+	#define PORT_PHY_QCFG_RESP_MEDIA_TYPE_LAST     PORT_PHY_QCFG_RESP_MEDIA_TYPE_BACKPLANE
 	u8	xcvr_pkg_type;
 	#define PORT_PHY_QCFG_RESP_XCVR_PKG_TYPE_XCVR_INTERNAL 0x1UL
 	#define PORT_PHY_QCFG_RESP_XCVR_PKG_TYPE_XCVR_EXTERNAL 0x2UL
@@ -4654,7 +4711,8 @@ struct hwrm_port_phy_qcfg_output {
 	#define PORT_PHY_QCFG_RESP_LINK_PARTNER_PAM4_ADV_SPEEDS_100GB     0x2UL
 	#define PORT_PHY_QCFG_RESP_LINK_PARTNER_PAM4_ADV_SPEEDS_200GB     0x4UL
 	u8	link_down_reason;
-	#define PORT_PHY_QCFG_RESP_LINK_DOWN_REASON_RF     0x1UL
+	#define PORT_PHY_QCFG_RESP_LINK_DOWN_REASON_RF                      0x1UL
+	#define PORT_PHY_QCFG_RESP_LINK_DOWN_REASON_OTP_SPEED_VIOLATION     0x2UL
 	__le16	support_speeds2;
 	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_1GB                0x1UL
 	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_10GB               0x2UL
@@ -9241,20 +9299,22 @@ struct hwrm_fw_set_time_output {
 /* hwrm_struct_hdr (size:128b/16B) */
 struct hwrm_struct_hdr {
 	__le16	struct_id;
-	#define STRUCT_HDR_STRUCT_ID_LLDP_CFG           0x41bUL
-	#define STRUCT_HDR_STRUCT_ID_DCBX_ETS           0x41dUL
-	#define STRUCT_HDR_STRUCT_ID_DCBX_PFC           0x41fUL
-	#define STRUCT_HDR_STRUCT_ID_DCBX_APP           0x421UL
-	#define STRUCT_HDR_STRUCT_ID_DCBX_FEATURE_STATE 0x422UL
-	#define STRUCT_HDR_STRUCT_ID_LLDP_GENERIC       0x424UL
-	#define STRUCT_HDR_STRUCT_ID_LLDP_DEVICE        0x426UL
-	#define STRUCT_HDR_STRUCT_ID_POWER_BKUP         0x427UL
-	#define STRUCT_HDR_STRUCT_ID_PEER_MMAP          0x429UL
-	#define STRUCT_HDR_STRUCT_ID_AFM_OPAQUE         0x1UL
-	#define STRUCT_HDR_STRUCT_ID_PORT_DESCRIPTION   0xaUL
-	#define STRUCT_HDR_STRUCT_ID_RSS_V2             0x64UL
-	#define STRUCT_HDR_STRUCT_ID_MSIX_PER_VF        0xc8UL
-	#define STRUCT_HDR_STRUCT_ID_LAST              STRUCT_HDR_STRUCT_ID_MSIX_PER_VF
+	#define STRUCT_HDR_STRUCT_ID_LLDP_CFG              0x41bUL
+	#define STRUCT_HDR_STRUCT_ID_DCBX_ETS              0x41dUL
+	#define STRUCT_HDR_STRUCT_ID_DCBX_PFC              0x41fUL
+	#define STRUCT_HDR_STRUCT_ID_DCBX_APP              0x421UL
+	#define STRUCT_HDR_STRUCT_ID_DCBX_FEATURE_STATE    0x422UL
+	#define STRUCT_HDR_STRUCT_ID_LLDP_GENERIC          0x424UL
+	#define STRUCT_HDR_STRUCT_ID_LLDP_DEVICE           0x426UL
+	#define STRUCT_HDR_STRUCT_ID_POWER_BKUP            0x427UL
+	#define STRUCT_HDR_STRUCT_ID_PEER_MMAP             0x429UL
+	#define STRUCT_HDR_STRUCT_ID_AFM_OPAQUE            0x1UL
+	#define STRUCT_HDR_STRUCT_ID_PORT_DESCRIPTION      0xaUL
+	#define STRUCT_HDR_STRUCT_ID_RSS_V2                0x64UL
+	#define STRUCT_HDR_STRUCT_ID_MSIX_PER_VF           0xc8UL
+	#define STRUCT_HDR_STRUCT_ID_UDCC_RTT_BUCKET_COUNT 0x12cUL
+	#define STRUCT_HDR_STRUCT_ID_UDCC_RTT_BUCKET_BOUND 0x12dUL
+	#define STRUCT_HDR_STRUCT_ID_LAST                 STRUCT_HDR_STRUCT_ID_UDCC_RTT_BUCKET_BOUND
 	__le16	len;
 	u8	version;
 	u8	count;
@@ -9756,6 +9816,7 @@ struct hwrm_dbg_qcaps_output {
 	#define DBG_QCAPS_RESP_FLAGS_COREDUMP_HOST_DDR         0x10UL
 	#define DBG_QCAPS_RESP_FLAGS_COREDUMP_HOST_CAPTURE     0x20UL
 	#define DBG_QCAPS_RESP_FLAGS_PTRACE                    0x40UL
+	#define DBG_QCAPS_RESP_FLAGS_REG_ACCESS_RESTRICTED     0x80UL
 	u8	unused_1[3];
 	u8	valid;
 };
@@ -9996,6 +10057,43 @@ struct hwrm_dbg_ring_info_get_output {
 	u8	valid;
 };
 
+/* hwrm_dbg_log_buffer_flush_input (size:192b/24B) */
+struct hwrm_dbg_log_buffer_flush_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	type;
+	#define DBG_LOG_BUFFER_FLUSH_REQ_TYPE_SRT_TRACE           0x0UL
+	#define DBG_LOG_BUFFER_FLUSH_REQ_TYPE_SRT2_TRACE          0x1UL
+	#define DBG_LOG_BUFFER_FLUSH_REQ_TYPE_CRT_TRACE           0x2UL
+	#define DBG_LOG_BUFFER_FLUSH_REQ_TYPE_CRT2_TRACE          0x3UL
+	#define DBG_LOG_BUFFER_FLUSH_REQ_TYPE_RIGP0_TRACE         0x4UL
+	#define DBG_LOG_BUFFER_FLUSH_REQ_TYPE_L2_HWRM_TRACE       0x5UL
+	#define DBG_LOG_BUFFER_FLUSH_REQ_TYPE_ROCE_HWRM_TRACE     0x6UL
+	#define DBG_LOG_BUFFER_FLUSH_REQ_TYPE_CA0_TRACE           0x7UL
+	#define DBG_LOG_BUFFER_FLUSH_REQ_TYPE_CA1_TRACE           0x8UL
+	#define DBG_LOG_BUFFER_FLUSH_REQ_TYPE_CA2_TRACE           0x9UL
+	#define DBG_LOG_BUFFER_FLUSH_REQ_TYPE_RIGP1_TRACE         0xaUL
+	#define DBG_LOG_BUFFER_FLUSH_REQ_TYPE_AFM_KONG_HWRM_TRACE 0xbUL
+	#define DBG_LOG_BUFFER_FLUSH_REQ_TYPE_LAST               DBG_LOG_BUFFER_FLUSH_REQ_TYPE_AFM_KONG_HWRM_TRACE
+	u8	unused_1[2];
+	__le32	flags;
+	#define DBG_LOG_BUFFER_FLUSH_REQ_FLAGS_FLUSH_ALL_BUFFERS     0x1UL
+};
+
+/* hwrm_dbg_log_buffer_flush_output (size:128b/16B) */
+struct hwrm_dbg_log_buffer_flush_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le32	current_buffer_offset;
+	u8	unused_1[3];
+	u8	valid;
+};
+
 /* hwrm_nvm_read_input (size:320b/40B) */
 struct hwrm_nvm_read_input {
 	__le16	req_type;
@@ -10080,6 +10178,7 @@ struct hwrm_nvm_write_input {
 	#define NVM_WRITE_REQ_FLAGS_KEEP_ORIG_ACTIVE_IMG     0x1UL
 	#define NVM_WRITE_REQ_FLAGS_BATCH_MODE               0x2UL
 	#define NVM_WRITE_REQ_FLAGS_BATCH_LAST               0x4UL
+	#define NVM_WRITE_REQ_FLAGS_SKIP_CRID_CHECK          0x8UL
 	__le32	dir_item_length;
 	__le32	offset;
 	__le32	len;
-- 
2.30.1


