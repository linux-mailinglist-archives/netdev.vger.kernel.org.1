Return-Path: <netdev+bounces-82120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC9888C591
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 15:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EA6B1C627AF
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 14:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6476713C82C;
	Tue, 26 Mar 2024 14:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4o74JKi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A05613C808
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 14:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464418; cv=none; b=t7Bo4/P9nf0BYTvlNfzdRH3qbwAkt5gmFxAiBYfxOgqvovHcfbeMYnloVbQp88SIsQOKbhCLMU+B3GBnuuX4dNCFTzySiOBYw/UwklToqCGZ26QrgzLaIj2Flgec3fevhqkH6Pb/neA4w2AW+RmJcS9dVEtFd47GN1BACygNpDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464418; c=relaxed/simple;
	bh=eHfJye8/AU2XdbG2KjGZM/VlHjmoaSA4lCel2jPGFdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFETfVpWAwA3DBuJ8bTlu7tLyHadRo7e0dtSwnBYky4mNjdiqf7k6GR0DMncOde4xCH6dAdTpJMLSUNmXY7hZdsQ+QThsDuibHTQHCiyVa/s27Ek4PytsaNHO6RKfG4+J13Pyzqm7Ai9aNuKk5gHp2lzR2kP8lGle/qcL4MK/Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4o74JKi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EFFC433B2;
	Tue, 26 Mar 2024 14:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711464417;
	bh=eHfJye8/AU2XdbG2KjGZM/VlHjmoaSA4lCel2jPGFdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j4o74JKikJxd54nYmDQo3rvOhjCXbY6vtVyhZjf5nWL9j98Tbp3UgCqbMzbmT/muj
	 dZ+nLSeb408xC5A1+IE+ge6rjyxXzq/RvjkwZ7XN8jE95f635M943ZQUsPciC9gDJq
	 D5zHQcFUQjJ4wdPm1/W8fNQHoNQetAqDCmw4uErIPkHqyREhvcnMJmAq52nnppuPyJ
	 8tRfVN4vL/GCySt/Ksdki4FsWHoJirLh1VbEvHHPnAYt50C8tYfC4wvu9C6BFi2C+1
	 ixJRSG4pisTBhRp4eiPUf0vOmCplbO6pfUFSjrfI/MQIZzRKhx8iPcLfcYgwl7y3eG
	 VtxbQP4nMpxqA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Michael Liang <mliang@purestorage.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Shay Drory <shayd@nvidia.com>
Subject: [net 03/10] net/mlx5: offset comp irq index in name by one
Date: Tue, 26 Mar 2024 07:46:39 -0700
Message-ID: <20240326144646.2078893-4-saeed@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326144646.2078893-1-saeed@kernel.org>
References: <20240326144646.2078893-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Liang <mliang@purestorage.com>

The mlx5 comp irq name scheme is changed a little bit between
commit 3663ad34bc70 ("net/mlx5: Shift control IRQ to the last index")
and commit 3354822cde5a ("net/mlx5: Use dynamic msix vectors allocation").
The index in the comp irq name used to start from 0 but now it starts
from 1. There is nothing critical here, but it's harmless to change
back to the old behavior, a.k.a starting from 0.

Fixes: 3354822cde5a ("net/mlx5: Use dynamic msix vectors allocation")
Reviewed-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Yuanyuan Zhong <yzhong@purestorage.com>
Signed-off-by: Michael Liang <mliang@purestorage.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index 4dcf995cb1a2..6bac8ad70ba6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -19,6 +19,7 @@
 #define MLX5_IRQ_CTRL_SF_MAX 8
 /* min num of vectors for SFs to be enabled */
 #define MLX5_IRQ_VEC_COMP_BASE_SF 2
+#define MLX5_IRQ_VEC_COMP_BASE 1
 
 #define MLX5_EQ_SHARE_IRQ_MAX_COMP (8)
 #define MLX5_EQ_SHARE_IRQ_MAX_CTRL (UINT_MAX)
@@ -246,6 +247,7 @@ static void irq_set_name(struct mlx5_irq_pool *pool, char *name, int vecidx)
 		return;
 	}
 
+	vecidx -= MLX5_IRQ_VEC_COMP_BASE;
 	snprintf(name, MLX5_MAX_IRQ_NAME, "mlx5_comp%d", vecidx);
 }
 
@@ -585,7 +587,7 @@ struct mlx5_irq *mlx5_irq_request_vector(struct mlx5_core_dev *dev, u16 cpu,
 	struct mlx5_irq_table *table = mlx5_irq_table_get(dev);
 	struct mlx5_irq_pool *pool = table->pcif_pool;
 	struct irq_affinity_desc af_desc;
-	int offset = 1;
+	int offset = MLX5_IRQ_VEC_COMP_BASE;
 
 	if (!pool->xa_num_irqs.max)
 		offset = 0;
-- 
2.44.0


