Return-Path: <netdev+bounces-42865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0076F7D06BF
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 05:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94D40B21386
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 03:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7E41C38;
	Fri, 20 Oct 2023 03:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndHYoYpq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62851BA32
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 03:04:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245A6C433C7;
	Fri, 20 Oct 2023 03:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697771088;
	bh=h+TraR7U/vpasMo1QJNshUN9yRlswbJs8I0ZXV20E6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ndHYoYpq38KPRKGccXZVjYK/eRximV2ntdTj+WSPXGhc7rA3mMiPXgA4MGmwrAbQ3
	 HGjJp0aP8MqsAt+mLnW+HlXAomfW+7S9GNSnmCtzisjQaMNAccAiTsVapkZKGNZGBg
	 +PX5Gkn0eeccUqHBxIdWkJ9J8eFA5vo0DzpOW1mCU/KI5ujPe5UnyBlC8GatEcOfWL
	 J+wa1Fqbh4YazuH09j2XvXpQcKg3IRjZY+6a1JshSQsb7AYCtd+oKKRa7djJwawuwI
	 nX8l6DdayoPpnlYYLWCQiDOFIXZeLIT8Dx3JleM+YwqXW/eWrfcqxNhwbfh8fP45nf
	 6j3yhKU/KxhwQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Shay Drory <shayd@nvidia.com>
Subject: [net-next 14/15] net/mlx5: print change on SW reset semaphore returns busy
Date: Thu, 19 Oct 2023 20:04:21 -0700
Message-ID: <20231020030422.67049-15-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020030422.67049-1-saeed@kernel.org>
References: <20231020030422.67049-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Moshe Shemesh <moshe@nvidia.com>

While collecting crdump as part of fw_fatal health reporter dump the PF
may fail to lock the SW reset semaphore. Change the print to indicate if
it was due to another PF locked the semaphore already and so trying to
lock the semaphore returned -EBUSY.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/diag/crdump.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/diag/crdump.c b/drivers/net/ethernet/mellanox/mlx5/core/diag/crdump.c
index 28d02749d3c4..7659ad21e6e5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/diag/crdump.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/diag/crdump.c
@@ -55,7 +55,10 @@ int mlx5_crdump_collect(struct mlx5_core_dev *dev, u32 *cr_data)
 	ret = mlx5_vsc_sem_set_space(dev, MLX5_SEMAPHORE_SW_RESET,
 				     MLX5_VSC_LOCK);
 	if (ret) {
-		mlx5_core_warn(dev, "Failed to lock SW reset semaphore\n");
+		if (ret == -EBUSY)
+			mlx5_core_info(dev, "SW reset semaphore is already in use\n");
+		else
+			mlx5_core_warn(dev, "Failed to lock SW reset semaphore\n");
 		goto unlock_gw;
 	}
 
-- 
2.41.0


