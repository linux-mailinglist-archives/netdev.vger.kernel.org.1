Return-Path: <netdev+bounces-59399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A343F81ABF7
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 01:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 441511F22FA9
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 00:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC6228FC;
	Thu, 21 Dec 2023 00:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7yhkVSw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86507A939
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 00:57:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393E6C433CA;
	Thu, 21 Dec 2023 00:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703120270;
	bh=bIDQ4AKpaNonIFYk9ferFztQ4SEfb+Lt+mCsNZvE9pI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U7yhkVSwPrVf6F+WonM1BhZwHdsD0rdswWeB5U/rKykZAhLFbM8W95oU+g8+8Wyd1
	 zQe1nyjSKWlfYojWk3Ryaf7+5mcjghdGv1ZR9968pqtjKRkG0/NiNb0//zSgGauRG9
	 IMRnsTX/p+RXlnLrl8NEeR3XJsmPZJAc6YjcvWhgismusTCdSGxlv8Q5OesNOg+4vd
	 Mo6eON71Mo9l+RZ3FwITms07YtutnUy7EWQS8OjOt7Xxysb7w14aYjxlTTzqCwNE45
	 Aqt+g3QqgLkQeoQ92RHwrxCreOVyv4XSHFJ9C1yNRxyrTwVxUzqT3y9X0YxM9a5ozk
	 LE/XQUxPWWAYA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>
Subject: [net-next 14/15] net/mlx5: Enable SD feature
Date: Wed, 20 Dec 2023 16:57:20 -0800
Message-ID: <20231221005721.186607-15-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221005721.186607-1-saeed@kernel.org>
References: <20231221005721.186607-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tariq Toukan <tariqt@nvidia.com>

Have an actual mlx5_sd instance in the core device, and fix the getter
accordingly. This allows SD stuff to flow, the feature becomes supported
only here.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h | 3 ++-
 include/linux/mlx5/driver.h                        | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h
index 0810b92b48d0..37d5f445598c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h
@@ -59,10 +59,11 @@ struct mlx5_sd;
 
 static inline struct mlx5_sd *mlx5_get_sd(struct mlx5_core_dev *dev)
 {
-	return NULL;
+	return dev->sd;
 }
 
 static inline void mlx5_set_sd(struct mlx5_core_dev *dev, struct mlx5_sd *sd)
 {
+	dev->sd = sd;
 }
 #endif
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index aafb36c9e5d9..cd286b681970 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -822,6 +822,7 @@ struct mlx5_core_dev {
 	struct blocking_notifier_head macsec_nh;
 #endif
 	u64 num_ipsec_offloads;
+	struct mlx5_sd          *sd;
 };
 
 struct mlx5_db {
-- 
2.43.0


