Return-Path: <netdev+bounces-296126-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cuQqCZFnJGoW6AEAu9opvQ
	(envelope-from <netdev+bounces-296126-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 20:31:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F71064E07E
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 20:31:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296126-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296126-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=chelsio.com (policy=reject);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E92F230214F6
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 18:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC103B47DD;
	Sat,  6 Jun 2026 18:21:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stargate.chelsio.com (unknown [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63663A7F60
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 18:21:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780770069; cv=none; b=hUfawLQItUwKF+q/NwqchHKqqwkEW3PQmwH2XPdLMM2GJXnh4NbZGGNPKOi55dhTkBAH2/7T7Y+8Zvol1U+n6TwGGZ64urmNpAk3cRFNNaCaX1tVsGCzmXnu4Pt8uZgLBLCsyu2+IY5ru8DqPX5lMvxY7NSqSH5Ogu8TtV+6s34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780770069; c=relaxed/simple;
	bh=34lwMj9mwUX632wuub43j1C6+Ng8BCvxAfTFln6QyeA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DQ9z52PYUJl5dtNDYS5YuYca6nU0RIGEgiIQof8yskBXbSfAPlY8thZnSVdbakBULiPdweSrGrol7SpCKW2yMqrJwkx5N0NMKLN0TWQArwlRhNXH9mklWdHW56akJeB4+OBgU57V9mJHvmLF0wPxRyZuKW0GhSkiTQRp9a2b22s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Received: from mehrangarh-blr-asicdesigners-com.asicdesigners.com (mehrangarh.blr.asicdesigners.com [10.193.185.169])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 656IKSGG029679;
	Sat, 6 Jun 2026 11:20:56 -0700
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, bharat@chelsio.com
Subject: [PATCH net-next v1 06/10] cxgb4: Move PCI initialization logic to cxgb4_pci.c
Date: Sat,  6 Jun 2026 23:52:16 -0400
Message-Id: <20260607035220.528439-7-bharat@chelsio.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260607035220.528439-1-bharat@chelsio.com>
References: <20260607035220.528439-1-bharat@chelsio.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: add header
X-Spamd-Result: default: False [7.54 / 15.00];
	DATE_IN_FUTURE(4.00)[9];
	DMARC_POLICY_REJECT(2.00)[chelsio.com : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:bharat@chelsio.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296126-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,body];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[bharat@chelsio.com,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[bharat@chelsio.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chelsio.com:mid,chelsio.com:from_mime,chelsio.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F71064E07E
X-Spam: Yes

Refactor the core driver initialization framework by extracting all
PCI-specific configurations out of cxgb4_main.c into a new module
in cxgb4_pci.c and cxgb4_pci.h.

This structural separation isolates mechanical bus logic from general
driver workflows:
 - Move resource allocation subroutines to manage BAR0 mappings and
   register physical SGE doorbell pointers.
 - Relocate chip identification, BAR2 mappings, DMA masking, primary PF
   election, and firmware handshake wrappers into independent bus paths.
 - Consolidate MSI/MSI-X vectors, VPD reading, config-space access
   wrappers, EEH error handlers, and driver probe, remove, and shutdown
   hooks.
 - Shift the pci_device_id table and MODULE_DEVICE_TABLE exports
   directly to the new file, leaving only global MODULE_FIRMWARE tags
   behind in cxgb4_main.c.

Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 drivers/net/ethernet/chelsio/cxgb4/Makefile   |   2 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_pci.c    | 370 ++++++++++++++++++
 .../net/ethernet/chelsio/cxgb4/cxgb4_pci.h    |  36 ++
 3 files changed, 407 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/chelsio/cxgb4/cxgb4_pci.c
 create mode 100644 drivers/net/ethernet/chelsio/cxgb4/cxgb4_pci.h

diff --git a/drivers/net/ethernet/chelsio/cxgb4/Makefile b/drivers/net/ethernet/chelsio/cxgb4/Makefile
index a4b4d475abf8..08aef803a14a 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/Makefile
+++ b/drivers/net/ethernet/chelsio/cxgb4/Makefile
@@ -9,7 +9,7 @@ cxgb4-objs := cxgb4_main.o l2t.o smt.o t4_hw.o sge.o clip_tbl.o cxgb4_ethtool.o
 	      cxgb4_uld.o srq.o sched.o cxgb4_filter.o cxgb4_tc_u32.o \
 	      cxgb4_ptp.o cxgb4_tc_flower.o cxgb4_cudbg.o cxgb4_mps.o \
 	      cudbg_common.o cudbg_lib.o cudbg_zlib.o cxgb4_tc_mqprio.o \
-	      cxgb4_tc_matchall.o
+	      cxgb4_tc_matchall.o cxgb4_pci.o
 cxgb4-$(CONFIG_CHELSIO_T4_DCB) +=  cxgb4_dcb.o
 cxgb4-$(CONFIG_CHELSIO_T4_FCOE) +=  cxgb4_fcoe.o
 cxgb4-$(CONFIG_DEBUG_FS) += cxgb4_debugfs.o
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_pci.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_pci.c
new file mode 100644
index 000000000000..9c6ad229432c
--- /dev/null
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_pci.c
@@ -0,0 +1,370 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This file is part of the Chelsio T4/T5/T6/T7 Ethernet driver for Linux.
+ *
+ * Copyright (C) 2026 Chelsio Communications.  All rights reserved.
+ *
+ */
+
+#include <linux/crash_dump.h>
+
+#include "cxgb4.h"
+#include "t4_regs.h"
+
+#include "cxgb4_pci.h"
+
+static void cxgb4_pci_set_primary_pf(struct adapter *adap)
+{
+	adap->primary_pf = CXGB4_UNIFIED_PF;
+}
+
+int cxgb4_pci_resource_init(struct adapter *adap)
+{
+	struct pci_dev *pdev = adap->pdev;
+	int ret;
+
+	ret = pci_request_regions(pdev, KBUILD_MODNAME);
+	if (ret) {
+		/* Just info, some other driver may have claimed the device. */
+		dev_info(adap->pdev_dev, "cannot obtain PCI resources\n");
+		return ret;
+	}
+
+	ret = pci_enable_device(pdev);
+	if (ret) {
+		dev_err(adap->pdev_dev, "cannot enable PCI device\n");
+		goto out_release_regions;
+	}
+
+	adap->regs = pci_ioremap_bar(pdev, 0);
+	if (!adap->regs) {
+		dev_err(adap->pdev_dev, "cannot map device registers\n");
+		ret = -ENOMEM;
+		goto out_disable_device;
+	}
+
+	adap->sge.tx_db_addr = adap->regs + MYPF_REG(SGE_PF_KDOORBELL_A);
+	adap->sge.rx_db_addr = adap->regs + MYPF_REG(SGE_PF_GTS_A);
+
+	adap->name = pci_name(pdev);
+	cxgb4_pci_set_primary_pf(adap);
+	return 0;
+
+out_disable_device:
+	pci_disable_device(pdev);
+
+out_release_regions:
+	pci_release_regions(pdev);
+	return ret;
+}
+
+void cxgb4_pci_resource_free(struct adapter *adap)
+{
+	struct pci_dev *pdev = adap->pdev;
+
+	iounmap(adap->regs);
+	if ((adap->flags & CXGB4_DEV_ENABLED))
+		pci_disable_device(pdev);
+	pci_release_regions(pdev);
+}
+
+int cxgb4_pci_chip_init(struct adapter *adap)
+{
+	struct pci_dev *pdev = adap->pdev;
+	u16 device_id;
+	u32 whoami;
+	u8 func;
+	int ret;
+
+	/*
+	 * Note that we use the PL_WHOAMI register to figure out to which PF
+	 * we're actually attached rather than PCI_FUNC(pdev->devfn).  We do
+	 * this because we could be operating within a Virtual Machine where,
+	 * say, PF4 has been inserted via some form of "PCI Pass Through"
+	 * resulting in the VM PCI Device having a completely different PCI
+	 * Function Number, say, PF0.  However, there are many communications
+	 * with the firmware (and the hardware) where we need to use the
+	 * actual Physical Function Number and we can get this from the
+	 * PL_WHOAMI register ...
+	 */
+	whoami = t4_read_reg(adap, PL_WHOAMI_A);
+	pci_read_config_word(pdev, PCI_DEVICE_ID, &device_id);
+	ret = t4_get_chip_type(adap, CHELSIO_PCI_ID_VER(device_id));
+	if (ret < 0)
+		return ret;
+
+	adap->params.chip = ret;
+	func = CHELSIO_CHIP_VERSION(adap->params.chip) <= CHELSIO_T5 ?
+		       SOURCEPF_G(whoami) :
+		       T6_SOURCEPF_G(whoami);
+
+	adap->mbox = func;
+	adap->pf = func;
+
+	ret = cxgb4_mbox_log_init(adap);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * If we're not the MASTER Physical Function, there's not much more
+	 * we need to do.
+	 */
+	if (!cxgb4_is_primary_pf(adap)) {
+		/* We must be a PCIe SR-IOV Virtual Function.  We won't be
+		 * doing any DMA, but we will be offering VF Management
+		 * services ...
+		 */
+		pci_disable_device(pdev);
+		pci_save_state(pdev); /* to restore SR-IOV later */
+		return 0;
+	}
+
+	ret = dma_set_mask_and_coherent(adap->pdev_dev, DMA_BIT_MASK(64));
+	if (ret) {
+		dev_err(adap->pdev_dev, "no usable DMA configuration\n");
+		goto out_free_mbox_log;
+	}
+
+	pci_set_master(pdev);
+	pci_save_state(pdev);
+
+	if (!is_t4(adap->params.chip)) {
+		adap->bar2 = ioremap_wc(pci_resource_start(pdev, 2),
+					pci_resource_len(pdev, 2));
+		if (!adap->bar2) {
+			dev_err(adap->pdev_dev,
+				"cannot map device bar2 region\n");
+			ret = -ENOMEM;
+			goto out_free_mbox_log;
+		}
+
+		t4_write_reg(adap, SGE_STAT_CFG_A,
+			     STATSOURCE_T5_V(7) | (is_t5(adap->params.chip) ?
+							   STATMODE_V(0) :
+							   T6_STATMODE_V(0)));
+	}
+
+       /* check for PCI Express bandwidth capabiltites */
+	pcie_print_link_status(pdev);
+
+	/* PCIe EEH recovery on powerpc platforms needs fundamental reset */
+	pdev->needs_freset = 1;
+
+	return 0;
+
+out_free_mbox_log:
+	cxgb4_mbox_log_free(adap);
+	return ret;
+}
+
+void cxgb4_pci_chip_free(struct adapter *adap)
+{
+	if (!is_t4(adap->params.chip)) {
+		if (adap->bar2)
+			iounmap(adap->bar2);
+	}
+
+	cxgb4_mbox_log_free(adap);
+}
+
+void cxgb4_pci_setup_memwin(struct adapter *adap)
+{
+	u32 nic_win_base = t4_get_util_window(adap);
+
+	t4_setup_memwin(adap, nic_win_base, MEMWIN_NIC);
+}
+
+void cxgb4_pci_setup_memwin_rdma(struct adapter *adap)
+{
+	unsigned int sz_kb;
+	u32 start;
+
+	if (!adap->vres.ocq.size)
+		return;
+
+	start = t4_read_pcie_cfg4(adap, PCI_BASE_ADDRESS_2);
+	start &= PCI_BASE_ADDRESS_MEM_MASK;
+	start += OCQ_WIN_OFFSET(adap->pdev, &adap->vres);
+	sz_kb = roundup_pow_of_two(adap->vres.ocq.size) >> WINDOW_SHIFT_X;
+
+	/*
+	 * Set up RDMA memory window for accessing adapter memory
+	 * ranges.  (Read back MA register to ensure that changes
+	 * propagate before we attempt to use the new values.)
+	 */
+	t4_write_reg(adap, t4_pcie_mem_access_base_win_reg(adap, MEMWIN_RDMA),
+		     start | BIR_V(1) | WINDOW_V(ilog2(sz_kb)));
+	t4_pcie_mem_access_offset_write(adap, adap->vres.ocq.start, MEMWIN_RDMA,
+					0);
+}
+
+void cxgb4_pci_fw_free(struct adapter *adap)
+{
+	t4_fw_bye(adap, adap->mbox);
+}
+
+int cxgb4_pci_fw_init(struct adapter *adap, enum dev_state *state)
+{
+	int ret;
+
+	/* Contact FW, advertising Master capability */
+	ret = t4_fw_hello(adap, adap->mbox, adap->mbox, MASTER_MAY, state);
+	if (ret < 0 && is_kdump_kernel())
+		ret = t4_fw_hello(adap, adap->mbox, adap->mbox, MASTER_MUST,
+				  state);
+	if (ret < 0) {
+		dev_err(adap->pdev_dev, "could not connect to FW, error %d\n",
+			ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+int cxgb4_pci_device_id(struct adapter *adap)
+{
+	return adap->pdev->device;
+}
+
+bool cxgb4_pci_msix_enabled(struct adapter *adap)
+{
+	if (!pci_dev_msi_enabled(adap->pdev))
+		return false;
+
+	return adap->pdev->msix_enabled;
+}
+
+bool cxgb4_pci_msi_enabled(struct adapter *adap)
+{
+	if (!pci_dev_msi_enabled(adap->pdev))
+		return false;
+
+	return adap->pdev->msi_enabled;
+}
+
+int cxgb4_pci_write_config_word(struct adapter *adap, int where, u16 val)
+{
+	return pci_write_config_word(adap->pdev, where, val);
+}
+
+ssize_t cxgb4_pci_read_vpd(struct adapter *adap, loff_t pos, size_t count,
+			   void *buf)
+{
+	return pci_read_vpd(adap->pdev, pos, count, buf);
+}
+
+ssize_t cxgb4_pci_write_vpd(struct adapter *adap, loff_t pos, size_t count,
+			    const void *buf)
+{
+	return pci_write_vpd(adap->pdev, pos, count, buf);
+}
+
+#if !defined(CHELSIO_T4_DIAGS) && defined(CONFIG_PCI_IOV)
+int cxgb4_pci_iov_configure(struct adapter *adap, int num_vfs)
+{
+	return cxgb4_iov_configure(adap->pdev, num_vfs);
+}
+
+static int cxgb4_pci_sriov_configure(struct pci_dev *pdev, int num_vfs)
+{
+	if (pci_is_bridge(pdev))
+		return -EOPNOTSUPP;
+
+	return cxgb4_pci_iov_configure(pci_get_drvdata(pdev), num_vfs);
+}
+#endif
+
+static int cxgb4_pci_init_one(struct pci_dev *pdev,
+			      const struct pci_device_id *ent)
+{
+	struct adapter *adap;
+	int ret;
+
+	if (pci_is_bridge(pdev))
+		return 0;
+
+	adap = cxgb4_adap_alloc(&pdev->dev);
+	if (!adap) {
+		dev_err(&pdev->dev, "FAIL - Adapter alloc\n");
+		return -ENOMEM;
+	}
+
+	pci_set_drvdata(pdev, adap);
+
+	adap->pdev = pdev;
+	adap->pdev_dev = &pdev->dev;
+
+	ret = cxgb4_adap_probe(adap);
+	if (ret < 0)
+		goto out_err;
+
+	return 0;
+
+out_err:
+	pci_set_drvdata(pdev, NULL);
+	return ret;
+}
+
+static void cxgb4_pci_remove_one(struct pci_dev *pdev)
+{
+	if (pci_is_bridge(pdev))
+		return;
+
+	cxgb4_adap_remove(pci_get_drvdata(pdev));
+	pci_set_drvdata(pdev, NULL);
+}
+
+static void cxgb4_pci_shutdown_one(struct pci_dev *pdev)
+{
+	if (pci_is_bridge(pdev))
+		return;
+
+	cxgb4_adap_shutdown(pci_get_drvdata(pdev));
+}
+
+#define CH_PCI_DEVICE_ID_TABLE_DEFINE_BEGIN \
+static const struct pci_device_id cxgb4_pci_tbl[] = {
+
+#define CH_PCI_DEVICE_ID_FUNCTION CXGB4_UNIFIED_PF
+#define CH_PCI_DEVICE_ID_FUNCTION2 0x0
+
+#define CH_PCI_ID_TABLE_ENTRY(devid) \
+	{ PCI_VDEVICE(CHELSIO, (devid)), CXGB4_UNIFIED_PF }
+
+#define CH_PCI_DEVICE_ID_TABLE_DEFINE_END \
+	{ 0, } \
+}
+
+#include "t4_pci_id_tbl.h"
+
+static const struct pci_error_handlers cxgb4_pci_eeh = {
+	.error_detected = cxgb4_pci_eeh_err_detected,
+	.slot_reset = cxgb4_pci_eeh_slot_reset,
+	.resume = cxgb4_pci_eeh_resume,
+	.reset_prepare = cxgb4_pci_eeh_reset_prepare,
+	.reset_done = cxgb4_pci_eeh_reset_done,
+};
+
+static struct pci_driver cxgb4_pci_driver = {
+	.name = KBUILD_MODNAME,
+	.id_table = cxgb4_pci_tbl,
+	.probe = cxgb4_pci_init_one,
+	.remove = cxgb4_pci_remove_one,
+	.shutdown = cxgb4_pci_shutdown_one,
+#if !defined(CHELSIO_T4_DIAGS) && defined(CONFIG_PCI_IOV)
+	.sriov_configure = cxgb4_pci_sriov_configure,
+#endif
+	.err_handler = &cxgb4_pci_eeh,
+};
+
+int cxgb4_pci_driver_register(void)
+{
+	return pci_register_driver(&cxgb4_pci_driver);
+}
+
+void cxgb4_pci_driver_unregister(void)
+{
+	pci_unregister_driver(&cxgb4_pci_driver);
+}
+
+MODULE_DEVICE_TABLE(pci, cxgb4_pci_tbl);
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_pci.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_pci.h
new file mode 100644
index 000000000000..4f4c56a90ba2
--- /dev/null
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_pci.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ *  Copyright (C) 2026 Chelsio Communications.  All rights reserved.
+ */
+
+#ifndef __CXGB4_PCI_H__
+#define __CXGB4_PCI_H__
+
+#define CXGB4_UNIFIED_PF 0x4
+
+int cxgb4_pci_resource_init(struct adapter *adap);
+void cxgb4_pci_resource_free(struct adapter *adap);
+int cxgb4_pci_chip_init(struct adapter *adap);
+void cxgb4_pci_chip_free(struct adapter *adap);
+void cxgb4_pci_setup_memwin(struct adapter *adap);
+void cxgb4_pci_setup_memwin_rdma(struct adapter *adap);
+void cxgb4_pci_fw_free(struct adapter *adap);
+int cxgb4_pci_fw_init(struct adapter *adap, enum dev_state *state);
+int cxgb4_pci_device_id(struct adapter *adap);
+bool cxgb4_pci_msix_enabled(struct adapter *adap);
+bool cxgb4_pci_msi_enabled(struct adapter *adap);
+int cxgb4_pci_read_config_word(struct adapter *adap, int where, u16 *val);
+int cxgb4_pci_write_config_word(struct adapter *adap, int where, u16 val);
+ssize_t cxgb4_pci_read_vpd(struct adapter *adap, loff_t pos, size_t count,
+			   void *buf);
+ssize_t cxgb4_pci_write_vpd(struct adapter *adap, loff_t pos, size_t count,
+			    const void *buf);
+int cxgb4_pci_memory_rw(struct adapter *adap, int win, u64 addr, u64 len,
+			void *buf, int dir);
+#if !defined(CHELSIO_T4_DIAGS) && defined(CONFIG_PCI_IOV)
+int cxgb4_pci_iov_configure(struct adapter *adap, int num_vfs);
+#endif
+
+int cxgb4_pci_driver_register(void);
+void cxgb4_pci_driver_unregister(void);
+#endif /* __CXGB4_PCI_H__ */
-- 
2.39.1


