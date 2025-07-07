Return-Path: <netdev+bounces-204498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 424F4AFAE82
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 10:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB6AA3BC8B7
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 08:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22FB28BA84;
	Mon,  7 Jul 2025 08:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BvHN3sqq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xo44KR/c"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD413597A;
	Mon,  7 Jul 2025 08:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751876427; cv=none; b=O+P2IRhanCtAWUM7HRe0ppufe3muyFkZEVaNc+x7HxVP9/i1xZpSIuLeNDQUOaxSwJGmk8Z/lWVhq2dkHEkjZeUpGo7y5M3ftgpwoKD4K6pLgR7AWVS2LBQvfddvW8myqB12jby7yEIhlzZ9s56E12Eiikl6MJ2bMkClB5vo7oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751876427; c=relaxed/simple;
	bh=0sU5N9KIzovRA1zRXAjCdZjYHDZi1yN5rr/PzpCSmBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qBk2x7L7dpMpPhGedKSY2MEqSADsOmue28uvhaD7tmMd0qxIhKgnY2zAB8gm1Yhmcge7YybssmBaECHYNKWJSo/tGXGUN44HcbJnpQPYf0pPKp7UbwZ5RjUBq7XmosEDoXlX2Ot42GJWGTahVeoOIC+adta7ILPi6LAyIXaG8WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BvHN3sqq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xo44KR/c; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751876424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dGTaPq9IrPGKtjCv4AflB+vEuleopO+ESeIDAY/xF9U=;
	b=BvHN3sqqnR4h2Fjdzn5q4iEjD7z1DOGCMoQC4+Z0JNg+IZE7nChQmtkSriwSRLGzFL7C+7
	VKUrgnSCu4jhTB+CGJ24zEeI9uuDLrQPzkYJbXf6/NhblIqMXApw5BWfpejqloIAVSJvqW
	C3M+MJyYDuBX2bJNcv3Pm7Lkg6CLUwmJzOlpzX4pH+OqLHUhvunyIwA0stlVwPd+h1pYN7
	w0viTCQgmqHgXd40lTVyLhxmEmcj2Jsn7CbzH3XZ7hbWtH2kXc4cdSgFn1iL2uOYRfxCl3
	ELooWfweGEQMEImwrpVrPzB4PsX7v6oLZ/pKz7nd7cLpnMS0R9coJSRgshIh2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751876424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dGTaPq9IrPGKtjCv4AflB+vEuleopO+ESeIDAY/xF9U=;
	b=Xo44KR/c/ZJSt07WoqDzv16arC2HLBezr3ePHEyLLnHAeHFMppwDBiGSKOsXSvEIqzFl2O
	Vr8jYPmCAOVCgSBQ==
To: Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michael Kelley <mhklinux@outlook.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH for-netdev v2 2/2] PCI: hv: Switch to msi_create_parent_irq_domain()
Date: Mon,  7 Jul 2025 10:20:16 +0200
Message-Id: <7b99cca47b41dacc9a82b96093935eab07cac43a.1751875853.git.namcao@linutronix.de>
In-Reply-To: <cover.1751875853.git.namcao@linutronix.de>
References: <cover.1751875853.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Move away from the legacy MSI domain setup, switch to use
msi_create_parent_irq_domain().

While doing the conversion, I noticed that hv_compose_msi_msg() is doing
more than it is supposed to (composing message). This function also
allocates and populates struct tran_int_desc, which should be done in
hv_pcie_domain_alloc() instead. It works, but it is not the correct design.
However, I have no hardware to test such change, therefore I leave a TODO
note.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
v2:
  - rebase onto netdev/next
  - clarify the TODO note
  - fixup arm64
  - Add HV_MSI_CHIP_FLAGS macro and reduce the amount of #ifdef
---
 drivers/pci/Kconfig                 |   1 +
 drivers/pci/controller/pci-hyperv.c | 111 +++++++++++++++++++++-------
 2 files changed, 84 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 9c0e4aaf4e8c..9a249c65aedc 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -223,6 +223,7 @@ config PCI_HYPERV
 	tristate "Hyper-V PCI Frontend"
 	depends on ((X86 && X86_64) || ARM64) && HYPERV && PCI_MSI && SYSFS
 	select PCI_HYPERV_INTERFACE
+	select IRQ_MSI_LIB
 	help
 	  The PCI device frontend driver allows the kernel to import arbitrary
 	  PCI devices from a PCI backend to support PCI driver domains.
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/p=
ci-hyperv.c
index 86ca041bf74a..ebe39218479a 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -44,6 +44,7 @@
 #include <linux/delay.h>
 #include <linux/semaphore.h>
 #include <linux/irq.h>
