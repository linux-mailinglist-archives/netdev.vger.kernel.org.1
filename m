Return-Path: <netdev+bounces-87542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 949CB8A3785
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 23:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 509EE284257
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 21:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249BA15099F;
	Fri, 12 Apr 2024 21:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JtXTpa6p"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790CA14BF9B
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 21:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712955946; cv=none; b=fxswDaKFPNoF6SJiU5zvkXwiCgsRsEZSqSmTi1EpP/qQEoV//8irasruMEXkphxQCzQYFc/low7Aw5mQvsk13RCZ4akL89iZe0EXqv455DUJapOWedMKVOgNEUXd3O6PdDHGGUmvRGr+n+S4kUe8JuqF45EC/S+jga55lXn1+Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712955946; c=relaxed/simple;
	bh=VA+eRgoi/XMJy0HQp2U0nPjRgnKtFmvZM3LQB/KVYrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aqvuy/tVjaFsGvExH2NKuGzC6QZKUcR/dD/77o5WdeNqBrefk3C9hj5d+nNB9GU01fJ3EvYhEiHgPq2gEPibIDsbeZQ1PY2N/3Y8NCp396zwdQdyZX2ohytuEAK0e8cve5Qa8Ovr6E2cdSpnh54eeDRs1wDsJS2bAlk3wA0t9fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JtXTpa6p; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712955944; x=1744491944;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VA+eRgoi/XMJy0HQp2U0nPjRgnKtFmvZM3LQB/KVYrk=;
  b=JtXTpa6pX8dFNMQ6irBT+nEpSGblOozYltVyR/7wzv90PQDoCCTN8iwx
   CZdMtMYuriLMRx2SKyrb5hqVP/JLnVeBHAi8Lah//3ma1CwqE4RQFV6kS
   oJWp/6OQ//shRPD/YhHdSFy8AquhDyRWhrlUIFAYiqUSKyUH8OiAHDov+
   SklHPV33xVtg7qhG2Lv5mpXw8/JU2kgrNo9vL5N4UbmakQJ8DaoYSgkvD
   15ILgV+/mEahn+3t3PKFdfxYKmX7F7UYbuVSvcUjHk+oyIq40Ovpj5jpT
   +B31OIppdh+2myeDRGP/zwuqWE1mZbxWONx0YN0+eQP8z/KxO+LAYSLvF
   A==;
X-CSE-ConnectionGUID: p7b9CYiIT0ScM13mcw2lig==
X-CSE-MsgGUID: FoagYTEqSYCqtnfQygz3xg==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="19575229"
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="19575229"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 14:05:42 -0700
X-CSE-ConnectionGUID: iAYaThOQRqeNxSxnCRhgNQ==
X-CSE-MsgGUID: NtgCFarHRWmOqOS1pcSp+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="21836891"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 12 Apr 2024 14:05:42 -0700
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
Subject: [PATCH net-next v2 3/4] ice: set vf->num_msix in ice_initialize_vf_entry()
Date: Fri, 12 Apr 2024 14:05:32 -0700
Message-ID: <20240412210534.916756-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240412210534.916756-1-anthony.l.nguyen@intel.com>
References: <20240412210534.916756-1-anthony.l.nguyen@intel.com>
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


