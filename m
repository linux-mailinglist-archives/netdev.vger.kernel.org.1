Return-Path: <netdev+bounces-106528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDE2916A99
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 16:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D9F0B22B29
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 14:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D57A16A945;
	Tue, 25 Jun 2024 14:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOGQcfGt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A6E16D31C
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 14:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719326168; cv=none; b=eFKUQULptTcEkdO8vmJVX37zkc2gL7KKsIJwMHHdPesPG7fuvKC4HNC/+D7pfPQRdBF4EkgE4viPqnF39GfWEVxDbm5QavPA0df2ZcqgHu6ov3eHnja9cCfGpC6zVP3McVjfu7Yhv+/1Oy2yat50yHjAcUBqEll66+6o3UmL2mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719326168; c=relaxed/simple;
	bh=8ArbgtY9Y/1F93ezYxG4YkzV4QVND748m5DUoaiVnOo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VR8yicKxyrbvAN7JaupnZ1cqwoRP3jdghr1mNkqtQxXEUaoVO+0vUBKJOqCy0OXYdu0MwLtAUtjKEOqQm43350+OAOL732fMfG0abFbJ00C0LHsXkdnX2GJWBNJPJ9JFzGeVs+eHgWY83AHqFRJyTiS93M9eFOVLVgPcE3Gb2F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOGQcfGt; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f4a5344ec7so38202345ad.1
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 07:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719326165; x=1719930965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J9jsw6S4pw4wkjZJhUCrZQBs78uqSAyhQdbgcU1oqPU=;
        b=nOGQcfGtpz5+B/5ozsvZmh6GQj0k6gdGFbUngFTOuq94szK2F1bmfMv5clfZWvu+qm
         Aua6CUjjfLZC2s8Yzf2NWwZWU1c85jAlzERrOsPz9gFFq99RvNdolBJ0XK8/AgZW2dfb
         qdD0afzANp7dbfDT+oM4hJaglTQyAOfjkdkjARgFOntHurKZyWYn14hyhAUvudvv2BrT
         TxHpx5CJzwQP01uHiX0N9605dmYJ8HQssmZf10SQodWyamgAGnG1pqcyae9/ownZeTCo
         X6N6r3f0ubj5d8bFqfhZNPAZamrIRaupZQVXBIFGzBsZJHLWuwi9zUm4mjXHz/lAVmmG
         BzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719326165; x=1719930965;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J9jsw6S4pw4wkjZJhUCrZQBs78uqSAyhQdbgcU1oqPU=;
        b=sDBdz4dRogGevV62h3kk6yc77HtLh+1YJnMSliAgMp59ZZGThWFrgR4NswAmzBBmck
         oYtS4BOHBW+LK5SSMIuaVzNi68bbfRLsnkNkReMqQefGmZq6nHngoSXnJ3/ln6JafJeY
         6heaYqYmpKvZTWibg9F782HQ/dwGP12+K7L6KmluITwVoINw4D1BK5lg7nVrVWG4fIFi
         MNYvMS8uoEqU6y+gisFwE+n6nSiZ6tYfIxxZ+mCicKwfyWzMEVSvNSoL9sm9GM8LJkOz
         OX/z7CPXbLnPo4JCEL0wyBYpW+0SdErc7Pfjm5cLGrpt+sdiK3xXM4J/wcoL/qFFoUkj
         pEwQ==
X-Gm-Message-State: AOJu0YyDM5EdPoqdWKzKPfJXFrKVzShOL1Lt0ZlSRNEAWXRibmJx4ifa
	mkWnk40K5Qm4FnVfpjVeBa4ETSzKFglyXuIWtx3xIKaoTwjBRGNw
X-Google-Smtp-Source: AGHT+IGUPvCzQHwmtJAR1N4qWL56oJPEO/sUUenuDrXBsIFwx+sDSmMIAvLKzyfgU6xBA9doBt+LBw==
X-Received: by 2002:a17:902:f610:b0:1f9:e3fa:d932 with SMTP id d9443c01a7336-1fa5e671d85mr61706845ad.9.1719326164688;
        Tue, 25 Jun 2024 07:36:04 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3c5f66sm82121995ad.123.2024.06.25.07.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 07:36:04 -0700 (PDT)
Subject: [net-next PATCH v2 07/15] eth: fbnic: Allocate a netdevice and napi
 vectors with queues
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com
Date: Tue, 25 Jun 2024 07:36:03 -0700
Message-ID: 
 <171932616332.3072535.5928220031237925415.stgit@ahduyck-xeon-server.home.arpa>
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

Allocate a netdev and figure out basics like how many queues
we need, MAC address, MTU bounds. Kick off a service task
to do various periodic things like health checking.
The service task only runs when device is open.

We have four levels of objects here:
 - ring - A HW ring with head / tail pointers,
 - triad - Two submission and one completion ring,
 - NAPI - NAPI, with one IRQ and any number of Rx and Tx triads,
 - Netdev - The ultimate container of the rings and napi vectors.

The "triad" is the only less-than-usual construct. On Rx we have
two "free buffer" submission rings, one for packet headers and
one for packet data. On Tx we have separate rings for XDP Tx
and normal Tx. So we ended up with ring triplets in both
directions.

