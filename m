Return-Path: <netdev+bounces-83713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFBB8937E5
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 05:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44FEE1F21559
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 03:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC2A53A6;
	Mon,  1 Apr 2024 03:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OzQW6x8T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6553A53BE
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 03:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711943701; cv=none; b=lXjjNaapNhC0sI5CCaionL0bStIoOQScgCjSfmlLqUMopKZE4ZAn7azyyJpL8m5D/8TNePAF6cagMdDhUAFrmC68sKlrjQ6ZrRWwvMFizMm46h3DmMxfswN0xVokPFK613vypUcKM4qdFgtiz5LySbAh6FKboTZDRnlSwplzBVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711943701; c=relaxed/simple;
	bh=yuiFM2kXpo3KIuGh/8JZNcZXC0j2EtiHR8B8svau268=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gyef+prf/UeqhElkbZYqI1WAgyCIDStgWh74V7oUxReu+Y0eJj0yr/YEyqn7WciX5vZU/oeoeE+59Dj747nilDahFitGLAW6ecnuw5g+RZE3KczoBRv4pgZJ+mLRs7uUtoAxBlXpQfP2NO/coodbbQ4r3ZnsfRSoEIQCp5/Wlak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OzQW6x8T; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6eaf1a3e917so1226767b3a.2
        for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 20:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1711943699; x=1712548499; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wyMmvTt2whW0Vx2QjmPEeehtScXqjOulYZX6iAemH2M=;
        b=OzQW6x8T1aZk0eF1u2QeeKjPElyW29YtRpJY5lVjMsKNYiXpAQiSolKNuSZnhhVPnE
         YtN0cBn2bZN4FHIaQAOz+74dU+S7d89J9k33boN3m0FFE60HlAte/MJw3EQbI+L6+rIt
         T+mDWlTLnLK2UWWwPpce+n8JKiXycuHTYcH7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711943699; x=1712548499;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wyMmvTt2whW0Vx2QjmPEeehtScXqjOulYZX6iAemH2M=;
        b=qDRcUZvToFqi8V/B+e2TiNQjYBIkN8f8LskT4J8NBukklCInYNGiM1qND6KCkAyqMC
         gCTEx9BNXPGfVnTNyn02lMMcz4SqG+UDfUYaoxKmN0IkAINM+Bfc+J8gaZiG4z5RcSc+
         a589vQ7ntsJwCyGJoc1Nyyanf9HGTDjRv/XnBrygJL+ToyJtPdjf70qm+RF9bZYcIwto
         BQT3tkSN49o6GfzcPUW5gaiwpZBDWsaYRlwUZ8+NRfrb6bHdq2bScDeWn4icVjhJaqso
         AeMWIn3nMVX5DV/GmL4ykTLchg+jWr8CNn1RIputOdKKbgvGEebkF4qvBwIQ8WvzyeKI
         zxOA==
X-Forwarded-Encrypted: i=1; AJvYcCWAQdM3AL4ukVCq8nC9V6pv/9kiRrilnSlwhE6/bOyTpTdH/E9L6pa4s9bjKYU54GSlgCKVsDSbLAaM6aEBvux1mNU+kqp4
X-Gm-Message-State: AOJu0Yw2vmaBJHx3eaU9ij+aCtBVJKsAMbiypiPnDo5u6jLTbkc9WlES
	uVRbWZ2Tggvdp7iO4LWamvTyG1xzopn1jBHGGwan04A7VyLvBZcxn9redh4DyA==
X-Google-Smtp-Source: AGHT+IHUGPhGIVZeZUWyFI/+yfzxUqUYK9fbpbJY0dOJTz6pSmW4JJ+RTsVYuhhx5U86Lr+LiZOoPw==
X-Received: by 2002:a05:6a00:4fc8:b0:6e7:82f2:efeb with SMTP id le8-20020a056a004fc800b006e782f2efebmr7883585pfb.22.1711943698428;
        Sun, 31 Mar 2024 20:54:58 -0700 (PDT)
