Return-Path: <netdev+bounces-236551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C32EC3DF29
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 01:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB6674E59CE
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 00:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E4D1E8329;
	Fri,  7 Nov 2025 00:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kf6RUULZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8C41D61BC
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 00:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762474149; cv=none; b=kGk2Gqepj05Bd9i98bb3DthAlks0ru36J5/b9Sghhg+ZarAWFKtRIvnd8SOtJ5YIPXzN+7B4k8pkBzF5trS+GDEoiVfZzde/06rqDzr6Rczp/yvZqm+amifzK+dz9ez+GYJc6AP8kERYYO045jgFd1wBK0IuCbuMQ2SfrwD/APY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762474149; c=relaxed/simple;
	bh=oP81PNwkIIKElhU0yfZftLgi3jPdmpAqHiqEHx34yyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LNC7e2BtS/8X2Wb57aF6TiJdSnnhrUb6N78q2s1U3vh8d/0fSNlpYEWK+IF8Ydh8nOk4CokysvkJNzNgAoHzfz4SmJAD6p2R3DwTbTDMNmNmoCut+4j0bqK9KKEDOCPxj480t/Q8c0VYHwxd7l8JZ5V85stgwvd4CSXBmU7yQC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kf6RUULZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED825C4CEFB;
	Fri,  7 Nov 2025 00:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762474148;
	bh=oP81PNwkIIKElhU0yfZftLgi3jPdmpAqHiqEHx34yyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kf6RUULZUiMrEiWjOsUrfVROdWM6mVSrl2h6PhXmtIV5GGzbE0hkUPcU/cpkbUhVu
	 skm6HwYWfuhed9s+fNKwnfJmz/3YmNTK8lbWaDhhJGTCITly/24nWvYbYbz6Pt5XWT
	 lwTJ8JuuhpiqM6eYWosKswumt8yWr3WbmCGdJMuHhdqfVSSIbAld+jhBxOUunOWlrU
	 4sVQ//a+qgxdTypUFKxUfn49ulnqvBen+niINHW9C70i9pfSAAWRhUd4KsBoPeS/Ep
	 alSo8DZ6qG+qlQsfcogWJhSvRww4LbFRs6erTfLUG7bQCpZkgFGKErihkIzCIjOOi4
	 CQ3GvOJqmftzw==
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
	Jiri Pirko <jiri@nvidia.com>,
	mbloch@nvidia.com,
	Adithya Jayachandran <ajayachandra@nvidia.com>
Subject: [PATCH net-next V2 2/3] net/mlx5: MPFS, add support for dynamic enable/disable
Date: Thu,  6 Nov 2025 16:08:30 -0800
Message-ID: <20251107000831.157375-3-saeed@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107000831.157375-1-saeed@kernel.org>
References: <20251107000831.157375-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

MPFS (Multi PF Switch) is enabled by default in Multi-Host environments,
the driver keeps a list of desired unicast mac addresses of all vports
(vfs/Sfs) and applied to HW via L2_table FW command.

Add API to dynamically apply the list of MACs to HW when needed for next
patches, to utilize this new API in devlink eswitch active/in-active uAPI.

Issue: 4314625
Change-Id: I185c144319e514f787811f556888e1b727bdbf35
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Adithya Jayachandran <ajayachandra@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/lib/mpfs.c    | 115 +++++++++++++++---
 .../ethernet/mellanox/mlx5/core/lib/mpfs.h    |   9 ++
 2 files changed, 107 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.c
index 4450091e181a..f27b5adb9606 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.c
@@ -65,13 +65,14 @@ static int del_l2table_entry_cmd(struct mlx5_core_dev *dev, u32 index)
 /* UC L2 table hash node */
 struct l2table_node {
 	struct l2addr_node node;
-	u32                index; /* index in HW l2 table */
+	int                index; /* index in HW l2 table */
 	int                ref_count;
 };
 
 struct mlx5_mpfs {
 	struct hlist_head    hash[MLX5_L2_ADDR_HASH_SIZE];
 	struct mutex         lock; /* Synchronize l2 table access */
+	bool                 enabled;
 	u32                  size;
 	unsigned long        *bitmap;
 };
