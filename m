Return-Path: <netdev+bounces-84599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C15897994
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 22:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE01A1C2246D
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 20:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12FF15572C;
	Wed,  3 Apr 2024 20:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3TZkexS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB3056B70
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 20:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712174921; cv=none; b=mUmr8JIDjDNtB4c3rxXnm5cOMpiWuW7bwdMSvbXYq8Qhl/TAHomUrltYiRA/HsBd0qgwMN/HtWVmVTEgoicqEA5lzWB+MWPVmtwmxggmQwhUO0jPMB+kVUjr53AZDnWFQDrEtV42bSnd6NUd5Yl3TqxKJ809XHrFtEyRJ32MiAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712174921; c=relaxed/simple;
	bh=m98jrkWA91r6FO/W3KJ8ebcYVj7RUok6ZpNa6yaQgXg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nE+lgCx0hi06zV8T5Hw3HrewoziyRU6KCI6rOIpFSg39H5d/4ggt1v/PxWLX16IHC5Yvgh0j34KFz6v6VlatR9WsowE9zpfWpcKzabIixnif6RNIe9XS5Pw7gU4mZFsw8O2PQRFTw9HWI5qWJbEvENp55K4e26kopG7E234j0IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3TZkexS; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e704078860so199460b3a.0
        for <netdev@vger.kernel.org>; Wed, 03 Apr 2024 13:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712174919; x=1712779719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RGx4yOlNRxJMGAJudxuSoGG7AnAEJGrxd45q47xs/Kg=;
        b=N3TZkexSoK8KvQjW8Ub68mprc8xhhgMDP1W2KFQ3ZoPmJ/zjV+Zxg827zkhnHmf9XU
         KjTGkEKiCEuwwteyR8jAVE8PX8jvv/+IXHjHlYP6xztUK5zhbmkaW3qzwGTQcOx8KF1K
         hMI880I1F8mgG9yMpDx7RM/2/W94IGq5bDa75ozsHVK+zlrB0mVX5H6VezwO37okqmln
         g1J9OtNIyBXzOb9I2ECafeLXkDOpstMIMYmdhFPrGY3MxUrnDHTejwx2OzUEDxtu1a6X
         WBWX+8swLVqn3EM7QvHedMxCqU+FjOsbr2eiWYAiBOtE6r7H9d5XapyZn03b+abhTP5F
         xWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712174919; x=1712779719;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RGx4yOlNRxJMGAJudxuSoGG7AnAEJGrxd45q47xs/Kg=;
        b=ucyP4E3XD9NEl0Tcimne6+qR591d1xOwTrHdkumIQ6HfEVWrdJ2cVeIfxEC3uvuoIW
         X1nNAf+0p19h9iQYcxqZ81Cp4djpLXV4U7YXLuCjJPeofDVU7ck56WkiKwH23i8un3lc
         pfBWDCDQn71cx8UuxJZUMScub+eeu1qD310Dsdyp1d24nnPNAoT29sxNuOgUS8r91nMo
         FyauORO9Yc31dvbdl3LYuffr31EfpsmquPzZLfLnuqh358zbEgdkut49tMyFxsb4rPbJ
         txlqyBVaTSaDgEXSv+Xh4g3ZfTmnZ/RxKF2HhI0i1/GqcdfvX16aBoTiIVwXT+zzGwS9
         yWkQ==
X-Gm-Message-State: AOJu0YxRheOwaRdsjIswVz4/pBsqTblpJRDMNpXeJFuVRcRCwCd/2rX5
	O9IglQCT+0Vq/Yvi5zh2MqT/r2HDTwScpr9tlbKcmP1h0Mb11ks/
X-Google-Smtp-Source: AGHT+IHzUQxsbfOoFmL759s4eTRmKJgIC6YBJvJf7q2376uRfVq3ChzpVzBJduieMqishGIQUvBVjw==
X-Received: by 2002:a05:6a00:1886:b0:6ea:be87:fd36 with SMTP id x6-20020a056a00188600b006eabe87fd36mr615902pfh.1.1712174919269;
        Wed, 03 Apr 2024 13:08:39 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.103.43])
        by smtp.gmail.com with ESMTPSA id gu5-20020a056a004e4500b006ead4eb1b09sm12165696pfb.124.2024.04.03.13.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 13:08:38 -0700 (PDT)
Subject: [net-next PATCH 03/15] eth: fbnic: Allocate core device specific
 structures and devlink interface
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com
Date: Wed, 03 Apr 2024 13:08:37 -0700
Message-ID: 
 <171217491765.1598374.8648487319055615080.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

At the core of the fbnic device will be the devlink interface. This
interface will eventually provide basic functionality in the event that
there are any issues with the network interface.

Add support for allocating the MSI-X vectors and setting up the BAR
mapping. With this we can start enabling various subsytems and start
brining up additional interfaces such the AXI fabric and the firmware
mailbox.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/Makefile        |    4 +
 drivers/net/ethernet/meta/fbnic/fbnic.h         |   28 ++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_devlink.c |   84 +++++++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c     |   52 ++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c     |   72 +++++++++++++++++++-
 5 files changed, 238 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_irq.c

