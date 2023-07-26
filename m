Return-Path: <netdev+bounces-21632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E75764138
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 23:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 531031C21465
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 21:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0945198B7;
	Wed, 26 Jul 2023 21:32:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B975B19899
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 21:32:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C05C4339A;
	Wed, 26 Jul 2023 21:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690407133;
	bh=iFY+HhTsmiJNucZipuoAgaSV8bgi1txl7OiGzXz82HI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r0dNb6GCUpcgbwwkP+8tVi1WntpJMZrYqy2Gij9+OeX6jjgczPmiQuYA3vLiOW71q
	 +eKRrL9YsJyBM3ZeUiyojW6oHSqPwj39CqcLYLAkrE1d2Yv2+HvV1rI+IduNIZJdCV
	 PAmcX7+yJQPbJd/dPPOzZfDkwHSyMuRSd63w+JdUlEh+fE5uPSNnY6YxsfQuxlj6me
	 RtFNAiiqV++sUkvYlnNu7yOUGkQNjptugicw3qfGce3rWCpVuZ9vXwzitUdAExrsWt
	 b1LhGODhqFtnouOHhoK82d7KNr1VQsTOGFV43ll2xeAV5kOPbYXIyDUuDFzEZ+rAzH
	 7nNqpcTe39qzA==
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
Subject: [net 05/15] net/mlx5: Honor user input for migratable port fn attr
Date: Wed, 26 Jul 2023 14:31:56 -0700
Message-ID: <20230726213206.47022-6-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726213206.47022-1-saeed@kernel.org>
References: <20230726213206.47022-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shay Drory <shayd@nvidia.com>

Currently, whenever a user is setting migratable port fn attr, the
driver is always turn migratable capability on.
Fix it by honor the user input

Fixes: e5b9642a33be ("net/mlx5: E-Switch, Implement devlink port function cmds to control migratable")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Roi Dayan <roid@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index bdfe609cc9ec..93b2b94d41cd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -4196,7 +4196,7 @@ int mlx5_devlink_port_fn_migratable_set(struct devlink_port *port, bool enable,
 	}
 
 	hca_caps = MLX5_ADDR_OF(query_hca_cap_out, query_ctx, capability);
-	MLX5_SET(cmd_hca_cap_2, hca_caps, migratable, 1);
+	MLX5_SET(cmd_hca_cap_2, hca_caps, migratable, enable);
 
 	err = mlx5_vport_set_other_func_cap(esw->dev, hca_caps, vport->vport,
 					    MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE2);
-- 
2.41.0


