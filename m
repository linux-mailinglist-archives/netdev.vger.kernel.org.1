Return-Path: <netdev+bounces-13532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F8273BEE3
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 21:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 289B81C2134E
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 19:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAB015496;
	Fri, 23 Jun 2023 19:29:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E39411CBC
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 19:29:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91CFC433CB;
	Fri, 23 Jun 2023 19:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687548568;
	bh=JA8JCn/mVtYO9vYTkPzLQY/2LVuvj+iiiUlQqUkXE+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=clw1ShAe/7Kh5nSWZ92UqiO+r2oT9BXnmj4Bc5x7GZvR8u0g2hXxadAwUayvvNSjr
	 nsAOPSliJmxwldMZXOefQKosywi1Vmu1ltHytGrJ3N9lY9CjR7CNau+W58eRVUXrjR
	 DLWFcpg1V4LVFin9CSrxQGwSlbMBUXDe666fsx+bv1H6jerpcXFRMYJ9XRWtXhyGLc
	 QpMToQTKxPeEIaCVUwA8JW4WiNHkqaV+V4ydcXviEtm1hSABMZeKgEK/WA478Z3ZgH
	 JU/eR1jl/+vfzPTdL61c9Nl7ucy1k4athuSfhdITmmnw18A38w7ZcHrQeo44/HqLxM
	 rhl64TprqGUuw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Shay Drory <shayd@nvidia.com>
Subject: [net-next V2 14/15] net/mlx5: Remove redundant check from mlx5_esw_query_vport_vhca_id()
Date: Fri, 23 Jun 2023 12:29:06 -0700
Message-ID: <20230623192907.39033-15-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230623192907.39033-1-saeed@kernel.org>
References: <20230623192907.39033-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Since mlx5_esw_query_vport_vhca_id() could be called either from
mlx5_esw_vport_enable() or mlx5_esw_vport_disable() where the
the check is done, this is always false here.
Remove the redundant check.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index cf58295ad7e2..bdfe609cc9ec 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3961,9 +3961,6 @@ static int mlx5_esw_query_vport_vhca_id(struct mlx5_eswitch *esw, u16 vport_num,
 	int err;
 
 	*vhca_id = 0;
-	if (mlx5_esw_is_manager_vport(esw, vport_num) ||
-	    !MLX5_CAP_GEN(esw->dev, vhca_resource_manager))
-		return -EPERM;
 
 	query_ctx = kzalloc(query_out_sz, GFP_KERNEL);
 	if (!query_ctx)
-- 
2.41.0


