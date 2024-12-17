Return-Path: <netdev+bounces-152681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B8C9F561E
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 19:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BDA97A36D6
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 18:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB561F8AD1;
	Tue, 17 Dec 2024 18:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HCxAshJD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8BE1F8930
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 18:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734460025; cv=none; b=LcA1/V1Z3k+HzzFu2XfyJgrbmLRMoEkXpsO9mctYxpgA+DuwE9DPIThJmBgbH1qB1RAXoOhRyQ42vcuSDHtnJK+UF28i+tXcYx4XQPblqQS5yOT3XLq1mQUftIg1tK+5hmyidf89fmtFF+ShaO8JjucSPPYQ5HW9ILn0MwHmbYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734460025; c=relaxed/simple;
	bh=ZTSBeoNYM5iuQnBZrcSyHM59ujLcUngYFpbh0rRDZ3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JH+8ajsGI5i8NZqyt9pf8cVPBB5oAp3M89HbwZ72wCIv8heTfsdShG55cKi6LIMKBwkdkb0bUgT8B/hd9onhUKFz01jp1HMoud8bX+vfp5LRs2EelPtNkxCbnZmMbtX2O+fWjohTBVNbRO9E3JtBD1PdpKBsdWHnU3LiBr4lYOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HCxAshJD; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-216281bc30fso59068515ad.0
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 10:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1734460023; x=1735064823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnrFzAMZ8v5VlMMYSKXe6yf+DpgsVC5sU2V1pw3sIL4=;
        b=HCxAshJDMdJNhH8pv5sDxO1EViaRCT9OFmORi4bYBSdN90YC6vbkrKzZG642QeoUTQ
         6ycsexcrhaqxGo16u4lWXjQIFUNF1C2MatmgZJequxN0W+utDjaonET0Jbe94HrkmPWZ
         NdsppEvwc7g696vtqvdHyH0L2MIwk4zM3+75s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734460023; x=1735064823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JnrFzAMZ8v5VlMMYSKXe6yf+DpgsVC5sU2V1pw3sIL4=;
        b=Du/8aUUBGcZiRS35Jhe/86+uXKgp8AsD4fzJwVSxgGbZW25h4QK8c5TcGiE+SHskxS
         n37swfpxIpeRIHGIgF1IWFUpzO5VDSjq1BTyQpGAXLxKgHsxhqlcqfD7IFmylqjoAL5q
         ufxDDBke1AqGZHu8WI74Vd66lWt5+Nzwz7P2+DwI16et7FYDYzGuYhwcxukeiTwxFhhH
         73uvQgbKpL7r640QucFFUYIoZge+NVYcY7sXYYDtu8HP2iy9FxVvZCUu9r5aADeIN+io
         WNUGDITzjtouSGiAsBr25NN0oi915DLLr02si8WvyYOYZRlOO2tHEK7SmuKDzD4drpgN
         7nfw==
X-Gm-Message-State: AOJu0YyyC32oeCDH9R4u5DsDlKOQiX58hTyoNs52ZSRlU3nfknoVhNuA
	NAGsTUtW32NhF/898Zyou2iyrn4HizQGt5IgmmayiPqopv50B1uS75637Kkt4Q==
X-Gm-Gg: ASbGnctEVlVGhuRAkb+lXpCYKeHIzqZcq1B7iGBNss0o0c3MWRSNuo5QYNGAEDakRHV
	2ySMGVCwmGM9FQDmgHS0KcaZUu7Jabz4VR7ufh6y0k2t8iAWBXM5XZx1nPgPkT/iGy/aUb53IZI
	k4+VoJn33TwpVX50jLOKgNqqH7ra/si9UnZoEU3HemSoSUIOjRjIvV5gTiBp6bysWZXGFS6qvFS
	avNFS6zkxZ8RhVNTaaDdBsPKMbzX6E+YeBKuvQ+Dd6i6VT64sWnVQCXJc9OXVdKjZqS0+OXmpTx
	U0x94TbWtEQFFpJzf3k6B0jPzRSoThXh
