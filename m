Return-Path: <netdev+bounces-110383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 669F892C272
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 19:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CCF2286C3B
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 17:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D11717B02D;
	Tue,  9 Jul 2024 17:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VS0zfWcy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50F21B86C5
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 17:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720546126; cv=none; b=e+OPL1RK5hgNggNSfqn4BiEI4WIVi+7CwyjIeKNuqq3svbCZncFG+Hf/hRCwg4YkjVDfAMhXspl0cqurOCp/hmJUJKfQSnOe2O66Qe2w4e0wuX9PfsLk0cRzVifJJzFgi4dCpym3I7cw3l9/u1mo4dmNCqGSshnmNWVdSO2vrU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720546126; c=relaxed/simple;
	bh=GXPb0s/rPhqQdfh4kE7BtRNSNw1WkBTvpFQkPAM1Af8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sB+s1nKK+4JRIOxrqXpw1cwLgU/ZGMdvQSqasMqd+WhqOKC0ekFRlMKlwFuyVyRi+8Y6o+D5YCmXR6AQiUfKb4JkW+MkAbRcU/pvQgMJ/C8LVBC6LJODanCwfFwJJkUhL/KdezIYKpsRggaeyyvoLTnUfmtbvlZzvk9SlTolvAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VS0zfWcy; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2c980b55741so3293249a91.2
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 10:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720546124; x=1721150924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ADwdqKh3ZFcDZ6A193tHnjr1PVJmWFMfp50CKcLcnXw=;
        b=VS0zfWcyeCjxg2+ba4nrfCxU4idmxBPQrxcaKDuJzsHPGJXZAdjImlCTV3yw6fOM5P
         +SETJP3wrqGLv6qMkD/DqGniGaqZ59FueX/sVlTNY9jA4+6Lmhv/8GzwBm5tdf+a5QwG
         etUHgGXioKGYT3VIIMoTYQtcfOkuNw2xPm1GXEwwE/bxf0PzTo7ZvX3+J3PX1XQc46aH
         NWzwx8jY3jRKIn7X0pjSrnq5A7ldrMy97c3B6xqk5FQdJmgZNnPhX4mo45dVjNI1xal+
         YO+RYwQDx0lIxKTOagvglNXX2g922uPWbIbwrmnZYGd4guMirkv7OVOIL5lg2lFKi9/3
         IUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720546124; x=1721150924;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ADwdqKh3ZFcDZ6A193tHnjr1PVJmWFMfp50CKcLcnXw=;
        b=DL8O/BCdEyOw9dpKh/UcBKJka0OLAQtlmH8fV0t1aVCT1HPyXAxkq4rvV82wsz6l/6
         jzCM6WK0D8v+OeSIHK+g1oP1Zdbpc6RkeBij0bvptXFsg1Mu6qwspawUyUfa8LY2NZG4
         9sAn8HhwF3TptTGICAJfP8PoSavwd/4bf/t3gpPIB4s07Wp38IApCTNTrmSzh9a2eEPs
         a3k4VntG53ozuk1ZmQqIE+78JK9NItrR9VvIkCVQv9k4TIfviJ8hQds0Pd+hW/EDWi57
         kyBgnxh64fQyoGkV1pa4d3LFeIRYGlSSR0hqvF3F+yQljKToStKbIETyta+ORt0pMArq
         1DQQ==
X-Gm-Message-State: AOJu0YxpS+ieey/nrGll7Y+6FFvSEuw4SF+y4V+qkH0Ftbm5BxFvtBUN
	flLSYMdxJKqsBUv9kkUiIwBkCb/JP9GBEBC4TmHiQmY0HPCxvRtk
X-Google-Smtp-Source: AGHT+IFf3W0+gCWJ/QEJxmhZG8z+tBFzVRHjslplU1fr1uExhhFedLDdKBVR52gSWdE6q6EUxnSe+Q==
X-Received: by 2002:a17:90a:1697:b0:2c9:5c7a:ce7b with SMTP id 98e67ed59e1d1-2ca35be7ed1mr2851811a91.6.1720546123882;
        Tue, 09 Jul 2024 10:28:43 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.103.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ca34e88bcasm2196313a91.28.2024.07.09.10.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 10:28:43 -0700 (PDT)
