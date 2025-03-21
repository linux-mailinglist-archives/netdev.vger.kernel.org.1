Return-Path: <netdev+bounces-176644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FF2A6B2DE
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 03:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7C3519C4382
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 02:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81961E32A0;
	Fri, 21 Mar 2025 02:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fOky5stL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE6C1E47A3
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 02:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742523330; cv=none; b=UQpImXdZkC0UBcRiIu7yXjKMFJEf9fxBTvsoR6wlHJVOrlAnbm1qOOAfROjrVEIrs9p23KO2rRN7OX9swIPtliUHRDl74QFor8FnacJLwHYw9/9OgPttrJdzuymUUbROwDF5CQh0dDtIpI3oMsfK1WJ2yRQhZU2fso80KyggTts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742523330; c=relaxed/simple;
	bh=drhvhcKBoGZtRl6QfejZkW+td+oLbR3poNPRXWuaRtU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qy05+TFV9C9NhYbtzocZUZCrxXCmcTpSnDK5P+IDxV+c924pcTTJsU2muWOdO08bN8QF8WaKAmfRzpNOtfFi//EIpOcbtvku4ye1hKsA6cGhxJS4H5d4kCnrmOCOcmtItF+bPB/RZrymKkccQPFQCsYWnViQzFn/2MYc4/tbVlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fOky5stL; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff7aecba07so2163829a91.2
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 19:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742523327; x=1743128127; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2nzcG6s8hDrL49Gg/Zf+DYZp+iDMq8jQuSDefJRUON8=;
        b=fOky5stLTyVoauhWnHrNzA4UhoaodIUT0F+klN2of5jOW8zTpc40yJCluqFkNdqdmw
         +GZUlno/QB3NnV+sR3dg8H2zc7kxr2oCHU+/iCfNC78ipKcbJXDKeKH7Lxs6/qpi3Pnm
         EBD4gescJnxb6ptyIGqIoYKwoZaia5no+mQSyN5qPK7t38I1riOki/bcfQ0TlcDbk5vp
         GHM+Ba/7tO/mWGq8vjoMrErPuR3gRnYyHRD+0XEndxDQmnJm78NNbZzDlDXrpvWOmSVl
         ngFIy1YOWjvhk8903p8e/78XDQ1mra90GEO/ym8g9gdj/hdlhHOpf4pa31PsgOMhLWJ8
         Z5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742523327; x=1743128127;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2nzcG6s8hDrL49Gg/Zf+DYZp+iDMq8jQuSDefJRUON8=;
        b=aiKAeF0hqN6SgQB98pAOfyHAlrrz3WLDlqjYJwapxQFEbW03KcuYNNZq+meiwBuEzU
         WIgvC6ylPouuyx3+2XolmZV4TkCRX4uDQf9wbEKiZ2mLn5cNOTtTQXlr4tAzzJnPFZCF
         6yUIJmQYyPB3wt3BdUNpDxQNWhhs1DjPUT04l0XB0dQiFc72Ck+QJlrsTuHkF/4s9Onh
         sA8hK6eiCg84G15WGhIn8S5aCfA+wFCGsrAQvbyHpiFpUdZzcQ3ULFnrZ5SlgSB8/coS
         2Va2R33oOyY/42kibAica1hYAz7np1vb4htunqB16RHTm64dJYUTWs9Y1aaxqocHQbkf
         SnzA==
X-Gm-Message-State: AOJu0YzE5sVaH7xyB/2+af0BchRRFysWLlqFa3HbdF1PjQFV3EseLAOH
	wC1jYyuhKpMqwDVLdtYsmgn6m3IrR+i4qJQ3QLCrcmBQ5q7s4QGmIEIB41Yl2bRotUaO2CEtZMy
	tlT7sJWAGXQ==
X-Google-Smtp-Source: AGHT+IHD5MPUdIlkUFLjXzZbGNli/Lkhi/X3vUwOWUX8dhqTyK/P6XFnMPU79P1CC8HYqh9jVK4bM0oI/v6htw==
X-Received: from pjh3.prod.google.com ([2002:a17:90b:3f83:b0:2fe:7f7a:74b2])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2545:b0:2ff:682b:b759 with SMTP id 98e67ed59e1d1-3030fe55ac3mr2693032a91.7.1742523326897;
 Thu, 20 Mar 2025 19:15:26 -0700 (PDT)
