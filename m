Return-Path: <netdev+bounces-65368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD70783A3F8
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 09:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EA06B226D3
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 08:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08841756A;
	Wed, 24 Jan 2024 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8xHij+r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0F61798F
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706084360; cv=none; b=ifFamNAU0FzGmQNh72p7kVjrOObEJabw+wJ4yxNdRrOuKbL9iuVPwE2YrkYNB9dOlYMQ38WPTQC9YPiGYQBox45NmPx3R7QkqWV6jWqQatAHN6mmZ+8Ul55bTgMApYcU7MR3oL2J3hUJ/t/+FS/ZVLGSjxn/mRlWua8j1bMQRvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706084360; c=relaxed/simple;
	bh=I+AiO1/6WaQit2HdivL44agcEEtZTWtSjXHqFrKl77o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBGNcVEZM0/41oqvAvoM6GUmcDmLs1G9YAyBEVr7jro4H9zmG4DUebMtDmL5xwbNtOuxuNlXWMqMYDl1XnIZCEWATCrkXQuaiTDqGoZUx8uSx3MmJCgIhwYGBk4a23IgUGiP7K8OlSmAEet4DHdgGDOKWubmGaA7Iq98XWlZan0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8xHij+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7044DC433F1;
	Wed, 24 Jan 2024 08:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706084360;
	bh=I+AiO1/6WaQit2HdivL44agcEEtZTWtSjXHqFrKl77o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I8xHij+rsj3xVzCanKnTdDj3YzD8k9fWyd6F5+TpdbKSOESDkqjFJZnoIHdVJ2l1W
	 AQNXzM219fzxZWLPOzY/2CS5aUKymB7/eaIK8o+evrBkm98oFr88aZTAUHHPyheV5V
	 E9MfHTl1jqatI1IIBreosJrEdsJoW8HdSzqsaeSgONt0TQe/fuUIciBm3RTnIiE0TJ
	 tQ0/qf+EWV6M2lnONTg6I/QkEfGCbmQZ4tmNA7US5yR1OsE5DAwiaP6Kx2HjyuTmhR
	 /9X1bw090i3ClO+DNlyNPqik7BlTVRz6mRyUprlgCVWTaXoJoKojqsJcBTx7O9EMA0
	 jtUvoV41n0qBQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [net 11/14] net/mlx5e: Allow software parsing when IPsec crypto is enabled
Date: Wed, 24 Jan 2024 00:18:52 -0800
Message-ID: <20240124081855.115410-12-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124081855.115410-1-saeed@kernel.org>
References: <20240124081855.115410-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

All ConnectX devices have software parsing capability enabled, but it is
more correct to set allow_swp only if capability exists, which for IPsec
means that crypto offload is supported.

Fixes: 2451da081a34 ("net/mlx5: Unify device IPsec capabilities check")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/params.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 284253b79266..5d213a9886f1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -1064,8 +1064,8 @@ void mlx5e_build_sq_param(struct mlx5_core_dev *mdev,
 	void *wq = MLX5_ADDR_OF(sqc, sqc, wq);
 	bool allow_swp;
 
-	allow_swp =
-		mlx5_geneve_tx_allowed(mdev) || !!mlx5_ipsec_device_caps(mdev);
+	allow_swp = mlx5_geneve_tx_allowed(mdev) ||
+		    (mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_CAP_CRYPTO);
 	mlx5e_build_sq_param_common(mdev, param);
 	MLX5_SET(wq, wq, log_wq_sz, params->log_sq_size);
 	MLX5_SET(sqc, sqc, allow_swp, allow_swp);
-- 
2.43.0


