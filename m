Return-Path: <netdev+bounces-122932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9E696333C
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 22:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC33A1F25538
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 20:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98C71AD5E6;
	Wed, 28 Aug 2024 20:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YRH/TM+B"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4183B1AC8B0
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 20:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724878657; cv=none; b=El/dfTyCmC+wuY+wL7wbXe3wuc7W9VJUniAvFAbKZ8CxhhiGKRiOfGZefGm5ciAK84Vw0Wo7UatkFNqqtDkcqUePoqFtbx1Ns5aNRuexBbQOQp38QOmyRj2Zqqdb1VWBQ1eAFOS4znPizVxEb62D7+cjeKVEHvtFTVxoxofeU7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724878657; c=relaxed/simple;
	bh=6kQrbIE4kr5T8eFDQTblirQ915WMJmra1Rfj0RlaOK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FhO+o9CBtvIMeHSNBGJr0ngcCuU6V74+G6w8sz1TkcQDSxSOpL+urOtyLwhTF2EZWKS0NgomuJhaPY2HfEXUAvF7Z8g1g7kxr/+X2SgNoi41CheeLVkKLgdNhiU3fzkEQtXMuMAHNbx1hsMoKllyY2lDgyttqCHdJFfNERjy64g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YRH/TM+B; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724878657; x=1756414657;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=6kQrbIE4kr5T8eFDQTblirQ915WMJmra1Rfj0RlaOK8=;
  b=YRH/TM+Bz2y0ZL4YZkeSpOtRXxkXgIeZFdxctDRYCiYaa99+f5jqiSs0
   01T3T0eigSM5rbgJKsOGxCx77troCw8CVMe2Eybjfj+hqOj21hX1A3l1s
   We4IV6jHoUJ4ohGosFzsD2hrCRp1wvbE1PT8bsJBElh5L2KsovJYWnZkB
   1U4zJtOrSEGR+hsmxiJVDVg7Rm6Av/0nnNlLYwd5KDdfreGqffJzyhQvm
   KlRy+PWoDYBCi0rHntnUgC+XL2CWlHtqNpAtf7XAIaGUxapWVu8vh1P92
   /fUNQdNjzoBCWwqQOSsYmLxdqQKIfMqyFIuCPFcPEfMLdkZvRUit9Tg1c
   A==;
X-CSE-ConnectionGUID: lAze8eIZR0uQeihAbcXVFA==
X-CSE-MsgGUID: zM74y79BRXCKT5hRSilAcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="34592625"
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="34592625"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 13:57:31 -0700
X-CSE-ConnectionGUID: rE+LzBF6T26rSiB+xfKqXw==
X-CSE-MsgGUID: GrxRlq3RRB+HmcCQRIQaJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="64049959"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 13:57:29 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 28 Aug 2024 13:57:17 -0700
Subject: [PATCH iwl-next v2 01/13] lib: packing: refuse operating on bit
 indices which exceed size of buffer
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-e810-live-migration-jk-prep-ctx-functions-v2-1-558ab9e240f5@intel.com>
References: <20240828-e810-live-migration-jk-prep-ctx-functions-v2-0-558ab9e240f5@intel.com>
In-Reply-To: <20240828-e810-live-migration-jk-prep-ctx-functions-v2-0-558ab9e240f5@intel.com>
To: Vladimir Oltean <olteanv@gmail.com>, netdev <netdev@vger.kernel.org>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
X-Mailer: b4 0.14.0

From: Vladimir Oltean <vladimir.oltean@nxp.com>

While reworking the implementation, it became apparent that this check
does not exist.

There is no functional issue yet, because at call sites, "startbit" and
"endbit" are always hardcoded to correct values, and never come from the
user.

Even with the upcoming support of arbitrary buffer lengths, the
"startbit >= 8 * pbuflen" check will remain correct. This is because
we intend to always interpret the packed buffer in a way that avoids
discontinuities in the available bit indices.

Fixes: 554aae35007e ("lib: Add support for generic packing operations")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 lib/packing.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/packing.c b/lib/packing.c
index 3f656167c17e..439125286d2b 100644
--- a/lib/packing.c
+++ b/lib/packing.c
@@ -86,8 +86,10 @@ int packing(void *pbuf, u64 *uval, int startbit, int endbit, size_t pbuflen,
 	 */
 	int plogical_first_u8, plogical_last_u8, box;
 
-	/* startbit is expected to be larger than endbit */
-	if (startbit < endbit)
+	/* startbit is expected to be larger than endbit, and both are
+	 * expected to be within the logically addressable range of the buffer.
+	 */
+	if (unlikely(startbit < endbit || startbit >= 8 * pbuflen || endbit < 0))
 		/* Invalid function call */
 		return -EINVAL;
 

-- 
2.46.0.124.g2dc1a81c8933


