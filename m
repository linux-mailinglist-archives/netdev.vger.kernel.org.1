Return-Path: <netdev+bounces-159028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF1FA14239
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 20:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFA063A9BBE
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 19:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E54241680;
	Thu, 16 Jan 2025 19:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="M6B+/W7q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3C322FAF9
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 19:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737055496; cv=none; b=pUvM3j5UXVA8B+U7btGUVIkn1K6AKlR2r6vLqyjgKHj2KIfH54s1ep8itgcIqv2vG4ZDIZm5dHzCbF6CVKJN/JwP+5l42ehHOTxkH5ryDp4sLv2znRvAjCrrG0pZCjca7csHAAkVCCeiedFD1o83qBf9XbcaHsWEETBiC//sh5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737055496; c=relaxed/simple;
	bh=bVZ02ozBZy15suKNeBy2zK3q3GtgbrwIotYxrQWb57g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iL7s8js4LfOWVMMLIHCrErjV305ASQwCD6GCrQ4U6alCH9+hCWlS28pj9kx4lp0InNYW8/AMy8fg6oHFq4H7FZm1YOP8Fxh3WlSOPMAesQ9JrgAoHu2oziZRhNpjyatGgEWpZUdTHaDFTA3QcZ7lOkmFLkMsy1I/uKPErsB5k2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=M6B+/W7q; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ee8e8e29f6so1950014a91.0
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 11:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737055494; x=1737660294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWCb+pEJ2OfgiyRV3/3UKjrPUO+fExMMGN/oK4bh2pA=;
        b=M6B+/W7qzucW8L7TlPngookN63/9jquCc3SjMQ9yL8tyKoEpOosqYLinzv7pNXZ37+
         YC6LwdaZ5XDyxCGsGbtU/jiAq3T0tZSemjTO5mFqyeIhj4W3lRMwxyYjwyyg8xS4ZoHY
         LlUgjSNBLMVtC0lPwAHHekjV0dlF+84EzhxJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737055494; x=1737660294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWCb+pEJ2OfgiyRV3/3UKjrPUO+fExMMGN/oK4bh2pA=;
        b=apRfjLiHXNmu29yEw9k058sffNVoJmNTp7nFYGjTLw09OC1DlVV23ABmPIohLTUQ+6
         nyE2giEYWe1IuELS/2kMWZGLJdT6YuKyCtmejMqZ7qsaZ2V7clMIV4XvwLXIrAGLwNCc
         0DNKJM9A4VupakgE0huEkZZJwb4FK2w0+4Rb8WiKIrR/JuCPX10yHHQ9duRAU1FD1itm
         5h0aXB+1G3I9tnprBWwNDy9BVAgFJJeayE9xXpyTY6WHuSFRKH9tUALIZntnkqva/W9p
         lLRJfIMnvjR0IKwZga8hLdJKo3deE3KrbK0XfYwKqWLRVgBJnXMQL2GuJ5sOL4Nh3dm0
         giNA==
X-Gm-Message-State: AOJu0YyMGbL9wymULb2+MpfoIAKibhOZB0GLM4YPVyuNsNUeJu+Lpo9l
	Hs1mRkV5bGHJm3D18sp/5l5uLV0YOoRpawtJcaBaXin56PC0xAvdeswJtYBqWg==
X-Gm-Gg: ASbGncutYLNK/qlKJ/EE1GLlpK1AKB1pkFG3XuXGbkfrqTSz8G1rjEm2wkfmh2JJJ2K
	LullV8rCb6PKqon+Bu31O/OuJOy8JeUVukrUeNd0ocSXFoAy0JNDLUas/Ctay0M/e3a/5OZtOBq
	9B95SaqFggeyE7qrK0D2r6iQlnqHf/sVZPTf8vT8IDc24gzAEit7zSS1hqRQcWj8ItrBHVoY5qG
	GZfpGiOe121gc57xeyUEdEhFPoNQzYTVqJCRyRVE52xUWIRH9jbJiQ9w4T2O+1u3ILA5iGVrdSG
	SGzhvl35cTm2NMoECDc901NV9pGbGvaX
