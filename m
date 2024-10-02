Return-Path: <netdev+bounces-131380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B717398E592
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 23:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 697091F225A7
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 21:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B33D19ABD1;
	Wed,  2 Oct 2024 21:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FHbpMF26"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7759199EA3
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 21:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727905928; cv=none; b=ROT79aR1v+0ttn+VDq6BCL5jSWvMBJwkRFpG/UCPoTD+SYVe4yEjK1LxFM4lo6isIRklvmL9Tr9fTCuiBRM0My3/bYRn174YTXYLobm8RhxeELYERohTP4YZuWiZTbZZjwPpDgxIaQWAlddUzTjpdpYrONMy671N34ERNdboZ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727905928; c=relaxed/simple;
	bh=vy++shb5ncL/nVvgUxfjbJiY+nZ1X5a+bZhcxmIEiWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sPToyGDM7Dz1WOIw+JwaXbGIiodrxg3Ecbh94iDJI66m6DKr4mSl5ca6Y5p1Lkqezwi3s0CKJ8cqrSbAIefGZ+T5oFMCjc6/KStqp/HzbVROkWEYOpAJukFOWrzEfnveXPiGyuh+PqHovhd1E7YTn9YjkJnng+ZRgI6RxSl4kbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FHbpMF26; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727905927; x=1759441927;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=vy++shb5ncL/nVvgUxfjbJiY+nZ1X5a+bZhcxmIEiWs=;
  b=FHbpMF26g1tAGo7Jrx5fMaYeBuYW5/LuEcRWcvmtWqqZ4yTN9WejLQvA
   huA8kcxHGkc1YHceWcVefAr2o0y8K6OYRMEpEc3HYOQXQYshCiemLpG1e
   4rPUjY2woPk5R1+w8Soc5Ok0/3P9+uXv4YhgsUyUPCIfHtiWp2jnR0az+
   O2Asr1Szj01mGWRIKSDR6uKXCUJdnXPcxt1aQF74bOIcX0mSjjIEtlrsZ
   sErRW7UpCWUmY37Z8DYpyU89XursemVGY96yotphUoJ2M7/S1kJJJiOBb
   3hoAydmCUtkV5woqZdGZw2v2PAI8QkN/5AEsIdzfflxenLN04zc+Yimn4
   A==;
X-CSE-ConnectionGUID: +KKE3Rn3TmOXfn73xG2rIA==
X-CSE-MsgGUID: XesqyiTWSW2cHT8TsVdi0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="27262058"
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="27262058"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 14:52:01 -0700
X-CSE-ConnectionGUID: BLVg6rmSTj2nyoR/hsKjng==
X-CSE-MsgGUID: kIJq2/cgQc28Z/stQELSYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="78673915"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 14:52:00 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 02 Oct 2024 14:51:59 -0700
Subject: [PATCH net-next v2 10/10] lib: packing: use GENMASK() for box_mask
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-packing-kunit-tests-and-split-pack-unpack-v2-10-8373e551eae3@intel.com>
References: <20241002-packing-kunit-tests-and-split-pack-unpack-v2-0-8373e551eae3@intel.com>
In-Reply-To: <20241002-packing-kunit-tests-and-split-pack-unpack-v2-0-8373e551eae3@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
X-Mailer: b4 0.14.1

From: Vladimir Oltean <vladimir.oltean@nxp.com>

This is an u8, so using GENMASK_ULL() for unsigned long long is
unnecessary.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 lib/packing.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/packing.c b/lib/packing.c
index ac1f36c56a77..793942745e34 100644
--- a/lib/packing.c
+++ b/lib/packing.c
@@ -141,7 +141,7 @@ int pack(void *pbuf, u64 uval, size_t startbit, size_t endbit, size_t pbuflen,
 		proj_start_bit = ((box * BITS_PER_BYTE) + box_start_bit) - endbit;
 		proj_end_bit = ((box * BITS_PER_BYTE) + box_end_bit) - endbit;
 		proj_mask = GENMASK_ULL(proj_start_bit, proj_end_bit);
-		box_mask  = GENMASK_ULL(box_start_bit, box_end_bit);
+		box_mask = GENMASK(box_start_bit, box_end_bit);
 
 		/* Determine the offset of the u8 box inside the pbuf,
 		 * adjusted for quirks. The adjusted box_addr will be used for
@@ -249,7 +249,7 @@ int unpack(const void *pbuf, u64 *uval, size_t startbit, size_t endbit,
 		proj_start_bit = ((box * BITS_PER_BYTE) + box_start_bit) - endbit;
 		proj_end_bit = ((box * BITS_PER_BYTE) + box_end_bit) - endbit;
 		proj_mask = GENMASK_ULL(proj_start_bit, proj_end_bit);
-		box_mask  = GENMASK_ULL(box_start_bit, box_end_bit);
+		box_mask = GENMASK(box_start_bit, box_end_bit);
 
 		/* Determine the offset of the u8 box inside the pbuf,
 		 * adjusted for quirks. The adjusted box_addr will be used for

-- 
2.46.2.828.g9e56e24342b6


