Return-Path: <netdev+bounces-126677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E0B9722FD
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 21:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E9731F2435C
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 19:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31E418A937;
	Mon,  9 Sep 2024 19:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWqcxXB4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E30118A6C9
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 19:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725911140; cv=none; b=uJD8YRM6wan/grgln76kC5bLaWFoStqhJxLl3yQzuqV867glumJoHMqPztDjIsItu7gOPhsk91iR6n/nLWilrEnS5V0KXpAyH5teMm0bUEDiu5Jn0ZQoUBqCc4PvjEkvDvt5P9ygil2wYQRgzkchJQ/ZHYQ0jmV4RcHMD32AoGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725911140; c=relaxed/simple;
	bh=237xFwtgNoWlHrM2Sbqh54nCHY/Xh2KbJPYEq122E7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPjgHQQP4Da2QRiQJ2Tz0fe9vSUvpdECuCqDbmShykoREFnd0E0ninsA3OLaftTWCOhS8Zue+CLUXNVTGS08bJeD7ptI//DUzFmv9AOOdDLAGH2ML5Px8y5gb4kLtpnvmrupH8h0lZ4Z9l1DVv0TsFongP+TnW2RoHEnfUJG6dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWqcxXB4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A950C4CEC8;
	Mon,  9 Sep 2024 19:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725911140;
	bh=237xFwtgNoWlHrM2Sbqh54nCHY/Xh2KbJPYEq122E7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CWqcxXB4oZZk0zm8oB9SmMNPhZXFfNL+x1tVQ1/Z7Ub4csH+T8e471bmHl9WAFWDR
	 KesW8zax+Ay3Wcvw6xtLIhNQuTCP1jEJHnc9tHiuYVUeDTIUbOj54vS1BTXJ4sEBxv
	 /jE+fLAEncjKZM9bfZGmH3VEXo1BAbtyhG3f2CcVnoeVObXn7N0b/+7JQBgp89W5tf
	 d2CkRvhBXFtUKoIdxSLKtBSr/LL4JFhpcTR7UmVfqguH6WJZyiYeAJzBQxY1Ks6kxD
	 4Gr6H/B88/padJ3lflCH5Xfv25XeQAGA/ZAOFcnkiGGWxEmcFcgvBFwCGLZqb425Ro
	 9KUWp71BBYdRw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: [net 6/7] net/mlx5: Verify support for scheduling element and TSAR type
Date: Mon,  9 Sep 2024 12:45:04 -0700
Message-ID: <20240909194505.69715-7-saeed@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909194505.69715-1-saeed@kernel.org>
References: <20240909194505.69715-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carolina Jubran <cjubran@nvidia.com>

Before creating a scheduling element in a NIC or E-Switch scheduler,
ensure that the requested element type is supported. If the element is
of type Transmit Scheduling Arbiter (TSAR), also verify that the
specific TSAR type is supported.

Fixes: 214baf22870c ("net/mlx5e: Support HTB offload")
Fixes: 85c5f7c9200e ("net/mlx5: E-switch, Create QoS on demand")
Fixes: 0fe132eac38c ("net/mlx5: E-switch, Allow to add vports to rate groups")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 44 ++++++++++---------
 drivers/net/ethernet/mellanox/mlx5/core/qos.c |  7 +++
 2 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 997c412a81af..02a3563f51ad 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -312,6 +312,25 @@ static int esw_qos_set_group_max_rate(struct mlx5_eswitch *esw,
 	return err;
 }
 
+static bool esw_qos_element_type_supported(struct mlx5_core_dev *dev, int type)
+{
+	switch (type) {
+	case SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR:
+		return MLX5_CAP_QOS(dev, esw_element_type) &
+		       ELEMENT_TYPE_CAP_MASK_TSAR;
+	case SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT:
+		return MLX5_CAP_QOS(dev, esw_element_type) &
+		       ELEMENT_TYPE_CAP_MASK_VPORT;
+	case SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT_TC:
+		return MLX5_CAP_QOS(dev, esw_element_type) &
+		       ELEMENT_TYPE_CAP_MASK_VPORT_TC;
+	case SCHEDULING_CONTEXT_ELEMENT_TYPE_PARA_VPORT_TC:
+		return MLX5_CAP_QOS(dev, esw_element_type) &
+		       ELEMENT_TYPE_CAP_MASK_PARA_VPORT_TC;
+	}
+	return false;
+}
+
 static int esw_qos_vport_create_sched_element(struct mlx5_eswitch *esw,
 					      struct mlx5_vport *vport,
 					      u32 max_rate, u32 bw_share)
