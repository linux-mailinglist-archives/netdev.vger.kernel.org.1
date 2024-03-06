Return-Path: <netdev+bounces-77746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F42872D2C
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 04:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E85328E3FA
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 03:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1510171BB;
	Wed,  6 Mar 2024 03:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0izGELG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E53B15E89
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 03:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709694193; cv=none; b=WvFEDZJRiWXVComahI5c7lFZ6l2p6rX3rZDuRo2ZaC5IKEm0mrP4YIIF8Tfv1jJVa9Hzdk+oUitGiZhkXLjhipM1TNXe6pp0a4JvLVYN4AFmdsFHGKPxE4nfOYM8nOlT+MeJWu04rT6yx5o/s5rjBXxWl00bJTHaEnYcH213mW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709694193; c=relaxed/simple;
	bh=aJO7z7J6QkZg90C6iQiXeOQf6XCLg+xoSnpEi6kPRiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VM+3QYLWytT0bBqPbnXR56hGnFKEMdOUT5ST6+IY5kAynuWaX+VFK318qJNA4TGN2BWqOC/m/Gpl8FgxA7uTJabR3AQ1EtpPZWzXm1af8TaZvdicPN2o2w7Ap9GIhIBou/zaH4wlakTAVSFsCqxGsSvkdLF1NvlhnhCed2jQSo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0izGELG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4277EC43399;
	Wed,  6 Mar 2024 03:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709694193;
	bh=aJO7z7J6QkZg90C6iQiXeOQf6XCLg+xoSnpEi6kPRiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L0izGELGs6eYJPJbwLmpR2MwccFTEZXconPvIrqN7FGISetct3DofWXNGeRynLGp1
	 F2pp9l9+06X8b3uclkOxTO/UHxAecpgfCCWb/agKxNEZRfgYHIpTwiMJ4SLaovMk0R
	 bW5WSNgwkJvmtSumAWx5SOMICVBP3K9qbzbU3R0h6tj26/XsWpUvzNeDGrWbuE1YWk
	 +O1x1HIVgk7+IA/spc6vJKSAALCKnYx8NHE303JrQVdqp7ivMWEgb4vSC/GTT4Ykki
	 JdZMOzWVw2MkHZJK3fj4btn1jBdgqCxEEXaOIgUpb8mQ5nrqu/lbxQFWnVkWn0NDnu
	 fv4Yl958ahZ5w==
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
Subject: [net-next V5 06/15] net/mlx5: SD, Add informative prints in kernel log
Date: Tue,  5 Mar 2024 19:02:49 -0800
Message-ID: <20240306030258.16874-7-saeed@kernel.org>
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

Print to kernel log when an SD group moves from/to ready state.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index 76c2426c2498..918138c13a92 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -376,6 +376,21 @@ static void sd_cmd_unset_secondary(struct mlx5_core_dev *secondary)
 	mlx5_fs_cmd_set_l2table_entry_silent(secondary, 0);
 }
 
+static void sd_print_group(struct mlx5_core_dev *primary)
+{
+	struct mlx5_sd *sd = mlx5_get_sd(primary);
+	struct mlx5_core_dev *pos;
+	int i;
+
+	sd_info(primary, "group id %#x, primary %s, vhca %#x\n",
+		sd->group_id, pci_name(primary->pdev),
+		MLX5_CAP_GEN(primary, vhca_id));
+	mlx5_sd_for_each_secondary(i, primary, pos)
+		sd_info(primary, "group id %#x, secondary_%d %s, vhca %#x\n",
+			sd->group_id, i - 1, pci_name(pos->pdev),
+			MLX5_CAP_GEN(pos, vhca_id));
+}
+
 int mlx5_sd_init(struct mlx5_core_dev *dev)
 {
 	struct mlx5_core_dev *primary, *pos, *to;
@@ -413,6 +428,10 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 			goto err_unset_secondaries;
 	}
 
+	sd_info(primary, "group id %#x, size %d, combined\n",
+		sd->group_id, mlx5_devcom_comp_get_size(sd->devcom));
+	sd_print_group(primary);
+
 	return 0;
 
 err_unset_secondaries:
@@ -443,6 +462,8 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
 	mlx5_sd_for_each_secondary(i, primary, pos)
 		sd_cmd_unset_secondary(pos);
 	sd_cmd_unset_primary(primary);
+
+	sd_info(primary, "group id %#x, uncombined\n", sd->group_id);
 out:
 	sd_unregister(dev);
 	sd_cleanup(dev);
-- 
2.44.0