We keep NAPIs on a local list, even though core already maintains a list.
Later on having a separate list will matter for live reconfig.
We introduce the list already, the churn would not be worth it.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/Makefile       |    4 
 drivers/net/ethernet/meta/fbnic/fbnic.h        |   18 ++
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h    |   40 ++++
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c    |   26 ++
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c |  185 +++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h |   37 +++
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c    |  140 +++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c   |  266 ++++++++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h   |   55 +++++
 9 files changed, 769 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h

diff --git a/drivers/net/ethernet/meta/fbnic/Makefile b/drivers/net/ethernet/meta/fbnic/Makefile
index 7b63cd5b09d4..f2ea90e0c14f 100644
--- a/drivers/net/ethernet/meta/fbnic/Makefile
+++ b/drivers/net/ethernet/meta/fbnic/Makefile
@@ -11,5 +11,7 @@ fbnic-y := fbnic_devlink.o \
 	   fbnic_fw.o \
 	   fbnic_irq.o \
 	   fbnic_mac.o \
+	   fbnic_netdev.o \
 	   fbnic_pci.o \
-	   fbnic_tlv.o
+	   fbnic_tlv.o \
+	   fbnic_txrx.o
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index 42e2744cfe10..8abae3b8ef4d 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -4,7 +4,10 @@
 #ifndef _FBNIC_H_
 #define _FBNIC_H_
 
+#include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
 
 #include "fbnic_csr.h"
 #include "fbnic_fw.h"
