Return-Path: <netdev+bounces-175725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4C1A6743A
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 13:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CD47188DA7D
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 12:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B3D20371E;
	Tue, 18 Mar 2025 12:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="rDZ3x3fZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FEB8479
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 12:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742302042; cv=none; b=ICDe1IRaQ94DlfAjln2fF10k9ijbzuEJakW7DcNRSEOUsn0YbSD3thU1JvTjL08SKiUPGI/aOC2lMkG+YG62aRyEqCNGPhwDJ0NvXrth8n6BVALa30SIEQXWZqsZfbAQlGgUwt/SozrMQDwB5jwRd7fZYsYIGbbCP/zKAkBA7co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742302042; c=relaxed/simple;
	bh=BKjkTHNoGnO6ep4k45vmsmyqSxCl1pyCzDhuRzouQiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2VlToZ2R5cS9bZ+nqiZn0VgPRPXsBljBpLplipBDJWw3P5Yru5b93ws1PzG7NtjdRaDSFiTeS21cMs58uNea5isUr5kvDq3GjqORcZEzfz0koepKoren4FD9yx0xpYOL4CYDNU+SQlfa8GpZw+ywrAAzE9AQBLfvk7wiwC/H9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=rDZ3x3fZ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3912e96c8e8so3603411f8f.2
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 05:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1742302039; x=1742906839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4Xjk7L7Aa3ZD+6evIPcxOMobYyFCNgXZrLwQChwWoY=;
        b=rDZ3x3fZ/dK4uUtibwMdzZeH1phhg5MPsRr3nTi+ab4Hpe+HSL0sjA+h1gjt4QzP43
         iQVlXb8UZsklVmySlklUph+TMZ08fO0qwXEIh7Vljp6De5M5ict+tyQ7Pgiwl0DP9XBN
         trOHVdyrpVW+1S4Zkwskz2C9gK3fD4qcaB0oeahA89Geol+e3RVoVUxL/4EOl93N7WzM
         qo2qcaZlCgBpwa7IQEszSiuSQ4jxtzPBpZQ27iLwQG240IGeFmn3ySy3HUdr6i4/j7xa
         UI0sANeDA7nrI04sxyGX37xO3ANbJELIkSg25uVJbLjAm8bJBBFeDCPNoB/KETTUMbWP
         ijsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742302039; x=1742906839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4Xjk7L7Aa3ZD+6evIPcxOMobYyFCNgXZrLwQChwWoY=;
        b=eGaEG227JKhyh3tfVe/wkpTO7aOXcYBIN3b2bCsSr/Rx1xFA6M4+790gwvQ96nhhkS
         Vqe7BE2ZJ2Ci0qhl1/h5qBsuccWBAsrCX/THAu4KbBmlJNl09te+06PGIhRGszh0TNV5
         lrpTcLFOMPNvSduFD/JBZXM/Da+nL166Xj/JmK1IPgQPlNsk6pD38A07XF0Ox8dbB/bW
         JJb/zGwdYzRme7MJjK7Hz/lcKBJevh0o9Kwcrrx+QYUaksk7YzbhTbuSm+/WYjVg3QmA
         9C8ABSG4MgNIybO8lHPIBG+nR0/O9e9o7Uwnav0Na8g/bTqqgL1tlLlrGt1sGtGfHEbz
         bWcw==
X-Gm-Message-State: AOJu0YzpmzKyTOM0nv4pWRq+uQJJWftBp5z9BoK4RChTYBqg626ciO1G
	o4e8IK50sbo91/JPCu6QFMw6XEOfhmltmHRMhdmZAP1PnlFJbAaZoFX8OS++4xU57ydRW8TfH3O
	g
