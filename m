Return-Path: <netdev+bounces-220436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7FDB45FE2
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 19:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1222A44490
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 17:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A40535A289;
	Fri,  5 Sep 2025 17:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="C4OI7C3T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f98.google.com (mail-io1-f98.google.com [209.85.166.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E64335334A
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 17:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092830; cv=none; b=azD9RuWFtNFDEAsKRHO2lLhv/r4cFY2qyyY/OfINs+Kdg+Ez8E0XnxhRQVyzK4RweIrE4tDCX3oWcpiL2gTZAUjtkTKAtr52KN0Homwo5BijPjeiqlwSF84NK0qAMZ0MjFm9CaQ3OuupLLXRbMe5yMtoXnQlfsJ3Kc8S4WYJdXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092830; c=relaxed/simple;
	bh=sbwCdmPRBOSjIuI08LWmsZifnOFSNYW0JJWUUgagank=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b5AMeGCtGXKh9M3Ves+R74UMZTnbVSnUzIY+sz2UvDPXzY3yNgtQQtx35EgVwl8ziBuE/E/eJ6t4YeZbeqG/YSAkTLwgKpgwoPhwCfro7KsFsy+eRGvmCa4V+/t94MA/J0dWYigH21DXVWZmxeOkkpkgyw3EoFTArOcidEOsd8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=C4OI7C3T; arc=none smtp.client-ip=209.85.166.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f98.google.com with SMTP id ca18e2360f4ac-887764c2868so3256939f.1
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 10:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757092827; x=1757697627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KE/wxZRixCsfc/2JuvzDJGHqhBwLnVxRK9rdzrG7L+Q=;
        b=OY1YMty2g97xxSuohMEJtw7i2PuDP6RU04pzEMZY5uLKg/RlxxhAIQtXosILEGLgBV
         ypZurnZPlsTgz7MqoAMGEf+CxIf8WGSfOgPC4+F8Il4yPozV/+ga7vGFmb7sM9raOWiq
         UD4T3DbMUiv7NLPIfD7KReX/kx8HQ5mW2m/NjjIve8HWEGY9jrJ5+0qwtOIirEdXq0ui
         bbKhkxNZV49mK9DXI7KldPDURGox9ZbNFFWEUhpxRB3yX0ZO6XaeY07Z/3x4jCi7KGsW
         11YAY7WWHhFRYU4/DAnkvuYnlVi4F36v5JweSyB2ZkX4S63iCQRlLDE6gNLYC0Ho5x2f
         BYBA==
X-Gm-Message-State: AOJu0YyV6jGKolXGkBkzof39JjWXQHFA8LJuvQkS/CgxMHsZfQZHuhEe
	s+pNFnQElqYl9D0hallMME/f9bnBHWpoAaPi0U9f9mo3y26x5nuMnGrt2zJE0RPueyHNv97mD2E
	oYXWwrzdaHOEvorCq0HQSxfvHW2xim0wUDkeTHzp+fv96cyuStnmthGSmvm/aM21G68IBEik7zT
	IpGafwp4VQSfCELg7Rilt4kHF+8IbqecGvT5R3AFhpa8SrxA142EsG0/BaabMUBTNwYJTz8ll01
	Te2Qxp5lzqGikAoJgwu
X-Gm-Gg: ASbGncvWYFGQbwqJz1A1HRYmmzwbPPG4ozJHSKGQ8DGn22mmkPpuM1shDSFy4A0/Nlr
	1xtYzdFinAnkB5Pqmxd0BwQ1LSGTKk8LU34QGAj0Tzqg3+tbF8IYDozpK+tpNX6f3eGsLxWIWnK
	elwwOaQehf+XAw+YNiLHz1h7Xf+HHaVOS2eTWNN37yS6z2Isyy8cAuwBXfkhYz/TmFRAgk9eKVH
	Ed7+GkraypY+3HgXXZ6t8bKlUxcp6b3nzrRY2+uZbyi3AH8xbFIWLy/4nEJCXFYGkTkvAuPax+S
	0Y9MfVr0YmlzQpAtsDSRxL7+5LR/41QPxBQabTfBcPmC4VxkvhV6pq21rOAdoz+qNiKcp75m5MA
	vYk6bfB0n65XqQkqBBB89BNTBU2uxHQ==
