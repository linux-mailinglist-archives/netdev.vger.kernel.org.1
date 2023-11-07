Return-Path: <netdev+bounces-46306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE5C7E3262
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 01:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 088FF1C20A54
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 00:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE86184E;
	Tue,  7 Nov 2023 00:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gtw4gyye"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E0B191
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 00:48:51 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0D81BF
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 16:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699318129; x=1730854129;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M68t8jDG+deQnvcOX9XK3fL1PjqwKXnMbV4vNIoc6/Q=;
  b=gtw4gyyektJ89dS9yPTIFgttr7yhmlRLdBCS8VTd+UUhWRXOspG/7juA
   uG7I5Pn6pFNHKXjeGxKMcHUEUXiy8+d5X88ohhXqlq/5mzZgvq8IDIw6v
   2zUcldF0jubZYHp5w+YXQfL2gi47R+Gpj/uauS9ZiEejTDjxsw/04zeLL
   DZwhz6Z5m+hvrv8KFsaftjIcJecA847+XcSM3oA4ak8DHS6waqssXXiNI
   Ps0o1bDOmje9V4gO+1EbUF6JgYyaXXfIE3UjDDL+7quP/mIZmmgCmv4I4
   FXlyKPTdzYjhx9xAZLHyInO0o9tm5kwQP5e+b4Hl+JMstGk6yJqp6RPYU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="392270699"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="392270699"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 16:48:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="762489655"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="762489655"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga002.jf.intel.com with ESMTP; 06 Nov 2023 16:48:48 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Dave Ertman <david.m.ertman@intel.com>,
	anthony.l.nguyen@intel.com,
	daniel.machon@microchip.com,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Simon Horman <horms@kernel.org>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net 1/4] ice: Fix SRIOV LAG disable on non-compliant aggregate
Date: Mon,  6 Nov 2023 16:48:39 -0800
Message-ID: <20231107004844.655549-2-anthony.l.nguyen@intel.com>
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

From: Dave Ertman <david.m.ertman@intel.com>

If an attribute of an aggregate interface disqualifies it from supporting
SRIOV, the driver will unwind the SRIOV support.  Currently the driver is
clearing the feature bit for all interfaces in the aggregate, but this is
not allowing the other interfaces to unwind successfully on driver unload.

Only clear the feature bit for the interface that is currently unwinding.

Fixes: bf65da2eb279 ("ice: enforce interface eligibility and add messaging for SRIOV LAG")
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lag.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index b980f89dc892..95e46bde54fe 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -1555,18 +1555,12 @@ static void ice_lag_chk_disabled_bond(struct ice_lag *lag, void *ptr)
  */
 static void ice_lag_disable_sriov_bond(struct ice_lag *lag)
 {
-	struct ice_lag_netdev_list *entry;
 	struct ice_netdev_priv *np;
-	struct net_device *netdev;
 	struct ice_pf *pf;
 
-	list_for_each_entry(entry, lag->netdev_head, node) {
-		netdev = entry->netdev;
-		np = netdev_priv(netdev);
-		pf = np->vsi->back;
-
-		ice_clear_feature_support(pf, ICE_F_SRIOV_LAG);
-	}
+	np = netdev_priv(lag->netdev);
+	pf = np->vsi->back;
+	ice_clear_feature_support(pf, ICE_F_SRIOV_LAG);
 }
 
 /**
-- 
2.41.0


