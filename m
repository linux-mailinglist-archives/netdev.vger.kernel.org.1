Return-Path: <netdev+bounces-34596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F14467A4D39
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 17:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB6C0282408
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 15:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E2C1F619;
	Mon, 18 Sep 2023 15:46:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AFF137C
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 15:46:23 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0C0CF8;
	Mon, 18 Sep 2023 08:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695051920; x=1726587920;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uEKrgp0fS4TcV/kqj/T1ibXnz9U6nSS/hcSxBB6l/C0=;
  b=fQjsiB6vONTRlk5HZosldvkskKXZ2MTyw1KqGM3O3eFuh+jVIf6/8ul4
   Rzi241HaWnxbMJgnRQya5Vf5HZBP40Y5/Jj4XJPboRdRKlTbqJ0qr0KOd
   nCbLZK7sWH5N93txZXAqS2jwkyz0Y8GoxizUBigNMg5QCESzbT+8Rj8Qv
   4YBOb63OSFvCwj72KYi0Jj4Vw0D+W+P2od8ZDz/C7ghlZjHdP8TrGwjnD
   vm6PTGbzxAKuGfkYpabIXNG137gcRf/MI5I7SpYfdHbXbsnn5eCB+evOX
   q6Dk4OQs5qbi37fN5XaOTMg5h66s6jQeP0qCtpkaAkAWdIuseFiDPqdxX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="446113406"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="446113406"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 06:12:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="811342150"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="811342150"
Received: from nprotaso-mobl1.ccr.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.49.156])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 06:12:30 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lukas Wunner <lukas@wunner.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: ath10k@lists.infradead.org,
	ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	intel-wired-lan@lists.osuosl.org,
	linux-arm-kernel@lists.infradead.org,
	linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-rdma@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 05/13] PCI/ASPM: Add pci_enable_link_state()
Date: Mon, 18 Sep 2023 16:10:55 +0300
Message-Id: <20230918131103.24119-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230918131103.24119-1-ilpo.jarvinen@linux.intel.com>
References: <20230918131103.24119-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

pci_disable_link_state() lacks a symmetric pair. Some drivers want to
disable ASPM during certain phases of their operation but then
re-enable it later on. If pci_disable_link_state() is made for the
device, there is currently no way to re-enable the states that were
disabled.

Add pci_enable_link_state() to remove ASPM states from the state
disable mask.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pcie/aspm.c | 42 +++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h     |  2 ++
 2 files changed, 44 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 91dc95aca90f..f45d18d47c20 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1117,6 +1117,48 @@ int pci_disable_link_state(struct pci_dev *pdev, int state)
 }
 EXPORT_SYMBOL(pci_disable_link_state);
 
+/**
+ * pci_enable_link_state - Re-enable device's link state
+ * @pdev: PCI device
+ * @state: ASPM link states to re-enable
+ *
+ * Enable device's link state that were previously disable so the link is
+ * allowed to enter the specific states. Note that if the BIOS didn't grant
+ * ASPM control to the OS, this does nothing because we can't touch the
+ * LNKCTL register.
+ *
+ * Return: 0 or a negative errno.
+ */
+int pci_enable_link_state(struct pci_dev *pdev, int state)
+{
+	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
+
+	if (!link)
+		return -EINVAL;
+	/*
+	 * A driver requested that ASPM be enabled on this device, but
+	 * if we don't have permission to manage ASPM (e.g., on ACPI
+	 * systems we have to observe the FADT ACPI_FADT_NO_ASPM bit and
+	 * the _OSC method), we can't honor that request.
+	 */
+	if (aspm_disabled) {
+		pci_warn(pdev, "can't enable ASPM; OS doesn't have ASPM control\n");
+		return -EPERM;
+	}
+
+	mutex_lock(&aspm_lock);
+	link->aspm_disable &= ~pci_link_state_mask(state);
+	pcie_config_aspm_link(link, policy_to_aspm_state(link));
+
+	if (state & PCIE_LINK_STATE_CLKPM)
+		link->clkpm_disable = 0;
+	pcie_set_clkpm(link, policy_to_clkpm_state(link));
+	mutex_unlock(&aspm_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL(pci_enable_link_state);
+
 /**
  * pci_set_default_link_state - Set the default device link state
  * @pdev: PCI device
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3c24ca164104..844d09230264 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1776,11 +1776,13 @@ extern bool pcie_ports_native;
 int pci_disable_link_state(struct pci_dev *pdev, int state);
 int pci_disable_link_state_locked(struct pci_dev *pdev, int state);
 #ifdef CONFIG_PCIEASPM
+int pci_enable_link_state(struct pci_dev *pdev, int state);
 int pci_set_default_link_state(struct pci_dev *pdev, int state);
 void pcie_no_aspm(void);
 bool pcie_aspm_support_enabled(void);
 bool pcie_aspm_enabled(struct pci_dev *pdev);
 #else
+static inline int pci_enable_link_state(struct pci_dev *pdev, int state) { return -EOPNOTSUPP; }
 static inline int pci_set_default_link_state(struct pci_dev *pdev, int state)
 { return 0; }
 static inline void pcie_no_aspm(void) { }
-- 
2.30.2


