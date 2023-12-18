Return-Path: <netdev+bounces-58637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E73F817AFE
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 20:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 922F828493C
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 19:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB7272050;
	Mon, 18 Dec 2023 19:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JavkQPq+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6BD71451
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 19:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702927636; x=1734463636;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bi+/jv/HYs16aDn6Nyn47K8UfxteReKQkjbgerfOaPQ=;
  b=JavkQPq+16mJOM0U11ggbT6ytOFMG8a08gP32F8oBMa6/bxan122ULQw
   rZ87xCJDSP19F29dGJZz3ExwxEYNJL5Oo5y0DKEAE+4XPkGzapDK3m5ej
   hcM0QU8wODcBN3cZsbeXklckryBtz2QsGPQVuMdRXTvlVvo1km2h5vIcD
   um4+x28gJX2AhEAweXwKKevEsjm/QI0SXm5vi57HKyUq8ftKT2wt1kmu8
   HNG4ccfjkC8NVg8Di0r3B4+ojQ075soe7ZIz2+MtLx0zKsHW+lkyIGrax
   CbkxAhAwHkcpQbrEvEtoBpLz9DG6TjitI+lXOVseMfLtILH1M0O86/y8+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="2377433"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="2377433"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 11:27:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="809940495"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="809940495"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga001.jf.intel.com with ESMTP; 18 Dec 2023 11:27:13 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 1/3] ice: stop trashing VF VSI aggregator node ID information
Date: Mon, 18 Dec 2023 11:27:04 -0800
Message-ID: <20231218192708.3397702-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231218192708.3397702-1-anthony.l.nguyen@intel.com>
References: <20231218192708.3397702-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

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
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
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


