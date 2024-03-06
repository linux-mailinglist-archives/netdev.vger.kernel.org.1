Return-Path: <netdev+bounces-78127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7AE874266
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14C2E1F21FE7
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 22:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7F91BC39;
	Wed,  6 Mar 2024 22:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gVTQ+cJ2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940331B946
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 22:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709762824; cv=none; b=DorafWlINO3RoXfIdrUaFN0+OeZ0btf2j73Spdi8KE9EA0vKeAf6s7icO+Gw4d6+dNlN2oY+YGNxV5mBDMN9HjPiALXHIaaBbVBOJ+Sik9HMb+pq1UruU7pHgmj7Dvhv7TXRD6tjX/pJEFHCXY8ildDy7O7p7e7VCVfhpxHwYlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709762824; c=relaxed/simple;
	bh=UZ7xHpKqeWCru7EaD9Ugm9DrcAaTrDOwoEHrnK98dKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ekCjDG+JLWVe3uknVd4I2tDaS6+SBzPUZQMcRW0Y8H2MgFkadeu7lOSRpVJLH19zvGocAfGJH58qf2MFCrAIsdqksDTBVw+ovu1SF6VicBFhz/tNxce3Xhc+g3nr96bk4F2Hk8Dv0sRz32QkMxor5LRwHIfnk8N1a0MaP1gz72Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gVTQ+cJ2; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709762823; x=1741298823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UZ7xHpKqeWCru7EaD9Ugm9DrcAaTrDOwoEHrnK98dKs=;
  b=gVTQ+cJ2JPTrRxGoGY1WxRpgSZR8kyfQj5n+GhIKM2CTAm7Sh8IbGCQS
   iOnUhP4K/+pEkEUJn81svcLnzlzlyO/Ox5yFLhCYgX1ziz4Xkpsqe/rGJ
   fEHTfo1e9IdlicDCwHbt56t2EdTaYP3Fb+B6A3/FQJk69WqqnewX+OGOT
   B2lyRH5PF90rBxVRmKR/76y746hT5xkx4qMU03iSjV7uuQIc5NoXdgR8S
   nx/Q7Z7QxztnPUiJb2TFeg40PhIiOX0bEBSW0CSE3/vpkyBfgVKIPEI/9
   zXs2U/HGnHH5xJfTTI3DM9insLFqCYsW0+dqLOoGbRnBzPt7t7awxh6aw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4982629"
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="4982629"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 13:56:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="9979674"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 06 Mar 2024 13:56:19 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
	anthony.l.nguyen@intel.com,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 2/3] i40e: remove unnecessary qv_info ptr NULL checks
Date: Wed,  6 Mar 2024 13:56:12 -0800
Message-ID: <20240306215615.970308-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240306215615.970308-1-anthony.l.nguyen@intel.com>
References: <20240306215615.970308-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>

The "qv_info" ptr cannot be NULL when it gets the address of
an element of the flexible array "qvlist_info->qv_info".

Detected using the static analysis tool - Svace.

Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_client.c      | 4 ----
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index 306758428aef..b32071ee84af 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -148,8 +148,6 @@ static void i40e_client_release_qvlist(struct i40e_info *ldev)
 		u32 reg_idx;
 
 		qv_info = &qvlist_info->qv_info[i];
-		if (!qv_info)
-			continue;
 		reg_idx = I40E_PFINT_LNKLSTN(qv_info->v_idx - 1);
 		wr32(&pf->hw, reg_idx, I40E_PFINT_LNKLSTN_FIRSTQ_INDX_MASK);
 	}
@@ -576,8 +574,6 @@ static int i40e_client_setup_qvlist(struct i40e_info *ldev,
 
 	for (i = 0; i < qvlist_info->num_vectors; i++) {
 		qv_info = &qvlist_info->qv_info[i];
-		if (!qv_info)
-			continue;
 		v_idx = qv_info->v_idx;
 
 		/* Validate vector id belongs to this client */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index b34c71770887..83a34e98bdc7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -491,8 +491,6 @@ static void i40e_release_rdma_qvlist(struct i40e_vf *vf)
 		u32 v_idx, reg_idx, reg;
 
 		qv_info = &qvlist_info->qv_info[i];
-		if (!qv_info)
-			continue;
 		v_idx = qv_info->v_idx;
 		if (qv_info->ceq_idx != I40E_QUEUE_INVALID_IDX) {
 			/* Figure out the queue after CEQ and make that the
@@ -562,8 +560,6 @@ i40e_config_rdma_qvlist(struct i40e_vf *vf,
 	msix_vf = pf->hw.func_caps.num_msix_vectors_vf;
 	for (i = 0; i < qvlist_info->num_vectors; i++) {
 		qv_info = &qvlist_info->qv_info[i];
-		if (!qv_info)
-			continue;
 
 		/* Validate vector id belongs to this vf */
 		if (!i40e_vc_isvalid_vector_id(vf, qv_info->v_idx)) {
-- 
2.41.0


