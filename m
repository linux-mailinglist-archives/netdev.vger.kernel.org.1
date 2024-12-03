Return-Path: <netdev+bounces-148269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D57B69E0FA7
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 01:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37E71B228D7
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 00:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6A92500C3;
	Tue,  3 Dec 2024 00:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DOIhrt8t"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AAB1FC8
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 00:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733185602; cv=none; b=Qqv3MP9AalerusZC1iaNMbYV7wgCPTvRFdtc8S7lzydKVOl3179zgK+d5plDJ2AThBA1E5OH1pQxFg7veEWQ/pZScQQmGZvVn4w2SvJYuKvlebgdQahCvyp3Eifvk5DAULHKV/3hSlvLRW8kFOJnELtFOK3ovKC84P0slkNfJ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733185602; c=relaxed/simple;
	bh=XhsEpmeQvNBuLUg+gz9/qFdnGju97lVMbfk6QdiBV68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z9yrzZ8ze+M3yOlIfW+ZK+8R2dDFBxROTpIzgN13PZzGtm0IzEXc88jA5AgpCPWQLnil4sCLoWEIFuLpZyV5DenVkAvaszD3697+XL/FSyrg04lVZQt6b+t4nHONcOV5Jz2CneTaLMKaXJ5aOAaZQvJOnuROwniYzgvFIed1Wok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DOIhrt8t; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733185601; x=1764721601;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=XhsEpmeQvNBuLUg+gz9/qFdnGju97lVMbfk6QdiBV68=;
  b=DOIhrt8tK68ceDgvANPT7O294hS76FZU0osPJGDEmq9JDavBWSquMjuf
   deJItZITIzniFSg7na7K8Wrf3Ba2vXaR54TVmulgmXdmGnPV3l7Q4PPf0
   pkxEb0lN8UgZLG++M0NhIWbwN32oo52gQs6TnmLPGLaqV6fTASdaR0h9r
   QiF4peUj3suLb2JeuxBmOL6EYxzP04PFZofhSkoUr5GgWh9lZn7JnYadM
   pVVNHDZH1xBSYDmfG/PaiGadC+1UHwwX8lW00eMMnfXcpEBLLEC0HQ1yc
   06gZ9DWdK4Ql1y3zYSPBf2DWI3/iIl7N0XSNVXhmAdr23lfQMVTbf7NEU
   w==;
X-CSE-ConnectionGUID: ypOkMRJTT6SgDglDRrNixQ==
X-CSE-MsgGUID: icSEyXdsRhqBqAkQmiHXyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33509727"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="33509727"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 16:26:39 -0800
X-CSE-ConnectionGUID: pXiBlHugSf2qN01erGsyuA==
X-CSE-MsgGUID: tys+UbcJQ+6l6kiCGrglFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="93454783"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 16:26:39 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 02 Dec 2024 16:26:25 -0800
Subject: [PATCH net-next v7 2/9] lib: packing: demote truncation error in
 pack() to a warning in __pack()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-packing-pack-fields-and-ice-implementation-v7-2-ed22e38e6c65@intel.com>
References: <20241202-packing-pack-fields-and-ice-implementation-v7-0-ed22e38e6c65@intel.com>
In-Reply-To: <20241202-packing-pack-fields-and-ice-implementation-v7-0-ed22e38e6c65@intel.com>
To: Vladimir Oltean <olteanv@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Masahiro Yamada <masahiroy@kernel.org>, netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
X-Mailer: b4 0.14.2

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Most of the sanity checks in pack() and unpack() can be covered at
compile time. There is only one exception, and that is truncation of the
uval during a pack() operation.

We'd like the error-less __pack() to catch that condition as well. But
at the same time, it is currently the responsibility of consumer drivers
(currently just sja1105) to print anything at all when this error
occurs, and then discard the return code.

