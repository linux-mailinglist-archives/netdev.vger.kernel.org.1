Return-Path: <netdev+bounces-186147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EE1A9D48A
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 23:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E13917D387
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 21:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81008227E88;
	Fri, 25 Apr 2025 21:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tz0yVljY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18CD22538F
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 21:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745617960; cv=none; b=USZItl/9RZmuKFESyr5eGaPQaojOKOnkUZTZh1ItUJPoDqtheLLOSVE6d+5n+L6tjUxSTKOXrVt6yPpvE31JGp++36CXOYqC1jQTt1SBb5PBBgZP8gO7I80MTPBgQLlXnRIW6RYAvt8YtqqepIhRxNQJ9EKSWVZQbHCkh00API4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745617960; c=relaxed/simple;
	bh=HpCr0ZmcEdZwMkp+2rG6CXAdFEJ/7IT/dgDXeAIbcRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+qZxOztXHL2iZZGnFqar0cH6dO3TJMeHejMMiD9RpPjFceePxVktzYI7XDD53ShJkM5qdcmanVYW+IoxgvXFIHkqPU+nYr4yS1UaKdjvcI0zqd37Qv8bSr+ac/4n8GPKqct2dF/nYgrJmalAuba5YR466/uMACKUfzGU4tbXi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tz0yVljY; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745617959; x=1777153959;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HpCr0ZmcEdZwMkp+2rG6CXAdFEJ/7IT/dgDXeAIbcRc=;
  b=Tz0yVljYIjRfZkFVY3UX6KVFdDEo/exZLNSK/kHoWHLgwipoGysLPF8d
   R7MJkAjbLtQTQKKaJYVf+dvogGvl7qizM6IwLulXR+9R+WxuQKDFBs3tt
   aqnS1Rwhk1VOs84iI43tyO4PayP1UVeD4F8fsUL93dkoqdxKevZfX+0DQ
   onC86pO6AxNpNc9Vqp+8WTS6TSrp9xbRxhxwl6RnqSNcSkVwQeZdUOBZm
   kuq77zawHbjylAQE7Y2CRYu4O9uKZ1aEvwarJlzzBFzUY3cgAb7V2ebcc
   TGIii6i9w1CO2uu5wQ6WaXiHIpQPvqzTiH/mt+4wRSU+L7jrPpUr+DMck
   A==;
X-CSE-ConnectionGUID: Nfaks/KFRcy5Mf2M7+F4Tg==
X-CSE-MsgGUID: pQMoFKcWSmeG+6e0k9Lpiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="69784534"
X-IronPort-AV: E=Sophos;i="6.15,240,1739865600"; 
   d="scan'208";a="69784534"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 14:52:36 -0700
X-CSE-ConnectionGUID: 4tne1VM7Qlq5VjQbaEhneQ==
X-CSE-MsgGUID: 46FHYCAiSX2QP3E96kDEGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,240,1739865600"; 
   d="scan'208";a="163973508"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 25 Apr 2025 14:52:36 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Milena Olech <milena.olech@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	richardcochran@gmail.com,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net-next v2 02/11] idpf: add initial PTP support
Date: Fri, 25 Apr 2025 14:52:16 -0700
Message-ID: <20250425215227.3170837-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425215227.3170837-1-anthony.l.nguyen@intel.com>
References: <20250425215227.3170837-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Milena Olech <milena.olech@intel.com>

PTP feature is supported if the VIRTCHNL2_CAP_PTP is negotiated during the
capabilities recognition. Initial PTP support includes PTP initialization
and registration of the clock.

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Milena Olech <milena.olech@intel.com>
Tested-by: Mina Almasry <almasrymina@google.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/Kconfig       |  1 +
 drivers/net/ethernet/intel/idpf/Makefile      |  1 +
 drivers/net/ethernet/intel/idpf/idpf.h        |  3 +
 drivers/net/ethernet/intel/idpf/idpf_main.c   |  4 +
 drivers/net/ethernet/intel/idpf/idpf_ptp.c    | 90 +++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_ptp.h    | 32 +++++++
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 10 ++-
 7 files changed, 140 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_ptp.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_ptp.h

