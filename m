Return-Path: <netdev+bounces-93799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 933AB8BD3A0
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 19:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 907321C2199A
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 17:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF450157493;
	Mon,  6 May 2024 17:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nw7AyNa2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357C715746C
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 17:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715015318; cv=none; b=SZB37TTGt4N3+LmRhufJLX9cweuzzfZ8eE9A450Qoo4mPScXBgjzsyWhnMlYOVwQNwfB/C4koynuJuadtoy6bPeBhLw5CI6oF9Lz/+sbq3bLXWsuDdzoJvaEEHUackeiCSXEYm45J3W7jGh91NyNkBim0W+jIVEUVdpSximu/Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715015318; c=relaxed/simple;
	bh=a3c2+FF66lYwHjumVUETpV0qeD62cjsFkPJVfLhEXr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JwipRVUTYqjKKjMvaU+dR1pUyAUhVZZvlvSy1VEMV5aY716OiyAkhcPlZp1dTcgPNDGGF+VGIXtnRcOX8G55qVb/rebMR7nXms++040V5X/9ybfwaGHrMHamy5sCkc0H2SKTOtcgus2lIV+NRvQTlCB95vUNQ5ZkG2OVDlWgEVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nw7AyNa2; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715015318; x=1746551318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a3c2+FF66lYwHjumVUETpV0qeD62cjsFkPJVfLhEXr0=;
  b=Nw7AyNa2fIZMH2f7RtaS29o4z7UYRU3ia9zF+O7OGIY4bHAsSVlcQJXX
   yw5ImYxBqiSNpoDEQp0oF8q5tvUNSyErcP/Xp12O0bgiKxoqsNrQXfJuW
   MZHOI8f7Gt6PqoYmpP5I24+8AsHYBNgeTUdxatCFS624Ez/zCgXRt2P65
   JLrNVbIb1OV10TLh2f/oaVbl31JYrhK154iyZlSO+xy6SIPA3laHxwSDK
   +vadx31wZugijPGKVw/AmHA3Z3ZopddT38VXVTq+Wx3D0CcoxVHzirmo8
   LAA76CZy7EMQ7zMA8LmEYp4wAYRtfbpfy1ist7391O2QHTMfEKq+4ax9J
   A==;
X-CSE-ConnectionGUID: 4xzAAVX9T3u2sGAWL6oJNg==
X-CSE-MsgGUID: ABJyzi0LR2GcbRVEcnpoVA==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10896795"
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="10896795"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 10:08:35 -0700
X-CSE-ConnectionGUID: RJv1PF5oRCWIrO/lNRu93Q==
X-CSE-MsgGUID: xeLbDdKwQceVisnQYIJ95Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="33037432"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 06 May 2024 10:08:34 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Marcin Szycik <marcin.szycik@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Simon Horman <horms@kernel.org>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 3/4] ice: Deduplicate tc action setup
Date: Mon,  6 May 2024 10:08:24 -0700
Message-ID: <20240506170827.948682-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240506170827.948682-1-anthony.l.nguyen@intel.com>
References: <20240506170827.948682-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marcin Szycik <marcin.szycik@linux.intel.com>

ice_tc_setup_redirect_action() and ice_tc_setup_mirror_action() are almost
identical, except for setting filter action. Reduce them to one function
with an extra param, which handles both cases.

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 56 ++++++---------------
 1 file changed, 15 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index 4d8f808f4898..8553c56dc95d 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -669,13 +669,19 @@ static bool ice_tc_is_dev_uplink(struct net_device *dev)
 	return netif_is_ice(dev) || ice_is_tunnel_supported(dev);
 }
 
-static int ice_tc_setup_redirect_action(struct net_device *filter_dev,
-					struct ice_tc_flower_fltr *fltr,
-					struct net_device *target_dev)
+static int ice_tc_setup_action(struct net_device *filter_dev,
+			       struct ice_tc_flower_fltr *fltr,
+			       struct net_device *target_dev,
+			       enum ice_sw_fwd_act_type action)
 {
 	struct ice_repr *repr;
 
-	fltr->action.fltr_act = ICE_FWD_TO_VSI;
+	if (action != ICE_FWD_TO_VSI && action != ICE_MIRROR_PACKET) {
+		NL_SET_ERR_MSG_MOD(fltr->extack, "Unsupported action to setup provided");
+		return -EINVAL;
+	}
+
+	fltr->action.fltr_act = action;
 
 	if (ice_is_port_repr_netdev(filter_dev) &&
 	    ice_is_port_repr_netdev(target_dev)) {
@@ -723,41 +729,6 @@ ice_tc_setup_drop_action(struct net_device *filter_dev,
 	return 0;
 }
 
-static int ice_tc_setup_mirror_action(struct net_device *filter_dev,
-				      struct ice_tc_flower_fltr *fltr,
-				      struct net_device *target_dev)
-{
-	struct ice_repr *repr;
-
-	fltr->action.fltr_act = ICE_MIRROR_PACKET;
-
-	if (ice_is_port_repr_netdev(filter_dev) &&
-	    ice_is_port_repr_netdev(target_dev)) {
-		repr = ice_netdev_to_repr(target_dev);
-
-		fltr->dest_vsi = repr->src_vsi;
-		fltr->direction = ICE_ESWITCH_FLTR_EGRESS;
-	} else if (ice_is_port_repr_netdev(filter_dev) &&
-		   ice_tc_is_dev_uplink(target_dev)) {
-		repr = ice_netdev_to_repr(filter_dev);
-
-		fltr->dest_vsi = repr->src_vsi->back->eswitch.uplink_vsi;
-		fltr->direction = ICE_ESWITCH_FLTR_EGRESS;
-	} else if (ice_tc_is_dev_uplink(filter_dev) &&
-		   ice_is_port_repr_netdev(target_dev)) {
-		repr = ice_netdev_to_repr(target_dev);
-
-		fltr->dest_vsi = repr->src_vsi;
-		fltr->direction = ICE_ESWITCH_FLTR_INGRESS;
-	} else {
-		NL_SET_ERR_MSG_MOD(fltr->extack,
-				   "Unsupported netdevice in switchdev mode");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int ice_eswitch_tc_parse_action(struct net_device *filter_dev,
 				       struct ice_tc_flower_fltr *fltr,
 				       struct flow_action_entry *act)
@@ -773,16 +744,19 @@ static int ice_eswitch_tc_parse_action(struct net_device *filter_dev,
 		break;
 
 	case FLOW_ACTION_REDIRECT:
-		err = ice_tc_setup_redirect_action(filter_dev, fltr, act->dev);
+		err = ice_tc_setup_action(filter_dev, fltr,
+					  act->dev, ICE_FWD_TO_VSI);
 		if (err)
 			return err;
 
 		break;
 
 	case FLOW_ACTION_MIRRED:
-		err = ice_tc_setup_mirror_action(filter_dev, fltr, act->dev);
+		err = ice_tc_setup_action(filter_dev, fltr,
+					  act->dev, ICE_MIRROR_PACKET);
 		if (err)
 			return err;
+
 		break;
 
 	default:
-- 
2.41.0


