Return-Path: <netdev+bounces-209506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCA2B0FB9C
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 22:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3C243A056A
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 20:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85C3233739;
	Wed, 23 Jul 2025 20:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPOu7Coz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7C623B616
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 20:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302912; cv=none; b=L0Od20QQjTagxIqWlgLoSw0UCAOwiO8DuvbQxrKN+hWFluJUdl9UDMRYAifNw5AVQ/y4idIOFPTZSzPX14mznWaaF8r3SOxRWvaj3Ne0pR2mYIpmGoTuObb11Ogi3JszYCtKTXutyP5uVvbH5ObMKBr3i/EXinYUiZuIh4Vo0D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302912; c=relaxed/simple;
	bh=TYORa3amjT9ez0DYkaENKrvKKpI6qQK4cFbU93EGk10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IemG+TCsd4o93aGHpAIUv1mUUdWjWGbVI0ctwayzo2oAILN08N+Er8Cs//0yEIp+8uCD/LYmyvgBjfa4dDL1ogC5E0qYvGS1e4w9wNhzyGyAU9qL91O2jCRyzUhincNFd1cGnsQweO+1/NxPc92EcdVq3wFP7Vf+borulDqwmSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPOu7Coz; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e8dd5602497so210836276.0
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 13:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753302909; x=1753907709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u7ycSzc+xzCuBbB8OtWlgeI6HHUxXeVP1dyyc0TrnPU=;
        b=iPOu7CozuBfFV85wItdR8079AExEcpTkeXpWNgdBOW3ZOLpLBClAWKRDg+8PW3gJej
         QWPyJGWL34MFXWnmbNiWDARlP2IcNq38UgN0Q6tzUudgwDcCkA0tFGFmTeyVKFrT6uVe
         lN6HPF9ihmUqi/p4KbRbANaKtiydYiDg74ekYwOMLLv7/CZfzbmMWHDW2JzZSsH3tcBP
         TkfjKoqFBYZM2uwas4jLHsmb1kmEXUtvF0FjLT29pJgPdt1GvOqPi3pnplPpVVmSJj96
         19OxX2LR4hXDSFddfb6nwzRX25flbktypVFSBUn7FJO2eHi25i2p43En9s3SQAyBarvM
         N9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753302909; x=1753907709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u7ycSzc+xzCuBbB8OtWlgeI6HHUxXeVP1dyyc0TrnPU=;
        b=CYbEo6DnE7QJAfQidUen6siIUsTugzuej7JGDxi8Xd2n82H3x7ng+9LjRNN9OrwwbE
         XfWtZYN35KSn8fsTSzAjxR9H6za7sus/7iQ+FfTWbbQOlAtYlhJ8lRChY4Lx6Gqrlxkg
         jfoxdDrc5ivvBl2/+C6Zb2gAEB2JMwTvSSTrxMt21xjNkeOAs92isHCQI/N82RmVqZ80
         Otgsz7mUpWhnc+xA8so26CBCAxECLu+0RdaCl8XZBqhUTIn/HlBjK5gJUGIYBAxRG8nH
         bceMfkcDHBlKDagU8613JBUL+s2uIDoynnhTaT94qRO2n7CKdM3BPwR7sbmTG+sjhsw7
         fr7A==
X-Forwarded-Encrypted: i=1; AJvYcCWGY86jwjNeTr6Xq4HjZXTf+OJI7kQUloABALbK69oQ2LjVplCpNtAjVjn7waKkjDYqrt8YwWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6/GLEnnmvr3tNA/nC74gCzAYuC1pcoF9ZmfR5qYqDs2w9UKz1
	syGKNgNI/9375eaxBNdedapfMErdBUaEz6cw6CWOyEVzgFC3XmJB9yOW
X-Gm-Gg: ASbGncusXJEMNr2sgCsNKNZiGz3L3lGWcyxSxdqU+2ZHgic4RMo2IZaCpMI4gTE0EDA
	jWQU1v3+MxVdTrAazIvOWK1l7LLMv4ju91aonRz4Tto8f8g7e/HDAU6LHGtQDPb6HPU7AEhrJxy
	9xXqtmEyVlfwh1SDiJzGPa79kQy2ySbA4OI4fu0ZkJZMsE2P0xvgzt0vK5zBeVvyoWy18FzFYjp
	l2jcSbY+J4R0cbxD8IX5jxxZEDjTD3bcF7IwLoBOBKliAakgScHCEHgzBp1ET069FQLc9agemQM
	lOVtvLrRu5L8HEATs3wrCQPySTiwsEZOkCFguAtG0F2gEBtMAQo+QyjMegWbuGHaNixgfluOQz2
	9xfVTQC4M2qHLHvcxVKUW