diff --git a/drivers/net/ethernet/intel/idpf/Kconfig b/drivers/net/ethernet/intel/idpf/Kconfig
index 1addd663acad..2c359a8551c7 100644
--- a/drivers/net/ethernet/intel/idpf/Kconfig
+++ b/drivers/net/ethernet/intel/idpf/Kconfig
@@ -4,6 +4,7 @@
 config IDPF
 	tristate "Intel(R) Infrastructure Data Path Function Support"
 	depends on PCI_MSI
+	depends on PTP_1588_CLOCK_OPTIONAL
 	select DIMLIB
 	select LIBETH
 	help
diff --git a/drivers/net/ethernet/intel/idpf/Makefile b/drivers/net/ethernet/intel/idpf/Makefile
index 2ce01a0b5898..1f38a9d7125c 100644
--- a/drivers/net/ethernet/intel/idpf/Makefile
+++ b/drivers/net/ethernet/intel/idpf/Makefile
@@ -17,3 +17,4 @@ idpf-y := \
 	idpf_vf_dev.o
 
 idpf-$(CONFIG_IDPF_SINGLEQ)	+= idpf_singleq_txrx.o
+idpf-$(CONFIG_PTP_1588_CLOCK)	+= idpf_ptp.o
diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 66544faab710..2e8b14dd9d96 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -530,6 +530,7 @@ struct idpf_vc_xn_manager;
  * @vector_lock: Lock to protect vector distribution
  * @queue_lock: Lock to protect queue distribution
  * @vc_buf_lock: Lock to protect virtchnl buffer
