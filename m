Return-Path: <netdev+bounces-122934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 479B996333E
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 22:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75B341C23EC5
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 20:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60ED31ABEC7;
	Wed, 28 Aug 2024 20:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BDs5Q2df"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B992D1AD41C
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 20:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724878659; cv=none; b=UVzbiED2dtFYZ/YtKpA33d6lpdwwzyEr7EC7h8Z7uYAieDgWgdUnI6wZQNp9f/75vXIwZhwOFF2hBhSeJCyANPXziyaFleBRJ1eE8viccoyGVv4EUdzNsyqOhiNYFp/y/lBcR+WGFjj9i+zxqtyn20gBwzMSmWAlIhudlOJ/nng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724878659; c=relaxed/simple;
	bh=fVvWWmc//evEZHcKzlFxreA95ao/xY72CyoACOvZbMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sR9GwXL2CtQRTRSW/sAY4oafjOSIgluUizbrDU4r69WFeU3vhk9QW/vcggc4GOg9QdkwskeGHm4xA/JwOBH7x8ST4vaPd/oPSddANhW/dD6rUWq/hSDXwS6CVXap0EjykZieZ3TmctMuVfYOzBkFw5Obr24a57xV0yaS1XnUBM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BDs5Q2df; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724878658; x=1756414658;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=fVvWWmc//evEZHcKzlFxreA95ao/xY72CyoACOvZbMI=;
  b=BDs5Q2df4VyCP6J9zcG4VOtkhPcpXU63PaKNYRaBuzD5QL5wWLJgWaa8
   m1qZrMdUI7PFquKIrxylGYLHwQMFar2d6Z13rtgQgXeFjMn7IRxEijG1D
   TKty+XgGejQEMtW/iW2Xj3WyVsWWw5UlYMPpwYcxg4fNqBh5ILh6r0Lox
   r7SA/rZD8Vo9Eo6RZRpML1uS2j8v5IrvUwOgXrRbIeYmmh4jOMU3G+Bge
   5NfKhacxr0p6sVwuX2qmLDYYoAdAFQiLmh8EFFr2y0IY5NC3aGWmmpYaB
   apfuYbznFuKwJc8OPcbfycxpCrNEJ0dygnn0I9n+0Cw0ntFiklvEEis+D
   A==;
X-CSE-ConnectionGUID: IFOopfAaQ7KN4qdu62rYFg==
X-CSE-MsgGUID: hRUL78QgS9iet2kKbYlrEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="34592631"
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="34592631"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 13:57:31 -0700
X-CSE-ConnectionGUID: 809NkwwUTcKZgKoOdBPiFQ==
X-CSE-MsgGUID: oauytBeTSaG8/c40jUOHjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="64049965"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 13:57:29 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 28 Aug 2024 13:57:19 -0700
Subject: [PATCH iwl-next v2 03/13] lib: packing: remove kernel-doc from
 header file
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-e810-live-migration-jk-prep-ctx-functions-v2-3-558ab9e240f5@intel.com>
References: <20240828-e810-live-migration-jk-prep-ctx-functions-v2-0-558ab9e240f5@intel.com>
In-Reply-To: <20240828-e810-live-migration-jk-prep-ctx-functions-v2-0-558ab9e240f5@intel.com>
To: Vladimir Oltean <olteanv@gmail.com>, netdev <netdev@vger.kernel.org>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
X-Mailer: b4 0.14.0

From: Vladimir Oltean <vladimir.oltean@nxp.com>

It is not necessary to have the kernel-doc duplicated both in the
header and in the implementation. It is better to have it near the
implementation of the function, since in C, a function can have N
declarations, but only one definition.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 include/linux/packing.h | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/include/linux/packing.h b/include/linux/packing.h
index 8d6571feb95d..69baefebcd02 100644
--- a/include/linux/packing.h
+++ b/include/linux/packing.h
@@ -17,32 +17,6 @@ enum packing_op {
 	UNPACK,
 };
 
-/**
- * packing - Convert numbers (currently u64) between a packed and an unpacked
- *	     format. Unpacked means laid out in memory in the CPU's native
- *	     understanding of integers, while packed means anything else that
- *	     requires translation.
- *
- * @pbuf: Pointer to a buffer holding the packed value.
- * @uval: Pointer to an u64 holding the unpacked value.
- * @startbit: The index (in logical notation, compensated for quirks) where
- *	      the packed value starts within pbuf. Must be larger than, or
- *	      equal to, endbit.
- * @endbit: The index (in logical notation, compensated for quirks) where
- *	    the packed value ends within pbuf. Must be smaller than, or equal
- *	    to, startbit.
- * @op: If PACK, then uval will be treated as const pointer and copied (packed)
- *	into pbuf, between startbit and endbit.
- *	If UNPACK, then pbuf will be treated as const pointer and the logical
- *	value between startbit and endbit will be copied (unpacked) to uval.
- * @quirks: A bit mask of QUIRK_LITTLE_ENDIAN, QUIRK_LSW32_IS_FIRST and
- *	    QUIRK_MSB_ON_THE_RIGHT.
- *
- * Return: 0 on success, EINVAL or ERANGE if called incorrectly. Assuming
- *	   correct usage, return code may be discarded.
- *	   If op is PACK, pbuf is modified.
- *	   If op is UNPACK, uval is modified.
- */
 int packing(void *pbuf, u64 *uval, int startbit, int endbit, size_t pbuflen,
 	    enum packing_op op, u8 quirks);
 

-- 
2.46.0.124.g2dc1a81c8933


