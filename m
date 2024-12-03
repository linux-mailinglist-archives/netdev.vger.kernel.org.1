Return-Path: <netdev+bounces-148729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C20AB9E3024
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 00:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87250281130
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 23:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B0C20C00C;
	Tue,  3 Dec 2024 23:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lgEeIjoJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384AE20B7E3
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 23:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733270116; cv=none; b=PdD0Iidi5st05cNiILxrTZu9hRfGFKnEe6W+lO330xCjdUqKDFSzYxJrGNqpSz3t3RIHc47tyu9X1UwuBqoUDEf9R9h99xmq5sE2SDn5pvCN6GHCSpCfYJrfS4FhinIxNO4SR341njVCWQvD/IVVocKNlUROt+QCRUnezIW4k8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733270116; c=relaxed/simple;
	bh=gu20ew2eNe0omuRWZFSExyiSntYD1ab+5kf2dvSDMZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XtCl260u8lnrGk1Bq+jYAMLKbf/yeOYf5RCIpwMNwybCTbyGRv8X+uyywR6BYuvJGNc15OaEpBxsjRe+aqLNNj+SpX3T2c5xyI0EGhnkKkZzX7eY7SxeIKi/XHQMlCinqSJBDq7z1zSh11/y6gg9jj8pDI7Ohu4COn/B/t3AvA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lgEeIjoJ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733270115; x=1764806115;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=gu20ew2eNe0omuRWZFSExyiSntYD1ab+5kf2dvSDMZo=;
  b=lgEeIjoJ1wqp3OPIVYTNuo9mCUJIcblFCsIk/BXa8FfVIcLg1oe+cm0a
   uslqFdI2Jh8fRXM1vxiWsd7/A8T4rv51hgiTBQG1sp6QvRGvp0WBF4zVU
   05yLfVORkZu5RtMR4CzKJhrm8NedIsRPQklYmFy/z3zAoFrFsSpcTVMWm
   tm4w+zKV4QJ3aUd8lGQ06aNvwkmjFLW1PyLc7E6bCBY70sCFP87K2Esc8
   PVB71z3tM6uheEv7i4qSQS6914aAArlz6YXskHN3ooqzVdXUpHKpZPq7D
   Pcffxu4Iosp7/i6xDdWyDi0z7u/p4m1Kwq544tdmgLqOJwTBZR59VwJuN
   Q==;
X-CSE-ConnectionGUID: KrgXNlY/RN+AiOVuQ6ePSA==
X-CSE-MsgGUID: a44xO8VURhGEy22B1Ip1/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="58918460"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="58918460"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 15:55:09 -0800
X-CSE-ConnectionGUID: yV8nZcZHRDmFiR2x4vKUDw==
X-CSE-MsgGUID: UiXKM8aZTq2GTdyMTzFTfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="93679059"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 15:55:09 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 03 Dec 2024 15:53:56 -0800
Subject: [PATCH net-next v8 10/10] ice: cleanup Rx queue context
 programming functions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-packing-pack-fields-and-ice-implementation-v8-10-2ed68edfe583@intel.com>
References: <20241203-packing-pack-fields-and-ice-implementation-v8-0-2ed68edfe583@intel.com>
In-Reply-To: <20241203-packing-pack-fields-and-ice-implementation-v8-0-2ed68edfe583@intel.com>
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
index 379040593d975342eaa2a3032938683b419f4f60..6c6862beab6a961ce5c0bc34e9c5794ed8cda865 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1358,32 +1358,23 @@ int ice_reset(struct ice_hw *hw, enum ice_reset_req req)
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
@@ -1432,23 +1423,26 @@ static void ice_pack_rxq_ctx(const struct ice_rlan_ctx *ctx,
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


