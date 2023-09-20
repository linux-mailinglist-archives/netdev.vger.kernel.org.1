Return-Path: <netdev+bounces-35130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C027A72F7
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 08:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A17451C20B8B
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 06:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFC4C2D3;
	Wed, 20 Sep 2023 06:36:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B2AC2CE
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 06:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A88DC433CA;
	Wed, 20 Sep 2023 06:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695191770;
	bh=xbIDfbwrx5ffOD4J8e33bqUjoA7tA9ioZ92tFFReuIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q/swOmPA00jRYaHe4Lxe+dMHyJ4mbMfs+ZHPBiXvG6NqrwWSPPa4ekF6ZgFm6xS/L
	 oxAva8n2NPB+2d22BPmc0LyQ1piQMSpvJgs08mgY9wEdaU7odYRIm2FPWLdFu+f1em
	 zZgz0hytdswnZM6K0JMKVvHaVrbjqqNIR14MaLbZ4i3W/3sHnQyX7MCAKu8P0bkoB8
	 vppz2PvqlJ2SMagiRPLeUr46m+/fAHpGrOjwLpm5TykeR7bEtEB0M6CTzTkMbN0yq/
	 PeUac9AYxdbsNOFjXVVTI+tnRLHYdkrPo7exAOhFnJIkJHGyXg8yioGoRmwFOW+8b8
	 ini4hxQ3pZe0A==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Erez Shitrit <erezsh@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: [net-next 12/15] net/mlx5: DR, Add check for multi destination FTE
Date: Tue, 19 Sep 2023 23:35:49 -0700
Message-ID: <20230920063552.296978-13-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920063552.296978-1-saeed@kernel.org>
References: <20230920063552.296978-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Erez Shitrit <erezsh@nvidia.com>

The driver should not allow rule that forward to more than one FT in TX
flow unless there is a specific support from the FW.

Signed-off-by: Erez Shitrit <erezsh@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/steering/dr_action.c         | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
index 5b83da08692d..7179542e9164 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
@@ -55,6 +55,12 @@ static const char *dr_action_id_to_str(enum mlx5dr_action_type action_id)
 	return action_type_to_str[action_id];
 }
 
+static bool mlx5dr_action_supp_fwd_fdb_multi_ft(struct mlx5_core_dev *dev)
+{
+	return (MLX5_CAP_ESW_FLOWTABLE(dev, fdb_multi_path_any_table_limit_regc) ||
+		MLX5_CAP_ESW_FLOWTABLE(dev, fdb_multi_path_any_table));
+}
+
 static const enum dr_action_valid_state
 next_action_state[DR_ACTION_DOMAIN_MAX][DR_ACTION_STATE_MAX][DR_ACTION_TYP_MAX] = {
 	[DR_ACTION_DOMAIN_NIC_INGRESS] = {
@@ -1167,6 +1173,7 @@ mlx5dr_action_create_mult_dest_tbl(struct mlx5dr_domain *dmn,
 	struct mlx5dr_action **ref_actions;
 	struct mlx5dr_action *action;
 	bool reformat_req = false;
+	u16 num_dst_ft = 0;
 	u32 num_of_ref = 0;
 	u32 ref_act_cnt;
 	int ret;
@@ -1210,6 +1217,12 @@ mlx5dr_action_create_mult_dest_tbl(struct mlx5dr_domain *dmn,
 			break;
 
 		case DR_ACTION_TYP_FT:
+			if (num_dst_ft &&
+			    !mlx5dr_action_supp_fwd_fdb_multi_ft(dmn->mdev)) {
+				mlx5dr_dbg(dmn, "multiple FT destinations not supported\n");
+				goto free_ref_actions;
+			}
+			num_dst_ft++;
 			hw_dests[i].type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
 			if (dest_action->dest_tbl->is_fw_tbl)
 				hw_dests[i].ft_id = dest_action->dest_tbl->fw_tbl.id;
-- 
2.41.0


