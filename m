Return-Path: <netdev+bounces-248274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9D6D06534
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 22:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6BD33078EE5
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 21:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CDA3382D4;
	Thu,  8 Jan 2026 21:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkRw1P5S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BB53321A5
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 21:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767907630; cv=none; b=TI4kzNdeKgctEGgNNOAaF8JTfDFBMuKIt2qH6tpq1hLFOEUrOkd/JzgqE4N/qa1tJ/Iu/0BAiVDmL9YHEWfmaEVespwFFWPX+uL1ITKBbNVZ6RUkGGsZd1RGvb8c0s2tMcR8GzzQWgmLxrcSZvFVffcT7P2mbQM7PkGbw2syPFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767907630; c=relaxed/simple;
	bh=tE5JoeY5dorpvYM0BilOd6py7iFh0xJfYhCxLMoE0II=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2uszX5N4HG0Xp0iExtS0QPAlKtfAFzIAeyd9rnBAD8OdJDPYw5d5dxD4pCKS2j0BDFj80HlxBJY8ymWMCernlIDtR5ECucuU9Qfsg7LsPIiHu1rj9C1PmcXtTGJx2Wjkn1RULkqVjV2JLpVFCYfxUtkNhhZCnWMkWvUaGACqTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkRw1P5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DABC2BC87;
	Thu,  8 Jan 2026 21:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767907630;
	bh=tE5JoeY5dorpvYM0BilOd6py7iFh0xJfYhCxLMoE0II=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jkRw1P5SkF5Ea/Z9NER0FsYNe5SzOpkjh5wzvHfVLsYzOLIDEgclNZe5uNwhwuwEC
	 n5lpNCmH2R75y1xErqA/ejx/BVVJHpvCtTx2eO6oLaYfa/MxgaFknlYx5mamKJVjWA
	 0Rlys7JmmXHfpc5LcOgBgekUkHYOR3xCOIDBqxSbtY9k7Uc5Zdu6bhjZTZFIxzhmpi
	 2BtheBFnw4kAbnCOpSue7YlatnoJl55QzEuAYn2TeVLrvA9BlZZUIxEnsp+jhCBQJK
	 jsb+8YHW3AWaHM3Mf7M55HO9YfeS27GF37lxyT5+jWote2FNMjnFz1CWVqXu7oVwLV
	 9NF8R3oSPfHyg==
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
Subject: [PATCH net 4/4] net/mlx5e: Restore destroying state bit after profile cleanup
Date: Thu,  8 Jan 2026 13:26:57 -0800
Message-ID: <20260108212657.25090-5-saeed@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108212657.25090-1-saeed@kernel.org>
References: <20260108212657.25090-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

Profile rollback can fail in mlx5e_netdev_change_profile() and we will
end up with invalid mlx5e_priv memset to 0, we must maintain the
'destroying' bit in order to gracefully shutdown even if the
profile/priv are not valid.

This patch maintains the previous state of the 'destroying' state of
mlx5e_priv after priv cleanup, to allow the remove flow to cleanup
common resources from mlx5_core to avoid FW fatal errors as seen below:

$ devlink dev eswitch set pci/0000:00:03.0 mode switchdev
    Error: mlx5_core: Failed setting eswitch to offloads.
dmesg: mlx5_core 0000:00:03.0 enp0s3np0: failed to rollback to orig profile, ...

$ devlink dev reload pci/0000:00:03.0

mlx5_core 0000:00:03.0: E-Switch: Disable: mode(LEGACY), nvfs(0), necvfs(0), active vports(0)
mlx5_core 0000:00:03.0: poll_health:803:(pid 519): Fatal error 3 detected
mlx5_core 0000:00:03.0: firmware version: 28.41.1000
mlx5_core 0000:00:03.0: 0.000 Gb/s available PCIe bandwidth (Unknown x255 link)
mlx5_core 0000:00:03.0: mlx5_function_enable:1200:(pid 519): enable hca failed
mlx5_core 0000:00:03.0: mlx5_function_enable:1200:(pid 519): enable hca failed
mlx5_core 0000:00:03.0: mlx5_health_try_recover:340:(pid 141): handling bad device here
mlx5_core 0000:00:03.0: mlx5_handle_bad_state:285:(pid 141): Expected to see disabled NIC but it is full driver
mlx5_core 0000:00:03.0: mlx5_error_sw_reset:236:(pid 141): start
mlx5_core 0000:00:03.0: NIC IFC still 0 after 4000ms.

Fixes: c4d7eb57687f ("net/mxl5e: Add change profile method")
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 2c06a4abea04..9042c8a388e4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -6325,6 +6325,7 @@ int mlx5e_priv_init(struct mlx5e_priv *priv,
 
 void mlx5e_priv_cleanup(struct mlx5e_priv *priv)
 {
+	bool destroying = test_bit(MLX5E_STATE_DESTROYING, &priv->state);
 	int i;
 
 	/* bail if change profile failed and also rollback failed */
@@ -6352,6 +6353,8 @@ void mlx5e_priv_cleanup(struct mlx5e_priv *priv)
 	}
 
 	memset(priv, 0, sizeof(*priv));
+	if (destroying) /* restore destroying bit, to allow unload */
+		set_bit(MLX5E_STATE_DESTROYING, &priv->state);
 }
 
 static unsigned int mlx5e_get_max_num_txqs(struct mlx5_core_dev *mdev,
-- 
2.52.0


