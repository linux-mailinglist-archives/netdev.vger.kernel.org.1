Return-Path: <netdev+bounces-153078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F009F6BBC
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 18:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3DDB7A1D28
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 17:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9392D1F9411;
	Wed, 18 Dec 2024 16:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C3BLxgXU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4D41F8928
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 16:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541178; cv=none; b=V3MudG5tSm6Uya1In02ngbPmKJoIZXt51b5xxugrHQmszWlwpbXazpbDDhJWeIhJW5tqfnujidY2mB68YdjFRDs79tCe6rzSephrTXk13JL0xOghLu7YXtvpFe3kPGgzRqaO+azVT9AsRkhb7r9dU5D8JYC3ldNMPu4wImtzsdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541178; c=relaxed/simple;
	bh=jh7QfFwjdq9d8AVFhmh0dt5lIAFNoZreqPrfeWLQM0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wl+CnYBENLT1fbW+nEDRvqq5ZZFBJuv2rPCOG7piT2SanVLuPyFDzqQt2tHNrejYsDmrxfP74Ts2kZhTGroBfOHtm/wb487mU5ib64Z5eEIoAPhwInfuxBwPN7Yi/Wn6MZvzzlCDmtkx6vEAwp45nZwcm5GvGVOzEzClHjSL55E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C3BLxgXU; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734541177; x=1766077177;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jh7QfFwjdq9d8AVFhmh0dt5lIAFNoZreqPrfeWLQM0A=;
  b=C3BLxgXUF86Mghi5vN8sCDah8eokBX1/nflDb0Ft9cQgjYRRYDYRgo5A
   hiBNoDpBNoaKbhHEOrTR4Tl89M17ws44Z3QYkfmkoQVMH7sItO4ODoOhQ
   TJ2gdd/fhMifoGOE16sl2RX20NgwQKxVTLWv78GNap8SAizWnZ9EkWHsO
   rgB38yQyLrBV+5vM0lp4JxE63vQsHV02vJwAU1NDV72hulNst9t47WgsW
   74T4FMV6s1xzHcZmWPUPSUQJu8anruRxWbaqpOCk1LE2DaQC1zwdZx6TA
   AY+d0JXeJ/3iHeX7cm9as8efcMKMiQnsLaeVsZ2RH4JHD4ehq0EMliqRP
   g==;
X-CSE-ConnectionGUID: BvYx6sHXTbWRw1Q5L9UKpg==
X-CSE-MsgGUID: AVS67WV2RYWg+NRTNCKf2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="46415560"
X-IronPort-AV: E=Sophos;i="6.12,245,1728975600"; 
   d="scan'208";a="46415560"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 08:59:36 -0800
X-CSE-ConnectionGUID: H/H9pH7ISy+MLgxWC2fb/w==
X-CSE-MsgGUID: U20IfUwOREyydZvvL3motA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102531926"
Received: from ldmartin-desk2.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.111.224])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 08:59:30 -0800
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
Subject: [PATCH net-next v2 5/8] bnxt: use napi's irq affinity
Date: Wed, 18 Dec 2024 09:58:40 -0700
Message-ID: <20241218165843.744647-6-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218165843.744647-1-ahmed.zaki@intel.com>
References: <20241218165843.744647-1-ahmed.zaki@intel.com>
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
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 28 ++++-------------------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  2 --
 2 files changed, 4 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index ac729a25ba52..f68f07686105 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11177,14 +11177,8 @@ static void bnxt_free_irq(struct bnxt *bp)
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
@@ -11213,26 +11207,12 @@ static int bnxt_request_irq(struct bnxt *bp)
 
 #ifdef CONFIG_RFS_ACCEL
 		netif_napi_set_irq(&bp->bnapi[i]->napi, irq->vector,
-				   NAPIF_IRQ_ARFS_RMAP);
+				   NAPIF_IRQ_AFFINITY | NAPIF_IRQ_ARFS_RMAP);
 #else
-		netif_napi_set_irq(&bp->bnapi[i]->napi, irq->vector, 0);
+		netif_napi_set_irq(&bp->bnapi[i]->napi, irq->vector,
+				   NAPIF_IRQ_AFFINITY);
 #endif
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
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 7df7a2233307..8a97c1fb2083 100644
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


