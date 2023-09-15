Return-Path: <netdev+bounces-34118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C27CE7A2278
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 17:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18A001C20B2D
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 15:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC577111B7;
	Fri, 15 Sep 2023 15:35:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3163E10A24
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 15:35:30 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F37CF3
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 08:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694792129; x=1726328129;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ABqV9ynyGVyNaVHUBL1ZgG1XUHjB1KwuGDghn1MvkhM=;
  b=ktaTS+kLVbBSJOkWLVQoKLBbsYPwpullOIcDhPu6L2RJs+qrLW7r2jKn
   sMwAwdMGDAPMy7pDennvA8srBkUySbcL7gwZwa05XjWipBcVqYkRibEsL
   si5RBcIkQAP3Z323sF9nM5fels35sAEu7xb/+PDP28YFsIkIyXSmjj429
   A7HHqLyUCyJnmZg8EasiTxKfiMd3hj9V/2d5iaodZymJirSOe4p8YM/3o
   3oxHNGdQhQoU0M+3tISy7RTdKq5B4jcVJWB1pv4R6dmjwD4Ipk/lpAb17
   uUSVSc50Yu7GeUXDPNZepKJfcimTI93snw3kAHWBBH2OrIhmmVBgq+Uq9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="359532758"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="359532758"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 08:35:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="860200030"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="860200030"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga002.fm.intel.com with ESMTP; 15 Sep 2023 08:35:10 -0700
Received: from mystra-4.igk.intel.com (mystra-4.igk.intel.com [10.123.220.40])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id C339E33E83;
	Fri, 15 Sep 2023 16:35:09 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	david.m.ertman@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: [PATCH iwl-net] ice: block default rule setting on LAG interface
Date: Fri, 15 Sep 2023 17:35:19 +0200
Message-ID: <20230915153518.464595-2-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
2.41.0


