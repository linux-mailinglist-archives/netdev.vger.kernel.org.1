Return-Path: <netdev+bounces-162328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD8CA268E5
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 01:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A97A7A33B7
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 00:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CC97082A;
	Tue,  4 Feb 2025 00:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dim4ixqC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656F07081A
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 00:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738630040; cv=none; b=b1OFG29SAKP5mI2FOSUSJWUL0ZIJPJL33jBVqMwslycY2m47COyq0ohxvUeMK/nAPn1Z8E/PM69yUxYpjHhFhWeaX4NLeOpYajwtfm7QKUoTR8Aibr5Nkye1rCELJNB5mPZqtUD59MzdYNm+6VOGBXWbFMUOhxx901vxPLDsG6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738630040; c=relaxed/simple;
	bh=87pEfRTnKV96xeMpSy0KROxiluXAc98traQJu9s7dlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rqeq0CbSSQBaJjaK78dVjjbqEaoiZ0PJwQwtIHTHYUHX3S1s6ePKeO99bxxeOOCM4IqZ/R43QPF/K2NrJ1YAew8jaqCrZIJDSP1UhFE0GlVdrC+odaEQb9sC4wdAg5nHQl/WzhjIBtZplCOt5acvNdIAf8N2px229y54qbL60zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dim4ixqC; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2a383315d96so2395481fac.3
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 16:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738630037; x=1739234837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k87Da2ACADeCGaxRCBYzKnh8Kp1OiWpm7bvX4/oJ6Ws=;
        b=dim4ixqCWU19wQOISFX1ptqmqMf1vj3WwC5+0tp0rUOF7pIEoz0CqSzNCU/Xvn7vIG
         FUEY5SGjlcmuJq+4sGjStqvLtn3E8nmxp7NuJW0/xMJv3Y6leHH/pa3ak+4la0w+nMHj
         sV/SS+yuNGnjFHKO9nFmiD0+7ERR9MlRbxjJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738630037; x=1739234837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k87Da2ACADeCGaxRCBYzKnh8Kp1OiWpm7bvX4/oJ6Ws=;
        b=lVT6SoZP/WyAl+QagSiLnpJGqpC8xezqD6y7kt1wbwAqwRcdnzjTh9hAIRVrIcTJFZ
         ljjGG1C695DbT270dUf3iz1Gq/SUYJp0/6ZZSVUD1/ZUttKdS6C4khmE+0nQTw3PsQMm
         3wnpA65Mwxq67IEDWe9SRXo2Fez+BPWrjY6IXE009+LJ1tJow3W963cLYdW31Pd6zUeU
         DZuTgFrow+qWqvB9gDX9mjftvwWDYc6hBchcz/kinPTtYmnurX6dKvxsKM4sQPzaTIjP
         3XwyOHSMjXJgLdvDXXeSyj/y21p8l7mVcQFSsGn8wuZOdge2y/9Ut1xLKqbAVZwchlHu
         tQhg==
X-Gm-Message-State: AOJu0Yzi2jWzEkp7+vE/ApVJwsCJLNKDcktCu1NB+10Mls4uh27up9nZ
	smc7bQ0ovukzMP69XBqSK8RBzPPLzoMwVoNSSqXtXB7JaY4uQYcwg2F3CZy3QA==
X-Gm-Gg: ASbGnctVt3cybLzLPn5g6wpwFGgjACKZoPuy13kIkZRE6dyTI6RBhZsR9XlRnG8D/R9
	3+83iKtu8RuvCluj0jrQ1UbeZ97pweacyrbEoeasB7VWJXSlpuqCzGKwzkrHYPGgATswRLuZVli
	zq0WAXvrbLtUtw7ADoKTU3dZJLVntm/2sHBqT+v3VW8TqT2vrcPOE6pTL2yAGaaJRFGzlhIH7R2
	RxcT9+TuXj0QUkA+3m/4pC5kTuKe15IzY4EJiVAez25AI0lm+b0G7w17NzQTjtVCfgW3FY2npg6
	ovc86aeyL7y9nk6W61XqPXDUYBrRDIqTVuZ9/hA5j6iwPVQvz1Nk2y11ktrrjVbevVE=
X-Google-Smtp-Source: AGHT+IG05ljVsBMtMiEBNd4RZyd6jEVVfQnza27egg8Amh+urtd9JBJp5GxIw+Oyr6/JdzLlwdtTvg==
X-Received: by 2002:a05:6871:a516:b0:29e:460d:f74a with SMTP id 586e51a60fabf-2b32f100b04mr14248697fac.3.1738630037313;
        Mon, 03 Feb 2025 16:47:17 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b356658291sm3680495fac.46.2025.02.03.16.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 16:47:16 -0800 (PST)
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
Subject: [PATCH net-next v3 10/10] bnxt_en: Add TPH support in BNXT driver
Date: Mon,  3 Feb 2025 16:46:09 -0800
Message-ID: <20250204004609.1107078-11-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250204004609.1107078-1-michael.chan@broadcom.com>
References: <20250204004609.1107078-1-michael.chan@broadcom.com>
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
index fee9baff9e5a..2b7df91840fd 100644
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
 
@@ -11359,6 +11362,83 @@ static int bnxt_tx_queue_start(struct bnxt *bp, int idx)
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
@@ -11381,11 +11461,18 @@ static void bnxt_free_irq(struct bnxt *bp)
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
@@ -11405,6 +11492,12 @@ static int bnxt_request_irq(struct bnxt *bp)
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
@@ -11428,8 +11521,11 @@ static int bnxt_request_irq(struct bnxt *bp)
 
 		if (zalloc_cpumask_var(&irq->cpu_mask, GFP_KERNEL)) {
 			int numa_node = dev_to_node(&bp->pdev->dev);
+			u16 tag;
 
 			irq->have_cpumask = 1;
+			irq->msix_nr = map_idx;
+			irq->ring_nr = i;
 			cpumask_set_cpu(cpumask_local_spread(i, numa_node),
 					irq->cpu_mask);
 			rc = irq_update_affinity_hint(irq->vector, irq->cpu_mask);
@@ -11439,6 +11535,16 @@ static int bnxt_request_irq(struct bnxt *bp)
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


