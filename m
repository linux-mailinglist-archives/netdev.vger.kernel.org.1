Return-Path: <netdev+bounces-76529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF1A86E0AA
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 12:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65A7D28302B
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 11:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3246CDD0;
	Fri,  1 Mar 2024 11:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BG8tjI72"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BCD6BFC6
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 11:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709293807; cv=none; b=MghP2CiAgvuylOvy3Fz/Y0MhGCPW57WZ4ZfQoCNsi/Uyuf8KDvUaPn0N/BvujwretzCBSoMlrMVk40OS/D0fcHQrH86/UV8CHHItk3fl0XuUMoRVj7xrCCnDfRvjx1H3wCYVv2a/BBefJJtGXgBCRoZTrVTYI1Hq1kM5Yz8osVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709293807; c=relaxed/simple;
	bh=PNyrbCjywjNlIXYg5ByVAotjsH2kxGncIfNEMqdut3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HmAQstIwf6dPfMcYlpTv+95OlSxmIOjD5ZTb1u7F/QQgQfAV/BJNwH1wp97tpv1LBhQxQGiIign4FFwNX6ezSpkOLwqhpR/b+J1Rnpv2BVTfiTGZpCWR3T+RJxNdfZRTAH6us6YqmH66tOzbUVJtqBUYn59l8VGGwmxytDU5vj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BG8tjI72; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709293806; x=1740829806;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PNyrbCjywjNlIXYg5ByVAotjsH2kxGncIfNEMqdut3Q=;
  b=BG8tjI72HlzYS79G7mVpu+0buKPvr1LpKoKMcAughfEg1JbeP1aH3+0x
   8n4+1ngBt0TE+0/fUqVblb5Be4QzCrY/GhTrQPX3kEe+wI+JNmsEj0deM
   7/7p0YEvWKgqaeopE18WDaI6+b9Mq1/7Cjm6LZQH9HEfFHy6DXrfA4Xul
   sOA+DkG6+LFrm+XH8tu6ggGTpjoBjNUO76IBn0L1yxrf+7CCJ9GtN/LeL
   uCcSFhBIXYkwWxoZC2T1NvUbUemiLzCOz0Pk+lK+1pDKV1tpZbVi0Mm6u
   cBfcFr6rzvBzuxsTKgkMUqE9EqckkT1fPD0yxKkojX50Q2TyqJSySkNwH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="4000074"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="4000074"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 03:50:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="39195084"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by fmviesa001.fm.intel.com with ESMTP; 01 Mar 2024 03:50:02 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	marcin.szycik@intel.com,
	wojciech.drewek@intel.com,
	sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	sujai.buvaneswaran@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [iwl-next v3 6/8] ice: change repr::id values
Date: Fri,  1 Mar 2024 12:54:12 +0100
Message-ID: <20240301115414.502097-7-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240301115414.502097-1-michal.swiatkowski@linux.intel.com>
References: <20240301115414.502097-1-michal.swiatkowski@linux.intel.com>
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


