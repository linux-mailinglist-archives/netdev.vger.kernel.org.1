Return-Path: <netdev+bounces-42861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 850417D06BB
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 05:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9024DB214B7
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 03:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1142D7476;
	Fri, 20 Oct 2023 03:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdg1Oqpu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49EF8F7A
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 03:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A599DC433C8;
	Fri, 20 Oct 2023 03:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697771083;
	bh=vRKC7vtsV6B0aO4TRfpqyXqy+QM3kIr5g29kMsJjuGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fdg1Oqpufr78KQ4gqGOj9F+oIoiSlVUmwBtBnknr1K61im4Nj++IvYe8jKToNN512
	 4boGMqVHtqqYnm/qvx8vXPjkMDan+9gsZANTOpx0OGuQhjYtxFKHRWCaqiiiQ4H54x
	 ypcCJ2pXAOG3VqoiyAHFLv6ycIzulMQcyI1F4DT8kz8CSPQkfg2WinxUHJyjqKc9KX
	 xbWP9yeMR7qGg9QDFYZYscGG3KrUn9vIU/KK48Y/15K0gNMQ4P8vMmhbv9IxTcOmxt
	 CcDWil5nq2+OMVwu19YAQcXkRlWDARy3ot9DBzrF41eS5XrRppAr7tSW4brI2Ks3Xv
	 HHG9+XrWw545w==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: [net-next 10/15] net/mlx5: Increase size of irq name buffer
Date: Thu, 19 Oct 2023 20:04:17 -0700
Message-ID: <20231020030422.67049-11-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020030422.67049-1-saeed@kernel.org>
References: <20231020030422.67049-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

Without increased buffer size, will trigger -Wformat-truncation with W=1
for the snprintf operation writing to the buffer.

    drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c: In function 'mlx5_irq_alloc':
    drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c:296:7: error: '@pci:' directive output may be truncated writing 5 bytes into a region of size between 1 and 32 [-Werror=format-truncation=]
      296 |    "%s@pci:%s", name, pci_name(dev->pdev));
          |       ^~~~~
    drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c:295:2: note: 'snprintf' output 6 or more bytes (assuming 37) into a destination of size 32
      295 |  snprintf(irq->name, MLX5_MAX_IRQ_NAME,
          |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      296 |    "%s@pci:%s", name, pci_name(dev->pdev));
          |    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6d4ab2e97dcfbcd748ae71761a9d8e5e41cc732c
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 6 +++---
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.h | 3 +++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index 653648216730..4dcf995cb1a2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -28,7 +28,7 @@
 struct mlx5_irq {
 	struct atomic_notifier_head nh;
 	cpumask_var_t mask;
-	char name[MLX5_MAX_IRQ_NAME];
+	char name[MLX5_MAX_IRQ_FORMATTED_NAME];
 	struct mlx5_irq_pool *pool;
 	int refcount;
 	struct msi_map map;
@@ -292,8 +292,8 @@ struct mlx5_irq *mlx5_irq_alloc(struct mlx5_irq_pool *pool, int i,
 	else
 		irq_sf_set_name(pool, name, i);
 	ATOMIC_INIT_NOTIFIER_HEAD(&irq->nh);
-	snprintf(irq->name, MLX5_MAX_IRQ_NAME,
-		 "%s@pci:%s", name, pci_name(dev->pdev));
+	snprintf(irq->name, MLX5_MAX_IRQ_FORMATTED_NAME,
+		 MLX5_IRQ_NAME_FORMAT_STR, name, pci_name(dev->pdev));
 	err = request_irq(irq->map.virq, irq_int_handler, 0, irq->name,
 			  &irq->nh);
 	if (err) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.h b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.h
index d3a77a0ab848..c4d377f8df30 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.h
@@ -7,6 +7,9 @@
 #include <linux/mlx5/driver.h>
 
 #define MLX5_MAX_IRQ_NAME (32)
+#define MLX5_IRQ_NAME_FORMAT_STR ("%s@pci:%s")
+#define MLX5_MAX_IRQ_FORMATTED_NAME \
+	(MLX5_MAX_IRQ_NAME + sizeof(MLX5_IRQ_NAME_FORMAT_STR))
 /* max irq_index is 2047, so four chars */
 #define MLX5_MAX_IRQ_IDX_CHARS (4)
 #define MLX5_EQ_REFS_PER_IRQ (2)
-- 
2.41.0


