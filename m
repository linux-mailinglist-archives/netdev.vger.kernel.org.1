Return-Path: <netdev+bounces-35132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 840277A72FD
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 08:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D2422819BA
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 06:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5719DC8DE;
	Wed, 20 Sep 2023 06:36:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4748EC8DD
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 06:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B02C43397;
	Wed, 20 Sep 2023 06:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695191772;
	bh=1MpMA1ZY2Tu59wjimrOZ0yw6YgENDvqiPLirA02/6oE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e+8QoPuK2W+mpZ2YwUfkAbN1osPgZrr6RfisUu9lKgzg6ph2UeDmyMpJ65Ajw2Ehf
	 BWX6j5RIiYI5WXV/UFqVp1jOg4MIV2G+QpQ+YA64YDAbY6BjUe9faT0tgfxXeV3Awu
	 6utU05E2SCSxprDty/v0aD6D29mpMpbMcp7w7D22IFYJLtJnMQSejWeIdyzVsldh1S
	 JmevMY0E4V7aKMW7YnX45opYA5p4HfYbjsS86JzY0XX6rlBDOwtJSCOsOMzFpXlpe7
	 lwR5+qVp1iEuu/o0HkwYBlY/jy3yc4eJ4ZUtxmq/73d7CLH7YoGEuJkXe6mbpAcSz7
	 dyT6n5AWTvr9Q==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Shay Drory <shayd@nvidia.com>
Subject: [net-next 14/15] net/mlx5: Add a health error syndrome for pci data poisoned
Date: Tue, 19 Sep 2023 23:35:51 -0700
Message-ID: <20230920063552.296978-15-saeed@kernel.org>
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

From: Moshe Shemesh <moshe@nvidia.com>

Add new health error syndrome to indicate that pci data poisoned error
has been received while fetching device ICM data.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/health.c | 2 ++
 include/linux/mlx5/mlx5_ifc.h                    | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/health.c b/drivers/net/ethernet/mellanox/mlx5/core/health.c
index 2fb2598b775e..1c220048ae9a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
@@ -365,6 +365,8 @@ static const char *hsynd_str(u8 synd)
 		return "FFSER error";
 	case MLX5_INITIAL_SEG_HEALTH_SYNDROME_HIGH_TEMP_ERR:
 		return "High temperature";
+	case MLX5_INITIAL_SEG_HEALTH_SYNDROME_ICM_PCI_POISONED_ERR:
+		return "ICM fetch PCI data poisoned error";
 	default:
 		return "unrecognized error";
 	}
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index dd8421d021cf..b23d8ff286a1 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -10574,6 +10574,7 @@ enum {
 	MLX5_INITIAL_SEG_HEALTH_SYNDROME_EQ_INV                       = 0xe,
 	MLX5_INITIAL_SEG_HEALTH_SYNDROME_FFSER_ERR                    = 0xf,
 	MLX5_INITIAL_SEG_HEALTH_SYNDROME_HIGH_TEMP_ERR                = 0x10,
+	MLX5_INITIAL_SEG_HEALTH_SYNDROME_ICM_PCI_POISONED_ERR         = 0x12,
 };
 
 struct mlx5_ifc_initial_seg_bits {
-- 
2.41.0


