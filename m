Return-Path: <netdev+bounces-35128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 295DF7A72EE
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 08:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C47F1C20B31
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 06:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDD8C13E;
	Wed, 20 Sep 2023 06:36:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3BDC13D
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 06:36:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A06C433CC;
	Wed, 20 Sep 2023 06:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695191768;
	bh=5cNcDJukxUqhZtOP1tOQ5D7Z3jgZBxscbObP9pX8/Q0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TH5uBpz62nn9IA4Ytp0MG5kTUmBcPg96UjMUGIzIQigze9y8Mr3JMmdJReF1vgQ/g
	 VjJvE5hmhK0sZOyjWhp26sna0LH5ad9K8fYLOqM2W1cgM0YVk4c1dTXWGW8YQdIHzs
	 EZiPChExEAvEjZU+Kt7+vF+QxH4jqGrT6I1xAP2x27rESNO0gVy95bEwPmEv+yURNY
	 qsWwTZrIeD7PHo2a5CnU64GC1R0b1hd2RHzJ96LTMZsuC8LDIE64E5pjzjwi/MwRD3
	 NSKyz0MaX28h9vHtGu0E1iJ24N3vKTmuENHbDZeAK/zK9pxNY+rMFtlhtdngb8ox9W
	 YhOrWlOAq7CEg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: [net-next 10/15] net/mlx5e: Check police action rate for matchall filter
Date: Tue, 19 Sep 2023 23:35:47 -0700
Message-ID: <20230920063552.296978-11-saeed@kernel.org>
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

From: Jianbo Liu <jianbol@nvidia.com>

As matchall filter uses TSAR (Transmit Scheduling Arbiter) for rate
limit, the rate of police action should not be over the port's max
link speed, or the maximum aggregated speed of both ports if LAG is
configured.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index f76c8f0562e9..d2ebe56c3977 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -770,6 +770,7 @@ int mlx5_esw_qos_modify_vport_rate(struct mlx5_eswitch *esw, u16 vport_num, u32
 {
 	u32 ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	struct mlx5_vport *vport;
+	u32 link_speed_max;
 	u32 bitmask;
 	int err;
 
@@ -777,6 +778,17 @@ int mlx5_esw_qos_modify_vport_rate(struct mlx5_eswitch *esw, u16 vport_num, u32
 	if (IS_ERR(vport))
 		return PTR_ERR(vport);
 
+	if (rate_mbps) {
+		err = mlx5_esw_qos_max_link_speed_get(esw->dev, &link_speed_max, false, NULL);
+		if (err)
+			return err;
+
+		err = mlx5_esw_qos_link_speed_verify(esw->dev, "Police",
+						     link_speed_max, rate_mbps, NULL);
+		if (err)
+			return err;
+	}
+
 	mutex_lock(&esw->state_lock);
 	if (!vport->qos.enabled) {
 		/* Eswitch QoS wasn't enabled yet. Enable it and vport QoS. */
-- 
2.41.0


