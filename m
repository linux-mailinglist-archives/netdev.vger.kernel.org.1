Return-Path: <netdev+bounces-74272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4696A860AD8
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 07:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F26BC286EC2
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 06:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F0B12B8F;
	Fri, 23 Feb 2024 06:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ISW+/t2d"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C80011CB2
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 06:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708670168; cv=none; b=YDdwbZzx8k0A4nRR3dvehBxKXjNsfB9gzffpeP1RcWPYeRidrB7sJGhXlwBSn63bwqRSl9iYi4h2geN2yI9l7CvBGFncEbFq1RtnBKVFIL3sSLDR0xqhMZWfrl9RI/HveaMZ4OYddOS9MEP6YGja3ERcagvIm0RotSjllm1GezU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708670168; c=relaxed/simple;
	bh=8yoLYxtyzN8QrGJBXGLzekHVHNTotxFsod80L/xnUPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N3yvlYKy/OutFuaxaahyfZgmFoPglK2p0i8H+QvfVLz9SZd8uLgz54FZFOa999lY/gsQyOQ5GAGKq/42yNDVco3X0C1081Spdg4ZgVFYuIiRcbnxTKu3JSrsoVJ0mSM+wQV+eI8nmCquM/0ecWazGpsqFB00RpAgZxYjUJlRplE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ISW+/t2d; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708670166; x=1740206166;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8yoLYxtyzN8QrGJBXGLzekHVHNTotxFsod80L/xnUPE=;
  b=ISW+/t2d4U6+n7cJG5iMAaCUXbcE3rPVXJ9geRS5e3MsGC1P2FLTWmAo
   3X6rWjYLG3TxCKGemt8oyFWNtvq/TfFEUIDt8d2IbI1KoLU0Ln6zMITta
   w66kCCLEcLO+SV0rrAi/eJ+7BysaYEXMj6qCdNoQavV2NS2fUe72/HMSB
   mk3uV0nZrO6EIACn/Z7XZFWXAf3GqfagHKqdPZ9/Fmbt6+cEcKHtuw5XO
   iiOFMiG5Dixf5FxcfvOCP0FA+LTApLZMhhLZxqoBy4/ifX2eqzH+IixjW
   MkBVgrUWeOjqV04jYsQKiDheK9CSbLzrseSmc0d5fPFHHiWpTAVY+f7r+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="20409282"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="20409282"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 22:36:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5950697"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by fmviesa008.fm.intel.com with ESMTP; 22 Feb 2024 22:36:04 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [iwl-net v1] ice: reconfig host after changing MSI-X on VF
Date: Fri, 23 Feb 2024 07:40:24 +0100
Message-ID: <20240223064024.4333-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During VSI reconfiguration filters and VSI config which is set in
ice_vf_init_host_cfg() are lost. Recall the host configuration function
to restore them.

Without this config VF on which MSI-X amount was changed might had a
connection problems.

Fixes: 4d38cb44bd32 ("ice: manage VFs MSI-X using resource tracking")
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
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
2.42.0


