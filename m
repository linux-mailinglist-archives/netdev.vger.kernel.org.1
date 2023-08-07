Return-Path: <netdev+bounces-25160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E63BC77313B
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 23:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FD39281591
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 21:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EEE17FF1;
	Mon,  7 Aug 2023 21:26:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A66D18031
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 21:26:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBB7C433BA;
	Mon,  7 Aug 2023 21:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691443583;
	bh=EMQRkPYOwknWWgtTfAjNOhAPm2Sk+35lsu2Fj9DQAmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OTB13tZXaT1PuNSJd3X3MVPJQCD3sTmHInq4dTgxtaWcUwEZew0s4KnqCctHSp91t
	 zqxvMmrHvQoNak3de3MmVRlI2y7lxWqc2AwJ7fEcla8cyAuRfyasWpG4TutbNx/Nfl
	 MP7lc/w053XUUtUw67SxZDSG8t7Hq0pCOOfjueePhu/DKfLTGu5XjaRexfny/bWhsF
	 3vHnI8jpwxf+D1/KNdsVVLgh38nHNNvjh2w8m+4c5Kgx8u7tvMa2PhYIWkpNapA2De
	 B1lBcL+pe9GMnLc5zMoEmUZ0N/KdOoydZaQnVckUvmzYxchGNFkVXl8/hscHDwwkc2
	 iGdQ6DmDh8QIQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Shay Drory <shayd@nvidia.com>,
	Maor Gottlieb <maorg@nvidia.com>
Subject: [net 08/11] net/mlx5: LAG, Check correct bucket when modifying LAG
Date: Mon,  7 Aug 2023 14:26:04 -0700
Message-ID: <20230807212607.50883-9-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807212607.50883-1-saeed@kernel.org>
References: <20230807212607.50883-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shay Drory <shayd@nvidia.com>

Cited patch introduced buckets in hash mode, but missed to update
the ports/bucket check when modifying LAG.
Fix the check.

Fixes: 352899f384d4 ("net/mlx5: Lag, use buckets in hash mode")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
index d3a3fe4ce670..7d9bbb494d95 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
@@ -574,7 +574,7 @@ static int __mlx5_lag_modify_definers_destinations(struct mlx5_lag *ldev,
 	for (i = 0; i < ldev->ports; i++) {
 		for (j = 0; j < ldev->buckets; j++) {
 			idx = i * ldev->buckets + j;
-			if (ldev->v2p_map[i] == ports[i])
+			if (ldev->v2p_map[idx] == ports[idx])
 				continue;
 
 			dest.vport.vhca_id = MLX5_CAP_GEN(ldev->pf[ports[idx] - 1].dev,
-- 
2.41.0


