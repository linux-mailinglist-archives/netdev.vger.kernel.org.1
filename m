Return-Path: <netdev+bounces-71927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEB985594D
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 04:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B87001F2C7BA
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 03:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D8E171CE;
	Thu, 15 Feb 2024 03:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHmjXDz7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B98171A7
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 03:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707966501; cv=none; b=qBVwR04Qf/mFaDmBKShgSkwTMAdUkMrKeAQ/hKWthovEfQsj6iJAuMIDkGTkna7o563mPy29diqwIEalvzr/S8kZZ+ITWgUDr5kS7nwerKIep16hFoHfwKtN+qN3mAwyqxFTttVn7NDUAt04CZ5CgexDDouiruKru+v5FJyd3cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707966501; c=relaxed/simple;
	bh=1J1Hrmr7kj4mwlZUoo6RowLhNLFh8tok6WYRe44EibE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICLIaUCjbdy5Pxj6L7JiSYQvXygfBBSc83b6vYGsiRMeE17TwllAwew0l/YzDWKBvjEYZTA5jd5vQqJP3xlmrLrPtsuazNDTOuzqkXWkvkZ4Vn5UoP7ssAKYusxw4fiHD3nnBsYSLc1D0QQUgWNEld/q5w5BqYavH5HDLsm6qiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHmjXDz7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A502C433B1;
	Thu, 15 Feb 2024 03:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707966501;
	bh=1J1Hrmr7kj4mwlZUoo6RowLhNLFh8tok6WYRe44EibE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dHmjXDz7qYZhat1+NqPaqbYbGGCGd8rNoCxJZfjpmv1stVI2uhvHn5Q0WN2gNucdj
	 9XM5OO9JTbBwaaG46/6pfjo4JM8ctv23yq/m9ZejB6/cvcVggSxwOzLTIopcFAYc5E
	 gFIEwlwfXbMqmbipzzMUKINpS3Z9yWBPiNqQiMSdk0uTN5J1wChiz4UMN3eNbI4b/j
	 7ncxpWavw8QFdfGpBod+IjR1364fDnCbtkXDSIvAYfPLB1q8oi1aX0wlJOs4duEOV8
	 oVP0Echyw076OGDFkxBGZWYwKAnq/GaHd+80TQsabiMSas4ZmLS+xbfT7R32H9tl+u
	 t26hAg6qsdW4g==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [net-next V3 02/15] net/mlx5: SD, Introduce SD lib
Date: Wed, 14 Feb 2024 19:08:01 -0800
Message-ID: <20240215030814.451812-3-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215030814.451812-1-saeed@kernel.org>
References: <20240215030814.451812-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tariq Toukan <tariqt@nvidia.com>

Add Socket-Direct API with empty/minimal implementation.
We fill-in the implementation gradually in downstream patches.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/Makefile  |  2 +-
 .../ethernet/mellanox/mlx5/core/lib/mlx5.h    | 11 ++++
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 60 +++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/lib/sd.h  | 38 ++++++++++++
 4 files changed, 110 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index c44870b175f9..76dc5a9b9648 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -29,7 +29,7 @@ mlx5_core-$(CONFIG_MLX5_CORE_EN) += en/rqt.o en/tir.o en/rss.o en/rx_res.o \
 		en/reporter_tx.o en/reporter_rx.o en/params.o en/xsk/pool.o \
 		en/xsk/setup.o en/xsk/rx.o en/xsk/tx.o en/devlink.o en/ptp.o \
 		en/qos.o en/htb.o en/trap.o en/fs_tt_redirect.o en/selq.o \
