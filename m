Return-Path: <netdev+bounces-28366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB24677F2F8
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 11:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90F50281E0C
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 09:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE1511C99;
	Thu, 17 Aug 2023 09:12:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CB21095B
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 09:12:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484A0C433C7;
	Thu, 17 Aug 2023 09:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692263569;
	bh=MhZ0ExkPHO6x7SjCyykMcqtKaCAzxA9PJwZ1DbtNW9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tvhGSILE6BFAij6I4l+dJPS3rr1Gnm0RCheETwkdvBKskDV49Vp/XY8hkY6KbXewR
	 R5kTcLwMMl/h2TbHoamqQGsn4qreWB60+uosp/z6SxucUIWE92U0gRyiYk1AUjXfCe
	 D0o59jW8+TOxFk/aNf6Fj1/5WR3PcTq7Qa8byvMsPsHoQJ8kg/+fgZoYLx/t1+F468
	 jkYcYrHs1F7N25mcZtXrX8eXn9g3jjS4JU0bYcoe0vnqeDaKImRl1BOte+sRxLhSKO
	 bNoJi+MYbcCPvlvFu3i4LHaQt5O4p+2WZb/Jdy5pNmThDB4blc3iqbgK0CrfEs20iT
	 5opR8LztCtSsQ==
From: Leon Romanovsky <leon@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Dima Chumak <dchumak@nvidia.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Simon Horman <simon.horman@corigine.com>
Subject: [PATCH net-next v3 8/8] net/mlx5: Implement devlink port function cmds to control ipsec_packet
Date: Thu, 17 Aug 2023 12:11:30 +0300
Message-ID: <5df76276a8d3fb638febecdf8c36d09b7ba84d0c.1692262560.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692262560.git.leonro@nvidia.com>
References: <cover.1692262560.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dima Chumak <dchumak@nvidia.com>

Implement devlink port function commands to enable / disable IPsec
packet offloads. This is used to control the IPsec capability of the
device.

When ipsec_offload is enabled for a VF, it prevents adding IPsec packet
offloads on the PF, because the two cannot be active simultaneously due
to HW constraints. Conversely, if there are any active IPsec packet
offloads on the PF, it's not allowed to enable ipsec_packet on a VF,
until PF IPsec offloads are cleared.

Signed-off-by: Dima Chumak <dchumak@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../ethernet/mellanox/mlx5/switchdev.rst      | 10 ++
 .../mellanox/mlx5/core/esw/devlink_port.c     |  2 +
 .../ethernet/mellanox/mlx5/core/esw/ipsec.c   | 62 +++++++++++-
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |  7 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.h | 11 +++
 .../mellanox/mlx5/core/eswitch_offloads.c     | 95 +++++++++++++++++++
 6 files changed, 183 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/switchdev.rst b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/switchdev.rst
index de51e55dcfe3..b617e93d7c2c 100644
--- a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/switchdev.rst
+++ b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/switchdev.rst
@@ -200,6 +200,16 @@ IPsec capability enabled, any IPsec offloading is blocked on the PF.
 mlx5 driver support devlink port function attr mechanism to setup ipsec_crypto
 capability. (refer to Documentation/networking/devlink/devlink-port.rst)
 