X-Google-Smtp-Source: AGHT+IH13FX+qr3yJHpQSF9362IRYBQCjHgFaRJkL/QM4ZfFDWU+ap9nOfeMwu654FCidEGrrWILgQ==
X-Received: by 2002:a17:902:c40e:b0:215:a18f:88a8 with SMTP id d9443c01a7336-218d52d0775mr7485245ad.51.1734460022745;
        Tue, 17 Dec 2024 10:27:02 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e63af1sm62496595ad.226.2024.12.17.10.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 10:27:02 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Hongguang Gao <hongguang.gao@broadcom.com>,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH net-next v2 1/6] bnxt_en: Use FW defined resource limits for RoCE
Date: Tue, 17 Dec 2024 10:26:15 -0800
Message-ID: <20241217182620.2454075-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20241217182620.2454075-1-michael.chan@broadcom.com>
References: <20241217182620.2454075-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongguang Gao <hongguang.gao@broadcom.com>

If FW supports setting resource limits for RoCE, then just use the
FW limits instead of using some fixed values in the driver.  These
limits will be used to allocate context memory for QP, SRQ, AH, and
MR resources for RoCE.

Reviewed-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Hongguang Gao <hongguang.gao@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 41 +++++++++++++------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  3 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c |  2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h |  2 +
 4 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index b86f980fa7ea..469352ac1f7e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -9117,10 +9117,18 @@ static int bnxt_alloc_ctx_mem(struct bnxt *bp)
 	ena = 0;
 	if ((bp->flags & BNXT_FLAG_ROCE_CAP) && !is_kdump_kernel()) {
 		pg_lvl = 2;
-		extra_qps = min_t(u32, 65536, max_qps - l2_qps - qp1_qps);
-		/* allocate extra qps if fw supports RoCE fast qp destroy feature */
-		extra_qps += fast_qpmd_qps;
-		extra_srqs = min_t(u32, 8192, max_srqs - srqs);
+		if (BNXT_SW_RES_LMT(bp)) {
+			extra_qps = max_qps - l2_qps - qp1_qps;
+			extra_srqs = max_srqs - srqs;
+		} else {
+			extra_qps = min_t(u32, 65536,
+					  max_qps - l2_qps - qp1_qps);
+			/* allocate extra qps if fw supports RoCE fast qp
+			 * destroy feature
+			 */
+			extra_qps += fast_qpmd_qps;
+			extra_srqs = min_t(u32, 8192, max_srqs - srqs);
+		}
 		if (fast_qpmd_qps)
 			ena |= FUNC_BACKING_STORE_CFG_REQ_ENABLES_QP_FAST_QPMD;
 	}
@@ -9156,14 +9164,20 @@ static int bnxt_alloc_ctx_mem(struct bnxt *bp)
 		goto skip_rdma;
 
 	ctxm = &ctx->ctx_arr[BNXT_CTX_MRAV];
-	/* 128K extra is needed to accommodate static AH context
-	 * allocation by f/w.
-	 */
-	num_mr = min_t(u32, ctxm->max_entries / 2, 1024 * 256);
-	num_ah = min_t(u32, num_mr, 1024 * 128);
-	ctxm->split_entry_cnt = BNXT_CTX_MRAV_AV_SPLIT_ENTRY + 1;
-	if (!ctxm->mrav_av_entries || ctxm->mrav_av_entries > num_ah)
-		ctxm->mrav_av_entries = num_ah;
+	if (BNXT_SW_RES_LMT(bp) &&
+	    ctxm->split_entry_cnt == BNXT_CTX_MRAV_AV_SPLIT_ENTRY + 1) {
+		num_ah = ctxm->mrav_av_entries;
+		num_mr = ctxm->max_entries - num_ah;
+	} else {
+		/* 128K extra is needed to accommodate static AH context
+		 * allocation by f/w.
+		 */
+		num_mr = min_t(u32, ctxm->max_entries / 2, 1024 * 256);
+		num_ah = min_t(u32, num_mr, 1024 * 128);
+		ctxm->split_entry_cnt = BNXT_CTX_MRAV_AV_SPLIT_ENTRY + 1;
+		if (!ctxm->mrav_av_entries || ctxm->mrav_av_entries > num_ah)
+			ctxm->mrav_av_entries = num_ah;
+	}
 
 	rc = bnxt_setup_ctxm_pg_tbls(bp, ctxm, num_mr + num_ah, 2);
 	if (rc)
