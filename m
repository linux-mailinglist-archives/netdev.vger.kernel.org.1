Return-Path: <netdev+bounces-100381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4BB8FA490
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 23:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3268B1F24E13
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 21:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851C613C904;
	Mon,  3 Jun 2024 21:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JR2bGeuM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B414713C80A
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 21:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717451489; cv=none; b=MyF34rOndDTmc+KXoCg3kMZN65TqS5GZcP3lFa4i4WxqMm4YrZrvvjw3/gRgS9h0RaOI6RGFnvzFxW5lXJaj0Gjjz0235yFxr5em7pFh2amCQ+PMUafgOKgwAUUFynLWzPh8N6rLKLb5p34EUINIyVu7hwAfndyXGpbBb3I+zb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717451489; c=relaxed/simple;
	bh=nsK1xYI+tztfapzrB2bS37X2EEtBBxDd6AIioUmjrGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cIo8exKm5F6i2qLsrw0jhaLa0fLVbj1g7ICbJGmpqpmnrWT4YNCIwvOMlTF1XopuK/U4eLMcVrsT9iATMDmfsm9Cf1DpwebqVOfkf/Ai7253J8LRkcGJJEi7+fbC4qqAfetHUWz4aO57Cc8wAADAj/mJyCmHl7w4uDQNJeRPLbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JR2bGeuM; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717451488; x=1748987488;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=nsK1xYI+tztfapzrB2bS37X2EEtBBxDd6AIioUmjrGM=;
  b=JR2bGeuM2WW8RoGpCDIr1Sm4z5/Y5uj/mRLllvr2RBp0fvxdd5DK9fZh
   4SEzQakjiZ/ucZ7p01Xepos5UqZmBRi83go5oW8TGHbh9oGavUhXKqy12
   enyWNwdIWbW5rsUmMVBR9u0MB5SrIDJEv9BV3BbyBfqxUQYjzon0Xs5cE
   QRM6uiDvHbbOup1dmPIeUePtfJ6QP2GIP4FsDBaOpGqviklMu6OREs+fa
   KV8RmPkWqlrZ4UHx1PmT7PfwJyNgxM6kNDstBPNx/pt3LAU66sUXmb0aU
   u5NPhPl63CGTPJhb0dx6f0WzJJ9vfWY65zbHli0xHKqYJFh1U2dv8y/At
   g==;
X-CSE-ConnectionGUID: YOBLKlA9TiiL9ETbUYPn2g==
X-CSE-MsgGUID: F6ZmsYBUQEuw1uYCcfMQ0g==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="24547588"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="24547588"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 14:51:24 -0700
X-CSE-ConnectionGUID: upEVZdBpS1iO5ZArKoMaOw==
X-CSE-MsgGUID: 2oor2gQ+TJ2vEJ5N82xiUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37608241"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 14:51:25 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 03 Jun 2024 14:42:31 -0700
Subject: [PATCH net v2 2/6] ice: fix reads from NVM Shadow RAM on E830 and
 E825-C devices
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240603-net-2024-05-30-intel-net-fixes-v2-2-e3563aa89b0c@intel.com>
References: <20240603-net-2024-05-30-intel-net-fixes-v2-0-e3563aa89b0c@intel.com>
In-Reply-To: <20240603-net-2024-05-30-intel-net-fixes-v2-0-e3563aa89b0c@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, netdev <netdev@vger.kernel.org>, 
 David Miller <davem@davemloft.net>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Paul Greenwalt <paul.greenwalt@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
X-Mailer: b4 0.13.0

The ice driver reads data from the Shadow RAM portion of the NVM during
initialization, including data used to identify the NVM image and device,
such as the ETRACK ID used to populate devlink dev info fw.bundle.

Currently it is using a fixed offset defined by ICE_CSS_HEADER_LENGTH to
compute the appropriate offset. This worked fine for E810 and E822 devices
which both have CSS header length of 330 words.

