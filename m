Return-Path: <netdev+bounces-12918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D97DD73970C
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 07:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16ABF1C20EA0
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 05:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87DA1D2B9;
	Thu, 22 Jun 2023 05:48:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D032B1D2B2
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:48:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86106C433D9;
	Thu, 22 Jun 2023 05:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687412883;
	bh=JA8JCn/mVtYO9vYTkPzLQY/2LVuvj+iiiUlQqUkXE+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bXYPN0NAjjNN4kqnXuA/UVkvp/4QxLmD6jSHgf9yYRXJcqhSPaKNDwwMWQPY7qpj3
	 rxMc6woDRIkx6WlajJp1oGUl+LUZtDkVgCQNbwfGUk4UIJg8ehm7JEZCvUg5V1NInt
	 fxbubWgWxEx5uV/nUTKUanNlMJPqIDDU/CWckCQuyoGwithldDzUOMBhoj37vlPVHC
	 1XWdvOiTuHaQj4b/ldEMSTzwjkoGuXpGgoyfJesdbFso5NDUiJwA0xu7gsWp9ESK/n
	 Me0humecr3VnoDt75R2zA/h5aJ7vPMDmY+V/9dhlLpGlwq4hX9e/01eVHSsghDsSMm
	 egqRLbZdlzFSg==
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
Subject: [net-next 14/15] net/mlx5: Remove redundant check from mlx5_esw_query_vport_vhca_id()
Date: Wed, 21 Jun 2023 22:47:34 -0700
Message-ID: <20230622054735.46790-15-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230622054735.46790-1-saeed@kernel.org>
References: <20230622054735.46790-1-saeed@kernel.org>
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


