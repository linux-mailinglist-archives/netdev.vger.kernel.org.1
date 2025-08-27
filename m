Return-Path: <netdev+bounces-217146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0D4B37938
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 06:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31567365300
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 04:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2692D46B7;
	Wed, 27 Aug 2025 04:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XE1TUkvp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EBA2D3EDF
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 04:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756269931; cv=none; b=G/Z/ez3mKXoXq+EEMwa8Dpxg+sGvYIIw/eTfMHBqGrgm1j/a7odTXMuYQjhvUivKEFHoT9c+UFcRrMUHlQ6VsVXlRNe04HR2Y8+2REfgvoSF/qhUdE0jZCmJCndWm88qWePN+SrlNv75/U8TMnHAg13jLoOL+phS+F9YnMjsW74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756269931; c=relaxed/simple;
	bh=xSG1oa3KG8kyPnfK83B37lCTsUU4uXDIm4YSc0euF04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N1t6TrJUXmiUCuqtbLq6Jp5E/WlILfXx6VsZwiYmBQ9+m3MlauOWxeZF5mlwTcVYdJr1V+UcVkF1vXXsmeQUypvNxA3fp3CQZVA/EPSsB5vO0XIoXPghh4Pwd3xSu/c7O3ML5DNbb5WAdeikbpmiRATFsOIRFLdwWEAFl+NFXTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XE1TUkvp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FB6C4CEEB;
	Wed, 27 Aug 2025 04:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756269930;
	bh=xSG1oa3KG8kyPnfK83B37lCTsUU4uXDIm4YSc0euF04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XE1TUkvpsSTZGcGfo95dnErR/IlVUYKtSpCVJl0hBXQ+bC68cwvk+/rUYsSUYz9wD
	 nHUItVlmlbyg8+OhzJHt7Y71WiIPK3jINXoiN3XQWH3Gx81y8/Yvi3g6IH+SfYgdX/
	 5sQ9Li+BQgQOANsRqijrcEi9sr7y83MTIKX/ufKFoTAGbrmVtDoQCzxUGRyWG+7NJM
	 jzcNOvUnCo2MpRJnBtX9MG0rJgFAt+QAhir0RWGId7IhuOy0Zc0k6MCzGu5KtTlFgn
	 fakNKDvP/r5VYWyTrvrYmrva1GOue0a3BE4AeH1FQyfJItTZU0x0JPGBWtQBZUqY44
	 edjnMyOixGXTw==
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
	mbloch@nvidia.com
Subject: [PATCH net-next V2 4/7] net/mlx5: E-Switch, Create acls root namespace for adjacent vports
Date: Tue, 26 Aug 2025 21:45:13 -0700
Message-ID: <20250827044516.275267-5-saeed@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827044516.275267-1-saeed@kernel.org>
References: <20250827044516.275267-1-saeed@kernel.org>
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


