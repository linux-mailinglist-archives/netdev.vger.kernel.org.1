Return-Path: <netdev+bounces-117265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A9C94D589
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 19:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53D7AB20ED5
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 17:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA86C155A4E;
	Fri,  9 Aug 2024 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RrFbywlW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167EB149C54
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 17:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723225001; cv=none; b=DMji69+OwtBXrf5/B8b2KpE/Inqpx16wfB99IBtTzhbNzmSKOul80C3CSsp+igNfetVe2hVHynl/Lx4Ir75m0h8HbCsyPozEK37MruvV0gnnPgLplMkoSVm8pgbKwoArNLljIwS+jKBbNmAbisBHbBPp5xbJNpxOwxiYT0YUhW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723225001; c=relaxed/simple;
	bh=iQOr94O3Zb5G7nLuSiVpB97At12+UMuNm63e7A7kzgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGVhH7FcfKAHHZQSCTDBWHeNDBXdY4YoixTX2Kzf5GCfoak2VVtl0s5EVtJAfqqjsTbHPuw+Z9VZClswg9tr7dUd0jQ7dJfToQcA6LNQCwGcA+0wtoIYIRpunYWN2KZr9AO9UbQrccHPotVXMRP6oK8qC+2Ik3PD2p24hZMPQO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RrFbywlW; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723225000; x=1754761000;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iQOr94O3Zb5G7nLuSiVpB97At12+UMuNm63e7A7kzgo=;
  b=RrFbywlWLPdW9Ma5j1iIlDje01U4ItvKP/5H+tPerhQ6W2HA2MKkzWsN
   eWFG/UCdh79x/OJrDizS4cgESD9UpWW+9L2oTDsEhhoRgAAlgPuboXx7C
   Hbtc6dDxyMNEPcPfoWmQBeefshbl1B8gfz/RWZxW3G+BqVk78F/EiUnxV
   +jn6hmIhqSEarphZwl25Kx9smeFAReJ3IZquBumpZpmG8dVirHAt8fsjH
   iGXYmbZTL3Uml0dihB4cJRQCeSVcOSYk5+cVBI3DXtXAh0SqnDlYjOGfV
   d1wtGSxs+6bQmJD75YZ7EYdgAdDIX54P5QN/8tCnSo/VWtdXGD6/tmCsT
   w==;
X-CSE-ConnectionGUID: RXWXaUPGRu2lXuxPKKnAIA==
X-CSE-MsgGUID: shJlGNhARRyNAb/BxollTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="21551322"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="21551322"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 10:36:32 -0700
X-CSE-ConnectionGUID: JqGpo3JfTe2irHO0j2Asgg==
X-CSE-MsgGUID: yJf7mJmLSFiww6bBVYU2MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="57589198"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 09 Aug 2024 10:36:31 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Junfeng Guo <junfeng.guo@intel.com>,
	anthony.l.nguyen@intel.com,
	ahmed.zaki@intel.com,
	madhu.chittim@intel.com,
	horms@kernel.org,
	hkelam@marvell.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 10/13] ice: add method to disable FDIR SWAP option
Date: Fri,  9 Aug 2024 10:36:09 -0700
Message-ID: <20240809173615.2031516-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240809173615.2031516-1-anthony.l.nguyen@intel.com>
References: <20240809173615.2031516-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Junfeng Guo <junfeng.guo@intel.com>

The SWAP Flag in the FDIR Programming Descriptor doesn't work properly,
it is always set and cannot be unset (hardware bug). Thus, add a method
to effectively disable the FDIR SWAP option by setting the FDSWAP instead
of FDINSET registers.

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ice/ice_flex_pipe.c    | 51 ++++++++++++++++++-
 .../net/ethernet/intel/ice/ice_flex_pipe.h    |  4 +-
 drivers/net/ethernet/intel/ice/ice_flow.c     |  2 +-
 3 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
