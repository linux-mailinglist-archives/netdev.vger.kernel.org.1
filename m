Return-Path: <netdev+bounces-100380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9EF8FA48F
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 23:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87E1E283952
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 21:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB2713C8F3;
	Mon,  3 Jun 2024 21:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L9Qg8KSV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F7513C698
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 21:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717451489; cv=none; b=gJGgTRYh0iWxQS4BTLiZpAz75e1eGA24NpPnkQ9ZG1JtvZc+g5MtyellX+uNMT6z14Bs/QxAknqzyjIIO3FqHbP3s1AYdl/K5X7UdannCXzxi8EXTQ9rQxCQvRpEqzbRcA5BFcZj/J8jJyEMreseRKi9q6tJ6F2b/wGqlP9pbc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717451489; c=relaxed/simple;
	bh=qdfHg9PVaUpjIO/0BQdzZcKwKbR09sOoGurrihtN+d0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o4opr4y2Z4CrTfW7Eiq814sV5Ok0p2Azyba3gTQnOxeh6s4uOjiaMp14dIyvp9i0/LbDOS6nEDE987C6bpJ2qDL9FU4huDNIE9A1vpxnQV8VyR6nzwgbFqzg1ZifPBXs6MyQ9s7DkrfNhdSwtBEZK7yHgfw/pxvkCnOAjDTwQjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L9Qg8KSV; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717451487; x=1748987487;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=qdfHg9PVaUpjIO/0BQdzZcKwKbR09sOoGurrihtN+d0=;
  b=L9Qg8KSVWgNwhFfxcB4NypKAihyHTAbvrhIKw22lExeaWrddjM/rZ04F
   kgcHaxIlipyj6f+1NhWVMkqJpG+4Mrca1uVIcTsXGI7jNhzgnAJ9ZYR9X
   JEEN+1jgDCI2vlI0qxzWRUNVPtKNJTNYTTjweDEz9MxFKQcUj09MbBEJr
   edrSahf43Ovi7e/x564tfTMnNcxdv5MzdLdXk1s0pXO5HQr1eT0Z7OJ/W
   ykPkFwQyZqDAFDZdpx59oYeRQ/c/6n8EVGi131os+IpJZ7Uel76q1Gifs
   hkj8s2CSs4YojGipmvmYtxsuSILvxRP/W2EIWGKjB0yHDGKfD+m/HxrkV
   A==;
X-CSE-ConnectionGUID: 5n/MSV1UQBqoy6odJjASUg==
X-CSE-MsgGUID: 6JP4mHiPSGaonO/JVe2n/w==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="24547585"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="24547585"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 14:51:24 -0700
X-CSE-ConnectionGUID: S7w0WHGQQHyYyoUXVFtNMg==
X-CSE-MsgGUID: hatJIWClTwqBjVna7zaKSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37608238"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 14:51:25 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 03 Jun 2024 14:42:30 -0700
Subject: [PATCH net v2 1/6] ice: fix iteration of TLVs in Preserved Fields
 Area
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240603-net-2024-05-30-intel-net-fixes-v2-1-e3563aa89b0c@intel.com>
References: <20240603-net-2024-05-30-intel-net-fixes-v2-0-e3563aa89b0c@intel.com>
In-Reply-To: <20240603-net-2024-05-30-intel-net-fixes-v2-0-e3563aa89b0c@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, netdev <netdev@vger.kernel.org>, 
 David Miller <davem@davemloft.net>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Paul Greenwalt <paul.greenwalt@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
X-Mailer: b4 0.13.0

The ice_get_pfa_module_tlv() function iterates over the Type-Length-Value
structures in the Preserved Fields Area (PFA) of the NVM. This is used by
the driver to access data such as the Part Board Assembly identifier.

The function uses simple logic to iterate over the PFA. First, the pointer
to the PFA in the NVM is read. Then the total length of the PFA is read
from the first word.

A pointer to the first TLV is initialized, and a simple loop iterates over
each TLV. The pointer is moved forward through the NVM until it exceeds the
PFA area.

The logic seems sound, but it is missing a key detail. The Preserved
Fields Area length includes one additional final word. This is documented
in the device data sheet as a dummy word which contains 0xFFFF. All NVMs
have this extra word.

If the driver tries to scan for a TLV that is not in the PFA, it will read
past the size of the PFA. It reads and interprets the last dummy word of
the PFA as a TLV with type 0xFFFF. It then reads the word following the PFA
as a length.

