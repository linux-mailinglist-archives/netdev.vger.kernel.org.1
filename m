Return-Path: <netdev+bounces-198953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2371FADE6CC
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 11:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88F497A9467
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 09:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7EC2874FD;
	Wed, 18 Jun 2025 09:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AuZWoe7C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84842874E3
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 09:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750238675; cv=none; b=T/v5G20vw9FpCZI5UA0Dgdmih8Iuo7VUYuwaHpLhEWyi2nZa1MIlUEmi61SyigL1T/FpDBU/GzfemT0PAiEvDRyJc2G3buDIg6ClmgrDJBwYEMeFgpQvOJ71nDYQFiaupCAczJDuV7lRWEgOzmLUugYv9aevQP0iFIbjQNfSNzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750238675; c=relaxed/simple;
	bh=79YFGMxYLWmqquINjWc4mpwHsCiqr4FvH5nLdIWFYSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tm6gs7Flx8yQo+Gkhvu5INpbnB8HpPw4Bd4Q+kHmKJvUY9a2lhfNZOdh11X18bs9CgoK+nzRHMRU2eHC0tplENdnNKkDFvBxs3od/NbAudPUZtoIp4M+HRyVhjmwGP+gjYWxff3mxr+Umj/anpyypDplmGgfskKtGpzRfT8+77k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AuZWoe7C; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b31befde0a0so934095a12.0
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 02:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1750238672; x=1750843472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCjoisodGfLD1729moLpX5gfUPaB6yTAZtYt5kbqKVQ=;
        b=AuZWoe7CmCEzI99bnGDQeeg9N+tPDUD1H8CEtsYSfW9lPUAkHuNPtTLBwV+wmkwvof
         5glI8PguVa5bSkAbV+qPwI12qhnkALfdhvw/73tSlU4DSmOmcLMsg4cldLJzuyqVYQJ9
         hC3gtri4PXhZSmesBBU0vDU2CBhsL3q0XDFMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750238672; x=1750843472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MCjoisodGfLD1729moLpX5gfUPaB6yTAZtYt5kbqKVQ=;
        b=owiI815o9om4oFbzd/2r+z8qMVStcgcMj5ItQMaUA06UcpWo4ZEm4OL9H9sBL5MFGQ
         PWd5NasyqY6PmcLr8CKdkp1r0mvcc2u66fH4pYa446vytSwWjpWQycFomNkIx4Dq4lsU
         GrEwQbi1lAQzhUrC1CswTx0KqMjUw8KkRym7NNixiRhOVA1YqPU6r2FtXOIrBPrJMGgV
         l6LJSh8UBqWfvlETAM6mv4D+jbXX2FaPcc6iBawbXCab1jvVqfcaMB7AV2ZYj3gwVtmq
         dZf1ONyeJ53/c+HgKAclM8UkknVmCLsMRVoMBN8k3jq8WohkfbhFgASjEUc6uESOFyW8
         z0Fg==
X-Gm-Message-State: AOJu0Ywb++Hq6iu0dMo+XkDiOEOnwBlFkPXIZMWHbhXD/QtE8M2b8Z0l
	hBJBM3wyqWaAEIpoySBo9OKTUHjnFhuB+rl1g8QNaoO3aVH/KrJzm1ny2sgNTtMzpg==
X-Gm-Gg: ASbGncuRnUQ7Cn6gbkpb1WSNQ5NtuEtOOmCzYjpXvm0jGin4xKE3s194g/6dxcPcUmM
	GsgnWbwPufEvmp/A5Ee68bY1ero+PEXGL9FNcldOHF/AAQJxRcXD9M64p3qsRcIuzpwb4DUCteo
	SvpRN7fId7WmpJT0ghdj4WqnOZEZu8Io5SYomxJYY17qyrE5iUK7tsBD7bk5FSqdG7V772jILyP
	bCby1jR0YyU3YhClYMIIcSa4hwUMfBXU2WbBD6I6E9uaMFXzmggChKioKib8Og+IGL7W9tiUzCn
	F3iOQ1VeUQueioNUwIJ75itAK/TwJfhLCLwkbw11oxud8Roky6kr9UNgGBEpardLByRbjrzT3XJ
	6A3zijK2NEo7jadpks17egzApizjJ
X-Google-Smtp-Source: AGHT+IFZNw2KDEcOURs3zcWhqJP1yDEhxNLt8HNoAJkYvThs4nXreEzWb7UnEnSnhGYmD3Lk0O7GjQ==
X-Received: by 2002:a05:6a00:4691:b0:748:e1e4:71de with SMTP id d2e1a72fcca58-748e1e47830mr3131527b3a.14.1750238672087;
        Wed, 18 Jun 2025 02:24:32 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffecd08sm10408993b3a.27.2025.06.18.02.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 02:24:31 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [net-next, 02/10] bng_en: Add devlink interface
