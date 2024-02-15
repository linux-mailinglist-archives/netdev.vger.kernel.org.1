Return-Path: <netdev+bounces-71932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9032855952
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 04:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64FDC291C35
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 03:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33DA4C69;
	Thu, 15 Feb 2024 03:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+iOiQY1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF721182DB
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 03:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707966506; cv=none; b=oUfndujfBII2sX0fuDUTVuMzS4J1KNLgTqfdsVI0R/Mep75KHcfEHwxdlfMHHWNGuYeGv60u97cLBGvLsihtPgbInrNjpyinqhtt8MQIVBOBrCtLYdo8c0qWQJFHgZ+FfcDi8iqORT1tj9OSMHHCQXnTHauo2Jie//NJvkOieSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707966506; c=relaxed/simple;
	bh=gDbps/6ATsXpIaTLypnNU+yZpLcsovJA+GHrDn5LBP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NFL+53EeAcWZp4Ii/1QRT/eaAZeQdICNcD9A8TRW8exYHNLQ0whWgOtdWTS7fO8CrtmVeBpsOoxOffPf0eCoAuPM50gKxbA1wVQH0q1+3jTkq90Kb5JNYPIrrBI5EkRS+2DlT39pAxFp7k/pP2BnHVm3ZKP3dY8y87VJWit9ny0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+iOiQY1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39242C433C7;
	Thu, 15 Feb 2024 03:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707966506;
	bh=gDbps/6ATsXpIaTLypnNU+yZpLcsovJA+GHrDn5LBP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U+iOiQY142HPUllw2HNFgfiW50D4BOBhLK9SJ/X/xjPg3fySOrsXplFwlOgTRIOah
	 hHgOxh4Xi8r7c89/TakuF5ZO2LG0sAXn1GEPDkVgHL4uuu4/AJf7hdh75UcY3T89Oc
	 ukDH5NK84pH2G2mJXF/LslMtaPcjHXqaMg6+H5WufoOQdwM913kwzVDr09xOdv4W2/
	 rV72e6JXVDqFrts1KmOqxo8qR+TyFuUnkO0pn4OFKHpk4vqJmTsZaNY6PWNC8jp+Dr
	 EWZF2j+XbRK8MwOV0HF1U373ZVDsx1+r5Sjv2HFYPBt9ogSb/KB+RDjNkSkhSjixb9
	 m61bxai56Utkw==
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
Subject: [net-next V3 07/15] net/mlx5: SD, Add debugfs
Date: Wed, 14 Feb 2024 19:08:06 -0800
Message-ID: <20240215030814.451812-8-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215030814.451812-1-saeed@kernel.org>
References: <20240215030814.451812-1-saeed@kernel.org>
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


