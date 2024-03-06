Return-Path: <netdev+bounces-77747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 678F0872D2D
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 04:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CE5628E497
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 03:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A445A15E89;
	Wed,  6 Mar 2024 03:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kg1V44Tn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DF1DF5C
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 03:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709694195; cv=none; b=EpmvnV08Cn0s/4CWUenBlL0JHY/k/rdJgnXRzzWckvPwyeGZss9Jc5EwbK5cTta7M/6fkC5YTHGDGnSMrjXIzKPag7/0CVMFCv88M9/OeqJ5liEeqXcnxuPE8TomYQUMB1Uop3bdEPm0hUqCX1XxCAWbydspyMAzoUOx32IAxq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709694195; c=relaxed/simple;
	bh=8DI8AmyIHtBjzKKYwZA4C5/bbYODVCu2V7iG9u35oz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XVatowXY6Dqr0XObvx9uMwqYLxBX6jB6Qe1D3+tPC+ZP0ZtiaXNcncZM9Hc11YDRsBWo9+qLPkAFRJsuNniZ6ciSl8VBDkevCYDmXS5Zz/mA1Wh17ctkgxDll40/tDiUaLCFZkzYotG/jw+BI6p5DDei7l2wuZ00PSTqaI0Zz9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kg1V44Tn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD93DC433C7;
	Wed,  6 Mar 2024 03:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709694194;
	bh=8DI8AmyIHtBjzKKYwZA4C5/bbYODVCu2V7iG9u35oz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kg1V44TnVe6nn0JwDbkuNrHKHnpcogOpDV+xsZO2jDYmzxdFnDB3dS5lyppts/n3s
	 /o0bRndsyXkM+8jDDC/xgi6cKnoLxPEO29J3qqVDDhrV8ocGYj5cxGyX5E04P57fFR
	 Uck/rsEnTu01RjHjYETRNEEuTcJIxTM9xF2Vp95t2UttG9edRwdn3EkLV7RQS21lTP
	 wrNdUAHdO/nKKjBxliD4YlTcxktE5eWmw2YEH0r1dGG4nlJSfQJNnESYP95QL3kHkI
	 iqPZ5M67f3F94QIjiG8zFbx194g44xP575uJTAnjYFr+K6ZVCjQUgK2U0d9OuZw2X6
	 uj5gFMfvtDJjQ==
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
Subject: [net-next V5 07/15] net/mlx5: SD, Add debugfs
Date: Tue,  5 Mar 2024 19:02:50 -0800
Message-ID: <20240306030258.16874-8-saeed@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240306030258.16874-1-saeed@kernel.org>
References: <20240306030258.16874-1-saeed@kernel.org>
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
$ grep -H . /sys/kernel/debug/mlx5/0000\:08\:00.0/multi-pf/*
/sys/kernel/debug/mlx5/0000:08:00.0/multi-pf/group_id:0x00000101
/sys/kernel/debug/mlx5/0000:08:00.0/multi-pf/primary:0000:08:00.0 vhca 0x0
/sys/kernel/debug/mlx5/0000:08:00.0/multi-pf/secondary_0:0000:09:00.0 vhca 0x2

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index 918138c13a92..5b28084e8a03 100644
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
 
+	sd->dfs = debugfs_create_dir("multi-pf", mlx5_debugfs_get_dev_root(primary));
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
2.44.0


