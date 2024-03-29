Return-Path: <netdev+bounces-83415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4BB892323
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 19:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEE301C20E14
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 18:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6331327ED;
	Fri, 29 Mar 2024 18:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e0Xduiym"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C553533CC4
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 18:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711735604; cv=none; b=OKJabklI69EdABTAutjb7dFeMRl3BvbSULe2/PqRpBFCRQHoBx76QF28EHEQxSrKN2KjILqTWro34Bdgon3TH/2AXYrCjwWK7fxKjQ+xBCBA0hxVgWn6+qg7z4BmXWZvr/1faO2GU4i6JwwU5RlIzcAuOZkZ5ddK+4GGIngFPGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711735604; c=relaxed/simple;
	bh=0Ctkc+RGXBQT6208+acgxNUi0VdYj+MIkSItUaKZE5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s+aCOs8IbXTD+o9GtG7ltUiDT++x+LJwiRK0CwkAx1WU21vRPHZYuiwS5tsmbHvCaTbUOze604Il8YSziWJypnzF7ksXireCEMKFYZ3P+efhCO667cXqjIonq0YtD3ERAyrdlzQO9Tsgq2qroqpT0AAaQQgnTgzokMvideW4I2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e0Xduiym; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711735603; x=1743271603;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0Ctkc+RGXBQT6208+acgxNUi0VdYj+MIkSItUaKZE5Q=;
  b=e0XduiymtbbVX/hb+I60Fgz18iDxVH5yGGdN8sgOLQF/jUW8klpSe7wU
   k1+Oz9Baf9Ee40BxMFlSMlfcP5ceV2y1Dzj2AuPFM6o+OPhq3Rk8/qvlq
   X/4YcAWtU36IOLux5zCbZUFxB/V8EVIV7qtQidsaN0CjVNxvk8KUHUfSr
   vi8mtzZiG8xN1bWmSNjm2eAo22z9BzRByxzq3bOV6ZUp6rCmCx+156j2J
   GTWSZtVxPE7+ONXbzfhc39rNEdGojsXOGX/4b0UG7m6CprcmdjJiU6Hoq
   RFcAqer82uDJfDxp0MkuYH3X87P3qJi32uImcGscOkA2QKXo40Hi+qT42
   Q==;
X-CSE-ConnectionGUID: IpO55iGRQ4uItyJ3WXQQmw==
X-CSE-MsgGUID: lKYJHe7nRG6btywCrwGxeA==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="6826713"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="6826713"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 11:06:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="17447159"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 29 Mar 2024 11:06:41 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net] i40e: Fix VF MAC filter removal
Date: Fri, 29 Mar 2024 11:06:37 -0700
Message-ID: <20240329180638.211412-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ivan Vecera <ivecera@redhat.com>

Commit 73d9629e1c8c ("i40e: Do not allow untrusted VF to remove
administratively set MAC") fixed an issue where untrusted VF was
allowed to remove its own MAC address although this was assigned
administratively from PF. Unfortunately the introduced check
is wrong because it causes that MAC filters for other MAC addresses
including multi-cast ones are not removed.

<snip>
	if (ether_addr_equal(addr, vf->default_lan_addr.addr) &&
	    i40e_can_vf_change_mac(vf))
		was_unimac_deleted = true;
	else
		continue;

	if (i40e_del_mac_filter(vsi, al->list[i].addr)) {
	...
</snip>

The else path with `continue` effectively skips any MAC filter
removal except one for primary MAC addr when VF is allowed to do so.
Fix the check condition so the `continue` is only done for primary
MAC address.

Fixes: 73d9629e1c8c ("i40e: Do not allow untrusted VF to remove administratively set MAC")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 83a34e98bdc7..4efcee7e6feb 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -3139,11 +3139,12 @@ static int i40e_vc_del_mac_addr_msg(struct i40e_vf *vf, u8 *msg)
 		/* Allow to delete VF primary MAC only if it was not set
 		 * administratively by PF or if VF is trusted.
 		 */
-		if (ether_addr_equal(addr, vf->default_lan_addr.addr) &&
-		    i40e_can_vf_change_mac(vf))
-			was_unimac_deleted = true;
-		else
-			continue;
+		if (ether_addr_equal(addr, vf->default_lan_addr.addr)) {
+			if (i40e_can_vf_change_mac(vf))
+				was_unimac_deleted = true;
+			else
+				continue;
+		}
 
 		if (i40e_del_mac_filter(vsi, al->list[i].addr)) {
 			ret = -EINVAL;
-- 
2.41.0