Date: Fri, 21 Mar 2025 02:15:20 +0000
In-Reply-To: <20250321021521.849856-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250321021521.849856-1-skhawaja@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250321021521.849856-4-skhawaja@google.com>
Subject: [PATCH net-next v4 3/4] Extend napi threaded polling to allow kthread
 based busy polling
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, jdamato@fastly.com, mkarsten@uwaterloo.ca
Cc: netdev@vger.kernel.org, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

Add a new state to napi state enum:

- STATE_THREADED_BUSY_POLL
  Threaded busy poll is enabled/running for this napi.

Following changes are introduced in the napi scheduling and state logic:

- When threaded busy poll is enabled through sysfs it also enables
  NAPI_STATE_THREADED so a kthread is created per napi. It also sets
  NAPI_STATE_THREADED_BUSY_POLL bit on each napi to indicate that we are
  supposed to busy poll for each napi.

- When napi is scheduled with STATE_SCHED_THREADED and associated
  kthread is woken up, the kthread owns the context. If
  NAPI_STATE_THREADED_BUSY_POLL and NAPI_SCHED_THREADED both are set
  then it means that we can busy poll.

- To keep busy polling and to avoid scheduling of the interrupts, the
  napi_complete_done returns false when both SCHED_THREADED and
  THREADED_BUSY_POLL flags are set. Also napi_complete_done returns
  early to avoid the STATE_SCHED_THREADED being unset.

- If at any point STATE_THREADED_BUSY_POLL is unset, the
  napi_complete_done will run and unset the SCHED_THREADED bit also.
  This will make the associated kthread go to sleep as per existing
  logic.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 Documentation/ABI/testing/sysfs-class-net     |  3 +-
 Documentation/netlink/specs/netdev.yaml       | 12 ++-
 Documentation/networking/napi.rst             | 67 ++++++++++++-
 .../net/ethernet/atheros/atl1c/atl1c_main.c   |  2 +-
 drivers/net/ethernet/mellanox/mlxsw/pci.c     |  2 +-
 drivers/net/ethernet/renesas/ravb_main.c      |  2 +-
 drivers/net/wireless/ath/ath10k/snoc.c        |  2 +-
 include/linux/netdevice.h                     | 20 +++-
 include/uapi/linux/netdev.h                   |  6 ++
 net/core/dev.c                                | 93 ++++++++++++++++---
 net/core/net-sysfs.c                          |  2 +-
 net/core/netdev-genl-gen.c                    |  2 +-
 net/core/netdev-genl.c                        |  2 +-
 tools/include/uapi/linux/netdev.h             |  6 ++
 14 files changed, 188 insertions(+), 33 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-net b/Documentation/ABI/testing/sysfs-class-net
index ebf21beba846..15d7d36a8294 100644
--- a/Documentation/ABI/testing/sysfs-class-net
+++ b/Documentation/ABI/testing/sysfs-class-net
@@ -343,7 +343,7 @@ Date:		Jan 2021
 KernelVersion:	5.12
 Contact:	netdev@vger.kernel.org
 Description:
-		Boolean value to control the threaded mode per device. User could
+		Integer value to control the threaded mode per device. User could
 		set this value to enable/disable threaded mode for all napi
 		belonging to this device, without the need to do device up/down.
 
@@ -351,4 +351,5 @@ Description:
 		== ==================================
 		0  threaded mode disabled for this dev
 		1  threaded mode enabled for this dev
+		2  threaded mode enabled, and busy polling enabled.
 		== ==================================
diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 92f98f2a6bd7..650179559558 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -82,6 +82,10 @@ definitions:
     name: qstats-scope
     type: flags
     entries: [ queue ]
+  -
+    name: napi-threaded
+    type: enum
+    entries: [ disable, enable, busy-poll-enable ]
 
 attribute-sets:
   -
@@ -283,11 +287,11 @@ attribute-sets:
       -
         name: threaded
         doc: Whether the napi is configured to operate in threaded polling
