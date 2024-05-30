Return-Path: <netdev+bounces-99502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E608D5122
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 19:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01FD32859AD
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 17:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AB8481B8;
	Thu, 30 May 2024 17:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G/amJ4+7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BA34655F
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 17:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717090807; cv=none; b=Zs1LlwZpWPQj7HxE2EsmRsI9FtFOPp0J94/tovgjL/Yl2K55kWlCet7B3h80GnAb9qB9OAf/DfWnUWDXYOSg/kE7PCOgGGt/Gaw+cmhOkl0S+v+P4MBK9Vg8FtiY4iXCjE5xErvu9ulFgRb9Ash618GrHoq4fQ3MUDX5Gf79jUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717090807; c=relaxed/simple;
	bh=nsK1xYI+tztfapzrB2bS37X2EEtBBxDd6AIioUmjrGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g8w8ieENsuEKl1/JX7h6lc+hxy/bVPg0mmxb2N+QDWujLgwY6G6noQZlrK1Audcxj/W2eGvsoMKqce9Q7QBm4h361Y0ck9fUAoDnOLb4wcdpUiIVBMQTjSML4hzyBpbajiqzKOfIiakpBBAU1RRftr/X6JY/6e8v2xqpF9TQU4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G/amJ4+7; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717090805; x=1748626805;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=nsK1xYI+tztfapzrB2bS37X2EEtBBxDd6AIioUmjrGM=;
  b=G/amJ4+7Am+NEUvMPoD5rzjDjTRehodBRUTfgepAXKlajQGwPK7Jmj31
   QIHanDAU5Jdv8EMo2qwlLvJiAQCv6FONist9GxB3S1f1I3Wp5BL3LRowC
   0T/gP0rqS8FlswX3BT9ogpyPnfwQ24i+9V7JyjPMA2Hi5Fkw51BTOnqzL
   B4NuOD74MWNEiSTCqVVAUoUpZ/Zh8NjF4Vh61dlBdpfgR6SLt9MkFbyh2
   ngDGoJFPkUUY2EwaPtF2nTV7GUdl8sF5fxfQX0ATWs4ysQBnV/jP42piw
   iYKYhOndJu8BGb6yujSI5bxymC/3kX/risNcASjVwJyOdBki/9mlmuVjS
   w==;
X-CSE-ConnectionGUID: WbD+IoSRT62gZtqQKd1uKA==
X-CSE-MsgGUID: fE7Du/JdSp2+NfrQSs+pDA==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="31119258"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="31119258"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 10:40:02 -0700
X-CSE-ConnectionGUID: CE8nTLkCS62zaVmMtZK6Pg==
X-CSE-MsgGUID: 8Z5kP8PUQfWwRbkr2x8AAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="66766673"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 10:40:02 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 30 May 2024 10:39:29 -0700
Subject: [PATCH net 2/6] ice: fix reads from NVM Shadow RAM on E830 and
 E825-C devices
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-net-2024-05-30-intel-net-fixes-v1-2-8b11c8c9bff8@intel.com>
References: <20240530-net-2024-05-30-intel-net-fixes-v1-0-8b11c8c9bff8@intel.com>
In-Reply-To: <20240530-net-2024-05-30-intel-net-fixes-v1-0-8b11c8c9bff8@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>, 
 netdev <netdev@vger.kernel.org>
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


