Return-Path: <netdev+bounces-95271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7842F8C1CB8
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 05:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DC0728198F
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 03:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C3514A4F3;
	Fri, 10 May 2024 03:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r60+ibym"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01DA14A4EE
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 03:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715310291; cv=none; b=LA0/64uW2J0KoTUxzm461M1rk7CDV+hB4m4LrrvkkH5cgQrjfv0J7BNP/S+DiY3NMJHCOK6GXMW2f+87nSJYrj//Cj4Y+sfDn8MZuNDJt86Qzg51WhD9amLGTtKfquftaP1sPiPzVXSX9Hf9/X4hZSzR5zXJz9KgYb8SPasAIxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715310291; c=relaxed/simple;
	bh=upOqaZJB+SbXIj2iAAB/XsbcajXrGP+lTOeYDUKikRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZzzKLCAM6sXypCjxM6oiI8L8TYi0WhQx2XNqv+rveuTbkHrTBrlcWz/MOodftMHHM1YUETajNxDJfndzvQnQ2yO0CS3LakGE8puPRl3w0NJjiHXIWGgCie1H+G7cam9DPa7jieCkA+X2+N5J4UrDIIlnBUdyPfImtkImVN/ROE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r60+ibym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F4EC3277B;
	Fri, 10 May 2024 03:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715310291;
	bh=upOqaZJB+SbXIj2iAAB/XsbcajXrGP+lTOeYDUKikRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r60+ibymnLBVoJrgw6FoYzXXXYypA0jDUOk1LfIfH6/gUulFzhZk/m//4ixJnYSeO
	 Uf7RL+SQWxJSEv9cseoDfkDErU4beiDSjYLZ8mCmbBaVKA6a1OfkFntjZcpHlrkidS
	 mM5wb02GQ56QFwUty/+Gh3Xw9iRW0RLOrBSLW7qfQYLKkjUtPt+SKpChuxuNu4o0ic
	 9qW2dHriEzalO0FnLdF49fH4tmwZDvjQJnyRq8qnZO/3VVE83sQ/qRjY/HxjUQnpxz
	 fzOkc6mB6EAAKgc9aOim2Elxek2I7Iou5OOSClBj7I4EFVxEjt4gjMsYYnUerswqXV
	 nPF+2lX33DUNw==
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	borisp@nvidia.com,
	gal@nvidia.com,
	cratiu@nvidia.com,
	rrameshbabu@nvidia.com,
	steffen.klassert@secunet.com,
	tariqt@nvidia.com,
	Raed Salem <raeds@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 10/15] net/mlx5e: Implement PSP operations .assoc_add and .assoc_del
Date: Thu,  9 May 2024 20:04:30 -0700
Message-ID: <20240510030435.120935-11-kuba@kernel.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240510030435.120935-1-kuba@kernel.org>
References: <20240510030435.120935-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Raed Salem <raeds@nvidia.com>

Implement .assoc_add and .assoc_del PSP operations used in the tx control
path. Allocate the relevant hardware resources when a new key is registered
using .assoc_add. Destroy the key when .assoc_del is called. Use a atomic
counter to keep track of the current number of keys being used by the
device.

Signed-off-by: Raed Salem <raeds@nvidia.com>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +-
 .../mellanox/mlx5/core/en_accel/en_accel.h    |   8 +
 .../mellanox/mlx5/core/en_accel/nisp.c        |  57 ++++-
 .../mellanox/mlx5/core/en_accel/nisp.h        |   2 +
 .../mellanox/mlx5/core/en_accel/nisp_fs.c     | 234 ++++++++++++++++++
 .../mellanox/mlx5/core/en_accel/nisp_fs.h     |  23 ++
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  10 +-
 .../ethernet/mellanox/mlx5/core/lib/crypto.h  |   1 +
 8 files changed, 327 insertions(+), 10 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_fs.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_fs.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index c17a5e343603..5ce78b84c763 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -109,7 +109,7 @@ mlx5_core-$(CONFIG_MLX5_EN_TLS) += en_accel/ktls_stats.o \
 				   en_accel/fs_tcp.o en_accel/ktls.o en_accel/ktls_txrx.o \
 				   en_accel/ktls_tx.o en_accel/ktls_rx.o
 
