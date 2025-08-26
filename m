Return-Path: <netdev+bounces-216882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6FEB35B15
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 820A83B56A0
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 11:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710D4321433;
	Tue, 26 Aug 2025 11:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Hy0ojCat"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914CE31CA7C
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 11:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207057; cv=none; b=j54mA0zA7b5yI/8HrFpKKf7PCU4yEJwVWa/ewoSXXl8IfNrDvytm2LjJlDppGHQ5RvxFwjeKryAqwDKjCq090Uq/n6Swnk928hFH0GMdv+MY2Fi0iyhtzfCquNd5qyGLgPXP7/L18KpNQzGIF7PSGy4ld63UzdTp+BSRJhFUpCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207057; c=relaxed/simple;
	bh=mqc66Rd4OFHB8FGSet61CfCkE0/bn5eSG3iApS1it/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/OCCtSu++mpYpiOVXGbsd1+7MltWtEVb+CQuCZ770gcQEcEP2Dy9jFC5vYtHfnRMV1g04we+muW5FlFZdRguIGkvIYuBCW+CIVsYU3PxgLy6jhNXWV2lDa4BC81jGytilki/K5sGejwfEtFWdMOVWKIdm8vmOhyBOoYpF9TZs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Hy0ojCat; arc=none smtp.client-ip=209.85.215.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso4802551a12.3
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 04:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756207055; x=1756811855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ntJGYEUiuBh9zZugRw94xx78BQdVs+C9ZGQw3nQQ1EI=;
        b=bm496F8rXrKM1JuB3bwUfyiBH1xt/6BTsYCgky96aXFzdRIk8375CQrsuX6q8cs0c1
         UUGBuGh/iuYQFtcygJgn4ckE8HD5HgdpHmDA6b/zShF9sHJgo1ndzAyxDacWBJUNu9c6
         fKpI3ScYbebHnYSynttOlMxmVhQBrANPJdJOUOA94BnfVeBWRoqS+lD2kTk70P7+bzQS
         dbBDogg0mosC6MDEQy485u+sB/QsBJxsOLPRaW/j7gn+9a4+v3Ejapq+nJc+TuFx774i
         8+LDc0iyTasDdFO24nUB6BvDT42c+MPtlrnwJudm6WFthYOpPIUQduobqaz63P2b0S3o
         79iA==
X-Gm-Message-State: AOJu0YwA7DxzQYlysgub5hB/h89Fum9vmwlnEmhzNgVfoSL4wWLJ9P4w
	rUnOr0K1MtCPczIQDgUM0MWKqdeOA4qzDiAmA1JoZi+QIznuc/BIkiMn/FEyZEAABH8DLleJ6zd
	g8woW24Rfd3HjYjCFLce8Ux0YDMhMlan01NGbSCAJUYyDlKGnF6cJOt/b08+dkxauIG6Na51RBH
	3M7KJ8tlg1ULdHELzwoEXCoJ4+/cM2pm9GIpg6obxbWWAPYdjuJhggSzRnthW/yfgjs98qy0NRs
	ygF4Xa1QZKtqNs5o4fU
X-Gm-Gg: ASbGnctmoJ27qXDMynntqNuKfRcUT6k06/FfJrIzumXo6qylGpYxWzi0iHC3zolK+/H
	JIoepQZcMlSWbs6KV6elmgtPz3cE7mcWk5zAJvhZDQJetFL0YJVK5jucjb3fh5+dGmFoHwzXlWI
	4I/yte8/stVWjV8XZLdBdU1G2R0N1q/rOZVvLQvPPA7DM+Y2iCOftIVOs6boPOB/pXz0k0pLCCj
	H1LNnvWBPhbsgogrB7XGFMMHZjObLRqMlG1KzC5aUaNnrYgApXmGE+Re1ghjdcjaOTU6PtBcXDQ
	Cmju2Ldxgsw/tVA094ZtdPGJesyfxMWyevrGCHn8yKYEJZIrifgUYR0NE6+9fN5ra9ZrTps0Y++
	UkKFuAzI+NQeyL3ff/eZY4L3p3T/jcfE/9oQ8Z90J5Uwk2mu4tU8pH5kU7lQs7VT5xHqFvXtkmr
	7RwB0clg==
X-Google-Smtp-Source: AGHT+IEYoi4s2nYQj9MzXUf+x+6qbbDv01RmErV4zf1ENc1JHPUyExnRwVeUW7r3Pdpvt+M341IscPhyojfV
X-Received: by 2002:a17:903:178b:b0:240:8cec:4823 with SMTP id d9443c01a7336-2462eeea432mr186689935ad.41.1756207054817;
        Tue, 26 Aug 2025 04:17:34 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2466879196asm8419645ad.9.2025.08.26.04.17.34
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Aug 2025 04:17:34 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77053dd5eecso4880740b3a.3
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 04:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756207053; x=1756811853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntJGYEUiuBh9zZugRw94xx78BQdVs+C9ZGQw3nQQ1EI=;
        b=Hy0ojCataldX0hFBZg8j0mQeZ9Xmb7S0gJd49DRAs7kQaTCuF4fvTIcICB0phRVqxf
         2P5+uhGnHqB4s5F1gShDisbvr9b0NX284WKBSxRV9vkHRo8cfJ0DK9ksnSFf7UteQbJa
         +3GqN2jr4qNBiGv3h9vmJ7prUnKwSMNV89QKU=
X-Received: by 2002:a05:6300:210c:b0:23f:f7ae:6e1c with SMTP id adf61e73a8af0-24340d00d45mr20808043637.25.1756207052737;
        Tue, 26 Aug 2025 04:17:32 -0700 (PDT)
