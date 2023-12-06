Return-Path: <netdev+bounces-54602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 744F1807942
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 21:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DDB61F211F3
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 20:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098F16F606;
	Wed,  6 Dec 2023 20:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jvWSPSl5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF1D109
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 12:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701893950; x=1733429950;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NplvjNbEFM1WsC4sfnvrDmZLgEk7qco917sLaQ7BfYQ=;
  b=jvWSPSl5Q/Gjal2PJqPDIuZcqp6UFXs3YftKria+ZsflJJJJT15DxoLS
   x1YsBt/VOi8OmhE81pUOcrQXVrbyMznA9Q6ekybON32jDgo1wAf3oCngS
   cK0FkN6rHuXn6BdxjsIj+V+y9wfhU29nN7h5Jau5NcRm1Wu5Ocb3bcIEV
   bWi00ZmXsonfB2GTAjwj1giViA2AugLGydYrrIr63jNBe8ZlamPRDoB1D
   KU6SafGNUaq94PJd3ox0Fdp4bUqoPp/RdUQhNlmDeiMUiawwnUkPZ0jzh
   lWyh+Or8MGEDGaNFTBPjDWk9iIWuU7cM+2JHsF8bv69/tR8Ui04QLkvA5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="393849133"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="393849133"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 12:19:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="771422076"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="771422076"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 12:19:09 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Anthony Nguyen <anthony.l.nguyen@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH iwl-net] ice: stop trashing VF VSI aggregator node ID information
Date: Wed,  6 Dec 2023 12:19:05 -0800
Message-ID: <20231206201905.846723-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When creating new VSIs, they are assigned into an aggregator node in the
scheduler tree. Information about which aggregator node a VSI is assigned
into is maintained by the vsi->agg_node structure. In ice_vsi_decfg(), this
information is being destroyed, by overwriting the valid flag and the
agg_id field to zero.

For VF VSIs, this breaks the aggregator node configuration replay, which
depends on this information. This results in VFs being inserted into the
default aggregator node. The resulting configuration will have unexpected
Tx bandwidth sharing behavior.

This was broken by commit 6624e780a577 ("ice: split ice_vsi_setup into
smaller functions"), which added the block to reset the agg_node data.

The vsi->agg_node structure is not managed by the scheduler code, but is
instead a wrapper around an aggregator node ID that is tracked at the VSI
layer. Its been around for a long time, and its primary purpose was for
handling VFs. The SR-IOV VF reset flow does not make use of the standard VSI
rebuild/replay logic, and uses vsi->agg_node as part of its handling to
rebuild the aggregator node configuration.

The logic for aggregator nodes stretches  back to early ice driver code from
commit b126bd6bcd67 ("ice: create scheduler aggregator node config and move
VSIs")

The logic in ice_vsi_decfg() which trashes the ice_agg_node data is clearly
wrong. It destroys information that is necessary for handling VF reset,. It
is also not the correct way to actually remove a VSI from an aggregator
node. For that, we need to implement logic in the scheduler code. Further,
non-VF VSIs properly replay their aggregator configuration using existing
scheduler replay logic.

To fix the VF replay logic, remove this broken aggregator node cleanup
logic. This is the simplest way to immediately fix this.

This ensures that VFs will have proper aggregate configuration after a
reset. This is especially important since VFs often perform resets as part
of their reconfiguration flows. Without fixing this, VFs will be placed in
the default aggregator node and Tx bandwidth will not be shared in the
expected and configured manner.

Fixes: 6624e780a577 ("ice: split ice_vsi_setup into smaller functions")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
This is the simplest fix to resolve the aggregator node problem. However, I
think we should clean this up properly. I don't know why the VF VSIs have
their own custom code for replaying aggregator configuration. I also think
its odd that there is both structures to track aggregator information in
ice_sched.c, but we use a separate structure in ice.h for the ice_vsi
structure. I plan to investigate this and clean it up in next. However, I
wanted to get a smaller fix out to net sooner rather than later.

 drivers/net/ethernet/intel/ice/ice_lib.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 4b1e56396293..de7ba87af45d 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2620,10 +2620,6 @@ void ice_vsi_decfg(struct ice_vsi *vsi)
 	if (vsi->type == ICE_VSI_VF &&
 	    vsi->agg_node && vsi->agg_node->valid)
 		vsi->agg_node->num_vsis--;
-	if (vsi->agg_node) {
-		vsi->agg_node->valid = false;
-		vsi->agg_node->agg_id = 0;
-	}
 }
 
 /**
-- 
2.41.0


