Return-Path: <netdev+bounces-211194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B598B171C2
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 15:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7576E7AF703
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 13:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C182C08DB;
	Thu, 31 Jul 2025 13:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EBEoJWTy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2081322F765
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 13:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753967224; cv=none; b=GSZoinzbb2ktDc+3zr0gK5k1+5x7Gtoo81b0li1a/ryWt0PRQyunHA1MkMRdWJDLLsOZO7HKdE/F/y5/UD62H5huNg0rXzt+ZHJVkLtNzlAaml1a2pFrkgE3MvfeBtqha+gs/M1GCF3HA0o4l1RfdbXmOqeJl4Anzh/KuatxtuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753967224; c=relaxed/simple;
	bh=l0vq5qn3at3NW29rFgCNYsWN3p9fceKGmmZzgwuLhdc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R+MCYCF2mZuF7GjAVbR4MeVP7zLEQgBhLX3jlfHbuc85mjhHIwrYmK6n2LvjG3yKsnF9MBVvhX+5Mea96Mn+MH+IozhjFwDiB6x18Qfvse/ETlsf2wZiGcO26YdoketQmLYKD3U2ft/ealNwH/8a0lk1L5QNUy7iFh3x8diskRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EBEoJWTy; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753967223; x=1785503223;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l0vq5qn3at3NW29rFgCNYsWN3p9fceKGmmZzgwuLhdc=;
  b=EBEoJWTyQdqBscC/79P0tX4XSCE+bIsD3JRoIs0tpWK6JUjzzeHzMmKk
   dZQV8SRuz+BVoNgIyIefpA4O1fkxv9cumzMHCDf1B78bRpmz8fP3qFAaM
   bon8C8jcQGSx+KZwbrE9sPBz695Vob6A/X9wkgmJydK+zrH+3k+YHr+4W
   FQ4fSXK025sLCANs++a/Ld/g1CEuw9s6LbPxeQY4QXpZYxEO67l8gNelg
   9g6HCUwi41joReyQeWjYihGip7V2SwqH0XqVaH8tfE1DVPLl++bWh54Hg
   q9mkejWA5QItVPcGPOjFbicGklDS5qcmRvDS1MOYrk3dv8CUm4L1/WGXt
   g==;
X-CSE-ConnectionGUID: aVEeQ1SARvuw79cGzoRzYg==
X-CSE-MsgGUID: T1E/GNqzRd6Cf+gcfLd+KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="56369459"
X-IronPort-AV: E=Sophos;i="6.17,353,1747724400"; 
   d="scan'208";a="56369459"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 06:07:02 -0700
X-CSE-ConnectionGUID: 4a3x4C4QTHSFoiHq+4lgTw==
X-CSE-MsgGUID: 5RfmKOz4TMyEtqun6eJwCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,353,1747724400"; 
   d="scan'208";a="163704405"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmviesa008.fm.intel.com with ESMTP; 31 Jul 2025 06:07:01 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v1] ixgbe: reduce number of reads when getting OROM data
Date: Thu, 31 Jul 2025 14:50:25 +0200
Message-Id: <20250731125025.1683557-1-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, during locating the CIVD section, the ixgbe driver loops
over the OROM area and at each iteration reads only OROM-datastruct-size
amount of data. This results in many small reads and is inefficient.

Optimize this by reading the entire OROM bank into memory once before
entering the loop. This significantly reduces the probing time.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 58 +++++++++++++------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 87b03c1992a8..048b2aae155a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -3006,50 +3006,70 @@ static int ixgbe_get_nvm_srev(struct ixgbe_hw *hw,
  * Searches through the Option ROM flash contents to locate the CIVD data for
  * the image.
  *
- * Return: the exit code of the operation.
+ * Return: -ENOMEM when cannot allocate memory, -EDOM for checksum violation,
+ *	   -ENODATA when cannot find proper data, -EIO for faulty read or
+ *	   0 on success.
+ *
+ *	   On success @civd stores collected data.
  */
 static int
 ixgbe_get_orom_civd_data(struct ixgbe_hw *hw, enum ixgbe_bank_select bank,
 			 struct ixgbe_orom_civd_info *civd)
 {
-	struct ixgbe_orom_civd_info tmp;
+	u32 orom_size = hw->flash.banks.orom_size;
+	u8 *orom_data;
 	u32 offset;
 	int err;
 
+	orom_data = kzalloc(orom_size, GFP_KERNEL);
+	if (!orom_data)
+		return -ENOMEM;
+
+	err = ixgbe_read_flash_module(hw, bank,
+				      IXGBE_E610_SR_1ST_OROM_BANK_PTR, 0,
+				      orom_data, orom_size);
+	if (err) {
+		err = -EIO;
+		goto cleanup;
+	}
+
 	/* The CIVD section is located in the Option ROM aligned to 512 bytes.
 	 * The first 4 bytes must contain the ASCII characters "$CIV".
 	 * A simple modulo 256 sum of all of the bytes of the structure must
 	 * equal 0.
 	 */
-	for (offset = 0; (offset + SZ_512) <= hw->flash.banks.orom_size;
-	     offset += SZ_512) {
+	for (offset = 0; (offset + SZ_512) <= orom_size; offset += SZ_512) {
+		struct ixgbe_orom_civd_info *tmp;
 		u8 sum = 0;
 		u32 i;
 
-		err = ixgbe_read_flash_module(hw, bank,
-					      IXGBE_E610_SR_1ST_OROM_BANK_PTR,
-					      offset,
-					      (u8 *)&tmp, sizeof(tmp));
-		if (err)
-			return err;
+		BUILD_BUG_ON(sizeof(*tmp) > SZ_512);
+
+		tmp = (struct ixgbe_orom_civd_info *)&orom_data[offset];
 
 		/* Skip forward until we find a matching signature */
-		if (memcmp(IXGBE_OROM_CIV_SIGNATURE, tmp.signature,
-			   sizeof(tmp.signature)))
+		if (memcmp(IXGBE_OROM_CIV_SIGNATURE, tmp->signature,
+			   sizeof(tmp->signature)))
 			continue;
 
 		/* Verify that the simple checksum is zero */
-		for (i = 0; i < sizeof(tmp); i++)
-			sum += ((u8 *)&tmp)[i];
+		for (i = 0; i < sizeof(*tmp); i++)
+			sum += ((u8 *)tmp)[i];
 
-		if (sum)
-			return -EDOM;
+		if (sum) {
+			err = -EDOM;
+			goto cleanup;
+		}
 
-		*civd = tmp;
-		return 0;
+		*civd = *tmp;
+		err = 0;
+		goto cleanup;
 	}
 
-	return -ENODATA;
+	err = -ENODATA;
+cleanup:
+	kfree(orom_data);
+	return err;
 }
 
 /**
-- 
2.31.1