-             mode. If this is set to `1` then the NAPI context operates
-             in threaded polling mode.
+             mode. If this is set to `enable` then the NAPI context operates
+             in threaded polling mode. If this is set to `busy-poll-enable`
+             then the NAPI kthread also does busypolling.
         type: u32
-        checks:
-          max: 1
+        enum: napi-threaded
   -
     name: xsk-info
     attributes: []
diff --git a/Documentation/networking/napi.rst b/Documentation/networking/napi.rst
index 63f98c05860f..0f83142c624d 100644
--- a/Documentation/networking/napi.rst
+++ b/Documentation/networking/napi.rst
@@ -263,7 +263,9 @@ are not well known).
 Busy polling is enabled by either setting ``SO_BUSY_POLL`` on
 selected sockets or using the global ``net.core.busy_poll`` and
 ``net.core.busy_read`` sysctls. An io_uring API for NAPI busy polling
-also exists.
+also exists. Threaded polling of NAPI also has a mode to busy poll for
+packets (:ref:`threaded busy polling<threaded_busy_poll>`) using the same
+thread that is used for NAPI processing.
 
 epoll-based busy polling
 ------------------------
@@ -426,6 +428,69 @@ Therefore, setting ``gro_flush_timeout`` and ``napi_defer_hard_irqs`` is
 the recommended usage, because otherwise setting ``irq-suspend-timeout``
 might not have any discernible effect.
 
+.. _threaded_busy_poll:
+
+Threaded NAPI busy polling
+--------------------------
+
+Threaded napi allows processing of packets from each NAPI in a kthread in
+kernel. Threaded napi busy polling extends this and adds support to do
+continuous busy polling of this napi. This can be used to enable busy polling
+independent of userspace application or the API (epoll, io_uring, raw sockets)
+being used in userspace to process the packets.
+
+It can be enabled for each NAPI using netlink interface or at device level using
+the threaded NAPI sysctl.
+
+For example, using following script:
+
+.. code-block:: bash
+
+  $ kernel-source/tools/net/ynl/pyynl/cli.py \
+            --spec Documentation/netlink/specs/netdev.yaml \
+            --do napi-set \
+            --json='{"id": 66,
+                     "threaded": "busy-poll-enable"}'
+
+
+Enabling it for each NAPI allows finer control to enable busy pollling for
+only a set of NIC queues which will get traffic with low latency requirements.
+
+Depending on application requirement, user might want to set affinity of the
+kthread that is busy polling each NAPI. User might also want to set priority
+and the scheduler of the thread depending on the latency requirements.
+
+For a hard low-latency application, user might want to dedicate the full core
+for the NAPI polling so the NIC queue descriptors are picked up from the queue
+as soon as they appear. For more relaxed low-latency requirement, user might
+want to share the core with other threads.
+
+Once threaded busy polling is enabled for a NAPI, PID of the kthread can be
+fetched using netlink interface so the affinity, priority and scheduler
+configuration can be done.
+
+For example, following script can be used to fetch the pid:
+
+.. code-block:: bash
+
+  $ kernel-source/tools/net/ynl/pyynl/cli.py \
+            --spec Documentation/netlink/specs/netdev.yaml \
+            --do napi-get \
+            --json='{"id": 66}'
+
+This will output something like following, the pid `258` is the PID of the
+kthread that is polling this NAPI.
+
+.. code-block:: bash
+
+  $ {'defer-hard-irqs': 0,
+     'gro-flush-timeout': 0,
+     'id': 66,
+     'ifindex': 2,
+     'irq-suspend-timeout': 0,
+     'pid': 258,
+     'threaded': 'enable'}
+
 .. _threaded:
 
 Threaded NAPI
diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
index c571614b1d50..513328476770 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -2688,7 +2688,7 @@ static int atl1c_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	adapter->mii.mdio_write = atl1c_mdio_write;
 	adapter->mii.phy_id_mask = 0x1f;
 	adapter->mii.reg_num_mask = MDIO_CTRL_REG_MASK;
