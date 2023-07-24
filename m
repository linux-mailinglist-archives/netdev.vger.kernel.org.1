Return-Path: <netdev+bounces-20577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A26C8760297
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 00:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D6EA2815AB
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 22:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB07134A1;
	Mon, 24 Jul 2023 22:44:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6D1134BB
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 22:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF65C433D9;
	Mon, 24 Jul 2023 22:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690238675;
	bh=ABjJUvz3QYk3yvgCm/xsksESzgHacOgmbmYQ4O1ZdH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rd861cEXucZ5QDNbioB/1zoDLFKobxguWlDH0sgvOWmXpQpHKK19qX9MUlOSXkWGa
	 BnyvUvLIJuN1MFyMdosmdKI9elU678HCVtZ3BbZsi6S9CQ6qy7DV8p4t2uMf1phSIF
	 TMsum6UnfqeN44FDg1xXtKl/nV7/VMAAM1eEasWOcWrLLV2sRIQTx6gCR5PjI/oC5V
	 tlM3uJ/uJQQNuAjRdR8ex0nzgIAtZxkfRy2dSxwX7WHdF6UWKbfCFa8ZETA5P2ZFmU
	 KyBSBQ5l9jU+BR4kt8DSKq7HOF/0+5oM+vt35ApVlDtTxBZtkj2BJm900udkiBZAzS
	 ZWSOVWI69DpFw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Roi Dayan <roid@nvidia.com>,
	Shay Drory <shayd@nvidia.com>
Subject: [net-next 06/14] net/mlx5e: E-Switch, Allow devcom initialization on more vports
Date: Mon, 24 Jul 2023 15:44:18 -0700
Message-ID: <20230724224426.231024-7-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230724224426.231024-1-saeed@kernel.org>
References: <20230724224426.231024-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Roi Dayan <roid@nvidia.com>

New features could use the devcom interface but not necessarily
the lag feature although for vport managers and ECPF
still check for lag support.

Signed-off-by: Roi Dayan <roid@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 7d100cd4afab..b4b8cb788573 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2897,7 +2897,8 @@ void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw, u64 key)
 	if (!MLX5_CAP_ESW(esw->dev, merged_eswitch))
 		return;
 
-	if (!mlx5_lag_is_supported(esw->dev))
+	if ((MLX5_VPORT_MANAGER(esw->dev) || mlx5_core_is_ecpf_esw_manager(esw->dev)) &&
+	    !mlx5_lag_is_supported(esw->dev))
 		return;
 
 	xa_init(&esw->paired);
-- 
2.41.0


