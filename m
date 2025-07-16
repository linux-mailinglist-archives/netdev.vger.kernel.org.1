Return-Path: <netdev+bounces-207496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DA1B07880
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 16:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BF273B8149
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 14:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE25E2EE97D;
	Wed, 16 Jul 2025 14:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCdncmBu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D81265CDD
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 14:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677178; cv=none; b=jTkefktOj+sXOOh8Tw+V7sxQmo+3en/dIqimEkoC6hVcunKWeMm0PMeRIt8yTwQGObqkgc+S3IK0z2qjuLh2tg6U8T6LJ1o0HdZDdDdPOUUOLHOd/PJjrd7ZJuwzPjDyXYK/DQgLMhPH/wmiA2oarG+Pw6AugHo3tmOCfLWfb/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677178; c=relaxed/simple;
	bh=pwIl84NthVqKS1vsRajYE9Q0cVZQ1aRR6mVc/tQ2GnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W8w+o0d8B49K2QD3TEYX9KQZWgIrhkAKZGs/u9qkSZqIVr6yK83YEEnxqShhJK5mmQrjhQncxYND9kiGRXVd/fv6BZ9dtIgRu355P8Jwx4trc6o88C2w0RqE/LU4s4/ykhMrWJBptE2rCtDONE2G/sgTnqEka04e8DaSrADfAks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCdncmBu; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-718389fb988so7778257b3.1
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 07:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752677175; x=1753281975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+NkyLqtlHLBvTiwp+j4KlccyK4UAXKFGsbgRp/9TNA=;
        b=UCdncmBuMSDYiRZ0UXhX5T9Ldf3NLqIdAycWQsnWyrY0jPjn9lBMV1bi9fomFXI+X5
         VF4BkfNHIKvGfqYwcm22CaAUIlij2cXLO6ITDiWpsEnnB+4kOZp4Lsx6OUwRaSFioh/f
         XXc+44Po4PkngIV1FRyB9elUDCX5RLuT6dz0EWsHhsjhWbvjiIwKhErVeF3kb8qDr1n2
         xp6lqLxfnp9lPwztZY29qpUvQApHHU9hiRwBSCjvA/O3+0bTe2kquOS7b8xhgivB1Hje
         ahK/W6k2/XtkngMSbD9Hnb4AXoD1Z5h17rm+Jc8K8JFouyk+ZiPbhSMb5SlUtGyVvFL+
         PDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677175; x=1753281975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g+NkyLqtlHLBvTiwp+j4KlccyK4UAXKFGsbgRp/9TNA=;
        b=r+Q3azswwy7QbYexstYOmuBXJ0Xiog28Igq3h9r7akVUr5sNT2CIBVPjpxT43mB/Lj
         ejfrjXCCUQZNTQ6YW0c+hY6nThOn4QVZzIPYxhhGwceCtOqYJTyacdrEvhDAGxYN8zsb
         UxrUb3u7x+kAwkBReImpfWUF9p5+4CaMwP+zQi5XmyAHXfItCmHGuIDQvLnimNkeNrFR
         YKV2RoK7WmkcBtX5gqoZvH8HAhG8vlN0hGh4KAairfROm+lkdpwcamQxH9GYP25iGUgE
         BHrSbCM5bZ46vC7B0N3hhAeYX6BYNtQTPpqDNmE/z/nhtjNPoD7hVy4pntBLrHPhSZej
         mvKw==
X-Forwarded-Encrypted: i=1; AJvYcCXJmchCocCUegLZJxDD5TEyNlHNvrdTBTrZUC5gk1EzRggmBDXpesLtR1KZhwegeQ1kee4t6ZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIX/nO0YDF6NqvyAeAUCX8KNmRkVDQvms875MzoXo21mKCFDub
	uRJwDlUT8bGtdGN4/5VqQ+aUlocdvubY/gEnXeJ6nbcZl45jKfGH5KsZ
X-Gm-Gg: ASbGncvS2/uUaCoQwC/WpB5XuyTuk683gezUxfznV+eoUVb2JRsNOGZNhqrc8DC8wRf
	6MEXDDAr1fYjRC6RZ7Ocl/At/p5ZWy43DxNGNxIvLDyDCZbjbWMjkkQrDnpdSWU7GWecLqn7p0t
	6xYoP1eL0tV1m+juSyyzf+WvsC4UFqz2S55vDo5V0QRppJIoH7Xg7vweAHoIhWRol66JeJbCQ24
	13SyW5SoIccYYZPUc5NTv+JU2heLYbsWofdqZGOXtWg1VVLb6CNvTWFVaaEWdbyei8xQKZPztpn
	CqPXzP3bArjjWxkvkwuMyAWbWagAQdlm6ZJcbkV1UYsQh9K564zZtrBfw1g66qV1wQuJL5i2oY1
	QlABSBxUToCc+DTrs0UvcluDTwTHV9lk=
