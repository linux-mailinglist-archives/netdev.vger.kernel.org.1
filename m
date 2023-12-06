Return-Path: <netdev+bounces-54197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC898063D2
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 02:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B059282135
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 01:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1E562A;
	Wed,  6 Dec 2023 01:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V1k/7oBb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C789181
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 17:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701824494; x=1733360494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bssGAbRo6EZ7uH9j8e/gpjKd/Bpnhc8jnprKFrUZrJs=;
  b=V1k/7oBbAlr/1GjEVBSDIHBCwMxOf0mk0Pzby+igDoVd0Ejt6pWLYucX
   /Q+5zT8jW7c2CncglrTuBKu9PWfOZ62O5kWQj8PQ95ctRZj2vL4oUWiZK
   PkhPOrS7s0RgAuaMP4zQy6n5vvbG6IO3A8iQ/abG7lSRGJQ4cYYasT6pT
   +CriDQCZKgwNvJOl1B4Ghk1iDkqaIewKbpLsioOsZN+E7fBEXXGBcVIrR
   ECoA0RWdKObq7yc2GfK8VlqDvC0Ekc38p+nf6AeLcxx6b6n5iN+yP6jm0
   11cQTHyY5HzuyXupufn55X1h3BDKH96uaNhMCCr7hHlrIHGZQutapMyx4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="12700275"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="12700275"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 17:01:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="841655229"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="841655229"
Received: from jbrandeb-spr1.jf.intel.com ([10.166.28.233])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 17:01:31 -0800
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	netdev@vger.kernel.org,
	aleksander.lobakin@intel.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	marcin.szycik@linux.intel.com
Subject: [PATCH iwl-next v2 01/15] e1000e: make lost bits explicit
Date: Tue,  5 Dec 2023 17:01:00 -0800
Message-Id: <20231206010114.2259388-2-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231206010114.2259388-1-jesse.brandeburg@intel.com>
References: <20231206010114.2259388-1-jesse.brandeburg@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For more than 15 years this code has passed in a request for a page and
masked off that page when read/writing. This code has been here forever,
but FIELD_PREP finds the bug when converted to use it. Change the code
to do exactly the same thing but allow the conversion to FIELD_PREP in a
later patch. To make it clear what we lost when making this change I
left a comment, but there is no point to change the code to generate a
correct sequence at this point.

This is not a Fixes tagged patch on purpose because it doesn't change
the binary output.

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/e1000e/80003es2lan.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/80003es2lan.c b/drivers/net/ethernet/intel/e1000e/80003es2lan.c
index be9c695dde12..74671201208e 100644
--- a/drivers/net/ethernet/intel/e1000e/80003es2lan.c
+++ b/drivers/net/ethernet/intel/e1000e/80003es2lan.c
@@ -1035,17 +1035,18 @@ static s32 e1000_setup_copper_link_80003es2lan(struct e1000_hw *hw)
 	 * iteration and increase the max iterations when
 	 * polling the phy; this fixes erroneous timeouts at 10Mbps.
 	 */
-	ret_val = e1000_write_kmrn_reg_80003es2lan(hw, GG82563_REG(0x34, 4),
-						   0xFFFF);
+	/* these next three accesses were always meant to use page 0x34 using
+	 * GG82563_REG(0x34, N) but never did, so we've just corrected the call
+	 * to not drop bits
+	 */
+	ret_val = e1000_write_kmrn_reg_80003es2lan(hw, 4, 0xFFFF);
 	if (ret_val)
 		return ret_val;
-	ret_val = e1000_read_kmrn_reg_80003es2lan(hw, GG82563_REG(0x34, 9),
-						  &reg_data);
+	ret_val = e1000_read_kmrn_reg_80003es2lan(hw, 9, &reg_data);
 	if (ret_val)
 		return ret_val;
 	reg_data |= 0x3F;
-	ret_val = e1000_write_kmrn_reg_80003es2lan(hw, GG82563_REG(0x34, 9),
-						   reg_data);
+	ret_val = e1000_write_kmrn_reg_80003es2lan(hw, 9, reg_data);
 	if (ret_val)
 		return ret_val;
 	ret_val =
-- 
2.39.3


