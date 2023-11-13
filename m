Return-Path: <netdev+bounces-47492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38917EA68F
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6F3BB20A9A
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 23:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE463E47D;
	Mon, 13 Nov 2023 23:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJHTatqt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABF93C6B0
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 23:01:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C31BC433C8;
	Mon, 13 Nov 2023 23:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699916487;
	bh=pZP3YkL9R6tKeuxvJ0/BPJtWTrnFvBH+94QIQTTXqC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rJHTatqtyHMEQKy2idTu687jhjm4DHdo3ebuUYabweNURhEULv37mWKy/os2pvoK7
	 Tp61AU8F/OnsjnUkvJVwbac916EoLj/4wvHmFTcqn3/B5bAfQK7kfVcAotYdG0mwgT
	 zWJItlnvW5AcU6x8XTUaGbmO1qvZxhoOCmcD38UKj2+e3fj0WFq6Xi5k6u6l7zFmO/
	 CEDg+aZQSRHnNKmpE/LYibHzQ7hnx+jb4Vt3qnoXKZYJK55Q/n/yMYQlMm1sHBrzcC
	 oodS54e3V9l7wDyI1WKzGYazktIHDIu3Ah8Db95EEMsDK3n0a+7TXUdgf4tniYfvzB
	 RwoAmqbD36+Jg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [net-next 11/14] net/mlx5: Convert scaled ppm values outside the s32 range for PHC frequency adjustments
Date: Mon, 13 Nov 2023 15:00:48 -0800
Message-ID: <20231113230051.58229-12-saeed@kernel.org>
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


