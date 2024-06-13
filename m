Return-Path: <netdev+bounces-103300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CFF907772
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 17:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C81F1C24B4D
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 15:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E48014B949;
	Thu, 13 Jun 2024 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H69YgYY/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6207146588
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 15:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718293525; cv=none; b=BvUZA916kQC6OIUPg15K8+LccgCy+1caWsJMn5VieRW+Ck2+DEtbffaCkCCCjVRiEZh84l/8U4xSb3y/3PBERmJ0j3c12gsvGK9vej7CYL4N17ircvznJhVX/BJKTHCisZYhRQcgW9eWaBfyuUog0wIb69xToogZLrK8mXVQ3eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718293525; c=relaxed/simple;
	bh=cdci/UIHnxyuQxXe4uC5r8TNaiA1AXhAkgJObHOgHx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGo85VmntNkrS2GLTyh4SAEY7arOdv/YhEBjzP+fQgJgI1STXN5t6RrWShUk+cRnXQFaFngZmzAh2Eiboq2pY9B9mInxBqqR34OxCR3VUAcMFDgwG4QeBvGjx6JPTi48+C5Xc91DcVAcVlQXoxL22d3bmU3y26bC1zqe1Ww0ZbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H69YgYY/; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718293523; x=1749829523;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cdci/UIHnxyuQxXe4uC5r8TNaiA1AXhAkgJObHOgHx0=;
  b=H69YgYY/P9Hj3vFEqWuoZVlGw3OxpsLR4uPNNGkzVrhw0SboL9Ilh1S5
   vNUlzAq+42VPF0n7cDWiei4ICVWk59Bi63pxeM54+mEUBrVSkyJ1F21HK
   tLEzfLa23Jr0glom1HITzqTbpoltReaBrtu8qf83k6lcJmmAAta88Metm
   2iKREGYhNlf2mcYdYhUBHD36KpNg20t19spBxsf3nWwlDeTD9nyehgJNZ
   pv/HHCroI4ZwvbXJWex9c0YH0Wnzysz3FqBz3xgqd6Xg1I7BELLNFhiy3
   V3b04q2IeClh4qejp8IEc9IwdZf7+nOhLzk9HRwcO+YszGCTkPrk/9rGX
   A==;
X-CSE-ConnectionGUID: vD+gjsfMTzC+664vRtZi7g==
X-CSE-MsgGUID: cnyZ6TBOSCGlRqiDPW4DtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="37645759"
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="37645759"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 08:45:21 -0700
X-CSE-ConnectionGUID: 2l5vtxseQte4FiriGXwvHw==
X-CSE-MsgGUID: S45v37sNQW2hrCug702H9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="40124489"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 13 Jun 2024 08:45:21 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: En-Wei Wu <en-wei.wu@canonical.com>,
	anthony.l.nguyen@intel.com,
	david.m.ertman@intel.com,
	shiraz.saleem@intel.com,
	Cyrus Lien <cyrus.lien@canonical.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net v2 1/3] ice: avoid IRQ collision to fix init failure on ACPI S3 resume
Date: Thu, 13 Jun 2024 08:45:08 -0700
Message-ID: <20240613154514.1948785-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240613154514.1948785-1-anthony.l.nguyen@intel.com>
References: <20240613154514.1948785-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: En-Wei Wu <en-wei.wu@canonical.com>

A bug in https://bugzilla.kernel.org/show_bug.cgi?id=218906 describes
that irdma would break and report hardware initialization failed after
suspend/resume with Intel E810 NIC (tested on 6.9.0-rc5).

The problem is caused due to the collision between the irq numbers
requested in irdma and the irq numbers requested in other drivers
after suspend/resume.

The irq numbers used by irdma are derived from ice's ice_pf->msix_entries
which stores mappings between MSI-X index and Linux interrupt number.
It's supposed to be cleaned up when suspend and rebuilt in resume but
it's not, causing irdma using the old irq numbers stored in the old
ice_pf->msix_entries to request_irq() when resume. And eventually
collide with other drivers.

This patch fixes this problem. On suspend, we call ice_deinit_rdma() to
clean up the ice_pf->msix_entries (and free the MSI-X vectors used by
irdma if we've dynamically allocated them). On resume, we call
ice_init_rdma() to rebuild the ice_pf->msix_entries (and allocate the
MSI-X vectors if we would like to dynamically allocate them).

Fixes: f9f5301e7e2d ("ice: Register auxiliary device to provide RDMA")
Tested-by: Cyrus Lien <cyrus.lien@canonical.com>
Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 1b61ca3a6eb6..45d850514f4c 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5564,7 +5564,7 @@ static int ice_suspend(struct device *dev)
 	 */
 	disabled = ice_service_task_stop(pf);
 
-	ice_unplug_aux_dev(pf);
+	ice_deinit_rdma(pf);
 
 	/* Already suspended?, then there is nothing to do */
 	if (test_and_set_bit(ICE_SUSPENDED, pf->state)) {
@@ -5644,6 +5644,11 @@ static int ice_resume(struct device *dev)
 	if (ret)
 		dev_err(dev, "Cannot restore interrupt scheme: %d\n", ret);
 
+	ret = ice_init_rdma(pf);
+	if (ret)
+		dev_err(dev, "Reinitialize RDMA during resume failed: %d\n",
+			ret);
+
 	clear_bit(ICE_DOWN, pf->state);
 	/* Now perform PF reset and rebuild */
 	reset_type = ICE_RESET_PFR;
-- 
2.41.0


