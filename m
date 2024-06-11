Return-Path: <netdev+bounces-102678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD669043D9
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 20:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C4F61C24E24
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 18:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F3774E2E;
	Tue, 11 Jun 2024 18:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HOqRgn5y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C148A57CB5
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 18:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718131370; cv=none; b=At4s1pxJTOhVoiLGiHl+eIUrd+iS+t6k8AghBfT9MpKojDOdC6FE3ugiGlUCOsgei1Tpf6W/aeqLi7uHfgrkcEtMHq4v6kOVQsmZVYn1kDhkjSc0isXSiJYv3uVoFfJnxfRcn/PXFw54H5o0B0vkAyDccov4LS8fj//B4mvUSCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718131370; c=relaxed/simple;
	bh=cdci/UIHnxyuQxXe4uC5r8TNaiA1AXhAkgJObHOgHx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBnNQt50qeqLsDtrMx1cV8qHIsmeeohbiyd17r9n+rWgrDiv8tbtSQ/jdyPuwWMwZzM9RHVVOnHHK0k0ax2R1/6NJks+r+F/Hcm2+NBVMRk7+RI+It9nfeGQEEs+hdg4by8fVBpW+27BPV+ujLIp5s5PcznODlj7iV1pzjxDCrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HOqRgn5y; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718131369; x=1749667369;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cdci/UIHnxyuQxXe4uC5r8TNaiA1AXhAkgJObHOgHx0=;
  b=HOqRgn5ylcp+yOqxsdA4N+kffRr9gBivb0prM/CqEeUParjIyrMqN19Y
   L51LNgAQPbML5ZIZEbqTaYzCQS/tyII0X72A6J6csNnq+aP6TJk+7YiDv
   /Pm7R7n8Omsq9/Gr2BF6qoKCM7jD0a7ca9FvvMMcsh3G2fwhldXk26s8O
   b7j87OT6jGr2aRfm29IojoVcHfRGc2p01UFfuBP7J9T6LjHBq5TNa2Qpw
   JGdbj0PjKnqT2kRxvDnUtsn72bwWgCU2q9/YcntrCkyt+7E3Vk13L9Xs9
   oOUZZ+XzOB2KL8oa04Gn5fl3FHsRBCLvO03iCYmDHdsNcD1hKJzBpfEqn
   g==;
X-CSE-ConnectionGUID: Oj8zziaISd+9QpNiyIxrjQ==
X-CSE-MsgGUID: crGP+0ZvQc6XHixVBHpeGQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="12025544"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="12025544"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 11:42:47 -0700
X-CSE-ConnectionGUID: YE4Rwdr9T+a98QVk8DQ3GA==
X-CSE-MsgGUID: nZDG+s+nQz+3jfZ9qyyX+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="39592495"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 11 Jun 2024 11:42:47 -0700
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
Subject: [PATCH net 2/4] ice: avoid IRQ collision to fix init failure on ACPI S3 resume
Date: Tue, 11 Jun 2024 11:42:36 -0700
Message-ID: <20240611184239.1518418-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240611184239.1518418-1-anthony.l.nguyen@intel.com>
References: <20240611184239.1518418-1-anthony.l.nguyen@intel.com>
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