We can just print a loud warning in the library code and continue with
the truncated __pack() operation. In practice, having the warning is
very important, see commit 24deec6b9e4a ("net: dsa: sja1105: disallow
C45 transactions on the BASE-TX MDIO bus") where the bug was caught
exactly by noticing this print.

Add the first print to the packing library, and at the same time remove
the print for the same condition from the sja1105 driver, to avoid
double printing.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/sja1105/sja1105_static_config.c |  8 ++------
 lib/packing.c                                   | 26 ++++++++++---------------
 2 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_static_config.c b/drivers/net/dsa/sja1105/sja1105_static_config.c
index baba204ad62f6b507a6ccf3337248dd02b777249..3d790f8c6f4dab3640ede014345ef469fefb7085 100644
--- a/drivers/net/dsa/sja1105/sja1105_static_config.c
+++ b/drivers/net/dsa/sja1105/sja1105_static_config.c
@@ -26,12 +26,8 @@ void sja1105_pack(void *buf, const u64 *val, int start, int end, size_t len)
 		pr_err("Start bit (%d) expected to be larger than end (%d)\n",
 		       start, end);
 	} else if (rc == -ERANGE) {
-		if ((start - end + 1) > 64)
-			pr_err("Field %d-%d too large for 64 bits!\n",
-			       start, end);
-		else
-			pr_err("Cannot store %llx inside bits %d-%d (would truncate)\n",
-			       *val, start, end);
+		pr_err("Field %d-%d too large for 64 bits!\n",
+		       start, end);
 	}
 	dump_stack();
 }
diff --git a/lib/packing.c b/lib/packing.c
index f237b8af99f5fa8e839c38126769c50b2bfe6361..09a2d195b9433b61c86f3b63ff019ab319c83e97 100644
--- a/lib/packing.c
+++ b/lib/packing.c
@@ -59,8 +59,17 @@ static void __pack(void *pbuf, u64 uval, size_t startbit, size_t endbit,
 	 */
 	int plogical_first_u8 = startbit / BITS_PER_BYTE;
 	int plogical_last_u8 = endbit / BITS_PER_BYTE;
+	int value_width = startbit - endbit + 1;
 	int box;
 
+	/* Check if "uval" fits in "value_width" bits.
+	 * The test only works for value_width < 64, but in the latter case,
+	 * any 64-bit uval will surely fit.
+	 */
+	WARN(value_width < 64 && uval >= (1ull << value_width),
+	     "Cannot store 0x%llx inside bits %zu-%zu - will truncate\n",
+	     uval, startbit, endbit);
+
 	/* Iterate through an idealistic view of the pbuf as an u64 with
 	 * no quirks, u8 by u8 (aligned at u8 boundaries), from high to low
 	 * logical bit significance. "box" denotes the current logical u8.
@@ -143,9 +152,6 @@ static void __pack(void *pbuf, u64 uval, size_t startbit, size_t endbit,
 int pack(void *pbuf, u64 uval, size_t startbit, size_t endbit, size_t pbuflen,
 	 u8 quirks)
 {
-	/* width of the field to access in the pbuf */
-	u64 value_width;
-
 	/* startbit is expected to be larger than endbit, and both are
 	 * expected to be within the logically addressable range of the buffer.
 	 */
@@ -153,19 +159,7 @@ int pack(void *pbuf, u64 uval, size_t startbit, size_t endbit, size_t pbuflen,
 		/* Invalid function call */
 		return -EINVAL;
 
-	value_width = startbit - endbit + 1;
-	if (unlikely(value_width > 64))
-		return -ERANGE;
-
-	/* Check if "uval" fits in "value_width" bits.
-	 * If value_width is 64, the check will fail, but any
-	 * 64-bit uval will surely fit.
-	 */
-	if (value_width < 64 && uval >= (1ull << value_width))
-		/* Cannot store "uval" inside "value_width" bits.
-		 * Truncating "uval" is most certainly not desirable,
-		 * so simply erroring out is appropriate.
-		 */
+	if (unlikely(startbit - endbit >= 64))
 		return -ERANGE;
 
 	__pack(pbuf, uval, startbit, endbit, pbuflen, quirks);

-- 
2.47.0.265.g4ca455297942


