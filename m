Return-Path: <netdev+bounces-46309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 463127E3265
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 01:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA7F4B20AF7
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 00:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAB220F8;
	Tue,  7 Nov 2023 00:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B1OiQ5/H"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BE717E3
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 00:48:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3520C10F
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 16:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699318131; x=1730854131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+epAKaCAVB0M//9esyrF9jeDbX2p3hzBWZ/A1KjRvyg=;
  b=B1OiQ5/HP+Pzu9CXJs93TXMU6o00DRrtJAXl7i+/6LEV9Yp79jYwrUpc
   FOsVbzVV1ubDxYBD8X45jVIj96/w4M5g/d2eWlMl7JA74daTW3D/G+Kkz
   l0SwAEr46zmQ9yx3GcADjItWYqezc414Jj9xnO//ejsXcZw7aHxD6T32N
   BJnhNdf08yMSqgGupJFGKnsD1qohCF094/eVmfMGO9hY2KNcO54AzkqZJ
   ga7SO8ieuQYnOZmxN4f2ZweKJ8/NMZuIdyuO1Pw4LDKf5bedvhT6UFPsJ
   d6x/fK9736pvCfqix3tuI37euPft8XXtkmac8LbqcZg4QgF5EmNQQXCTs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="392270717"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="392270717"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 16:48:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="762489664"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="762489664"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga002.jf.intel.com with ESMTP; 06 Nov 2023 16:48:48 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Marcin Szycik <marcin.szycik@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net 4/4] ice: Fix VF-VF direction matching in drop rule in switchdev
Date: Mon,  6 Nov 2023 16:48:42 -0800
Message-ID: <20231107004844.655549-5-anthony.l.nguyen@intel.com>
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

From: Marcin Szycik <marcin.szycik@linux.intel.com>

When adding a drop rule on a VF, rule direction is not being set, which
results in it always being set to ingress (ICE_ESWITCH_FLTR_INGRESS
equals 0). Because of this, drop rules added on port representors don't
match any packets.

To fix it, set rule direction in drop action to egress when netdev is a
port representor, otherwise set it to ingress.

Fixes: 0960a27bd479 ("ice: Add direction metadata")
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 24 ++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index 0e75fc6b3c06..dd03cb69ad26 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -670,6 +670,25 @@ static int ice_tc_setup_redirect_action(struct net_device *filter_dev,
 	return 0;
 }
 
+static int
+ice_tc_setup_drop_action(struct net_device *filter_dev,
+			 struct ice_tc_flower_fltr *fltr)
+{
+	fltr->action.fltr_act = ICE_DROP_PACKET;
+
+	if (ice_is_port_repr_netdev(filter_dev)) {
+		fltr->direction = ICE_ESWITCH_FLTR_EGRESS;
+	} else if (ice_tc_is_dev_uplink(filter_dev)) {
+		fltr->direction = ICE_ESWITCH_FLTR_INGRESS;
+	} else {
+		NL_SET_ERR_MSG_MOD(fltr->extack,
+				   "Unsupported netdevice in switchdev mode");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int ice_eswitch_tc_parse_action(struct net_device *filter_dev,
 				       struct ice_tc_flower_fltr *fltr,
 				       struct flow_action_entry *act)
@@ -678,7 +697,10 @@ static int ice_eswitch_tc_parse_action(struct net_device *filter_dev,
 
 	switch (act->id) {
 	case FLOW_ACTION_DROP:
-		fltr->action.fltr_act = ICE_DROP_PACKET;
+		err = ice_tc_setup_drop_action(filter_dev, fltr);
+		if (err)
+			return err;
+
 		break;
 
 	case FLOW_ACTION_REDIRECT:
-- 
2.41.0


