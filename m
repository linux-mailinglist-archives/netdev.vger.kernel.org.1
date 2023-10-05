Return-Path: <netdev+bounces-38328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAD47BA683
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 18:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B32F0281CBA
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 16:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696CD34CFC;
	Thu,  5 Oct 2023 16:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IKmSeEm+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D1E34CE2
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 16:36:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FB34C08
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 09:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696523700; x=1728059700;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=H06lUteHrEDkDudOAPbLTl1G2j9pPFVJGSCVEaWI9Ow=;
  b=IKmSeEm+11SXOPyS18Mz0juNpPO5ADqcaf9S9Ir/RUWIh5yffRyfoJO3
   MH8UTJz3QTAFtGiUQ9XPkL3K3PeFyLjvc1qt6cj5cha9jSMq5tnJ61rcQ
   gPDnOFU1rJ7zTI6pllvfUaYNPRgR8cVlQN/7yiy0l52NjWvN/3sux+OEe
   3I69UgcpnQmB9aSu/9xGI+3JSS7VcWet6OMHzqIRBOXuT7W/VIH+RhS14
   0GYXXGrAinrF20FOTPZtGC7qLSyalCOWopLhgGPBK7Na0DTsiDPX49j+o
   hfNjHbeOdGdd3mJUOZu3LUqz8R9fR3DQgssklErKeJ1bmLycwVcBAVly4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="383448534"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="383448534"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 09:34:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="842477250"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="842477250"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Oct 2023 09:34:48 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	daniel.machon@microchip.com,
	david.m.ertman@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Simon Horman <horms@kernel.org>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net] ice: block default rule setting on LAG interface
Date: Thu,  5 Oct 2023 09:33:30 -0700
Message-Id: <20231005163330.3219008-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

When one of the LAG interfaces is in switchdev mode, setting default rule
can't be done.

The interface on which switchdev is running has ice_set_rx_mode() blocked
to avoid default rule adding (and other rules). The other interfaces
(without switchdev running but connected via bond with interface that
runs switchdev) can't follow the same scheme, because rx filtering needs
to be disabled when failover happens. Notification for bridge to set
promisc mode seems like good place to do that.

Fixes: bb52f42acef6 ("ice: Add driver support for firmware changes for LAG")
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lag.c | 32 ++++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_lag.h |  1 +
 drivers/net/ethernet/intel/ice/ice_lib.c |  6 +++++
 3 files changed, 39 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index 4f39863b5537..7b1256992dcf 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -2093,3 +2093,35 @@ void ice_lag_rebuild(struct ice_pf *pf)
 	}
 	mutex_unlock(&pf->lag_mutex);
 }
+
+/**
+ * ice_lag_is_switchdev_running
+ * @pf: pointer to PF structure
+ *
+ * Check if switchdev is running on any of the interfaces connected to lag.
+ */
+bool ice_lag_is_switchdev_running(struct ice_pf *pf)
+{
+	struct ice_lag *lag = pf->lag;
+	struct net_device *tmp_nd;
+
+	if (!ice_is_feature_supported(pf, ICE_F_SRIOV_LAG) || !lag)
+		return false;
+
+	rcu_read_lock();
+	for_each_netdev_in_bond_rcu(lag->upper_netdev, tmp_nd) {
+		struct ice_netdev_priv *priv = netdev_priv(tmp_nd);
+
+		if (!netif_is_ice(tmp_nd) || !priv || !priv->vsi ||
+		    !priv->vsi->back)
+			continue;
+
+		if (ice_is_switchdev_running(priv->vsi->back)) {
+			rcu_read_unlock();
+			return true;
+		}
+	}
+	rcu_read_unlock();
+
+	return false;
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_lag.h b/drivers/net/ethernet/intel/ice/ice_lag.h
index 18075b82485a..facb6c894b6d 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.h
+++ b/drivers/net/ethernet/intel/ice/ice_lag.h
@@ -62,4 +62,5 @@ void ice_lag_move_new_vf_nodes(struct ice_vf *vf);
 int ice_init_lag(struct ice_pf *pf);
 void ice_deinit_lag(struct ice_pf *pf);
 void ice_lag_rebuild(struct ice_pf *pf);
+bool ice_lag_is_switchdev_running(struct ice_pf *pf);
 #endif /* _ICE_LAG_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 201570cd2e0b..7bf9b7069754 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3575,6 +3575,12 @@ int ice_set_dflt_vsi(struct ice_vsi *vsi)
 
 	dev = ice_pf_to_dev(vsi->back);
 
+	if (ice_lag_is_switchdev_running(vsi->back)) {
+		dev_dbg(dev, "VSI %d passed is a part of LAG containing interfaces in switchdev mode, nothing to do\n",
+			vsi->vsi_num);
+		return 0;
+	}
+
 	/* the VSI passed in is already the default VSI */
 	if (ice_is_vsi_dflt_vsi(vsi)) {
 		dev_dbg(dev, "VSI %d passed in is already the default forwarding VSI, nothing to do\n",
-- 
2.38.1