X-Google-Smtp-Source: AGHT+IH1LUb9ev5+aAYzK3WjhFDxC2OCmWhP11ecxSYCYAkCFbf2Yay3EfwRQz1Tp+IUqjuu9ZKhGsLooVMk
X-Received: by 2002:a05:6e02:3e05:b0:3f6:6910:db48 with SMTP id e9e14a558f8ab-3f66910dcb6mr95319985ab.3.1757092827120;
        Fri, 05 Sep 2025 10:20:27 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3f3df873dfasm13383645ab.43.2025.09.05.10.20.26
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Sep 2025 10:20:27 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3234811cab3so2775564a91.3
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 10:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757092825; x=1757697625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KE/wxZRixCsfc/2JuvzDJGHqhBwLnVxRK9rdzrG7L+Q=;
        b=C4OI7C3TcmduikqkR0F42Ff+7I/hGxlYTAS0WLT7SbRSz3sOH4juNmkaI0JPcIbmFP
         huF4KutKJ4gDeQBPfCUtBQx3lNN48f8cxd0qWJD01zgaGeZThSBXqhp2c8R87tsfyPg0
         bcf6AKY+UvwPiYPU2BDL0yagLxJVF8Kqyjuwk=
X-Received: by 2002:a17:90b:3d48:b0:32b:70a7:16c2 with SMTP id 98e67ed59e1d1-32b70a719e5mr11880028a91.22.1757092825431;
        Fri, 05 Sep 2025 10:20:25 -0700 (PDT)
X-Received: by 2002:a17:90b:3d48:b0:32b:70a7:16c2 with SMTP id 98e67ed59e1d1-32b70a719e5mr11879985a91.22.1757092824927;
        Fri, 05 Sep 2025 10:20:24 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2b78d7sm22678001b3a.30.2025.09.05.10.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:20:24 -0700 (PDT)
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
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [v6, net-next 03/10] bng_en: Add initial support for CP and NQ rings
Date: Fri,  5 Sep 2025 22:46:45 +0000
Message-ID: <20250905224652.48692-4-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250905224652.48692-1-bhargava.marreddy@broadcom.com>
References: <20250905224652.48692-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Allocate CP and NQ related data structures and add support to
associate NQ and CQ rings. Also, add the association of NQ, NAPI,
and interrupts.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge.h     |   1 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 439 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  12 +
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |   2 +-
 4 files changed, 453 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index 03e55b931f7..c536c0cc66e 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -215,5 +215,6 @@ static inline bool bnge_is_agg_reqd(struct bnge_dev *bd)
 }
 
 bool bnge_aux_registered(struct bnge_dev *bd);
+u16 bnge_aux_get_msix(struct bnge_dev *bd);
 
 #endif /* _BNGE_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index b537c66381d..207cbaba08a 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -27,6 +27,237 @@
 #define BNGE_RING_TO_TC(bd, tx)		\
 	((tx) / (bd)->tx_nr_rings_per_tc)
 