Date: Wed, 18 Jun 2025 14:47:32 +0000
Message-ID: <20250618144743.843815-3-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250618144743.843815-1-vikas.gupta@broadcom.com>
References: <20250618144743.843815-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allocate a base device and devlink interface with minimal
devlink ops.
Add dsn and board related information.
Map PCIe BAR (bar0), which helps to communicate with the
firmware.

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 drivers/net/ethernet/broadcom/Kconfig         |   1 +
 drivers/net/ethernet/broadcom/bnge/Makefile   |   3 +-
 drivers/net/ethernet/broadcom/bnge/bnge.h     |  11 ++
 .../net/ethernet/broadcom/bnge/bnge_core.c    |  43 +++++
 .../net/ethernet/broadcom/bnge/bnge_devlink.c | 147 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_devlink.h |  18 +++
 6 files changed, 222 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_devlink.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_devlink.h

diff --git a/drivers/net/ethernet/broadcom/Kconfig b/drivers/net/ethernet/broadcom/Kconfig
index e2c1ac91708e..0fc10e6c6902 100644
--- a/drivers/net/ethernet/broadcom/Kconfig
+++ b/drivers/net/ethernet/broadcom/Kconfig
@@ -256,6 +256,7 @@ config BNXT_HWMON
 config BNGE
 	tristate "Broadcom Ethernet device support"
 	depends on PCI
+	select NET_DEVLINK
 	help
 	  This driver supports Broadcom 50/100/200/400/800 gigabit Ethernet cards.
 	  The module will be called bng_en. To compile this driver as a module,
diff --git a/drivers/net/ethernet/broadcom/bnge/Makefile b/drivers/net/ethernet/broadcom/bnge/Makefile
index 0c3d632805d1..e021a14d2fa0 100644
--- a/drivers/net/ethernet/broadcom/bnge/Makefile
+++ b/drivers/net/ethernet/broadcom/bnge/Makefile
@@ -2,4 +2,5 @@
 
 obj-$(CONFIG_BNGE) += bng_en.o
 
-bng_en-y := bnge_core.o
+bng_en-y := bnge_core.o \
+	    bnge_devlink.o
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index b49c51b44473..19d85aabab4e 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -13,4 +13,15 @@ enum board_idx {
 	BCM57708,
 };
 
+struct bnge_dev {
+	struct device	*dev;
+	struct pci_dev	*pdev;
+	u64	dsn;
+#define BNGE_VPD_FLD_LEN	32
+	char		board_partno[BNGE_VPD_FLD_LEN];
+	char		board_serialno[BNGE_VPD_FLD_LEN];
+
+	void __iomem	*bar0;
+};
+
 #endif /* _BNGE_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_core.c b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
index 3778210da98d..1a46c7663012 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_core.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
@@ -7,6 +7,7 @@
 #include <linux/pci.h>
 
 #include "bnge.h"
+#include "bnge_devlink.h"
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION(DRV_SUMMARY);
@@ -85,8 +86,19 @@ static int bnge_pci_enable(struct pci_dev *pdev)
 	return rc;
 }
 
+static void bnge_unmap_bars(struct pci_dev *pdev)
+{
+	struct bnge_dev *bd = pci_get_drvdata(pdev);
+
+	if (bd->bar0) {
+		pci_iounmap(pdev, bd->bar0);
+		bd->bar0 = NULL;
+	}
+}
+
 static int bnge_probe_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
+	struct bnge_dev *bd;
 	int rc;
 
 	if (pci_is_bridge(pdev))
@@ -108,13 +120,44 @@ static int bnge_probe_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	bnge_print_device_info(pdev, ent->driver_data);
 
+	bd = bnge_devlink_alloc(pdev);
+	if (!bd) {
+		dev_err(&pdev->dev, "Devlink allocation failed\n");
+		rc = -ENOMEM;
+		goto err_pci_disable;
+	}
+
+	bnge_devlink_register(bd);
+
+	bd->bar0 = pci_ioremap_bar(pdev, 0);
+	if (!bd->bar0) {
+		dev_err(&pdev->dev, "Failed mapping BAR-0, aborting\n");
+		rc = -ENOMEM;
+		goto err_devl_unreg;
+	}
+
 	pci_save_state(pdev);
 
 	return 0;
