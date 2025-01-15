Return-Path: <netdev+bounces-158309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77460A115E0
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 01:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04EDA168E26
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 00:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAED111AD;
	Wed, 15 Jan 2025 00:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XuZDQxNj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD606FB9
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 00:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736899737; cv=none; b=pZIDfbXgw9MGxjKP4BfaKm6596ydJZULR7AY7K8IwAjnvIJKSILXp15zdXEg0B52QU4ScbkVZtpIAkuXVtOtkyGSRjgPmfBm6A3WJ74q+RrcwksDhpqx1//X6UBZi7fXtaR8CjjD0CLWHdwSjaNHgpf0bANavIYuGKJMWaK1TuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736899737; c=relaxed/simple;
	bh=W43vtbRTfk61f7o9uDx1IH0WgkO64zm4gkwG4+EQtQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KbGjZllZ+gfU6EBCJYQICvCnvgkbG+ONs3DsfV3n4DVh4BIbjeE5CnbmFpoeqgXWDhLa45Z1ujE6ZFx+ubnH6rvEcoqt0uU2I926Kw94f0Kd+LtVMuh4TIernxa+Iu4C6z+6z2cSlvAlWAPImDtoZGnJtq5O8xmsrhabClDrdk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XuZDQxNj; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736899736; x=1768435736;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W43vtbRTfk61f7o9uDx1IH0WgkO64zm4gkwG4+EQtQs=;
  b=XuZDQxNjKIVbTItYWi1uEExScx5+34qF7O4IUIan2CDBhhPc7uKuMmGt
   Mv3o37IFUkPId6PxlXqllV53sVBY2Paxfq+Yi//IsDF+PpH4j96pNwG0c
   D1fRXe5ICAx5OSsagFQ93Z43sIgqVzvxJaJ8gG/+f5a2b51IVIAC2eXCF
   1exRBGLLQBxWEG30sVwzerZJRhUkFXzVXbyfLp5oN/a8dfMyhr5tIeCwC
   63n6ylj0WCh1nvNgPfbm8XG+3n86foUB/mfLxe3Sj/IwgWDZUDOG55ypp
   K/kBN9fnZZk7FFAW5fqYsjVn/FitrZAjYfvbvSMFimGh+jvSd+IgCwLhU
   A==;
X-CSE-ConnectionGUID: TIMJUF9EScS6F8nDtWFrAw==
X-CSE-MsgGUID: yUhLjZxLRvOWxJtgp3rx9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="40897476"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="40897476"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 16:08:52 -0800
X-CSE-ConnectionGUID: u+D9OLZvTxSjKcpO8dRd8A==
X-CSE-MsgGUID: QeoXZ1IyQB2m5eHB6gh7/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128211410"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 14 Jan 2025 16:08:52 -0800
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
Subject: [PATCH net-next v2 05/13] ice: add recipe priority check in search
Date: Tue, 14 Jan 2025 16:08:31 -0800
Message-ID: <20250115000844.714530-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115000844.714530-1-anthony.l.nguyen@intel.com>
References: <20250115000844.714530-1-anthony.l.nguyen@intel.com>
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


