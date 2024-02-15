Return-Path: <netdev+bounces-71939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C69FC85595D
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 04:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59F7E29201A
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 03:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8971B950;
	Thu, 15 Feb 2024 03:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbzS3PUX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C271BC41
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 03:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707966512; cv=none; b=IXqXUMj4dMuBPOo8KuTbxOhQWhRaLM9R1XGr9MXqHeJCSYdKH31wghrv0QINmsvnBmqwPgWWA+xMttUIVBnY+DuNDFUH8Y4wNTRzittK1paVHlAiMVOGpGHTJsYU3oM+zXNeu3OxbnVTk6orkyfKbK90tT3U5zwTlvVQhwh9fNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707966512; c=relaxed/simple;
	bh=AO2G8kRjzb/fIqTPy+Ncmy681b1P5a6yj+QVpp9CxJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XpriK5a+Cc2d4CSY6YIHKZAit0BOlFJtLxWySb3MD/BXLztWnDjkQ9Fw5Fie09SrmqP1Jvj72CukoFigiNIOlcrD40kh/bPguIp01kPKloMDPXWSxmzbt5l3yIE1IWgc51i0w89ElCHqvQx0NwldTydw3PmTEgh/gGJJ7vjnFn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbzS3PUX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C8BC433C7;
	Thu, 15 Feb 2024 03:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707966512;
	bh=AO2G8kRjzb/fIqTPy+Ncmy681b1P5a6yj+QVpp9CxJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MbzS3PUXDD/V05/i67bj6TsdBqAJ+5a0i9518qm/pbVgMdbV+pLBqFOe8W7w9t+Kd
	 +p53BG/bhh8UGzXM2Jd9UtbS7nZJUe4LepBfgfZwHTI+oRO6MMcz3TrAlqPNl/juDn
	 ssut/XLetkhGYi+sWl6BaMhaawqZ5Af6wypzznGlxbV9ISxwl+5dXPA6FAi5/6NKni
	 r90VDvnTsa30RdW4894DP0OQ0mGo3bS3012YLl32dsMTiPIzDgpRgBfcKDfKYmbLdl
	 1s46VS2Rh1mMw3oEathvc8enwyGdV1Dd1xH9aAx6NGLtf4I2zCyBxn6KQ1TN+xAxhd
	 vc+He/csdYQZQ==
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
Subject: [net-next V3 13/15] net/mlx5e: Block TLS device offload on combined SD netdev
Date: Wed, 14 Feb 2024 19:08:12 -0800
Message-ID: <20240215030814.451812-14-saeed@kernel.org>
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


