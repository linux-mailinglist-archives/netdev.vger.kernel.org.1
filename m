Return-Path: <netdev+bounces-77754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5AF872D34
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 04:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5FAF1C25E63
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 03:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0EE1B299;
	Wed,  6 Mar 2024 03:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dt/4xeeA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838E51AACB
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 03:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709694206; cv=none; b=n1lFfQXSaQTLv6g9RG+JqpIWRZ0LaUX45zxvUyovBtZeOIZ+2rkeiIGiNmowcnzBDTNn1JxJGffPNeqlNwZwbkIdII4G0Fo1sfy9bB8loB+BznI7HQf0Idmb69hk5zHHfUWutP9C6yPrFdT1B2ZDSRxnNZt0PKi3kLuAeLNow5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709694206; c=relaxed/simple;
	bh=LByt4fDpvLI3yHzi5uT7STPE49xcc8ESEhlPMZSXQHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jbtF02uJ6of3G73RLlURXlcdnKRWO33B3q4vxFtROGfCSGarWbIHc0q/kCI5OZLwvx9HiQLyfGqThtE4QC8t6fk5HJKKcpQvfevMZeOfDUwN/YstyDiWa66VEN2VCHqar+nZ+H6dQTOoTUBpWdmS9qWxl+VBoH/UW/s6tlldfO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dt/4xeeA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF82BC433F1;
	Wed,  6 Mar 2024 03:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709694204;
	bh=LByt4fDpvLI3yHzi5uT7STPE49xcc8ESEhlPMZSXQHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dt/4xeeAzFbKl0fVrTo1xkTOQJGgaQZJry2tmm+DgXic59KkLKzlv/ota/x0EwQaT
	 1Peac4x7sZ0PKzx8fam8JRByn61b2bQJ6qKU4tD5TUMPes4aDKEFzB8NIZGBRGc4FJ
	 FNy6sW7EZ8MXesOghL/lvcwa4LcWAMPWyGf11xgvt8zpv53v+B0iNUdN52KuzV3VoE
	 Wc6rfDgQf4x1v92i0ZvC113beIl2Z23tiKNKeV/bGfAlD9PkeDHwCdu2AaeElSOgy3
	 2d3x0XG1JTGY+3oCa8liVikMHSuvGAoO9akSfest/+SrJz9W5rsJKDvWEG5dCY1fcZ
	 5wfxvM9qIfZmQ==
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
Subject: [net-next V5 13/15] net/mlx5e: Block TLS device offload on combined SD netdev
Date: Tue,  5 Mar 2024 19:02:56 -0800
Message-ID: <20240306030258.16874-14-saeed@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240306030258.16874-1-saeed@kernel.org>
References: <20240306030258.16874-1-saeed@kernel.org>
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


