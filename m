Return-Path: <netdev+bounces-27936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C02A77DAB3
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 08:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4255F2817F4
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 06:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F172C8DF;
	Wed, 16 Aug 2023 06:52:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BD8C8CC
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 06:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48707C433C8;
	Wed, 16 Aug 2023 06:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692168760;
	bh=abWiWPKwcgaHPVQRZlXrDvbyWt7euJGqA6mcYi7jVrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BFijh41P+NVInGCZcyfdxuBf//Px+ckUMXhH7J8rIx6rDJjNftufP8KaOabxNSxU7
	 dP0iw22bl4SxL/4LlTlrh8BWuvb8dC0VJk3ZwKIQOCDoRlYwppQ6Z/SR5bXYJUg/v8
	 3HOvfu4kCpElSjr2ExTJTzo1Mfeu3CXivpwRaYUdJYL62M/o5gxsfMNLFI7WbUJ9jD
	 ZnhLPAx3krpbFIdN+A3AZ0Ime770idL/pEewkGzw4oZ0qWfCpsMhYNrSb15SFkan+W
	 B87xC9OnaJT9Cak37It9O6F+iDgr83SjohhdPv9uwZCk71Kcd77S4H9zITqrlCJx++
	 MeHwUOkat4z+A==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mark Bloch <mbloch@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	Mark Zhang <markzhang@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH rdma-next 2/2] RDMA/mlx5: Send correct port events
Date: Wed, 16 Aug 2023 09:52:24 +0300
Message-ID: <86a8473d0ccea1b66e59eb86457359be9005cfcb.1692168533.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692168533.git.leon@kernel.org>
References: <cover.1692168533.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Bloch <mbloch@nvidia.com>

When operating in switchdev mode and with an active LAG, the function
mlx5_lag_get_roce_netdev() fails to return a valid net device as this
function is designed specifically for RoCE LAGs.

Consequently, this issue resulted in the driver sending incorrect event
reports. To address this, a new API is introduced to properly obtain the
net device. Additionally, some code logic is cleaned up during this
modification.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c             | 39 +++++++++++++++----
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 29 ++++++++++++++
 include/linux/mlx5/driver.h                   |  2 +
 3 files changed, 62 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 215d7b0add8f..8b98200bd94c 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -159,6 +159,29 @@ static struct mlx5_roce *mlx5_get_rep_roce(struct mlx5_ib_dev *dev,
 	return NULL;
 }
 
+static bool mlx5_netdev_send_event(struct mlx5_ib_dev *dev,
+				   struct net_device *ndev,
+				   struct net_device *upper,
+				   struct mlx5_roce *roce)
+{
+	if (!dev->ib_active)
+		return false;
+
+	/* Event is about our upper device */
+	if (upper == ndev)
+		return true;
+
+	/* RDMA device not in lag and not in switchdev */
+	if (!dev->is_rep && !upper && ndev == roce->netdev)
+		return true;
+
+	/* RDMA device in switchdev */
+	if (dev->is_rep && ndev == roce->netdev)
+		return true;
+
+	return false;
+}
+
 static int mlx5_netdev_event(struct notifier_block *this,
 			     unsigned long event, void *ptr)
 {
@@ -200,7 +223,7 @@ static int mlx5_netdev_event(struct notifier_block *this,
 		if (ibdev->lag_active) {
 			struct net_device *lag_ndev;
 
-			lag_ndev = mlx5_lag_get_roce_netdev(mdev);
+			lag_ndev = mlx5_lag_get_netdev(mdev);
 			if (lag_ndev) {
 				upper = netdev_master_upper_dev_get(lag_ndev);
 				dev_put(lag_ndev);
@@ -209,13 +232,13 @@ static int mlx5_netdev_event(struct notifier_block *this,
 			}
 		}
 
-		if (ibdev->is_rep)
+		if (ibdev->is_rep) {
 			roce = mlx5_get_rep_roce(ibdev, ndev, upper, &port_num);
-		if (!roce)
-			return NOTIFY_DONE;
-		if ((upper == ndev ||
-		     ((!upper || ibdev->is_rep) && ndev == roce->netdev)) &&
-		    ibdev->ib_active) {
+			if (!roce)
+				return NOTIFY_DONE;
+		}
+
+		if (mlx5_netdev_send_event(ibdev, ndev, upper, roce)) {
 			struct ib_event ibev = { };
 			enum ib_port_state port_state;
 
@@ -260,7 +283,7 @@ static struct net_device *mlx5_ib_get_netdev(struct ib_device *device,
 	if (!mdev)
 		return NULL;
 
-	if (ibdev->lag_active) {
+	if (!ibdev->is_rep && ibdev->lag_active) {
 		ndev = mlx5_lag_get_roce_netdev(mdev);
 		if (ndev)
 			goto out;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index f0a074b2fcdf..83298e9addd3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -1498,6 +1498,35 @@ struct net_device *mlx5_lag_get_roce_netdev(struct mlx5_core_dev *dev)
 }
 EXPORT_SYMBOL(mlx5_lag_get_roce_netdev);
 
+struct net_device *mlx5_lag_get_netdev(struct mlx5_core_dev *dev)
+{
+	struct net_device *ndev = NULL;
+	struct mlx5_lag *ldev;
+	unsigned long flags;
+	int i;
+
+	spin_lock_irqsave(&lag_lock, flags);
+	ldev = mlx5_lag_dev(dev);
+
+	if (!(ldev && __mlx5_lag_is_active(ldev)))
+		goto unlock;
+
+	for (i = 0; i < ldev->ports; i++) {
+		if (ldev->pf[i].dev == dev) {
+			ndev = ldev->pf[i].netdev;
+			break;
+		}
+	}
+
+	if (ndev)
+		dev_hold(ndev);
+
+unlock:
+	spin_unlock_irqrestore(&lag_lock, flags);
+	return ndev;
+}
+EXPORT_SYMBOL(mlx5_lag_get_netdev);
+
 u8 mlx5_lag_get_slave_port(struct mlx5_core_dev *dev,
 			   struct net_device *slave)
 {
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 25d0528f9219..bc7e3a974f62 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1160,6 +1160,8 @@ bool mlx5_lag_is_master(struct mlx5_core_dev *dev);
 bool mlx5_lag_is_shared_fdb(struct mlx5_core_dev *dev);
 bool mlx5_lag_is_mpesw(struct mlx5_core_dev *dev);
 struct net_device *mlx5_lag_get_roce_netdev(struct mlx5_core_dev *dev);
+
+struct net_device *mlx5_lag_get_netdev(struct mlx5_core_dev *dev);
 u8 mlx5_lag_get_slave_port(struct mlx5_core_dev *dev,
 			   struct net_device *slave);
 int mlx5_lag_query_cong_counters(struct mlx5_core_dev *dev,
-- 
2.41.0