+IPsec packet capability setup
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+User who wants mlx5 PCI VFs to be able to perform IPsec packet offloading need
+to explicitly enable the VF ipsec_packet capability. Enabling IPsec capability
+for VFs is supported starting with ConnectX6dx devices and above. When a VF has
+IPsec capability enabled, any IPsec offloading is blocked on the PF.
+
+mlx5 driver support devlink port function attr mechanism to setup ipsec_packet
+capability. (refer to Documentation/networking/devlink/devlink-port.rst)
+
 SF state setup
 --------------
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index 1c3a9764f8ce..2968a2412b0f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -81,6 +81,8 @@ static const struct devlink_port_ops mlx5_esw_dl_port_ops = {
 #ifdef CONFIG_XFRM_OFFLOAD
 	.port_fn_ipsec_crypto_get = mlx5_devlink_port_fn_ipsec_crypto_get,
 	.port_fn_ipsec_crypto_set = mlx5_devlink_port_fn_ipsec_crypto_set,
+	.port_fn_ipsec_packet_get = mlx5_devlink_port_fn_ipsec_packet_get,
+	.port_fn_ipsec_packet_set = mlx5_devlink_port_fn_ipsec_packet_set,
 #endif /* CONFIG_XFRM_OFFLOAD */
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c
index 187fb5f2d0cb..da10e04777cf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c
@@ -37,6 +37,7 @@ static int esw_ipsec_vf_query_generic(struct mlx5_core_dev *dev, u16 vport_num,
 
 enum esw_vport_ipsec_offload {
 	MLX5_ESW_VPORT_IPSEC_CRYPTO_OFFLOAD,
+	MLX5_ESW_VPORT_IPSEC_PACKET_OFFLOAD,
 };
 
 int mlx5_esw_ipsec_vf_offload_get(struct mlx5_core_dev *dev, struct mlx5_vport *vport)
@@ -55,6 +56,7 @@ int mlx5_esw_ipsec_vf_offload_get(struct mlx5_core_dev *dev, struct mlx5_vport *
 
 	if (!ipsec_enabled) {
 		vport->info.ipsec_crypto_enabled = false;
+		vport->info.ipsec_packet_enabled = false;
 		return 0;
 	}
 
@@ -69,6 +71,8 @@ int mlx5_esw_ipsec_vf_offload_get(struct mlx5_core_dev *dev, struct mlx5_vport *
 	hca_cap = MLX5_ADDR_OF(query_hca_cap_out, query_cap, capability);
 	vport->info.ipsec_crypto_enabled =
 		MLX5_GET(ipsec_cap, hca_cap, ipsec_crypto_offload);
+	vport->info.ipsec_packet_enabled =
+		MLX5_GET(ipsec_cap, hca_cap, ipsec_full_offload);
 free:
 	kvfree(query_cap);
 	return err;
@@ -143,6 +147,9 @@ static int esw_ipsec_vf_set_bytype(struct mlx5_core_dev *dev, struct mlx5_vport
 	case MLX5_ESW_VPORT_IPSEC_CRYPTO_OFFLOAD:
 		MLX5_SET(ipsec_cap, cap, ipsec_crypto_offload, enable);
 		break;
+	case MLX5_ESW_VPORT_IPSEC_PACKET_OFFLOAD:
+		MLX5_SET(ipsec_cap, cap, ipsec_full_offload, enable);
+		break;
 	default:
 		ret = -EOPNOTSUPP;
 		goto free;
@@ -222,15 +229,28 @@ static int esw_ipsec_vf_offload_set_bytype(struct mlx5_eswitch *esw, struct mlx5
 		err = esw_ipsec_vf_set_bytype(dev, vport, enable, type);
 		if (err)
 			return err;
-		err = esw_ipsec_vf_set_generic(dev, vport->vport, enable);
+		err = mlx5_esw_ipsec_vf_offload_get(dev, vport);
 		if (err)
 			return err;
+
+		/* The generic ipsec_offload cap can be disabled only if both
+		 * ipsec_crypto_offload and ipsec_full_offload aren't enabled.
+		 */
+		if (!vport->info.ipsec_crypto_enabled &&
+		    !vport->info.ipsec_packet_enabled) {
+			err = esw_ipsec_vf_set_generic(dev, vport->vport, enable);
+			if (err)
+				return err;
+		}
 	}
 
 	switch (type) {
 	case MLX5_ESW_VPORT_IPSEC_CRYPTO_OFFLOAD:
 		vport->info.ipsec_crypto_enabled = enable;
 		break;
+	case MLX5_ESW_VPORT_IPSEC_PACKET_OFFLOAD:
+		vport->info.ipsec_packet_enabled = enable;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -301,9 +321,49 @@ int mlx5_esw_ipsec_vf_crypto_offload_supported(struct mlx5_core_dev *dev,
 	return err;
 }
 
+int mlx5_esw_ipsec_vf_packet_offload_supported(struct mlx5_core_dev *dev,
+					       u16 vport_num)
+{
+	int query_sz = MLX5_ST_SZ_BYTES(query_hca_cap_out);
+	void *hca_cap, *query_cap;
+	int ret;
+
+	if (!mlx5_esw_ipsec_vf_offload_supported(dev))
+		return -EOPNOTSUPP;
+
+	ret = esw_ipsec_offload_supported(dev, vport_num);
+	if (ret)
+		return ret;
+
+	query_cap = kvzalloc(query_sz, GFP_KERNEL);
+	if (!query_cap)
+		return -ENOMEM;
+
+	ret = mlx5_vport_get_other_func_cap(dev, vport_num, query_cap, MLX5_CAP_FLOW_TABLE);
+	if (ret)
+		goto out;
+
+	hca_cap = MLX5_ADDR_OF(query_hca_cap_out, query_cap, capability);
+	if (!MLX5_GET(flow_table_nic_cap, hca_cap, flow_table_properties_nic_receive.decap)) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+out:
+	kvfree(query_cap);
+	return ret;
+}
+
 int mlx5_esw_ipsec_vf_crypto_offload_set(struct mlx5_eswitch *esw, struct mlx5_vport *vport,
 					 bool enable)
 {
 	return esw_ipsec_vf_offload_set_bytype(esw, vport, enable,
 					       MLX5_ESW_VPORT_IPSEC_CRYPTO_OFFLOAD);
 }
+
+int mlx5_esw_ipsec_vf_packet_offload_set(struct mlx5_eswitch *esw, struct mlx5_vport *vport,
+					 bool enable)
+{
+	return esw_ipsec_vf_offload_set_bytype(esw, vport, enable,
+					       MLX5_ESW_VPORT_IPSEC_PACKET_OFFLOAD);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 74b27b5fed65..cdd5fc09e231 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -821,7 +821,6 @@ static int mlx5_esw_vport_caps_get(struct mlx5_eswitch *esw, struct mlx5_vport *
 	vport->info.mig_enabled = MLX5_GET(cmd_hca_cap_2, hca_caps, migratable);
 
 	err = mlx5_esw_ipsec_vf_offload_get(esw->dev, vport);
-
 out_free:
 	kfree(query_ctx);
 	return err;
@@ -939,7 +938,8 @@ int mlx5_esw_vport_enable(struct mlx5_eswitch *esw, u16 vport_num,
 	/* Sync with current vport context */
 	vport->enabled_events = enabled_events;
 	vport->enabled = true;
-	if (vport->vport != MLX5_VPORT_PF && vport->info.ipsec_crypto_enabled)
+	if (vport->vport != MLX5_VPORT_PF &&
+	    (vport->info.ipsec_crypto_enabled || vport->info.ipsec_packet_enabled))
 		esw->enabled_ipsec_vf_count++;
 
 	/* Esw manager is trusted by default. Host PF (vport 0) is trusted as well
@@ -1000,7 +1000,8 @@ void mlx5_esw_vport_disable(struct mlx5_eswitch *esw, u16 vport_num)
 	    MLX5_CAP_GEN(esw->dev, vhca_resource_manager))
 		mlx5_esw_vport_vhca_id_clear(esw, vport_num);
 
-	if (vport->vport != MLX5_VPORT_PF && vport->info.ipsec_crypto_enabled)
+	if (vport->vport != MLX5_VPORT_PF &&
+	    (vport->info.ipsec_crypto_enabled || vport->info.ipsec_packet_enabled))
 		esw->enabled_ipsec_vf_count--;
 
 	/* We don't assume VFs will cleanup after themselves.
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index a92a23198b3c..2c273d301c78 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -164,6 +164,7 @@ struct mlx5_vport_info {
 	u8                      roce_enabled: 1;
 	u8                      mig_enabled: 1;
 	u8                      ipsec_crypto_enabled: 1;
+	u8                      ipsec_packet_enabled: 1;
 };
 
 /* Vport context events */
@@ -542,6 +543,10 @@ int mlx5_devlink_port_fn_ipsec_crypto_get(struct devlink_port *port, bool *is_en
 					  struct netlink_ext_ack *extack);
 int mlx5_devlink_port_fn_ipsec_crypto_set(struct devlink_port *port, bool enable,
 					  struct netlink_ext_ack *extack);
+int mlx5_devlink_port_fn_ipsec_packet_get(struct devlink_port *port, bool *is_enabled,
+					  struct netlink_ext_ack *extack);
+int mlx5_devlink_port_fn_ipsec_packet_set(struct devlink_port *port, bool enable,
+					  struct netlink_ext_ack *extack);
 #endif /* CONFIG_XFRM_OFFLOAD */
 void *mlx5_eswitch_get_uplink_priv(struct mlx5_eswitch *esw, u8 rep_type);
 
@@ -702,8 +707,14 @@ int mlx5_esw_ipsec_vf_crypto_offload_supported(struct mlx5_core_dev *dev,
 					       u16 vport_num);
 int mlx5_esw_ipsec_vf_offload_get(struct mlx5_core_dev *dev,
 				  struct mlx5_vport *vport);
+int mlx5_esw_ipsec_vf_packet_offload_supported(struct mlx5_core_dev *dev,
+					       u16 vport_num);
 int mlx5_esw_ipsec_vf_crypto_offload_set(struct mlx5_eswitch *esw, struct mlx5_vport *vport,
 					 bool enable);
+int mlx5_esw_ipsec_vf_packet_offload_set(struct mlx5_eswitch *esw, struct mlx5_vport *vport,
+					 bool enable);
+void mlx5_esw_vport_ipsec_offload_enable(struct mlx5_eswitch *esw);
+void mlx5_esw_vport_ipsec_offload_disable(struct mlx5_eswitch *esw);
 bool mlx5_eswitch_block_ipsec(struct mlx5_core_dev *dev);
 void mlx5_eswitch_unblock_ipsec(struct mlx5_core_dev *dev);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 9b9aecc1809e..e30d357fcd9d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -4538,4 +4538,99 @@ int mlx5_devlink_port_fn_ipsec_crypto_set(struct devlink_port *port, bool enable
 	mutex_unlock(&esw->state_lock);
 	return err;
 }
+
+int mlx5_devlink_port_fn_ipsec_packet_get(struct devlink_port *port, bool *is_enabled,
+					  struct netlink_ext_ack *extack)
+{
+	struct mlx5_eswitch *esw;
+	struct mlx5_vport *vport;
+	int err = 0;
+
+	esw = mlx5_devlink_eswitch_get(port->devlink);
+	if (IS_ERR(esw))
+		return PTR_ERR(esw);
+
+	vport = mlx5_devlink_port_fn_get_vport(port, esw);
+	if (IS_ERR(vport)) {
+		NL_SET_ERR_MSG_MOD(extack, "Invalid port");
+		return PTR_ERR(vport);
+	}
+
+	if (!mlx5_esw_ipsec_vf_offload_supported(esw->dev)) {
+		NL_SET_ERR_MSG_MOD(extack, "Device doesn't support IPsec packet");
+		return -EOPNOTSUPP;
+	}
+
+	mutex_lock(&esw->state_lock);
+	if (!vport->enabled) {
+		err = -EOPNOTSUPP;
+		goto unlock;
+	}
+
+	*is_enabled = vport->info.ipsec_packet_enabled;
+unlock:
+	mutex_unlock(&esw->state_lock);
+	return err;
+}
+
+int mlx5_devlink_port_fn_ipsec_packet_set(struct devlink_port *port,
+					  bool enable,
+					  struct netlink_ext_ack *extack)
+{
+	struct mlx5_eswitch *esw;
+	struct mlx5_vport *vport;
+	u16 vport_num;
+	int err;
+
+	esw = mlx5_devlink_eswitch_get(port->devlink);
+	if (IS_ERR(esw))
+		return PTR_ERR(esw);
+
+	vport = mlx5_devlink_port_fn_get_vport(port, esw);
+	if (IS_ERR(vport)) {
+		NL_SET_ERR_MSG_MOD(extack, "Invalid port");
+		return PTR_ERR(vport);
+	}
+
+	vport_num = mlx5_esw_devlink_port_index_to_vport_num(port->index);
+	err = mlx5_esw_ipsec_vf_packet_offload_supported(esw->dev, vport_num);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(
+			extack,
+			"Device doesn't support IPsec packet mode");
+		return err;
+	}
+
+	mutex_lock(&esw->state_lock);
+	if (!vport->enabled) {
+		err = -EOPNOTSUPP;
+		NL_SET_ERR_MSG_MOD(extack, "Eswitch vport is disabled");
+		goto unlock;
+	}
+
+	if (vport->info.ipsec_packet_enabled == enable)
+		goto unlock;
+
+	if (!esw->enabled_ipsec_vf_count && esw->dev->num_ipsec_offloads) {
+		err = -EBUSY;
+		goto unlock;
+	}
+
+	err = mlx5_esw_ipsec_vf_packet_offload_set(esw, vport, enable);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(
+			extack,
+			"Failed to set IPsec packet mode");
+		goto unlock;
+	}
+
+	vport->info.ipsec_packet_enabled = enable;
+	if (enable)
+		esw->enabled_ipsec_vf_count++;
+	else
+		esw->enabled_ipsec_vf_count--;
+unlock:
+	mutex_unlock(&esw->state_lock);
+	return err;
+}
 #endif /* CONFIG_XFRM_OFFLOAD */
-- 
2.41.0


