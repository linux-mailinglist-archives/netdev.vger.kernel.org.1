Return-Path: <netdev+bounces-246901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F66CCF2369
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 08:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BA3F3068BDA
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 07:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8712652BD;
	Mon,  5 Jan 2026 07:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bleSNb9j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com [209.85.128.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5EB28750B
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 07:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767597764; cv=none; b=oWSjWwTtXH9OuK3UFzc0FrMWMvXB/Nvqfde0hcS61xmBtnxjEBzZiaGms01zxaER8K9ClZg8LgGVcCKmrma5pD5V77LPB4MPgQ+5uYha7IA5JgSb/Bw01gh5Durpt+f59fbYc3S9FolDtwauLk0jBv2Z0scbVNnm+TuVLNlEscQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767597764; c=relaxed/simple;
	bh=DI3G0ojy3hO6OMRcepuZZcIyEDaAmgu93om9PNhnlec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IxnXsslLVeZKdjTyF0guI0UyQ2bq9A6c1QLs4+LOLgspWCx1pLv/nTMJc2I0PCG6u1e//PwcPjmIKncMNRpZJcDakYqYN05+GyJY82RwGivZe0edsZxfhAgjLR4AdzyxDkVl7ahdjbgldb/heJsGCL0whjYunLkcxNqGrvJ7CNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bleSNb9j; arc=none smtp.client-ip=209.85.128.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f228.google.com with SMTP id 00721157ae682-790647da8cbso23361117b3.1
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 23:22:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767597757; x=1768202557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1xUzUYUNLXnQRm0Ur1ULmzBOklSMRNbKcuIZG17nr1A=;
        b=HxebSmkBErWXjyoCKMyaMVZrIY5iLE4zYw4osy9J5LJoe4U4KJ1HQtsuATnm1JqdOO
         Wq3Ug0hNwSb7e12wVPDQc8b/BmXBt05Uc2aV+iAOvB2fq2WoSSffkP3bQEZFLLS1FW3X
         UG3F4xpBb6T1jJC750krSfh9Lh1jrc0b8BFoKxQ+uwXpS/xaJxDD27PoH1Oqr4aJIIAk
         UQX7bFoVuCpDJDGLXKSKvOL4zUjRTdnwKJod87qdow9FQBFWYYXfvCHkb9rz5wX58aJ9
         50thZpLr07I+AERmwErovG4+IJn11Ustj3UkgibC1ORbc2H+aGhTpF0mQkH6N4BfVeD6
         iCSw==
X-Gm-Message-State: AOJu0YwyoVlX4xgfwW+EgYGy1k7t3y7ZtJGeKhYkNQm4gFMwQmIG4i+D
	WbfD3vTvyZpSYGJyR8tVsM9jTXPtDumVAy+9vFdZ8HH3I6HnUdz+G6bfca+tYKyhW+RzWQQpBRh
	DcchWhFRFPXB3fuImikeR+GDULQodj9U5dJ5e8D2urxjPnrb+3NeJZRfcV7lqJDmqIUbBV38tiz
	rOzAUcVcum+ZYos34bbWUtRvuf/0QoJvRgpGpFw7JlVEDnwIavgCPYSnfLBLOVNalEisN+Ynuap
	hcPdhrMGApihDaMQXVR
X-Gm-Gg: AY/fxX4pZPTtRWP2OBtUgYycpoE3+tFCwkYsM4Zg5d6XCcKmM/RJsXyhTto4vQ8mdOk
	Uvd6vkNRHFwmXV7ouUow/6ewDj6+Mv/U9srn84FhBuHoDQaJQFgY44iq8L8XW8S6HNsepACXmWe
	y658yEEXGAJZmhKmzmC9OGgpEeystrEgOpxdtKhKd6t46ZUdXoGLuom6MvTCj8vuNt7SgiI+3aV
	FK93okhXHDBalDEgXffQ7trEtgxXa3xXz+Cqg4tJCcZFYtGgfi5PlB9wFRU+lB2BRAzanN5EO9A
	x1GDnTdjB+3VpMALxYwxZrFJ7FbeATaLkkx4YpsVCatdAlZAdzjOIksL7/Hfm8MA6Cirt7P4fyL
	7Aj4qOaNiGwrpda7zbBThtk/gnchhZ/ommLm1U4ATJI00D7HuYYNog29N5y68HPPw6WUMprMPYb
	+gzaNZ60sutfvZs/+EfdDmKWSzeyVGzUO3N7EbltChDQSPGkpUFic3mQ==
X-Google-Smtp-Source: AGHT+IEeQFa/9Ds7TAjKE19+DKpnJySuCwR9AfI23gzYB5Ne+Eck1cKBVACrpIzBemzSlxaQYjc8EER+wbe2
X-Received: by 2002:a05:690c:c83:b0:78c:6a2b:c6aa with SMTP id 00721157ae682-78fb4067fb2mr489294967b3.58.1767597757473;
        Sun, 04 Jan 2026 23:22:37 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-78fc64f3ab6sm23635937b3.15.2026.01.04.23.22.37
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Jan 2026 23:22:37 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7f046e16d50so23877033b3a.3
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 23:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767597756; x=1768202556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xUzUYUNLXnQRm0Ur1ULmzBOklSMRNbKcuIZG17nr1A=;
        b=bleSNb9jqZGy/mMDKOUClKrcknJIexa+m3DXHQkwxJ6iaCbvOPHMgkld1MDoGMWzVd
         GIAKqHdhBcQ8eWONlOzGuIZDt9IKiD2BmwYb+YKo2CN0C3lmMFWmf0tpOi7GJmsQgYc5
         q504UbScmuaw+VTlbkJQdvwODrDSIh0X9bLK4=
X-Received: by 2002:a05:6a00:808c:b0:7f6:2b06:7126 with SMTP id d2e1a72fcca58-7ff6607bcd2mr41797044b3a.39.1767597755678;
        Sun, 04 Jan 2026 23:22:35 -0800 (PST)
X-Received: by 2002:a05:6a00:808c:b0:7f6:2b06:7126 with SMTP id d2e1a72fcca58-7ff6607bcd2mr41797019b3a.39.1767597755120;
        Sun, 04 Jan 2026 23:22:35 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7dfab836sm47293293b3a.36.2026.01.04.23.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 23:22:34 -0800 (PST)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [v4, net-next 2/7] bng_en: Add RX support
Date: Mon,  5 Jan 2026 12:51:38 +0530
Message-ID: <20260105072143.19447-3-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260105072143.19447-1-bhargava.marreddy@broadcom.com>
References: <20260105072143.19447-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Add support to receive packet using NAPI, build and deliver the skb
to stack. With help of meta data available in completions, fill the
appropriate information in skb.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/Makefile   |   3 +-
 .../net/ethernet/broadcom/bnge/bnge_hw_def.h  | 198 ++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 113 +++-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  60 +-
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    | 573 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_txrx.h    |  90 +++
 6 files changed, 1016 insertions(+), 21 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_txrx.h

diff --git a/drivers/net/ethernet/broadcom/bnge/Makefile b/drivers/net/ethernet/broadcom/bnge/Makefile
index ea6596854e5c..fa604ee20264 100644
--- a/drivers/net/ethernet/broadcom/bnge/Makefile
+++ b/drivers/net/ethernet/broadcom/bnge/Makefile
@@ -10,4 +10,5 @@ bng_en-y := bnge_core.o \
 	    bnge_resc.o \
 	    bnge_netdev.o \
 	    bnge_ethtool.o \
-	    bnge_auxr.o
+	    bnge_auxr.o \
+	    bnge_txrx.o
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h b/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
new file mode 100644
index 000000000000..4da4259095fa
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
@@ -0,0 +1,198 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2025 Broadcom */
+
+#ifndef _BNGE_HW_DEF_H_
+#define _BNGE_HW_DEF_H_
+
+struct tx_bd_ext {
+	__le32 tx_bd_hsize_lflags;
+	#define TX_BD_FLAGS_TCP_UDP_CHKSUM			(1 << 0)
+	#define TX_BD_FLAGS_IP_CKSUM				(1 << 1)
+	#define TX_BD_FLAGS_NO_CRC				(1 << 2)
+	#define TX_BD_FLAGS_STAMP				(1 << 3)
+	#define TX_BD_FLAGS_T_IP_CHKSUM				(1 << 4)
+	#define TX_BD_FLAGS_LSO					(1 << 5)
+	#define TX_BD_FLAGS_IPID_FMT				(1 << 6)
+	#define TX_BD_FLAGS_T_IPID				(1 << 7)
+	#define TX_BD_HSIZE					(0xff << 16)
+	 #define TX_BD_HSIZE_SHIFT				 16
+
+	__le32 tx_bd_mss;
+	__le32 tx_bd_cfa_action;
+	#define TX_BD_CFA_ACTION				(0xffff << 16)
+	 #define TX_BD_CFA_ACTION_SHIFT				 16
+
+	__le32 tx_bd_cfa_meta;
+	#define TX_BD_CFA_META_MASK                             0xfffffff
+	#define TX_BD_CFA_META_VID_MASK                         0xfff
+	#define TX_BD_CFA_META_PRI_MASK                         (0xf << 12)
+	 #define TX_BD_CFA_META_PRI_SHIFT                        12
+	#define TX_BD_CFA_META_TPID_MASK                        (3 << 16)
+	 #define TX_BD_CFA_META_TPID_SHIFT                       16
+	#define TX_BD_CFA_META_KEY                              (0xf << 28)
+	 #define TX_BD_CFA_META_KEY_SHIFT			 28
+	#define TX_BD_CFA_META_KEY_VLAN                         (1 << 28)
+};
+
+#define TX_CMP_SQ_CONS_IDX(txcmp)					\
+	(le32_to_cpu((txcmp)->sq_cons_idx) & TX_CMP_SQ_CONS_IDX_MASK)
+
+struct rx_cmp {
+	__le32 rx_cmp_len_flags_type;
+	#define RX_CMP_CMP_TYPE					(0x3f << 0)
+	#define RX_CMP_FLAGS_ERROR				(1 << 6)
+	#define RX_CMP_FLAGS_PLACEMENT				(7 << 7)
+	#define RX_CMP_FLAGS_RSS_VALID				(1 << 10)
+	#define RX_CMP_FLAGS_PKT_METADATA_PRESENT		(1 << 11)
+	 #define RX_CMP_FLAGS_ITYPES_SHIFT			 12
+	 #define RX_CMP_FLAGS_ITYPES_MASK			 0xf000
+	 #define RX_CMP_FLAGS_ITYPE_UNKNOWN			 (0 << 12)
+	 #define RX_CMP_FLAGS_ITYPE_IP				 (1 << 12)
+	 #define RX_CMP_FLAGS_ITYPE_TCP				 (2 << 12)
+	 #define RX_CMP_FLAGS_ITYPE_UDP				 (3 << 12)
+	 #define RX_CMP_FLAGS_ITYPE_FCOE			 (4 << 12)
+	 #define RX_CMP_FLAGS_ITYPE_ROCE			 (5 << 12)
+	 #define RX_CMP_FLAGS_ITYPE_PTP_WO_TS			 (8 << 12)
+	 #define RX_CMP_FLAGS_ITYPE_PTP_W_TS			 (9 << 12)
+	#define RX_CMP_LEN					(0xffff << 16)
+	 #define RX_CMP_LEN_SHIFT				 16
+
+	u32 rx_cmp_opaque;
+	__le32 rx_cmp_misc_v1;
+	#define RX_CMP_V1					(1 << 0)
+	#define RX_CMP_AGG_BUFS					(0x1f << 1)
+	 #define RX_CMP_AGG_BUFS_SHIFT				 1
+	#define RX_CMP_RSS_HASH_TYPE				(0x7f << 9)
+	 #define RX_CMP_RSS_HASH_TYPE_SHIFT			 9
+	#define RX_CMP_V3_RSS_EXT_OP_LEGACY			(0xf << 12)
+	 #define RX_CMP_V3_RSS_EXT_OP_LEGACY_SHIFT		 12
+	#define RX_CMP_V3_RSS_EXT_OP_NEW			(0xf << 8)
+	 #define RX_CMP_V3_RSS_EXT_OP_NEW_SHIFT			 8
+	#define RX_CMP_PAYLOAD_OFFSET				(0xff << 16)
+	 #define RX_CMP_PAYLOAD_OFFSET_SHIFT			 16
+	#define RX_CMP_SUB_NS_TS				(0xf << 16)
+	 #define RX_CMP_SUB_NS_TS_SHIFT				 16
+	#define RX_CMP_METADATA1				(0xf << 28)
+	 #define RX_CMP_METADATA1_SHIFT				 28
+	#define RX_CMP_METADATA1_TPID_SEL			(0x7 << 28)
+	#define RX_CMP_METADATA1_TPID_8021Q			(0x1 << 28)
+	#define RX_CMP_METADATA1_TPID_8021AD			(0x0 << 28)
+	#define RX_CMP_METADATA1_VALID				(0x8 << 28)
+
+	__le32 rx_cmp_rss_hash;
+};
+
+struct rx_cmp_ext {
+	__le32 rx_cmp_flags2;
+	#define RX_CMP_FLAGS2_IP_CS_CALC			0x1
+	#define RX_CMP_FLAGS2_L4_CS_CALC			(0x1 << 1)
+	#define RX_CMP_FLAGS2_T_IP_CS_CALC			(0x1 << 2)
+	#define RX_CMP_FLAGS2_T_L4_CS_CALC			(0x1 << 3)
+	#define RX_CMP_FLAGS2_META_FORMAT_VLAN			(0x1 << 4)
+	__le32 rx_cmp_meta_data;
+	#define RX_CMP_FLAGS2_METADATA_TCI_MASK			0xffff
+	#define RX_CMP_FLAGS2_METADATA_VID_MASK			0xfff
+	#define RX_CMP_FLAGS2_METADATA_TPID_MASK		0xffff0000
+	 #define RX_CMP_FLAGS2_METADATA_TPID_SFT		 16
+	__le32 rx_cmp_cfa_code_errors_v2;
+	#define RX_CMP_V					(1 << 0)
+	#define RX_CMPL_ERRORS_MASK				(0x7fff << 1)
+	 #define RX_CMPL_ERRORS_SFT				 1
+	#define RX_CMPL_ERRORS_BUFFER_ERROR_MASK		(0x7 << 1)
+	 #define RX_CMPL_ERRORS_BUFFER_ERROR_NO_BUFFER		 (0x0 << 1)
+	 #define RX_CMPL_ERRORS_BUFFER_ERROR_DID_NOT_FIT	 (0x1 << 1)
+	 #define RX_CMPL_ERRORS_BUFFER_ERROR_NOT_ON_CHIP	 (0x2 << 1)
+	 #define RX_CMPL_ERRORS_BUFFER_ERROR_BAD_FORMAT		 (0x3 << 1)
+	#define RX_CMPL_ERRORS_IP_CS_ERROR			(0x1 << 4)
+	#define RX_CMPL_ERRORS_L4_CS_ERROR			(0x1 << 5)
+	#define RX_CMPL_ERRORS_T_IP_CS_ERROR			(0x1 << 6)
+	#define RX_CMPL_ERRORS_T_L4_CS_ERROR			(0x1 << 7)
+	#define RX_CMPL_ERRORS_CRC_ERROR			(0x1 << 8)
+	#define RX_CMPL_ERRORS_T_PKT_ERROR_MASK			(0x7 << 9)
+	 #define RX_CMPL_ERRORS_T_PKT_ERROR_NO_ERROR		 (0x0 << 9)
+	 #define RX_CMPL_ERRORS_T_PKT_ERROR_T_L3_BAD_VERSION	 (0x1 << 9)
+	 #define RX_CMPL_ERRORS_T_PKT_ERROR_T_L3_BAD_HDR_LEN	 (0x2 << 9)
+	 #define RX_CMPL_ERRORS_T_PKT_ERROR_TUNNEL_TOTAL_ERROR	 (0x3 << 9)
+	 #define RX_CMPL_ERRORS_T_PKT_ERROR_T_IP_TOTAL_ERROR	 (0x4 << 9)
+	 #define RX_CMPL_ERRORS_T_PKT_ERROR_T_UDP_TOTAL_ERROR	 (0x5 << 9)
+	 #define RX_CMPL_ERRORS_T_PKT_ERROR_T_L3_BAD_TTL	 (0x6 << 9)
+	#define RX_CMPL_ERRORS_PKT_ERROR_MASK			(0xf << 12)
+	 #define RX_CMPL_ERRORS_PKT_ERROR_NO_ERROR		 (0x0 << 12)
+	 #define RX_CMPL_ERRORS_PKT_ERROR_L3_BAD_VERSION	 (0x1 << 12)
+	 #define RX_CMPL_ERRORS_PKT_ERROR_L3_BAD_HDR_LEN	 (0x2 << 12)
+	 #define RX_CMPL_ERRORS_PKT_ERROR_L3_BAD_TTL		 (0x3 << 12)
+	 #define RX_CMPL_ERRORS_PKT_ERROR_IP_TOTAL_ERROR	 (0x4 << 12)
+	 #define RX_CMPL_ERRORS_PKT_ERROR_UDP_TOTAL_ERROR	 (0x5 << 12)
+	 #define RX_CMPL_ERRORS_PKT_ERROR_L4_BAD_HDR_LEN	 (0x6 << 12)
+	 #define RX_CMPL_ERRORS_PKT_ERROR_L4_BAD_HDR_LEN_TOO_SMALL (0x7 << 12)
+	 #define RX_CMPL_ERRORS_PKT_ERROR_L4_BAD_OPT_LEN	 (0x8 << 12)
+
+	#define RX_CMPL_CFA_CODE_MASK				(0xffff << 16)
+	 #define RX_CMPL_CFA_CODE_SFT				 16
+	#define RX_CMPL_METADATA0_TCI_MASK			(0xffff << 16)
+	#define RX_CMPL_METADATA0_VID_MASK			(0x0fff << 16)
+	 #define RX_CMPL_METADATA0_SFT				 16
+
+	__le32 rx_cmp_timestamp;
+};
+
+#define RX_CMP_L2_ERRORS						\
+	cpu_to_le32(RX_CMPL_ERRORS_BUFFER_ERROR_MASK | RX_CMPL_ERRORS_CRC_ERROR)
+
+#define RX_CMP_L4_CS_BITS						\
+	(cpu_to_le32(RX_CMP_FLAGS2_L4_CS_CALC | RX_CMP_FLAGS2_T_L4_CS_CALC))
+
+#define RX_CMP_L4_CS_ERR_BITS						\
+	(cpu_to_le32(RX_CMPL_ERRORS_L4_CS_ERROR | RX_CMPL_ERRORS_T_L4_CS_ERROR))
+
+#define RX_CMP_L4_CS_OK(rxcmp1)						\
+	    (((rxcmp1)->rx_cmp_flags2 &	RX_CMP_L4_CS_BITS) &&		\
+	     !((rxcmp1)->rx_cmp_cfa_code_errors_v2 & RX_CMP_L4_CS_ERR_BITS))
+
+#define RX_CMP_METADATA0_TCI(rxcmp1)					\
+	((le32_to_cpu((rxcmp1)->rx_cmp_cfa_code_errors_v2) &		\
+	  RX_CMPL_METADATA0_TCI_MASK) >> RX_CMPL_METADATA0_SFT)
+
+#define RX_CMP_ENCAP(rxcmp1)						\
+	    ((le32_to_cpu((rxcmp1)->rx_cmp_flags2) &			\
+	     RX_CMP_FLAGS2_T_L4_CS_CALC) >> 3)
+
+#define RX_CMP_V3_HASH_TYPE_LEGACY(rxcmp)				\
+	((le32_to_cpu((rxcmp)->rx_cmp_misc_v1) &			\
+	  RX_CMP_V3_RSS_EXT_OP_LEGACY) >> RX_CMP_V3_RSS_EXT_OP_LEGACY_SHIFT)
+
+#define RX_CMP_V3_HASH_TYPE_NEW(rxcmp)				\
+	((le32_to_cpu((rxcmp)->rx_cmp_misc_v1) & RX_CMP_V3_RSS_EXT_OP_NEW) >>\
+	 RX_CMP_V3_RSS_EXT_OP_NEW_SHIFT)
+
+#define RX_CMP_V3_HASH_TYPE(bd, rxcmp)				\
+	(((bd)->rss_cap & BNGE_RSS_CAP_RSS_TCAM) ?		\
+	  RX_CMP_V3_HASH_TYPE_NEW(rxcmp) :			\
+	  RX_CMP_V3_HASH_TYPE_LEGACY(rxcmp))
+
+#define EXT_OP_INNER_4		0x0
+#define EXT_OP_OUTER_4		0x2
+#define EXT_OP_INNFL_3		0x8
+#define EXT_OP_OUTFL_3		0xa
+
+#define RX_CMP_VLAN_VALID(rxcmp)				\
+	((rxcmp)->rx_cmp_misc_v1 & cpu_to_le32(RX_CMP_METADATA1_VALID))
+
+#define RX_CMP_VLAN_TPID_SEL(rxcmp)				\
+	(le32_to_cpu((rxcmp)->rx_cmp_misc_v1) & RX_CMP_METADATA1_TPID_SEL)
+
+#define RSS_PROFILE_ID_MASK	0x1f
+
+#define RX_CMP_HASH_TYPE(rxcmp)					\
+	(((le32_to_cpu((rxcmp)->rx_cmp_misc_v1) & RX_CMP_RSS_HASH_TYPE) >>\
+	  RX_CMP_RSS_HASH_TYPE_SHIFT) & RSS_PROFILE_ID_MASK)
+
+#define RX_CMP_HASH_VALID(rxcmp)				\
+	((rxcmp)->rx_cmp_len_flags_type & cpu_to_le32(RX_CMP_FLAGS_RSS_VALID))
+
+#define HWRM_RING_ALLOC_TX	0x1
+#define HWRM_RING_ALLOC_RX	0x2
+#define HWRM_RING_ALLOC_AGG	0x4
+#define HWRM_RING_ALLOC_CMPL	0x8
+#define HWRM_RING_ALLOC_NQ	0x10
+#endif /* _BNGE_HW_DEF_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 8bd019ea55a2..7533c382714e 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -21,6 +21,7 @@
 #include "bnge_hwrm_lib.h"
 #include "bnge_ethtool.h"
 #include "bnge_rmem.h"
+#include "bnge_txrx.h"
 
 #define BNGE_RING_TO_TC_OFF(bd, tx)	\
 	((tx) % (bd)->tx_nr_rings_per_tc)
@@ -857,6 +858,13 @@ u16 bnge_cp_ring_for_tx(struct bnge_tx_ring_info *txr)
 	return txr->tx_cpr->ring_struct.fw_ring_id;
 }
 
