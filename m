Return-Path: <netdev+bounces-47448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B71E7EA538
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 22:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951911C209CA
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 21:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE87D2D624;
	Mon, 13 Nov 2023 21:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlUzxNiz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14632D620
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 21:08:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69462C433C8;
	Mon, 13 Nov 2023 21:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699909714;
	bh=ISJcsiIbYTq9C0L3f/fQS5ndWgoPq5kRlXGYJju5rnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BlUzxNizz+n3N05ZNnPmw3OSa7w/59xnFtdbn5AxRyQ6W57Ite6L5XRkQECAf4yRT
	 cZlNrL+5oc6rcgOyIjrGGT7b70iEYEB8rCg7u03E3AUfDDMGjl3nkWE5GIeT1N9xD4
	 DBGRp5Rvph2FJNKWoKkGVTcdacOwezF/DDBjrBuV+rsztijpWMvZW3Igz9pbZNmviH
	 hcbaSjUtcp3KWI+YNgwq6V1N5+HeE9Ws6S0WtmlAVBkkOHcwelkMCR5iSNAgRbJAtG
	 mE/d/YaxcVKtiNfWxBtx2nRh3+rDXxdfv1ewlFn+WrNGfx+pp1Iqjbml4Sd1qezxRW
	 WSDH6KS1mhxkA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Erez Shitrit <erezsh@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: [net 03/17] net/mlx5: DR, Allow old devices to use multi destination FTE
Date: Mon, 13 Nov 2023 13:08:12 -0800
Message-ID: <20231113210826.47593-4-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113210826.47593-1-saeed@kernel.org>
References: <20231113210826.47593-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Erez Shitrit <erezsh@nvidia.com>

The current check isn't aware of old devices that don't have the
relevant FW capability. This patch allows multi destination FTE
in old cards, as it was before this check.

Fixes: f6f46e7173cb ("net/mlx5: DR, Add check for multi destination FTE")
Signed-off-by: Erez Shitrit <erezsh@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
index 6ea88a581804..e3ec559369fa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
@@ -57,7 +57,8 @@ static const char *dr_action_id_to_str(enum mlx5dr_action_type action_id)
 
 static bool mlx5dr_action_supp_fwd_fdb_multi_ft(struct mlx5_core_dev *dev)
 {
-	return (MLX5_CAP_ESW_FLOWTABLE(dev, fdb_multi_path_any_table_limit_regc) ||
+	return (MLX5_CAP_GEN(dev, steering_format_version) < MLX5_STEERING_FORMAT_CONNECTX_6DX ||
+		MLX5_CAP_ESW_FLOWTABLE(dev, fdb_multi_path_any_table_limit_regc) ||
 		MLX5_CAP_ESW_FLOWTABLE(dev, fdb_multi_path_any_table));
 }
 
-- 
2.41.0


