Return-Path: <netdev+bounces-211528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F65B19F1E
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 11:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E7BC3A35EE
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 09:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31059244662;
	Mon,  4 Aug 2025 09:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z8j2gtI5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747161DE2DE
	for <netdev@vger.kernel.org>; Mon,  4 Aug 2025 09:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754301517; cv=none; b=V5kdhbtT0HHplyunHSPMNptJit5nJ6TAMCuDmnuIOYuvqf0AUVtmXij59wTe9o6OZzXJfYtYMXWnz17EOMAxnOaba9009laoaAB4jPRnYjdmF+y4yUj8Io1IpBP8IMZ0x4MvOIBm1ZfZUtzl5bj9cJPT7ob5xxHdpUSWpfQTI7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754301517; c=relaxed/simple;
	bh=2pgtrcDSEmLRsepPdNJTXis26cRpz8jrYFm437WcEOw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OvBsF/SDwPJseNGxc8O4qDupLr1oWmAlXJn8f80a7oXytO3kCLL2zGaVeyt7/TP5l6sW8/snuXGV0wey0x9l77Ba5hS0M3D41rvEgahLWrtvh6/FXcOe+mdKX01kjAGp8wWub4LbRDAcf6QKmnj+Pr00pSZr2GY3HZbddCbzs3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z8j2gtI5; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754301515; x=1785837515;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2pgtrcDSEmLRsepPdNJTXis26cRpz8jrYFm437WcEOw=;
  b=Z8j2gtI5kXfNLSwgUhPsCTsKIMduL8rFnlLNp5hOYOiHJSxO21dIjIaS
   uRLOxJaR5Y6Z6ESAj/zOzBfgoxMH/KccPQDVY3l1c2AK85pgDQ+CjzvUn
   uvleqEsTet1f3yJX0uut4d1RfOnMH87vTUBADGqIppIoFUm5WHLs4XKH6
   jgPSawSekp57O+2D9AIYcmmd0sFvbBJeaVJ5DosJzPQ4C7VCqpas/sBz+
   J2GZ6L3nfjQaMQt7SYr0sBc/KueNrioIr/UrvwydXfSYEF50zdXkXvs3C
   SM3LSfMMK/Gr1cbSl52MD2R5LTmM13F6DM9S90INTgt6JKPJNC89nfzmL
   A==;
X-CSE-ConnectionGUID: CVrYg8VESSuYMTctstcxkQ==
X-CSE-MsgGUID: +hwHnlcnThWtqbXZ2bdNSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11511"; a="79114157"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="79114157"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 02:58:35 -0700
X-CSE-ConnectionGUID: 87q1Cmi0SSKdY643tgYUsQ==
X-CSE-MsgGUID: E2tetukrRWCq1CzHSeDnMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="168304594"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmviesa003.fm.intel.com with ESMTP; 04 Aug 2025 02:58:32 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH iwl-next v2] ixgbe: reduce number of reads when getting OROM data
Date: Mon,  4 Aug 2025 11:41:56 +0200
Message-Id: <20250804094156.1690216-1-jedrzej.jagielski@intel.com>
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

Without this patch probing time may exceed over 25s, whereas with this
patch applied avrege time of probe is not greter than 5s.

without the patch:
[14:12:22] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[14:12:25] ixgbe 0000:21:00.0: Multiqueue Enabled: Rx Queue count = 63, Tx Queue count = 63 XDP Queue count = 0
[14:12:25] ixgbe 0000:21:00.0: 63.012 Gb/s available PCIe bandwidth (16.0 GT/s PCIe x4 link)
[14:12:26] ixgbe 0000:21:00.0: MAC: 7, PHY: 27, PBA No: N55484-001
[14:12:26] ixgbe 0000:21:00.0: 20:3a:43:09:3a:12
[14:12:26] ixgbe 0000:21:00.0: Intel(R) 10 Gigabit Network Connection
[14:12:50] ixgbe 0000:21:00.0 ens2f0np0: renamed from eth0

with the patch:
[14:18:18] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[14:18:19] ixgbe 0000:21:00.0: Multiqueue Enabled: Rx Queue count = 63, Tx Queue count = 63 XDP Queue count = 0
[14:18:19] ixgbe 0000:21:00.0: 63.012 Gb/s available PCIe bandwidth (16.0 GT/s PCIe x4 link)
[14:18:19] ixgbe 0000:21:00.0: MAC: 7, PHY: 27, PBA No: N55484-001
[14:18:19] ixgbe 0000:21:00.0: 20:3a:43:09:3a:12
[14:18:19] ixgbe 0000:21:00.0: Intel(R) 10 Gigabit Network Connection
[14:18:22] ixgbe 0000:21:00.0 ens2f0np0: renamed from eth0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
v2: extend the commit msg; minor code tweaks
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 59 +++++++++++++------
 1 file changed, 40 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 87b03c1992a8..db01b088e4a1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -3006,50 +3006,71 @@ static int ixgbe_get_nvm_srev(struct ixgbe_hw *hw,
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
+	for (offset = 0; offset + SZ_512 <= orom_size; offset += SZ_512) {
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
+
+		if (sum) {
+			err = -EDOM;
+			goto cleanup;
+		}
 
-		if (sum)
-			return -EDOM;
+		*civd = *tmp;
+		err = 0;
 
-		*civd = tmp;
-		return 0;
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