X-Google-Smtp-Source: AGHT+IHOiPZwdmOqeMVuxakxvzLhKoEgaoNdR/NtsQ/ms+Y2DkDVcdfE5EsGS8PcNsVebuKOQpzvoA==
X-Received: by 2002:a05:690c:a0ac:10b0:718:38bd:bb47 with SMTP id 00721157ae682-71838bdcfc2mr22789157b3.42.1752677175111;
        Wed, 16 Jul 2025 07:46:15 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:59::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-717c5d4fa4dsm29514237b3.8.2025.07.16.07.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:46:11 -0700 (PDT)
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
Subject: [PATCH net-next v4 12/19] net/mlx5e: Implement PSP operations .assoc_add and .assoc_del
Date: Wed, 16 Jul 2025 07:45:33 -0700
Message-ID: <20250716144551.3646755-13-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250716144551.3646755-1-daniel.zahka@gmail.com>
References: <20250716144551.3646755-1-daniel.zahka@gmail.com>
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
---

Notes:
    v4:
    - delete unused struct mlx5e_psp_sa_entry declaration
    - use psp_key_size() instead of pas->key_sz in mlx5e_psp_assoc_add()
    v1:
    - https://lore.kernel.org/netdev/20240510030435.120935-11-kuba@kernel.org/

 .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +-
 .../mellanox/mlx5/core/en_accel/en_accel.h    |   8 +
 .../mellanox/mlx5/core/en_accel/psp.c         |  52 +++-
 .../mellanox/mlx5/core/en_accel/psp.h         |   2 +
 .../mellanox/mlx5/core/en_accel/psp_fs.c      | 233 ++++++++++++++++++
 .../mellanox/mlx5/core/en_accel/psp_fs.h      |  23 ++
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  10 +-
 .../ethernet/mellanox/mlx5/core/lib/crypto.h  |   1 +
 8 files changed, 321 insertions(+), 10 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_fs.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_fs.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index 84d5a0561790..a145c7f2385d 100644
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
index 096dc4180aaa..56f39f452bc8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
@@ -7,6 +7,7 @@
 #include "psp.h"
 #include "lib/crypto.h"
 #include "en_accel/psp.h"
+#include "en_accel/psp_fs.h"
 
 static int
 mlx5e_psp_set_config(struct psp_dev *psd, struct psp_dev_config *conf,
@@ -40,19 +41,45 @@ mlx5e_psp_rx_spi_alloc(struct psp_dev *psd, u32 version,
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
+
+	mdev = priv->mdev;
+	nkey = (struct psp_key *)pas->drv_data;
+
+	err = mlx5_create_encryption_key(mdev, tx->key,
+					 psp_key_size(pas->version),
+					 MLX5_ACCEL_OBJ_PSP_KEY,
+					 &nkey->id);
+	if (err) {
+		mlx5_core_err(mdev, "Failed to create encryption key (err = %d)\n", err);
+		return err;
+	}
 
-	mlx5_core_dbg(priv->mdev, "PSP assoc add: rx: %u, tx: %u\n",
-		      be32_to_cpu(pas->rx.spi), be32_to_cpu(pas->tx.spi));
-
-	return -EINVAL;
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
@@ -92,7 +119,9 @@ void mlx5e_psp_register(struct mlx5e_priv *priv)
 int mlx5e_psp_init(struct mlx5e_priv *priv)
 {
 	struct mlx5_core_dev *mdev = priv->mdev;
+	struct mlx5e_psp_fs *fs;
 	struct mlx5e_psp *psp;
+	int err;
 
 	if (!mlx5_is_psp_device(mdev)) {
 		mlx5_core_dbg(mdev, "PSP offload not supported\n");
@@ -124,8 +153,21 @@ int mlx5e_psp_init(struct mlx5e_priv *priv)
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
@@ -135,6 +177,8 @@ void mlx5e_psp_cleanup(struct mlx5e_priv *priv)
 	if (!psp)
 		return;
 
+	WARN_ON(atomic_read(&psp->tx_key_cnt));
+	mlx5e_accel_psp_fs_cleanup(psp->fs);
 	priv->psp = NULL;
 	kfree(psp);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
index a94530f79f6a..3f64a162f503 100644
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


