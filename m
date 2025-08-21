Return-Path: <netdev+bounces-215707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4AFB2FF84
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 18:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D39A8643186
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 15:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1152E1EE3;
	Thu, 21 Aug 2025 15:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="a212Yefm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f227.google.com (mail-il1-f227.google.com [209.85.166.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E6F2D46C6
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791328; cv=none; b=NoFO99QZl+JST6Anass0+n8pElA64QQkd2SzAa9GM8J2tFeT0uG39frgpSrQAeNfL6aAOfNFHAt52c6CF+BMlzRLM0gzx+lkGM9Z9NuhIt7w1yHV5qx6GDFb5NiUOiUfMxkY7aB5gZMfWH5v1+tIkm+VgrmmPDGZ1I6e7P5ljis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791328; c=relaxed/simple;
	bh=nXyZRA9+gHj8W2U0UoMcEhEznq/0rEd1gJGLnGuKaVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tq7OcwzPSs6suuUrJ7UNGi1xetFnQyHWOd1rL2hOvbIEDti9AdVW1bzwXdl1Rj6627L02PwQjZGnZZ2uOTF95QboNMIxrKab6sCMeDp2N+lMC8BjgnGRjX34jIqEAEGiwpQf5HJw90zRffgDQP5eGT5gXzgZEq7B9FItApNh2Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=a212Yefm; arc=none smtp.client-ip=209.85.166.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f227.google.com with SMTP id e9e14a558f8ab-3e669190664so9437315ab.2
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 08:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755791325; x=1756396125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lrvvzFuDGf6iofRkb7kVzWtJZa/wCHeLkIlK4b5QY+o=;
        b=Bai426SNniE2coQ3CsY+L0IQ7kIDT/i2jCpFz7e5J50wOPIXYFWe2CTiMNyDJZSFON
         8rH2D30ab9eWSBje6F++uEmqCnctrvnsj1+r2XY7Z+kkT/dYls/VWGPEoEsCK2yaofW8
         6uuGjiydfByqB+UN3zwLbsvGQVW2GDnvjBB4VKL4sTzwLThrPtUr4ZABoDie0yBiR05q
         /HoKuTR3K0J789buyCjrD3eMKbW1VNOLb8fx2P+HW6Xs94EgHoF3kWsvOLnGPmDcUcL+
         e2fyOEr+301/YF/Fb4dQpPz2Q7z2gg+8MrobJyjwlu0A7g8hSwEzViaK88rAG/qVhA93
         aFDQ==
X-Gm-Message-State: AOJu0YwzbZz8nuOBuIRZOdG1sa8+N8AXwIZjJc7CQ0Fo0Q9VFJb+diNT
	jA06SBgQE2c/pMPegkBuliBl0r36tDWVkhkmKcxRO/Ep/87KCaP+a6qLsoJmKPrNVVugrJli+a2
	duW6lhLLrVKpBDO3MEe+HETKuF17Knz78lRIVfURDPUVFq+RdToBCl1Oj8ygUuwQ+NLZyuYrB82
	1CWUxyiox5Iq57trXAQUNN7XWwYMjdMbCByudRR6G5igK4rfVaQh8r72OIgmoPTdCFyk3RoX4+z
	IS+tF3YdQqj6mtR+eW+
X-Gm-Gg: ASbGnctEwhrMJnwfuEssgJ7hmrPvD7q3Bi+wRQs1vLqoD7nHp1eyaAybtqR+r5rvL90
	UPUQVb1wly0IRNWh7igH8rcqSxPLf8kXggeA3TammcwWCHqHYiKQ0bXwvZN6KvElLyUrBQhU30X
	e9TEYgIda7va1neydokEzseazWKOg7mOoKqXjVKz4QsL+ZimEWT6Kk6QOGr+jhBAtcKW9Ymg3TS
	vdZI9UuymVMwD3V0M7Aig873dt5pIeeaU1DbebbAsVggG1IfBasIyYDPvJZaLFSWhabt+hj+EEF
	oupjm3TDiDncDRIix2p6dLzC03TfSzj2Muco83SXaezZ7bZFX0IDTQt9O0YRQtJkssn4g/wLmXB
	liTbqpsu8NoVXJqb34eV1fNO15H/s1MhMlrIpet8x1LmvXfsd0N9eIiC9AwGEQe8flVj5CLKCrb
	StcPPlfA==
