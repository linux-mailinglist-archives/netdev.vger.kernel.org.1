Return-Path: <netdev+bounces-64189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB87831ADD
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 14:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 378A3B25487
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 13:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E337E25605;
	Thu, 18 Jan 2024 13:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yhvikv2d"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E63F25753
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 13:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705586028; cv=none; b=tnd9LbVIntX2Zu4Jy3kKuZnHWIHYgBMUrwiz1n/c0hS82ZPfdDzDUXaer91tyrFPQdTk69aF9AhLFocUjQksa0CwNkEFMaIx/B+Rz/jp6mcOdkCrV6DU/JyWJoHD05ZKHzwUkGzXfkejgAPiRgIINvy0Qk1RT6+lXHZmTnWg2EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705586028; c=relaxed/simple;
	bh=Uq6X1ljwAynQGrEWAvH3NSQV1vY1NlFyZK4w5KxomRs=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=oq+JDz2E2YsosQD8lkbQw5yQiJcKMVlTWqyQlQ7u7gq3ZqyYLWUr6mxJDGTDJrEXUOF88rC/gy7u8TIu8BMPAwNusnxwS68V2eW76ENIdvgBUGTYyNiwI02E1qJqzYANjR0v3Rktcdld6iIqmQg5CD0MDdHF053cQ17h4gzrlFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yhvikv2d; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705586027; x=1737122027;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Uq6X1ljwAynQGrEWAvH3NSQV1vY1NlFyZK4w5KxomRs=;
  b=Yhvikv2dJZ/q9JpqMxPTtsCTblL36X0gw8rnpxQt5AaF1Xc7d8zpPwO+
   MsfVtHc+iMa6dJGQXdlkh0Uq5S4tf/SMq/l3LWJYz3dySuUXZhwuas97V
   S9gPba7ydBWYO29++L04Bmkvl67TWH8z+HGx7uFBEwit782TlDPoUMthK
   jP0rTLsys/vgkh9Bs27wEJkMbQyTcPxM2IPqwCfd1r4dZg07CqQG+gVb4
   lyUx3g2pVybW5FbZQnr8n+goQmmam00f015BpNe+ONGwhJ0uAlrT1+sgB
   HsIts5hA71267qPrvFC/BZAlgT8mLRq6KMtlTRTnfSmMkxRn+gIyFHX+F
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="431606968"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="431606968"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 05:53:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="784802303"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="784802303"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orsmga002.jf.intel.com with ESMTP; 18 Jan 2024 05:53:39 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH iwl-next v3 2/3] ixgbe: Fix smatch warnings after type convertion
Date: Thu, 18 Jan 2024 14:43:31 +0100
Message-Id: <20240118134332.470907-2-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240118134332.470907-1-jedrzej.jagielski@intel.com>
References: <20240118134332.470907-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Converting s32 functions to regular int in the patch 8035560dbfaf caused
trigerring smatch warnings about missing error code. The bug predates
the mentioned patch.

New smatch warnings:
drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:2884 ixgbe_get_lcd_t_x550em() warn: missing error code? 'status'
drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:3130 ixgbe_enter_lplu_t_x550em() warn: missing error code? 'status'

Old smatch warnings:
drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:2890 ixgbe_get_lcd_t_x550em() warn: missing error code? 'status'

Fix it by clearly stating returning error code as 0.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202401041701.6QKTsZmx-lkp@intel.com/
Fixes: 6ac743945960 ("ixgbe: Add support for entering low power link up state")
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 70a58bf3d563..56bc1ba184b5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -2883,17 +2883,17 @@ static int ixgbe_get_lcd_t_x550em(struct ixgbe_hw *hw,
 	/* If link partner advertised 1G, return 1G */
 	if (an_lp_status & IXGBE_AUTO_NEG_LP_1000BASE_CAP) {
 		*lcd_speed = IXGBE_LINK_SPEED_1GB_FULL;
-		return status;
+		return 0;
 	}
 
 	/* If 10G disabled for LPLU via NVM D10GMP, then return no valid LCD */
 	if ((hw->bus.lan_id && (word & NVM_INIT_CTRL_3_D10GMP_PORT1)) ||
 	    (word & NVM_INIT_CTRL_3_D10GMP_PORT0))
-		return status;
+		return 0;
 
 	/* Link partner not capable of lower speeds, return 10G */
 	*lcd_speed = IXGBE_LINK_SPEED_10GB_FULL;
-	return status;
+	return 0;
 }
 
 /**
@@ -3129,7 +3129,7 @@ static int ixgbe_enter_lplu_t_x550em(struct ixgbe_hw *hw)
 	     (lcd_speed == IXGBE_LINK_SPEED_1GB_FULL)) ||
 	    ((speed == IXGBE_MDIO_AUTO_NEG_VENDOR_STATUS_10GB) &&
 	     (lcd_speed == IXGBE_LINK_SPEED_10GB_FULL)))
-		return status;
+		return 0;
 
 	/* Clear AN completed indication */
 	status = hw->phy.ops.read_reg(hw, IXGBE_MDIO_AUTO_NEG_VENDOR_TX_ALARM,
-- 
2.31.1


