Return-Path: <netdev+bounces-165759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A381FA33479
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 02:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFED2188A2C2
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 01:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DF113B58B;
	Thu, 13 Feb 2025 01:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DRGo163u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC00153598
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 01:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739409227; cv=none; b=cIKL57ZKwjyoNiZ7SoOp5uNAVzArOgufQdWFkYAC8oVAPpzCjlOzDGBnHXtkmUyd+782vN8toPBBSD+69Ra/uLKG+LRsOfLY92BlYuVv9R2sy0rsVsgIUBdm+uamOQD8e0g+xMZz+fuiAfI4VbJ/drKJkm8AhkxJWaZL0pnsj1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739409227; c=relaxed/simple;
	bh=t1ZTNMpHicfVMyIowy0DXLMxgE2fqOtZdkWdpAHwIUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s8A+9kJb9HMtACqomVVqXon8c00w1EPauq/btpv08fm2C5m+7bWnEF5aMsK8BOKRv52JHI8K0GS/ABbTZt7pmRbFcXz8vhAOH7rUYzG11nxQQMTLwRbdv8jT/Hgo1owfNE9IxNBRg8wOwTwbjGDXQTnH7x3U/+4RvDzdnutT8f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DRGo163u; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-726f1de8190so118268a34.3
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 17:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739409224; x=1740014024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4R/yPIFFTjU1z1BbTkCQhD01Z9CT3ll1m6Xp1u1mhmY=;
        b=DRGo163uBszmPi9AnYk+KW+doS9ICEzsfkslc6UhhJ0sXzBUQJAVqOr67biStp/D4U
         slMUpltAvwuBAvLRYA5qmx4ovBzDg+4VMwEigw2/IkI8cRdIi4V87lTaUb7/sC6QiEej
         BupWYHDJwPBW46RwdDDzaTvLnzFtB5DOtAb/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739409224; x=1740014024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4R/yPIFFTjU1z1BbTkCQhD01Z9CT3ll1m6Xp1u1mhmY=;
        b=NkkNfjwKZr8EwtD53Sj/SX5AvHrqdnE5+n4NIzwjKVr857IIeMFd2u5EHl9OYs2Ygz
         yp0/x/6NUQ79jnFicSLHLKOU8eZRtQTi7ZlVkIQ/StyBR/VZkbI3HlbjJPcvVQF8dIQ6
         AkhlHVIxt2OCxnM0RYguXnEtwhIMF77CLQ4Vag7xflMreeXjEV+BxhumGowCDAqTzrCk
         OZlLkSHeEJ3HlwPkEobq1RbSCOaJl6gCHCwFX8jevrn98GIP+bLkM3/IrDLBu3W5fqy/
         4R9LuSr39SWMygOtPJKcMtuNe5XqMR1HB++0ljgz+hNc+P6GLgI3BdphIZAGl8n8MzZf
         5eRw==
X-Gm-Message-State: AOJu0YyVD1F4nuo1ufK74SnoLyaUR6j2nJpisXoMIG5edcgwWtn2J8IZ
	27YcOsTxPaY+HVqn1yqvPt3M4nBkJ7zpDsnhbnDECiVAglwAX98IplxpjxvOrg==
X-Gm-Gg: ASbGncvZakyH4XbIurZYX3Yju9jh0Tyn1doKvPxst1qHqg0RtHVcljcw/8pTRJ0Ta6/
	Vkpo5nXQ691T3aCtireBvClNW+1uNBQ7LC/wz90xpZO0Tv6p9LaqDbdQnHyCGhvxHwXqBDl8rgE
	ken3T//uj+FeI0k2RCUY/3BOS4Ku2l2vvy4+nFCl8bQH6PQCg93TvL8I4RkAiw3mnqcp5xGHmK/
	yQXaCeBHtoQoV2Qjzqem/l0yJBJZJLtM0wKiBNxb5aUkcTyNO2N36ITHCJ1bCUDVgWOEBBs+lNe
	GaXvpcy7pQOvBLq+1tIuFqCGhDJdksEfblb/0nVJQkdB/U8xmq0q8l/Nmdsq6BTuAuo=
X-Google-Smtp-Source: AGHT+IFDgEgUU+aBUSTGDH1M5Hq/KLaD64Zz7BNNWUzXGYbKnm4egPysQsPnv6ceNlR5OFNcSV1DMg==
X-Received: by 2002:a05:6830:3786:b0:71d:fb64:b606 with SMTP id 46e09a7af769-726fe7eea07mr924552a34.23.1739409223871;
        Wed, 12 Feb 2025 17:13:43 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-727001cdb70sm195967a34.13.2025.02.12.17.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 17:13:43 -0800 (PST)
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
	horms@kernel.org,
	Manoj Panicker <manoj.panicker2@amd.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Wei Huang <wei.huang2@amd.com>,
	Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH net-next v5 11/11] bnxt_en: Add TPH support in BNXT driver
Date: Wed, 12 Feb 2025 17:12:39 -0800
Message-ID: <20250213011240.1640031-12-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250213011240.1640031-1-michael.chan@broadcom.com>
References: <20250213011240.1640031-1-michael.chan@broadcom.com>
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

v3:
Add MODULE_IMPORT_NS("NETDEV_INTERNAL")

Previous driver series fixing rtnl_lock and empty release function:

https://lore.kernel.org/netdev/20241115200412.1340286-1-wei.huang2@amd.com/

v5 of the PCI series using netdev_rx_queue_restart():

https://lore.kernel.org/netdev/20240916205103.3882081-5-wei.huang2@amd.com/

v1 of the PCI series using open/close:

https://lore.kernel.org/netdev/20240509162741.1937586-9-wei.huang2@amd.com/
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 106 ++++++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |   5 +
 2 files changed, 111 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 1997cdbd5801..15c57a06ecaf 100644
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
@@ -76,6 +78,7 @@
 #define BNXT_DEF_MSG_ENABLE	(NETIF_MSG_DRV | NETIF_MSG_HW | \
 				 NETIF_MSG_TX_ERR)
 
+MODULE_IMPORT_NS("NETDEV_INTERNAL");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Broadcom NetXtreme network driver");
 
@@ -11351,6 +11354,83 @@ static int bnxt_tx_queue_start(struct bnxt *bp, int idx)
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
@@ -11373,11 +11453,18 @@ static void bnxt_free_irq(struct bnxt *bp)
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
@@ -11397,6 +11484,12 @@ static int bnxt_request_irq(struct bnxt *bp)
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
@@ -11420,8 +11513,11 @@ static int bnxt_request_irq(struct bnxt *bp)
 
 		if (zalloc_cpumask_var(&irq->cpu_mask, GFP_KERNEL)) {
 			int numa_node = dev_to_node(&bp->pdev->dev);
+			u16 tag;
 
 			irq->have_cpumask = 1;
+			irq->msix_nr = map_idx;
+			irq->ring_nr = i;
 			cpumask_set_cpu(cpumask_local_spread(i, numa_node),
 					irq->cpu_mask);
 			rc = irq_update_affinity_hint(irq->vector, irq->cpu_mask);
@@ -11431,6 +11527,16 @@ static int bnxt_request_irq(struct bnxt *bp)
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
index 4e20878e7714..e85b5ce94f58 100644
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
-- 
2.30.1


