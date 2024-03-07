Return-Path: <netdev+bounces-78289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3A38749F7
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 09:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A32111F23FA6
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 08:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EA283CBD;
	Thu,  7 Mar 2024 08:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUXlBqGH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB9D83CA8
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 08:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709800970; cv=none; b=RWokE5SJZsvws3p1BG05tzSdGIZEoPWsevgDkPZfmgjUsC7DRa6lPdzEhigLnO+lEDgxpBuBGYB2ecFxfYfBXX5zkF3rsDrfiOkfV8eOUHewhRNMzSsUfS0d95zWO1tXw0Hu7EJ/c34lqV7zY6P+Q3k+IM9zzNyWk6yvcMstruI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709800970; c=relaxed/simple;
	bh=LByt4fDpvLI3yHzi5uT7STPE49xcc8ESEhlPMZSXQHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tzffcfhuB5a7ry3Z8IC88MkldRIHHtz3hooM83tgjl7ngTzjCUtCJgJwmhUa6bj9gRtkJazAX6s9rdirB51Ux0JqvqxdsXZRjiwJkskHNH9mZs5PSdB5D2vaGbTvDmyxu62JCrZZ0O2ukuIACi5zGO8HrfLx2ys3kuzDKdWFebk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUXlBqGH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E87DC433C7;
	Thu,  7 Mar 2024 08:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709800970;
	bh=LByt4fDpvLI3yHzi5uT7STPE49xcc8ESEhlPMZSXQHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hUXlBqGH1Bfrgt6O7hY94/rajV7ECcEnDK5Tc1Nt79QSo3kxUEpQLwdGqt92qFES+
	 vo9epSVXZK6T0I+wymArOH8PTGVVUBp/RQ9vq6/LFCpjb23q2eEp41HpCuRTn+25cl
	 wXh7x2LsIsvvVBBk46qGvBRWbr/aKhzMqeII/YbK4i+lBI28chQY58JN0oP80hL9m9
	 Wj9moH34Ey/J54IeowXMxIK1hQaOd+7vD/J+ppGbr3ETrusJdUfo0CP/SOfA5b/nQb
	 QjD1BOI24KIwwxH6WED/llf5w+qljLuOpIKuJa2bC4Yh3yFTlbiEhsxee4RcK6/Pod
	 g55ns9PRyeFuA==
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
Subject: [net-next V6 13/15] net/mlx5e: Block TLS device offload on combined SD netdev
Date: Thu,  7 Mar 2024 00:42:27 -0800
Message-ID: <20240307084229.500776-14-saeed@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240307084229.500776-1-saeed@kernel.org>
References: <20240307084229.500776-1-saeed@kernel.org>
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
2.44.0


