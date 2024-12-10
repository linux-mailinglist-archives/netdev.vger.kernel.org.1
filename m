Return-Path: <netdev+bounces-150832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E57D9EBADB
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 21:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 554251671C7
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 20:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8D6228384;
	Tue, 10 Dec 2024 20:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kIHgTQzR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1575227BBE
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 20:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733862457; cv=none; b=qq68Z0c2xCzRvqyyU7iMuS3su1lxVEqIfkVtiJDdJwh16kGx3kA1UN51et4UePpGKoqGFfcFUOb6UOlf3iquZdNe8RIdd1e2itmBnUSgbM30KkNo+3VquQpgrIWUdoOw//bseKr6FcBDPA3s6kryZS3LDe7yK+YD0fY2f6Q/aus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733862457; c=relaxed/simple;
	bh=W31xymk0wO6aQw+1z1i7Q1HuoIfaLrTWEwHFw2r3btY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e5WODcx2Mcr6DY8iPFBJswZZWMTtLOTTsB3vcW0kMXSjMuGLI8J2CQwh3D9PIAiloEpLc2wx/eKfdT64h6ZNKzJSYzBHfCMG+9aL/cyqkqIWoy37/839wW5PgzXzk+Yef4jjO3p2wTQq4K3ubJbxToKBOv7FtnHm1wxnWxcngJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kIHgTQzR; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733862456; x=1765398456;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=W31xymk0wO6aQw+1z1i7Q1HuoIfaLrTWEwHFw2r3btY=;
  b=kIHgTQzRyWd2aPMIGzQXHFFtQ/TaGmjsd+ZUnc+3b4K/AzCRuQTdryOn
   N5uyKb5bWLt51d2vSUjsqSc0ClPu17rHjH7oE5zDzhhGLBLKjNkPY7e0K
   6F0iyhd5whrK0sl16w9UO77GaNYvo2DGd7wRwCScV03ickhOPt5cmEsMO
   2BGdWkr3uKpXL1PYb+4MonLCad/4xz+fyXGY7J/0XveKATdOjknuOrFrF
   hrLeIjnqzJwAD2XFLnOwuwz33KP/2e62pZDRgKXbKFjZE/8yl8v9TjYQx
   0GVVbVhhWiAfi/GX1DHMsL6OWu8Y7WkuOfkhpjaYxDLlQlEAIXh8y7bx5
   w==;
X-CSE-ConnectionGUID: zmCaig5+RCutZOK+Iaoz6Q==
X-CSE-MsgGUID: qv9FRhrLSXOKRddVgAOAsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34147332"
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="34147332"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 12:27:29 -0800
X-CSE-ConnectionGUID: UIsUEywSSVa1b5IC6utqfA==
X-CSE-MsgGUID: ag2okD05TmWzjyua9IAwww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="126424107"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 12:27:29 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 10 Dec 2024 12:27:19 -0800
Subject: [PATCH net-next v10 10/10] ice: cleanup Rx queue context
 programming functions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-packing-pack-fields-and-ice-implementation-v10-10-ee56a47479ac@intel.com>
References: <20241210-packing-pack-fields-and-ice-implementation-v10-0-ee56a47479ac@intel.com>
In-Reply-To: <20241210-packing-pack-fields-and-ice-implementation-v10-0-ee56a47479ac@intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Masahiro Yamada <masahiroy@kernel.org>, netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.14.2

The ice_copy_rxq_ctx_to_hw() and ice_write_rxq_ctx() functions perform some
defensive checks which are typically frowned upon by kernel style
guidelines.

In particular, NULL checks on buffers which point to the stack are
discouraged, especially when the functions are static and only called once.
Checks of this sort only serve to hide potential programming error, as we
will not produce the normal crash dump on a NULL access.

In addition, ice_copy_rxq_ctx_to_hw() cannot fail in another way, so could
be made void.

