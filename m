Return-Path: <netdev+bounces-57181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D763B812504
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 03:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77E14B2112B
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 02:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222661368;
	Thu, 14 Dec 2023 02:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jF7Gov9H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B4B184E
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 02:08:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AC0C433C8;
	Thu, 14 Dec 2023 02:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702519724;
	bh=9GLGJpeOE3NzuK1dnnT1fcd5mix5534yE3LtBtVUq88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jF7Gov9HiEKHiMKdt5wEuXVg7EVeaa49g68sRiqP26+HBgkGG7mehGQIqHx8bJo2N
	 bZ+vw58dFXKk/Aosn6l+duNYnBIWV2jBOcpbEQrgD4HI+NSxGFrxI8KgKZ0k1IpJTr
	 8EDulCvgyGctnuwqA4UjpJVsbGpOg74584pSjD9uMf5hbyTvCipXzNFsMYzgrobLVL
	 WB3kZ7oRecL78rjsZ5o0YRXFie4MTzYvMiQ03HVH8hynRTy+HMitFdwzoMT1ONnPfw
	 tHpUVq5pKg39c8PnrZ872BNCoIUwxQfPXHVBpZF1Cuxir+fMhKISG3/ttZkZb5iMq8
	 Wv/qGlRhxG8Lw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>
Subject: [net-next 05/11] net/mlx5e: Remove TLS-specific logic in generic create TIS API
Date: Wed, 13 Dec 2023 18:08:26 -0800
Message-ID: <20231214020832.50703-6-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214020832.50703-1-saeed@kernel.org>
References: <20231214020832.50703-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tariq Toukan <tariqt@nvidia.com>

TLS TISes are created using their own dedicated functions,
don't honor their specific logic here.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 26a98cfb0a59..b49b7c28863c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3357,9 +3357,6 @@ int mlx5e_create_tis(struct mlx5_core_dev *mdev, void *in, u32 *tisn)
 
 	MLX5_SET(tisc, tisc, transport_domain, mdev->mlx5e_res.hw_objs.td.tdn);
 
-	if (MLX5_GET(tisc, tisc, tls_en))
-		MLX5_SET(tisc, tisc, pd, mdev->mlx5e_res.hw_objs.pdn);
-
 	if (mlx5_lag_is_lacp_owner(mdev))
 		MLX5_SET(tisc, tisc, strict_lag_tx_port_affinity, 1);
 
-- 
2.43.0


