Return-Path: <netdev+bounces-232705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7734C08215
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 22:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D074034E9
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 20:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F1C2FD1B9;
	Fri, 24 Oct 2025 20:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bo+FwHvC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB342FC026
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 20:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761338879; cv=none; b=bhKZtxW0eKOJ2ky3Mp5OdBoiNTTqzMAGIPxFCYN9tv7NtfXTmvtZlPmH6NEXczCLQVpzbEJOBOGnzeRoQrCxuu1mv5L8WBIFYOxH5+1PmaifuryokRO7FPGYKVjotLxlA4Y8MyblTG3KNmjPYU3ETqI9itu/K4v7/bOwmAhgDp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761338879; c=relaxed/simple;
	bh=ReB+Wn9SNbm1jnlxZLAvGzch3UqGrLHI39IaWaqYAeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2bY+OE1ly1A5uL+JPHOrA0cAUeTww5pUEoxeRiEWXlDtTcSQ4n8PjeuSWJ0QLmfZi6WQWoVl7W7JWqJCYcSQljAsxUn6JCd+CcNImqkNWf1Pxhm6Pibtay8TjUMiBGJI/nB7Vhfk2zhGcLMSAWKjNF86rdNn0ipAJL0eECziTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bo+FwHvC; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761338877; x=1792874877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ReB+Wn9SNbm1jnlxZLAvGzch3UqGrLHI39IaWaqYAeU=;
  b=bo+FwHvCSgcC3J2Aosf5Cf7YW6d92zSHGSQuRSboR/3vlDSvsHqkxyoH
   w5ikqzweetBad2uFX41JXA/GBhBcOSQUJlAs9ooMFf8sJn+k3oHPhwzlV
   kIj2czI/eySOwZpvHzzcaQBoZFvwckmqUm22ojB67D/O1hMMcnWqjiL8h
   yxfK02fdJJp/M2XYFAnwGLiy5Gkz+TNNVvqJgb15GMWRqj5gwIXKy48tC
   5/yzq+kOYOvZ/v9K7BnvafsItzgvOZ6AKzlBi+JPxfi5TBI67NF6vfASt
   KGJm7mfHqjVZHImKV7T88X5ULl2msis0e3X3Mu5BpzjNPXR42hR9e7dAl
   w==;
X-CSE-ConnectionGUID: xQICtN+DR5KTr7YNDzL89A==
X-CSE-MsgGUID: 9Sz0Rq28Q3yS9zPNR10avA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66139508"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="66139508"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 13:47:53 -0700
X-CSE-ConnectionGUID: FGdDtQeHRNq1KeH2iH/XZw==
X-CSE-MsgGUID: zhKmZ8p9QCGMQQpZYkiDjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="188821529"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 24 Oct 2025 13:47:54 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	mschmidt@redhat.com,
	poros@redhat.com,
	horms@kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 6/9] ice: move ice_init_pf() out of ice_init_dev()
Date: Fri, 24 Oct 2025 13:47:41 -0700
Message-ID: <20251024204746.3092277-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251024204746.3092277-1-anthony.l.nguyen@intel.com>
References: <20251024204746.3092277-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Move ice_init_pf() out of ice_init_dev().
Do the same for deinit counterpart.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ice/devlink/devlink.c  | 16 ++++++++--
 drivers/net/ethernet/intel/ice/ice.h          |  2 ++
 drivers/net/ethernet/intel/ice/ice_main.c     | 32 +++++++++----------
 3 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index fb2de521731a..c354a03c950c 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -459,6 +459,7 @@ static void ice_devlink_reinit_down(struct ice_pf *pf)
 	rtnl_lock();
 	ice_vsi_decfg(ice_get_main_vsi(pf));
 	rtnl_unlock();
+	ice_deinit_pf(pf);
 	ice_deinit_dev(pf);
 }
 
