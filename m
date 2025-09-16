Return-Path: <netdev+bounces-223282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3985DB588E3
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 02:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B9CE7B2669
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 00:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA251A2545;
	Tue, 16 Sep 2025 00:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skCNGTji"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776361A08AF
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 00:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757981174; cv=none; b=ogddWtWl4Dl8+jEmP1E0SJPSIDnR8NJbTU3XRWZPMbT7CMjYOZn1ZVuXQZSsCEgch2ydu0x6jsUcEDQboRcdj/hOHNbkMY1c2ZGrW2WJsZ1XK2Ni/7ua4+YqMI1b9UMu8YAgASU5IXAnv5dbzph3nxTHiZkqWx09DZQ9KqsC+kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757981174; c=relaxed/simple;
	bh=PsOk/RJWVhGfqKu0LQopbLzdpZn+SygD7OEgHMgjwAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WsgppsN8azeCcnYuXUJZijK9+NbVRKo91yqH+Ud1Jnr2M2ccHIgPkq8ORi04dX0Kap8x7cn2h7iJTvES5MUCokmtoGqtiTOqO93R7HxDoORbQPXbrg+MY508o/TZVHYRra9inTP+1BXngd2wE78Dd59VGEpzBpWEh0nFNrzPqCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skCNGTji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D869AC4CEF1;
	Tue, 16 Sep 2025 00:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757981174;
	bh=PsOk/RJWVhGfqKu0LQopbLzdpZn+SygD7OEgHMgjwAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=skCNGTji2YgjBeeYkSl5qPlZpzJ0Z8qGjWMoE+fGJxqwFQL5IvsUlfO8+CL9bczfh
	 wtN73l2cyhM7oZJurlQOrYK/BxVIiwqL2Crzwc2/AeA3K0gsbJ/NwcEKG2E4D/+WVw
	 cLOlac981Oui51AaYjNMM31bZ3hDVR5S+gDz0Zh0TmnAgcN318kmQgPZYJK2X/mi/3
	 FI0PpXUozBHRbWTVJN6EJDJgGTGUghk1LjUjpLP/Qr/bknsNgwRQc8SIQDYqt4pd6q
	 UiYx76u+I9Vt3e9q0weFCv1nMyiOpWYyRgIw3y5iDODC0QEmsPOKXFuHfGxE3cDWIj
	 vJjTkpyo09AmA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemb@google.com,
	Raed Salem <raeds@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v12 12/19] net/mlx5e: Implement PSP operations .assoc_add and .assoc_del
Date: Mon, 15 Sep 2025 17:05:52 -0700
Message-ID: <20250916000559.1320151-13-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916000559.1320151-1-kuba@kernel.org>
References: <20250916000559.1320151-1-kuba@kernel.org>
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
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Notes:
    v4:
    - delete unused struct mlx5e_psp_sa_entry declaration
    - use psp_key_size() instead of pas->key_sz in mlx5e_psp_assoc_add()
    v1:
    - https://lore.kernel.org/netdev/20240510030435.120935-11-kuba@kernel.org/
---
 .../mellanox/mlx5/core/en_accel/en_accel.h    |   8 +
 .../mellanox/mlx5/core/en_accel/psp.h         |  10 +
 .../ethernet/mellanox/mlx5/core/lib/crypto.h  |   1 +
 .../mellanox/mlx5/core/en_accel/psp.c         | 265 +++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  10 +-
 5 files changed, 286 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
index 33e32584b07f..4fb02ffb0dcc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
@@ -42,6 +42,7 @@
 #include <en_accel/macsec.h>
 #include "en.h"
 #include "en/txrx.h"
+#include "en_accel/psp.h"
 
 #if IS_ENABLED(CONFIG_GENEVE)
 #include <net/geneve.h>
@@ -218,11 +219,18 @@ static inline void mlx5e_accel_cleanup_rx(struct mlx5e_priv *priv)
 
 static inline int mlx5e_accel_init_tx(struct mlx5e_priv *priv)
 {
+	int err;
+
+	err = mlx5_accel_psp_fs_init_tx_tables(priv);
+	if (err)
+		return err;
+
 	return mlx5e_ktls_init_tx(priv);
 }
 
 static inline void mlx5e_accel_cleanup_tx(struct mlx5e_priv *priv)
 {
 	mlx5e_ktls_cleanup_tx(priv);
+	mlx5_accel_psp_fs_cleanup_tx_tables(priv);
 }
 #endif /* __MLX5E_EN_ACCEL_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