Future support for VF Live Migration will need to introduce an inverse
function for reading Rx queue context from HW registers to unpack it, as
well as functions to pack and unpack Tx queue context from HW.

Rather than copying these style issues into the new functions, lets first
cleanup the existing code.

For the ice_copy_rxq_ctx_to_hw() function:

 * Move the Rx queue index check out of this function.
 * Convert the function to a void return.
 * Use a simple int variable instead of a u8 for the for loop index, and
   initialize it inside the for loop.
 * Update the function description to better align with kernel doc style.

For the ice_write_rxq_ctx() function:

 * Move the Rx queue index check into this function.
 * Update the function description with a Returns: to align with kernel doc
   style.

These changes align the existing write functions to current kernel
style, and will align with the style of the new functions added when we
implement live migration in a future series.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 4c6cc48aaef0c31eaa1d9de35effcd812933d270..f89bc6ede315717f2db7ba18d54c2c628609686f 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1361,32 +1361,23 @@ int ice_reset(struct ice_hw *hw, enum ice_reset_req req)
 }
 
 /**
- * ice_copy_rxq_ctx_to_hw
+ * ice_copy_rxq_ctx_to_hw - Copy packed Rx queue context to HW registers
  * @hw: pointer to the hardware structure
  * @rxq_ctx: pointer to the packed Rx queue context
  * @rxq_index: the index of the Rx queue
- *
- * Copies rxq context from dense structure to HW register space
  */
-static int ice_copy_rxq_ctx_to_hw(struct ice_hw *hw,
-				  const ice_rxq_ctx_buf_t *rxq_ctx,
-				  u32 rxq_index)
+static void ice_copy_rxq_ctx_to_hw(struct ice_hw *hw,
+				   const ice_rxq_ctx_buf_t *rxq_ctx,
+				   u32 rxq_index)
 {
-	u8 i;
-
-	if (rxq_index > QRX_CTRL_MAX_INDEX)
-		return -EINVAL;
-
 	/* Copy each dword separately to HW */
-	for (i = 0; i < ICE_RXQ_CTX_SIZE_DWORDS; i++) {
+	for (int i = 0; i < ICE_RXQ_CTX_SIZE_DWORDS; i++) {
 		u32 ctx = ((const u32 *)rxq_ctx)[i];
 
 		wr32(hw, QRX_CONTEXT(i, rxq_index), ctx);
 
 		ice_debug(hw, ICE_DBG_QCTX, "qrxdata[%d]: %08X\n", i, ctx);
 	}
-
-	return 0;
 }
 
 #define ICE_CTX_STORE(struct_name, struct_field, width, lsb) \
@@ -1435,23 +1426,26 @@ static void ice_pack_rxq_ctx(const struct ice_rlan_ctx *ctx,
 /**
  * ice_write_rxq_ctx - Write Rx Queue context to hardware
  * @hw: pointer to the hardware structure
- * @rlan_ctx: pointer to the rxq context
+ * @rlan_ctx: pointer to the unpacked Rx queue context
  * @rxq_index: the index of the Rx queue
  *
  * Pack the sparse Rx Queue context into dense hardware format and write it
  * into the HW register space.
+ *
+ * Return: 0 on success, or -EINVAL if the Rx queue index is invalid.
  */
 int ice_write_rxq_ctx(struct ice_hw *hw, struct ice_rlan_ctx *rlan_ctx,
 		      u32 rxq_index)
 {
 	ice_rxq_ctx_buf_t buf = {};
 
-	if (!rlan_ctx)
+	if (rxq_index > QRX_CTRL_MAX_INDEX)
 		return -EINVAL;
 
 	ice_pack_rxq_ctx(rlan_ctx, &buf);
+	ice_copy_rxq_ctx_to_hw(hw, &buf, rxq_index);
 
-	return ice_copy_rxq_ctx_to_hw(hw, &buf, rxq_index);
+	return 0;
 }
 
 /* LAN Tx Queue Context */

-- 
2.47.0.265.g4ca455297942


