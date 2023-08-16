Return-Path: <netdev+bounces-28241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E4977EB5C
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 23:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2373281C64
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 21:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D071DA46;
	Wed, 16 Aug 2023 21:01:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85371BEEB
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 21:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89289C433CB;
	Wed, 16 Aug 2023 21:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692219671;
	bh=e7LyN4JKv6az2HMVGnjcOdHGTMJmGvLrvWCpf+OBGFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c3iqybQrDSsPDOxf4I5XmSS+yZFZt+pDyzrNUwokc3BnMQVFeUC1irQp/W41H4tNJ
	 3teb0+Gx8/IpTcNyP0JJOjolQEmhufjQGHYt1B6QpEaTk78waTakGNP3eXnhD6ljgt
	 wONlZ2cf0oM4d/H7FVI0VzkYcsl98tzDIigplF+0/AgJ76LogV7B7UcCd5Z7ehDEsR
	 x2nmWmUvz3TvVC+aszzqriPCO/ud61FmjwXV9+sE4mv6QsKKeNgTdfHyt1Y4g6AFse
	 6n3DoKGpZY3whlyqEfUr6KdM2BMNOtCHoFMUxkNRsTWGOCeRb3krBsxnTeTCniMi9e
	 5nsJGgRwDQvHA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Li Zetao <lizetao1@huawei.com>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [net-next 15/15] net/mlx5: Devcom, only use devcom after NULL check in mlx5_devcom_send_event()
Date: Wed, 16 Aug 2023 14:00:49 -0700
Message-ID: <20230816210049.54733-16-saeed@kernel.org>
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

From: Li Zetao <lizetao1@huawei.com>

There is a warning reported by kernel test robot:

smatch warnings:
drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c:264
	mlx5_devcom_send_event() warn: variable dereferenced before
		IS_ERR check devcom (see line 259)

The reason for the warning is that the pointer is used before check, put
the assignment to comp after devcom check to silence the warning.

Fixes: 88d162b47981 ("net/mlx5: Devcom, Infrastructure changes")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202308041028.AkXYDwJ6-lkp@intel.com/
Signed-off-by: Li Zetao <lizetao1@huawei.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
index feb62d952643..00e67910e3ee 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
@@ -256,14 +256,15 @@ int mlx5_devcom_send_event(struct mlx5_devcom_comp_dev *devcom,
 			   int event, int rollback_event,
 			   void *event_data)
 {
-	struct mlx5_devcom_comp *comp = devcom->comp;
 	struct mlx5_devcom_comp_dev *pos;
+	struct mlx5_devcom_comp *comp;
 	int err = 0;
 	void *data;
 
 	if (IS_ERR_OR_NULL(devcom))
 		return -ENODEV;
 
+	comp = devcom->comp;
 	down_write(&comp->sem);
 	list_for_each_entry(pos, &comp->comp_dev_list_head, list) {
 		data = rcu_dereference_protected(pos->data, lockdep_is_held(&comp->sem));
-- 
2.41.0


