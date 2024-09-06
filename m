Return-Path: <netdev+bounces-126084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5055D96FD99
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 23:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3C5A1F23470
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 21:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EB815B55D;
	Fri,  6 Sep 2024 21:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRKzF3nh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BB115990C
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 21:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725659668; cv=none; b=XllQsZzAJZbKXz3DwwObuwJAh+SzKeY1tEu8wKuDwFhIOfsNuFGOPjQHnZiS3dHX6aCt4rgOm6ixxXKShdFKFP7py9TfU8lmp7gRBRzx7z1tUpUy3CvqiM7V9VgkL6dXAIM4qxjJg1Qvjx9ybvVrOcQHRinFGE5iDZ41Mji7tnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725659668; c=relaxed/simple;
	bh=Kck1AqJAfrrUoldefvTkOAf0Wfo67hyzJWncTBseFRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aC1sPlzYrcIfxNpb9i0INd+rb5z9/L+uU57o1ge0SaS4zdhelz3heCbCMPHx1zqMKDukPS7QK9/ERYu7rvFR0wC0hKi+AnKdpe2mnxFtFSHJnNY/keyhMAGjIgQA2D94hBTRLltMTluXR5Zh73qY0zFjchMgkY81q1AEO/2xK8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRKzF3nh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35012C4CECA;
	Fri,  6 Sep 2024 21:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725659668;
	bh=Kck1AqJAfrrUoldefvTkOAf0Wfo67hyzJWncTBseFRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HRKzF3nhc7Nn9S5A5x6qOKwtCiaedt1WARRV5tOQXigJAlFLBYZr7+KYECBfxFkKQ
	 6jIFaL3LVS48SRjMHnzJiYpwAUP8ENCqHhyFmnJf4ifjX2UVYVooCZjpgAYamlejYW
	 SzZUmUVjDMomkS3taZ2/eKOTlCz9JFaHQvkEp//LqdGT5egfzv1PWiAmZwPOIkKzU+
	 ehhz7QoskE2Jpz4pmp7e+t5/xt3KGq0D0OReDObj4LIMOjL3S4lkdwHMHmH4K3rOsb
	 ubIxDu0Vjf0LPZt7Xfqb8e+yZW+x89l8zT5SrbGmZfeVK3clIVXgGDVTBjGoxRyXxR
	 BvVYriZHypayA==
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
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Hamdan Agbariya <hamdani@nvidia.com>
Subject: [net-next V3 10/15] net/mlx5: HWS, added vport handling
Date: Fri,  6 Sep 2024 14:54:05 -0700
Message-ID: <20240906215411.18770-11-saeed@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240906215411.18770-1-saeed@kernel.org>
References: <20240906215411.18770-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Vport is a virtual eswitch port that is associated with its virtual
function (VF), physical function (PF) or sub-function (SF).
This patch adds handling of vports in HWS.

Reviewed-by: Hamdan Agbariya <hamdani@nvidia.com>
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mlx5/core/steering/hws/mlx5hws_vport.c    | 86 +++++++++++++++++++
 .../mlx5/core/steering/hws/mlx5hws_vport.h    | 13 +++
 2 files changed, 99 insertions(+)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_vport.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_vport.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_vport.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_vport.c
new file mode 100644
index 000000000000..faf42421c43f
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_vport.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2024 NVIDIA Corporation & Affiliates */
+
+#include "mlx5hws_internal.h"
+
+int mlx5hws_vport_init_vports(struct mlx5hws_context *ctx)
+{
+	int ret;
+
+	if (!ctx->caps->eswitch_manager)
+		return 0;
+
+	xa_init(&ctx->vports.vport_gvmi_xa);
+
+	/* Set gvmi for eswitch manager and uplink vports only. Rest of the vports
+	 * (vport 0 of other function, VFs and SFs) will be queried dynamically.
+	 */
+
+	ret = mlx5hws_cmd_query_gvmi(ctx->mdev, false, 0, &ctx->vports.esw_manager_gvmi);
+	if (ret)
+		return ret;
+
+	ctx->vports.uplink_gvmi = 0;
+	return 0;
+}
+
+void mlx5hws_vport_uninit_vports(struct mlx5hws_context *ctx)
+{
+	if (ctx->caps->eswitch_manager)
+		xa_destroy(&ctx->vports.vport_gvmi_xa);
+}
+
+static int hws_vport_add_gvmi(struct mlx5hws_context *ctx, u16 vport)
+{
+	u16 vport_gvmi;
+	int ret;
+
+	ret = mlx5hws_cmd_query_gvmi(ctx->mdev, true, vport, &vport_gvmi);
+	if (ret)
+		return -EINVAL;
+
+	ret = xa_insert(&ctx->vports.vport_gvmi_xa, vport,
+			xa_mk_value(vport_gvmi), GFP_KERNEL);
+	if (ret)
+		mlx5hws_dbg(ctx, "Couldn't insert new vport gvmi into xarray (%d)\n", ret);
+
+	return ret;
+}
+
+static bool hws_vport_is_esw_mgr_vport(struct mlx5hws_context *ctx, u16 vport)
+{
+	return ctx->caps->is_ecpf ? vport == MLX5_VPORT_ECPF :
+				    vport == MLX5_VPORT_PF;
+}
+
+int mlx5hws_vport_get_gvmi(struct mlx5hws_context *ctx, u16 vport, u16 *vport_gvmi)
+{
+	void *entry;
+	int ret;
+
+	if (!ctx->caps->eswitch_manager)
+		return -EINVAL;
+
+	if (hws_vport_is_esw_mgr_vport(ctx, vport)) {
+		*vport_gvmi = ctx->vports.esw_manager_gvmi;
+		return 0;
+	}
+
+	if (vport == MLX5_VPORT_UPLINK) {
+		*vport_gvmi = ctx->vports.uplink_gvmi;
+		return 0;
+	}
+
+load_entry:
+	entry = xa_load(&ctx->vports.vport_gvmi_xa, vport);
+
+	if (!xa_is_value(entry)) {
+		ret = hws_vport_add_gvmi(ctx, vport);
+		if (ret && ret != -EBUSY)
+			return ret;
+		goto load_entry;
+	}
+
+	*vport_gvmi = (u16)xa_to_value(entry);
+	return 0;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_vport.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_vport.h
new file mode 100644
index 000000000000..0912fc166b3a
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_vport.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2024 NVIDIA Corporation & Affiliates */
+
+#ifndef MLX5HWS_VPORT_H_
+#define MLX5HWS_VPORT_H_
+
+int mlx5hws_vport_init_vports(struct mlx5hws_context *ctx);
+
+void mlx5hws_vport_uninit_vports(struct mlx5hws_context *ctx);
+
+int mlx5hws_vport_get_gvmi(struct mlx5hws_context *ctx, u16 vport, u16 *vport_gvmi);
+
+#endif /* MLX5HWS_VPORT_H_ */
-- 
2.46.0