-mlx5_core-$(CONFIG_MLX5_EN_PSP) += en_accel/nisp.o en_accel/nisp_offload.o
+mlx5_core-$(CONFIG_MLX5_EN_PSP) += en_accel/nisp.o en_accel/nisp_offload.o en_accel/nisp_fs.o
 
 mlx5_core-$(CONFIG_MLX5_SW_STEERING) += steering/dr_domain.o steering/dr_table.o \
 					steering/dr_matcher.o steering/dr_rule.o \
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
index caa34b9c161e..c15e48b0724c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
@@ -42,6 +42,7 @@
 #include <en_accel/macsec.h>
 #include "en.h"
 #include "en/txrx.h"
+#include "en_accel/nisp_fs.h"
 
 #if IS_ENABLED(CONFIG_GENEVE)
 #include <net/geneve.h>
@@ -212,11 +213,18 @@ static inline void mlx5e_accel_cleanup_rx(struct mlx5e_priv *priv)
 
 static inline int mlx5e_accel_init_tx(struct mlx5e_priv *priv)
 {
+	int err;
+
+	err = mlx5_accel_nisp_fs_init_tx_tables(priv);
+	if (err)
+		return err;
+
 	return mlx5e_ktls_init_tx(priv);
 }
 
 static inline void mlx5e_accel_cleanup_tx(struct mlx5e_priv *priv)
 {
 	mlx5e_ktls_cleanup_tx(priv);
+	mlx5_accel_nisp_fs_cleanup_tx_tables(priv);
 }
 #endif /* __MLX5E_EN_ACCEL_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp.c
index eff7906b3764..1131aa6e9b3d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp.c
@@ -7,6 +7,12 @@
 #include "../nisp.h"
 #include "lib/crypto.h"
 #include "en_accel/nisp.h"
