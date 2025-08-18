Return-Path: <netdev+bounces-214427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D268B295EC
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 02:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 129131962C18
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 00:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703DB1F9F47;
	Mon, 18 Aug 2025 00:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eJOdMnvD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76321E00B4
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755478237; cv=none; b=Mj7tqw8NCWvUNQKwNKpAk3KKJXSZh+iFcb4uIbETw+XcFhjdzGeZnJolng/nSDPgrA4giWE4kyrjZusNtv2+l/aOEpEg9wr4yCpwOEzeXb5csT54KjK5pnhtsUmrknUmQNOeWl50VKaXYoNYKjW30VoLaCq+AkFDN63/lV+iZiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755478237; c=relaxed/simple;
	bh=Iz0WTgXkDfo2CI0/0+LowGupJ/J7YJ/8koPqC52YHvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DkgAbNZ0HM7Zu414BqsXiAeR2TP75Vcj0W+QKbV5Gn1LD9bK5HrEF7+9+9kTU61/z298gmSRzsfZlUlmxeALmlmvMs1dsah50hlXsPJ6Ljxyj265UE6E8AJNe4UIBN1ZeLG86lQOMC+05Ke0y6IfI4DIqQypHtBrUtuPvmJlo2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eJOdMnvD; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-70a928ad710so30364016d6.2
        for <netdev@vger.kernel.org>; Sun, 17 Aug 2025 17:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755478234; x=1756083034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEfOiL2S9Wxci+bbsK9MKskuFAmTocio+jDk9x7R/PE=;
        b=eJOdMnvD7/hfcMQyP9eUZK8s7RMhZRKYtBsX4FbAMmhB+ntcVCmb/zabVBQEf+EFkf
         kfGbrZStmvKhpyP1xwYtBJXdQ+PawEyM6RVqbjLzzoSM/BDZqyKnW1CdPqKx7raqnjX9
         Vpu2rRV5E8HYxJ3sivQHf80zsmEmgzGsV8ffU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755478234; x=1756083034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EEfOiL2S9Wxci+bbsK9MKskuFAmTocio+jDk9x7R/PE=;
        b=caKSYv4Rxgeu8++dORu1jNr63MN1FLPvx0dYYWpMWV9LWtk44kR+Wzltv2CPCpLMEg
         9hxfr3wZQY3wAJGijIVxFJtRUejfkudaoS/s/FjDagag8VKn8uRhr5PCAysuFlgjhArN
         VDuHz0OFdcvD7Y/WIgVSU0vEuwhRlvw9iB8CrglD4G333g22jsW+NxqPDqoC5OjPyjQu
         71+/ZtcWt4c2mtuo2yT2njuZKwyiRtmpV/oVnCS7F8nRdxiD/BUCPi+Z1ngYXGPTEkD2
         Ja3gv7Gwo6IclWCADPvVV5Je1YJdyxNUQA5ASmOfRGUNm3f81+uITtp9XX9F2yqxukE1
         bSKw==
X-Gm-Message-State: AOJu0YyOHn334LI32sVqHUmY574stEYv4j07b6FYE3tbwAwpgB8s8xor
	I1fB/20f05sX4onYbP3Q0OpdDEQFwvZ6JjEA48Y7k/3mT/63oCtbpSTimzP0L42Mow==
X-Gm-Gg: ASbGncu58Cosr88hE1PUAEJoo+goqgVEiZXZodyk4VMga4qL41RLFg4ogfYGkxd1+G3
	XPabDnl1FMmT3wUZG1ixPeW8MYPuNHVLym3op5JVuWWMU73Tb3stE85p9ffAD0KwRPfbgwGTGlK
	qfLdgSzoPgafAMbF7TzCPlbbThSwxq3PydiVVdp28qrUX71Lvzps1L1KgW5sCMohq9zKoc9izbE
	PRX0VTL1F3OBkBkQU+vmkY5QbcypXdeDFyVJElfoO/eCtNevSQGFLVtxdfrJ1zjw8fDOpOQKugM
	RUcgo3M43oRsglhkO498zPRbBfp6h6JFurTSgLRPTyUJjhWxb4lFQv+UPACbQEnqkskTpXGh3da
	Ovwrt5MMkZqxT8Xjlpyz5sGQS3bfEYb42rKgxKhENEbGUIylwYh+qqO8k2heYM1GofIJYWNiVTQ
	==
X-Google-Smtp-Source: AGHT+IFfr3bLnPuCbgcISn+0TZGBrdqYLFbTATpVcIL7VHGLCSuGwTirifsf3zygepqvv/sDyI40Vw==
X-Received: by 2002:a05:6214:19e9:b0:709:f5a9:d053 with SMTP id 6a1803df08f44-70ba7b2c80cmr150426586d6.18.1755478233495;
        Sun, 17 Aug 2025 17:50:33 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba9301703sm44987526d6.49.2025.08.17.17.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 17:50:32 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next 1/5] bnxt_en: hsi: Update FW interface to 1.10.3.133
Date: Sun, 17 Aug 2025 17:49:36 -0700
Message-ID: <20250818004940.5663-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250818004940.5663-1-michael.chan@broadcom.com>
References: <20250818004940.5663-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The major change is struct pcie_ctx_hw_stats_v2 which has new latency
histograms added.

Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 include/linux/bnxt/hsi.h | 315 +++++++++++++++++++++++++++++++--------
 1 file changed, 253 insertions(+), 62 deletions(-)

