Return-Path: <netdev+bounces-173624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7733DA5A31A
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 19:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 880AA3A2BC1
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 18:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FBB235BF1;
	Mon, 10 Mar 2025 18:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Oa8CrPqh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3AB235BFB
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 18:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741631643; cv=none; b=hzxtdWkAFyMiyHGVwnW0OD3pZAUDqYRy1ULLbf9zsmKqQRQVXCokKtn1Z4iGi5bmxiqe3z/snw0qXYWkMl57dmnR6fffPFAEHlCKTMomf/Ch9T+AjhudLLWpOWekjxjvyDTVv/EtdDqfIb204LZq2+AYkjiA8ypESBTzHLamaz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741631643; c=relaxed/simple;
	bh=JrhOsfOhZ+1cQci9cfZKZOP88usyAwP/q6Zumwk+wjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvqQ+Wg70MCCntXJxHH+Bh9KjTN+05On4/zz0mcWzBkWpdjpOC1/B5+oo6KAaPIp7sH1vKTl/MjkKgdOjeSawHkLeAE7FqHMXb0gd6DKvkeoSXk7r5Sz806fGQtCTC0aushb8+YC12z+bQ5jvfN5mR0klMoFjHofzzEIaE3kMAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Oa8CrPqh; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-72737740673so2372288a34.3
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 11:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741631640; x=1742236440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhrDw2zPlbW/SIgP2gVmLS53I+lE4uYNlRDJevlb7LM=;
        b=Oa8CrPqhq5574urCuBzFwo1ie7cQECjdfBORt3MOc/DCOTIh4L4cGx/PQU6V0Xu3Zi
         N43Wf8tZM7IMlNEhWwwmivxVhvqpCSQR+r2ASRfbzNOYnfE8QFM4y/+5/FRTJm5+zVlR
         2A5vDniceVQ9tdo1iILMKIpcrb6tw1eSWcfVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741631640; x=1742236440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qhrDw2zPlbW/SIgP2gVmLS53I+lE4uYNlRDJevlb7LM=;
        b=Xikem3o2lnymLp78/VHWgtPAF3NrpxA2tc/YQ3sN7vdIZ915nbec0UhMSTen2aD7gX
         9oiEXXdEJf9lOTuetP3/PGpTqG8uGmAo0DP9oUZ3g0pcwZCo+oq6qWAFX9hVWHRxrWIn
         D5Rprjf35OX/xp6Y6iNVdMKiUuK5hcFAFOfkps+3go7gNMGH79p83sgS6uB7N/7AusMl
         jTshPIeFC6JQjng+m3Kzadbx/adj5ZD0C/ylZWFnHXbvY3rdrIemOVGNd6Fxsm8p+JV8
         jxiAvEMKuIkEXp+TyxwhnPFeAAjqT2ARnEnUzeOLyBF1SwCv63B61pJ1cnlH9MqwgKJY
         zOSw==
X-Gm-Message-State: AOJu0YyLllieZ5nqjY2Lh28vOj6PKi4jneF2KHQ+TvGMl/DUtYQuCwtg
	DuWUAh2GrIITKnOP3KsgwM9IKtFB3iKceP4yfx8lGftZi7zGARjcPvObc4KnVQ==
X-Gm-Gg: ASbGncs5nTu1wQRMjjyjjuC+RVjiZZnqB8Ia04ZNXwSBXLW5GV6rahHDhDJSdScR+9I
	8ILwWIdgYCVBD05YVBSSjO8foIbAWYCirQzZtUzfdf3ANjL9tMuelhPq5CtoZGnESvKSjQafZeh
	28JF5waUY7P5FMwKXYbtTgdWM0Fxz/IeqWNpllcvmYfatlF7PO8DqCR3FRwsI7RLuPWueABkccN
	tNg7TnWpvAyyvxGhzNZssD2F9T9CdO0OfRwvxTYqc7bhcJba5/D/soqE0M9+CG60N9rLtP0t4Xq
	6wSwWFYkCEX3evorrRHsHwUkZLp/a7lbofXf9wqV2i1GwpQv9u1dztNLsXDrHMKoFZPoD5xsa4l
	4bOQpacn72H+qFsP5pizf
