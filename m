Return-Path: <netdev+bounces-35123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F8E7A72DE
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 08:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B5CF1C209AD
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 06:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0158493;
	Wed, 20 Sep 2023 06:36:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E5A8475
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 06:36:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFEBC433CA;
	Wed, 20 Sep 2023 06:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695191763;
	bh=KlvOUU0P6aIhdXDuJ8/ABMzAhvqzUWvtyCx8rBoO9y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dAHz5G5eppnwLyRbS4/KLyT/7jKzFB2Z06bdfZ4pkwSo2W+X/pVZcLtR3Q6jkNO5/
	 Hb9ExHmzNvtrkJ9ZaUDpJilGff3gYonYhRaqYDk7i0sDsGA92r9kVKBVXfE7fFy3Aa
	 L0X9lQJVfMvhRHMwn4C8glgpSbcot1ZPNT8eATlE9d5A0z3mDMjRKRnzyj0Y/5Ionf
	 APzsfxvPPKiZAa2yVVzdv2+QSNWmxvgF9r1Fwwaand3Ihm2cO5jvfsTAHw3Q9biyIC
	 KMDE5WqBiZG7Xu/6vzDGXn6vyKQlzeTonXk7VIUfz+dcFHUX6GUYNJb5RS4fu/Qnx6
	 Kmk1uvzFiIO8Q==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Shay Drory <shayd@nvidia.com>
Subject: [net-next 05/15] net/mlx5: Rename mlx5_sf_deactivate_all() to mlx5_sf_del_all()
Date: Tue, 19 Sep 2023 23:35:42 -0700
Message-ID: <20230920063552.296978-6-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920063552.296978-1-saeed@kernel.org>
References: <20230920063552.296978-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

The function does not do deactivation, but it deletes all SFs instead.
Rename accordingly.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
index bed3fe8759d2..454185ef04f3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
@@ -437,7 +437,7 @@ static void mlx5_sf_table_enable(struct mlx5_sf_table *table)
 	refcount_set(&table->refcount, 1);
 }
 
-static void mlx5_sf_deactivate_all(struct mlx5_sf_table *table)
+static void mlx5_sf_del_all(struct mlx5_sf_table *table)
 {
 	struct mlx5_eswitch *esw = table->dev->priv.eswitch;
 	unsigned long index;
@@ -463,7 +463,7 @@ static void mlx5_sf_table_disable(struct mlx5_sf_table *table)
 	mlx5_sf_table_put(table);
 	wait_for_completion(&table->disable_complete);
 
-	mlx5_sf_deactivate_all(table);
+	mlx5_sf_del_all(table);
 }
 
 static int mlx5_sf_esw_event(struct notifier_block *nb, unsigned long event, void *data)
-- 
2.41.0


