Return-Path: <netdev+bounces-25163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD94277313E
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 23:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19EE11C20D30
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 21:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F76B198BD;
	Mon,  7 Aug 2023 21:26:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4109E198A7
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 21:26:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09AA8C433B7;
	Mon,  7 Aug 2023 21:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691443586;
	bh=X27WxB6mVa5sWQ+rXGlNvF0aA08PANkyXOTW40Y2sTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M8RTt8X2SDTUcmRSaED7B/UcW8oEy2fm6TLQxFWnx3JH32BMtgY3gaofo9V09pmLE
	 KlozBsJLEEmJisZgQ6dJ7dynKCa94QE1hWsPr3DLaN8dxSnKicDK2ZbtqI62VDIv7G
	 XgTSU6aN0xjSHWSkYyagZzj8gURbFk/3XyxGx2uHhWL/C66ZCpFL+2ENPmU/+eVeJg
	 fput9H2vBm6Od9nke90ApntLBXmFpoWnoRJ2YFyr4Z6pjGXgjT7VIjUIAF+EXZTmDB
	 nlS3O+50OQtMLHwQtYvJ0/aPtLBYwnIdWvaYxshvprffZoFq2pF85p+XnNrve85ds8
	 sdzEcysnme8uQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Lama Kayal <lkayal@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>
Subject: [net 11/11] net/mlx5e: Add capability check for vnic counters
Date: Mon,  7 Aug 2023 14:26:07 -0700
Message-ID: <20230807212607.50883-12-saeed@kernel.org>
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

From: Lama Kayal <lkayal@nvidia.com>

Add missing capability check for each of the vnic counters exposed by
devlink health reporter, and thus avoid unexpected behavior due to
invalid access to registers.

While at it, read only the exact number of bits for each counter whether
it was 32 bits or 64 bits.

Fixes: b0bc615df488 ("net/mlx5: Add vnic devlink health reporter to PFs/VFs")
Fixes: a33682e4e78e ("net/mlx5e: Expose catastrophic steering error counters")
Signed-off-by: Lama Kayal <lkayal@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/diag/reporter_vnic.c   | 116 ++++++++++--------
 1 file changed, 67 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.c b/drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.c
index b0128336ff01..e869c65d8e90 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. */
 
 #include "reporter_vnic.h"
+#include "en_stats.h"
 #include "devlink.h"
 
 #define VNIC_ENV_GET64(vnic_env_stats, c) \
@@ -36,55 +37,72 @@ int mlx5_reporter_vnic_diagnose_counters(struct mlx5_core_dev *dev,
 	if (err)
 		return err;
 
-	err = devlink_fmsg_u64_pair_put(fmsg, "total_error_queues",
-					VNIC_ENV_GET64(&vnic, total_error_queues));
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u64_pair_put(fmsg, "send_queue_priority_update_flow",
-					VNIC_ENV_GET64(&vnic, send_queue_priority_update_flow));
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u64_pair_put(fmsg, "comp_eq_overrun",
-					VNIC_ENV_GET64(&vnic, comp_eq_overrun));
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u64_pair_put(fmsg, "async_eq_overrun",
-					VNIC_ENV_GET64(&vnic, async_eq_overrun));
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u64_pair_put(fmsg, "cq_overrun",
-					VNIC_ENV_GET64(&vnic, cq_overrun));
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u64_pair_put(fmsg, "invalid_command",
-					VNIC_ENV_GET64(&vnic, invalid_command));
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u64_pair_put(fmsg, "quota_exceeded_command",
-					VNIC_ENV_GET64(&vnic, quota_exceeded_command));
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u64_pair_put(fmsg, "nic_receive_steering_discard",
-					VNIC_ENV_GET64(&vnic, nic_receive_steering_discard));
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u64_pair_put(fmsg, "generated_pkt_steering_fail",
-					VNIC_ENV_GET64(&vnic, generated_pkt_steering_fail));
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u64_pair_put(fmsg, "handled_pkt_steering_fail",
-					VNIC_ENV_GET64(&vnic, handled_pkt_steering_fail));
-	if (err)
-		return err;
+	if (MLX5_CAP_GEN(dev, vnic_env_queue_counters)) {
+		err = devlink_fmsg_u32_pair_put(fmsg, "total_error_queues",
+						VNIC_ENV_GET(&vnic, total_error_queues));
+		if (err)
+			return err;
+
+		err = devlink_fmsg_u32_pair_put(fmsg, "send_queue_priority_update_flow",
+						VNIC_ENV_GET(&vnic,
+							     send_queue_priority_update_flow));
+		if (err)
+			return err;
+	}
+
+	if (MLX5_CAP_GEN(dev, eq_overrun_count)) {
+		err = devlink_fmsg_u32_pair_put(fmsg, "comp_eq_overrun",
+						VNIC_ENV_GET(&vnic, comp_eq_overrun));
+		if (err)
+			return err;
+
+		err = devlink_fmsg_u32_pair_put(fmsg, "async_eq_overrun",
+						VNIC_ENV_GET(&vnic, async_eq_overrun));
+		if (err)
+			return err;
+	}
+
+	if (MLX5_CAP_GEN(dev, vnic_env_cq_overrun)) {
+		err = devlink_fmsg_u32_pair_put(fmsg, "cq_overrun",
+						VNIC_ENV_GET(&vnic, cq_overrun));
+		if (err)
+			return err;
+	}
+
+	if (MLX5_CAP_GEN(dev, invalid_command_count)) {
+		err = devlink_fmsg_u32_pair_put(fmsg, "invalid_command",
+						VNIC_ENV_GET(&vnic, invalid_command));
+		if (err)
+			return err;
+	}
+
+	if (MLX5_CAP_GEN(dev, quota_exceeded_count)) {
+		err = devlink_fmsg_u32_pair_put(fmsg, "quota_exceeded_command",
+						VNIC_ENV_GET(&vnic, quota_exceeded_command));
+		if (err)
+			return err;
+	}
+
+	if (MLX5_CAP_GEN(dev, nic_receive_steering_discard)) {
+		err = devlink_fmsg_u64_pair_put(fmsg, "nic_receive_steering_discard",
+						VNIC_ENV_GET64(&vnic,
+							       nic_receive_steering_discard));
+		if (err)
+			return err;
+	}
+
+	if (MLX5_CAP_GEN(dev, vnic_env_cnt_steering_fail)) {
+		err = devlink_fmsg_u64_pair_put(fmsg, "generated_pkt_steering_fail",
+						VNIC_ENV_GET64(&vnic,
+							       generated_pkt_steering_fail));
+		if (err)
+			return err;
+
+		err = devlink_fmsg_u64_pair_put(fmsg, "handled_pkt_steering_fail",
+						VNIC_ENV_GET64(&vnic, handled_pkt_steering_fail));
+		if (err)
+			return err;
+	}
 
 	err = devlink_fmsg_obj_nest_end(fmsg);
 	if (err)
-- 
2.41.0


