Return-Path: <netdev+bounces-48176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A737ECD80
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 20:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EC91281128
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 19:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A2341AB8;
	Wed, 15 Nov 2023 19:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Odeu2Mbc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D03E41A87
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 19:36:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB5CC433C9;
	Wed, 15 Nov 2023 19:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700077012;
	bh=h+TraR7U/vpasMo1QJNshUN9yRlswbJs8I0ZXV20E6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Odeu2MbclpyFt9vqA3V3Uk8QiuwjFy32EZVWQmoxKJWzHPzOIbmTR8XfSuM82uZwF
	 DNxdWXUSmMM8r9QlLkvt83aDXIXfriNdM3i4xbUkwe+07aO7VdIW3vaegRaIiwCP6l
	 xgfSF+796UIc6MsQg2nGD+VCZA+E2qpIk7WrZr3N20SUitEKOOX0SXFVLPFbbN1VmU
	 /BYCRmvaezvlTp7s+MyNnvd5McO1IkOTXmJXP87yhLNGoFfpc/WuoIdGs1WcEEetYe
	 GgO9SAwYpgSETG0NyCoMODlQzdsTMWXfD+23IKUBIF+qdK2htofE7CK7KIWq5S9/Qd
	 481UUkk9Bdwnw==
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
Subject: [net-next V2 01/13] net/mlx5: print change on SW reset semaphore returns busy
Date: Wed, 15 Nov 2023 11:36:37 -0800
Message-ID: <20231115193649.8756-2-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115193649.8756-1-saeed@kernel.org>
References: <20231115193649.8756-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Moshe Shemesh <moshe@nvidia.com>

While collecting crdump as part of fw_fatal health reporter dump the PF
may fail to lock the SW reset semaphore. Change the print to indicate if
it was due to another PF locked the semaphore already and so trying to
lock the semaphore returned -EBUSY.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/diag/crdump.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/diag/crdump.c b/drivers/net/ethernet/mellanox/mlx5/core/diag/crdump.c
index 28d02749d3c4..7659ad21e6e5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/diag/crdump.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/diag/crdump.c
@@ -55,7 +55,10 @@ int mlx5_crdump_collect(struct mlx5_core_dev *dev, u32 *cr_data)
 	ret = mlx5_vsc_sem_set_space(dev, MLX5_SEMAPHORE_SW_RESET,
 				     MLX5_VSC_LOCK);
 	if (ret) {
-		mlx5_core_warn(dev, "Failed to lock SW reset semaphore\n");
+		if (ret == -EBUSY)
+			mlx5_core_info(dev, "SW reset semaphore is already in use\n");
+		else
+			mlx5_core_warn(dev, "Failed to lock SW reset semaphore\n");
 		goto unlock_gw;
 	}
 
-- 
2.41.0


