Return-Path: <netdev+bounces-218407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB1CB3C50D
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 00:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A5B51BA5999
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 22:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA2D2D94BB;
	Fri, 29 Aug 2025 22:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzOFMruT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01A42D94A5
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 22:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756507057; cv=none; b=NAMsFtt5ufJeiykNKJwWEEkn7hWDXLwgZKE6JQzguKpE0o0HVjYHn9KtF7tBR3+lwiWzbxmQPTQGuxZ49daZ6sdqnCqEm6FJL2QJNprwTOP8BspRO3gZ1oDW9kIhr4aQDyBQJkC0yR8llI7Uj7WagC9Jwf9sBNgQ55U8ssVnAjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756507057; c=relaxed/simple;
	bh=XVv8m9NaJXqHRBT68tDIVgkKeUNHnArlTB1rS4i3PHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g9OWzAqGKfVO1BP4fqxpCMBaHcLavsuz49g5NWvo+bUHM/GVXVkInB/U0jMV8Ciu0F0D8JHD9s5X7ai04Y4voUfXXyUs+pmev7dQYy+XV+ID/g6iDvdk4woVLs3cO0pIfdu3Q4v78HE85k/yKqxndfFaz5PNOONiGgEcw3EZSvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzOFMruT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73937C4CEF0;
	Fri, 29 Aug 2025 22:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756507056;
	bh=XVv8m9NaJXqHRBT68tDIVgkKeUNHnArlTB1rS4i3PHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MzOFMruTHMufUlf6ysaq7XHgWLct7V1dMHpUeP80WmgEt4BojgBNgNr3rc5pQ+zoi
	 cuo1cwNDPzC+NhD+05awcC+I6VLxp7VLkoD4XWDxlq2Zj+TC57hLnR5ZT7Qv22uSU+
	 ZdAMlrzcdo9GhdxUIs9IdQ5bsXAIfeaTbBouXMDYJyKIGoPA7ibhlxxJOTNcD/zy5U
	 xkCznyrFODY+Rdr8jhS23XDnXwWnz6vx7S8jUQX5Wy5pypW5D3IcEDBXmegO4QRsVA
	 LhwG58UOhWvS2mJkGuMpnatwlOTasLahsojnj962WaIW5L0iZw2/p51BRvnjemjJEF
	 Mylp26pZG+weQ==
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
Subject: [PATCH net-next V3 4/7] net/mlx5: E-Switch, Create acls root namespace for adjacent vports
Date: Fri, 29 Aug 2025 15:37:19 -0700
Message-ID: <20250829223722.900629-5-saeed@kernel.org>
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

Use the new vport acl root namespace add/remove API to create the
missing acl root name spaces per each new adjacent function vport.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/adj_vport.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/adj_vport.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/adj_vport.c
index 37a06c0949d5..1d104b3fe9e0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/adj_vport.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/adj_vport.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 // Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 
+#include "fs_core.h"
 #include "eswitch.h"
 
 enum {
@@ -82,6 +83,9 @@ static int mlx5_esw_adj_vport_create(struct mlx5_eswitch *esw, u16 vhca_id)
 	vport->adjacent = true;
 	vport->vhca_id = vhca_id;
 
+	mlx5_fs_vport_egress_acl_ns_add(esw->dev->priv.steering, vport->index);
+	mlx5_fs_vport_ingress_acl_ns_add(esw->dev->priv.steering, vport->index);
+
 	mlx5_esw_adj_vport_modify(esw->dev, vport_num, MLX5_ADJ_VPORT_CONNECT);
 	return 0;
 
@@ -99,6 +103,10 @@ static void mlx5_esw_adj_vport_destroy(struct mlx5_eswitch *esw,
 		  vport_num, vport->vhca_id);
 	mlx5_esw_adj_vport_modify(esw->dev, vport_num,
 				  MLX5_ADJ_VPORT_DISCONNECT);
+	mlx5_fs_vport_egress_acl_ns_remove(esw->dev->priv.steering,
+					   vport->index);
+	mlx5_fs_vport_ingress_acl_ns_remove(esw->dev->priv.steering,
+					    vport->index);
 	mlx5_esw_vport_free(esw, vport);
 	/* Reset the vport index back so new adj vports can use this index.
 	 * When vport count can incrementally change, this needs to be modified.
-- 
2.50.1


