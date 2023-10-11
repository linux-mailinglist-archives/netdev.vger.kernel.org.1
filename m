Return-Path: <netdev+bounces-39838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E27A87C49B9
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 08:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAA4B1C20FB9
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 06:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3AD111A9;
	Wed, 11 Oct 2023 06:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmTd+RUS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E444615EBD
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 06:12:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438ACC433C8;
	Wed, 11 Oct 2023 06:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697004761;
	bh=M+Z2nhIjy7/gp58Z5ErgM1xdgnFiBYeHcCIqdHolUyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tmTd+RUS6zRmNX5h4rn74bcogIeAQwBwimqDNBYORVPIR9z82ft2Pz6Q7FmSqBmjn
	 wnml97c4bKMAbsjzFVh6TEhNgaVdEoue58o/LCbXTKs2JrtrCxujZsZP2+fp+O0hH4
	 0TxRsMIK4e7fpBmxCqHz7jOKmsgHjkX0hF6mtMxVNoZym+RoRhz9v4eEtv6dNUr+FH
	 Wup1AUeoQ2xwkMtKd7aBJlVTGZ1SBNLJlwn5hjHarBFUrVewDVqZUlkp/dj/sNAPsD
	 KokQWF0zX24Qo0CRXYKhmRMns51mjw6ZA/94znyXyMBntF4oIkwrkAMiAHtKnhml3O
	 T170gxUrjoj4w==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Yu Liao <liaoyu15@huawei.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [net-next 09/15] net/mlx5e: Use PTR_ERR_OR_ZERO() to simplify code
Date: Tue, 10 Oct 2023 23:12:24 -0700
Message-ID: <20231011061230.11530-10-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011061230.11530-1-saeed@kernel.org>
References: <20231011061230.11530-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yu Liao <liaoyu15@huawei.com>

Use the standard error pointer macro to shorten the code and simplify.

Signed-off-by: Yu Liao <liaoyu15@huawei.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_fs.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
index 934b0d5ce1b3..777d311d44ef 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
@@ -1283,9 +1283,7 @@ static int mlx5e_create_inner_ttc_table(struct mlx5e_flow_steering *fs,
 	mlx5e_set_inner_ttc_params(fs, rx_res, &ttc_params);
 	fs->inner_ttc = mlx5_create_inner_ttc_table(fs->mdev,
 						    &ttc_params);
-	if (IS_ERR(fs->inner_ttc))
-		return PTR_ERR(fs->inner_ttc);
-	return 0;
+	return PTR_ERR_OR_ZERO(fs->inner_ttc);
 }
 
 int mlx5e_create_ttc_table(struct mlx5e_flow_steering *fs,
@@ -1295,9 +1293,7 @@ int mlx5e_create_ttc_table(struct mlx5e_flow_steering *fs,
 
 	mlx5e_set_ttc_params(fs, rx_res, &ttc_params, true);
 	fs->ttc = mlx5_create_ttc_table(fs->mdev, &ttc_params);
-	if (IS_ERR(fs->ttc))
-		return PTR_ERR(fs->ttc);
-	return 0;
+	return PTR_ERR_OR_ZERO(fs->ttc);
 }
 
 int mlx5e_create_flow_steering(struct mlx5e_flow_steering *fs,
-- 
2.41.0