X-Google-Smtp-Source: AGHT+IFeU76btJdxQKNsFy5R34EdpQlpvDCJZUvpG7rd92pBuO2NJYcee91jbyvHN96do/EOs3ubsw==
X-Received: by 2002:a17:90b:2cc7:b0:2ee:5edc:4b2 with SMTP id 98e67ed59e1d1-2f548f6a952mr49828356a91.20.1737055493692;
        Thu, 16 Jan 2025 11:24:53 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f77615720asm491017a91.19.2025.01.16.11.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 11:24:52 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	michal.swiatkowski@linux.intel.com,
	helgaas@kernel.org,
	Manoj Panicker <manoj.panicker2@amd.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Wei Huang <wei.huang2@amd.com>,
	Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH net-next v2 10/10] bnxt_en: Add TPH support in BNXT driver
Date: Thu, 16 Jan 2025 11:23:43 -0800
Message-ID: <20250116192343.34535-11-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250116192343.34535-1-michael.chan@broadcom.com>
References: <20250116192343.34535-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Manoj Panicker <manoj.panicker2@amd.com>

Add TPH support to the Broadcom BNXT device driver. This allows the
driver to utilize TPH functions for retrieving and configuring Steering
Tags when changing interrupt affinity. With compatible NIC firmware,
network traffic will be tagged correctly with Steering Tags, resulting
in significant memory bandwidth savings and other advantages as
demonstrated by real network benchmarks on TPH-capable platforms.

Co-developed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Manoj Panicker <manoj.panicker2@amd.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
Cc: Bjorn Helgaas <helgaas@kernel.org>

Previous driver series fixing rtnl_lock and empty release function:

https://lore.kernel.org/netdev/20241115200412.1340286-1-wei.huang2@amd.com/

v5 of the PCI series using netdev_rx_queue_restart():

https://lore.kernel.org/netdev/20240916205103.3882081-5-wei.huang2@amd.com/

v1 of the PCI series using open/close:

https://lore.kernel.org/netdev/20240509162741.1937586-9-wei.huang2@amd.com/
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 105 ++++++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |   7 ++
 2 files changed, 112 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 0a10a4cffcc8..8c24642b8812 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -55,6 +55,8 @@
 #include <net/page_pool/helpers.h>
 #include <linux/align.h>
 #include <net/netdev_queues.h>
+#include <net/netdev_rx_queue.h>
+#include <linux/pci-tph.h>
 
 #include "bnxt_hsi.h"
 #include "bnxt.h"
@@ -11330,6 +11332,83 @@ static int bnxt_tx_queue_start(struct bnxt *bp, int idx)
 	return 0;
 }
 
+static void bnxt_irq_affinity_notify(struct irq_affinity_notify *notify,
+				     const cpumask_t *mask)
+{
+	struct bnxt_irq *irq;
+	u16 tag;
+	int err;
+
+	irq = container_of(notify, struct bnxt_irq, affinity_notify);
+
+	if (!irq->bp->tph_mode)
+		return;
+
+	cpumask_copy(irq->cpu_mask, mask);
+
+	if (irq->ring_nr >= irq->bp->rx_nr_rings)
+		return;
+
+	if (pcie_tph_get_cpu_st(irq->bp->pdev, TPH_MEM_TYPE_VM,
+				cpumask_first(irq->cpu_mask), &tag))
+		return;
+
+	if (pcie_tph_set_st_entry(irq->bp->pdev, irq->msix_nr, tag))
+		return;
+
+	rtnl_lock();
+	if (netif_running(irq->bp->dev)) {
+		err = netdev_rx_queue_restart(irq->bp->dev, irq->ring_nr);
+		if (err)
+			netdev_err(irq->bp->dev,
+				   "RX queue restart failed: err=%d\n", err);
+	}
+	rtnl_unlock();
+}
+
+static void bnxt_irq_affinity_release(struct kref *ref)
+{
+	struct irq_affinity_notify *notify =
+		container_of(ref, struct irq_affinity_notify, kref);
+	struct bnxt_irq *irq;
+
+	irq = container_of(notify, struct bnxt_irq, affinity_notify);
+
+	if (!irq->bp->tph_mode)
+		return;
+
+	if (pcie_tph_set_st_entry(irq->bp->pdev, irq->msix_nr, 0)) {
+		netdev_err(irq->bp->dev,
+			   "Setting ST=0 for MSIX entry %d failed\n",
+			   irq->msix_nr);
+		return;
+	}
+}
+
+static void bnxt_release_irq_notifier(struct bnxt_irq *irq)
+{
+	irq_set_affinity_notifier(irq->vector, NULL);
+}
+
+static void bnxt_register_irq_notifier(struct bnxt *bp, struct bnxt_irq *irq)
+{
+	struct irq_affinity_notify *notify;
+
+	irq->bp = bp;
+
+	/* Nothing to do if TPH is not enabled */
+	if (!bp->tph_mode)
+		return;
+
+	/* Register IRQ affinity notifier */
+	notify = &irq->affinity_notify;
+	notify->irq = irq->vector;
+	notify->notify = bnxt_irq_affinity_notify;
+	notify->release = bnxt_irq_affinity_release;
+
+	irq_set_affinity_notifier(irq->vector, notify);
+}
+
 static void bnxt_free_irq(struct bnxt *bp)
 {
 	struct bnxt_irq *irq;
@@ -11352,11 +11431,18 @@ static void bnxt_free_irq(struct bnxt *bp)
 				free_cpumask_var(irq->cpu_mask);
 				irq->have_cpumask = 0;
 			}
