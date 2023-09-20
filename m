Return-Path: <netdev+bounces-35122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA38B7A72DC
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 08:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64A7E28162E
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 06:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E953747B;
	Wed, 20 Sep 2023 06:36:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE9E8475
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 06:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1145C433C8;
	Wed, 20 Sep 2023 06:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695191762;
	bh=cLBLe7sysdezFUApsta72Mo5zskijgbOxtYj0dZXZec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iy9+mUIVSgJFDmbJ1UnfsEeDULR63ANI3dvfeV40G2F7JAC+NZQTOjOBkdlbffe4+
	 6HcivxyGgQgmzV5k2VJjgTfK2LApZc+nOlGXxw/lO/8iGzHptsT0kplJrPOO+w9p5G
	 /QNMlYuxJFIjaClsigIw120ZH727iV8W5u+zMekWCVZQpFZQqgpJXmbShxmSK0eHF/
	 PhWA7BhiGLt8SIxBfXXusQPrf9IQk2XoHIOqjwinY5sPDqI+pmImPIgKd7xI2Pq6JE
	 9jVxj6ITWwhXjMhoJ17GUu3eYj3UchzHcywHA6DBW1Nny7x5hhhv1Z1xlFBVdORzRn
	 Twz/QGcEFlesQ==
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
Subject: [net-next 04/15] net/mlx5: Move state lock taking into mlx5_sf_dealloc()
Date: Tue, 19 Sep 2023 23:35:41 -0700
Message-ID: <20230920063552.296978-5-saeed@kernel.org>
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

Instead of taking lock and calling mlx5_sf_dealloc(), move the lock
taking into mlx5_sf_dealloc(). The other caller of mlx5_sf_dealloc()
does not need it now, but will need it after a follow-up patch removing
the table reference counting.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
index 78cdfe595a01..bed3fe8759d2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
@@ -341,6 +341,8 @@ int mlx5_devlink_sf_port_new(struct devlink *devlink,
 
 static void mlx5_sf_dealloc(struct mlx5_sf_table *table, struct mlx5_sf *sf)
 {
+	mutex_lock(&table->sf_state_lock);
+
 	mlx5_sf_function_id_erase(table, sf);
 
 	if (sf->hw_state == MLX5_VHCA_STATE_ALLOCATED) {
@@ -358,6 +360,8 @@ static void mlx5_sf_dealloc(struct mlx5_sf_table *table, struct mlx5_sf *sf)
 		mlx5_sf_hw_table_sf_deferred_free(table->dev, sf->controller, sf->id);
 		kfree(sf);
 	}
+
+	mutex_unlock(&table->sf_state_lock);
 }
 
 int mlx5_devlink_sf_port_del(struct devlink *devlink,
@@ -377,10 +381,7 @@ int mlx5_devlink_sf_port_del(struct devlink *devlink,
 	}
 
 	mlx5_eswitch_unload_sf_vport(esw, sf->hw_fn_id);
-
-	mutex_lock(&table->sf_state_lock);
 	mlx5_sf_dealloc(table, sf);
-	mutex_unlock(&table->sf_state_lock);
 	mlx5_sf_table_put(table);
 	return 0;
 }
-- 
2.41.0