@@ -12,6 +15,7 @@
 
 struct fbnic_dev {
 	struct device *dev;
+	struct net_device *netdev;
 
 	u32 __iomem *uc_addr0;
 	u32 __iomem *uc_addr4;
@@ -19,6 +23,8 @@ struct fbnic_dev {
 	unsigned int fw_msix_vector;
 	unsigned short num_irqs;
 
+	struct delayed_work service_task;
+
 	struct fbnic_fw_mbx mbx[FBNIC_IPC_MBX_INDICES];
 	/* Lock protecting Tx Mailbox queue to prevent possible races */
 	spinlock_t fw_tx_lock;
@@ -26,6 +32,9 @@ struct fbnic_dev {
 	u64 dsn;
 	u32 mps;
 	u32 readrq;
+
+	/* Number of TCQs/RCQs available on hardware */
+	u16 max_num_queues;
 };
 
 /* Reserve entry 0 in the MSI-X "others" array until we have filled all
@@ -81,6 +90,11 @@ void fbnic_fw_wr32(struct fbnic_dev *fbd, u32 reg, u32 val);
 #define fw_wr32(_f, _r, _v)	fbnic_fw_wr32(_f, _r, _v)
 #define fw_wrfl(_f)		fbnic_fw_rd32(_f, FBNIC_FW_ZERO_REG)
 
+static inline bool fbnic_init_failure(struct fbnic_dev *fbd)
+{
+	return !fbd->netdev;
+}
+
 extern char fbnic_driver_name[];
 
 void fbnic_devlink_free(struct fbnic_dev *fbd);
@@ -91,6 +105,9 @@ void fbnic_devlink_unregister(struct fbnic_dev *fbd);
 int fbnic_fw_enable_mbx(struct fbnic_dev *fbd);
 void fbnic_fw_disable_mbx(struct fbnic_dev *fbd);
 
+int fbnic_request_irq(struct fbnic_dev *dev, int nr, irq_handler_t handler,
+		      unsigned long flags, const char *name, void *data);
+void fbnic_free_irq(struct fbnic_dev *dev, int nr, void *data);
 void fbnic_free_irqs(struct fbnic_dev *fbd);
 int fbnic_alloc_irqs(struct fbnic_dev *fbd);
 
@@ -99,6 +116,7 @@ enum fbnic_boards {
 };
 
 struct fbnic_info {
+	unsigned int max_num_queues;
 	unsigned int bar_mask;
 };
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index 47a5321b68a7..da1333301d15 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -366,7 +366,47 @@ enum {
 #define FBNIC_PUL_OB_TLP_HDR_AR_CFG_BME		CSR_BIT(18)
 #define FBNIC_CSR_END_PUL_USER	0x31080	/* CSR section delimiter */
 
+/* Queue Registers
+ *
+ * The queue register offsets are specific for a given queue grouping. So to
+ * find the actual register offset it is necessary to combine FBNIC_QUEUE(n)
+ * with the register to get the actual register offset like so:
+ *   FBNIC_QUEUE_TWQ0_CTL(n) == FBNIC_QUEUE(n) + FBNIC_QUEUE_TWQ0_CTL
+ */
+#define FBNIC_CSR_START_QUEUE		0x40000	/* CSR section delimiter */
+#define FBNIC_QUEUE_STRIDE		0x400		/* 0x1000 */
+#define FBNIC_QUEUE(n)\
+	(0x40000 + FBNIC_QUEUE_STRIDE * (n))	/* 0x100000 + 4096*n */
+
+#define FBNIC_QUEUE_TWQ0_CTL		0x000		/* 0x000 */
+#define FBNIC_QUEUE_TWQ1_CTL		0x001		/* 0x004 */
+#define FBNIC_QUEUE_TWQ_CTL_RESET		CSR_BIT(0)
+#define FBNIC_QUEUE_TWQ_CTL_ENABLE		CSR_BIT(1)
+#define FBNIC_QUEUE_TWQ_CTL_PREFETCH_DISABLE	CSR_BIT(2)
+#define FBNIC_QUEUE_TWQ_CTL_TXB_FIFO_SEL_MASK	CSR_GENMASK(30, 29)
+enum {
+	FBNIC_QUEUE_TWQ_CTL_TXB_SHARED	= 0,
+	FBNIC_QUEUE_TWQ_CTL_TXB_EI_DATA	= 1,
+	FBNIC_QUEUE_TWQ_CTL_TXB_EI_CTL	= 2,
+};
+
+#define FBNIC_QUEUE_TWQ_CTL_AGGR_MODE		CSR_BIT(31)
+
+#define FBNIC_QUEUE_TWQ0_TAIL		0x002		/* 0x008 */
+#define FBNIC_QUEUE_TWQ1_TAIL		0x003		/* 0x00c */
+
+/* Tx Completion Queue Registers */
+#define FBNIC_QUEUE_TCQ_HEAD		0x081		/* 0x204 */
+
+/* Rx Completion Queue Registers */
+#define FBNIC_QUEUE_RCQ_HEAD		0x201		/* 0x804 */
+
+/* Rx Buffer Descriptor Queue Registers */
+#define FBNIC_QUEUE_BDQ_HPQ_TAIL	0x241		/* 0x904 */
+#define FBNIC_QUEUE_BDQ_PPQ_TAIL	0x242		/* 0x908 */
+
 #define FBNIC_MAX_QUEUES		128
+#define FBNIC_CSR_END_QUEUE	(0x40000 + 0x400 * FBNIC_MAX_QUEUES - 1)
 
 /* BAR 4 CSRs */
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
index d8f668142135..10377a4a9719 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 
 #include "fbnic.h"
+#include "fbnic_txrx.h"
 
 static irqreturn_t fbnic_fw_msix_intr(int __always_unused irq, void *data)
 {
@@ -82,6 +83,29 @@ void fbnic_fw_disable_mbx(struct fbnic_dev *fbd)
 	fbnic_mbx_clean(fbd);
 }
 
+int fbnic_request_irq(struct fbnic_dev *fbd, int nr, irq_handler_t handler,
+		      unsigned long flags, const char *name, void *data)
+{
+	struct pci_dev *pdev = to_pci_dev(fbd->dev);
+	int irq = pci_irq_vector(pdev, nr);
+
+	if (irq < 0)
+		return irq;
+
+	return request_irq(irq, handler, flags, name, data);
+}
+
+void fbnic_free_irq(struct fbnic_dev *fbd, int nr, void *data)
+{
+	struct pci_dev *pdev = to_pci_dev(fbd->dev);
+	int irq = pci_irq_vector(pdev, nr);
+
+	if (irq < 0)
+		return;
+
+	free_irq(irq, data);
+}
+
 void fbnic_free_irqs(struct fbnic_dev *fbd)
 {
 	struct pci_dev *pdev = to_pci_dev(fbd->dev);
@@ -99,7 +123,7 @@ int fbnic_alloc_irqs(struct fbnic_dev *fbd)
 	struct pci_dev *pdev = to_pci_dev(fbd->dev);
 	int num_irqs;
 
-	wanted_irqs += 1;
+	wanted_irqs += min_t(unsigned int, num_online_cpus(), FBNIC_MAX_RXQS);
 	num_irqs = pci_alloc_irq_vectors(pdev, FBNIC_NON_NAPI_VECTORS + 1,
 					 wanted_irqs, PCI_IRQ_MSIX);
 	if (num_irqs < 0) {
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
new file mode 100644
index 000000000000..73f46ede82fc
--- /dev/null
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#include <linux/etherdevice.h>
+#include <linux/ipv6.h>
+#include <linux/types.h>
+
+#include "fbnic.h"
+#include "fbnic_netdev.h"
+#include "fbnic_txrx.h"
+
+int __fbnic_open(struct fbnic_net *fbn)
+{
+	int err;
+
+	err = fbnic_alloc_napi_vectors(fbn);
+	if (err)
+		return err;
+
+	err = netif_set_real_num_tx_queues(fbn->netdev,
+					   fbn->num_tx_queues);
+	if (err)
+		goto free_resources;
+
+	err = netif_set_real_num_rx_queues(fbn->netdev,
+					   fbn->num_rx_queues);
+	if (err)
+		goto free_resources;
+
+	return 0;
+free_resources:
+	fbnic_free_napi_vectors(fbn);
+	return err;
+}
+
+static int fbnic_open(struct net_device *netdev)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	int err;
+
+	err = __fbnic_open(fbn);
+	if (!err)
+		fbnic_up(fbn);
+
+	return err;
+}
+
+static int fbnic_stop(struct net_device *netdev)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+
+	fbnic_down(fbn);
+
+	fbnic_free_napi_vectors(fbn);
+
+	return 0;
+}
+
+static const struct net_device_ops fbnic_netdev_ops = {
+	.ndo_open		= fbnic_open,
+	.ndo_stop		= fbnic_stop,
+	.ndo_validate_addr	= eth_validate_addr,
+	.ndo_start_xmit		= fbnic_xmit_frame,
+};
+
+void fbnic_reset_queues(struct fbnic_net *fbn,
+			unsigned int tx, unsigned int rx)
+{
+	struct fbnic_dev *fbd = fbn->fbd;
+	unsigned int max_napis;
+
+	max_napis = fbd->num_irqs - FBNIC_NON_NAPI_VECTORS;
+
+	tx = min(tx, max_napis);
+	fbn->num_tx_queues = tx;
+
+	rx = min(rx, max_napis);
+	fbn->num_rx_queues = rx;
+
+	fbn->num_napi = max(tx, rx);
+}
+
+/**
+ * fbnic_netdev_free - Free the netdev associate with fbnic
+ * @fbd: Driver specific structure to free netdev from
+ *
+ * Allocate and initialize the netdev and netdev private structure. Bind
+ * together the hardware, netdev, and pci data structures.
+ **/
+void fbnic_netdev_free(struct fbnic_dev *fbd)
+{
+	free_netdev(fbd->netdev);
+	fbd->netdev = NULL;
+}
+
+/**
+ * fbnic_netdev_alloc - Allocate a netdev and associate with fbnic
+ * @fbd: Driver specific structure to associate netdev with
+ *
+ * Allocate and initialize the netdev and netdev private structure. Bind
+ * together the hardware, netdev, and pci data structures.
+ **/
+struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
+{
+	struct net_device *netdev;
+	struct fbnic_net *fbn;
+	int default_queues;
+
+	netdev = alloc_etherdev_mq(sizeof(*fbn), FBNIC_MAX_RXQS);
+	if (!netdev)
+		return NULL;
+
+	SET_NETDEV_DEV(netdev, fbd->dev);
+	fbd->netdev = netdev;
+
+	netdev->netdev_ops = &fbnic_netdev_ops;
+
+	fbn = netdev_priv(netdev);
+
+	fbn->netdev = netdev;
+	fbn->fbd = fbd;
+	INIT_LIST_HEAD(&fbn->napis);
+
+	default_queues = netif_get_num_default_rss_queues();
+	if (default_queues > fbd->max_num_queues)
+		default_queues = fbd->max_num_queues;
+
+	fbnic_reset_queues(fbn, default_queues, default_queues);
+
+	netdev->min_mtu = IPV6_MIN_MTU;
+	netdev->max_mtu = FBNIC_MAX_JUMBO_FRAME_SIZE - ETH_HLEN;
+
+	netif_carrier_off(netdev);
+
+	netif_tx_stop_all_queues(netdev);
+
+	return netdev;
+}
+
+static int fbnic_dsn_to_mac_addr(u64 dsn, char *addr)
+{
+	addr[0] = (dsn >> 56) & 0xFF;
+	addr[1] = (dsn >> 48) & 0xFF;
+	addr[2] = (dsn >> 40) & 0xFF;
+	addr[3] = (dsn >> 16) & 0xFF;
+	addr[4] = (dsn >> 8) & 0xFF;
+	addr[5] = dsn & 0xFF;
+
+	return is_valid_ether_addr(addr) ? 0 : -EINVAL;
+}
+
+/**
+ * fbnic_netdev_register - Initialize general software structures
+ * @netdev: Netdev containing structure to initialize and register
+ *
+ * Initialize the MAC address for the netdev and register it.
+ **/
+int fbnic_netdev_register(struct net_device *netdev)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	struct fbnic_dev *fbd = fbn->fbd;
+	u64 dsn = fbd->dsn;
+	u8 addr[ETH_ALEN];
+	int err;
+
+	err = fbnic_dsn_to_mac_addr(dsn, addr);
+	if (!err) {
+		ether_addr_copy(netdev->perm_addr, addr);
+		eth_hw_addr_set(netdev, addr);
+	} else {
+		/* A randomly assigned MAC address will cause provisioning
+		 * issues so instead just fail to spawn the netdev and
+		 * avoid any confusion.
+		 */
+		dev_err(fbd->dev, "MAC addr %pM invalid\n", addr);
+		return err;
+	}
+
+	return register_netdev(netdev);
+}
+
+void fbnic_netdev_unregister(struct net_device *netdev)
+{
+	unregister_netdev(netdev);
+}
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
new file mode 100644
index 000000000000..8d12abe5fb57
--- /dev/null
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#ifndef _FBNIC_NETDEV_H_
+#define _FBNIC_NETDEV_H_
+
+#include <linux/types.h>
+
+#include "fbnic_txrx.h"
+
+struct fbnic_net {
+	struct fbnic_ring *tx[FBNIC_MAX_TXQS];
+	struct fbnic_ring *rx[FBNIC_MAX_RXQS];
+
+	struct net_device *netdev;
+	struct fbnic_dev *fbd;
+
+	u16 num_napi;
+
+	u16 num_tx_queues;
+	u16 num_rx_queues;
+
+	struct list_head napis;
+};
+
+int __fbnic_open(struct fbnic_net *fbn);
+void fbnic_up(struct fbnic_net *fbn);
+void fbnic_down(struct fbnic_net *fbn);
+
+struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd);
+void fbnic_netdev_free(struct fbnic_dev *fbd);
+int fbnic_netdev_register(struct net_device *netdev);
+void fbnic_netdev_unregister(struct net_device *netdev);
+void fbnic_reset_queues(struct fbnic_net *fbn,
+			unsigned int tx, unsigned int rx);
+
+#endif /* _FBNIC_NETDEV_H_ */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 0c94b5bdc9b5..e08aa4edeec0 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -4,10 +4,12 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/rtnetlink.h>
 #include <linux/types.h>
 
 #include "fbnic.h"
 #include "fbnic_drvinfo.h"