diff --git a/drivers/net/ethernet/meta/fbnic/Makefile b/drivers/net/ethernet/meta/fbnic/Makefile
index ce277fec875f..c06041e70bc5 100644
--- a/drivers/net/ethernet/meta/fbnic/Makefile
+++ b/drivers/net/ethernet/meta/fbnic/Makefile
@@ -7,4 +7,6 @@
 
 obj-$(CONFIG_FBNIC) += fbnic.o
 
-fbnic-y := fbnic_pci.o
+fbnic-y := fbnic_devlink.o \
+	   fbnic_irq.o \
+	   fbnic_pci.o
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index 25702dab8d66..f322cea4ce22 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -6,8 +6,36 @@
 
 #include "fbnic_csr.h"
 
+struct fbnic_dev {
+	struct device *dev;
+
+	u32 __iomem *uc_addr0;
+	u32 __iomem *uc_addr4;
+	struct msix_entry *msix_entries;
+	unsigned short num_irqs;
+
+	u64 dsn;
+};
+
+/* Reserve entry 0 in the MSI-X "others" array until we have filled all
+ * 32 of the possible interrupt slots. By doing this we can avoid any
+ * potential conflicts should we need to enable one of the debug interrupt
+ * causes later.
+ */
+enum {
+	FBNIC_NON_NAPI_VECTORS
+};
+
 extern char fbnic_driver_name[];
 
