Return-Path: <netdev+bounces-54121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9761806094
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 22:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67A7D1F217C2
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 21:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A036E5AB;
	Tue,  5 Dec 2023 21:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nbIP7610"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E20818F
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 13:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701811183; x=1733347183;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dS2Z6NAmDO2pR3wC3e2gMXozh2cakb9BTOE8Qro6mOE=;
  b=nbIP7610HDn8Q59EEJ6VQEOPOqRmAbX9lHYSSAXPjArK2oZIxvxmLbuH
   GnkHvpQPmbLoBZ0fg9eq0esVTig0MxUIdD2QiKr+6xx5EBrrrxq5JAXOK
   MT8upxTZhS6Gch3XEjjUOT7pX/z5OA1FwQT+zy2NmFkRbyhSoSEN7hJaI
   gRJHeKnZ0A/itZPpO/ioZjExG7/JmgJrMNyJmaYhsgBZOjY1i738+Dde9
   oy/RsDKfov9kV6fkdhxyUWVnZaYySyeg1pCmr6PQVnxm0GAVZ2VUaVka3
   ZqVDrkRI//VG+ZmvKDvHYjPBY4kQj+eTfd7k9c2mIBlT8YJTaTHlTdeq+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="393693810"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="393693810"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:19:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="894510104"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="894510104"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga004.jf.intel.com with ESMTP; 05 Dec 2023 13:19:26 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Marcin Szycik <marcin.szycik@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 2/4] ice: Restore fix disabling RX VLAN filtering
Date: Tue,  5 Dec 2023 13:19:13 -0800
Message-ID: <20231205211918.2123019-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231205211918.2123019-1-anthony.l.nguyen@intel.com>
References: <20231205211918.2123019-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marcin Szycik <marcin.szycik@linux.intel.com>

Fix setting dis_rx_filtering depending on whether port vlan is being
turned on or off. This was originally fixed in commit c793f8ea15e3 ("ice:
Fix disabling Rx VLAN filtering with port VLAN enabled"), but while
refactoring ice_vf_vsi_init_vlan_ops(), the fix has been lost. Restore the
fix along with the original comment from that change.

Also delete duplicate lines in ice_port_vlan_on().

Fixes: 2946204b3fa8 ("ice: implement bridge port vlan")
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c b/drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c
index d7b10dc67f03..80dc4bcdd3a4 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c
@@ -32,7 +32,6 @@ static void ice_port_vlan_on(struct ice_vsi *vsi)
 		/* setup outer VLAN ops */
 		vlan_ops->set_port_vlan = ice_vsi_set_outer_port_vlan;
 		vlan_ops->clear_port_vlan = ice_vsi_clear_outer_port_vlan;
-		vlan_ops->clear_port_vlan = ice_vsi_clear_outer_port_vlan;
 
 		/* setup inner VLAN ops */
 		vlan_ops = &vsi->inner_vlan_ops;
@@ -47,8 +46,13 @@ static void ice_port_vlan_on(struct ice_vsi *vsi)
 
 		vlan_ops->set_port_vlan = ice_vsi_set_inner_port_vlan;
 		vlan_ops->clear_port_vlan = ice_vsi_clear_inner_port_vlan;
-		vlan_ops->clear_port_vlan = ice_vsi_clear_inner_port_vlan;
 	}
+
+	/* all Rx traffic should be in the domain of the assigned port VLAN,
+	 * so prevent disabling Rx VLAN filtering
+	 */
+	vlan_ops->dis_rx_filtering = noop_vlan;
+
 	vlan_ops->ena_rx_filtering = ice_vsi_ena_rx_vlan_filtering;
 }
 
@@ -77,6 +81,8 @@ static void ice_port_vlan_off(struct ice_vsi *vsi)
 		vlan_ops->del_vlan = ice_vsi_del_vlan;
 	}
 
+	vlan_ops->dis_rx_filtering = ice_vsi_dis_rx_vlan_filtering;
+
 	if (!test_bit(ICE_FLAG_VF_VLAN_PRUNING, pf->flags))
 		vlan_ops->ena_rx_filtering = noop_vlan;
 	else
@@ -141,7 +147,6 @@ void ice_vf_vsi_init_vlan_ops(struct ice_vsi *vsi)
 		&vsi->outer_vlan_ops : &vsi->inner_vlan_ops;
 
 	vlan_ops->add_vlan = ice_vsi_add_vlan;
-	vlan_ops->dis_rx_filtering = ice_vsi_dis_rx_vlan_filtering;
 	vlan_ops->ena_tx_filtering = ice_vsi_ena_tx_vlan_filtering;
 	vlan_ops->dis_tx_filtering = ice_vsi_dis_tx_vlan_filtering;
 }
-- 
2.41.0


