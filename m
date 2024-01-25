Return-Path: <netdev+bounces-65884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6CB83C2CE
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 13:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F0BA1C22407
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 12:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D0A4F893;
	Thu, 25 Jan 2024 12:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HnqNFccU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41B64F219
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 12:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706186965; cv=none; b=T/nKN5YXn59kABsLLbGxmk5XupQaqTXKF2v1iBquiAzqUEgPHvvVMkJ3MpeKktTeuoYfDHqOEX2gFuE7sqCvocjohGeZpczelQLcGa2kazjOPCUG8chGLMWPpsXb5g9PhzfnulZf8LeTVbrUOAG71OxkWAtK+id9XnVceFMCRIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706186965; c=relaxed/simple;
	bh=PNyrbCjywjNlIXYg5ByVAotjsH2kxGncIfNEMqdut3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jb4/X3td9Za+cxpSPqfhmPJlDn4dAC8rBX9XG+p7nqi/qr1dFk3Intwf6oXtHQn8AK1mgZmgmO8AOlFApgsYf+7tA8aumSGdXqMyjYs4zQAAVTX8eOOUmgIe+yWfr2BTNnuJ7p1ruxX9mR10B5HKWkLWAbmpbygtILgIyEkbvDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HnqNFccU; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706186963; x=1737722963;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PNyrbCjywjNlIXYg5ByVAotjsH2kxGncIfNEMqdut3Q=;
  b=HnqNFccUVEX4P7xTgRfG5kqETMjh6pKL5Pkfp4qRCoiNn9c1h/npv4Jo
   IJQcKRUBPaI0NUK/9dqjBBp/eUWHMCFhFvEa8R4uL2kDa6v/QvQfh5Kwj
   +jw9YcXO3U+GrlNNjMuf3J5JSLVgeFwJRrpgRNP6n8n0RHJaiwxNDg55g
   3icwttwMRHG5gGoDTmzBWhjpHyAWPBYWz27uZ3I4wx3VG2sywQhfhn6VI
   sAQGg64czlslAF6/rs38Jw18yKpnztLv4XvvR3zCc6XQzkHp8v3oXeZiS
   GyNF6v+kPA1CxZBibgH35vGJPk5/2M71iuMj9ny+6cV49G6TeN/xrBh8B
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="399313540"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="399313540"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 04:49:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="905956690"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="905956690"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jan 2024 04:49:21 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	marcin.szycik@intel.com,
	wojciech.drewek@intel.com,
	sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [iwl-next v1 6/8] ice: change repr::id values
Date: Thu, 25 Jan 2024 13:53:12 +0100
Message-ID: <20240125125314.852914-7-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240125125314.852914-1-michal.swiatkowski@linux.intel.com>
References: <20240125125314.852914-1-michal.swiatkowski@linux.intel.com>
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


