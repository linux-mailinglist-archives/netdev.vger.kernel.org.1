Return-Path: <netdev+bounces-152703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5559F574A
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 20:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B29CF1885465
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 19:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0291F9420;
	Tue, 17 Dec 2024 19:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="bBHN8R2S"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B881F76BC
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 19:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734465505; cv=none; b=m1NOs5N+FwK9qzotoI9w12fXG5X+qaho5DvUoDJ0Yclw2NP8XjyH5wEteXwP2a5/4puLVYbCmoPf2CHYb6j1q9vN/yqtZTw78kOM7p//TS9yInL9pfgTI1R4ZK0rAc7Y14HMSVLizfnLeipePwkhjUOzwVuTC8QfuVt1i+UlcMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734465505; c=relaxed/simple;
	bh=RVTDXssZoraQvZx2bH4q7cc4uON9qPRkZJ+2c3SPMc0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oZ2CW3rBT2rgMWiIjbT4AQRKHg3GmGvr0Qkq7MKjOVYeHlDoOdrV2o08PhmRXAW79Y3G688vhn5vlGyZM5cZRTbA8wERL9y0bo/LHYLM4CgCBTxvxAotOMCb/h8kGQgw3L6+Hq872kwjjHH5WPAjJvJuOJtw7xxqbNG5fWM2DIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=bBHN8R2S; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHIv1dY026755;
	Tue, 17 Dec 2024 11:57:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=hKlSLWAhM+HbN09jVo
	miKBvpwPmWrbbDQvC6Nxsjj9A=; b=bBHN8R2Sg96n+AJcDC40CceLUoq2zNnOSJ
	aIWakyUD4Pbl6BH3d/JNLsSzCr88wQd0DvSxs9yIQ8LmcXVvicViWYzZmgIrgCMX
	fAe52jY0PSfMuS0duf5PLgR0SbRS2kWkrnu9ajYkK0/0twUsort6ya4Rzw12mOFj
	bi9VP/ZmyCbhJHA/4DMkpDhLu7qHkBlGaABj7EGhoUenEWizSTrtak/AGD6IfCmK
	4pcxoK1xp9caqYO+xCbnEOELE5P72YRsIegAM+tLtI6jr6WQiR54McW8IhDUiXJn
	ovW9xj7uGmmaQVMOlWh8z2sJrOMi7RrHymWfpS8bwWgDzcCKX9IA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43kf1egeyu-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 17 Dec 2024 11:57:57 -0800 (PST)
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server id
 15.2.1544.14; Tue, 17 Dec 2024 19:57:53 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Dragos Tatulea
	<dtatulea@nvidia.com>, Gal Pressman <gal@nvidia.com>,
        Jakub Kicinski
	<kuba@kernel.org>
CC: Tariq Toukan <tariqt@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
        Bar Shapira <bshapira@nvidia.com>, <netdev@vger.kernel.org>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran
	<richardcochran@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Saeed
 Mahameed" <saeedm@nvidia.com>,
        Vadim Fedorenko <vadfed@meta.com>
Subject: [PATCH net-next] net/mlx5: use do_aux_work for PHC overflow checks
Date: Tue, 17 Dec 2024 11:57:38 -0800
Message-ID: <20241217195738.743391-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: xQsZZdWf5r33hriloNHFc1YTebzs-8nr
X-Proofpoint-ORIG-GUID: xQsZZdWf5r33hriloNHFc1YTebzs-8nr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

The overflow_work is using system wq to do overflow checks and updates
for PHC device timecounter, which might be overhelmed by other tasks.
But there is dedicated kthread in PTP subsystem designed for such
things. This patch changes the work queue to proper align with PTP
subsystem and to avoid overloading system work queue.
The adjfine() function acts the same way as overflow check worker,
we can postpone ptp aux worker till the next overflow period after
adjfine() was called.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 .../ethernet/mellanox/mlx5/core/lib/clock.c   | 25 +++++++++++--------
 include/linux/mlx5/driver.h                   |  1 -
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index 4822d01123b4..ff3780331273 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -322,17 +322,16 @@ static void mlx5_pps_out(struct work_struct *work)
 	}
 }
 