The PFA resides within the Shadow RAM portion of the NVM, which is
relatively small. All of its offsets are within a 16-bit size. The PFA
pointer and TLV pointer are stored by the driver as 16-bit values.

In almost all cases, the word following the PFA will be such that
interpreting it as a length will result in 16-bit arithmetic overflow. Once
overflowed, the new next_tlv value is now below the maximum offset of the
PFA. Thus, the driver will continue to iterate the data as TLVs. In the
worst case, the driver hits on a sequence of reads which loop back to
reading the same offsets in an endless loop.

To fix this, we need to correct the loop iteration check to account for
this extra word at the end of the PFA. This alone is sufficient to resolve
the known cases of this issue in the field. However, it is plausible that
an NVM could be misconfigured or have corrupt data which results in the
same kind of overflow. Protect against this by using check_add_overflow
when calculating both the maximum offset of the TLVs, and when calculating
the next_tlv offset at the end of each loop iteration. This ensures that
the driver will not get stuck in an infinite loop when scanning the PFA.

Fixes: e961b679fb0b ("ice: add board identifier info to devlink .info_get")
Co-developed-by: Paul Greenwalt <paul.greenwalt@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_nvm.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c b/drivers/net/ethernet/intel/ice/ice_nvm.c
index 84eab92dc03c..ea7cbdf8492d 100644
--- a/drivers/net/ethernet/intel/ice/ice_nvm.c
+++ b/drivers/net/ethernet/intel/ice/ice_nvm.c
@@ -440,8 +440,7 @@ int
 ice_get_pfa_module_tlv(struct ice_hw *hw, u16 *module_tlv, u16 *module_tlv_len,
 		       u16 module_type)
 {
-	u16 pfa_len, pfa_ptr;
-	u16 next_tlv;
+	u16 pfa_len, pfa_ptr, next_tlv, max_tlv;
 	int status;
 
 	status = ice_read_sr_word(hw, ICE_SR_PFA_PTR, &pfa_ptr);
@@ -454,11 +453,23 @@ ice_get_pfa_module_tlv(struct ice_hw *hw, u16 *module_tlv, u16 *module_tlv_len,
 		ice_debug(hw, ICE_DBG_INIT, "Failed to read PFA length.\n");
 		return status;
 	}
+
+	/* The Preserved Fields Area contains a sequence of Type-Length-Value
+	 * structures which define its contents. The PFA length includes all
+	 * of the TLVs, plus the initial length word itself, *and* one final
+	 * word at the end after all of the TLVs.
+	 */
+	if (check_add_overflow(pfa_ptr, pfa_len - 1, &max_tlv)) {
+		dev_warn(ice_hw_to_dev(hw), "PFA starts at offset %u. PFA length of %u caused 16-bit arithmetic overflow.\n",
+			 pfa_ptr, pfa_len);
+		return -EINVAL;
+	}
+
 	/* Starting with first TLV after PFA length, iterate through the list
 	 * of TLVs to find the requested one.
 	 */
 	next_tlv = pfa_ptr + 1;
-	while (next_tlv < pfa_ptr + pfa_len) {
+	while (next_tlv < max_tlv) {
 		u16 tlv_sub_module_type;
 		u16 tlv_len;
 
@@ -482,10 +493,13 @@ ice_get_pfa_module_tlv(struct ice_hw *hw, u16 *module_tlv, u16 *module_tlv_len,
 			}
 			return -EINVAL;
 		}
-		/* Check next TLV, i.e. current TLV pointer + length + 2 words
-		 * (for current TLV's type and length)
-		 */
-		next_tlv = next_tlv + tlv_len + 2;
+
+		if (check_add_overflow(next_tlv, 2, &next_tlv) ||
+		    check_add_overflow(next_tlv, tlv_len, &next_tlv)) {
+			dev_warn(ice_hw_to_dev(hw), "TLV of type %u and length 0x%04x caused 16-bit arithmetic overflow. The PFA starts at 0x%04x and has length of 0x%04x\n",
+				 tlv_sub_module_type, tlv_len, pfa_ptr, pfa_len);
+			return -EINVAL;
+		}
 	}
 	/* Module does not exist */
 	return -ENOENT;

-- 
2.44.0.53.g0f9d4d28b7e6


