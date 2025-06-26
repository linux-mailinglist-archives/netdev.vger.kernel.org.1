Return-Path: <netdev+bounces-201490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FA9AE98E2
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 10:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCEE33BF172
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0CA2D9784;
	Thu, 26 Jun 2025 08:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZgDCz5jW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE612D4B59
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 08:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750927588; cv=none; b=CSEgypk/apOPDeiecLRNh6k4rOyL+R2JpVtoT0l9qw7FKBMoE2KvjyeTM8RUn5jZDhzZ40qzXq0JGU8+sLkNO/ynplaJsdJiGFO7UQk6PrRU2M5zfIKbTvf7DdsrnNr9voPkxq2wqe4imEeabWc8M4Cb/XHPk66IHc0UR3T/IU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750927588; c=relaxed/simple;
	bh=MM3njytMxw+bV2ooRLvutfRL1cNAyE9NJrXv1/W92i0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PnwWHIZbrznLNaExsNZg2TmF8c2NNdaDWzTekFGQdxyCwGg35LIEQriFG4s4KDqPODZj7EF78tfIZ728n+MxpLpEt3UshpVO+9Ms2wVbCi7PlgeOqOAN1TbCrlASIZrVnwWhZ6mNZyxsMj5mWcTqnZiwdGq6TWnfgpovoNq3jvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZgDCz5jW; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-234bfe37cccso9852265ad.0
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 01:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1750927584; x=1751532384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h83hH5O+ZfPMjj7o4JbNHK0/+yH5Ip6XnIL2xZO+2Wc=;
        b=ZgDCz5jW84ZiSrupFCznOqVkVPxNIvHZVFfWzEdRx9EJGCd9/5DgrIHjohFHQrU2MV
         8OtqT0d4LGqAom/3mWzwmvhwl9hrxb9ZJ73zQoNzPWANswyfKsROo14izimnwIYUcR6t
         Qq5XYr+29JfmyJRulPvfVrwiG5eG7/n6t1lvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750927584; x=1751532384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h83hH5O+ZfPMjj7o4JbNHK0/+yH5Ip6XnIL2xZO+2Wc=;
        b=PGYwgQ2jpeGcTTQFbsBx7MJ6YzeMhBm3WZMC+yQ4XelL0k3VlUW/6pOHN7+Y5xrKPj
         E4tAsmQNRN+VdhRrzvciz7b1JOImQ6KlQTmnMWVzhn4E3yH2a+49/AO7lzLJnPBQpISh
         8DSNxlfEPGLZqs7HwTlwgj7DOBfaNdA+ZeP6tIQRwdj0QK+5ABYon3VzE+HLgWvPjCnE
         /kNf3kRQPof4ewrrc+AU52PokcNlLStrox21V5AXsIBUCGw2rrYTbIT+t0B0Fv7Qzt1H
         jEqkoEp3k97y3RQN+497CSS+p48UCrTFEJxlt/Bg+MZaNOD15VHBlxFbUKeadRIvj+nH
         sVmw==
X-Gm-Message-State: AOJu0YyO7p/6oXV64gyE9sp3KuG9BYUUxoSAtqoKRuKCOEd5Mnz8UnB8
	MbyIaztC5isPpu6KdMPovZ5xz8Wt9X2y7RdSvUauwroZxRwhsbJ/s1+ewUTsiVKVLQ==
X-Gm-Gg: ASbGncs0d8juUkLGlTPMcDTdNfNdXWEOLpRbUNiME2nb9Wgg6j5GzicQInHl1ylkhyq
	xIpP0G7VoiunejHvEhXa7nw5sEAL+X0o9hk23toBIvK5VszBIDjEkRtX4FrZULWV/uAZW+APggn
	P+XfNzM2cp3sscphd6TJc7rCsb2pt5yig87BakJiqbMDPLrqzsZ6pGpoBONG7iOH4HJs50iVZvq
	/W5+nhJtMSRBtjo45MumadKZF8keZU8KyTPkgVYWe6Xecg+OG8m/0V+hF4bu7P99W5rbYB17/GT
	DCBWh/GE3bOogrYddbdJqOvkiB7LCDjXL346H27mhszoMnDuD21vY+he3Jsy0ULjXge3y+T6cqj
	dOURvmJBLs9Uo/X8Rd87D6Ccog0SQ
X-Google-Smtp-Source: AGHT+IFKrPqEtxrpPaaTTGVABaLhKAkPYoTwChkOF7WHdRPhU3k0/4GgbgjCiqBRKbteVkcpZ9JP8w==
X-Received: by 2002:a17:902:c403:b0:235:2403:779f with SMTP id d9443c01a7336-2382424be14mr106471955ad.29.1750927584094;
        Thu, 26 Jun 2025 01:46:24 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83fbe94sm152524875ad.86.2025.06.26.01.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 01:46:23 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
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
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [net-next, v2 07/10] bng_en: Add resource management support
Date: Thu, 26 Jun 2025 14:08:16 +0000
Message-ID: <20250626140844.266456-8-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250626140844.266456-1-vikas.gupta@broadcom.com>
References: <20250626140844.266456-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Get the resources and capabilities from the firmware.
Add functions to manage the resources with the firmware.
These functions will help netdev reserve the resources
with the firmware before registering the device in future
patches. The resources and their information, such as
the maximum available and reserved, are part of the members
present in the bnge_hw_resc struct.
The bnge_reserve_rings() function also populates
the RSS table entries once the RX rings are reserved with
the firmware.

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/Makefile   |   3 +-
 drivers/net/ethernet/broadcom/bnge/bnge.h     |  77 ++++
 .../net/ethernet/broadcom/bnge/bnge_core.c    |   5 +
 .../net/ethernet/broadcom/bnge/bnge_hwrm.h    |   1 -
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    | 268 ++++++++++++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |   6 +
 .../net/ethernet/broadcom/bnge/bnge_resc.c    | 328 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_resc.h    |  75 ++++
 8 files changed, 761 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_resc.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_resc.h

