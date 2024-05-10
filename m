Return-Path: <netdev+bounces-95270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DB78C1CB7
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 05:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D66FD280E55
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 03:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB78814A095;
	Fri, 10 May 2024 03:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCi5vrg/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F2C14A088
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 03:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715310290; cv=none; b=gxxnos5YD7wFnqeNUSIicDOnfzWTob9+j8okaHAv9DZoKnXIB/VC0xQGhXzsnYXyO/c3JlP4X+pkOS1Cd+6PtLyBmEiDjrhbNnRjyjTWIrR/WT2ynuFVaK6/hJpwSUuROMuPwV4H+dvWgZFwUTF4zHBC8NmE6GkGPs/Yc5pPYBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715310290; c=relaxed/simple;
	bh=UmJPQY6q/vJGwfx+xf27dIf+FqQgMB7AfaBEjQ1Cxkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RwEvzhdM/23Q4Eava5S2qK77tqQrVJYQiOnKMuTBqmn0/fUX+7dYXCwmAUD16wS6ZBEeT/GiPFJxvlZxz1vCZ9Q4oPC3RJmiuJYxcRlRfNhC4OeYD49dCX3BQSMcqd7+PQ4LUhAvGzKMiiAr9NZ1JezjLRXPZOPqn4mCjYM5le8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCi5vrg/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E29FC116B1;
	Fri, 10 May 2024 03:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715310290;
	bh=UmJPQY6q/vJGwfx+xf27dIf+FqQgMB7AfaBEjQ1Cxkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HCi5vrg/deJcHpVfzeGMO9uwKxMiTxBk/dHwQD026srJL676FdPhiX+hWUC+CpsGM
	 wAvJ+J5LnR2+/GKi86t4xdUXtFbQfVh9aNzDqg1CbwCcu9i0gsm+y3usW3IO3RV0+M
	 K2Eupn8x61LHBIN1A0TqRA0hor+Tz+P+JyNtoa/xXKJJzF4EXSj/quqM0a7hAkozS6
	 guhX45UTpCr2dE4SjefXCoKJMJj/IQPiOWIVmGIh+ZJr1T3Vb6JHNEWeVkX2U/Xk33
	 SIXQN9kEz3Do6Iv894AWKYt2XF8+vy6lHQYMs+6f7IciMOgAYWPmi1coTAD79UnvCE
	 3AJ2t3LfIgitQ==
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
Subject: [RFC net-next 09/15] net/mlx5e: Support PSP offload functionality
Date: Thu,  9 May 2024 20:04:29 -0700
Message-ID: <20240510030435.120935-10-kuba@kernel.org>
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

Add PSP offload related IFC structs, layouts, and enumerations. Implement
.set_config and .rx_spi_alloc PSP device operations. Driver does not need
to make use of the .set_config operation. Stub .assoc_add and .assoc_del
PSP operations.

Introduce the MLX5_EN_PSP configuration option for enabling PSP offload
support on mlx5 devices.

Signed-off-by: Raed Salem <raeds@nvidia.com>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../net/ethernet/mellanox/mlx5/core/Kconfig   |  11 ++
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   3 +
 .../ethernet/mellanox/mlx5/core/en/params.c   |   4 +-
 .../mellanox/mlx5/core/en_accel/nisp.c        | 149 ++++++++++++++++++
 .../mellanox/mlx5/core/en_accel/nisp.h        |  53 +++++++
 .../mlx5/core/en_accel/nisp_offload.c         |  52 ++++++
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   9 ++
 drivers/net/ethernet/mellanox/mlx5/core/fw.c  |   6 +
 .../net/ethernet/mellanox/mlx5/core/main.c    |   5 +
 .../net/ethernet/mellanox/mlx5/core/nisp.c    |  24 +++
 .../net/ethernet/mellanox/mlx5/core/nisp.h    |  15 ++
 include/linux/mlx5/device.h                   |   4 +
 include/linux/mlx5/driver.h                   |   2 +
 include/linux/mlx5/mlx5_ifc.h                 |  98 +++++++++++-
 15 files changed, 431 insertions(+), 8 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_offload.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/nisp.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/nisp.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
