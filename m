Return-Path: <netdev+bounces-77255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA710870CF7
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 22:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC9BE1C20358
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 21:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D277CF1D;
	Mon,  4 Mar 2024 21:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qm/ldRJX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE60D7C0A8
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 21:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587787; cv=none; b=ByVhu4Ymz+hUIXc+rFuGUf7TPugxI7lgoVGHzH3V5JK3kVTGMZJq2QdHKF9oJIWYZ7m9hDJKYYS7RcLtGPEOpXYbcg0exshqNGjq8VmlMS0gjB9ClGu7khRr8gZnqih6zzJ0zQxcprSYyxTpFywabFndusiahK6wJ+Iitmktnos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587787; c=relaxed/simple;
	bh=79K3tGmbQNGBaIekVFrb80at8Sy0ZEo5vXySWcMUxPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JlEv94QR2wyZJQ3VLZyaaVL2ozzQL/qJntzQqcesNehmCsnPmHvBpXx8AiDB4cY4iCp5H4N24Xa47uLFrJFbvFAJ2CmXBdQooQB/oH0HngalNATyPGDABJBJ/+4T1FAVKRapAebXOcr870wQa+EMzJhUwIAk8Nex8aiGBiLu4pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qm/ldRJX; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709587786; x=1741123786;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=79K3tGmbQNGBaIekVFrb80at8Sy0ZEo5vXySWcMUxPc=;
  b=Qm/ldRJXEjqMJ5joSYu96qyREVhSeFys0Yz2wh2MaLIt4Rtejt8mBxhF
   1vhz3dr0fmN3jloXSp1bafpu3SQ/GVEIIXczjbzsBx4IHCrdBHuruXiHS
   uVPz2afRharDmssGsJ1kDKihDO0yLSSFCGPEHHhOwTiJQlshoUXmbhvbe
   c2IWwgcwwkhxSpzl2kP5gh9FciAvuSWa/mqjW+6jIZP8nIZtLTu880dcG
   C8YVeP4etJWDkIgDXZZ9wfWWx7VRbfMwRlaSXXJAKR6rxcwVmpV9SkDt4
   1ShBebenQlWaPYpmMl6zL7nzXgbLt8dCxtS5krncxtbemKVipji5TX215
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="3968089"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="3968089"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 13:29:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="46647887"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 04 Mar 2024 13:29:40 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next 7/9] ice: cleanup line splitting for context set functions
Date: Mon,  4 Mar 2024 13:29:28 -0800
Message-ID: <20240304212932.3412641-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240304212932.3412641-1-anthony.l.nguyen@intel.com>
References: <20240304212932.3412641-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The indentation for ice_set_ctx and ice_write_rxq_ctx breaks the function
name after the return type. This style of breaking is used a lot throughout
the ice driver, even in cases where its not actually helpful for
readability. We no longer prefer this style of line splitting in the
driver, and new code is avoiding it.

Normally, I would leave this alone unless the actual function contents or
description needed updating. However, a future change is going to add
inverse functions for converting packed context to unpacked context
structures. To keep this code uniform with the existing set functions, fix
up the style to the modern format of keeping the type on the same line.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 12 +++++-------
 drivers/net/ethernet/intel/ice/ice_common.h | 10 ++++------
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index e9e4a8ef7904..7d9315ffae57 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1399,9 +1399,8 @@ static const struct ice_ctx_ele ice_rlan_ctx_info[] = {
  * it to HW register space and enables the hardware to prefetch descriptors
  * instead of only fetching them on demand
  */
-int
-ice_write_rxq_ctx(struct ice_hw *hw, struct ice_rlan_ctx *rlan_ctx,
-		  u32 rxq_index)
+int ice_write_rxq_ctx(struct ice_hw *hw, struct ice_rlan_ctx *rlan_ctx,
+		      u32 rxq_index)
 {
 	u8 ctx_buf[ICE_RXQ_CTX_SZ] = { 0 };
 
@@ -4522,11 +4521,10 @@ static void ice_pack_ctx_qword(u8 *src_ctx, u8 *dest_ctx,
  * @hw: pointer to the hardware structure
  * @src_ctx:  pointer to a generic non-packed context structure
  * @dest_ctx: pointer to memory for the packed structure
- * @ce_info:  a description of the structure to be transformed
+ * @ce_info: List of Rx context elements
  */
-int
-ice_set_ctx(struct ice_hw *hw, u8 *src_ctx, u8 *dest_ctx,
-	    const struct ice_ctx_ele *ce_info)
+int ice_set_ctx(struct ice_hw *hw, u8 *src_ctx, u8 *dest_ctx,
+		const struct ice_ctx_ele *ce_info)
 {
 	int f;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index 32fd10de620c..ffb22c7ce28b 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -53,9 +53,8 @@ int ice_get_caps(struct ice_hw *hw);
 
 void ice_set_safe_mode_caps(struct ice_hw *hw);
 
-int
-ice_write_rxq_ctx(struct ice_hw *hw, struct ice_rlan_ctx *rlan_ctx,
-		  u32 rxq_index);
+int ice_write_rxq_ctx(struct ice_hw *hw, struct ice_rlan_ctx *rlan_ctx,
+		      u32 rxq_index);
 
 int
 ice_aq_get_rss_lut(struct ice_hw *hw, struct ice_aq_get_set_rss_lut_params *get_params);
@@ -72,9 +71,8 @@ bool ice_check_sq_alive(struct ice_hw *hw, struct ice_ctl_q_info *cq);
 int ice_aq_q_shutdown(struct ice_hw *hw, bool unloading);
 void ice_fill_dflt_direct_cmd_desc(struct ice_aq_desc *desc, u16 opcode);
 extern const struct ice_ctx_ele ice_tlan_ctx_info[];
-int
-ice_set_ctx(struct ice_hw *hw, u8 *src_ctx, u8 *dest_ctx,
-	    const struct ice_ctx_ele *ce_info);
+int ice_set_ctx(struct ice_hw *hw, u8 *src_ctx, u8 *dest_ctx,
+		const struct ice_ctx_ele *ce_info);
 
 extern struct mutex ice_global_cfg_lock_sw;
 
-- 
2.41.0


