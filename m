Return-Path: <netdev+bounces-218408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC45AB3C50E
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 00:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B82B71BA3714
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 22:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AD52D97B7;
	Fri, 29 Aug 2025 22:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3l8BNlS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B262D2D97A1
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 22:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756507057; cv=none; b=i6/xGDmKXGWkb+Yn1q0SR1MmOUb1g2Zb5SU3q5F8FKx0py6JANIt1ff42q5zpwMq1VnjCGmDGP/OlFbPvyULiQ80dc9Lnc2KjhvHsRcu9kbfKlm4dmOFJxBdp6J/5Bk3y17yXjCAmLjIq8J8URcZsrSKfuXo1R8riRd9nplhsFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756507057; c=relaxed/simple;
	bh=fe1xV8VRGSruyfKO7mBmTk8Ctv+WBwa/ngDnm5xHUcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rx8qmywklM+ah++G3DjmSNUYQ0Mva0d/9QZYAPNtgQ7YZm0an667ZwDXN05UxiuMP4Jasnyz53dbhcWonJFlsFPm36cQ8TpHPtrDbTeZ/+x6yOxU1INS6zT+2I6GdMH4iEBYG6G8IiEzKLhnpx8V9zhqS//DJOuyQrdA+jdnUfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3l8BNlS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436E5C4CEF1;
	Fri, 29 Aug 2025 22:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756507057;
	bh=fe1xV8VRGSruyfKO7mBmTk8Ctv+WBwa/ngDnm5xHUcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V3l8BNlSXDEDVYeMTkLwZBkfOAUPKEg64KVbRaWQQp4i/1kLGj/mXNlb9Cm8zUqs5
	 kkqDYOXV8p7Szqa1J4Cu1Ka0LqKVtnuoXVB30tY+yrFbSxYR6hkQIQrRns5Qk4VWno
	 MhJg+k+UukYpiIjs9PSCkLt94GrYu1kpIDRK05xGHynAH/9N5xE3oBS7BkIqk8nnFA
	 oaCIZ0Fye+GFhLaNGBbxTfre4UEPjUK/kZVnpa+IqKKQDXmI6xWCavLJDyLUUkA3cn
	 dEtdd6OFeu50jYO0eWSUVGQ4+jz0p1mZy0DLbG0dR22WdF/9S8tAGPlkeEJPgb5+k6
	 IPGGO2f9Yf0MA==
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
	mbloch@nvidia.com,
	horms@kernel.org
Subject: [PATCH net-next V3 5/7] net/mlx5: E-Switch, Register representors for adjacent vports
Date: Fri, 29 Aug 2025 15:37:20 -0700
Message-ID: <20250829223722.900629-6-saeed@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250829223722.900629-1-saeed@kernel.org>
References: <20250829223722.900629-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

Register representors for adjacent vports dynamically when they are
discovered. Dynamically added representors state will now be set to
'REGISTERED' when the representor type was already registered,
otherwise they won't be loaded.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 .../mellanox/mlx5/core/esw/adj_vport.c        | 10 ++++++
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  5 +++
 .../mellanox/mlx5/core/eswitch_offloads.c     | 33 ++++++++++++++++---
 3 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/adj_vport.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/adj_vport.c
index 1d104b3fe9e0..3380f85678bc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/adj_vport.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/adj_vport.c
@@ -85,10 +85,19 @@ static int mlx5_esw_adj_vport_create(struct mlx5_eswitch *esw, u16 vhca_id)
 
 	mlx5_fs_vport_egress_acl_ns_add(esw->dev->priv.steering, vport->index);
 	mlx5_fs_vport_ingress_acl_ns_add(esw->dev->priv.steering, vport->index);
+	err = mlx5_esw_offloads_rep_add(esw, vport);
+	if (err)
+		goto acl_ns_remove;
 
 	mlx5_esw_adj_vport_modify(esw->dev, vport_num, MLX5_ADJ_VPORT_CONNECT);
 	return 0;
 
+acl_ns_remove:
+	mlx5_fs_vport_ingress_acl_ns_remove(esw->dev->priv.steering,
+					    vport->index);
+	mlx5_fs_vport_egress_acl_ns_remove(esw->dev->priv.steering,
+					   vport->index);
+	mlx5_esw_vport_free(esw, vport);
 destroy_esw_vport:
 	mlx5_esw_destroy_esw_vport(esw->dev, vport_num);
 	return err;
