Return-Path: <netdev+bounces-154830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1833F9FFF3E
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 20:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E81A818817BC
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 19:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025A5192D87;
	Thu,  2 Jan 2025 19:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SHsBWYez"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5264C1A2632
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 19:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735844658; cv=none; b=ZPLZUYcsPiG/Ed/OPvodcVBnnWfDKMyX/mTtJj/jVCAcCB6QgSJxrKFNX95PL0bgwRDm2UXrYFSGXq/UI9ATwRni0169SbLYJzUjdYwMUsWzaDvYHH0GpgMoVxWqnL2IESjBNfH6ZGOu1r89v5R+mVNDk1PQ3ZV8J1YSo+QiKR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735844658; c=relaxed/simple;
	bh=dQtlI0STkRC2aJGltzLuuXjG6WT1FUsuLiTVb/iXk8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jsxWOgXJZnPkQaPhdsv6vnaL8gQVPd1coY8pnYR4L6wl2wfUgrTy+3hakS/81dTodqc+PjvM83hmKcG2AYTKhZaC/57eYRVZ9pVNEeGOcE2mnSMZzf28CzpnvZeFIM5NtlGucmCKAqZsvh1Vhiwvq3tO3C+/lUI4rHO8lP8tKok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SHsBWYez; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735844656; x=1767380656;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dQtlI0STkRC2aJGltzLuuXjG6WT1FUsuLiTVb/iXk8s=;
  b=SHsBWYezCd5I7+ba/7rDMe8v+T3GHVviqZ87NpDted92vUP6OWAYgX+q
   dFBSBlL/n1YnNvkuT2t42JmqP1syN+h9U0MOm68YdXPcXDfrY/g8uO6X4
   cntlmKUHpZN0zC8HJtPXdT/AqR6uqQHzH8kyfjo7/HErT0nVygZ0P63e+
   MIPdnTVEgetHvC8yjK/Id1gW33phRtcrmEVDaOmjhT5NY3r6yohDgu0Ge
   d+SyGmbc/Wsg43T1qFXR0r+8jOIvNemO7yj3zKuD4mWq1xhYUuP8GuI9D
   N7Fb8xBnVnmp1H9Yt6myMNBXv59wtuNE/hQkWwMXtMXx/SUBn3h5uBfzs
   Q==;
X-CSE-ConnectionGUID: WkRnMxQCQdu/ZLHDaL8nOQ==
X-CSE-MsgGUID: bEI3kkvoRwuXY5l5Y5AX5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11303"; a="40019449"
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; 
   d="scan'208";a="40019449"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 11:04:16 -0800
X-CSE-ConnectionGUID: Y3NyWuBmRJGvJxsIpf//hA==
X-CSE-MsgGUID: ThdaegfGTGWQjhR7osT41A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; 
   d="scan'208";a="106449225"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa004.fm.intel.com with ESMTP; 02 Jan 2025 11:04:14 -0800
Received: from mystra-4.igk.intel.com (mystra-4.igk.intel.com [10.123.220.40])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 2BCD32FC57;
	Thu,  2 Jan 2025 19:04:13 +0000 (GMT)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-net] ice: Fix switchdev slow-path in LAG
Date: Thu,  2 Jan 2025 20:07:52 +0100
Message-ID: <20250102190751.7691-2-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ever since removing switchdev control VSI and using PF for port
representor Tx/Rx, switchdev slow-path has been working improperly after
failover in SR-IOV LAG. LAG assumes that the first uplink to be added to
the aggregate will own VFs and have switchdev configured. After
failing-over to the other uplink, representors are still configured to
Tx through the uplink they are set up on, which fails because that
uplink is now down.

On failover, update all PRs on primary uplink to use the currently
active uplink for Tx. Call netif_keep_dst(), as the secondary uplink
might not be in switchdev mode. Also make sure to call
ice_eswitch_set_target_vsi() if uplink is in LAG.

On the Rx path, representors are already working properly, because
default Tx from VFs is set to PF owning the eswitch. After failover the
same PF is receiving traffic from VFs, even though link is down.

Fixes: defd52455aee ("ice: do Tx through PF netdev in slow-path")
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lag.c  | 27 +++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_txrx.c |  4 +++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index 1ccb572ce285..22371011c249 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -1000,6 +1000,28 @@ static void ice_lag_link(struct ice_lag *lag)
 	netdev_info(lag->netdev, "Shared SR-IOV resources in bond are active\n");
 }
 
+/**
+ * ice_lag_config_eswitch - configure eswitch to work with LAG
+ * @lag: lag info struct
+ * @netdev: active network interface device struct
+ *
+ * Updates all port representors in eswitch to use @netdev for Tx.
+ *
+ * Configures the netdev to keep dst metadata (also used in representor Tx).
+ * This is required for an uplink without switchdev mode configured.
+ */
+static void ice_lag_config_eswitch(struct ice_lag *lag,
+				   struct net_device *netdev)
+{
+	struct ice_repr *repr;
+	unsigned long id;
+
+	xa_for_each(&lag->pf->eswitch.reprs, id, repr)
+		repr->dst->u.port_info.lower_dev = netdev;
+
+	netif_keep_dst(netdev);
+}
+
 /**
  * ice_lag_unlink - handle unlink event
  * @lag: LAG info struct
@@ -1021,6 +1043,9 @@ static void ice_lag_unlink(struct ice_lag *lag)
 			ice_lag_move_vf_nodes(lag, act_port, pri_port);
 		lag->primary = false;
 		lag->active_port = ICE_LAG_INVALID_PORT;
+
+		/* Config primary's eswitch back to normal operation. */
+		ice_lag_config_eswitch(lag, lag->netdev);
 	} else {
 		struct ice_lag *primary_lag;
 
@@ -1419,6 +1444,7 @@ static void ice_lag_monitor_active(struct ice_lag *lag, void *ptr)
 				ice_lag_move_vf_nodes(lag, prim_port,
 						      event_port);
 			lag->active_port = event_port;
+			ice_lag_config_eswitch(lag, event_netdev);
 			return;
 		}
 
@@ -1428,6 +1454,7 @@ static void ice_lag_monitor_active(struct ice_lag *lag, void *ptr)
 		/* new active port */
 		ice_lag_move_vf_nodes(lag, lag->active_port, event_port);
 		lag->active_port = event_port;
+		ice_lag_config_eswitch(lag, event_netdev);
 	} else {
 		/* port not set as currently active (e.g. new active port
 		 * has already claimed the nodes and filters
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 5d2d7736fd5f..f1c06c227dc5 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -2368,7 +2368,9 @@ ice_xmit_frame_ring(struct sk_buff *skb, struct ice_tx_ring *tx_ring)
 					ICE_TXD_CTX_QW1_CMD_S);
 
 	ice_tstamp(tx_ring, skb, first, &offload);
-	if (ice_is_switchdev_running(vsi->back) && vsi->type != ICE_VSI_SF)
+	if ((ice_is_switchdev_running(vsi->back) ||
+	     ice_lag_is_switchdev_running(vsi->back)) &&
+	    vsi->type != ICE_VSI_SF)
 		ice_eswitch_set_target_vsi(skb, &offload);
 
 	if (offload.cd_qw1 & ICE_TX_DESC_DTYPE_CTX) {
-- 
2.45.0


