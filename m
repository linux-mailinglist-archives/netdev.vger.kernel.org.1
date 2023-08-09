Return-Path: <netdev+bounces-25757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B2D775595
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 10:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 134C7281ADF
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 08:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF05B17FF2;
	Wed,  9 Aug 2023 08:30:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741E117FE2
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 08:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44DCC43142;
	Wed,  9 Aug 2023 08:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691569827;
	bh=PONZ6KAAHDRUQddfGuS4AnIVYLmcjnGQRAKUNaKMi80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hDBdhHxgQI+wqGZL17bODfUzU+dMhEgc2Z5km90fE5DAN4rZzWcJ1nAcV/2BCIAEx
	 J8bUuqGSctYQ3XECXYlXWQXem1jbJvbXK+I0yJ4zHgML68IX4Xw+j9O3Q1hgewXwyv
	 +I5MAkwfdlOqrI7NQQZAdTe3sE5bVzxgb01xaSKuXV/CB7KdkItc0Sa7KoKTar2KuF
	 OmDR4kIS7wylOur1Y/T7b8vjSZUps78OzuMu+Wcb52VZlIXg4LwobTl4am7K5b0fnI
	 IiWtMCZxmcqB79n4zBJkZlkUYNmfYy9EBLU5sa9IQ5j3RgLmxAtimOCMR1CXMniRfZ
	 njmYTC3jKtrpg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	linux-rdma@vger.kernel.org,
	Maor Gottlieb <maorg@nvidia.com>,
	Mark Zhang <markzhang@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Raed Salem <raeds@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH mlx5-next v1 10/14] IB/core: Reorder GID delete code for RoCE
Date: Wed,  9 Aug 2023 11:29:22 +0300
Message-ID: <63c4d475bfde82ec6d81e20e612f5281da02ce07.1691569414.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691569414.git.leon@kernel.org>
References: <cover.1691569414.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrisious Haddad <phaddad@nvidia.com>

Reorder GID delete code so that the driver del_gid operation is executed
before nullifying the gid attribute ndev parameter, this allows drivers
to access the ndev during their gid delete operation, which makes more
sense since they had access to it during the gid addition operation.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cache.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 2e91d8879326..73f913cbd146 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -400,6 +400,9 @@ static void del_gid(struct ib_device *ib_dev, u32 port,
 		table->data_vec[ix] = NULL;
 	write_unlock_irq(&table->rwlock);
 
+	if (rdma_cap_roce_gid_table(ib_dev, port))
+		ib_dev->ops.del_gid(&entry->attr, &entry->context);
+
 	ndev_storage = entry->ndev_storage;
 	if (ndev_storage) {
 		entry->ndev_storage = NULL;
@@ -407,9 +410,6 @@ static void del_gid(struct ib_device *ib_dev, u32 port,
 		call_rcu(&ndev_storage->rcu_head, put_gid_ndev);
 	}
 
-	if (rdma_cap_roce_gid_table(ib_dev, port))
-		ib_dev->ops.del_gid(&entry->attr, &entry->context);
-
 	put_gid_entry_locked(entry);
 }
 
-- 
2.41.0


