Return-Path: <netdev+bounces-15604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D4B748B21
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 19:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 589121C20BAF
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 17:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CE314A8D;
	Wed,  5 Jul 2023 17:58:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1B113AEB
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 17:58:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA69C433CB;
	Wed,  5 Jul 2023 17:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688579898;
	bh=KTx6wwnKkl+KtKezZ3xoDXW9pUeiyhMG8yTrxvjMBt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e8gIKHQg91avTABd3dYa232zpd5UYd4TzUzALtL0h/i3c3yVZUbDyBxkMy1M5LgHP
	 076yIyGh5CykAW6yFZr5SWaiGi+CTHX85rO3LWmAIZ1K3p4ICum6lpsE6brG+Qr+PH
	 7jO7RhQPxiMeUN2LFPE6bDHsIGz0wzl1T8FbH8yJg0U3+hXuyCxb80rNlQ1vTW2c9i
	 RpM46AWryprmO9s2vbtP24Zu8Ih0OrozDyV6hZYUuAC8lfH/rtMI2AinD5ef6Ugd0G
	 0fuIKVJdLyqEItRCWrgiZThUUn+DR6lld2JDUas/ZsqReb21lFXTyuvGtsS0F7wRnE
	 CrkuZiTGkV6Fw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Zhengchao Shao <shaozhengchao@huawei.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Simon Horman <simon.horman@corigine.com>
Subject: [net V2 3/9] net/mlx5e: fix memory leak in mlx5e_ptp_open
Date: Wed,  5 Jul 2023 10:57:51 -0700
Message-ID: <20230705175757.284614-4-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705175757.284614-1-saeed@kernel.org>
References: <20230705175757.284614-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhengchao Shao <shaozhengchao@huawei.com>

When kvzalloc_node or kvzalloc failed in mlx5e_ptp_open, the memory
pointed by "c" or "cparams" is not freed, which can lead to a memory
leak. Fix by freeing the array in the error path.

Fixes: 145e5637d941 ("net/mlx5e: Add TX PTP port object support")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
index 3cbebfba582b..b0b429a0321e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
@@ -729,8 +729,10 @@ int mlx5e_ptp_open(struct mlx5e_priv *priv, struct mlx5e_params *params,
 
 	c = kvzalloc_node(sizeof(*c), GFP_KERNEL, dev_to_node(mlx5_core_dma_dev(mdev)));
 	cparams = kvzalloc(sizeof(*cparams), GFP_KERNEL);
-	if (!c || !cparams)
-		return -ENOMEM;
+	if (!c || !cparams) {
+		err = -ENOMEM;
+		goto err_free;
+	}
 
 	c->priv     = priv;
 	c->mdev     = priv->mdev;
-- 
2.41.0


