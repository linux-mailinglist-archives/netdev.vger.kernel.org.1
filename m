Return-Path: <netdev+bounces-92585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3898B7F88
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 20:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E39271F23A2B
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 18:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8ED179650;
	Tue, 30 Apr 2024 18:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nFXiW8GC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2A51527A8
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 18:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714500882; cv=none; b=umNLEs5nsPNgQ7NzTNnhE8q4tilTO8Ba9fChSrdMUIw1i/Cu51D5eANmQcyI6+O3lx538rVq/yK0rSatr1LiUI5qAhLdBvTY2eJ6xBGT3n69jKR3W1iqNntT1X1Ew0cHTLq+QZyc7uLzhXopW/lulz4/zlS6mqYntwc20+5Noq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714500882; c=relaxed/simple;
	bh=stTl1O8ZTdphmlHp//lcSAE3ur1Wh1V0/CFltudRVm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N9KQzyvKB+hn6y0sfyOL01n/Rb14xuGH98DhqR1fV53lBficwvUjz2IZc7BlvEl7Q29L5YMWWjVX/BHje/hT0Vywtl8TQRfM7hBviV82Q9WnI3/MZmxklbqIy9Z7zf2Vr1bv/7KUIOgH1BhicjqN9uu+qhkgvTGC/iGtDpZdJ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nFXiW8GC; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714500881; x=1746036881;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=stTl1O8ZTdphmlHp//lcSAE3ur1Wh1V0/CFltudRVm0=;
  b=nFXiW8GCxHYcJM4PqFHT0AfccWOabz8TeuR7Qg9l0gXFit8Vy7l/nxnX
   stsc8GTXSAfTP5zlkWE2KfpI26Nuw6xF2RwFwCHLNvXp0R+vMCwFKCyQE
   7kLg5M/WNppHWP8N6eCQOeq/s+wkj6rFk+LnlYUPlRPoddXG6Sm5J1f2K
   4fzchOV9k5XFBTJSy0G9I3sZ/j3zJFdfPNV+cRqsEfuhXiGhdTtZ0mrbm
   gIQe9Z0X51mmXDwri2zjF2FycqEjvgLr7iMLIhkHJ7+5EsU+If8nZLr2N
   3hW4H7BbGUQmDvaVqqIQIchwc44xknnQYLR9OkPyHd7cswjOMLdUvstGu
   g==;
X-CSE-ConnectionGUID: o3kkUz4sRzevZM7BDL/5kA==
X-CSE-MsgGUID: SyDnxePjSQOuzRU5eCe0zQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="20840379"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="20840379"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 11:14:40 -0700
X-CSE-ConnectionGUID: pJxGr9ivTu+iTG5mVJWFcw==
X-CSE-MsgGUID: 6qfNBnJGSbiB7Br2G9fojg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="31149077"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 30 Apr 2024 11:14:39 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>,
	anthony.l.nguyen@intel.com,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net] ice: Do not get coalesce settings while in reset
Date: Tue, 30 Apr 2024 11:14:32 -0700
Message-ID: <20240430181434.1942751-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
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
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
2.41.0