diff --git a/include/linux/bnxt/hsi.h b/include/linux/bnxt/hsi.h
index 549231703bce..8c5dac3b3ef3 100644
--- a/include/linux/bnxt/hsi.h
+++ b/include/linux/bnxt/hsi.h
@@ -276,6 +276,10 @@ struct cmd_nums {
 	#define HWRM_REG_POWER_QUERY                      0xe1UL
 	#define HWRM_CORE_FREQUENCY_QUERY                 0xe2UL
 	#define HWRM_REG_POWER_HISTOGRAM                  0xe3UL
+	#define HWRM_MONITOR_PAX_HISTOGRAM_START          0xe4UL
+	#define HWRM_MONITOR_PAX_HISTOGRAM_COLLECT        0xe5UL
+	#define HWRM_STAT_QUERY_ROCE_STATS                0xe6UL
+	#define HWRM_STAT_QUERY_ROCE_STATS_EXT            0xe7UL
 	#define HWRM_WOL_FILTER_ALLOC                     0xf0UL
 	#define HWRM_WOL_FILTER_FREE                      0xf1UL
 	#define HWRM_WOL_FILTER_QCFG                      0xf2UL
@@ -407,9 +411,8 @@ struct cmd_nums {
 	#define HWRM_FUNC_LAG_UPDATE                      0x1b1UL
 	#define HWRM_FUNC_LAG_FREE                        0x1b2UL
 	#define HWRM_FUNC_LAG_QCFG                        0x1b3UL
-	#define HWRM_FUNC_TIMEDTX_PACING_RATE_ADD         0x1c2UL
-	#define HWRM_FUNC_TIMEDTX_PACING_RATE_DELETE      0x1c3UL
-	#define HWRM_FUNC_TIMEDTX_PACING_RATE_QUERY       0x1c4UL
+	#define HWRM_FUNC_TTX_PACING_RATE_PROF_QUERY      0x1c3UL
+	#define HWRM_FUNC_TTX_PACING_RATE_QUERY           0x1c4UL
 	#define HWRM_SELFTEST_QLIST                       0x200UL
 	#define HWRM_SELFTEST_EXEC                        0x201UL
 	#define HWRM_SELFTEST_IRQ                         0x202UL
@@ -441,6 +444,7 @@ struct cmd_nums {
 	#define HWRM_MFG_WRITE_CERT_NVM                   0x21cUL
 	#define HWRM_PORT_POE_CFG                         0x230UL
 	#define HWRM_PORT_POE_QCFG                        0x231UL
+	#define HWRM_PORT_PHY_FDRSTAT                     0x232UL
 	#define HWRM_UDCC_QCAPS                           0x258UL
 	#define HWRM_UDCC_CFG                             0x259UL
 	#define HWRM_UDCC_QCFG                            0x25aUL
@@ -453,6 +457,8 @@ struct cmd_nums {
 	#define HWRM_QUEUE_PFCWD_TIMEOUT_QCAPS            0x261UL
 	#define HWRM_QUEUE_PFCWD_TIMEOUT_CFG              0x262UL
 	#define HWRM_QUEUE_PFCWD_TIMEOUT_QCFG             0x263UL
+	#define HWRM_QUEUE_ADPTV_QOS_RX_QCFG              0x264UL
+	#define HWRM_QUEUE_ADPTV_QOS_TX_QCFG              0x265UL
 	#define HWRM_TF                                   0x2bcUL
 	#define HWRM_TF_VERSION_GET                       0x2bdUL
 	#define HWRM_TF_SESSION_OPEN                      0x2c6UL
@@ -551,6 +557,8 @@ struct cmd_nums {
 	#define HWRM_DBG_COREDUMP_CAPTURE                 0xff2cUL
 	#define HWRM_DBG_PTRACE                           0xff2dUL
 	#define HWRM_DBG_SIM_CABLE_STATE                  0xff2eUL
+	#define HWRM_DBG_TOKEN_QUERY_AUTH_IDS             0xff2fUL
+	#define HWRM_DBG_TOKEN_CFG                        0xff30UL
 	#define HWRM_NVM_GET_VPD_FIELD_INFO               0xffeaUL
 	#define HWRM_NVM_SET_VPD_FIELD_INFO               0xffebUL
 	#define HWRM_NVM_DEFRAG                           0xffecUL
@@ -632,8 +640,8 @@ struct hwrm_err_output {
 #define HWRM_VERSION_MAJOR 1
 #define HWRM_VERSION_MINOR 10
 #define HWRM_VERSION_UPDATE 3
-#define HWRM_VERSION_RSVD 97
-#define HWRM_VERSION_STR "1.10.3.97"
+#define HWRM_VERSION_RSVD 133
+#define HWRM_VERSION_STR "1.10.3.133"
 
 /* hwrm_ver_get_input (size:192b/24B) */
 struct hwrm_ver_get_input {
@@ -688,6 +696,7 @@ struct hwrm_ver_get_output {
 	#define VER_GET_RESP_DEV_CAPS_CFG_CFA_TRUFLOW_SUPPORTED                    0x4000UL
 	#define VER_GET_RESP_DEV_CAPS_CFG_SECURE_BOOT_CAPABLE                      0x8000UL
 	#define VER_GET_RESP_DEV_CAPS_CFG_SECURE_SOC_CAPABLE                       0x10000UL
+	#define VER_GET_RESP_DEV_CAPS_CFG_DEBUG_TOKEN_SUPPORTED                    0x20000UL
 	u8	roce_fw_maj_8b;
 	u8	roce_fw_min_8b;
 	u8	roce_fw_bld_8b;
@@ -872,7 +881,8 @@ struct hwrm_async_event_cmpl {
 	#define ASYNC_EVENT_CMPL_EVENT_ID_REPRESENTOR_PAIR_CHANGE         0x4eUL
 	#define ASYNC_EVENT_CMPL_EVENT_ID_VF_STAT_CHANGE                  0x4fUL
 	#define ASYNC_EVENT_CMPL_EVENT_ID_HOST_COREDUMP                   0x50UL
-	#define ASYNC_EVENT_CMPL_EVENT_ID_MAX_RGTR_EVENT_ID               0x51UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_ADPTV_QOS                       0x51UL
+	#define ASYNC_EVENT_CMPL_EVENT_ID_MAX_RGTR_EVENT_ID               0x52UL
 	#define ASYNC_EVENT_CMPL_EVENT_ID_FW_TRACE_MSG                    0xfeUL
 	#define ASYNC_EVENT_CMPL_EVENT_ID_HWRM_ERROR                      0xffUL
 	#define ASYNC_EVENT_CMPL_EVENT_ID_LAST                           ASYNC_EVENT_CMPL_EVENT_ID_HWRM_ERROR
@@ -1344,7 +1354,8 @@ struct hwrm_async_event_cmpl_dbg_buf_producer {
 	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_CA2_TRACE            0x9UL
 	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_RIGP1_TRACE          0xaUL
 	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_AFM_KONG_HWRM_TRACE  0xbUL
-	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_LAST                ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_AFM_KONG_HWRM_TRACE
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_ERR_QPC_TRACE        0xcUL
+	#define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_LAST                ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_ERR_QPC_TRACE
 };
 
 /* hwrm_async_event_cmpl_hwrm_error (size:128b/16B) */
@@ -1401,7 +1412,11 @@ struct hwrm_async_event_cmpl_error_report_base {
 	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_DOORBELL_DROP_THRESHOLD       0x4UL
 	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_THERMAL_THRESHOLD             0x5UL
 	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_DUAL_DATA_RATE_NOT_SUPPORTED  0x6UL
-	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_LAST                         ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_DUAL_DATA_RATE_NOT_SUPPORTED
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_DUP_UDCC_SES                  0x7UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_DB_DROP                       0x8UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_MD_TEMP                       0x9UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_VNIC_ERR                      0xaUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_LAST                         ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_VNIC_ERR
 };
 
 /* hwrm_async_event_cmpl_error_report_pause_storm (size:128b/16B) */
@@ -1914,6 +1929,12 @@ struct hwrm_func_qcaps_output {
 	#define FUNC_QCAPS_RESP_FLAGS_EXT3_RX_RATE_PROFILE_SEL_SUPPORTED     0x8UL
 	#define FUNC_QCAPS_RESP_FLAGS_EXT3_BIDI_OPT_SUPPORTED                0x10UL
 	#define FUNC_QCAPS_RESP_FLAGS_EXT3_MIRROR_ON_ROCE_SUPPORTED          0x20UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT3_ROCE_VF_DYN_ALLOC_SUPPORT         0x40UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT3_CHANGE_UDP_SRCPORT_SUPPORT        0x80UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT3_PCIE_COMPLIANCE_SUPPORTED         0x100UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT3_MULTI_L2_DB_SUPPORTED             0x200UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT3_PCIE_SECURE_ATS_SUPPORTED         0x400UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT3_MBUF_STATS_SUPPORTED              0x800UL
 	__le16	max_roce_vfs;
 	__le16	max_crypto_rx_flow_filters;
 	u8	unused_3[3];
@@ -1931,7 +1952,7 @@ struct hwrm_func_qcfg_input {
 	u8	unused_0[6];
 };
 
-/* hwrm_func_qcfg_output (size:1344b/168B) */
+/* hwrm_func_qcfg_output (size:1408b/176B) */
 struct hwrm_func_qcfg_output {
 	__le16	error_code;
 	__le16	req_type;
@@ -2124,7 +2145,43 @@ struct hwrm_func_qcfg_output {
 	#define FUNC_QCFG_RESP_XID_PARTITION_CFG_TX_CK     0x1UL
 	#define FUNC_QCFG_RESP_XID_PARTITION_CFG_RX_CK     0x2UL
 	__le16	mirror_vnic_id;
-	u8	unused_7[7];
+	u8	max_link_width;
+	#define FUNC_QCFG_RESP_MAX_LINK_WIDTH_UNKNOWN 0x0UL
+	#define FUNC_QCFG_RESP_MAX_LINK_WIDTH_X1      0x1UL
+	#define FUNC_QCFG_RESP_MAX_LINK_WIDTH_X2      0x2UL
+	#define FUNC_QCFG_RESP_MAX_LINK_WIDTH_X4      0x4UL
+	#define FUNC_QCFG_RESP_MAX_LINK_WIDTH_X8      0x8UL
+	#define FUNC_QCFG_RESP_MAX_LINK_WIDTH_X16     0x10UL
+	#define FUNC_QCFG_RESP_MAX_LINK_WIDTH_LAST   FUNC_QCFG_RESP_MAX_LINK_WIDTH_X16
+	u8	max_link_speed;
+	#define FUNC_QCFG_RESP_MAX_LINK_SPEED_UNKNOWN 0x0UL
+	#define FUNC_QCFG_RESP_MAX_LINK_SPEED_G1      0x1UL
+	#define FUNC_QCFG_RESP_MAX_LINK_SPEED_G2      0x2UL
+	#define FUNC_QCFG_RESP_MAX_LINK_SPEED_G3      0x3UL
+	#define FUNC_QCFG_RESP_MAX_LINK_SPEED_G4      0x4UL
+	#define FUNC_QCFG_RESP_MAX_LINK_SPEED_G5      0x5UL
+	#define FUNC_QCFG_RESP_MAX_LINK_SPEED_LAST   FUNC_QCFG_RESP_MAX_LINK_SPEED_G5
+	u8	negotiated_link_width;
+	#define FUNC_QCFG_RESP_NEGOTIATED_LINK_WIDTH_UNKNOWN 0x0UL
+	#define FUNC_QCFG_RESP_NEGOTIATED_LINK_WIDTH_X1      0x1UL
+	#define FUNC_QCFG_RESP_NEGOTIATED_LINK_WIDTH_X2      0x2UL
+	#define FUNC_QCFG_RESP_NEGOTIATED_LINK_WIDTH_X4      0x4UL
+	#define FUNC_QCFG_RESP_NEGOTIATED_LINK_WIDTH_X8      0x8UL
+	#define FUNC_QCFG_RESP_NEGOTIATED_LINK_WIDTH_X16     0x10UL
+	#define FUNC_QCFG_RESP_NEGOTIATED_LINK_WIDTH_LAST   FUNC_QCFG_RESP_NEGOTIATED_LINK_WIDTH_X16
+	u8	negotiated_link_speed;
+	#define FUNC_QCFG_RESP_NEGOTIATED_LINK_SPEED_UNKNOWN 0x0UL
+	#define FUNC_QCFG_RESP_NEGOTIATED_LINK_SPEED_G1      0x1UL
+	#define FUNC_QCFG_RESP_NEGOTIATED_LINK_SPEED_G2      0x2UL
+	#define FUNC_QCFG_RESP_NEGOTIATED_LINK_SPEED_G3      0x3UL
+	#define FUNC_QCFG_RESP_NEGOTIATED_LINK_SPEED_G4      0x4UL
+	#define FUNC_QCFG_RESP_NEGOTIATED_LINK_SPEED_G5      0x5UL
+	#define FUNC_QCFG_RESP_NEGOTIATED_LINK_SPEED_LAST   FUNC_QCFG_RESP_NEGOTIATED_LINK_SPEED_G5
+	u8	unused_7[2];
+	u8	pcie_compliance;
+	u8	unused_8;
+	__le16	l2_db_multi_page_size_kb;
+	u8	unused_9[5];
 	u8	valid;
 };
 
@@ -2322,6 +2379,7 @@ struct hwrm_func_cfg_input {
 	#define FUNC_CFG_REQ_ENABLES2_ROCE_MAX_GID_PER_VF      0x200UL
 	#define FUNC_CFG_REQ_ENABLES2_XID_PARTITION_CFG        0x400UL
 	#define FUNC_CFG_REQ_ENABLES2_PHYSICAL_SLOT_NUMBER     0x800UL
+	#define FUNC_CFG_REQ_ENABLES2_PCIE_COMPLIANCE          0x1000UL
 	u8	port_kdnet_mode;
 	#define FUNC_CFG_REQ_PORT_KDNET_MODE_DISABLED 0x0UL
 	#define FUNC_CFG_REQ_PORT_KDNET_MODE_ENABLED  0x1UL
@@ -2353,7 +2411,8 @@ struct hwrm_func_cfg_input {
 	__le16	xid_partition_cfg;
 	#define FUNC_CFG_REQ_XID_PARTITION_CFG_TX_CK     0x1UL
 	#define FUNC_CFG_REQ_XID_PARTITION_CFG_RX_CK     0x2UL
-	__le16	unused_2;
+	u8	pcie_compliance;
+	u8	unused_2;
 };
 
 /* hwrm_func_cfg_output (size:128b/16B) */
@@ -2370,11 +2429,41 @@ struct hwrm_func_cfg_output {
 struct hwrm_func_cfg_cmd_err {
 	u8	code;
 	#define FUNC_CFG_CMD_ERR_CODE_UNKNOWN                      0x0UL
-	#define FUNC_CFG_CMD_ERR_CODE_PARTITION_MIN_BW_RANGE       0x1UL
-	#define FUNC_CFG_CMD_ERR_CODE_PARTITION_MIN_MORE_THAN_MAX  0x2UL
-	#define FUNC_CFG_CMD_ERR_CODE_PARTITION_MIN_BW_UNSUPPORTED 0x3UL
-	#define FUNC_CFG_CMD_ERR_CODE_PARTITION_BW_PERCENT         0x4UL
-	#define FUNC_CFG_CMD_ERR_CODE_LAST                        FUNC_CFG_CMD_ERR_CODE_PARTITION_BW_PERCENT
+	#define FUNC_CFG_CMD_ERR_CODE_PARTITION_BW_OUT_OF_RANGE    0x1UL
+	#define FUNC_CFG_CMD_ERR_CODE_NPAR_PARTITION_DOWN_FAILED   0x2UL
+	#define FUNC_CFG_CMD_ERR_CODE_TPID_SET_DFLT_VLAN_NOT_SET   0x3UL
+	#define FUNC_CFG_CMD_ERR_CODE_RES_ARRAY_ALLOC_FAILED       0x4UL
+	#define FUNC_CFG_CMD_ERR_CODE_TX_RING_ASSET_TEST_FAILED    0x5UL
+	#define FUNC_CFG_CMD_ERR_CODE_TX_RING_RES_UPDATE_FAILED    0x6UL
+	#define FUNC_CFG_CMD_ERR_CODE_APPLY_MAX_BW_FAILED          0x7UL
+	#define FUNC_CFG_CMD_ERR_CODE_ENABLE_EVB_FAILED            0x8UL
+	#define FUNC_CFG_CMD_ERR_CODE_RSS_CTXT_ASSET_TEST_FAILED   0x9UL
+	#define FUNC_CFG_CMD_ERR_CODE_RSS_CTXT_RES_UPDATE_FAILED   0xaUL
+	#define FUNC_CFG_CMD_ERR_CODE_CMPL_RING_ASSET_TEST_FAILED  0xbUL
+	#define FUNC_CFG_CMD_ERR_CODE_CMPL_RING_RES_UPDATE_FAILED  0xcUL
+	#define FUNC_CFG_CMD_ERR_CODE_NQ_ASSET_TEST_FAILED         0xdUL
+	#define FUNC_CFG_CMD_ERR_CODE_NQ_RES_UPDATE_FAILED         0xeUL
+	#define FUNC_CFG_CMD_ERR_CODE_RX_RING_ASSET_TEST_FAILED    0xfUL
+	#define FUNC_CFG_CMD_ERR_CODE_RX_RING_RES_UPDATE_FAILED    0x10UL
+	#define FUNC_CFG_CMD_ERR_CODE_VNIC_ASSET_TEST_FAILED       0x11UL
+	#define FUNC_CFG_CMD_ERR_CODE_VNIC_RES_UPDATE_FAILED       0x12UL
+	#define FUNC_CFG_CMD_ERR_CODE_FAILED_TO_START_STATS_THREAD 0x13UL
+	#define FUNC_CFG_CMD_ERR_CODE_RDMA_SRIOV_DISABLED          0x14UL
+	#define FUNC_CFG_CMD_ERR_CODE_TX_KTLS_DISABLED             0x15UL
+	#define FUNC_CFG_CMD_ERR_CODE_TX_KTLS_ASSET_TEST_FAILED    0x16UL
+	#define FUNC_CFG_CMD_ERR_CODE_TX_KTLS_RES_UPDATE_FAILED    0x17UL
+	#define FUNC_CFG_CMD_ERR_CODE_RX_KTLS_DISABLED             0x18UL
+	#define FUNC_CFG_CMD_ERR_CODE_RX_KTLS_ASSET_TEST_FAILED    0x19UL
+	#define FUNC_CFG_CMD_ERR_CODE_RX_KTLS_RES_UPDATE_FAILED    0x1aUL
+	#define FUNC_CFG_CMD_ERR_CODE_TX_QUIC_DISABLED             0x1bUL
+	#define FUNC_CFG_CMD_ERR_CODE_TX_QUIC_ASSET_TEST_FAILED    0x1cUL
+	#define FUNC_CFG_CMD_ERR_CODE_TX_QUIC_RES_UPDATE_FAILED    0x1dUL
+	#define FUNC_CFG_CMD_ERR_CODE_RX_QUIC_DISABLED             0x1eUL
+	#define FUNC_CFG_CMD_ERR_CODE_RX_QUIC_ASSET_TEST_FAILED    0x1fUL
+	#define FUNC_CFG_CMD_ERR_CODE_RX_QUIC_RES_UPDATE_FAILED    0x20UL
+	#define FUNC_CFG_CMD_ERR_CODE_INVALID_KDNET_MODE           0x21UL
+	#define FUNC_CFG_CMD_ERR_CODE_SCHQ_CFG_FAIL                0x22UL
+	#define FUNC_CFG_CMD_ERR_CODE_LAST                        FUNC_CFG_CMD_ERR_CODE_SCHQ_CFG_FAIL
 	u8	unused_0[7];
 };
 
@@ -3780,6 +3869,7 @@ struct hwrm_func_backing_store_cfg_v2_input {
 	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_CA2_TRACE           0x28UL
 	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_RIGP1_TRACE         0x29UL
 	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_AFM_KONG_HWRM_TRACE 0x2aUL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_ERR_QPC_TRACE       0x2bUL
 	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_INVALID             0xffffUL
 	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_LAST               FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_INVALID
 	__le16	instance;
@@ -3865,6 +3955,7 @@ struct hwrm_func_backing_store_qcfg_v2_input {
 	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_CA2_TRACE           0x28UL
 	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_RIGP1_TRACE         0x29UL
 	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_AFM_KONG_HWRM_TRACE 0x2aUL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_ERR_QPC_TRACE       0x2bUL
 	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_INVALID             0xffffUL
 	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_LAST               FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_INVALID
 	__le16	instance;
@@ -3904,6 +3995,7 @@ struct hwrm_func_backing_store_qcfg_v2_output {
 	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_CA1_TRACE           0x27UL
 	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_CA2_TRACE           0x28UL
 	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_RIGP1_TRACE         0x29UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_ERR_QPC_TRACE       0x2aUL
 	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_INVALID             0xffffUL
 	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_LAST               FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_INVALID
 	__le16	instance;
@@ -4027,6 +4119,7 @@ struct hwrm_func_backing_store_qcaps_v2_input {
 	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_CA2_TRACE           0x28UL
 	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_RIGP1_TRACE         0x29UL
 	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_AFM_KONG_HWRM_TRACE 0x2aUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_ERR_QPC_TRACE       0x2bUL
 	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_INVALID             0xffffUL
 	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_LAST               FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_INVALID
 	u8	rsvd[6];
@@ -4070,6 +4163,7 @@ struct hwrm_func_backing_store_qcaps_v2_output {
 	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_CA2_TRACE           0x28UL
 	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_RIGP1_TRACE         0x29UL
 	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_AFM_KONG_HWRM_TRACE 0x2aUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_ERR_QPC_TRACE       0x2bUL
 	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_INVALID             0xffffUL
 	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_LAST               FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_INVALID
 	__le16	entry_size;
@@ -4216,6 +4310,10 @@ struct hwrm_port_phy_cfg_input {
 	#define PORT_PHY_CFG_REQ_FLAGS_FEC_RS272_1XN_DISABLE      0x100000UL
 	#define PORT_PHY_CFG_REQ_FLAGS_FEC_RS272_IEEE_ENABLE      0x200000UL
 	#define PORT_PHY_CFG_REQ_FLAGS_FEC_RS272_IEEE_DISABLE     0x400000UL
+	#define PORT_PHY_CFG_REQ_FLAGS_LINK_TRAINING_ENABLE       0x800000UL
+	#define PORT_PHY_CFG_REQ_FLAGS_LINK_TRAINING_DISABLE      0x1000000UL
+	#define PORT_PHY_CFG_REQ_FLAGS_PRECODING_ENABLE           0x2000000UL
+	#define PORT_PHY_CFG_REQ_FLAGS_PRECODING_DISABLE          0x4000000UL
 	__le32	enables;
 	#define PORT_PHY_CFG_REQ_ENABLES_AUTO_MODE                     0x1UL
 	#define PORT_PHY_CFG_REQ_ENABLES_AUTO_DUPLEX                   0x2UL
@@ -4703,6 +4801,8 @@ struct hwrm_port_phy_qcfg_output {
 	#define PORT_PHY_QCFG_RESP_OPTION_FLAGS_MEDIA_AUTO_DETECT     0x1UL
 	#define PORT_PHY_QCFG_RESP_OPTION_FLAGS_SIGNAL_MODE_KNOWN     0x2UL
 	#define PORT_PHY_QCFG_RESP_OPTION_FLAGS_SPEEDS2_SUPPORTED     0x4UL
+	#define PORT_PHY_QCFG_RESP_OPTION_FLAGS_LINK_TRAINING         0x8UL
+	#define PORT_PHY_QCFG_RESP_OPTION_FLAGS_PRECODING             0x10UL
 	char	phy_vendor_name[16];
 	char	phy_vendor_partnumber[16];
 	__le16	support_pam4_speeds;
@@ -4725,6 +4825,10 @@ struct hwrm_port_phy_qcfg_output {
 	u8	link_down_reason;
 	#define PORT_PHY_QCFG_RESP_LINK_DOWN_REASON_RF                      0x1UL
 	#define PORT_PHY_QCFG_RESP_LINK_DOWN_REASON_OTP_SPEED_VIOLATION     0x2UL
+	#define PORT_PHY_QCFG_RESP_LINK_DOWN_REASON_CABLE_REMOVED           0x4UL
+	#define PORT_PHY_QCFG_RESP_LINK_DOWN_REASON_MODULE_FAULT            0x8UL
+	#define PORT_PHY_QCFG_RESP_LINK_DOWN_REASON_BMC_REQUEST             0x10UL
+	#define PORT_PHY_QCFG_RESP_LINK_DOWN_REASON_TX_LASER_DISABLED       0x20UL
 	__le16	support_speeds2;
 	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_1GB                0x1UL
 	#define PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_10GB               0x2UL
@@ -5882,9 +5986,10 @@ struct hwrm_port_led_qcaps_output {
 	#define PORT_LED_QCAPS_RESP_LED0_STATE_CAPS_BLINK_SUPPORTED         0x8UL
 	#define PORT_LED_QCAPS_RESP_LED0_STATE_CAPS_BLINK_ALT_SUPPORTED     0x10UL
 	__le16	led0_color_caps;
-	#define PORT_LED_QCAPS_RESP_LED0_COLOR_CAPS_RSVD                0x1UL
-	#define PORT_LED_QCAPS_RESP_LED0_COLOR_CAPS_AMBER_SUPPORTED     0x2UL
-	#define PORT_LED_QCAPS_RESP_LED0_COLOR_CAPS_GREEN_SUPPORTED     0x4UL
+	#define PORT_LED_QCAPS_RESP_LED0_COLOR_CAPS_RSVD                 0x1UL
+	#define PORT_LED_QCAPS_RESP_LED0_COLOR_CAPS_AMBER_SUPPORTED      0x2UL
+	#define PORT_LED_QCAPS_RESP_LED0_COLOR_CAPS_GREEN_SUPPORTED      0x4UL
+	#define PORT_LED_QCAPS_RESP_LED0_COLOR_CAPS_GRNAMB_SUPPORTED     0x8UL
 	u8	led1_id;
 	u8	led1_type;
 	#define PORT_LED_QCAPS_RESP_LED1_TYPE_SPEED    0x0UL
@@ -5900,9 +6005,10 @@ struct hwrm_port_led_qcaps_output {
 	#define PORT_LED_QCAPS_RESP_LED1_STATE_CAPS_BLINK_SUPPORTED         0x8UL
 	#define PORT_LED_QCAPS_RESP_LED1_STATE_CAPS_BLINK_ALT_SUPPORTED     0x10UL
 	__le16	led1_color_caps;
-	#define PORT_LED_QCAPS_RESP_LED1_COLOR_CAPS_RSVD                0x1UL
-	#define PORT_LED_QCAPS_RESP_LED1_COLOR_CAPS_AMBER_SUPPORTED     0x2UL
-	#define PORT_LED_QCAPS_RESP_LED1_COLOR_CAPS_GREEN_SUPPORTED     0x4UL
+	#define PORT_LED_QCAPS_RESP_LED1_COLOR_CAPS_RSVD                 0x1UL
+	#define PORT_LED_QCAPS_RESP_LED1_COLOR_CAPS_AMBER_SUPPORTED      0x2UL
+	#define PORT_LED_QCAPS_RESP_LED1_COLOR_CAPS_GREEN_SUPPORTED      0x4UL
+	#define PORT_LED_QCAPS_RESP_LED1_COLOR_CAPS_GRNAMB_SUPPORTED     0x8UL
 	u8	led2_id;
 	u8	led2_type;
 	#define PORT_LED_QCAPS_RESP_LED2_TYPE_SPEED    0x0UL
@@ -5918,9 +6024,10 @@ struct hwrm_port_led_qcaps_output {
 	#define PORT_LED_QCAPS_RESP_LED2_STATE_CAPS_BLINK_SUPPORTED         0x8UL
 	#define PORT_LED_QCAPS_RESP_LED2_STATE_CAPS_BLINK_ALT_SUPPORTED     0x10UL
 	__le16	led2_color_caps;
-	#define PORT_LED_QCAPS_RESP_LED2_COLOR_CAPS_RSVD                0x1UL
-	#define PORT_LED_QCAPS_RESP_LED2_COLOR_CAPS_AMBER_SUPPORTED     0x2UL
-	#define PORT_LED_QCAPS_RESP_LED2_COLOR_CAPS_GREEN_SUPPORTED     0x4UL
+	#define PORT_LED_QCAPS_RESP_LED2_COLOR_CAPS_RSVD                 0x1UL
+	#define PORT_LED_QCAPS_RESP_LED2_COLOR_CAPS_AMBER_SUPPORTED      0x2UL
+	#define PORT_LED_QCAPS_RESP_LED2_COLOR_CAPS_GREEN_SUPPORTED      0x4UL
+	#define PORT_LED_QCAPS_RESP_LED2_COLOR_CAPS_GRNAMB_SUPPORTED     0x8UL
 	u8	led3_id;
 	u8	led3_type;
 	#define PORT_LED_QCAPS_RESP_LED3_TYPE_SPEED    0x0UL
@@ -5936,9 +6043,10 @@ struct hwrm_port_led_qcaps_output {
 	#define PORT_LED_QCAPS_RESP_LED3_STATE_CAPS_BLINK_SUPPORTED         0x8UL
 	#define PORT_LED_QCAPS_RESP_LED3_STATE_CAPS_BLINK_ALT_SUPPORTED     0x10UL
 	__le16	led3_color_caps;
-	#define PORT_LED_QCAPS_RESP_LED3_COLOR_CAPS_RSVD                0x1UL
-	#define PORT_LED_QCAPS_RESP_LED3_COLOR_CAPS_AMBER_SUPPORTED     0x2UL
-	#define PORT_LED_QCAPS_RESP_LED3_COLOR_CAPS_GREEN_SUPPORTED     0x4UL
+	#define PORT_LED_QCAPS_RESP_LED3_COLOR_CAPS_RSVD                 0x1UL
+	#define PORT_LED_QCAPS_RESP_LED3_COLOR_CAPS_AMBER_SUPPORTED      0x2UL
+	#define PORT_LED_QCAPS_RESP_LED3_COLOR_CAPS_GREEN_SUPPORTED      0x4UL
+	#define PORT_LED_QCAPS_RESP_LED3_COLOR_CAPS_GRNAMB_SUPPORTED     0x8UL
 	u8	unused_4[3];
 	u8	valid;
 };
@@ -7036,9 +7144,22 @@ struct hwrm_vnic_rss_cfg_output {
 /* hwrm_vnic_rss_cfg_cmd_err (size:64b/8B) */
 struct hwrm_vnic_rss_cfg_cmd_err {
 	u8	code;
-	#define VNIC_RSS_CFG_CMD_ERR_CODE_UNKNOWN             0x0UL
-	#define VNIC_RSS_CFG_CMD_ERR_CODE_INTERFACE_NOT_READY 0x1UL
-	#define VNIC_RSS_CFG_CMD_ERR_CODE_LAST               VNIC_RSS_CFG_CMD_ERR_CODE_INTERFACE_NOT_READY
+	#define VNIC_RSS_CFG_CMD_ERR_CODE_UNKNOWN                      0x0UL
+	#define VNIC_RSS_CFG_CMD_ERR_CODE_INTERFACE_NOT_READY          0x1UL
+	#define VNIC_RSS_CFG_CMD_ERR_CODE_UNABLE_TO_GET_RSS_CFG        0x2UL
+	#define VNIC_RSS_CFG_CMD_ERR_CODE_HASH_TYPE_UNSUPPORTED        0x3UL
+	#define VNIC_RSS_CFG_CMD_ERR_CODE_HASH_TYPE_ERR                0x4UL
+	#define VNIC_RSS_CFG_CMD_ERR_CODE_HASH_MODE_FAIL               0x5UL
+	#define VNIC_RSS_CFG_CMD_ERR_CODE_RING_GRP_TABLE_ALLOC_ERR     0x6UL
+	#define VNIC_RSS_CFG_CMD_ERR_CODE_HASH_KEY_ALLOC_ERR           0x7UL
+	#define VNIC_RSS_CFG_CMD_ERR_CODE_DMA_FAILED                   0x8UL
+	#define VNIC_RSS_CFG_CMD_ERR_CODE_RX_RING_ALLOC_ERR            0x9UL
+	#define VNIC_RSS_CFG_CMD_ERR_CODE_CMPL_RING_ALLOC_ERR          0xaUL
+	#define VNIC_RSS_CFG_CMD_ERR_CODE_HW_SET_RSS_FAILED            0xbUL
+	#define VNIC_RSS_CFG_CMD_ERR_CODE_CTX_INVALID                  0xcUL
+	#define VNIC_RSS_CFG_CMD_ERR_CODE_VNIC_INVALID                 0xdUL
+	#define VNIC_RSS_CFG_CMD_ERR_CODE_VNIC_RING_TABLE_PAIR_INVALID 0xeUL
+	#define VNIC_RSS_CFG_CMD_ERR_CODE_LAST                        VNIC_RSS_CFG_CMD_ERR_CODE_VNIC_RING_TABLE_PAIR_INVALID
 	u8	unused_0[7];
 };
 
@@ -7177,7 +7298,7 @@ struct hwrm_vnic_rss_cos_lb_ctx_free_output {
 	u8	valid;
 };
 
-/* hwrm_ring_alloc_input (size:704b/88B) */
+/* hwrm_ring_alloc_input (size:768b/96B) */
 struct hwrm_ring_alloc_input {
 	__le16	req_type;
 	__le16	cmpl_ring;
@@ -7195,6 +7316,7 @@ struct hwrm_ring_alloc_input {
 	#define RING_ALLOC_REQ_ENABLES_MPC_CHNLS_TYPE            0x400UL
 	#define RING_ALLOC_REQ_ENABLES_STEERING_TAG_VALID        0x800UL
 	#define RING_ALLOC_REQ_ENABLES_RX_RATE_PROFILE_VALID     0x1000UL
+	#define RING_ALLOC_REQ_ENABLES_DPI_VALID                 0x2000UL
 	u8	ring_type;
 	#define RING_ALLOC_REQ_RING_TYPE_L2_CMPL   0x0UL
 	#define RING_ALLOC_REQ_RING_TYPE_TX        0x1UL
@@ -7287,6 +7409,8 @@ struct hwrm_ring_alloc_input {
 	#define RING_ALLOC_REQ_RX_RATE_PROFILE_SEL_LAST     RING_ALLOC_REQ_RX_RATE_PROFILE_SEL_POLL_MODE
 	u8	unused_4;
 	__le64	cq_handle;
+	__le16	dpi;
+	__le16	unused_5[3];
 };
 
 /* hwrm_ring_alloc_output (size:128b/16B) */
@@ -7776,7 +7900,10 @@ struct hwrm_cfa_l2_set_rx_mask_cmd_err {
 	u8	code;
 	#define CFA_L2_SET_RX_MASK_CMD_ERR_CODE_UNKNOWN                    0x0UL
 	#define CFA_L2_SET_RX_MASK_CMD_ERR_CODE_NTUPLE_FILTER_CONFLICT_ERR 0x1UL
-	#define CFA_L2_SET_RX_MASK_CMD_ERR_CODE_LAST                      CFA_L2_SET_RX_MASK_CMD_ERR_CODE_NTUPLE_FILTER_CONFLICT_ERR
+	#define CFA_L2_SET_RX_MASK_CMD_ERR_CODE_MAX_VLAN_TAGS              0x2UL
+	#define CFA_L2_SET_RX_MASK_CMD_ERR_CODE_INVALID_VNIC_ID            0x3UL
+	#define CFA_L2_SET_RX_MASK_CMD_ERR_CODE_INVALID_ACTION             0x4UL
+	#define CFA_L2_SET_RX_MASK_CMD_ERR_CODE_LAST                      CFA_L2_SET_RX_MASK_CMD_ERR_CODE_INVALID_ACTION
 	u8	unused_0[7];
 };
 
@@ -8109,9 +8236,38 @@ struct hwrm_cfa_ntuple_filter_alloc_output {
 /* hwrm_cfa_ntuple_filter_alloc_cmd_err (size:64b/8B) */
 struct hwrm_cfa_ntuple_filter_alloc_cmd_err {
 	u8	code;
-	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_UNKNOWN                   0x0UL
-	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_RX_MASK_VLAN_CONFLICT_ERR 0x1UL
-	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_LAST                     CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_RX_MASK_VLAN_CONFLICT_ERR
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_UNKNOWN            0x0UL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_ZERO_MAC           0x65UL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_BC_MC_MAC          0x66UL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_INVALID_VNIC       0x67UL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_INVALID_PF_FID     0x68UL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_INVALID_L2_CTXT_ID 0x69UL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_NULL_L2_CTXT_CFG   0x6aUL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_NULL_L2_DATA_FLD   0x6bUL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_INVALID_CFA_LAYOUT 0x6cUL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_L2_CTXT_ALLOC_FAIL 0x6dUL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_ROCE_FLOW_ERR      0x6eUL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_INVALID_OWNER_FID  0x6fUL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_ZERO_REF_CNT       0x70UL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_INVALID_FLOW_TYPE  0x71UL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_INVALID_IVLAN      0x72UL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_MAX_VLAN_ID        0x73UL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_INVALID_TNL_REQ    0x74UL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_L2_ADDR            0x75UL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_L2_IVLAN           0x76UL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_L3_ADDR            0x77UL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_L3_ADDR_TYPE       0x78UL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_T_L3_ADDR_TYPE     0x79UL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_DST_VNIC_ID        0x7aUL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_VNI                0x7bUL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_INVALID_DST_ID     0x7cUL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_FAIL_ROCE_L2_FLOW  0x7dUL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_INVALID_NPAR_VLAN  0x7eUL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_ATSP_ADD           0x7fUL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_DFLT_VLAN_FAIL     0x80UL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_INVALID_L3_TYPE    0x81UL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_VAL_FAIL_TNL_FLOW  0x82UL
+	#define CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_LAST              CFA_NTUPLE_FILTER_ALLOC_CMD_ERR_CODE_VAL_FAIL_TNL_FLOW
 	u8	unused_0[7];
 };
 
@@ -9181,7 +9337,7 @@ struct pcie_ctx_hw_stats {
 	__le64	pcie_recovery_histogram;
 };
 
-/* pcie_ctx_hw_stats_v2 (size:4096b/512B) */
+/* pcie_ctx_hw_stats_v2 (size:4544b/568B) */
 struct pcie_ctx_hw_stats_v2 {
 	__le64	pcie_pl_signal_integrity;
 	__le64	pcie_dl_signal_integrity;
@@ -9212,6 +9368,9 @@ struct pcie_ctx_hw_stats_v2 {
 	__le64	pcie_other_packet_count;
 	__le64	pcie_blocked_packet_count;
 	__le64	pcie_cmpl_packet_count;
+	__le32	pcie_rd_latency_histogram[12];
+	__le32	pcie_rd_latency_all_normal_count;
+	__le32	unused_2;
 };
 
 /* hwrm_stat_generic_qstats_input (size:256b/32B) */
@@ -9406,7 +9565,8 @@ struct hwrm_struct_hdr {
 	#define STRUCT_HDR_STRUCT_ID_MSIX_PER_VF           0xc8UL
 	#define STRUCT_HDR_STRUCT_ID_UDCC_RTT_BUCKET_COUNT 0x12cUL
 	#define STRUCT_HDR_STRUCT_ID_UDCC_RTT_BUCKET_BOUND 0x12dUL
-	#define STRUCT_HDR_STRUCT_ID_LAST                 STRUCT_HDR_STRUCT_ID_UDCC_RTT_BUCKET_BOUND
+	#define STRUCT_HDR_STRUCT_ID_DBG_TOKEN_CLAIMS      0x190UL
+	#define STRUCT_HDR_STRUCT_ID_LAST                 STRUCT_HDR_STRUCT_ID_DBG_TOKEN_CLAIMS
 	__le16	len;
 	u8	version;
 	#define STRUCT_HDR_VERSION_0 0x0UL
@@ -9459,11 +9619,13 @@ struct hwrm_fw_set_structured_data_output {
 /* hwrm_fw_set_structured_data_cmd_err (size:64b/8B) */
 struct hwrm_fw_set_structured_data_cmd_err {
 	u8	code;
-	#define FW_SET_STRUCTURED_DATA_CMD_ERR_CODE_UNKNOWN     0x0UL
-	#define FW_SET_STRUCTURED_DATA_CMD_ERR_CODE_BAD_HDR_CNT 0x1UL
-	#define FW_SET_STRUCTURED_DATA_CMD_ERR_CODE_BAD_FMT     0x2UL
-	#define FW_SET_STRUCTURED_DATA_CMD_ERR_CODE_BAD_ID      0x3UL
-	#define FW_SET_STRUCTURED_DATA_CMD_ERR_CODE_LAST       FW_SET_STRUCTURED_DATA_CMD_ERR_CODE_BAD_ID
+	#define FW_SET_STRUCTURED_DATA_CMD_ERR_CODE_UNKNOWN       0x0UL
+	#define FW_SET_STRUCTURED_DATA_CMD_ERR_CODE_BAD_HDR_CNT   0x1UL
+	#define FW_SET_STRUCTURED_DATA_CMD_ERR_CODE_BAD_FMT       0x2UL
+	#define FW_SET_STRUCTURED_DATA_CMD_ERR_CODE_BAD_ID        0x3UL
+	#define FW_SET_STRUCTURED_DATA_CMD_ERR_CODE_ALREADY_ADDED 0x4UL
+	#define FW_SET_STRUCTURED_DATA_CMD_ERR_CODE_INST_IN_PROG  0x5UL
+	#define FW_SET_STRUCTURED_DATA_CMD_ERR_CODE_LAST         FW_SET_STRUCTURED_DATA_CMD_ERR_CODE_INST_IN_PROG
 	u8	unused_0[7];
 };
 
@@ -9487,7 +9649,9 @@ struct hwrm_fw_get_structured_data_input {
 	#define FW_GET_STRUCTURED_DATA_REQ_SUBTYPE_NON_TPMR_PEER           0x201UL
 	#define FW_GET_STRUCTURED_DATA_REQ_SUBTYPE_NON_TPMR_OPERATIONAL    0x202UL
 	#define FW_GET_STRUCTURED_DATA_REQ_SUBTYPE_HOST_OPERATIONAL        0x300UL
-	#define FW_GET_STRUCTURED_DATA_REQ_SUBTYPE_LAST                   FW_GET_STRUCTURED_DATA_REQ_SUBTYPE_HOST_OPERATIONAL
+	#define FW_GET_STRUCTURED_DATA_REQ_SUBTYPE_CLAIMS_SUPPORTED        0x320UL
+	#define FW_GET_STRUCTURED_DATA_REQ_SUBTYPE_CLAIMS_ACTIVE           0x321UL
+	#define FW_GET_STRUCTURED_DATA_REQ_SUBTYPE_LAST                   FW_GET_STRUCTURED_DATA_REQ_SUBTYPE_CLAIMS_ACTIVE
 	u8	count;
 	u8	unused_0;
 };
@@ -10172,7 +10336,8 @@ struct hwrm_dbg_log_buffer_flush_input {
 	#define DBG_LOG_BUFFER_FLUSH_REQ_TYPE_CA2_TRACE           0x9UL
 	#define DBG_LOG_BUFFER_FLUSH_REQ_TYPE_RIGP1_TRACE         0xaUL
 	#define DBG_LOG_BUFFER_FLUSH_REQ_TYPE_AFM_KONG_HWRM_TRACE 0xbUL
-	#define DBG_LOG_BUFFER_FLUSH_REQ_TYPE_LAST               DBG_LOG_BUFFER_FLUSH_REQ_TYPE_AFM_KONG_HWRM_TRACE
+	#define DBG_LOG_BUFFER_FLUSH_REQ_TYPE_ERR_QPC_TRACE       0xcUL
+	#define DBG_LOG_BUFFER_FLUSH_REQ_TYPE_LAST               DBG_LOG_BUFFER_FLUSH_REQ_TYPE_ERR_QPC_TRACE
 	u8	unused_1[2];
 	__le32	flags;
 	#define DBG_LOG_BUFFER_FLUSH_REQ_FLAGS_FLUSH_ALL_BUFFERS     0x1UL
@@ -10295,10 +10460,15 @@ struct hwrm_nvm_write_output {
 /* hwrm_nvm_write_cmd_err (size:64b/8B) */
 struct hwrm_nvm_write_cmd_err {
 	u8	code;
-	#define NVM_WRITE_CMD_ERR_CODE_UNKNOWN  0x0UL
-	#define NVM_WRITE_CMD_ERR_CODE_FRAG_ERR 0x1UL
-	#define NVM_WRITE_CMD_ERR_CODE_NO_SPACE 0x2UL
-	#define NVM_WRITE_CMD_ERR_CODE_LAST    NVM_WRITE_CMD_ERR_CODE_NO_SPACE
+	#define NVM_WRITE_CMD_ERR_CODE_UNKNOWN              0x0UL
+	#define NVM_WRITE_CMD_ERR_CODE_FRAG_ERR             0x1UL
+	#define NVM_WRITE_CMD_ERR_CODE_NO_SPACE             0x2UL
+	#define NVM_WRITE_CMD_ERR_CODE_WRITE_FAILED         0x3UL
+	#define NVM_WRITE_CMD_ERR_CODE_REQD_ERASE_FAILED    0x4UL
+	#define NVM_WRITE_CMD_ERR_CODE_VERIFY_FAILED        0x5UL
+	#define NVM_WRITE_CMD_ERR_CODE_INVALID_HEADER       0x6UL
+	#define NVM_WRITE_CMD_ERR_CODE_UPDATE_DIGEST_FAILED 0x7UL
+	#define NVM_WRITE_CMD_ERR_CODE_LAST                NVM_WRITE_CMD_ERR_CODE_UPDATE_DIGEST_FAILED
 	u8	unused_0[7];
 };
 
@@ -10438,7 +10608,11 @@ struct hwrm_nvm_get_dev_info_output {
 	__le16	srt2_fw_minor;
 	__le16	srt2_fw_build;
 	__le16	srt2_fw_patch;
-	u8	unused_0[7];
+	u8	security_soc_fw_major;
+	u8	security_soc_fw_minor;
+	u8	security_soc_fw_build;
+	u8	security_soc_fw_patch;
+	u8	unused_0[3];
 	u8	valid;
 };
 
@@ -10568,7 +10742,9 @@ struct hwrm_nvm_install_update_cmd_err {
 	#define NVM_INSTALL_UPDATE_CMD_ERR_CODE_NO_SPACE           0x2UL
 	#define NVM_INSTALL_UPDATE_CMD_ERR_CODE_ANTI_ROLLBACK      0x3UL
 	#define NVM_INSTALL_UPDATE_CMD_ERR_CODE_NO_VOLTREG_SUPPORT 0x4UL
-	#define NVM_INSTALL_UPDATE_CMD_ERR_CODE_LAST              NVM_INSTALL_UPDATE_CMD_ERR_CODE_NO_VOLTREG_SUPPORT
+	#define NVM_INSTALL_UPDATE_CMD_ERR_CODE_DEFRAG_FAILED      0x5UL
+	#define NVM_INSTALL_UPDATE_CMD_ERR_CODE_UNKNOWN_DIR_ERR    0x6UL
+	#define NVM_INSTALL_UPDATE_CMD_ERR_CODE_LAST              NVM_INSTALL_UPDATE_CMD_ERR_CODE_UNKNOWN_DIR_ERR
 	u8	unused_0[7];
 };
 
@@ -10591,7 +10767,8 @@ struct hwrm_nvm_get_variable_input {
 	__le16	index_2;
 	__le16	index_3;
 	u8	flags;
-	#define NVM_GET_VARIABLE_REQ_FLAGS_FACTORY_DFLT     0x1UL
+	#define NVM_GET_VARIABLE_REQ_FLAGS_FACTORY_DFLT           0x1UL
+	#define NVM_GET_VARIABLE_REQ_FLAGS_VALIDATE_OPT_VALUE     0x2UL
 	u8	unused_0;
 };
 
@@ -10606,18 +10783,25 @@ struct hwrm_nvm_get_variable_output {
 	#define NVM_GET_VARIABLE_RESP_OPTION_NUM_RSVD_0    0x0UL
 	#define NVM_GET_VARIABLE_RESP_OPTION_NUM_RSVD_FFFF 0xffffUL
 	#define NVM_GET_VARIABLE_RESP_OPTION_NUM_LAST     NVM_GET_VARIABLE_RESP_OPTION_NUM_RSVD_FFFF
-	u8	unused_0[3];
+	u8	flags;
+	#define NVM_GET_VARIABLE_RESP_FLAGS_VALIDATE_OPT_VALUE     0x1UL
+	u8	unused_0[2];
 	u8	valid;
 };
 
 /* hwrm_nvm_get_variable_cmd_err (size:64b/8B) */
 struct hwrm_nvm_get_variable_cmd_err {
 	u8	code;
-	#define NVM_GET_VARIABLE_CMD_ERR_CODE_UNKNOWN       0x0UL
-	#define NVM_GET_VARIABLE_CMD_ERR_CODE_VAR_NOT_EXIST 0x1UL
-	#define NVM_GET_VARIABLE_CMD_ERR_CODE_CORRUPT_VAR   0x2UL
-	#define NVM_GET_VARIABLE_CMD_ERR_CODE_LEN_TOO_SHORT 0x3UL
-	#define NVM_GET_VARIABLE_CMD_ERR_CODE_LAST         NVM_GET_VARIABLE_CMD_ERR_CODE_LEN_TOO_SHORT
+	#define NVM_GET_VARIABLE_CMD_ERR_CODE_UNKNOWN          0x0UL
+	#define NVM_GET_VARIABLE_CMD_ERR_CODE_VAR_NOT_EXIST    0x1UL
+	#define NVM_GET_VARIABLE_CMD_ERR_CODE_CORRUPT_VAR      0x2UL
+	#define NVM_GET_VARIABLE_CMD_ERR_CODE_LEN_TOO_SHORT    0x3UL
+	#define NVM_GET_VARIABLE_CMD_ERR_CODE_INDEX_INVALID    0x4UL
+	#define NVM_GET_VARIABLE_CMD_ERR_CODE_ACCESS_DENIED    0x5UL
+	#define NVM_GET_VARIABLE_CMD_ERR_CODE_CB_FAILED        0x6UL
+	#define NVM_GET_VARIABLE_CMD_ERR_CODE_INVALID_DATA_LEN 0x7UL
+	#define NVM_GET_VARIABLE_CMD_ERR_CODE_NO_MEM           0x8UL
+	#define NVM_GET_VARIABLE_CMD_ERR_CODE_LAST            NVM_GET_VARIABLE_CMD_ERR_CODE_NO_MEM
 	u8	unused_0[7];
 };
 
@@ -10667,10 +10851,17 @@ struct hwrm_nvm_set_variable_output {
 /* hwrm_nvm_set_variable_cmd_err (size:64b/8B) */
 struct hwrm_nvm_set_variable_cmd_err {
 	u8	code;
-	#define NVM_SET_VARIABLE_CMD_ERR_CODE_UNKNOWN       0x0UL
-	#define NVM_SET_VARIABLE_CMD_ERR_CODE_VAR_NOT_EXIST 0x1UL
-	#define NVM_SET_VARIABLE_CMD_ERR_CODE_CORRUPT_VAR   0x2UL
-	#define NVM_SET_VARIABLE_CMD_ERR_CODE_LAST         NVM_SET_VARIABLE_CMD_ERR_CODE_CORRUPT_VAR
+	#define NVM_SET_VARIABLE_CMD_ERR_CODE_UNKNOWN              0x0UL
+	#define NVM_SET_VARIABLE_CMD_ERR_CODE_VAR_NOT_EXIST        0x1UL
+	#define NVM_SET_VARIABLE_CMD_ERR_CODE_CORRUPT_VAR          0x2UL
+	#define NVM_SET_VARIABLE_CMD_ERR_CODE_LEN_TOO_SHORT        0x3UL
+	#define NVM_SET_VARIABLE_CMD_ERR_CODE_ACTION_NOT_SUPPORTED 0x4UL
+	#define NVM_SET_VARIABLE_CMD_ERR_CODE_INDEX_INVALID        0x5UL
+	#define NVM_SET_VARIABLE_CMD_ERR_CODE_ACCESS_DENIED        0x6UL
+	#define NVM_SET_VARIABLE_CMD_ERR_CODE_CB_FAILED            0x7UL
+	#define NVM_SET_VARIABLE_CMD_ERR_CODE_INVALID_DATA_LEN     0x8UL
+	#define NVM_SET_VARIABLE_CMD_ERR_CODE_NO_MEM               0x9UL
+	#define NVM_SET_VARIABLE_CMD_ERR_CODE_LAST                NVM_SET_VARIABLE_CMD_ERR_CODE_NO_MEM
 	u8	unused_0[7];
 };
 
-- 
2.30.1


