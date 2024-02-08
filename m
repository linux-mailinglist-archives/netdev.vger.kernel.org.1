Return-Path: <netdev+bounces-70090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6D984D93B
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 04:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 275A41C23B3F
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 03:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999E936114;
	Thu,  8 Feb 2024 03:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4lX4xqP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC8E19470
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 03:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707364462; cv=none; b=iPqafktotOyqcvqBC2hgoK5TOUDV/+wohNmc6HrukjQkPWzkojjm9fVuDbnQ6Gnkny3aJjQ7XOvbNPPygjeF1VrkcD5WtBfcnBiIVu5gc/PKIH0UWjboYPNz0PlJXe5skWHNKKWOXjePpnLkfYtODDwsV9hdAadnjgyRFSe5SC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707364462; c=relaxed/simple;
	bh=AO2G8kRjzb/fIqTPy+Ncmy681b1P5a6yj+QVpp9CxJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgVr0dOofywh3M4KIBnXZ5txrXqtwrSHR5a9D12ganPzUbiM8bwf8j5LdX9lW96Qx5YQDVKTTM7BUNPiCi4T7IAbwPCsiCY5qc9sMxXus5oK0c9c7AaNrbl5Bi+8HMhkRaedhvkspSxp2XnSax2sIQJVpPah2w+7IlN1Z1BZJNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4lX4xqP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC31BC43390;
	Thu,  8 Feb 2024 03:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707364462;
	bh=AO2G8kRjzb/fIqTPy+Ncmy681b1P5a6yj+QVpp9CxJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a4lX4xqP/75g/JPLxxptxxtvzuIlLr93cdLi7gFbskYurSjYMWid9NRn68iIW86pY
	 H5z9S5IE9GiPrwZppCxeMEKNsw3bqyjtNyKmQjvRcvXrtUdwh0BemWgoLEd9jS5yMZ
	 HQRV75xXNzUyKzVAk7aT45tGDXPBIO+0DNMrIGu6vxJpx4pzgrZjaim47bX8DIRQU1
	 d8umjghR0Aovsj7u+7eGgmPK+PKk39yikOVqfV8ckxbGUF5O94587EzDT0ZZJ/Vp+4
	 OPRkb8eJXkk4P7kYIgjBwy7odmMb2MC4JGpwv8C/I8yxxiznDufGsbufEA+q2Lu0nY
	 VTxEQkYG0YHTg==
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
Subject: [net-next V2 13/15] net/mlx5e: Block TLS device offload on combined SD netdev
Date: Wed,  7 Feb 2024 19:53:50 -0800
Message-ID: <20240208035352.387423-14-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208035352.387423-1-saeed@kernel.org>
References: <20240208035352.387423-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tariq Toukan <tariqt@nvidia.com>

1) Each TX TLS device offloaded context has its own TIS object.  Extra work
is needed to get it working in a SD environment, where a stream can move
between different SQs (belonging to different mdevs).

2) Each RX TLS device offloaded context needs a DEK object from the DEK
pool.

Extra work is needed to get it working in a SD environment, as the DEK
pool currently falsely depends on TX cap, and is on the primary device
only.

Disallow this combination for now.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
index 984fa04bd331..e3e57c849436 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
@@ -96,7 +96,7 @@ bool mlx5e_is_ktls_rx(struct mlx5_core_dev *mdev)
 {
 	u8 max_sq_wqebbs = mlx5e_get_max_sq_wqebbs(mdev);
 
-	if (is_kdump_kernel() || !MLX5_CAP_GEN(mdev, tls_rx))
+	if (is_kdump_kernel() || !MLX5_CAP_GEN(mdev, tls_rx) || mlx5_get_sd(mdev))
 		return false;
 
 	/* Check the possibility to post the required ICOSQ WQEs. */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h
index f11075e67658..adc6d8ea0960 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h
@@ -11,6 +11,7 @@
 
 #ifdef CONFIG_MLX5_EN_TLS
 #include "lib/crypto.h"
+#include "lib/mlx5.h"
 
 struct mlx5_crypto_dek *mlx5_ktls_create_key(struct mlx5_crypto_dek_pool *dek_pool,
 					     struct tls_crypto_info *crypto_info);
@@ -61,7 +62,8 @@ void mlx5e_ktls_rx_resync_destroy_resp_list(struct mlx5e_ktls_resync_resp *resp_
 
 static inline bool mlx5e_is_ktls_tx(struct mlx5_core_dev *mdev)
 {
-	return !is_kdump_kernel() && MLX5_CAP_GEN(mdev, tls_tx);
+	return !is_kdump_kernel() && MLX5_CAP_GEN(mdev, tls_tx) &&
+		!mlx5_get_sd(mdev);
 }
 
 bool mlx5e_is_ktls_rx(struct mlx5_core_dev *mdev);
-- 
2.43.0


