Return-Path: <netdev+bounces-201489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA63AE98DF
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 10:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C17E3BD107
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9ECE2C3246;
	Thu, 26 Jun 2025 08:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FEvnsu2A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862FD2D3ECC
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 08:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750927582; cv=none; b=kg80G4OSGhoDL7KCbYKBWmmSiKuj5J9OvbRbATzpIZLENQpxpCjl/0pjwgo3ccnEO7txddf/TlSN8Y8O15YBS113un1hcmN3ZvOhJMDAOh8AxVVMUCLGokXAnNmZzraIGSG11mgweoawT04pL1zalA3RFF+dcTsd5iXC44ZtgAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750927582; c=relaxed/simple;
	bh=aRvvfwgn4muU07e9mCsSPE6zLsYVdRsN+X5I7zRhPYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q76Fs8mGSWenXMyjCkrG+bB5k7HaQI9ACzIsiNMkYqz+hTckQa6ode/fOCEKbsgqNLrp5r2YQ2J0+VwsIpAovVFHtlmAWdAS/4JUfiNnsNL+mypMm8v5ieagSoBZMEoRKH+IRxnmsK0KrueEPwHyY1JFPP32oQT0f9beZ9siOcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FEvnsu2A; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22c33677183so8277545ad.2
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 01:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1750927580; x=1751532380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6zldlB+51cDZUFEJG/JbyeLDVSusfY0mmn3+U6svIM=;
        b=FEvnsu2ATOEfPMVisTYt4DvWMnUhLuy3rmxSXzqOdilNBcoSicxDjgTMROTFKob6du
         xj5nbxbvHt6RvHQjp+zxxxIgAnfhQS+0jqlhIQTaZVQ9Cd9wdylGHczmi8VAeqk+Mt4Y
         hdPm0pzeKTs4LA/n/fgxGDRUn1xDl9tEkRhxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750927580; x=1751532380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6zldlB+51cDZUFEJG/JbyeLDVSusfY0mmn3+U6svIM=;
        b=mvLV/pIPmlKY8QbzLyGV5drb2+k0AnzhDLcImP9CKYlGfAB9blEU9xxJjVIjGESAzx
         H+XTwYtpyrthdhnN8wsWUWB4BCg7tukIDFHJnC4+VyVE4yIVDJbLR8Eq/69le+gnQ35r
         KUfMZVOA1Z3//2hfIti41ftEPluoYiQVdThVfHLs8qb6LyrA0IPFSGgChEdSEBGU1E9z
         5ZB1jFkdeHvl9bDa904o4MoYYoQWTPtHIVaqgkqnWDkakXP4Iv8RpCgaaHnGinIQfWFy
         EMl3VNFxrbXFBfO2yr+VrzQj/1Nqa0og8m7l0oVJ5aIcbkOLHbCg5V3rxKYpz2xTpfPK
         YiHw==
X-Gm-Message-State: AOJu0YzyvouL9iuZLlnPfhZYc+pxX/LBrln/U4cEejfWkcS9UrOgBi50
	hdcV+ToOTS+F/S8t37dbhc/iqfT12wpQV65v/kJhr6/krbhVIOGt96qJNzQ0HkSYiA==
X-Gm-Gg: ASbGncsF74sEdUrCDPDuXWwGD2nezFQJ/zhq4m9bMO2Q68AI1Zkkd3oFIUv3mulE4b/
	f+pSHehaeLDvK4LSHKw5Hn4lSxAR0rrxjmvzUFHn8WUi0WHrjXN6P8/rhMTlBzGAFdAXbSwM6X3
	eJYyxOVK9e2AiMm9YTuEjzlQKs0+troPopXOUKdKkIl8dghfSXAWFCMRrZ6aLTQRMIHxcoN3jpV
	cPcPh7VEw7cGK4MRAHUsUPRZnYPgY2sstOHsbAp+Hyy562pR6hI0BdF25t8bGh770635114Xpn8
	/fJi7Q+VgUyEiXF0ko4jpa56FRgcUCGzQ4VwAT4crmiIQYq0UvuzfpIZtGkoepgW/1xOVm+x6Z/
	GbF27H6+ULfBIK8MhUmQ0HQDW55Zl
X-Google-Smtp-Source: AGHT+IFolVG2FY/KPtcroJ1uHumyvB9+UA4SpAqlC1hvCU5YDyxYFIdahFJCoAaP4uugcWJSFa9Y+A==
X-Received: by 2002:a17:902:d501:b0:237:ec18:eab9 with SMTP id d9443c01a7336-2382424b9aamr97965265ad.32.1750927579709;
        Thu, 26 Jun 2025 01:46:19 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83fbe94sm152524875ad.86.2025.06.26.01.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 01:46:19 -0700 (PDT)
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
Subject: [net-next, v2 06/10] bng_en: Add backing store support
Date: Thu, 26 Jun 2025 14:08:15 +0000
Message-ID: <20250626140844.266456-7-vikas.gupta@broadcom.com>
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