@@ -1231,11 +1232,12 @@ static void ice_set_min_max_msix(struct ice_pf *pf)
 static int ice_devlink_reinit_up(struct ice_pf *pf)
 {
 	struct ice_vsi *vsi = ice_get_main_vsi(pf);
+	struct device *dev = ice_pf_to_dev(pf);
 	int err;
 
 	err = ice_init_hw(&pf->hw);
 	if (err) {
-		dev_err(ice_pf_to_dev(pf), "ice_init_hw failed: %d\n", err);
+		dev_err(dev, "ice_init_hw failed: %d\n", err);
 		return err;
 	}
 
@@ -1246,13 +1248,19 @@ static int ice_devlink_reinit_up(struct ice_pf *pf)
 	if (err)
 		goto unroll_hw_init;
 
+	err = ice_init_pf(pf);
+	if (err) {
+		dev_err(dev, "ice_init_pf failed: %d\n", err);
+		goto unroll_dev_init;
+	}
+
 	vsi->flags = ICE_VSI_FLAG_INIT;
 
 	rtnl_lock();
 	err = ice_vsi_cfg(vsi);
 	rtnl_unlock();
 	if (err)
-		goto err_vsi_cfg;
+		goto unroll_pf_init;
 
 	/* No need to take devl_lock, it's already taken by devlink API */
 	err = ice_load(pf);
@@ -1265,7 +1273,9 @@ static int ice_devlink_reinit_up(struct ice_pf *pf)
 	rtnl_lock();
 	ice_vsi_decfg(vsi);
 	rtnl_unlock();
-err_vsi_cfg:
+unroll_pf_init:
+	ice_deinit_pf(pf);
+unroll_dev_init:
 	ice_deinit_dev(pf);
 unroll_hw_init:
 	ice_deinit_hw(&pf->hw);
diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 0e58a58c23eb..9a1abd457337 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -1035,6 +1035,8 @@ void ice_unload(struct ice_pf *pf);
 void ice_adv_lnk_speed_maps_init(void);
 int ice_init_dev(struct ice_pf *pf);
 void ice_deinit_dev(struct ice_pf *pf);
+int ice_init_pf(struct ice_pf *pf);
+void ice_deinit_pf(struct ice_pf *pf);
 int ice_change_mtu(struct net_device *netdev, int new_mtu);
 void ice_tx_timeout(struct net_device *netdev, unsigned int txqueue);
 int ice_xdp(struct net_device *dev, struct netdev_bpf *xdp);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 1691dda1067e..a4acc42fabab 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3949,7 +3949,7 @@ u16 ice_get_avail_rxq_count(struct ice_pf *pf)
  * ice_deinit_pf - Unrolls initialziations done by ice_init_pf
  * @pf: board private structure to initialize
  */
-static void ice_deinit_pf(struct ice_pf *pf)
+void ice_deinit_pf(struct ice_pf *pf)
 {
 	/* note that we unroll also on ice_init_pf() failure here */
 
@@ -4045,8 +4045,9 @@ void ice_start_service_task(struct ice_pf *pf)
 /**
  * ice_init_pf - Initialize general software structures (struct ice_pf)
  * @pf: board private structure to initialize
+ * Return: 0 on success, negative errno otherwise.
  */
-static int ice_init_pf(struct ice_pf *pf)
+int ice_init_pf(struct ice_pf *pf)
 {
 	struct udp_tunnel_nic_info *udp_tunnel_nic = &pf->hw.udp_tunnel_nic;
 	struct device *dev = ice_pf_to_dev(pf);
@@ -4772,23 +4773,12 @@ int ice_init_dev(struct ice_pf *pf)
 	}
 
 	ice_start_service_task(pf);
-	err = ice_init_pf(pf);
-	if (err) {
-		dev_err(dev, "ice_init_pf failed: %d\n", err);
-		goto unroll_irq_scheme_init;
-	}
 
 	return 0;
-
-unroll_irq_scheme_init:
-	ice_service_task_stop(pf);
-	ice_clear_interrupt_scheme(pf);
-	return err;
 }
 
 void ice_deinit_dev(struct ice_pf *pf)
 {
-	ice_deinit_pf(pf);
 	ice_deinit_hw(&pf->hw);
 	ice_service_task_stop(pf);
 
@@ -5030,21 +5020,28 @@ static void ice_deinit_devlink(struct ice_pf *pf)
 
 static int ice_init(struct ice_pf *pf)
 {
+	struct device *dev = ice_pf_to_dev(pf);
 	int err;
 
 	err = ice_init_dev(pf);
 	if (err)
 		return err;
 
+	err = ice_init_pf(pf);
+	if (err) {
+		dev_err(dev, "ice_init_pf failed: %d\n", err);
+		goto unroll_dev_init;
+	}
+
 	if (pf->hw.mac_type == ICE_MAC_E830) {
 		err = pci_enable_ptm(pf->pdev, NULL);
 		if (err)
-			dev_dbg(ice_pf_to_dev(pf), "PCIe PTM not supported by PCIe bus/controller\n");
+			dev_dbg(dev, "PCIe PTM not supported by PCIe bus/controller\n");
 	}
 
 	err = ice_alloc_vsis(pf);
 	if (err)
-		goto err_alloc_vsis;
+		goto unroll_pf_init;
 
 	err = ice_init_pf_sw(pf);
 	if (err)
@@ -5081,7 +5078,9 @@ static int ice_init(struct ice_pf *pf)
 	ice_deinit_pf_sw(pf);
 err_init_pf_sw:
 	ice_dealloc_vsis(pf);
-err_alloc_vsis:
+unroll_pf_init:
+	ice_deinit_pf(pf);
+unroll_dev_init:
 	ice_deinit_dev(pf);
 	return err;
 }
@@ -5093,6 +5092,7 @@ static void ice_deinit(struct ice_pf *pf)
 
 	ice_deinit_pf_sw(pf);
 	ice_dealloc_vsis(pf);
+	ice_deinit_pf(pf);
 	ice_deinit_dev(pf);
 }
 
-- 
2.47.1


