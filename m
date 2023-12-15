Return-Path: <netdev+bounces-57878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BC081462B
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 12:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75289B20D23
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 11:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9246D20307;
	Fri, 15 Dec 2023 11:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ft0IY+dw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADFF2421D
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 11:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702638224; x=1734174224;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=izoEArmY3BTSCQrEPl2eZ2gxCJtnlinZSxzFEQRzkJk=;
  b=Ft0IY+dw0JN419jMADXY78lQxcW2SG5LfMU7YFZ2/CFhMc75T6txTwek
   VNA4cID+0lGvIDTxeUBan4NDVlDmRTdzSfdfhVx/2yBUCTkqXrImBJYz5
   2E7gMWkX83TnqeCNRGs0pKUC0Th40q56fX9jNFpC5Gn1HlLSVNBo5dafm
   ilJLEjk9X+OSgrN7X09uIhOvSom0ZCpZdGNeNthBHHY/o4LQlhvE8w5M3
   aOEF9Ohcq+zy4H9EGT5z3MjOMusX198s73R4Pgzagm+xNcwExp5vBc4mW
   kA/obafEz1Z423mxD13ttPawJgl6d3rjuWkb+PFfna+5t3VMbY2uC7lvY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="385679107"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="385679107"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 03:03:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="918408308"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="918408308"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga001.fm.intel.com with ESMTP; 15 Dec 2023 03:03:42 -0800
Received: from rozewie.igk.intel.com (unknown [10.211.8.69])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id A003639C83;
	Fri, 15 Dec 2023 11:03:41 +0000 (GMT)
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net 1/2] ice: Fix link_down_on_close message
Date: Fri, 15 Dec 2023 12:01:56 +0100
Message-Id: <20231215110157.296923-2-wojciech.drewek@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231215110157.296923-1-wojciech.drewek@intel.com>
References: <20231215110157.296923-1-wojciech.drewek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Katarzyna Wieczerzycka <katarzyna.wieczerzycka@intel.com>

The driver should not report an error message when for a medialess port
the link_down_on_close flag is enabled and the physical link cannot be
set down.

Fixes: 8ac7132704f3 ("ice: Fix interface being down after reset with link-down-on-close flag on")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Katarzyna Wieczerzycka <katarzyna.wieczerzycka@intel.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index cfa584627993..67c2ed2e61f9 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2145,7 +2145,7 @@ static int ice_configure_phy(struct ice_vsi *vsi)
 
 	/* Ensure we have media as we cannot configure a medialess port */
 	if (!(phy->link_info.link_info & ICE_AQ_MEDIA_AVAILABLE))
-		return -EPERM;
+		return -ENOMEDIUM;
 
 	ice_print_topo_conflict(vsi);
 
@@ -9295,8 +9295,12 @@ int ice_stop(struct net_device *netdev)
 		int link_err = ice_force_phys_link_state(vsi, false);
 
 		if (link_err) {
-			netdev_err(vsi->netdev, "Failed to set physical link down, VSI %d error %d\n",
-				   vsi->vsi_num, link_err);
+			if (link_err == -ENOMEDIUM)
+				netdev_info(vsi->netdev, "Skipping link reconfig - no media attached, VSI %d\n",
+					    vsi->vsi_num);
+			else
+				netdev_err(vsi->netdev, "Failed to set physical link down, VSI %d error %d\n",
+					   vsi->vsi_num, link_err);
 			return -EIO;
 		}
 	}
-- 
2.40.1