+#include <linux/irqchip/irq-msi-lib.h>
 #include <linux/msi.h>
 #include <linux/hyperv.h>
 #include <linux/refcount.h>
@@ -508,7 +509,6 @@ struct hv_pcibus_device {
 	struct list_head children;
 	struct list_head dr_list;
=20
-	struct msi_domain_info msi_info;
 	struct irq_domain *irq_domain;
=20
 	struct workqueue_struct *wq;
@@ -576,9 +576,8 @@ struct hv_pci_compl {
 static void hv_pci_onchannelcallback(void *context);
=20
 #ifdef CONFIG_X86
-#define DELIVERY_MODE	APIC_DELIVERY_MODE_FIXED
-#define FLOW_HANDLER	handle_edge_irq
-#define FLOW_NAME	"edge"
+#define DELIVERY_MODE		APIC_DELIVERY_MODE_FIXED
+#define HV_MSI_CHIP_FLAGS	MSI_CHIP_FLAG_SET_ACK
=20
 static int hv_pci_irqchip_init(void)
 {
@@ -723,8 +722,7 @@ static void hv_arch_irq_unmask(struct irq_data *data)
 #define HV_PCI_MSI_SPI_START	64
 #define HV_PCI_MSI_SPI_NR	(1020 - HV_PCI_MSI_SPI_START)
 #define DELIVERY_MODE		0
-#define FLOW_HANDLER		NULL
-#define FLOW_NAME		NULL
+#define HV_MSI_CHIP_FLAGS	MSI_CHIP_FLAG_SET_EOI
 #define hv_msi_prepare		NULL
=20
 struct hv_pci_chip_data {
@@ -1687,7 +1685,7 @@ static void hv_msi_free(struct irq_domain *domain, st=
ruct msi_domain_info *info,
 	struct msi_desc *msi =3D irq_data_get_msi_desc(irq_data);
=20
 	pdev =3D msi_desc_to_pci_dev(msi);
-	hbus =3D info->data;
+	hbus =3D domain->host_data;
 	int_desc =3D irq_data_get_irq_chip_data(irq_data);
 	if (!int_desc)
 		return;
@@ -1705,7 +1703,6 @@ static void hv_msi_free(struct irq_domain *domain, st=
ruct msi_domain_info *info,
=20
 static void hv_irq_mask(struct irq_data *data)
 {
-	pci_msi_mask_irq(data);
 	if (data->parent_data->chip->irq_mask)
 		irq_chip_mask_parent(data);
 }
@@ -1716,7 +1713,6 @@ static void hv_irq_unmask(struct irq_data *data)
=20
 	if (data->parent_data->chip->irq_unmask)
 		irq_chip_unmask_parent(data);
-	pci_msi_unmask_irq(data);
 }
=20
 struct compose_comp_ctxt {
@@ -2101,25 +2097,87 @@ static void hv_compose_msi_msg(struct irq_data *dat=
a, struct msi_msg *msg)
 	msg->data =3D 0;
 }
=20
+static bool hv_pcie_init_dev_msi_info(struct device *dev, struct irq_domai=
n *domain,
+				      struct irq_domain *real_parent, struct msi_domain_info *info)
+{
+	struct irq_chip *chip =3D info->chip;
+
+	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
+		return false;
+
+	info->ops->msi_prepare =3D hv_msi_prepare;
+
+	chip->irq_set_affinity =3D irq_chip_set_affinity_parent;
+
+	if (IS_ENABLED(CONFIG_X86))
+		chip->flags |=3D IRQCHIP_MOVE_DEFERRED;
+
+	return true;
+}
+
+#define HV_PCIE_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS		| \
+				    MSI_FLAG_USE_DEF_CHIP_OPS		| \
+				    MSI_FLAG_PCI_MSI_MASK_PARENT)
+#define HV_PCIE_MSI_FLAGS_SUPPORTED (MSI_FLAG_MULTI_PCI_MSI		| \
+				     MSI_FLAG_PCI_MSIX			| \
+				     MSI_FLAG_PCI_MSIX_ALLOC_DYN	| \
+				     MSI_GENERIC_FLAGS_MASK)
+
+static const struct msi_parent_ops hv_pcie_msi_parent_ops =3D {
+	.required_flags		=3D HV_PCIE_MSI_FLAGS_REQUIRED,
+	.supported_flags	=3D HV_PCIE_MSI_FLAGS_SUPPORTED,
+	.bus_select_token	=3D DOMAIN_BUS_PCI_MSI,
+	.chip_flags		=3D HV_MSI_CHIP_FLAGS,
+	.prefix			=3D "HV-",
+	.init_dev_msi_info	=3D hv_pcie_init_dev_msi_info,
+};
+
 /* HW Interrupt Chip Descriptor */
 static struct irq_chip hv_msi_irq_chip =3D {
 	.name			=3D "Hyper-V PCIe MSI",
 	.irq_compose_msi_msg	=3D hv_compose_msi_msg,
 	.irq_set_affinity	=3D irq_chip_set_affinity_parent,
-#ifdef CONFIG_X86
 	.irq_ack		=3D irq_chip_ack_parent,
-	.flags			=3D IRQCHIP_MOVE_DEFERRED,
-#elif defined(CONFIG_ARM64)
 	.irq_eoi		=3D irq_chip_eoi_parent,
-#endif
 	.irq_mask		=3D hv_irq_mask,
 	.irq_unmask		=3D hv_irq_unmask,
 };
=20
-static struct msi_domain_ops hv_msi_ops =3D {
-	.msi_prepare	=3D hv_msi_prepare,
-	.msi_free	=3D hv_msi_free,
-	.prepare_desc	=3D pci_msix_prepare_desc,
+static int hv_pcie_domain_alloc(struct irq_domain *d, unsigned int virq, u=
nsigned int nr_irqs,
+			       void *arg)
+{
+	/*
+	 * TODO: Allocating and populating struct tran_int_desc in hv_compose_msi=
_msg()
+	 * should be moved here.
+	 */
+	int ret;
+
+	ret =3D irq_domain_alloc_irqs_parent(d, virq, nr_irqs, arg);
+	if (ret < 0)
+		return ret;
+
+	for (int i =3D 0; i < nr_irqs; i++) {
+		irq_domain_set_hwirq_and_chip(d, virq + i, 0, &hv_msi_irq_chip, NULL);
+		if (IS_ENABLED(CONFIG_X86))
+			__irq_set_handler(virq + i, handle_edge_irq, 0, "edge");
+	}
+
+	return 0;
+}
+
+static void hv_pcie_domain_free(struct irq_domain *d, unsigned int virq, u=
nsigned int nr_irqs)
+{
+	struct msi_domain_info *info =3D d->host_data;
+
+	for (int i =3D 0; i < nr_irqs; i++)
+		hv_msi_free(d, info, virq + i);
+
+	irq_domain_free_irqs_top(d, virq, nr_irqs);
+}
+
+static const struct irq_domain_ops hv_pcie_domain_ops =3D {
+	.alloc	=3D hv_pcie_domain_alloc,
+	.free	=3D hv_pcie_domain_free,
 };
=20
 /**
@@ -2137,17 +2195,14 @@ static struct msi_domain_ops hv_msi_ops =3D {
  */
 static int hv_pcie_init_irq_domain(struct hv_pcibus_device *hbus)
 {
-	hbus->msi_info.chip =3D &hv_msi_irq_chip;
-	hbus->msi_info.ops =3D &hv_msi_ops;
-	hbus->msi_info.flags =3D (MSI_FLAG_USE_DEF_DOM_OPS |
-		MSI_FLAG_USE_DEF_CHIP_OPS | MSI_FLAG_MULTI_PCI_MSI |
-		MSI_FLAG_PCI_MSIX | MSI_FLAG_PCI_MSIX_ALLOC_DYN);
-	hbus->msi_info.handler =3D FLOW_HANDLER;
-	hbus->msi_info.handler_name =3D FLOW_NAME;
-	hbus->msi_info.data =3D hbus;
-	hbus->irq_domain =3D pci_msi_create_irq_domain(hbus->fwnode,
-						     &hbus->msi_info,
-						     hv_pci_get_root_domain());
+	struct irq_domain_info info =3D {
+		.fwnode		=3D hbus->fwnode,
+		.ops		=3D &hv_pcie_domain_ops,
+		.host_data	=3D hbus,
+		.parent		=3D hv_pci_get_root_domain(),
+	};
+
+	hbus->irq_domain =3D msi_create_parent_irq_domain(&info, &hv_pcie_msi_par=
ent_ops);
 	if (!hbus->irq_domain) {
 		dev_err(&hbus->hdev->device,
 			"Failed to build an MSI IRQ domain\n");
--=20
2.39.5


