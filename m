Return-Path: <netdev+bounces-172205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A10BA50DB5
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 22:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9638C1752AD
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 21:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5A0257AC3;
	Wed,  5 Mar 2025 21:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RmmSbK2V"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA91425BADB
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 21:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741210563; cv=none; b=nOnqP8g+6E2x663mla2KTsOwccEeuu71iW0aTsTlCPW38jF/c3uTFvIn+/7sBNA/uUXzsBwvNkhEMzBq1XamxFTWm6blLK3Ud6xn5f7vc3URbNr//6URgkYuCReC0A1EDVL+kPEAROwQU7wc/sr/hyT60pXCAYLAQlN2d75wWy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741210563; c=relaxed/simple;
	bh=/sCB1Dq1vBtS9I7Os9cb7agZpe7e8iUsSJxkfOPBqw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oaMH7h7UDHM2vS1CkFc1iSFCs8i9HEEHuVI2OFcBVfbr9wsg0x+/KMMmwpZ0Ng8AFsNYczdpPKTr53Smicj2oGib1gEpwyXwqWQUTcWKkWsEHQgMs1DVT4OkosNBmTFOLMcRTDeLLPDSFvydOvE02/kpvPCBKL4vCjJ5K6F97IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RmmSbK2V; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741210561; x=1772746561;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/sCB1Dq1vBtS9I7Os9cb7agZpe7e8iUsSJxkfOPBqw4=;
  b=RmmSbK2VDKE1Ir647dD2sRgoIctuVMeSA7X2kPP9MoMwVFxUP3+aAXqX
   9XachCLnHmyR1m3DiSj49ys+csLQ+gqC+A+NYRxGjoQQLoyk6mYnUSZlz
   fMRvj2EhZ31wdkUnJmbr67E20ivGuNZXadRuqD40Wr5Ln7V2Ny3RM7QZ6
   M+CBJI0jOgedpdaEZz6HswEtq4aqM2TGktWQ/dYa34JZezaN1EFGIafSC
   k2rQ9D2LchjMtt2kcOsmxRsksZWAvOQNjL4cbhiyOTAELbv1dDa4wzF6w
   hhBfGveMrE6VJvAXdN/3SAOU9bYNI8eVulen9vvr/LOxEY2b1FvCgzFXT
   w==;
X-CSE-ConnectionGUID: RKtaG4WZQamZ1JXRmJHqSQ==
X-CSE-MsgGUID: Xa5H10x9QIKeR9vfHzureQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="53606479"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="53606479"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 13:35:57 -0800
X-CSE-ConnectionGUID: z72tyXKnRCmo1L2HK0VTWg==
X-CSE-MsgGUID: XxfTurKaQ2qx0I4bl8dxzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="123828486"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 05 Mar 2025 13:35:55 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Marcin Szycik <marcin.szycik@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net 3/4] ice: Fix switchdev slow-path in LAG
Date: Wed,  5 Mar 2025 13:35:45 -0800
Message-ID: <20250305213549.1514274-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305213549.1514274-1-anthony.l.nguyen@intel.com>
References: <20250305213549.1514274-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marcin Szycik <marcin.szycik@linux.intel.com>

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
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
index 9c9ea4c1b93b..380ba1e8b3b2 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -2424,7 +2424,9 @@ ice_xmit_frame_ring(struct sk_buff *skb, struct ice_tx_ring *tx_ring)
 					ICE_TXD_CTX_QW1_CMD_S);
 
 	ice_tstamp(tx_ring, skb, first, &offload);
-	if (ice_is_switchdev_running(vsi->back) && vsi->type != ICE_VSI_SF)
+	if ((ice_is_switchdev_running(vsi->back) ||
+	     ice_lag_is_switchdev_running(vsi->back)) &&
+	    vsi->type != ICE_VSI_SF)
 		ice_eswitch_set_target_vsi(skb, &offload);
 
 	if (offload.cd_qw1 & ICE_TX_DESC_DTYPE_CTX) {
-- 
2.47.1


