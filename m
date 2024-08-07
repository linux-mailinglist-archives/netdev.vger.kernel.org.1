Return-Path: <netdev+bounces-116622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F89294B338
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 00:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2691F223CD
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 22:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4C6155CBD;
	Wed,  7 Aug 2024 22:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B7Y5DB8c"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC2D155A58
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 22:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723070732; cv=none; b=sNogfeLZX2GsOB28Lofp2rwhZW+7nyfc4msgd/3AkYerrf/wcvM2WKQ0YTb9/NvnvM0XmSoFFq7cLXsufzVHvhWnbdSuaYbcOXsJ2aliQStfrvmzGRolJxLkgt2FAGA8VDlCH4XJ+zwkQ4Vyc+MroQqwa+Znq6NwHLjpnF+kLOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723070732; c=relaxed/simple;
	bh=5opfEZqHHujyFFZLzwf9QTfP3PZh3lLAcZSFEoDTIAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhTdZ9Jlgr6zcQ3JEqXLM/qfDfnChKqwt9m1nrgMTxsBStoyPplTydTyFS0Jkf3nsvqfelEtlHe2Xw3Nj1SuKvEtlg2gcP0vtKtlnesqT1soHoieTox85QaMQk5yKn0I0IxuDhbFPNeGBFV2/CDDyKu5k5UFBExcLt8fmdY4PXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B7Y5DB8c; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723070731; x=1754606731;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5opfEZqHHujyFFZLzwf9QTfP3PZh3lLAcZSFEoDTIAQ=;
  b=B7Y5DB8cIjHDhmUdtmeHNtGPYENn5cW6x9iYDesQY/eeC8U2az4Ins7a
   yDeDUPzWrMQVXQyfwz0h8gt5Dl+ELPfHjgcpP141nb4L81dSzcX1YYuJ7
   VagqPlupUx4xugtrv5130E8lzr+n5OULOnjoezGpoJKBz98DtvOxiaLXW
   0idiTuJD19huswJb0/JIcqKBOXufRJf5tsVJgBuzSzNiuLcZGVHxUQpYj
   I1yhMvgls7fTjKnSAawO0/6ncDzSR7tf0Hrv8XGnE30K27DY22QI0G+UR
   GzF5U1POHl9cCZNaxrzFkbvA3TOpppgO5TFjNrzCyefpRGjq3wmwmYFoG
   A==;
X-CSE-ConnectionGUID: yQXHnly5QiOa3z0BdR5DSw==
X-CSE-MsgGUID: IIpYlUYuR5O4asI7bCIJYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="32573973"
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="32573973"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 15:45:29 -0700
X-CSE-ConnectionGUID: tQfNV9N4Rhqe0W44MwA+YA==
X-CSE-MsgGUID: DsIj6w++Qf6assyaLhjDrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="57088295"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 07 Aug 2024 15:45:28 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 3/3] ice: Fix incorrect assigns of FEC counts
Date: Wed,  7 Aug 2024 15:45:20 -0700
Message-ID: <20240807224521.3819189-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240807224521.3819189-1-anthony.l.nguyen@intel.com>
References: <20240807224521.3819189-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Commit ac21add2540e ("ice: Implement driver functionality to dump fec
statistics") introduces obtaining FEC correctable and uncorrectable
stats per netdev in ICE driver. Unfortunately the assignment of values
to fec_stats structure has been done incorrectly. This commit fixes the
assignments.

Fixes: ac21add2540e ("ice: Implement driver functionality to dump fec statistics")
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 8c990c976132..bc79ba974e49 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -4673,10 +4673,10 @@ static int ice_get_port_fec_stats(struct ice_hw *hw, u16 pcs_quad, u16 pcs_port,
 	if (err)
 		return err;
 
-	fec_stats->uncorrectable_blocks.total = (fec_corr_high_val << 16) +
-						 fec_corr_low_val;
-	fec_stats->corrected_blocks.total = (fec_uncorr_high_val << 16) +
-					     fec_uncorr_low_val;
+	fec_stats->corrected_blocks.total = (fec_corr_high_val << 16) +
+					     fec_corr_low_val;
+	fec_stats->uncorrectable_blocks.total = (fec_uncorr_high_val << 16) +
+						 fec_uncorr_low_val;
 	return 0;
 }
 
-- 
2.42.0


