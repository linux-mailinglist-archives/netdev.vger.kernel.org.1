Return-Path: <netdev+bounces-199179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FE1ADF4EC
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 19:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F320E3BF6C3
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 17:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F062307AE5;
	Wed, 18 Jun 2025 17:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nBHqYxSP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7D72FE398
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268575; cv=none; b=MCpE7Z5wnNe+Q5AuO4sXGQlcXDBOKyDXKlI3w/5+LhR/dqTNw0ahb+y34k4Y3Ta9DH4Lrs+RxhToEuDM0BmtbEw/n6u1I2uNNutrF33pVRY1CafFTTvedK19jkGpp3JfJcT5TITrMIRlFcNfjJZHVH5gOb979IoldA+GJFjD4ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268575; c=relaxed/simple;
	bh=mJBqrazWFbtsbQ5wE9+lNj6Wy9pNmxPAIL7BiQsu5IU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N6MHo8dkzITH+7bpi8O/Y1J/bCjH2g0sbRMqjOKYw3K9uJbQc3Q7C430oNeFDrUVbaPanBquobeq/+wm4Ekhajc04IrKHazL0+bkBFixWyjsvQEU1/0K0P8b2BYyjFnmCv0LItvRknU/JS88Y6vwtqIPz0Hd2pCrCdXpdST2Y6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nBHqYxSP; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750268573; x=1781804573;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mJBqrazWFbtsbQ5wE9+lNj6Wy9pNmxPAIL7BiQsu5IU=;
  b=nBHqYxSPFIy73j7amn+iOW+oVu+bs72Irb5f8rhez8uU6+UzE50Nenf+
   Ylb6/v4tr+lmC7RVj/YJ7Vasdwph7iA4QJZLyNecoz6tPs2B9aIuNNZw1
   NXbpCXtZbsa6jHHo6IOuhLEnryiAiePFRqzT26mTjx7TyEwdOtuXx5hhR
   9nlx2RRx+jS+pvCgycKy3zIoMBuKK60HpNO2UwOtK9wapqcoATdgjmq8d
   76e2hPAvt6E2dXvBXsJvzpWd80QU7jJwX0oWbj1IxT14mCEZbRfWWJ41C
   vjQQuma/DFnNM8O3knK6wfdq9cYa6FTFaqeKOFrfe6N1c9N8frYbI3HHk
   Q==;
X-CSE-ConnectionGUID: O9Alh3w1Q4iggmUd16DSWw==
X-CSE-MsgGUID: Zq41olm2RWGgbxE+SxG6eA==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="56183730"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="56183730"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 10:42:50 -0700
X-CSE-ConnectionGUID: CwsZYF/KQvm2PKG6xIHiwA==
X-CSE-MsgGUID: JvM9uT9sRiSTzvwSHadttw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="149695948"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 18 Jun 2025 10:42:49 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	karol.kolacinski@intel.com,
	przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 09/15] ice: read TSPLL registers again before reporting status
Date: Wed, 18 Jun 2025 10:42:21 -0700
Message-ID: <20250618174231.3100231-10-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250618174231.3100231-1-anthony.l.nguyen@intel.com>
References: <20250618174231.3100231-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

After programming the TSPLL, re-read the registers before reporting status.
This ensures the debug log message will show what was actually programmed,
rather than relying on a cached value.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tspll.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index 8de1ad1da834..743847258693 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -201,8 +201,11 @@ static int ice_tspll_cfg_e82x(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 		return -EBUSY;
 	}
 
-	ice_tspll_log_cfg(hw, dw24.ts_pll_enable, clk_src, clk_freq, true,
-			  true);
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R9, &dw9.val);
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R24, &dw24.val);
+
+	ice_tspll_log_cfg(hw, dw24.ts_pll_enable, dw24.time_ref_sel,
+			  dw9.time_ref_freq_sel, true, false);
 
 	return 0;
 }
@@ -343,8 +346,11 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 		return -EBUSY;
 	}
 
-	ice_tspll_log_cfg(hw, dw23.ts_pll_enable, clk_src, clk_freq, true,
-			  true);
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R9, &dw9.val);
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R23, &dw23.val);
+
+	ice_tspll_log_cfg(hw, dw23.ts_pll_enable, dw23.time_ref_sel,
+			  dw9.time_ref_freq_sel, true, true);
 
 	return 0;
 }
-- 
2.47.1


