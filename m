Return-Path: <netdev+bounces-164375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0454FA2D8A3
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 21:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F1B11888A18
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 20:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0391F3BB2;
	Sat,  8 Feb 2025 20:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CUwh+GdB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8E3241C93
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 20:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739046622; cv=none; b=prk6Tcq6iYXp6LSJJgGeHDGc8Fl/zH3Axq/oP6fdU1M5zKCU/m58w4K9XFplceu6lp4v+S+E6I4MPcwktzJpd+pQOFTXR94TiUhu7uTUQiUjcIRUIUqnUnIA41RiZmcWQ4NVYtTCELOBlIgw/RXc1G5gl8ZaeFqaaxj6pGrfq50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739046622; c=relaxed/simple;
	bh=87pEfRTnKV96xeMpSy0KROxiluXAc98traQJu9s7dlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nssTqh/La1IGtKLjrLGF5aNmliuNNrQ4RZcgeedVpWpCz4VaGl/peORg1ZWX3q8M3ATjhR4qBUP6dXIk8i4iJkTwzGaF/ZUJPacCzSJ1GMiV2oFGTMFNzWm6L2A8khKV3CscE/JBKygr4lx72/C6ulutAyaYuFIa/Oho/bnJ+LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CUwh+GdB; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-71e22b2387cso2500473a34.3
        for <netdev@vger.kernel.org>; Sat, 08 Feb 2025 12:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739046620; x=1739651420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k87Da2ACADeCGaxRCBYzKnh8Kp1OiWpm7bvX4/oJ6Ws=;
        b=CUwh+GdBahGeMoZODZXWEGw6qZasIyL2ODykuWEqddpke7T9jlJAgrkfYi8TatIzhl
         PbyPUb4MnJtt4+BY5BBg/zYyj98oxiFRbQr2fqQLJobnva2kvqNpi39gV0O+zWP9Jet2
         q2TNx/XjI8XZdJpUaqvovvITExvyas7M+p/ZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739046620; x=1739651420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k87Da2ACADeCGaxRCBYzKnh8Kp1OiWpm7bvX4/oJ6Ws=;
        b=c5bqpn8Wcup5ZV8wmRl5iuCBQL9yD5Dq/Aw2eGLL3qLBwJ6alBhcnBGSZjfqzBqznt
         1R2Wxw0vF/NLCh3iJFXzz2JRxFMhgxz7UueSSGJo/YG0l80MJzxyNw1UED8mFsBVbvIi
         IEwKVnvdXbQkreGrlw0NY1O09USYxeBKZsmNGEMljMmlekWoL26ieDj/DtSq0KrwHCtK
         ya8FgwMkZeZTfWsCBjL8YJEErqK9L2ySRkWKX/FMnfQZaMjFnmknW6rTcCHJZM620lpv
         F4xo90v3SY3s238M5RyLu67omeie0UHYQXe19N5w4nEdoBRY5KtOMyfgWrM85DDK7XJj
         7PCw==
X-Gm-Message-State: AOJu0Yw9QLms0K1ikpiU75fh34AqW9kIn563JUrIjWIbgFJcPRU7IeC5
	Ks/qAI1XGqDnjXZo7ttyhUYL0th9GNyon9eaJPUFJPHCeOVylNely1SfreSmiQ==
X-Gm-Gg: ASbGnctc/ge4E0v9gFeOVKbhWPrDC9EJDaAAJy+58LWVefmot8vmzPbxwcg803L7xwB
	2LYXcvSDzeIcun9atBEvfPyv4U/dtW1CqmAgKvGuu7fBivoUaKuhlMCtorJ5JypaErbMojzKqvz
	8oleWOm/hOXIPjClgZoOmk/8bvim/wvWYM9pmtJq+FraGeYPjcmAymKkoOMC5uf6mHwzR0zO7VG
	Glg/oP+Ofk+KxlwOpGfO8D58h8wr89N/lOP+vhcL8ojwA61tWAWsejfGqTs0FWd/e2nHpt1fmBe
	SJwVcl0B1H1slisFqYOINxtQ+k+p/IhnoTHmbU/sTkbf8tsKKSveKoMwjkg6PyWneW4=
X-Google-Smtp-Source: AGHT+IENpyIIr3h1KfmPH71lspQy9fQk3Z+P3mK0CJvNyXqQZGcyA4Ok/huOlnN3xbe3rsiG6fChnA==
X-Received: by 2002:a05:6830:6010:b0:71e:904:6aed with SMTP id 46e09a7af769-726b87db5e6mr5931754a34.10.1739046620061;
        Sat, 08 Feb 2025 12:30:20 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726af932f78sm1564130a34.18.2025.02.08.12.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 12:30:18 -0800 (PST)
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
Subject: [PATCH net-next v4 10/10] bnxt_en: Add TPH support in BNXT driver
Date: Sat,  8 Feb 2025 12:29:16 -0800
Message-ID: <20250208202916.1391614-11-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250208202916.1391614-1-michael.chan@broadcom.com>
References: <20250208202916.1391614-1-michael.chan@broadcom.com>
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