+#include "en_accel/nisp_fs.h"
+
+struct mlx5e_nisp_sa_entry {
+	struct mlx5e_accel_nisp_rule *nisp_rule;
+	u32 enc_key_id;
+};
 
 static int
 mlx5e_psp_set_config(struct psp_dev *psd, struct psp_dev_config *conf,
@@ -49,19 +55,45 @@ mlx5e_psp_rx_spi_alloc(struct psp_dev *psd, u32 version,
 	return 0;
 }
 
+struct nisp_key {
+	u32 id;
+};
+
 static int mlx5e_psp_assoc_add(struct psp_dev *psd, struct psp_assoc *pas,
 			       struct netlink_ext_ack *extack)
 {
 	struct mlx5e_priv *priv = netdev_priv(psd->main_netdev);
+	struct mlx5_core_dev *mdev = priv->mdev;
+	struct mlx5e_nisp *nisp = priv->nisp;
+	struct psp_key_parsed *tx = &pas->tx;
+	struct nisp_key *nkey;
+	int err;
 
-	mlx5_core_dbg(priv->mdev, "PSP assoc add: rx: %u, tx: %u\n",
-		      be32_to_cpu(pas->rx.spi), be32_to_cpu(pas->tx.spi));
+	mdev = priv->mdev;
+	nkey = (struct nisp_key *)pas->drv_data;
 
-	return -EINVAL;
+	err = mlx5_create_encryption_key(mdev, tx->key,
+					 pas->key_sz,
+					 MLX5_ACCEL_OBJ_NISP_KEY,
+					 &nkey->id);
+	if (err) {
+		mlx5_core_err(mdev, "Failed to create encryption key (err = %d)\n", err);
+		return err;
+	}
+
+	atomic_inc(&nisp->tx_key_cnt);
+	return 0;
 }
 
-static void mlx5e_psp_assoc_del(struct psp_dev *psd, struct psp_assoc *tas)
+static void mlx5e_psp_assoc_del(struct psp_dev *psd, struct psp_assoc *pas)
 {
+	struct mlx5e_priv *priv = netdev_priv(psd->main_netdev);
+	struct mlx5e_nisp *nisp = priv->nisp;
+	struct nisp_key *nkey;
+
+	nkey = (struct nisp_key *)pas->drv_data;
+	mlx5_destroy_encryption_key(priv->mdev, nkey->id);
+	atomic_dec(&nisp->tx_key_cnt);
 }
 
 static struct psp_dev_ops mlx5_psp_ops = {
@@ -101,7 +133,9 @@ void mlx5e_nisp_register(struct mlx5e_priv *priv)
 int mlx5e_nisp_init(struct mlx5e_priv *priv)
 {
 	struct mlx5_core_dev *mdev = priv->mdev;
+	struct mlx5e_nisp_fs *fs;
 	struct mlx5e_nisp *nisp;
+	int err;
 
 	if (!mlx5_is_nisp_device(mdev)) {
 		mlx5_core_dbg(mdev, "NISP offload not supported\n");
@@ -133,8 +167,21 @@ int mlx5e_nisp_init(struct mlx5e_priv *priv)
 		return -ENOMEM;
 
 	priv->nisp = nisp;
+	fs = mlx5e_accel_nisp_fs_init(priv);
+	if (IS_ERR(fs)) {
+		err = PTR_ERR(fs);
+		goto out_err;
+	}
+
+	nisp->fs = fs;
+
 	mlx5_core_dbg(priv->mdev, "NISP attached to netdevice\n");
 	return 0;
+
+out_err:
+	priv->nisp = NULL;
+	kfree(nisp);
+	return err;
 }
 
 void mlx5e_nisp_cleanup(struct mlx5e_priv *priv)
@@ -144,6 +191,8 @@ void mlx5e_nisp_cleanup(struct mlx5e_priv *priv)
 	if (!nisp)
 		return;
 
+	WARN_ON(atomic_read(&nisp->tx_key_cnt));
+	mlx5e_accel_nisp_fs_cleanup(nisp->fs);
 	priv->nisp = NULL;
 	kfree(nisp);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp.h
index 93eaea8b6f77..14e5813367a7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp.h
@@ -10,6 +10,8 @@
 struct mlx5e_nisp {
 	struct psp_dev *psp;
 	struct psp_dev_caps caps;
+	struct mlx5e_nisp_fs *fs;
+	atomic_t tx_key_cnt;
 };
 
 struct nisp_key_spi {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_fs.c
new file mode 100644
index 000000000000..5d2ce83db7cc
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_fs.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#include <linux/netdevice.h>
+#include <linux/mlx5/fs.h>
+#include "en.h"
+#include "fs_core.h"
+#include "en_accel/nisp_fs.h"
+#include "en_accel/nisp.h"
+
+struct mlx5e_nisp_tx {
+	struct mlx5_flow_namespace *ns;
+	struct mlx5_flow_table *ft;
+	struct mlx5_flow_group *fg;
+	struct mlx5_flow_handle *rule;
+	struct mutex mutex; /* Protect NISP TX steering */
+	u32 refcnt;
+};
+
+struct mlx5e_nisp_fs {
+	struct mlx5_core_dev *mdev;
+	struct mlx5e_nisp_tx *tx_fs;
+	struct mlx5e_flow_steering *fs;
+};
+
+enum accel_nisp_rule_action {
+	ACCEL_NISP_RULE_ACTION_ENCRYPT,
+};
+
+struct mlx5e_accel_nisp_rule {
+	struct mlx5_flow_handle *rule;
+	u8 action;
+};
+
+static void setup_fte_udp_psp(struct mlx5_flow_spec *spec, u16 udp_port)
+{
+	spec->match_criteria_enable |= MLX5_MATCH_OUTER_HEADERS;
+	MLX5_SET(fte_match_set_lyr_2_4, spec->match_criteria, udp_dport, 0xffff);
+	MLX5_SET(fte_match_set_lyr_2_4, spec->match_value, udp_dport, udp_port);
+	MLX5_SET_TO_ONES(fte_match_set_lyr_2_4, spec->match_criteria, ip_protocol);
+	MLX5_SET(fte_match_set_lyr_2_4, spec->match_value, ip_protocol, IPPROTO_UDP);
+}
+
+static int accel_nisp_fs_tx_create_ft_table(struct mlx5e_nisp_fs *fs)
+{
+	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
+	struct mlx5_flow_table_attr ft_attr = {};
+	struct mlx5_core_dev *mdev = fs->mdev;
+	struct mlx5_flow_act flow_act = {};
+	u32 *in, *mc, *outer_headers_c;
+	struct mlx5_flow_handle *rule;
+	struct mlx5_flow_spec *spec;
+	struct mlx5e_nisp_tx *tx_fs;
+	struct mlx5_flow_table *ft;
+	struct mlx5_flow_group *fg;
+	int err = 0;
+
+	spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
+	in = kvzalloc(inlen, GFP_KERNEL);
+	if (!spec || !in) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	ft_attr.max_fte = 1;
+#define MLX5E_NISP_PRIO 0
+	ft_attr.prio = MLX5E_NISP_PRIO;
+#define MLX5E_NISP_LEVEL 0
+	ft_attr.level = MLX5E_NISP_LEVEL;
+	ft_attr.autogroup.max_num_groups = 1;
+
+	tx_fs = fs->tx_fs;
+	ft = mlx5_create_flow_table(tx_fs->ns, &ft_attr);
+	if (IS_ERR(ft)) {
+		err = PTR_ERR(ft);
+		mlx5_core_err(mdev, "PSP: fail to add psp tx flow table, err = %d\n", err);
+		goto out;
+	}
+
+	mc = MLX5_ADDR_OF(create_flow_group_in, in, match_criteria);
+	outer_headers_c = MLX5_ADDR_OF(fte_match_param, mc, outer_headers);
+	MLX5_SET_TO_ONES(fte_match_set_lyr_2_4, outer_headers_c, ip_protocol);
+	MLX5_SET_TO_ONES(fte_match_set_lyr_2_4, outer_headers_c, udp_dport);
+	MLX5_SET_CFG(in, match_criteria_enable, MLX5_MATCH_OUTER_HEADERS);
+	fg = mlx5_create_flow_group(ft, in);
+	if (IS_ERR(fg)) {
+		err = PTR_ERR(fg);
+		mlx5_core_err(mdev, "PSP: fail to add psp tx flow group, err = %d\n", err);
+		goto err_create_fg;
+	}
+
+	setup_fte_udp_psp(spec, PSP_DEFAULT_UDP_PORT);
+	flow_act.crypto.type = MLX5_FLOW_CONTEXT_ENCRYPT_DECRYPT_TYPE_NISP;
+	flow_act.flags |= FLOW_ACT_NO_APPEND;
+	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_ALLOW |
+			  MLX5_FLOW_CONTEXT_ACTION_CRYPTO_ENCRYPT;
+	rule = mlx5_add_flow_rules(ft, spec, &flow_act, NULL, 0);
+	if (IS_ERR(rule)) {
+		err = PTR_ERR(rule);
+		mlx5_core_err(mdev, "PSP: fail to add psp tx flow rule, err = %d\n", err);
+		goto err_add_flow_rule;
+	}
+
+	tx_fs->ft = ft;
+	tx_fs->fg = fg;
+	tx_fs->rule = rule;
+	goto out;
+
+err_add_flow_rule:
+	mlx5_destroy_flow_group(fg);
+err_create_fg:
+	mlx5_destroy_flow_table(ft);
+out:
+	kvfree(in);
+	kvfree(spec);
+	return err;
+}
+
+static void accel_nisp_fs_tx_destroy(struct mlx5e_nisp_tx *tx_fs)
+{
+	if (!tx_fs->ft)
+		return;
+
+	mlx5_del_flow_rules(tx_fs->rule);
+	mlx5_destroy_flow_group(tx_fs->fg);
+	mlx5_destroy_flow_table(tx_fs->ft);
+}
+
+static int accel_nisp_fs_tx_ft_get(struct mlx5e_nisp_fs *fs)
+{
+	struct mlx5e_nisp_tx *tx_fs = fs->tx_fs;
+	int err = 0;
+
+	mutex_lock(&tx_fs->mutex);
+	if (tx_fs->refcnt++)
+		goto out;
+
+	err = accel_nisp_fs_tx_create_ft_table(fs);
+	if (err)
+		tx_fs->refcnt--;
+out:
+	mutex_unlock(&tx_fs->mutex);
+	return err;
+}
+
+static void accel_nisp_fs_tx_ft_put(struct mlx5e_nisp_fs *fs)
+{
+	struct mlx5e_nisp_tx *tx_fs = fs->tx_fs;
+
+	mutex_lock(&tx_fs->mutex);
+	if (--tx_fs->refcnt)
+		goto out;
+
+	accel_nisp_fs_tx_destroy(tx_fs);
+out:
+	mutex_unlock(&tx_fs->mutex);
+}
+
+static void accel_nisp_fs_cleanup_tx(struct mlx5e_nisp_fs *fs)
+{
+	struct mlx5e_nisp_tx *tx_fs = fs->tx_fs;
+
+	if (!tx_fs)
+		return;
+
+	mutex_destroy(&tx_fs->mutex);
+	WARN_ON(tx_fs->refcnt);
+	kfree(tx_fs);
+	fs->tx_fs = NULL;
+}
+
+static int accel_nisp_fs_init_tx(struct mlx5e_nisp_fs *fs)
+{
+	struct mlx5_flow_namespace *ns;
+	struct mlx5e_nisp_tx *tx_fs;
+
+	ns = mlx5_get_flow_namespace(fs->mdev,
+				     MLX5_FLOW_NAMESPACE_EGRESS_IPSEC);
+	if (!ns)
+		return -EOPNOTSUPP;
+
+	tx_fs = kzalloc(sizeof(*tx_fs), GFP_KERNEL);
+	if (!tx_fs)
+		return -ENOMEM;
+
+	mutex_init(&tx_fs->mutex);
+	tx_fs->ns = ns;
+	fs->tx_fs = tx_fs;
+	return 0;
+}
+
+void mlx5_accel_nisp_fs_cleanup_tx_tables(struct mlx5e_priv *priv)
+{
+	if (!priv->nisp)
+		return;
+
+	accel_nisp_fs_tx_ft_put(priv->nisp->fs);
+}
+
+int mlx5_accel_nisp_fs_init_tx_tables(struct mlx5e_priv *priv)
+{
+	if (!priv->nisp)
+		return 0;
+
+	return accel_nisp_fs_tx_ft_get(priv->nisp->fs);
+}
+
+void mlx5e_accel_nisp_fs_cleanup(struct mlx5e_nisp_fs *fs)
+{
+	accel_nisp_fs_cleanup_tx(fs);
+	kfree(fs);
+}
+
+struct mlx5e_nisp_fs *mlx5e_accel_nisp_fs_init(struct mlx5e_priv *priv)
+{
+	struct mlx5e_nisp_fs *fs;
+	int err = 0;
+
+	fs = kzalloc(sizeof(*fs), GFP_KERNEL);
+	if (!fs)
+		return ERR_PTR(-ENOMEM);
+
+	fs->mdev = priv->mdev;
+	err = accel_nisp_fs_init_tx(fs);
+	if (err)
+		goto err_tx;
+
+	fs->fs = priv->fs;
+
+	return fs;
+err_tx:
+	kfree(fs);
+	return ERR_PTR(err);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_fs.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_fs.h
new file mode 100644
index 000000000000..11cdc447a401
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_fs.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#ifndef __MLX5_NISP_FS_H__
+#define __MLX5_NISP_FS_H__
+
+#ifdef CONFIG_MLX5_EN_PSP
+
+struct mlx5e_nisp_fs;
+
+struct mlx5e_nisp_fs *mlx5e_accel_nisp_fs_init(struct mlx5e_priv *priv);
+void mlx5e_accel_nisp_fs_cleanup(struct mlx5e_nisp_fs *fs);
+int mlx5_accel_nisp_fs_init_tx_tables(struct mlx5e_priv *priv);
+void mlx5_accel_nisp_fs_cleanup_tx_tables(struct mlx5e_priv *priv);
+#else
+static inline int mlx5_accel_nisp_fs_init_tx_tables(struct mlx5e_priv *priv)
+{
+	return 0;
+}
+
+static inline void mlx5_accel_nisp_fs_cleanup_tx_tables(struct mlx5e_priv *priv) { }
+#endif /* CONFIG_MLX5_EN_PSP */
+#endif /* __MLX5_NISP_FS_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 4948e19c3f3f..38e0c4786b1c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5495,6 +5495,10 @@ static int mlx5e_nic_init(struct mlx5_core_dev *mdev,
 	}
 	priv->fs = fs;
 
+	err = mlx5e_nisp_init(priv);
+	if (err)
+		mlx5_core_err(mdev, "PSP initialization failed, %d\n", err);
+
 	err = mlx5e_ktls_init(priv);
 	if (err)
 		mlx5_core_err(mdev, "TLS initialization failed, %d\n", err);
@@ -5522,6 +5526,7 @@ static void mlx5e_nic_cleanup(struct mlx5e_priv *priv)
 	mlx5e_health_destroy_reporters(priv);
 	mlx5e_nisp_unregister(priv);
 	mlx5e_ktls_cleanup(priv);
+	mlx5e_nisp_cleanup(priv);
 	mlx5e_fs_cleanup(priv->fs);
 	debugfs_remove_recursive(priv->dfs_root);
 	priv->fs = NULL;
@@ -5648,10 +5653,6 @@ static void mlx5e_nic_enable(struct mlx5e_priv *priv)
 	if (err)
 		mlx5_core_err(mdev, "MACsec initialization failed, %d\n", err);
 
-	err = mlx5e_nisp_init(priv);
-	if (err)
-		mlx5_core_err(mdev, "PSP initialization failed, %d\n", err);
-
 	/* Marking the link as currently not needed by the Driver */
 	if (!netif_running(netdev))
 		mlx5e_modify_admin_state(mdev, MLX5_PORT_DOWN);
@@ -5709,7 +5710,6 @@ static void mlx5e_nic_disable(struct mlx5e_priv *priv)
 	mlx5e_disable_async_events(priv);
 	mlx5_lag_remove_netdev(mdev, priv->netdev);
 	mlx5_vxlan_reset_to_default(mdev->vxlan);
-	mlx5e_nisp_cleanup(priv);
 	mlx5e_macsec_cleanup(priv);
 	mlx5e_ipsec_cleanup(priv);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/crypto.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/crypto.h
index c819c047bb9c..f257dfcf45d6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/crypto.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/crypto.h
@@ -8,6 +8,7 @@ enum {
 	MLX5_ACCEL_OBJ_TLS_KEY = MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_PURPOSE_TLS,
 	MLX5_ACCEL_OBJ_IPSEC_KEY = MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_PURPOSE_IPSEC,
 	MLX5_ACCEL_OBJ_MACSEC_KEY = MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_PURPOSE_MACSEC,
+	MLX5_ACCEL_OBJ_NISP_KEY = MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_PURPOSE_NISP,
 	MLX5_ACCEL_OBJ_TYPE_KEY_NUM,
 };
 
-- 
2.45.0


