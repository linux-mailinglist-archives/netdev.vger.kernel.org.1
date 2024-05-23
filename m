Return-Path: <netdev+bounces-97866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F628CD95A
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 19:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BD9BB21093
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 17:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591037E777;
	Thu, 23 May 2024 17:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J2vEK2mR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B057820332
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 17:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716486363; cv=none; b=h0VE2Iijt1GrIQOO+mtP85yAtWP3bnmPihMnf8Eq0Dgkpgqe5Cpu3y407O4K7TgUFOmJd4578+nfZ59mHllUqLSJth3JgrqcbKn2FLqp1WTnO1uh23k+t97ytsHalgK7ZD9Sg3gIJJ6YFyjWkr1pPZITxe7D0SesRXyVGf1OSx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716486363; c=relaxed/simple;
	bh=Fw0Zxn3Kz6xuTGXsyHTAML/SA4AydvJipCNVBJupyNM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jUSIylcYUVBrKMSm1MwBQB0VG1Yh6Hcs3kLi4TN9SVJucMd0EYmGpYxmKrkFSlSbU7RFKitknGmHEEaf4N3+VW/szV1OxbEf6ewqzHxwgPcN6qeRkc6M94Vd0b5or59/W/onmpsqSfDFpTaXZ2OkjUw8XZbvXOg5HXTDgI0UQCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J2vEK2mR; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716486362; x=1748022362;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Fw0Zxn3Kz6xuTGXsyHTAML/SA4AydvJipCNVBJupyNM=;
  b=J2vEK2mRS1AHtsce74XvYTfWGW+QYohQ3jj5AJNos/b2AV8PM5sem1ba
   UkgfAckiAKUSKyT45fFr3OUFYxYm0BEa9PwpImnvHVP2kI4+CWvS1Jagq
   zx1ze4K94Rj02k3fELHQc88ZGSE3YeqrJNyUm0KLl5Wv9ZK0wKQOST1QR
   dCR3d+nhKowonYwFuNDSfji5PlL2cskXMQKIEXUWcw5Nl1yAt01HtLQME
   2GBPiAjuZJqT6ceDiUG2clyIpcyVHvr3MuqmMnirGN2OgDT0KqmeGHdAL
   SmoYQLmni2x4tPB0pGaSLuJhaxUHVFCHp90SaIGC1A1KPUiX+MFIANs3m
   g==;
X-CSE-ConnectionGUID: M1lHZSHkSgm3cs/T0hedmw==
X-CSE-MsgGUID: CkD+sJ8ARMavQyMyD/m/5A==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="12675514"
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="12675514"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 10:46:00 -0700
X-CSE-ConnectionGUID: qUAvPSzIR0qdw0nK2JtezA==
X-CSE-MsgGUID: Zy1jI3TFS6+hUqeTxsfuhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="33719184"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 10:45:59 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 23 May 2024 10:45:30 -0700
Subject: [PATCH net 2/2] ice: fix accounting if a VLAN already exists
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240523-net-2024-05-23-intel-net-fixes-v1-2-17a923e0bb5f@intel.com>
References: <20240523-net-2024-05-23-intel-net-fixes-v1-0-17a923e0bb5f@intel.com>
In-Reply-To: <20240523-net-2024-05-23-intel-net-fixes-v1-0-17a923e0bb5f@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, netdev <netdev@vger.kernel.org>, 
 David Miller <davem@davemloft.net>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
X-Mailer: b4 0.13.0

The ice_vsi_add_vlan() function is used to add a VLAN filter for the target
VSI. This function prepares a filter in the switch table for the given VSI.
If it succeeds, the vsi->num_vlan counter is incremented.

It is not considered an error to add a VLAN which already exists in the
switch table, so the function explicitly checks and ignores -EEXIST. The
vsi->num_vlan counter is still incremented.

This seems incorrect, as it means we can double-count in the case where the
same VLAN is added twice by the caller. The actual table will have one less
filter than the count.

The ice_vsi_del_vlan() function similarly checks and handles the -ENOENT
condition for when deleting a filter that doesn't exist. This flow only
decrements the vsi->num_vlan if it actually deleted a filter.

The vsi->num_vlan counter is used only in a few places, primarily related
to tracking the number of non-zero VLANs. If the vsi->num_vlans gets out of
sync, then ice_vsi_num_non_zero_vlans() will incorrectly report more VLANs
than are present, and ice_vsi_has_non_zero_vlans() could return true
potentially in cases where there are only VLAN 0 filters left.

Fix this by only incrementing the vsi->num_vlan in the case where we
actually added an entry, and not in the case where the entry already
existed.

Fixes: a1ffafb0b4a4 ("ice: Support configuring the device to Double VLAN Mode")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c b/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c
index 2e9ad27cb9d1..6e8f2aab6080 100644
--- a/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c
@@ -45,14 +45,15 @@ int ice_vsi_add_vlan(struct ice_vsi *vsi, struct ice_vlan *vlan)
 		return -EINVAL;
 
 	err = ice_fltr_add_vlan(vsi, vlan);
-	if (err && err != -EEXIST) {
+	if (!err)
+		vsi->num_vlan++;
+	else if (err == -EEXIST)
+		err = 0;
+	else
 		dev_err(ice_pf_to_dev(vsi->back), "Failure Adding VLAN %d on VSI %i, status %d\n",
 			vlan->vid, vsi->vsi_num, err);
-		return err;
-	}
 
-	vsi->num_vlan++;
-	return 0;
+	return err;
 }
 
 /**

-- 
2.44.0.53.g0f9d4d28b7e6