+#define BNGE_TC_TO_RING_BASE(bd, tc)	\
+	((tc) * (bd)->tx_nr_rings_per_tc)
+
+static void bnge_free_nq_desc_arr(struct bnge_nq_ring_info *nqr)
+{
+	struct bnge_ring_struct *ring = &nqr->ring_struct;
+
+	kfree(nqr->desc_ring);
+	nqr->desc_ring = NULL;
+	ring->ring_mem.pg_arr = NULL;
+	kfree(nqr->desc_mapping);
+	nqr->desc_mapping = NULL;
+	ring->ring_mem.dma_arr = NULL;
+}
+
+static void bnge_free_cp_desc_arr(struct bnge_cp_ring_info *cpr)
+{
+	struct bnge_ring_struct *ring = &cpr->ring_struct;
+
+	kfree(cpr->desc_ring);
+	cpr->desc_ring = NULL;
+	ring->ring_mem.pg_arr = NULL;
+	kfree(cpr->desc_mapping);
+	cpr->desc_mapping = NULL;
+	ring->ring_mem.dma_arr = NULL;
+}
+
+static int bnge_alloc_nq_desc_arr(struct bnge_nq_ring_info *nqr, int n)
+{
+	nqr->desc_ring = kcalloc(n, sizeof(*nqr->desc_ring), GFP_KERNEL);
+	if (!nqr->desc_ring)
+		return -ENOMEM;
+
+	nqr->desc_mapping = kcalloc(n, sizeof(*nqr->desc_mapping), GFP_KERNEL);
+	if (!nqr->desc_mapping)
+		goto err_free_desc_ring;
+	return 0;
+
+err_free_desc_ring:
+	kfree(nqr->desc_ring);
+	nqr->desc_ring = NULL;
+	return -ENOMEM;
+}
+
+static int bnge_alloc_cp_desc_arr(struct bnge_cp_ring_info *cpr, int n)
+{
+	cpr->desc_ring = kcalloc(n, sizeof(*cpr->desc_ring), GFP_KERNEL);
+	if (!cpr->desc_ring)
+		return -ENOMEM;
+
+	cpr->desc_mapping = kcalloc(n, sizeof(*cpr->desc_mapping), GFP_KERNEL);
+	if (!cpr->desc_mapping)
+		goto err_free_desc_ring;
+	return 0;
+
+err_free_desc_ring:
+	kfree(cpr->desc_ring);
+	cpr->desc_ring = NULL;
+	return -ENOMEM;
+}
+
+static void bnge_free_nq_arrays(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i;
+
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		struct bnge_napi *bnapi = bn->bnapi[i];
+
+		bnge_free_nq_desc_arr(&bnapi->nq_ring);
+	}
+}
+
+static int bnge_alloc_nq_arrays(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i, rc;
+
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		struct bnge_napi *bnapi = bn->bnapi[i];
+
+		rc = bnge_alloc_nq_desc_arr(&bnapi->nq_ring, bn->cp_nr_pages);
+		if (rc)
+			goto err_free_nq_arrays;
+	}
+	return 0;
+
+err_free_nq_arrays:
+	bnge_free_nq_arrays(bn);
+	return rc;
+}
+
+static void bnge_free_nq_tree(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i;
+
+	if (!bn->bnapi)
+		return;
+
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		struct bnge_napi *bnapi = bn->bnapi[i];
+		struct bnge_nq_ring_info *nqr;
+		struct bnge_ring_struct *ring;
+		int j;
+
+		nqr = &bnapi->nq_ring;
+		ring = &nqr->ring_struct;
+
+		bnge_free_ring(bd, &ring->ring_mem);
+
+		if (!nqr->cp_ring_arr)
+			continue;
+
+		for (j = 0; j < nqr->cp_ring_count; j++) {
+			struct bnge_cp_ring_info *cpr = &nqr->cp_ring_arr[j];
+
+			ring = &cpr->ring_struct;
+			bnge_free_ring(bd, &ring->ring_mem);
+			bnge_free_cp_desc_arr(cpr);
+		}
+		kfree(nqr->cp_ring_arr);
+		nqr->cp_ring_arr = NULL;
+		nqr->cp_ring_count = 0;
+	}
+}
+
+static int alloc_one_cp_ring(struct bnge_net *bn,
+			     struct bnge_cp_ring_info *cpr)
+{
+	struct bnge_ring_mem_info *rmem;
+	struct bnge_ring_struct *ring;
+	struct bnge_dev *bd = bn->bd;
+	int rc;
+
+	rc = bnge_alloc_cp_desc_arr(cpr, bn->cp_nr_pages);
+	if (rc)
+		return -ENOMEM;
+	ring = &cpr->ring_struct;
+	rmem = &ring->ring_mem;
+	rmem->nr_pages = bn->cp_nr_pages;
+	rmem->page_size = HW_CMPD_RING_SIZE;
+	rmem->pg_arr = (void **)cpr->desc_ring;
+	rmem->dma_arr = cpr->desc_mapping;
+	rmem->flags = BNGE_RMEM_RING_PTE_FLAG;
+	rc = bnge_alloc_ring(bd, rmem);
+	if (rc)
+		goto err_free_cp_desc_arr;
+	return rc;
+
+err_free_cp_desc_arr:
+	bnge_free_cp_desc_arr(cpr);
+	return rc;
+}
+
+static int bnge_alloc_nq_tree(struct bnge_net *bn)
+{
+	int i, j, ulp_msix, rc = -ENOMEM;
+	struct bnge_dev *bd = bn->bd;
+	int tcs = 1;
+
+	ulp_msix = bnge_aux_get_msix(bd);
+	for (i = 0, j = 0; i < bd->nq_nr_rings; i++) {
+		bool sh = !!(bd->flags & BNGE_EN_SHARED_CHNL);
+		struct bnge_napi *bnapi = bn->bnapi[i];
+		struct bnge_nq_ring_info *nqr;
+		struct bnge_cp_ring_info *cpr;
+		struct bnge_ring_struct *ring;
+		int cp_count = 0, k;
+		int rx = 0, tx = 0;
+
+		if (!bnapi)
+			continue;
+
+		nqr = &bnapi->nq_ring;
+		nqr->bnapi = bnapi;
+		ring = &nqr->ring_struct;
+
+		rc = bnge_alloc_ring(bd, &ring->ring_mem);
+		if (rc)
+			goto err_free_nq_tree;
+
+		ring->map_idx = ulp_msix + i;
+
+		if (i < bd->rx_nr_rings) {
+			cp_count++;
+			rx = 1;
+		}
+
+		if ((sh && i < bd->tx_nr_rings) ||
+		    (!sh && i >= bd->rx_nr_rings)) {
+			cp_count += tcs;
+			tx = 1;
+		}
+
+		nqr->cp_ring_arr = kcalloc(cp_count, sizeof(*cpr),
+					   GFP_KERNEL);
+		if (!nqr->cp_ring_arr)
+			goto err_free_nq_tree;
+
+		nqr->cp_ring_count = cp_count;
+
+		for (k = 0; k < cp_count; k++) {
+			cpr = &nqr->cp_ring_arr[k];
+			rc = alloc_one_cp_ring(bn, cpr);
+			if (rc)
+				goto err_free_nq_tree;
+
+			cpr->bnapi = bnapi;
+			cpr->cp_idx = k;
+			if (!k && rx) {
+				bn->rx_ring[i].rx_cpr = cpr;
+				cpr->cp_ring_type = BNGE_NQ_HDL_TYPE_RX;
+			} else {
+				int n, tc = k - rx;
+
+				n = BNGE_TC_TO_RING_BASE(bd, tc) + j;
+				bn->tx_ring[n].tx_cpr = cpr;
+				cpr->cp_ring_type = BNGE_NQ_HDL_TYPE_TX;
+			}
+		}
+		if (tx)
+			j++;
+	}
+	return 0;
+
+err_free_nq_tree:
+	bnge_free_nq_tree(bn);
+	return rc;
+}
+
 static bool bnge_separate_head_pool(struct bnge_rx_ring_info *rxr)
 {
 	return rxr->need_head_pool || PAGE_SIZE > BNGE_RX_PAGE_SIZE;
@@ -221,10 +452,19 @@ static int bnge_alloc_tx_rings(struct bnge_net *bn)
 	return rc;
 }
 
