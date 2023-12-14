Return-Path: <netdev+bounces-57156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C9C81248B
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 02:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1EA91C213FB
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 01:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687E37ED;
	Thu, 14 Dec 2023 01:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFI9Es2o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484E13D7C
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 01:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D953C433CB;
	Thu, 14 Dec 2023 01:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702517116;
	bh=5h8PjeKPgBikqIMJWdj/lwMwuYTz1KaOOIwl94MC+3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MFI9Es2osyzcVf3lzEhluEHZH0LXXSbLUMO1WCaGCohWHSNQbLuedub/sBcdh46Da
	 R8Nu4ap+8nlRgNLH86IZpOnWW+3YBAW32EQP8S43/R4CRZuzG5un4wTktHBAlZ36v6
	 XcqtRmHACa96N8o0bZERg6vAZXpQ4md041EMpMaBz5Z8vUGK9QcvKyy/PZEWkPtYl+
	 niJvCLt/DMqbCOjgialpjIoKjfhIQSeSlVBJsYYrGNANo0FJvXh0z4wpUtZq143TK8
	 t20Fu/OQ2UHjNyrkt9gtPfM9QYLEYTyxWhw8P8rX+QqvGXXfLt2TQ29LKpp1udB5E8
	 MYmIkGbsNPPtQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Roi Dayan <roid@nvidia.com>
Subject: [net 07/15] net/mlx5e: Fix overrun reported by coverity
Date: Wed, 13 Dec 2023 17:24:57 -0800
Message-ID: <20231214012505.42666-8-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214012505.42666-1-saeed@kernel.org>
References: <20231214012505.42666-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianbo Liu <jianbol@nvidia.com>

Coverity Scan reports the following issue. But it's impossible that
mlx5_get_dev_index returns 7 for PF, even if the index is calculated
from PCI FUNC ID. So add the checking to make coverity slience.

CID 610894 (#2 of 2): Out-of-bounds write (OVERRUN)
Overrunning array esw->fdb_table.offloads.peer_miss_rules of 4 8-byte
elements at element index 7 (byte offset 63) using index
mlx5_get_dev_index(peer_dev) (which evaluates to 7).

Fixes: 9bee385a6e39 ("net/mlx5: E-switch, refactor FDB miss rule add/remove")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Roi Dayan <roid@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c   | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index bb8bcb448ae9..9bd5609cf659 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -1177,9 +1177,9 @@ static int esw_add_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 	struct mlx5_flow_handle *flow;
 	struct mlx5_flow_spec *spec;
 	struct mlx5_vport *vport;
+	int err, pfindex;
 	unsigned long i;
 	void *misc;
-	int err;
 
 	if (!MLX5_VPORT_MANAGER(esw->dev) && !mlx5_core_is_ecpf_esw_manager(esw->dev))
 		return 0;
@@ -1255,7 +1255,15 @@ static int esw_add_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 			flows[vport->index] = flow;
 		}
 	}
-	esw->fdb_table.offloads.peer_miss_rules[mlx5_get_dev_index(peer_dev)] = flows;
+
+	pfindex = mlx5_get_dev_index(peer_dev);
+	if (pfindex >= MLX5_MAX_PORTS) {
+		esw_warn(esw->dev, "Peer dev index(%d) is over the max num defined(%d)\n",
+			 pfindex, MLX5_MAX_PORTS);
+		err = -EINVAL;
+		goto add_ec_vf_flow_err;
+	}
+	esw->fdb_table.offloads.peer_miss_rules[pfindex] = flows;
 
 	kvfree(spec);
 	return 0;
-- 
2.43.0


