Return-Path: <netdev+bounces-106524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B89916A94
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 16:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E700B236D9
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 14:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950B216D4C4;
	Tue, 25 Jun 2024 14:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHUdi+qz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8563BB23
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719326151; cv=none; b=dCg6mlOHyhwvwsG62r4OKaaBy6hlqo2asftOXNvW6Lb3x1c5zKfcCk7NaBlHMJX9pavj+vRJzVd6HmEdgy0NUbs66V2GYzrXJBkN4NOmf8jIwoi6WaIlrskBN0HXmA0rm1VJKaUoCFKJTVHZbWHFAjG7yyBT600BbeWKK2B7Lhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719326151; c=relaxed/simple;
	bh=UqdldPM+/hmLIgF8pjyd2Tjnpwsmf3etU5d02s/DANo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e7+xF+5yYLHEiHX7CXdBcK1N96fgtD3hWBjIIrjl0BEiORqJp6cHg4+z34aKGt1HryRq4jjP9WaXAbJQEtDtl3g5OMSszOuSChW3+LO6ZR3q8gpjOt99ziI0zFHVB/gAJhvLI4rxRYmQ5J4sZKzfYxJQQxfj5gtniHnJtj9ssHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHUdi+qz; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70698bcd19eso624568b3a.0
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 07:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719326149; x=1719930949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P0NXCWS5FeZl8HWFkXEgaY4iIa0EphQCOXK0eT6wanI=;
        b=EHUdi+qzBXr2esgXhC7lP0qDy0iDB6B5RfwY5IUI2s0PzmhlAGEh+6x/qNTO6eJ964
         zQB2cvthhOFE2bmwsGJG3ngqQmcOlCGe9CqTmtAita8Cqb9eMkV0e20i6+075t2bj2eB
         SqRA1qm1WDKt+AVEJI++iU/kiQNlUI0yY1iePL+DyS1YqAtuySi80JwVl4Ug0TxuIEdi
         FqYrIWyQX/ygF7Izx8a5zYHxUp6CKPoYyz4JSHOPHmy3gbiEqKSmReSnxxsLVaUML3h/
         oDTMVHeV4c9J4vMCohwlsEaajyFCta5CohNhQ9hYqcsyavQpKl3yISYf/PhpGWUaOKV4
         XGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719326149; x=1719930949;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P0NXCWS5FeZl8HWFkXEgaY4iIa0EphQCOXK0eT6wanI=;
        b=iB+Uua++w1Zcmjrbqh1tqr92d1JA2pq7DdDazTFklOVVgY46eHT/aFwkHbMKUNm1gC
         GFYVbDh+quw0Fspw3A7LDgJcAnva3cE42XYUm9iPxWSe5ppdzYo6VrOJ2nfV+qoVpmBV
         /QxURlUHC40DE9ToeiBYCLDVBJkBFWqw0edVxOuStMhIe39aGifb3ctVHKC9fJ5zBysU
         PbSyALCrNbmUw2bowKsRudIzMxvsyemESLJcZaL/LSf5bbNQlV3yWj9T9jsc9/PAj/9B
         1U0haBqzF+w+1R9H0iW8AtBKLuy7zNP3+3FOsvLPh+ZmqU45R8MDWUS269vVtlQoHTal
         ef6w==
X-Gm-Message-State: AOJu0Yxu3Z/+BMQ5w7mtA94bvuVOTcYOnZ2MHSJTloXNg4ldMRKfjd++
	QPRei6rih79R4LbE5Jynqhb1FOMOqm9bkjnWyaGT/WZb9uIquSCm7fOBFg==
X-Google-Smtp-Source: AGHT+IHnvN0gL9LVZrO60zFUjroddNZHT4nUalBNxiYj+YNmf1n8Jxs3jpeENdte3DsVOztS9OID9w==
X-Received: by 2002:a05:6a20:45b:b0:1bd:2703:840 with SMTP id adf61e73a8af0-1bd270308damr600738637.33.1719326149111;
        Tue, 25 Jun 2024 07:35:49 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c8b8332b06sm953902a91.1.2024.06.25.07.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 07:35:48 -0700 (PDT)
Subject: [net-next PATCH v2 03/15] eth: fbnic: Allocate core device specific
 structures and devlink interface
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com
Date: Tue, 25 Jun 2024 07:35:47 -0700
Message-ID: 
 <171932614766.3072535.4112937275775351621.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <171932574765.3072535.12103787411698322191.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <171932574765.3072535.12103787411698322191.stgit@ahduyck-xeon-server.home.arpa>
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
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c     |   72 +++++++++++++++++++-
 5 files changed, 224 insertions(+), 2 deletions(-)
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
index e860ec3750c3..185a4d2e6c52 100644
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
+	/* Restore device to previous state */
+	err = __fbnic_pm_resume(&pdev->dev);
+
+	return err ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
 }
 
 static void fbnic_err_resume(struct pci_dev *pdev)