index 20d5db88c99f..7f182a6f72aa 100644
--- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
+++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
@@ -2981,6 +2981,50 @@ ice_add_prof_attrib(struct ice_prof_map *prof, u8 ptg, u16 ptype,
 }
 
 /**
+ * ice_disable_fd_swap - set register appropriately to disable FD SWAP
+ * @hw: pointer to the HW struct
+ * @prof_id: profile ID
+ */
+static void
+ice_disable_fd_swap(struct ice_hw *hw, u8 prof_id)
+{
+	u16 swap_val, fvw_num;
+	unsigned int i;
+
+	swap_val = ICE_SWAP_VALID;
+	fvw_num = hw->blk[ICE_BLK_FD].es.fvw / ICE_FDIR_REG_SET_SIZE;
+
+	/* Since the SWAP Flag in the Programming Desc doesn't work,
+	 * here add method to disable the SWAP Option via setting
+	 * certain SWAP and INSET register sets.
+	 */
+	for (i = 0; i < fvw_num ; i++) {
+		u32 raw_swap, raw_in;
+		unsigned int j;
+
+		raw_swap = 0;
+		raw_in = 0;
+
+		for (j = 0; j < ICE_FDIR_REG_SET_SIZE; j++) {
+			raw_swap |= (swap_val++) << (j * BITS_PER_BYTE);
+			raw_in |= ICE_INSET_DFLT << (j * BITS_PER_BYTE);
+		}
+
+		/* write the FDIR swap register set */
+		wr32(hw, GLQF_FDSWAP(prof_id, i), raw_swap);
+
+		ice_debug(hw, ICE_DBG_INIT, "swap wr(%d, %d): 0x%x = 0x%08x\n",
+			  prof_id, i, GLQF_FDSWAP(prof_id, i), raw_swap);
+
+		/* write the FDIR inset register set */
+		wr32(hw, GLQF_FDINSET(prof_id, i), raw_in);
+
+		ice_debug(hw, ICE_DBG_INIT, "inset wr(%d, %d): 0x%x = 0x%08x\n",
+			  prof_id, i, GLQF_FDINSET(prof_id, i), raw_in);
+	}
+}
+
+/*
  * ice_add_prof - add profile
  * @hw: pointer to the HW struct
  * @blk: hardware block
@@ -2991,6 +3035,7 @@ ice_add_prof_attrib(struct ice_prof_map *prof, u8 ptg, u16 ptype,
  * @es: extraction sequence (length of array is determined by the block)
  * @masks: mask for extraction sequence
  * @symm: symmetric setting for RSS profiles
+ * @fd_swap: enable/disable FDIR paired src/dst fields swap option
  *
  * This function registers a profile, which matches a set of PTYPES with a
  * particular extraction sequence. While the hardware profile is allocated
@@ -3000,7 +3045,7 @@ ice_add_prof_attrib(struct ice_prof_map *prof, u8 ptg, u16 ptype,
 int
 ice_add_prof(struct ice_hw *hw, enum ice_block blk, u64 id, u8 ptypes[],
 	     const struct ice_ptype_attributes *attr, u16 attr_cnt,
-	     struct ice_fv_word *es, u16 *masks, bool symm)
+	     struct ice_fv_word *es, u16 *masks, bool symm, bool fd_swap)
 {
 	u32 bytes = DIV_ROUND_UP(ICE_FLOW_PTYPE_MAX, BITS_PER_BYTE);
 	DECLARE_BITMAP(ptgs_used, ICE_XLT1_CNT);
@@ -3020,7 +3065,7 @@ ice_add_prof(struct ice_hw *hw, enum ice_block blk, u64 id, u8 ptypes[],
 		status = ice_alloc_prof_id(hw, blk, &prof_id);
 		if (status)
 			goto err_ice_add_prof;
-		if (blk == ICE_BLK_FD) {
+		if (blk == ICE_BLK_FD && fd_swap) {
 			/* For Flow Director block, the extraction sequence may
 			 * need to be altered in the case where there are paired
 			 * fields that have no match. This is necessary because
@@ -3031,6 +3076,8 @@ ice_add_prof(struct ice_hw *hw, enum ice_block blk, u64 id, u8 ptypes[],
 			status = ice_update_fd_swap(hw, prof_id, es);
 			if (status)
 				goto err_ice_add_prof;
+		} else if (blk == ICE_BLK_FD) {
+			ice_disable_fd_swap(hw, prof_id);
 		}
 		status = ice_update_prof_masking(hw, blk, prof_id, masks);
 		if (status)
diff --git a/drivers/net/ethernet/intel/ice/ice_flex_pipe.h b/drivers/net/ethernet/intel/ice/ice_flex_pipe.h
index b39d7cdc381f..7c66652dadd6 100644
--- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.h
+++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.h
@@ -6,6 +6,8 @@
 
 #include "ice_type.h"
 
+#define ICE_FDIR_REG_SET_SIZE	4
+
 int
 ice_acquire_change_lock(struct ice_hw *hw, enum ice_aq_res_access_type access);
 void ice_release_change_lock(struct ice_hw *hw);
@@ -42,7 +44,7 @@ bool ice_hw_ptype_ena(struct ice_hw *hw, u16 ptype);
 int
 ice_add_prof(struct ice_hw *hw, enum ice_block blk, u64 id, u8 ptypes[],
 	     const struct ice_ptype_attributes *attr, u16 attr_cnt,
-	     struct ice_fv_word *es, u16 *masks, bool symm);
+	     struct ice_fv_word *es, u16 *masks, bool symm, bool fd_swap);
 struct ice_prof_map *
 ice_search_prof_id(struct ice_hw *hw, enum ice_block blk, u64 id);
 int
diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
index fc2b58f56279..79106503194b 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.c
+++ b/drivers/net/ethernet/intel/ice/ice_flow.c
@@ -1400,7 +1400,7 @@ ice_flow_add_prof_sync(struct ice_hw *hw, enum ice_block blk,
 	/* Add a HW profile for this flow profile */
 	status = ice_add_prof(hw, blk, prof_id, (u8 *)params->ptypes,
 			      params->attr, params->attr_cnt, params->es,
-			      params->mask, symm);
+			      params->mask, symm, true);
 	if (status) {
 		ice_debug(hw, ICE_DBG_FLOW, "Error adding a HW flow profile\n");
 		goto out;
-- 
2.42.0


