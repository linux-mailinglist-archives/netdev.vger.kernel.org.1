Return-Path: <netdev+bounces-45115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3757DAF03
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 23:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3798B20BF6
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 22:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EF210A13;
	Sun, 29 Oct 2023 22:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXA1gHSa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A944F9D2
	for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 22:55:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC74C43215;
	Sun, 29 Oct 2023 22:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698620133;
	bh=Uik5RqxSBjzyvuK45WQbsqMsr6W7JfRY8AnekusRtL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pXA1gHSamPudCKG1OPhOZW5+jArJXi9esfv9+7H1/rorPdkj7Q7xrwWA2P8G3OkGy
	 FjnZDDU3ZWTkRnhhZW0pANim0kOmDcUUImd4tlDmXcRIU9q2Rqk6No3jI9ZHVgIuf9
	 91wkrTJKeBhqs/0ECsJ06Rnos9DZZbAmh9iN8XZk2a+otPYaNWDkD3H+P+olFvlaNk
	 cZZrOlcsjM351SRTR1pT/zZDpIqCoB+LNVAlecBZS+KxQWrjX+DfndcaE3WRmPT7+E
	 C92iu8rR/T83z5YK4kDSqPe2oCMeXpp+bQFeDolZRrgz5gC40q710O5XAl2u8IqZAM
	 oEeQzyFsy8nVQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vlad Buslov <vladbu@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	roid@nvidia.com,
	maord@nvidia.com,
	shayd@nvidia.com,
	gal@nvidia.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 25/52] net/mlx5: Bridge, fix peer entry ageing in LAG mode
Date: Sun, 29 Oct 2023 18:53:12 -0400
Message-ID: <20231029225441.789781-25-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225441.789781-1-sashal@kernel.org>
References: <20231029225441.789781-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.9
Content-Transfer-Encoding: 8bit

From: Vlad Buslov <vladbu@nvidia.com>

[ Upstream commit 7a3ce8074878a68a75ceacec93d9ae05906eec86 ]

With current implementation in single FDB LAG mode all packets are
processed by eswitch 0 rules. As such, 'peer' FDB entries receive the
packets for rules of other eswitches and are responsible for updating the
main entry by sending SWITCHDEV_FDB_ADD_TO_BRIDGE notification from their
background update wq task. However, this introduces a race condition when
non-zero eswitch instance decides to delete a FDB entry, sends
SWITCHDEV_FDB_DEL_TO_BRIDGE notification, but another eswitch's update task
refreshes the same entry concurrently while its async delete work is still
pending on the workque. In such case another SWITCHDEV_FDB_ADD_TO_BRIDGE
event may be generated and entry will remain stuck in FDB marked as
'offloaded' since no more SWITCHDEV_FDB_DEL_TO_BRIDGE notifications are
sent for deleting the peer entries.

Fix the issue by synchronously marking deleted entries with
MLX5_ESW_BRIDGE_FLAG_DELETED flag and skipping them in background update
job.

Signed-off-by: Vlad Buslov <vladbu@nvidia.com>
Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../mellanox/mlx5/core/en/rep/bridge.c        | 11 ++++++++
 .../ethernet/mellanox/mlx5/core/esw/bridge.c  | 25 ++++++++++++++++++-
 .../ethernet/mellanox/mlx5/core/esw/bridge.h  |  3 +++
 .../mellanox/mlx5/core/esw/bridge_priv.h      |  1 +
 4 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
