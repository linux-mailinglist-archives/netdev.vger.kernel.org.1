Return-Path: <netdev+bounces-35384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E627A9411
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 14:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ED1D2819BF
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 12:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB90AD55;
	Thu, 21 Sep 2023 12:10:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF55AD50
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 12:10:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843C4C4E661;
	Thu, 21 Sep 2023 12:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695298248;
	bh=DgzUVyO94BHRDEnxLuvZy37u6uHpwfBgskzMDwYtI98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tMb9BpcBsEMzhCzh8Se5JYn0XxGARmerYvmTGI7Lu4cRG00Zyiw6Si3oSJ24loxVj
	 CV1Av1f+jAy/L4yEbt3SRmBfSLk0azn/Cn2tasOGmRUoIzwa3vejrMPGxS+NV8KSKk
	 ix23ZVjk20FWWPX9NsLIUXJokqnAxLP+MTe5OuM3CwZnX2iPlkuchoM+TmuJ7nHu6Y
	 ZC3kf1PaCy6dGby5ILVL8d78BCiwRBusFHJFOKKSdrWfoHocjGJlVYwVD+/YBv7dMA
	 SMyPp2W0RRD6MGY/lDNVKBL+Ei9GcOFg3jnmmj7MtxWI+nOzzc09zOiQFmoJBMQ9bQ
	 ov0PJnXs8gRXA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH mlx5-next 1/9] RDMA/mlx5: Send events from IB driver about device affiliation state
Date: Thu, 21 Sep 2023 15:10:27 +0300
Message-ID: <a7491c3e483cfd8d962f5f75b9a25f253043384a.1695296682.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695296682.git.leon@kernel.org>
References: <cover.1695296682.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrisious Haddad <phaddad@nvidia.com>

Send blocking events from IB driver whenever the device is done being
affiliated or if it is removed from an affiliation.

This is useful since now the EN driver can register to those event and
know when a device is affiliated or not.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c              | 17 +++++++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/main.c |  6 ++++++
 include/linux/mlx5/device.h                    |  2 ++
 include/linux/mlx5/driver.h                    |  2 ++
 4 files changed, 27 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index aed5cdea50e6..530d88784e41 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -24,6 +24,7 @@
 #include <linux/mlx5/vport.h>
 #include <linux/mlx5/fs.h>
 #include <linux/mlx5/eswitch.h>
+#include <linux/mlx5/driver.h>
 #include <linux/list.h>
 #include <rdma/ib_smi.h>
 #include <rdma/ib_umem_odp.h>
@@ -3175,6 +3176,13 @@ static void mlx5_ib_unbind_slave_port(struct mlx5_ib_dev *ibdev,
 
 	lockdep_assert_held(&mlx5_ib_multiport_mutex);
 
+	mlx5_core_mp_event_replay(ibdev->mdev,
+				  MLX5_DRIVER_EVENT_AFFILIATION_REMOVED,
+				  NULL);
+	mlx5_core_mp_event_replay(mpi->mdev,
+				  MLX5_DRIVER_EVENT_AFFILIATION_REMOVED,
+				  NULL);
+
 	mlx5_ib_cleanup_cong_debugfs(ibdev, port_num);
 
 	spin_lock(&port->mp.mpi_lock);
@@ -3226,6 +3234,7 @@ static bool mlx5_ib_bind_slave_port(struct mlx5_ib_dev *ibdev,
 				    struct mlx5_ib_multiport_info *mpi)
 {
 	u32 port_num = mlx5_core_native_port_num(mpi->mdev) - 1;
+	u64 key;
 	int err;
 
 	lockdep_assert_held(&mlx5_ib_multiport_mutex);
@@ -3254,6 +3263,14 @@ static bool mlx5_ib_bind_slave_port(struct mlx5_ib_dev *ibdev,
 
 	mlx5_ib_init_cong_debugfs(ibdev, port_num);
 
+	key = ibdev->ib_dev.index;
+	mlx5_core_mp_event_replay(mpi->mdev,
+				  MLX5_DRIVER_EVENT_AFFILIATION_DONE,
+				  &key);
+	mlx5_core_mp_event_replay(ibdev->mdev,
+				  MLX5_DRIVER_EVENT_AFFILIATION_DONE,
+				  &key);
+
 	return true;
 
 unbind:
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index d17c9c31b165..307ffe6300f8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -361,6 +361,12 @@ void mlx5_core_uplink_netdev_event_replay(struct mlx5_core_dev *dev)
 }
 EXPORT_SYMBOL(mlx5_core_uplink_netdev_event_replay);
 
+void mlx5_core_mp_event_replay(struct mlx5_core_dev *dev, u32 event, void *data)
+{
+	mlx5_blocking_notifier_call_chain(dev, event, data);
+}
+EXPORT_SYMBOL(mlx5_core_mp_event_replay);
+
 int mlx5_core_get_caps_mode(struct mlx5_core_dev *dev, enum mlx5_cap_type cap_type,
 			    enum mlx5_cap_mode cap_mode)
 {
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index 8fbe22de16ef..820bca965fb6 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -367,6 +367,8 @@ enum mlx5_driver_event {
 	MLX5_DRIVER_EVENT_MACSEC_SA_ADDED,
 	MLX5_DRIVER_EVENT_MACSEC_SA_DELETED,
 	MLX5_DRIVER_EVENT_SF_PEER_DEVLINK,
+	MLX5_DRIVER_EVENT_AFFILIATION_DONE,
+	MLX5_DRIVER_EVENT_AFFILIATION_REMOVED,
 };
 
 enum {
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 92434814c855..52e982bc0f50 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1029,6 +1029,8 @@ bool mlx5_cmd_is_down(struct mlx5_core_dev *dev);
 void mlx5_core_uplink_netdev_set(struct mlx5_core_dev *mdev, struct net_device *netdev);
 void mlx5_core_uplink_netdev_event_replay(struct mlx5_core_dev *mdev);
 
+void mlx5_core_mp_event_replay(struct mlx5_core_dev *dev, u32 event, void *data);
+
 void mlx5_health_cleanup(struct mlx5_core_dev *dev);
 int mlx5_health_init(struct mlx5_core_dev *dev);
 void mlx5_start_health_poll(struct mlx5_core_dev *dev);
-- 
2.41.0


