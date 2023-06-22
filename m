Return-Path: <netdev+bounces-12910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CC97396FC
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 07:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DE1C1C20A2D
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 05:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB92B79EE;
	Thu, 22 Jun 2023 05:47:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838F95CAC
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:47:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD5DC433A9;
	Thu, 22 Jun 2023 05:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687412873;
	bh=yJMiVVoFDJ4t/TVJlg6ySHFS92LatGL8JyxccN9I7us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ujz4xK9baoKOkSvX662pR6+y/eilbQJujZ42sbloAhImDh/wwuFNJCs4JDtgfyGfX
	 pAaou9dT4OkBb+2e3i40tbY9s8moGAf4CR1ofeLpMK3ZjQ3FW0aGXj4ztRInj81wMR
	 xzlusqU3mzTa5pr1374hlUaU4Etw3u2/m45MnI7NBcyIL8Fzw3baGhpfEzbyeXVtWL
	 YOwG8iNqj7w/G0XuWvRq32qbgRnGxwMCdlDugNH2XoQ1+PWLIKECZAYIegvXOcByju
	 eJ840ULeB10/ty1WrlzCaiSwOvk3VAYvSso3GSe+LfOR6wULpFQkJXMN/zTbscO+aa
	 WxXjVKMMkxgog==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Roi Dayan <roid@nvidia.com>,
	Shay Drory <shayd@nvidia.com>
Subject: [net-next 06/15] net/mlx5e: Use vhca_id for device index in vport rx rules
Date: Wed, 21 Jun 2023 22:47:26 -0700
Message-ID: <20230622054735.46790-7-saeed@kernel.org>
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

From: Roi Dayan <roid@nvidia.com>

Device index is like PF index and limited to max physical ports.
For example, SFs created under PF the device index is the PF device index.
Use vhca_id which gets the FW index per vport, for vport rx rules
and vport pair events.

Signed-off-by: Roi Dayan <roid@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 965a8261c99b..152b62138450 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -408,7 +408,7 @@ static int mlx5e_sqs2vport_add_peers_rules(struct mlx5_eswitch *esw, struct mlx5
 
 	mlx5_devcom_for_each_peer_entry(devcom, MLX5_DEVCOM_ESW_OFFLOADS,
 					peer_esw, tmp) {
-		int peer_rule_idx = mlx5_get_dev_index(peer_esw->dev);
+		u16 peer_rule_idx = MLX5_CAP_GEN(peer_esw->dev, vhca_id);
 		struct mlx5e_rep_sq_peer *sq_peer;
 		int err;
 
@@ -1581,7 +1581,7 @@ static void *mlx5e_vport_rep_get_proto_dev(struct mlx5_eswitch_rep *rep)
 static void mlx5e_vport_rep_event_unpair(struct mlx5_eswitch_rep *rep,
 					 struct mlx5_eswitch *peer_esw)
 {
-	int i = mlx5_get_dev_index(peer_esw->dev);
+	u16 i = MLX5_CAP_GEN(peer_esw->dev, vhca_id);
 	struct mlx5e_rep_priv *rpriv;
 	struct mlx5e_rep_sq *rep_sq;
 
@@ -1603,7 +1603,7 @@ static int mlx5e_vport_rep_event_pair(struct mlx5_eswitch *esw,
 				      struct mlx5_eswitch_rep *rep,
 				      struct mlx5_eswitch *peer_esw)
 {
-	int i = mlx5_get_dev_index(peer_esw->dev);
+	u16 i = MLX5_CAP_GEN(peer_esw->dev, vhca_id);
 	struct mlx5_flow_handle *flow_rule;
 	struct mlx5e_rep_sq_peer *sq_peer;
 	struct mlx5e_rep_priv *rpriv;
-- 
2.41.0


