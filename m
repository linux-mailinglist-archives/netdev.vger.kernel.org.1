Return-Path: <netdev+bounces-284027-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEaXKkny+GnJ3QIAu9opvQ
	(envelope-from <netdev+bounces-284027-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 21:23:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 312C34C3311
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 21:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 56F24300F774
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 19:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C803FA5C9;
	Mon,  4 May 2026 19:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YLLQaob9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C482D3ED1;
	Mon,  4 May 2026 19:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777922612; cv=none; b=l1oyO1VVIlN8DgrAWGTiLu1SLPwqRSEa7Ilr5BJcaRV9BkF5yr9kQPkVor0kIdSdfWApZT1p5kLkORZ0BIYU/KX+aLGUUnV2ZGQD0WfZ+l46uyZQuSre/czUPADYlsvjc4KdOxuUjWOQO84KwviOHGQpxaSLSesimAHwwjUvX8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777922612; c=relaxed/simple;
	bh=2PcAiHZvuzlXOrAPNoxt7VKMuWTJqscxowIzWExA4Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N1LGP1frxu3n7SC6mX5QYQvizum8kkieYBGgbMmXk/KRZl4qubCI7Tx+HFfgp57NdkRAGUZy8QsdXQ8w1TWwPnf7hUxBCyXkevwAYXwa6a9M/RqO0Nep2hux7E+bWngpR40M+Uel56SGbTsCf4Xco+PH6RS3xNOpHKdus+fOa5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YLLQaob9; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777922609; x=1809458609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2PcAiHZvuzlXOrAPNoxt7VKMuWTJqscxowIzWExA4Dw=;
  b=YLLQaob9RnLreBBKRX6cwNNE+mYYqRUpRqxrQRhVEI3/Gc8NvUqA8VYA
   BvHyaFaY3zFPDTee7pqjHc6spWwMW0b0pK7BqNPjXtD9OuqKxxnDzWxwF
   21RplB0lJ6wqG4Qc4e+EXdNizS1PFF2HJb6ZHSlOkU8KFz6u0jcz6tBnY
   Ggir4UXSZHeSqROZSPCT0iJK2n1S5TyVfMBHP28ekEo7heT8sF3l2hO/6
   Uu1pkjRdHG29m6lJOoALlmKzBvtiwCDpdfVmp+ApXQllql2rizvZ5W8rH
   OCjOH1EYN+FZbiKmhMGpi1tpw9KzysMaq3ZKLHzZPSi6l2iAm/w/Mz70S
   A==;
X-CSE-ConnectionGUID: Cihw073uRVyMxnkCE7sfBg==
X-CSE-MsgGUID: RxtvcI4eRA+fbgPzM6vMfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89482121"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="89482121"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 12:23:29 -0700
X-CSE-ConnectionGUID: ry3rhN9xQV+cTSt7STEMFw==
X-CSE-MsgGUID: RHOHk/7dRsW3fJviYWTtXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="239565881"
Received: from bnilawar-desk2.iind.intel.com ([10.190.239.41])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 12:23:21 -0700
From: Badal Nilawar <badal.nilawar@intel.com>
To: dri-devel@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: badal.nilawar@intel.com,
	rodrigo.vivi@intel.com,
	wojciech.drewek@intel.com,
	michael.brooks@intel.com,
	heikki.krogerus@intel.com,
	michael.j.ruhl@intel.com,
	thomas.hellstrom@linux.intel.com,
	michal.winiarski@intel.com,
	anshuman.gupta@intel.com,
	jacob.e.keller@intel.com,
	maarten.lankhorst@linux.intel.com,
	matthew.brost@intel.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	singaravelan.nallasellan@intel.com,
	kelvin.gardiner@intel.com,
	jk@codeconstruct.com.au,
	matt@codeconstruct.com.au,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	james.ausmus@intel.com
Subject: [RFC PATCH 1/1] xe/xe_mctp_mailbox: Add support for MCTP transport over mailbox
Date: Tue,  5 May 2026 01:04:22 +0530
Message-ID: <20260504193420.1232842-4-badal.nilawar@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504193420.1232842-3-badal.nilawar@intel.com>
References: <20260504193420.1232842-3-badal.nilawar@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 312C34C3311
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284027-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[badal.nilawar@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid,work.work:url]

Add support for MCTP transport over the Intel vendor-specific mailbox
protocol to enable in-band firmware updates for GPU/AMC via PLDM

Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
---
 drivers/gpu/drm/xe/Makefile          |   1 +
 drivers/gpu/drm/xe/xe_device.c       |   3 +
 drivers/gpu/drm/xe/xe_device_types.h |   4 +
 drivers/gpu/drm/xe/xe_mctp_mailbox.c | 186 +++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_mctp_mailbox.h |  14 ++
 5 files changed, 208 insertions(+)
 create mode 100644 drivers/gpu/drm/xe/xe_mctp_mailbox.c
 create mode 100644 drivers/gpu/drm/xe/xe_mctp_mailbox.h

diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
index 09661f079d03..d427152bc3fd 100644
--- a/drivers/gpu/drm/xe/Makefile
+++ b/drivers/gpu/drm/xe/Makefile
@@ -89,6 +89,7 @@ xe-y += xe_bb.o \
 	xe_late_bind_fw.o \
 	xe_lrc.o \
 	xe_mem_pool.o \
+	xe_mctp_mailbox.o \
 	xe_migrate.o \
 	xe_mmio.o \
 	xe_mmio_gem.o \
diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 4b45b617a039..ebf456f580d1 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -49,6 +49,7 @@
 #include "xe_i2c.h"
 #include "xe_irq.h"
 #include "xe_late_bind_fw.h"
+#include "xe_mctp_mailbox.h"
 #include "xe_mmio.h"
 #include "xe_module.h"
 #include "xe_nvm.h"
@@ -1065,6 +1066,8 @@ int xe_device_probe(struct xe_device *xe)
 	for_each_gt(gt, xe, id)
 		xe_gt_sanitize_freq(gt);
 
+	xe_mctp_mailbox_init(xe);
+
 	xe_vsec_init(xe);
 
 	err = xe_sriov_init_late(xe);
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 89437de3001a..9cfe70428c71 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -38,6 +38,7 @@
 struct drm_pagemap_shrinker;
 struct intel_display;
 struct intel_dg_nvm_dev;
+struct xe_mctp_mailbox;
 struct xe_ggtt;
 struct xe_i2c;
 struct xe_pat_ops;
@@ -500,6 +501,9 @@ struct xe_device {
 		struct llist_head async_list;
 	} bo_device;
 
+	/** @mctp_mailbox: mctp mailbox */
+	struct xe_mctp_mailbox *mctp_mailbox;
+
 	/** @pmu: performance monitoring unit */
 	struct xe_pmu pmu;
 
diff --git a/drivers/gpu/drm/xe/xe_mctp_mailbox.c b/drivers/gpu/drm/xe/xe_mctp_mailbox.c
new file mode 100644
index 000000000000..f1a81208a9a1
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_mctp_mailbox.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: MIT
+/*
+ * MCTP-over-MAILBOX transport for Xe.
+ *
+ * Copyright 2026 Intel Corporation
+ */
+
+#include "xe_device_types.h"
+
+#include <linux/netdevice.h>
+#include <linux/jiffies.h>
+#include <linux/workqueue.h>
+
+#include <net/mctp.h>
+#include <net/mctpdevice.h>
+#include <net/pkt_sched.h>
+
+#include <uapi/linux/if_arp.h>
+
+#include "xe_mctp_mailbox.h"
+
+#define XE_MCTP_MAILBOX_RX_POLL_MS 100
+
+/** @mctp_mailbox: Struct for mctp over mailbox */
+struct xe_mctp_mailbox {
+	/** @mctp_mailbox.netdev: network device  */
+	struct net_device *netdev;
+	/** @running: true while netdev is opened */
+	bool running;
+	/** @work: worker to handle mctp requests from firmware */
+	struct delayed_work work;
+	/** @wq: workqueue to schecdule mctp rx worker */
+	struct workqueue_struct *wq;
+};
+
+/*
+ * mailbox protocol is interrupt free so for receive path i.e. endpoint to host
+ * there is no irq available so rx handler need to be polled in worker periodically.
+ */
+static void mctp_mailbox_rx_handler(struct work_struct *work)
+{
+	struct xe_mctp_mailbox *mctp_mailbox =
+		container_of(work, struct xe_mctp_mailbox, work.work);
+	struct net_device *netdev = mctp_mailbox->netdev;
+
+	if (!netdev)
+		return;
+
+	dev_hold(netdev);
+
+	/*
+	 * if (mctp_mailbox_rx_ready()) {
+	 * Get data over MAILBOX
+	 * Allocate skb and copy rx data to skb
+	 * Queue skb to upper layer
+	 * netif_rx(skb);
+	}
+	 */
+	dev_put(netdev);
+
+	if (mctp_mailbox->running)
+		queue_delayed_work(mctp_mailbox->wq, &mctp_mailbox->work,
+				   msecs_to_jiffies(XE_MCTP_MAILBOX_RX_POLL_MS));
+}
+
+static netdev_tx_t mctp_mailbox_start_xmit(struct sk_buff *skb,
+					   struct net_device *dev)
+{
+	/* RFC stub: send skb over MAILBOX */
+	dev_dstats_tx_dropped(dev);
+	kfree_skb(skb);
+
+	return NETDEV_TX_OK;
+}
+
+static int mctp_mailbox_open(struct net_device *dev)
+{
+	struct xe_mctp_mailbox *mctp_mailbox = netdev_priv(dev);
+
+	mctp_mailbox->running = true;
+	netif_start_queue(dev);
+
+	queue_delayed_work(mctp_mailbox->wq, &mctp_mailbox->work, 0);
+
+	return 0;
+}
+
+static int mctp_mailbox_stop(struct net_device *dev)
+{
+	struct xe_mctp_mailbox *mctp_mailbox = netdev_priv(dev);
+
+	mctp_mailbox->running = false;
+	netif_stop_queue(dev);
+
+	cancel_delayed_work_sync(&mctp_mailbox->work);
+	flush_workqueue(mctp_mailbox->wq);
+
+	return 0;
+}
+
+static const struct net_device_ops mctp_mailbox_netdev_ops = {
+	.ndo_start_xmit = mctp_mailbox_start_xmit,
+	.ndo_open = mctp_mailbox_open,
+	.ndo_stop = mctp_mailbox_stop,
+};
+
+static void mctp_mailbox_netdev_setup(struct net_device *dev)
+{
+	/* Populate netdev structure */
+	dev->type = ARPHRD_MCTP;
+	/*
+	 *	dev->mtu = MCTP_MAILBOX_MTU_MIN;
+	 *	dev->min_mtu = MCTP_MAILBOX_MTU_MIN;
+	 *	dev->max_mtu = MCTP_MAILBOX_MTU_MAX;
+	 *
+	 *	dev->hard_header_len = sizeof(struct mctp_mailbox_hdr);
+	 *	dev->tx_queue_len = DEFAULT_TX_QUEUE_LEN;
+	 */
+	dev->flags = IFF_NOARP;
+	dev->netdev_ops = &mctp_mailbox_netdev_ops;
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
+}
+
+static void xe_mctp_mailbox_fini(void *arg)
+{
+	struct xe_device *xe = arg;
+	struct xe_mctp_mailbox *mctp_mailbox = xe->mctp_mailbox;
+	struct net_device *netdev;
+
+	if (!mctp_mailbox)
+		return;
+
+	netdev = mctp_mailbox->netdev;
+	if (!netdev) {
+		xe->mctp_mailbox = NULL;
+		return;
+	}
+
+	if (mctp_mailbox->wq) {
+		mctp_mailbox->running = false;
+		cancel_delayed_work_sync(&mctp_mailbox->work);
+		destroy_workqueue(mctp_mailbox->wq);
+		mctp_mailbox->wq = NULL;
+	}
+
+	xe->mctp_mailbox = NULL;
+	mctp_unregister_netdev(netdev);
+	free_netdev(netdev);
+}
+
+int xe_mctp_mailbox_init(struct xe_device *xe)
+{
+	struct xe_mctp_mailbox *mctp_mailbox;
+	struct net_device *netdev;
+	int ret, err;
+
+	netdev = alloc_netdev(sizeof(*mctp_mailbox), "mctp_mailbox%d", NET_NAME_ENUM,
+			      mctp_mailbox_netdev_setup);
+	if (!netdev)
+		return -ENOMEM;
+
+	SET_NETDEV_DEV(netdev, xe->drm.dev);
+	mctp_mailbox = netdev_priv(netdev);
+	mctp_mailbox->netdev = netdev;
+
+	ret = mctp_register_netdev(netdev, NULL, MCTP_PHYS_BINDING_VENDOR);
+	if (ret) {
+		free_netdev(netdev);
+		return ret;
+	}
+
+	INIT_DELAYED_WORK(&mctp_mailbox->work, mctp_mailbox_rx_handler);
+	mctp_mailbox->wq = alloc_ordered_workqueue("mctp-mailbox-ordered-wq", 0);
+	if (!mctp_mailbox->wq) {
+		mctp_unregister_netdev(netdev);
+		free_netdev(netdev);
+		return -ENOMEM;
+	}
+
+	xe->mctp_mailbox = mctp_mailbox;
+	err = devm_add_action_or_reset(xe->drm.dev, xe_mctp_mailbox_fini, xe);
+	if (err)
+		return err;
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/xe/xe_mctp_mailbox.h b/drivers/gpu/drm/xe/xe_mctp_mailbox.h
new file mode 100644
index 000000000000..318ae173aaa1
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_mctp_mailbox.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ *
+ * Copyright 2026 Intel Corporation
+ */
+
+#ifndef _XE_MCTP_MAILBOX_H_
+#define _XE_MCTP_MAILBOX_H_
+
+struct xe_device;
+
+int xe_mctp_mailbox_init(struct xe_device *xe);
+
+#endif /* _XE_MCTP_MAILBOX_H_ */
-- 
2.54.0


