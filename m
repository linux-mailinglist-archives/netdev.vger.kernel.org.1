Return-Path: <netdev+bounces-138367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 786999AD151
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 18:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A2A81C220CC
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 16:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546D51CEAAD;
	Wed, 23 Oct 2024 16:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="gbbs8smV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A201E51D
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 16:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729702176; cv=none; b=MQb8KxWpGGEIIiROkViRitaP4F3UKF13ETivhWWKEQ8bczxyYodaptTiaEbmTH6nk/8/rHupbMSLIJdVoWgCZsylcJJOHds7vBm9i2PWeNT/TXbvHGCYag9n/eBeWHgh6D2TR05to0NzXHllpo93NgXUok565jQjiri6Rhgs+LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729702176; c=relaxed/simple;
	bh=1Qd+2UIw5mTpdPBN1+YzSM7lu4G3D+Yef7o0N57hWqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E1lgTHz4VduuQ5ue4MeFWupbn7rcukZbSFnYvtXvEXKRKnfeavp2fa/msQ9CqGJVqlv+gsvJygPvFWibZXMFBTeyRxdZcTnSRr2mGyVvb8cl/vKSqSP3ChNwhklAmIimD45suLokMguM1x949DC0aR/APZY3BO4uN098wv4lJtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=gbbs8smV; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-2e2b720a0bbso10987a91.1
        for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 09:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1729702173; x=1730306973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KfrVJPD6wQsyemhoHqMNM3VAmkUeo82vYBV9ptYW5bA=;
        b=gbbs8smVnLhiz02n0BC34EQziTaqrwZ+TmthVQWZNNGI+kQlXmBl/y6BAPKk77soBM
         fKwS22DXlUFT0qVHZgRt9Ad7q3FafOoOLnf7AAeqPQoBtLOl21j0FWeRG3QVp2tSJVUw
         Juyj7qxyA5xdbe8N36ubAZfE97j3nVLNAEkJckSazKzubAM78GWqgNR8jZ+hmw4YNgiQ
         UFHVaQ24BqHcG6AbXAOXDRggR4FIm8x76xIugFbAbt44btN+he2B6/d4UnQCJEtrCPti
         qVHBqTO/r/cC9DmWkXyjzQiS9Sn+zEHBoZL1IZ5pDTQCblQa4HrAI7KvsaGzNFGd0o26
         MTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729702173; x=1730306973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KfrVJPD6wQsyemhoHqMNM3VAmkUeo82vYBV9ptYW5bA=;
        b=VoKDoK2KznuIEXvetGjPQhqWnfnyhnpGVQ7GIxOHMYsOL2R4RKzc1jhSaYxt4HpxzT
         Es58q6go4pIHkGts5LkcDxJ35dfTwj0PFihSaJEznhyYrBNk5rqMb2GgwNViKg9uPm50
         WTpnrJD5gfBDoe6/zde8IGMsUH0NgO4wb3WDViHzYK0rWtD/8oV0uoxsHmk/BVqbuGSh
         SlgUjpdQDiM7L5m3E6SLqV7U+xSEBMBVRRMHuflAxL6sisfopEgisMPsOtd2HIfN8+nM
         M2p7PX+3D3Tw0chGcCp5/NlycMiVAswj9Misi55t5cj4uMxS7jpxIKtErHcdHjLYQlPg
         YJpA==
X-Forwarded-Encrypted: i=1; AJvYcCVDrxhImUEdGuak4Cq/9gsj/1nqF+mgVtRXzo5HyeNUIBp0iBZrj3YMkoglIvJKDI8Hh/bOiEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9ISW/sFD40bMaVHDv7b8qLrNL5ot7KTImNzCkiVjpkgk1y30w
	1naeMGUgToVs35JfG6QzlaG+YsetsViaX01YINLTqnHhcm7hvxO31YHqWLg5yJkUpnVoWUsISqY
	GOndE2AG5d2gdupXukx7jstCNsQjIcESz