index 5608002465734..285c13edc09f0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
@@ -463,6 +463,17 @@ static int mlx5_esw_bridge_switchdev_event(struct notifier_block *nb,
 		/* only handle the event on peers */
 		if (mlx5_esw_bridge_is_local(dev, rep, esw))
 			break;
+
+		fdb_info = container_of(info,
+					struct switchdev_notifier_fdb_info,
+					info);
+		/* Mark for deletion to prevent the update wq task from
+		 * spuriously refreshing the entry which would mark it again as
+		 * offloaded in SW bridge. After this fallthrough to regular
+		 * async delete code.
+		 */
+		mlx5_esw_bridge_fdb_mark_deleted(dev, vport_num, esw_owner_vhca_id, br_offloads,
+						 fdb_info);
 		fallthrough;
 	case SWITCHDEV_FDB_ADD_TO_DEVICE:
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
index f4fe1daa4afd5..de1ed59239da8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
@@ -1748,6 +1748,28 @@ void mlx5_esw_bridge_fdb_update_used(struct net_device *dev, u16 vport_num, u16
 	entry->lastuse = jiffies;
 }
 
+void mlx5_esw_bridge_fdb_mark_deleted(struct net_device *dev, u16 vport_num, u16 esw_owner_vhca_id,
+				      struct mlx5_esw_bridge_offloads *br_offloads,
+				      struct switchdev_notifier_fdb_info *fdb_info)
+{
+	struct mlx5_esw_bridge_fdb_entry *entry;
+	struct mlx5_esw_bridge *bridge;
+
+	bridge = mlx5_esw_bridge_from_port_lookup(vport_num, esw_owner_vhca_id, br_offloads);
+	if (!bridge)
+		return;
+
+	entry = mlx5_esw_bridge_fdb_lookup(bridge, fdb_info->addr, fdb_info->vid);
+	if (!entry) {
+		esw_debug(br_offloads->esw->dev,
+			  "FDB mark deleted entry with specified key not found (MAC=%pM,vid=%u,vport=%u)\n",
+			  fdb_info->addr, fdb_info->vid, vport_num);
+		return;
+	}
+
+	entry->flags |= MLX5_ESW_BRIDGE_FLAG_DELETED;
+}
+
 void mlx5_esw_bridge_fdb_create(struct net_device *dev, u16 vport_num, u16 esw_owner_vhca_id,
 				struct mlx5_esw_bridge_offloads *br_offloads,
 				struct switchdev_notifier_fdb_info *fdb_info)
@@ -1810,7 +1832,8 @@ void mlx5_esw_bridge_update(struct mlx5_esw_bridge_offloads *br_offloads)
 			unsigned long lastuse =
 				(unsigned long)mlx5_fc_query_lastuse(entry->ingress_counter);
 
-			if (entry->flags & MLX5_ESW_BRIDGE_FLAG_ADDED_BY_USER)
+			if (entry->flags & (MLX5_ESW_BRIDGE_FLAG_ADDED_BY_USER |
+					    MLX5_ESW_BRIDGE_FLAG_DELETED))
 				continue;
 
 			if (time_after(lastuse, entry->lastuse))
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.h
index c2c7c70d99eb7..d6f5391619930 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.h
@@ -62,6 +62,9 @@ int mlx5_esw_bridge_vport_peer_unlink(struct net_device *br_netdev, u16 vport_nu
 void mlx5_esw_bridge_fdb_update_used(struct net_device *dev, u16 vport_num, u16 esw_owner_vhca_id,
 				     struct mlx5_esw_bridge_offloads *br_offloads,
 				     struct switchdev_notifier_fdb_info *fdb_info);
+void mlx5_esw_bridge_fdb_mark_deleted(struct net_device *dev, u16 vport_num, u16 esw_owner_vhca_id,
+				      struct mlx5_esw_bridge_offloads *br_offloads,
+				      struct switchdev_notifier_fdb_info *fdb_info);
 void mlx5_esw_bridge_fdb_create(struct net_device *dev, u16 vport_num, u16 esw_owner_vhca_id,
 				struct mlx5_esw_bridge_offloads *br_offloads,
 				struct switchdev_notifier_fdb_info *fdb_info);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge_priv.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge_priv.h
index 4911cc32161b4..7c251af566c6f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge_priv.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge_priv.h
@@ -133,6 +133,7 @@ struct mlx5_esw_bridge_mdb_key {
 enum {
 	MLX5_ESW_BRIDGE_FLAG_ADDED_BY_USER = BIT(0),
 	MLX5_ESW_BRIDGE_FLAG_PEER = BIT(1),
+	MLX5_ESW_BRIDGE_FLAG_DELETED = BIT(2),
 };
 
 enum {
-- 
2.42.0