+static void bnge_free_ring_grps(struct bnge_net *bn)
+{
+	kfree(bn->grp_info);
+	bn->grp_info = NULL;
+}
+
 static void bnge_free_core(struct bnge_net *bn)
 {
 	bnge_free_tx_rings(bn);
 	bnge_free_rx_rings(bn);
+	bnge_free_nq_tree(bn);
+	bnge_free_nq_arrays(bn);
+	bnge_free_ring_grps(bn);
 	kfree(bn->tx_ring_map);
 	bn->tx_ring_map = NULL;
 	kfree(bn->tx_ring);
@@ -311,6 +551,10 @@ static int bnge_alloc_core(struct bnge_net *bn)
 		txr->bnapi = bnapi2;
 	}
 
+	rc = bnge_alloc_nq_arrays(bn);
+	if (rc)
+		goto err_free_core;
+
 	bnge_init_ring_struct(bn);
 
 	rc = bnge_alloc_rx_rings(bn);
@@ -318,6 +562,10 @@ static int bnge_alloc_core(struct bnge_net *bn)
 		goto err_free_core;
 
 	rc = bnge_alloc_tx_rings(bn);
+	if (rc)
+		goto err_free_core;
+
+	rc = bnge_alloc_nq_tree(bn);
 	if (rc)
 		goto err_free_core;
 	return 0;
@@ -327,6 +575,181 @@ static int bnge_alloc_core(struct bnge_net *bn)
 	return rc;
 }
 
