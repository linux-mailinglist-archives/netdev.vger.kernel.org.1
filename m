Return-Path: <netdev+bounces-60402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A63981F12B
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 19:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A247A1C210BF
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 18:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7288146B9A;
	Wed, 27 Dec 2023 18:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wu/yHSTM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC424655B
	for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 18:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703701548; x=1735237548;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/rOyo2mcERxloBxbqPV7a7XxSknELVYNbFKpXnYYPCc=;
  b=Wu/yHSTML9lr2esCAFFqza5Sr9VBup51gNmEbASkqM3bi1tPc40JJHOW
   2jxnGB1kE2L9KcgzYRufkzo10Z/9lSs8u9LmPxupauqYo5MeZby0JPLIn
   XDaGGu/zuWd8QkrIeqswfks7sba/j4J1HyDI55lhBKB9sPjqD6lsVZYdL
   UXsmrBFXOnruzY2tcDtcpmcGTu9RfHjkNKc67WTbZxPQfI2DYr2mLAhfD
   0t9Awcl5AS2lOt18BGbQa98vpUoTyPdq3XoQZneFqKv4JWgFLdAshDnY9
   x7VerPIZOwigFrFHvyalofowlYqFrnpJRkdH1VgJRdiKiFIVau+NSCXAs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="3312826"
X-IronPort-AV: E=Sophos;i="6.04,310,1695711600"; 
   d="scan'208";a="3312826"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 10:25:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="868921413"
X-IronPort-AV: E=Sophos;i="6.04,310,1695711600"; 
   d="scan'208";a="868921413"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Dec 2023 10:25:45 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Katarzyna Wieczerzycka <katarzyna.wieczerzycka@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 1/4] ice: Fix link_down_on_close message
Date: Wed, 27 Dec 2023 10:25:30 -0800
Message-ID: <20231227182541.3033124-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231227182541.3033124-1-anthony.l.nguyen@intel.com>
References: <20231227182541.3033124-1-anthony.l.nguyen@intel.com>
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
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index fb9c93f37e84..270d68b69c59 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2146,7 +2146,7 @@ static int ice_configure_phy(struct ice_vsi *vsi)
 
 	/* Ensure we have media as we cannot configure a medialess port */
 	if (!(phy->link_info.link_info & ICE_AQ_MEDIA_AVAILABLE))
-		return -EPERM;
+		return -ENOMEDIUM;
 
 	ice_print_topo_conflict(vsi);
 
@@ -9187,8 +9187,12 @@ int ice_stop(struct net_device *netdev)
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
2.41.0


