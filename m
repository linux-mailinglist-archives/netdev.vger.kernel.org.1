Return-Path: <netdev+bounces-28210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6B077EAEA
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 22:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA91F281C52
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 20:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC4E182C8;
	Wed, 16 Aug 2023 20:41:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B870C18024
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 20:41:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2905DC433CD;
	Wed, 16 Aug 2023 20:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692218476;
	bh=CccmoTtUD10ENFPBMJ1x9E5LBA9u+4gfLf6JOonuNrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mC96V2yInTNL9QSitMd3U2Zs5jCPIWwBU2/5qbNGyT3d4hiRKdTZVkF0poYy+78Vn
	 /Iw32Ujp3ygB3qNTkA/AtEf0V+GgsipLQH+6h4VG7bsDQpvlgtBctmwJpppU20EagQ
	 jKj86/n8P/xAetra1oCcWpYwrXf0ltj3Ol0mwrVyj4zw7lmcN5y2VvJhI9cAV+HM/U
	 yUWPXVVMaJfjFjDEPlx+oDlG/jk7dAylKFtjwLQnCfVfou7S30WNkKtTB07SsEjHXC
	 9phedKsqblSE4PZaTMCDmUcJEOh8OtVk8L1X7AoeCUj3z93m+xN4MsNb42401nMUig
	 q0tyMz2pNnfVg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Shay Drory <shayd@nvidia.com>,
	Roi Dayan <roid@nvidia.com>
Subject: [net 2/2] net/mlx5: Fix mlx5_cmd_update_root_ft() error flow
Date: Wed, 16 Aug 2023 13:41:08 -0700
Message-ID: <20230816204108.53819-3-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816204108.53819-1-saeed@kernel.org>
References: <20230816204108.53819-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shay Drory <shayd@nvidia.com>

The cited patch change mlx5_cmd_update_root_ft() to work with multiple
peer devices. However, it didn't align the error flow as well.
Hence, Fix the error code to work with multiple peer devices.

Fixes: 222dd185833e ("{net/RDMA}/mlx5: introduce lag_for_each_peer")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Roi Dayan <roid@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
index aab7059bf6e9..244cfd470903 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
@@ -245,12 +245,20 @@ static int mlx5_cmd_update_root_ft(struct mlx5_flow_root_namespace *ns,
 	    mlx5_lag_is_shared_fdb(dev) &&
 	    mlx5_lag_is_master(dev)) {
 		struct mlx5_core_dev *peer_dev;
-		int i;
+		int i, j;
 
 		mlx5_lag_for_each_peer_mdev(dev, peer_dev, i) {
 			err = mlx5_cmd_set_slave_root_fdb(dev, peer_dev, !disconnect,
 							  (!disconnect) ? ft->id : 0);
 			if (err && !disconnect) {
+				mlx5_lag_for_each_peer_mdev(dev, peer_dev, j) {
+					if (j < i)
+						mlx5_cmd_set_slave_root_fdb(dev, peer_dev, 1,
+									    ns->root_ft->id);
+					else
+						break;
+				}
+
 				MLX5_SET(set_flow_table_root_in, in, op_mod, 0);
 				MLX5_SET(set_flow_table_root_in, in, table_id,
 					 ns->root_ft->id);
-- 
2.41.0


