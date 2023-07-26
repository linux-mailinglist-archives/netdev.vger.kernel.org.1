Return-Path: <netdev+bounces-21630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B331C764132
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 23:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E44191C21457
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 21:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CA81988F;
	Wed, 26 Jul 2023 21:32:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124DB18045
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 21:32:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D9AC433C7;
	Wed, 26 Jul 2023 21:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690407131;
	bh=Jipv8kNRgo3yBMh8Ls+LiUo4PYRyWDjEoYvF5+uS7jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FMB1fqW0Te9oQ77cVcyKKu8XBbPV2Bl1POblYKKvMRhK+W7VcuR8OWo2GYVHSeXG+
	 PUOa2Mung7u+tFdoxDPqXjVeYUgPMpv+Xg4DUsKvGFZuHzrzqsyJqsJ3Dz00O+MLrv
	 2OZ4CgHj3jwBTKN8KJBlkiUubwge5XBNL/j93+CNRxvKVoSI0a1fcOvzUSrx11bSQM
	 OF1kXPgghRpU6UalZHmvraxgfRok17hRxbDTI4uFj07MdDrFlxciujsX4r0jIlVCs8
	 JapelQ3Lhuu27jux4SyCMEJTls8My0DsV8Bxx6eGfbSpiu6XjEtxsEpSjshmof3te8
	 Tcb3UeuF3BC9w==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Zhengchao Shao <shaozhengchao@huawei.com>,
	Simon Horman <simon.horman@corigine.com>
Subject: [net 03/15] net/mlx5: fix potential memory leak in mlx5e_init_rep_rx
Date: Wed, 26 Jul 2023 14:31:54 -0700
Message-ID: <20230726213206.47022-4-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726213206.47022-1-saeed@kernel.org>
References: <20230726213206.47022-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhengchao Shao <shaozhengchao@huawei.com>

The memory pointed to by the priv->rx_res pointer is not freed in the error
path of mlx5e_init_rep_rx, which can lead to a memory leak. Fix by freeing
the memory in the error path, thereby making the error path identical to
mlx5e_cleanup_rep_rx().

Fixes: af8bbf730068 ("net/mlx5e: Convert mlx5e_flow_steering member of mlx5e_priv to pointer")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 152b62138450..0b265a3f9b76 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -1012,7 +1012,7 @@ static int mlx5e_init_rep_rx(struct mlx5e_priv *priv)
 	err = mlx5e_open_drop_rq(priv, &priv->drop_rq);
 	if (err) {
 		mlx5_core_err(mdev, "open drop rq failed, %d\n", err);
-		return err;
+		goto err_rx_res_free;
 	}
 
 	err = mlx5e_rx_res_init(priv->rx_res, priv->mdev, 0,
@@ -1046,6 +1046,7 @@ static int mlx5e_init_rep_rx(struct mlx5e_priv *priv)
 	mlx5e_rx_res_destroy(priv->rx_res);
 err_close_drop_rq:
 	mlx5e_close_drop_rq(&priv->drop_rq);
+err_rx_res_free:
 	mlx5e_rx_res_free(priv->rx_res);
 	priv->rx_res = NULL;
 err_free_fs:
-- 
2.41.0