X-Google-Smtp-Source: AGHT+IEp+3Cagcha5sfTeu4+8RBW7r6lV7dkDjfdU4DY4DPcFE61RScBpTQuD9XnbMRACVWT6TuRqQ==
X-Received: by 2002:a05:6808:2105:b0:3f8:b73b:6848 with SMTP id 5614622812f47-3f8b74abbeemr3154694b6e.26.1741631639092;
        Mon, 10 Mar 2025 11:33:59 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3fa33834905sm41814b6e.27.2025.03.10.11.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 11:33:57 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next 5/7] bnxt_en: Update firmware interface to 1.10.3.97
Date: Mon, 10 Mar 2025 11:31:27 -0700
Message-ID: <20250310183129.3154117-6-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250310183129.3154117-1-michael.chan@broadcom.com>
References: <20250310183129.3154117-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The main changes are adding i2c write for module eeprom and a new v2
PCIe statistics structure.

Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h | 143 +++++++++++++++---
 1 file changed, 119 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
index 5f8de1634378..549231703bce 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
@@ -2,7 +2,7 @@
  *
  * Copyright (c) 2014-2016 Broadcom Corporation
  * Copyright (c) 2014-2018 Broadcom Limited
- * Copyright (c) 2018-2024 Broadcom Inc.
+ * Copyright (c) 2018-2025 Broadcom Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -438,6 +438,7 @@ struct cmd_nums {
 	#define HWRM_MFG_PRVSN_EXPORT_CERT                0x219UL
 	#define HWRM_STAT_DB_ERROR_QSTATS                 0x21aUL
 	#define HWRM_MFG_TESTS                            0x21bUL
+	#define HWRM_MFG_WRITE_CERT_NVM                   0x21cUL
 	#define HWRM_PORT_POE_CFG                         0x230UL
 	#define HWRM_PORT_POE_QCFG                        0x231UL
 	#define HWRM_UDCC_QCAPS                           0x258UL
@@ -514,6 +515,8 @@ struct cmd_nums {
 	#define HWRM_TFC_TBL_SCOPE_CONFIG_GET             0x39aUL
 	#define HWRM_TFC_RESC_USAGE_QUERY                 0x39bUL
 	#define HWRM_TFC_GLOBAL_ID_FREE                   0x39cUL
+	#define HWRM_TFC_TCAM_PRI_UPDATE                  0x39dUL
+	#define HWRM_TFC_HOT_UPGRADE_PROCESS              0x3a0UL
 	#define HWRM_SV                                   0x400UL
 	#define HWRM_DBG_SERDES_TEST                      0xff0eUL
 	#define HWRM_DBG_LOG_BUFFER_FLUSH                 0xff0fUL
@@ -629,8 +632,8 @@ struct hwrm_err_output {
 #define HWRM_VERSION_MAJOR 1
 #define HWRM_VERSION_MINOR 10
 #define HWRM_VERSION_UPDATE 3
-#define HWRM_VERSION_RSVD 85
-#define HWRM_VERSION_STR "1.10.3.85"
+#define HWRM_VERSION_RSVD 97
+#define HWRM_VERSION_STR "1.10.3.97"
 
 /* hwrm_ver_get_input (size:192b/24B) */
 struct hwrm_ver_get_input {
@@ -1905,11 +1908,15 @@ struct hwrm_func_qcaps_output {
 	__le32	roce_vf_max_srq;
 	__le32	roce_vf_max_gid;
 	__le32	flags_ext3;
-	#define FUNC_QCAPS_RESP_FLAGS_EXT3_RM_RSV_WHILE_ALLOC_CAP     0x1UL
-	#define FUNC_QCAPS_RESP_FLAGS_EXT3_REQUIRE_L2_FILTER          0x2UL
-	#define FUNC_QCAPS_RESP_FLAGS_EXT3_MAX_ROCE_VFS_SUPPORTED     0x4UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT3_RM_RSV_WHILE_ALLOC_CAP            0x1UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT3_REQUIRE_L2_FILTER                 0x2UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT3_MAX_ROCE_VFS_SUPPORTED            0x4UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT3_RX_RATE_PROFILE_SEL_SUPPORTED     0x8UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT3_BIDI_OPT_SUPPORTED                0x10UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT3_MIRROR_ON_ROCE_SUPPORTED          0x20UL
 	__le16	max_roce_vfs;
-	u8	unused_3[5];
+	__le16	max_crypto_rx_flow_filters;
+	u8	unused_3[3];
 	u8	valid;
 };
 
@@ -1924,7 +1931,7 @@ struct hwrm_func_qcfg_input {
 	u8	unused_0[6];
 };
 
-/* hwrm_func_qcfg_output (size:1280b/160B) */
+/* hwrm_func_qcfg_output (size:1344b/168B) */
 struct hwrm_func_qcfg_output {
 	__le16	error_code;
 	__le16	req_type;
@@ -2087,14 +2094,18 @@ struct hwrm_func_qcfg_output {
 	__le16	host_mtu;
 	__le16	flags2;
 	#define FUNC_QCFG_RESP_FLAGS2_SRIOV_DSCP_INSERT_ENABLED     0x1UL
-	u8	unused_4[2];
+	__le16	stag_vid;
 	u8	port_kdnet_mode;
 	#define FUNC_QCFG_RESP_PORT_KDNET_MODE_DISABLED 0x0UL
 	#define FUNC_QCFG_RESP_PORT_KDNET_MODE_ENABLED  0x1UL
 	#define FUNC_QCFG_RESP_PORT_KDNET_MODE_LAST    FUNC_QCFG_RESP_PORT_KDNET_MODE_ENABLED
 	u8	kdnet_pcie_function;
 	__le16	port_kdnet_fid;
-	u8	unused_5[2];
+	u8	unused_5;
+	u8	roce_bidi_opt_mode;
+	#define FUNC_QCFG_RESP_ROCE_BIDI_OPT_MODE_DISABLED      0x1UL
+	#define FUNC_QCFG_RESP_ROCE_BIDI_OPT_MODE_DEDICATED     0x2UL
+	#define FUNC_QCFG_RESP_ROCE_BIDI_OPT_MODE_SHARED        0x4UL
 	__le32	num_ktls_tx_key_ctxs;
 	__le32	num_ktls_rx_key_ctxs;
 	u8	lag_id;
@@ -2112,7 +2123,8 @@ struct hwrm_func_qcfg_output {
 	__le16	xid_partition_cfg;
 	#define FUNC_QCFG_RESP_XID_PARTITION_CFG_TX_CK     0x1UL
 	#define FUNC_QCFG_RESP_XID_PARTITION_CFG_RX_CK     0x2UL
-	u8	unused_7;
+	__le16	mirror_vnic_id;
+	u8	unused_7[7];
 	u8	valid;
 };
 
@@ -3965,7 +3977,7 @@ struct ts_split_entries {
 	__le32	region_num_entries;
 	u8	tsid;
 	u8	lkup_static_bkt_cnt_exp[2];
-	u8	rsvd;
+	u8	locked;
 	__le32	rsvd2[2];
 };
 
@@ -5483,6 +5495,37 @@ struct hwrm_port_phy_qcaps_output {
 	u8	valid;
 };
 
+/* hwrm_port_phy_i2c_write_input (size:832b/104B) */
+struct hwrm_port_phy_i2c_write_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le32	flags;
+	__le32	enables;
+	#define PORT_PHY_I2C_WRITE_REQ_ENABLES_PAGE_OFFSET     0x1UL
+	#define PORT_PHY_I2C_WRITE_REQ_ENABLES_BANK_NUMBER     0x2UL
+	__le16	port_id;
+	u8	i2c_slave_addr;
+	u8	bank_number;
+	__le16	page_number;
+	__le16	page_offset;
+	u8	data_length;
+	u8	unused_1[7];
+	__le32	data[16];
+};
+
+/* hwrm_port_phy_i2c_write_output (size:128b/16B) */
+struct hwrm_port_phy_i2c_write_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	unused_0[7];
+	u8	valid;
+};
+
 /* hwrm_port_phy_i2c_read_input (size:320b/40B) */
 struct hwrm_port_phy_i2c_read_input {
 	__le16	req_type;
@@ -6610,8 +6653,9 @@ struct hwrm_vnic_alloc_input {
 	__le32	flags;
 	#define VNIC_ALLOC_REQ_FLAGS_DEFAULT                  0x1UL
 	#define VNIC_ALLOC_REQ_FLAGS_VIRTIO_NET_FID_VALID     0x2UL
+	#define VNIC_ALLOC_REQ_FLAGS_VNIC_ID_VALID            0x4UL
 	__le16	virtio_net_fid;
-	u8	unused_0[2];
+	__le16	vnic_id;
 };
 
 /* hwrm_vnic_alloc_output (size:128b/16B) */
@@ -6710,6 +6754,7 @@ struct hwrm_vnic_cfg_input {
 	#define VNIC_CFG_REQ_ENABLES_QUEUE_ID                 0x80UL
 	#define VNIC_CFG_REQ_ENABLES_RX_CSUM_V2_MODE          0x100UL
 	#define VNIC_CFG_REQ_ENABLES_L2_CQE_MODE              0x200UL
+	#define VNIC_CFG_REQ_ENABLES_RAW_QP_ID                0x400UL
 	__le16	vnic_id;
 	__le16	dflt_ring_grp;
 	__le16	rss_rule;
@@ -6729,7 +6774,7 @@ struct hwrm_vnic_cfg_input {
 	#define VNIC_CFG_REQ_L2_CQE_MODE_COMPRESSED 0x1UL
 	#define VNIC_CFG_REQ_L2_CQE_MODE_MIXED      0x2UL
 	#define VNIC_CFG_REQ_L2_CQE_MODE_LAST      VNIC_CFG_REQ_L2_CQE_MODE_MIXED
-	u8	unused0[4];
+	__le32	raw_qp_id;
 };
 
 /* hwrm_vnic_cfg_output (size:128b/16B) */
@@ -7082,6 +7127,15 @@ struct hwrm_vnic_plcmodes_cfg_output {
 	u8	valid;
 };
 
+/* hwrm_vnic_plcmodes_cfg_cmd_err (size:64b/8B) */
+struct hwrm_vnic_plcmodes_cfg_cmd_err {
+	u8	code;
+	#define VNIC_PLCMODES_CFG_CMD_ERR_CODE_UNKNOWN               0x0UL
+	#define VNIC_PLCMODES_CFG_CMD_ERR_CODE_INVALID_HDS_THRESHOLD 0x1UL
+	#define VNIC_PLCMODES_CFG_CMD_ERR_CODE_LAST                 VNIC_PLCMODES_CFG_CMD_ERR_CODE_INVALID_HDS_THRESHOLD
+	u8	unused_0[7];
+};
+
 /* hwrm_vnic_rss_cos_lb_ctx_alloc_input (size:128b/16B) */
 struct hwrm_vnic_rss_cos_lb_ctx_alloc_input {
 	__le16	req_type;
@@ -7131,15 +7185,16 @@ struct hwrm_ring_alloc_input {
 	__le16	target_id;
 	__le64	resp_addr;
 	__le32	enables;
-	#define RING_ALLOC_REQ_ENABLES_RING_ARB_CFG           0x2UL
-	#define RING_ALLOC_REQ_ENABLES_STAT_CTX_ID_VALID      0x8UL
-	#define RING_ALLOC_REQ_ENABLES_MAX_BW_VALID           0x20UL
-	#define RING_ALLOC_REQ_ENABLES_RX_RING_ID_VALID       0x40UL
-	#define RING_ALLOC_REQ_ENABLES_NQ_RING_ID_VALID       0x80UL
-	#define RING_ALLOC_REQ_ENABLES_RX_BUF_SIZE_VALID      0x100UL
-	#define RING_ALLOC_REQ_ENABLES_SCHQ_ID                0x200UL
-	#define RING_ALLOC_REQ_ENABLES_MPC_CHNLS_TYPE         0x400UL
-	#define RING_ALLOC_REQ_ENABLES_STEERING_TAG_VALID     0x800UL
+	#define RING_ALLOC_REQ_ENABLES_RING_ARB_CFG              0x2UL
+	#define RING_ALLOC_REQ_ENABLES_STAT_CTX_ID_VALID         0x8UL
+	#define RING_ALLOC_REQ_ENABLES_MAX_BW_VALID              0x20UL
+	#define RING_ALLOC_REQ_ENABLES_RX_RING_ID_VALID          0x40UL
+	#define RING_ALLOC_REQ_ENABLES_NQ_RING_ID_VALID          0x80UL
+	#define RING_ALLOC_REQ_ENABLES_RX_BUF_SIZE_VALID         0x100UL
+	#define RING_ALLOC_REQ_ENABLES_SCHQ_ID                   0x200UL
+	#define RING_ALLOC_REQ_ENABLES_MPC_CHNLS_TYPE            0x400UL
+	#define RING_ALLOC_REQ_ENABLES_STEERING_TAG_VALID        0x800UL
+	#define RING_ALLOC_REQ_ENABLES_RX_RATE_PROFILE_VALID     0x1000UL
 	u8	ring_type;
 	#define RING_ALLOC_REQ_RING_TYPE_L2_CMPL   0x0UL
 	#define RING_ALLOC_REQ_RING_TYPE_TX        0x1UL
@@ -7226,7 +7281,11 @@ struct hwrm_ring_alloc_input {
 	#define RING_ALLOC_REQ_MPC_CHNLS_TYPE_RE_CFA  0x3UL
 	#define RING_ALLOC_REQ_MPC_CHNLS_TYPE_PRIMATE 0x4UL
 	#define RING_ALLOC_REQ_MPC_CHNLS_TYPE_LAST   RING_ALLOC_REQ_MPC_CHNLS_TYPE_PRIMATE
-	u8	unused_4[2];
+	u8	rx_rate_profile_sel;
+	#define RING_ALLOC_REQ_RX_RATE_PROFILE_SEL_DEFAULT   0x0UL
+	#define RING_ALLOC_REQ_RX_RATE_PROFILE_SEL_POLL_MODE 0x1UL
+	#define RING_ALLOC_REQ_RX_RATE_PROFILE_SEL_LAST     RING_ALLOC_REQ_RX_RATE_PROFILE_SEL_POLL_MODE
+	u8	unused_4;
 	__le64	cq_handle;
 };
 
@@ -9122,6 +9181,39 @@ struct pcie_ctx_hw_stats {
 	__le64	pcie_recovery_histogram;
 };
 
+/* pcie_ctx_hw_stats_v2 (size:4096b/512B) */
+struct pcie_ctx_hw_stats_v2 {
+	__le64	pcie_pl_signal_integrity;
+	__le64	pcie_dl_signal_integrity;
+	__le64	pcie_tl_signal_integrity;
+	__le64	pcie_link_integrity;
+	__le64	pcie_tx_traffic_rate;
+	__le64	pcie_rx_traffic_rate;
+	__le64	pcie_tx_dllp_statistics;
+	__le64	pcie_rx_dllp_statistics;
+	__le64	pcie_equalization_time;
+	__le32	pcie_ltssm_histogram[4];
+	__le64	pcie_recovery_histogram;
+	__le32	pcie_tl_credit_nph_histogram[8];
+	__le32	pcie_tl_credit_ph_histogram[8];
+	__le32	pcie_tl_credit_pd_histogram[8];
+	__le32	pcie_cmpl_latest_times[4];
+	__le32	pcie_cmpl_longest_time;
+	__le32	pcie_cmpl_shortest_time;
+	__le32	unused_0[2];
+	__le32	pcie_cmpl_latest_headers[4][4];
+	__le32	pcie_cmpl_longest_headers[4][4];
+	__le32	pcie_cmpl_shortest_headers[4][4];
+	__le32	pcie_wr_latency_histogram[12];
+	__le32	pcie_wr_latency_all_normal_count;
+	__le32	unused_1;
+	__le64	pcie_posted_packet_count;
+	__le64	pcie_non_posted_packet_count;
+	__le64	pcie_other_packet_count;
+	__le64	pcie_blocked_packet_count;
+	__le64	pcie_cmpl_packet_count;
+};
+
 /* hwrm_stat_generic_qstats_input (size:256b/32B) */
 struct hwrm_stat_generic_qstats_input {
 	__le16	req_type;
@@ -9317,6 +9409,9 @@ struct hwrm_struct_hdr {
 	#define STRUCT_HDR_STRUCT_ID_LAST                 STRUCT_HDR_STRUCT_ID_UDCC_RTT_BUCKET_BOUND
 	__le16	len;
 	u8	version;
+	#define STRUCT_HDR_VERSION_0 0x0UL
+	#define STRUCT_HDR_VERSION_1 0x1UL
+	#define STRUCT_HDR_VERSION_LAST STRUCT_HDR_VERSION_1
 	u8	count;
 	__le16	subtype;
 	__le16	next_offset;
-- 
2.30.1


