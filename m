Return-Path: <netdev+bounces-47490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C93C47EA68D
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 613B3B20A9B
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 23:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D173D99D;
	Mon, 13 Nov 2023 23:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7xFcKit"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6629B3E468
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 23:01:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4EFC433C7;
	Mon, 13 Nov 2023 23:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699916484;
	bh=kF9vr75SmtZu9p/rXgYjqhwRPyT0NZ2SZvQB0tjJLvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u7xFcKitSmrJ/6+cjHVORr+c+nYf/XbTDYOyR5kQ+su0vvAh7utBwEi7ncLaj31+y
	 xZ6pyjFFb8GzrLnPrbVMPKAEYsjLH7ppuOYFDZuuBI1fE7RXmFaqLvohI+Ia8uxbnQ
	 50EowTGuVESAH42OwijcX69+CpEIgWaj0b5K648YPmgSsbJrFOYu19frmE+gqgnmhB
	 MdKURegXCYpoeBGrNRXTohvy3wO0JRLdqqBcBnOINorewrWpk8YjIfAK4eWYezul8x
	 +CSQilbohjz2m57fzhAWvK3wHG5431kjScQ6Hm7Yv0JWctBxAIHhYF8GegtfwgXOwo
	 K6hg4smtoKwGg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [net-next 09/14] net/mlx5: Refactor real time clock operation checks for PHC
Date: Mon, 13 Nov 2023 15:00:46 -0800
Message-ID: <20231113230051.58229-10-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113230051.58229-1-saeed@kernel.org>
References: <20231113230051.58229-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

Check if the MTUTC register of the NIC can be modified before attempting to
execute a real-time clock operation. Previous implementation aborted the
real-time clock operation pre-emptively when the MTUTC register used to
control the real-time clock was not modifiable, indicating real-time clock
mode was not enabled on the NIC. The original control flow was confusing
since the noop-if-RTC-disabled branch looked similar to an error handling
guard clause. The purpose of this patch is purely for improving readability
and should lead to no functional change.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/lib/clock.c   | 41 +++++++++----------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index aa29f09e8356..c4f4d1c63463 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -266,9 +266,6 @@ static int mlx5_ptp_settime_real_time(struct mlx5_core_dev *mdev,
 {
 	u32 in[MLX5_ST_SZ_DW(mtutc_reg)] = {};
 
-	if (!mlx5_modify_mtutc_allowed(mdev))
-		return 0;
-
 	if (ts->tv_sec < 0 || ts->tv_sec > U32_MAX ||
 	    ts->tv_nsec < 0 || ts->tv_nsec > NSEC_PER_SEC)
 		return -EINVAL;
@@ -286,12 +283,15 @@ static int mlx5_ptp_settime(struct ptp_clock_info *ptp, const struct timespec64
 	struct mlx5_timer *timer = &clock->timer;
 	struct mlx5_core_dev *mdev;
 	unsigned long flags;
-	int err;
 
 	mdev = container_of(clock, struct mlx5_core_dev, clock);
-	err = mlx5_ptp_settime_real_time(mdev, ts);
-	if (err)
-		return err;
+
+	if (mlx5_modify_mtutc_allowed(mdev)) {
+		int err = mlx5_ptp_settime_real_time(mdev, ts);
+
+		if (err)
+			return err;
+	}
 
 	write_seqlock_irqsave(&clock->lock, flags);
 	timecounter_init(&timer->tc, &timer->cycles, timespec64_to_ns(ts));
@@ -341,9 +341,6 @@ static int mlx5_ptp_adjtime_real_time(struct mlx5_core_dev *mdev, s64 delta)
 {
 	u32 in[MLX5_ST_SZ_DW(mtutc_reg)] = {};
 
-	if (!mlx5_modify_mtutc_allowed(mdev))
-		return 0;
-
 	/* HW time adjustment range is checked. If out of range, settime instead */
 	if (!mlx5_is_mtutc_time_adj_cap(mdev, delta)) {
 		struct timespec64 ts;
@@ -367,13 +364,16 @@ static int mlx5_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 	struct mlx5_timer *timer = &clock->timer;
 	struct mlx5_core_dev *mdev;
 	unsigned long flags;
-	int err;
 
 	mdev = container_of(clock, struct mlx5_core_dev, clock);
 
-	err = mlx5_ptp_adjtime_real_time(mdev, delta);
-	if (err)
-		return err;
+	if (mlx5_modify_mtutc_allowed(mdev)) {
+		int err = mlx5_ptp_adjtime_real_time(mdev, delta);
+
+		if (err)
+			return err;
+	}
+
 	write_seqlock_irqsave(&clock->lock, flags);
 	timecounter_adjtime(&timer->tc, delta);
 	mlx5_update_clock_info_page(mdev);
@@ -391,9 +391,6 @@ static int mlx5_ptp_freq_adj_real_time(struct mlx5_core_dev *mdev, long scaled_p
 {
 	u32 in[MLX5_ST_SZ_DW(mtutc_reg)] = {};
 
-	if (!mlx5_modify_mtutc_allowed(mdev))
-		return 0;
-
 	MLX5_SET(mtutc_reg, in, operation, MLX5_MTUTC_OPERATION_ADJUST_FREQ_UTC);
 
 	if (MLX5_CAP_MCAM_FEATURE(mdev, mtutc_freq_adj_units)) {
@@ -415,13 +412,15 @@ static int mlx5_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 	struct mlx5_core_dev *mdev;
 	unsigned long flags;
 	u32 mult;
-	int err;
 
 	mdev = container_of(clock, struct mlx5_core_dev, clock);
 
-	err = mlx5_ptp_freq_adj_real_time(mdev, scaled_ppm);
-	if (err)
-		return err;
+	if (mlx5_modify_mtutc_allowed(mdev)) {
+		int err = mlx5_ptp_freq_adj_real_time(mdev, scaled_ppm);
+
+		if (err)
+			return err;
+	}
 
 	mult = (u32)adjust_by_scaled_ppm(timer->nominal_c_mult, scaled_ppm);
 
-- 
2.41.0


