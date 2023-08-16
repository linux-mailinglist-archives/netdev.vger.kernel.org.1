Return-Path: <netdev+bounces-28231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D12AA77EB3E
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 23:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D2F21C20B1E
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 21:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D4E1ADC1;
	Wed, 16 Aug 2023 21:01:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D8D1AA75
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 21:01:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D012C433CD;
	Wed, 16 Aug 2023 21:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692219661;
	bh=HEZn8Z35s+8r/41VTXz4RtTH0IBRRWWcuAc/OQouMW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D4NjUJmYH16WDc/LllzFBh105R1a8vnQHV8qmOosFMXCYV3DAPaxSv71w2dCTCMeI
	 t+Yc77tGS7X9ks4XBPCvF99HqimNSuLdixuAGGOM8EzFLcGTgBJGExG0amhxPSITe5
	 ma7fWbFF2Irt+VseW5m8GBMYHi4R+MuV/b742qdSZy5kovIjuTzPtXWYB80YtLPU0I
	 4B6wtbgpnS0hNtbqquguLiqR59xlST89NbKTAKdjUanePqGTTDVZecNS2ujetwBnpa
	 E82d2rTSHDUOSC6zNRW9nB2hIK3xZOaN8bDHfwXnFFuKRcg/MixhYJq4xaGvK1PFor
	 lcgtOPYZtL8WA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Shay Drory <shayd@nvidia.com>
Subject: [net-next 05/15] net/mlx5: IRQ, consolidate irq and affinity mask allocation
Date: Wed, 16 Aug 2023 14:00:39 -0700
Message-ID: <20230816210049.54733-6-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816210049.54733-1-saeed@kernel.org>
References: <20230816210049.54733-1-saeed@kernel.org>
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


