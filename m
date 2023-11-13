Return-Path: <netdev+bounces-47491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB637EA68E
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A3F71C2088C
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 23:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4779D3E46F;
	Mon, 13 Nov 2023 23:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHjYFIJ7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE6B3E46C
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 23:01:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F2FC433C9;
	Mon, 13 Nov 2023 23:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699916486;
	bh=e26f/y5Z6tDOPgogltnRDDerM8rLY3R8QEGGvlTIH3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oHjYFIJ7lyrgMnV08jx7OhFjXrYz49tbE/jW8FZWBbJJuejEsSnwZ+UXWXFS7KC1G
	 436qpYCGVZkD6EY0v0Qi3lcEODic81MIOsWuG968bZHNYlSoS10KXBBv2KBQKwStAN
	 tKnseQbuQ+w/lHTGMc97rHw72j3HoXOExOYQsRB4g1923m9MJF6hSqFAgyCcNXEVdV
	 KpDn6h19+HwZaW4d/LatTV7y401/XTpHvv8h9ErMF1AuttKLEDwUTDBJkzXr3ou9Nj
	 p+dVLbUiKcq9DmL3Hkv38qt3AZNy8AiZqVRCxZ4SSNMOLCfdd4KbQVEH5UUrjXt2/0
	 d5qNpmLxbcXnw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [net-next 10/14] net/mlx5: Initialize clock->ptp_info inside mlx5_init_timer_clock
Date: Mon, 13 Nov 2023 15:00:47 -0800
Message-ID: <20231113230051.58229-11-saeed@kernel.org>
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