X-Google-Smtp-Source: AGHT+IGx0vf5LGe+T+TlDbyLs23Vxx0LFwmdZqMZsSTJOEFGg/Qm/lflvvB1tyy9ZMcEncyI+DkhSv+CwaNt
X-Received: by 2002:a05:6e02:1485:b0:3e5:3520:4a75 with SMTP id e9e14a558f8ab-3e6d84eb178mr45528035ab.23.1755791325163;
        Thu, 21 Aug 2025 08:48:45 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3e67a13e2c7sm4754785ab.45.2025.08.21.08.48.44
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Aug 2025 08:48:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b47475cf8edso1921804a12.3
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 08:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755791324; x=1756396124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrvvzFuDGf6iofRkb7kVzWtJZa/wCHeLkIlK4b5QY+o=;
        b=a212Yefmp5GnDYYuylKdyajyZnN+NsShszsBRa3ZsU3qzwZ0WmwhkW8+3QAOxY0xsx
         O2hxzWS/fhpFKCbOWz5aznMKVphR6pJuu7T+gpV6EugVQtQkQWNVgJeUn1s3py52x//S
         ipK2zICNJktX+Tqq9PTyJfc0L2E++eB7lx/jc=
X-Received: by 2002:a05:6a20:9147:b0:240:1c56:6485 with SMTP id adf61e73a8af0-243307b86aamr4182487637.3.1755791323588;
        Thu, 21 Aug 2025 08:48:43 -0700 (PDT)
X-Received: by 2002:a05:6a20:9147:b0:240:1c56:6485 with SMTP id adf61e73a8af0-243307b86aamr4182446637.3.1755791323056;
        Thu, 21 Aug 2025 08:48:43 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b47640b2d37sm5046894a12.46.2025.08.21.08.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:48:42 -0700 (PDT)
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
Subject: [v3, net-next 2/9] bng_en: Add initial support for CP and NQ rings
Date: Thu, 21 Aug 2025 21:15:10 +0000
Message-ID: <20250821211517.16578-3-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250821211517.16578-1-bhargava.marreddy@broadcom.com>
References: <20250821211517.16578-1-bhargava.marreddy@broadcom.com>
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
index 9fbb1c385fe8..d8976faabd3c 100644
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
@@ -209,10 +428,19 @@ static int bnge_alloc_tx_rings(struct bnge_net *bn)
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
@@ -300,6 +528,10 @@ static int bnge_alloc_core(struct bnge_net *bn)
 		txr->bnapi = bnapi2;
 	}
 
+	rc = bnge_alloc_nq_arrays(bn);
+	if (rc)
+		goto err_free_core;
+
 	bnge_init_ring_struct(bn);
 
 	rc = bnge_alloc_rx_rings(bn);
@@ -310,13 +542,198 @@ static int bnge_alloc_core(struct bnge_net *bn)
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
@@ -336,8 +753,22 @@ static int bnge_open_core(struct bnge_net *bn)
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
@@ -364,6 +795,9 @@ static void bnge_close_core(struct bnge_net *bn)
 	struct bnge_dev *bd = bn->bd;
 
 	clear_bit(BNGE_STATE_OPEN, &bd->state);
+	bnge_free_irq(bn);
+	bnge_del_napi(bn);
+
 	bnge_free_core(bn);
 }
 
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index b78b5e6d3edd..665a20380ded 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -132,6 +132,9 @@ enum {
 
 #define BNGE_NET_EN_TPA		(BNGE_NET_EN_GRO | BNGE_NET_EN_LRO)
 
+#define BNGE_NQ_HDL_TYPE_RX	0x00
+#define BNGE_NQ_HDL_TYPE_TX	0x01
+
 struct bnge_net {
 	struct bnge_dev		*bd;
 	struct net_device	*netdev;
@@ -171,6 +174,10 @@ struct bnge_net {
 
 	u16				*tx_ring_map;
 	enum dma_data_direction		rx_dir;
+
+	/* grp_info indexed by napi/nq index */
+	struct bnge_ring_grp_info	*grp_info;
+	int				total_irqs;
 };
 
 #define BNGE_DEFAULT_RX_RING_SIZE	511
@@ -222,6 +229,8 @@ struct bnge_cp_ring_info {
 	dma_addr_t		*desc_mapping;
 	struct tx_cmp		**desc_ring;
 	struct bnge_ring_struct	ring_struct;
+	u8			cp_ring_type;
+	u8			cp_idx;
 };
 
 struct bnge_nq_ring_info {
@@ -229,6 +238,9 @@ struct bnge_nq_ring_info {
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