Received: from PC-MID-R740.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id j26-20020a62b61a000000b006e73d1c0c0esm6860781pff.154.2024.03.31.20.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 20:54:57 -0700 (PDT)
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
To: michael.chan@broadcom.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	gospo@broadcom.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [PATCH net-next 6/7] bnxt_en: Update firmware interface to 1.10.3.39
Date: Sun, 31 Mar 2024 20:57:29 -0700
Message-Id: <20240401035730.306790-7-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240401035730.306790-1-pavan.chebbi@broadcom.com>
References: <20240401035730.306790-1-pavan.chebbi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000000e8e6f061500f493"

--0000000000000e8e6f061500f493
Content-Transfer-Encoding: 8bit

This updated interface supports backing store APIs to
configure host FW trace buffers, updates transceivers ID
types, updates to TrueFlow features and other changes
for the basic L2 features.

Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Michael Chan <michael.chan@broadcom.com
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h | 184 +++++++++++++-----
 1 file changed, 137 insertions(+), 47 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
index e957abd704db..06ea86c80be1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
@@ -468,6 +468,10 @@ struct cmd_nums {
 	#define HWRM_TF_GLOBAL_CFG_GET                    0x2fdUL
 	#define HWRM_TF_IF_TBL_SET                        0x2feUL
 	#define HWRM_TF_IF_TBL_GET                        0x2ffUL
+	#define HWRM_TF_RESC_USAGE_SET                    0x300UL
+	#define HWRM_TF_RESC_USAGE_QUERY                  0x301UL
+	#define HWRM_TF_TBL_TYPE_ALLOC                    0x302UL
+	#define HWRM_TF_TBL_TYPE_FREE                     0x303UL
 	#define HWRM_TFC_TBL_SCOPE_QCAPS                  0x380UL
 	#define HWRM_TFC_TBL_SCOPE_ID_ALLOC               0x381UL
 	#define HWRM_TFC_TBL_SCOPE_CONFIG                 0x382UL
@@ -495,6 +499,7 @@ struct cmd_nums {
 	#define HWRM_TFC_IF_TBL_SET                       0x398UL
 	#define HWRM_TFC_IF_TBL_GET                       0x399UL
 	#define HWRM_TFC_TBL_SCOPE_CONFIG_GET             0x39aUL
+	#define HWRM_TFC_RESC_USAGE_QUERY                 0x39bUL
 	#define HWRM_SV                                   0x400UL
 	#define HWRM_DBG_READ_DIRECT                      0xff10UL
 	#define HWRM_DBG_READ_INDIRECT                    0xff11UL
@@ -604,8 +609,8 @@ struct hwrm_err_output {
 #define HWRM_VERSION_MAJOR 1
 #define HWRM_VERSION_MINOR 10
 #define HWRM_VERSION_UPDATE 3
-#define HWRM_VERSION_RSVD 15
-#define HWRM_VERSION_STR "1.10.3.15"
+#define HWRM_VERSION_RSVD 39
+#define HWRM_VERSION_STR "1.10.3.39"
 
 /* hwrm_ver_get_input (size:192b/24B) */
 struct hwrm_ver_get_input {
@@ -1328,8 +1333,9 @@ struct hwrm_async_event_cmpl_error_report_base {
 	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_INVALID_SIGNAL           0x2UL
 	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_NVM                      0x3UL
 	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_DOORBELL_DROP_THRESHOLD  0x4UL
-	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_THERMAL_THRESHOLD        0x5UL
-	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_LAST                    ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_THERMAL_THRESHOLD
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_THERMAL_THRESHOLD             0x5UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_DUAL_DATA_RATE_NOT_SUPPORTED  0x6UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_LAST                         ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_DUAL_DATA_RATE_NOT_SUPPORTED
 };
 
 /* hwrm_async_event_cmpl_error_report_pause_storm (size:128b/16B) */
@@ -1478,6 +1484,30 @@ struct hwrm_async_event_cmpl_error_report_thermal {
 	#define ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_TRANSITION_DIR_LAST       ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_TRANSITION_DIR_INCREASING
 };
 
+/* hwrm_async_event_cmpl_error_report_dual_data_rate_not_supported (size:128b/16B) */
+struct hwrm_async_event_cmpl_error_report_dual_data_rate_not_supported {
+	__le16	type;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DUAL_DATA_RATE_NOT_SUPPORTED_TYPE_MASK            0x3fUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DUAL_DATA_RATE_NOT_SUPPORTED_TYPE_SFT             0
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DUAL_DATA_RATE_NOT_SUPPORTED_TYPE_HWRM_ASYNC_EVENT  0x2eUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DUAL_DATA_RATE_NOT_SUPPORTED_TYPE_LAST             ASYNC_EVENT_CMPL_ERROR_REPORT_DUAL_DATA_RATE_NOT_SUPPORTED_TYPE_HWRM_ASYNC_EVENT
+	__le16	event_id;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DUAL_DATA_RATE_NOT_SUPPORTED_EVENT_ID_ERROR_REPORT 0x45UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DUAL_DATA_RATE_NOT_SUPPORTED_EVENT_ID_LAST        ASYNC_EVENT_CMPL_ERROR_REPORT_DUAL_DATA_RATE_NOT_SUPPORTED_EVENT_ID_ERROR_REPORT
+	__le32	event_data2;
+	u8	opaque_v;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DUAL_DATA_RATE_NOT_SUPPORTED_V          0x1UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DUAL_DATA_RATE_NOT_SUPPORTED_OPAQUE_MASK 0xfeUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DUAL_DATA_RATE_NOT_SUPPORTED_OPAQUE_SFT 1
+	u8	timestamp_lo;
+	__le16	timestamp_hi;
+	__le32	event_data1;
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DUAL_DATA_RATE_NOT_SUPPORTED_EVENT_DATA1_ERROR_TYPE_MASK                        0xffUL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DUAL_DATA_RATE_NOT_SUPPORTED_EVENT_DATA1_ERROR_TYPE_SFT                         0
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DUAL_DATA_RATE_NOT_SUPPORTED_EVENT_DATA1_ERROR_TYPE_DUAL_DATA_RATE_NOT_SUPPORTED  0x6UL
+	#define ASYNC_EVENT_CMPL_ERROR_REPORT_DUAL_DATA_RATE_NOT_SUPPORTED_EVENT_DATA1_ERROR_TYPE_LAST                         ASYNC_EVENT_CMPL_ERROR_REPORT_DUAL_DATA_RATE_NOT_SUPPORTED_EVENT_DATA1_ERROR_TYPE_DUAL_DATA_RATE_NOT_SUPPORTED
+};
+
 /* hwrm_func_reset_input (size:192b/24B) */
 struct hwrm_func_reset_input {
 	__le16	req_type;
@@ -1781,6 +1811,9 @@ struct hwrm_func_qcaps_output {
 	#define FUNC_QCAPS_RESP_FLAGS_EXT2_ROCE_VF_RESOURCE_MGMT_SUPPORTED       0x100000UL
 	#define FUNC_QCAPS_RESP_FLAGS_EXT2_UDCC_SUPPORTED                        0x200000UL
 	#define FUNC_QCAPS_RESP_FLAGS_EXT2_TIMED_TX_SO_TXTIME_SUPPORTED          0x400000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_SW_MAX_RESOURCE_LIMITS_SUPPORTED      0x800000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_TF_INGRESS_NIC_FLOW_SUPPORTED         0x1000000UL
+	#define FUNC_QCAPS_RESP_FLAGS_EXT2_LPBK_STATS_SUPPORTED                  0x2000000UL
 	__le16	tunnel_disable_flag;
 	#define FUNC_QCAPS_RESP_TUNNEL_DISABLE_FLAG_DISABLE_VXLAN      0x1UL
 	#define FUNC_QCAPS_RESP_TUNNEL_DISABLE_FLAG_DISABLE_NGE        0x2UL
@@ -1791,10 +1824,8 @@ struct hwrm_func_qcaps_output {
 	#define FUNC_QCAPS_RESP_TUNNEL_DISABLE_FLAG_DISABLE_MPLS       0x40UL
 	#define FUNC_QCAPS_RESP_TUNNEL_DISABLE_FLAG_DISABLE_PPPOE      0x80UL
 	__le16	xid_partition_cap;
-	#define FUNC_QCAPS_RESP_XID_PARTITION_CAP_KTLS_TKC     0x1UL
-	#define FUNC_QCAPS_RESP_XID_PARTITION_CAP_KTLS_RKC     0x2UL
-	#define FUNC_QCAPS_RESP_XID_PARTITION_CAP_QUIC_TKC     0x4UL
-	#define FUNC_QCAPS_RESP_XID_PARTITION_CAP_QUIC_RKC     0x8UL
+	#define FUNC_QCAPS_RESP_XID_PARTITION_CAP_TX_CK     0x1UL
+	#define FUNC_QCAPS_RESP_XID_PARTITION_CAP_RX_CK     0x2UL
 	u8	device_serial_number[8];
 	__le16	ctxs_per_partition;
 	u8	unused_2[2];
@@ -1844,6 +1875,7 @@ struct hwrm_func_qcfg_output {
 	#define FUNC_QCFG_RESP_FLAGS_FAST_RESET_ALLOWED           0x1000UL
 	#define FUNC_QCFG_RESP_FLAGS_MULTI_ROOT                   0x2000UL
 	#define FUNC_QCFG_RESP_FLAGS_ENABLE_RDMA_SRIOV            0x4000UL
+	#define FUNC_QCFG_RESP_FLAGS_ROCE_VNIC_ID_VALID           0x8000UL
 	u8	mac_address[6];
 	__le16	pci_id;
 	__le16	alloc_rsscos_ctx;
@@ -1955,7 +1987,7 @@ struct hwrm_func_qcfg_output {
 	#define FUNC_QCFG_RESP_DB_PAGE_SIZE_2MB   0x9UL
 	#define FUNC_QCFG_RESP_DB_PAGE_SIZE_4MB   0xaUL
 	#define FUNC_QCFG_RESP_DB_PAGE_SIZE_LAST FUNC_QCFG_RESP_DB_PAGE_SIZE_4MB
-	u8	unused_2[2];
+	__le16	roce_vnic_id;
 	__le32	partition_min_bw;
 	#define FUNC_QCFG_RESP_PARTITION_MIN_BW_BW_VALUE_MASK             0xfffffffUL
 	#define FUNC_QCFG_RESP_PARTITION_MIN_BW_BW_VALUE_SFT              0
@@ -2003,6 +2035,8 @@ struct hwrm_func_qcfg_output {
 	__le32	roce_max_srq_per_vf;
 	__le32	roce_max_gid_per_vf;
 	__le16	xid_partition_cfg;
+	#define FUNC_QCFG_RESP_XID_PARTITION_CFG_TX_CK     0x1UL
+	#define FUNC_QCFG_RESP_XID_PARTITION_CFG_RX_CK     0x2UL
 	u8	unused_7;
 	u8	valid;
 };
@@ -2229,10 +2263,8 @@ struct hwrm_func_cfg_input {
 	__le32	roce_max_srq_per_vf;
 	__le32	roce_max_gid_per_vf;
 	__le16	xid_partition_cfg;
-	#define FUNC_CFG_REQ_XID_PARTITION_CFG_KTLS_TKC     0x1UL
-	#define FUNC_CFG_REQ_XID_PARTITION_CFG_KTLS_RKC     0x2UL
-	#define FUNC_CFG_REQ_XID_PARTITION_CFG_QUIC_TKC     0x4UL
-	#define FUNC_CFG_REQ_XID_PARTITION_CFG_QUIC_RKC     0x8UL
+	#define FUNC_CFG_REQ_XID_PARTITION_CFG_TX_CK     0x1UL
+	#define FUNC_CFG_REQ_XID_PARTITION_CFG_RX_CK     0x2UL
 	__le16	unused_2;
 };
 
@@ -2416,6 +2448,7 @@ struct hwrm_func_drv_rgtr_input {
 	#define FUNC_DRV_RGTR_REQ_FLAGS_RSS_STRICT_HASH_TYPE_SUPPORT     0x100UL
 	#define FUNC_DRV_RGTR_REQ_FLAGS_NPAR_1_2_SUPPORT                 0x200UL
 	#define FUNC_DRV_RGTR_REQ_FLAGS_ASYM_QUEUE_CFG_SUPPORT           0x400UL
+	#define FUNC_DRV_RGTR_REQ_FLAGS_TF_INGRESS_NIC_FLOW_MODE         0x800UL
 	__le32	enables;
 	#define FUNC_DRV_RGTR_REQ_ENABLES_OS_TYPE             0x1UL
 	#define FUNC_DRV_RGTR_REQ_ENABLES_VER                 0x2UL
@@ -3636,19 +3669,22 @@ struct hwrm_func_backing_store_cfg_v2_input {
 	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_FP_TQM_RING   0x6UL
 	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_MRAV          0xeUL
 	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_TIM           0xfUL
-	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_TKC           0x13UL
-	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_RKC           0x14UL
 	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_MP_TQM_RING   0x15UL
 	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_SQ_DB_SHADOW  0x16UL
 	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_RQ_DB_SHADOW  0x17UL
 	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_SRQ_DB_SHADOW 0x18UL
 	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_CQ_DB_SHADOW  0x19UL
-	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_QUIC_TKC      0x1aUL
-	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_QUIC_RKC      0x1bUL
 	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_TBL_SCOPE     0x1cUL
 	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_XID_PARTITION 0x1dUL
-	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_INVALID       0xffffUL
-	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_LAST         FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_INVALID
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_SRT_TRACE       0x1eUL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_SRT2_TRACE      0x1fUL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_CRT_TRACE       0x20UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_CRT2_TRACE      0x21UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_RIGP0_TRACE     0x22UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_L2_HWRM_TRACE   0x23UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_ROCE_HWRM_TRACE 0x24UL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_INVALID         0xffffUL
+	#define FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_LAST           FUNC_BACKING_STORE_CFG_V2_REQ_TYPE_INVALID
 	__le16	instance;
 	__le32	flags;
 	#define FUNC_BACKING_STORE_CFG_V2_REQ_FLAGS_PREBOOT_MODE        0x1UL
@@ -3707,17 +3743,22 @@ struct hwrm_func_backing_store_qcfg_v2_input {
 	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_FP_TQM_RING         0x6UL
 	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_MRAV                0xeUL
 	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_TIM                 0xfUL
-	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_TKC                 0x13UL
-	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_RKC                 0x14UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_TX_CK               0x13UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_RX_CK               0x14UL
 	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_MP_TQM_RING         0x15UL
 	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_SQ_DB_SHADOW        0x16UL
 	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_RQ_DB_SHADOW        0x17UL
 	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_SRQ_DB_SHADOW       0x18UL
 	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_CQ_DB_SHADOW        0x19UL
-	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_QUIC_TKC            0x1aUL
-	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_QUIC_RKC            0x1bUL
 	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_TBL_SCOPE           0x1cUL
 	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_XID_PARTITION_TABLE 0x1dUL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_SRT_TRACE           0x1eUL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_SRT2_TRACE          0x1fUL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_CRT_TRACE           0x20UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_CRT2_TRACE          0x21UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_RIGP0_TRACE         0x22UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_L2_HWRM_TRACE       0x23UL
+	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_ROCE_HWRM_TRACE     0x24UL
 	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_INVALID             0xffffUL
 	#define FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_LAST               FUNC_BACKING_STORE_QCFG_V2_REQ_TYPE_INVALID
 	__le16	instance;
@@ -3740,15 +3781,18 @@ struct hwrm_func_backing_store_qcfg_v2_output {
 	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_FP_TQM_RING   0x6UL
 	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_MRAV          0xeUL
 	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_TIM           0xfUL
-	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_TKC           0x13UL
-	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_RKC           0x14UL
 	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_MP_TQM_RING   0x15UL
-	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_QUIC_TKC      0x1aUL
-	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_QUIC_RKC      0x1bUL
 	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_TBL_SCOPE     0x1cUL
 	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_XID_PARTITION 0x1dUL
-	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_INVALID       0xffffUL
-	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_LAST         FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_INVALID
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_SRT_TRACE       0x1eUL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_SRT2_TRACE      0x1fUL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_CRT_TRACE       0x20UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_CRT2_TRACE      0x21UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_RIGP0_TRACE     0x22UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_L2_HWRM_TRACE   0x23UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_ROCE_HWRM_TRACE 0x24UL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_INVALID         0xffffUL
+	#define FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_LAST           FUNC_BACKING_STORE_QCFG_V2_RESP_TYPE_INVALID
 	__le16	instance;
 	__le32	flags;
 	__le64	page_dir;
@@ -3841,19 +3885,22 @@ struct hwrm_func_backing_store_qcaps_v2_input {
 	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_FP_TQM_RING   0x6UL
 	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_MRAV          0xeUL
 	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_TIM           0xfUL
-	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_KTLS_TKC      0x13UL
-	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_KTLS_RKC      0x14UL
 	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_MP_TQM_RING   0x15UL
 	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_SQ_DB_SHADOW  0x16UL
 	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_RQ_DB_SHADOW  0x17UL
 	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_SRQ_DB_SHADOW 0x18UL
 	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_CQ_DB_SHADOW  0x19UL
-	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_QUIC_TKC      0x1aUL
-	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_QUIC_RKC      0x1bUL
 	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_TBL_SCOPE     0x1cUL
 	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_XID_PARTITION 0x1dUL
-	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_INVALID       0xffffUL
-	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_LAST         FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_INVALID
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_SRT_TRACE       0x1eUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_SRT2_TRACE      0x1fUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_CRT_TRACE       0x20UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_CRT2_TRACE      0x21UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_RIGP0_TRACE     0x22UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_L2_HWRM_TRACE   0x23UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_ROCE_HWRM_TRACE 0x24UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_INVALID         0xffffUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_LAST           FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_INVALID
 	u8	rsvd[6];
 };
 
@@ -3873,19 +3920,22 @@ struct hwrm_func_backing_store_qcaps_v2_output {
 	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_FP_TQM_RING   0x6UL
 	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_MRAV          0xeUL
 	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_TIM           0xfUL
-	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_KTLS_TKC      0x13UL
-	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_KTLS_RKC      0x14UL
 	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_MP_TQM_RING   0x15UL
 	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_SQ_DB_SHADOW  0x16UL
 	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_RQ_DB_SHADOW  0x17UL
 	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_SRQ_DB_SHADOW 0x18UL
 	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_CQ_DB_SHADOW  0x19UL
-	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_QUIC_TKC      0x1aUL
-	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_QUIC_RKC      0x1bUL
 	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_TBL_SCOPE     0x1cUL
 	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_XID_PARTITION 0x1dUL
-	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_INVALID       0xffffUL
-	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_LAST         FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_INVALID
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_SRT_TRACE       0x1eUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_SRT2_TRACE      0x1fUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_CRT_TRACE       0x20UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_CRT2_TRACE      0x21UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_RIGP0_TRACE     0x22UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_L2_HWRM_TRACE   0x23UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_ROCE_HWRM_TRACE 0x24UL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_INVALID         0xffffUL
+	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_LAST           FUNC_BACKING_STORE_QCAPS_V2_RESP_TYPE_INVALID
 	__le16	entry_size;
 	__le32	flags;
 	#define FUNC_BACKING_STORE_QCAPS_V2_RESP_FLAGS_ENABLE_CTX_KIND_INIT            0x1UL
@@ -3990,6 +4040,7 @@ struct hwrm_func_drv_if_change_output {
 	__le32	flags;
 	#define FUNC_DRV_IF_CHANGE_RESP_FLAGS_RESC_CHANGE           0x1UL
 	#define FUNC_DRV_IF_CHANGE_RESP_FLAGS_HOT_FW_RESET_DONE     0x2UL
+	#define FUNC_DRV_IF_CHANGE_RESP_FLAGS_CAPS_CHANGE           0x4UL
 	u8	unused_0[3];
 	u8	valid;
 };
@@ -4472,7 +4523,11 @@ struct hwrm_port_phy_qcfg_output {
 	#define PORT_PHY_QCFG_RESP_XCVR_IDENTIFIER_TYPE_QSFP      (0xcUL << 24)
 	#define PORT_PHY_QCFG_RESP_XCVR_IDENTIFIER_TYPE_QSFPPLUS  (0xdUL << 24)
 	#define PORT_PHY_QCFG_RESP_XCVR_IDENTIFIER_TYPE_QSFP28    (0x11UL << 24)
-	#define PORT_PHY_QCFG_RESP_XCVR_IDENTIFIER_TYPE_LAST     PORT_PHY_QCFG_RESP_XCVR_IDENTIFIER_TYPE_QSFP28
+	#define PORT_PHY_QCFG_RESP_XCVR_IDENTIFIER_TYPE_QSFPDD    (0x18UL << 24)
+	#define PORT_PHY_QCFG_RESP_XCVR_IDENTIFIER_TYPE_QSFP112   (0x1eUL << 24)
+	#define PORT_PHY_QCFG_RESP_XCVR_IDENTIFIER_TYPE_SFPDD     (0x1fUL << 24)
+	#define PORT_PHY_QCFG_RESP_XCVR_IDENTIFIER_TYPE_CSFP      (0x20UL << 24)
+	#define PORT_PHY_QCFG_RESP_XCVR_IDENTIFIER_TYPE_LAST     PORT_PHY_QCFG_RESP_XCVR_IDENTIFIER_TYPE_CSFP
 	__le16	fec_cfg;
 	#define PORT_PHY_QCFG_RESP_FEC_CFG_FEC_NONE_SUPPORTED           0x1UL
 	#define PORT_PHY_QCFG_RESP_FEC_CFG_FEC_AUTONEG_SUPPORTED        0x2UL
@@ -7380,7 +7435,7 @@ struct hwrm_cfa_l2_filter_free_output {
 	u8	valid;
 };
 
-/* hwrm_cfa_l2_filter_cfg_input (size:320b/40B) */
+/* hwrm_cfa_l2_filter_cfg_input (size:384b/48B) */
 struct hwrm_cfa_l2_filter_cfg_input {
 	__le16	req_type;
 	__le16	cmpl_ring;
@@ -7399,12 +7454,22 @@ struct hwrm_cfa_l2_filter_cfg_input {
 	#define CFA_L2_FILTER_CFG_REQ_FLAGS_TRAFFIC_L2          (0x1UL << 2)
 	#define CFA_L2_FILTER_CFG_REQ_FLAGS_TRAFFIC_ROCE        (0x2UL << 2)
 	#define CFA_L2_FILTER_CFG_REQ_FLAGS_TRAFFIC_LAST       CFA_L2_FILTER_CFG_REQ_FLAGS_TRAFFIC_ROCE
+	#define CFA_L2_FILTER_CFG_REQ_FLAGS_REMAP_OP_MASK       0x30UL
+	#define CFA_L2_FILTER_CFG_REQ_FLAGS_REMAP_OP_SFT        4
+	#define CFA_L2_FILTER_CFG_REQ_FLAGS_REMAP_OP_NO_UPDATE    (0x0UL << 4)
+	#define CFA_L2_FILTER_CFG_REQ_FLAGS_REMAP_OP_BYPASS_LKUP  (0x1UL << 4)
+	#define CFA_L2_FILTER_CFG_REQ_FLAGS_REMAP_OP_ENABLE_LKUP  (0x2UL << 4)
+	#define CFA_L2_FILTER_CFG_REQ_FLAGS_REMAP_OP_LAST        CFA_L2_FILTER_CFG_REQ_FLAGS_REMAP_OP_ENABLE_LKUP
 	__le32	enables;
 	#define CFA_L2_FILTER_CFG_REQ_ENABLES_DST_ID                 0x1UL
 	#define CFA_L2_FILTER_CFG_REQ_ENABLES_NEW_MIRROR_VNIC_ID     0x2UL
+	#define CFA_L2_FILTER_CFG_REQ_ENABLES_PROF_FUNC              0x4UL
+	#define CFA_L2_FILTER_CFG_REQ_ENABLES_L2_CONTEXT_ID          0x8UL
 	__le64	l2_filter_id;
 	__le32	dst_id;
 	__le32	new_mirror_vnic_id;
+	__le32	prof_func;
+	__le32	l2_context_id;
 };
 
 /* hwrm_cfa_l2_filter_cfg_output (size:128b/16B) */
@@ -8466,7 +8531,15 @@ struct hwrm_tunnel_dst_port_query_input {
 	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_SRV6         0xfUL
 	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_VXLAN_GPE    0x10UL
 	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_GRE          0x11UL
-	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_LAST        TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_GRE
+	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_ULP_DYN_UPAR       0x12UL
+	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES01 0x13UL
+	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES02 0x14UL
+	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES03 0x15UL
+	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES04 0x16UL
+	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES05 0x17UL
+	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES06 0x18UL
+	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES07 0x19UL
+	#define TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_LAST              TUNNEL_DST_PORT_QUERY_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES07
 	u8	tunnel_next_proto;
 	u8	unused_0[6];
 };
@@ -8514,7 +8587,15 @@ struct hwrm_tunnel_dst_port_alloc_input {
 	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_SRV6         0xfUL
 	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_VXLAN_GPE    0x10UL
 	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_GRE          0x11UL
-	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_LAST        TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_GRE
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_ULP_DYN_UPAR       0x12UL
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES01 0x13UL
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES02 0x14UL
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES03 0x15UL
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES04 0x16UL
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES05 0x17UL
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES06 0x18UL
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES07 0x19UL
+	#define TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_LAST              TUNNEL_DST_PORT_ALLOC_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES07
 	u8	tunnel_next_proto;
 	__be16	tunnel_dst_port_val;
 	u8	unused_0[4];
@@ -8565,7 +8646,15 @@ struct hwrm_tunnel_dst_port_free_input {
 	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_SRV6         0xfUL
 	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_VXLAN_GPE    0x10UL
 	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_GRE          0x11UL
-	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_LAST        TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_GRE
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_ULP_DYN_UPAR       0x12UL
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES01 0x13UL
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES02 0x14UL
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES03 0x15UL
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES04 0x16UL
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES05 0x17UL
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES06 0x18UL
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES07 0x19UL
+	#define TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_LAST              TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_ULP_DYN_UPAR_RES07
 	u8	tunnel_next_proto;
 	__le16	tunnel_dst_port_id;
 	u8	unused_0[4];
@@ -8860,7 +8949,7 @@ struct hwrm_stat_generic_qstats_output {
 	u8	valid;
 };
 
-/* generic_sw_hw_stats (size:1408b/176B) */
+/* generic_sw_hw_stats (size:1472b/184B) */
 struct generic_sw_hw_stats {
 	__le64	pcie_statistics_tx_tlp;
 	__le64	pcie_statistics_rx_tlp;
@@ -8884,6 +8973,7 @@ struct generic_sw_hw_stats {
 	__le64	hw_db_recov_dbs_dropped;
 	__le64	hw_db_recov_drops_serviced;
 	__le64	hw_db_recov_dbs_recovered;
+	__le64	hw_db_recov_oo_drop_count;
 };
 
 /* hwrm_fw_reset_input (size:192b/24B) */
-- 
2.39.1


--0000000000000e8e6f061500f493
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OltyqaGBuzv+bJTUL+bmV7E4QBLIqGt4jVr1R9hJdH6KxXwJdyfHZ9C6qXmoe2NQhiFUyBOJ0wgk
dB9Z1IU7nCwvNKYg2JMoJs93tIgbhPJg/D7pqW8gabkCAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUEV6y/89alKPoFbKUaJXsvWu5
fdowDQYJKoZIhvcNAQELBQADggEBAEHSIB6g652wVb+r2YCmfHW47Jo+5TuCBD99Hla8PYhaWGkd
9HIyD3NPhb6Vb6vtMWJW4MFGQF42xYRrAS4LZj072DuMotr79rI09pbOiWg0FlRRFt6R9vgUgebu
pWSH7kmwVXcPtY94XSMMak4b7RSKig2mKbHDpD4bC7eGlwl5RxzYkgrHtMNRmHmQor5Nvqe52cFJ
25Azqtwvjt5nbrEd81iBmboNTEnLaKuxbbCtLaMEP8xKeDjAKnNOqHUMps0AsQT8c0EGq39YHpjp
Wn1l67VU0rMShbEFsiUf9WYgE677oinpdm0t2mdCjxr35tryxptoTZXKHDxr/Yy6l6ExggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwV/XkICjVscn4SNZMw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIG8mGLVssQR+G/WhfnMaNGJ3Kt5xwmHE
7zDORdsxOuGHMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDQw
MTAzNTQ1OVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCfww6BP0qsTH0dSZkLWx8GXMxiqz32P7U753SoUoN7K4OLenWk
pgDxsCreL/NjzkVXklYJxZ7gzWBUsA+f7qhu0EJ0KVWMxjFTApUx7LQ7/X/+IWmeVbMnA+eU+Xgo
JddqFYTtVTC0U9pM+hslvlodEW5K7PfvpE0dwKuoZp6hStu/mkAJ2J8Ng69YPfDeLAI64atnRRkO
gCVe2eJWwJEBnbK7YmM/EzxyNPy4KfAJMjbqVB8Y3ctu4pX40faTYGFZxpJZysUxzqlfgXaYieFe
m3tv0V/PTcGFx+DrhHZ+Kynu+CRP8xU/hRD8TZ93HeIedRhUD0vizgihxfeHkPZW
--0000000000000e8e6f061500f493--

