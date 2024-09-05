Return-Path: <netdev+bounces-125386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D9796CF43
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 08:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C058C1C22D94
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 06:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F086819148F;
	Thu,  5 Sep 2024 06:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxmGUGfm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB1F190686
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 06:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725517688; cv=none; b=fD3ZmLVnXrxhxhI/teH4INsLWE7fOzGDA//2u3Nm0nuJi1ONciF3D+cpREBP5NEZoA1mrxDk1Xfmwu2p7vjRqFRg1gRPoUKdpZIhpnDTwoG7D3+xHOdwGgHdc6u9jlSJiKFc2LPnmCgUHLdJpZUP0VM3Negi4qSGEuzv2siMSoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725517688; c=relaxed/simple;
	bh=Kck1AqJAfrrUoldefvTkOAf0Wfo67hyzJWncTBseFRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJ0migLvY6MlC9r9EFu5IMXImfwemndMped4IJDLnpN+jGvjRJNg9+/7s8vncpqrcoTtbinjA/7eNhDykOoNwwUQ/GofGDoZQByWC6yWnTk6qmDBa93kON5JMNz9DbpM48q/xq11BRm+dt9Pp0MFS9VlopWlWmgvIvNa++axbcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxmGUGfm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B79C4CEC4;
	Thu,  5 Sep 2024 06:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725517688;
	bh=Kck1AqJAfrrUoldefvTkOAf0Wfo67hyzJWncTBseFRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BxmGUGfmuUBXv5VQ6l6t/mSngS4F0hvxBIMDq9MhRPQIk8Qw0tHMmUkh1wgycsy7l
	 U4Pi9gMA8HV/lXa44OOYSuLcl27YB6YGps3T4yQSYug2j8+bCgTyUWYtVftnIotO6n
	 75fmJk9bH85lt51UXyByxJAYSn8jKxwwReszQyiAo7OOQuK4M0JaAJ1xcMEx4zvjF4
	 lLIAM/Z53VFyS3uM6/oIb6W1TmwYmgf/jEUFMVvvT0XSIoIn8WX8pttAaDaMj5x+hN
	 LHn/Reg8V/iTWVCSUNEPTdU2y/QLtqJyF2cZxKClDPDsoc9bWk/6iCiextUfO+ZuvA
	 3d6LVDDg9lFQw==
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
Subject: [net-next V2 10/15] net/mlx5: HWS, added vport handling
Date: Wed,  4 Sep 2024 23:27:45 -0700
Message-ID: <20240905062752.10883-11-saeed@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905062752.10883-1-saeed@kernel.org>
References: <20240905062752.10883-1-saeed@kernel.org>
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


