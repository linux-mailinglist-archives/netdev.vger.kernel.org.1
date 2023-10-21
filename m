Return-Path: <netdev+bounces-43201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6E67D1B65
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 08:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 243AE1C210A5
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 06:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3477FCA63;
	Sat, 21 Oct 2023 06:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODrkHSe2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17743DDA8
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 06:46:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC923C433C7;
	Sat, 21 Oct 2023 06:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697870803;
	bh=h+TraR7U/vpasMo1QJNshUN9yRlswbJs8I0ZXV20E6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ODrkHSe2HoHs6XKVAcvmNFTiKR5TtLYu+MGRvc6vPNyQEZjXQm2zQCk9QzbJcdEWm
	 drRfC86i4ds9qBpHb7AyDbth0dFJzYeMf2JJVmXiCXLMqbB0OJaaJRR1vbN/qmcc/y
	 FqQCEVr/DLKYDg8Uy6Yn9eSmdH6lfSQbrx4XodIQK6k/lnyL2OPaIg22tz/t/H9bty
	 Y01oi8VJAXLBJaQ4kxHbty3NDUYq62yc5Bs/N2FVOcRT0Nl0EPeihYZUeK5XJ2m+bX
	 ir5zhtpSprg4cGu+qzWrdgo+IvhXeg/A6E56ZKzGVAP6X/0uaIa3dqIhkno4VX6xSv
	 NzYA2bdzYUCcA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Shay Drory <shayd@nvidia.com>
Subject: [net-next V2 14/15] net/mlx5: print change on SW reset semaphore returns busy
Date: Fri, 20 Oct 2023 23:46:19 -0700
Message-ID: <20231021064620.87397-15-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231021064620.87397-1-saeed@kernel.org>
References: <20231021064620.87397-1-saeed@kernel.org>
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


