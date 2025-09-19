Return-Path: <netdev+bounces-224813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BBBB8ACED
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 19:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36237585BFF
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 17:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4030F322DC7;
	Fri, 19 Sep 2025 17:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DP771FA7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f97.google.com (mail-oo1-f97.google.com [209.85.161.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0BD322DBA
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 17:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758304109; cv=none; b=JqNxpotGB3VoGZyiwikthaImdwdblAjH/EEGemsFj5aoxieRIwejMNNnQC6okq16OZLHvEG6i2Y0uC+oTU6pPwwCz3ediVys3ET+gQlshB/R8RSmCjQLEUW+C7nEwOYmERpsuLiH7IG4UX0q46g2cwO8Z1UX9SVRr7rpLx7vrJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758304109; c=relaxed/simple;
	bh=986ZgAiHCAzs5+S/kSV/dnX5tedqBxDFKoy2aeHmjAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iz+LQEP7sLiXMlpB2rnLKxM2ZZsVl1QHF/ilO+De8kfzkE2OW8iUA0f6NNM1MNtBtRnuSXQ64QJChUGNPh7I01rQizvC/Q5nOaOKEcn2eG5hUXYflgudRNGjBhNBG4WVy7qjfq+uTaslbV7j8Bdfb1q2Tc/4hKB9Uoh1jFtIaN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DP771FA7; arc=none smtp.client-ip=209.85.161.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f97.google.com with SMTP id 006d021491bc7-62189987b54so1284013eaf.3
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 10:48:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758304106; x=1758908906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w4/gA5U/tnXX8j6mDLvEdMncKn+aFLon9l2ymHb15JQ=;
        b=IKnXnq+JN4XVPGz/WIj0hJp1jC1jVMrs/IUoOPNoP4BTe1xv8K41JHvanfwK4knC3a
         gNgXIJkakWTrDbO52u0EIPx98CWtkrzVQIIpi11xBSvc8UgnRpnnL6/HWaQ4FqyidTxk
         +aOLOAihfC0AKVuCL4AB+7h0wuxp6hbTzYYCYhNtZuGzwuW+Vvf00xwu/pQGtVMu6pmk
         2ws1cDyW+Dgw5qU2R+w9p7fxw54FjNLWPoWVnTI/JeRBj9nz9J6APqKCvtKHU9K80mpk
         osvQNukv+G/VP33d0V7lVMb3NX100S5mFVrhHGs3V9pMWxy3MWV9U7j3GiSrLd0qQ4dG
         pMIA==
X-Gm-Message-State: AOJu0YxKqgha7T6GRfYKVLknXlBh5521Ukup/WlBC/CeQlr1D+5qUeCK
	YzDa0cZvl9mKB4Z0+g9JzOqEuG6RUxt1AW/Sr6EOCO5iifrNiqID2Dsx4O3a+kPjjR8Yow+Q6M4
	nCTgdGx+APOnE+AikbBdqlU1245W6hvT3iH4EX5VVppz7OnImD36Hdy4TUI2ppNdP3RUDlLPq/t
	/fc+tsJQtvdSfhNYpIObjdu/LQQ0ln6w0N9cc4//tHytxPWGQlsBrWDjj+WgIOvHejcq5meTCxN
	jCybijI7Z3DJtUxuJsQ
X-Gm-Gg: ASbGncuU61eqtm07OEIvJjzjDhCGoXdDHcZXBF52+hl1u/W8fDyXH52TDTjzHu0590A
	CnSaWW0uQNnuuhNPdYyWlILeiTArWLuJZ7nvghPY8blaT5mSuDvatdv5ZsH4eqpZnR3TLTpoNFz
	rY0wMlBKJjZLtTeJWjiIjViuChJ5tuPPYoexuD4Zos1eouDpnWZHnCTjDAyo2roQMgJReNKLxOK
	SEXNBntjKRQMFczEeKR0N2ygJ9O57++jpI7uTpDVzmFHnePHtf3+E+GmnY99BROd2oFCGhjTtG5
	EaeIzN/Nn7KR3/BB24J1vMzgP6GAGS0Nln7pmO2+ju0ZldBVhqe+Ssskuzm2+6F4FEt0Atg+o8b
	zr/EdiZPc10UzcG1g/o/7vZRrJ+L5zTzhSPyJSUMNILV3q5o9UdcfFZjMjEvu5D9K2fsDZtjcjQ
	00sPxdi2HD
X-Google-Smtp-Source: AGHT+IGXjR/JHUUGyDQcvA4NpsWRRtTZxt2+Q20NdZa7I31iXZTx6J1/7mBfaUR0f+xrkXzbgu+JUGZ2AKfP
X-Received: by 2002:a05:6820:60b:b0:623:48ee:a1fa with SMTP id 006d021491bc7-6272be5674fmr1829193eaf.8.1758304106065;
        Fri, 19 Sep 2025 10:48:26 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-625d8fe62d5sm287103eaf.7.2025.09.19.10.48.25
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Sep 2025 10:48:26 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32ee4998c4aso2305264a91.1
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 10:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758304104; x=1758908904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4/gA5U/tnXX8j6mDLvEdMncKn+aFLon9l2ymHb15JQ=;
        b=DP771FA7JfrHBcLOZlelno5nDhgMEji2QzVMBI2rWTv1lPdnK2iWBG4IfhYCBG3gyN
         otonVhpbL4DYwfK7E0i8A0OeD4hiT6/sqkRem/aFmeaQzgM3cKkx9d2ZUDmEFMgaDm+E
         HDR847W52IC/+x986Ks+Nkyn5dtHoHBk516h8=
X-Received: by 2002:a17:90b:3f48:b0:329:cb75:fef2 with SMTP id 98e67ed59e1d1-33097fd0cfemr5398410a91.3.1758304104279;
        Fri, 19 Sep 2025 10:48:24 -0700 (PDT)
X-Received: by 2002:a17:90b:3f48:b0:329:cb75:fef2 with SMTP id 98e67ed59e1d1-33097fd0cfemr5398389a91.3.1758304103677;
        Fri, 19 Sep 2025 10:48:23 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b55138043b6sm3513119a12.26.2025.09.19.10.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 10:48:23 -0700 (PDT)
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
Subject: [v8, net-next 03/10] bng_en: Add initial support for CP and NQ rings
Date: Fri, 19 Sep 2025 23:17:34 +0530
Message-ID: <20250919174742.24969-4-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919174742.24969-1-bhargava.marreddy@broadcom.com>
References: <20250919174742.24969-1-bhargava.marreddy@broadcom.com>
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
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 413 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  10 +
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |   2 +-
 4 files changed, 425 insertions(+), 1 deletion(-)

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
index c25a793b8ae..67da7001427 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -27,6 +27,233 @@
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
+	struct bnge_dev *bd = bn->bd;
+	int i, j, ulp_msix, rc;
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
+		if (!nqr->cp_ring_arr) {
+			rc = -ENOMEM;
+			goto err_free_nq_tree;
+		}
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
@@ -216,6 +443,8 @@ static void bnge_free_core(struct bnge_net *bn)
 {
 	bnge_free_tx_rings(bn);
 	bnge_free_rx_rings(bn);
+	bnge_free_nq_tree(bn);
+	bnge_free_nq_arrays(bn);
 	kfree(bn->tx_ring_map);
 	bn->tx_ring_map = NULL;
 	kfree(bn->tx_ring);
@@ -302,6 +531,10 @@ static int bnge_alloc_core(struct bnge_net *bn)
 		txr->bnapi = bnapi2;
 	}
 
+	rc = bnge_alloc_nq_arrays(bn);
+	if (rc)
+		goto err_free_core;
+
 	bnge_init_ring_struct(bn);
 
 	rc = bnge_alloc_rx_rings(bn);
@@ -309,6 +542,10 @@ static int bnge_alloc_core(struct bnge_net *bn)
 		goto err_free_core;
 
 	rc = bnge_alloc_tx_rings(bn);
+	if (rc)
+		goto err_free_core;
+
+	rc = bnge_alloc_nq_tree(bn);
 	if (rc)
 		goto err_free_core;
 	return 0;
@@ -318,6 +555,166 @@ static int bnge_alloc_core(struct bnge_net *bn)
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
+
+	bnge_setup_msix(bn);
+
+	return netif_set_real_num_queues(dev, bd->tx_nr_rings, bd->rx_nr_rings);
+}
+
+static void bnge_free_irq(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	struct bnge_irq *irq;
+	int i;
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
+			goto err_free_irq;
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
+				goto err_free_irq;
+			}
+		}
+	}
+	return 0;
+
+err_free_irq:
+	bnge_free_irq(bn);
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
 static int bnge_open_core(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
@@ -337,8 +734,20 @@ static int bnge_open_core(struct bnge_net *bn)
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
@@ -365,6 +774,9 @@ static void bnge_close_core(struct bnge_net *bn)
 	struct bnge_dev *bd = bn->bd;
 
 	clear_bit(BNGE_STATE_OPEN, &bd->state);
+	bnge_free_irq(bn);
+	bnge_del_napi(bn);
+
 	bnge_free_core(bn);
 }
 
@@ -587,6 +999,7 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 	bnge_init_l2_fltr_tbl(bn);
 	bnge_init_mac_addr(bd);
 
+	netdev->request_ops_lock = true;
 	rc = register_netdev(netdev);
 	if (rc) {
 		dev_err(bd->dev, "Register netdev failed rc: %d\n", rc);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 92bae665f59..bccddae09fa 100644
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
@@ -172,6 +175,8 @@ struct bnge_net {
 
 	u16				*tx_ring_map;
 	enum dma_data_direction		rx_dir;
+
+	int				total_irqs;
 };
 
 #define BNGE_DEFAULT_RX_RING_SIZE	511
@@ -223,6 +228,8 @@ struct bnge_cp_ring_info {
 	dma_addr_t		*desc_mapping;
 	struct tx_cmp		**desc_ring;
 	struct bnge_ring_struct	ring_struct;
+	u8			cp_ring_type;
+	u8			cp_idx;
 };
 
 struct bnge_nq_ring_info {
@@ -230,6 +237,9 @@ struct bnge_nq_ring_info {
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


