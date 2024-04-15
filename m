Return-Path: <netdev+bounces-87797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 971898A4AC3
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 10:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4805F282C8E
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 08:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF67D38FA5;
	Mon, 15 Apr 2024 08:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LHzWItar"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129D03FB2F
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 08:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170861; cv=none; b=HTXvEjVmUZV9wmKDOF59RXaL6lXBOitsuXF3kCYrKPyhiW7SEykEHkN/dPDJBVXdp+TlqNhmzkLS8M4yDpekiiL67h7jtuRt3ytpit0DO8WgVdH1MOXJC+Ul7L+CyVCwSMKTFKJ56TZuLGoy8BkQTjwZ3MXbzWqeD0VJ9RzdUhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170861; c=relaxed/simple;
	bh=2xJuMIvGTn/SBOqzXflc1BZxI4dzGrpiZz4Zzy+4fFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UTREsnklUEY9fssdKG2yVwBxNWvkHr3iAI3pjU+hzIqSyCftYlSypx8M77MIiBHr+MkaLRmRd+W+8JO8PcjwlSkWVC9Lxg0vLF3ao8FpWw1VOa7SVkB0bMGl0aBDuhamBOPqSzieRfYll6HYtbnP6aHSbb8KvlzqSvxBzWY1g5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LHzWItar; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713170860; x=1744706860;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2xJuMIvGTn/SBOqzXflc1BZxI4dzGrpiZz4Zzy+4fFY=;
  b=LHzWItarjdxXLPtsyafKQBtpYMbqgajWRrsF7dDdPEMd34PXmFUsJa9k
   gULZCa7rnVZFyq5Q8H75dMUWzKw0vGWd5Nfc8AeZ+ryk48mKOpg8AC0dE
   RRoFICd1nBdF7iITIbU3BPFoIqCg7H2fMD2bHfhMxfbvZHEoA1blrM6CD
   dkVYnkuwOOKip8B0WthBxorgO8ad1mrAHtIIK4XNKFWZuvZgZIUTQKqWR
   v80q1HqItTFhbIN4Poz3xLGeR3LEvRNyFRTE0i9JP71TlghfmHYMy6TNs
   YNC9TAU6Tk/EUQLm44rndXIzsX55GpGz/O9d2vWL/Yrk2xgRz6FTcrZw8
   A==;
X-CSE-ConnectionGUID: 189U6VVRTFip5frD0qpd5w==
X-CSE-MsgGUID: ++84kGihSh6BYjq8Y9RPkA==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="26060915"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="26060915"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:47:38 -0700
X-CSE-ConnectionGUID: WrdgePshRwKa8wfoiPu/5g==
X-CSE-MsgGUID: pPj1y73nR1OmmRavqfrIvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="45123757"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa002.fm.intel.com with ESMTP; 15 Apr 2024 01:47:37 -0700
Received: from mystra-4.igk.intel.com (mystra-4.igk.intel.com [10.123.220.40])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id D38CC332D3;
	Mon, 15 Apr 2024 09:47:35 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	andrii.staikov@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [PATCH iwl-next] ice: Deduplicate tc action setup
Date: Mon, 15 Apr 2024 10:49:07 +0200
Message-ID: <20240415084907.613777-1-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ice_tc_setup_redirect_action() and ice_tc_setup_mirror_action() are almost
identical, except for setting filter action. Reduce them to one function
with an extra param, which handles both cases.

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
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


