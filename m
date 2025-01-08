Return-Path: <netdev+bounces-156483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1976A06818
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 23:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F6A67A2F0B
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 22:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BC9204C2F;
	Wed,  8 Jan 2025 22:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="llaMZpkC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19042204C02
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 22:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736374688; cv=none; b=S/ruPY5QWQh+alJNvLFZmt/Ir9dTDpdZ7wcMnguRiXJmqFU+sn/gRiZNoOWhivT1I3Cj/s5TkTKM0yVuZic3I3c6YV8sillQUToPK4mH+JBF4nv6kXkoMafcRrdBOIcNaCObYfe3j7g8Fi32+RPkr+tjXKmDafSUzkQ15MWh3Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736374688; c=relaxed/simple;
	bh=W43vtbRTfk61f7o9uDx1IH0WgkO64zm4gkwG4+EQtQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DiCcWE+1koXQkghVoFFcl+UiSl9GswDqt1ECANOKiZ7T/8bLs7fKk9XYPjwtJf20a9939yi4sHcAMgsF5Lg8YegUOxw0PSwRRPHtUIYC/1RpUc9NSSq+K7/iXksaT/HvZ86yFrVClpjLW3Cav3lg1WL1dLf9hniv7hkLrpgxyMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=llaMZpkC; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736374687; x=1767910687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W43vtbRTfk61f7o9uDx1IH0WgkO64zm4gkwG4+EQtQs=;
  b=llaMZpkCC8hFrRk2tBKITrIIyGpINeY97Pt1YyZmYMk/W0eTBnMUsu4p
   Y11eaANp069pElxtcKDNR2mG6FfhVYxwuLUTaSznCQWDoxI3VSXOQsq4C
   u1r/LjIOABDFSwUmS9wJVNSE4OQ+Zn0r+EPVqWfuvjbHdcBO2jcj1S9Rz
   oR0d88eKLulAUgP/Csi28zGd0/26A5tGunkXEvTyEKgKcYMjKm8Q4tykx
   y7IXW15pxIQyUbaxG3Pa9RzOHcEL0gxRz2suUnJgsGNDCJLiuHz292UxM
   aokE6/ChHltpW5NsMnA8EUsJuU+vEDgovXv6UrOq3QcR8X5k+Y0R6xo6z
   g==;
X-CSE-ConnectionGUID: q+9a6CC3QP6CWGc3ZD3/4w==
X-CSE-MsgGUID: XBrjkWpWTbOBVIBrpoULEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="40384664"
X-IronPort-AV: E=Sophos;i="6.12,299,1728975600"; 
   d="scan'208";a="40384664"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 14:18:03 -0800
X-CSE-ConnectionGUID: rvFXzt9jSnSJFwkqhj9WyA==
X-CSE-MsgGUID: 4zSsLqBiQiKuLeWM91XQ5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="140545120"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 08 Jan 2025 14:18:03 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 05/13] ice: add recipe priority check in search
Date: Wed,  8 Jan 2025 14:17:42 -0800
Message-ID: <20250108221753.2055987-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108221753.2055987-1-anthony.l.nguyen@intel.com>
References: <20250108221753.2055987-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

The new recipe should be added even if exactly the same recipe already
exists with different priority.

Example use case is when the rule is being added from TC tool context.
It should has the highest priority, but if the recipe already exists
the rule will inherit it priority. It can lead to the situation when
the rule added from TC tool has lower priority than expected.

The solution is to check the recipe priority when trying to find
existing one.

Previous recipe is still useful. Example:
RID 8 -> priority 4
RID 10 -> priority 7

The difference is only in priority rest is let's say eth + mac +
direction.

Adding ARP + MAC_A + RX on RID 8, forward to VF0_VSI
After that IP + MAC_B + RX on RID 10 (from TC tool), forward to PF0

Both will work.

In case of adding ARP + MAC_A + RX on RID 8, forward to VF0_VSI
ARP + MAC_A + RX on RID 10, forward to PF0.

Only second one will match, but this is expected.

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 0e740342e294..4a91e0aaf0a5 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -4784,7 +4784,8 @@ ice_find_recp(struct ice_hw *hw, struct ice_prot_lkup_ext *lkup_exts,
 			 */
 			if (found && recp[i].tun_type == rinfo->tun_type &&
 			    recp[i].need_pass_l2 == rinfo->need_pass_l2 &&
-			    recp[i].allow_pass_l2 == rinfo->allow_pass_l2)
+			    recp[i].allow_pass_l2 == rinfo->allow_pass_l2 &&
+			    recp[i].priority == rinfo->priority)
 				return i; /* Return the recipe ID */
 		}
 	}
-- 
2.47.1