X-Gm-Gg: ASbGncsXQRZTCcY1IEzVx7g3QfsyDLFZZ2BON702pUxY6XP5JRRMgImNLL6zRp7r8gC
	p31cq2TdbZiYbka8/6gSN7Gj+/f/cqV4TXk8K+sqhcg87OPEGYx9IamTw2xGFfh7jNrjB+p0Mpf
	9iDmyYfSvjxchN0/sXZTHhtN7r2WaoCn0a/aZqB6E7cF+h8HCZUBwD9CAwJVgsF1IhFUcZPVtF2
	/BDCRWNbhMTyOsgbwHPom6SAKG8PgEl3MukkBsSB3+KC8rGsDskwWhOuyQUUfuyEWwlY5tQa6Ug
	BvQvw6cHSnMInEyGMfflDE+MYQIpVog8nVe1Fw==
X-Google-Smtp-Source: AGHT+IHnR7jDXyWrgbiXvOOTW/T1A0mYmAbSnDDdEHilUrSZCaoS7fkxRgcOgCh9xNxydDVWSr4qew==
X-Received: by 2002:a5d:64cc:0:b0:390:df75:ddc4 with SMTP id ffacd0b85a97d-3971f9e490emr17290602f8f.44.1742302038778;
        Tue, 18 Mar 2025 05:47:18 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb3188e8sm18386842f8f.65.2025.03.18.05.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 05:47:18 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	andrew+netdev@lunn.ch,
	dakr@kernel.org,
	rafael@kernel.org,
	gregkh@linuxfoundation.org,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	cratiu@nvidia.com,
	jacob.e.keller@intel.com,
	konrad.knitter@intel.com,
	cjubran@nvidia.com
Subject: [PATCH net-next RFC 2/3] net/mlx5: Introduce shared devlink instance for PFs on same chip
Date: Tue, 18 Mar 2025 13:47:05 +0100
Message-ID: <20250318124706.94156-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318124706.94156-1-jiri@resnulli.us>
References: <20250318124706.94156-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Multiple PFS may reside on the same physical chip, running a single
firmware. Some of the resources and configurations may be shared among
these PFs. Currently, there is not good object to pin the configuration
knobs on.

Introduce a shared devlink, instantiated upon probe of the first PF,
removed during remove of the last PF. Back this shared devlink instance
by faux device, as there is no PCI device related to it.

Make the PF devlink instances nested in this shared devlink instance.

Example:

$ devlink dev
pci/0000:08:00.0:
  nested_devlink:
    auxiliary/mlx5_core.eth.0
faux/mlx5_core_83013c12b77faa1a30000c82a1045c91:
  nested_devlink:
    pci/0000:08:00.0
    pci/0000:08:00.1
auxiliary/mlx5_core.eth.0
pci/0000:08:00.1:
  nested_devlink:
    auxiliary/mlx5_core.eth.1
auxiliary/mlx5_core.eth.1

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   4 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    |  18 +++
 .../ethernet/mellanox/mlx5/core/sh_devlink.c  | 150 ++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/sh_devlink.h  |  10 ++
 include/linux/mlx5/driver.h                   |   5 +
 5 files changed, 185 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index 568bbe5f83f5..510850b6e6e2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -16,8 +16,8 @@ mlx5_core-y :=	main.o cmd.o debugfs.o fw.o eq.o uar.o pagealloc.o \
 		transobj.o vport.o sriov.o fs_cmd.o fs_core.o pci_irq.o \
 		fs_counters.o fs_ft_pool.o rl.o lag/debugfs.o lag/lag.o dev.o events.o wq.o lib/gid.o \
 		lib/devcom.o lib/pci_vsc.o lib/dm.o lib/fs_ttc.o diag/fs_tracepoint.o \
-		diag/fw_tracer.o diag/crdump.o devlink.o diag/rsc_dump.o diag/reporter_vnic.o \
-		fw_reset.o qos.o lib/tout.o lib/aso.o wc.o fs_pool.o
+		diag/fw_tracer.o diag/crdump.o devlink.o sh_devlink.o diag/rsc_dump.o \
+		diag/reporter_vnic.o fw_reset.o qos.o lib/tout.o lib/aso.o wc.o fs_pool.o
 
 #
 # Netdev basic
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 710633d5fdbe..e1217a8bf4db 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -74,6 +74,7 @@
 #include "mlx5_irq.h"
 #include "hwmon.h"
 #include "lag/lag.h"
