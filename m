Return-Path: <netdev+bounces-217358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40556B38713
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 17:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7472B3A1ECD
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 15:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8245D30BB8F;
	Wed, 27 Aug 2025 15:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSv4V5db"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163BE3314A9
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310038; cv=none; b=Q5aMsjF/FSa6iET5VkJOXmk+n09VwKlk3lxkTZmrF814OCvEMgFg+Df4Fo2DR//Nf6rS+LEPTJfSmIdTHRGuW6eyyJxE4/xPtRQ36E3FVw4VsENtcqUjYx5eeDZ+VpE9dhA7x2ue0cHsf7XrWgIvKjdDXBw+PkePgqava87F9zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310038; c=relaxed/simple;
	bh=EIMEr+Rr5HUz4JJNT1e3C6WK/ZU6RSeHw4jPCn+q+Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VHq2oSsBP8xHrP6IoXzLYhfLh8ikSbHRBEXIXQcoM4tVEcJyV6DqldkUFnaZhLhvF/Sv8RRmV59i0n9TE8pATOu5b/ay6Ta/Txkx8NZddr4NL6MAeuy5XN21zupP8rvITaWa7ssNzA2OmEs65slRAaBIeCTRHBIXZNKegjUNl7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSv4V5db; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e96fc00ad79so281419276.0
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 08:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756310035; x=1756914835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fpEiq5Qnep1fvIhuV4WkShBUQtrfYorDQsZJqSyepI=;
        b=TSv4V5dbBVsODbHwrftRUGBiu7i7LBHOkSSFZsQ2eIOS7WownaI+NP0PAuENsR2e5T
         HZcsNt4QqgNjcsFysk6xQIpDAhrC1R7itFESOexQ9YGwmAJy7TxolakYCmKZB0EfzBg5
         9PXIgOK0Lm6rTxCwGxGn5Qh1z/MFq7oi6jdDM4ZGErpO+XZG/8CsTwT/3G9dXaZ6CZWJ
         EkltqU6CNGXs/UCOxuIRwFoeOo6MIXcWwDZZlnaRELbyebGvAT7cS92CtOmg/u8OSYAU
         o6SxuNKv9IeNMXQ+Y5sjUZa0+EQ5fHDmdEnO0pMMguQXpB2/3uTZaHxJ3H9t6THsS6K4
         ho7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756310035; x=1756914835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8fpEiq5Qnep1fvIhuV4WkShBUQtrfYorDQsZJqSyepI=;
        b=SttTyDlViIJYbVhLKgSOrqf372LtsxbHWbQecZz6/RomNUhW/iOJnpM0II2a7FI4+I
         HCPuYL29+xUBPCstaYAQs4LXgthynaV0cl5SqKiCYq3WDxWohXT/7WyC2JhMQrEu1e08
         ZRk0YcMHe2cQCGI3G5TJhN4xVF3bn+CHmG98xA2ymrahfofkwDs+jq3mY7tv/quPOAT0
         ZFa3nX1BjHtG9FTqfR1DlK4lZ3xvbFPfZ8Wk3FKfekcSqVOUno2BdFmig5BakFqg8ODO
         5to0JcuBV7DRPMMe06V3KFdABvdGffjcz+hnqfikvv9CJHzUcVEqW7WY5Dz4CLhzvvJG
         oRIg==
X-Forwarded-Encrypted: i=1; AJvYcCWmnDCCYLQIWn9gYN0rR6LqCeggik7SyxJwXOECzAOMKlZND6keFGFEIBbvbp77mmBRC7Vi888=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo5SD9vZvLwEm1xWK1VCvjND3vppa9fv37TJvaz/M1GetOxRmz
	6RAOgM3gTtzE4yfyjXlYlKGgVgmzGQNxHhEhXP+JNVQoLuxA2De9q/Zr
