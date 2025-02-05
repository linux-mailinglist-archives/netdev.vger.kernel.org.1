Return-Path: <netdev+bounces-162811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAF0A27FFF
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 01:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57377166C0D
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 00:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10FC802;
	Wed,  5 Feb 2025 00:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c7rkBCLy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ADB33D8
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 00:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738714260; cv=none; b=G5oHjQ8oHKFgY4axtF2VUpIRdRfBp9Q1fetbmazYzsuMKhqDkDi+nXHoEotTy1IcmlPPhzYR4HzD0sCJCRNqwTACiT4cXrIMLJ5RzMZMLRWmKTFH0Ynz+vSqmQcyIWrPDHol4UrmOXe6X0KYXJfX6RVIPrBDwbQIXIQfbWRU8zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738714260; c=relaxed/simple;
	bh=tQnET/IuQr+enIbUwXJWtSGWpWzV7XpwcQgzo76nwJY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mlWzdCI/7yTmoAUtsS7WGpAyzJ/dPmSHFLaso1QXkVptFIrocE6rDNyRg0v8pIfFebvKw1X7veu7tr+xY5c28J9PN1NMOAxhmNc9Gk6tsvMkpVktJymjcBbmfYEFKBbQVHvm+aq6iCjFJ7D0abHNXnI4G0WOveSjph0h7hWLGUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c7rkBCLy; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-21648c8601cso118525755ad.2
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 16:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738714258; x=1739319058; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RepckqquWV6jnHyzsOLEyp/E9ypnuaZTtTKUZxQ71CQ=;
        b=c7rkBCLy0Xjh7YA7hL0yx0ZC2bmjLsQJzFoZXsVcEz3Kcy3Nea2RiEJPMXzP5hq+YT
         cP0AV4dzfsbVAW0nlmyeCBPd9bnFvMZ3T3ruXcaI669If8OtnoKqA9WLm4cKG2BZsfNk
         yewTOqdin0+yG9ONQ09J6RPbRtdzB/2al3okWDqfRC0oUZctNVG2xZUUR0GKO4rWo2no
         aNS5I0ZWc/1dzQQUdhcvMQu9jToNe1KZUaQFsWWuEudRZ9EibPJq3vF7f/YW1iNeJCpO
         8S3dSzJWy/K0KpM5UdvXQXkEJLBMBo3/nuEgcEGuSb+pxEDtF2TyWvhMLELXE7PXVAuz
         r5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738714258; x=1739319058;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RepckqquWV6jnHyzsOLEyp/E9ypnuaZTtTKUZxQ71CQ=;
        b=jgJNwaoyzA4lZdCFAIlXWeTHe1/Gq7wzN3INk//VYlDLFrUXj6HA4VjLjkVgjfTggo
         kvGv+sk8Ixth7LldhrY/yst5IyZmxD6/B1Ut6yNqr7xnNow34QLMXexuj9VSGKa6ApmH
         PRgWFCbylEQ3mgo6lFGDrQIfOMI64xiPhQk8YidIfZP+gOPOMXn3geuPxrFv4qOGbcJ9
         B2qAqlUQsKh+uklX4xXa+jVJ9ozWkt3Q5ArjYH+GZS1LdUY67v3j+ahh1qQSkax4Ph6h
         n99K3c1t2ayicemNlhdBPtF6ET/TG71lf5nY4AjpdJxzb8019qpphdjfAMB4kC0g66N1
         Kz5A==
X-Gm-Message-State: AOJu0YwKRr0YMA+Mx2tlQcpshRzJojDMavOrqs/JpWhm/OktU8UXJE6b
	535BOGLlbwtTSuJvuCAFGvBULUF98O73Wxw8pcg/AG+umuj5cjouiFWfaGcyqecqzTisVXUKSuy
	aIIjM9ERqWg==
X-Google-Smtp-Source: AGHT+IHZwTIoSaIaivPRhAUuEyjdhku/ejk4gsf+jY+CLGCtm5Z94WPni74x+OR4dn5lIPYrMTblgCMXQ0cseA==
X-Received: from pgbfu19.prod.google.com ([2002:a05:6a02:4a93:b0:823:a2ef:e363])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ec92:b0:21f:a02:2c17 with SMTP id d9443c01a7336-21f17ed09eamr10700645ad.45.1738714258151;
 Tue, 04 Feb 2025 16:10:58 -0800 (PST)