-	dev_set_threaded(netdev, true);
+	dev_set_threaded(netdev, NETDEV_NAPI_THREADED_ENABLE);
 	for (i = 0; i < adapter->rx_queue_count; ++i)
 		netif_napi_add(netdev, &adapter->rrd_ring[i].napi,
 			       atl1c_clean_rx);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 058dcabfaa2e..2ed3b9263be2 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -156,7 +156,7 @@ static int mlxsw_pci_napi_devs_init(struct mlxsw_pci *mlxsw_pci)
 	}
 	strscpy(mlxsw_pci->napi_dev_rx->name, "mlxsw_rx",
 		sizeof(mlxsw_pci->napi_dev_rx->name));
-	dev_set_threaded(mlxsw_pci->napi_dev_rx, true);
+	dev_set_threaded(mlxsw_pci->napi_dev_rx, NETDEV_NAPI_THREADED_ENABLE);
 
 	return 0;
 
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index c9f4976a3527..12e4f68c0c8f 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -3075,7 +3075,7 @@ static int ravb_probe(struct platform_device *pdev)
 	if (info->coalesce_irqs) {
 		netdev_sw_irq_coalesce_default_on(ndev);
 		if (num_present_cpus() == 1)
-			dev_set_threaded(ndev, true);
+			dev_set_threaded(ndev, NETDEV_NAPI_THREADED_ENABLE);
 	}
 
 	/* Network device register */
diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index d436a874cd5a..52e0de8c3069 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -935,7 +935,7 @@ static int ath10k_snoc_hif_start(struct ath10k *ar)
 
 	bitmap_clear(ar_snoc->pending_ce_irqs, 0, CE_COUNT_MAX);
 
-	dev_set_threaded(ar->napi_dev, true);
+	dev_set_threaded(ar->napi_dev, NETDEV_NAPI_THREADED_ENABLE);
 	ath10k_core_napi_enable(ar);
 	ath10k_snoc_irq_enable(ar);
 	ath10k_snoc_rx_post(ar);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 3c244fd9ae6d..b990cbe76f86 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -369,7 +369,7 @@ struct napi_config {
 	u64 irq_suspend_timeout;
 	u32 defer_hard_irqs;
 	cpumask_t affinity_mask;
-	bool threaded;
+	u8 threaded;
 	unsigned int napi_id;
 };
 
