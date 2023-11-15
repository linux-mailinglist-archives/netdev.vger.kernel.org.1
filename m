Return-Path: <netdev+bounces-48184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 255EC7ECDA2
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 20:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F31191C20991
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 19:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395393C46B;
	Wed, 15 Nov 2023 19:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nx9S+NCs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB1A3C468
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 19:36:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B3DC433C7;
	Wed, 15 Nov 2023 19:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700077019;
	bh=e26f/y5Z6tDOPgogltnRDDerM8rLY3R8QEGGvlTIH3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nx9S+NCsF+XzbozzKFbzC1arMmuGU+FMhRFYK9xL7z213wf/K0xDbBpWKaBtjaeTH
	 OQkMVR2f0jf7SMAn8hJ350uZXVSME0qeYvgDZPbCXacXKg2SLKmtc93Bjx1+++Y2j3
	 aC1jIb+8CV4LfvWWj6vL/O3pnvhjzLF07QwhYQNuXwi7Lre0SKX+ONYdor/9KuPObm
	 CEfwIRssPH9fR7wLqDVnhN+lXxjpAGJJkGNzfTrW/XPlILFTaGw3O+L0o3okaG0olz
	 zXPbu4iKtiQMRNub98e73C8KNW0pwNjiahdEhQu6M28NjKbn7avugBNLFKEHN1hy10
	 sjdIymcsHElmQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [net-next V2 09/13] net/mlx5: Initialize clock->ptp_info inside mlx5_init_timer_clock
Date: Wed, 15 Nov 2023 11:36:45 -0800
Message-ID: <20231115193649.8756-10-saeed@kernel.org>
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

Configure the PHC inside mlx5_init_timer_clock for calling mlx5_ptp_settime
later in the function. Would previously use mlx5_ptp_clock_info instance to
invoke mlx5_ptp_settime to set the NIC real-time clock to be synchronized
with the host system clock.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index c4f4d1c63463..ca7691930f6b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -1002,10 +1002,12 @@ static void mlx5_init_timer_clock(struct mlx5_core_dev *mdev)
 {
 	struct mlx5_clock *clock = &mdev->clock;
 
+	/* Configure the PHC */
+	clock->ptp_info = mlx5_ptp_clock_info;
+
 	mlx5_timecounter_init(mdev);
 	mlx5_init_clock_info(mdev);
 	mlx5_init_overflow_period(clock);
-	clock->ptp_info = mlx5_ptp_clock_info;
 
 	if (mlx5_real_time_mode(mdev)) {
 		struct timespec64 ts;
@@ -1036,11 +1038,10 @@ void mlx5_init_clock(struct mlx5_core_dev *mdev)
 	}
 
 	seqlock_init(&clock->lock);
-	mlx5_init_timer_clock(mdev);
 	INIT_WORK(&clock->pps_info.out_work, mlx5_pps_out);
 
-	/* Configure the PHC */
-	clock->ptp_info = mlx5_ptp_clock_info;
+	/* Initialize the device clock */
+	mlx5_init_timer_clock(mdev);
 
 	/* Initialize 1PPS data structures */
 	mlx5_init_pps(mdev);
-- 
2.41.0


