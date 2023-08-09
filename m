Return-Path: <netdev+bounces-25756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3434F775594
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 10:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 652C31C2116D
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 08:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D5817AD4;
	Wed,  9 Aug 2023 08:30:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303211DA50
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 08:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E34C43397;
	Wed,  9 Aug 2023 08:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691569826;
	bh=PONZ6KAAHDRUQddfGuS4AnIVYLmcjnGQRAKUNaKMi80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sgLPi2Y7XjmJG+eQZ3KRXQYcvMyEn6qiTFQTM/6n8fJmN/5VJthermeNZev01AgFI
	 LpMNIHathD4DwXeRvWTgdtUSNJdhiPMgK8M+dZszL5qKFrDmS7tmJFYDoVv3BJU3ep
	 sqEUMm5ZSNGrrVNFX+e0W3UCr6HaDJrTpZrpGVvhHMKtPlbHAV2AU653gfYnmNFxzl
	 uuvbvyS0eQ12wPmHtBqo9ocrZBn5v23SDClxvQ9PsZa70jCuh4NXjYFbY/q5NhIVNz
	 TPOdDUe3jMxzUVBWjDLPR1Dx3oeGCDxqeW8bKY+0Cvz3VTWH2cHvwe9NRgC9ShBkdU
	 +dMx+UUY65f5g==
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


