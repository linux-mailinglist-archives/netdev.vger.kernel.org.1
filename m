Return-Path: <netdev+bounces-131379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA3E98E591
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 23:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A5C286BE8
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 21:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270A419CC26;
	Wed,  2 Oct 2024 21:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FX4Z3UQa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5A119ABD1
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 21:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727905927; cv=none; b=AlLRyBDHzLPcU1idihk5y9w/XkNuzM0jLtJ9b7nQXqexNOg8T7F2CBpgnC4hSIk8hZ3v5biQUbvFqb4d3I7hf7auHXqhrBE0yOhTEf5EiMu6v/OMwvn81uasOM3/LYv2/kgh8T1OCO6ft/dUi9LsTYEDxrtzoIa4PQjb7ndzhV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727905927; c=relaxed/simple;
	bh=xxfE0zIJdsxCAM61V+h/iAbbvPnxOfTiWpWlW4/yhlU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u4f9tLXS/u2YJaQwEqZ4jKO/cIUQBxQ2Q3rl7BvZ5bAgL7ToTRPlBfDv0xVdQLmdKrCqg85Ds8xgMTYlTxS3N7HXElCujQhrSIVAr353uXlosM6yrmG9Lxi1XFC0+EaoLTeXnYPm0f3JBD4Vv3Lys/8C0DwEux+9yw8JAg6tRqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FX4Z3UQa; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727905925; x=1759441925;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=xxfE0zIJdsxCAM61V+h/iAbbvPnxOfTiWpWlW4/yhlU=;
  b=FX4Z3UQa/YPOBT0fPYF70OdWtm2Cu36IslUnGh5JpXlqpRxNBIHo7Imy
   OlbrKNeUQw/KbCIBSBED39OZRWErj14CC9lkORHINX81xC0xdqgeBxjKu
   JX8G4J7Rr3eqU7UyjrCnyaagsFdFSXp5yDVEpj9MWIuztPJVG1xRv9FHY
   tA8WxQvbvbvWfzckrpv9hcDBCTn2UlxK+UDUxtD55/ROU0ltoQ9Ps5nj9
   BjB42gK23Ju1kYcE8LUmTRSl+i8Q+tUlsJAT6sYwaf8z3eNUhEcpb1dOG
   idhv7wsXqF3K30d5S9i38c/OYwtLE/yIyg96nz2ePSthocSlX1g5MIp79
   Q==;
X-CSE-ConnectionGUID: 3tXYPxYuSc+f3CLgtayo+Q==
X-CSE-MsgGUID: ARYHiA84TJCUwHvBIWMOdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="27262053"
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="27262053"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 14:52:01 -0700
X-CSE-ConnectionGUID: 4xJxEhvGTUawHyj7HyvIxg==
X-CSE-MsgGUID: FuVpan78S0mMsH+lwllvyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="78673909"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 14:52:00 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 02 Oct 2024 14:51:58 -0700
Subject: [PATCH net-next v2 09/10] lib: packing: use BITS_PER_BYTE instead
 of 8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-packing-kunit-tests-and-split-pack-unpack-v2-9-8373e551eae3@intel.com>
References: <20241002-packing-kunit-tests-and-split-pack-unpack-v2-0-8373e551eae3@intel.com>
In-Reply-To: <20241002-packing-kunit-tests-and-split-pack-unpack-v2-0-8373e551eae3@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
X-Mailer: b4 0.14.1

From: Vladimir Oltean <vladimir.oltean@nxp.com>