X-Google-Smtp-Source: AGHT+IFKk8zBWETsvxv/Ru6bpfCYUp6OZWQ2f0qNExz3bQNH+ojN293Ub9GGxwGfV0Mr4CICHPWbeg==
X-Received: by 2002:a05:6902:220d:b0:e8d:be80:45d1 with SMTP id 3f1490d57ef6-e8dc5b0af53mr6186689276.49.1753302908771;
        Wed, 23 Jul 2025 13:35:08 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4f::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8d7cc4bc54sm4113561276.20.2025.07.23.13.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 13:35:08 -0700 (PDT)
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
Subject: [PATCH net-next v5 11/19] net/mlx5e: Support PSP offload functionality
Date: Wed, 23 Jul 2025 13:34:22 -0700
Message-ID: <20250723203454.519540-12-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250723203454.519540-1-daniel.zahka@gmail.com>
References: <20250723203454.519540-1-daniel.zahka@gmail.com>
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
 include/linux/mlx5/mlx5_ifc.h                 |  94 +++++++++++-
 13 files changed, 360 insertions(+), 7 deletions(-)
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
index 650df18a9216..4eeeb4152c0e 100644
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
index 99295eaf2f02..ed1b9620f077 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -935,6 +935,9 @@ struct mlx5e_priv {
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
index 33bdb7f1e03f..97b95094fcdf 100644
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
@@ -5846,6 +5847,7 @@ static int mlx5e_nic_init(struct mlx5_core_dev *mdev,
 	if (take_rtnl)
 		rtnl_lock();
 
+	mlx5e_psp_register(priv);
 	/* update XDP supported features */
 	mlx5e_set_xdp_feature(netdev);
 
@@ -5858,6 +5860,7 @@ static int mlx5e_nic_init(struct mlx5_core_dev *mdev,
 static void mlx5e_nic_cleanup(struct mlx5e_priv *priv)
 {
 	mlx5e_health_destroy_reporters(priv);
+	mlx5e_psp_unregister(priv);
 	mlx5e_ktls_cleanup(priv);
 	mlx5e_fs_cleanup(priv->fs);
 	debugfs_remove_recursive(priv->dfs_root);
@@ -5985,6 +5988,10 @@ static void mlx5e_nic_enable(struct mlx5e_priv *priv)
 	if (err)
 		mlx5_core_err(mdev, "MACsec initialization failed, %d\n", err);
 
+	err = mlx5e_psp_init(priv);
+	if (err)
+		mlx5_core_err(mdev, "PSP initialization failed, %d\n", err);
+
 	/* Marking the link as currently not needed by the Driver */
 	if (!netif_running(netdev))
 		mlx5e_modify_admin_state(mdev, MLX5_PORT_DOWN);
@@ -6048,6 +6055,7 @@ static void mlx5e_nic_disable(struct mlx5e_priv *priv)
 	mlx5e_disable_async_events(priv);
 	mlx5_lag_remove_netdev(mdev, priv->netdev);
 	mlx5_vxlan_reset_to_default(mdev->vxlan);
+	mlx5e_psp_cleanup(priv);
 	mlx5e_macsec_cleanup(priv);
 	mlx5e_ipsec_cleanup(priv);
 }
@@ -6706,6 +6714,7 @@ static void _mlx5e_remove(struct auxiliary_device *adev)
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
index e7bcd0f0a709..7e869a675504 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1796,6 +1796,7 @@ static const int types[] = {
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
index ed4130e49c27..0aa751967def 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -311,6 +311,8 @@ enum {
 	MLX5_CMD_OP_CREATE_UMEM                   = 0xa08,
 	MLX5_CMD_OP_DESTROY_UMEM                  = 0xa0a,
 	MLX5_CMD_OP_SYNC_STEERING                 = 0xb00,
+	MLX5_CMD_OP_PSP_GEN_SPI                   = 0xb10,
+	MLX5_CMD_OP_PSP_ROTATE_KEY                = 0xb11,
 	MLX5_CMD_OP_QUERY_VHCA_STATE              = 0xb0d,
 	MLX5_CMD_OP_MODIFY_VHCA_STATE             = 0xb0e,
 	MLX5_CMD_OP_SYNC_CRYPTO                   = 0xb12,
@@ -486,12 +488,14 @@ struct mlx5_ifc_flow_table_prop_layout_bits {
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
@@ -700,7 +704,7 @@ struct mlx5_ifc_fte_match_set_misc2_bits {
 
 	u8         metadata_reg_a[0x20];
 
-	u8         reserved_at_1a0[0x8];
+	u8         psp_syndrome[0x8];
 	u8         macsec_syndrome[0x8];
 	u8         ipsec_syndrome[0x8];
 	u8         ipsec_next_header[0x8];
@@ -1508,6 +1512,19 @@ struct mlx5_ifc_macsec_cap_bits {
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
@@ -1647,7 +1664,7 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         reg_c_preserve[0x1];
 	u8         reserved_at_aa[0x1];
 	u8         log_max_srq[0x5];
-	u8         reserved_at_b0[0x1];
+	u8	   reserved_at_b0[0x1];
 	u8         uplink_follow[0x1];
 	u8         ts_cqe_to_dest_cqn[0x1];
 	u8         reserved_at_b3[0x6];
@@ -1871,7 +1888,8 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         reserved_at_280[0x10];
 	u8         max_wqe_sz_sq[0x10];
 
-	u8         reserved_at_2a0[0xb];
+	u8         reserved_at_2a0[0xa];
+	u8         psp[0x1];
 	u8         shampo[0x1];
 	u8         reserved_at_2ac[0x4];
 	u8         max_wqe_sz_rq[0x10];
@@ -3786,6 +3804,7 @@ union mlx5_ifc_hca_cap_union_bits {
 	struct mlx5_ifc_macsec_cap_bits macsec_cap;
 	struct mlx5_ifc_crypto_cap_bits crypto_cap;
 	struct mlx5_ifc_ipsec_cap_bits ipsec_cap;
+	struct mlx5_ifc_psp_cap_bits psp_cap;
 	u8         reserved_at_0[0x8000];
 };
 
@@ -3815,6 +3834,7 @@ enum {
 enum {
 	MLX5_FLOW_CONTEXT_ENCRYPT_DECRYPT_TYPE_IPSEC   = 0x0,
 	MLX5_FLOW_CONTEXT_ENCRYPT_DECRYPT_TYPE_MACSEC  = 0x1,
+	MLX5_FLOW_CONTEXT_ENCRYPT_DECRYPT_TYPE_PSP     = 0x2,
 };
 
 struct mlx5_ifc_vlan_bits {
@@ -7108,6 +7128,8 @@ enum mlx5_reformat_ctx_type {
 	MLX5_REFORMAT_TYPE_DEL_ESP_TRANSPORT_OVER_UDP = 0xa,
 	MLX5_REFORMAT_TYPE_ADD_ESP_TRANSPORT_OVER_IPV6 = 0xb,
 	MLX5_REFORMAT_TYPE_ADD_ESP_TRANSPORT_OVER_UDPV6 = 0xc,
+	MLX5_REFORMAT_TYPE_ADD_PSP_TUNNEL = 0xd,
+	MLX5_REFORMAT_TYPE_DEL_PSP_TUNNEL = 0xe,
 	MLX5_REFORMAT_TYPE_INSERT_HDR = 0xf,
 	MLX5_REFORMAT_TYPE_REMOVE_HDR = 0x10,
 	MLX5_REFORMAT_TYPE_ADD_MACSEC = 0x11,
@@ -7234,6 +7256,7 @@ enum {
 	MLX5_ACTION_IN_FIELD_IPSEC_SYNDROME    = 0x5D,
 	MLX5_ACTION_IN_FIELD_OUT_EMD_47_32     = 0x6F,
 	MLX5_ACTION_IN_FIELD_OUT_EMD_31_0      = 0x70,
+	MLX5_ACTION_IN_FIELD_PSP_SYNDROME      = 0x71,
 };
 
 struct mlx5_ifc_alloc_modify_header_context_out_bits {
@@ -12944,6 +12967,7 @@ enum {
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_PURPOSE_TLS = 0x1,
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_PURPOSE_IPSEC = 0x2,
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_PURPOSE_MACSEC = 0x4,
+	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_PURPOSE_PSP = 0x6,
 };
 
 struct mlx5_ifc_tls_static_params_bits {
@@ -13361,4 +13385,64 @@ enum mlx5e_pcie_cong_event_mod_field {
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
+	struct mlx5_ifc_key_spi_bits key_spi[0];
+};
+
 #endif /* MLX5_IFC_H */
-- 
2.47.1