X-Gm-Gg: ASbGncs3WwE/zVDgAXE8NVqmtea0YStdhDgFPjF3qLEHvItCHpUCFvWaSOhR5veJ7Ag
	Zc0o3luSnWpmBlRuO5QYlkDkASEh4kVxdaLYyY4yhv36YuEUW0s2mMp230oycLyGtOxGh/wQ5Sr
	wBdGy6VxE2CvHvsWK+tKCtWnMzPHqKTgzcQuqXaspSaMKMCdTxJoSuQPGLjbe9B3YTIJFea8aE4
	+PNC+QeqtE5UPnFdj3P06hmSAovvx5on4pZUs07chC/xv5GW9WMe+xXUctEvjMecTwrmoRCJbx9
	8pV4g+tJyA8CcrCaeay/qlm3krOHxiyLOJ0uOOuwS22JwCYLWhpTgUGj/6DuLjcYjTZkRXkcIXG
	FDGK463OLuTaj6hH65Jk=
X-Google-Smtp-Source: AGHT+IFs8ZsmPAVkre9IDGqHQu4da1Ire1GqUhmUntZcH3znB4fTFp3cZclOA/7k/dmUem8u+pW7CA==
X-Received: by 2002:a05:6902:124d:b0:e96:cba0:16ee with SMTP id 3f1490d57ef6-e96cba01abdmr10448469276.15.1756310034640;
        Wed, 27 Aug 2025 08:53:54 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e96dd12fbd9sm1569013276.32.2025.08.27.08.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:53:53 -0700 (PDT)
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
	Kiran Kella <kiran.kella@broadcom.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v9 11/19] net/mlx5e: Support PSP offload functionality
Date: Wed, 27 Aug 2025 08:53:28 -0700
Message-ID: <20250827155340.2738246-12-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250827155340.2738246-1-daniel.zahka@gmail.com>
References: <20250827155340.2738246-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Raed Salem <raeds@nvidia.com>

Add PSP offload related IFC structs, layouts, and enumerations. Implement
.set_config and .rx_spi_alloc PSP device operations. Driver does not need
to make use of the .set_config operation. Stub .assoc_add and .assoc_del
PSP operations.

Introduce the MLX5_EN_PSP configuration option for enabling PSP offload
support on mlx5 devices.

Signed-off-by: Raed Salem <raeds@nvidia.com>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---

Notes:
    v7:
    - use flexible array declaration instead of 0-length array declaration
      in struct mlx5_ifc_psp_gen_spi_out_bits
    v4:
    - remove unneeded psp.c/psp.h files
    - remove unneeded struct psp_key_spi usage
    v1:
    - https://lore.kernel.org/netdev/20240510030435.120935-10-kuba@kernel.org/

 .../net/ethernet/mellanox/mlx5/core/Kconfig   |  11 ++
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   3 +
 .../ethernet/mellanox/mlx5/core/en/params.c   |   4 +-
 .../mellanox/mlx5/core/en_accel/psp.c         | 140 ++++++++++++++++++
 .../mellanox/mlx5/core/en_accel/psp.h         |  47 ++++++
 .../mellanox/mlx5/core/en_accel/psp_offload.c |  44 ++++++
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   9 ++
 drivers/net/ethernet/mellanox/mlx5/core/fw.c  |   6 +
 .../net/ethernet/mellanox/mlx5/core/main.c    |   1 +
 .../mellanox/mlx5/core/steering/hws/definer.c |   2 +-
 include/linux/mlx5/device.h                   |   4 +
 include/linux/mlx5/mlx5_ifc.h                 |  95 +++++++++++-
 13 files changed, 361 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_offload.c

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
index 6ec7d6e0181d..79a64489da89 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
@@ -208,3 +208,14 @@ config MLX5_DPLL
 	help
 	  DPLL support in Mellanox Technologies ConnectX NICs.
 
+config MLX5_EN_PSP
+	bool "Mellanox Technologies support for PSP cryptography-offload acceleration"
+	depends on INET_PSP
+	depends on MLX5_CORE_EN
+	default y
+	help
+	  mlx5 device offload support for Google PSP Security Protocol offload.
+	  Adds support for PSP encryption offload and for SPI and key generation
+	  interfaces to PSP Stack which supports PSP crypto offload.
+
+	  If unsure, say Y.
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index a253c73db9e5..22bbf6f8e2d5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -110,6 +110,8 @@ mlx5_core-$(CONFIG_MLX5_EN_TLS) += en_accel/ktls_stats.o \
 				   en_accel/fs_tcp.o en_accel/ktls.o en_accel/ktls_txrx.o \
 				   en_accel/ktls_tx.o en_accel/ktls_rx.o
 
