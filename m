Return-Path: <netdev+bounces-35131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE3D7A72FB
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 08:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C03091C20B9D
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 06:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6FFC8C3;
	Wed, 20 Sep 2023 06:36:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE6EC8C0
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 06:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D40C433C8;
	Wed, 20 Sep 2023 06:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695191771;
	bh=CzpjofPmz2uCktoqCJll9eKy6rDJBBUqcabXJbReep0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N6DrhVu1cnWzgspbVpAKVDvj7VjN3isFhIeEe5luyYqGZ91dHKp4KnbDH4mtEsWtB
	 mAEdMeeuSFCsy6Sh1n6yu3NtVHihY7J4p+YneSQEUqhKGvOSToMgNz6rP50sscUKfv
	 pK/8WH+Q0s0YpZzqOSVlEesvOB1mnuJfkyiDH+Pyrj4/3Hh7SGV4TOkVYkVtwP/GVC
	 OhdEw55zieMnDL07FIpSQmBki7wua2UZAgMB2pnBuD9nH2YBC3eHwmzWly+AOZ9STi
	 6QXWzdlagtz4twirpPtobaixnH/RItVDbONUazWuPxaAvkIbR8wQ1NGtkrk0grG7jw
	 zH5izhAvyfl3w==
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
Subject: [net-next 13/15] net/mlx5: DR, Handle multi destination action in the right order
Date: Tue, 19 Sep 2023 23:35:50 -0700
Message-ID: <20230920063552.296978-14-saeed@kernel.org>
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

Whenever we have few destinations from Flow-table type we need to put
the one that goes to the wire to be the last one.

We are using FW in order to get iterator, the FW uses RX for the first
destinations and TX for the last destination, if we want the packet to
be directed to the wire it should be done in the TX path and not in the
RX.
The code now checks if the FT is directed to the wire and if so puts it
as the last destination.

Signed-off-by: Erez Shitrit <erezsh@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/steering/dr_action.c   | 22 +++++++++++++++++--
 .../mellanox/mlx5/core/steering/dr_types.h    |  1 +
 .../mellanox/mlx5/core/steering/fs_dr.c       |  9 +++++++-
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
index 7179542e9164..6ea88a581804 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
@@ -1169,13 +1169,16 @@ mlx5dr_action_create_mult_dest_tbl(struct mlx5dr_domain *dmn,
 				   bool ignore_flow_level,
 				   u32 flow_source)
 {
+	struct mlx5dr_cmd_flow_destination_hw_info tmp_hw_dest;
 	struct mlx5dr_cmd_flow_destination_hw_info *hw_dests;
 	struct mlx5dr_action **ref_actions;
 	struct mlx5dr_action *action;
 	bool reformat_req = false;
+	bool is_ft_wire = false;
 	u16 num_dst_ft = 0;
 	u32 num_of_ref = 0;
 	u32 ref_act_cnt;
+	u16 last_dest;
 	int ret;
 	int i;
 
@@ -1224,10 +1227,15 @@ mlx5dr_action_create_mult_dest_tbl(struct mlx5dr_domain *dmn,
 			}
 			num_dst_ft++;
 			hw_dests[i].type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
-			if (dest_action->dest_tbl->is_fw_tbl)
+			if (dest_action->dest_tbl->is_fw_tbl) {
 				hw_dests[i].ft_id = dest_action->dest_tbl->fw_tbl.id;
-			else
+			} else {
 				hw_dests[i].ft_id = dest_action->dest_tbl->tbl->table_id;
+				if (dest_action->dest_tbl->is_wire_ft) {
+					is_ft_wire = true;
+					last_dest = i;
+				}
+			}
 			break;
 
 		default:
@@ -1236,6 +1244,16 @@ mlx5dr_action_create_mult_dest_tbl(struct mlx5dr_domain *dmn,
 		}
 	}
 
+	/* In multidest, the FW does the iterator in the RX except of the last
+	 * one that done in the TX.
+	 * So, if one of the ft target is wire, put it at the end of the dest list.
+	 */
+	if (is_ft_wire && num_dst_ft > 1) {
+		tmp_hw_dest = hw_dests[last_dest];
+		hw_dests[last_dest] = hw_dests[num_of_dests - 1];
+		hw_dests[num_of_dests - 1] = tmp_hw_dest;
+	}
+
 	action = dr_action_create_generic(DR_ACTION_TYP_FT);
 	if (!action)
 		goto free_ref_actions;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_types.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_types.h
index 6c59de3e28f6..55dc7383477c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_types.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_types.h
@@ -1064,6 +1064,7 @@ struct mlx5dr_action_sampler {
 
 struct mlx5dr_action_dest_tbl {
 	u8 is_fw_tbl:1;
+	u8 is_wire_ft:1;
 	union {
 		struct mlx5dr_table *tbl;
 		struct {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.c
index 14f6df88b1f9..50c2554c9ccf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.c
@@ -209,10 +209,17 @@ static struct mlx5dr_action *create_ft_action(struct mlx5dr_domain *domain,
 					      struct mlx5_flow_rule *dst)
 {
 	struct mlx5_flow_table *dest_ft = dst->dest_attr.ft;
+	struct mlx5dr_action *tbl_action;
 
 	if (mlx5dr_is_fw_table(dest_ft))
 		return mlx5dr_action_create_dest_flow_fw_table(domain, dest_ft);
-	return mlx5dr_action_create_dest_table(dest_ft->fs_dr_table.dr_table);
+
+	tbl_action = mlx5dr_action_create_dest_table(dest_ft->fs_dr_table.dr_table);
+	if (tbl_action)
+		tbl_action->dest_tbl->is_wire_ft =
+			dest_ft->flags & MLX5_FLOW_TABLE_UPLINK_VPORT ? 1 : 0;
+
+	return tbl_action;
 }
 
 static struct mlx5dr_action *create_range_action(struct mlx5dr_domain *domain,
-- 
2.41.0


