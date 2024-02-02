Return-Path: <netdev+bounces-68546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFF684725B
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 15:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAB36292BFF
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 14:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46073145B19;
	Fri,  2 Feb 2024 14:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MmETG366"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BE4145B2F
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 14:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706885751; cv=none; b=XdJpBACuyRwhVkG1q0oC7jy8zxwaxIt8ItpeGU/nIwaO0n5fKP8Hu5vGH2CnEV5A8SnMJpAWz6aUhjIlJr/nKqv/rXS3eV0iorQ9oiHicNsDe0vrYlWajNkfggl0GGiB00B8D6Hcx9esPo2sM+ZMoKS7CTatGJro044gPB003PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706885751; c=relaxed/simple;
	bh=PNyrbCjywjNlIXYg5ByVAotjsH2kxGncIfNEMqdut3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNXY6WqQbVLnwlVvu2qq6ggKXvuBsV7oVYf3gawFT/ukbWh9SGQryAVceyumSfxJ4rJhIltg9Iwq5PuIziNorVjU3SmqLPYB/ORo4f9DcZYrjE7pjGbLss6vC1CcBJE5kXwwihlNkBaAcEqAUXM9Vq9Qpio2/l+jIDSRqclgPJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MmETG366; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706885750; x=1738421750;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PNyrbCjywjNlIXYg5ByVAotjsH2kxGncIfNEMqdut3Q=;
  b=MmETG366/LKGbchinXkL4f2e9ThUqSx4rnT1ENXKEphL11G5XAqkwmZz
   bBvnsrqdrGpI4H2cQl+38zCQaCzwSWcXx1T+DuJ2dse6kBlCELkf+yRqe
   jBapIWjUwus3aWxTpxVSjB1q7K/oEHd58eaPSheCtj/Qtwy/NQrxcCULS
   PPjpvSDhXfmRGzdztXIbhLVEyj6TGhqHIQQGq9HwvR6kSLYNh9O5lUNrO
   YVN1OiRo6K9wYs94rqIwHQMubnFrynBUgDaPeDVYUFF4IKmY0zcs2tDIP
   AwOYTMwhT/hlpYGdxBM2Ua0R86BhkRPxNSJkMRfqZMGXJ7lzZV3ctZHel
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="10823042"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="10823042"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 06:55:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="98474"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by orviesa009.jf.intel.com with ESMTP; 02 Feb 2024 06:55:34 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	marcin.szycik@intel.com,
	wojciech.drewek@intel.com,
	sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [iwl-next v2 6/8] ice: change repr::id values
Date: Fri,  2 Feb 2024 15:59:26 +0100
Message-ID: <20240202145929.12444-7-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240202145929.12444-1-michal.swiatkowski@linux.intel.com>
References: <20240202145929.12444-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of getting repr::id from xa_alloc() value, set it to the
src_vsi::num_vsi value. It is unique for each PR.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 5 ++---
 drivers/net/ethernet/intel/ice/ice_repr.c    | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 76fa114f22c9..5eba8dec9f94 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -319,7 +319,7 @@ ice_eswitch_mode_set(struct devlink *devlink, u16 mode,
 
 		dev_info(ice_pf_to_dev(pf), "PF %d changed eswitch mode to switchdev",
 			 pf->hw.pf_id);
-		xa_init_flags(&pf->eswitch.reprs, XA_FLAGS_ALLOC);
+		xa_init(&pf->eswitch.reprs);
 		NL_SET_ERR_MSG_MOD(extack, "Changed eswitch mode to switchdev");
 		break;
 	}
@@ -426,8 +426,7 @@ ice_eswitch_attach(struct ice_pf *pf, struct ice_vf *vf)
 	if (err)
 		goto err_setup_repr;
 
-	err = xa_alloc(&pf->eswitch.reprs, &repr->id, repr,
-		       XA_LIMIT(1, INT_MAX), GFP_KERNEL);
+	err = xa_insert(&pf->eswitch.reprs, repr->id, repr, GFP_KERNEL);
 	if (err)
 		goto err_xa_alloc;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index a5c24da31b88..b4fb74271811 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -345,6 +345,7 @@ ice_repr_add(struct ice_pf *pf, struct ice_vsi *src_vsi, const u8 *parent_mac)
 	}
 
 	repr->src_vsi = src_vsi;
+	repr->id = src_vsi->vsi_num;
 	np = netdev_priv(repr->netdev);
 	np->repr = repr;
 
-- 
2.42.0


