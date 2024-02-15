Return-Path: <netdev+bounces-71931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 426B1855951
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 04:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29E5291B68
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 03:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23F917C8D;
	Thu, 15 Feb 2024 03:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JllppSNb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E81ABA2E
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 03:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707966505; cv=none; b=b6UGTfTd01oKgnnN7iVSUAJYSlFG/01fwI9BCUcUNhoRtN9gLejZFMbLw59jJ3/jFHkciPp48bmeW11yOzflDYIEDk1uUb4LqPiT16dXHCB/VdLgBdMHDVnle6vVnHUHmWvoFxaApz0R8MOAySudF+jl9HhYEKVC/j5map/jjfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707966505; c=relaxed/simple;
	bh=MWqvUJqC47lFobMmXhaMhiTvVoB9cIGhGiqWl20SGac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRUPyKSw2qCGN6HHF0fsEVgfRbB8FPIkujuvk8BEV8zQmVHwmjdutEEeIusByW3t9W2LShPgVgvxpioe5HVqxtyZ/sZYMqMo6qu9k5/THc918UZgM1s3LzR51o9T5aVcSZrM8E/g7jiIJ2XOnUI/pG1nOSb/NokLHZa++Ei0jo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JllppSNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45EA7C433F1;
	Thu, 15 Feb 2024 03:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707966505;
	bh=MWqvUJqC47lFobMmXhaMhiTvVoB9cIGhGiqWl20SGac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JllppSNbpdeE3F0QXmO/SI7LeHVtVwaW0yZX7Kr+GyXXE2cQANoDkVLhGGM/T115L
	 r1KnmOST8GL7sYxK8iqZKY/DZ21zdvUq8KeoAUJXHmjJvFFv3OTB8gfZDbqoKXzyFZ
	 kF9ovpLwTbAWeT+1oXJ5VZGOhoPjneF2nsBBPR2r3XISBUTw8Q4z5EVXRmNOo1A9sg
	 WFo+7yd6gdlbq+7fAJ8l6YtpWe3DLKnR8EY0Y4K3FWtQdDAp6EnAtiVMpO7Vv8r85B
	 7VPOxLS7sGjlqvXJwquAmqGkdtzJ9LotpKpbLfDFWZiik8SvwB8EiVm4+q4XqN6zvG
	 NG4vDOyn/2hAg==
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
Subject: [net-next V3 06/15] net/mlx5: SD, Add informative prints in kernel log
Date: Wed, 14 Feb 2024 19:08:05 -0800
Message-ID: <20240215030814.451812-7-saeed@kernel.org>
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
2.43.0


