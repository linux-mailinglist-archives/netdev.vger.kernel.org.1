Return-Path: <netdev+bounces-82118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D473A88C58F
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 15:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 551791F3FB9A
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 14:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9CD13C69D;
	Tue, 26 Mar 2024 14:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCN39AM2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EF413C698
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 14:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464415; cv=none; b=QA2rTaQDW8f8Sdq0q+sBt0VTE9fHhmhCQSC+50fQpPkY6ulc54keCWbRnEYuaTx5UsAELRxL20ZB+1w3CqANNR1LBAfSfQIhZKDvG4WKKls9AS95UU3UyKtmff5RdZQIFsajTQjo0vPg3CXP/+nf16xuQtH0b7gYBw0eMXg5CzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464415; c=relaxed/simple;
	bh=fY4th8eIAv/dBU8j4SI3m7hueZqAPUNG3ZqRyIbZKcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oYI1rAl93SokuK0wBBQDvbIINQetADLGVX4U+DGfJDMqXwqEoLBhIIUrHo/QgkQIWb4XjrR33+XAgy/4QBSomZZc74CzHIVcvqM33+7p/CFrpXlMyUWB1Qq1Trnq0xKYLZMladElgl2CXB2Sgh4+VOaf3z51OV77/7S054ANUy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCN39AM2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA4DC43394;
	Tue, 26 Mar 2024 14:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711464414;
	bh=fY4th8eIAv/dBU8j4SI3m7hueZqAPUNG3ZqRyIbZKcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sCN39AM2dGIyI1pkpZ2jZZcovtOSo/vyYygXNHytbGahbsGciEQd/ROYuDRpQ7CB4
	 ygcgvS0nymuMvp4wJg3xXi8NxHJtWV/uULRRlrdPvuemHoqImUtFTJgAHfyee3B7RP
	 GPXgudkwpK+xn19QEoExbMVxGIKDlOUNkI9nGPrGlaOFt7CEJIIbQSVvs4R5SpWom9
	 AbUVQWwEzQ6eIgdktjoRt01BBvwTiAV01UrfgsrdVIMamcT5PBeCPGXG8kihRZ7Zeu
	 47eBKomygeK9E+CvfAyckBImuQGevi8r7pAcpBioDGCTbaF88rLmO/ryyrecwY20M3
	 biWJOlzDWWbeg==
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
	Shay Drory <shayd@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>
Subject: [net 01/10] net/mlx5: E-switch, store eswitch pointer before registering devlink_param
Date: Tue, 26 Mar 2024 07:46:37 -0700
Message-ID: <20240326144646.2078893-2-saeed@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326144646.2078893-1-saeed@kernel.org>
References: <20240326144646.2078893-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shay Drory <shayd@nvidia.com>

Next patch will move devlink register to be first. Therefore, whenever
mlx5 will register a param, the user will be notified.
In order to notify the user, devlink is using the get() callback of
the param. Hence, resources that are being used by the get() callback
must be set before the devlink param is registered.

Therefore, store eswitch pointer inside mdev before registering the
param.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c        | 9 +++------
 .../net/ethernet/mellanox/mlx5/core/eswitch_offloads.c   | 4 ++++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 3047d7015c52..1789800faaeb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1868,6 +1868,7 @@ int mlx5_eswitch_init(struct mlx5_core_dev *dev)
 	if (err)
 		goto abort;
 
+	dev->priv.eswitch = esw;
 	err = esw_offloads_init(esw);
 	if (err)
 		goto reps_err;
@@ -1892,11 +1893,6 @@ int mlx5_eswitch_init(struct mlx5_core_dev *dev)
 		esw->offloads.encap = DEVLINK_ESWITCH_ENCAP_MODE_BASIC;
 	else
 		esw->offloads.encap = DEVLINK_ESWITCH_ENCAP_MODE_NONE;
-	if (MLX5_ESWITCH_MANAGER(dev) &&
-	    mlx5_esw_vport_match_metadata_supported(esw))
-		esw->flags |= MLX5_ESWITCH_VPORT_MATCH_METADATA;
-
-	dev->priv.eswitch = esw;
 	BLOCKING_INIT_NOTIFIER_HEAD(&esw->n_head);
 
 	esw_info(dev,
@@ -1908,6 +1904,7 @@ int mlx5_eswitch_init(struct mlx5_core_dev *dev)
 
 reps_err:
 	mlx5_esw_vports_cleanup(esw);
+	dev->priv.eswitch = NULL;
 abort:
 	if (esw->work_queue)
 		destroy_workqueue(esw->work_queue);
@@ -1926,7 +1923,6 @@ void mlx5_eswitch_cleanup(struct mlx5_eswitch *esw)
 
 	esw_info(esw->dev, "cleanup\n");
 
-	esw->dev->priv.eswitch = NULL;
 	destroy_workqueue(esw->work_queue);
 	WARN_ON(refcount_read(&esw->qos.refcnt));
 	mutex_destroy(&esw->state_lock);
@@ -1937,6 +1933,7 @@ void mlx5_eswitch_cleanup(struct mlx5_eswitch *esw)
 	mutex_destroy(&esw->offloads.encap_tbl_lock);
 	mutex_destroy(&esw->offloads.decap_tbl_lock);
 	esw_offloads_cleanup(esw);
+	esw->dev->priv.eswitch = NULL;
 	mlx5_esw_vports_cleanup(esw);
 	debugfs_remove_recursive(esw->debugfs_root);
 	devl_params_unregister(priv_to_devlink(esw->dev), mlx5_eswitch_params,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index baaae628b0a0..e3cce110e52f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2476,6 +2476,10 @@ int esw_offloads_init(struct mlx5_eswitch *esw)
 	if (err)
 		return err;
 
+	if (MLX5_ESWITCH_MANAGER(esw->dev) &&
+	    mlx5_esw_vport_match_metadata_supported(esw))
+		esw->flags |= MLX5_ESWITCH_VPORT_MATCH_METADATA;
+
 	err = devl_params_register(priv_to_devlink(esw->dev),
 				   esw_devlink_params,
 				   ARRAY_SIZE(esw_devlink_params));
-- 
2.44.0


