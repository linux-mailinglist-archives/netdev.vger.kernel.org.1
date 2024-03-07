Return-Path: <netdev+bounces-78282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9008749F0
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 09:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AD07282928
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 08:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6A8839F1;
	Thu,  7 Mar 2024 08:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2J5p9Jg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277D0839EF
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 08:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709800963; cv=none; b=Dcev8FJ4AEJqLYkmnOZZuToVatqbPRiEx82lbDqnInXtH2mNKEOIVf1tdRF2YEcu5HauTkM4gaOfp2DRalchNYtqJSPieIoBei7xlKx5t0WqRLSRWySr8Pgp1lIeGoQZBBDiCytpbMnvoTVnpExD+BBBRa76ldGqBzhbHUX/NJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709800963; c=relaxed/simple;
	bh=aJO7z7J6QkZg90C6iQiXeOQf6XCLg+xoSnpEi6kPRiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Me4p28jfHHdRGAphuhnaOs8YPILbPoS5ZlHaJKTZoLaQGkaCZ+Xv9P+Rh/GdQ6rHgXSuBXuaW6a5YRxlCtMW5p4Y/OKqzHyUEOieWJyt/g2azEkUcT/Jh2CCdJy0/TD+YpA6/9RnZjEjEijIFQCuzdHdBGTxHPfj7ApiG9fXHpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2J5p9Jg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBF2C43394;
	Thu,  7 Mar 2024 08:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709800962;
	bh=aJO7z7J6QkZg90C6iQiXeOQf6XCLg+xoSnpEi6kPRiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h2J5p9JgGraLijOdaWfzsPk4yTyQNOcdyzjxnfggFQaMOCqsd89eEZxZruiA7aRzW
	 RI/1TxyuAQuIhqDBSZfKZqpkZA9LgjKUpnbEVBkODs0SFCvvSskhPkxAfDmmKbtQSf
	 JheBPZ8hi7yL4m3i1r3I8HGFbG1seuBE1FuIjJf6H2Fd2L/AHjrXewaF58p6DodqRv
	 IuEqKihZVEU4haMhjjxdnhUf5GyAXlII2YzcDM0fIDt6MXxMJUX4EFK49FaCqRnZpn
	 h7vGBl2kxRoQYWk667Rscv/uhpIqHYPnpnzdEaXxUE6VFkoVrBTOJuoSgb14+ni38j
	 l2jKCznVrQ7fA==
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
Subject: [net-next V6 06/15] net/mlx5: SD, Add informative prints in kernel log
Date: Thu,  7 Mar 2024 00:42:20 -0800
Message-ID: <20240307084229.500776-7-saeed@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240307084229.500776-1-saeed@kernel.org>
References: <20240307084229.500776-1-saeed@kernel.org>
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


