Return-Path: <netdev+bounces-59392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F67181ABF0
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 01:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B48841F22CCF
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 00:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769C015AE;
	Thu, 21 Dec 2023 00:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGeaHGuc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC166119
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 00:57:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA62C433CB;
	Thu, 21 Dec 2023 00:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703120259;
	bh=2Pia4PspxqxAUbnRepBrTBpkl8b/TWmmuJfNOEKYo0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AGeaHGucXqrMW/7dMa0803LPh+LC2rGSPhcLqQoY8JAL8WGmg3+2ZG7QdMs2CrNYu
	 MskfnTFLEBPHFVVwykwjNYOvDo88XD1GBLMsRhLHq6nirxiaBCtvjb7cWW14gtQS7N
	 qkJHAUbVUuRW9Bx3Y1hoUI0kayj99mvJiCuTLnjjDGmBjf1jhVnE8gGkuJOjf8Ngtx
	 9e0l3LCCSzu8LsqmRc21vCa44bwDK0+PWjdLFgwJ7xjInsIrjzhgLBcy4MgY86eIcX
	 6xo8GtKq8rdA36dXW98ib+Evo7Nw4z1h8DtoUY0i/+Q+FohQrbAxSNIASV5ir5NQWC
	 RLT5cmtvbPOYg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [net-next 07/15] net/mlx5: SD, Add informative prints in kernel log
Date: Wed, 20 Dec 2023 16:57:13 -0800
Message-ID: <20231221005721.186607-8-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221005721.186607-1-saeed@kernel.org>
References: <20231221005721.186607-1-saeed@kernel.org>
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
index 3309f21d892e..f68942277c62 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -373,6 +373,21 @@ static void sd_cmd_unset_secondary(struct mlx5_core_dev *secondary)
 	mlx5_fs_cmd_set_l2table_entry_silent(secondary, 0);
 }
 
+static void sd_print_group(struct mlx5_core_dev *primary)
+{
+	struct mlx5_sd *sd = mlx5_get_sd(primary);
+	struct mlx5_core_dev *pos;
+	int i;
+
+	sd_info(primary, "group id %#x, primary %s, vhca %u\n",
+		sd->group_id, pci_name(primary->pdev),
+		MLX5_CAP_GEN(primary, vhca_id));
+	mlx5_sd_for_each_secondary(i, primary, pos)
+		sd_info(primary, "group id %#x, secondary#%d %s, vhca %u\n",
+			sd->group_id, i - 1, pci_name(pos->pdev),
+			MLX5_CAP_GEN(pos, vhca_id));
+}
+
 int mlx5_sd_init(struct mlx5_core_dev *dev)
 {
 	struct mlx5_core_dev *primary, *pos, *to;
@@ -410,6 +425,10 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 			goto err_unset_secondaries;
 	}
 
+	sd_info(primary, "group id %#x, size %d, combined\n",
+		sd->group_id, mlx5_devcom_comp_get_size(sd->devcom));
+	sd_print_group(primary);
+
 	return 0;
 
 err_unset_secondaries:
@@ -440,6 +459,8 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
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