-static void mlx5_timestamp_overflow(struct work_struct *work)
+static long mlx5_timestamp_overflow(struct ptp_clock_info *ptp_info)
 {
-	struct delayed_work *dwork = to_delayed_work(work);
 	struct mlx5_core_dev *mdev;
 	struct mlx5_timer *timer;
 	struct mlx5_clock *clock;
 	unsigned long flags;
 
-	timer = container_of(dwork, struct mlx5_timer, overflow_work);
-	clock = container_of(timer, struct mlx5_clock, timer);
+	clock = container_of(ptp_info, struct mlx5_clock, ptp_info);
 	mdev = container_of(clock, struct mlx5_core_dev, clock);
+	timer = &clock->timer;
 
 	if (mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR)
 		goto out;
@@ -343,7 +342,7 @@ static void mlx5_timestamp_overflow(struct work_struct *work)
 	write_sequnlock_irqrestore(&clock->lock, flags);
 
 out:
-	schedule_delayed_work(&timer->overflow_work, timer->overflow_period);
+	return timer->overflow_period;
 }
 
 static int mlx5_ptp_settime_real_time(struct mlx5_core_dev *mdev,
@@ -517,6 +516,7 @@ static int mlx5_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 	timer->cycles.mult = mult;
 	mlx5_update_clock_info_page(mdev);
 	write_sequnlock_irqrestore(&clock->lock, flags);
+	ptp_schedule_worker(clock->ptp, timer->overflow_period);
 
 	return 0;
 }
@@ -852,6 +852,7 @@ static const struct ptp_clock_info mlx5_ptp_clock_info = {
 	.settime64	= mlx5_ptp_settime,
 	.enable		= NULL,
 	.verify		= NULL,
+	.do_aux_work	= mlx5_timestamp_overflow,
 };
 
 static int mlx5_query_mtpps_pin_mode(struct mlx5_core_dev *mdev, u8 pin,
@@ -1052,12 +1053,12 @@ static void mlx5_init_overflow_period(struct mlx5_clock *clock)
 	do_div(ns, NSEC_PER_SEC / HZ);
 	timer->overflow_period = ns;
 
-	INIT_DELAYED_WORK(&timer->overflow_work, mlx5_timestamp_overflow);
-	if (timer->overflow_period)
-		schedule_delayed_work(&timer->overflow_work, 0);
-	else
+	if (!timer->overflow_period) {
+		timer->overflow_period = HZ;
 		mlx5_core_warn(mdev,
-			       "invalid overflow period, overflow_work is not scheduled\n");
+			       "invalid overflow period,"
+			       "overflow_work is scheduled once per second\n");
+	}
 
 	if (clock_info)
 		clock_info->overflow_period = timer->overflow_period;
@@ -1172,6 +1173,9 @@ void mlx5_init_clock(struct mlx5_core_dev *mdev)
 
 	MLX5_NB_INIT(&clock->pps_nb, mlx5_pps_event, PPS_EVENT);
 	mlx5_eq_notifier_register(mdev, &clock->pps_nb);
+
+	if (clock->ptp)
+		ptp_schedule_worker(clock->ptp, 0);
 }
 
 void mlx5_cleanup_clock(struct mlx5_core_dev *mdev)
@@ -1188,7 +1192,6 @@ void mlx5_cleanup_clock(struct mlx5_core_dev *mdev)
 	}
 
 	cancel_work_sync(&clock->pps_info.out_work);
-	cancel_delayed_work_sync(&clock->timer.overflow_work);
 
 	if (mdev->clock_info) {
 		free_page((unsigned long)mdev->clock_info);
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index fc7e6153b73d..3ac2fc1b52cf 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -690,7 +690,6 @@ struct mlx5_timer {
 	struct timecounter         tc;
 	u32                        nominal_c_mult;
 	unsigned long              overflow_period;
-	struct delayed_work        overflow_work;
 };
 
 struct mlx5_clock {
-- 
2.43.5


