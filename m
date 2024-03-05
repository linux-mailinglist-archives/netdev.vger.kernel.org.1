Return-Path: <netdev+bounces-77641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AD7872720
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 19:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 387B81F29C65
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 18:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D3686AC0;
	Tue,  5 Mar 2024 18:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ge4vn1Xn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699A55C5FB
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 18:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709665070; cv=none; b=W5/3/t54bPn7RI2lvJeiqEw5rVNQeT0CCx0YVqo4cNKsw3nIny0q6gYQ0vSf0uGBQyUgruhK/FJLowvWT361lggy1O2AGchjkBFpJ7EBNY+LoAmYlkCLnk7VXH7FNrH/fJPkF4XRx4ZGwbC+NlduakU6KGp9DfvvJa7lcGg1290=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709665070; c=relaxed/simple;
	bh=Gq6ymIzDeFqG0DllLpvULhkAKLbvvl0Xyr7S8TdXZCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uhg8B/FSp+nWmjytWG36uGJ+7nyENbg0hOd8AIIupta+zrODhwlyckiEU2zm7szcFwshNCpwijRAMVQYI7JoIME8iIYsk4qr7ohauBAQy89zqM7j1ZnzgyT2KCUScymY3WRoBlwaWBpNTj1LJbLzoSr4Vq17BMMQBgg0bHDl36o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ge4vn1Xn; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709665069; x=1741201069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gq6ymIzDeFqG0DllLpvULhkAKLbvvl0Xyr7S8TdXZCc=;
  b=ge4vn1XnwUInAZIrUFpbmY5w4u4ANpXDN3YeXdMk4I5tlZG2wkde0O6b
   ChdpohAw+cAXkDRS1YY4Ig+LAXHCVHJq1pEGo/vDRgkY/JIAg/Ok8T7Hn
   m503+/t7JgZWynbrS6u6Uml5990URtezVrw9N5I7Ki8xHYN+qXTFU+zRD
   qNbLwcuHJPECKd3kP2rLaLaThnonERwYBxRyc5muWvo+2kaj4YIZIsjjl
   8tl1s/o5sS7JNexE3UwhA5zDCCALa3GXBu+9PbmOwC3drwDP6C6ELB4ck
   eyT6k3ioCQDmCbsPYVFDdxxR+ZVVoGo3iuWdIY6m9Bl+VR16nwpsAWBMi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4822227"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="4822227"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 10:57:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="9337232"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 05 Mar 2024 10:57:45 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Sasha Neftin <sasha.neftin@intel.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	Vitaly Lifshits <vitaly.lifshits@intel.com>,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net 8/8] intel: legacy: Partial revert of field get conversion
Date: Tue,  5 Mar 2024 10:57:36 -0800
Message-ID: <20240305185737.3925349-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240305185737.3925349-1-anthony.l.nguyen@intel.com>
References: <20240305185737.3925349-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sasha Neftin <sasha.neftin@intel.com>

Refactoring of the field get conversion introduced a regression in the
legacy Wake On Lan from a magic packet with i219 devices. Rx address
copied not correctly from MAC to PHY with FIELD_GET macro.

Fixes: b9a452545075 ("intel: legacy: field get conversion")
Suggested-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index a2788fd5f8bb..19e450a5bd31 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -2559,7 +2559,7 @@ void e1000_copy_rx_addrs_to_phy_ich8lan(struct e1000_hw *hw)
 		hw->phy.ops.write_reg_page(hw, BM_RAR_H(i),
 					   (u16)(mac_reg & 0xFFFF));
 		hw->phy.ops.write_reg_page(hw, BM_RAR_CTRL(i),
-					   FIELD_GET(E1000_RAH_AV, mac_reg));
+					   (u16)((mac_reg & E1000_RAH_AV) >> 16));
 	}
 
 	e1000_disable_phy_wakeup_reg_access_bm(hw, &phy_reg);
-- 
2.41.0


