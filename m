Return-Path: <netdev+bounces-155110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD72A0115B
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 01:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 115F01881B8A
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 00:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6128142A87;
	Sat,  4 Jan 2025 00:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WIyHNf54"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7A3EAC7
	for <netdev@vger.kernel.org>; Sat,  4 Jan 2025 00:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735951431; cv=none; b=mH0uZ/vT+KeZyEoSm2OuJPcBRplbWPynJTyJ2sn4bGPI9/HgQQx435rqt0wlwPr4qRjQV2ubyI1GvWD8f0G2UL7DDiTPPPEhoNDV3/g9lmoZSLB9JSln9EPbq2OL48cyoAWju0zU0DzgsNRxcuIcYz2tfNWPSseS0cMf91Irkg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735951431; c=relaxed/simple;
	bh=xHiCt/y+3f0LvtPqy8jiQRBJ2SQzi16seHZcNlI/olI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YzOAWs9E+eiOR5YFjJOmk2LicbG+Eg5fCY/yxligxLRzwKvDZUgaPJgAknUfdauVK16cZvvIc3bMEV/eshbRVvwvER1ZqgFj/i6WOEcPCys8HAYF1I/xAR4KTXiwJm+0LgP1j+btklyNlzvRW14ADi7bU2ku2uw//DvWLYVheI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WIyHNf54; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735951430; x=1767487430;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xHiCt/y+3f0LvtPqy8jiQRBJ2SQzi16seHZcNlI/olI=;
  b=WIyHNf541HVUbT/A0kXxoQEeZWuZCI/Gujgh8TSnoy0SlNnpMLd15G2n
   SlVF1+4SKnAl4eAwHDWm7DhmClrUkeNMC0+6/k4STpc2Q6njTPovHo8qc
   G+wNfU/kVbYMM4oHzbLQ3G07edKqXScIBsiE6ePcqdM3+EtqNj/VDSkWm
   CAe4RWyeicigzssg3XpVsK9lco9QQwvaNsif+Ue+yFXlMjwAj4vKxXB+A
   8KgOMFtj6Zx10Rdhxaj1taxbQ1r6IHVJ1I8LROKfQ4Pma0CRzoMahKIOU
   jaZXXT0JbkK46TAGsrI+7pwb/j+Mu+u8BaOatEAV7n5STL8VGbVPpL2RG
   w==;
X-CSE-ConnectionGUID: Lyn3LU7dQAuX54FL4E8OUA==
X-CSE-MsgGUID: yi5qOcRBSdS/PBRXQ4WYbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11304"; a="36075983"
X-IronPort-AV: E=Sophos;i="6.12,287,1728975600"; 
   d="scan'208";a="36075983"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2025 16:43:49 -0800
X-CSE-ConnectionGUID: DzgqcQRESCOtxv0W5nd8fg==
X-CSE-MsgGUID: 8Sda/QHYS3ibiCdJJunuQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,287,1728975600"; 
   d="scan'208";a="106879737"
Received: from spandruv-desk1.amr.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.110.48])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2025 16:43:45 -0800
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	michael.chan@broadcom.com,
	tariqt@nvidia.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jdamato@fastly.com,
	shayd@nvidia.com,
	akpm@linux-foundation.org,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH net-next v3 4/6] bnxt: use napi's irq affinity
Date: Fri,  3 Jan 2025 17:43:12 -0700
Message-ID: <20250104004314.208259-5-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250104004314.208259-1-ahmed.zaki@intel.com>
References: <20250104004314.208259-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Delete the driver CPU affinity info and use the core's napi config
instead.

Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 26 ++++-------------------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  2 --
 2 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index cc3ca3440b0a..fcf230fde1ec 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11193,14 +11193,8 @@ static void bnxt_free_irq(struct bnxt *bp)
 		int map_idx = bnxt_cp_num_to_irq_num(bp, i);
 
 		irq = &bp->irq_tbl[map_idx];
-		if (irq->requested) {
-			if (irq->have_cpumask) {
-				irq_update_affinity_hint(irq->vector, NULL);
-				free_cpumask_var(irq->cpu_mask);
-				irq->have_cpumask = 0;
-			}
+		if (irq->requested)
 			free_irq(irq->vector, bp->bnapi[i]);
-		}
 
 		irq->requested = 0;
 	}
@@ -11229,21 +11223,6 @@ static int bnxt_request_irq(struct bnxt *bp)
 
 		netif_napi_set_irq(&bp->bnapi[i]->napi, irq->vector);
 		irq->requested = 1;
-
-		if (zalloc_cpumask_var(&irq->cpu_mask, GFP_KERNEL)) {
-			int numa_node = dev_to_node(&bp->pdev->dev);
-
-			irq->have_cpumask = 1;
-			cpumask_set_cpu(cpumask_local_spread(i, numa_node),
-					irq->cpu_mask);
-			rc = irq_update_affinity_hint(irq->vector, irq->cpu_mask);
-			if (rc) {
-				netdev_warn(bp->dev,
-					    "Update affinity hint failed, IRQ = %d\n",
-					    irq->vector);
-				break;
-			}
-		}
 	}
 	return rc;
 }
@@ -13292,6 +13271,7 @@ static int bnxt_set_features(struct net_device *dev, netdev_features_t features)
 				bp->flags = old_flags;
 		}
 	}
+
 	return rc;
 }
 
@@ -16172,6 +16152,8 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
 			    NETDEV_XDP_ACT_RX_SG;
 
+	netif_enable_irq_affinity(dev);
+
 #ifdef CONFIG_BNXT_SRIOV
 	init_waitqueue_head(&bp->sriov_cfg_wait);
 #endif
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 094c9e95b463..7be2f90d0c05 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1228,9 +1228,7 @@ struct bnxt_irq {
 	irq_handler_t	handler;
 	unsigned int	vector;
 	u8		requested:1;
-	u8		have_cpumask:1;
 	char		name[IFNAMSIZ + BNXT_IRQ_NAME_EXTRA];
-	cpumask_var_t	cpu_mask;
 };
 
 #define HWRM_RING_ALLOC_TX	0x1
-- 
2.43.0


