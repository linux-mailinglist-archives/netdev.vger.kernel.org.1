Return-Path: <netdev+bounces-203456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4851AF5FA5
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 19:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5440216D9B5
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 17:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837C3301121;
	Wed,  2 Jul 2025 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fX3jmMdx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F158303DFF
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 17:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751476424; cv=none; b=MrhJBCvZ5D5d94e7ysOtIPmZp8tOTqfbSbA3wIMN4tZqrqh73ublyNOx32SKsBGGni8jb74rmUoonefJYHbPTjrkT5LYXMnLxXRJtAp0Vps9iV9Gmq9EO0R315KHZIcenLlDaVJfUblv3kHgDzD/tskyOtIxFYmu4X3ZWMsD3iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751476424; c=relaxed/simple;
	bh=dkfn0EwGJcQj8BK/RjqH15NlwsVbAle4S0CfcKWpdBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qSYxSkIUhq/QfnJPzeWiXS9r5QN83SusVEW7ygIBEnveIQhl0UMH8MruLfbic86pJOQIy3BOn771gk5OyzSSaw9XRgGc9uQdSIU4Rrj7ocI/ll13BHPGD3Lj+vpMfWJzaZR9g+k0uy6TllGL0Jab36RhDWKddxvealHs840Ouf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fX3jmMdx; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e812fc35985so5699824276.0
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 10:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751476421; x=1752081221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aF55zIFm9APMcdhWvk5/eVLbKZ7zXsWnJPfcQXsvu4=;
        b=fX3jmMdxh7Rgo41ub9NoY67ug5w0JpMjh2pzH4vOAvWWKK9lIErCz1gV1Pf5UcAcZb
         J7NQwAqiVO5Rw5xAjlnTX9iBYl0JsWSNrlbIfoIQEfKAtQ2OZk/vlCgn0BMnWUUKqVOr
         +VB3ZKmA3JFcansW6VDaRvgUjspKN8iTQDYF58z4ymz6fbn2Q0QplazUh1CVStmY5fYk
         CsnKj/NxZ3h1lIDEh/ZWZywPh6AAzxugfqTSW3B71qnDq5pqyXf63yuoXK0ILUKE1RAc
         mNYrhD3i3Mi4r9Ak138E3UlN+XgySHq50YhVgvOQbbG8ru49dwMvytmNVeRpDJJQt2L9
         aAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751476421; x=1752081221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8aF55zIFm9APMcdhWvk5/eVLbKZ7zXsWnJPfcQXsvu4=;
        b=ICT4OPabpzQocJKin/9mN5qx5qKDj5cW/5YYwXU2jizv5E8ZPNsxifugJIq41FEHZv
         Ci133dT92hNJhKgBbRLx28IS90DBEstIqcbKMo+nM+dKcJhoxh4r0vEVasFAHGvJyjeT
         gGcGeaXx3sPcInbtqW38bc/Dve8GePjqcv2hDfEyITjFnjTqY/Hn6Z5NTRGAK/oKncJ9
         FzlqsJod8QRZ0OzQhOsSjCUPRW4IA6Ly0dypso+GCb8lxYZ2QTSi1v4AD/BIPnNNuvbP
         rRshyvWc9cYfC5V5u2AJ5vDE1cw/ChSjOi4x71yzzaiekrl2MbXAu6/4WQT71o1pkyoZ
         yrTw==
X-Forwarded-Encrypted: i=1; AJvYcCVjqaTaNd6XN3pjLpS2DYpg40bMuYnJbtfiXYMrvE9rleWS5GNS5RqK27DRaCwt/9yp4tqqxQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ8m3Sov5Ko7tWhFGsWKhUL6L+v9udl4kkOUe6xBzE3BI0uA2C
	/4yZHaY3Hogb/jkKghVZ2Cl3WT6Kl/hLOI871jPlvy5bRyfVxYUv0D3cn9sCAA==
X-Gm-Gg: ASbGnctd84toFFD9HmY0z/6BCYju77uGOw4Ov1Vc2aXhPRENZumHlpLKWNzVgdwTVCz
	fsqU5sGWtHI/pChyAujvh+ZIcnRWRkRjrjqeO95zg0MjIsJiBRwf/mLpP4PSneesqBVEg+tKGc+
	21BfZyBtII592oEVr5Sl4H5NOHTGlQ6Wt1G3MVX+laOnaMNNSkWnQtpiALaQoE24JmBMLtR7aS3
	OAEw8J/OOBaUANUC95648M8IZlr+TEtGnX04BA58MQpDXLijkHOMDneEip1cVBvU8qtzQXWnoxz
	F1sdB6NJ7BqaB9CiQBRj3FhI+LICfipiufHewOK2DaeUWAABwDy69o4+95F5
