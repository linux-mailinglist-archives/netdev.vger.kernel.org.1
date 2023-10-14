Return-Path: <netdev+bounces-41021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E7D7C95A5
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 19:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E887281E98
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 17:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB460266B5;
	Sat, 14 Oct 2023 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCViFiVL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF68B266B3
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 17:19:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84027C433BC;
	Sat, 14 Oct 2023 17:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697303972;
	bh=CHQPU2Srk7AV+wl+LhyFoBcoWO89EFA20+bcsEvAhUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bCViFiVLVBc1TGvPNL6IKxpEf4BoxEfBoevdoyIn7JexprXw4kL2rjes6MlCRwxin
	 6DNAY8OECO7ST370yOnkZILMK2lH4CpX/YiCQxFRpTRgXFyhhjCWnmGQC8sxQkf0if
	 RpgZbLimzX+8iFmoQqoyfrP7J5Br4p/A4oCR1Z+l/CDt82ElVWMIN86sUAti3XwI5P
	 HR+jmd3x5cXhPpxtDTstwmWAb910gHOmB+sT8vCR561G/2YG0gpH0elxvMd2ARGRX1
	 dG35+FDk4kavr3Yf3+FbbkMkB+92qb9OaPABmxt28EPQYOjjiq7t/zfbpVJYhJKPLP
	 wZWVhrFQwahwA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Yu Liao <liaoyu15@huawei.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [net-next V3 09/15] net/mlx5e: Use PTR_ERR_OR_ZERO() to simplify code
Date: Sat, 14 Oct 2023 10:19:02 -0700
Message-ID: <20231014171908.290428-10-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231014171908.290428-1-saeed@kernel.org>
References: <20231014171908.290428-1-saeed@kernel.org>
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
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
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


