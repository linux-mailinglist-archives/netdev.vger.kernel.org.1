Return-Path: <netdev+bounces-22021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD81765B79
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 20:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C566728217A
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 18:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FB719896;
	Thu, 27 Jul 2023 18:39:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EC71803A
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 18:39:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9190C433CB;
	Thu, 27 Jul 2023 18:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690483166;
	bh=ABjJUvz3QYk3yvgCm/xsksESzgHacOgmbmYQ4O1ZdH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cCSSgf5K8OFuzkDVfsHBVmWCPTzbXZ+VaPaVFgfEsD5IVyqtrVazZn3MnoVwlpQ81
	 g8bcquP+dudRy/5BSS/pTIkSjnM3h2nmkOVObMkgU3/qpWLqyPizvnFXt29F051uBM
	 KYc74VjMfR852dZdJpB2tbSbdSZhR1l6JOHDYxDDuAzn6B70ZxjS81M7Kt1XA3PNCS
	 UIRfL19UF8T3EJH9R/9Ud6ai2rMHkF7k7dEYkdCC6U04XfGzsVyJMgaVR6nLnGdunp
	 KzMg+cxGtTHyT2s3hmwx/ye+QzCv6A64bWf9mCRvHcIhwrr5InamKP00zx0aG5BioT
	 uUbeBs8MMqhbg==
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
Subject: [net-next V2 04/15] net/mlx5e: E-Switch, Allow devcom initialization on more vports
Date: Thu, 27 Jul 2023 11:39:03 -0700
Message-ID: <20230727183914.69229-5-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727183914.69229-1-saeed@kernel.org>
References: <20230727183914.69229-1-saeed@kernel.org>
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