@@ -427,6 +427,8 @@ enum {
 	NAPI_STATE_THREADED,		/* The poll is performed inside its own thread*/
 	NAPI_STATE_SCHED_THREADED,	/* Napi is currently scheduled in threaded mode */
 	NAPI_STATE_HAS_NOTIFIER,	/* Napi has an IRQ notifier */
+	NAPI_STATE_THREADED_BUSY_POLL,	/* The threaded napi poller will busy poll */
+	NAPI_STATE_SCHED_THREADED_BUSY_POLL,  /* The threaded napi poller is busy polling */
 };
 
 enum {
@@ -441,8 +443,14 @@ enum {
 	NAPIF_STATE_THREADED		= BIT(NAPI_STATE_THREADED),
 	NAPIF_STATE_SCHED_THREADED	= BIT(NAPI_STATE_SCHED_THREADED),
 	NAPIF_STATE_HAS_NOTIFIER	= BIT(NAPI_STATE_HAS_NOTIFIER),
+	NAPIF_STATE_THREADED_BUSY_POLL	= BIT(NAPI_STATE_THREADED_BUSY_POLL),
+	NAPIF_STATE_SCHED_THREADED_BUSY_POLL  =
+			BIT(NAPI_STATE_SCHED_THREADED_BUSY_POLL),
 };
 
+#define NAPIF_STATE_THREADED_BUSY_POLL_MASK \
+	(NAPIF_STATE_THREADED | NAPIF_STATE_THREADED_BUSY_POLL)
+
 enum gro_result {
 	GRO_MERGED,
 	GRO_MERGED_FREE,
@@ -589,16 +597,18 @@ static inline bool napi_complete(struct napi_struct *n)
 	return napi_complete_done(n, 0);
 }
 
-int dev_set_threaded(struct net_device *dev, bool threaded);
+int dev_set_threaded(struct net_device *dev,
+		     enum netdev_napi_threaded threaded);
 
 /*
  * napi_set_threaded - set napi threaded state
  * @napi: NAPI context
- * @threaded: whether this napi does threaded polling
+ * @threaded: threading mode
  *
  * Return 0 on success and negative errno on failure.
  */
-int napi_set_threaded(struct napi_struct *napi, bool threaded);
+int napi_set_threaded(struct napi_struct *napi,
+		      enum netdev_napi_threaded threaded);
 
 void napi_disable(struct napi_struct *n);
 void napi_disable_locked(struct napi_struct *n);
@@ -2432,7 +2442,7 @@ struct net_device {
 	struct sfp_bus		*sfp_bus;
 	struct lock_class_key	*qdisc_tx_busylock;
 	bool			proto_down;
-	bool			threaded;
+	u8			threaded;
 	bool			irq_affinity_auto;
 	bool			rx_cpu_rmap_auto;
 
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index fac1b8ffeb55..b9b59d60957f 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -77,6 +77,12 @@ enum netdev_qstats_scope {
 	NETDEV_QSTATS_SCOPE_QUEUE = 1,
 };
 
+enum netdev_napi_threaded {
+	NETDEV_NAPI_THREADED_DISABLE,
+	NETDEV_NAPI_THREADED_ENABLE,
+	NETDEV_NAPI_THREADED_BUSY_POLL_ENABLE,
+};
+
 enum {
 	NETDEV_A_DEV_IFINDEX = 1,
 	NETDEV_A_DEV_PAD,
diff --git a/net/core/dev.c b/net/core/dev.c
index cc746f223554..8323782541fa 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -78,6 +78,7 @@
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/sched/isolation.h>
+#include <linux/sched/types.h>
 #include <linux/sched/mm.h>
 #include <linux/smpboot.h>
 #include <linux/mutex.h>
@@ -6436,7 +6437,8 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 	 *    the guarantee we will be called later.
 	 */
 	if (unlikely(n->state & (NAPIF_STATE_NPSVC |
-				 NAPIF_STATE_IN_BUSY_POLL)))
+				 NAPIF_STATE_IN_BUSY_POLL |
+				 NAPIF_STATE_SCHED_THREADED_BUSY_POLL)))
 		return false;
 
 	if (work_done) {
@@ -6811,7 +6813,21 @@ static enum hrtimer_restart napi_watchdog(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
-int napi_set_threaded(struct napi_struct *napi, bool threaded)
+static void napi_set_threaded_state(struct napi_struct *napi,
+				    enum netdev_napi_threaded threaded)
+{
+	unsigned long val;
+
+	val = 0;
+	if (threaded == NETDEV_NAPI_THREADED_BUSY_POLL_ENABLE)
+		val |= NAPIF_STATE_THREADED_BUSY_POLL;
+	if (threaded)
+		val |= NAPIF_STATE_THREADED;
+	set_mask_bits(&napi->state, NAPIF_STATE_THREADED_BUSY_POLL_MASK, val);
+}
+
+int napi_set_threaded(struct napi_struct *napi,
+		      enum netdev_napi_threaded threaded)
 {
 	if (napi->dev->threaded)
 		return -EINVAL;
@@ -6830,14 +6846,15 @@ int napi_set_threaded(struct napi_struct *napi, bool threaded)
 
 	/* Make sure kthread is created before THREADED bit is set. */
 	smp_mb__before_atomic();
-	assign_bit(NAPI_STATE_THREADED, &napi->state, threaded);
+	napi_set_threaded_state(napi, threaded);
 
 	return 0;
 }
 
-int dev_set_threaded(struct net_device *dev, bool threaded)
+int dev_set_threaded(struct net_device *dev, enum netdev_napi_threaded threaded)
 {
 	struct napi_struct *napi;
+	unsigned long val;
 	int err = 0;
 
 	netdev_assert_locked_or_invisible(dev);
@@ -6845,17 +6862,22 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
 	if (dev->threaded == threaded)
 		return 0;
 
+	val = 0;
 	if (threaded) {
 		/* Check if threaded is set at napi level already */
 		list_for_each_entry(napi, &dev->napi_list, dev_list)
 			if (test_bit(NAPI_STATE_THREADED, &napi->state))
 				return -EINVAL;
 
+		val |= NAPIF_STATE_THREADED;
+		if (threaded == NETDEV_NAPI_THREADED_BUSY_POLL_ENABLE)
+			val |= NAPIF_STATE_THREADED_BUSY_POLL;
+
 		list_for_each_entry(napi, &dev->napi_list, dev_list) {
 			if (!napi->thread) {
 				err = napi_kthread_create(napi);
 				if (err) {
-					threaded = false;
+					threaded = NETDEV_NAPI_THREADED_DISABLE;
 					break;
 				}
 			}
@@ -6874,9 +6896,13 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
 	 * polled. In this case, the switch between threaded mode and
 	 * softirq mode will happen in the next round of napi_schedule().
 	 * This should not cause hiccups/stalls to the live traffic.
+	 *
+	 * Switch to busy_poll threaded napi will occur after the threaded
+	 * napi is scheduled.
 	 */
 	list_for_each_entry(napi, &dev->napi_list, dev_list)
-		assign_bit(NAPI_STATE_THREADED, &napi->state, threaded);
+		set_mask_bits(&napi->state,
+			      NAPIF_STATE_THREADED_BUSY_POLL_MASK, val);
 
 	return err;
 }
@@ -7196,8 +7222,12 @@ void netif_napi_add_weight_locked(struct net_device *dev,
 	 * Clear dev->threaded if kthread creation failed so that
 	 * threaded mode will not be enabled in napi_enable().
 	 */
-	if (dev->threaded && napi_kthread_create(napi))
-		dev->threaded = false;
+	if (dev->threaded) {
+		if (napi_kthread_create(napi))
+			dev->threaded = false;
+		else
+			napi_set_threaded_state(napi, dev->threaded);
+	}
 	netif_napi_set_irq_locked(napi, -1);
 }
 EXPORT_SYMBOL(netif_napi_add_weight_locked);
@@ -7219,7 +7249,9 @@ void napi_disable_locked(struct napi_struct *n)
 		}
 
 		new = val | NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC;
-		new &= ~(NAPIF_STATE_THREADED | NAPIF_STATE_PREFER_BUSY_POLL);
+		new &= ~(NAPIF_STATE_THREADED
+			 | NAPIF_STATE_THREADED_BUSY_POLL
+			 | NAPIF_STATE_PREFER_BUSY_POLL);
 	} while (!try_cmpxchg(&n->state, &val, new));
 
 	hrtimer_cancel(&n->timer);
@@ -7263,7 +7295,7 @@ void napi_enable_locked(struct napi_struct *n)
 
 		new = val & ~(NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC);
 		if (n->dev->threaded && n->thread)
-			new |= NAPIF_STATE_THREADED;
+			napi_set_threaded_state(n, n->dev->threaded);
 	} while (!try_cmpxchg(&n->state, &val, new));
 }
 EXPORT_SYMBOL(napi_enable_locked);
