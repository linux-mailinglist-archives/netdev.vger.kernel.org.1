Return-Path: <netdev+bounces-222591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECB1B54F30
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 15:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFF35A018C3
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 13:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3CE257827;
	Fri, 12 Sep 2025 13:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D9o9zdfi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012FA305068
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 13:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683037; cv=none; b=XYZIW5VSPifQpN5Zw1xs51hWkuGaaArweRHPrymRtZa8ScHMeuNYUB7tS9KtqwWcNkpVq7BaqnSNseLz8IrbWe9sivWy6zLMNjSZIgtpyzNrQoHu32VdhsBYds+I0Uyg962atoTtHBnvCwVYUqOyFs8kj+KvQXht+gTrtVuOfV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683037; c=relaxed/simple;
	bh=V/mQSwS8gXXPUzTsZ7IwM2FLorQBirXchMY7nkdp8Rs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IM24CQnR/AgEpY15h1CBbnpe2R0lMOkYMqyK2KbwpoV7pbvSvWsXfPhma+whHf+6EKbD8PdR5fFe/GIqOFub8kXZOuCLUZW+4V0i57GxfI2Iz5RaekTx9qZ3pHGrSD3Q+uedk2DRTKp75JW0zvctZdrwoDdyJXO7ULAQkSL15Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D9o9zdfi; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757683036; x=1789219036;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V/mQSwS8gXXPUzTsZ7IwM2FLorQBirXchMY7nkdp8Rs=;
  b=D9o9zdfiIdc5xvImcP5ssnN9QYfK0WqPdVe/4+TsIPzs4vtPj4ViPEqX
   YQRPMseSXL8XwAkaCSnkdvJyM6XI8wj1uzcFzfD4Gr2wrACxQho6UTzzz
   MKKPVS+0adfF9IcQszU2SWC+HUe6yWlL7wHo8+59lUruNvwr4uy8ITcKM
   cM6kgxvj+DkdVR7WI+AvHn9WL82J63m/fXtRcGjCVb9bPxrG5MWy+jQs4
   LwxgH4c8toFCtBQ1sPHOHA+ucV2kGyNZXwmj+957mpR/7FrTaztGdRn2Y
   kgd4ilcg/UOmFoA/5MawhJSDVNPtK7iT7mJIsXFhviDkqyDgpVAAlb5GP
   A==;
X-CSE-ConnectionGUID: fzhx6YdLTX61qtn4QOkmbA==
X-CSE-MsgGUID: 8XmNfIT9R2iAL6nBPAW1MA==
X-IronPort-AV: E=McAfee;i="6800,10657,11551"; a="85461407"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="85461407"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 06:17:13 -0700
X-CSE-ConnectionGUID: Ek1tYyg+R/ykV9jdCynt/g==
X-CSE-MsgGUID: oEto6l+IRc+75bxBuWhD3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="173131212"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa006.jf.intel.com with ESMTP; 12 Sep 2025 06:17:11 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id DDEE92FC70;
	Fri, 12 Sep 2025 14:17:09 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next 2/9] ice: move service task start out of ice_init_pf()
Date: Fri, 12 Sep 2025 15:06:20 +0200
Message-Id: <20250912130627.5015-3-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250912130627.5015-1-przemyslaw.kitszel@intel.com>
References: <20250912130627.5015-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move service task start out of ice_init_pf(). Do analogous with deinit.
Service task is needed up to the very end of driver removal, later commit
of the series will move it later on execution timeline.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h      |  1 +
 drivers/net/ethernet/intel/ice/ice_main.c | 18 +++++++++++-------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index e952d67388bf..184aab6221c2 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -1002,6 +1002,7 @@ int ice_open(struct net_device *netdev);
 int ice_open_internal(struct net_device *netdev);
 int ice_stop(struct net_device *netdev);
 void ice_service_task_schedule(struct ice_pf *pf);
+void ice_start_service_task(struct ice_pf *pf);
 int ice_load(struct ice_pf *pf);
 void ice_unload(struct ice_pf *pf);
 void ice_adv_lnk_speed_maps_init(void);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 92b95d92d599..53a535c76bd3 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3975,7 +3975,6 @@ u16 ice_get_avail_rxq_count(struct ice_pf *pf)
  */
 static void ice_deinit_pf(struct ice_pf *pf)
 {
-	ice_service_task_stop(pf);
 	mutex_destroy(&pf->lag_mutex);
 	mutex_destroy(&pf->adev_mutex);
 	mutex_destroy(&pf->sw_mutex);
@@ -4049,6 +4048,14 @@ static void ice_set_pf_caps(struct ice_pf *pf)
 	pf->max_pf_rxqs = func_caps->common_cap.num_rxq;
 }
 
+void ice_start_service_task(struct ice_pf *pf)
+{
+	timer_setup(&pf->serv_tmr, ice_service_timer, 0);
+	pf->serv_tmr_period = HZ;
+	INIT_WORK(&pf->serv_task, ice_service_task);
+	clear_bit(ICE_SERVICE_SCHED, pf->state);
+}
+
 /**
  * ice_init_pf - Initialize general software structures (struct ice_pf)
  * @pf: board private structure to initialize
@@ -4068,12 +4075,6 @@ static int ice_init_pf(struct ice_pf *pf)
 
 	init_waitqueue_head(&pf->reset_wait_queue);
 
-	/* setup service timer and periodic service task */
-	timer_setup(&pf->serv_tmr, ice_service_timer, 0);
-	pf->serv_tmr_period = HZ;
-	INIT_WORK(&pf->serv_task, ice_service_task);
-	clear_bit(ICE_SERVICE_SCHED, pf->state);
-
 	mutex_init(&pf->avail_q_mutex);
 	pf->avail_txqs = bitmap_zalloc(pf->max_pf_txqs, GFP_KERNEL);
 	if (!pf->avail_txqs)
@@ -4768,6 +4769,7 @@ int ice_init_dev(struct ice_pf *pf)
 		ice_set_safe_mode_caps(hw);
 	}
 
+	ice_start_service_task(pf);
 	err = ice_init_pf(pf);
 	if (err) {
 		dev_err(dev, "ice_init_pf failed: %d\n", err);
@@ -4814,14 +4816,16 @@ int ice_init_dev(struct ice_pf *pf)
 	ice_clear_interrupt_scheme(pf);
 unroll_pf_init:
 	ice_deinit_pf(pf);
+	ice_service_task_stop(pf);
 	return err;
 }
 
 void ice_deinit_dev(struct ice_pf *pf)
 {
 	ice_free_irq_msix_misc(pf);
 	ice_deinit_pf(pf);
 	ice_deinit_hw(&pf->hw);
+	ice_service_task_stop(pf);
 
 	/* Service task is already stopped, so call reset directly. */
 	ice_reset(&pf->hw, ICE_RESET_PFR);
-- 
2.39.3


