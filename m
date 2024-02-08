Return-Path: <netdev+bounces-70084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 315D784D935
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 04:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3D352841AD
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 03:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E532D2E83F;
	Thu,  8 Feb 2024 03:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIInL7cc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18872E83C
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 03:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707364455; cv=none; b=nOENvJWnS9VshzIjT7rKgK9YbtMhnowciOcYIn2wk9N4S8rb7yZ/IBgbAu2tbmLYVsOj6vZEc6+yiXh6do4em2ZUvM1aO8pinMF291w3B/rKisLqHile2jYBInNusdxHgtdwdLkO62uBW7nmEV05iP6vHM8OIfdrcdRLVPeBsL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707364455; c=relaxed/simple;
	bh=gDbps/6ATsXpIaTLypnNU+yZpLcsovJA+GHrDn5LBP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Th09PxcemWR4aogEcrXPFLN/mIm34TUbx+y5ZnRaHPbcElal+i59M6Amb2NDPNiHB2By2PA4ZbAaQBD/8gqfq037IKwPI8ctUwnEb8GEjY59PRkZLsubosaqB4JbJeggLGoqoKi7BFMQJRPHNljeS+WPJrilASTfNV3Dv9ex39g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIInL7cc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D8CC43394;
	Thu,  8 Feb 2024 03:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707364455;
	bh=gDbps/6ATsXpIaTLypnNU+yZpLcsovJA+GHrDn5LBP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PIInL7ccqL4mqToZKhUrNg0YKcp4YXGskdQMVD8SAfuHzxs5qyWz4G8H4MtgJqqjd
	 48IGsJAoB5bH7mGgHIIZ7oW5nfMD07ebXzra4VVKDGfYE6bjDjiF3GT6ghE+ztWkly
	 hYwbOkqKwFHtshJcBC/H9M0sknBf6FTQzON9YSNBQWQn5qs3g3QIlIULqCSEnVqcDq
	 Fj0rFCvAJfeoWHTT9P49PsKQVBgaXeZvWzzD79omav93ir4TTrSKwcr2Z5gwxosp4q
	 TG/47iWKsvNC5ZLciS+dxt81KbwLHNO2RRnyjEXVXRpLFMAk944EbJp68vWKG5kjTT
	 lmiDKGd78pjSw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [net-next V2 07/15] net/mlx5: SD, Add debugfs
Date: Wed,  7 Feb 2024 19:53:44 -0800
Message-ID: <20240208035352.387423-8-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208035352.387423-1-saeed@kernel.org>
References: <20240208035352.387423-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tariq Toukan <tariqt@nvidia.com>

Add debugfs entries that describe the Socket-Direct group.

Example:
$ grep -H . /sys/kernel/debug/mlx5/0000\:08\:00.0/sd/*
/sys/kernel/debug/mlx5/0000:08:00.0/sd/group_id:0x00000101
/sys/kernel/debug/mlx5/0000:08:00.0/sd/primary:0000:08:00.0 vhca 0x0
/sys/kernel/debug/mlx5/0000:08:00.0/sd/secondary_0:0000:09:00.0 vhca 0x2

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index 918138c13a92..5012510a69d5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -6,6 +6,7 @@
 #include "lib/mlx5.h"
 #include "fs_cmd.h"
 #include <linux/mlx5/vport.h>
+#include <linux/debugfs.h>
 
 #define sd_info(__dev, format, ...) \
 	dev_info((__dev)->device, "Socket-Direct: " format, ##__VA_ARGS__)
@@ -16,6 +17,7 @@ struct mlx5_sd {
 	u32 group_id;
 	u8 host_buses;
 	struct mlx5_devcom_comp_dev *devcom;
+	struct dentry *dfs;
 	bool primary;
 	union {
 		struct { /* primary */
@@ -391,6 +393,26 @@ static void sd_print_group(struct mlx5_core_dev *primary)
 			MLX5_CAP_GEN(pos, vhca_id));
 }
 
+static ssize_t dev_read(struct file *filp, char __user *buf, size_t count,
+			loff_t *pos)
+{
+	struct mlx5_core_dev *dev;
+	char tbuf[32];
+	int ret;
+
+	dev = filp->private_data;
+	ret = snprintf(tbuf, sizeof(tbuf), "%s vhca %#x\n", pci_name(dev->pdev),
+		       MLX5_CAP_GEN(dev, vhca_id));
+
+	return simple_read_from_buffer(buf, count, pos, tbuf, ret);
+}
+
+static const struct file_operations dev_fops = {
+	.owner	= THIS_MODULE,
+	.open	= simple_open,
+	.read	= dev_read,
+};
+
 int mlx5_sd_init(struct mlx5_core_dev *dev)
 {
 	struct mlx5_core_dev *primary, *pos, *to;
@@ -422,10 +444,20 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 	if (err)
 		goto err_sd_unregister;
 
+	sd->dfs = debugfs_create_dir("sd", mlx5_debugfs_get_dev_root(primary));
+	debugfs_create_x32("group_id", 0400, sd->dfs, &sd->group_id);
+	debugfs_create_file("primary", 0400, sd->dfs, primary, &dev_fops);
+
 	mlx5_sd_for_each_secondary(i, primary, pos) {
+		char name[32];
+
 		err = sd_cmd_set_secondary(pos, primary, alias_key);
 		if (err)
 			goto err_unset_secondaries;
+
+		snprintf(name, sizeof(name), "secondary_%d", i - 1);
+		debugfs_create_file(name, 0400, sd->dfs, pos, &dev_fops);
+
 	}
 
 	sd_info(primary, "group id %#x, size %d, combined\n",
@@ -439,6 +471,7 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 	mlx5_sd_for_each_secondary_to(i, primary, to, pos)
 		sd_cmd_unset_secondary(pos);
 	sd_cmd_unset_primary(primary);
+	debugfs_remove_recursive(sd->dfs);
 err_sd_unregister:
 	sd_unregister(dev);
 err_sd_cleanup:
@@ -462,6 +495,7 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
 	mlx5_sd_for_each_secondary(i, primary, pos)
 		sd_cmd_unset_secondary(pos);
 	sd_cmd_unset_primary(primary);
+	debugfs_remove_recursive(sd->dfs);
 
 	sd_info(primary, "group id %#x, uncombined\n", sd->group_id);
 out:
-- 
2.43.0


