Return-Path: <netdev+bounces-111103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 245F392FDDC
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 17:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D29602882F9
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 15:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DEA1741EC;
	Fri, 12 Jul 2024 15:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUw+xuG9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C33171085
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720799364; cv=none; b=DXu2PcVhys9wma2WjHdYoy3u7WE0161HDdw8i+oaD/v39rUHYGSOZUAEU6KBihagOqNG9oNxKP4IcJSCre95GYntyi2/sGT/Zu9zp8gM5pnMfI9dL2+XkKcRMKzf04Grmdj9K/9mRw0XEz20c21wjKG12S6A1iO2XVIOYyhRbXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720799364; c=relaxed/simple;
	bh=GXPb0s/rPhqQdfh4kE7BtRNSNw1WkBTvpFQkPAM1Af8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mPOZKMD64P+PX1MaV9JoH6/2mmTXk0ZXD9F8+kbPwH24v7vwxPTRde2NU1LfbXtmT74niqHSo+8496yEaSnvdQvMbRyjUUmXAwaT+Q/P4uV5abz+X6bQwrnvw4A6gfNOiHPQGYFUKAwaxKhz+/4e1NDhVae+zY82xQsldUgzvS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUw+xuG9; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5b9a35a0901so714980eaf.0
        for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 08:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720799362; x=1721404162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ADwdqKh3ZFcDZ6A193tHnjr1PVJmWFMfp50CKcLcnXw=;
        b=UUw+xuG98vTIVb37LwD96tSKvINExsf2sdGRxFsoFynQdhZTvzD8k2FgGcMIKBMVK0
         8pMTysOhNXNw1yX77V3evJauoNvg0otpy0wTFq7DZVe7cpJWWvmrD52HH9gE/C30yOXr
         nDFlX1k1mpRw+Lex2yoLrwkSNlmaFZeKu3NTj7PX5F/qtHcwvUcdxIkdebGF4zk1OvJC
         K1r9h4W70HEdaEWy2SgMPMxwjZ5K6WvMSnshHYxrdsIM42e2s7jhZHmC2kNTCdhZ73XP
         iOaJRo/EY6FEXKjA0YWnyLizgZStzVbLwfpBe3FxkTWrgh/RwaJHvozPV1fdYdLhph+8
         fJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720799362; x=1721404162;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ADwdqKh3ZFcDZ6A193tHnjr1PVJmWFMfp50CKcLcnXw=;
        b=jSeOdVxaTIM2PrpG79ZBfUD+xcanjb8EYquvM9+n6E03Y3dW062T2b/E7SHfqSYxkv
         zggT4YZ6guh5YIhXbBmFeUKHpdh9SCy0dUg0KIyP0YVMPfuAIPwAI4zN/w0ReNjSaou8
         nbypzq5o7T8LelMYsqmOuO1kZ9qAmIftDixTwFFKt/kiazPz3RgIIBoyzjPBx6VaPy4+
         iwDgByeleYecJzmjaKAtLD2pGnGT1Gd2ZLMG/o2V2JybOst5WEVb6RLqzr0iS4LVzgNO
         mO47sp5k+Rid43MWWNKfxuFXTgEbQG9JrwDIpxA3b0dP5Q/dYPskXLywhj3f2gF/NgdU
         FVOg==
X-Gm-Message-State: AOJu0YzEtzRYRaxWonzrssPJsKntCR6IWduWTi0cgbLB2wugmx75kPAv
	6SRLuKuaiUjKNo0FmTknv4LjNR5sj26Ly/Jr50BJvCGaYUm6sDwqhrETbg==
X-Google-Smtp-Source: AGHT+IEWeQoT6hoCWj8Jn9Fbga2KVsh/g13R5+pnFNUad8CImTW3GFSoa7RdUkcFv1JWIXWj7l6C/w==
X-Received: by 2002:a05:6359:59b:b0:1aa:b9ec:50ca with SMTP id e5c5f4694b2df-1aade10b18dmr977101655d.25.1720799361579;
        Fri, 12 Jul 2024 08:49:21 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.103.43])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-77d61367835sm5923525a12.39.2024.07.12.08.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 08:49:21 -0700 (PDT)
Subject: [net-next PATCH v5 03/15] eth: fbnic: Allocate core device specific
 structures and devlink interface
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 kernel-team@meta.com
Date: Fri, 12 Jul 2024 08:49:20 -0700
Message-ID: 
 <172079936012.1778861.4670986685222676467.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <172079913640.1778861.11459276843992867323.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <172079913640.1778861.11459276843992867323.stgit@ahduyck-xeon-server.home.arpa>
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



