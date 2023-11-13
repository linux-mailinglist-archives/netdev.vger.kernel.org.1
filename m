Return-Path: <netdev+bounces-47449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E65177EA539
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 22:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 232A61C209CE
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 21:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACDB2D633;
	Mon, 13 Nov 2023 21:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QERFTAPU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDA7250EF
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 21:08:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E77EC433C8;
	Mon, 13 Nov 2023 21:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699909715;
	bh=L13hPonBEYETLt0p2b/iJGNJkr6zHfGjek08DVAAmE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QERFTAPU3ZVbPT5vz4ILUn0Khn9bGP43yeK+7MvJQ65udAIZZWzVUGMispLHPWNzy
	 VAun/2wLYK+0Tmk/TxblFwr5J1xfDicg+L8zzHp/A9XDpZ3gfhgl6hLlLlM/4Lr6aA
	 RRxwrvWYMOkFIInL35pXJIrAu0rzHSjsH4XAuVutuox145WONG3cvpzGfkPXyGIaQY
	 CAKYdXuBl/obtq3RjzzkDW9wuTM5tl9NN1Lqt9Idp0m08H/QRNH/7YTWwvnx8DKIx4
	 Yx9dq1sWCd2cSArdhNxCUCOkjXTY4pLHXlLG/rXhWmJYEF2HHFuOxQxVu1EwvKi5Qc
	 Ti8dSgsDgnmlw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [net 04/17] net/mlx5: Decouple PHC .adjtime and .adjphase implementations
Date: Mon, 13 Nov 2023 13:08:13 -0800
Message-ID: <20231113210826.47593-5-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113210826.47593-1-saeed@kernel.org>
References: <20231113210826.47593-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

When running a phase adjustment operation, the free running clock should
not be modified at all. The phase control keyword is intended to trigger an
internal servo on the device that will converge to the provided delta. A
free running counter cannot implement phase adjustment.

Fixes: 8e11a68e2e8a ("net/mlx5: Add adjphase function to support hardware-only offset control")
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index aa29f09e8356..0c83ef174275 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -384,7 +384,12 @@ static int mlx5_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 
 static int mlx5_ptp_adjphase(struct ptp_clock_info *ptp, s32 delta)
 {
-	return mlx5_ptp_adjtime(ptp, delta);
+	struct mlx5_clock *clock = container_of(ptp, struct mlx5_clock, ptp_info);
+	struct mlx5_core_dev *mdev;
+
+	mdev = container_of(clock, struct mlx5_core_dev, clock);
+
+	return mlx5_ptp_adjtime_real_time(mdev, delta);
 }
 
 static int mlx5_ptp_freq_adj_real_time(struct mlx5_core_dev *mdev, long scaled_ppm)
-- 
2.41.0


