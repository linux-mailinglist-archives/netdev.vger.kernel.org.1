Return-Path: <netdev+bounces-165287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D44A31744
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 22:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D943A38E8
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 21:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361AE264F9C;
	Tue, 11 Feb 2025 21:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="liBt98YT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693A1264FA3
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 21:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739308069; cv=none; b=fFhkr031UC6T0XAeDEnODUgozwNqyWkUAb40FwwNbmzB1yFW6861SOo4dKsW+NzdWMAeM45majCvFdF2A6L0Zr+M+EELxRSuR3OETmFzYe3rWapNjmKrArMm27EIjp19BNfvNCqyp7RXZoyXkbUQ0Zq75nAsgIU9RBYsWk52B2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739308069; c=relaxed/simple;
	bh=FVrTHHagfXgQJ5NODwm9tqP7dymAE4aOeEQJH2UhG2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sp1MXbJFqBE+KgRv+6D8haFPwHeyd0GTB8iVWl+Mt31gYLX39n/a/7N/Q36Ks7s2jkHY/G3836bqCGTXZWOe70xGWCqeLAI2WCDAo80tJwbCGrZBRa9HsCNpolpGVXM33cljdUhtv6pwE1+G8HcDuH42rrFbhWhTklGNk/v8ldM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=liBt98YT; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739308067; x=1770844067;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FVrTHHagfXgQJ5NODwm9tqP7dymAE4aOeEQJH2UhG2A=;
  b=liBt98YTuFjSV/ZAKAXn0TQWCcNw5GQcuJl/coMPVrcCQ9vo79jNbre2
   AcEqBl7cmx1YD5uFMMF0yjDb6XbBLZgBctew4W2bMkVRRbSgvhJOL+Bcb
   WbhMyaBve3O5YY/ShIb9PnuJ6YifD8CKDMmk+J3Dd4AOS8lV6ByZuclzq
   przt5+/iOd0GYwXKBD5mDS3o5loaIE8d4bSkxP1mY5q8K3VQaG2RR+wBr
   eqn93fW+cz7llf+MQHujbl07KNnZR2eZCKCmVcqwuNCXlRpfeQa2yJD10
   vLVVr4GSyZJpgcclQ3EXxz9QNc8V+Gn2tZFZv0243Z6Pldyn/L2PlOcKM
   w==;
X-CSE-ConnectionGUID: 2WEMvmLQRYSw/hp1LIFapg==
X-CSE-MsgGUID: 0HyJGvNlR5aiBg+94ub9rg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="51339667"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="51339667"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 13:07:47 -0800
X-CSE-ConnectionGUID: 4KM8Xz4sQdi2V+czVUT/uQ==
X-CSE-MsgGUID: 2rAK/9NRQyueIbLt1ETvRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116713263"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.108.7])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 13:07:40 -0800
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	michael.chan@broadcom.com,
	tariqt@nvidia.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jdamato@fastly.com,
	shayd@nvidia.com,
	akpm@linux-foundation.org,
	shayagr@amazon.com,
	kalesh-anakkur.purayil@broadcom.com,
	pavan.chebbi@broadcom.com,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH net-next v8 4/6] bnxt: use napi's irq affinity
Date: Tue, 11 Feb 2025 14:06:55 -0700
Message-ID: <20250211210657.428439-5-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250211210657.428439-1-ahmed.zaki@intel.com>
References: <20250211210657.428439-1-ahmed.zaki@intel.com>
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
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 25 +++--------------------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  2 --
 2 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index b9b839cb942a..8b231bbc0709 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11246,14 +11246,8 @@ static void bnxt_free_irq(struct bnxt *bp)
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
@@ -11282,21 +11276,6 @@ static int bnxt_request_irq(struct bnxt *bp)
 
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
@@ -16225,6 +16204,8 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
 			    NETDEV_XDP_ACT_RX_SG;
 
+	netif_set_affinity_auto(dev);
+
 #ifdef CONFIG_BNXT_SRIOV
 	init_waitqueue_head(&bp->sriov_cfg_wait);
 #endif
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 2373f423a523..9e6984458b46 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1231,9 +1231,7 @@ struct bnxt_irq {
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


