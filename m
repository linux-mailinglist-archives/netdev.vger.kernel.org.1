Return-Path: <netdev+bounces-69331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C764C84AB3B
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 01:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64D6C1F23935
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 00:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7731BA41;
	Tue,  6 Feb 2024 00:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vm0gy9bz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A35D79CD
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 00:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707180943; cv=none; b=Lg6MPXtLLxGbbkuPMohqnk84aS0KuvQJ4n4l/JIC93CG/yLzejVtNuNu6bhUrZUA3BMsPXmwjGBKk+YVLDLhuDEGahnWR4soWon0ZVUUDiMcRdfRCbzjeNBnu5vZqCyv2Ry6MlLW1vTUyPWDZ/eM4Hi3qgWdin2jyz4Cl9wVW00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707180943; c=relaxed/simple;
	bh=qLPTj/GITcn9YU5JJjUQObLYqhNens9zBvUAEM3bAUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Krg8YfUXhc1t7I+aQTHVqwQ4abhg0f8vYUO9RgHENHxYnHxD/dk3j3sH5j+Abd2N2alagIrcL5vJIe4BX2idB/FO1AQ38xOaEYTZNtLlH+OhBf2NAEpvZv6LspuAnfg15NPXGB6IzeKksDIg88W1DuQ/HLdpxtm0OVD6DiUmRhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vm0gy9bz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFEBC433F1;
	Tue,  6 Feb 2024 00:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707180942;
	bh=qLPTj/GITcn9YU5JJjUQObLYqhNens9zBvUAEM3bAUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vm0gy9bz+thsxROEPZpsmMIS7xK3NdO8CMn5Ftm0xYLyFfbXno6gimpEwtZIqsLRH
	 LTwU6qvfmSssMXxPMt6WEH+7cblOFS+1Q6pdHAkEUITL+f+mObjJ94C97bnr9TST7M
	 RNLX11bm9GwP7PszTvbEvWX8SYbTHLlym9ZfoI1zyg2H3mtaAgaINjaSBPLfQhhKv9
	 Gc0/bn//x8NKwj0Ln0uLi9hkFiYIp0H9XzrRST/TRyS5Kr5kDPKkHD6uPBzb+q9JkY
	 I4LD6G4O3QKO9OPLfWXjV1mBjPe48LCMO6HNZv0cPjh5WpzSR54UxXPKHOgetXASOu
	 3nFziRYELaZSg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>
Subject: [net-next V4 10/15] net/mlx5: Return specific error code for timeout on wait_fw_init
Date: Mon,  5 Feb 2024 16:55:22 -0800
Message-ID: <20240206005527.1353368-11-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206005527.1353368-1-saeed@kernel.org>
References: <20240206005527.1353368-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Moshe Shemesh <moshe@nvidia.com>

The function wait_fw_init() returns same error code either if it breaks
waiting due to timeout or other reason. Thus, the function callers print
error message on timeout without checking error type.

Return different error code for different failure reason and print error
message accordingly on wait_fw_init().

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/main.c    | 38 +++++++++----------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index bccf6e53556c..c2593625c09a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -187,31 +187,36 @@ static struct mlx5_profile profile[] = {
 };
 
 static int wait_fw_init(struct mlx5_core_dev *dev, u32 max_wait_mili,
-			u32 warn_time_mili)
+			u32 warn_time_mili, const char *init_state)
 {
 	unsigned long warn = jiffies + msecs_to_jiffies(warn_time_mili);
 	unsigned long end = jiffies + msecs_to_jiffies(max_wait_mili);
 	u32 fw_initializing;
-	int err = 0;
 
 	do {
 		fw_initializing = ioread32be(&dev->iseg->initializing);
 		if (!(fw_initializing >> 31))
 			break;
-		if (time_after(jiffies, end) ||
-		    test_bit(MLX5_BREAK_FW_WAIT, &dev->intf_state)) {
-			err = -EBUSY;
-			break;
+		if (time_after(jiffies, end)) {
+			mlx5_core_err(dev, "Firmware over %u MS in %s state, aborting\n",
+				      max_wait_mili, init_state);
+			return -ETIMEDOUT;
+		}
+		if (test_bit(MLX5_BREAK_FW_WAIT, &dev->intf_state)) {
+			mlx5_core_warn(dev, "device is being removed, stop waiting for FW %s\n",
+				       init_state);
+			return -ENODEV;
 		}
 		if (warn_time_mili && time_after(jiffies, warn)) {
-			mlx5_core_warn(dev, "Waiting for FW initialization, timeout abort in %ds (0x%x)\n",
-				       jiffies_to_msecs(end - warn) / 1000, fw_initializing);
+			mlx5_core_warn(dev, "Waiting for FW %s, timeout abort in %ds (0x%x)\n",
+				       init_state, jiffies_to_msecs(end - warn) / 1000,
+				       fw_initializing);
 			warn = jiffies + msecs_to_jiffies(warn_time_mili);
 		}
 		msleep(mlx5_tout_ms(dev, FW_PRE_INIT_WAIT));
 	} while (true);
 
-	return err;
+	return 0;
 }
 
 static void mlx5_set_driver_version(struct mlx5_core_dev *dev)
@@ -1151,12 +1156,10 @@ static int mlx5_function_enable(struct mlx5_core_dev *dev, bool boot, u64 timeou
 	/* wait for firmware to accept initialization segments configurations
 	 */
 	err = wait_fw_init(dev, timeout,
-			   mlx5_tout_ms(dev, FW_PRE_INIT_WARN_MESSAGE_INTERVAL));
-	if (err) {
-		mlx5_core_err(dev, "Firmware over %llu MS in pre-initializing state, aborting\n",
-			      timeout);
+			   mlx5_tout_ms(dev, FW_PRE_INIT_WARN_MESSAGE_INTERVAL),
+			   "pre-initializing");
+	if (err)
 		return err;
-	}
 
 	err = mlx5_cmd_enable(dev);
 	if (err) {
@@ -1166,12 +1169,9 @@ static int mlx5_function_enable(struct mlx5_core_dev *dev, bool boot, u64 timeou
 
 	mlx5_tout_query_iseg(dev);
 
-	err = wait_fw_init(dev, mlx5_tout_ms(dev, FW_INIT), 0);
-	if (err) {
-		mlx5_core_err(dev, "Firmware over %llu MS in initializing state, aborting\n",
-			      mlx5_tout_ms(dev, FW_INIT));
+	err = wait_fw_init(dev, mlx5_tout_ms(dev, FW_INIT), 0, "initializing");
+	if (err)
 		goto err_cmd_cleanup;
-	}
 
 	dev->caps.embedded_cpu = mlx5_read_embedded_cpu(dev);
 	mlx5_cmd_set_state(dev, MLX5_CMDIF_STATE_UP);
-- 
2.43.0


