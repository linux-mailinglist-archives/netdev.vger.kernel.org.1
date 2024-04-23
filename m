Return-Path: <netdev+bounces-90508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 851278AE52A
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 13:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7CEA1C22206
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 11:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6172983CD1;
	Tue, 23 Apr 2024 11:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NEwT41/G"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A676960DFB
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 11:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872609; cv=none; b=ZxrD4NSPbH6EzrvsDd+6wS7010Uxr1i5L0BGmsEKJg1RhG7MbsuRmC/l6wupFBhmtmOPXg81/T98d4objHwGvXp5qi+Hu91AdO8g/RuU3uFDGA7U7Qog0uqtuxmAY9vu2IhRu/wDNsXfK0WE6ppeKFbKZRvN/9gvByAP0yG/F24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872609; c=relaxed/simple;
	bh=ONUZ6ywtWwqCEpiCcgIoOtRzTRvlPlnxVvq4B2f3fnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gnBZnijU8ugLXVzKh+IJUYvhWwIjzq9agdVAEEesLj6bTFzVMsDsLsdGZAhmvT9zzDRTqcsRCYv3W2FRtm4O4kaHy9IMrcEtR+hRNz4vFPXHulttbub/XK0xIlqwkZX+uaMIVn4kNxriGXm0g0x7dI/ii6+8EIrPv6iVhOuDIhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NEwT41/G; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713872608; x=1745408608;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ONUZ6ywtWwqCEpiCcgIoOtRzTRvlPlnxVvq4B2f3fnw=;
  b=NEwT41/GPbzXQZ5iGM3GRBaL9ZjPfmkwBS/JAjVIYbpBy9m7aUX4FFM9
   mnZKmt2gtv6Qyt3BfZDT7kvaHT5cQp1eSfjcHiNAv+oV1R0Z5jJ4jEp2Y
   0OcdaEa0SrM3SrBRGmoQ5D3vEmuL+LqmKGL2X7dTfVNkRNBXyq+7GHy47
   pX623eK1rrCdLr+Q7GBq5vlbaPuI4U7RthX+BWASzqOJhAWMj4cJjUliw
   glqwrz4y3WuG9qZEJl8m9WJg0Q43+K9WoZrwKhCwdWldGJZeXyIto0vxZ
   tjemlU8kf6JSm5svoN0W7XAS+WuEZWqZ+VKs9+oamEeEEm+Fnq+p4eqYP
   Q==;
X-CSE-ConnectionGUID: NGO3JABETjmuRtoR6B1H6Q==
X-CSE-MsgGUID: Dw8gfSA7TZKE6id9oyp59g==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="13237184"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="13237184"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 04:43:27 -0700
X-CSE-ConnectionGUID: +jPJQrEpRxKQK5zL04mnYA==
X-CSE-MsgGUID: Pu4K9qqjRXy5ZneCNqdR5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="28848199"
Received: from unknown (HELO localhost.igk.intel.com) ([10.91.240.220])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 04:43:25 -0700
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Ngai-Mint Kwan <ngai-mint.kwan@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Subject: [PATCH iwl-net v3] ice: Do not get coalesce settings while in reset
Date: Tue, 23 Apr 2024 13:43:08 +0200
Message-ID: <20240423114308.22962-1-dawid.osuchowski@linux.intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>

Getting coalesce settings while reset is in progress can cause NULL
pointer deference bug.
If under reset, abort get coalesce for ethtool.

Fixes: 67fe64d78c43 ("ice: Implement getting and setting ethtool coalesce")
Signed-off-by: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
---
Changes since v1:
* Added "Fixes:" tag
Changes since v2:
* Rebased over current IWL net branch
* Confirmed that the issue previously reported for this patch [1] by
Himasekhar Reddy Pucha was caused by other, internally tracked issue -
reposting this as an ask for retest as well

[1] https://lore.kernel.org/netdev/BL0PR11MB3122D70ABDE6C2ACEE376073BD90A@BL0PR11MB3122.namprd11.prod.outlook.com/
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 78b833b3e1d7..efdfe46a91ee 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3825,6 +3825,9 @@ __ice_get_coalesce(struct net_device *netdev, struct ethtool_coalesce *ec,
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 	struct ice_vsi *vsi = np->vsi;
 
+	if (ice_is_reset_in_progress(vsi->back->state))
+		return -EBUSY;
+
 	if (q_num < 0)
 		q_num = 0;
 
-- 
2.44.0