+
+			bnxt_release_irq_notifier(irq);
+
 			free_irq(irq->vector, bp->bnapi[i]);
 		}
 
 		irq->requested = 0;
 	}
+
+	/* Disable TPH support */
+	pcie_disable_tph(bp->pdev);
+	bp->tph_mode = 0;
 }
 
 static int bnxt_request_irq(struct bnxt *bp)
@@ -11376,6 +11462,12 @@ static int bnxt_request_irq(struct bnxt *bp)
 #ifdef CONFIG_RFS_ACCEL
 	rmap = bp->dev->rx_cpu_rmap;
 #endif
+
+	/* Enable TPH support as part of IRQ request */
+	rc = pcie_enable_tph(bp->pdev, PCI_TPH_ST_IV_MODE);
+	if (!rc)
+		bp->tph_mode = PCI_TPH_ST_IV_MODE;
+
 	for (i = 0, j = 0; i < bp->cp_nr_rings; i++) {
 		int map_idx = bnxt_cp_num_to_irq_num(bp, i);
 		struct bnxt_irq *irq = &bp->irq_tbl[map_idx];
@@ -11399,8 +11491,11 @@ static int bnxt_request_irq(struct bnxt *bp)
 
 		if (zalloc_cpumask_var(&irq->cpu_mask, GFP_KERNEL)) {
 			int numa_node = dev_to_node(&bp->pdev->dev);
+			u16 tag;
 
 			irq->have_cpumask = 1;
+			irq->msix_nr = map_idx;
+			irq->ring_nr = i;
 			cpumask_set_cpu(cpumask_local_spread(i, numa_node),
 					irq->cpu_mask);
 			rc = irq_update_affinity_hint(irq->vector, irq->cpu_mask);
@@ -11410,6 +11505,16 @@ static int bnxt_request_irq(struct bnxt *bp)
 					    irq->vector);
 				break;
 			}
+
+			bnxt_register_irq_notifier(bp, irq);
+
+			/* Init ST table entry */
+			if (pcie_tph_get_cpu_st(irq->bp->pdev, TPH_MEM_TYPE_VM,
+						cpumask_first(irq->cpu_mask),
+						&tag))
+				continue;
+
+			pcie_tph_set_st_entry(irq->bp->pdev, irq->msix_nr, tag);
 		}
 	}
 	return rc;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 826ae030fc09..02dc2ed9c75d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1234,6 +1234,11 @@ struct bnxt_irq {
 	u8		have_cpumask:1;
 	char		name[IFNAMSIZ + BNXT_IRQ_NAME_EXTRA];
 	cpumask_var_t	cpu_mask;
+
+	struct bnxt	*bp;
+	int		msix_nr;
+	int		ring_nr;
+	struct irq_affinity_notify affinity_notify;
 };
 
 #define HWRM_RING_ALLOC_TX	0x1
@@ -2229,6 +2234,8 @@ struct bnxt {
 	struct net_device	*dev;
 	struct pci_dev		*pdev;
 
+	u8			tph_mode;
+
 	atomic_t		intr_sem;
 
 	u32			flags;
-- 
2.30.1


