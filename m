Return-Path: <netdev+bounces-27935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E4977DAB2
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 08:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6D642817A0
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 06:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049B4C8CB;
	Wed, 16 Aug 2023 06:52:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42CEC8DF
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 06:52:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A724EC433C7;
	Wed, 16 Aug 2023 06:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692168756;
	bh=2AIWKp2sy/1XGCmuzq+BzxxsosNVLkqm9wiJBK2f824=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NXmpk9FHf7EZA3mi9USxU6WDzCuRwF2to9NXqyWAzJsb9WRaa7dO01/3UC+Wsf3zu
	 ivKMSPJZs7cZEyz4r7XklvhO/BbZSUchaPrawzee71pwUmYeNa0Y2raSUOAooO2Skw
	 ph+3YHjtz9vdf8BfuscQegL5IZju4YiF1e3eH79+dsLGuFZqgqHjO5TL03PJ3oXuGW
	 /MH7uBj2vUf8VM7WS4LgN5eBUqp7USKqSNFd0RyK6W2Bs9JoI3lE0d5PVv8DhXN8wy
	 IlR2ilZxHQecendin8FCkuUB9kzu4omxSzuQQ3nRR1PvOWAl00uJk6hWqutLgdwfjM
	 KB+1BJztsMnrQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mark Bloch <mbloch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	Mark Zhang <markzhang@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH rdma-next 1/2] RDMA/mlx5: Get upper device only if device is lagged
Date: Wed, 16 Aug 2023 09:52:23 +0300
Message-ID: <117b591f5e6e130aeccc871888084fb92fb43b5a.1692168533.git.leon@kernel.org>
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

If the RDMA device isn't in LAG mode there is no need
to try to get the upper device.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index f0b394ed7452..215d7b0add8f 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -195,12 +195,18 @@ static int mlx5_netdev_event(struct notifier_block *this,
 	case NETDEV_CHANGE:
 	case NETDEV_UP:
 	case NETDEV_DOWN: {
-		struct net_device *lag_ndev = mlx5_lag_get_roce_netdev(mdev);
 		struct net_device *upper = NULL;
 
-		if (lag_ndev) {
-			upper = netdev_master_upper_dev_get(lag_ndev);
-			dev_put(lag_ndev);
+		if (ibdev->lag_active) {
+			struct net_device *lag_ndev;
+
+			lag_ndev = mlx5_lag_get_roce_netdev(mdev);
+			if (lag_ndev) {
+				upper = netdev_master_upper_dev_get(lag_ndev);
+				dev_put(lag_ndev);
+			} else {
+				goto done;
+			}
 		}
 
 		if (ibdev->is_rep)
@@ -254,9 +260,11 @@ static struct net_device *mlx5_ib_get_netdev(struct ib_device *device,
 	if (!mdev)
 		return NULL;
 
-	ndev = mlx5_lag_get_roce_netdev(mdev);
-	if (ndev)
-		goto out;
+	if (ibdev->lag_active) {
+		ndev = mlx5_lag_get_roce_netdev(mdev);
+		if (ndev)
+			goto out;
+	}
 
 	/* Ensure ndev does not disappear before we invoke dev_hold()
 	 */
-- 
2.41.0