+static void bnge_db_nq_arm(struct bnge_net *bn,
+			   struct bnge_db_info *db, u32 idx)
+{
+	bnge_writeq(bn->bd, db->db_key64 | DBR_TYPE_NQ_ARM |
+		    DB_RING_IDX(db, idx), db->doorbell);
+}
+
 static void bnge_db_nq(struct bnge_net *bn, struct bnge_db_info *db, u32 idx)
 {
 	bnge_writeq(bn->bd, db->db_key64 | DBR_TYPE_NQ_MASK |
@@ -879,12 +887,6 @@ static int bnge_cp_num_to_irq_num(struct bnge_net *bn, int n)
 	return nqr->ring_struct.map_idx;
 }
 
-static irqreturn_t bnge_msix(int irq, void *dev_instance)
-{
-	/* NAPI scheduling to be added in a future patch */
-	return IRQ_HANDLED;
-}
-
 static void bnge_init_nq_tree(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
@@ -942,9 +944,8 @@ static u8 *__bnge_alloc_rx_frag(struct bnge_net *bn, dma_addr_t *mapping,
 	return page_address(page) + offset;
 }
 
-static int bnge_alloc_rx_data(struct bnge_net *bn,
-			      struct bnge_rx_ring_info *rxr,
-			      u16 prod, gfp_t gfp)
+int bnge_alloc_rx_data(struct bnge_net *bn, struct bnge_rx_ring_info *rxr,
+		       u16 prod, gfp_t gfp)
 {
 	struct bnge_sw_rx_bd *rx_buf = &rxr->rx_buf_ring[RING_RX(bn, prod)];
 	struct rx_bd *rxbd;
@@ -1756,6 +1757,78 @@ static int bnge_cfg_def_vnic(struct bnge_net *bn)
 	return rc;
 }
 
+static void bnge_disable_int(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i;
+
+	if (!bn->bnapi)
+		return;
+
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		struct bnge_napi *bnapi = bn->bnapi[i];
+		struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;
+		struct bnge_ring_struct *ring = &nqr->ring_struct;
+
+		if (ring->fw_ring_id != INVALID_HW_RING_ID)
+			bnge_db_nq(bn, &nqr->nq_db, nqr->nq_raw_cons);
+	}
+}
+
+static void bnge_disable_int_sync(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i;
+
+	bnge_disable_int(bn);
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		int map_idx = bnge_cp_num_to_irq_num(bn, i);
+
+		synchronize_irq(bd->irq_tbl[map_idx].vector);
+	}
+}
+
+static void bnge_enable_int(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i;
+
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		struct bnge_napi *bnapi = bn->bnapi[i];
+		struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;
+
+		bnge_db_nq_arm(bn, &nqr->nq_db, nqr->nq_raw_cons);
+	}
+}
+
+static void bnge_disable_napi(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i;
+
+	if (test_and_set_bit(BNGE_STATE_NAPI_DISABLED, &bn->state))
+		return;
+
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		struct bnge_napi *bnapi = bn->bnapi[i];
+
+		napi_disable_locked(&bnapi->napi);
+	}
+}
+
+static void bnge_enable_napi(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i;
+
+	clear_bit(BNGE_STATE_NAPI_DISABLED, &bn->state);
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		struct bnge_napi *bnapi = bn->bnapi[i];
+
+		napi_enable_locked(&bnapi->napi);
+	}
+}
+
 static void bnge_hwrm_vnic_free(struct bnge_net *bn)
 {
 	int i;
@@ -1887,6 +1960,12 @@ static void bnge_hwrm_ring_free(struct bnge_net *bn, bool close_path)
 		bnge_hwrm_rx_agg_ring_free(bn, &bn->rx_ring[i], close_path);
 	}
 
