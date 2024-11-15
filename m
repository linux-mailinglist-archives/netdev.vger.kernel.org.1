Return-Path: <netdev+bounces-145124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EE29CD52D
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 02:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C591F2238E
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 01:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79ED51474DA;
	Fri, 15 Nov 2024 01:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dk0OKdRF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561B93F9D2
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 01:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731635637; cv=none; b=RziBGXqbjkReQp4eLs1IbbmOA+xJUyjoq4uR4c8M4NAcc3Qc3SJ3CP7HoHpZvCp3gxxwDzKKrkGztv68zLP9xZegR12vDYcSyPKQzS51aYIPfwa4CBTHeXk0fXq5J8zPvmmY6VigEWUr9Z6YtgJX+Tub1LR+f/+ODvTTq2ky7RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731635637; c=relaxed/simple;
	bh=Ceh0WbVePW6qIvC5da6bMgBCHkeRvGPIxQz6/IjyQ20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rpUNpIoGs8YlfZwwZcUQ2j3t8HVDnvH7JNP3M2jDGNqGdt65lojPtHTjHBzsl4e7KRof+A3Q2ZmCdwV4ZyFNsYDfXf5+tBOZ0WHGr0gDYPE1HG4BUFlA0FjJTTW1nBNdi9YkRZ24IXujhQ/Z2oVpbbUrZaYao3ano7M0nkpMnio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dk0OKdRF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB94C4CED5;
	Fri, 15 Nov 2024 01:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731635636;
	bh=Ceh0WbVePW6qIvC5da6bMgBCHkeRvGPIxQz6/IjyQ20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dk0OKdRFkNvfLrzqKEgUUk+fJTmxpVoKWoxU4tJCjyv2Bn+bmAFHwUKZn7Bzc2Y8l
	 7lv0hhiFppf5VPjYTaVQ4s7GkgQwWWDea+pIWZ8I/R/hRweospGNGvx/vdLVpNP41T
	 cZdJzhM8pI/bRcUKfSo6iROmVh2UcOYgWi66zjEkRov3sgHljbhK8pWUyqAylCv8Go
	 +Uar1u4TLvTFCHrPJuKTd99aCWSd74KdS2Xzj64+ZfJA8+VQf8RmpIVysS6K30/H0w
	 HiVfyusVK8rc4tDtH9sibbTbjpttrwWSm6W29AkKdaeMPa6SrsxxHAPcVO7n+zAhq+
	 oV88xoYknOWgA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	alexanderduyck@fb.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/5] eth: fbnic: add basic debugfs structure
Date: Thu, 14 Nov 2024 17:53:42 -0800
Message-ID: <20241115015344.757567-4-kuba@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115015344.757567-1-kuba@kernel.org>
References: <20241115015344.757567-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the usual debugfs structure:

 fbnic/
   $pci-id/
     device-fileA
     device-fileB

This patch only adds the directories, subsequent changes
will add files.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/Makefile      |  1 +
 drivers/net/ethernet/meta/fbnic/fbnic.h       |  6 ++++
 .../net/ethernet/meta/fbnic/fbnic_debugfs.c   | 34 +++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   | 10 +++++-
 4 files changed, 50 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c

diff --git a/drivers/net/ethernet/meta/fbnic/Makefile b/drivers/net/ethernet/meta/fbnic/Makefile
index 425e8b801265..239b2258ec65 100644
--- a/drivers/net/ethernet/meta/fbnic/Makefile
+++ b/drivers/net/ethernet/meta/fbnic/Makefile
@@ -8,6 +8,7 @@
 obj-$(CONFIG_FBNIC) += fbnic.o
 
 fbnic-y := fbnic_csr.o \
+	   fbnic_debugfs.o \
 	   fbnic_devlink.o \
 	   fbnic_ethtool.o \
 	   fbnic_fw.o \
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index 98870cb2b689..706ae6104c8e 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -19,6 +19,7 @@
 struct fbnic_dev {
 	struct device *dev;
 	struct net_device *netdev;
+	struct dentry *dbg_fbd;
 	struct device *hwmon;
 
 	u32 __iomem *uc_addr0;
@@ -156,6 +157,11 @@ int fbnic_alloc_irqs(struct fbnic_dev *fbd);
 void fbnic_get_fw_ver_commit_str(struct fbnic_dev *fbd, char *fw_version,
 				 const size_t str_sz);
 
+void fbnic_dbg_fbd_init(struct fbnic_dev *fbd);
+void fbnic_dbg_fbd_exit(struct fbnic_dev *fbd);
+void fbnic_dbg_init(void);
+void fbnic_dbg_exit(void);
+
 void fbnic_csr_get_regs(struct fbnic_dev *fbd, u32 *data, u32 *regs_version);
 int fbnic_csr_regs_len(struct fbnic_dev *fbd);
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c b/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
new file mode 100644
index 000000000000..183c7c4914dc
--- /dev/null
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#include <linux/debugfs.h>
+#include <linux/pci.h>
+
+#include "fbnic.h"
+
+static struct dentry *fbnic_dbg_root;
+
+void fbnic_dbg_fbd_init(struct fbnic_dev *fbd)
+{
+	struct pci_dev *pdev = to_pci_dev(fbd->dev);
+	const char *name = pci_name(pdev);
+
+	fbd->dbg_fbd = debugfs_create_dir(name, fbnic_dbg_root);
+}
+
+void fbnic_dbg_fbd_exit(struct fbnic_dev *fbd)
+{
+	debugfs_remove_recursive(fbd->dbg_fbd);
+	fbd->dbg_fbd = NULL;
+}
+
+void fbnic_dbg_init(void)
+{
+	fbnic_dbg_root = debugfs_create_dir(fbnic_driver_name, NULL);
+}
+
+void fbnic_dbg_exit(void)
+{
+	debugfs_remove_recursive(fbnic_dbg_root);
+	fbnic_dbg_root = NULL;
+}
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index f1e9aaaf66fc..877c45e6dcae 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -288,6 +288,7 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	fbnic_devlink_register(fbd);
+	fbnic_dbg_fbd_init(fbd);
 
 	fbnic_hwmon_register(fbd);
 
@@ -354,6 +355,7 @@ static void fbnic_remove(struct pci_dev *pdev)
 	}
 
 	fbnic_hwmon_unregister(fbd);
+	fbnic_dbg_fbd_exit(fbd);
 	fbnic_devlink_unregister(fbd);
 	fbnic_fw_disable_mbx(fbd);
 	fbnic_free_irqs(fbd);
@@ -550,9 +552,13 @@ static int __init fbnic_init_module(void)
 {
 	int err;
 
+	fbnic_dbg_init();
+
 	err = pci_register_driver(&fbnic_driver);
-	if (err)
+	if (err) {
+		fbnic_dbg_exit();
 		goto out;
+	}
 
 	pr_info(DRV_SUMMARY " (%s)", fbnic_driver.name);
 out:
@@ -568,5 +574,7 @@ module_init(fbnic_init_module);
 static void __exit fbnic_exit_module(void)
 {
 	pci_unregister_driver(&fbnic_driver);
+
+	fbnic_dbg_exit();
 }
 module_exit(fbnic_exit_module);
-- 
2.47.0