+#include "fbnic_netdev.h"
 
 char fbnic_driver_name[] = DRV_NAME;
 
@@ -15,6 +17,7 @@ MODULE_DESCRIPTION(DRV_SUMMARY);
 MODULE_LICENSE("GPL");
 
 static const struct fbnic_info fbnic_asic_info = {
+	.max_num_queues = FBNIC_MAX_QUEUES,
 	.bar_mask = BIT(0) | BIT(4)
 };
 
@@ -55,6 +58,10 @@ u32 fbnic_rd32(struct fbnic_dev *fbd, u32 reg)
 		"Failed read (idx 0x%x AKA addr 0x%x), disabled CSR access, awaiting reset\n",
 		reg, reg << 2);
 
+	/* Notify stack that device has lost (PCIe) link */
+	if (!fbnic_init_failure(fbd))
+		netif_device_detach(fbd->netdev);
+
 	return ~0U;
 }
 
@@ -97,9 +104,56 @@ u32 fbnic_fw_rd32(struct fbnic_dev *fbd, u32 reg)
 		"Failed read (idx 0x%x AKA addr 0x%x), disabled CSR access, awaiting reset\n",
 		reg, reg << 2);
 
+	/* Notify stack that device has lost (PCIe) link */
+	if (!fbnic_init_failure(fbd))
+		netif_device_detach(fbd->netdev);
+
 	return ~0U;
 }
 
