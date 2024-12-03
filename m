Return-Path: <netdev+bounces-148700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D2B9E2E86
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 22:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AD1A280DCC
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 21:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5535320CCE1;
	Tue,  3 Dec 2024 21:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GeYBUc5R"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796D420C46F
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 21:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262937; cv=none; b=R/2sPmzxuCrcEARCwA5SkAS2Uz4UHHzu11xYl6ikRmEuw5ikmkOrVwWUBZ3kguXc/lVMnpSnVCd95TWZevwQCbROp7duoiiennq9tB4GSKYFU9x3mhL22Nbfe6QYfHZXfupJnJvOmIKGce/OCJ6fvixBJ5EMWWvgzmEgBEKQfSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262937; c=relaxed/simple;
	bh=36E1tF73fRhT1Qc4HMd0JfiPteVCDgEUZcMK1NA3kWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Esu9dWGL3z6sJgH2fpUUrU/DnD/JjDHwLBmw5B3RT4GvDNDCeyo8UFPcQ6k5ESN5iwoisxFlDI8ohLgNFcxOzd0IUrklbJaHIApVDfOPr8jl/kja8Fw6GkhmsYu3AeXOFyYYBcyO6YHD8CgxjfgdP01tA2IJDkNPmZDWOzhFgSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GeYBUc5R; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733262935; x=1764798935;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=36E1tF73fRhT1Qc4HMd0JfiPteVCDgEUZcMK1NA3kWE=;
  b=GeYBUc5ReM/v/OxXjGXVii1w76LO+VtLBi3znAiRZW3vjITlfPXCNLLY
   emnZRMIqhDuNoeZ0OvCdAlwSNB4o2eJ/DyapvRtKtrv+u1Z19abO181BS
   NScjl5J+DdT2I3cWfcgmvKTKrS0cvKwoyG/gvvjAO6mMVlWt+5i4eopEJ
   BOnwAddQl4ySAH57hkyQxp0SJKRWI9ZNicT8qK44NNU8dIrlJJ6QzyiS9
   DxoofD8Vy9NCO7t4aw9kqQFWimx38U+94Ko6V3DOu5HAfjQQF2qgn4Lb1
   UasthXuikytnhcSo7aIcA01+11GQnAF4g8oKwQOWFDZGrR8TRH6tGO0j5
   w==;
X-CSE-ConnectionGUID: DWNz/bIRTWihSl4wEvJmtg==
X-CSE-MsgGUID: KwflW6uZQri6Jt6bceojcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="21087157"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="21087157"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 13:55:30 -0800
X-CSE-ConnectionGUID: hEaB4he3T6mZ56bKYM+UTg==
X-CSE-MsgGUID: Ce4RmBucTiifG7hde0kczg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="98578891"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 03 Dec 2024 13:55:30 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tore Amundsen <tore@amundsen.org>,
	anthony.l.nguyen@intel.com,
	ernesto@castellotti.net,
	przemyslaw.kitszel@intel.com,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 8/9] ixgbe: Correct BASE-BX10 compliance code
Date: Tue,  3 Dec 2024 13:55:17 -0800
Message-ID: <20241203215521.1646668-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241203215521.1646668-1-anthony.l.nguyen@intel.com>
References: <20241203215521.1646668-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tore Amundsen <tore@amundsen.org>

SFF-8472 (section 5.4 Transceiver Compliance Codes) defines bit 6 as
BASE-BX10. Bit 6 means a value of 0x40 (decimal 64).

The current value in the source code is 0x64, which appears to be a
mix-up of hex and decimal values. A value of 0x64 (binary 01100100)
incorrectly sets bit 2 (1000BASE-CX) and bit 5 (100BASE-FX) as well.

Fixes: 1b43e0d20f2d ("ixgbe: Add 1000BASE-BX support")
Signed-off-by: Tore Amundsen <tore@amundsen.org>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Acked-by: Ernesto Castellotti <ernesto@castellotti.net>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
index 14aa2ca51f70..81179c60af4e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
@@ -40,7 +40,7 @@
 #define IXGBE_SFF_1GBASESX_CAPABLE		0x1
 #define IXGBE_SFF_1GBASELX_CAPABLE		0x2
 #define IXGBE_SFF_1GBASET_CAPABLE		0x8
-#define IXGBE_SFF_BASEBX10_CAPABLE		0x64
+#define IXGBE_SFF_BASEBX10_CAPABLE		0x40
 #define IXGBE_SFF_10GBASESR_CAPABLE		0x10
 #define IXGBE_SFF_10GBASELR_CAPABLE		0x20
 #define IXGBE_SFF_SOFT_RS_SELECT_MASK		0x8
-- 
2.42.0