+void fbnic_devlink_free(struct fbnic_dev *fbd);
+struct fbnic_dev *fbnic_devlink_alloc(struct pci_dev *pdev);
+void fbnic_devlink_register(struct fbnic_dev *fbd);
+void fbnic_devlink_unregister(struct fbnic_dev *fbd);
+
+void fbnic_free_irqs(struct fbnic_dev *fbd);
+int fbnic_alloc_irqs(struct fbnic_dev *fbd);
+
 enum fbnic_boards {
 	fbnic_board_asic
 };
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
new file mode 100644
index 000000000000..91e8135410df
--- /dev/null
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#include <asm/unaligned.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+#include <net/devlink.h>
+
+#include "fbnic.h"
+
+#define FBNIC_SN_STR_LEN	24
+
+static int fbnic_devlink_info_get(struct devlink *devlink,
+				  struct devlink_info_req *req,
+				  struct netlink_ext_ack *extack)
+{
+	struct fbnic_dev *fbd = devlink_priv(devlink);
+	int err;
+
+	if (fbd->dsn) {
+		unsigned char serial[FBNIC_SN_STR_LEN];
+		u8 dsn[8];
+
+		put_unaligned_be64(fbd->dsn, dsn);
+		err = snprintf(serial, FBNIC_SN_STR_LEN, "%8phD", dsn);
+		if (err < 0)
+			return err;
+
+		err = devlink_info_serial_number_put(req, serial);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static const struct devlink_ops fbnic_devlink_ops = {
+	.info_get = fbnic_devlink_info_get,
+};
+
+void fbnic_devlink_free(struct fbnic_dev *fbd)
+{
+	struct devlink *devlink = priv_to_devlink(fbd);
+
+	devlink_free(devlink);
+}
+
+struct fbnic_dev *fbnic_devlink_alloc(struct pci_dev *pdev)
+{
+	void __iomem * const *iomap_table;
+	struct devlink *devlink;
+	struct fbnic_dev *fbd;
+
+	devlink = devlink_alloc(&fbnic_devlink_ops, sizeof(struct fbnic_dev),
+				&pdev->dev);
+	if (!devlink)
+		return NULL;
+
+	fbd = devlink_priv(devlink);
+	pci_set_drvdata(pdev, fbd);
+	fbd->dev = &pdev->dev;
+
+	iomap_table = pcim_iomap_table(pdev);
+	fbd->uc_addr0 = iomap_table[0];
+	fbd->uc_addr4 = iomap_table[4];
+
+	fbd->dsn = pci_get_dsn(pdev);
+
+	return fbd;
+}
+
+void fbnic_devlink_register(struct fbnic_dev *fbd)
+{
+	struct devlink *devlink = priv_to_devlink(fbd);
+
+	devlink_register(devlink);
+}
+
+void fbnic_devlink_unregister(struct fbnic_dev *fbd)
+{
+	struct devlink *devlink = priv_to_devlink(fbd);
+
+	devlink_unregister(devlink);
+}
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
new file mode 100644
index 000000000000..d2fdc51704b9
--- /dev/null
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#include <linux/pci.h>
+#include <linux/types.h>
+
+#include "fbnic.h"
+
+void fbnic_free_irqs(struct fbnic_dev *fbd)
+{
+	struct pci_dev *pdev = to_pci_dev(fbd->dev);
+
+	fbd->num_irqs = 0;
+
+	pci_disable_msix(pdev);
+
+	kfree(fbd->msix_entries);
+	fbd->msix_entries = NULL;
+}
+
+int fbnic_alloc_irqs(struct fbnic_dev *fbd)
+{
+	unsigned int wanted_irqs = FBNIC_NON_NAPI_VECTORS;
+	struct pci_dev *pdev = to_pci_dev(fbd->dev);
+	struct msix_entry *msix_entries;
+	int i, num_irqs;
+
+	msix_entries = kcalloc(wanted_irqs, sizeof(*msix_entries), GFP_KERNEL);
+	if (!msix_entries)
+		return -ENOMEM;
+
+	for (i = 0; i < wanted_irqs; i++)
+		msix_entries[i].entry = i;
+
+	num_irqs = pci_enable_msix_range(pdev, msix_entries,
+					 FBNIC_NON_NAPI_VECTORS + 1,
+					 wanted_irqs);
+	if (num_irqs < 0) {
+		dev_err(fbd->dev, "Failed to allocate MSI-X entries\n");
+		kfree(msix_entries);
+		return num_irqs;
+	}
+
+	if (num_irqs < wanted_irqs)
+		dev_warn(fbd->dev, "Allocated %d IRQs, expected %d\n",
+			 num_irqs, wanted_irqs);
+
+	fbd->msix_entries = msix_entries;
+	fbd->num_irqs = num_irqs;
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 1cb71cb1de14..596151396eac 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -43,6 +43,7 @@ MODULE_DEVICE_TABLE(pci, fbnic_pci_tbl);
 static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	const struct fbnic_info *info = fbnic_info_tbl[ent->driver_data];
+	struct fbnic_dev *fbd;
 	int err;
 
 	if (pdev->error_state != pci_channel_io_normal) {
@@ -72,10 +73,41 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		return err;
 	}
 
+	fbd = fbnic_devlink_alloc(pdev);
+	if (!fbd) {
+		dev_err(&pdev->dev, "Devlink allocation failed\n");
+		return -ENOMEM;
+	}
+
 	pci_set_master(pdev);
 	pci_save_state(pdev);
 
+	fbnic_devlink_register(fbd);
+
+	err = fbnic_alloc_irqs(fbd);
+	if (err)
+		goto free_fbd;
+
+	if (!fbd->dsn) {
+		dev_warn(&pdev->dev, "Reading serial number failed\n");
+		goto init_failure_mode;
+	}
+
 	return 0;
+
+init_failure_mode:
+	dev_warn(&pdev->dev, "Probe error encountered, entering init failure mode. Normal networking functionality will not be available.\n");
+	 /* Always return 0 even on error so devlink is registered to allow
+	  * firmware updates for fixes.
+	  */
+	return 0;
+free_fbd:
+	pci_disable_device(pdev);
+
+	fbnic_devlink_unregister(fbd);
+	fbnic_devlink_free(fbd);
+
+	return err;
 }
 
 /**
@@ -88,16 +120,49 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
  **/
 static void fbnic_remove(struct pci_dev *pdev)
 {
+	struct fbnic_dev *fbd = pci_get_drvdata(pdev);
+
+	fbnic_free_irqs(fbd);
+
+	fbnic_devlink_unregister(fbd);
+	fbnic_devlink_free(fbd);
 }
 
 static int fbnic_pm_suspend(struct device *dev)
 {
+	struct fbnic_dev *fbd = dev_get_drvdata(dev);
+
+	/* Free the IRQs so they aren't trying to occupy sleeping CPUs */
+	fbnic_free_irqs(fbd);
+
+	/* Hardware is about ot go away, so switch off MMIO access internally */
+	WRITE_ONCE(fbd->uc_addr0, NULL);
+	WRITE_ONCE(fbd->uc_addr4, NULL);
+
 	return 0;
 }
 
 static int __fbnic_pm_resume(struct device *dev)
 {
+	struct fbnic_dev *fbd = dev_get_drvdata(dev);
+	void __iomem * const *iomap_table;
+	int err;
+
+	/* restore MMIO access */
+	iomap_table = pcim_iomap_table(to_pci_dev(dev));
+	fbd->uc_addr0 = iomap_table[0];
+	fbd->uc_addr4 = iomap_table[4];
+
+	/* rerequest the IRQs */
+	err = fbnic_alloc_irqs(fbd);
+	if (err)
+		goto err_invalidate_uc_addr;
+
 	return 0;
+err_invalidate_uc_addr:
+	WRITE_ONCE(fbd->uc_addr0, NULL);
+	WRITE_ONCE(fbd->uc_addr4, NULL);
+	return err;
 }
 
 static int __maybe_unused fbnic_pm_resume(struct device *dev)
@@ -133,6 +198,8 @@ static pci_ers_result_t fbnic_err_error_detected(struct pci_dev *pdev,
 
 static pci_ers_result_t fbnic_err_slot_reset(struct pci_dev *pdev)
 {
+	int err;
+
 	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev);
 	pci_save_state(pdev);
@@ -143,7 +210,10 @@ static pci_ers_result_t fbnic_err_slot_reset(struct pci_dev *pdev)
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
 
-	return PCI_ERS_RESULT_RECOVERED;
+	/* restore device to previous state */
+	err = __fbnic_pm_resume(&pdev->dev);
+
+	return err ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
 }
 
 static void fbnic_err_resume(struct pci_dev *pdev)