Date: Wed,  5 Feb 2025 00:10:51 +0000
In-Reply-To: <20250205001052.2590140-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250205001052.2590140-1-skhawaja@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250205001052.2590140-4-skhawaja@google.com>
Subject: [PATCH net-next v3 3/4] Extend napi threaded polling to allow kthread
 based busy polling
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com
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
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 Documentation/ABI/testing/sysfs-class-net     |  3 +-
 Documentation/netlink/specs/netdev.yaml       | 12 ++--
 Documentation/networking/napi.rst             | 67 ++++++++++++++++-
 .../net/ethernet/atheros/atl1c/atl1c_main.c   |  2 +-
 drivers/net/ethernet/mellanox/mlxsw/pci.c     |  2 +-
 drivers/net/ethernet/renesas/ravb_main.c      |  2 +-
 drivers/net/wireless/ath/ath10k/snoc.c        |  2 +-
 include/linux/netdevice.h                     | 20 ++++--
 include/uapi/linux/netdev.h                   |  6 ++
 net/core/dev.c                                | 72 ++++++++++++++++---
 net/core/net-sysfs.c                          |  2 +-
 net/core/netdev-genl-gen.c                    |  2 +-
 net/core/netdev-genl.c                        |  2 +-
 tools/include/uapi/linux/netdev.h             |  6 ++
 14 files changed, 171 insertions(+), 29 deletions(-)

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
index 785240d60df6..db3bf1eb9a63 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -78,6 +78,10 @@ definitions:
     name: qstats-scope
     type: flags
     entries: [ queue ]
+  -
+    name: napi-threaded
+    type: enum
+    entries: [ disable, enable, busy-poll-enable ]
 
 attribute-sets:
   -
@@ -271,11 +275,11 @@ attribute-sets:
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
     name: queue
     attributes:
diff --git a/Documentation/networking/napi.rst b/Documentation/networking/napi.rst
index 73c83b4533dc..f6596573b777 100644
--- a/Documentation/networking/napi.rst
+++ b/Documentation/networking/napi.rst
@@ -232,7 +232,9 @@ are not well known).
 Busy polling is enabled by either setting ``SO_BUSY_POLL`` on
 selected sockets or using the global ``net.core.busy_poll`` and
 ``net.core.busy_read`` sysctls. An io_uring API for NAPI busy polling
-also exists.
+also exists. Threaded polling of NAPI also has a mode to busy poll for
+packets (:ref:`threaded busy polling<threaded_busy_poll>`) using the same
+thread that is used for NAPI processing.
 
 epoll-based busy polling
 ------------------------
@@ -395,6 +397,69 @@ Therefore, setting ``gro_flush_timeout`` and ``napi_defer_hard_irqs`` is
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
index 5b44c931b660..52f1ffb77a3c 100644
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
index a0e485722ed9..c3069a17fa7e 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -352,7 +352,7 @@ struct napi_config {
 	u64 gro_flush_timeout;
 	u64 irq_suspend_timeout;
 	u32 defer_hard_irqs;
-	bool threaded;
+	u8 threaded;
 	unsigned int napi_id;
 };
 
