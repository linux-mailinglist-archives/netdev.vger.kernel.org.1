Return-Path: <netdev+bounces-181784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D05D1A86782
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 22:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F10161B82549
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7499329CB52;
	Fri, 11 Apr 2025 20:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lm8qcj9H"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C120129B23D
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 20:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744404257; cv=none; b=oRtr7Ycv3+URRJOP42msBOA1a3LYfwQlsbBu4xPaTqIARSQb9QQIK+aLwsmheBpwaDigwQ8Af0/CKpEa7FSDajka5g+aWARaUaJqQgd2M++Xge6VL/NXtGkT/hARjAf55VGTMLcmbUwyZJEbiw3Y76QHcE0ai2H/Kbba19kDBT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744404257; c=relaxed/simple;
	bh=u7YdM1QY8Bjc8GPTlObxMHwPlVhiXrRTn/Cemj14yfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KgS6HAOpEYiX7Ziq64kcaP7exjW95pGaOB9YUsurhjjs7HZVSeg0Ft/4taImcN/IcHyLIone4g43YMw/uCPYr7TtWWwlMgJ1uBLti3ABnGkfwVmOX7n6Ud6NG9laVbIGxUNUHXz/U7InSPpqPUoIK5e6qRIFGDmRHv5DQgpCU34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lm8qcj9H; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744404256; x=1775940256;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u7YdM1QY8Bjc8GPTlObxMHwPlVhiXrRTn/Cemj14yfo=;
  b=Lm8qcj9HEHeJ1UJTMNfan/KcFuTHr1pK38QtGSa0bR5o9ALYi5+HAY7R
   N+0LwDcrn3xZ48k+fm/PMDMgUgrrXjCZxO4oZ72uCfqXF50hrNYK8qYYk
   +cQiud80kauiP+WriYpZzJ9ir6c/CzzoLPT4BFKE0W5i+wcmPmVNNZVCW
   KSJoJwxAlvsiVZ2NVYABbeuZc2fRvq8XTNphQILIA4cShkCBWFY+F7Msr
   sFnXrEvQDxmjgpJG7z4K0yF2K9MvteyOcbJyiGEyAnsVCyv+wuJ8zYaTt
   sCoXF93zxg4QGCXvdFpsUkHEOoR1+jB8JEzsfb/UnJ7Ld2AVUMT0rEJDb
   Q==;
X-CSE-ConnectionGUID: 3dIOAd9qT2OOiLwvWq580Q==
X-CSE-MsgGUID: 0+EKyifeQUSmaXSKec8nfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="45103922"
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="45103922"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 13:44:08 -0700
X-CSE-ConnectionGUID: PIa1iw/LQ36S6wecmI8Odg==
X-CSE-MsgGUID: ebwwmdpLRUa1n3R6UgCH2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="129241832"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 11 Apr 2025 13:44:07 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Rand Deeb <rand.sec96@gmail.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	voskresenski.stanislav@confident.ru,
	deeb.rand@confident.ru,
	lvc-project@linuxtesting.org,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 13/15] ixgbe: Fix unreachable retry logic in combined and byte I2C write functions
Date: Fri, 11 Apr 2025 13:43:54 -0700
Message-ID: <20250411204401.3271306-14-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411204401.3271306-1-anthony.l.nguyen@intel.com>
References: <20250411204401.3271306-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rand Deeb <rand.sec96@gmail.com>

The current implementation of `ixgbe_write_i2c_combined_generic_int` and
`ixgbe_write_i2c_byte_generic_int` sets `max_retry` to `1`, which makes
the condition `retry < max_retry` always evaluate to `false`. This renders
the retry mechanism ineffective, as the debug message and retry logic are
never executed.

This patch increases `max_retry` to `3` in both functions, aligning them
with the retry logic in `ixgbe_read_i2c_combined_generic_int`. This
ensures that the retry mechanism functions as intended, improving
robustness in case of I2C write failures.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index 0a03a8bb5f88..2d54828bdfbb 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -167,7 +167,7 @@ int ixgbe_write_i2c_combined_generic_int(struct ixgbe_hw *hw, u8 addr,
 					 u16 reg, u16 val, bool lock)
 {
 	u32 swfw_mask = hw->phy.phy_semaphore_mask;
-	int max_retry = 1;
+	int max_retry = 3;
 	int retry = 0;
 	u8 reg_high;
 	u8 csum;
@@ -2285,7 +2285,7 @@ static int ixgbe_write_i2c_byte_generic_int(struct ixgbe_hw *hw, u8 byte_offset,
 					    u8 dev_addr, u8 data, bool lock)
 {
 	u32 swfw_mask = hw->phy.phy_semaphore_mask;
-	u32 max_retry = 1;
+	u32 max_retry = 3;
 	u32 retry = 0;
 	int status;
 
-- 
2.47.1


