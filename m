Return-Path: <netdev+bounces-12911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F417396FD
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 07:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76BED1C20EC5
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 05:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0194CDDBC;
	Thu, 22 Jun 2023 05:47:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABEB3C22
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85521C433C8;
	Thu, 22 Jun 2023 05:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687412874;
	bh=+mesCMhbH61ywaQwLk84Q5m8471XrPZIc3broOlOtPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eaBMZXvL2DM9qz9VQzivn1IsDCJZr5wa9xWZ6luNuBwN3eXcmVRB3EnC/pQyKmu+4
	 +NJyd9G7qB4FHo+1jQkKQkHkZWaXKSSyFPeXVXxbSgtr9vGLUJqMHUGh2GZst9Ty1l
	 Ze4jn/+57Cl8Ko/NtJcUFh5NB497ltpuxkSZhY314q419P30CmyRsglTcYFzpK4Ejo
	 N6I+H8/nG+xZBoS6D3OrGjU2a54lwVCQUNfVRN135B0fjnV8tzjc4SOEKbovq8DZWj
	 ZEgaIZE0KNCUaCldLp2bbIIcGgP0ajbcfCc0HEKHdV1ssvG3uONv2Ykw/pw5eaYPXn
	 QNtUK4q0UhAFA==
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
Subject: [net-next 07/15] net/mlx5e: E-Switch, Add peer fdb miss rules for vport manager or ecpf
Date: Wed, 21 Jun 2023 22:47:27 -0700
Message-ID: <20230622054735.46790-8-saeed@kernel.org>
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

Add peer fdb rules for E-Switch that are vport managers or ecpf device.
It is not needed for other devices.

Signed-off-by: Roi Dayan <roid@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 9056b0b014f6..ed986d1c9e90 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -1069,6 +1069,9 @@ static int esw_add_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 	void *misc;
 	int err;
 
+	if (!MLX5_VPORT_MANAGER(esw->dev) && !mlx5_core_is_ecpf_esw_manager(esw->dev))
+		return 0;
+
 	spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
 	if (!spec)
 		return -ENOMEM;
@@ -1177,11 +1180,14 @@ static int esw_add_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 static void esw_del_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 					struct mlx5_core_dev *peer_dev)
 {
+	u16 peer_index = mlx5_get_dev_index(peer_dev);
 	struct mlx5_flow_handle **flows;
 	struct mlx5_vport *vport;
 	unsigned long i;
 
-	flows = esw->fdb_table.offloads.peer_miss_rules[mlx5_get_dev_index(peer_dev)];
+	flows = esw->fdb_table.offloads.peer_miss_rules[peer_index];
+	if (!flows)
+		return;
 
 	if (mlx5_core_ec_sriov_enabled(esw->dev)) {
 		mlx5_esw_for_each_ec_vf_vport(esw, i, vport, mlx5_core_max_ec_vfs(esw->dev)) {
@@ -1206,7 +1212,9 @@ static void esw_del_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 		vport = mlx5_eswitch_get_vport(esw, MLX5_VPORT_PF);
 		mlx5_del_flow_rules(flows[vport->index]);
 	}
+
 	kvfree(flows);
+	esw->fdb_table.offloads.peer_miss_rules[peer_index] = NULL;
 }
 
 static int esw_add_fdb_miss_rule(struct mlx5_eswitch *esw)
-- 
2.41.0