+	/* The completion rings are about to be freed.  After that the
+	 * IRQ doorbell will not work anymore.  So we need to disable
+	 * IRQ here.
+	 */
+	bnge_disable_int_sync(bn);
+
 	for (i = 0; i < bd->nq_nr_rings; i++) {
 		struct bnge_napi *bnapi = bn->bnapi[i];
 		struct bnge_nq_ring_info *nqr;
@@ -2086,16 +2165,6 @@ static int bnge_init_chip(struct bnge_net *bn)
 	return rc;
 }
 
-static int bnge_napi_poll(struct napi_struct *napi, int budget)
-{
-	int work_done = 0;
-
-	/* defer NAPI implementation to next patch series */
-	napi_complete_done(napi, work_done);
-
-	return work_done;
-}
-
 static void bnge_init_napi(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
@@ -2193,7 +2262,12 @@ static int bnge_open_core(struct bnge_net *bn)
 		netdev_err(bn->netdev, "bnge_init_nic err: %d\n", rc);
 		goto err_free_irq;
 	}
+
+	bnge_enable_napi(bn);
+
 	set_bit(BNGE_STATE_OPEN, &bd->state);
+
+	bnge_enable_int(bn);
 	return 0;
 
 err_free_irq:
@@ -2236,6 +2310,7 @@ static void bnge_close_core(struct bnge_net *bn)
 
 	clear_bit(BNGE_STATE_OPEN, &bd->state);
 	bnge_shutdown_nic(bn);
