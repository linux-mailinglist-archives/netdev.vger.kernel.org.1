Return-Path: <netdev+bounces-21560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF795763E77
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 20:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E002F1C20750
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 18:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C642A379AB;
	Wed, 26 Jul 2023 18:28:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84AA379A8
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 18:28:00 +0000 (UTC)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74221BF2
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 11:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690396079; x=1721932079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0p+Ovc4/6A7lIbH2YemT8GtTcQUGOmW4LO6JijiLFU0=;
  b=KowGQaD6n3Muo9ImnkF/1UW6DOWH+CeQ9L77i3KpBm3ItvdotGe9BECO
   DkXG4TFZXxqUQoCbWfOHNbk8MKvIkNLKfDs+W/YMHs8aDdVwZaT64gBWO
   xFtdTx5TIBjtaqLGpdGjub5+xdK6q6zChb+oAOmpX/rlUoX60z7NSrxwL
   nnS5x+qXr8+yVHImRxhIr9l4sDueJLue4UK9D9xTDbpxqQxEKtbKqEUw8
   qD9GvRKB8cgxdnBHxKrAeF4BYiZvcyMNy7gtE3nclowAsQzSJEekxbV1v
   OrkK4fuHUg3OHOVQhhUnMVfXrWW7dFOVpp/sI6tRhrZlY8fEwjOp4TLoa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="368119089"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="368119089"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 11:27:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="756340048"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="756340048"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga008.jf.intel.com with ESMTP; 26 Jul 2023 11:27:55 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Dave Ertman <david.m.ertman@intel.com>,
	anthony.l.nguyen@intel.com,
	daniel.machon@microchip.com,
	simon.horman@corigine.com,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 07/10] ice: support non-standard teardown of bond interface
Date: Wed, 26 Jul 2023 11:21:38 -0700
Message-Id: <20230726182141.3797928-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230726182141.3797928-1-anthony.l.nguyen@intel.com>
References: <20230726182141.3797928-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Dave Ertman <david.m.ertman@intel.com>

Code for supporting removal of the PF driver (NETDEV_UNREGISTER) events for
both when the bond has the primary interface as active and when failed over
to thew secondary interface.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lag.c | 47 ++++++++++++++++++++----
 1 file changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index 532b6273867c..b717d920025d 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -1186,15 +1186,16 @@ static void ice_lag_changeupper_event(struct ice_lag *lag, void *ptr)
 		if (!primary_lag && lag->primary)
 			primary_lag = lag;
 
-		if (primary_lag) {
-			if (!lag->primary) {
-				ice_lag_set_swid(0, lag, false);
-			} else {
+		if (!lag->primary) {
+			ice_lag_set_swid(0, lag, false);
+		} else {
+			if (primary_lag && lag->primary) {
 				ice_lag_primary_swid(lag, false);
 				ice_lag_del_prune_list(primary_lag, lag->pf);
 			}
-			ice_lag_cfg_cp_fltr(lag, false);
 		}
+		/* remove filter for control packets */
+		ice_lag_cfg_cp_fltr(lag, false);
 	}
 }
 
@@ -1397,6 +1398,38 @@ ice_lag_chk_comp(struct ice_lag *lag, void *ptr)
 static void
 ice_lag_unregister(struct ice_lag *lag, struct net_device *event_netdev)
 {
+	struct ice_netdev_priv *np;
+	struct ice_pf *event_pf;
+	struct ice_lag *p_lag;
+
+	p_lag = ice_lag_find_primary(lag);
+	np = netdev_priv(event_netdev);
+	event_pf = np->vsi->back;
+
+	if (p_lag) {
+		if (p_lag->active_port != p_lag->pf->hw.port_info->lport &&
+		    p_lag->active_port != ICE_LAG_INVALID_PORT) {
+			struct ice_hw *active_hw;
+
+			active_hw = ice_lag_find_hw_by_lport(lag,
+							     p_lag->active_port);
+			if (active_hw)
+				ice_lag_reclaim_vf_nodes(p_lag, active_hw);
+			lag->active_port = ICE_LAG_INVALID_PORT;
+		}
+	}
+
+	/* primary processing for primary */
+	if (lag->primary && lag->netdev == event_netdev)
+		ice_lag_primary_swid(lag, false);
+
+	/* primary processing for secondary */
+	if (lag->primary && lag->netdev != event_netdev)
+		ice_lag_del_prune_list(lag, event_pf);
+
+	/* secondary processing for secondary */
+	if (!lag->primary && lag->netdev == event_netdev)
+		ice_lag_set_swid(0, lag, false);
 }
 
 /**
@@ -1466,8 +1499,8 @@ static void ice_lag_process_event(struct work_struct *work)
 	case NETDEV_UNREGISTER:
 		if (ice_is_feature_supported(pf, ICE_F_SRIOV_LAG)) {
 			netdev = lag_work->info.bonding_info.info.dev;
-			if (netdev == lag_work->lag->netdev &&
-			    lag_work->lag->bonded)
+			if ((netdev == lag_work->lag->netdev ||
+			     lag_work->lag->primary) && lag_work->lag->bonded)
 				ice_lag_unregister(lag_work->lag, netdev);
 		}
 		break;
-- 
2.38.1