@@ -7425,7 +7457,7 @@ static int napi_thread_wait(struct napi_struct *napi)
 	return -1;
 }
 
-static void napi_threaded_poll_loop(struct napi_struct *napi)
+static void napi_threaded_poll_loop(struct napi_struct *napi, bool busy_poll)
 {
 	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	struct softnet_data *sd;
@@ -7454,22 +7486,53 @@ static void napi_threaded_poll_loop(struct napi_struct *napi)
 		}
 		skb_defer_free_flush(sd);
 		bpf_net_ctx_clear(bpf_net_ctx);
+
+		/* Push the skbs up the stack if busy polling. */
+		if (busy_poll)
+			__napi_gro_flush_helper(napi);
 		local_bh_enable();
 
-		if (!repoll)
+		/* If busy polling then do not break here because we need to
+		 * call cond_resched and rcu_softirq_qs_periodic to prevent
+		 * watchdog warnings.
+		 */
+		if (!repoll && !busy_poll)
 			break;
 
 		rcu_softirq_qs_periodic(last_qs);
 		cond_resched();
+
+		if (!repoll)
+			break;
 	}
 }
 
 static int napi_threaded_poll(void *data)
 {
 	struct napi_struct *napi = data;
+	bool busy_poll_sched;
+	unsigned long val;
+	bool busy_poll;
+
+	while (!napi_thread_wait(napi)) {
+		/* Once woken up, this means that we are scheduled as threaded
+		 * napi and this thread owns the napi context, if busy poll
+		 * state is set then we busy poll this napi.
+		 */
+		val = READ_ONCE(napi->state);
+		busy_poll = val & NAPIF_STATE_THREADED_BUSY_POLL;
+		busy_poll_sched = val & NAPIF_STATE_SCHED_THREADED_BUSY_POLL;
 
-	while (!napi_thread_wait(napi))
-		napi_threaded_poll_loop(napi);
+		/* Do not busy poll if napi is disabled. */
+		if (unlikely(val & NAPIF_STATE_DISABLE))
+			busy_poll = false;
+
+		if (busy_poll != busy_poll_sched)
+			assign_bit(NAPI_STATE_SCHED_THREADED_BUSY_POLL,
+				   &napi->state, busy_poll);
+
+		napi_threaded_poll_loop(napi, busy_poll);
+	}
 
 	return 0;
 }