index 40dbdb3e5d73..fb3d5f3dd9d4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
@@ -10,6 +10,8 @@
 struct mlx5e_psp {
 	struct psp_dev *psp;
 	struct psp_dev_caps caps;
+	struct mlx5e_psp_fs *fs;
+	atomic_t tx_key_cnt;
 };
 
 static inline bool mlx5_is_psp_device(struct mlx5_core_dev *mdev)
@@ -25,11 +27,19 @@ static inline bool mlx5_is_psp_device(struct mlx5_core_dev *mdev)
 	return true;
 }
 
+int mlx5_accel_psp_fs_init_tx_tables(struct mlx5e_priv *priv);
+void mlx5_accel_psp_fs_cleanup_tx_tables(struct mlx5e_priv *priv);
 void mlx5e_psp_register(struct mlx5e_priv *priv);
 void mlx5e_psp_unregister(struct mlx5e_priv *priv);
 int mlx5e_psp_init(struct mlx5e_priv *priv);
 void mlx5e_psp_cleanup(struct mlx5e_priv *priv);
 #else
+static inline int mlx5_accel_psp_fs_init_tx_tables(struct mlx5e_priv *priv)
+{
+	return 0;
+}
+
+static inline void mlx5_accel_psp_fs_cleanup_tx_tables(struct mlx5e_priv *priv) { }
 static inline bool mlx5_is_psp_device(struct mlx5_core_dev *mdev)
 {
 	return false;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/crypto.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/crypto.h
index c819c047bb9c..4821163a547f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/crypto.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/crypto.h
@@ -8,6 +8,7 @@ enum {
 	MLX5_ACCEL_OBJ_TLS_KEY = MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_PURPOSE_TLS,
 	MLX5_ACCEL_OBJ_IPSEC_KEY = MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_PURPOSE_IPSEC,
 	MLX5_ACCEL_OBJ_MACSEC_KEY = MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_PURPOSE_MACSEC,
+	MLX5_ACCEL_OBJ_PSP_KEY = MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_PURPOSE_PSP,
 	MLX5_ACCEL_OBJ_TYPE_KEY_NUM,
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
index 87eba63451a3..6d88c246c8dd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
@@ -7,6 +7,222 @@
 #include "psp.h"
 #include "lib/crypto.h"
 #include "en_accel/psp.h"
+#include "fs_core.h"
+
+struct mlx5e_psp_tx {
+	struct mlx5_flow_namespace *ns;
+	struct mlx5_flow_table *ft;
+	struct mlx5_flow_group *fg;
+	struct mlx5_flow_handle *rule;
+	struct mutex mutex; /* Protect PSP TX steering */
+	u32 refcnt;
+};
+
+struct mlx5e_psp_fs {
+	struct mlx5_core_dev *mdev;
+	struct mlx5e_psp_tx *tx_fs;
+	struct mlx5e_flow_steering *fs;
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
+static int accel_psp_fs_tx_create_ft_table(struct mlx5e_psp_fs *fs)
+{
+	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
+	struct mlx5_flow_table_attr ft_attr = {};
+	struct mlx5_core_dev *mdev = fs->mdev;
+	struct mlx5_flow_act flow_act = {};
+	u32 *in, *mc, *outer_headers_c;
+	struct mlx5_flow_handle *rule;
+	struct mlx5_flow_spec *spec;
+	struct mlx5e_psp_tx *tx_fs;
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
+#define MLX5E_PSP_PRIO 0
+	ft_attr.prio = MLX5E_PSP_PRIO;
+#define MLX5E_PSP_LEVEL 0
+	ft_attr.level = MLX5E_PSP_LEVEL;
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
+	flow_act.crypto.type = MLX5_FLOW_CONTEXT_ENCRYPT_DECRYPT_TYPE_PSP;
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
+static void accel_psp_fs_tx_destroy(struct mlx5e_psp_tx *tx_fs)
+{
+	if (!tx_fs->ft)
+		return;
+
+	mlx5_del_flow_rules(tx_fs->rule);
+	mlx5_destroy_flow_group(tx_fs->fg);
+	mlx5_destroy_flow_table(tx_fs->ft);
+}
+
+static int accel_psp_fs_tx_ft_get(struct mlx5e_psp_fs *fs)
+{
+	struct mlx5e_psp_tx *tx_fs = fs->tx_fs;
+	int err = 0;
+
+	mutex_lock(&tx_fs->mutex);
+	if (tx_fs->refcnt++)
+		goto out;
+
+	err = accel_psp_fs_tx_create_ft_table(fs);
+	if (err)
+		tx_fs->refcnt--;
+out:
+	mutex_unlock(&tx_fs->mutex);
+	return err;
+}
+
+static void accel_psp_fs_tx_ft_put(struct mlx5e_psp_fs *fs)
+{
+	struct mlx5e_psp_tx *tx_fs = fs->tx_fs;
+
+	mutex_lock(&tx_fs->mutex);
+	if (--tx_fs->refcnt)
+		goto out;
+
+	accel_psp_fs_tx_destroy(tx_fs);
+out:
+	mutex_unlock(&tx_fs->mutex);
+}
+
+static void accel_psp_fs_cleanup_tx(struct mlx5e_psp_fs *fs)
+{
+	struct mlx5e_psp_tx *tx_fs = fs->tx_fs;
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
+static int accel_psp_fs_init_tx(struct mlx5e_psp_fs *fs)
+{
+	struct mlx5_flow_namespace *ns;
+	struct mlx5e_psp_tx *tx_fs;
+
+	ns = mlx5_get_flow_namespace(fs->mdev, MLX5_FLOW_NAMESPACE_EGRESS_IPSEC);
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
+void mlx5_accel_psp_fs_cleanup_tx_tables(struct mlx5e_priv *priv)
+{
+	if (!priv->psp)
+		return;
+
+	accel_psp_fs_tx_ft_put(priv->psp->fs);
+}
+
+int mlx5_accel_psp_fs_init_tx_tables(struct mlx5e_priv *priv)
+{
+	if (!priv->psp)
+		return 0;
+
+	return accel_psp_fs_tx_ft_get(priv->psp->fs);
+}
+
+static void mlx5e_accel_psp_fs_cleanup(struct mlx5e_psp_fs *fs)
+{
+	accel_psp_fs_cleanup_tx(fs);
+	kfree(fs);
+}
+
+static struct mlx5e_psp_fs *mlx5e_accel_psp_fs_init(struct mlx5e_priv *priv)
+{
+	struct mlx5e_psp_fs *fs;
+	int err = 0;
+
+	fs = kzalloc(sizeof(*fs), GFP_KERNEL);
+	if (!fs)
+		return ERR_PTR(-ENOMEM);
+
+	fs->mdev = priv->mdev;
+	err = accel_psp_fs_init_tx(fs);
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
 
 static int
 mlx5e_psp_set_config(struct psp_dev *psd, struct psp_dev_config *conf,
@@ -68,19 +284,45 @@ mlx5e_psp_rx_spi_alloc(struct psp_dev *psd, u32 version,
 	return mlx5e_psp_generate_key_spi(priv->mdev, keysz, keysz_bytes, assoc);
 }
 
+struct psp_key {
+	u32 id;
+};
+
 static int mlx5e_psp_assoc_add(struct psp_dev *psd, struct psp_assoc *pas,
 			       struct netlink_ext_ack *extack)
 {
 	struct mlx5e_priv *priv = netdev_priv(psd->main_netdev);
+	struct mlx5_core_dev *mdev = priv->mdev;
+	struct psp_key_parsed *tx = &pas->tx;
+	struct mlx5e_psp *psp = priv->psp;
+	struct psp_key *nkey;
+	int err;
 
-	mlx5_core_dbg(priv->mdev, "PSP assoc add: rx: %u, tx: %u\n",
-		      be32_to_cpu(pas->rx.spi), be32_to_cpu(pas->tx.spi));
+	mdev = priv->mdev;
+	nkey = (struct psp_key *)pas->drv_data;
 
-	return -EINVAL;
+	err = mlx5_create_encryption_key(mdev, tx->key,
+					 psp_key_size(pas->version),
+					 MLX5_ACCEL_OBJ_PSP_KEY,
+					 &nkey->id);
+	if (err) {
+		mlx5_core_err(mdev, "Failed to create encryption key (err = %d)\n", err);
+		return err;
+	}
+
+	atomic_inc(&psp->tx_key_cnt);
+	return 0;
 }
 
 static void mlx5e_psp_assoc_del(struct psp_dev *psd, struct psp_assoc *pas)
 {
+	struct mlx5e_priv *priv = netdev_priv(psd->main_netdev);
+	struct mlx5e_psp *psp = priv->psp;
+	struct psp_key *nkey;
+
+	nkey = (struct psp_key *)pas->drv_data;
+	mlx5_destroy_encryption_key(priv->mdev, nkey->id);
+	atomic_dec(&psp->tx_key_cnt);
 }
 
 static struct psp_dev_ops mlx5_psp_ops = {
@@ -120,7 +362,9 @@ void mlx5e_psp_register(struct mlx5e_priv *priv)
 int mlx5e_psp_init(struct mlx5e_priv *priv)
 {
 	struct mlx5_core_dev *mdev = priv->mdev;
+	struct mlx5e_psp_fs *fs;
 	struct mlx5e_psp *psp;
+	int err;
 
 	if (!mlx5_is_psp_device(mdev)) {
 		mlx5_core_dbg(mdev, "PSP offload not supported\n");
@@ -152,8 +396,21 @@ int mlx5e_psp_init(struct mlx5e_priv *priv)
 		return -ENOMEM;
 
 	priv->psp = psp;
+	fs = mlx5e_accel_psp_fs_init(priv);
+	if (IS_ERR(fs)) {
+		err = PTR_ERR(fs);
+		goto out_err;
+	}
+
+	psp->fs = fs;
+
 	mlx5_core_dbg(priv->mdev, "PSP attached to netdevice\n");
 	return 0;
+
+out_err:
+	priv->psp = NULL;
+	kfree(psp);
+	return err;
 }
 
 void mlx5e_psp_cleanup(struct mlx5e_priv *priv)
@@ -163,6 +420,8 @@ void mlx5e_psp_cleanup(struct mlx5e_priv *priv)
 	if (!psp)
 		return;
 
+	WARN_ON(atomic_read(&psp->tx_key_cnt));
+	mlx5e_accel_psp_fs_cleanup(psp->fs);
 	priv->psp = NULL;
 	kfree(psp);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index e44cdea5e2b3..1f1d87f559af 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5893,6 +5893,10 @@ static int mlx5e_nic_init(struct mlx5_core_dev *mdev,
 	}
 	priv->fs = fs;
 
+	err = mlx5e_psp_init(priv);
+	if (err)
+		mlx5_core_err(mdev, "PSP initialization failed, %d\n", err);
+
 	err = mlx5e_ktls_init(priv);
 	if (err)
 		mlx5_core_err(mdev, "TLS initialization failed, %d\n", err);
@@ -5920,6 +5924,7 @@ static void mlx5e_nic_cleanup(struct mlx5e_priv *priv)
 	mlx5e_health_destroy_reporters(priv);
 	mlx5e_psp_unregister(priv);
 	mlx5e_ktls_cleanup(priv);
+	mlx5e_psp_cleanup(priv);
 	mlx5e_fs_cleanup(priv->fs);
 	debugfs_remove_recursive(priv->dfs_root);
 	priv->fs = NULL;
@@ -6046,10 +6051,6 @@ static void mlx5e_nic_enable(struct mlx5e_priv *priv)
 	if (err)
 		mlx5_core_err(mdev, "MACsec initialization failed, %d\n", err);
 
-	err = mlx5e_psp_init(priv);
-	if (err)
-		mlx5_core_err(mdev, "PSP initialization failed, %d\n", err);
-
 	/* Marking the link as currently not needed by the Driver */
 	if (!netif_running(netdev))
 		mlx5e_modify_admin_state(mdev, MLX5_PORT_DOWN);
@@ -6113,7 +6114,6 @@ static void mlx5e_nic_disable(struct mlx5e_priv *priv)
 	mlx5e_disable_async_events(priv);
 	mlx5_lag_remove_netdev(mdev, priv->netdev);
 	mlx5_vxlan_reset_to_default(mdev->vxlan);
-	mlx5e_psp_cleanup(priv);
 	mlx5e_macsec_cleanup(priv);
 	mlx5e_ipsec_cleanup(priv);
 }
-- 
2.51.0


