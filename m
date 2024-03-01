Return-Path: <netdev+bounces-76716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE30086E97C
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 20:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2E5DB24B4D
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 19:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACC43B790;
	Fri,  1 Mar 2024 19:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V1+UrC1b"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64193AC19
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 19:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709321162; cv=none; b=dq8lqNv8W20It9SIAvwVU5C0DI0vknpUkRXQZWQ4nOTYg1rdUw9jhTSDMdvM+RHDA7x53S4B7pOd1/E86vrAbPqunF8KlYrS6S7j/HtxJw7DyyFDSV7U34wkElsc6iJ0yCyocLSnGoSbAtMsumXqlk4vhH18RIMpHPzttmt15F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709321162; c=relaxed/simple;
	bh=kAmTi/F30UZBNUkWjv9dTnntFNzBmrrYMpMsTDz0FAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1jhl4fDblQ/L7C8cL9jGAMVQsd6p097I6f4Cb01lEORmIo+NWRkN2SnxTtSQQSmywcOHWxRCXoEB7eSRPDW05gNY691Ic9ytWtWG+QqsNiLLmg8962Wee1MuyQgxq3lpEBIiVYbKBtS+Zoif2wQ8nBD03cKaVDkLvtQSVejeXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V1+UrC1b; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709321160; x=1740857160;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kAmTi/F30UZBNUkWjv9dTnntFNzBmrrYMpMsTDz0FAM=;
  b=V1+UrC1bftaoWo50OfD9cHx10kCs8vmfEsyeKtt+1oygtt8LxZ+E5pRd
   xVoH/cxq+zLM0oeTpWapq0gK/5CdKmTyLydAwMyIpNyYlKGPlGNfn6E6l
   GPOfVTHX7ZeqeLeiKFGtxiPaL8mOvmwRaF7XzQsBeKzIMMs2mcUZwpeD6
   rZHAAuwBTTQGL/saGD3snSS9hnB9pPtpjeQmDzpn/k/60XXOoBbKA0+XG
   zp9k6P7FKfhMwYz5LKnLAuuJKePd3zwSlLhDj0lqQl9SqAF8YyMd4P7FY
   Ll+8ZhgGmJU1/1NbdKnxq6ptZswcQoGzIjH4ZjAnRsTcFghQjxM/0gM6Q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="7694939"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="7694939"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 11:25:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="12998484"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 01 Mar 2024 11:25:57 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 4/4] ice: reconfig host after changing MSI-X on VF
Date: Fri,  1 Mar 2024 11:25:49 -0800
Message-ID: <20240301192549.2993798-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240301192549.2993798-1-anthony.l.nguyen@intel.com>
References: <20240301192549.2993798-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

During VSI reconfiguration filters and VSI config which is set in
ice_vf_init_host_cfg() are lost. Recall the host configuration function
to restore them.

Without this config VF on which MSI-X amount was changed might had a
connection problems.

Fixes: 4d38cb44bd32 ("ice: manage VFs MSI-X using resource tracking")
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index a94a1c48c3de..b0f78c2f2790 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -1068,6 +1068,7 @@ int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count)
 	struct ice_pf *pf = pci_get_drvdata(pdev);
 	u16 prev_msix, prev_queues, queues;
 	bool needs_rebuild = false;
+	struct ice_vsi *vsi;
 	struct ice_vf *vf;
 	int id;
 
@@ -1102,6 +1103,10 @@ int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count)
 	if (!vf)
 		return -ENOENT;
 
+	vsi = ice_get_vf_vsi(vf);
+	if (!vsi)
+		return -ENOENT;
+
 	prev_msix = vf->num_msix;
 	prev_queues = vf->num_vf_qs;
 
@@ -1122,7 +1127,7 @@ int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count)
 	if (vf->first_vector_idx < 0)
 		goto unroll;
 
-	if (ice_vf_reconfig_vsi(vf)) {
+	if (ice_vf_reconfig_vsi(vf) || ice_vf_init_host_cfg(vf, vsi)) {
 		/* Try to rebuild with previous values */
 		needs_rebuild = true;
 		goto unroll;
@@ -1148,8 +1153,10 @@ int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count)
 	if (vf->first_vector_idx < 0)
 		return -EINVAL;
 
-	if (needs_rebuild)
+	if (needs_rebuild) {
 		ice_vf_reconfig_vsi(vf);
+		ice_vf_init_host_cfg(vf, vsi);
+	}
 
 	ice_ena_vf_mappings(vf);
 	ice_put_vf(vf);
-- 
2.41.0