@@ -410,6 +410,8 @@ enum {
 	NAPI_STATE_PREFER_BUSY_POLL,	/* prefer busy-polling over softirq processing*/
 	NAPI_STATE_THREADED,		/* The poll is performed inside its own thread*/
 	NAPI_STATE_SCHED_THREADED,	/* Napi is currently scheduled in threaded mode */
+	NAPI_STATE_THREADED_BUSY_POLL,	/* The threaded napi poller will busy poll */
+	NAPI_STATE_SCHED_THREADED_BUSY_POLL,  /* The threaded napi poller is busy polling */
 };
 
 enum {
@@ -423,8 +425,14 @@ enum {
 	NAPIF_STATE_PREFER_BUSY_POLL	= BIT(NAPI_STATE_PREFER_BUSY_POLL),
 	NAPIF_STATE_THREADED		= BIT(NAPI_STATE_THREADED),
 	NAPIF_STATE_SCHED_THREADED	= BIT(NAPI_STATE_SCHED_THREADED),
+	NAPIF_STATE_THREADED_BUSY_POLL	= BIT(NAPI_STATE_THREADED_BUSY_POLL),
+	NAPIF_STATE_SCHED_THREADED_BUSY_POLL
+				= BIT(NAPI_STATE_SCHED_THREADED_BUSY_POLL),
 };
 
+#define NAPIF_STATE_THREADED_BUSY_POLL_MASK \
+	(NAPIF_STATE_THREADED | NAPIF_STATE_THREADED_BUSY_POLL)
+
 enum gro_result {
 	GRO_MERGED,
 	GRO_MERGED_FREE,
@@ -571,16 +579,18 @@ static inline bool napi_complete(struct napi_struct *n)
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
@@ -2404,7 +2414,7 @@ struct net_device {
 	struct sfp_bus		*sfp_bus;
 	struct lock_class_key	*qdisc_tx_busylock;
 	bool			proto_down;
-	bool			threaded;
+	u8			threaded;
 
 	/* priv_flags_slow, ungrouped to save space */
 	unsigned long		see_all_hwtstamp_requests:1;
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 829648b2ef65..c2a9dbb361f6 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -74,6 +74,12 @@ enum netdev_qstats_scope {
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
index d5dcf9dd6225..1964c184ce8a 100644
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
@@ -6403,7 +6404,8 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 	 *    the guarantee we will be called later.
 	 */
 	if (unlikely(n->state & (NAPIF_STATE_NPSVC |
-				 NAPIF_STATE_IN_BUSY_POLL)))
+				 NAPIF_STATE_IN_BUSY_POLL |
+				 NAPIF_STATE_SCHED_THREADED_BUSY_POLL)))
 		return false;
 
 	if (work_done) {
@@ -6792,8 +6794,10 @@ static void init_gro_hash(struct napi_struct *napi)
 	napi->gro_bitmask = 0;
 }
 
-int napi_set_threaded(struct napi_struct *napi, bool threaded)
+int napi_set_threaded(struct napi_struct *napi,
+		      enum netdev_napi_threaded threaded)
 {
+	unsigned long val;
 	if (napi->dev->threaded)
 		return -EINVAL;
 
@@ -6811,14 +6815,20 @@ int napi_set_threaded(struct napi_struct *napi, bool threaded)
 
 	/* Make sure kthread is created before THREADED bit is set. */
 	smp_mb__before_atomic();
-	assign_bit(NAPI_STATE_THREADED, &napi->state, threaded);
+	val = 0;
+	if (threaded == NETDEV_NAPI_THREADED_BUSY_POLL_ENABLE)
+		val |= NAPIF_STATE_THREADED_BUSY_POLL;
+	if (threaded)
+		val |= NAPIF_STATE_THREADED;
+	set_mask_bits(&napi->state, NAPIF_STATE_THREADED_BUSY_POLL_MASK, val);
 
 	return 0;
 }
 
-int dev_set_threaded(struct net_device *dev, bool threaded)
+int dev_set_threaded(struct net_device *dev, enum netdev_napi_threaded threaded)
 {
 	struct napi_struct *napi;
+	unsigned long val;
 	int err = 0;
 
 	netdev_assert_locked_or_invisible(dev);
@@ -6826,17 +6836,22 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
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
@@ -6855,9 +6870,13 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
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
@@ -7235,7 +7254,7 @@ static int napi_thread_wait(struct napi_struct *napi)
 	return -1;
 }
 
-static void napi_threaded_poll_loop(struct napi_struct *napi)
+static void napi_threaded_poll_loop(struct napi_struct *napi, bool busy_poll)
 {
 	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	struct softnet_data *sd;
@@ -7264,22 +7283,53 @@ static void napi_threaded_poll_loop(struct napi_struct *napi)
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
+
+		/* Do not busy poll if napi is disabled. */
+		if (unlikely(val & NAPIF_STATE_DISABLE))
+			busy_poll = false;
+
+		if (busy_poll != busy_poll_sched)
+			assign_bit(NAPI_STATE_SCHED_THREADED_BUSY_POLL,
+				   &napi->state, busy_poll);
 
-	while (!napi_thread_wait(napi))
-		napi_threaded_poll_loop(napi);
+		napi_threaded_poll_loop(napi, busy_poll);
+	}
 
 	return 0;
 }
@@ -12474,7 +12524,7 @@ static void run_backlog_napi(unsigned int cpu)
 {
 	struct softnet_data *sd = per_cpu_ptr(&softnet_data, cpu);
 
-	napi_threaded_poll_loop(&sd->backlog);
+	napi_threaded_poll_loop(&sd->backlog, false);
 }
 
 static void backlog_napi_setup(unsigned int cpu)
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 07cb99b114bd..beb496bcb633 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -657,7 +657,7 @@ static int modify_napi_threaded(struct net_device *dev, unsigned long val)
 	if (list_empty(&dev->napi_list))
 		return -EOPNOTSUPP;
 
-	if (val != 0 && val != 1)
+	if (val > NETDEV_NAPI_THREADED_BUSY_POLL_ENABLE)
 		return -EOPNOTSUPP;
 
 	ret = dev_set_threaded(dev, val);
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index a1f80e687f53..b572beba42e7 100644
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
index 208c3dd768ec..7ae5f3ed0961 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -329,7 +329,7 @@ netdev_nl_napi_set_config(struct napi_struct *napi, struct genl_info *info)
 
 	if (info->attrs[NETDEV_A_NAPI_THREADED]) {
 		threaded = nla_get_u32(info->attrs[NETDEV_A_NAPI_THREADED]);
-		napi_set_threaded(napi, !!threaded);
+		napi_set_threaded(napi, threaded);
 	}
 
 	if (info->attrs[NETDEV_A_NAPI_DEFER_HARD_IRQS]) {
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 829648b2ef65..c2a9dbb361f6 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -74,6 +74,12 @@ enum netdev_qstats_scope {
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
2.48.1.362.g079036d154-goog


