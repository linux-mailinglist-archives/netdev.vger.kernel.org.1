Return-Path: <netdev+bounces-76789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A67C486EF06
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 08:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADBDFB24D2E
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 07:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB63125BF;
	Sat,  2 Mar 2024 07:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaP1Cc3Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B00F12B80
	for <netdev@vger.kernel.org>; Sat,  2 Mar 2024 07:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709363012; cv=none; b=LaF/0k3CXh8MJofK78r9KJKkmQVg6DiJo6Dk71R3PJLiPBHtCw6t6THzMDL97XMVh5mDGM97LQ2ZhTwE4qgmp09uYRUoXCRdyXohhwOF4MryqKrSL/DCoSEwatfGrWSJ6M4tTay7kCV4upuTRSeyMcoJgWGxQn//o/e9srJAhzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709363012; c=relaxed/simple;
	bh=GQUbpXrbe8eCWaF4vdRQ65DJzEnH0Il8lWULM8R5/S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wj3r449vNKaj9NcGtusTqdMXWbNQmEZDip0lXZXkED42EXJLW4+0qaTnH2ziYu75rmSaffas3a3O5efUS/fcLFCyesqf/eEGu2b/9yRXho/MaSynMmd3+4LVVecBaiBBw1kynN/0pd/Q6B8m7rHEWqhoKmBpk587iN3FiND8fxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaP1Cc3Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93135C43399;
	Sat,  2 Mar 2024 07:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709363011;
	bh=GQUbpXrbe8eCWaF4vdRQ65DJzEnH0Il8lWULM8R5/S4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eaP1Cc3Z3nDmvbREePzRRUFPQ/DnkEDzbIXshYl9mVN9zLW7f2opOjtcOzEla0hxh
	 20bWy1OCyoa4+Ek3IOmp5K5uz3JtW8uq0wpeayoYK8CjmQRfpMTzHfCtJUtkh+t8xg
	 +nZVhkNp7Orootkeqr/qbw/CUOZs9DUGswhwUlQ3WZeT/U3tEU9GMf+PCx5Mqsh2up
	 HcV4FvkYfaXC9Dr8et0CpzmPyilDT3k46BK+KVPnS2BrInch4mJB3l04jBL4oeJIFB
	 AxRw8yFF7AhGl3fmQfTyM+I2f/siwIJs1nVYzGF5nMb78ird5oWHcvMtJ8hd5tEfx5
	 pFRlfIZRZJzAw==
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
	Jianbo Liu <jianbol@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [net V2 3/9] net/mlx5: E-switch, Change flow rule destination checking
Date: Fri,  1 Mar 2024 23:03:12 -0800
Message-ID: <20240302070318.62997-4-saeed@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240302070318.62997-1-saeed@kernel.org>
References: <20240302070318.62997-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianbo Liu <jianbol@nvidia.com>

The checking in the cited commit is not accurate. In the common case,
VF destination is internal, and uplink destination is external.
However, uplink destination with packet reformat is considered as
internal because firmware uses LB+hairpin to support it. Update the
checking so header rewrite rules with both internal and external
destinations are not allowed.

Fixes: e0e22d59b47a ("net/mlx5: E-switch, Add checking for flow rule destinations")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/eswitch_offloads.c     | 23 +++++++++++--------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 14b3bd3c5e2f..baaae628b0a0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -535,21 +535,26 @@ esw_src_port_rewrite_supported(struct mlx5_eswitch *esw)
 }
 
 static bool
-esw_dests_to_vf_pf_vports(struct mlx5_flow_destination *dests, int max_dest)
+esw_dests_to_int_external(struct mlx5_flow_destination *dests, int max_dest)
 {
-	bool vf_dest = false, pf_dest = false;
+	bool internal_dest = false, external_dest = false;
 	int i;
 
 	for (i = 0; i < max_dest; i++) {
-		if (dests[i].type != MLX5_FLOW_DESTINATION_TYPE_VPORT)
+		if (dests[i].type != MLX5_FLOW_DESTINATION_TYPE_VPORT &&
+		    dests[i].type != MLX5_FLOW_DESTINATION_TYPE_UPLINK)
 			continue;
 
-		if (dests[i].vport.num == MLX5_VPORT_UPLINK)
-			pf_dest = true;
+		/* Uplink dest is external, but considered as internal
+		 * if there is reformat because firmware uses LB+hairpin to support it.
+		 */
+		if (dests[i].vport.num == MLX5_VPORT_UPLINK &&
+		    !(dests[i].vport.flags & MLX5_FLOW_DEST_VPORT_REFORMAT_ID))
+			external_dest = true;
 		else
-			vf_dest = true;
+			internal_dest = true;
 
-		if (vf_dest && pf_dest)
+		if (internal_dest && external_dest)
 			return true;
 	}
 
@@ -695,9 +700,9 @@ mlx5_eswitch_add_offloaded_rule(struct mlx5_eswitch *esw,
 
 		/* Header rewrite with combined wire+loopback in FDB is not allowed */
 		if ((flow_act.action & MLX5_FLOW_CONTEXT_ACTION_MOD_HDR) &&
-		    esw_dests_to_vf_pf_vports(dest, i)) {
+		    esw_dests_to_int_external(dest, i)) {
 			esw_warn(esw->dev,
-				 "FDB: Header rewrite with forwarding to both PF and VF is not allowed\n");
+				 "FDB: Header rewrite with forwarding to both internal and external dests is not allowed\n");
 			rule = ERR_PTR(-EINVAL);
 			goto err_esw_get;
 		}
-- 
2.44.0


