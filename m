Return-Path: <netdev+bounces-71800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C42A8551FB
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 19:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DBA8B31589
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 18:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C482912C7F0;
	Wed, 14 Feb 2024 18:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kUsKDdKB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2233712C7E3
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 18:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933839; cv=none; b=if/z+dn2lleM3iFUA56SlwZawAnmFylu5AkRIZdkfYvq66y/M3Jdp6+4F/s936QoDXiJzeVvVC5bCDIXLaIbZ93jTLfX3+nfyI55rPSeFa0WQleQbTHYNXFxD4e7Sg9SjK+k24ZwSHi5pkumgSJsitRlRAghY12otQfZ4L+aBOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933839; c=relaxed/simple;
	bh=R6xknYZmHiaEcCbJz5m6dXCbplm9//j4SfgceruhKyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HerAlZhwHXUie0gMRAkTJOtPkvTL3d3k5BI92w0hTjZva2jcmDEX8HpxROv2orsISpThgabkWTmIM9sZwGyKM67SgWp8/arXLpDYGLDbVMWjQn+JVZmRukfQJZveDqumoIf1190c9C22PQ9QEQ2ghjYT0Gm92eHTvyxTXp8m/os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kUsKDdKB; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707933838; x=1739469838;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R6xknYZmHiaEcCbJz5m6dXCbplm9//j4SfgceruhKyE=;
  b=kUsKDdKBw5h972oC5QKIEw11dObmTO8uQgunOaTkKO+rPGUt55HHgCWm
   5n0a48dcBrosMWTPqpmnPE6B0sXi1zsd1vKH4kxelYanaTaD6xO1j0mPe
   O+K7xybZLwmbuFdcmMaaX3aRKZCzAN5Nz4g3hbYNcBKnEj/Tlhw31g/It
   oUq1+4MdaFjdH5+slIPMe3aNALtIBIjUo29i+m/A2O5GvjEwskZkK8fmf
   sf0Q330BZC6/3AYS2k3jmBOt3ZdLY0lETYb3R2s7u31d3Nw15i4VHCvMc
   OyH3z31c5Ssq+dXJE7Q6iwMupIVxUAj+wDtX13dyxGOIGIYRmsz3tnyYM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="19505807"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="19505807"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 10:03:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="3251279"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 14 Feb 2024 10:03:55 -0800
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
Subject: [PATCH net v2 2/2] igc: Remove temporary workaround
Date: Wed, 14 Feb 2024 10:03:45 -0800
Message-ID: <20240214180347.3219650-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240214180347.3219650-1-anthony.l.nguyen@intel.com>
References: <20240214180347.3219650-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sasha Neftin <sasha.neftin@intel.com>

PHY_CONTROL register works as defined in the IEEE 802.3 specification
(IEEE 802.3-2008 22.2.4.1). Tidy up the temporary workaround.

User impact: PHY can now be powered down when the ethernet link is down.

Testing hints: ip link set down <device> (or just disconnect the
ethernet cable).

Oldest tested NVM version is: 1045:740.

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


