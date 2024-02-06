Return-Path: <netdev+bounces-69637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C30684BF34
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 22:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29021B250C9
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 21:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17B51B96B;
	Tue,  6 Feb 2024 21:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dmDORtLs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270891B94A
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 21:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707254911; cv=none; b=HVKr5zhPdmi0lydQalrR/7GDChgDqK6IUCyy1PznvpJ1SIVBvnqdce1rU7ItP0tId0f92JjjPoX8/ugGnNz7xXaZsvi0jHEiswLodCsapGxg0hcXxcQInr2Ps0K1iDgtm7Y5cdRFfXFY5JvGhVHQDl/f7JUAkUbbXzvo9ZZSImA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707254911; c=relaxed/simple;
	bh=H2Ofz7ZA9UN1w2/A6W26dmY3Z27qOkFkRbMdznsDUyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hV/3DsKA3DLloC2AiR32voscMDtXVTVtonPXJYPuvjynVBUBA0+90n96HAkwwQsdCa1ZXMO8sdqmgKmV8LTYa8JIDRGzzJt4Ko93pP3jwX2Mhf+Vwc/P+46Tbycn7GWHAZrY7eJL3YapkBKxp4iTXLPFwc1z0HLL/Q5ze5IXPJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dmDORtLs; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707254910; x=1738790910;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H2Ofz7ZA9UN1w2/A6W26dmY3Z27qOkFkRbMdznsDUyw=;
  b=dmDORtLs5T0luNkZOyEfX3/S90cJ67njH7OCVhkz774GgIm3TR1ox4u7
   PV6KbAsDh6nPYyLhLrrfe9tDFssHMNgabzwiuQXpTqD4eOKcMMOnwTX4L
   vfzdW7mT7+0MrzPMRGncc4/q9g9GVWc8spef8onqjn7uTR5xdRLfXrfPZ
   SKNwhhqY5lHUHo3GXHngK24REf4LaVo4vBG6Nk7da3R3nQLtvFS4oguQ7
   GTlBAcy5Yx0W9+UGbTpQiNQSgUbiSW6R+9iSUj09gHpyOz8uswOkgdRju
   XZgmemfvGbnSQ5AxWGXWku2ngpQG4L7PK30H3cgJUsb/j2ulhBQijeBsg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="11583410"
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="11583410"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 13:28:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="5748304"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 06 Feb 2024 13:28:27 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Sasha Neftin <sasha.neftin@intel.com>,
	anthony.l.nguyen@intel.com,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net 2/2] igc: Remove temporary workaround
Date: Tue,  6 Feb 2024 13:28:18 -0800
Message-ID: <20240206212820.988687-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240206212820.988687-1-anthony.l.nguyen@intel.com>
References: <20240206212820.988687-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sasha Neftin <sasha.neftin@intel.com>

PHY_CONTROL register works as defined in the IEEE 802.3 specification
(IEEE 802.3-2008 22.2.4.1). Tide up the temporary workaround.

Fixes: 5586838fe9ce ("igc: Add code for PHY support")
Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_phy.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_phy.c b/drivers/net/ethernet/intel/igc/igc_phy.c
index 7cd8716d2ffa..861f37076861 100644
--- a/drivers/net/ethernet/intel/igc/igc_phy.c
+++ b/drivers/net/ethernet/intel/igc/igc_phy.c
@@ -130,11 +130,7 @@ void igc_power_down_phy_copper(struct igc_hw *hw)
 	/* The PHY will retain its settings across a power down/up cycle */
 	hw->phy.ops.read_reg(hw, PHY_CONTROL, &mii_reg);
 	mii_reg |= MII_CR_POWER_DOWN;
-
-	/* Temporary workaround - should be removed when PHY will implement
-	 * IEEE registers as properly
-	 */
-	/* hw->phy.ops.write_reg(hw, PHY_CONTROL, mii_reg);*/
+	hw->phy.ops.write_reg(hw, PHY_CONTROL, mii_reg);
 	usleep_range(1000, 2000);
 }
 
-- 
2.41.0


