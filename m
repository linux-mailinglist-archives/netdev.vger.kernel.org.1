Return-Path: <netdev+bounces-157608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 108AEA0AF6B
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 07:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73E301661C3
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 06:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFAD231C9F;
	Mon, 13 Jan 2025 06:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PYGW4cn7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D31233144
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 06:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736750423; cv=none; b=KkQSPRuT1Qwe2VSIuipHMhAJWDcxXlwZQc3wk/20Mvr1kw8n5OkfJgxKn1ZMkqBfQzwWciULCISX8E4VUS4OshtbK0JkmFNmZBq9wN/qVjoOehNl3ImBeF6P8lrfZ9Kv4VStuslA4lOXwLF3TtPMyM5JFfdPlSrSzQD64x5kRto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736750423; c=relaxed/simple;
	bh=mnedUmr9IljE/hJC4fKm2q61/HXseTzHXW4pQkrn7vI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iloYNQOjlncaM/PzwMghbPSMn5sj80q9EQ/hsmjaZbL5sYVUdJx3f79KZPmAsWjG6g2RJQKEbbmZPbqC76q7OnrSmmjavhOeW2NlO2/jUpd2xsDsut2jX9XU1uFGEUyKey4pV8uICe5Gj12zKIXLoDCLAps4Bkf7RrVAjGpSEYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PYGW4cn7; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21669fd5c7cso68094415ad.3
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 22:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736750421; x=1737355221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vA/WKiwKiQZNmXyvLp7Dbup9U3dRaWdy45DN8g4yOEA=;
        b=PYGW4cn7b33kKrNfVjmG/B21x7YgOJZLqrFnUT4FG4i0WDjBHl638PmcPhPV3Iz4BM
         dH+6bFnsywiF7J4Tl6jle7Kdifg/kl6sSP9o6gIs7efMf8Mz7B7mQ6S0XBrIgcbQq6V4
         vbcaBkXi6ojMBnzdCYvIHDOnxNg2jhMKTxJpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736750421; x=1737355221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vA/WKiwKiQZNmXyvLp7Dbup9U3dRaWdy45DN8g4yOEA=;
        b=oN6hP3idzg2sm978pUG6CS2ev+Z8/0rrUHKeapJRjqcLjjnkFJEs0Jqc8IPenrlyn4
         blWnHieFdBdgrFshKnFTPqglUpUzAcoPvA2Q49Vn12QmNB/x1WmIBa+CZbLUlxUCIrdG
         yIhoVZv15urG+FagOR+DSO9pxPvkYXFn35R68/Y3NbpfgV0jE8MUPEdZMG9Vgvgf0byy
         Idlkl5Nk4IXaHSOtHBkGnCzEVf5Uu4P9VBoTalRsbQmuJk4k5OQgwz+zlTJD3Tblh7Wz
         FyW98vLhqWiyRa5iaoa5jKDV7Wc+dMSwrGR3lt8HZ5CBLkdKHp4hAu33Cz2LHianS+la
         LcVA==
X-Gm-Message-State: AOJu0YwL2FI5e98IGXZ1QMBZ/QHVxgyjEv7Nl4bGm8Xo/RGMhKnX2d8y
	f//2XrGsqDR9XHUYB2tL+hbZScUoXo5A1PDF083Lv1faeuOc6s6yn/P04karSg==
X-Gm-Gg: ASbGncvL/Z3UdGDGGIGKBzTimTWANo5fqNTxzcQRYRvY0fPyWl6vNMaaYo+cy+AXBTG
	eDxXzqKTIAiXf9AiimlGzpll9WfGJNGa4VbkXBfPYgPbdzq5TbggYxepGvjxXrO2UsxQn+bI7vs
	Ee5yzlCRHZAIvhD7kLOGPfPIxQxmQhCyyJeE/AlGUoMIZKiN+4CPJgkmCwcG31rfPyQRlg0hNND
	85EIv8UVohIASXd79lwroq86AkF0UYtLqc+X8qcLCqa3PC1wGxN3Nwo/Z/NeyV9sPn5u1OBjTTU
	UJlVuh68kWyo7KrrbbrMEK718pHqMCWG
X-Google-Smtp-Source: AGHT+IHsZzeOkmVV7zInYnWyUChuf43zF1VwwSXgxvtpQ1SVDNOAdZMX4rOEYW0riGwT2QtNN2MKOQ==
X-Received: by 2002:a17:902:ec83:b0:215:7ce4:57bc with SMTP id d9443c01a7336-21a83f54a5cmr284780155ad.16.1736750419683;
        Sun, 12 Jan 2025 22:40:19 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f254264sm46488165ad.233.2025.01.12.22.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 22:40:19 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	somnath.kotur@broadcom.com,
	Manoj Panicker <manoj.panicker2@amd.com>,
	Wei Huang <wei.huang2@amd.com>,
	Ajit Khaparde <ajit.khaparde@broadcom.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH net-next 10/10] bnxt_en: Add TPH support in BNXT driver
Date: Sun, 12 Jan 2025 22:39:27 -0800
Message-ID: <20250113063927.4017173-11-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250113063927.4017173-1-michael.chan@broadcom.com>
References: <20250113063927.4017173-1-michael.chan@broadcom.com>
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
index eddb4de959c6..8ca73da801a3 100644
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
@@ -11326,6 +11328,83 @@ static int bnxt_tx_queue_start(struct bnxt *bp, int idx)
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
@@ -11348,11 +11427,18 @@ static void bnxt_free_irq(struct bnxt *bp)
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
@@ -11372,6 +11458,12 @@ static int bnxt_request_irq(struct bnxt *bp)
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
@@ -11395,8 +11487,11 @@ static int bnxt_request_irq(struct bnxt *bp)
 
 		if (zalloc_cpumask_var(&irq->cpu_mask, GFP_KERNEL)) {
 			int numa_node = dev_to_node(&bp->pdev->dev);
+			u16 tag;
 
 			irq->have_cpumask = 1;
+			irq->msix_nr = map_idx;
+			irq->ring_nr = i;
 			cpumask_set_cpu(cpumask_local_spread(i, numa_node),
 					irq->cpu_mask);
 			rc = irq_update_affinity_hint(irq->vector, irq->cpu_mask);
@@ -11406,6 +11501,16 @@ static int bnxt_request_irq(struct bnxt *bp)
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
index a634ad76177d..7069d7f6f90b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1231,6 +1231,11 @@ struct bnxt_irq {
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
@@ -2226,6 +2231,8 @@ struct bnxt {
 	struct net_device	*dev;
 	struct pci_dev		*pdev;
 
+	u8			tph_mode;
+
 	atomic_t		intr_sem;
 
 	u32			flags;
-- 
2.30.1