@@ -9470,6 +9484,9 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 		bp->flags |= BNXT_FLAG_UDP_GSO_CAP;
 	if (flags_ext2 & FUNC_QCAPS_RESP_FLAGS_EXT2_TX_PKT_TS_CMPL_SUPPORTED)
 		bp->fw_cap |= BNXT_FW_CAP_TX_TS_CMP;
+	if (flags_ext2 &
+	    FUNC_QCAPS_RESP_FLAGS_EXT2_SW_MAX_RESOURCE_LIMITS_SUPPORTED)
+		bp->fw_cap |= BNXT_FW_CAP_SW_MAX_RESOURCE_LIMITS;
 	if (BNXT_PF(bp) &&
 	    (flags_ext2 & FUNC_QCAPS_RESP_FLAGS_EXT2_ROCE_VF_RESOURCE_MGMT_SUPPORTED))
 		bp->fw_cap |= BNXT_FW_CAP_ROCE_VF_RESC_MGMT_SUPPORTED;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 7df7a2233307..3e20d200da62 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2482,6 +2482,7 @@ struct bnxt {
 	#define BNXT_FW_CAP_CFA_NTUPLE_RX_EXT_IP_PROTO	BIT_ULL(38)
 	#define BNXT_FW_CAP_CFA_RFS_RING_TBL_IDX_V3	BIT_ULL(39)
 	#define BNXT_FW_CAP_VNIC_RE_FLUSH		BIT_ULL(40)
+	#define BNXT_FW_CAP_SW_MAX_RESOURCE_LIMITS	BIT_ULL(41)
 
 	u32			fw_dbg_cap;
 
@@ -2501,6 +2502,8 @@ struct bnxt {
 	((bp)->fw_cap & BNXT_FW_CAP_ENABLE_RDMA_SRIOV)
 #define BNXT_ROCE_VF_RESC_CAP(bp)	\
 	((bp)->fw_cap & BNXT_FW_CAP_ROCE_VF_RESC_MGMT_SUPPORTED)
+#define BNXT_SW_RES_LMT(bp)		\
+	((bp)->fw_cap & BNXT_FW_CAP_SW_MAX_RESOURCE_LIMITS)
 
 	u32			hwrm_spec_code;
 	u16			hwrm_cmd_seq;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index b771c84cdd89..94c6a0928ca0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -416,6 +416,8 @@ static void bnxt_set_edev_info(struct bnxt_en_dev *edev, struct bnxt *bp)
 		edev->flags |= BNXT_EN_FLAG_VF;
 	if (BNXT_ROCE_VF_RESC_CAP(bp))
 		edev->flags |= BNXT_EN_FLAG_ROCE_VF_RES_MGMT;
+	if (BNXT_SW_RES_LMT(bp))
+		edev->flags |= BNXT_EN_FLAG_SW_RES_LMT;
 
 	edev->chip_num = bp->chip_num;
 	edev->hw_ring_stats_size = bp->hw_ring_stats_size;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
index 5d6aac60f236..54ad9f8273d7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
@@ -65,6 +65,8 @@ struct bnxt_en_dev {
 	#define BNXT_EN_FLAG_VF			0x10
 #define BNXT_EN_VF(edev)	((edev)->flags & BNXT_EN_FLAG_VF)
 	#define BNXT_EN_FLAG_ROCE_VF_RES_MGMT	0x20
+	#define BNXT_EN_FLAG_SW_RES_LMT		0x40
+#define BNXT_EN_SW_RES_LMT(edev) ((edev)->flags & BNXT_EN_FLAG_SW_RES_LMT)
 
 	struct bnxt_ulp			*ulp_tbl;
 	int				l2_db_size;	/* Doorbell BAR size in
-- 
2.30.1