X-Google-Smtp-Source: AGHT+IH2+SQQ+q3YU1qd5iAJXOwhtrvgpVYrQZePc4CRtfIzqcgs96LvcSC78HCA1W91kmYR9K2+QA==
X-Received: by 2002:a05:6902:2b01:b0:e82:5142:7c9f with SMTP id 3f1490d57ef6-e897e260b55mr4808088276.35.1751476421253;
        Wed, 02 Jul 2025 10:13:41 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:71::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e898cc284b2sm175645276.9.2025.07.02.10.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 10:13:40 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Raed Salem <raeds@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH v3 12/19] net/mlx5e: Implement PSP operations .assoc_add and .assoc_del
Date: Wed,  2 Jul 2025 10:13:17 -0700
Message-ID: <20250702171326.3265825-13-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250702171326.3265825-1-daniel.zahka@gmail.com>
References: <20250702171326.3265825-1-daniel.zahka@gmail.com>
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
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---

Notes:
    v1:
    - https://lore.kernel.org/netdev/20240510030435.120935-11-kuba@kernel.org/

 .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +-
 .../mellanox/mlx5/core/en_accel/en_accel.h    |   8 +
 .../mellanox/mlx5/core/en_accel/psp.c         |  55 ++++-
 .../mellanox/mlx5/core/en_accel/psp.h         |   2 +
 .../mellanox/mlx5/core/en_accel/psp_fs.c      | 233 ++++++++++++++++++
 .../mellanox/mlx5/core/en_accel/psp_fs.h      |  23 ++
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  10 +-
 .../ethernet/mellanox/mlx5/core/lib/crypto.h  |   1 +
 8 files changed, 325 insertions(+), 9 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_fs.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_fs.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index e27de74ef028..5d2783f2e82f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -110,7 +110,7 @@ mlx5_core-$(CONFIG_MLX5_EN_TLS) += en_accel/ktls_stats.o \
 				   en_accel/fs_tcp.o en_accel/ktls.o en_accel/ktls_txrx.o \
 				   en_accel/ktls_tx.o en_accel/ktls_rx.o
 
-mlx5_core-$(CONFIG_MLX5_EN_PSP) += en_accel/psp.o en_accel/psp_offload.o
+mlx5_core-$(CONFIG_MLX5_EN_PSP) += en_accel/psp.o en_accel/psp_offload.o en_accel/psp_fs.o
 
 #
 # SW Steering
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
index 33e32584b07f..bd990e7a6a79 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
@@ -42,6 +42,7 @@
 #include <en_accel/macsec.h>
 #include "en.h"
 #include "en/txrx.h"
+#include "en_accel/psp_fs.h"
 
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
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
index 482e2cdabdae..fb2b7e4e2f06 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
@@ -7,6 +7,12 @@
 #include "psp.h"
 #include "lib/crypto.h"
 #include "en_accel/psp.h"