@@ -103,6 +112,7 @@ static void mlx5_esw_adj_vport_destroy(struct mlx5_eswitch *esw,
 		  vport_num, vport->vhca_id);
 	mlx5_esw_adj_vport_modify(esw->dev, vport_num,
 				  MLX5_ADJ_VPORT_DISCONNECT);
+	mlx5_esw_offloads_rep_remove(esw, vport);
 	mlx5_fs_vport_egress_acl_ns_remove(esw->dev->priv.steering,
 					   vport->index);
 	mlx5_fs_vport_ingress_acl_ns_remove(esw->dev->priv.steering,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 2c0e5ca73f3d..6d36d8bbb979 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -838,6 +838,11 @@ void mlx5_esw_vport_vhca_id_unmap(struct mlx5_eswitch *esw,
 int mlx5_eswitch_vhca_id_to_vport(struct mlx5_eswitch *esw, u16 vhca_id, u16 *vport_num);
 bool mlx5_esw_vport_vhca_id(struct mlx5_eswitch *esw, u16 vportn, u16 *vhca_id);
 
+void mlx5_esw_offloads_rep_remove(struct mlx5_eswitch *esw,
+				  const struct mlx5_vport *vport);
+int mlx5_esw_offloads_rep_add(struct mlx5_eswitch *esw,
+			      const struct mlx5_vport *vport);
+
 /**
  * struct mlx5_esw_event_info - Indicates eswitch mode changed/changing.
  *
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index fb03981d5036..d57f86d297ab 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2378,7 +2378,20 @@ static int esw_offloads_start(struct mlx5_eswitch *esw,
 	return 0;
 }
 
-static int mlx5_esw_offloads_rep_init(struct mlx5_eswitch *esw, const struct mlx5_vport *vport)
+void mlx5_esw_offloads_rep_remove(struct mlx5_eswitch *esw,
+				  const struct mlx5_vport *vport)
+{
+	struct mlx5_eswitch_rep *rep = xa_load(&esw->offloads.vport_reps,
+					       vport->vport);
+
+	if (!rep)
+		return;
+	xa_erase(&esw->offloads.vport_reps, vport->vport);
+	kfree(rep);
+}
+
+int mlx5_esw_offloads_rep_add(struct mlx5_eswitch *esw,
+			      const struct mlx5_vport *vport)
 {
 	struct mlx5_eswitch_rep *rep;
 	int rep_type;
@@ -2390,9 +2403,19 @@ static int mlx5_esw_offloads_rep_init(struct mlx5_eswitch *esw, const struct mlx
 
 	rep->vport = vport->vport;
 	rep->vport_index = vport->index;
-	for (rep_type = 0; rep_type < NUM_REP_TYPES; rep_type++)
-		atomic_set(&rep->rep_data[rep_type].state, REP_UNREGISTERED);
-
+	for (rep_type = 0; rep_type < NUM_REP_TYPES; rep_type++) {
+		if (!esw->offloads.rep_ops[rep_type]) {
+			atomic_set(&rep->rep_data[rep_type].state,
+				   REP_UNREGISTERED);
+			continue;
+		}
+		/* Dynamic/delegated vports add their representors after
+		 * mlx5_eswitch_register_vport_reps, so mark them as registered
+		 * for them to be loaded later with the others.
+		 */
+		rep->esw = esw;
+		atomic_set(&rep->rep_data[rep_type].state, REP_REGISTERED);
+	}
 	err = xa_insert(&esw->offloads.vport_reps, rep->vport, rep, GFP_KERNEL);
 	if (err)
 		goto insert_err;
@@ -2430,7 +2453,7 @@ static int esw_offloads_init_reps(struct mlx5_eswitch *esw)
 	xa_init(&esw->offloads.vport_reps);
 
 	mlx5_esw_for_each_vport(esw, i, vport) {
-		err = mlx5_esw_offloads_rep_init(esw, vport);
+		err = mlx5_esw_offloads_rep_add(esw, vport);
 		if (err)
 			goto err;
 	}
-- 
2.50.1


