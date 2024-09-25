Return-Path: <netdev+bounces-129845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1978986783
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 22:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61B952845F4
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 20:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB281145324;
	Wed, 25 Sep 2024 20:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4ElnPfv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B731A14884C
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 20:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727295619; cv=none; b=O+evS5KoaRDgNZqQGTn2JbtIYM9uMRnwexB7Encz9NuNJsnzLj1AXXzPYhjEt2JKj3ANF+OFAABS8EFUr3j6OwhGJO9k/8YvnLnBlXsh9SxI0bYMtAaaJWUzo8MyASnvz8Oj7R5ELu17QQzH6nA/zPJ7YVtTo5nUd33Y/HF/EYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727295619; c=relaxed/simple;
	bh=6vIrgKwlwWw0JozlQZEvOhq5Fo8aBIbsGcWrnYZk45s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vExqiDzGLmj9mVdCGbwbBCyxuFN6X9LLI/nDEZzZ4rIScIU30h22WpTD4McCFhFgJBkBrSTH/xFNnH27dzMcR+m/IXIRVeLW0frtt+Fkf/VfeI1BTSKzUADF5I7fU4dTPfmp/mHOX/w6REJpEacVu3wQ5s1gemhL6nIshnKPjNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4ElnPfv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F07EC4CEC9;
	Wed, 25 Sep 2024 20:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727295619;
	bh=6vIrgKwlwWw0JozlQZEvOhq5Fo8aBIbsGcWrnYZk45s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o4ElnPfvcOzNdnZjkgmigO+vPJyfr1eLtSDn/S/0Hf1x57NYuyL/M9p9F5O/5L++v
	 3RrkLt81+QlK3VYn0RRx7dt3kDCqnHJsWDdQniMEi6h1eAQW5eNSr42QHXTlVKIUx8
	 KyoNbzBczistzNYtzz8HT5pj/QwAwsfJ+AAThX9lP4BOcrOQo4iiLAO7clKHSajJYo
	 nrHM8yX1qoPmCX3mGj8E7oYu+h2F11GLkhUoTTSrf63rtEgOp+izdJF0+yvwPCEQUX
	 STwSUkZE8xslivFolzfNDZxb8yPiwK68+BF7U2pEVHFGVkx13Cd0DfhE3aFQgOsccM
	 /S2xdGL6vWZOg==
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
	Gerd Bayer <gbayer@linux.ibm.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Maxim Mikityanskiy <maxtram95@gmail.com>
Subject: [net 1/8] net/mlx5: Fix error path in multi-packet WQE transmit
Date: Wed, 25 Sep 2024 13:20:06 -0700
Message-ID: <20240925202013.45374-2-saeed@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240925202013.45374-1-saeed@kernel.org>
References: <20240925202013.45374-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gerd Bayer <gbayer@linux.ibm.com>

Remove the erroneous unmap in case no DMA mapping was established

The multi-packet WQE transmit code attempts to obtain a DMA mapping for
the skb. This could fail, e.g. under memory pressure, when the IOMMU
driver just can't allocate more memory for page tables. While the code
tries to handle this in the path below the err_unmap label it erroneously
unmaps one entry from the sq's FIFO list of active mappings. Since the
current map attempt failed this unmap is removing some random DMA mapping
that might still be required. If the PCI function now presents that IOVA,
the IOMMU may assumes a rogue DMA access and e.g. on s390 puts the PCI
function in error state.

The erroneous behavior was seen in a stress-test environment that created
memory pressure.

Fixes: 5af75c747e2a ("net/mlx5e: Enhanced TX MPWQE for SKBs")
Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Acked-by: Maxim Mikityanskiy <maxtram95@gmail.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index b09e9abd39f3..f8c7912abe0e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -642,7 +642,6 @@ mlx5e_sq_xmit_mpwqe(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 	return;
 
 err_unmap:
-	mlx5e_dma_unmap_wqe_err(sq, 1);
 	sq->stats->dropped++;
 	dev_kfree_skb_any(skb);
 	mlx5e_tx_flush(sq);
-- 
2.46.1


