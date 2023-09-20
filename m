Return-Path: <netdev+bounces-35127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB78E7A72EC
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 08:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F0928189F
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 06:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE258C0A;
	Wed, 20 Sep 2023 06:36:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4008F72
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 06:36:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18140C433C7;
	Wed, 20 Sep 2023 06:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695191767;
	bh=/PbfMOZhJMNV00rw/gz9c/Tmp0rtYfzGzyUD04wIurw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=spMCw0CoETkIyZVLQNgMPIteHd5D88TkkkY2yy4lNmN0NUs3Oet2MvZXmcUFhDhf2
	 hLZW8SwTKTOVmYSbOWHzBOqvgVtkzC7cLDc2mx8Fi6o4kfYOzrNkV1hMuoDz98Dhfj
	 68U7QzQ2ZX3NWNZLL1wSUxb+ntlJrrnDKmC74CaTwuidruXBkmfk5TOo3tlEmpNToK
	 amNY8OiS1oCzjkWGWM/6xy6UNOI4pLURIjKZFjTuVhEeOpVYR2netkpg7q+Z9ZRqtv
	 XMGYm5TcIePD4MIX4u79jPoPc14yYx3iPaMtUIunGR3rFeCmeTKYlCM8EdBjWAZ3gM
	 bfWFvjHWgTZzQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: [net-next 09/15] net/mlx5e: Consider aggregated port speed during rate configuration
Date: Tue, 19 Sep 2023 23:35:46 -0700
Message-ID: <20230920063552.296978-10-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920063552.296978-1-saeed@kernel.org>
References: <20230920063552.296978-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianbo Liu <jianbol@nvidia.com>

When LAG is configured, functions (PF,VF,SF) can utilize the maximum
aggregated link speed for transmission. Currently the aggregated link
speed is not considered.

Hence, improve it to use the aggregated link speed by referring to the
physical port's upper bonding device when LAG is configured.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 84 ++++++++++++++++---
 1 file changed, 72 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 1887a24ee414..f76c8f0562e9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2021, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
 
 #include "eswitch.h"
+#include "lib/mlx5.h"
 #include "esw/qos.h"
 #include "en/port.h"
 #define CREATE_TRACE_POINTS
@@ -701,6 +702,70 @@ int mlx5_esw_qos_set_vport_rate(struct mlx5_eswitch *esw, struct mlx5_vport *vpo
 	return err;
 }
 
+static u32 mlx5_esw_qos_lag_link_speed_get_locked(struct mlx5_core_dev *mdev)
+{
+	struct ethtool_link_ksettings lksettings;
+	struct net_device *slave, *master;
+	u32 speed = SPEED_UNKNOWN;
+
+	/* Lock ensures a stable reference to master and slave netdevice
+	 * while port speed of master is queried.
+	 */
+	ASSERT_RTNL();
+
+	slave = mlx5_uplink_netdev_get(mdev);
+	if (!slave)
+		goto out;
+
+	master = netdev_master_upper_dev_get(slave);
+	if (master && !__ethtool_get_link_ksettings(master, &lksettings))
+		speed = lksettings.base.speed;
+
+out:
+	return speed;
+}
+
+static int mlx5_esw_qos_max_link_speed_get(struct mlx5_core_dev *mdev, u32 *link_speed_max,
+					   bool hold_rtnl_lock, struct netlink_ext_ack *extack)
+{
+	int err;
+
+	if (!mlx5_lag_is_active(mdev))
+		goto skip_lag;
+
+	if (hold_rtnl_lock)
+		rtnl_lock();
+
+	*link_speed_max = mlx5_esw_qos_lag_link_speed_get_locked(mdev);
+
+	if (hold_rtnl_lock)
+		rtnl_unlock();
+
+	if (*link_speed_max != (u32)SPEED_UNKNOWN)
+		return 0;
+
+skip_lag:
+	err = mlx5_port_max_linkspeed(mdev, link_speed_max);
+	if (err)
+		NL_SET_ERR_MSG_MOD(extack, "Failed to get link maximum speed");
+
+	return err;
+}
+
+static int mlx5_esw_qos_link_speed_verify(struct mlx5_core_dev *mdev,
+					  const char *name, u32 link_speed_max,
+					  u64 value, struct netlink_ext_ack *extack)
+{
+	if (value > link_speed_max) {
+		pr_err("%s rate value %lluMbps exceed link maximum speed %u.\n",
+		       name, value, link_speed_max);
+		NL_SET_ERR_MSG_MOD(extack, "TX rate value exceed link maximum speed");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 int mlx5_esw_qos_modify_vport_rate(struct mlx5_eswitch *esw, u16 vport_num, u32 rate_mbps)
 {
 	u32 ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
@@ -744,12 +809,6 @@ static int esw_qos_devlink_rate_to_mbps(struct mlx5_core_dev *mdev, const char *
 	u64 value;
 	int err;
 
-	err = mlx5_port_max_linkspeed(mdev, &link_speed_max);
-	if (err) {
-		NL_SET_ERR_MSG_MOD(extack, "Failed to get link maximum speed");
-		return err;
-	}
-
 	value = div_u64_rem(*rate, MLX5_LINKSPEED_UNIT, &remainder);
 	if (remainder) {
 		pr_err("%s rate value %lluBps not in link speed units of 1Mbps.\n",
@@ -758,12 +817,13 @@ static int esw_qos_devlink_rate_to_mbps(struct mlx5_core_dev *mdev, const char *
 		return -EINVAL;
 	}
 
-	if (value > link_speed_max) {
-		pr_err("%s rate value %lluMbps exceed link maximum speed %u.\n",
-		       name, value, link_speed_max);
-		NL_SET_ERR_MSG_MOD(extack, "TX rate value exceed link maximum speed");
-		return -EINVAL;
-	}
+	err = mlx5_esw_qos_max_link_speed_get(mdev, &link_speed_max, true, extack);
+	if (err)
+		return err;
+
+	err = mlx5_esw_qos_link_speed_verify(mdev, name, link_speed_max, value, extack);
+	if (err)
+		return err;
 
 	*rate = value;
 	return 0;
-- 
2.41.0


