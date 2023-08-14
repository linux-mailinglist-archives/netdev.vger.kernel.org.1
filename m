Return-Path: <netdev+bounces-27503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C453177C2A2
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 23:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C977281242
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 21:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B0B11197;
	Mon, 14 Aug 2023 21:42:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7A211CB2
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 21:42:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465D5C43391;
	Mon, 14 Aug 2023 21:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692049323;
	bh=poCygf5KZOFk58h8CIxNtM8dhTjzJn3E9NOFzFJNA04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZrU3+B+y1sHZR9vABnFtwk8RNrFeu8Q24xf1wJCENQqsSfE0s1UYKbFv/r2iiH0ot
	 nOxw+okJbDl5JJ28KBtBC+u9x74XJO+KeHL6Dr2aEMiSmItGx8bQnVnIixGZ4V4w81
	 8WUR8wmz4hOpvdKJ/NwzL0IhbbI8c9X0ezFtdAoP6VffX5nz5VPuiEAGhGxFFj2fbX
	 vYq7dxsh+iVHOfKpd6haZBUCmnQMlWiJqCiDMFVgW8Xeys5n4A1v06vevmokeXCTR4
	 TiByBMKczIXcz/jfrNuGS4axmezQuF7lNkoXq7y9hlS4ZiPGOsG/RkZKCmG0tXdkxv
	 hIJBq/NMYw2ew==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Shay Drory <shayd@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>
Subject: [net-next 14/14] net/mlx5: Don't query MAX caps twice
Date: Mon, 14 Aug 2023 14:41:44 -0700
Message-ID: <20230814214144.159464-15-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814214144.159464-1-saeed@kernel.org>
References: <20230814214144.159464-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shay Drory <shayd@nvidia.com>

Whenever mlx5 driver is probed or reloaded, it queries some capabilities
in MAX mode via set_hca_cap() API. Afterwards, the driver queries all
capabilities in MAX mode via mlx5_query_hca_caps() API.

Since MAX caps are read only caps, querying them twice is redundant.
Hence, delete the second query.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fw.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw.c b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
index 0e394408af75..58f4c0d0fafa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
@@ -143,18 +143,18 @@ int mlx5_query_hca_caps(struct mlx5_core_dev *dev)
 {
 	int err;
 
-	err = mlx5_core_get_caps(dev, MLX5_CAP_GENERAL);
+	err = mlx5_core_get_caps_mode(dev, MLX5_CAP_GENERAL, HCA_CAP_OPMOD_GET_CUR);
 	if (err)
 		return err;
 
 	if (MLX5_CAP_GEN(dev, port_selection_cap)) {
-		err = mlx5_core_get_caps(dev, MLX5_CAP_PORT_SELECTION);
+		err = mlx5_core_get_caps_mode(dev, MLX5_CAP_PORT_SELECTION, HCA_CAP_OPMOD_GET_CUR);
 		if (err)
 			return err;
 	}
 
 	if (MLX5_CAP_GEN(dev, hca_cap_2)) {
-		err = mlx5_core_get_caps(dev, MLX5_CAP_GENERAL_2);
+		err = mlx5_core_get_caps_mode(dev, MLX5_CAP_GENERAL_2, HCA_CAP_OPMOD_GET_CUR);
 		if (err)
 			return err;
 	}
@@ -174,19 +174,19 @@ int mlx5_query_hca_caps(struct mlx5_core_dev *dev)
 	}
 
 	if (MLX5_CAP_GEN(dev, pg)) {
-		err = mlx5_core_get_caps(dev, MLX5_CAP_ODP);
+		err = mlx5_core_get_caps_mode(dev, MLX5_CAP_ODP, HCA_CAP_OPMOD_GET_CUR);
 		if (err)
 			return err;
 	}
 
 	if (MLX5_CAP_GEN(dev, atomic)) {
-		err = mlx5_core_get_caps(dev, MLX5_CAP_ATOMIC);
+		err = mlx5_core_get_caps_mode(dev, MLX5_CAP_ATOMIC, HCA_CAP_OPMOD_GET_CUR);
 		if (err)
 			return err;
 	}
 
 	if (MLX5_CAP_GEN(dev, roce)) {
-		err = mlx5_core_get_caps(dev, MLX5_CAP_ROCE);
+		err = mlx5_core_get_caps_mode(dev, MLX5_CAP_ROCE, HCA_CAP_OPMOD_GET_CUR);
 		if (err)
 			return err;
 	}
-- 
2.41.0


