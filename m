Return-Path: <netdev+bounces-229844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DF3BE12D5
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 03:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE4E53E2969
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 01:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212091624D5;
	Thu, 16 Oct 2025 01:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eekoopIG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12C94A21
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 01:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760578620; cv=none; b=bnOlumxd/xYTST4Vkw4C8trqyx2x26pfYUmXuZfU2TkI+9EdOpLYpdQV6c0kYzkhPc7LNiXnNxloHyku7TpQ9T4jbyrJKUTiCDLsgPKGmTeZ2SzrDhqlkdqRKoy2l/hLyY/5F9TQhG5xxozwSqR8Y8LCNOrNMuYuoJsDQrlF9Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760578620; c=relaxed/simple;
	bh=grBdeOmlk0IuQYYWzYZChwuGjsJnisuwSaxW9gQinWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ar1IInx/EJIy4wkWHoE+ibpoKXaliUxHpVNokeCM6mliEYyE7gru+hVBKT0oi/PvW4WGi6bCQLl0aLie91BQC4GkVj+7GFtgrT7hnDacqKsQK3ERWF/6lqEzevJgVNyFxWEV5IiowxslN26ITgvKjR+VD/OZBw78V4x3EMh6PsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eekoopIG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D940C4CEF8;
	Thu, 16 Oct 2025 01:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760578619;
	bh=grBdeOmlk0IuQYYWzYZChwuGjsJnisuwSaxW9gQinWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eekoopIGJdP1+PMNjv6iiWlr5N1vSZ2uPzD+H0IwQYMjeyGky0ImawHNrlIe9XvnM
	 wUrhH8sH2dsc41qI+G3qewqrCq5z0/pSdSBhppwGdm1zBkt1IrBqO/d1Y5mfYb3+Qn
	 Tg7/54qZweQM8MdFHDPPY9f6Tj55KAEHBBP4Pz4E1+NxEbMmafYq6ttwO240yBxxz7
	 YSWFxCHOaXN2czHJoHhC8ASZKWUaLmxQ1Z/uWuIZ+Tw2nEOMci2guYS7JAoFlF8YDo
	 XRJgE9GwSOun2ElcY+WOc5fQwuv+HiNOsLBilNtyDJb6cuc/tstOUxftUIxPMu220Q
	 94xdP1ksl6RMA==
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
	mbloch@nvidia.com,
	Adithya Jayachandran <ajayachandra@nvidia.com>
Subject: [PATCH net-next 2/3] net/mlx5: MPFS, add support for dynamic enable/disable
Date: Wed, 15 Oct 2025 18:36:17 -0700
Message-ID: <20251016013618.2030940-3-saeed@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016013618.2030940-1-saeed@kernel.org>
References: <20251016013618.2030940-1-saeed@kernel.org>
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

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Adithya Jayachandran <ajayachandra@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/lib/mpfs.c    | 111 +++++++++++++++---
 .../ethernet/mellanox/mlx5/core/lib/mpfs.h    |   9 ++
 2 files changed, 103 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.c
index 4450091e181a..9230c31539fb 100644
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
@@ -148,30 +151,32 @@ int mlx5_mpfs_add_mac(struct mlx5_core_dev *dev, u8 *mac)
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
@@ -183,7 +188,7 @@ int mlx5_mpfs_del_mac(struct mlx5_core_dev *dev, u8 *mac)
 	struct mlx5_mpfs *mpfs = dev->priv.mpfs;
 	struct l2table_node *l2addr;
 	int err = 0;
-	u32 index;
+	int index;
 
 	if (!mpfs)
 		return 0;
@@ -200,12 +205,84 @@ int mlx5_mpfs_del_mac(struct mlx5_core_dev *dev, u8 *mac)
 		goto unlock;
 
 	index = l2addr->index;
-	del_l2table_entry_cmd(dev, index);
+	if (index >= 0) {
+		del_l2table_entry_cmd(dev, index);
+		free_l2table_index(mpfs, index);
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
index 4a293542a7aa..866c94982e46 100644
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
+int mlx5_mpfs_enable(struct mlx5_core_dev *dev) { return 0; }
+void mlx5_mpfs_disable(struct mlx5_core_dev *dev) {}
 #endif
 
 #endif
-- 
2.51.0


