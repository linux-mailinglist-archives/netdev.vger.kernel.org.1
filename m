Return-Path: <netdev+bounces-48186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9AB7ECDAA
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 20:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB45D281576
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 19:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FF83C483;
	Wed, 15 Nov 2023 19:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+nzlM0K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5D13C468
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 19:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85536C433C8;
	Wed, 15 Nov 2023 19:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700077021;
	bh=kHxyfzuDpnF98WxwbDkDhJoazlbAqXBE6oSSzgRTLWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l+nzlM0KSVzVbxyoH/wVKt4Cf57DgA4PvrLp6MbigExSuZkvoXYHleIxyc0WQIWcy
	 O+kABiX7qXguXM2PteXbm5cMPVY/Yj+aWMnFIWlD9b3OHccLJ65jflUTOh49YrLZHb
	 B7wxg7ec9V3udfJZEBpN68ugfJoE0rWJ4brQo6tj0XGeGUjRwMmwnW5qtCfi9moFZ5
	 4n063/HMZF7BY0EEBE8qVfs4BCZAlqktomCJOw6iNIVB/meOOeXjwTt30WE+7cbR45
	 VoJvgMM8AiUOi6cRTt/F9J5ClomqOvSu0M+yJ85CNduRWmpDDEJ/zpK+GfI+aVowOP
	 mAmhElJfQv9gA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [net-next V2 11/13] net/mlx5: Query maximum frequency adjustment of the PTP hardware clock
Date: Wed, 15 Nov 2023 11:36:47 -0800
Message-ID: <20231115193649.8756-12-saeed@kernel.org>
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

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

Some mlx5 devices do not support the default advertised maximum frequency
adjustment value for the PTP hardware clock that is set by the driver.
These devices need to be queried when initializing the clock functionality
in order to get the maximum supported frequency adjustment value. This
value can be greater than the minimum supported frequency adjustment across
mlx5 devices (50 million ppb).

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/lib/clock.c   | 22 +++++++++++++++++++
 include/linux/mlx5/mlx5_ifc.h                 |  5 ++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index 1daa4b019513..cac60a841e1d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -1000,6 +1000,25 @@ static void mlx5_init_clock_info(struct mlx5_core_dev *mdev)
 	info->frac = timer->tc.frac;
 }
 
+static void mlx5_init_timer_max_freq_adjustment(struct mlx5_core_dev *mdev)
+{
+	struct mlx5_clock *clock = &mdev->clock;
+	u32 out[MLX5_ST_SZ_DW(mtutc_reg)] = {};
+	u32 in[MLX5_ST_SZ_DW(mtutc_reg)] = {};
+	u8 log_max_freq_adjustment = 0;
+	int err;
+
+	err = mlx5_core_access_reg(mdev, in, sizeof(in), out, sizeof(out),
+				   MLX5_REG_MTUTC, 0, 0);
+	if (!err)
+		log_max_freq_adjustment =
+			MLX5_GET(mtutc_reg, out, log_max_freq_adjustment);
+
+	if (log_max_freq_adjustment)
+		clock->ptp_info.max_adj =
+			min(S32_MAX, 1 << log_max_freq_adjustment);
+}
+
 static void mlx5_init_timer_clock(struct mlx5_core_dev *mdev)
 {
 	struct mlx5_clock *clock = &mdev->clock;
@@ -1007,6 +1026,9 @@ static void mlx5_init_timer_clock(struct mlx5_core_dev *mdev)
 	/* Configure the PHC */
 	clock->ptp_info = mlx5_ptp_clock_info;
 
+	if (MLX5_CAP_MCAM_REG(mdev, mtutc))
+		mlx5_init_timer_max_freq_adjustment(mdev);
+
 	mlx5_timecounter_init(mdev);
 	mlx5_init_clock_info(mdev);
 	mlx5_init_overflow_period(clock);
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 6f3631425f38..ce2e71cd6d2a 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -10103,7 +10103,10 @@ enum {
 struct mlx5_ifc_mtutc_reg_bits {
 	u8         reserved_at_0[0x5];
 	u8         freq_adj_units[0x3];
-	u8         reserved_at_8[0x14];
+	u8         reserved_at_8[0x3];
+	u8         log_max_freq_adjustment[0x5];
+
+	u8         reserved_at_10[0xc];
 	u8         operation[0x4];
 
 	u8         freq_adjustment[0x20];
-- 
2.41.0


