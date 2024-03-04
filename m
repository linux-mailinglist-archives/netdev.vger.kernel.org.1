Return-Path: <netdev+bounces-77252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0F5870CF4
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 22:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D770A28B79B
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 21:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17707C0A7;
	Mon,  4 Mar 2024 21:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bfle4qFT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F96B7BB0D
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 21:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587785; cv=none; b=Nis2/yp/twkmsVZRcNDsVSsukztSRFSihwvmlWrh0Tj6UMkdgUNyjjKK0qTXjQDk6Hd7UdYFb3gvxZBaVSEJfUZrCkQSDnTYud/NPo0qtaxyywuhv6xx1ssbJjNSoidUzqpXZw+WJkYpZ2T/AtMJl4e2WwBLi4/mzdkQoDiIEUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587785; c=relaxed/simple;
	bh=LW5bHj7/5udQDIH+ydsEFFCK+H3rCdZVnkZsC9ha1Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o74/5sxtgDAm9ehiF8x0mw69N8HBgqtRFK6e0DT1myV1HOjdUjn7FHllXLZzWfhq3RJBXHe0FE34hEjF3LSphsbidXmzoeoqYrPiTEgJcFCnvXuf2ufUeqAI7pwL1GJohG205pfBVv16nZjex2cxnv/QOB2fxbQp9cNknm1TZQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bfle4qFT; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709587784; x=1741123784;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LW5bHj7/5udQDIH+ydsEFFCK+H3rCdZVnkZsC9ha1Qc=;
  b=bfle4qFTJ40SaS4uERygT7L2wPtj1rg57Cyc0iKqEDcBx0BryDjs4NGk
   OymnAHGAruenI7TCRyci5m5ZQZrbKbleuXMooui76H0ROAC99xngBTTO3
   xm5IYYW5+0V/6/FyJIgzMnGI2XtwHNrESxg404i9HWPIcGrKNjmoR/Swm
   6Pz9ACFRCxJDrHvOxo/u2vxVfI2BK+wJEa/8wFZR2p5+tUfcucYiS8QFY
   9RtDHKTSUq+aimMPQVeOqydKjSRNpjFMGKjr8YM14mzzm7BYYNE0a8JS0
   2pwXfNfeGwldTwCcJklFdz5Rcy9AKwepaxG5kmNda8H/71SgiebFb3Llz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="3968083"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="3968083"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 13:29:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="46647881"
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
Subject: [PATCH net-next 5/9] ice: rename ice_write_* functions to ice_pack_ctx_*
Date: Mon,  4 Mar 2024 13:29:26 -0800
Message-ID: <20240304212932.3412641-6-anthony.l.nguyen@intel.com>
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

In ice_common.c there are 4 functions used for converting the unpacked
software Tx and Rx context structure data into the packed format used by
hardware. These functions have extremely generic names:

 * ice_write_byte
 * ice_write_word
 * ice_write_dword
 * ice_write_qword

When I saw these function names my first thought was "write what? to
where?". Understanding what these functions do requires looking at the
implementation details. The functions take bits from an unpacked structure
and copy them into the packed layout used by hardware.

As part of live migration, we will want functions which perform the inverse
operation of reading bits from the packed layout and copying them into the
unpacked format. Naming these as "ice_read_byte", etc would be very
confusing since they appear to write data.

In preparation for adding this new inverse operation, rename the existing
functions to use the prefix "ice_pack_ctx_". This makes it clear that they
perform the bit packing while copying from the unpacked software context
structure to the packed hardware context.

