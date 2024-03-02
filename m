Return-Path: <netdev+bounces-76798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB19386EF16
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 08:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA25286102
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 07:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0C812B80;
	Sat,  2 Mar 2024 07:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ffzp9YLP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CAF12B7D
	for <netdev@vger.kernel.org>; Sat,  2 Mar 2024 07:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709364198; cv=none; b=JU8wEJ6te6GOyuMoo3GUEeY5DI/dzQR6mTW8NlNzkSaE7B6hHokmH9Gtot5rR69uRbcYrI+6HsvgoSjoWAqLtUHmM7jydo6hNra1165ajKd0I06kh7LCTGyM8I+F8D5DgPw5SRL/2iaARRrmnjRFvhcfOWLjzr6ByI4TMJVrCPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709364198; c=relaxed/simple;
	bh=D+2JMSBGEOcyh7ueOqGd4kUbJYph9bV85fjNxCZ40gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2n3Z99wf0sM+/5bdB7NlNlsdBHF12pgQnGRpu5oPdX8VmYWzXyq0dJVvTF0WxYLK/25IC7nINj5tiVS3CzoK35cpIyAA1CV6w2cO9LF+e7w7NiyKgQSF+XekX1+LrvPhzd8ehdR398KblypCRuywf7JR0gR7Ng/IXnrKspxh5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ffzp9YLP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43972C433C7;
	Sat,  2 Mar 2024 07:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709364198;
	bh=D+2JMSBGEOcyh7ueOqGd4kUbJYph9bV85fjNxCZ40gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ffzp9YLP/SIQ/bCbvq6e+GGa2ZrjXain0Z367PzsKj35pOwGPzbseBbaHneavM2ve
	 tD3oMD0SXSeFXiOPr5lL4SuFz5acFDisvQ4gl7MgCk+4bFgjCCWFZDU2peXOP+pdMB
	 QcU6R7Ku77Yc5QEWH4pn6H32xA1hgNuE4bzmQuU9c0cWEbETfKjFz6bgQkSbOVvT14
	 CzfUgDUPDJbpOUVHpjjcybEbiRbygGsLS/3KeHH7wDcsxNGP4t0khTi/J93mCIHFH1
	 yjW9PizqM+iJtvnP3ttJd411W+zEogLGhQ3n+St8F1YmvHttkDnzb41AjAGDuSXBDu
	 JqEpQVGLg54FA==
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
	sridhar.samudrala@intel.com,
	Jay Vosburgh <jay.vosburgh@canonical.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [net-next V4 02/15] net/mlx5: SD, Introduce SD lib
Date: Fri,  1 Mar 2024 23:22:32 -0800
Message-ID: <20240302072246.67920-3-saeed@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240302072246.67920-1-saeed@kernel.org>
References: <20240302072246.67920-1-saeed@kernel.org>
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


