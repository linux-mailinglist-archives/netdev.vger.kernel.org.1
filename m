Return-Path: <netdev+bounces-69640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 327C084BF59
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 22:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E332D288DF4
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 21:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8C61BF34;
	Tue,  6 Feb 2024 21:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ODd6FPpb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992A41BC41
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 21:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707255677; cv=none; b=jMoKSobdMcsbrBmT3C4S3tYAHD2YRepmpb4mLsjLknOFNGvACqM1fL9Zy82rp7BeqdVSE+tWaNkYlgQa+dIJIZw4OGb6rUz+F5xmelzgcDHDE+ldRBeEb7v3ciI42oBj+0O+6C9JDQiRDfNvDD+a9UENQo3sAUn4Xw+v7ADPc/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707255677; c=relaxed/simple;
	bh=ES+LmaiBdrmEKYPwsb9mARybNIZMsa8TWbag+BvAwTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n3jWwpbqNPXBbRAcScqMc5q/xDMNWzXSKmavMzHwrbPuKd6YKu36M5Qb4dxjSLCKUg8JvNH3jM9i1eoeUGCfXWrCo8fqxUGe6PvKsPdvlyIFXhnEiEe0hMCVS5+ruRAakVTxspoRGNtawgZq7X57xXuNZpWySeUBgT4nZPWVT+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ODd6FPpb; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707255676; x=1738791676;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ES+LmaiBdrmEKYPwsb9mARybNIZMsa8TWbag+BvAwTU=;
  b=ODd6FPpbTB+7ilRjUwkaRaOSvhoZeEKl+JphyyguERKcoxrI/sq0c8vi
   XgmcAHrs4rAFGwvyASC5lHpxmKuqmOfRrOnaf4GIXsc028Ezg7NUV/z7c
   UFaOQV0lObOfJpiPsXsRl/7RXKB1yHBBNy1KArgbVaGNXzue/VeM86DWW
   XwdLkp8oOGffM97wYRp8S0sNOd9rz9zyZu1iUvF1UNudYNifj4ZkJIrLB
   ddoA8upXgaXFpkLRg+vly7S+5ybDntSE7YrKxHvqtbEspSTqbIPqX5hvA
   EQFft/0aTJPf8IDpwFaWVrttUjDr/zTxi1qLbAv7wJexboLYq1oATWEXJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="759321"
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="759321"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 13:41:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="5917818"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 06 Feb 2024 13:41:00 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	anthony.l.nguyen@intel.com,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 3/3] ixgbe: Clarify the values of the returning status
Date: Tue,  6 Feb 2024 13:40:53 -0800
Message-ID: <20240206214054.1002919-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240206214054.1002919-1-anthony.l.nguyen@intel.com>
References: <20240206214054.1002919-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

Converting s32 functions to regular int in the previous patch of the series
caused triggering smatch warnings about missing error code.

New smatch warnings:
drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:2884 ixgbe_get_lcd_t_x550em() warn: missing error code? 'status'
drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:3130 ixgbe_enter_lplu_t_x550em() warn: missing error code? 'status'

Old smatch warnings:
drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:2890 ixgbe_get_lcd_t_x550em() warn: missing error code? 'status'

Fix it by clearly stating returning error code as 0.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202401041701.6QKTsZmx-lkp@intel.com/
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 6419c159c1b1..2decb0710b6e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -2884,17 +2884,17 @@ static int ixgbe_get_lcd_t_x550em(struct ixgbe_hw *hw,
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
@@ -3130,7 +3130,7 @@ static int ixgbe_enter_lplu_t_x550em(struct ixgbe_hw *hw)
 	     (lcd_speed == IXGBE_LINK_SPEED_1GB_FULL)) ||
 	    ((speed == IXGBE_MDIO_AUTO_NEG_VENDOR_STATUS_10GB) &&
 	     (lcd_speed == IXGBE_LINK_SPEED_10GB_FULL)))
-		return status;
+		return 0;
 
 	/* Clear AN completed indication */
 	status = hw->phy.ops.read_reg(hw, IXGBE_MDIO_AUTO_NEG_VENDOR_TX_ALARM,
-- 
2.41.0