+
+err_devl_unreg:
+	bnge_devlink_unregister(bd);
+	bnge_devlink_free(bd);
+
+err_pci_disable:
+	bnge_pci_disable(pdev);
+	return rc;
 }
 
 static void bnge_remove_one(struct pci_dev *pdev)
 {
+	struct bnge_dev *bd = pci_get_drvdata(pdev);
+
+	bnge_unmap_bars(pdev);
+
+	bnge_devlink_unregister(bd);
+	bnge_devlink_free(bd);
+
 	bnge_pci_disable(pdev);
 }
 
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c b/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c
new file mode 100644
index 000000000000..d406338da130
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2025 Broadcom.
+
+#include <linux/unaligned.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+#include <net/devlink.h>
+
+#include "bnge.h"
+#include "bnge_devlink.h"
+
+static int bnge_dl_info_put(struct bnge_dev *bd, struct devlink_info_req *req,
+			    enum bnge_dl_version_type type, const char *key,
+			    char *buf)
+{
+	if (!strlen(buf))
+		return 0;
+
+	switch (type) {
+	case BNGE_VERSION_FIXED:
+		return devlink_info_version_fixed_put(req, key, buf);
+	case BNGE_VERSION_RUNNING:
+		return devlink_info_version_running_put(req, key, buf);
+	case BNGE_VERSION_STORED:
+		return devlink_info_version_stored_put(req, key, buf);
+	}
+
+	return 0;
+}
+
+static void bnge_vpd_read_info(struct bnge_dev *bd)
+{
+	struct pci_dev *pdev = bd->pdev;
+	unsigned int vpd_size, kw_len;
+	int pos, size;
+	u8 *vpd_data;
+
+	vpd_data = pci_vpd_alloc(pdev, &vpd_size);
+	if (IS_ERR(vpd_data)) {
+		pci_warn(pdev, "Unable to read VPD\n");
+		return;
+	}
+
+	pos = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
+					   PCI_VPD_RO_KEYWORD_PARTNO, &kw_len);
+	if (pos < 0)
+		goto read_sn;
+
+	size = min_t(int, kw_len, BNGE_VPD_FLD_LEN - 1);
+	memcpy(bd->board_partno, &vpd_data[pos], size);
+
+read_sn:
+	pos = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
+					   PCI_VPD_RO_KEYWORD_SERIALNO,
+					   &kw_len);
+	if (pos < 0)
+		goto exit;
+
+	size = min_t(int, kw_len, BNGE_VPD_FLD_LEN - 1);
+	memcpy(bd->board_serialno, &vpd_data[pos], size);
+
+exit:
+	kfree(vpd_data);
+}
+
+static int bnge_devlink_info_get(struct devlink *devlink,
+				 struct devlink_info_req *req,
+				 struct netlink_ext_ack *extack)
+{
+	struct bnge_dev *bd = devlink_priv(devlink);
+	int rc;
+
+	if (bd->dsn) {
+		char buf[32];
+		u8 dsn[8];
+		int rc;
+
+		put_unaligned_le64(bd->dsn, dsn);
+		sprintf(buf, "%02X-%02X-%02X-%02X-%02X-%02X-%02X-%02X",
+			dsn[7], dsn[6], dsn[5], dsn[4],
+			dsn[3], dsn[2], dsn[1], dsn[0]);
+		rc = devlink_info_serial_number_put(req, buf);
+		if (rc)
+			return rc;
+	}
+
+	if (strlen(bd->board_serialno)) {
+		rc = devlink_info_board_serial_number_put(req,
+							  bd->board_serialno);
+		if (rc)
+			return rc;
+	}
+
+	rc = bnge_dl_info_put(bd, req, BNGE_VERSION_FIXED,
+			      DEVLINK_INFO_VERSION_GENERIC_BOARD_ID,
+			      bd->board_partno);
+
+	return rc;
+}
+
+static const struct devlink_ops bnge_devlink_ops = {
+	.info_get = bnge_devlink_info_get,
+};
+
+void bnge_devlink_free(struct bnge_dev *bd)
+{
+	struct devlink *devlink = priv_to_devlink(bd);
+
+	devlink_free(devlink);
+}
+
+struct bnge_dev *bnge_devlink_alloc(struct pci_dev *pdev)
+{
+	struct devlink *devlink;
+	struct bnge_dev *bd;
+
+	devlink = devlink_alloc(&bnge_devlink_ops, sizeof(*bd), &pdev->dev);
+	if (!devlink)
+		return NULL;
+
+	bd = devlink_priv(devlink);
+	pci_set_drvdata(pdev, bd);
+	bd->dev = &pdev->dev;
+	bd->pdev = pdev;
+
+	bd->dsn = pci_get_dsn(pdev);
+	if (!bd->dsn)
+		pci_warn(pdev, "Failed to get DSN\n");
+
+	bnge_vpd_read_info(bd);
+
+	return bd;
+}
+
+void bnge_devlink_register(struct bnge_dev *bd)
+{
+	struct devlink *devlink = priv_to_devlink(bd);
+
+	devlink_register(devlink);
+}
+
+void bnge_devlink_unregister(struct bnge_dev *bd)
+{
+	struct devlink *devlink = priv_to_devlink(bd);
+
+	devlink_unregister(devlink);
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_devlink.h b/drivers/net/ethernet/broadcom/bnge/bnge_devlink.h
new file mode 100644
index 000000000000..c6575255e650
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_devlink.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2025 Broadcom */
+
+#ifndef _BNGE_DEVLINK_H_
+#define _BNGE_DEVLINK_H_
+
+enum bnge_dl_version_type {
+	BNGE_VERSION_FIXED,
+	BNGE_VERSION_RUNNING,
+	BNGE_VERSION_STORED,
+};
+
+void bnge_devlink_free(struct bnge_dev *bd);
+struct bnge_dev *bnge_devlink_alloc(struct pci_dev *pdev);
+void bnge_devlink_register(struct bnge_dev *bd);
+void bnge_devlink_unregister(struct bnge_dev *bd);
+
+#endif /* _BNGE_DEVLINK_H_ */
-- 
2.47.1