Backing store or context memory on the host helps the
device to manage rings, stats and other resources.
Context memory is allocated with the help of ring
alloc/free functions.

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge.h     |  18 +
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    | 168 +++++++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |   4 +
 .../net/ethernet/broadcom/bnge/bnge_rmem.c    | 337 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_rmem.h    | 153 ++++++++
 5 files changed, 680 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index 60af0517c45e..01f64a10729c 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -9,6 +9,7 @@
 
 #include <linux/etherdevice.h>
 #include "../bnxt/bnxt_hsi.h"
+#include "bnge_rmem.h"
 
 #define DRV_VER_MAJ	1
 #define DRV_VER_MIN	15
@@ -52,6 +53,13 @@ enum {
 	BNGE_FW_CAP_VNIC_RE_FLUSH			= BIT_ULL(26),
 };
 
+enum {
+	BNGE_EN_ROCE_V1					= BIT_ULL(0),
+	BNGE_EN_ROCE_V2					= BIT_ULL(1),
+};
+
+#define BNGE_EN_ROCE		(BNGE_EN_ROCE_V1 | BNGE_EN_ROCE_V2)
+
 struct bnge_dev {
 	struct device	*dev;
 	struct pci_dev	*pdev;
@@ -89,6 +97,16 @@ struct bnge_dev {
 #define BNGE_STATE_DRV_REGISTERED      0
 
 	u64			fw_cap;
+
+	/* Backing stores */
+	struct bnge_ctx_mem_info	*ctx;
+
+	u64			flags;
 };
 
+static inline bool bnge_is_roce_en(struct bnge_dev *bd)
+{
+	return bd->flags & BNGE_EN_ROCE;
+}
+
 #endif /* _BNGE_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index 25ac73ac37ba..dc69bd1461f9 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
@@ -10,6 +10,7 @@
 #include "../bnxt/bnxt_hsi.h"
 #include "bnge_hwrm.h"
 #include "bnge_hwrm_lib.h"
+#include "bnge_rmem.h"
 
 int bnge_hwrm_ver_get(struct bnge_dev *bd)
 {
@@ -211,3 +212,170 @@ int bnge_hwrm_func_drv_unrgtr(struct bnge_dev *bd)
 		return rc;
 	return bnge_hwrm_req_send(bd, req);
 }
+
+static void bnge_init_ctx_initializer(struct bnge_ctx_mem_type *ctxm,
+				      u8 init_val, u8 init_offset,
+				      bool init_mask_set)
+{
+	ctxm->init_value = init_val;
+	ctxm->init_offset = BNGE_CTX_INIT_INVALID_OFFSET;
+	if (init_mask_set)
+		ctxm->init_offset = init_offset * 4;
+	else
+		ctxm->init_value = 0;
+}
+
+static int bnge_alloc_all_ctx_pg_info(struct bnge_dev *bd, int ctx_max)
+{
+	struct bnge_ctx_mem_info *ctx = bd->ctx;
+	u16 type;
+
+	for (type = 0; type < ctx_max; type++) {
+		struct bnge_ctx_mem_type *ctxm = &ctx->ctx_arr[type];
+		int n = 1;
+
+		if (!ctxm->max_entries)
+			continue;
+
+		if (ctxm->instance_bmap)
+			n = hweight32(ctxm->instance_bmap);
+		ctxm->pg_info = kcalloc(n, sizeof(*ctxm->pg_info), GFP_KERNEL);
+		if (!ctxm->pg_info)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+#define BNGE_CTX_INIT_VALID(flags)	\
+	(!!((flags) &			\
+	    FUNC_BACKING_STORE_QCAPS_V2_RESP_FLAGS_ENABLE_CTX_KIND_INIT))
+
+int bnge_hwrm_func_backing_store_qcaps(struct bnge_dev *bd)
+{
+	struct hwrm_func_backing_store_qcaps_v2_output *resp;
+	struct hwrm_func_backing_store_qcaps_v2_input *req;
+	struct bnge_ctx_mem_info *ctx;
+	u16 type;
+	int rc;
+
+	if (bd->ctx)
+		return 0;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_FUNC_BACKING_STORE_QCAPS_V2);
+	if (rc)
+		return rc;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	bd->ctx = ctx;
+
+	resp = bnge_hwrm_req_hold(bd, req);
+
+	for (type = 0; type < BNGE_CTX_V2_MAX; ) {
+		struct bnge_ctx_mem_type *ctxm = &ctx->ctx_arr[type];
+		u8 init_val, init_off, i;
+		__le32 *p;
+		u32 flags;
+
+		req->type = cpu_to_le16(type);
+		rc = bnge_hwrm_req_send(bd, req);
+		if (rc)
+			goto ctx_done;
+		flags = le32_to_cpu(resp->flags);
+		type = le16_to_cpu(resp->next_valid_type);
+		if (!(flags &
+		      FUNC_BACKING_STORE_QCAPS_V2_RESP_FLAGS_TYPE_VALID))
+			continue;
+
+		ctxm->type = le16_to_cpu(resp->type);
+		ctxm->entry_size = le16_to_cpu(resp->entry_size);
+		ctxm->flags = flags;
+		ctxm->instance_bmap = le32_to_cpu(resp->instance_bit_map);
+		ctxm->entry_multiple = resp->entry_multiple;
+		ctxm->max_entries = le32_to_cpu(resp->max_num_entries);
+		ctxm->min_entries = le32_to_cpu(resp->min_num_entries);
+		init_val = resp->ctx_init_value;
+		init_off = resp->ctx_init_offset;
+		bnge_init_ctx_initializer(ctxm, init_val, init_off,
+					  BNGE_CTX_INIT_VALID(flags));
+		ctxm->split_entry_cnt = min_t(u8, resp->subtype_valid_cnt,
+					      BNGE_MAX_SPLIT_ENTRY);
+		for (i = 0, p = &resp->split_entry_0; i < ctxm->split_entry_cnt;
+		     i++, p++)
+			ctxm->split[i] = le32_to_cpu(*p);
+	}
+	rc = bnge_alloc_all_ctx_pg_info(bd, BNGE_CTX_V2_MAX);
+
+ctx_done:
+	bnge_hwrm_req_drop(bd, req);
+	return rc;
+}
+
+static void bnge_hwrm_set_pg_attr(struct bnge_ring_mem_info *rmem, u8 *pg_attr,
+				  __le64 *pg_dir)
+{
+	if (!rmem->nr_pages)
+		return;
+
+	BNGE_SET_CTX_PAGE_ATTR(*pg_attr);
+	if (rmem->depth >= 1) {
+		if (rmem->depth == 2)
+			*pg_attr |= 2;
+		else
+			*pg_attr |= 1;
+		*pg_dir = cpu_to_le64(rmem->dma_pg_tbl);
+	} else {
+		*pg_dir = cpu_to_le64(rmem->dma_arr[0]);
+	}
+}
+
+int bnge_hwrm_func_backing_store(struct bnge_dev *bd,
+				 struct bnge_ctx_mem_type *ctxm,
+				 bool last)
+{
+	struct hwrm_func_backing_store_cfg_v2_input *req;
+	u32 instance_bmap = ctxm->instance_bmap;
+	int i, j, rc = 0, n = 1;
+	__le32 *p;
+
+	if (!(ctxm->flags & BNGE_CTX_MEM_TYPE_VALID) || !ctxm->pg_info)
+		return 0;
+
+	if (instance_bmap)
+		n = hweight32(ctxm->instance_bmap);
+	else
+		instance_bmap = 1;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_FUNC_BACKING_STORE_CFG_V2);
+	if (rc)
+		return rc;
+	bnge_hwrm_req_hold(bd, req);
+	req->type = cpu_to_le16(ctxm->type);
+	req->entry_size = cpu_to_le16(ctxm->entry_size);
+	req->subtype_valid_cnt = ctxm->split_entry_cnt;
+	for (i = 0, p = &req->split_entry_0; i < ctxm->split_entry_cnt; i++)
+		p[i] = cpu_to_le32(ctxm->split[i]);
+	for (i = 0, j = 0; j < n && !rc; i++) {
+		struct bnge_ctx_pg_info *ctx_pg;
+
+		if (!(instance_bmap & (1 << i)))
+			continue;
+		req->instance = cpu_to_le16(i);
+		ctx_pg = &ctxm->pg_info[j++];
+		if (!ctx_pg->entries)
+			continue;
+		req->num_entries = cpu_to_le32(ctx_pg->entries);
+		bnge_hwrm_set_pg_attr(&ctx_pg->ring_mem,
+				      &req->page_size_pbl_level,
+				      &req->page_dir);
+		if (last && j == n)
+			req->flags =
+				cpu_to_le32(BNGE_BS_CFG_ALL_DONE);
+		rc = bnge_hwrm_req_send(bd, req);
+	}
+	bnge_hwrm_req_drop(bd, req);
+
+	return rc;
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
index 9308d4fe64d2..c04291d74bf0 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
@@ -12,5 +12,9 @@ int bnge_hwrm_func_drv_unrgtr(struct bnge_dev *bd);
 int bnge_hwrm_vnic_qcaps(struct bnge_dev *bd);
 int bnge_hwrm_nvm_dev_info(struct bnge_dev *bd,
 			   struct hwrm_nvm_get_dev_info_output *nvm_dev_info);
+int bnge_hwrm_func_backing_store(struct bnge_dev *bd,
+				 struct bnge_ctx_mem_type *ctxm,
+				 bool last);
+int bnge_hwrm_func_backing_store_qcaps(struct bnge_dev *bd);
 
 #endif /* _BNGE_HWRM_LIB_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
index ef232c4217bc..0e935cc46da6 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
@@ -15,6 +15,24 @@
 #include "bnge_hwrm_lib.h"
 #include "bnge_rmem.h"
 
+static void bnge_init_ctx_mem(struct bnge_ctx_mem_type *ctxm,
+			      void *p, int len)
+{
+	u8 init_val = ctxm->init_value;
+	u16 offset = ctxm->init_offset;
+	u8 *p2 = p;
+	int i;
+
+	if (!init_val)
+		return;
+	if (offset == BNGE_CTX_INIT_INVALID_OFFSET) {
+		memset(p, init_val, len);
+		return;
+	}
+	for (i = 0; i < len; i += ctxm->entry_size)
+		*(p2 + i + offset) = init_val;
+}
+
 void bnge_free_ring(struct bnge_dev *bd, struct bnge_ring_mem_info *rmem)
 {
 	struct pci_dev *pdev = bd->pdev;
@@ -79,6 +97,10 @@ int bnge_alloc_ring(struct bnge_dev *bd, struct bnge_ring_mem_info *rmem)
 		if (!rmem->pg_arr[i])
 			return -ENOMEM;
 
+		if (rmem->ctx_mem)
+			bnge_init_ctx_mem(rmem->ctx_mem, rmem->pg_arr[i],
+					  rmem->page_size);
+
 		if (rmem->nr_pages > 1 || rmem->depth > 0) {
 			if (i == rmem->nr_pages - 2 &&
 			    (rmem->flags & BNGE_RMEM_RING_PTE_FLAG))
@@ -99,3 +121,318 @@ int bnge_alloc_ring(struct bnge_dev *bd, struct bnge_ring_mem_info *rmem)
 
 	return 0;
 }
+
+static int bnge_alloc_ctx_one_lvl(struct bnge_dev *bd,
+				  struct bnge_ctx_pg_info *ctx_pg)
+{
+	struct bnge_ring_mem_info *rmem = &ctx_pg->ring_mem;
+
+	rmem->page_size = BNGE_PAGE_SIZE;
+	rmem->pg_arr = ctx_pg->ctx_pg_arr;
+	rmem->dma_arr = ctx_pg->ctx_dma_arr;
+	rmem->flags = BNGE_RMEM_VALID_PTE_FLAG;
+	if (rmem->depth >= 1)
+		rmem->flags |= BNGE_RMEM_USE_FULL_PAGE_FLAG;
+	return bnge_alloc_ring(bd, rmem);
+}
+
+static int bnge_alloc_ctx_pg_tbls(struct bnge_dev *bd,
+				  struct bnge_ctx_pg_info *ctx_pg, u32 mem_size,
+				  u8 depth, struct bnge_ctx_mem_type *ctxm)
+{
+	struct bnge_ring_mem_info *rmem = &ctx_pg->ring_mem;
+	int rc;
+
+	if (!mem_size)
+		return -EINVAL;
+
+	ctx_pg->nr_pages = DIV_ROUND_UP(mem_size, BNGE_PAGE_SIZE);
+	if (ctx_pg->nr_pages > MAX_CTX_TOTAL_PAGES) {
+		ctx_pg->nr_pages = 0;
+		return -EINVAL;
+	}
+	if (ctx_pg->nr_pages > MAX_CTX_PAGES || depth > 1) {
+		int nr_tbls, i;
+
+		rmem->depth = 2;
+		ctx_pg->ctx_pg_tbl = kcalloc(MAX_CTX_PAGES, sizeof(ctx_pg),
+					     GFP_KERNEL);
+		if (!ctx_pg->ctx_pg_tbl)
+			return -ENOMEM;
+		nr_tbls = DIV_ROUND_UP(ctx_pg->nr_pages, MAX_CTX_PAGES);
+		rmem->nr_pages = nr_tbls;
+		rc = bnge_alloc_ctx_one_lvl(bd, ctx_pg);
+		if (rc)
+			return rc;
+		for (i = 0; i < nr_tbls; i++) {
+			struct bnge_ctx_pg_info *pg_tbl;
+
+			pg_tbl = kzalloc(sizeof(*pg_tbl), GFP_KERNEL);
+			if (!pg_tbl)
+				return -ENOMEM;
+			ctx_pg->ctx_pg_tbl[i] = pg_tbl;
+			rmem = &pg_tbl->ring_mem;
+			rmem->pg_tbl = ctx_pg->ctx_pg_arr[i];
+			rmem->dma_pg_tbl = ctx_pg->ctx_dma_arr[i];
+			rmem->depth = 1;
+			rmem->nr_pages = MAX_CTX_PAGES;
+			rmem->ctx_mem = ctxm;
+			if (i == (nr_tbls - 1)) {
+				int rem = ctx_pg->nr_pages % MAX_CTX_PAGES;
+
+				if (rem)
+					rmem->nr_pages = rem;
+			}
+			rc = bnge_alloc_ctx_one_lvl(bd, pg_tbl);
+			if (rc)
+				break;
+		}
+	} else {
+		rmem->nr_pages = DIV_ROUND_UP(mem_size, BNGE_PAGE_SIZE);
+		if (rmem->nr_pages > 1 || depth)
+			rmem->depth = 1;
+		rmem->ctx_mem = ctxm;
+		rc = bnge_alloc_ctx_one_lvl(bd, ctx_pg);
+	}
+
+	return rc;
+}
+
+static void bnge_free_ctx_pg_tbls(struct bnge_dev *bd,
+				  struct bnge_ctx_pg_info *ctx_pg)
+{
+	struct bnge_ring_mem_info *rmem = &ctx_pg->ring_mem;
+
+	if (rmem->depth > 1 || ctx_pg->nr_pages > MAX_CTX_PAGES ||
+	    ctx_pg->ctx_pg_tbl) {
+		int i, nr_tbls = rmem->nr_pages;
+
+		for (i = 0; i < nr_tbls; i++) {
+			struct bnge_ctx_pg_info *pg_tbl;
+			struct bnge_ring_mem_info *rmem2;
+
+			pg_tbl = ctx_pg->ctx_pg_tbl[i];
+			if (!pg_tbl)
+				continue;
+			rmem2 = &pg_tbl->ring_mem;
+			bnge_free_ring(bd, rmem2);
+			ctx_pg->ctx_pg_arr[i] = NULL;
+			kfree(pg_tbl);
+			ctx_pg->ctx_pg_tbl[i] = NULL;
+		}
+		kfree(ctx_pg->ctx_pg_tbl);
+		ctx_pg->ctx_pg_tbl = NULL;
+	}
+	bnge_free_ring(bd, rmem);
+	ctx_pg->nr_pages = 0;
+}
+
+static int bnge_setup_ctxm_pg_tbls(struct bnge_dev *bd,
+				   struct bnge_ctx_mem_type *ctxm, u32 entries,
+				   u8 pg_lvl)
+{
+	struct bnge_ctx_pg_info *ctx_pg = ctxm->pg_info;
+	int i, rc = 0, n = 1;
+	u32 mem_size;
+
+	if (!ctxm->entry_size || !ctx_pg)
+		return -EINVAL;
+	if (ctxm->instance_bmap)
+		n = hweight32(ctxm->instance_bmap);
+	if (ctxm->entry_multiple)
+		entries = roundup(entries, ctxm->entry_multiple);
+	entries = clamp_t(u32, entries, ctxm->min_entries, ctxm->max_entries);
+	mem_size = entries * ctxm->entry_size;
+	for (i = 0; i < n && !rc; i++) {
+		ctx_pg[i].entries = entries;
+		rc = bnge_alloc_ctx_pg_tbls(bd, &ctx_pg[i], mem_size, pg_lvl,
+					    ctxm->init_value ? ctxm : NULL);
+	}
+
+	return rc;
+}
+
+static int bnge_backing_store_cfg(struct bnge_dev *bd, u32 ena)
+{
+	struct bnge_ctx_mem_info *ctx = bd->ctx;
+	struct bnge_ctx_mem_type *ctxm;
+	u16 last_type;
+	int rc = 0;
+	u16 type;
+
+	if (!ena)
+		return 0;
+	else if (ena & FUNC_BACKING_STORE_CFG_REQ_ENABLES_TIM)
+		last_type = BNGE_CTX_MAX - 1;
+	else
+		last_type = BNGE_CTX_L2_MAX - 1;
+	ctx->ctx_arr[last_type].last = 1;
+
+	for (type = 0 ; type < BNGE_CTX_V2_MAX; type++) {
+		ctxm = &ctx->ctx_arr[type];
+
+		rc = bnge_hwrm_func_backing_store(bd, ctxm, ctxm->last);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+void bnge_free_ctx_mem(struct bnge_dev *bd)
+{
+	struct bnge_ctx_mem_info *ctx = bd->ctx;
+	u16 type;
+
+	if (!ctx)
+		return;
+
+	for (type = 0; type < BNGE_CTX_V2_MAX; type++) {
+		struct bnge_ctx_mem_type *ctxm = &ctx->ctx_arr[type];
+		struct bnge_ctx_pg_info *ctx_pg = ctxm->pg_info;
+		int i, n = 1;
+
+		if (!ctx_pg)
+			continue;
+		if (ctxm->instance_bmap)
+			n = hweight32(ctxm->instance_bmap);
+		for (i = 0; i < n; i++)
+			bnge_free_ctx_pg_tbls(bd, &ctx_pg[i]);
+
+		kfree(ctx_pg);
+		ctxm->pg_info = NULL;
+	}
+
+	ctx->flags &= ~BNGE_CTX_FLAG_INITED;
+	kfree(ctx);
+	bd->ctx = NULL;
+}
+
+#define FUNC_BACKING_STORE_CFG_REQ_DFLT_ENABLES			\
+	(FUNC_BACKING_STORE_CFG_REQ_ENABLES_QP |		\
+	 FUNC_BACKING_STORE_CFG_REQ_ENABLES_SRQ |		\
+	 FUNC_BACKING_STORE_CFG_REQ_ENABLES_CQ |		\
+	 FUNC_BACKING_STORE_CFG_REQ_ENABLES_VNIC |		\
+	 FUNC_BACKING_STORE_CFG_REQ_ENABLES_STAT)
+
+int bnge_alloc_ctx_mem(struct bnge_dev *bd)
+{
+	struct bnge_ctx_mem_type *ctxm;
+	struct bnge_ctx_mem_info *ctx;
+	u32 l2_qps, qp1_qps, max_qps;
+	u32 ena, entries_sp, entries;
+	u32 srqs, max_srqs, min;
+	u32 num_mr, num_ah;
+	u32 extra_srqs = 0;
+	u32 extra_qps = 0;
+	u32 fast_qpmd_qps;
+	u8 pg_lvl = 1;
+	int i, rc;
+
+	rc = bnge_hwrm_func_backing_store_qcaps(bd);
+	if (rc) {
+		dev_err(bd->dev, "Failed querying ctx mem caps, rc: %d\n", rc);
+		return rc;
+	}
+
+	ctx = bd->ctx;
+	if (!ctx || (ctx->flags & BNGE_CTX_FLAG_INITED))
+		return 0;
+
+	ctxm = &ctx->ctx_arr[BNGE_CTX_QP];
+	l2_qps = ctxm->qp_l2_entries;
+	qp1_qps = ctxm->qp_qp1_entries;
+	fast_qpmd_qps = ctxm->qp_fast_qpmd_entries;
+	max_qps = ctxm->max_entries;
+	ctxm = &ctx->ctx_arr[BNGE_CTX_SRQ];
+	srqs = ctxm->srq_l2_entries;
+	max_srqs = ctxm->max_entries;
+	ena = 0;
+	if (bnge_is_roce_en(bd) && !is_kdump_kernel()) {
+		pg_lvl = 2;
+		extra_qps = min_t(u32, 65536, max_qps - l2_qps - qp1_qps);
+		/* allocate extra qps if fast qp destroy feature enabled */
+		extra_qps += fast_qpmd_qps;
+		extra_srqs = min_t(u32, 8192, max_srqs - srqs);
+		if (fast_qpmd_qps)
+			ena |= FUNC_BACKING_STORE_CFG_REQ_ENABLES_QP_FAST_QPMD;
+	}
+
+	ctxm = &ctx->ctx_arr[BNGE_CTX_QP];
+	rc = bnge_setup_ctxm_pg_tbls(bd, ctxm, l2_qps + qp1_qps + extra_qps,
+				     pg_lvl);
+	if (rc)
+		return rc;
+
+	ctxm = &ctx->ctx_arr[BNGE_CTX_SRQ];
+	rc = bnge_setup_ctxm_pg_tbls(bd, ctxm, srqs + extra_srqs, pg_lvl);
+	if (rc)
+		return rc;
+
+	ctxm = &ctx->ctx_arr[BNGE_CTX_CQ];
+	rc = bnge_setup_ctxm_pg_tbls(bd, ctxm, ctxm->cq_l2_entries +
+				     extra_qps * 2, pg_lvl);
+	if (rc)
+		return rc;
+
+	ctxm = &ctx->ctx_arr[BNGE_CTX_VNIC];
+	rc = bnge_setup_ctxm_pg_tbls(bd, ctxm, ctxm->max_entries, 1);
+	if (rc)
+		return rc;
+
+	ctxm = &ctx->ctx_arr[BNGE_CTX_STAT];
+	rc = bnge_setup_ctxm_pg_tbls(bd, ctxm, ctxm->max_entries, 1);
+	if (rc)
+		return rc;
+
+	if (!bnge_is_roce_en(bd))
+		goto skip_rdma;
+
+	ctxm = &ctx->ctx_arr[BNGE_CTX_MRAV];
+	/* 128K extra is needed to accommodate static AH context
+	 * allocation by f/w.
+	 */
+	num_mr = min_t(u32, ctxm->max_entries / 2, 1024 * 256);
+	num_ah = min_t(u32, num_mr, 1024 * 128);
+	ctxm->split_entry_cnt = BNGE_CTX_MRAV_AV_SPLIT_ENTRY + 1;
+	if (!ctxm->mrav_av_entries || ctxm->mrav_av_entries > num_ah)
+		ctxm->mrav_av_entries = num_ah;
+
+	rc = bnge_setup_ctxm_pg_tbls(bd, ctxm, num_mr + num_ah, 2);
+	if (rc)
+		return rc;
+	ena |= FUNC_BACKING_STORE_CFG_REQ_ENABLES_MRAV;
+
+	ctxm = &ctx->ctx_arr[BNGE_CTX_TIM];
+	rc = bnge_setup_ctxm_pg_tbls(bd, ctxm, l2_qps + qp1_qps + extra_qps, 1);
+	if (rc)
+		return rc;
+	ena |= FUNC_BACKING_STORE_CFG_REQ_ENABLES_TIM;
+
+skip_rdma:
+	ctxm = &ctx->ctx_arr[BNGE_CTX_STQM];
+	min = ctxm->min_entries;
+	entries_sp = ctx->ctx_arr[BNGE_CTX_VNIC].vnic_entries + l2_qps +
+		     2 * (extra_qps + qp1_qps) + min;
+	rc = bnge_setup_ctxm_pg_tbls(bd, ctxm, entries_sp, 2);
+	if (rc)
+		return rc;
+
+	ctxm = &ctx->ctx_arr[BNGE_CTX_FTQM];
+	entries = l2_qps + 2 * (extra_qps + qp1_qps);
+	rc = bnge_setup_ctxm_pg_tbls(bd, ctxm, entries, 2);
+	if (rc)
+		return rc;
+	for (i = 0; i < ctx->tqm_fp_rings_count + 1; i++)
+		ena |= FUNC_BACKING_STORE_CFG_REQ_ENABLES_TQM_SP << i;
+	ena |= FUNC_BACKING_STORE_CFG_REQ_DFLT_ENABLES;
+
+	rc = bnge_backing_store_cfg(bd, ena);
+	if (rc) {
+		dev_err(bd->dev, "Failed configuring ctx mem, rc: %d\n", rc);
+		return rc;
+	}
+	ctx->flags |= BNGE_CTX_FLAG_INITED;
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h
index 56de31ed6613..300f1d8268ef 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h
@@ -4,6 +4,9 @@
 #ifndef _BNGE_RMEM_H_
 #define _BNGE_RMEM_H_
 
+struct bnge_ctx_mem_type;
+struct bnge_dev;
+
 #define PTU_PTE_VALID             0x1UL
 #define PTU_PTE_LAST              0x2UL
 #define PTU_PTE_NEXT_TO_LAST      0x4UL
@@ -27,9 +30,159 @@ struct bnge_ring_mem_info {
 
 	int			vmem_size;
 	void			**vmem;
+
+	struct bnge_ctx_mem_type	*ctx_mem;
+};
+
+/* The hardware supports certain page sizes.
+ * Use the supported page sizes to allocate the rings.
+ */
+#if (PAGE_SHIFT < 12)
+#define BNGE_PAGE_SHIFT	12
+#elif (PAGE_SHIFT <= 13)
+#define BNGE_PAGE_SHIFT	PAGE_SHIFT
+#elif (PAGE_SHIFT < 16)
+#define BNGE_PAGE_SHIFT	13
+#else
+#define BNGE_PAGE_SHIFT	16
+#endif
+#define BNGE_PAGE_SIZE	(1 << BNGE_PAGE_SHIFT)
+/* The RXBD length is 16-bit so we can only support page sizes < 64K */
+#if (PAGE_SHIFT > 15)
+#define BNGE_RX_PAGE_SHIFT 15
+#else
+#define BNGE_RX_PAGE_SHIFT PAGE_SHIFT
+#endif
+#define MAX_CTX_PAGES	(BNGE_PAGE_SIZE / 8)
+#define MAX_CTX_TOTAL_PAGES	(MAX_CTX_PAGES * MAX_CTX_PAGES)
+
+struct bnge_ctx_pg_info {
+	u32		entries;
+	u32		nr_pages;
+	void		*ctx_pg_arr[MAX_CTX_PAGES];
+	dma_addr_t	ctx_dma_arr[MAX_CTX_PAGES];
+	struct bnge_ring_mem_info ring_mem;
+	struct bnge_ctx_pg_info **ctx_pg_tbl;
+};
+
+#define BNGE_MAX_TQM_SP_RINGS		1
+#define BNGE_MAX_TQM_FP_RINGS		8
+#define BNGE_MAX_TQM_RINGS		\
+	(BNGE_MAX_TQM_SP_RINGS + BNGE_MAX_TQM_FP_RINGS)
+#define BNGE_BACKING_STORE_CFG_LEGACY_LEN	256
+#define BNGE_SET_CTX_PAGE_ATTR(attr)					\
+do {									\
+	if (BNGE_PAGE_SIZE == 0x2000)					\
+		attr = FUNC_BACKING_STORE_CFG_REQ_SRQ_PG_SIZE_PG_8K;	\
+	else if (BNGE_PAGE_SIZE == 0x10000)				\
+		attr = FUNC_BACKING_STORE_CFG_REQ_QPC_PG_SIZE_PG_64K;	\
+	else								\
+		attr = FUNC_BACKING_STORE_CFG_REQ_QPC_PG_SIZE_PG_4K;	\
+} while (0)
+
+#define BNGE_CTX_MRAV_AV_SPLIT_ENTRY	0
+
+#define BNGE_CTX_QP	\
+	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_QP
+#define BNGE_CTX_SRQ	\
+	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_SRQ
+#define BNGE_CTX_CQ	\
+	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_CQ
+#define BNGE_CTX_VNIC	\
+	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_VNIC
+#define BNGE_CTX_STAT	\
+	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_STAT
+#define BNGE_CTX_STQM	\
+	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_SP_TQM_RING
+#define BNGE_CTX_FTQM	\
+	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_FP_TQM_RING
+#define BNGE_CTX_MRAV	\
+	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_MRAV
+#define BNGE_CTX_TIM	\
+	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_TIM
+#define BNGE_CTX_TCK	\
+	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_TX_CK
+#define BNGE_CTX_RCK	\
+	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_RX_CK
+#define BNGE_CTX_MTQM	\
+	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_MP_TQM_RING
+#define BNGE_CTX_SQDBS	\
+	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_SQ_DB_SHADOW
+#define BNGE_CTX_RQDBS	\
+	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_RQ_DB_SHADOW
+#define BNGE_CTX_SRQDBS	\
+	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_SRQ_DB_SHADOW
+#define BNGE_CTX_CQDBS	\
+	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_CQ_DB_SHADOW
+#define BNGE_CTX_SRT_TRACE	\
+	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_SRT_TRACE
+#define BNGE_CTX_SRT2_TRACE	\
+	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_SRT2_TRACE
+#define BNGE_CTX_CRT_TRACE	\
+	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_CRT_TRACE
+#define BNGE_CTX_CRT2_TRACE	\
+	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_CRT2_TRACE
+#define BNGE_CTX_RIGP0_TRACE	\
+	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_RIGP0_TRACE
+#define BNGE_CTX_L2_HWRM_TRACE	\
+	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_L2_HWRM_TRACE
+#define BNGE_CTX_ROCE_HWRM_TRACE	\
+	FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_ROCE_HWRM_TRACE
+
+#define BNGE_CTX_MAX		(BNGE_CTX_TIM + 1)
+#define BNGE_CTX_L2_MAX		(BNGE_CTX_FTQM + 1)
+#define BNGE_CTX_INV		((u16)-1)
+
+#define BNGE_CTX_V2_MAX	\
+	(FUNC_BACKING_STORE_QCAPS_V2_REQ_TYPE_ROCE_HWRM_TRACE + 1)
+
+#define BNGE_BS_CFG_ALL_DONE	\
+	FUNC_BACKING_STORE_CFG_V2_REQ_FLAGS_BS_CFG_ALL_DONE
+
+struct bnge_ctx_mem_type {
+	u16	type;
+	u16	entry_size;
+	u32	flags;
+#define BNGE_CTX_MEM_TYPE_VALID	\
+	FUNC_BACKING_STORE_QCAPS_V2_RESP_FLAGS_TYPE_VALID
+	u32	instance_bmap;
+	u8	init_value;
+	u8	entry_multiple;
+	u16	init_offset;
+#define	BNGE_CTX_INIT_INVALID_OFFSET	0xffff
+	u32	max_entries;
+	u32	min_entries;
+	u8	last:1;
+	u8	split_entry_cnt;
+#define BNGE_MAX_SPLIT_ENTRY	4
+	union {
+		struct {
+			u32	qp_l2_entries;
+			u32	qp_qp1_entries;
+			u32	qp_fast_qpmd_entries;
+		};
+		u32	srq_l2_entries;
+		u32	cq_l2_entries;
+		u32	vnic_entries;
+		struct {
+			u32	mrav_av_entries;
+			u32	mrav_num_entries_units;
+		};
+		u32	split[BNGE_MAX_SPLIT_ENTRY];
+	};
+	struct bnge_ctx_pg_info	*pg_info;
+};
+
+struct bnge_ctx_mem_info {
+	u8	tqm_fp_rings_count;
+	u32	flags;
+#define BNGE_CTX_FLAG_INITED	0x01
+	struct bnge_ctx_mem_type	ctx_arr[BNGE_CTX_V2_MAX];
 };
 
 int bnge_alloc_ring(struct bnge_dev *bd, struct bnge_ring_mem_info *rmem);
 void bnge_free_ring(struct bnge_dev *bd, struct bnge_ring_mem_info *rmem);
+int bnge_alloc_ctx_mem(struct bnge_dev *bd);
+void bnge_free_ctx_mem(struct bnge_dev *bd);
 
 #endif /* _BNGE_RMEM_H_ */
-- 
2.47.1