+static void fbnic_service_task_start(struct fbnic_net *fbn)
+{
+	struct fbnic_dev *fbd = fbn->fbd;
+
+	schedule_delayed_work(&fbd->service_task, HZ);
+}
+
+static void fbnic_service_task_stop(struct fbnic_net *fbn)
+{
+	struct net_device *netdev = fbn->netdev;
+	struct fbnic_dev *fbd = fbn->fbd;
+
+	cancel_delayed_work(&fbd->service_task);
+	netif_carrier_off(netdev);
+}
+
+void fbnic_up(struct fbnic_net *fbn)
+{
+	netif_tx_start_all_queues(fbn->netdev);
+
+	fbnic_service_task_start(fbn);
+}
+
+void fbnic_down(struct fbnic_net *fbn)
+{
+	fbnic_service_task_stop(fbn);
+
+	netif_tx_disable(fbn->netdev);
+}
+
+static void fbnic_service_task(struct work_struct *work)
+{
+	struct fbnic_dev *fbd = container_of(to_delayed_work(work),
+					     struct fbnic_dev, service_task);
+
+	rtnl_lock();
+
+	if (netif_running(fbd->netdev))
+		schedule_delayed_work(&fbd->service_task, HZ);
+
+	rtnl_unlock();
+}
+
 /**
  *  fbnic_probe - Device Initialization Routine
  *  @pdev: PCI device information struct
@@ -114,6 +168,7 @@ u32 fbnic_fw_rd32(struct fbnic_dev *fbd, u32 reg)
 static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	const struct fbnic_info *info = fbnic_info_tbl[ent->driver_data];
+	struct net_device *netdev;
 	struct fbnic_dev *fbd;
 	int err;
 
@@ -150,11 +205,16 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		return -ENOMEM;
 	}
 
+	/* Populate driver with hardware-specific info and handlers */
+	fbd->max_num_queues = info->max_num_queues;
+
 	pci_set_master(pdev);
 	pci_save_state(pdev);
 
 	fbnic_devlink_register(fbd);
 
+	INIT_DELAYED_WORK(&fbd->service_task, fbnic_service_task);
+
 	err = fbnic_alloc_irqs(fbd);
 	if (err)
 		goto free_fbd;
@@ -177,8 +237,22 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto init_failure_mode;
 	}
 
+	netdev = fbnic_netdev_alloc(fbd);
+	if (!netdev) {
+		dev_err(&pdev->dev, "Netdev allocation failed\n");
+		goto init_failure_mode;
+	}
+
+	err = fbnic_netdev_register(netdev);
+	if (err) {
+		dev_err(&pdev->dev, "Netdev registration failed: %d\n", err);
+		goto ifm_free_netdev;
+	}
+
 	return 0;
 
