Return-Path: <netdev+bounces-87149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D3D8A1E00
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 20:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C43828E7C8
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 18:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6780E1292FC;
	Thu, 11 Apr 2024 17:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IDM/gCPt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAF3126F32
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 17:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712857141; cv=none; b=KPSQSG9sApHsdhaaIIA4Gps1ByUFGC5BfMRoj6kQTd9F7Yo8EJvXI3QG9PbWSLj7EOTTMWSTvQf5SUGziqr12PexyVWqyBBA4kyc6gdtVfw5GlnkCmMsgMxUc9WLycZnn4L/clOJf2dHqsCoGh5pfs+VGqrRfC6vbYkPJcSQEP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712857141; c=relaxed/simple;
	bh=VA+eRgoi/XMJy0HQp2U0nPjRgnKtFmvZM3LQB/KVYrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GG9YuOIjP9zIjL5GRh+fKRE2qbf8V9mwSwlgvrLHW2oGC4ro9M8taaLlLeAIRP9aQ7eh2lCqfoSl2PLOWb5RVq0BuPQXlZGLm2Ofe2KMeEN/eVg+3JQKJsYrBF1E48ySLogwmQpDjZ389kbWhOJEwnhiuPevVhS7AVt63/WXS6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IDM/gCPt; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712857140; x=1744393140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VA+eRgoi/XMJy0HQp2U0nPjRgnKtFmvZM3LQB/KVYrk=;
  b=IDM/gCPtZ8xt4J/6eIkcEpVLowdoqvqSvoALMQ9H46xi2OZO/xj6u/t1
   sjtCLYMAj+M5wX7cZf2l9tostjYECORv2gLq2SCpzZtmkwx6d+sj3Lyqz
   /QgfWtmG9N/afJcgl6iOntX43WIldVjJkz8LuNhm9sOANb1J8ZTtr3y4M
   pZNIYguKhWwNk4/4g7NwwVK8B9pjQs5ai0JTjNg6mxkfvGIRh4WRDKP4W
   Kj0hBJb/64Shwv2aPtv01jo4OsptkeE/Dv8ZyluDnsTKQsRtN4+MB3X9s
   jxRvOf1Uz8rTWNMTOMxJ+tU84gp3p2eCfVkrUoX77xIOCKniRFXBUkQ4E
   A==;
X-CSE-ConnectionGUID: ErxldQf7SH6V/NwH3nG+qQ==
X-CSE-MsgGUID: GBMz3dPhQ+iKi+9ljk2nAA==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="11252963"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="11252963"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 10:38:58 -0700
X-CSE-ConnectionGUID: m+/3YeaBSUGQWFinkB6Pew==
X-CSE-MsgGUID: yBaPcgmKSuOZDlWBAcptEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="20949114"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 11 Apr 2024 10:38:57 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 3/4] ice: set vf->num_msix in ice_initialize_vf_entry()
Date: Thu, 11 Apr 2024 10:38:43 -0700
Message-ID: <20240411173846.157007-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240411173846.157007-1-anthony.l.nguyen@intel.com>
References: <20240411173846.157007-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

Commit fe1c5ca2fe76 ("ice: implement num_msix field per VF") updated the
driver to allow for per-VF MSI-X configuration. The initial defaults were
set in ice_create_vf_entries(). This logic is better placed in
ice_initialize_vf_entry(). Indeed, that function already sets
vf->num_vf_qs, as well as initializes the allow list via calling
ice_vc_set_default_allowlist().

Move this logic into ice_initialize_vf_entry(). This makes the code clear,
and ensures that these VF fields will be initialized properly for both
SR-IOV VFs and the upcoming Scalable IOV VFs.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c  | 5 -----
 drivers/net/ethernet/intel/ice/ice_vf_lib.c | 5 ++++-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 65e1986af777..5e9521876617 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -831,11 +831,6 @@ static int ice_create_vf_entries(struct ice_pf *pf, u16 num_vfs)
 
 		pci_dev_get(vfdev);
 
-		/* set default number of MSI-X */
-		vf->num_msix = pf->vfs.num_msix_per;
-		vf->num_vf_qs = pf->vfs.num_qps_per;
-		ice_vc_set_default_allowlist(vf);
-
 		hash_add_rcu(vfs->table, &vf->entry, vf_id);
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index 21d26e19338a..c51e2482cad2 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -992,10 +992,13 @@ void ice_initialize_vf_entry(struct ice_vf *vf)
 
 	/* assign default capabilities */
 	vf->spoofchk = true;
-	vf->num_vf_qs = vfs->num_qps_per;
 	ice_vc_set_default_allowlist(vf);
 	ice_virtchnl_set_dflt_ops(vf);
 
+	/* set default number of MSI-X */
+	vf->num_msix = vfs->num_msix_per;
+	vf->num_vf_qs = vfs->num_qps_per;
+
 	/* ctrl_vsi_idx will be set to a valid value only when iAVF
 	 * creates its first fdir rule.
 	 */
-- 
2.41.0