+	bnge_disable_napi(bn);
 	bnge_free_all_rings_bufs(bn);
 	bnge_free_irq(bn);
 	bnge_del_napi(bn);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 557cca472db6..04989908b133 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -8,6 +8,7 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/refcount.h>
 #include "bnge_db.h"
+#include "bnge_hw_def.h"
 
 struct tx_bd {
 	__le32 tx_bd_len_flags_type;
@@ -173,10 +174,16 @@ enum {
 #define RING_RX_AGG(bn, idx)	((idx) & (bn)->rx_agg_ring_mask)
 #define NEXT_RX_AGG(idx)	((idx) + 1)
 
+#define BNGE_NQ_HDL_IDX_MASK	0x00ffffff
+#define BNGE_NQ_HDL_TYPE_MASK	0xff000000
 #define BNGE_NQ_HDL_TYPE_SHIFT	24
 #define BNGE_NQ_HDL_TYPE_RX	0x00
 #define BNGE_NQ_HDL_TYPE_TX	0x01
 
+#define BNGE_NQ_HDL_IDX(hdl)	((hdl) & BNGE_NQ_HDL_IDX_MASK)
+#define BNGE_NQ_HDL_TYPE(hdl)	(((hdl) & BNGE_NQ_HDL_TYPE_MASK) >>	\
+				 BNGE_NQ_HDL_TYPE_SHIFT)
+
 struct bnge_net {
 	struct bnge_dev		*bd;
 	struct net_device	*netdev;
@@ -232,6 +239,9 @@ struct bnge_net {
 	u8			rss_hash_key_updated:1;
 	int			rsscos_nr_ctxs;
 	u32			stats_coal_ticks;
+
+	unsigned long		state;
+#define BNGE_STATE_NAPI_DISABLED	0
 };
 
 #define BNGE_DEFAULT_RX_RING_SIZE	511
@@ -278,9 +288,25 @@ void bnge_set_ring_params(struct bnge_dev *bd);
 	     txr = (iter < BNGE_MAX_TXR_PER_NAPI - 1) ?	\
 	     (bnapi)->tx_ring[++iter] : NULL)
 
+#define DB_EPOCH(db, idx)	(((idx) & (db)->db_epoch_mask) <<	\
+				 ((db)->db_epoch_shift))
+
+#define DB_TOGGLE(tgl)		((tgl) << DBR_TOGGLE_SFT)
+
+#define DB_RING_IDX(db, idx)	(((idx) & (db)->db_ring_mask) |		\
+				 DB_EPOCH(db, idx))
+
 #define BNGE_SET_NQ_HDL(cpr)						\
 	(((cpr)->cp_ring_type << BNGE_NQ_HDL_TYPE_SHIFT) | (cpr)->cp_idx)
 
