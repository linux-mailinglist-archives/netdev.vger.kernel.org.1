Return-Path: <netdev+bounces-57084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E89A812134
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 23:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B4D12827D6
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 22:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4F07FBDC;
	Wed, 13 Dec 2023 22:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OJuc4c+E"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657BEAC
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 14:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702505313; x=1734041313;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v1KuvCm/ROrK5/RLQAjPzDrceupWULlgJnbe9Bt28Vw=;
  b=OJuc4c+ETusQqv1pNxRXwsHx2JDqnjynRLlR1gwVnsUqTELJZ5hIIMuA
   xX4WIB6Fp6qFnAI8zX/uRpgt1j/nGFN5mDsRPAe1LR0HGRPPTgrIU41x5
   wpXx1dnaLBpaYRlY1hue+jdZxgVmqhebthLs+w+sWwxwcysQ3VMKFkpT6
   I25T3Pibr9l9ElXn2CJmKqBjl/kiDANvrHbG0DGo5WRf7lffhj4Ma3DpR
   iDdqRCuK6I7fXdp7Qduwb25yAnD6KbXRqAQSi/eyc4uDzXzMwxDyJXDWh
   +z3FWjtqodN2/iWG6DEO2ivyQEsiYTmbCdYVBggcK5ukvUXO4QDirLS8S
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="392209633"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="392209633"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 14:08:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="803034129"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="803034129"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga008.jf.intel.com with ESMTP; 13 Dec 2023 14:08:32 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 1/2] ice: fix theoretical out-of-bounds access in ethtool link modes
Date: Wed, 13 Dec 2023 14:08:25 -0800
Message-ID: <20231213220827.1311772-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231213220827.1311772-1-anthony.l.nguyen@intel.com>
References: <20231213220827.1311772-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Schmidt <mschmidt@redhat.com>

To map phy types reported by the hardware to ethtool link mode bits,
ice uses two lookup tables (phy_type_low_lkup, phy_type_high_lkup).
The "low" table has 64 elements to cover every possible bit the hardware
may report, but the "high" table has only 13. If the hardware reports a
higher bit in phy_types_high, the driver would access memory beyond the
lookup table's end.

Instead of iterating through all 64 bits of phy_types_{low,high}, use
the sizes of the respective lookup tables.

Fixes: 9136e1f1e5c3 ("ice: refactor PHY type to ethtool link mode")
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index a34083567e6f..bde9bc74f928 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -1850,14 +1850,14 @@ ice_phy_type_to_ethtool(struct net_device *netdev,
 	linkmode_zero(ks->link_modes.supported);
 	linkmode_zero(ks->link_modes.advertising);
 
-	for (i = 0; i < BITS_PER_TYPE(u64); i++) {
+	for (i = 0; i < ARRAY_SIZE(phy_type_low_lkup); i++) {
 		if (phy_types_low & BIT_ULL(i))
 			ice_linkmode_set_bit(&phy_type_low_lkup[i], ks,
 					     req_speeds, advert_phy_type_lo,
 					     i);
 	}
 
-	for (i = 0; i < BITS_PER_TYPE(u64); i++) {
+	for (i = 0; i < ARRAY_SIZE(phy_type_high_lkup); i++) {
 		if (phy_types_high & BIT_ULL(i))
 			ice_linkmode_set_bit(&phy_type_high_lkup[i], ks,
 					     req_speeds, advert_phy_type_hi,
-- 
2.41.0