The inverse operations can then neatly be named ice_unpack_ctx_*, clearly
indicating they perform the bit unpacking while copying from the packed
hardware context to the unpacked software context structure.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 56 ++++++++++-----------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 9266f25a9978..3622079cb506 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -4362,13 +4362,13 @@ ice_aq_add_rdma_qsets(struct ice_hw *hw, u8 num_qset_grps,
 /* End of FW Admin Queue command wrappers */
 
 /**
- * ice_write_byte - write a byte to a packed context structure
- * @src_ctx:  the context structure to read from
- * @dest_ctx: the context to be written to
- * @ce_info:  a description of the struct to be filled
+ * ice_pack_ctx_byte - write a byte to a packed context structure
+ * @src_ctx: unpacked source context structure
+ * @dest_ctx: packed destination context data
+ * @ce_info: context element description
  */
-static void
-ice_write_byte(u8 *src_ctx, u8 *dest_ctx, const struct ice_ctx_ele *ce_info)
+static void ice_pack_ctx_byte(u8 *src_ctx, u8 *dest_ctx,
+			      const struct ice_ctx_ele *ce_info)
 {
 	u8 src_byte, dest_byte, mask;
 	u8 *from, *dest;
@@ -4401,13 +4401,13 @@ ice_write_byte(u8 *src_ctx, u8 *dest_ctx, const struct ice_ctx_ele *ce_info)
 }
 
 /**
- * ice_write_word - write a word to a packed context structure
- * @src_ctx:  the context structure to read from
- * @dest_ctx: the context to be written to
- * @ce_info:  a description of the struct to be filled
+ * ice_pack_ctx_word - write a word to a packed context structure
+ * @src_ctx: unpacked source context structure
+ * @dest_ctx: packed destination context data
+ * @ce_info: context element description
  */
-static void
-ice_write_word(u8 *src_ctx, u8 *dest_ctx, const struct ice_ctx_ele *ce_info)
+static void ice_pack_ctx_word(u8 *src_ctx, u8 *dest_ctx,
+			      const struct ice_ctx_ele *ce_info)
 {
 	u16 src_word, mask;
 	__le16 dest_word;
@@ -4444,13 +4444,13 @@ ice_write_word(u8 *src_ctx, u8 *dest_ctx, const struct ice_ctx_ele *ce_info)
 }
 
 /**
- * ice_write_dword - write a dword to a packed context structure
- * @src_ctx:  the context structure to read from
- * @dest_ctx: the context to be written to
- * @ce_info:  a description of the struct to be filled
+ * ice_pack_ctx_dword - write a dword to a packed context structure
+ * @src_ctx: unpacked source context structure
+ * @dest_ctx: packed destination context data
+ * @ce_info: context element description
  */
-static void
-ice_write_dword(u8 *src_ctx, u8 *dest_ctx, const struct ice_ctx_ele *ce_info)
+static void ice_pack_ctx_dword(u8 *src_ctx, u8 *dest_ctx,
+			       const struct ice_ctx_ele *ce_info)
 {
 	u32 src_dword, mask;
 	__le32 dest_dword;
@@ -4495,13 +4495,13 @@ ice_write_dword(u8 *src_ctx, u8 *dest_ctx, const struct ice_ctx_ele *ce_info)
 }
 
 /**
- * ice_write_qword - write a qword to a packed context structure
- * @src_ctx:  the context structure to read from
- * @dest_ctx: the context to be written to
- * @ce_info:  a description of the struct to be filled
+ * ice_pack_ctx_qword - write a qword to a packed context structure
+ * @src_ctx: unpacked source context structure
+ * @dest_ctx: packed destination context data
+ * @ce_info: context element description
  */
-static void
-ice_write_qword(u8 *src_ctx, u8 *dest_ctx, const struct ice_ctx_ele *ce_info)
+static void ice_pack_ctx_qword(u8 *src_ctx, u8 *dest_ctx,
+			       const struct ice_ctx_ele *ce_info)
 {
 	u64 src_qword, mask;
 	__le64 dest_qword;
@@ -4570,16 +4570,16 @@ ice_set_ctx(struct ice_hw *hw, u8 *src_ctx, u8 *dest_ctx,
 		}
 		switch (ce_info[f].size_of) {
 		case sizeof(u8):
-			ice_write_byte(src_ctx, dest_ctx, &ce_info[f]);
+			ice_pack_ctx_byte(src_ctx, dest_ctx, &ce_info[f]);
 			break;
 		case sizeof(u16):
-			ice_write_word(src_ctx, dest_ctx, &ce_info[f]);
+			ice_pack_ctx_word(src_ctx, dest_ctx, &ce_info[f]);
 			break;
 		case sizeof(u32):
-			ice_write_dword(src_ctx, dest_ctx, &ce_info[f]);
+			ice_pack_ctx_dword(src_ctx, dest_ctx, &ce_info[f]);
 			break;
 		case sizeof(u64):
-			ice_write_qword(src_ctx, dest_ctx, &ce_info[f]);
+			ice_pack_ctx_qword(src_ctx, dest_ctx, &ce_info[f]);
 			break;
 		default:
 			return -EINVAL;
-- 
2.41.0