X-Google-Smtp-Source: AGHT+IGpi4/pmXTMK1N8jp+RIMLveFc6P+F8kPqtYgzHyaG4VHfRlGhO9+E0PrID1AZP6Sao7JzqQolTTrEK
X-Received: by 2002:a17:903:2447:b0:20c:d04f:94ad with SMTP id d9443c01a7336-20fa9e2627emr19253295ad.4.1729702172699;
        Wed, 23 Oct 2024 09:49:32 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-20e7f1a11c5sm2540035ad.144.2024.10.23.09.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 09:49:32 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id D51EF340213;
	Wed, 23 Oct 2024 10:49:31 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id C887CE40BE0; Wed, 23 Oct 2024 10:49:01 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mlx5: fix typo in "mlx5_cqwq_get_cqe_enahnced_comp"
Date: Wed, 23 Oct 2024 10:48:38 -0600
Message-ID: <20241023164840.140535-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"enahnced" looks to be a misspelling of "enhanced".
Rename "mlx5_cqwq_get_cqe_enahnced_comp" to
"mlx5_cqwq_get_cqe_enhanced_comp".

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c   | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/wq.h      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index e601324a690a..604c0a72aa6c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1124,11 +1124,11 @@ static void mlx5e_flush_rq_cq(struct mlx5e_rq *rq)
 {
 	struct mlx5_cqwq *cqwq = &rq->cq.wq;
 	struct mlx5_cqe64 *cqe;
 
 	if (test_bit(MLX5E_RQ_STATE_MINI_CQE_ENHANCED, &rq->state)) {
-		while ((cqe = mlx5_cqwq_get_cqe_enahnced_comp(cqwq)))
+		while ((cqe = mlx5_cqwq_get_cqe_enhanced_comp(cqwq)))
 			mlx5_cqwq_pop(cqwq);
 	} else {
 		while ((cqe = mlx5_cqwq_get_cqe(cqwq)))
 			mlx5_cqwq_pop(cqwq);
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 8e24ba96c779..d81083f4f316 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2434,11 +2434,11 @@ static int mlx5e_rx_cq_process_enhanced_cqe_comp(struct mlx5e_rq *rq,
 {
 	struct mlx5_cqe64 *cqe, *title_cqe = NULL;
 	struct mlx5e_cq_decomp *cqd = &rq->cqd;
 	int work_done = 0;
 
-	cqe = mlx5_cqwq_get_cqe_enahnced_comp(cqwq);
+	cqe = mlx5_cqwq_get_cqe_enhanced_comp(cqwq);
 	if (!cqe)
 		return work_done;
 
 	if (cqd->last_cqe_title &&
 	    (mlx5_get_cqe_format(cqe) == MLX5_COMPRESSED)) {
@@ -2464,11 +2464,11 @@ static int mlx5e_rx_cq_process_enhanced_cqe_comp(struct mlx5e_rq *rq,
 		INDIRECT_CALL_3(rq->handle_rx_cqe, mlx5e_handle_rx_cqe_mpwrq,
 				mlx5e_handle_rx_cqe, mlx5e_handle_rx_cqe_mpwrq_shampo,
 				rq, cqe);
 		work_done++;
 	} while (work_done < budget_rem &&
-		 (cqe = mlx5_cqwq_get_cqe_enahnced_comp(cqwq)));
+		 (cqe = mlx5_cqwq_get_cqe_enhanced_comp(cqwq)));
 
 	/* last cqe might be title on next poll bulk */
 	if (title_cqe) {
 		mlx5e_read_enhanced_title_slot(rq, title_cqe);
 		cqd->last_cqe_title = true;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/wq.h b/drivers/net/ethernet/mellanox/mlx5/core/wq.h
index e4ef1d24a3ad..6debb8fd33ff 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/wq.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/wq.h
@@ -242,11 +242,11 @@ static inline struct mlx5_cqe64 *mlx5_cqwq_get_cqe(struct mlx5_cqwq *wq)
 
 	return cqe;
 }
 
 static inline
-struct mlx5_cqe64 *mlx5_cqwq_get_cqe_enahnced_comp(struct mlx5_cqwq *wq)
+struct mlx5_cqe64 *mlx5_cqwq_get_cqe_enhanced_comp(struct mlx5_cqwq *wq)
 {
 	u8 sw_validity_iteration_count = mlx5_cqwq_get_wrap_cnt(wq) & 0xff;
 	u32 ci = mlx5_cqwq_get_ci(wq);
 	struct mlx5_cqe64 *cqe;
 
-- 
2.45.2