+mlx5_core-$(CONFIG_MLX5_EN_PSP) += en_accel/psp.o en_accel/psp_offload.o
+
 #
 # SW Steering
 #
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 0dd3bc0f4caa..32e7b791dd6a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -936,6 +936,9 @@ struct mlx5e_priv {
 #ifdef CONFIG_MLX5_EN_IPSEC
 	struct mlx5e_ipsec        *ipsec;
 #endif
+#ifdef CONFIG_MLX5_EN_PSP
+	struct mlx5e_psp          *psp;
+#endif
 #ifdef CONFIG_MLX5_EN_TLS
 	struct mlx5e_tls          *tls;
 #endif
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 3cca06a74cf9..9975a9d8945b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -6,6 +6,7 @@
 #include "en/port.h"
 #include "en_accel/en_accel.h"
 #include "en_accel/ipsec.h"
+#include "en_accel/psp.h"
 #include <linux/dim.h>
 #include <net/page_pool/types.h>
 #include <net/xdp_sock_drv.h>
@@ -1003,7 +1004,8 @@ void mlx5e_build_sq_param(struct mlx5_core_dev *mdev,
 	bool allow_swp;
 
 	allow_swp = mlx5_geneve_tx_allowed(mdev) ||
-		    (mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_CAP_CRYPTO);
+		    (mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_CAP_CRYPTO) ||
+		    mlx5_is_psp_device(mdev);
 	mlx5e_build_sq_param_common(mdev, param);
 	MLX5_SET(wq, wq, log_wq_sz, params->log_sq_size);
 	MLX5_SET(sqc, sqc, allow_swp, allow_swp);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
new file mode 100644
index 000000000000..096dc4180aaa
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+#include <linux/mlx5/device.h>
+#include <net/psp.h>
+#include <linux/psp.h>
+#include "mlx5_core.h"
+#include "psp.h"
+#include "lib/crypto.h"
+#include "en_accel/psp.h"
+
+static int
+mlx5e_psp_set_config(struct psp_dev *psd, struct psp_dev_config *conf,
+		     struct netlink_ext_ack *extack)
+{
+	return 0; /* TODO: this should actually do things to the device */
+}
+
+static int
+mlx5e_psp_rx_spi_alloc(struct psp_dev *psd, u32 version,
+		       struct psp_key_parsed *assoc,
+		       struct netlink_ext_ack *extack)
+{
+	struct mlx5e_priv *priv = netdev_priv(psd->main_netdev);
+	enum mlx5_psp_gen_spi_in_key_size keysz;
+	u8 keysz_bytes;
+
+	switch (version) {
+	case PSP_VERSION_HDR0_AES_GCM_128:
+		keysz = MLX5_PSP_GEN_SPI_IN_KEY_SIZE_128;
+		keysz_bytes = 16;
+		break;
+	case PSP_VERSION_HDR0_AES_GCM_256:
+		keysz = MLX5_PSP_GEN_SPI_IN_KEY_SIZE_256;
+		keysz_bytes = 32;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return mlx5e_psp_generate_key_spi(priv->mdev, keysz, keysz_bytes, assoc);
+}
+
+static int mlx5e_psp_assoc_add(struct psp_dev *psd, struct psp_assoc *pas,
+			       struct netlink_ext_ack *extack)
+{
+	struct mlx5e_priv *priv = netdev_priv(psd->main_netdev);
+
+	mlx5_core_dbg(priv->mdev, "PSP assoc add: rx: %u, tx: %u\n",
+		      be32_to_cpu(pas->rx.spi), be32_to_cpu(pas->tx.spi));
+
+	return -EINVAL;
+}
+
+static void mlx5e_psp_assoc_del(struct psp_dev *psd, struct psp_assoc *pas)
+{
+}
+
+static struct psp_dev_ops mlx5_psp_ops = {
+	.set_config   = mlx5e_psp_set_config,
+	.rx_spi_alloc = mlx5e_psp_rx_spi_alloc,
+	.tx_key_add   = mlx5e_psp_assoc_add,
+	.tx_key_del   = mlx5e_psp_assoc_del,
+};
+
+void mlx5e_psp_unregister(struct mlx5e_priv *priv)
+{
+	if (!priv->psp || !priv->psp->psp)
+		return;
+
+	psp_dev_unregister(priv->psp->psp);
+}
+
+void mlx5e_psp_register(struct mlx5e_priv *priv)
+{
+	/* FW Caps missing */
+	if (!priv->psp)
+		return;
+
+	priv->psp->caps.assoc_drv_spc = sizeof(u32);
+	priv->psp->caps.versions = 1 << PSP_VERSION_HDR0_AES_GCM_128;
+	if (MLX5_CAP_PSP(priv->mdev, psp_crypto_esp_aes_gcm_256_encrypt) &&
+	    MLX5_CAP_PSP(priv->mdev, psp_crypto_esp_aes_gcm_256_decrypt))
+		priv->psp->caps.versions |= 1 << PSP_VERSION_HDR0_AES_GCM_256;
+
+	priv->psp->psp = psp_dev_create(priv->netdev, &mlx5_psp_ops,
+					&priv->psp->caps, NULL);
+	if (IS_ERR(priv->psp->psp))
+		mlx5_core_err(priv->mdev, "PSP failed to register due to %pe\n",
+			      priv->psp->psp);
+}
+
+int mlx5e_psp_init(struct mlx5e_priv *priv)
+{
+	struct mlx5_core_dev *mdev = priv->mdev;
+	struct mlx5e_psp *psp;
+
+	if (!mlx5_is_psp_device(mdev)) {
+		mlx5_core_dbg(mdev, "PSP offload not supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (!MLX5_CAP_ETH(mdev, swp)) {
+		mlx5_core_dbg(mdev, "SWP not supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (!MLX5_CAP_ETH(mdev, swp_csum)) {
+		mlx5_core_dbg(mdev, "SWP checksum not supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (!MLX5_CAP_ETH(mdev, swp_csum_l4_partial)) {
+		mlx5_core_dbg(mdev, "SWP L4 partial checksum not supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (!MLX5_CAP_ETH(mdev, swp_lso)) {
+		mlx5_core_dbg(mdev, "PSP LSO not supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	psp = kzalloc(sizeof(*psp), GFP_KERNEL);
+	if (!psp)
+		return -ENOMEM;
+
+	priv->psp = psp;
+	mlx5_core_dbg(priv->mdev, "PSP attached to netdevice\n");
+	return 0;
+}
+
+void mlx5e_psp_cleanup(struct mlx5e_priv *priv)
+{
+	struct mlx5e_psp *psp = priv->psp;
+
+	if (!psp)
+		return;
+
+	priv->psp = NULL;
+	kfree(psp);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
new file mode 100644
index 000000000000..a94530f79f6a
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#ifndef __MLX5E_ACCEL_PSP_H__
+#define __MLX5E_ACCEL_PSP_H__
+#if IS_ENABLED(CONFIG_MLX5_EN_PSP)
+#include <net/psp/types.h>
+#include "en.h"
+
+struct mlx5e_psp {
+	struct psp_dev *psp;
+	struct psp_dev_caps caps;
+};
+
+static inline bool mlx5_is_psp_device(struct mlx5_core_dev *mdev)
+{
+	if (!MLX5_CAP_GEN(mdev, psp))
+		return false;
+
+	if (!MLX5_CAP_PSP(mdev, psp_crypto_esp_aes_gcm_128_encrypt) ||
+	    !MLX5_CAP_PSP(mdev, psp_crypto_esp_aes_gcm_128_decrypt))
+		return false;
+
+	return true;
+}
+
+void mlx5e_psp_register(struct mlx5e_priv *priv);
+void mlx5e_psp_unregister(struct mlx5e_priv *priv);
+int mlx5e_psp_init(struct mlx5e_priv *priv);
+void mlx5e_psp_cleanup(struct mlx5e_priv *priv);
+int mlx5e_psp_rotate_key(struct mlx5_core_dev *mdev);
+int mlx5e_psp_generate_key_spi(struct mlx5_core_dev *mdev,
+			       enum mlx5_psp_gen_spi_in_key_size keysz,
+			       unsigned int keysz_bytes,
+			       struct psp_key_parsed *key);
+#else
+static inline bool mlx5_is_psp_device(struct mlx5_core_dev *mdev)
+{
+	return false;
+}
+
+static inline void mlx5e_psp_register(struct mlx5e_priv *priv) { }
+static inline void mlx5e_psp_unregister(struct mlx5e_priv *priv) { }
+static inline int mlx5e_psp_init(struct mlx5e_priv *priv) { return 0; }
+static inline void mlx5e_psp_cleanup(struct mlx5e_priv *priv) { }
+#endif /* CONFIG_MLX5_EN_PSP */
+#endif /* __MLX5E_ACCEL_PSP_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_offload.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_offload.c
new file mode 100644
index 000000000000..5a85fd67d59e
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_offload.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+#include <linux/workqueue.h>
+#include <net/psp/types.h>
+#include "mlx5_core.h"
+#include "en_accel/psp.h"
+
+int mlx5e_psp_rotate_key(struct mlx5_core_dev *mdev)
+{
+	u32 in[MLX5_ST_SZ_DW(psp_rotate_key_in)] = {};
+	u32 out[MLX5_ST_SZ_DW(psp_rotate_key_out)];
+
+	MLX5_SET(psp_rotate_key_in, in, opcode,
+		 MLX5_CMD_OP_PSP_ROTATE_KEY);
+
+	return mlx5_cmd_exec(mdev, in, sizeof(in), out, sizeof(out));
+}
+
+int mlx5e_psp_generate_key_spi(struct mlx5_core_dev *mdev,
+			       enum mlx5_psp_gen_spi_in_key_size keysz,
+			       unsigned int keysz_bytes,
+			       struct psp_key_parsed *key)
+{
+	u32 out[MLX5_ST_SZ_DW(psp_gen_spi_out) + MLX5_ST_SZ_DW(key_spi)] = {};
+	u32 in[MLX5_ST_SZ_DW(psp_gen_spi_in)] = {};
+	void *outkey;
+	int err;
+
+	WARN_ON_ONCE(keysz_bytes > PSP_MAX_KEY);
+
+	MLX5_SET(psp_gen_spi_in, in, opcode, MLX5_CMD_OP_PSP_GEN_SPI);
+	MLX5_SET(psp_gen_spi_in, in, key_size, keysz);
+	MLX5_SET(psp_gen_spi_in, in, num_of_spi, 1);
+	err = mlx5_cmd_exec(mdev, in, sizeof(in), out, sizeof(out));
+	if (err)
+		return err;
+
+	outkey = MLX5_ADDR_OF(psp_gen_spi_out, out, key_spi);
+	key->spi = cpu_to_be32(MLX5_GET(key_spi, outkey, spi));
+	memcpy(key->key, MLX5_ADDR_OF(key_spi, outkey, key) + 32 - keysz_bytes,
+	       keysz_bytes);
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 21bb88c5d3dc..c4cd3ae1dc5c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -52,6 +52,7 @@
 #include "en_tc.h"
 #include "en_rep.h"
 #include "en_accel/ipsec.h"
+#include "en_accel/psp.h"
 #include "en_accel/macsec.h"
 #include "en_accel/en_accel.h"
 #include "en_accel/ktls.h"
@@ -5870,6 +5871,7 @@ static int mlx5e_nic_init(struct mlx5_core_dev *mdev,
 	if (take_rtnl)
 		rtnl_lock();
 
+	mlx5e_psp_register(priv);
 	/* update XDP supported features */
 	mlx5e_set_xdp_feature(netdev);
 
@@ -5882,6 +5884,7 @@ static int mlx5e_nic_init(struct mlx5_core_dev *mdev,
 static void mlx5e_nic_cleanup(struct mlx5e_priv *priv)
 {
 	mlx5e_health_destroy_reporters(priv);
+	mlx5e_psp_unregister(priv);
 	mlx5e_ktls_cleanup(priv);
 	mlx5e_fs_cleanup(priv->fs);
 	debugfs_remove_recursive(priv->dfs_root);
@@ -6009,6 +6012,10 @@ static void mlx5e_nic_enable(struct mlx5e_priv *priv)
 	if (err)
 		mlx5_core_err(mdev, "MACsec initialization failed, %d\n", err);
 
+	err = mlx5e_psp_init(priv);
+	if (err)
+		mlx5_core_err(mdev, "PSP initialization failed, %d\n", err);
+
 	/* Marking the link as currently not needed by the Driver */
 	if (!netif_running(netdev))
 		mlx5e_modify_admin_state(mdev, MLX5_PORT_DOWN);
@@ -6072,6 +6079,7 @@ static void mlx5e_nic_disable(struct mlx5e_priv *priv)
 	mlx5e_disable_async_events(priv);
 	mlx5_lag_remove_netdev(mdev, priv->netdev);
 	mlx5_vxlan_reset_to_default(mdev->vxlan);
+	mlx5e_psp_cleanup(priv);
 	mlx5e_macsec_cleanup(priv);
 	mlx5e_ipsec_cleanup(priv);
 }
@@ -6730,6 +6738,7 @@ static void _mlx5e_remove(struct auxiliary_device *adev)
 	 * is already unregistered before changing to NIC profile.
 	 */
 	if (priv->netdev->reg_state == NETREG_REGISTERED) {
+		mlx5e_psp_unregister(priv);
 		unregister_netdev(priv->netdev);
 		_mlx5e_suspend(adev, false);
 	} else {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw.c b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
index 57476487e31f..eeb4437975f2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
@@ -294,6 +294,12 @@ int mlx5_query_hca_caps(struct mlx5_core_dev *dev)
 			return err;
 	}
 
+	if (MLX5_CAP_GEN(dev, psp)) {
+		err = mlx5_core_get_caps(dev, MLX5_CAP_PSP);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 8517d4e5d5ef..0951c7cc1b5f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1798,6 +1798,7 @@ static const int types[] = {
 	MLX5_CAP_VDPA_EMULATION,
 	MLX5_CAP_IPSEC,
 	MLX5_CAP_PORT_SELECTION,
+	MLX5_CAP_PSP,
 	MLX5_CAP_MACSEC,
 	MLX5_CAP_ADV_VIRTUALIZATION,
 	MLX5_CAP_CRYPTO,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c
index c6436c3a7a83..c4bb6967f74d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c
@@ -1280,7 +1280,7 @@ hws_definer_conv_misc2(struct mlx5hws_definer_conv_data *cd,
 	struct mlx5hws_definer_fc *fc = cd->fc;
 	struct mlx5hws_definer_fc *curr_fc;
 
-	if (HWS_IS_FLD_SET_SZ(match_param, misc_parameters_2.reserved_at_1a0, 0x8) ||
+	if (HWS_IS_FLD_SET_SZ(match_param, misc_parameters_2.psp_syndrome, 0x8) ||
 	    HWS_IS_FLD_SET_SZ(match_param,
 			      misc_parameters_2.ipsec_next_header, 0x8) ||
 	    HWS_IS_FLD_SET_SZ(match_param, misc_parameters_2.reserved_at_1c0, 0x40) ||
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index 9d2467f982ad..72a83666e67f 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -1248,6 +1248,7 @@ enum mlx5_cap_type {
 	MLX5_CAP_IPSEC,
 	MLX5_CAP_CRYPTO = 0x1a,
 	MLX5_CAP_SHAMPO = 0x1d,
+	MLX5_CAP_PSP = 0x1e,
 	MLX5_CAP_MACSEC = 0x1f,
 	MLX5_CAP_GENERAL_2 = 0x20,
 	MLX5_CAP_PORT_SELECTION = 0x25,
@@ -1487,6 +1488,9 @@ enum mlx5_qcam_feature_groups {
 #define MLX5_CAP_SHAMPO(mdev, cap) \
 	MLX5_GET(shampo_cap, mdev->caps.hca[MLX5_CAP_SHAMPO]->cur, cap)
 
+#define MLX5_CAP_PSP(mdev, cap)\
+	MLX5_GET(psp_cap, (mdev)->caps.hca[MLX5_CAP_PSP]->cur, cap)
+
 enum {
 	MLX5_CMD_STAT_OK			= 0x0,
 	MLX5_CMD_STAT_INT_ERR			= 0x1,
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 44d497272162..1f9e0e47dc91 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -314,6 +314,8 @@ enum {
 	MLX5_CMD_OP_CREATE_UMEM                   = 0xa08,
 	MLX5_CMD_OP_DESTROY_UMEM                  = 0xa0a,
 	MLX5_CMD_OP_SYNC_STEERING                 = 0xb00,
+	MLX5_CMD_OP_PSP_GEN_SPI                   = 0xb10,
+	MLX5_CMD_OP_PSP_ROTATE_KEY                = 0xb11,
 	MLX5_CMD_OP_QUERY_VHCA_STATE              = 0xb0d,
 	MLX5_CMD_OP_MODIFY_VHCA_STATE             = 0xb0e,
 	MLX5_CMD_OP_SYNC_CRYPTO                   = 0xb12,
@@ -489,12 +491,14 @@ struct mlx5_ifc_flow_table_prop_layout_bits {
 	u8         execute_aso[0x1];
 	u8         reserved_at_47[0x19];
 
-	u8         reserved_at_60[0x2];
+	u8         reformat_l2_to_l3_psp_tunnel[0x1];
+	u8         reformat_l3_psp_tunnel_to_l2[0x1];
 	u8         reformat_insert[0x1];
 	u8         reformat_remove[0x1];
 	u8         macsec_encrypt[0x1];
 	u8         macsec_decrypt[0x1];
-	u8         reserved_at_66[0x2];
+	u8         psp_encrypt[0x1];
+	u8         psp_decrypt[0x1];
 	u8         reformat_add_macsec[0x1];
 	u8         reformat_remove_macsec[0x1];
 	u8         reparse[0x1];
@@ -703,7 +707,7 @@ struct mlx5_ifc_fte_match_set_misc2_bits {
 
 	u8         metadata_reg_a[0x20];
 
-	u8         reserved_at_1a0[0x8];
+	u8         psp_syndrome[0x8];
 	u8         macsec_syndrome[0x8];
 	u8         ipsec_syndrome[0x8];
 	u8         ipsec_next_header[0x8];
@@ -1511,6 +1515,19 @@ struct mlx5_ifc_macsec_cap_bits {
 	u8    reserved_at_40[0x7c0];
 };
 
+struct mlx5_ifc_psp_cap_bits {
+	u8         reserved_at_0[0x1];
+	u8         psp_crypto_offload[0x1]; /* Set by the driver */
+	u8         reserved_at_2[0x1];
+	u8         psp_crypto_esp_aes_gcm_256_encrypt[0x1];
+	u8         psp_crypto_esp_aes_gcm_128_encrypt[0x1];
+	u8         psp_crypto_esp_aes_gcm_256_decrypt[0x1];
+	u8         psp_crypto_esp_aes_gcm_128_decrypt[0x1];
+	u8         reserved_at_7[0x4];
+	u8         log_max_num_of_psp_spi[0x5];
+	u8         reserved_at_10[0x7f0];
+};
+
 enum {
 	MLX5_WQ_TYPE_LINKED_LIST  = 0x0,
 	MLX5_WQ_TYPE_CYCLIC       = 0x1,
@@ -1650,7 +1667,7 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         reg_c_preserve[0x1];
 	u8         reserved_at_aa[0x1];
 	u8         log_max_srq[0x5];
-	u8         reserved_at_b0[0x1];
+	u8	   reserved_at_b0[0x1];
 	u8         uplink_follow[0x1];
 	u8         ts_cqe_to_dest_cqn[0x1];
 	u8         reserved_at_b3[0x6];
@@ -1876,7 +1893,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 
 	u8         reserved_at_2a0[0x7];
 	u8         mkey_pcie_tph[0x1];
-	u8         reserved_at_2a8[0x3];
+	u8         reserved_at_2a8[0x2];
+
+	u8         psp[0x1];
 	u8         shampo[0x1];
 	u8         reserved_at_2ac[0x4];
 	u8         max_wqe_sz_rq[0x10];
@@ -3803,6 +3822,7 @@ union mlx5_ifc_hca_cap_union_bits {
 	struct mlx5_ifc_macsec_cap_bits macsec_cap;
 	struct mlx5_ifc_crypto_cap_bits crypto_cap;
 	struct mlx5_ifc_ipsec_cap_bits ipsec_cap;
+	struct mlx5_ifc_psp_cap_bits psp_cap;
 	u8         reserved_at_0[0x8000];
 };
 
@@ -3832,6 +3852,7 @@ enum {
 enum {
 	MLX5_FLOW_CONTEXT_ENCRYPT_DECRYPT_TYPE_IPSEC   = 0x0,
 	MLX5_FLOW_CONTEXT_ENCRYPT_DECRYPT_TYPE_MACSEC  = 0x1,
+	MLX5_FLOW_CONTEXT_ENCRYPT_DECRYPT_TYPE_PSP     = 0x2,
 };
 
 struct mlx5_ifc_vlan_bits {
@@ -7159,6 +7180,8 @@ enum mlx5_reformat_ctx_type {
 	MLX5_REFORMAT_TYPE_DEL_ESP_TRANSPORT_OVER_UDP = 0xa,
 	MLX5_REFORMAT_TYPE_ADD_ESP_TRANSPORT_OVER_IPV6 = 0xb,
 	MLX5_REFORMAT_TYPE_ADD_ESP_TRANSPORT_OVER_UDPV6 = 0xc,
+	MLX5_REFORMAT_TYPE_ADD_PSP_TUNNEL = 0xd,
+	MLX5_REFORMAT_TYPE_DEL_PSP_TUNNEL = 0xe,
 	MLX5_REFORMAT_TYPE_INSERT_HDR = 0xf,
 	MLX5_REFORMAT_TYPE_REMOVE_HDR = 0x10,
 	MLX5_REFORMAT_TYPE_ADD_MACSEC = 0x11,
@@ -7285,6 +7308,7 @@ enum {
 	MLX5_ACTION_IN_FIELD_IPSEC_SYNDROME    = 0x5D,
 	MLX5_ACTION_IN_FIELD_OUT_EMD_47_32     = 0x6F,
 	MLX5_ACTION_IN_FIELD_OUT_EMD_31_0      = 0x70,
+	MLX5_ACTION_IN_FIELD_PSP_SYNDROME      = 0x71,
 };
 
 struct mlx5_ifc_alloc_modify_header_context_out_bits {
@@ -13079,6 +13103,7 @@ enum {
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_PURPOSE_TLS = 0x1,
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_PURPOSE_IPSEC = 0x2,
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_PURPOSE_MACSEC = 0x4,
+	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_PURPOSE_PSP = 0x6,
 };
 
 struct mlx5_ifc_tls_static_params_bits {
@@ -13496,4 +13521,64 @@ enum mlx5e_pcie_cong_event_mod_field {
 	MLX5_PCIE_CONG_EVENT_MOD_THRESH   = BIT(2),
 };
 
+struct mlx5_ifc_psp_rotate_key_in_bits {
+	u8         opcode[0x10];
+	u8         uid[0x10];
+
+	u8         reserved_at_20[0x10];
+	u8         op_mod[0x10];
+
+	u8         reserved_at_40[0x40];
+};
+
+struct mlx5_ifc_psp_rotate_key_out_bits {
+	u8         status[0x8];
+	u8         reserved_at_8[0x18];
+
+	u8         syndrome[0x20];
+
+	u8         reserved_at_40[0x40];
+};
+
+enum mlx5_psp_gen_spi_in_key_size {
+	MLX5_PSP_GEN_SPI_IN_KEY_SIZE_128 = 0x0,
+	MLX5_PSP_GEN_SPI_IN_KEY_SIZE_256 = 0x1,
+};
+
+struct mlx5_ifc_key_spi_bits {
+	u8         spi[0x20];
+
+	u8         reserved_at_20[0x60];
+
+	u8         key[8][0x20];
+};
+
+struct mlx5_ifc_psp_gen_spi_in_bits {
+	u8         opcode[0x10];
+	u8         uid[0x10];
+
+	u8         reserved_at_20[0x10];
+	u8         op_mod[0x10];
+
+	u8         reserved_at_40[0x20];
+
+	u8         key_size[0x2];
+	u8         reserved_at_62[0xe];
+	u8         num_of_spi[0x10];
+};
+
+struct mlx5_ifc_psp_gen_spi_out_bits {
+	u8         status[0x8];
+	u8         reserved_at_8[0x18];
+
+	u8         syndrome[0x20];
+
+	u8         reserved_at_40[0x10];
+	u8         num_of_spi[0x10];
+
+	u8         reserved_at_60[0x20];
+
+	struct mlx5_ifc_key_spi_bits key_spi[];
+};
+
 #endif /* MLX5_IFC_H */
-- 
2.47.3


