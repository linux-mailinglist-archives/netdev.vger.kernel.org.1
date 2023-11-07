Return-Path: <netdev+bounces-46307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E247E3263
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 01:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24476B20C39
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 00:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602711873;
	Tue,  7 Nov 2023 00:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F+VU1Ki4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4731615A7
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 00:48:52 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E3ED51
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 16:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699318131; x=1730854131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hcb/Rj5uKE1Fr+xWQwEqswEQrFt0dt1K/Sg3IcGwrKI=;
  b=F+VU1Ki46aLU557m8aKfcBUTZwo4gyL/tNT4Jq3QnL77e01h8TzrWBnS
   zlovMeYBpFnJIx64KpzPpibBZCu7pbRK6PvN8WqghUVSlsiU1ykOIYfUu
   ZA9ehQNN8PfB1O1YSB0RzHBoQNYh7g6q710ZdeUKa8T0gAU5XGwsY8KgD
   gvXPAg7mjYVNqYpqDl52Yz4BIOLSrWrcGsrt2r8+3AcTRrHBobkox9Nxu
   TV7SeeAovvbn76GWG/3beX6OiKAdVIwm/n/VsVySfNE0szuSVchenrJOo
   JvHjzRDRbu4S+bWxoxLSb9RxZqCGSxlia8b0Jf524I71F5WRwtymPRJDQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="392270705"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="392270705"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 16:48:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="762489658"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="762489658"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga002.jf.intel.com with ESMTP; 06 Nov 2023 16:48:48 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>,
	anthony.l.nguyen@intel.com,
	daniel.machon@microchip.com,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net 2/4] ice: lag: in RCU, use atomic allocation
Date: Mon,  6 Nov 2023 16:48:40 -0800
Message-ID: <20231107004844.655549-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107004844.655549-1-anthony.l.nguyen@intel.com>
References: <20231107004844.655549-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Schmidt <mschmidt@redhat.com>

Sleeping is not allowed in RCU read-side critical sections.
Use atomic allocations under rcu_read_lock.

Fixes: 1e0f9881ef79 ("ice: Flesh out implementation of support for SRIOV on bonded interface")
Fixes: 41ccedf5ca8f ("ice: implement lag netdev event handler")
Fixes: 3579aa86fb40 ("ice: update reset path for SRIOV LAG support")
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lag.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index 95e46bde54fe..cd065ec48c87 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -628,7 +628,7 @@ void ice_lag_move_new_vf_nodes(struct ice_vf *vf)
 		INIT_LIST_HEAD(&ndlist.node);
 		rcu_read_lock();
 		for_each_netdev_in_bond_rcu(lag->upper_netdev, tmp_nd) {
-			nl = kzalloc(sizeof(*nl), GFP_KERNEL);
+			nl = kzalloc(sizeof(*nl), GFP_ATOMIC);
 			if (!nl)
 				break;
 
@@ -1692,7 +1692,7 @@ ice_lag_event_handler(struct notifier_block *notif_blk, unsigned long event,
 
 		rcu_read_lock();
 		for_each_netdev_in_bond_rcu(upper_netdev, tmp_nd) {
-			nd_list = kzalloc(sizeof(*nd_list), GFP_KERNEL);
+			nd_list = kzalloc(sizeof(*nd_list), GFP_ATOMIC);
 			if (!nd_list)
 				break;
 
@@ -2069,7 +2069,7 @@ void ice_lag_rebuild(struct ice_pf *pf)
 		INIT_LIST_HEAD(&ndlist.node);
 		rcu_read_lock();
 		for_each_netdev_in_bond_rcu(lag->upper_netdev, tmp_nd) {
-			nl = kzalloc(sizeof(*nl), GFP_KERNEL);
+			nl = kzalloc(sizeof(*nl), GFP_ATOMIC);
 			if (!nl)
 				break;
 
-- 
2.41.0