@@ -114,6 +115,8 @@ int mlx5_mpfs_init(struct mlx5_core_dev *dev)
 		return -ENOMEM;
 	}
 
+	mpfs->enabled = true;
+
 	dev->priv.mpfs = mpfs;
 	return 0;
 }
@@ -135,7 +138,7 @@ int mlx5_mpfs_add_mac(struct mlx5_core_dev *dev, u8 *mac)
 	struct mlx5_mpfs *mpfs = dev->priv.mpfs;
 	struct l2table_node *l2addr;
 	int err = 0;
-	u32 index;
+	int index;
 
 	if (!mpfs)
 		return 0;
@@ -148,30 +151,34 @@ int mlx5_mpfs_add_mac(struct mlx5_core_dev *dev, u8 *mac)
 		goto out;
 	}
 
-	err = alloc_l2table_index(mpfs, &index);
-	if (err)
-		goto out;
-
 	l2addr = l2addr_hash_add(mpfs->hash, mac, struct l2table_node, GFP_KERNEL);
 	if (!l2addr) {
 		err = -ENOMEM;
-		goto hash_add_err;
+		goto out;
 	}
 
-	err = set_l2table_entry_cmd(dev, index, mac);
-	if (err)
-		goto set_table_entry_err;
+	index = -1;
+
+	if (mpfs->enabled) {
+		err = alloc_l2table_index(mpfs, &index);
+		if (err)
+			goto hash_del;
+		err = set_l2table_entry_cmd(dev, index, mac);
+		if (err)
+			goto free_l2table_index;
+		mlx5_core_dbg(dev, "MPFS entry %pM, set @index (%d)\n",
+			      l2addr->node.addr, l2addr->index);
+	}
 
 	l2addr->index = index;
 	l2addr->ref_count = 1;
 
 	mlx5_core_dbg(dev, "MPFS mac added %pM, index (%d)\n", mac, index);
 	goto out;
-
-set_table_entry_err:
-	l2addr_hash_del(l2addr);
-hash_add_err:
+free_l2table_index:
 	free_l2table_index(mpfs, index);
+hash_del:
+	l2addr_hash_del(l2addr);
 out:
 	mutex_unlock(&mpfs->lock);
 	return err;
@@ -183,7 +190,7 @@ int mlx5_mpfs_del_mac(struct mlx5_core_dev *dev, u8 *mac)
 	struct mlx5_mpfs *mpfs = dev->priv.mpfs;
 	struct l2table_node *l2addr;
 	int err = 0;
-	u32 index;
+	int index;
 
 	if (!mpfs)
 		return 0;
@@ -200,12 +207,86 @@ int mlx5_mpfs_del_mac(struct mlx5_core_dev *dev, u8 *mac)
 		goto unlock;
 
 	index = l2addr->index;
-	del_l2table_entry_cmd(dev, index);
+	if (index >= 0) {
+		del_l2table_entry_cmd(dev, index);
+		free_l2table_index(mpfs, index);
+		mlx5_core_dbg(dev, "MPFS entry %pM, deleted @index (%d)\n",
+			      mac, index);
+	}
 	l2addr_hash_del(l2addr);
-	free_l2table_index(mpfs, index);
 	mlx5_core_dbg(dev, "MPFS mac deleted %pM, index (%d)\n", mac, index);
 unlock:
 	mutex_unlock(&mpfs->lock);
 	return err;
 }
 EXPORT_SYMBOL(mlx5_mpfs_del_mac);