index 685335832a93..0dc9665a9557 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
@@ -197,3 +197,14 @@ config MLX5_DPLL
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
index 76dc5a9b9648..c17a5e343603 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -17,7 +17,7 @@ mlx5_core-y :=	main.o cmd.o debugfs.o fw.o eq.o uar.o pagealloc.o \
 		fs_counters.o fs_ft_pool.o rl.o lag/debugfs.o lag/lag.o dev.o events.o wq.o lib/gid.o \
 		lib/devcom.o lib/pci_vsc.o lib/dm.o lib/fs_ttc.o diag/fs_tracepoint.o \
 		diag/fw_tracer.o diag/crdump.o devlink.o diag/rsc_dump.o diag/reporter_vnic.o \
-		fw_reset.o qos.o lib/tout.o lib/aso.o
+		fw_reset.o qos.o lib/tout.o lib/aso.o nisp.o
 
 #
 # Netdev basic
@@ -109,6 +109,8 @@ mlx5_core-$(CONFIG_MLX5_EN_TLS) += en_accel/ktls_stats.o \
 				   en_accel/fs_tcp.o en_accel/ktls.o en_accel/ktls_txrx.o \
 				   en_accel/ktls_tx.o en_accel/ktls_rx.o
 
+mlx5_core-$(CONFIG_MLX5_EN_PSP) += en_accel/nisp.o en_accel/nisp_offload.o
+
 mlx5_core-$(CONFIG_MLX5_SW_STEERING) += steering/dr_domain.o steering/dr_table.o \
 					steering/dr_matcher.o steering/dr_rule.o \
 					steering/dr_icm_pool.o steering/dr_buddy.o \
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index f8bd9dbf59cd..b7ceb8011a92 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -941,6 +941,9 @@ struct mlx5e_priv {
 #ifdef CONFIG_MLX5_EN_IPSEC
 	struct mlx5e_ipsec        *ipsec;
 #endif
+#ifdef CONFIG_MLX5_EN_PSP
+	struct mlx5e_nisp        *nisp;
+#endif
 #ifdef CONFIG_MLX5_EN_TLS
 	struct mlx5e_tls          *tls;
 #endif
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index ec819dfc98be..3141abb33ff7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -6,6 +6,7 @@
 #include "en/port.h"
 #include "en_accel/en_accel.h"
 #include "en_accel/ipsec.h"
+#include "en_accel/nisp.h"
 #include <linux/dim.h>
 #include <net/page_pool/types.h>
 #include <net/xdp_sock_drv.h>
@@ -1005,7 +1006,8 @@ void mlx5e_build_sq_param(struct mlx5_core_dev *mdev,
 	bool allow_swp;
 
 	allow_swp = mlx5_geneve_tx_allowed(mdev) ||
-		    (mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_CAP_CRYPTO);
+		    (mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_CAP_CRYPTO) ||
+		    mlx5_is_nisp_device(mdev);
 	mlx5e_build_sq_param_common(mdev, param);
 	MLX5_SET(wq, wq, log_wq_sz, params->log_sq_size);
 	MLX5_SET(sqc, sqc, allow_swp, allow_swp);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp.c
new file mode 100644
index 000000000000..eff7906b3764
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+#include <linux/mlx5/device.h>
+#include <net/psp.h>
+#include <linux/psp.h>
+#include "mlx5_core.h"
+#include "../nisp.h"
+#include "lib/crypto.h"
+#include "en_accel/nisp.h"
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
+	enum mlx5_nisp_gen_spi_in_key_size keysz;
+	struct nisp_key_spi key_spi = {};
+	u8 keysz_bytes;
+	int err;
+
+	switch (version) {
+	case PSP_VERSION_HDR0_AES_GCM_128:
+		keysz = MLX5_NISP_GEN_SPI_IN_KEY_SIZE_128;
+		keysz_bytes = 16;
+		break;
+	case PSP_VERSION_HDR0_AES_GCM_256:
+		keysz = MLX5_NISP_GEN_SPI_IN_KEY_SIZE_256;
+		keysz_bytes = 32;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	err = mlx5e_nisp_generate_key_spi(priv->mdev, keysz, keysz_bytes,
+					  &key_spi);
+	if (err)
+		return err;
+
+	assoc->spi = cpu_to_be32(key_spi.spi);
+	memcpy(assoc->key, key_spi.key, keysz_bytes);
+	return 0;
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
+static void mlx5e_psp_assoc_del(struct psp_dev *psd, struct psp_assoc *tas)
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
+void mlx5e_nisp_unregister(struct mlx5e_priv *priv)
+{
+	if (!priv->nisp || !priv->nisp->psp)
+		return;
+
+	psp_dev_unregister(priv->nisp->psp);
+}
+
+void mlx5e_nisp_register(struct mlx5e_priv *priv)
+{
+	/* FW Caps missing */
+	if (!priv->nisp)
+		return;
+
+	priv->nisp->caps.assoc_drv_spc = sizeof(u32);
+	priv->nisp->caps.versions = 1 << PSP_VERSION_HDR0_AES_GCM_128;
+	if (MLX5_CAP_NISP(priv->mdev, nisp_crypto_esp_aes_gcm_256_encrypt) &&
+	    MLX5_CAP_NISP(priv->mdev, nisp_crypto_esp_aes_gcm_256_decrypt))
+		priv->nisp->caps.versions |= 1 << PSP_VERSION_HDR0_AES_GCM_256;
+
+	priv->nisp->psp = psp_dev_create(priv->netdev, &mlx5_psp_ops,
+					 &priv->nisp->caps, NULL);
+	if (IS_ERR(priv->nisp->psp))
+		mlx5_core_err(priv->mdev, "PSP failed to register due to %pe\n",
+			      priv->nisp->psp);
+}
+
+int mlx5e_nisp_init(struct mlx5e_priv *priv)
+{
+	struct mlx5_core_dev *mdev = priv->mdev;
+	struct mlx5e_nisp *nisp;
+
+	if (!mlx5_is_nisp_device(mdev)) {
+		mlx5_core_dbg(mdev, "NISP offload not supported\n");
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
+		mlx5_core_dbg(mdev, "NISP LSO not supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	nisp = kzalloc(sizeof(*nisp), GFP_KERNEL);
+	if (!nisp)
+		return -ENOMEM;
+
+	priv->nisp = nisp;
+	mlx5_core_dbg(priv->mdev, "NISP attached to netdevice\n");
+	return 0;
+}
+
+void mlx5e_nisp_cleanup(struct mlx5e_priv *priv)
+{
+	struct mlx5e_nisp *nisp = priv->nisp;
+
+	if (!nisp)
+		return;
+
+	priv->nisp = NULL;
+	kfree(nisp);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp.h
new file mode 100644
index 000000000000..93eaea8b6f77
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#ifndef __MLX5E_ACCEL_NISP_H__
+#define __MLX5E_ACCEL_NISP_H__
+#if IS_ENABLED(CONFIG_MLX5_EN_PSP)
+#include <net/psp/types.h>
+#include "en.h"
+
+struct mlx5e_nisp {
+	struct psp_dev *psp;
+	struct psp_dev_caps caps;
+};
+
+struct nisp_key_spi {
+	u32 spi;
+	__be32 key[PSP_MAX_KEY / sizeof(u32)];
+	u16 keysz;
+};
+
+static inline bool mlx5_is_nisp_device(struct mlx5_core_dev *mdev)
+{
+	if (!MLX5_CAP_GEN(mdev, psp))
+		return false;
+
+	if (!MLX5_CAP_NISP(mdev, nisp_crypto_esp_aes_gcm_128_encrypt) ||
+	    !MLX5_CAP_NISP(mdev, nisp_crypto_esp_aes_gcm_128_decrypt))
+		return false;
+
+	return true;
+}
+
+void mlx5e_nisp_register(struct mlx5e_priv *priv);
+void mlx5e_nisp_unregister(struct mlx5e_priv *priv);
+int mlx5e_nisp_init(struct mlx5e_priv *priv);
+void mlx5e_nisp_cleanup(struct mlx5e_priv *priv);
+int mlx5e_nisp_rotate_key(struct mlx5_core_dev *mdev);
+int mlx5e_nisp_generate_key_spi(struct mlx5_core_dev *mdev,
+				enum mlx5_nisp_gen_spi_in_key_size keysz,
+				unsigned int keysz_bytes,
+				struct nisp_key_spi *keys);
+#else
+static inline bool mlx5_is_nisp_device(struct mlx5_core_dev *mdev)
+{
+	return false;
+}
+
+static inline void mlx5e_nisp_register(struct mlx5e_priv *priv) { }
+static inline void mlx5e_nisp_unregister(struct mlx5e_priv *priv) { }
+static inline int mlx5e_nisp_init(struct mlx5e_priv *priv) { return 0; }
+static inline void mlx5e_nisp_cleanup(struct mlx5e_priv *priv) { }
+#endif /* CONFIG_MLX5_EN_PSP */
+#endif /* __MLX5E_ACCEL_NISP_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_offload.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_offload.c
new file mode 100644
index 000000000000..fc3268884dc9
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_offload.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+#include <linux/workqueue.h>
+#include <net/psp/types.h>
+#include "mlx5_core.h"
+#include "en_accel/nisp.h"
+
+int mlx5e_nisp_rotate_key(struct mlx5_core_dev *mdev)
+{
+	u32 in[MLX5_ST_SZ_DW(nisp_rotate_key_in)] = {};
+	u32 out[MLX5_ST_SZ_DW(nisp_rotate_key_out)];
+
+	MLX5_SET(nisp_rotate_key_in, in, opcode,
+		 MLX5_CMD_OP_NISP_ROTATE_KEY);
+
+	return mlx5_cmd_exec(mdev, in, sizeof(in), out, sizeof(out));
+}
+
+int mlx5e_nisp_generate_key_spi(struct mlx5_core_dev *mdev,
+				enum mlx5_nisp_gen_spi_in_key_size keysz,
+				unsigned int keysz_bytes,
+				struct nisp_key_spi *keys)
+{
+	u32 in[MLX5_ST_SZ_DW(nisp_gen_spi_in)] = {};
+	int err, outlen, i;
+	void *out, *outkey;
+
+	WARN_ON_ONCE(keysz_bytes > PSP_MAX_KEY);
+
+	outlen = MLX5_ST_SZ_BYTES(nisp_gen_spi_out) + MLX5_ST_SZ_BYTES(key_spi);
+	out = kzalloc(outlen, GFP_KERNEL);
+	if (!out)
+		return -ENOMEM;
+
+	MLX5_SET(nisp_gen_spi_in, in, opcode, MLX5_CMD_OP_NISP_GEN_SPI);
+	MLX5_SET(nisp_gen_spi_in, in, key_size, keysz);
+	MLX5_SET(nisp_gen_spi_in, in, num_of_spi, 1);
+	err = mlx5_cmd_exec(mdev, in, sizeof(in), out, outlen);
+	if (err)
+		goto out;
+
+	outkey = MLX5_ADDR_OF(nisp_gen_spi_out, out, key_spi);
+	keys->keysz = keysz_bytes * BITS_PER_BYTE;
+	keys->spi = MLX5_GET(key_spi, outkey, spi);
+	for (i = 0; i < keysz_bytes / sizeof(*keys->key); ++i)
+		keys->key[i] = cpu_to_be32(MLX5_GET(key_spi,
+						    outkey + (32 - keysz_bytes), key[i]));
+
+out:
+	kfree(out);
+	return err;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index ffe8919494d5..4948e19c3f3f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -49,6 +49,7 @@
 #include "en_tc.h"
 #include "en_rep.h"
 #include "en_accel/ipsec.h"
+#include "en_accel/nisp.h"
 #include "en_accel/macsec.h"
 #include "en_accel/en_accel.h"
 #include "en_accel/ktls.h"
@@ -5506,6 +5507,7 @@ static int mlx5e_nic_init(struct mlx5_core_dev *mdev,
 	if (take_rtnl)
 		rtnl_lock();
 
+	mlx5e_nisp_register(priv);
 	/* update XDP supported features */
 	mlx5e_set_xdp_feature(netdev);
 
@@ -5518,6 +5520,7 @@ static int mlx5e_nic_init(struct mlx5_core_dev *mdev,
 static void mlx5e_nic_cleanup(struct mlx5e_priv *priv)
 {
 	mlx5e_health_destroy_reporters(priv);
+	mlx5e_nisp_unregister(priv);
 	mlx5e_ktls_cleanup(priv);
 	mlx5e_fs_cleanup(priv->fs);
 	debugfs_remove_recursive(priv->dfs_root);
@@ -5645,6 +5648,10 @@ static void mlx5e_nic_enable(struct mlx5e_priv *priv)
 	if (err)
 		mlx5_core_err(mdev, "MACsec initialization failed, %d\n", err);
 
+	err = mlx5e_nisp_init(priv);
+	if (err)
+		mlx5_core_err(mdev, "PSP initialization failed, %d\n", err);
+
 	/* Marking the link as currently not needed by the Driver */
 	if (!netif_running(netdev))
 		mlx5e_modify_admin_state(mdev, MLX5_PORT_DOWN);
@@ -5702,6 +5709,7 @@ static void mlx5e_nic_disable(struct mlx5e_priv *priv)
 	mlx5e_disable_async_events(priv);
 	mlx5_lag_remove_netdev(mdev, priv->netdev);
 	mlx5_vxlan_reset_to_default(mdev->vxlan);
+	mlx5e_nisp_cleanup(priv);
 	mlx5e_macsec_cleanup(priv);
 	mlx5e_ipsec_cleanup(priv);
 }
@@ -6337,6 +6345,7 @@ static void _mlx5e_remove(struct auxiliary_device *adev)
 
 	mlx5_core_uplink_netdev_set(mdev, NULL);
 	mlx5e_dcbnl_delete_app(priv);
+	mlx5e_nisp_unregister(priv);
 	unregister_netdev(priv->netdev);
 	_mlx5e_suspend(adev);
 	priv->profile->cleanup(priv);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw.c b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
index 2d95a9b7b44e..eee318d64d98 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
@@ -280,6 +280,12 @@ int mlx5_query_hca_caps(struct mlx5_core_dev *dev)
 			return err;
 	}
 
+	if (MLX5_CAP_GEN(dev, psp)) {
+		err = mlx5_core_get_caps(dev, MLX5_CAP_NISP);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 331ce47f51a1..8625d593ed89 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -74,6 +74,7 @@
 #include "mlx5_irq.h"
 #include "hwmon.h"
 #include "lag/lag.h"
+#include "nisp.h"
 
 MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
 MODULE_DESCRIPTION("Mellanox 5th generation network adapters (ConnectX series) core driver");
@@ -1013,6 +1014,7 @@ static int mlx5_init_once(struct mlx5_core_dev *dev)
 
 	dev->vxlan = mlx5_vxlan_create(dev);
 	dev->geneve = mlx5_geneve_create(dev);
+	dev->nisp = mlx5_nisp_create(dev);
 
 	err = mlx5_init_rl_table(dev);
 	if (err) {
@@ -1095,6 +1097,7 @@ static int mlx5_init_once(struct mlx5_core_dev *dev)
 err_rl_cleanup:
 	mlx5_cleanup_rl_table(dev);
 err_tables_cleanup:
+	mlx5_nisp_destroy(dev->nisp);
 	mlx5_geneve_destroy(dev->geneve);
 	mlx5_vxlan_destroy(dev->vxlan);
 	mlx5_cleanup_clock(dev);
@@ -1129,6 +1132,7 @@ static void mlx5_cleanup_once(struct mlx5_core_dev *dev)
 	mlx5_sriov_cleanup(dev);
 	mlx5_mpfs_cleanup(dev);
 	mlx5_cleanup_rl_table(dev);
+	mlx5_nisp_destroy(dev->nisp);
 	mlx5_geneve_destroy(dev->geneve);
 	mlx5_vxlan_destroy(dev->vxlan);
 	mlx5_cleanup_clock(dev);
@@ -1763,6 +1767,7 @@ static const int types[] = {
 	MLX5_CAP_VDPA_EMULATION,
 	MLX5_CAP_IPSEC,
 	MLX5_CAP_PORT_SELECTION,
+	MLX5_CAP_NISP,
 	MLX5_CAP_MACSEC,
 	MLX5_CAP_ADV_VIRTUALIZATION,
 	MLX5_CAP_CRYPTO,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/nisp.c b/drivers/net/ethernet/mellanox/mlx5/core/nisp.c
new file mode 100644
index 000000000000..f82734df8bf0
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/nisp.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#include "nisp.h"
+
+struct mlx5_nisp *mlx5_nisp_create(struct mlx5_core_dev *mdev)
+{
+	struct mlx5_nisp *nisp = kzalloc(sizeof(*nisp), GFP_KERNEL);
+
+	if (!nisp)
+		return ERR_PTR(-ENOMEM);
+
+	nisp->mdev = mdev;
+
+	return nisp;
+}
+
+void mlx5_nisp_destroy(struct mlx5_nisp *nisp)
+{
+	if (IS_ERR_OR_NULL(nisp))
+		return;
+
+	kfree(nisp);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/nisp.h b/drivers/net/ethernet/mellanox/mlx5/core/nisp.h
new file mode 100644
index 000000000000..c15e50e7ada7
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/nisp.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#ifndef __MLX5_NISP_H__
+#define __MLX5_NISP_H__
+#include <linux/mlx5/driver.h>
+
+struct mlx5_nisp {
+	struct mlx5_core_dev *mdev;
+};
+
+struct mlx5_nisp *mlx5_nisp_create(struct mlx5_core_dev *mdev);
+void mlx5_nisp_destroy(struct mlx5_nisp *nisp);
+
+#endif /* __MLX5_NISP_H__ */
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index d7bb31d9a446..6c00c78bad53 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -1223,6 +1223,7 @@ enum mlx5_cap_type {
 	MLX5_CAP_DEV_EVENT = 0x14,
 	MLX5_CAP_IPSEC,
 	MLX5_CAP_CRYPTO = 0x1a,
+	MLX5_CAP_NISP = 0x1e,
 	MLX5_CAP_MACSEC = 0x1f,
 	MLX5_CAP_GENERAL_2 = 0x20,
 	MLX5_CAP_PORT_SELECTION = 0x25,
@@ -1435,6 +1436,9 @@ enum mlx5_qcam_feature_groups {
 #define MLX5_CAP_MACSEC(mdev, cap)\
 	MLX5_GET(macsec_cap, (mdev)->caps.hca[MLX5_CAP_MACSEC]->cur, cap)
 
+#define MLX5_CAP_NISP(mdev, cap)\
+	MLX5_GET(nisp_cap, (mdev)->caps.hca[MLX5_CAP_NISP]->cur, cap)
+
 enum {
 	MLX5_CMD_STAT_OK			= 0x0,
 	MLX5_CMD_STAT_INT_ERR			= 0x1,
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index bf9324a31ae9..8d6060866163 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -515,6 +515,7 @@ struct mlx5_sf_dev_table;
 struct mlx5_sf_hw_table;
 struct mlx5_sf_table;
 struct mlx5_crypto_dek_priv;
+struct mlx5_nisp;
 
 struct mlx5_rate_limit {
 	u32			rate;
@@ -824,6 +825,7 @@ struct mlx5_core_dev {
 #endif
 	u64 num_ipsec_offloads;
 	struct mlx5_sd          *sd;
+	struct mlx5_nisp        *nisp;
 };
 
 struct mlx5_db {
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index f468763478ae..a48e6a293602 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -309,6 +309,8 @@ enum {
 	MLX5_CMD_OP_CREATE_UMEM                   = 0xa08,
 	MLX5_CMD_OP_DESTROY_UMEM                  = 0xa0a,
 	MLX5_CMD_OP_SYNC_STEERING                 = 0xb00,
+	MLX5_CMD_OP_NISP_GEN_SPI                  = 0xb10,
+	MLX5_CMD_OP_NISP_ROTATE_KEY               = 0xb11,
 	MLX5_CMD_OP_QUERY_VHCA_STATE              = 0xb0d,
 	MLX5_CMD_OP_MODIFY_VHCA_STATE             = 0xb0e,
 	MLX5_CMD_OP_SYNC_CRYPTO                   = 0xb12,
@@ -477,12 +479,14 @@ struct mlx5_ifc_flow_table_prop_layout_bits {
 	u8         execute_aso[0x1];
 	u8         reserved_at_47[0x19];
 
-	u8         reserved_at_60[0x2];
+	u8         reformat_l2_to_l3_nisp_tunnel[0x1];
+	u8         reformat_l3_nisp_tunnel_to_l2[0x1];
 	u8         reformat_insert[0x1];
 	u8         reformat_remove[0x1];
 	u8         macsec_encrypt[0x1];
 	u8         macsec_decrypt[0x1];
-	u8         reserved_at_66[0x2];
+	u8         nisp_encrypt[0x1];
+	u8         nisp_decrypt[0x1];
 	u8         reformat_add_macsec[0x1];
 	u8         reformat_remove_macsec[0x1];
 	u8         reserved_at_6a[0xe];
@@ -670,7 +674,7 @@ struct mlx5_ifc_fte_match_set_misc2_bits {
 
 	u8         metadata_reg_a[0x20];
 
-	u8         reserved_at_1a0[0x8];
+	u8         nisp_syndrome[0x8];
 
 	u8         macsec_syndrome[0x8];
 	u8         ipsec_syndrome[0x8];
@@ -1093,7 +1097,8 @@ struct mlx5_ifc_per_protocol_networking_offload_caps_bits {
 	u8         tunnel_stateless_ip_over_ip_tx[0x1];
 	u8         reserved_at_2e[0x2];
 	u8         max_vxlan_udp_ports[0x8];
-	u8         reserved_at_38[0x6];
+	u8         swp_csum_l4_partial[0x1];
+	u8         reserved_at_39[0x5];
 	u8         max_geneve_opt_len[0x1];
 	u8         tunnel_stateless_geneve_rx[0x1];
 
@@ -1390,6 +1395,19 @@ struct mlx5_ifc_macsec_cap_bits {
 	u8    reserved_at_40[0x7c0];
 };
 
+struct mlx5_ifc_nisp_cap_bits {
+	u8         reserved_at_0[0x1];
+	u8         nisp_crypto_offload[0x1]; /* Set by the driver */
+	u8         reserved_at_2[0x1];
+	u8         nisp_crypto_esp_aes_gcm_256_encrypt[0x1];
+	u8         nisp_crypto_esp_aes_gcm_128_encrypt[0x1];
+	u8         nisp_crypto_esp_aes_gcm_256_decrypt[0x1];
+	u8         nisp_crypto_esp_aes_gcm_128_decrypt[0x1];
+	u8         reserved_at_7[0x4];
+	u8         log_max_num_of_nisp_spi[0x5];
+	u8         reserved_at_10[0x7f0];
+};
+
 enum {
 	MLX5_WQ_TYPE_LINKED_LIST  = 0x0,
 	MLX5_WQ_TYPE_CYCLIC       = 0x1,
@@ -1521,7 +1539,7 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         reg_c_preserve[0x1];
 	u8         reserved_at_aa[0x1];
 	u8         log_max_srq[0x5];
-	u8         reserved_at_b0[0x1];
+	u8	   reserved_at_b0[0x1];
 	u8         uplink_follow[0x1];
 	u8         ts_cqe_to_dest_cqn[0x1];
 	u8         reserved_at_b3[0x6];
@@ -1744,7 +1762,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         reserved_at_280[0x10];
 	u8         max_wqe_sz_sq[0x10];
 
-	u8         reserved_at_2a0[0x10];
+	u8         reserved_at_2a0[0xa];
+	u8         psp[0x1];
+	u8         reserved_at_2b1[0x5];
 	u8         max_wqe_sz_rq[0x10];
 
 	u8         max_flow_counter_31_16[0x10];
@@ -3519,6 +3539,7 @@ union mlx5_ifc_hca_cap_union_bits {
 	struct mlx5_ifc_macsec_cap_bits macsec_cap;
 	struct mlx5_ifc_crypto_cap_bits crypto_cap;
 	struct mlx5_ifc_ipsec_cap_bits ipsec_cap;
+	struct mlx5_ifc_nisp_cap_bits nisp_cap;
 	u8         reserved_at_0[0x8000];
 };
 
@@ -3548,6 +3569,7 @@ enum {
 enum {
 	MLX5_FLOW_CONTEXT_ENCRYPT_DECRYPT_TYPE_IPSEC   = 0x0,
 	MLX5_FLOW_CONTEXT_ENCRYPT_DECRYPT_TYPE_MACSEC  = 0x1,
+	MLX5_FLOW_CONTEXT_ENCRYPT_DECRYPT_TYPE_NISP    = 0x2,
 };
 
 struct mlx5_ifc_vlan_bits {
@@ -6747,6 +6769,8 @@ enum mlx5_reformat_ctx_type {
 	MLX5_REFORMAT_TYPE_DEL_ESP_TRANSPORT_OVER_UDP = 0xa,
 	MLX5_REFORMAT_TYPE_ADD_ESP_TRANSPORT_OVER_IPV6 = 0xb,
 	MLX5_REFORMAT_TYPE_ADD_ESP_TRANSPORT_OVER_UDPV6 = 0xc,
+	MLX5_REFORMAT_TYPE_ADD_NISP_TUNNEL = 0xd,
+	MLX5_REFORMAT_TYPE_DEL_NISP_TUNNEL = 0xe,
 	MLX5_REFORMAT_TYPE_INSERT_HDR = 0xf,
 	MLX5_REFORMAT_TYPE_REMOVE_HDR = 0x10,
 	MLX5_REFORMAT_TYPE_ADD_MACSEC = 0x11,
@@ -6873,6 +6897,7 @@ enum {
 	MLX5_ACTION_IN_FIELD_IPSEC_SYNDROME    = 0x5D,
 	MLX5_ACTION_IN_FIELD_OUT_EMD_47_32     = 0x6F,
 	MLX5_ACTION_IN_FIELD_OUT_EMD_31_0      = 0x70,
+	MLX5_ACTION_IN_FIELD_NISP_SYNDROME     = 0x71,
 };
 
 struct mlx5_ifc_alloc_modify_header_context_out_bits {
@@ -12452,6 +12477,7 @@ enum {
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_PURPOSE_TLS = 0x1,
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_PURPOSE_IPSEC = 0x2,
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_PURPOSE_MACSEC = 0x4,
+	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_PURPOSE_NISP = 0x6,
 };
 
 struct mlx5_ifc_tls_static_params_bits {
@@ -12786,4 +12812,64 @@ struct mlx5_ifc_msees_reg_bits {
 	u8         reserved_at_80[0x180];
 };
 
+struct mlx5_ifc_nisp_rotate_key_in_bits {
+	u8         opcode[0x10];
+	u8         uid[0x10];
+
+	u8         reserved_at_20[0x10];
+	u8         op_mod[0x10];
+
+	u8         reserved_at_40[0x40];
+};
+
+struct mlx5_ifc_nisp_rotate_key_out_bits {
+	u8         status[0x8];
+	u8         reserved_at_8[0x18];
+
+	u8         syndrome[0x20];
+
+	u8         reserved_at_40[0x40];
+};
+
+enum mlx5_nisp_gen_spi_in_key_size {
+	MLX5_NISP_GEN_SPI_IN_KEY_SIZE_128 = 0x0,
+	MLX5_NISP_GEN_SPI_IN_KEY_SIZE_256 = 0x1,
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
+struct mlx5_ifc_nisp_gen_spi_in_bits {
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
+struct mlx5_ifc_nisp_gen_spi_out_bits {
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
2.45.0


