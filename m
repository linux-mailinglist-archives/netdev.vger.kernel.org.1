Return-Path: <netdev+bounces-139268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3165C9B13B7
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 02:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43A4CB2138E
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 00:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8760428E37;
	Sat, 26 Oct 2024 00:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QdJ/aaWJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CF5A947;
	Sat, 26 Oct 2024 00:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729901161; cv=none; b=c7m9uEbS5A9+KKmeW0kCsvxRipNeRLF/RUUof4xT7qtaDqY1q8KAD8+PQhLTvaDDg+cNleuB5opBpVan/BYWV/0qactJFXfumdN+SOtuPXwH/OuF5zhsn9emroPhgxfzD0Lbz7jsZ0ZxntcPOYva6aIRYzHgxcvElCowZcTKrt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729901161; c=relaxed/simple;
	bh=K+Qc2S3O5vn6PT+PSvSB43VgqV6G0RA250yc3yR2da8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DnV0Tad6JKwhGUci4nTXgZFNYIsK6L8RBWyJYOfnvOQ1yjz/DgGM8m2HlTxwI0CxsstEZrmptqQNxeZsFNrv5GjNr4il1Q9Ji4xY9w4ZWDY9/twN8JMHYKUnsLW1YOokfwjSg7RoK4it0csdWZCLxlDLMpct4AB5v7maF+ayOp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QdJ/aaWJ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729901158; x=1761437158;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=K+Qc2S3O5vn6PT+PSvSB43VgqV6G0RA250yc3yR2da8=;
  b=QdJ/aaWJo27qIG1UsrLwyIxbRoPAtzOkX+iOIU/SOzEmLGDSFtkh9aW5
   6muJzlgsCAeWMoE4LjMKcg/LBWMgpc4JRzfSJqrVTb9oLh4cOUBKYoq++
   WAivKevXIsY/wYg1nernCSL9YnPo1wzSb2VnKL2705UQAlNUPuAZOzUh1
   Yt2X3mfyQURb2TTrYqFSMlatQXu3LVmMZKSkkEzJtNaFHAsY3JCipK1TZ
   Vwi740Y/kq2J6a1MIoVmQh1+pmDNuKapSacT+Wrdo62Hon4/rkkpW7h2T
   lNqxQKDKJRhBFM21uH7+wvZYWnpQb9BZsN79hMLWGwwdzAimFj4UzFiZK
   Q==;
X-CSE-ConnectionGUID: lombvu7FTgGfvzFARIElUw==
X-CSE-MsgGUID: 87jOvB+xTAq3B2GxGyTn4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="40959149"
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="40959149"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 17:05:54 -0700
X-CSE-ConnectionGUID: cDoXwZFeSd26KOoisLmTiQ==
X-CSE-MsgGUID: XI76J1CERRKcsXnddVAI1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="104386855"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 17:05:54 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 25 Oct 2024 17:04:58 -0700
Subject: [PATCH net-next v2 6/9] ice: use <linux/packing.h> for Tx and Rx
 queue context data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-packing-pack-fields-and-ice-implementation-v2-6-734776c88e40@intel.com>
References: <20241025-packing-pack-fields-and-ice-implementation-v2-0-734776c88e40@intel.com>
In-Reply-To: <20241025-packing-pack-fields-and-ice-implementation-v2-0-734776c88e40@intel.com>
To: Vladimir Oltean <olteanv@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.14.1

The ice driver needs to write the Tx and Rx queue context when programming
Tx and Rx queues. This is currently done using some bespoke custom logic
via the ice_set_ctx() and its helper functions, along with bit position
definitions in the ice_tlan_ctx_info and ice_rlan_ctx_info structures.

This logic does work, but is problematic for several reasons:

1) ice_set_ctx requires a helper function for each byte size being packed,
   as it uses a separate function to pack u8, u16, u32, and u64 fields.
   This requires 4 functions which contain near-duplicate logic with the
   types changed out.

2) The logic in the ice_pack_ctx_word, ice_pack_ctx_dword, and
   ice_pack_ctx_qword does not handle values which straddle alignment
   boundaries very well. This requires that several fields in the
   ice_tlan_ctx_info and ice_rlan_ctx_info be a size larger than their bit
   size should require.

