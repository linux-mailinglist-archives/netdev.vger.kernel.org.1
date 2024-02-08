Return-Path: <netdev+bounces-70083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFB284D934
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 04:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6F561C22C6D
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 03:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA88A2E820;
	Thu,  8 Feb 2024 03:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kr+Qg6jU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D872E652
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 03:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707364454; cv=none; b=bRefQHrTJOIvcYF8VQSU39nK1rP9IJzuq3mJW+1h0e5FYMAuSyFS2IQCmkaBszFv/ssYUQ6bbMw73gCAm0Jx9N1WSnBhnD4pZiodeyuMcc9lUUHS5ICFoah68gdUUPoHw7BAqirX6/NY25wCkbqh3+LmbWumLiNE+x9r2PvfcdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707364454; c=relaxed/simple;
	bh=MWqvUJqC47lFobMmXhaMhiTvVoB9cIGhGiqWl20SGac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y5/JXHfaQY3Sg1dXUClR8GiNAMW+uK73iaan7c0EgdZDmzMY6YuO+ewUPmAYYi8Ibny+5klBpE3HPo/NALB8Meudw0c1tFYXnBBkeNypBWwoz3Y5ercePRfebQe8hUII0+h+PoSCG8g9Q4E2qs8yq9fFcpWNrUoo3ZyXle0Tczg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kr+Qg6jU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4015FC43390;
	Thu,  8 Feb 2024 03:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707364454;
	bh=MWqvUJqC47lFobMmXhaMhiTvVoB9cIGhGiqWl20SGac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kr+Qg6jUvB0jFAM7MCMB9MuhCR66qlKk7bHF4Znuma6REkFHISKQAtRcrKE75Q9xo
	 3ARdCX7+fNRGHQGPRGVeoVFuXEhqd9ppsh2+3ieL3HUlBRt9ERwK4KhFADztEYbnw6
	 akyn+wRypiwJHW6X34xZMgFN3tJfFostjRg45YPHRC9bc1ZtlufM6H9r74kzY2SQl0
	 +tkK+fchm6GNGUury/PwPMTcMqbN0sO6b/KSwE/h1FGHpn2eMWpGoqombIfEHb2qzt
	 T44jMnq3tIzmap8zM30uX6eMJzRfACscEmYjRv8nneQGoKWMEAsAu9EaIrcbZ6UsLZ
	 J9w22lXy53m7A==
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
Subject: [net-next V2 06/15] net/mlx5: SD, Add informative prints in kernel log
Date: Wed,  7 Feb 2024 19:53:43 -0800
Message-ID: <20240208035352.387423-7-saeed@kernel.org>
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


