Return-Path: <netdev+bounces-59389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E5281ABED
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 01:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 668511F233EF
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 00:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C171BEA8;
	Thu, 21 Dec 2023 00:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S13g08ck"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72C94687
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 00:57:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588DAC433C9;
	Thu, 21 Dec 2023 00:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703120254;
	bh=SuliZR/xcFC1LKvniBU+nYi13X3koX3vQgG/MOkXPOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S13g08ckWmauiKd+QkBUMK5PWHh0/RoHXpuWhFpA10txO9kfjWRXnC0PfOOeXjNZY
	 lRK0iG8ZHjqqgSy0LsE8Y6obddPjyvSVhNznFoTDaMC+nSGwq0N+SyOQnWhzLlaBK/
	 9ouVhsjqqDd3AovFocCbC+sZlpABicQh9a5kx+/Nr84K/bS9HTY1ug2P6lZmFLemCI
	 /FD9ozFnH8fvkjmK8ilehT7CeLxWC6DC6GMsm4+pglX/PT/NENjO7KIAZLlUGPH7tC
	 pgwmfObKUsU2YbpPnU9Cy5mJm4JylowUFcZjz3vsI8S2UmvRsDB7nbIjwbidhiHJ8F
	 PsHP9Oiv6ukKw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [net-next 04/15] net/mlx5: SD, Implement basic query and instantiation
Date: Wed, 20 Dec 2023 16:57:10 -0800
Message-ID: <20231221005721.186607-5-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221005721.186607-1-saeed@kernel.org>
References: <20231221005721.186607-1-saeed@kernel.org>
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
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 107 +++++++++++++++++-
 1 file changed, 106 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index ea37238c4519..9d8b1bb0c0a6 100644
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
@@ -43,13 +52,109 @@ struct mlx5_core_dev *mlx5_sd_ch_ix_get_dev(struct mlx5_core_dev *primary, int c
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