+ifm_free_netdev:
+	fbnic_netdev_free(fbd);
 init_failure_mode:
 	dev_warn(&pdev->dev, "Probe error encountered, entering init failure mode. Normal networking functionality will not be available.\n");
 	 /* Always return 0 even on error so devlink is registered to allow
@@ -208,6 +282,14 @@ static void fbnic_remove(struct pci_dev *pdev)
 {
 	struct fbnic_dev *fbd = pci_get_drvdata(pdev);
 
+	if (!fbnic_init_failure(fbd)) {
+		struct net_device *netdev = fbd->netdev;
+
+		fbnic_netdev_unregister(netdev);
+		cancel_delayed_work_sync(&fbd->service_task);
+		fbnic_netdev_free(fbd);
+	}
+
 	fbnic_fw_disable_mbx(fbd);
 	fbnic_free_irqs(fbd);
 
@@ -218,7 +300,21 @@ static void fbnic_remove(struct pci_dev *pdev)
 static int fbnic_pm_suspend(struct device *dev)
 {
 	struct fbnic_dev *fbd = dev_get_drvdata(dev);
+	struct net_device *netdev = fbd->netdev;
 
+	if (fbnic_init_failure(fbd))
+		goto null_uc_addr;
+
+	rtnl_lock();
+
+	netif_device_detach(netdev);
+
+	if (netif_running(netdev))
+		netdev->netdev_ops->ndo_stop(netdev);
+
+	rtnl_unlock();
+
+null_uc_addr:
 	fbnic_fw_disable_mbx(fbd);
 
 	/* Free the IRQs so they aren't trying to occupy sleeping CPUs */
@@ -234,7 +330,9 @@ static int fbnic_pm_suspend(struct device *dev)
 static int __fbnic_pm_resume(struct device *dev)
 {
 	struct fbnic_dev *fbd = dev_get_drvdata(dev);
+	struct net_device *netdev = fbd->netdev;
 	void __iomem * const *iomap_table;
+	struct fbnic_net *fbn;
 	int err;
 
 	/* Restore MMIO access */
@@ -254,7 +352,29 @@ static int __fbnic_pm_resume(struct device *dev)
 	if (err)
 		goto err_free_irqs;
 
+	/* No netdev means there isn't a network interface to bring up */
+	if (fbnic_init_failure(fbd))
+		return 0;
+
+	fbn = netdev_priv(netdev);
+
+	/* Reset the queues if needed */
+	fbnic_reset_queues(fbn, fbn->num_tx_queues, fbn->num_rx_queues);
+
+	rtnl_lock();
+
+	if (netif_running(netdev)) {
+		err = __fbnic_open(fbn);
+		if (err)
+			goto err_disable_mbx;
+	}
+
+	rtnl_unlock();
+
 	return 0;
+err_disable_mbx:
+	rtnl_unlock();
+	fbnic_fw_disable_mbx(fbd);
 err_free_irqs:
 	fbnic_free_irqs(fbd);
 err_invalidate_uc_addr:
@@ -263,11 +383,30 @@ static int __fbnic_pm_resume(struct device *dev)
 	return err;
 }
 
+static void __fbnic_pm_attach(struct device *dev)
+{
+	struct fbnic_dev *fbd = dev_get_drvdata(dev);
+	struct net_device *netdev = fbd->netdev;
+	struct fbnic_net *fbn;
+
+	if (fbnic_init_failure(fbd))
+		return;
+
+	fbn = netdev_priv(netdev);
+
+	if (netif_running(netdev))
+		fbnic_up(fbn);
+
+	netif_device_attach(netdev);
+}
+
 static int __maybe_unused fbnic_pm_resume(struct device *dev)
 {
 	int err;
 
 	err = __fbnic_pm_resume(dev);
+	if (!err)
+		__fbnic_pm_attach(dev);
 
 	return err;
 }
