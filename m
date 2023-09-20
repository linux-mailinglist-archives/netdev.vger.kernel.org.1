Return-Path: <netdev+bounces-35129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5787A72F5
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 08:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6E72816DD
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 06:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8FCC15F;
	Wed, 20 Sep 2023 06:36:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D658C13D
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 06:36:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20FBAC433C9;
	Wed, 20 Sep 2023 06:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695191769;
	bh=tNng2k+y2H0WRG39MPaMpRplIFtogBg1r85RRsvfOrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D1vM/DXMn7U9q+e1G1G6st/RRVR+Ntmmu2P7ZAQyTuX5VJH9g3l9u+nXkymgc9fzz
	 Kx5zHPWQXdYYHfOXRcEZa8/IPwMBu5tto6BNYgsoAlRD/8Ia2gnKJ8Iz4jSUybUXJf
	 JVym+uLMuuidXGWUoJ4J3/6yw1mYsn5sKi1wR6p/sYXfvO9ntAaoTP2Xjv3/xPfMCb
	 zc+Irjbr5XnSFLV/pJ3+zYtlb7CzG67xZ/ZixQQMy7x/ZWiQBM7qNId4Tnq8Vt+h40
	 QEBPKzWr34XTKuXey6Zpuqib1NRWw+DyriGYm2IH6xGD1qWrJssslkh/WDiliNDlST
	 6BR+2zxIcYF5g==
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
	Vlad Buslov <vladbu@nvidia.com>
Subject: [net-next 11/15] net/mlx5: Bridge, Enable mcast in smfs steering mode
Date: Tue, 19 Sep 2023 23:35:48 -0700
Message-ID: <20230920063552.296978-12-saeed@kernel.org>
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

In order to have mcast offloads the driver needs the following:
It should know if that mcast comes from wire port, in addition the flow
should not be marked as any specific source, that way it will give the
flexibility for the driver not to be depended on the way iterator
implemented in the FW.

Signed-off-by: Erez Shitrit <erezsh@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/esw/bridge_mcast.c    | 11 ++---------
 include/linux/mlx5/fs.h                               |  1 +
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge_mcast.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge_mcast.c
index 7a01714b3780..a7ed87e9d842 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge_mcast.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge_mcast.c
@@ -78,6 +78,8 @@ mlx5_esw_bridge_mdb_flow_create(u16 esw_owner_vhca_id, struct mlx5_esw_bridge_md
 	xa_for_each(&entry->ports, idx, port) {
 		dests[i].type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
 		dests[i].ft = port->mcast.ft;
+		if (port->vport_num == MLX5_VPORT_UPLINK)
+			dests[i].ft->flags |= MLX5_FLOW_TABLE_UPLINK_VPORT;
 		i++;
 	}
 
@@ -585,10 +587,6 @@ mlx5_esw_bridge_mcast_vlan_flow_create(u16 vlan_proto, struct mlx5_esw_bridge_po
 	if (!rule_spec)
 		return ERR_PTR(-ENOMEM);
 
-	if (MLX5_CAP_ESW_FLOWTABLE(bridge->br_offloads->esw->dev, flow_source) &&
-	    port->vport_num == MLX5_VPORT_UPLINK)
-		rule_spec->flow_context.flow_source =
-			MLX5_FLOW_CONTEXT_FLOW_SOURCE_LOCAL_VPORT;
 	rule_spec->match_criteria_enable = MLX5_MATCH_OUTER_HEADERS;
 
 	flow_act.action |= MLX5_FLOW_CONTEXT_ACTION_PACKET_REFORMAT;
@@ -660,11 +658,6 @@ mlx5_esw_bridge_mcast_fwd_flow_create(struct mlx5_esw_bridge_port *port)
 	if (!rule_spec)
 		return ERR_PTR(-ENOMEM);
 
-	if (MLX5_CAP_ESW_FLOWTABLE(bridge->br_offloads->esw->dev, flow_source) &&
-	    port->vport_num == MLX5_VPORT_UPLINK)
-		rule_spec->flow_context.flow_source =
-			MLX5_FLOW_CONTEXT_FLOW_SOURCE_LOCAL_VPORT;
-
 	if (MLX5_CAP_ESW(bridge->br_offloads->esw->dev, merged_eswitch)) {
 		dest.vport.flags = MLX5_FLOW_DEST_VPORT_VHCA_ID;
 		dest.vport.vhca_id = port->esw_owner_vhca_id;
diff --git a/include/linux/mlx5/fs.h b/include/linux/mlx5/fs.h
index 1e00c2436377..6f7725238abc 100644
--- a/include/linux/mlx5/fs.h
+++ b/include/linux/mlx5/fs.h
@@ -67,6 +67,7 @@ enum {
 	MLX5_FLOW_TABLE_TERMINATION = BIT(2),
 	MLX5_FLOW_TABLE_UNMANAGED = BIT(3),
 	MLX5_FLOW_TABLE_OTHER_VPORT = BIT(4),
+	MLX5_FLOW_TABLE_UPLINK_VPORT = BIT(5),
 };
 
 #define LEFTOVERS_RULE_NUM	 2
-- 
2.41.0


