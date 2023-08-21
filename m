Return-Path: <netdev+bounces-29390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B60782FC9
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 19:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3DA5280E1D
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 17:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42299F513;
	Mon, 21 Aug 2023 17:57:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C975D11712
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 17:57:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23258C43391;
	Mon, 21 Aug 2023 17:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692640675;
	bh=HEZn8Z35s+8r/41VTXz4RtTH0IBRRWWcuAc/OQouMW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iqemnBc+kG81qXDWyErdfXeTDbu/yYx6hvD01UEY36eekpWR8meUcmbMlJ0hQdM12
	 efaNfgCcXVbn+VLcCHHtS/VsYnAHCEY3SeFHxHaXyRV/JXXoJ15d/d5Qz82mibS+vb
	 LUZehQlzLbz/HcCe+RQ/EhHQoVwlj2v/QlBcB4WYR4cknNnKf0MYmFx6HeuHmxQifd
	 EgDX7o9UPKmTm+M/9Vp3JdPrzcJoVXZS4P7t5xIp8U83tXsHk3xR2PePOqWqGQsnCw
	 6J98VxxRiU/FzI8lQbdW3Krb/wr3huvyhUFPDb4B8r3ddHIomBKXWhOcbixKq9ahPV
	 Bekjlzpl0bKYw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Shay Drory <shayd@nvidia.com>
Subject: [net-next V2 05/14] net/mlx5: IRQ, consolidate irq and affinity mask allocation
Date: Mon, 21 Aug 2023 10:57:30 -0700
Message-ID: <20230821175739.81188-6-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821175739.81188-1-saeed@kernel.org>
References: <20230821175739.81188-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

Consolidate the mlx5_irq and mlx5_irq->mask allocation, to simplify
error flows and to match the dealloctation sequence @irq_release for
symmetry.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index 33a133c9918c..653648216730 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -259,8 +259,11 @@ struct mlx5_irq *mlx5_irq_alloc(struct mlx5_irq_pool *pool, int i,
 	int err;
 
 	irq = kzalloc(sizeof(*irq), GFP_KERNEL);
-	if (!irq)
+	if (!irq || !zalloc_cpumask_var(&irq->mask, GFP_KERNEL)) {
+		kfree(irq);
 		return ERR_PTR(-ENOMEM);
+	}
+
 	if (!i || !pci_msix_can_alloc_dyn(dev->pdev)) {
 		/* The vector at index 0 is always statically allocated. If
 		 * dynamic irq is not supported all vectors are statically
@@ -297,11 +300,7 @@ struct mlx5_irq *mlx5_irq_alloc(struct mlx5_irq_pool *pool, int i,
 		mlx5_core_err(dev, "Failed to request irq. err = %d\n", err);
 		goto err_req_irq;
 	}
-	if (!zalloc_cpumask_var(&irq->mask, GFP_KERNEL)) {
-		mlx5_core_warn(dev, "zalloc_cpumask_var failed\n");
-		err = -ENOMEM;
-		goto err_cpumask;
-	}
+
 	if (af_desc) {
 		cpumask_copy(irq->mask, &af_desc->mask);
 		irq_set_affinity_and_hint(irq->map.virq, irq->mask);
@@ -319,8 +318,6 @@ struct mlx5_irq *mlx5_irq_alloc(struct mlx5_irq_pool *pool, int i,
 err_xa:
 	if (af_desc)
 		irq_update_affinity_hint(irq->map.virq, NULL);
-	free_cpumask_var(irq->mask);
-err_cpumask:
 	free_irq(irq->map.virq, &irq->nh);
 err_req_irq:
 #ifdef CONFIG_RFS_ACCEL
@@ -333,6 +330,7 @@ struct mlx5_irq *mlx5_irq_alloc(struct mlx5_irq_pool *pool, int i,
 	if (i && pci_msix_can_alloc_dyn(dev->pdev))
 		pci_msix_free_irq(dev->pdev, irq->map);
 err_alloc_irq:
+	free_cpumask_var(irq->mask);
 	kfree(irq);
 	return ERR_PTR(err);
 }
-- 
2.41.0