+ * @ptp: Storage for PTP-related data
  */
 struct idpf_adapter {
 	struct pci_dev *pdev;
@@ -587,6 +588,8 @@ struct idpf_adapter {
 	struct mutex vector_lock;
 	struct mutex queue_lock;
 	struct mutex vc_buf_lock;
+
+	struct idpf_ptp *ptp;
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index 1284ab2adaf1..b9874c59db0a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -167,6 +167,10 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_free;
 	}
 
+	err = pci_enable_ptm(pdev, NULL);
+	if (err)
+		pci_dbg(pdev, "PCIe PTM is not supported by PCIe bus/controller\n");
+
 	/* set up for high or low dma */
 	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
 	if (err) {
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
new file mode 100644
index 000000000000..71fc652b79e6
--- /dev/null
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2024 Intel Corporation */
+
+#include "idpf.h"
+#include "idpf_ptp.h"
+
+/**
+ * idpf_ptp_create_clock - Create PTP clock device for userspace
+ * @adapter: Driver specific private structure
+ *
+ * This function creates a new PTP clock device.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int idpf_ptp_create_clock(const struct idpf_adapter *adapter)
+{
+	struct ptp_clock *clock;
+
+	/* Attempt to register the clock before enabling the hardware. */
+	clock = ptp_clock_register(&adapter->ptp->info,
+				   &adapter->pdev->dev);
+	if (IS_ERR(clock)) {
+		pci_err(adapter->pdev, "PTP clock creation failed: %pe\n",
+			clock);
+		return PTR_ERR(clock);
+	}
+
+	adapter->ptp->clock = clock;
+
+	return 0;
+}
+
+/**
+ * idpf_ptp_init - Initialize PTP hardware clock support
+ * @adapter: Driver specific private structure
+ *
+ * Set up the device for interacting with the PTP hardware clock for all
+ * functions. Function will allocate and register a ptp_clock with the
+ * PTP_1588_CLOCK infrastructure.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+int idpf_ptp_init(struct idpf_adapter *adapter)
+{
+	int err;
+
+	if (!idpf_is_cap_ena(adapter, IDPF_OTHER_CAPS, VIRTCHNL2_CAP_PTP)) {
+		pci_dbg(adapter->pdev, "PTP capability is not detected\n");
+		return -EOPNOTSUPP;
+	}
+
+	adapter->ptp = kzalloc(sizeof(*adapter->ptp), GFP_KERNEL);
+	if (!adapter->ptp)
+		return -ENOMEM;
+
+	/* add a back pointer to adapter */
+	adapter->ptp->adapter = adapter;
+
+	err = idpf_ptp_create_clock(adapter);
+	if (err)
+		goto free_ptp;
+
+	pci_dbg(adapter->pdev, "PTP init successful\n");
+
+	return 0;
+
+free_ptp:
+	kfree(adapter->ptp);
+	adapter->ptp = NULL;
+
+	return err;
+}
+
+/**
+ * idpf_ptp_release - Clear PTP hardware clock support
+ * @adapter: Driver specific private structure
+ */
+void idpf_ptp_release(struct idpf_adapter *adapter)
+{
+	struct idpf_ptp *ptp = adapter->ptp;
+
+	if (!ptp)
+		return;
+
+	if (ptp->clock)
+		ptp_clock_unregister(ptp->clock);
+
+	kfree(ptp);
+	adapter->ptp = NULL;
+}
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.h b/drivers/net/ethernet/intel/idpf/idpf_ptp.h
new file mode 100644
index 000000000000..d009417bf947
--- /dev/null
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2024 Intel Corporation */
+
+#ifndef _IDPF_PTP_H
+#define _IDPF_PTP_H
+
+#include <linux/ptp_clock_kernel.h>
+
+/**
+ * struct idpf_ptp - PTP parameters
+ * @info: structure defining PTP hardware capabilities
+ * @clock: pointer to registered PTP clock device
+ * @adapter: back pointer to the adapter
+ */
+struct idpf_ptp {
+	struct ptp_clock_info info;
+	struct ptp_clock *clock;
+	struct idpf_adapter *adapter;
+};
+
+#if IS_ENABLED(CONFIG_PTP_1588_CLOCK)
+int idpf_ptp_init(struct idpf_adapter *adapter);
+void idpf_ptp_release(struct idpf_adapter *adapter);
+#else /* CONFIG_PTP_1588_CLOCK */
+static inline int idpf_ptp_init(struct idpf_adapter *adapter)
+{
+	return 0;
+}
+
+static inline void idpf_ptp_release(struct idpf_adapter *adapter) { }
+#endif /* CONFIG_PTP_1588_CLOCK */
+#endif /* _IDPF_PTP_H */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 3d2413b8684f..1d42f8aee4aa 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -5,6 +5,7 @@
 
 #include "idpf.h"
 #include "idpf_virtchnl.h"
+#include "idpf_ptp.h"
 
 #define IDPF_VC_XN_MIN_TIMEOUT_MSEC	2000
 #define IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC	(60 * 1000)
@@ -900,7 +901,8 @@ static int idpf_send_get_caps_msg(struct idpf_adapter *adapter)
 			    VIRTCHNL2_CAP_MACFILTER		|
 			    VIRTCHNL2_CAP_SPLITQ_QSCHED		|
 			    VIRTCHNL2_CAP_PROMISC		|
-			    VIRTCHNL2_CAP_LOOPBACK);
+			    VIRTCHNL2_CAP_LOOPBACK		|
+			    VIRTCHNL2_CAP_PTP);
 
 	xn_params.vc_op = VIRTCHNL2_OP_GET_CAPS;
 	xn_params.send_buf.iov_base = &caps;
@@ -3029,6 +3031,11 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
 		goto err_intr_req;
 	}
 
+	err = idpf_ptp_init(adapter);
+	if (err)
+		pci_err(adapter->pdev, "PTP init failed, err=%pe\n",
+			ERR_PTR(err));
+
 	idpf_init_avail_queues(adapter);
 
 	/* Skew the delay for init tasks for each function based on fn number
@@ -3091,6 +3098,7 @@ void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 	if (!remove_in_prog)
 		idpf_vc_xn_shutdown(adapter->vcxn_mngr);
 
+	idpf_ptp_release(adapter);
 	idpf_deinit_task(adapter);
 	idpf_intr_rel(adapter);
 
-- 
2.47.1


