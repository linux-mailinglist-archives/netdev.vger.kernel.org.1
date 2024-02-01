Return-Path: <netdev+bounces-67856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54857845205
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 08:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8724A1C23C6B
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 07:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15749158D78;
	Thu,  1 Feb 2024 07:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETkENlr+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E565E1586F3
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 07:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706772746; cv=none; b=Bl87W0Igm4pIhzYcnbyLKtuwUJEqfBBARL9BeNp7Bz0aARbWqYypZ53D6yIHK+7fMDZdJh6IQlfWcIcjM38dlk48J40oD5OVfBV3CzIzm9WPyZ9uDyDUYaDgOyEY/r8Xp8P3Bo71+WeIzeelh5EaNlzdjO7W4C0ar7ZQbMZ5ung=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706772746; c=relaxed/simple;
	bh=qLPTj/GITcn9YU5JJjUQObLYqhNens9zBvUAEM3bAUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QmT/1zTb67go6iUOj+qlHparSZlkA4xe1iR2yTmW8I5L8T3/z6Dy3CnMhi/kc9rYI0jV4Aoydk+nHzqzZasDX36yW+GUjg+ErD08rpW1JKwysB8IyCNCWHpum9kSKSfEHaGnF1niMyLHKNyH9QA/WF9b09/B+DU5cPCHC/qvzBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETkENlr+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9EFC43399;
	Thu,  1 Feb 2024 07:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706772745;
	bh=qLPTj/GITcn9YU5JJjUQObLYqhNens9zBvUAEM3bAUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ETkENlr+O7PspVEdzYPb3S6PREpkj40OyseLYuDDBqkBzgA9XfLxiOI2bnqNXLOuo
	 mkYbnvON92awX3foQUblnJS4+eO6N3hXOqKD4DB2y99CAjr4Uo3cO21vrwZT7+mgKg
	 7+HycVEAODEqr0YDdJpG4wRpD7L9v5ia0VGnYFgCz8wdWZijLu5ZrdtyeAPS/65j5g
	 1daZ2ivSDjekM94TtA/gEwegIN9DMZUlNuhE8BhsTvfca2eNHeJMDpLHDBIIOzsiKF
	 BD5XSe9WNz+SwtEBRIP4mHoD+mVBju6EDRelQgarIH5ISJyOJ3iba3x1sB7zU7OJWT
	 COEa/PrFwF9YQ==
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
Subject: [net-next V2 10/15] net/mlx5: Return specific error code for timeout on wait_fw_init
Date: Wed, 31 Jan 2024 23:31:53 -0800
Message-ID: <20240201073158.22103-11-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201073158.22103-1-saeed@kernel.org>
References: <20240201073158.22103-1-saeed@kernel.org>
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


