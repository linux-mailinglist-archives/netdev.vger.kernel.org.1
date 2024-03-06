Return-Path: <netdev+bounces-77742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 392D0872D28
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 04:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29F341C225F0
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 03:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD3212E63;
	Wed,  6 Mar 2024 03:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGPof6tF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8952A125DB
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 03:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709694187; cv=none; b=dq/AK9oRYPl3q+/dbdUAZjeMV/byoK/CXDqEFSEc0llYpx6cIV0ejdu4lh081MXiSZIM6v0txbgx7eomy6VXKqq6NRG8aU0vXYhkaiRG9TJIm8MM6Zlv4PAZWeQYZAa2fr983HyQ1T74zUtWT5rFidbAobjLa7pQjGycsJSFL7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709694187; c=relaxed/simple;
	bh=D+2JMSBGEOcyh7ueOqGd4kUbJYph9bV85fjNxCZ40gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hV3FI9fwkk8UFt9w2MzuBUa5kFlw3f4Q6f9NuwSi8Ug44SnrmwGuhLgOP8Pna4FMVcxYwgC+fITwQ+y2q0EPaYEfuIQ/CW+LKr5RcAkGIlBhTDRNg3NcpJ0N9nhPkPWx6sjFuBqUEZAo19IYjZILbBuX/m10yw6duqReOsEhqp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGPof6tF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A37C433C7;
	Wed,  6 Mar 2024 03:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709694187;
	bh=D+2JMSBGEOcyh7ueOqGd4kUbJYph9bV85fjNxCZ40gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EGPof6tF0tjFJLMGL9VMdSVAYIPGnL4pMgs/wbvCuuRze57wao5aatr9gQ4XQYhmm
	 owMioIep9tA7yHGsDbQ+h+ER5pRUds2VkTt7FYGGS7CpSrsLymOagDscLoi1uw0/Uf
	 Uzrr4F0r21nDHrXbGDgcMO6EZf1CbJDmVyH5LzqMTqwfk0yUBXLZJ5jBIUkp58v/m4
	 SrJhDTGy6FSiOCFxz8k7HctYctINfdHRLn+iY/klPxqKE2HmLLp9X2ibOemIQlU64s
	 siRCXxZ6O06kBvV0B9WU18jc1Ut9S1UzGzxlw2+PXjPwltl4x7xyS7OroQrLNL/Wvh
	 EVtFgoSe8hY4Q==
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
Subject: [net-next V5 02/15] net/mlx5: SD, Introduce SD lib
Date: Tue,  5 Mar 2024 19:02:45 -0800
Message-ID: <20240306030258.16874-3-saeed@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240306030258.16874-1-saeed@kernel.org>
References: <20240306030258.16874-1-saeed@kernel.org>
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
2.44.0