@@ -316,6 +455,7 @@ static pci_ers_result_t fbnic_err_slot_reset(struct pci_dev *pdev)
 
 static void fbnic_err_resume(struct pci_dev *pdev)
 {
+	__fbnic_pm_attach(&pdev->dev);
 }
 
 static const struct pci_error_handlers fbnic_err_handler = {
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
new file mode 100644
index 000000000000..372ca95dceb4
--- /dev/null
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -0,0 +1,266 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#include <linux/pci.h>
+
+#include "fbnic.h"
+#include "fbnic_netdev.h"
+#include "fbnic_txrx.h"
+
+netdev_tx_t fbnic_xmit_frame(struct sk_buff *skb, struct net_device *dev)
+{
+	dev_kfree_skb_any(skb);
+	return NETDEV_TX_OK;
+}
+
+static int fbnic_poll(struct napi_struct *napi, int budget)
+{
+	return 0;
+}
+
+static irqreturn_t fbnic_msix_clean_rings(int __always_unused irq, void *data)
+{
+	struct fbnic_napi_vector *nv = data;
+
+	napi_schedule_irqoff(&nv->napi);
+
+	return IRQ_HANDLED;
+}
+
+static void fbnic_remove_tx_ring(struct fbnic_net *fbn,
+				 struct fbnic_ring *txr)
+{
+	if (!(txr->flags & FBNIC_RING_F_STATS))
+		return;
+
+	/* Remove pointer to the Tx ring */
+	WARN_ON(fbn->tx[txr->q_idx] && fbn->tx[txr->q_idx] != txr);
+	fbn->tx[txr->q_idx] = NULL;
+}
+
+static void fbnic_remove_rx_ring(struct fbnic_net *fbn,
+				 struct fbnic_ring *rxr)
+{
+	if (!(rxr->flags & FBNIC_RING_F_STATS))
+		return;
+
+	/* Remove pointer to the Rx ring */
+	WARN_ON(fbn->rx[rxr->q_idx] && fbn->rx[rxr->q_idx] != rxr);
+	fbn->rx[rxr->q_idx] = NULL;
+}
+
+static void fbnic_free_napi_vector(struct fbnic_net *fbn,
+				   struct fbnic_napi_vector *nv)
+{
+	struct fbnic_dev *fbd = nv->fbd;
+	u32 v_idx = nv->v_idx;
+	int i, j;
+
+	for (i = 0; i < nv->txt_count; i++) {
+		fbnic_remove_tx_ring(fbn, &nv->qt[i].sub0);
+		fbnic_remove_tx_ring(fbn, &nv->qt[i].cmpl);
+	}
+
+	for (j = 0; j < nv->rxt_count; j++, i++) {
+		fbnic_remove_rx_ring(fbn, &nv->qt[i].sub0);
+		fbnic_remove_rx_ring(fbn, &nv->qt[i].sub1);
+		fbnic_remove_rx_ring(fbn, &nv->qt[i].cmpl);
+	}
+
+	fbnic_free_irq(fbd, v_idx, nv);
+	netif_napi_del(&nv->napi);
+	list_del(&nv->napis);
+	kfree(nv);
+}
+
+void fbnic_free_napi_vectors(struct fbnic_net *fbn)
+{
+	struct fbnic_napi_vector *nv, *temp;
+
+	list_for_each_entry_safe(nv, temp, &fbn->napis, napis)
+		fbnic_free_napi_vector(fbn, nv);
+}
+
+static void fbnic_name_napi_vector(struct fbnic_napi_vector *nv)
+{
+	unsigned char *dev_name = nv->napi.dev->name;
+
+	if (!nv->rxt_count)
+		snprintf(nv->name, sizeof(nv->name), "%s-Tx-%u", dev_name,
+			 nv->v_idx - FBNIC_NON_NAPI_VECTORS);
+	else
+		snprintf(nv->name, sizeof(nv->name), "%s-TxRx-%u", dev_name,
+			 nv->v_idx - FBNIC_NON_NAPI_VECTORS);
+}
+
+static void fbnic_ring_init(struct fbnic_ring *ring, u32 __iomem *doorbell,
+			    int q_idx, u8 flags)
+{
+	ring->doorbell = doorbell;
+	ring->q_idx = q_idx;
+	ring->flags = flags;
+}
+
+static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
+				   unsigned int v_count, unsigned int v_idx,
+				   unsigned int txq_count, unsigned int txq_idx,
+				   unsigned int rxq_count, unsigned int rxq_idx)
+{
+	int txt_count = txq_count, rxt_count = rxq_count;
+	u32 __iomem *uc_addr = fbd->uc_addr0;
+	struct fbnic_napi_vector *nv;
+	struct fbnic_q_triad *qt;
+	int qt_count, err;
+	u32 __iomem *db;
+
+	qt_count = txt_count + rxq_count;
+	if (!qt_count)
+		return -EINVAL;
+
+	/* If MMIO has already failed there are no rings to initialize */
+	if (!uc_addr)
+		return -EIO;
+
+	/* Allocate NAPI vector and queue triads */
+	nv = kzalloc(struct_size(nv, qt, qt_count), GFP_KERNEL);
+	if (!nv)
+		return -ENOMEM;
+
+	/* Record queue triad counts */
+	nv->txt_count = txt_count;
+	nv->rxt_count = rxt_count;
+
+	/* Provide pointer back to fbnic and MSI-X vectors */
+	nv->fbd = fbd;
+	nv->v_idx = v_idx;
+
+	/* Tie napi to netdev */
+	list_add(&nv->napis, &fbn->napis);
+	netif_napi_add(fbn->netdev, &nv->napi, fbnic_poll);
+
+	/* Tie nv back to PCIe dev */
+	nv->dev = fbd->dev;
+
+	/* Initialize vector name */
+	fbnic_name_napi_vector(nv);
+
+	/* Request the IRQ for napi vector */
+	err = fbnic_request_irq(fbd, v_idx, &fbnic_msix_clean_rings,
+				IRQF_SHARED, nv->name, nv);
+	if (err)
+		goto napi_del;
+
+	/* Initialize queue triads */
+	qt = nv->qt;
+
+	while (txt_count) {
+		/* Configure Tx queue */
+		db = &uc_addr[FBNIC_QUEUE(txq_idx) + FBNIC_QUEUE_TWQ0_TAIL];
+
+		/* Assign Tx queue to netdev if applicable */
+		if (txq_count > 0) {
+			u8 flags = FBNIC_RING_F_CTX | FBNIC_RING_F_STATS;
+
+			fbnic_ring_init(&qt->sub0, db, txq_idx, flags);
+			fbn->tx[txq_idx] = &qt->sub0;
+			txq_count--;
+		} else {
+			fbnic_ring_init(&qt->sub0, db, 0,
+					FBNIC_RING_F_DISABLED);
+		}
+
+		/* Configure Tx completion queue */
+		db = &uc_addr[FBNIC_QUEUE(txq_idx) + FBNIC_QUEUE_TCQ_HEAD];
+		fbnic_ring_init(&qt->cmpl, db, 0, 0);
+
+		/* Update Tx queue index */
+		txt_count--;
+		txq_idx += v_count;
+
+		/* Move to next queue triad */
+		qt++;
+	}
+
+	while (rxt_count) {
+		/* Configure header queue */
+		db = &uc_addr[FBNIC_QUEUE(rxq_idx) + FBNIC_QUEUE_BDQ_HPQ_TAIL];
+		fbnic_ring_init(&qt->sub0, db, 0, FBNIC_RING_F_CTX);
+
+		/* Configure payload queue */
+		db = &uc_addr[FBNIC_QUEUE(rxq_idx) + FBNIC_QUEUE_BDQ_PPQ_TAIL];
+		fbnic_ring_init(&qt->sub1, db, 0, FBNIC_RING_F_CTX);
+
+		/* Configure Rx completion queue */
+		db = &uc_addr[FBNIC_QUEUE(rxq_idx) + FBNIC_QUEUE_RCQ_HEAD];
+		fbnic_ring_init(&qt->cmpl, db, rxq_idx, FBNIC_RING_F_STATS);
+		fbn->rx[rxq_idx] = &qt->cmpl;
+
+		/* Update Rx queue index */
+		rxt_count--;
+		rxq_idx += v_count;
+
+		/* Move to next queue triad */
+		qt++;
+	}
+
+	return 0;
+
+napi_del:
+	netif_napi_del(&nv->napi);
+	list_del(&nv->napis);
+	kfree(nv);
+	return err;
+}
+
+int fbnic_alloc_napi_vectors(struct fbnic_net *fbn)
+{
+	unsigned int txq_idx = 0, rxq_idx = 0, v_idx = FBNIC_NON_NAPI_VECTORS;
+	unsigned int num_tx = fbn->num_tx_queues;
+	unsigned int num_rx = fbn->num_rx_queues;
+	unsigned int num_napi = fbn->num_napi;
+	struct fbnic_dev *fbd = fbn->fbd;
+	int err;
+
+	/* Allocate 1 Tx queue per napi vector */
+	if (num_napi < FBNIC_MAX_TXQS && num_napi == num_tx + num_rx) {
+		while (num_tx) {
+			err = fbnic_alloc_napi_vector(fbd, fbn,
+						      num_napi, v_idx,
+						      1, txq_idx, 0, 0);
+			if (err)
+				goto free_vectors;
+
+			/* Update counts and index */
+			num_tx--;
+			txq_idx++;
+
+			v_idx++;
+		}
+	}
+
+	/* Allocate Tx/Rx queue pairs per vector, or allocate remaining Rx */
+	while (num_rx | num_tx) {
+		int tqpv = DIV_ROUND_UP(num_tx, num_napi - txq_idx);
+		int rqpv = DIV_ROUND_UP(num_rx, num_napi - rxq_idx);
+
+		err = fbnic_alloc_napi_vector(fbd, fbn, num_napi, v_idx,
+					      tqpv, txq_idx, rqpv, rxq_idx);
+		if (err)
+			goto free_vectors;
+
+		/* Update counts and index */
+		num_tx -= tqpv;
+		txq_idx++;
+
+		num_rx -= rqpv;
+		rxq_idx++;
+
+		v_idx++;
+	}
+
+	return 0;
+
+free_vectors:
+	fbnic_free_napi_vectors(fbn);
+	return -ENOMEM;
+}
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
new file mode 100644
index 000000000000..4b88f0f76137
--- /dev/null
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#ifndef _FBNIC_TXRX_H_
+#define _FBNIC_TXRX_H_
+
+#include <linux/netdevice.h>
+#include <linux/types.h>
+
+struct fbnic_net;
+
+#define FBNIC_MAX_TXQS			128u
+#define FBNIC_MAX_RXQS			128u
+
+#define FBNIC_RING_F_DISABLED		BIT(0)
+#define FBNIC_RING_F_CTX		BIT(1)
+#define FBNIC_RING_F_STATS		BIT(2)	/* Ring's stats may be used */
+
+struct fbnic_ring {
+	u32 __iomem *doorbell;		/* Pointer to CSR space for ring */
+	u16 size_mask;			/* Size of ring in descriptors - 1 */
+	u8 q_idx;			/* Logical netdev ring index */
+	u8 flags;			/* Ring flags (FBNIC_RING_F_*) */
+
+	u32 head, tail;			/* Head/Tail of ring */
+};
+
+struct fbnic_q_triad {
+	struct fbnic_ring sub0, sub1, cmpl;
+};
+
+struct fbnic_napi_vector {
+	struct napi_struct napi;
+	struct device *dev;		/* Device for DMA unmapping */
+	struct fbnic_dev *fbd;
+	char name[IFNAMSIZ + 9];
+
+	u16 v_idx;
+	u8 txt_count;
+	u8 rxt_count;
+
+	struct list_head napis;
+
+	struct fbnic_q_triad qt[];
+};
+
+#define FBNIC_MAX_TXQS			128u
+#define FBNIC_MAX_RXQS			128u
+
+netdev_tx_t fbnic_xmit_frame(struct sk_buff *skb, struct net_device *dev);
+
+int fbnic_alloc_napi_vectors(struct fbnic_net *fbn);
+void fbnic_free_napi_vectors(struct fbnic_net *fbn);
+
+#endif /* _FBNIC_TXRX_H_ */



