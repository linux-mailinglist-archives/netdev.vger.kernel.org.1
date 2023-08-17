Return-Path: <netdev+bounces-28360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F5677F2D4
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 11:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90B96281A82
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 09:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C781095A;
	Thu, 17 Aug 2023 09:12:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D82125B9
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 09:12:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D462C433C8;
	Thu, 17 Aug 2023 09:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692263543;
	bh=AdCGw65Sp30/Y/5xCO8g6GynIgoWlihomWyv4XJymKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H+olRZXS1TLiy5vRSzoua6cc6nqFaAxWsDZqgKVgiU6+/kpkS6KUAU6tW62zkm1eP
	 t8pRfjBb3kZ+C7wbzO5kEo9YqVUcGfTjJNh1sezYvQBHjJFRbWz1lMT/WRUwLP3tnB
	 l6SR4X0WwKJpLtRV0DvkN23WXGg63BRCCtHPfYwLiv0wQA9DmMbmpK5XBRKruBCi1n
	 HxHn/rSPapu4W4XFUTVSjkelcbnmWVRPzmyYK/o+KexbvBiEjOqlf6r0p0LxzGlKBG
	 4qDslSHHpaPANtQH9j5p62gW2sG03VkpERS5B1xHtMC0X4u/o3moaea9YJpO0A10a7
	 C4x/R6gZInEbw==
From: Leon Romanovsky <leon@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Dima Chumak <dchumak@nvidia.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Simon Horman <simon.horman@corigine.com>
Subject: [PATCH net-next v3 3/8] net/mlx5: Drop extra layer of locks in IPsec
Date: Thu, 17 Aug 2023 12:11:25 +0300
Message-ID: <8c50d16c8cbb07ea0aaeeabbbf9439ee3eb6490b.1692262560.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692262560.git.leonro@nvidia.com>
References: <cover.1692262560.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

There is no need in holding devlink lock as it gives nothing
compared to already used write mode_lock.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../mellanox/mlx5/core/eswitch_offloads.c      | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 46b8c60ac39a..ef2bb04f10be 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3879,38 +3879,28 @@ int mlx5_devlink_eswitch_inline_mode_get(struct devlink *devlink, u8 *mode)
 
 bool mlx5_eswitch_block_encap(struct mlx5_core_dev *dev)
 {
-	struct devlink *devlink = priv_to_devlink(dev);
-	struct mlx5_eswitch *esw;
+	struct mlx5_eswitch *esw = dev->priv.eswitch;
 
-	devl_lock(devlink);
-	esw = mlx5_devlink_eswitch_get(devlink);
-	if (IS_ERR(esw)) {
-		devl_unlock(devlink);
-		/* Failure means no eswitch => not possible to change encap */
+	if (!mlx5_esw_allowed(esw))
 		return true;
-	}
 
 	down_write(&esw->mode_lock);
 	if (esw->mode != MLX5_ESWITCH_LEGACY &&
 	    esw->offloads.encap != DEVLINK_ESWITCH_ENCAP_MODE_NONE) {
 		up_write(&esw->mode_lock);
-		devl_unlock(devlink);
 		return false;
 	}
 
 	esw->offloads.num_block_encap++;
 	up_write(&esw->mode_lock);
-	devl_unlock(devlink);
 	return true;
 }
 
 void mlx5_eswitch_unblock_encap(struct mlx5_core_dev *dev)
 {
-	struct devlink *devlink = priv_to_devlink(dev);
-	struct mlx5_eswitch *esw;
+	struct mlx5_eswitch *esw = dev->priv.eswitch;
 
-	esw = mlx5_devlink_eswitch_get(devlink);
-	if (IS_ERR(esw))
+	if (!mlx5_esw_allowed(esw))
 		return;
 
 	down_write(&esw->mode_lock);
-- 
2.41.0


