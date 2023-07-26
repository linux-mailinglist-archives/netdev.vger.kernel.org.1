Return-Path: <netdev+bounces-21629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26380764131
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 23:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5108281E79
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 21:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E3318044;
	Wed, 26 Jul 2023 21:32:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4138F1BEE3
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 21:32:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047ABC433C8;
	Wed, 26 Jul 2023 21:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690407131;
	bh=JGGrB4NwV2vAix+LnjMOouDpWo1lR8GK79P8ZkAEGlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gkrhx066qZflPTR3O9va0VEtdN9lH7RnBnea+WrMsXi4jYHJeCngAmgNPg+xpfohd
	 l13UQHejR2Unoar8wNadpIJUX6TNqynCe8vYce5tNo5MATC7oN0+l4Y3/94SdAoqyc
	 C+7+d1zZr/uNSkk3A6oEL5ExdwnGqgaaw6L5gsAhnD3FpOlpGmiL6VLjzDrtlHI3TK
	 /iDvn4NOt4OB/KGWRdUnTOPlYGsAUYa6gffloUj6XSJaxIGkptewsjbXFY6CANlpfA
	 il86L33o/vg/D0CkK2PftmtJQKzwAmgx80QU1dNplS9zMh2GO5QFpmoDm0Po2p9Qzq
	 RufVHcBTf2//g==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Zhengchao Shao <shaozhengchao@huawei.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [net 02/15] net/mlx5: DR, fix memory leak in mlx5dr_cmd_create_reformat_ctx
Date: Wed, 26 Jul 2023 14:31:53 -0700
Message-ID: <20230726213206.47022-3-saeed@kernel.org>
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

when mlx5_cmd_exec failed in mlx5dr_cmd_create_reformat_ctx, the memory
pointed by 'in' is not released, which will cause memory leak. Move memory
release after mlx5_cmd_exec.

Fixes: 1d9186476e12 ("net/mlx5: DR, Add direct rule command utilities")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c
index 7491911ebcb5..8c2a34a0d6be 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c
@@ -564,11 +564,12 @@ int mlx5dr_cmd_create_reformat_ctx(struct mlx5_core_dev *mdev,
 
 	err = mlx5_cmd_exec(mdev, in, inlen, out, sizeof(out));
 	if (err)
-		return err;
+		goto err_free_in;
 
 	*reformat_id = MLX5_GET(alloc_packet_reformat_context_out, out, packet_reformat_id);
-	kvfree(in);
 
+err_free_in:
+	kvfree(in);
 	return err;
 }
 
-- 
2.41.0


