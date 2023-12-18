Return-Path: <netdev+bounces-58638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15495817AFF
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 20:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17A411C22974
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 19:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5715572069;
	Mon, 18 Dec 2023 19:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VAgBjMat"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2953671456
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 19:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702927638; x=1734463638;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uTf2dysmTyoVMirZN6GfR9pMtbxXvd1uWteSecEkEoo=;
  b=VAgBjMatyhz74pn7MWpNe05P6iqgYSRkQvsAfClQjGDCJnk9L5rmCJO3
   ZrEX9CuPPw3SB/HG024vQR4R9N+57/grMIoqgrXRbTVha22fBI0HMdZTS
   W7FY89Lb+al6M9+khPKmxG8oFZgVlCwclFWbawzxfz14yx10VyU5Kbt5d
   l5Z93oOkfO14OvXodgv4FnefqIAesagm5529Kh/CBAgcsyy60BD0jryK2
   PM8zIZqXPdCjn/ecJEctSWVrKOMRCtvKv1SbjvORMa/BSK5wukaKa3Q4P
   T/RfBlXUVkaN/xQTUXfOoqEPTSM7LVl5gHIpZaMf/rQVHMzABxt+fD52t
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="2377437"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="2377437"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 11:27:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="809940500"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="809940500"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga001.jf.intel.com with ESMTP; 18 Dec 2023 11:27:13 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Dave Ertman <david.m.ertman@intel.com>,
	anthony.l.nguyen@intel.com,
	daniel.machon@microchip.com,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 2/3] ice: alter feature support check for SRIOV and LAG
Date: Mon, 18 Dec 2023 11:27:05 -0800
Message-ID: <20231218192708.3397702-3-anthony.l.nguyen@intel.com>
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

From: Dave Ertman <david.m.ertman@intel.com>

Previously, the ice driver had support for using a handler for bonding
netdev events to ensure that conflicting features were not allowed to be
activated at the same time.  While this was still in place, additional
support was added to specifically support SRIOV and LAG together.  These
both utilized the netdev event handler, but the SRIOV and LAG feature was
behind a capabilities feature check to make sure the current NVM has
support.

The exclusion part of the event handler should be removed since there are
users who have custom made solutions that depend on the non-exclusion of
features.

Wrap the creation/registration and cleanup of the event handler and
associated structs in the probe flow with a feature check so that the
only systems that support the full implementation of LAG features will
initialize support.  This will leave other systems unhindered with
functionality as it existed before any LAG code was added.

Fixes: bb52f42acef6 ("ice: Add driver support for firmware changes for LAG")
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lag.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index 280994ee5933..b47cd43ae871 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -1981,6 +1981,8 @@ int ice_init_lag(struct ice_pf *pf)
 	int n, err;
 
 	ice_lag_init_feature_support_flag(pf);
+	if (!ice_is_feature_supported(pf, ICE_F_SRIOV_LAG))
+		return 0;
 
 	pf->lag = kzalloc(sizeof(*lag), GFP_KERNEL);
 	if (!pf->lag)
-- 
2.41.0