+
+int mlx5_mpfs_enable(struct mlx5_core_dev *dev)
+{
+	struct mlx5_mpfs *mpfs = dev->priv.mpfs;
+	struct l2table_node *l2addr;
+	struct hlist_node *n;
+	int err = 0;
+
+	if (!mpfs)
+		return -ENODEV;
+
+	mutex_lock(&mpfs->lock);
+	if (mpfs->enabled)
+		goto out;
+	mpfs->enabled = true;
+	mlx5_core_dbg(dev, "MPFS enabling mpfs\n");
+
+	mlx5_mpfs_foreach(l2addr, n, mpfs) {
+		u32 index;
+
+		err = alloc_l2table_index(mpfs, &index);
+		if (err) {
+			mlx5_core_err(dev, "Failed to allocated MPFS index for %pM, err(%d)\n",
+				      l2addr->node.addr, err);
+			goto out;
+		}
+
+		err = set_l2table_entry_cmd(dev, index, l2addr->node.addr);
+		if (err) {
+			mlx5_core_err(dev, "Failed to set MPFS l2table entry for %pM index=%d, err(%d)\n",
+				      l2addr->node.addr, index, err);
+			free_l2table_index(mpfs, index);
+			goto out;
+		}
+
+		l2addr->index = index;
+		mlx5_core_dbg(dev, "MPFS entry %pM, set @index (%d)\n",
+			      l2addr->node.addr, l2addr->index);
+	}
+out:
+	mutex_unlock(&mpfs->lock);
+	return err;
+}
+
+void mlx5_mpfs_disable(struct mlx5_core_dev *dev)
+{
+	struct mlx5_mpfs *mpfs = dev->priv.mpfs;
+	struct l2table_node *l2addr;
+	struct hlist_node *n;
+
+	if (!mpfs)
+		return;
+
+	mutex_lock(&mpfs->lock);
+	if (!mpfs->enabled)
+		goto unlock;
+	mlx5_mpfs_foreach(l2addr, n, mpfs) {
+		if (l2addr->index < 0)
+			continue;
+		del_l2table_entry_cmd(dev, l2addr->index);
+		free_l2table_index(mpfs, l2addr->index);
+		mlx5_core_dbg(dev, "MPFS entry %pM, deleted @index (%d)\n",
+			      l2addr->node.addr, l2addr->index);
+		l2addr->index = -1;
+	}
+	mpfs->enabled = false;
+	mlx5_core_dbg(dev, "MPFS disabled\n");
+unlock:
+	mutex_unlock(&mpfs->lock);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.h
index 4a293542a7aa..be0ccdd5a0aa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.h
@@ -45,6 +45,10 @@ struct l2addr_node {
 	u8                addr[ETH_ALEN];
 };
 
+#define mlx5_mpfs_foreach(hs, tmp, mpfs) \
+	for (int j = 0; j < MLX5_L2_ADDR_HASH_SIZE; j++) \
+		hlist_for_each_entry_safe(hs, tmp, &(mpfs)->hash[j], node.hlist)
+
 #define for_each_l2hash_node(hn, tmp, hash, i) \
 	for (i = 0; i < MLX5_L2_ADDR_HASH_SIZE; i++) \
 		hlist_for_each_entry_safe(hn, tmp, &(hash)[i], hlist)
@@ -82,11 +86,16 @@ struct l2addr_node {
 })
 
 #ifdef CONFIG_MLX5_MPFS
+struct mlx5_core_dev;
 int  mlx5_mpfs_init(struct mlx5_core_dev *dev);
 void mlx5_mpfs_cleanup(struct mlx5_core_dev *dev);
+int mlx5_mpfs_enable(struct mlx5_core_dev *dev);
+void mlx5_mpfs_disable(struct mlx5_core_dev *dev);
 #else /* #ifndef CONFIG_MLX5_MPFS */
 static inline int  mlx5_mpfs_init(struct mlx5_core_dev *dev) { return 0; }
 static inline void mlx5_mpfs_cleanup(struct mlx5_core_dev *dev) {}
+static inline int mlx5_mpfs_enable(struct mlx5_core_dev *dev) { return 0; }
+static inline void mlx5_mpfs_disable(struct mlx5_core_dev *dev) {}
 #endif
 
 #endif
-- 
2.51.1