+#include "sh_devlink.h"
 
 MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
 MODULE_DESCRIPTION("Mellanox 5th generation network adapters (ConnectX series) core driver");
@@ -1554,10 +1555,17 @@ int mlx5_init_one(struct mlx5_core_dev *dev)
 	int err;
 
 	devl_lock(devlink);
+	if (dev->shd) {
+		err = devl_nested_devlink_set(priv_to_devlink(dev->shd),
+					      devlink);
+		if (err)
+			goto unlock;
+	}
 	devl_register(devlink);
 	err = mlx5_init_one_devl_locked(dev);
 	if (err)
 		devl_unregister(devlink);
+unlock:
 	devl_unlock(devlink);
 	return err;
 }
@@ -1998,6 +2006,13 @@ static int probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto pci_init_err;
 	}
 
+	err = mlx5_shd_init(dev);
+	if (err) {
+		mlx5_core_err(dev, "mlx5_shd_init failed with error code %d\n",
+			      err);
+		goto shd_init_err;
+	}
+
 	err = mlx5_init_one(dev);
 	if (err) {
 		mlx5_core_err(dev, "mlx5_init_one failed with error code %d\n",
@@ -2009,6 +2024,8 @@ static int probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 err_init_one:
+	mlx5_shd_uninit(dev);
+shd_init_err:
 	mlx5_pci_close(dev);
 pci_init_err:
 	mlx5_mdev_uninit(dev);
@@ -2030,6 +2047,7 @@ static void remove_one(struct pci_dev *pdev)
 	mlx5_drain_health_wq(dev);
 	mlx5_sriov_disable(pdev, false);
 	mlx5_uninit_one(dev);
+	mlx5_shd_uninit(dev);
 	mlx5_pci_close(dev);
 	mlx5_mdev_uninit(dev);
 	mlx5_adev_idx_free(dev->priv.adev_idx);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
new file mode 100644
index 000000000000..671a3442525b
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#include <linux/device/faux.h>
+#include <linux/mlx5/driver.h>
+#include <linux/mlx5/vport.h>
+
+#include "sh_devlink.h"
+
+static LIST_HEAD(shd_list);
+static DEFINE_MUTEX(shd_mutex); /* Protects shd_list and shd->list */
+
+/* This structure represents a shared devlink instance,
+ * there is one created for PF group of the same chip.
+ */
+struct mlx5_shd {
+	/* Node in shd list */
+	struct list_head list;
+	/* Serial number of the chip */
+	const char *sn;
+	/* List of per-PF dev instances. */
+	struct list_head dev_list;
+	/* Related faux device */
+	struct faux_device *faux_dev;
+};
+
+static const struct devlink_ops mlx5_shd_ops = {
+};
+
+static int mlx5_shd_faux_probe(struct faux_device *faux_dev)
+{
+	struct devlink *devlink;
+	struct mlx5_shd *shd;
+
+	devlink = devlink_alloc(&mlx5_shd_ops, sizeof(struct mlx5_shd), &faux_dev->dev);
+	if (!devlink)
+		return -ENOMEM;
+	shd = devlink_priv(devlink);
+	faux_device_set_drvdata(faux_dev, shd);
+
+	devl_lock(devlink);
+	devl_register(devlink);
+	devl_unlock(devlink);
+	return 0;
+}
+
+static void mlx5_shd_faux_remove(struct faux_device *faux_dev)
+{
+	struct mlx5_shd *shd = faux_device_get_drvdata(faux_dev);
+	struct devlink *devlink = priv_to_devlink(shd);
+
+	devl_lock(devlink);
+	devl_unregister(devlink);
+	devl_unlock(devlink);
+	devlink_free(devlink);
+}
+
+static const struct faux_device_ops mlx5_shd_faux_ops = {
+	.probe = mlx5_shd_faux_probe,
+	.remove = mlx5_shd_faux_remove,
+};
+
+static struct mlx5_shd *mlx5_shd_create(const char *sn)
+{
+	struct faux_device *faux_dev;
+	struct mlx5_shd *shd;
+
+	faux_dev = faux_device_create(THIS_MODULE, sn, NULL, &mlx5_shd_faux_ops);
+	if (!faux_dev)
+		return NULL;
+	shd = faux_device_get_drvdata(faux_dev);
+	if (!shd)
+		return NULL;
+	list_add_tail(&shd->list, &shd_list);
+	shd->sn = sn;
+	INIT_LIST_HEAD(&shd->dev_list);
+	shd->faux_dev = faux_dev;
+	return shd;
+}
+
+static void mlx5_shd_destroy(struct mlx5_shd *shd)
+{
+	list_del(&shd->list);
+	kfree(shd->sn);
+	faux_device_destroy(shd->faux_dev);
+}
+
+int mlx5_shd_init(struct mlx5_core_dev *dev)
+{
+	u8 *vpd_data __free(kfree) = NULL;
+	struct pci_dev *pdev = dev->pdev;
+	unsigned int vpd_size, kw_len;
+	struct mlx5_shd *shd;
+	const char *sn;
+	char *end;
+	int start;
+	int err;
+
+	if (!mlx5_core_is_pf(dev))
+		return 0;
+
+	vpd_data = pci_vpd_alloc(pdev, &vpd_size);
+	if (IS_ERR(vpd_data)) {
+		err = PTR_ERR(vpd_data);
+		return err == -ENODEV ? 0 : err;
+	}
+	start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size, "V3", &kw_len);
+	if (start < 0) {
+		/* Fall-back to SN for older devices. */
+		start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
+						     PCI_VPD_RO_KEYWORD_SERIALNO, &kw_len);
+		if (start < 0)
+			return -ENOENT;
+	}
+	sn = kstrndup(vpd_data + start, kw_len, GFP_KERNEL);
+	if (!sn)
+		return -ENOMEM;
+	end = strchrnul(sn, ' ');
+	*end = '\0';
+
+	guard(mutex)(&shd_mutex);
+	list_for_each_entry(shd, &shd_list, list) {
+		if (!strcmp(shd->sn, sn)) {
+			kfree(sn);
+			goto found;
+		}
+	}
+	shd = mlx5_shd_create(sn);
+	if (!shd) {
+		kfree(sn);
+		return -ENOMEM;
+	}
+found:
+	list_add_tail(&dev->shd_list, &shd->dev_list);
+	dev->shd = shd;
+	return 0;
+}
+
+void mlx5_shd_uninit(struct mlx5_core_dev *dev)
+{
+	struct mlx5_shd *shd = dev->shd;
+
+	if (!dev->shd)
+		return;
+
+	guard(mutex)(&shd_mutex);
+	list_del(&dev->shd_list);
+	if (list_empty(&shd->dev_list))
+		mlx5_shd_destroy(shd);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
new file mode 100644
index 000000000000..67df03e3c72e
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#ifndef __MLX5_SH_DEVLINK_H__
+#define __MLX5_SH_DEVLINK_H__
+
+int mlx5_shd_init(struct mlx5_core_dev *dev);
+void mlx5_shd_uninit(struct mlx5_core_dev *dev);
+
+#endif /* __MLX5_SH_DEVLINK_H__ */
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 46bd7550adf8..78f1f034568f 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -721,6 +721,8 @@ enum mlx5_wc_state {
 	MLX5_WC_STATE_SUPPORTED,
 };
 
+struct mlx5_shd;
+
 struct mlx5_core_dev {
 	struct device *device;
 	enum mlx5_coredev_type coredev_type;
@@ -783,6 +785,9 @@ struct mlx5_core_dev {
 	enum mlx5_wc_state wc_state;
 	/* sync write combining state */
 	struct mutex wc_state_lock;
+	/* node in shared devlink list */
+	struct list_head shd_list;
+	struct mlx5_shd *shd;
 };
 
 struct mlx5_db {
-- 
2.48.1


