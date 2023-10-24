Return-Path: <netdev+bounces-43828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEF87D4EEB
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 13:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECDD21C20B83
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 11:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1D3266B8;
	Tue, 24 Oct 2023 11:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NuYN9AIi"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83AE262B8
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 11:35:02 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A773DD7A
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 04:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698147302; x=1729683302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9SZ9VIt19nuY75ONe6pBJXwTW3GSNQB+O88Sp7ZJIak=;
  b=NuYN9AIi5d99XPXqeZn7qjA5y2iCddF8rrpaTTPSz+n5cCd8awMbVExf
   My1k0pk13aniQbISDHTEvRbVq9fHSeXhnDkMi/k5FjiKsXI1PN8H8BQnI
   0yv4MZwtm0NI+6hSH0l3ejJ1hHuZUnq0VZguYykpGapPsCWfbh0+MZx7x
   WYNK99WPxoIzpKB9AZh5oeE0TTImLAB75YyUfdImY1xB8fw2vONB/ptUW
   /mvohFY8Ce+BgqyEdLToxLPLTmPDTrd3humyapRkjDrwFXrXYLrJyYVV9
   yA+JnEXBoeJUtM/K3fPJTFa9zB8VlfS3tKzUuSahF4YNDKaaiNv7AAe7m
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="5660551"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="5660551"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 04:35:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="6146143"
Received: from wasp.igk.intel.com ([10.102.20.192])
  by orviesa001.jf.intel.com with ESMTP; 24 Oct 2023 04:33:42 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	piotr.raczynski@intel.com,
	wojciech.drewek@intel.com,
	marcin.szycik@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	jesse.brandeburg@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v1 09/15] ice: return pointer to representor
Date: Tue, 24 Oct 2023 13:09:23 +0200
Message-ID: <20231024110929.19423-10-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024110929.19423-1-michal.swiatkowski@linux.intel.com>
References: <20231024110929.19423-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In follow up patches it will be easier to obtain created port
representor pointer instead of the id. Without it the pattern from
eswitch side will look like:
- create PR
- get PR based on the id

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_repr.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index fce25472d053..b29a3d010780 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -382,7 +382,7 @@ ice_repr_add(struct ice_pf *pf, struct ice_vsi *src_vsi, const u8 *parent_mac)
 	return ERR_PTR(err);
 }
 
-static int ice_repr_add_vf(struct ice_vf *vf)
+static struct ice_repr *ice_repr_add_vf(struct ice_vf *vf)
 {
 	struct ice_repr *repr;
 	struct ice_vsi *vsi;
@@ -390,11 +390,11 @@ static int ice_repr_add_vf(struct ice_vf *vf)
 
 	vsi = ice_get_vf_vsi(vf);
 	if (!vsi)
-		return -EINVAL;
+		return ERR_PTR(-ENOENT);
 
 	err = ice_devlink_create_vf_port(vf);
 	if (err)
-		return err;
+		return ERR_PTR(err);
 
 	repr = ice_repr_add(vf->pf, vsi, vf->hw_lan_addr);
 	if (IS_ERR(repr)) {
@@ -416,13 +416,13 @@ static int ice_repr_add_vf(struct ice_vf *vf)
 
 	ice_virtchnl_set_repr_ops(vf);
 
-	return 0;
+	return repr;
 
 err_netdev:
 	ice_repr_rem(&vf->pf->eswitch.reprs, repr);
 err_repr_add:
 	ice_devlink_destroy_vf_port(vf);
-	return err;
+	return ERR_PTR(err);
 }
 
 /**
@@ -432,6 +432,7 @@ static int ice_repr_add_vf(struct ice_vf *vf)
 int ice_repr_add_for_all_vfs(struct ice_pf *pf)
 {
 	struct devlink *devlink;
+	struct ice_repr *repr;
 	struct ice_vf *vf;
 	unsigned int bkt;
 	int err;
@@ -439,9 +440,11 @@ int ice_repr_add_for_all_vfs(struct ice_pf *pf)
 	lockdep_assert_held(&pf->vfs.table_lock);
 
 	ice_for_each_vf(pf, bkt, vf) {
-		err = ice_repr_add_vf(vf);
-		if (err)
+		repr = ice_repr_add_vf(vf);
+		if (IS_ERR(repr)) {
+			err = PTR_ERR(repr);
 			goto err;
+		}
 	}
 
 	/* only export if ADQ and DCB disabled */
-- 
2.41.0


