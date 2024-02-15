Return-Path: <netdev+bounces-71928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F18F085594E
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 04:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762061F2C931
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 03:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CA1CA4A;
	Thu, 15 Feb 2024 03:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRJGfP7j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A21175BC
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 03:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707966503; cv=none; b=GjShAA99qVacaiQsNQSXL3vqcvXKd3FSqcTUxaUSkkYUaDbXPEms1WRKLilo+PV5pO0ioz0+GKmg2bgn1VVPkryOaHQ04ci1TcLyJa2MqRH03pVhQw5qKMUefaFFon1pHIrE1+AB2gJDsQwj7MgoczaM1bymBMQ9SVNLuj7+Dx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707966503; c=relaxed/simple;
	bh=Wrb/NVxUr5BqLMjMCXvH/jmxv/YWdcsuXCpA68TWWa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=isjPVWhGcDBJTw7i5cqtmuyMkTACrSS02hL9pFcFG2ema8sxTHdN8qFXMaYaORz+xGXF0OC9M6TSsAEoDvklgb/nh2s0O4vlvf6kZWlTK5vsi91QN07MlStlRg7F7jZkaiYWb7TTgr9w9edhnx0nge4JpCBa7GENDCbUMR5/MEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRJGfP7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6170AC43390;
	Thu, 15 Feb 2024 03:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707966502;
	bh=Wrb/NVxUr5BqLMjMCXvH/jmxv/YWdcsuXCpA68TWWa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YRJGfP7jkvtdHHHSWm9NIZ74eK6aw5L+iPIiovQ3ryZyfmsabM3qr9aq/aYg7ULga
	 NX7ZNCWbqLR6YOJRZdhNH7lwozznYUARyw99mL17UDpPoOmBKgZK9C/96dVkAVCoXf
	 3ZkwA2rWhsf9WYGbADwlw6R+sp9Q3G9BrJErH7Nm40I87ZGlnCbUSbryn+MJ98lCti
	 4F7h+FvlAIfjKoHt2EfORlroSBPCyBcQdOspiug5Ag/Q0xpiLZpkHRCKd9XRBNWYvY
	 h/mHzpmslNmxvt+z7LbBNwnoFvSGKFO8XCO2593BPlfMCr88wL6hyc8KEWDaP0fgXo
	 tR2jW1iXmF7sA==
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
Subject: [net-next V3 03/15] net/mlx5: SD, Implement basic query and instantiation
Date: Wed, 14 Feb 2024 19:08:02 -0800
Message-ID: <20240215030814.451812-4-saeed@kernel.org>
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

Add implementation for querying the MPIR register for Socket-Direct
attributes, and instantiating a SD struct accordingly.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 110 +++++++++++++++++-
 1 file changed, 109 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index ea37238c4519..b1f86549af1c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -3,6 +3,8 @@
 
 #include "lib/sd.h"
 #include "mlx5_core.h"
+#include "lib/mlx5.h"
+#include <linux/mlx5/vport.h>
 
 #define sd_info(__dev, format, ...) \
 	dev_info((__dev)->device, "Socket-Direct: " format, ##__VA_ARGS__)
@@ -10,11 +12,18 @@
 	dev_warn((__dev)->device, "Socket-Direct: " format, ##__VA_ARGS__)
 
 struct mlx5_sd {
+	u32 group_id;
+	u8 host_buses;
 };
 
 static int mlx5_sd_get_host_buses(struct mlx5_core_dev *dev)
 {
-	return 1;
+	struct mlx5_sd *sd = mlx5_get_sd(dev);
+
+	if (!sd)
+		return 1;
+
+	return sd->host_buses;
 }
 
 struct mlx5_core_dev *
@@ -43,13 +52,112 @@ struct mlx5_core_dev *mlx5_sd_ch_ix_get_dev(struct mlx5_core_dev *primary, int c
 	return mlx5_sd_primary_get_peer(primary, mdev_idx);
 }
 
+static bool mlx5_sd_is_supported(struct mlx5_core_dev *dev, u8 host_buses)
+{
+	/* Feature is currently implemented for PFs only */
+	if (!mlx5_core_is_pf(dev))
+		return false;
+
+	/* Honor the SW implementation limit */
+	if (host_buses > MLX5_SD_MAX_GROUP_SZ)
+		return false;
+
+	return true;
+}
+
+static int mlx5_query_sd(struct mlx5_core_dev *dev, bool *sdm,
+			 u8 *host_buses, u8 *sd_group)
+{
+	u32 out[MLX5_ST_SZ_DW(mpir_reg)];
+	int err;
+
+	err = mlx5_query_mpir_reg(dev, out);
+	if (err)
+		return err;
+
+	err = mlx5_query_nic_vport_sd_group(dev, sd_group);
+	if (err)
+		return err;
+
+	*sdm = MLX5_GET(mpir_reg, out, sdm);
+	*host_buses = MLX5_GET(mpir_reg, out, host_buses);
+
+	return 0;
+}
+
+static u32 mlx5_sd_group_id(struct mlx5_core_dev *dev, u8 sd_group)
+{
+	return (u32)((MLX5_CAP_GEN(dev, native_port_num) << 8) | sd_group);
+}
+
+static int sd_init(struct mlx5_core_dev *dev)
+{
+	u8 host_buses, sd_group;
+	struct mlx5_sd *sd;
+	u32 group_id;
+	bool sdm;
+	int err;
+
+	if (!MLX5_CAP_MCAM_REG(dev, mpir))
+		return 0;
+
+	err = mlx5_query_sd(dev, &sdm, &host_buses, &sd_group);
+	if (err)
+		return err;
+
+	if (!sdm)
+		return 0;
+
+	if (!sd_group)
+		return 0;
+
+	group_id = mlx5_sd_group_id(dev, sd_group);
+
+	if (!mlx5_sd_is_supported(dev, host_buses)) {
+		sd_warn(dev, "can't support requested netdev combining for group id 0x%x), skipping\n",
+			group_id);
+		return 0;
+	}
+
+	sd = kzalloc(sizeof(*sd), GFP_KERNEL);
+	if (!sd)
+		return -ENOMEM;
+
+	sd->host_buses = host_buses;
+	sd->group_id = group_id;
+
+	mlx5_set_sd(dev, sd);
+
+	return 0;
+}
+
+static void sd_cleanup(struct mlx5_core_dev *dev)
+{
+	struct mlx5_sd *sd = mlx5_get_sd(dev);
+
+	mlx5_set_sd(dev, NULL);
+	kfree(sd);
+}
+
 int mlx5_sd_init(struct mlx5_core_dev *dev)
 {
+	int err;
+
+	err = sd_init(dev);
+	if (err)
+		return err;
+
 	return 0;
 }
 
 void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
 {
+	struct mlx5_sd *sd = mlx5_get_sd(dev);
+
+	if (!sd)
+		return;
+
+	sd_cleanup(dev);
 }
 
 struct auxiliary_device *mlx5_sd_get_adev(struct mlx5_core_dev *dev,
-- 
2.43.0