3) Future support for live migration will require adding unpacking
   functions to take the packed hardware context and unpack it into the
   ice_rlan_ctx and ice_tlan_ctx structures. Implementing this would
   require implementing ice_get_ctx, and its associated helper functions,
   which essentially doubles the amount of code required.

The Linux kernel has had a packing library that can handle this logic since
commit 554aae35007e ("lib: Add support for generic packing operations").
The library was recently extended with support for packing or unpacking an
array of fields, with a similar structure as the ice_ctx_ele structure.

Replace the ice-specific ice_set_ctx() logic with the recently added
pack_fields and packed_field_s infrastructure from <linux/packing.h>

For API simplicity, the Tx and Rx queue context are programmed using
separate ice_pack_txq_ctx() and ice_pack_rxq_ctx(). This avoids needing to
export the packed_field_s arrays. The functions can pointers to the
appropriate ice_txq_ctx_buf_t and ice_rxq_ctx_buf_t types, ensuring that
only buffers of the appropriate size are passed.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.h    |   5 +-
 drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h |  14 --
 drivers/net/ethernet/intel/ice/ice_base.c      |   3 +-
 drivers/net/ethernet/intel/ice/ice_common.c    | 249 +++++--------------------
 drivers/net/ethernet/intel/Kconfig             |   3 +
 5 files changed, 50 insertions(+), 224 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index 27208a60cece..a68bea3934e3 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -92,9 +92,8 @@ ice_aq_set_rss_key(struct ice_hw *hw, u16 vsi_handle,
 bool ice_check_sq_alive(struct ice_hw *hw, struct ice_ctl_q_info *cq);
 int ice_aq_q_shutdown(struct ice_hw *hw, bool unloading);
 void ice_fill_dflt_direct_cmd_desc(struct ice_aq_desc *desc, u16 opcode);
-extern const struct ice_ctx_ele ice_tlan_ctx_info[];
-int ice_set_ctx(struct ice_hw *hw, u8 *src_ctx, u8 *dest_ctx,
-		const struct ice_ctx_ele *ce_info);
+
+void ice_pack_txq_ctx(const struct ice_tlan_ctx *ctx, ice_txq_ctx_buf_t *buf);
 
 extern struct mutex ice_global_cfg_lock_sw;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
index a76e5b0e7861..31d4a445d640 100644
--- a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
+++ b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
@@ -408,20 +408,6 @@ struct ice_rlan_ctx {
 	u8 prefena;	/* NOTE: normally must be set to 1 at init */
 };
 
-struct ice_ctx_ele {
-	u16 offset;
-	u16 size_of;
-	u16 width;
-	u16 lsb;
-};
-
-#define ICE_CTX_STORE(_struct, _ele, _width, _lsb) {	\
-	.offset = offsetof(struct _struct, _ele),	\
-	.size_of = sizeof_field(struct _struct, _ele),	\
-	.width = _width,				\
-	.lsb = _lsb,					\
-}
-
 /* for hsplit_0 field of Rx RLAN context */
 enum ice_rlan_ctx_rx_hsplit_0 {
 	ICE_RLAN_RX_HSPLIT_0_NO_SPLIT		= 0,
diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 260942877968..0a325dec804e 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -909,8 +909,7 @@ ice_vsi_cfg_txq(struct ice_vsi *vsi, struct ice_tx_ring *ring,
 	ice_setup_tx_ctx(ring, &tlan_ctx, pf_q);
 	/* copy context contents into the qg_buf */
 	qg_buf->txqs[0].txq_id = cpu_to_le16(pf_q);
-	ice_set_ctx(hw, (u8 *)&tlan_ctx, (u8 *)&qg_buf->txqs[0].txq_ctx,
-		    ice_tlan_ctx_info);
+	ice_pack_txq_ctx(&tlan_ctx, &qg_buf->txqs[0].txq_ctx);
 
 	/* init queue specific tail reg. It is referred as
 	 * transmit comm scheduler queue doorbell.
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 48d95cb49864..905f5c745a7b 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -6,6 +6,7 @@
 #include "ice_adminq_cmd.h"
 #include "ice_flow.h"
 #include "ice_ptp_hw.h"
+#include <linux/packing.h>
 
 #define ICE_PF_RESET_WAIT_COUNT	300
 #define ICE_MAX_NETLIST_SIZE	10
@@ -1385,9 +1386,12 @@ static int ice_copy_rxq_ctx_to_hw(struct ice_hw *hw,
 	return 0;
 }
 
+#define ICE_CTX_STORE(struct_name, struct_field, width, lsb) \
+	PACKED_FIELD((lsb) + (width) - 1, (lsb), struct struct_name, struct_field)
+
 /* LAN Rx Queue Context */
-static const struct ice_ctx_ele ice_rlan_ctx_info[] = {
-	/* Field		Width	LSB */
+static const struct packed_field_s ice_rlan_ctx_fields[] = {
+				 /* Field		Width	LSB */
 	ICE_CTX_STORE(ice_rlan_ctx, head,		13,	0),
 	ICE_CTX_STORE(ice_rlan_ctx, cpuid,		8,	13),
 	ICE_CTX_STORE(ice_rlan_ctx, base,		57,	32),
@@ -1408,9 +1412,26 @@ static const struct ice_ctx_ele ice_rlan_ctx_info[] = {
 	ICE_CTX_STORE(ice_rlan_ctx, tphhead_ena,	1,	196),
 	ICE_CTX_STORE(ice_rlan_ctx, lrxqthresh,		3,	198),
 	ICE_CTX_STORE(ice_rlan_ctx, prefena,		1,	201),
-	{ 0 }
 };
 
+/**
+ * ice_pack_rxq_ctx - Pack Rx queue context into a HW buffer
+ * @ctx: the Rx queue context to pack
+ * @buf: the HW buffer to pack into
+ *
+ * Pack the Rx queue context from the CPU-friendly unpacked buffer into its
+ * bit-packed HW layout.
+ */
+static void ice_pack_rxq_ctx(const struct ice_rlan_ctx *ctx,
+			     ice_rxq_ctx_buf_t *buf)
+{
+	CHECK_PACKED_FIELDS_20(ice_rlan_ctx_fields, ICE_RXQ_CTX_SZ);
+	BUILD_BUG_ON(sizeof(*buf) != ICE_RXQ_CTX_SZ);
+
+	pack_fields(buf, sizeof(*buf), ctx, ice_rlan_ctx_fields,
+		    QUIRK_LITTLE_ENDIAN | QUIRK_LSW32_IS_FIRST);
+}
+
 /**
  * ice_write_rxq_ctx
  * @hw: pointer to the hardware structure
@@ -1431,12 +1452,13 @@ int ice_write_rxq_ctx(struct ice_hw *hw, struct ice_rlan_ctx *rlan_ctx,
 
 	rlan_ctx->prefena = 1;
 
-	ice_set_ctx(hw, (u8 *)rlan_ctx, (u8 *)&buf, ice_rlan_ctx_info);
+	ice_pack_rxq_ctx(rlan_ctx, &buf);
+
 	return ice_copy_rxq_ctx_to_hw(hw, &buf, rxq_index);
 }
 
 /* LAN Tx Queue Context */
-const struct ice_ctx_ele ice_tlan_ctx_info[] = {
+static const struct packed_field_s ice_tlan_ctx_fields[] = {
 				    /* Field			Width	LSB */
 	ICE_CTX_STORE(ice_tlan_ctx, base,			57,	0),
 	ICE_CTX_STORE(ice_tlan_ctx, port_num,			3,	57),
@@ -1465,9 +1487,25 @@ const struct ice_ctx_ele ice_tlan_ctx_info[] = {
 	ICE_CTX_STORE(ice_tlan_ctx, drop_ena,			1,	165),
 	ICE_CTX_STORE(ice_tlan_ctx, cache_prof_idx,		2,	166),
 	ICE_CTX_STORE(ice_tlan_ctx, pkt_shaper_prof_idx,	3,	168),
-	{ 0 }
 };
 
+/**
+ * ice_pack_txq_ctx - Pack Tx queue context into a HW buffer
+ * @ctx: the Tx queue context to pack
+ * @buf: the HW buffer to pack into
+ *
+ * Pack the Tx queue context from the CPU-friendly unpacked buffer into its
+ * bit-packed HW layout.
+ */
+void ice_pack_txq_ctx(const struct ice_tlan_ctx *ctx, ice_txq_ctx_buf_t *buf)
+{
+	CHECK_PACKED_FIELDS_27(ice_tlan_ctx_fields, ICE_TXQ_CTX_SZ);
+	BUILD_BUG_ON(sizeof(*buf) != ICE_TXQ_CTX_SZ);
+
+	pack_fields(buf, sizeof(*buf), ctx, ice_tlan_ctx_fields,
+		    QUIRK_LITTLE_ENDIAN | QUIRK_LSW32_IS_FIRST);
+}
+
 /* Sideband Queue command wrappers */
 
 /**
@@ -4545,205 +4583,6 @@ ice_aq_add_rdma_qsets(struct ice_hw *hw, u8 num_qset_grps,
 
 /* End of FW Admin Queue command wrappers */
 
-/**
- * ice_pack_ctx_byte - write a byte to a packed context structure
- * @src_ctx: unpacked source context structure
- * @dest_ctx: packed destination context data
- * @ce_info: context element description
- */
-static void ice_pack_ctx_byte(u8 *src_ctx, u8 *dest_ctx,
-			      const struct ice_ctx_ele *ce_info)
-{
-	u8 src_byte, dest_byte, mask;
-	u8 *from, *dest;
-	u16 shift_width;
-
-	/* copy from the next struct field */
-	from = src_ctx + ce_info->offset;
-
-	/* prepare the bits and mask */
-	shift_width = ce_info->lsb % 8;
-	mask = GENMASK(ce_info->width - 1 + shift_width, shift_width);
-
-	src_byte = *from;
-	src_byte <<= shift_width;
-	src_byte &= mask;
-
-	/* get the current bits from the target bit string */
-	dest = dest_ctx + (ce_info->lsb / 8);
-
-	memcpy(&dest_byte, dest, sizeof(dest_byte));
-
-	dest_byte &= ~mask;	/* get the bits not changing */
-	dest_byte |= src_byte;	/* add in the new bits */
-
-	/* put it all back */
-	memcpy(dest, &dest_byte, sizeof(dest_byte));
-}
-
-/**
- * ice_pack_ctx_word - write a word to a packed context structure
- * @src_ctx: unpacked source context structure
- * @dest_ctx: packed destination context data
- * @ce_info: context element description
- */
-static void ice_pack_ctx_word(u8 *src_ctx, u8 *dest_ctx,
-			      const struct ice_ctx_ele *ce_info)
-{
-	u16 src_word, mask;
-	__le16 dest_word;
-	u8 *from, *dest;
-	u16 shift_width;
-
-	/* copy from the next struct field */
-	from = src_ctx + ce_info->offset;
-
-	/* prepare the bits and mask */
-	shift_width = ce_info->lsb % 8;
-	mask = GENMASK(ce_info->width - 1 + shift_width, shift_width);
-
-	/* don't swizzle the bits until after the mask because the mask bits
-	 * will be in a different bit position on big endian machines
-	 */
-	src_word = *(u16 *)from;
-	src_word <<= shift_width;
-	src_word &= mask;
-
-	/* get the current bits from the target bit string */
-	dest = dest_ctx + (ce_info->lsb / 8);
-
-	memcpy(&dest_word, dest, sizeof(dest_word));
-
-	dest_word &= ~(cpu_to_le16(mask));	/* get the bits not changing */
-	dest_word |= cpu_to_le16(src_word);	/* add in the new bits */
-
-	/* put it all back */
-	memcpy(dest, &dest_word, sizeof(dest_word));
-}
-
-/**
- * ice_pack_ctx_dword - write a dword to a packed context structure
- * @src_ctx: unpacked source context structure
- * @dest_ctx: packed destination context data
- * @ce_info: context element description
- */
-static void ice_pack_ctx_dword(u8 *src_ctx, u8 *dest_ctx,
-			       const struct ice_ctx_ele *ce_info)
-{
-	u32 src_dword, mask;
-	__le32 dest_dword;
-	u8 *from, *dest;
-	u16 shift_width;
-
-	/* copy from the next struct field */
-	from = src_ctx + ce_info->offset;
-
-	/* prepare the bits and mask */
-	shift_width = ce_info->lsb % 8;
-	mask = GENMASK(ce_info->width - 1 + shift_width, shift_width);
-
-	/* don't swizzle the bits until after the mask because the mask bits
-	 * will be in a different bit position on big endian machines
-	 */
-	src_dword = *(u32 *)from;
-	src_dword <<= shift_width;
-	src_dword &= mask;
-
-	/* get the current bits from the target bit string */
-	dest = dest_ctx + (ce_info->lsb / 8);
-
-	memcpy(&dest_dword, dest, sizeof(dest_dword));
-
-	dest_dword &= ~(cpu_to_le32(mask));	/* get the bits not changing */
-	dest_dword |= cpu_to_le32(src_dword);	/* add in the new bits */
-
-	/* put it all back */
-	memcpy(dest, &dest_dword, sizeof(dest_dword));
-}
-
-/**
- * ice_pack_ctx_qword - write a qword to a packed context structure
- * @src_ctx: unpacked source context structure
- * @dest_ctx: packed destination context data
- * @ce_info: context element description
- */
-static void ice_pack_ctx_qword(u8 *src_ctx, u8 *dest_ctx,
-			       const struct ice_ctx_ele *ce_info)
-{
-	u64 src_qword, mask;
-	__le64 dest_qword;
-	u8 *from, *dest;
-	u16 shift_width;
-
-	/* copy from the next struct field */
-	from = src_ctx + ce_info->offset;
-
-	/* prepare the bits and mask */
-	shift_width = ce_info->lsb % 8;
-	mask = GENMASK_ULL(ce_info->width - 1 + shift_width, shift_width);
-
-	/* don't swizzle the bits until after the mask because the mask bits
-	 * will be in a different bit position on big endian machines
-	 */
-	src_qword = *(u64 *)from;
-	src_qword <<= shift_width;
-	src_qword &= mask;
-
-	/* get the current bits from the target bit string */
-	dest = dest_ctx + (ce_info->lsb / 8);
-
-	memcpy(&dest_qword, dest, sizeof(dest_qword));
-
-	dest_qword &= ~(cpu_to_le64(mask));	/* get the bits not changing */
-	dest_qword |= cpu_to_le64(src_qword);	/* add in the new bits */
-
-	/* put it all back */
-	memcpy(dest, &dest_qword, sizeof(dest_qword));
-}
-
-/**
- * ice_set_ctx - set context bits in packed structure
- * @hw: pointer to the hardware structure
- * @src_ctx:  pointer to a generic non-packed context structure
- * @dest_ctx: pointer to memory for the packed structure
- * @ce_info: List of Rx context elements
- */
-int ice_set_ctx(struct ice_hw *hw, u8 *src_ctx, u8 *dest_ctx,
-		const struct ice_ctx_ele *ce_info)
-{
-	int f;
-
-	for (f = 0; ce_info[f].width; f++) {
-		/* We have to deal with each element of the FW response
-		 * using the correct size so that we are correct regardless
-		 * of the endianness of the machine.
-		 */
-		if (ce_info[f].width > (ce_info[f].size_of * BITS_PER_BYTE)) {
-			ice_debug(hw, ICE_DBG_QCTX, "Field %d width of %d bits larger than size of %d byte(s) ... skipping write\n",
-				  f, ce_info[f].width, ce_info[f].size_of);
-			continue;
-		}
-		switch (ce_info[f].size_of) {
-		case sizeof(u8):
-			ice_pack_ctx_byte(src_ctx, dest_ctx, &ce_info[f]);
-			break;
-		case sizeof(u16):
-			ice_pack_ctx_word(src_ctx, dest_ctx, &ce_info[f]);
-			break;
-		case sizeof(u32):
-			ice_pack_ctx_dword(src_ctx, dest_ctx, &ce_info[f]);
-			break;
-		case sizeof(u64):
-			ice_pack_ctx_qword(src_ctx, dest_ctx, &ce_info[f]);
-			break;
-		default:
-			return -EINVAL;
-		}
-	}
-
-	return 0;
-}
-
 /**
  * ice_get_lan_q_ctx - get the LAN queue context for the given VSI and TC
  * @hw: pointer to the HW struct
diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index 20bc40eec487..c4ea8ae65a95 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -292,6 +292,9 @@ config ICE
 	select DIMLIB
 	select LIBIE
 	select NET_DEVLINK
+	select PACKING
+	select PACKING_CHECK_FIELDS_20
+	select PACKING_CHECK_FIELDS_27
 	select PLDMFW
 	select DPLL
 	help

-- 
2.47.0.265.g4ca455297942