X-Received: by 2002:a05:6300:210c:b0:23f:f7ae:6e1c with SMTP id adf61e73a8af0-24340d00d45mr20808007637.25.1756207052193;
        Tue, 26 Aug 2025 04:17:32 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77054bb0c46sm7280339b3a.41.2025.08.26.04.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 04:17:31 -0700 (PDT)
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
Subject: [v4, net-next 2/9] bng_en: Add initial support for CP and NQ rings
Date: Tue, 26 Aug 2025 16:44:05 +0000
Message-ID: <20250826164412.220565-3-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250826164412.220565-1-bhargava.marreddy@broadcom.com>
References: <20250826164412.220565-1-bhargava.marreddy@broadcom.com>
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
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 434 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  12 +
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |   2 +-
 4 files changed, 448 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index 2d3b2fd57be4..07df86f0061f 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -219,5 +219,6 @@ static inline bool bnge_is_agg_reqd(struct bnge_dev *bd)
 }
 
 bool bnge_aux_registered(struct bnge_dev *bd);
+u16 bnge_aux_get_msix(struct bnge_dev *bd);
 
 #endif /* _BNGE_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 947072707e64..dd56e8b5eee9 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -27,6 +27,225 @@
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
+		return -ENOMEM;
+
+	return 0;
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
+		return -ENOMEM;
+
+	return 0;
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
+	int i;
+
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		struct bnge_napi *bnapi = bn->bnapi[i];
+		int rc;
+
+		rc = bnge_alloc_nq_desc_arr(&bnapi->nq_ring, bn->cp_nr_pages);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
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
+	if (rc) {
+		bnge_free_cp_desc_arr(cpr);
+		return -ENOMEM;
+	}
+	ring = &cpr->ring_struct;
+	rmem = &ring->ring_mem;
+	rmem->nr_pages = bn->cp_nr_pages;
+	rmem->page_size = HW_CMPD_RING_SIZE;
+	rmem->pg_arr = (void **)cpr->desc_ring;
+	rmem->dma_arr = cpr->desc_mapping;
+	rmem->flags = BNGE_RMEM_RING_PTE_FLAG;
+	rc = bnge_alloc_ring(bd, rmem);
+	if (rc) {
+		bnge_free_ring(bd, rmem);
+		bnge_free_cp_desc_arr(cpr);
+	}
+
+	return rc;
+}
+
+static int bnge_alloc_nq_tree(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i, j, rc, ulp_msix;
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
+			return rc;
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
+			return -ENOMEM;
+
+		nqr->cp_ring_count = cp_count;
+
+		for (k = 0; k < cp_count; k++) {
+			cpr = &nqr->cp_ring_arr[k];
+			rc = alloc_one_cp_ring(bn, cpr);
+			if (rc)
+				return rc;
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
+
+	return 0;
+}
+
 static bool bnge_separate_head_pool(struct bnge_rx_ring_info *rxr)
 {
 	return rxr->need_head_pool || PAGE_SIZE > BNGE_RX_PAGE_SIZE;
@@ -216,10 +435,19 @@ static int bnge_alloc_tx_rings(struct bnge_net *bn)
 	return 0;
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
@@ -307,6 +535,10 @@ static int bnge_alloc_core(struct bnge_net *bn)
 		txr->bnapi = bnapi2;
 	}
 
+	rc = bnge_alloc_nq_arrays(bn);
+	if (rc)
+		goto err_free_core;
+
 	bnge_init_ring_struct(bn);
 
 	rc = bnge_alloc_rx_rings(bn);
@@ -317,13 +549,198 @@ static int bnge_alloc_core(struct bnge_net *bn)
 	if (rc)
 		goto err_free_core;
 
+	rc = bnge_alloc_nq_tree(bn);
+	if (rc)
+		goto err_free_core;
+
 	return 0;
 
 err_free_core:
 	bnge_free_core(bn);
+
+	return rc;
+}
+
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
+static int bnge_set_real_num_queues(struct bnge_net *bn)
+{
+	struct net_device *dev = bn->netdev;
+	struct bnge_dev *bd = bn->bd;
+	int rc;
+
+	rc = netif_set_real_num_tx_queues(dev, bd->tx_nr_rings);
+	if (rc)
+		return rc;
+
+	return netif_set_real_num_rx_queues(dev, bd->rx_nr_rings);
+}
+
+static int bnge_setup_interrupts(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+
+	if (!bd->irq_tbl) {
+		if (bnge_alloc_irqs(bd))
+			return -ENODEV;
+	}
+
+	bnge_setup_msix(bn);
+
+	return bnge_set_real_num_queues(bn);
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
 	return rc;
 }
 
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
+		netif_napi_add_config(bn->netdev, &bnapi->napi, bnge_napi_poll,
+				      bnapi->index);
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
+		__netif_napi_del(&bnapi->napi);
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
@@ -343,8 +760,22 @@ static int bnge_open_core(struct bnge_net *bn)
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
+
 	return 0;
+
+err_del_napi:
+	bnge_del_napi(bn);
+	bnge_free_core(bn);
+
+	return rc;
 }
 
 static netdev_tx_t bnge_start_xmit(struct sk_buff *skb, struct net_device *dev)
@@ -371,6 +802,9 @@ static void bnge_close_core(struct bnge_net *bn)
 	struct bnge_dev *bd = bn->bd;
 
 	clear_bit(BNGE_STATE_OPEN, &bd->state);
+	bnge_free_irq(bn);
+	bnge_del_napi(bn);
+
 	bnge_free_core(bn);
 }
 
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 92bae665f59c..8041951da187 100644
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
index c79a3607a1b7..5597af1b3b7c 100644
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