This helps clarify what the 8 is for.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 lib/packing.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/lib/packing.c b/lib/packing.c
index 9efe57d347c7..ac1f36c56a77 100644
--- a/lib/packing.c
+++ b/lib/packing.c
@@ -83,7 +83,7 @@ int pack(void *pbuf, u64 uval, size_t startbit, size_t endbit, size_t pbuflen,
 	/* startbit is expected to be larger than endbit, and both are
 	 * expected to be within the logically addressable range of the buffer.
 	 */
-	if (unlikely(startbit < endbit || startbit >= 8 * pbuflen))
+	if (unlikely(startbit < endbit || startbit >= BITS_PER_BYTE * pbuflen))
 		/* Invalid function call */
 		return -EINVAL;
 
@@ -106,8 +106,8 @@ int pack(void *pbuf, u64 uval, size_t startbit, size_t endbit, size_t pbuflen,
 	 * no quirks, u8 by u8 (aligned at u8 boundaries), from high to low
 	 * logical bit significance. "box" denotes the current logical u8.
 	 */
-	plogical_first_u8 = startbit / 8;
-	plogical_last_u8  = endbit / 8;
+	plogical_first_u8 = startbit / BITS_PER_BYTE;
+	plogical_last_u8  = endbit / BITS_PER_BYTE;
 
 	for (box = plogical_first_u8; box >= plogical_last_u8; box--) {
 		/* Bit indices into the currently accessed 8-bit box */
@@ -123,11 +123,11 @@ int pack(void *pbuf, u64 uval, size_t startbit, size_t endbit, size_t pbuflen,
 		 * input arguments startbit and endbit.
 		 */
 		if (box == plogical_first_u8)
-			box_start_bit = startbit % 8;
+			box_start_bit = startbit % BITS_PER_BYTE;
 		else
 			box_start_bit = 7;
 		if (box == plogical_last_u8)
-			box_end_bit = endbit % 8;
+			box_end_bit = endbit % BITS_PER_BYTE;
 		else
 			box_end_bit = 0;
 
@@ -138,8 +138,8 @@ int pack(void *pbuf, u64 uval, size_t startbit, size_t endbit, size_t pbuflen,
 		 * box is u8, the projection is u64 because it may fall
 		 * anywhere within the unpacked u64.
 		 */
-		proj_start_bit = ((box * 8) + box_start_bit) - endbit;
-		proj_end_bit   = ((box * 8) + box_end_bit) - endbit;
+		proj_start_bit = ((box * BITS_PER_BYTE) + box_start_bit) - endbit;
+		proj_end_bit = ((box * BITS_PER_BYTE) + box_end_bit) - endbit;
 		proj_mask = GENMASK_ULL(proj_start_bit, proj_end_bit);
 		box_mask  = GENMASK_ULL(box_start_bit, box_end_bit);
 
@@ -199,7 +199,7 @@ int unpack(const void *pbuf, u64 *uval, size_t startbit, size_t endbit,
 	/* startbit is expected to be larger than endbit, and both are
 	 * expected to be within the logically addressable range of the buffer.
 	 */
-	if (unlikely(startbit < endbit || startbit >= 8 * pbuflen))
+	if (unlikely(startbit < endbit || startbit >= BITS_PER_BYTE * pbuflen))
 		/* Invalid function call */
 		return -EINVAL;
 
@@ -214,8 +214,8 @@ int unpack(const void *pbuf, u64 *uval, size_t startbit, size_t endbit,
 	 * no quirks, u8 by u8 (aligned at u8 boundaries), from high to low
 	 * logical bit significance. "box" denotes the current logical u8.
 	 */
-	plogical_first_u8 = startbit / 8;
-	plogical_last_u8  = endbit / 8;
+	plogical_first_u8 = startbit / BITS_PER_BYTE;
+	plogical_last_u8  = endbit / BITS_PER_BYTE;
 
 	for (box = plogical_first_u8; box >= plogical_last_u8; box--) {
 		/* Bit indices into the currently accessed 8-bit box */
@@ -231,11 +231,11 @@ int unpack(const void *pbuf, u64 *uval, size_t startbit, size_t endbit,
 		 * input arguments startbit and endbit.
 		 */
 		if (box == plogical_first_u8)
-			box_start_bit = startbit % 8;
+			box_start_bit = startbit % BITS_PER_BYTE;
 		else
 			box_start_bit = 7;
 		if (box == plogical_last_u8)
-			box_end_bit = endbit % 8;
+			box_end_bit = endbit % BITS_PER_BYTE;
 		else
 			box_end_bit = 0;
 
@@ -246,8 +246,8 @@ int unpack(const void *pbuf, u64 *uval, size_t startbit, size_t endbit,
 		 * box is u8, the projection is u64 because it may fall
 		 * anywhere within the unpacked u64.
 		 */
-		proj_start_bit = ((box * 8) + box_start_bit) - endbit;
-		proj_end_bit   = ((box * 8) + box_end_bit) - endbit;
+		proj_start_bit = ((box * BITS_PER_BYTE) + box_start_bit) - endbit;
+		proj_end_bit = ((box * BITS_PER_BYTE) + box_end_bit) - endbit;
 		proj_mask = GENMASK_ULL(proj_start_bit, proj_end_bit);
 		box_mask  = GENMASK_ULL(box_start_bit, box_end_bit);
 

-- 
2.46.2.828.g9e56e24342b6