+static int bnge_cp_num_to_irq_num(struct bnge_net *bn, int n)
+{
+	struct bnge_napi *bnapi = bn->bnapi[n];
+	struct bnge_nq_ring_info *nqr;
+
+	nqr = &bnapi->nq_ring;
+
+	return nqr->ring_struct.map_idx;
+}
+
+static irqreturn_t bnge_msix(int irq, void *dev_instance)
+{
+	/* NAPI scheduling to be added in a future patch */
+	return IRQ_HANDLED;
+}
+
+static void bnge_setup_msix(struct bnge_net *bn)
+{
+	struct net_device *dev = bn->netdev;
+	struct bnge_dev *bd = bn->bd;
+	int len, i;
+
+	len = sizeof(bd->irq_tbl[0].name);
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		int map_idx = bnge_cp_num_to_irq_num(bn, i);
+		char *attr;
+
+		if (bd->flags & BNGE_EN_SHARED_CHNL)
+			attr = "TxRx";
+		else if (i < bd->rx_nr_rings)
+			attr = "rx";
+		else
+			attr = "tx";
+
+		snprintf(bd->irq_tbl[map_idx].name, len, "%s-%s-%d", dev->name,
+			 attr, i);
+		bd->irq_tbl[map_idx].handler = bnge_msix;
+	}
+}
+
+static int bnge_setup_interrupts(struct bnge_net *bn)
+{
+	struct net_device *dev = bn->netdev;
+	struct bnge_dev *bd = bn->bd;
+	int rc;
+
+	if (!bd->irq_tbl) {
+		if (bnge_alloc_irqs(bd))
+			return -ENODEV;
+	}
+
+	bnge_setup_msix(bn);
+	rc = netif_set_real_num_queues(dev, bd->tx_nr_rings, bd->rx_nr_rings);
+	if (rc)
+		goto err_free_irqs;
+	return rc;
+
+err_free_irqs:
+	bnge_free_irqs(bd);
+	return rc;
+}
+
+static int bnge_request_irq(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i, rc;
+
+	rc = bnge_setup_interrupts(bn);
+	if (rc) {
+		netdev_err(bn->netdev, "bnge_setup_interrupts err: %d\n", rc);
+		return rc;
+	}
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		int map_idx = bnge_cp_num_to_irq_num(bn, i);
+		struct bnge_irq *irq = &bd->irq_tbl[map_idx];
+
+		rc = request_irq(irq->vector, irq->handler, 0, irq->name,
+				 bn->bnapi[i]);
+		if (rc)
+			break;
+
+		netif_napi_set_irq_locked(&bn->bnapi[i]->napi, irq->vector);
+		irq->requested = 1;
+
+		if (zalloc_cpumask_var(&irq->cpu_mask, GFP_KERNEL)) {
+			int numa_node = dev_to_node(&bd->pdev->dev);
+
+			irq->have_cpumask = 1;
+			cpumask_set_cpu(cpumask_local_spread(i, numa_node),
+					irq->cpu_mask);
+			rc = irq_set_affinity_hint(irq->vector, irq->cpu_mask);
+			if (rc) {
+				netdev_warn(bn->netdev,
+					    "Set affinity failed, IRQ = %d\n",
+					    irq->vector);
+				break;
+			}
+		}
+	}
+
+	return rc;
+}
+
+static int bnge_napi_poll(struct napi_struct *napi, int budget)
+{
+	int work_done = 0;
+
+	/* defer NAPI implementation to next patch series */
+	napi_complete_done(napi, work_done);
+
+	return work_done;
+}
+
+static void bnge_init_napi(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	struct bnge_napi *bnapi;
+	int i;
+
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		bnapi = bn->bnapi[i];
+		netif_napi_add_config_locked(bn->netdev, &bnapi->napi,
+					     bnge_napi_poll, bnapi->index);
+	}
+}
+
+static void bnge_del_napi(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i;
+
+	if (!bn->bnapi)
+		return;
+
+	for (i = 0; i < bd->rx_nr_rings; i++)
+		netif_queue_set_napi(bn->netdev, i, NETDEV_QUEUE_TYPE_RX, NULL);
+	for (i = 0; i < bd->tx_nr_rings; i++)
+		netif_queue_set_napi(bn->netdev, i, NETDEV_QUEUE_TYPE_TX, NULL);
+
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		struct bnge_napi *bnapi = bn->bnapi[i];
+
+		__netif_napi_del_locked(&bnapi->napi);
+	}
+
+	/* Wait for RCU grace period after removing NAPI instances */
+	synchronize_net();
+}
+
+static void bnge_free_irq(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	struct bnge_irq *irq;
+	int i;
+
+	if (!bd->irq_tbl || !bn->bnapi)
+		return;
+
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		int map_idx = bnge_cp_num_to_irq_num(bn, i);
+
+		irq = &bd->irq_tbl[map_idx];
+		if (irq->requested) {
+			if (irq->have_cpumask) {
+				irq_set_affinity_hint(irq->vector, NULL);
+				free_cpumask_var(irq->cpu_mask);
+				irq->have_cpumask = 0;
+			}
+			free_irq(irq->vector, bn->bnapi[i]);
+		}
+
+		irq->requested = 0;
+	}
+}
+
 static int bnge_open_core(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
@@ -346,8 +769,20 @@ static int bnge_open_core(struct bnge_net *bn)
 		return rc;
 	}
 
