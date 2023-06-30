Return-Path: <netdev+bounces-14865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BECAF744210
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 20:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5141C20C36
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 18:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9E117AC8;
	Fri, 30 Jun 2023 18:15:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7011117ABB
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 18:15:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A91C433D9;
	Fri, 30 Jun 2023 18:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688148955;
	bh=J5azMA4gAKCKdBOSKSIqmmi2MSMIkVnyQS78BzXQSfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j/sxfmiNLOmWGKMFxfn5evZzz2nEDjKIlDDoXW6sjE8g2tr0vxVQySz09VZKELWct
	 8ClQ+iny7tZ33MjWIsFxMY2Z0ib3FSWDNGaP4NdKc4fYdbLB3dBpJWI2JlH4sK5JUT
	 ibcQaPuXwU/+UYWx96Gl+nBel8QTxBAQWepy+e0RLc06Vns3Vds4mfVi5pGcn0RD4T
	 MFPyAd2stmVjbkpsQjo8mkWi2h9t6c+nrnvJGatZk00/n5uajajacSmcD7BMGn3y67
	 BjZE0h7mHJDP7q9Fvr8Y5rpkVOua4EG+icjRDtpgcx3WbziBFp1YNmT59iUQOAXHCs
	 X5fc0lVFmnhrA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>,
	Shay Drory <shayd@nvidia.com>
Subject: [net 8/9] net/mlx5: Query hca_cap_2 only when supported
Date: Fri, 30 Jun 2023 11:15:43 -0700
Message-ID: <20230630181544.82958-9-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630181544.82958-1-saeed@kernel.org>
References: <20230630181544.82958-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maher Sanalla <msanalla@nvidia.com>

On vport enable, where fw's hca caps are queried, the driver queries
hca_caps_2 without checking if fw truly supports them, causing a false
failure of vfs vport load and blocking SRIOV enablement on old devices
such as CX4 where hca_caps_2 support is missing.

Thus, add a check for the said caps support before accessing them.

Fixes: e5b9642a33be ("net/mlx5: E-Switch, Implement devlink port function cmds to control migratable")
Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index faec7d7a4400..243c455f1029 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -807,6 +807,9 @@ static int mlx5_esw_vport_caps_get(struct mlx5_eswitch *esw, struct mlx5_vport *
 	hca_caps = MLX5_ADDR_OF(query_hca_cap_out, query_ctx, capability);
 	vport->info.roce_enabled = MLX5_GET(cmd_hca_cap, hca_caps, roce);
 
+	if (!MLX5_CAP_GEN_MAX(esw->dev, hca_cap_2))
+		goto out_free;
+
 	memset(query_ctx, 0, query_out_sz);
 	err = mlx5_vport_get_other_func_cap(esw->dev, vport->vport, query_ctx,
 					    MLX5_CAP_GENERAL_2);
-- 
2.41.0