diff --git a/drivers/net/ethernet/broadcom/bnge/Makefile b/drivers/net/ethernet/broadcom/bnge/Makefile
index 1144594fc3f6..10df05b6695e 100644
--- a/drivers/net/ethernet/broadcom/bnge/Makefile
+++ b/drivers/net/ethernet/broadcom/bnge/Makefile
@@ -6,4 +6,5 @@ bng_en-y := bnge_core.o \
 	    bnge_devlink.o \
 	    bnge_hwrm.o \
 	    bnge_hwrm_lib.o \
-	    bnge_rmem.o
+	    bnge_rmem.o \
+	    bnge_resc.o
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index 01f64a10729c..b58d8fc6f258 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -10,6 +10,7 @@
 #include <linux/etherdevice.h>
 #include "../bnxt/bnxt_hsi.h"
 #include "bnge_rmem.h"
+#include "bnge_resc.h"
 
 #define DRV_VER_MAJ	1
 #define DRV_VER_MIN	15
@@ -21,6 +22,12 @@ enum board_idx {
 	BCM57708,
 };
 
+struct bnge_pf_info {
+	u16	fw_fid;
+	u16	port_id;
+	u8	mac_addr[ETH_ALEN];
+};
+
 #define INVALID_HW_RING_ID      ((u16)-1)
 
 enum {
@@ -56,10 +63,23 @@ enum {
 enum {
 	BNGE_EN_ROCE_V1					= BIT_ULL(0),
 	BNGE_EN_ROCE_V2					= BIT_ULL(1),
+	BNGE_EN_STRIP_VLAN				= BIT_ULL(2),
+	BNGE_EN_SHARED_CHNL				= BIT_ULL(3),
 };
 
 #define BNGE_EN_ROCE		(BNGE_EN_ROCE_V1 | BNGE_EN_ROCE_V2)
 
+enum {
+	BNGE_RSS_CAP_RSS_HASH_TYPE_DELTA		= BIT(0),
+	BNGE_RSS_CAP_UDP_RSS_CAP			= BIT(1),
+	BNGE_RSS_CAP_NEW_RSS_CAP			= BIT(2),
+	BNGE_RSS_CAP_RSS_TCAM				= BIT(3),
+	BNGE_RSS_CAP_AH_V4_RSS_CAP			= BIT(4),
+	BNGE_RSS_CAP_AH_V6_RSS_CAP			= BIT(5),
+	BNGE_RSS_CAP_ESP_V4_RSS_CAP			= BIT(6),
+	BNGE_RSS_CAP_ESP_V6_RSS_CAP			= BIT(7),
+};
+
 struct bnge_dev {
 	struct device	*dev;
 	struct pci_dev	*pdev;
@@ -73,6 +93,9 @@ struct bnge_dev {
 	u16		chip_num;
 	u8		chip_rev;
 
+	int		db_offset; /* db_offset within db_size */
+	int		db_size;
+
 	/* HWRM members */
 	u16			hwrm_cmd_seq;
 	u16			hwrm_cmd_kong_seq;
@@ -93,6 +116,8 @@ struct bnge_dev {
 #define BNGE_FW_VER_CODE(maj, min, bld, rsv)			\
 	((u64)(maj) << 48 | (u64)(min) << 32 | (u64)(bld) << 16 | (rsv))
 
+	struct bnge_pf_info	pf;
+
 	unsigned long           state;
 #define BNGE_STATE_DRV_REGISTERED      0
 
@@ -102,6 +127,51 @@ struct bnge_dev {
 	struct bnge_ctx_mem_info	*ctx;
 
 	u64			flags;
+
+	struct bnge_hw_resc	hw_resc;
+
+	u16			tso_max_segs;
+
+	int			max_fltr;
+#define BNGE_L2_FLTR_MAX_FLTR	1024
+
+	u32			*rss_indir_tbl;
+#define BNGE_RSS_TABLE_ENTRIES	64
+#define BNGE_RSS_TABLE_SIZE		(BNGE_RSS_TABLE_ENTRIES * 4)
+#define BNGE_RSS_TABLE_MAX_TBL	8
+#define BNGE_MAX_RSS_TABLE_SIZE				\
+	(BNGE_RSS_TABLE_SIZE * BNGE_RSS_TABLE_MAX_TBL)
+#define BNGE_MAX_RSS_TABLE_ENTRIES				\
+	(BNGE_RSS_TABLE_ENTRIES * BNGE_RSS_TABLE_MAX_TBL)
+	u16			rss_indir_tbl_entries;
+
+	u32			rss_cap;
+
+	u16			rx_nr_rings;
+	u16			tx_nr_rings;
+	u16			tx_nr_rings_per_tc;
+	/* Number of NQs */
+	u16			nq_nr_rings;
+
+	/* Aux device resources */
+	u16			aux_num_msix;
+	u16			aux_num_stat_ctxs;
+
+	u16			max_mtu;
+#define BNGE_MAX_MTU		9500
+
+	u16			hw_ring_stats_size;
+#define BNGE_NUM_RX_RING_STATS			8
+#define BNGE_NUM_TX_RING_STATS			8
+#define BNGE_NUM_TPA_RING_STATS			6
+#define BNGE_RING_STATS_SIZE					\
+	((BNGE_NUM_RX_RING_STATS + BNGE_NUM_TX_RING_STATS +	\
+	  BNGE_NUM_TPA_RING_STATS) * 8)
+
+	u16			max_tpa_v2;
+#define BNGE_SUPPORTS_TPA(bd)	((bd)->max_tpa_v2)
+
+	u8                      num_tc;
 };
 
 static inline bool bnge_is_roce_en(struct bnge_dev *bd)
@@ -109,4 +179,11 @@ static inline bool bnge_is_roce_en(struct bnge_dev *bd)
 	return bd->flags & BNGE_EN_ROCE;
 }
 
+static inline bool bnge_is_agg_reqd(struct bnge_dev *bd)
+{
+	return true;
+}
+
+bool bnge_aux_registered(struct bnge_dev *bd);
+
 #endif /* _BNGE_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_core.c b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
index c6e2f965017a..47d56f7c28af 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_core.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
@@ -39,6 +39,11 @@ static void bnge_print_device_info(struct pci_dev *pdev, enum board_idx idx)
 	pcie_print_link_status(pdev);
 }
 
+bool bnge_aux_registered(struct bnge_dev *bd)
+{
+	return false;
+}
+
 static void bnge_nvm_cfg_ver_get(struct bnge_dev *bd)
 {
 	struct hwrm_nvm_get_dev_info_output nvm_info;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm.h b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm.h
index c99aa8406b14..012aa4fa5aa9 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm.h
@@ -107,5 +107,4 @@ int bnge_hwrm_req_send_silent(struct bnge_dev *bd, void *req);
 void bnge_hwrm_req_alloc_flags(struct bnge_dev *bd, void *req, gfp_t flags);
 void *bnge_hwrm_req_dma_slice(struct bnge_dev *bd, void *req, u32 size,
 			      dma_addr_t *dma);
-
 #endif /* _BNGE_HWRM_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index dc69bd1461f9..ee2675776c14 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
@@ -11,6 +11,7 @@
 #include "bnge_hwrm.h"
 #include "bnge_hwrm_lib.h"
 #include "bnge_rmem.h"
+#include "bnge_resc.h"
 
 int bnge_hwrm_ver_get(struct bnge_dev *bd)
 {
@@ -379,3 +380,270 @@ int bnge_hwrm_func_backing_store(struct bnge_dev *bd,
 
 	return rc;
 }
+
+static int bnge_hwrm_get_rings(struct bnge_dev *bd)
+{
+	struct bnge_hw_resc *hw_resc = &bd->hw_resc;
+	struct hwrm_func_qcfg_output *resp;
+	struct hwrm_func_qcfg_input *req;
+	u16 cp, stats;
+	u16 rx, tx;
+	int rc;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_FUNC_QCFG);
+	if (rc)
+		return rc;
+
+	req->fid = cpu_to_le16(0xffff);
+	resp = bnge_hwrm_req_hold(bd, req);
+	rc = bnge_hwrm_req_send(bd, req);
+	if (rc) {
+		bnge_hwrm_req_drop(bd, req);
+		return rc;
+	}
+
+	hw_resc->resv_tx_rings = le16_to_cpu(resp->alloc_tx_rings);
+	hw_resc->resv_rx_rings = le16_to_cpu(resp->alloc_rx_rings);
+	hw_resc->resv_hw_ring_grps =
+		le32_to_cpu(resp->alloc_hw_ring_grps);
+	hw_resc->resv_vnics = le16_to_cpu(resp->alloc_vnics);
+	hw_resc->resv_rsscos_ctxs = le16_to_cpu(resp->alloc_rsscos_ctx);
+	cp = le16_to_cpu(resp->alloc_cmpl_rings);
+	stats = le16_to_cpu(resp->alloc_stat_ctx);
+	hw_resc->resv_irqs = cp;
+	rx = hw_resc->resv_rx_rings;
+	tx = hw_resc->resv_tx_rings;
+	if (bnge_is_agg_reqd(bd))
+		rx >>= 1;
+	if (cp < (rx + tx)) {
+		rc = bnge_fix_rings_count(&rx, &tx, cp, false);
+		if (rc)
+			goto get_rings_exit;
+		if (bnge_is_agg_reqd(bd))
+			rx <<= 1;
+		hw_resc->resv_rx_rings = rx;
+		hw_resc->resv_tx_rings = tx;
+	}
+	hw_resc->resv_irqs = le16_to_cpu(resp->alloc_msix);
+	hw_resc->resv_hw_ring_grps = rx;
+	hw_resc->resv_cp_rings = cp;
+	hw_resc->resv_stat_ctxs = stats;
+
+get_rings_exit:
+	bnge_hwrm_req_drop(bd, req);
+	return rc;
+}
+
+static struct hwrm_func_cfg_input *
+__bnge_hwrm_reserve_pf_rings(struct bnge_dev *bd, struct bnge_hw_rings *hwr)
+{
+	struct hwrm_func_cfg_input *req;
+	u32 enables = 0;
+
+	if (bnge_hwrm_req_init(bd, req, HWRM_FUNC_QCFG))
+		return NULL;
+
+	req->fid = cpu_to_le16(0xffff);
+	enables |= hwr->tx ? FUNC_CFG_REQ_ENABLES_NUM_TX_RINGS : 0;
+	req->num_tx_rings = cpu_to_le16(hwr->tx);
+
+	enables |= hwr->rx ? FUNC_CFG_REQ_ENABLES_NUM_RX_RINGS : 0;
+	enables |= hwr->stat ? FUNC_CFG_REQ_ENABLES_NUM_STAT_CTXS : 0;
+	enables |= hwr->nq ? FUNC_CFG_REQ_ENABLES_NUM_MSIX : 0;
+	enables |= hwr->cmpl ? FUNC_CFG_REQ_ENABLES_NUM_CMPL_RINGS : 0;
+	enables |= hwr->vnic ? FUNC_CFG_REQ_ENABLES_NUM_VNICS : 0;
+	enables |= hwr->rss_ctx ? FUNC_CFG_REQ_ENABLES_NUM_RSSCOS_CTXS : 0;
+
+	req->num_rx_rings = cpu_to_le16(hwr->rx);
+	req->num_rsscos_ctxs = cpu_to_le16(hwr->rss_ctx);
+	req->num_cmpl_rings = cpu_to_le16(hwr->cmpl);
+	req->num_msix = cpu_to_le16(hwr->nq);
+	req->num_stat_ctxs = cpu_to_le16(hwr->stat);
+	req->num_vnics = cpu_to_le16(hwr->vnic);
+	req->enables = cpu_to_le32(enables);
+
+	return req;
+}
+
+static int
+bnge_hwrm_reserve_pf_rings(struct bnge_dev *bd, struct bnge_hw_rings *hwr)
+{
+	struct hwrm_func_cfg_input *req;
+	int rc;
+
+	req = __bnge_hwrm_reserve_pf_rings(bd, hwr);
+	if (!req)
+		return -ENOMEM;
+
+	if (!req->enables) {
+		bnge_hwrm_req_drop(bd, req);
+		return 0;
+	}
+
+	rc = bnge_hwrm_req_send(bd, req);
+	if (rc)
+		return rc;
+
+	return bnge_hwrm_get_rings(bd);
+}
+
+int bnge_hwrm_reserve_rings(struct bnge_dev *bd, struct bnge_hw_rings *hwr)
+{
+	return bnge_hwrm_reserve_pf_rings(bd, hwr);
+}
+
+int bnge_hwrm_func_qcfg(struct bnge_dev *bd)
+{
+	struct hwrm_func_qcfg_output *resp;
+	struct hwrm_func_qcfg_input *req;
+	int rc;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_FUNC_QCFG);
+	if (rc)
+		return rc;
+
+	req->fid = cpu_to_le16(0xffff);
+	resp = bnge_hwrm_req_hold(bd, req);
+	rc = bnge_hwrm_req_send(bd, req);
+	if (rc)
+		goto func_qcfg_exit;
+
+	bd->max_mtu = le16_to_cpu(resp->max_mtu_configured);
+	if (!bd->max_mtu)
+		bd->max_mtu = BNGE_MAX_MTU;
+
+	if (bd->db_size)
+		goto func_qcfg_exit;
+
+	bd->db_offset = le16_to_cpu(resp->legacy_l2_db_size_kb) * 1024;
+	bd->db_size = PAGE_ALIGN(le16_to_cpu(resp->l2_doorbell_bar_size_kb) *
+			1024);
+	if (!bd->db_size || bd->db_size > pci_resource_len(bd->pdev, 2) ||
+	    bd->db_size <= bd->db_offset)
+		bd->db_size = pci_resource_len(bd->pdev, 2);
+
+func_qcfg_exit:
+	bnge_hwrm_req_drop(bd, req);
+	return rc;
+}
+
+int bnge_hwrm_func_resc_qcaps(struct bnge_dev *bd)
+{
+	struct hwrm_func_resource_qcaps_output *resp;
+	struct bnge_hw_resc *hw_resc = &bd->hw_resc;
+	struct hwrm_func_resource_qcaps_input *req;
+	int rc;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_FUNC_RESOURCE_QCAPS);
+	if (rc)
+		return rc;
+
+	req->fid = cpu_to_le16(0xffff);
+	resp = bnge_hwrm_req_hold(bd, req);
+	rc = bnge_hwrm_req_send_silent(bd, req);
+	if (rc)
+		goto hwrm_func_resc_qcaps_exit;
+
+	hw_resc->max_tx_sch_inputs = le16_to_cpu(resp->max_tx_scheduler_inputs);
+	hw_resc->min_rsscos_ctxs = le16_to_cpu(resp->min_rsscos_ctx);
+	hw_resc->max_rsscos_ctxs = le16_to_cpu(resp->max_rsscos_ctx);
+	hw_resc->min_cp_rings = le16_to_cpu(resp->min_cmpl_rings);
+	hw_resc->max_cp_rings = le16_to_cpu(resp->max_cmpl_rings);
+	hw_resc->min_tx_rings = le16_to_cpu(resp->min_tx_rings);
+	hw_resc->max_tx_rings = le16_to_cpu(resp->max_tx_rings);
+	hw_resc->min_rx_rings = le16_to_cpu(resp->min_rx_rings);
+	hw_resc->max_rx_rings = le16_to_cpu(resp->max_rx_rings);
+	hw_resc->min_hw_ring_grps = le16_to_cpu(resp->min_hw_ring_grps);
+	hw_resc->max_hw_ring_grps = le16_to_cpu(resp->max_hw_ring_grps);
+	hw_resc->min_l2_ctxs = le16_to_cpu(resp->min_l2_ctxs);
+	hw_resc->max_l2_ctxs = le16_to_cpu(resp->max_l2_ctxs);
+	hw_resc->min_vnics = le16_to_cpu(resp->min_vnics);
+	hw_resc->max_vnics = le16_to_cpu(resp->max_vnics);
+	hw_resc->min_stat_ctxs = le16_to_cpu(resp->min_stat_ctx);
+	hw_resc->max_stat_ctxs = le16_to_cpu(resp->max_stat_ctx);
+
+	hw_resc->max_nqs = le16_to_cpu(resp->max_msix);
+	hw_resc->max_hw_ring_grps = hw_resc->max_rx_rings;
+
+hwrm_func_resc_qcaps_exit:
+	bnge_hwrm_req_drop(bd, req);
+	return rc;
+}
+
+int bnge_hwrm_func_qcaps(struct bnge_dev *bd)
+{
+	struct hwrm_func_qcaps_output *resp;
+	struct hwrm_func_qcaps_input *req;
+	struct bnge_pf_info *pf = &bd->pf;
+	u32 flags;
+	int rc;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_FUNC_QCAPS);
+	if (rc)
+		return rc;
+
+	req->fid = cpu_to_le16(0xffff);
+	resp = bnge_hwrm_req_hold(bd, req);
+	rc = bnge_hwrm_req_send(bd, req);
+	if (rc)
+		goto hwrm_func_qcaps_exit;
+
+	flags = le32_to_cpu(resp->flags);
+	if (flags & FUNC_QCAPS_RESP_FLAGS_ROCE_V1_SUPPORTED)
+		bd->flags |= BNGE_EN_ROCE_V1;
+	if (flags & FUNC_QCAPS_RESP_FLAGS_ROCE_V2_SUPPORTED)
+		bd->flags |= BNGE_EN_ROCE_V2;
+
+	pf->fw_fid = le16_to_cpu(resp->fid);
+	pf->port_id = le16_to_cpu(resp->port_id);
+	memcpy(pf->mac_addr, resp->mac_address, ETH_ALEN);
+
+	bd->tso_max_segs = le16_to_cpu(resp->max_tso_segs);
+
+hwrm_func_qcaps_exit:
+	bnge_hwrm_req_drop(bd, req);
+	return rc;
+}
+
+int bnge_hwrm_vnic_qcaps(struct bnge_dev *bd)
+{
+	struct hwrm_vnic_qcaps_output *resp;
+	struct hwrm_vnic_qcaps_input *req;
+	int rc;
+
+	bd->hw_ring_stats_size = sizeof(struct ctx_hw_stats);
+	bd->rss_cap &= ~BNGE_RSS_CAP_NEW_RSS_CAP;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_VNIC_QCAPS);
+	if (rc)
+		return rc;
+
+	resp = bnge_hwrm_req_hold(bd, req);
+	rc = bnge_hwrm_req_send(bd, req);
+	if (!rc) {
+		u32 flags = le32_to_cpu(resp->flags);
+
+		if (flags & VNIC_QCAPS_RESP_FLAGS_VLAN_STRIP_CAP)
+			bd->fw_cap |= BNGE_FW_CAP_VLAN_RX_STRIP;
+		if (flags & VNIC_QCAPS_RESP_FLAGS_RSS_HASH_TYPE_DELTA_CAP)
+			bd->rss_cap |= BNGE_RSS_CAP_RSS_HASH_TYPE_DELTA;
+		if (flags & VNIC_QCAPS_RESP_FLAGS_RSS_PROF_TCAM_MODE_ENABLED)
+			bd->rss_cap |= BNGE_RSS_CAP_RSS_TCAM;
+		bd->max_tpa_v2 = le16_to_cpu(resp->max_aggs_supported);
+		if (bd->max_tpa_v2)
+			bd->hw_ring_stats_size = BNGE_RING_STATS_SIZE;
+		if (flags & VNIC_QCAPS_RESP_FLAGS_HW_TUNNEL_TPA_CAP)
+			bd->fw_cap |= BNGE_FW_CAP_VNIC_TUNNEL_TPA;
+		if (flags & VNIC_QCAPS_RESP_FLAGS_RSS_IPSEC_AH_SPI_IPV4_CAP)
+			bd->rss_cap |= BNGE_RSS_CAP_AH_V4_RSS_CAP;
+		if (flags & VNIC_QCAPS_RESP_FLAGS_RSS_IPSEC_AH_SPI_IPV6_CAP)
+			bd->rss_cap |= BNGE_RSS_CAP_AH_V6_RSS_CAP;
+		if (flags & VNIC_QCAPS_RESP_FLAGS_RSS_IPSEC_ESP_SPI_IPV4_CAP)
+			bd->rss_cap |= BNGE_RSS_CAP_ESP_V4_RSS_CAP;
+		if (flags & VNIC_QCAPS_RESP_FLAGS_RSS_IPSEC_ESP_SPI_IPV6_CAP)
+			bd->rss_cap |= BNGE_RSS_CAP_ESP_V6_RSS_CAP;
+	}
+	bnge_hwrm_req_drop(bd, req);
+
+	return rc;
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
index c04291d74bf0..59ec1899879a 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
@@ -16,5 +16,11 @@ int bnge_hwrm_func_backing_store(struct bnge_dev *bd,
 				 struct bnge_ctx_mem_type *ctxm,
 				 bool last);
 int bnge_hwrm_func_backing_store_qcaps(struct bnge_dev *bd);
+int bnge_hwrm_reserve_rings(struct bnge_dev *bd,
+			    struct bnge_hw_rings *hwr);
+int bnge_hwrm_func_qcaps(struct bnge_dev *bd);
+int bnge_hwrm_vnic_qcaps(struct bnge_dev *bd);
+int bnge_hwrm_func_qcfg(struct bnge_dev *bd);
+int bnge_hwrm_func_resc_qcaps(struct bnge_dev *bd);
 
 #endif /* _BNGE_HWRM_LIB_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
new file mode 100644
index 000000000000..68e094474822
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
@@ -0,0 +1,328 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2025 Broadcom.
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/ethtool.h>
+
+#include "bnge.h"
+#include "bnge_hwrm.h"
+#include "bnge_hwrm_lib.h"
+#include "bnge_resc.h"
+
+static u16 bnge_num_tx_to_cp(struct bnge_dev *bd, u16 tx)
+{
+	u16 tcs = bd->num_tc;
+
+	if (!tcs)
+		tcs = 1;
+
+	return tx / tcs;
+}
+
+static u16 bnge_get_max_func_irqs(struct bnge_dev *bd)
+{
+	struct bnge_hw_resc *hw_resc = &bd->hw_resc;
+
+	return min_t(u16, hw_resc->max_irqs, hw_resc->max_nqs);
+}
+
+static int bnge_aux_get_dflt_msix(struct bnge_dev *bd)
+{
+	int roce_msix = BNGE_MAX_ROCE_MSIX;
+
+	return min_t(int, roce_msix, num_online_cpus() + 1);
+}
+
+static u16 bnge_aux_get_msix(struct bnge_dev *bd)
+{
+	if (bnge_is_roce_en(bd))
+		return bd->aux_num_msix;
+
+	return 0;
+}
+
+static void bnge_aux_set_msix_num(struct bnge_dev *bd, u16 num)
+{
+	if (bnge_is_roce_en(bd))
+		bd->aux_num_msix = num;
+}
+
+static u16 bnge_aux_get_stat_ctxs(struct bnge_dev *bd)
+{
+	if (bnge_is_roce_en(bd))
+		return bd->aux_num_stat_ctxs;
+
+	return 0;
+}
+
+static void bnge_aux_set_stat_ctxs(struct bnge_dev *bd, u16 num_aux_ctx)
+{
+	if (bnge_is_roce_en(bd))
+		bd->aux_num_stat_ctxs = num_aux_ctx;
+}
+
+static u16 bnge_func_stat_ctxs_demand(struct bnge_dev *bd)
+{
+	return bd->nq_nr_rings + bnge_aux_get_stat_ctxs(bd);
+}
+
+static u16 bnge_nqs_demand(struct bnge_dev *bd)
+{
+	return bd->nq_nr_rings + bnge_aux_get_msix(bd);
+}
+
+static u16 bnge_cprs_demand(struct bnge_dev *bd)
+{
+	return bd->tx_nr_rings + bd->rx_nr_rings;
+}
+
+static u16 bnge_get_avail_msix(struct bnge_dev *bd, int num)
+{
+	u16 max_irq = bnge_get_max_func_irqs(bd);
+	u16 total_demand = bd->nq_nr_rings + num;
+
+	if (max_irq < total_demand) {
+		num = max_irq - bd->nq_nr_rings;
+		if (num <= 0)
+			return 0;
+	}
+
+	return num;
+}
+
+static u16 bnge_num_cp_to_tx(struct bnge_dev *bd, u16 tx_chunks)
+{
+	return tx_chunks * bd->num_tc;
+}
+
+int bnge_fix_rings_count(u16 *rx, u16 *tx, u16 max, bool shared)
+{
+	u16 _rx = *rx, _tx = *tx;
+
+	if (shared) {
+		*rx = min_t(u16, _rx, max);
+		*tx = min_t(u16, _tx, max);
+	} else {
+		if (max < 2)
+			return -ENOMEM;
+		while (_rx + _tx > max) {
+			if (_rx > _tx && _rx > 1)
+				_rx--;
+			else if (_tx > 1)
+				_tx--;
+		}
+		*rx = _rx;
+		*tx = _tx;
+	}
+
+	return 0;
+}
+
+static int bnge_adjust_rings(struct bnge_dev *bd, u16 *rx,
+			     u16 *tx, u16 max_nq, bool sh)
+{
+	u16 tx_chunks = bnge_num_tx_to_cp(bd, *tx);
+
+	if (tx_chunks != *tx) {
+		u16 tx_saved = tx_chunks, rc;
+
+		rc = bnge_fix_rings_count(rx, &tx_chunks, max_nq, sh);
+		if (rc)
+			return rc;
+		if (tx_chunks != tx_saved)
+			*tx = bnge_num_cp_to_tx(bd, tx_chunks);
+		return 0;
+	}
+
+	return bnge_fix_rings_count(rx, tx, max_nq, sh);
+}
+
+static int bnge_cal_nr_rss_ctxs(u16 rx_rings)
+{
+	if (!rx_rings)
+		return 0;
+
+	return bnge_adjust_pow_two(rx_rings - 1,
+				   BNGE_RSS_TABLE_ENTRIES);
+}
+
+static u16 bnge_rss_ctxs_in_use(struct bnge_dev *bd,
+				struct bnge_hw_rings *hwr)
+{
+	return bnge_cal_nr_rss_ctxs(hwr->grp);
+}
+
+static u16 bnge_get_total_vnics(struct bnge_dev *bd, u16 rx_rings)
+{
+	return 1;
+}
+
+static u32 bnge_get_rxfh_indir_size(struct bnge_dev *bd)
+{
+	return bnge_cal_nr_rss_ctxs(bd->rx_nr_rings) *
+	       BNGE_RSS_TABLE_ENTRIES;
+}
+
+static void bnge_set_dflt_rss_indir_tbl(struct bnge_dev *bd)
+{
+	u16 max_entries, pad;
+	u32 *rss_indir_tbl;
+	int i;
+
+	max_entries = bnge_get_rxfh_indir_size(bd);
+	rss_indir_tbl = &bd->rss_indir_tbl[0];
+
+	for (i = 0; i < max_entries; i++)
+		rss_indir_tbl[i] = ethtool_rxfh_indir_default(i,
+							      bd->rx_nr_rings);
+
+	pad = bd->rss_indir_tbl_entries - max_entries;
+	if (pad)
+		memset(&rss_indir_tbl[i], 0, pad * sizeof(*rss_indir_tbl));
+}
+
+static void bnge_copy_reserved_rings(struct bnge_dev *bd,
+				     struct bnge_hw_rings *hwr)
+{
+	struct bnge_hw_resc *hw_resc = &bd->hw_resc;
+
+	hwr->tx = hw_resc->resv_tx_rings;
+	hwr->rx = hw_resc->resv_rx_rings;
+	hwr->nq = hw_resc->resv_irqs;
+	hwr->cmpl = hw_resc->resv_cp_rings;
+	hwr->grp = hw_resc->resv_hw_ring_grps;
+	hwr->vnic = hw_resc->resv_vnics;
+	hwr->stat = hw_resc->resv_stat_ctxs;
+	hwr->rss_ctx = hw_resc->resv_rsscos_ctxs;
+}
+
+static bool bnge_rings_ok(struct bnge_hw_rings *hwr)
+{
+	return hwr->tx && hwr->rx && hwr->nq && hwr->grp && hwr->vnic &&
+	       hwr->stat && hwr->cmpl;
+}
+
+static bool bnge_need_reserve_rings(struct bnge_dev *bd)
+{
+	struct bnge_hw_resc *hw_resc = &bd->hw_resc;
+	u16 cprs = bnge_cprs_demand(bd);
+	u16 rx = bd->rx_nr_rings, stat;
+	u16 nqs = bnge_nqs_demand(bd);
+	u16 vnic;
+
+	if (hw_resc->resv_tx_rings != bd->tx_nr_rings)
+		return true;
+
+	vnic = bnge_get_total_vnics(bd, rx);
+
+	if (bnge_is_agg_reqd(bd))
+		rx <<= 1;
+	stat = bnge_func_stat_ctxs_demand(bd);
+	if (hw_resc->resv_rx_rings != rx || hw_resc->resv_cp_rings != cprs ||
+	    hw_resc->resv_vnics != vnic || hw_resc->resv_stat_ctxs != stat)
+		return true;
+	if (hw_resc->resv_irqs != nqs)
+		return true;
+
+	return false;
+}
+
+int bnge_reserve_rings(struct bnge_dev *bd)
+{
+	u16 aux_dflt_msix = bnge_aux_get_dflt_msix(bd);
+	struct bnge_hw_rings hwr = {0};
+	u16 rx_rings, old_rx_rings;
+	u16 nq = bd->nq_nr_rings;
+	u16 aux_msix = 0;
+	bool sh = false;
+	u16 tx_cp;
+	int rc;
+
+	if (!bnge_need_reserve_rings(bd))
+		return 0;
+
+	if (!bnge_aux_registered(bd)) {
+		aux_msix = bnge_get_avail_msix(bd, aux_dflt_msix);
+		if (!aux_msix)
+			bnge_aux_set_stat_ctxs(bd, 0);
+
+		if (aux_msix > aux_dflt_msix)
+			aux_msix = aux_dflt_msix;
+		hwr.nq = nq + aux_msix;
+	} else {
+		hwr.nq = bnge_nqs_demand(bd);
+	}
+
+	hwr.tx = bd->tx_nr_rings;
+	hwr.rx = bd->rx_nr_rings;
+	if (bd->flags & BNGE_EN_SHARED_CHNL)
+		sh = true;
+	hwr.cmpl = hwr.rx + hwr.tx;
+
+	hwr.vnic = bnge_get_total_vnics(bd, hwr.rx);
+
+	if (bnge_is_agg_reqd(bd))
+		hwr.rx <<= 1;
+	hwr.grp = bd->rx_nr_rings;
+	hwr.rss_ctx = bnge_rss_ctxs_in_use(bd, &hwr);
+	hwr.stat = bnge_func_stat_ctxs_demand(bd);
+	old_rx_rings = bd->hw_resc.resv_rx_rings;
+
+	rc = bnge_hwrm_reserve_rings(bd, &hwr);
+	if (rc)
+		return rc;
+
+	bnge_copy_reserved_rings(bd, &hwr);
+
+	rx_rings = hwr.rx;
+	if (bnge_is_agg_reqd(bd)) {
+		if (hwr.rx >= 2)
+			rx_rings = hwr.rx >> 1;
+		else
+			return -ENOMEM;
+	}
+
+	rx_rings = min_t(u16, rx_rings, hwr.grp);
+	hwr.nq = min_t(u16, hwr.nq, bd->nq_nr_rings);
+	if (hwr.stat > bnge_aux_get_stat_ctxs(bd))
+		hwr.stat -= bnge_aux_get_stat_ctxs(bd);
+	hwr.nq = min_t(u16, hwr.nq, hwr.stat);
+
+	/* Adjust the rings */
+	rc = bnge_adjust_rings(bd, &rx_rings, &hwr.tx, hwr.nq, sh);
+	if (bnge_is_agg_reqd(bd))
+		hwr.rx = rx_rings << 1;
+	tx_cp = hwr.tx;
+	hwr.nq = sh ? max_t(u16, tx_cp, rx_rings) : tx_cp + rx_rings;
+	bd->tx_nr_rings = hwr.tx;
+
+	if (rx_rings != bd->rx_nr_rings)
+		dev_warn(bd->dev, "RX rings resv reduced to %d than earlier %d requested\n",
+			 rx_rings, bd->rx_nr_rings);
+
+	bd->rx_nr_rings = rx_rings;
+	bd->nq_nr_rings = hwr.nq;
+
+	if (!bnge_rings_ok(&hwr))
+		return -ENOMEM;
+
+	if (old_rx_rings != bd->hw_resc.resv_rx_rings)
+		bnge_set_dflt_rss_indir_tbl(bd);
+
+	if (!bnge_aux_registered(bd)) {
+		u16 resv_msix, resv_ctx, aux_ctxs;
+		struct bnge_hw_resc *hw_resc;
+
+		hw_resc = &bd->hw_resc;
+		resv_msix = hw_resc->resv_irqs - bd->nq_nr_rings;
+		aux_msix = min_t(u16, resv_msix, aux_msix);
+		bnge_aux_set_msix_num(bd, aux_msix);
+		resv_ctx = hw_resc->resv_stat_ctxs  - bd->nq_nr_rings;
+		aux_ctxs = min(resv_ctx, bnge_aux_get_stat_ctxs(bd));
+		bnge_aux_set_stat_ctxs(bd, aux_ctxs);
+	}
+
+	return rc;
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.h b/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
new file mode 100644
index 000000000000..c6cef514588f
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2025 Broadcom */
+
+#ifndef _BNGE_RESC_H_
+#define _BNGE_RESC_H_
+
+struct bnge_hw_resc {
+	u16	min_rsscos_ctxs;
+	u16	max_rsscos_ctxs;
+	u16	resv_rsscos_ctxs;
+	u16	min_cp_rings;
+	u16	max_cp_rings;
+	u16	resv_cp_rings;
+	u16	min_tx_rings;
+	u16	max_tx_rings;
+	u16	resv_tx_rings;
+	u16	max_tx_sch_inputs;
+	u16	min_rx_rings;
+	u16	max_rx_rings;
+	u16	resv_rx_rings;
+	u16	min_hw_ring_grps;
+	u16	max_hw_ring_grps;
+	u16	resv_hw_ring_grps;
+	u16	min_l2_ctxs;
+	u16	max_l2_ctxs;
+	u16	min_vnics;
+	u16	max_vnics;
+	u16	resv_vnics;
+	u16	min_stat_ctxs;
+	u16	max_stat_ctxs;
+	u16	resv_stat_ctxs;
+	u16	max_nqs;
+	u16	max_irqs;
+	u16	resv_irqs;
+	u32	max_encap_records;
+	u32	max_decap_records;
+	u32	max_tx_em_flows;
+	u32	max_tx_wm_flows;
+	u32	max_rx_em_flows;
+	u32	max_rx_wm_flows;
+};
+
+struct bnge_hw_rings {
+	u16 tx;
+	u16 rx;
+	u16 grp;
+	u16 nq;
+	u16 cmpl;
+	u16 stat;
+	u16 vnic;
+	u16 rss_ctx;
+};
+
+int bnge_reserve_rings(struct bnge_dev *bd);
+int bnge_fix_rings_count(u16 *rx, u16 *tx, u16 max, bool shared);
+
+static inline u32
+bnge_adjust_pow_two(u32 total_ent, u16 ent_per_blk)
+{
+	u32 blks = total_ent / ent_per_blk;
+
+	if (blks == 0 || blks == 1)
+		return ++blks;
+
+	if (!is_power_of_2(blks))
+		blks = roundup_pow_of_two(blks);
+
+	return blks;
+}
+
+#define BNGE_MAX_ROCE_MSIX		64
+#define BNGE_MIN_ROCE_CP_RINGS		2
+#define BNGE_MIN_ROCE_STAT_CTXS		1
+
+#endif /* _BNGE_RESC_H_ */
-- 
2.47.1