@@ -12637,7 +12700,7 @@ static void run_backlog_napi(unsigned int cpu)
 {
 	struct softnet_data *sd = per_cpu_ptr(&softnet_data, cpu);
 
-	napi_threaded_poll_loop(&sd->backlog);
+	napi_threaded_poll_loop(&sd->backlog, false);
 }
 
 static void backlog_napi_setup(unsigned int cpu)
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index abaa1c919b98..d3ccd04960fb 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -741,7 +741,7 @@ static int modify_napi_threaded(struct net_device *dev, unsigned long val)
 	if (list_empty(&dev->napi_list))
 		return -EOPNOTSUPP;
 
-	if (val != 0 && val != 1)
+	if (val > NETDEV_NAPI_THREADED_BUSY_POLL_ENABLE)
 		return -EOPNOTSUPP;
 
 	ret = dev_set_threaded(dev, val);
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index c2e5cee857d2..1dbe5f19a192 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -97,7 +97,7 @@ static const struct nla_policy netdev_napi_set_nl_policy[NETDEV_A_NAPI_THREADED
 	[NETDEV_A_NAPI_DEFER_HARD_IRQS] = NLA_POLICY_FULL_RANGE(NLA_U32, &netdev_a_napi_defer_hard_irqs_range),
 	[NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT] = { .type = NLA_UINT, },
 	[NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT] = { .type = NLA_UINT, },
-	[NETDEV_A_NAPI_THREADED] = NLA_POLICY_MAX(NLA_U32, 1),
+	[NETDEV_A_NAPI_THREADED] = NLA_POLICY_MAX(NLA_U32, 2),
 };
 
 /* Ops table for netdev */
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 057001c3bbba..e540475290ca 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -332,7 +332,7 @@ netdev_nl_napi_set_config(struct napi_struct *napi, struct genl_info *info)
 
 	if (info->attrs[NETDEV_A_NAPI_THREADED]) {
 		threaded = nla_get_u32(info->attrs[NETDEV_A_NAPI_THREADED]);
-		napi_set_threaded(napi, !!threaded);
+		napi_set_threaded(napi, threaded);
 	}
 
 	if (info->attrs[NETDEV_A_NAPI_DEFER_HARD_IRQS]) {
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index fac1b8ffeb55..b9b59d60957f 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -77,6 +77,12 @@ enum netdev_qstats_scope {
 	NETDEV_QSTATS_SCOPE_QUEUE = 1,
 };
 
+enum netdev_napi_threaded {
+	NETDEV_NAPI_THREADED_DISABLE,
+	NETDEV_NAPI_THREADED_ENABLE,
+	NETDEV_NAPI_THREADED_BUSY_POLL_ENABLE,
+};
+
 enum {
 	NETDEV_A_DEV_IFINDEX = 1,
 	NETDEV_A_DEV_PAD,
-- 
2.49.0.395.g12beb8f557-goog