@@ -323,6 +342,9 @@ static int esw_qos_vport_create_sched_element(struct mlx5_eswitch *esw,
 	void *vport_elem;
 	int err;
 
+	if (!esw_qos_element_type_supported(dev, SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT))
+		return -EOPNOTSUPP;
+
 	parent_tsar_ix = group ? group->tsar_ix : esw->qos.root_tsar_ix;
 	MLX5_SET(scheduling_context, sched_ctx, element_type,
 		 SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT);
@@ -533,25 +555,6 @@ static int esw_qos_destroy_rate_group(struct mlx5_eswitch *esw,
 	return err;
 }
 
-static bool esw_qos_element_type_supported(struct mlx5_core_dev *dev, int type)
-{
-	switch (type) {
-	case SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR:
-		return MLX5_CAP_QOS(dev, esw_element_type) &
-		       ELEMENT_TYPE_CAP_MASK_TSAR;
-	case SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT:
-		return MLX5_CAP_QOS(dev, esw_element_type) &
-		       ELEMENT_TYPE_CAP_MASK_VPORT;
-	case SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT_TC:
-		return MLX5_CAP_QOS(dev, esw_element_type) &
-		       ELEMENT_TYPE_CAP_MASK_VPORT_TC;
-	case SCHEDULING_CONTEXT_ELEMENT_TYPE_PARA_VPORT_TC:
-		return MLX5_CAP_QOS(dev, esw_element_type) &
-		       ELEMENT_TYPE_CAP_MASK_PARA_VPORT_TC;
-	}
-	return false;
-}
-
 static int esw_qos_create(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
 {
 	u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
@@ -562,7 +565,8 @@ static int esw_qos_create(struct mlx5_eswitch *esw, struct netlink_ext_ack *exta
 	if (!MLX5_CAP_GEN(dev, qos) || !MLX5_CAP_QOS(dev, esw_scheduling))
 		return -EOPNOTSUPP;
 
-	if (!esw_qos_element_type_supported(dev, SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR))
+	if (!esw_qos_element_type_supported(dev, SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR) ||
+	    !(MLX5_CAP_QOS(dev, esw_tsar_type) & TSAR_TYPE_CAP_MASK_DWRR))
 		return -EOPNOTSUPP;
 
 	MLX5_SET(scheduling_context, tsar_ctx, element_type,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/qos.c
index 8bce730b5c5b..db2bd3ad63ba 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/qos.c
@@ -28,6 +28,9 @@ int mlx5_qos_create_leaf_node(struct mlx5_core_dev *mdev, u32 parent_id,
 {
 	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {0};
 
+	if (!(MLX5_CAP_QOS(mdev, nic_element_type) & ELEMENT_TYPE_CAP_MASK_QUEUE_GROUP))
+		return -EOPNOTSUPP;
+
 	MLX5_SET(scheduling_context, sched_ctx, parent_element_id, parent_id);
 	MLX5_SET(scheduling_context, sched_ctx, element_type,
 		 SCHEDULING_CONTEXT_ELEMENT_TYPE_QUEUE_GROUP);
@@ -44,6 +47,10 @@ int mlx5_qos_create_inner_node(struct mlx5_core_dev *mdev, u32 parent_id,
 	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {0};
 	void *attr;
 
+	if (!(MLX5_CAP_QOS(mdev, nic_element_type) & ELEMENT_TYPE_CAP_MASK_TSAR) ||
+	    !(MLX5_CAP_QOS(mdev, nic_tsar_type) & TSAR_TYPE_CAP_MASK_DWRR))
+		return -EOPNOTSUPP;
+
 	MLX5_SET(scheduling_context, sched_ctx, parent_element_id, parent_id);
 	MLX5_SET(scheduling_context, sched_ctx, element_type,
 		 SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR);
-- 
2.46.0