+#define BNGE_DB_NQ(bd, db, idx)						\
+	bnge_writeq(bd, (db)->db_key64 | DBR_TYPE_NQ | DB_RING_IDX(db, idx),\
+		    (db)->doorbell)
+
+#define BNGE_DB_NQ_ARM(bd, db, idx)					\
+	bnge_writeq(bd, (db)->db_key64 | DBR_TYPE_NQ_ARM |	\
+		    DB_RING_IDX(db, idx), (db)->doorbell)
+
 struct bnge_stats_mem {
 	u64		*sw_stats;
 	u64		*hw_masks;
@@ -289,6 +315,25 @@ struct bnge_stats_mem {
 	int		len;
 };
 
+struct nqe_cn {
+	__le16	type;
+	#define NQ_CN_TYPE_MASK			0x3fUL
+	#define NQ_CN_TYPE_SFT			0
+	#define NQ_CN_TYPE_CQ_NOTIFICATION	0x30UL
+	#define NQ_CN_TYPE_LAST			NQ_CN_TYPE_CQ_NOTIFICATION
+	#define NQ_CN_TOGGLE_MASK		0xc0UL
+	#define NQ_CN_TOGGLE_SFT		6
+	__le16	reserved16;
+	__le32	cq_handle_low;
+	__le32	v;
+	#define NQ_CN_V				0x1UL
+	__le32	cq_handle_high;
+};
+
+#define NQE_CN_TYPE(type)	((type) & NQ_CN_TYPE_MASK)
+#define NQE_CN_TOGGLE(type)	(((type) & NQ_CN_TOGGLE_MASK) >>	\
+				 NQ_CN_TOGGLE_SFT)
+
 struct bnge_cp_ring_info {
 	struct bnge_napi	*bnapi;
 	dma_addr_t		*desc_mapping;
@@ -298,6 +343,10 @@ struct bnge_cp_ring_info {
 	u8			cp_idx;
 	u32			cp_raw_cons;
 	struct bnge_db_info	cp_db;
+	u8			had_work_done:1;
+	u8			has_more_work:1;
+	u8			had_nqe_notify:1;
+	u8			toggle;
 };
 
 struct bnge_nq_ring_info {
@@ -310,8 +359,9 @@ struct bnge_nq_ring_info {
 
 	struct bnge_stats_mem	stats;
 	u32			hw_stats_ctx_id;
+	u8			has_more_work:1;
 
-	int				cp_ring_count;
+	u16				cp_ring_count;
 	struct bnge_cp_ring_info	*cp_ring_arr;
 };
 
@@ -374,6 +424,12 @@ struct bnge_napi {
 	struct bnge_nq_ring_info	nq_ring;
 	struct bnge_rx_ring_info	*rx_ring;
 	struct bnge_tx_ring_info	*tx_ring[BNGE_MAX_TXR_PER_NAPI];
+	u8				events;
+#define BNGE_RX_EVENT			1
+#define BNGE_AGG_EVENT			2
+#define BNGE_TX_EVENT			4
+#define BNGE_REDIRECT_EVENT		8
+#define BNGE_TX_CMP_EVENT		0x10
 };
 
 #define INVALID_STATS_CTX_ID	-1
@@ -452,4 +508,6 @@ struct bnge_l2_filter {
 u16 bnge_cp_ring_for_rx(struct bnge_rx_ring_info *rxr);
 u16 bnge_cp_ring_for_tx(struct bnge_tx_ring_info *txr);
 void bnge_fill_hw_rss_tbl(struct bnge_net *bn, struct bnge_vnic_info *vnic);
+int bnge_alloc_rx_data(struct bnge_net *bn, struct bnge_rx_ring_info *rxr,
+		       u16 prod, gfp_t gfp);
 #endif /* _BNGE_NETDEV_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
new file mode 100644
index 000000000000..db49a92542c0
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
@@ -0,0 +1,573 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2025 Broadcom.
+
+#include <asm/byteorder.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmapool.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/pci.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/if.h>
+#include <net/ip.h>
+#include <linux/skbuff.h>
+#include <net/page_pool/helpers.h>
+#include <linux/if_vlan.h>
+#include <net/udp_tunnel.h>
+#include <net/dst_metadata.h>
+#include <net/netdev_queues.h>
+
+#include "bnge.h"
+#include "bnge_hwrm.h"
+#include "bnge_hwrm_lib.h"
+#include "bnge_netdev.h"
+#include "bnge_rmem.h"
+#include "bnge_txrx.h"
+
+irqreturn_t bnge_msix(int irq, void *dev_instance)
+{
+	struct bnge_napi *bnapi = dev_instance;
+	struct bnge_nq_ring_info *nqr;
+	struct bnge_net *bn;
+	u32 cons;
+
+	bn = bnapi->bn;
+	nqr = &bnapi->nq_ring;
+	cons = RING_CMP(bn, nqr->nq_raw_cons);
+
+	prefetch(&nqr->desc_ring[CP_RING(cons)][CP_IDX(cons)]);
+	napi_schedule(&bnapi->napi);
+	return IRQ_HANDLED;
+}
+
+static void bnge_sched_reset_rxr(struct bnge_net *bn,
+				 struct bnge_rx_ring_info *rxr)
+{
+	/* TODO: Initiate reset task */
+	rxr->rx_next_cons = 0xffff;
+}
+
+void bnge_reuse_rx_data(struct bnge_rx_ring_info *rxr, u16 cons, void *data)
+{
+	struct bnge_sw_rx_bd *cons_rx_buf, *prod_rx_buf;
+	struct bnge_net *bn = rxr->bnapi->bn;
+	struct rx_bd *cons_bd, *prod_bd;
+	u16 prod = rxr->rx_prod;
+
+	prod_rx_buf = &rxr->rx_buf_ring[RING_RX(bn, prod)];
+	cons_rx_buf = &rxr->rx_buf_ring[cons];
+
+	prod_rx_buf->data = data;
+	prod_rx_buf->data_ptr = cons_rx_buf->data_ptr;
+
+	prod_rx_buf->mapping = cons_rx_buf->mapping;
+
+	prod_bd = &rxr->rx_desc_ring[RX_RING(bn, prod)][RX_IDX(prod)];
+	cons_bd = &rxr->rx_desc_ring[RX_RING(bn, cons)][RX_IDX(cons)];
+
+	prod_bd->rx_bd_haddr = cons_bd->rx_bd_haddr;
+}
+
+static void bnge_deliver_skb(struct bnge_net *bn, struct bnge_napi *bnapi,
+			     struct sk_buff *skb)
+{
+	skb_mark_for_recycle(skb);
+	skb_record_rx_queue(skb, bnapi->index);
+	napi_gro_receive(&bnapi->napi, skb);
+}
+
+static struct sk_buff *bnge_copy_skb(struct bnge_napi *bnapi, u8 *data,
+				     unsigned int len, dma_addr_t mapping)
+{
+	struct bnge_net *bn = bnapi->bn;
+	struct bnge_dev *bd = bn->bd;
+	struct sk_buff *skb;
+
+	skb = napi_alloc_skb(&bnapi->napi, len);
+	if (!skb)
+		return NULL;
+
+	dma_sync_single_for_cpu(bd->dev, mapping, bn->rx_copybreak,
+				bn->rx_dir);
+
+	memcpy(skb->data - NET_IP_ALIGN, data - NET_IP_ALIGN,
+	       len + NET_IP_ALIGN);
+
+	dma_sync_single_for_device(bd->dev, mapping, bn->rx_copybreak,
+				   bn->rx_dir);
+
+	skb_put(skb, len);
+
+	return skb;
+}
+
+static enum pkt_hash_types bnge_rss_ext_op(struct bnge_net *bn,
+					   struct rx_cmp *rxcmp)
+{
+	u8 ext_op = RX_CMP_V3_HASH_TYPE(bn->bd, rxcmp);
+
+	switch (ext_op) {
+	case EXT_OP_INNER_4:
+	case EXT_OP_OUTER_4:
+	case EXT_OP_INNFL_3:
+	case EXT_OP_OUTFL_3:
+		return PKT_HASH_TYPE_L4;
+	default:
+		return PKT_HASH_TYPE_L3;
+	}
+}
+
+static struct sk_buff *bnge_rx_vlan(struct sk_buff *skb, u8 cmp_type,
+				    struct rx_cmp *rxcmp,
+				    struct rx_cmp_ext *rxcmp1)
+{
+	__be16 vlan_proto;
+	u16 vtag;
+
+	if (cmp_type == CMP_TYPE_RX_L2_CMP) {
+		__le32 flags2 = rxcmp1->rx_cmp_flags2;
+		u32 meta_data;
+
+		if (!(flags2 & cpu_to_le32(RX_CMP_FLAGS2_META_FORMAT_VLAN)))
+			return skb;
+
+		meta_data = le32_to_cpu(rxcmp1->rx_cmp_meta_data);
+		vtag = meta_data & RX_CMP_FLAGS2_METADATA_TCI_MASK;
+		vlan_proto =
+			htons(meta_data >> RX_CMP_FLAGS2_METADATA_TPID_SFT);
+		if (eth_type_vlan(vlan_proto))
+			__vlan_hwaccel_put_tag(skb, vlan_proto, vtag);
+		else
+			goto vlan_err;
+	} else if (cmp_type == CMP_TYPE_RX_L2_V3_CMP) {
+		if (RX_CMP_VLAN_VALID(rxcmp)) {
+			u32 tpid_sel = RX_CMP_VLAN_TPID_SEL(rxcmp);
+
+			if (tpid_sel == RX_CMP_METADATA1_TPID_8021Q)
+				vlan_proto = htons(ETH_P_8021Q);
+			else if (tpid_sel == RX_CMP_METADATA1_TPID_8021AD)
+				vlan_proto = htons(ETH_P_8021AD);
+			else
+				goto vlan_err;
+			vtag = RX_CMP_METADATA0_TCI(rxcmp1);
+			__vlan_hwaccel_put_tag(skb, vlan_proto, vtag);
+		}
+	}
+	return skb;
+
+vlan_err:
+	skb_mark_for_recycle(skb);
+	dev_kfree_skb(skb);
+	return NULL;
+}
+
+static struct sk_buff *bnge_rx_skb(struct bnge_net *bn,
+				   struct bnge_rx_ring_info *rxr, u16 cons,
+				   void *data, u8 *data_ptr,
+				   dma_addr_t dma_addr,
+				   unsigned int offset_and_len)
+{
+	struct bnge_dev *bd = bn->bd;
+	u16 prod = rxr->rx_prod;
+	struct sk_buff *skb;
+	int err;
+
+	err = bnge_alloc_rx_data(bn, rxr, prod, GFP_ATOMIC);
+	if (unlikely(err)) {
+		bnge_reuse_rx_data(rxr, cons, data);
+		return NULL;
+	}
+
+	skb = napi_build_skb(data, bn->rx_buf_size);
+	dma_sync_single_for_cpu(bd->dev, dma_addr, bn->rx_buf_use_size,
+				bn->rx_dir);
+	if (!skb) {
+		page_pool_free_va(rxr->head_pool, data, true);
+		return NULL;
+	}
+
+	skb_mark_for_recycle(skb);
+	skb_reserve(skb, bn->rx_offset);
+	skb_put(skb, offset_and_len & 0xffff);
+	return skb;
+}
+
+/* returns the following:
+ * 1       - 1 packet successfully received
+ * -EBUSY  - completion ring does not have all the agg buffers yet
+ * -ENOMEM - packet aborted due to out of memory
+ * -EIO    - packet aborted due to hw error indicated in BD
+ */
+static int bnge_rx_pkt(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
+		       u32 *raw_cons, u8 *event)
+{
+	struct bnge_napi *bnapi = cpr->bnapi;
+	struct net_device *dev = bn->netdev;
+	struct bnge_rx_ring_info *rxr;
+	u32 tmp_raw_cons, flags, misc;
+	struct bnge_sw_rx_bd *rx_buf;
+	struct rx_cmp_ext *rxcmp1;
+	u16 cons, prod, cp_cons;
+	u8 *data_ptr, cmp_type;
+	struct rx_cmp *rxcmp;
+	dma_addr_t dma_addr;
+	struct sk_buff *skb;
+	unsigned int len;
+	void *data;
+	int rc = 0;
+
+	rxr = bnapi->rx_ring;
+
+	tmp_raw_cons = *raw_cons;
+	cp_cons = RING_CMP(bn, tmp_raw_cons);
+	rxcmp = (struct rx_cmp *)
+			&cpr->desc_ring[CP_RING(cp_cons)][CP_IDX(cp_cons)];
+
+	cmp_type = RX_CMP_TYPE(rxcmp);
+
+	tmp_raw_cons = NEXT_RAW_CMP(tmp_raw_cons);
+	cp_cons = RING_CMP(bn, tmp_raw_cons);
+	rxcmp1 = (struct rx_cmp_ext *)
+			&cpr->desc_ring[CP_RING(cp_cons)][CP_IDX(cp_cons)];
+
+	if (!RX_CMP_VALID(rxcmp1, tmp_raw_cons))
+		return -EBUSY;
+
+	/* The valid test of the entry must be done first before
+	 * reading any further.
+	 */
+	dma_rmb();
+	prod = rxr->rx_prod;
+
+	cons = rxcmp->rx_cmp_opaque;
+	if (unlikely(cons != rxr->rx_next_cons)) {
+		/* 0xffff is forced error, don't print it */
+		if (rxr->rx_next_cons != 0xffff)
+			netdev_warn(bn->netdev, "RX cons %x != expected cons %x\n",
+				    cons, rxr->rx_next_cons);
+		bnge_sched_reset_rxr(bn, rxr);
+		goto next_rx_no_prod_no_len;
+	}
+	rx_buf = &rxr->rx_buf_ring[cons];
+	data = rx_buf->data;
+	data_ptr = rx_buf->data_ptr;
+	prefetch(data_ptr);
+
+	misc = le32_to_cpu(rxcmp->rx_cmp_misc_v1);
+	*event |= BNGE_RX_EVENT;
+
+	rx_buf->data = NULL;
+	if (rxcmp1->rx_cmp_cfa_code_errors_v2 & RX_CMP_L2_ERRORS) {
+		bnge_reuse_rx_data(rxr, cons, data);
+		rc = -EIO;
+		goto next_rx_no_len;
+	}
+
+	flags = le32_to_cpu(rxcmp->rx_cmp_len_flags_type);
+	len = flags >> RX_CMP_LEN_SHIFT;
+	dma_addr = rx_buf->mapping;
+
+	if (len <= bn->rx_copybreak) {
+		skb = bnge_copy_skb(bnapi, data_ptr, len, dma_addr);
+		bnge_reuse_rx_data(rxr, cons, data);
+		if (!skb)
+			goto oom_next_rx;
+	} else {
+		u32 payload;
+
+		if (rx_buf->data_ptr == data_ptr)
+			payload = misc & RX_CMP_PAYLOAD_OFFSET;
+		else
+			payload = 0;
+		skb = bnge_rx_skb(bn, rxr, cons, data, data_ptr, dma_addr,
+				  payload | len);
+		if (!skb)
+			goto oom_next_rx;
+	}
+
+	if (RX_CMP_HASH_VALID(rxcmp)) {
+		enum pkt_hash_types type;
+
+		if (cmp_type == CMP_TYPE_RX_L2_V3_CMP) {
+			type = bnge_rss_ext_op(bn, rxcmp);
+		} else {
+			u32 itypes = RX_CMP_ITYPES(rxcmp);
+
+			if (itypes == RX_CMP_FLAGS_ITYPE_TCP ||
+			    itypes == RX_CMP_FLAGS_ITYPE_UDP)
+				type = PKT_HASH_TYPE_L4;
+			else
+				type = PKT_HASH_TYPE_L3;
+		}
+		skb_set_hash(skb, le32_to_cpu(rxcmp->rx_cmp_rss_hash), type);
+	}
+
+	skb->protocol = eth_type_trans(skb, dev);
+
+	if (skb->dev->features & BNGE_HW_FEATURE_VLAN_ALL_RX) {
+		skb = bnge_rx_vlan(skb, cmp_type, rxcmp, rxcmp1);
+		if (!skb)
+			goto next_rx;
+	}
+
+	skb_checksum_none_assert(skb);
+	if (RX_CMP_L4_CS_OK(rxcmp1)) {
+		if (dev->features & NETIF_F_RXCSUM) {
+			skb->ip_summed = CHECKSUM_UNNECESSARY;
+			skb->csum_level = RX_CMP_ENCAP(rxcmp1);
+		}
+	}
+
+	bnge_deliver_skb(bn, bnapi, skb);
+	rc = 1;
+
+next_rx:
+	/* Update Stats */
+next_rx_no_len:
+	rxr->rx_prod = NEXT_RX(prod);
+	rxr->rx_next_cons = RING_RX(bn, NEXT_RX(cons));
+
+next_rx_no_prod_no_len:
+	*raw_cons = tmp_raw_cons;
+	return rc;
+
+oom_next_rx:
+	rc = -ENOMEM;
+	goto next_rx;
+}
+
+/* In netpoll mode, if we are using a combined completion ring, we need to
+ * discard the rx packets and recycle the buffers.
+ */
+static int bnge_force_rx_discard(struct bnge_net *bn,
+				 struct bnge_cp_ring_info *cpr,
+				 u32 *raw_cons, u8 *event)
+{
+	u32 tmp_raw_cons = *raw_cons;
+	struct rx_cmp_ext *rxcmp1;
+	struct rx_cmp *rxcmp;
+	u16 cp_cons;
+	u8 cmp_type;
+	int rc;
+
+	cp_cons = RING_CMP(bn, tmp_raw_cons);
+	rxcmp = (struct rx_cmp *)
+			&cpr->desc_ring[CP_RING(cp_cons)][CP_IDX(cp_cons)];
+
+	tmp_raw_cons = NEXT_RAW_CMP(tmp_raw_cons);
+	cp_cons = RING_CMP(bn, tmp_raw_cons);
+	rxcmp1 = (struct rx_cmp_ext *)
+			&cpr->desc_ring[CP_RING(cp_cons)][CP_IDX(cp_cons)];
+
+	if (!RX_CMP_VALID(rxcmp1, tmp_raw_cons))
+		return -EBUSY;
+
+	/* The valid test of the entry must be done first before
+	 * reading any further.
+	 */
+	dma_rmb();
+	cmp_type = RX_CMP_TYPE(rxcmp);
+	if (cmp_type == CMP_TYPE_RX_L2_CMP ||
+	    cmp_type == CMP_TYPE_RX_L2_V3_CMP) {
+		rxcmp1->rx_cmp_cfa_code_errors_v2 |=
+			cpu_to_le32(RX_CMPL_ERRORS_CRC_ERROR);
+	}
+	rc = bnge_rx_pkt(bn, cpr, raw_cons, event);
+	return rc;
+}
+
+static void __bnge_poll_work_done(struct bnge_net *bn, struct bnge_napi *bnapi,
+				  int budget)
+{
+	struct bnge_rx_ring_info *rxr = bnapi->rx_ring;
+
+	if ((bnapi->events & BNGE_RX_EVENT)) {
+		bnge_db_write(bn->bd, &rxr->rx_db, rxr->rx_prod);
+		bnapi->events &= ~BNGE_RX_EVENT;
+	}
+}
+
+static int __bnge_poll_work(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
+			    int budget)
+{
+	struct bnge_napi *bnapi = cpr->bnapi;
+	u32 raw_cons = cpr->cp_raw_cons;
+	struct tx_cmp *txcmp;
+	int rx_pkts = 0;
+	u8 event = 0;
+	u32 cons;
+
+	cpr->has_more_work = 0;
+	cpr->had_work_done = 1;
+	while (1) {
+		u8 cmp_type;
+		int rc;
+
+		cons = RING_CMP(bn, raw_cons);
+		txcmp = &cpr->desc_ring[CP_RING(cons)][CP_IDX(cons)];
+
+		if (!TX_CMP_VALID(bn, txcmp, raw_cons))
+			break;
+
+		/* The valid test of the entry must be done first before
+		 * reading any further.
+		 */
+		dma_rmb();
+		cmp_type = TX_CMP_TYPE(txcmp);
+		if (cmp_type == CMP_TYPE_TX_L2_CMP ||
+		    cmp_type == CMP_TYPE_TX_L2_COAL_CMP) {
+			/*
+			 * Tx Compl Processng
+			 */
+		} else if (cmp_type >= CMP_TYPE_RX_L2_CMP &&
+			   cmp_type <= CMP_TYPE_RX_L2_TPA_START_V3_CMP) {
+			if (likely(budget))
+				rc = bnge_rx_pkt(bn, cpr, &raw_cons, &event);
+			else
+				rc = bnge_force_rx_discard(bn, cpr, &raw_cons,
+							   &event);
+			if (likely(rc >= 0))
+				rx_pkts += rc;
+			/* Increment rx_pkts when rc is -ENOMEM to count towards
+			 * the NAPI budget.  Otherwise, we may potentially loop
+			 * here forever if we consistently cannot allocate
+			 * buffers.
+			 */
+			else if (rc == -ENOMEM && budget)
+				rx_pkts++;
+			else if (rc == -EBUSY)	/* partial completion */
+				break;
+		}
+
+		raw_cons = NEXT_RAW_CMP(raw_cons);
+
+		if (rx_pkts && rx_pkts == budget) {
+			cpr->has_more_work = 1;
+			break;
+		}
+	}
+
+	cpr->cp_raw_cons = raw_cons;
+	bnapi->events |= event;
+	return rx_pkts;
+}
+
+static void __bnge_poll_cqs_done(struct bnge_net *bn, struct bnge_napi *bnapi,
+				 u64 dbr_type, int budget)
+{
+	struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;
+	int i;
+
+	for (i = 0; i < nqr->cp_ring_count; i++) {
+		struct bnge_cp_ring_info *cpr = &nqr->cp_ring_arr[i];
+		struct bnge_db_info *db;
+
+		if (cpr->had_work_done) {
+			u32 tgl = 0;
+
+			if (dbr_type == DBR_TYPE_CQ_ARMALL) {
+				cpr->had_nqe_notify = 0;
+				tgl = cpr->toggle;
+			}
+			db = &cpr->cp_db;
+			bnge_writeq(bn->bd,
+				    db->db_key64 | dbr_type | DB_TOGGLE(tgl) |
+				    DB_RING_IDX(db, cpr->cp_raw_cons),
+				    db->doorbell);
+			cpr->had_work_done = 0;
+		}
+	}
+	__bnge_poll_work_done(bn, bnapi, budget);
+}
+
+static int __bnge_poll_cqs(struct bnge_net *bn, struct bnge_napi *bnapi,
+			   int budget)
+{
+	struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;
+	int i, work_done = 0;
+
+	for (i = 0; i < nqr->cp_ring_count; i++) {
+		struct bnge_cp_ring_info *cpr = &nqr->cp_ring_arr[i];
+
+		if (cpr->had_nqe_notify) {
+			work_done += __bnge_poll_work(bn, cpr,
+						      budget - work_done);
+			nqr->has_more_work |= cpr->has_more_work;
+		}
+	}
+	return work_done;
+}
+
+int bnge_napi_poll(struct napi_struct *napi, int budget)
+{
+	struct bnge_napi *bnapi = container_of(napi, struct bnge_napi, napi);
+	struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;
+	u32 raw_cons = nqr->nq_raw_cons;
+	struct bnge_net *bn = bnapi->bn;
+	struct bnge_dev *bd = bn->bd;
+	struct nqe_cn *nqcmp;
+	int work_done = 0;
+	u32 cons;
+
+	if (nqr->has_more_work) {
+		nqr->has_more_work = 0;
+		work_done = __bnge_poll_cqs(bn, bnapi, budget);
+	}
+
+	while (1) {
+		u16 type;
+
+		cons = RING_CMP(bn, raw_cons);
+		nqcmp = &nqr->desc_ring[CP_RING(cons)][CP_IDX(cons)];
+
+		if (!NQ_CMP_VALID(bn, nqcmp, raw_cons)) {
+			if (nqr->has_more_work)
+				break;
+
+			__bnge_poll_cqs_done(bn, bnapi, DBR_TYPE_CQ_ARMALL,
+					     budget);
+			nqr->nq_raw_cons = raw_cons;
+			if (napi_complete_done(napi, work_done))
+				BNGE_DB_NQ_ARM(bd, &nqr->nq_db,
+					       nqr->nq_raw_cons);
+			goto poll_done;
+		}
+
+		/* The valid test of the entry must be done first before
+		 * reading any further.
+		 */
+		dma_rmb();
+
+		type = le16_to_cpu(nqcmp->type);
+		if (NQE_CN_TYPE(type) == NQ_CN_TYPE_CQ_NOTIFICATION) {
+			u32 idx = le32_to_cpu(nqcmp->cq_handle_low);
+			u32 cq_type = BNGE_NQ_HDL_TYPE(idx);
+			struct bnge_cp_ring_info *cpr;
+
+			/* No more budget for RX work */
+			if (budget && work_done >= budget &&
+			    cq_type == BNGE_NQ_HDL_TYPE_RX)
+				break;
+
+			idx = BNGE_NQ_HDL_IDX(idx);
+			cpr = &nqr->cp_ring_arr[idx];
+			cpr->had_nqe_notify = 1;
+			cpr->toggle = NQE_CN_TOGGLE(type);
+			work_done += __bnge_poll_work(bn, cpr,
+						      budget - work_done);
+			nqr->has_more_work |= cpr->has_more_work;
+		}
+		raw_cons = NEXT_RAW_CMP(raw_cons);
+	}
+
+	__bnge_poll_cqs_done(bn, bnapi, DBR_TYPE_CQ, budget);
+	if (raw_cons != nqr->nq_raw_cons) {
+		nqr->nq_raw_cons = raw_cons;
+		BNGE_DB_NQ(bd, &nqr->nq_db, raw_cons);
+	}
+poll_done:
+	return work_done;
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
new file mode 100644
index 000000000000..b13081b0eb79
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2025 Broadcom */
+
+#ifndef _BNGE_TXRX_H_
+#define _BNGE_TXRX_H_
+
+#include <linux/bnxt/hsi.h>
+#include "bnge_netdev.h"
+
+#define BNGE_MIN_PKT_SIZE	52
+
+#define TX_OPAQUE_IDX_MASK	0x0000ffff
+#define TX_OPAQUE_BDS_MASK	0x00ff0000
+#define TX_OPAQUE_BDS_SHIFT	16
+#define TX_OPAQUE_RING_MASK	0xff000000
+#define TX_OPAQUE_RING_SHIFT	24
+
+#define SET_TX_OPAQUE(bn, txr, idx, bds)				\
+	(((txr)->tx_napi_idx << TX_OPAQUE_RING_SHIFT) |			\
+	 ((bds) << TX_OPAQUE_BDS_SHIFT) | ((idx) & (bn)->tx_ring_mask))
+
+#define TX_OPAQUE_IDX(opq)	((opq) & TX_OPAQUE_IDX_MASK)
+#define TX_OPAQUE_RING(opq)	(((opq) & TX_OPAQUE_RING_MASK) >>	\
+				 TX_OPAQUE_RING_SHIFT)
+#define TX_OPAQUE_BDS(opq)	(((opq) & TX_OPAQUE_BDS_MASK) >>	\
+				 TX_OPAQUE_BDS_SHIFT)
+#define TX_OPAQUE_PROD(bn, opq)	((TX_OPAQUE_IDX(opq) + TX_OPAQUE_BDS(opq)) &\
+				 (bn)->tx_ring_mask)
+
+/* Minimum TX BDs for a TX packet with MAX_SKB_FRAGS + 1.  We need one extra
+ * BD because the first TX BD is always a long BD.
+ */
+#define BNGE_MIN_TX_DESC_CNT		(MAX_SKB_FRAGS + 2)
+
+#define RX_RING(bn, x)	(((x) & (bn)->rx_ring_mask) >> (BNGE_PAGE_SHIFT - 4))
+#define RX_AGG_RING(bn, x)	(((x) & (bn)->rx_agg_ring_mask) >>	\
+				 (BNGE_PAGE_SHIFT - 4))
+#define RX_IDX(x)	((x) & (RX_DESC_CNT - 1))
+
+#define TX_RING(bn, x)	(((x) & (bn)->tx_ring_mask) >> (BNGE_PAGE_SHIFT - 4))
+#define TX_IDX(x)	((x) & (TX_DESC_CNT - 1))
+
+#define CP_RING(x)	(((x) & ~(CP_DESC_CNT - 1)) >> (BNGE_PAGE_SHIFT - 4))
+#define CP_IDX(x)	((x) & (CP_DESC_CNT - 1))
+
+#define TX_CMP_VALID(bn, txcmp, raw_cons)				\
+	(!!((txcmp)->tx_cmp_errors_v & cpu_to_le32(TX_CMP_V)) ==	\
+	 !((raw_cons) & (bn)->cp_bit))
+
+#define RX_CMP_VALID(rxcmp1, raw_cons)					\
+	(!!((rxcmp1)->rx_cmp_cfa_code_errors_v2 & cpu_to_le32(RX_CMP_V)) ==\
+	 !((raw_cons) & (bn)->cp_bit))
+
+#define RX_AGG_CMP_VALID(bn, agg, raw_cons)			\
+	(!!((agg)->rx_agg_cmp_v & cpu_to_le32(RX_AGG_CMP_V)) ==	\
+	 !((raw_cons) & (bn)->cp_bit))
+
+#define NQ_CMP_VALID(bn, nqcmp, raw_cons)				\
+	(!!((nqcmp)->v & cpu_to_le32(NQ_CN_V)) == !((raw_cons) & (bn)->cp_bit))
+
+#define TX_CMP_TYPE(txcmp)					\
+	(le32_to_cpu((txcmp)->tx_cmp_flags_type) & CMP_TYPE)
+
+#define RX_CMP_TYPE(rxcmp)					\
+	(le32_to_cpu((rxcmp)->rx_cmp_len_flags_type) & RX_CMP_CMP_TYPE)
+
+#define RING_RX(bn, idx)	((idx) & (bn)->rx_ring_mask)
+#define NEXT_RX(idx)		((idx) + 1)
+
+#define RING_RX_AGG(bn, idx)	((idx) & (bn)->rx_agg_ring_mask)
+#define NEXT_RX_AGG(idx)	((idx) + 1)
+
+#define RING_TX(bn, idx)	((idx) & (bn)->tx_ring_mask)
+#define NEXT_TX(idx)		((idx) + 1)
+
+#define ADV_RAW_CMP(idx, n)	((idx) + (n))
+#define NEXT_RAW_CMP(idx)	ADV_RAW_CMP(idx, 1)
+#define RING_CMP(bn, idx)	((idx) & (bn)->cp_ring_mask)
+
+#define RX_CMP_ITYPES(rxcmp)					\
+	(le32_to_cpu((rxcmp)->rx_cmp_len_flags_type) & RX_CMP_FLAGS_ITYPES_MASK)
+
+#define RX_CMP_CFA_CODE(rxcmpl1)					\
+	((le32_to_cpu((rxcmpl1)->rx_cmp_cfa_code_errors_v2) &		\
+	  RX_CMPL_CFA_CODE_MASK) >> RX_CMPL_CFA_CODE_SFT)
+
+irqreturn_t bnge_msix(int irq, void *dev_instance);
+void bnge_reuse_rx_data(struct bnge_rx_ring_info *rxr, u16 cons, void *data);
+int bnge_napi_poll(struct napi_struct *napi, int budget);
+#endif /* _BNGE_TXRX_H_ */
-- 
2.47.3


