Return-Path: <netdev+bounces-142105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 111C29BD7D5
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 22:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C51AB283D9B
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 21:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC824216432;
	Tue,  5 Nov 2024 21:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MUm4Tv5c"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC1E21620F
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 21:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843362; cv=none; b=bEwqbIPsVV/NyZw1qpm5AyRa/GBrq2nS27eNkaPYpGzWe2TAETmld4nQW15bmX4pExTPGsc6mtS45U0X0k5Hw62YRaum0jIRKev4/8pFmoWxqQYGYexRFJR2M3DXrQ3HGkmpKQ1DWd6Z2jz/YwVLQlFpaKM9szz3KQfMMsJ/GuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843362; c=relaxed/simple;
	bh=cPWS4f0r9yWak9dT8ctCM7VCSSxRTsgXjzI+Wr46d5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uxlaeLZTBIDfhKcF1M3PuuYA2+XWwR7HasIscu3nQpPDD8uMl9sSZBHAJhCDupl5c/KnEcbvl+Ijvl9FetSEj9doKQl++5QWcw9equIH1e2VO+BoZode1da24XcAF1QdLgztu8iVHRjA6moVc/Gi3FljHDPEO8EfymGFvf7pWbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MUm4Tv5c; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730843361; x=1762379361;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cPWS4f0r9yWak9dT8ctCM7VCSSxRTsgXjzI+Wr46d5I=;
  b=MUm4Tv5cBYEVJQI+GAzdhHNb7C5AK2aijYlN6gL4cBQ2TO0N3hfyJScQ
   q7yowc2wL1uQFjT+hGRT2hSM2D4ZUn8icjL+Yfbg6ERS/POz8E12DINPe
   hYo68ZSiC8jWHfZh94KXdfLP1nXQ7TNAFyBNw0/ZVpnE4YOX3OOh7peBp
   HUcsQKcryc6+tRQcRrh8cMWybXSt3U/9CQtB/vzkptINqpDhrGAaqXU/L
   kMvNB0v2VQV5ZTpueetedQIMyLU/IWI7FcxL6edkse/uukCYTUBxUPHmQ
   aihsK0KXVlcwLHZznlnMsBt/k2MZbKLJz4CCMDTYG/AvHJ1xTfqZqhMVX
   A==;
X-CSE-ConnectionGUID: N3CT8yWrTwuFm6+1/da/NQ==
X-CSE-MsgGUID: bO0/FoKuRg2k2IohJ6y7tA==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="30735927"
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="30735927"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 13:49:16 -0800
X-CSE-ConnectionGUID: rdnFo2JFTYKAgEeC/gfb+g==
X-CSE-MsgGUID: dE6mHU+ISQeE0T42JJf4Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="85010425"
Received: from coyotepass-34596-p1.jf.intel.com ([10.166.80.48])
  by orviesa008.jf.intel.com with ESMTP; 05 Nov 2024 13:49:06 -0800
From: Tarun K Singh <tarun.k.singh@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net v1 4/4] idpf: add lock class key
Date: Tue,  5 Nov 2024 13:48:59 -0500
Message-ID: <20241105184859.741473-5-tarun.k.singh@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241105184859.741473-1-tarun.k.singh@intel.com>
References: <20241105184859.741473-1-tarun.k.singh@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ahmed Zaki <ahmed.zaki@intel.com>

Add lock class key changes to prevent lockdep from complaining
when PF reset the VFs.

Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Signed-off-by: Tarun K Singh <tarun.k.singh@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_main.c | 32 +++++++++++++--------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index 04bbc048c829..082026c2a7ab 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -11,6 +11,10 @@ MODULE_DESCRIPTION(DRV_SUMMARY);
 MODULE_IMPORT_NS(LIBETH);
 MODULE_LICENSE("GPL");
 
+/* Prevent lockdep from complaining when PF reset the VFs */
+static struct lock_class_key idpf_pf_vport_init_lock_key;
+static struct lock_class_key idpf_pf_work_lock_key;
+
 /**
  * idpf_remove - Device removal routine
  * @pdev: PCI device information struct
@@ -140,9 +144,25 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	adapter->req_tx_splitq = true;
 	adapter->req_rx_splitq = true;
 
+	mutex_init(&adapter->vport_init_lock);
+	mutex_init(&adapter->vport_cfg_lock);
+	mutex_init(&adapter->vector_lock);
+	mutex_init(&adapter->queue_lock);
+	mutex_init(&adapter->vc_buf_lock);
+
+	INIT_DELAYED_WORK(&adapter->init_task, idpf_init_task);
+	INIT_DELAYED_WORK(&adapter->serv_task, idpf_service_task);
+	INIT_DELAYED_WORK(&adapter->mbx_task, idpf_mbx_task);
+	INIT_DELAYED_WORK(&adapter->stats_task, idpf_statistics_task);
+	INIT_DELAYED_WORK(&adapter->vc_event_task, idpf_vc_event_task);
+
 	switch (ent->device) {
 	case IDPF_DEV_ID_PF:
 		idpf_dev_ops_init(adapter);
+		lockdep_set_class(&adapter->vport_init_lock,
+				  &idpf_pf_vport_init_lock_key);
+		lockdep_init_map(&adapter->vc_event_task.work.lockdep_map,
+				 "idpf-PF-vc-work", &idpf_pf_work_lock_key, 0);
 		break;
 	case IDPF_DEV_ID_VF:
 		idpf_vf_dev_ops_init(adapter);
@@ -233,18 +253,6 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_cfg_hw;
 	}
 
-	mutex_init(&adapter->vport_init_lock);
-	mutex_init(&adapter->vport_cfg_lock);
-	mutex_init(&adapter->vector_lock);
-	mutex_init(&adapter->queue_lock);
-	mutex_init(&adapter->vc_buf_lock);
-
-	INIT_DELAYED_WORK(&adapter->init_task, idpf_init_task);
-	INIT_DELAYED_WORK(&adapter->serv_task, idpf_service_task);
-	INIT_DELAYED_WORK(&adapter->mbx_task, idpf_mbx_task);
-	INIT_DELAYED_WORK(&adapter->stats_task, idpf_statistics_task);
-	INIT_DELAYED_WORK(&adapter->vc_event_task, idpf_vc_event_task);
-
 	adapter->dev_ops.reg_ops.reset_reg_init(adapter);
 	set_bit(IDPF_HR_DRV_LOAD, adapter->flags);
 	queue_delayed_work(adapter->vc_event_wq, &adapter->vc_event_task,
-- 
2.46.0


