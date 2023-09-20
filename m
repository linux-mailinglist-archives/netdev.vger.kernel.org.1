Return-Path: <netdev+bounces-35196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 144777A789A
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 12:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0472281CCE
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 10:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE2015ACF;
	Wed, 20 Sep 2023 10:08:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF8215AC3
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 10:08:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB42C433C8;
	Wed, 20 Sep 2023 10:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695204483;
	bh=o+qXj8W7DVoYQY75qK0NxoUqduddIC1gpz+smx2PevM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KRR6FXeT5AiW6/DkOLsjN6sdIp8u5kb5ntic7SMz0hxatwt6TDsYUDYi7SgGDW9fV
	 Rk262MQwrobsyVIhMGPAl9nJTxfBT2cv0YJwPHOtglJZozGY3CLUamyL2Oso6jy/pM
	 mAg5VH6irnF62svLk7PV/gfhb1uW4Hc8ud36kOpwT2XfHSoowPLa0ZYWIers4Ekwkx
	 Dgk0xo2PxcTSJZjQfRCPfDoxiaCjvHhB26jcUeG1sxQNc9IVmSCW5k7DRNXRuYj0X/
	 1UVCzAiMBZEheKzY3JMKjXF5fbpCh1+nnoeSW8mFUyUt7Ne7w/tRXaBdS4biS5M0Ub
	 6+JN09mzPDVhg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	Mark Zhang <markzhang@nvidia.com>,
	netdev@vger.kernel.org,
	Or Har-Toov <ohartoov@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH rdma-next 3/6] IB/mlx5: Add support for 800G_8X lane speed
Date: Wed, 20 Sep 2023 13:07:42 +0300
Message-ID: <26fd0b6e1fac071c3eb779657bb3d8ba47f47c4f.1695204156.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695204156.git.leon@kernel.org>
References: <cover.1695204156.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrisious Haddad <phaddad@nvidia.com>

Add a check for 800G_8X speed when querying PTYS and report it back
correctly when needed.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c              | 4 ++++
 drivers/net/ethernet/mellanox/mlx5/core/port.c | 1 +
 include/linux/mlx5/port.h                      | 1 +
 3 files changed, 6 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index f9286820ad3b..830dac95c163 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -482,6 +482,10 @@ static int translate_eth_ext_proto_oper(u32 eth_proto_oper, u16 *active_speed,
 		*active_width = IB_WIDTH_4X;
 		*active_speed = IB_SPEED_NDR;
 		break;
+	case MLX5E_PROT_MASK(MLX5E_800GAUI_8_800GBASE_CR8_KR8):
+		*active_width = IB_WIDTH_8X;
+		*active_speed = IB_SPEED_NDR;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/port.c b/drivers/net/ethernet/mellanox/mlx5/core/port.c
index be70d1f23a5d..43423543f34c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/port.c
@@ -1102,6 +1102,7 @@ static const u32 mlx5e_ext_link_speed[MLX5E_EXT_LINK_MODES_NUMBER] = {
 	[MLX5E_100GAUI_1_100GBASE_CR_KR] = 100000,
 	[MLX5E_200GAUI_2_200GBASE_CR2_KR2] = 200000,
 	[MLX5E_400GAUI_4_400GBASE_CR4_KR4] = 400000,
+	[MLX5E_800GAUI_8_800GBASE_CR8_KR8] = 800000,
 };
 
 int mlx5_port_query_eth_proto(struct mlx5_core_dev *dev, u8 port, bool ext,
diff --git a/include/linux/mlx5/port.h b/include/linux/mlx5/port.h
index 98b2e1e149f9..794001ebd003 100644
--- a/include/linux/mlx5/port.h
+++ b/include/linux/mlx5/port.h
@@ -117,6 +117,7 @@ enum mlx5e_ext_link_mode {
 	MLX5E_200GAUI_2_200GBASE_CR2_KR2	= 13,
 	MLX5E_400GAUI_8				= 15,
 	MLX5E_400GAUI_4_400GBASE_CR4_KR4	= 16,
+	MLX5E_800GAUI_8_800GBASE_CR8_KR8	= 19,
 	MLX5E_EXT_LINK_MODES_NUMBER,
 };
 
-- 
2.41.0


