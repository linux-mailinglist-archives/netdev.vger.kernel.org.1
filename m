Return-Path: <netdev+bounces-30553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE5E787FE9
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 08:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97E5E28172D
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 06:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2863823D5;
	Fri, 25 Aug 2023 06:29:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAFA1C13
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 06:29:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F89C433D9;
	Fri, 25 Aug 2023 06:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692944997;
	bh=RcLPeWfsxWIQHYfNQXHElUtwwOap1AVBrBMjci4wknQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bLJyIGWDjB5cN+/xg+5E+AGjf+pwHG9fjGcH39MT4aIjLA2lFD6JV7e+6kBwi0+te
	 HKYxk2LFftZMVHQjRQWuVFqHQH90pZPEO/2VVHXsHy2gLgFKnYJ9u9OeoxUFxr0MhA
	 tFU0jfTIY7A3DuUwe68Njn1sfo3OG9++BTVs30OIXLBv9Ro9qo/khiU3rsDf1+q49y
	 8cHrofDkUf4f85Zl+s9OJXZVyXiy13lK1WfE8ioQbXSMjcyNTeWkbSSx0rGTKrES42
	 hHAgDZZ/Y6vEuYjKJJVSroh/7QDT5q9tbFrKtPoo83ysjD38bhNlq6zNRSiFeC37VV
	 PWzLWNCXSP68w==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH net-next V4 3/8] net/mlx5: Drop extra layer of locks in IPsec
Date: Thu, 24 Aug 2023 23:28:31 -0700
Message-ID: <20230825062836.103744-4-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825062836.103744-1-saeed@kernel.org>
References: <20230825062836.103744-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

There is no need in holding devlink lock as it gives nothing
compared to already used write mode_lock.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/eswitch_offloads.c      | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 67eab99f95b1..28c4b9724e38 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3903,38 +3903,28 @@ int mlx5_devlink_eswitch_inline_mode_get(struct devlink *devlink, u8 *mode)
 
 bool mlx5_eswitch_block_encap(struct mlx5_core_dev *dev)
 {
-	struct devlink *devlink = priv_to_devlink(dev);
-	struct mlx5_eswitch *esw;
+	struct mlx5_eswitch *esw = dev->priv.eswitch;
 
-	devl_lock(devlink);
-	esw = mlx5_devlink_eswitch_get(devlink);
-	if (IS_ERR(esw)) {
-		devl_unlock(devlink);
-		/* Failure means no eswitch => not possible to change encap */
+	if (!mlx5_esw_allowed(esw))
 		return true;
-	}
 
 	down_write(&esw->mode_lock);
 	if (esw->mode != MLX5_ESWITCH_LEGACY &&
 	    esw->offloads.encap != DEVLINK_ESWITCH_ENCAP_MODE_NONE) {
 		up_write(&esw->mode_lock);
-		devl_unlock(devlink);
 		return false;
 	}
 
 	esw->offloads.num_block_encap++;
 	up_write(&esw->mode_lock);
-	devl_unlock(devlink);
 	return true;
 }
 
 void mlx5_eswitch_unblock_encap(struct mlx5_core_dev *dev)
 {
-	struct devlink *devlink = priv_to_devlink(dev);
-	struct mlx5_eswitch *esw;
+	struct mlx5_eswitch *esw = dev->priv.eswitch;
 
-	esw = mlx5_devlink_eswitch_get(devlink);
-	if (IS_ERR(esw))
+	if (!mlx5_esw_allowed(esw))
 		return;
 
 	down_write(&esw->mode_lock);
-- 
2.41.0