Subject: [net-next PATCH v4 03/15] eth: fbnic: Allocate core device specific
 structures and devlink interface
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 kernel-team@meta.com
Date: Tue, 09 Jul 2024 10:28:42 -0700
Message-ID: 
 <172054612235.1305884.5791448806972122172.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <172054602727.1305884.10973465571854855750.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <172054602727.1305884.10973465571854855750.stgit@ahduyck-xeon-server.home.arpa>
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
mapping. With this we can start enabling various subsystems and start
brining up additional interfaces such the AXI fabric and the firmware
mailbox.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/Makefile        |    4 +
 drivers/net/ethernet/meta/fbnic/fbnic.h         |   27 +++++++
 drivers/net/ethernet/meta/fbnic/fbnic_devlink.c |   84 +++++++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c     |   39 +++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c     |   70 +++++++++++++++++++
 5 files changed, 222 insertions(+), 2 deletions(-)
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
index 25702dab8d66..db85b04e9b80 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -6,8 +6,35 @@
 
 #include "fbnic_csr.h"
 
+struct fbnic_dev {
+	struct device *dev;
+
+	u32 __iomem *uc_addr0;
+	u32 __iomem *uc_addr4;
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
index 000000000000..7d1475750b64
--- /dev/null
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
@@ -0,0 +1,39 @@
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
+	pci_free_irq_vectors(pdev);
+}
+
+int fbnic_alloc_irqs(struct fbnic_dev *fbd)
+{
+	unsigned int wanted_irqs = FBNIC_NON_NAPI_VECTORS;
+	struct pci_dev *pdev = to_pci_dev(fbd->dev);
+	int num_irqs;
+
+	wanted_irqs += 1;
+	num_irqs = pci_alloc_irq_vectors(pdev, FBNIC_NON_NAPI_VECTORS + 1,
+					 wanted_irqs, PCI_IRQ_MSIX);
+	if (num_irqs < 0) {
+		dev_err(fbd->dev, "Failed to allocate MSI-X entries\n");
+		return num_irqs;
+	}
+
+	if (num_irqs < wanted_irqs)
+		dev_warn(fbd->dev, "Allocated %d IRQs, expected %d\n",
+			 num_irqs, wanted_irqs);
+
+	fbd->num_irqs = num_irqs;
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index aff031e74344..fffe8a7cc96e 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -43,6 +43,7 @@ MODULE_DEVICE_TABLE(pci, fbnic_pci_tbl);
 static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	const struct fbnic_info *info = fbnic_info_tbl[ent->driver_data];
+	struct fbnic_dev *fbd;
 	int err;
 
 	if (pdev->error_state != pci_channel_io_normal) {
@@ -72,10 +73,39 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
 
+	err = fbnic_alloc_irqs(fbd);
+	if (err)
+		goto free_fbd;
+
+	fbnic_devlink_register(fbd);
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
+	fbnic_devlink_free(fbd);
+
+	return err;
 }
 
 /**
@@ -88,17 +118,50 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
  **/
 static void fbnic_remove(struct pci_dev *pdev)
 {
+	struct fbnic_dev *fbd = pci_get_drvdata(pdev);
+
+	fbnic_devlink_unregister(fbd);
+	fbnic_free_irqs(fbd);
+
 	pci_disable_device(pdev);
+	fbnic_devlink_free(fbd);
 }
 
 static int fbnic_pm_suspend(struct device *dev)
 {
+	struct fbnic_dev *fbd = dev_get_drvdata(dev);
+
+	/* Free the IRQs so they aren't trying to occupy sleeping CPUs */
+	fbnic_free_irqs(fbd);
+
+	/* Hardware is about to go away, so switch off MMIO access internally */
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
+	/* Restore MMIO access */
+	iomap_table = pcim_iomap_table(to_pci_dev(dev));
+	fbd->uc_addr0 = iomap_table[0];
+	fbd->uc_addr4 = iomap_table[4];
+
+	/* Rerequest the IRQs */
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
@@ -134,6 +197,8 @@ static pci_ers_result_t fbnic_err_error_detected(struct pci_dev *pdev,
 
 static pci_ers_result_t fbnic_err_slot_reset(struct pci_dev *pdev)
 {
+	int err;
+
 	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev);
 	pci_save_state(pdev);
@@ -144,7 +209,10 @@ static pci_ers_result_t fbnic_err_slot_reset(struct pci_dev *pdev)
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
 
-	return PCI_ERS_RESULT_RECOVERED;
+	/* Restore device to previous state */
+	err = __fbnic_pm_resume(&pdev->dev);
+
+	return err ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
 }
 
 static void fbnic_err_resume(struct pci_dev *pdev)



