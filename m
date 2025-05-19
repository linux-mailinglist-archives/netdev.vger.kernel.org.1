Return-Path: <netdev+bounces-191655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CABABC8DD
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 23:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 162B117DFF5
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 21:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCCF21ABD7;
	Mon, 19 May 2025 21:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JJcWvVGU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2E81F1319
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 21:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747688732; cv=none; b=ErmjulFlCpy9NExD3d7mCwLvSrLEZYfoHNq31uuaS9SFDKl19Pn0JllzO4iblsI7lPTBci+ThyfKezxEyTM/Pht48y8kI60pyU0AUJPTlJfeFWIrlS+pSzc2baQXe63nGHVihjGiVCxWvaTsXEGypYCx+c1QKfC6+JTUATNd5cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747688732; c=relaxed/simple;
	bh=nmv03eH24p8Z6+2xMtyZUhqjkeH/ir9DOPI7lPjwWDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DEgppHpjwnQf3F4aGFwGlOs1zjnE/rN+p0JuJ+3kWE9f4k3bpc0hdatRZbemoaOz0qLdXAFoQ3ZH+ZqCQs1/X0Hhs63jc5Gr7hWLXH53f8vMxpaJ3ybxODHXYbJTCjRwa4okJu8Y5J+EZ+3Ig4/Oo5lOFycB4IlLB+N3zmxvYQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JJcWvVGU; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747688731; x=1779224731;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nmv03eH24p8Z6+2xMtyZUhqjkeH/ir9DOPI7lPjwWDU=;
  b=JJcWvVGUwoNyPq8SMxDQyaUfG71xLvlWPpepNHLPcOFTeaJq92Iu0xmT
   keQQXA4lCn204pF1zXYA59nt/pVXfgz8ohaZ4aUTfSubqmI+wua5r4nQJ
   gT7KIC1DmsHCAdRWzg1+wM1pCPz0oyE+0LQeq7hnSClLS4oO4iDKRqDOt
   bpwhHXmCIt0aw8J4Jheb8/yLdOVqcfT9VkXe06DTm7iZ4uXoJWoiSEBb1
   0AMDG+vukIqOjgtStUtTwG0lFG80ZvTd7Ly4AMHeCMRULBQoi6PiyjEFE
   FdFM1mT6qf2fZhUnAKL0qyKoKuPl/tUTL9pPCd8CAL4ssctN6RVxoyYRz
   g==;
X-CSE-ConnectionGUID: BX4LN1lORMSHORsLCqHKEg==
X-CSE-MsgGUID: /R277cnmRi2FiXgRPksQLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49668526"
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="49668526"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 14:05:30 -0700
X-CSE-ConnectionGUID: JVBxtjbHTtOZ91HOlq9FBA==
X-CSE-MsgGUID: RDvtDEKqRpuJGCdJzDUVZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="140491850"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 19 May 2025 14:05:29 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net 1/3] ice: fix vf->num_mac count with port representors
Date: Mon, 19 May 2025 14:05:18 -0700
Message-ID: <20250519210523.1866503-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250519210523.1866503-1-anthony.l.nguyen@intel.com>
References: <20250519210523.1866503-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The ice_vc_repr_add_mac() function indicates that it does not store the MAC
address filters in the firmware. However, it still increments vf->num_mac.
This is incorrect, as vf->num_mac should represent the number of MAC
filters currently programmed to firmware.

Indeed, we only perform this increment if the requested filter is a unicast
address that doesn't match the existing vf->hw_lan_addr. In addition,
ice_vc_repr_del_mac() does not decrement the vf->num_mac counter. This
results in the counter becoming out of sync with the actual count.

As it turns out, vf->num_mac is currently only used in legacy made without
port representors. The single place where the value is checked is for
enforcing a filter limit on untrusted VFs.

Upcoming patches to support VF Live Migration will use this value when
determining the size of the TLV for MAC address filters. Fix the
representor mode function to stop incrementing the counter incorrectly.

Fixes: ac19e03ef780 ("ice: allow process VF opcodes in different ways")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index 7c3006eb68dd..6446d0fcc052 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -4275,7 +4275,6 @@ static int ice_vc_repr_add_mac(struct ice_vf *vf, u8 *msg)
 		}
 
 		ice_vfhw_mac_add(vf, &al->list[i]);
-		vf->num_mac++;
 		break;
 	}
 
-- 
2.47.1