Other devices, including both E825-C and E830 devices have different sizes
for their CSS header. The use of a hard coded value results in the driver
reading from the wrong block in the NVM when attempting to access the
Shadow RAM copy. This results in the driver reporting the fw.bundle as 0x0
in both the devlink dev info and ethtool -i output.

The first E830 support was introduced by commit ba20ecb1d1bb ("ice: Hook up
4 E830 devices by adding their IDs") and the first E825-C support was
introducted by commit f64e18944233 ("ice: introduce new E825C devices
family")

The NVM actually contains the CSS header length embedded in it. Remove the
hard coded value and replace it with logic to read the length from the NVM
directly. This is more resilient against all existing and future hardware,
vs looking up the expected values from a table. It ensures the driver will
read from the appropriate place when determining the ETRACK ID value used
for populating the fw.bundle_id and for reporting in ethtool -i.

The CSS header length for both the active and inactive flash bank is stored
in the ice_bank_info structure to avoid unnecessary duplicate work when
accessing multiple words of the Shadow RAM. Both banks are read in the
unlikely event that the header length is different for the NVM in the
inactive bank, rather than being different only by the overall device
family.

Fixes: ba20ecb1d1bb ("ice: Hook up 4 E830 devices by adding their IDs")
Co-developed-by: Paul Greenwalt <paul.greenwalt@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_nvm.c  | 88 ++++++++++++++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_type.h | 14 +++--
 2 files changed, 93 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c b/drivers/net/ethernet/intel/ice/ice_nvm.c
index ea7cbdf8492d..59e8879ac059 100644
--- a/drivers/net/ethernet/intel/ice/ice_nvm.c
+++ b/drivers/net/ethernet/intel/ice/ice_nvm.c
@@ -374,11 +374,25 @@ ice_read_nvm_module(struct ice_hw *hw, enum ice_bank_select bank, u32 offset, u1
  *
  * Read the specified word from the copy of the Shadow RAM found in the
  * specified NVM module.
+ *
+ * Note that the Shadow RAM copy is always located after the CSS header, and
+ * is aligned to 64-byte (32-word) offsets.
  */
 static int
 ice_read_nvm_sr_copy(struct ice_hw *hw, enum ice_bank_select bank, u32 offset, u16 *data)
 {
-	return ice_read_nvm_module(hw, bank, ICE_NVM_SR_COPY_WORD_OFFSET + offset, data);
+	u32 sr_copy;
+
+	switch (bank) {
+	case ICE_ACTIVE_FLASH_BANK:
+		sr_copy = roundup(hw->flash.banks.active_css_hdr_len, 32);
+		break;
+	case ICE_INACTIVE_FLASH_BANK:
+		sr_copy = roundup(hw->flash.banks.inactive_css_hdr_len, 32);
+		break;
+	}
+
+	return ice_read_nvm_module(hw, bank, sr_copy + offset, data);
 }
 
 /**
@@ -1023,6 +1037,72 @@ static int ice_determine_active_flash_banks(struct ice_hw *hw)
 	return 0;
 }
 
+/**
+ * ice_get_nvm_css_hdr_len - Read the CSS header length from the NVM CSS header
+ * @hw: pointer to the HW struct
+ * @bank: whether to read from the active or inactive flash bank
+ * @hdr_len: storage for header length in words
+ *
+ * Read the CSS header length from the NVM CSS header and add the Authentication
+ * header size, and then convert to words.
+ *
+ * Return: zero on success, or a negative error code on failure.
+ */
+static int
+ice_get_nvm_css_hdr_len(struct ice_hw *hw, enum ice_bank_select bank,
+			u32 *hdr_len)
+{
+	u16 hdr_len_l, hdr_len_h;
+	u32 hdr_len_dword;
+	int status;
+
+	status = ice_read_nvm_module(hw, bank, ICE_NVM_CSS_HDR_LEN_L,
+				     &hdr_len_l);
+	if (status)
+		return status;
+
+	status = ice_read_nvm_module(hw, bank, ICE_NVM_CSS_HDR_LEN_H,
+				     &hdr_len_h);
+	if (status)
+		return status;
+
+	/* CSS header length is in DWORD, so convert to words and add
+	 * authentication header size
+	 */
+	hdr_len_dword = hdr_len_h << 16 | hdr_len_l;
+	*hdr_len = (hdr_len_dword * 2) + ICE_NVM_AUTH_HEADER_LEN;
+
+	return 0;
+}
+
+/**
+ * ice_determine_css_hdr_len - Discover CSS header length for the device
+ * @hw: pointer to the HW struct
+ *
+ * Determine the size of the CSS header at the start of the NVM module. This
+ * is useful for locating the Shadow RAM copy in the NVM, as the Shadow RAM is
+ * always located just after the CSS header.
+ *
+ * Return: zero on success, or a negative error code on failure.
+ */
+static int ice_determine_css_hdr_len(struct ice_hw *hw)
+{
+	struct ice_bank_info *banks = &hw->flash.banks;
+	int status;
+
+	status = ice_get_nvm_css_hdr_len(hw, ICE_ACTIVE_FLASH_BANK,
+					 &banks->active_css_hdr_len);
+	if (status)
+		return status;
+
+	status = ice_get_nvm_css_hdr_len(hw, ICE_INACTIVE_FLASH_BANK,
+					 &banks->inactive_css_hdr_len);
+	if (status)
+		return status;
+
+	return 0;
+}
+
 /**
  * ice_init_nvm - initializes NVM setting
  * @hw: pointer to the HW struct
@@ -1069,6 +1149,12 @@ int ice_init_nvm(struct ice_hw *hw)
 		return status;
 	}
 
+	status = ice_determine_css_hdr_len(hw);
+	if (status) {
+		ice_debug(hw, ICE_DBG_NVM, "Failed to determine Shadow RAM copy offsets.\n");
+		return status;
+	}
+
 	status = ice_get_nvm_ver_info(hw, ICE_ACTIVE_FLASH_BANK, &flash->nvm);
 	if (status) {
 		ice_debug(hw, ICE_DBG_INIT, "Failed to read NVM info.\n");
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index f0796a93f428..eef397e5baa0 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -482,6 +482,8 @@ struct ice_bank_info {
 	u32 orom_size;				/* Size of OROM bank */
 	u32 netlist_ptr;			/* Pointer to 1st Netlist bank */
 	u32 netlist_size;			/* Size of Netlist bank */
+	u32 active_css_hdr_len;			/* Active CSS header length */
+	u32 inactive_css_hdr_len;		/* Inactive CSS header length */
 	enum ice_flash_bank nvm_bank;		/* Active NVM bank */
 	enum ice_flash_bank orom_bank;		/* Active OROM bank */
 	enum ice_flash_bank netlist_bank;	/* Active Netlist bank */
@@ -1087,17 +1089,13 @@ struct ice_aq_get_set_rss_lut_params {
 #define ICE_SR_SECTOR_SIZE_IN_WORDS	0x800
 
 /* CSS Header words */
+#define ICE_NVM_CSS_HDR_LEN_L			0x02
+#define ICE_NVM_CSS_HDR_LEN_H			0x03
 #define ICE_NVM_CSS_SREV_L			0x14
 #define ICE_NVM_CSS_SREV_H			0x15
 
-/* Length of CSS header section in words */
-#define ICE_CSS_HEADER_LENGTH			330
-
-/* Offset of Shadow RAM copy in the NVM bank area. */
-#define ICE_NVM_SR_COPY_WORD_OFFSET		roundup(ICE_CSS_HEADER_LENGTH, 32)
-
-/* Size in bytes of Option ROM trailer */
-#define ICE_NVM_OROM_TRAILER_LENGTH		(2 * ICE_CSS_HEADER_LENGTH)
+/* Length of Authentication header section in words */
+#define ICE_NVM_AUTH_HEADER_LEN			0x08
 
 /* The Link Topology Netlist section is stored as a series of words. It is
  * stored in the NVM as a TLV, with the first two words containing the type

-- 
2.44.0.53.g0f9d4d28b7e6


