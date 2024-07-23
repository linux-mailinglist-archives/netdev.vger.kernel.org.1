Return-Path: <netdev+bounces-112698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7BC93A9EE
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 01:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86F2228547F
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 23:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EE8149C5E;
	Tue, 23 Jul 2024 23:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QbgTn+VT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC121494D6
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 23:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721777570; cv=none; b=ut7Iy1EZRkh8h4c82DOBZcVHgJ9JuBTiflB6gfHesH4B6uMprtlZrnSTcD2hjD3ahwLQCJmJkfoU3htIoHjNX/FLmPMlogU437xzSJDkIhWcbCXEMlPZHYoTRKVVJI+C/+eEXjR5wAtwN821Xj7P5kpy24MgQ3u5/x1vvronNXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721777570; c=relaxed/simple;
	bh=2y47HrzQ10u1vvE6/1JwHiK3GbG94ai+BkLVFonBNXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dq49ZW6ewB29gkv31UkqdrzQ7WXJrBXzIK6FMrHja3noqJMm6QQqlWv35S7SQprviRdIt/krBLly40pHP+A8HOuQ7k57shIRGeDsPoth/EoNKW3tzLrxI0MGxlS0JIY2oJvZchtT4/oNL9ZpVrnbzDf2XBtVXKAZNlTMPFpKOUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QbgTn+VT; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721777569; x=1753313569;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2y47HrzQ10u1vvE6/1JwHiK3GbG94ai+BkLVFonBNXo=;
  b=QbgTn+VTZkrnaQ/LPbyuB4z2q+l8xuCdVIlxvCz9RalIsinhS/W3i9rG
   KefN1Dj3p1rKQT3S8/dVp3DLcRI0AyKdU1gfid/mYTbEcobqHzv9sM2Qx
   mzlhwb3u+mYgAQWmhjyvS7xqDQRilvLtLkGcmFIchcAdl9Bwi65yIvJfB
   pDpo5ZdAavYp1TKVORSpAqwfb90AOuTVdFNTXEWmoifsWrZIGr9+OMIX7
   7oKm9e52rrE5C/2HBrnd2hi9+KvywsaNsE+I/L3DPWGebtUg4m3KDWGLB
   eV574drg+iYbwxNUIV/b0r8YYctgog2WGqbAM3VV+ZAoxHzxy5U1C3trJ
   A==;
X-CSE-ConnectionGUID: o00tuqX1QO6VaxZ9bClJdg==
X-CSE-MsgGUID: 8+nTDLx9TsG3woe02BQEUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="30049082"
X-IronPort-AV: E=Sophos;i="6.09,231,1716274800"; 
   d="scan'208";a="30049082"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 16:32:46 -0700
X-CSE-ConnectionGUID: +/6at0KcTeWYuGx87LYEsA==
X-CSE-MsgGUID: +gU89QC+QIOR6MWPQYm6ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,231,1716274800"; 
   d="scan'208";a="89847955"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 23 Jul 2024 16:32:46 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Wojciech Drewek <wojciech.drewek@intel.com>,
	anthony.l.nguyen@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net 2/2] ice: Fix recipe read procedure
Date: Tue, 23 Jul 2024 16:32:40 -0700
Message-ID: <20240723233242.3146628-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240723233242.3146628-1-anthony.l.nguyen@intel.com>
References: <20240723233242.3146628-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wojciech Drewek <wojciech.drewek@intel.com>

When ice driver reads recipes from firmware information about
need_pass_l2 and allow_pass_l2 flags is not stored correctly.
Those flags are stored as one bit each in ice_sw_recipe structure.
Because of that, the result of checking a flag has to be casted to bool.
Note that the need_pass_l2 flag currently works correctly, because
it's stored in the first bit.

Fixes: bccd9bce29e0 ("ice: Add guard rule when creating FDB in switchdev")
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 3caafcdc301f..fe8847184cb1 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -2400,10 +2400,10 @@ ice_get_recp_frm_fw(struct ice_hw *hw, struct ice_sw_recipe *recps, u8 rid,
 
 		/* Propagate some data to the recipe database */
 		recps[idx].priority = root_bufs.content.act_ctrl_fwd_priority;
-		recps[idx].need_pass_l2 = root_bufs.content.act_ctrl &
-					  ICE_AQ_RECIPE_ACT_NEED_PASS_L2;
-		recps[idx].allow_pass_l2 = root_bufs.content.act_ctrl &
-					   ICE_AQ_RECIPE_ACT_ALLOW_PASS_L2;
+		recps[idx].need_pass_l2 = !!(root_bufs.content.act_ctrl &
+					     ICE_AQ_RECIPE_ACT_NEED_PASS_L2);
+		recps[idx].allow_pass_l2 = !!(root_bufs.content.act_ctrl &
+					      ICE_AQ_RECIPE_ACT_ALLOW_PASS_L2);
 		bitmap_zero(recps[idx].res_idxs, ICE_MAX_FV_WORDS);
 		if (root_bufs.content.result_indx & ICE_AQ_RECIPE_RESULT_EN) {
 			set_bit(root_bufs.content.result_indx &
-- 
2.41.0