-		lib/crypto.o
+		lib/crypto.o lib/sd.o
 
 #
 # Netdev extra
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h
index 2b5826a785c4..0810b92b48d0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h
@@ -54,4 +54,15 @@ static inline struct net_device *mlx5_uplink_netdev_get(struct mlx5_core_dev *md
 {
 	return mdev->mlx5e_res.uplink_netdev;
 }
+
+struct mlx5_sd;
+
+static inline struct mlx5_sd *mlx5_get_sd(struct mlx5_core_dev *dev)
+{
+	return NULL;
+}
+
+static inline void mlx5_set_sd(struct mlx5_core_dev *dev, struct mlx5_sd *sd)
+{
+}
 #endif
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
new file mode 100644
index 000000000000..ea37238c4519
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#include "lib/sd.h"
+#include "mlx5_core.h"
+
+#define sd_info(__dev, format, ...) \
+	dev_info((__dev)->device, "Socket-Direct: " format, ##__VA_ARGS__)
+#define sd_warn(__dev, format, ...) \
+	dev_warn((__dev)->device, "Socket-Direct: " format, ##__VA_ARGS__)
+
+struct mlx5_sd {
+};
+
+static int mlx5_sd_get_host_buses(struct mlx5_core_dev *dev)
+{
+	return 1;
+}
+
+struct mlx5_core_dev *
+mlx5_sd_primary_get_peer(struct mlx5_core_dev *primary, int idx)
+{
+	if (idx == 0)
+		return primary;
+
+	return NULL;
+}
+
+int mlx5_sd_ch_ix_get_dev_ix(struct mlx5_core_dev *dev, int ch_ix)
+{
+	return ch_ix % mlx5_sd_get_host_buses(dev);
+}
+
+int mlx5_sd_ch_ix_get_vec_ix(struct mlx5_core_dev *dev, int ch_ix)
+{
+	return ch_ix / mlx5_sd_get_host_buses(dev);
+}
+
+struct mlx5_core_dev *mlx5_sd_ch_ix_get_dev(struct mlx5_core_dev *primary, int ch_ix)
+{
+	int mdev_idx = mlx5_sd_ch_ix_get_dev_ix(primary, ch_ix);
+
+	return mlx5_sd_primary_get_peer(primary, mdev_idx);
+}
+
+int mlx5_sd_init(struct mlx5_core_dev *dev)
+{
+	return 0;
+}
+
+void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
+{
+}
+
+struct auxiliary_device *mlx5_sd_get_adev(struct mlx5_core_dev *dev,
+					  struct auxiliary_device *adev,
+					  int idx)
+{
+	return adev;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
new file mode 100644
index 000000000000..137efaf9aabc
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#ifndef __MLX5_LIB_SD_H__
+#define __MLX5_LIB_SD_H__
+
+#define MLX5_SD_MAX_GROUP_SZ 2
+
+struct mlx5_sd;
+
+struct mlx5_core_dev *mlx5_sd_primary_get_peer(struct mlx5_core_dev *primary, int idx);
+int mlx5_sd_ch_ix_get_dev_ix(struct mlx5_core_dev *dev, int ch_ix);
+int mlx5_sd_ch_ix_get_vec_ix(struct mlx5_core_dev *dev, int ch_ix);
+struct mlx5_core_dev *mlx5_sd_ch_ix_get_dev(struct mlx5_core_dev *primary, int ch_ix);
+struct auxiliary_device *mlx5_sd_get_adev(struct mlx5_core_dev *dev,
+					  struct auxiliary_device *adev,
+					  int idx);
+
+int mlx5_sd_init(struct mlx5_core_dev *dev);
+void mlx5_sd_cleanup(struct mlx5_core_dev *dev);
+
+#define mlx5_sd_for_each_dev_from_to(i, primary, ix_from, to, pos)	\
+	for (i = ix_from;							\
+	     (pos = mlx5_sd_primary_get_peer(primary, i)) && pos != (to); i++)
+
+#define mlx5_sd_for_each_dev(i, primary, pos)				\
+	mlx5_sd_for_each_dev_from_to(i, primary, 0, NULL, pos)
+
+#define mlx5_sd_for_each_dev_to(i, primary, to, pos)			\
+	mlx5_sd_for_each_dev_from_to(i, primary, 0, to, pos)
+
+#define mlx5_sd_for_each_secondary(i, primary, pos)			\
+	mlx5_sd_for_each_dev_from_to(i, primary, 1, NULL, pos)
+
+#define mlx5_sd_for_each_secondary_to(i, primary, to, pos)		\
+	mlx5_sd_for_each_dev_from_to(i, primary, 1, to, pos)
+
+#endif /* __MLX5_LIB_SD_H__ */
-- 
2.43.0


