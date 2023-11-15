Return-Path: <netdev+bounces-48185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3037ECDA6
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 20:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04DD01C20B4B
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 19:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127EF3C478;
	Wed, 15 Nov 2023 19:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lE213ieu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1293C477
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 19:37:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB28C433C8;
	Wed, 15 Nov 2023 19:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700077020;
	bh=pZP3YkL9R6tKeuxvJ0/BPJtWTrnFvBH+94QIQTTXqC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lE213ieuMlBEoak0xRKwhslZZOJDuLuVahGnv1iv+l0+gS0MGRgwpUsqUS/5fb/qB
	 qiAtG8nLth1eQpojJF2pCBgu+EzOmczPj4yXBdRQBZR+Zv/RNn63z9b+5or9nneQt6
	 2LnXxQI9gZIOVvRsPaljea2bx8m2BIxPFm8ADQrtKjiC/LAaSyUcYe1S3lrdyIVqWa
	 ogdUT9SQd1u/O3mgE85LJ8M4fsPzqHnNdU6pbMjRpJcQ2ujOfTfrxHmJ7jNIBQxBw/
	 Ae/rTbi9y83UpZqNUZV+nbrqjjiUSaIW+H71tb5xnHCgz2piYgR6sZXYRxOMJn7AvT
	 bjr7HHk2pY9tA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [net-next V2 10/13] net/mlx5: Convert scaled ppm values outside the s32 range for PHC frequency adjustments
Date: Wed, 15 Nov 2023 11:36:46 -0800
Message-ID: <20231115193649.8756-11-saeed@kernel.org>
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

Represent scaled ppm as ppb to the device when the value in scaled ppm is
not representable as a 32-bit signed integer. mlx5 devices only support a
32-bit field for the frequency adjustment value in units of either scaled
ppm or ppb.

Since mlx5 devices only support a 32-bit field for the frequency adjustment
value independent of unit used, limit the maximum frequency adjustment to
S32_MAX ppb.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index ca7691930f6b..1daa4b019513 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -393,10 +393,12 @@ static int mlx5_ptp_freq_adj_real_time(struct mlx5_core_dev *mdev, long scaled_p
 
 	MLX5_SET(mtutc_reg, in, operation, MLX5_MTUTC_OPERATION_ADJUST_FREQ_UTC);
 
-	if (MLX5_CAP_MCAM_FEATURE(mdev, mtutc_freq_adj_units)) {
+	if (MLX5_CAP_MCAM_FEATURE(mdev, mtutc_freq_adj_units) &&
+	    scaled_ppm <= S32_MAX && scaled_ppm >= S32_MIN) {
+		/* HW scaled_ppm support on mlx5 devices only supports a 32-bit value */
 		MLX5_SET(mtutc_reg, in, freq_adj_units,
 			 MLX5_MTUTC_FREQ_ADJ_UNITS_SCALED_PPM);
-		MLX5_SET(mtutc_reg, in, freq_adjustment, scaled_ppm);
+		MLX5_SET(mtutc_reg, in, freq_adjustment, (s32)scaled_ppm);
 	} else {
 		MLX5_SET(mtutc_reg, in, freq_adj_units, MLX5_MTUTC_FREQ_ADJ_UNITS_PPB);
 		MLX5_SET(mtutc_reg, in, freq_adjustment, scaled_ppm_to_ppb(scaled_ppm));
-- 
2.41.0


