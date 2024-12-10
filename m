Return-Path: <netdev+bounces-150435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C12689EA3A5
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 01:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1275B282D9E
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 00:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48962111AD;
	Tue, 10 Dec 2024 00:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nf8CKfIQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894BFAD24
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 00:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733790418; cv=none; b=JEFHOeCiv2UXxaCB5JGArDAs57zN06AZLfX4xwpQAvLKS6ZRwpdqTADiV6V80bMebg7Qyfe+5MQYU7nHGqX5OCmDfJkwqvrEmJTejEbPcQoeDl5+ljK1evxQGo6kl/7afkgG8tUsIFtWq5JpmSCY+vXMvjm4Uk+VCmayPIbkN8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733790418; c=relaxed/simple;
	bh=Ga2n2dHXfggkY8T5PHFGb+Q3jtFgyf3OB37QvZz+zJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJSNnJlV+hvhQc8sa2r0xllcB6AlR0LVyWPDqnn6doHUAka8cEYcOfo9rWNA4mVo0ggZP5AM2JnpkW3hJchov9JxZopEuJHmTlm6R5GwxCgLiYCxJw8rhnGjZCfMieUBYXJyvMfz4xBxZl5kXz03Yt+82uDdpqZrjubmrOiNGmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nf8CKfIQ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733790417; x=1765326417;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ga2n2dHXfggkY8T5PHFGb+Q3jtFgyf3OB37QvZz+zJ0=;
  b=nf8CKfIQXq5qqgTsrZCP4q54E8wl9IsQ90HGYkpVNbuvbrcV/n2Of4d3
   /buAz/huOzgqWzy919/Z+B0P+ZFDJFqqOVKX2Z7SyjkSh28eIOURu2riS
   0F/hgemDXKSA+Zx9h1ojqyQVeKMpKs6s7B6cf4MufD4kNJCymwfYHyQsA
   CnbXYLYCbA8zOHUMctBH+eHnVWBULSQKyYxtq6ONJgGIvOb/6aenAYDCm
   v5ionWV1exyvIvSf6Sq2pPbKjWxsVyJPDV4QESrsKxI3/Ln+/cUKWT+d4
   Jj4l3vVXGQQL3wvp970Yzev27VLg/J2uMESqTzwlWaeVcwkJVOO3dUG70
   Q==;
X-CSE-ConnectionGUID: iCxnpq51RhS6GPxCWInfSg==
X-CSE-MsgGUID: 5vamn1vIQXKsRYioVbrATQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="44791430"
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="44791430"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 16:26:56 -0800
X-CSE-ConnectionGUID: 9M+uhNRhRN+sK3d8gQ8U5g==
X-CSE-MsgGUID: wwGezakFRx2/pClzqDBHKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="126132144"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.109.73])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 16:26:52 -0800
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
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH v1 net-next 3/6] bnxt: use napi's irq affinity
Date: Mon,  9 Dec 2024 17:26:23 -0700
Message-ID: <20241210002626.366878-4-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210002626.366878-1-ahmed.zaki@intel.com>
References: <20241210002626.366878-1-ahmed.zaki@intel.com>
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
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 26 +++--------------------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  2 --
 2 files changed, 3 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 45b27460d462..d1c9a70514e0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11126,14 +11126,8 @@ static void bnxt_free_irq(struct bnxt *bp)
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
@@ -11174,23 +11168,9 @@ static int bnxt_request_irq(struct bnxt *bp)
 		if (rc)
 			break;
 
-		netif_napi_set_irq(&bp->bnapi[i]->napi, irq->vector, 0);
+		netif_napi_set_irq(&bp->bnapi[i]->napi,
+				   irq->vector, NAPIF_F_IRQ_AFFINITY);
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
index 231e38933984..9942d6f0127b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1225,9 +1225,7 @@ struct bnxt_irq {
 	irq_handler_t	handler;
 	unsigned int	vector;
 	u8		requested:1;
-	u8		have_cpumask:1;
 	char		name[IFNAMSIZ + BNXT_IRQ_NAME_EXTRA];
-	cpumask_var_t	cpu_mask;
 };
 
 #define HWRM_RING_ALLOC_TX	0x1
-- 
2.47.0