+#include "en_accel/psp_fs.h"
+
+struct mlx5e_psp_sa_entry {
+	struct mlx5e_accel_psp_rule *psp_rule;
+	u32 enc_key_id;
+};
 
 static int
 mlx5e_psp_set_config(struct psp_dev *psd, struct psp_dev_config *conf,
@@ -49,19 +55,45 @@ mlx5e_psp_rx_spi_alloc(struct psp_dev *psd, u32 version,
 	return 0;
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
+					 pas->key_sz,
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
@@ -101,7 +133,9 @@ void mlx5e_psp_register(struct mlx5e_priv *priv)
 int mlx5e_psp_init(struct mlx5e_priv *priv)
 {
 	struct mlx5_core_dev *mdev = priv->mdev;
+	struct mlx5e_psp_fs *fs;
 	struct mlx5e_psp *psp;
+	int err;
 
 	if (!mlx5_is_psp_device(mdev)) {
 		mlx5_core_dbg(mdev, "PSP offload not supported\n");
@@ -133,8 +167,21 @@ int mlx5e_psp_init(struct mlx5e_priv *priv)
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
@@ -144,6 +191,8 @@ void mlx5e_psp_cleanup(struct mlx5e_priv *priv)
 	if (!psp)
 		return;
 
+	WARN_ON(atomic_read(&psp->tx_key_cnt));
+	mlx5e_accel_psp_fs_cleanup(psp->fs);
 	priv->psp = NULL;
 	kfree(psp);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
index 9707f50029ed..16e5ba591307 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
@@ -10,6 +10,8 @@
 struct mlx5e_psp {
 	struct psp_dev *psp;
 	struct psp_dev_caps caps;
+	struct mlx5e_psp_fs *fs;
+	atomic_t tx_key_cnt;
 };
 
 struct psp_key_spi {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_fs.c
new file mode 100644
index 000000000000..cabbc8f0d84a
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_fs.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#include <linux/netdevice.h>
+#include <linux/mlx5/fs.h>
+#include "en.h"
+#include "fs_core.h"
+#include "en_accel/psp_fs.h"
+#include "en_accel/psp.h"
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
+enum accel_psp_rule_action {
+	ACCEL_PSP_RULE_ACTION_ENCRYPT,
+};
+
+struct mlx5e_accel_psp_rule {
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
+void mlx5e_accel_psp_fs_cleanup(struct mlx5e_psp_fs *fs)
+{
+	accel_psp_fs_cleanup_tx(fs);
+	kfree(fs);
+}
+
+struct mlx5e_psp_fs *mlx5e_accel_psp_fs_init(struct mlx5e_priv *priv)
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
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_fs.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_fs.h
new file mode 100644
index 000000000000..d81aeea43505
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_fs.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#ifndef __MLX5_PSP_FS_H__
+#define __MLX5_PSP_FS_H__
+
+#ifdef CONFIG_MLX5_EN_PSP
+
+struct mlx5e_psp_fs;
+
+struct mlx5e_psp_fs *mlx5e_accel_psp_fs_init(struct mlx5e_priv *priv);
+void mlx5e_accel_psp_fs_cleanup(struct mlx5e_psp_fs *fs);
+int mlx5_accel_psp_fs_init_tx_tables(struct mlx5e_priv *priv);
+void mlx5_accel_psp_fs_cleanup_tx_tables(struct mlx5e_priv *priv);
+#else
+static inline int mlx5_accel_psp_fs_init_tx_tables(struct mlx5e_priv *priv)
+{
+	return 0;
+}
+
+static inline void mlx5_accel_psp_fs_cleanup_tx_tables(struct mlx5e_priv *priv) { }
+#endif /* CONFIG_MLX5_EN_PSP */
+#endif /* __MLX5_PSP_FS_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index b651827e5321..cf10d43abc25 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5824,6 +5824,10 @@ static int mlx5e_nic_init(struct mlx5_core_dev *mdev,
 	}
 	priv->fs = fs;
 
+	err = mlx5e_psp_init(priv);
+	if (err)
+		mlx5_core_err(mdev, "PSP initialization failed, %d\n", err);
+
 	err = mlx5e_ktls_init(priv);
 	if (err)
 		mlx5_core_err(mdev, "TLS initialization failed, %d\n", err);
@@ -5851,6 +5855,7 @@ static void mlx5e_nic_cleanup(struct mlx5e_priv *priv)
 	mlx5e_health_destroy_reporters(priv);
 	mlx5e_psp_unregister(priv);
 	mlx5e_ktls_cleanup(priv);
+	mlx5e_psp_cleanup(priv);
 	mlx5e_fs_cleanup(priv->fs);
 	debugfs_remove_recursive(priv->dfs_root);
 	priv->fs = NULL;
@@ -5977,10 +5982,6 @@ static void mlx5e_nic_enable(struct mlx5e_priv *priv)
 	if (err)
 		mlx5_core_err(mdev, "MACsec initialization failed, %d\n", err);
 
-	err = mlx5e_psp_init(priv);
-	if (err)
-		mlx5_core_err(mdev, "PSP initialization failed, %d\n", err);
-
 	/* Marking the link as currently not needed by the Driver */
 	if (!netif_running(netdev))
 		mlx5e_modify_admin_state(mdev, MLX5_PORT_DOWN);
@@ -6042,7 +6043,6 @@ static void mlx5e_nic_disable(struct mlx5e_priv *priv)
 	mlx5e_disable_async_events(priv);
 	mlx5_lag_remove_netdev(mdev, priv->netdev);
 	mlx5_vxlan_reset_to_default(mdev->vxlan);
-	mlx5e_psp_cleanup(priv);
 	mlx5e_macsec_cleanup(priv);
 	mlx5e_ipsec_cleanup(priv);
 }
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
 
-- 
2.47.1