+	bnge_init_napi(bn);
+	rc = bnge_request_irq(bn);
+	if (rc) {
+		netdev_err(bn->netdev, "bnge_request_irq err: %d\n", rc);
+		goto err_del_napi;
+	}
+
 	set_bit(BNGE_STATE_OPEN, &bd->state);
 	return 0;
+
+err_del_napi:
+	bnge_del_napi(bn);
+	bnge_free_core(bn);
+	return rc;
 }
 
 static netdev_tx_t bnge_start_xmit(struct sk_buff *skb, struct net_device *dev)
@@ -374,6 +809,9 @@ static void bnge_close_core(struct bnge_net *bn)
 	struct bnge_dev *bd = bn->bd;
 
 	clear_bit(BNGE_STATE_OPEN, &bd->state);
+	bnge_free_irq(bn);
+	bnge_del_napi(bn);
+
 	bnge_free_core(bn);
 }
 
@@ -596,6 +1034,7 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 	bnge_init_l2_fltr_tbl(bn);
 	bnge_init_mac_addr(bd);
 
+	netdev->request_ops_lock = true;
 	rc = register_netdev(netdev);
 	if (rc) {
 		dev_err(bd->dev, "Register netdev failed rc: %d\n", rc);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 92bae665f59..8041951da18 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -133,6 +133,9 @@ enum {
 
 #define BNGE_NET_EN_TPA		(BNGE_NET_EN_GRO | BNGE_NET_EN_LRO)
 
+#define BNGE_NQ_HDL_TYPE_RX	0x00
+#define BNGE_NQ_HDL_TYPE_TX	0x01
+
 struct bnge_net {
 	struct bnge_dev		*bd;
 	struct net_device	*netdev;
@@ -172,6 +175,10 @@ struct bnge_net {
 
 	u16				*tx_ring_map;
 	enum dma_data_direction		rx_dir;
+
+	/* grp_info indexed by napi/nq index */
+	struct bnge_ring_grp_info	*grp_info;
+	int				total_irqs;
 };
 
 #define BNGE_DEFAULT_RX_RING_SIZE	511
@@ -223,6 +230,8 @@ struct bnge_cp_ring_info {
 	dma_addr_t		*desc_mapping;
 	struct tx_cmp		**desc_ring;
 	struct bnge_ring_struct	ring_struct;
+	u8			cp_ring_type;
+	u8			cp_idx;
 };
 
 struct bnge_nq_ring_info {
@@ -230,6 +239,9 @@ struct bnge_nq_ring_info {
 	dma_addr_t		*desc_mapping;
 	struct nqe_cn		**desc_ring;
 	struct bnge_ring_struct	ring_struct;
+
+	int				cp_ring_count;
+	struct bnge_cp_ring_info	*cp_ring_arr;
 };
 
 struct bnge_rx_ring_info {
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
index c79a3607a1b..5597af1b3b7 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
@@ -46,7 +46,7 @@ static int bnge_aux_get_dflt_msix(struct bnge_dev *bd)
 	return min_t(int, roce_msix, num_online_cpus() + 1);
 }
 
-static u16 bnge_aux_get_msix(struct bnge_dev *bd)
+u16 bnge_aux_get_msix(struct bnge_dev *bd)
 {
 	if (bnge_is_roce_en(bd))
 		return bd->aux_num_msix;
-- 
2.47.3


