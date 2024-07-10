Return-Path: <netdev+bounces-110634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C7292DA14
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 22:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28850B236DF
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 20:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41F3198821;
	Wed, 10 Jul 2024 20:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jh+kMcIV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FFD83CD9
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 20:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720643445; cv=none; b=KblVn1JOvjQkcRp0nMvHHGZdY5PGu6bLhbtAzmNaoQXygmvnxefV6x8losyse3PwMz6pcpBudt4mHjp8b0NWn/CWppvCYBgyTQTsqQp/nH3M4ZU5+YUSr9lm2EVL0FOFluIBmH6uZeq12moJMsy5OfOakADbMvaHlx37rJwLfWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720643445; c=relaxed/simple;
	bh=N/PGrC4RYmmcG32rCF81s6jTdoAJjjMnjUgsuLoubjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jDGXJlHpMIi3T44dSuXN6TvJJkay0uCDyfiYCp5VL6/4wMbnKYTS886agvF1JQf0ugN4VsnK9Qo13xifMlgBF+WiprtaDU6ttcbnS1S7NPQOKul3H6zCsb88TTtKnt/GfsWCzz8F3dC5iCgrK1P+mlyHEEJYAWB1RBgw8yVgHFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jh+kMcIV; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720643443; x=1752179443;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N/PGrC4RYmmcG32rCF81s6jTdoAJjjMnjUgsuLoubjg=;
  b=jh+kMcIVqxw2OzB/uWQHc+f9SyJIwDHRx1ay9Adlzi6kvyNn/7QspPaF
   otOidVwRXcdb4gofJigDt/IuunR3QFepT4d54L7TONr/0Ua4cU5HD8GwK
   mpPXT+r3ob3Y6Dj+mK7pwjRAqJqwOh3Vp5tRFFWAcAZg9qMCrxi/SHus6
   BpME6B9besID8nTR7S1ZKI1CiMOF19tPDBd4Oc6UMJEuB2HU95n/YP9mR
   ngZCwW8E+rjSLYIZVdWLzx8eFE6ibWD68AKrdIPk9sCqpqhvGLze9Fp0Y
   y2cluLYtNDj0MsxAwtCLvOm6e8qQXOJpSRXEGnSELT7PMxCdYKMaswUZ9
   A==;
X-CSE-ConnectionGUID: B5auMUG1QlONEws4IaG/5g==
X-CSE-MsgGUID: iQ8IVneBTayMwUDxZJeFeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="12483741"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="12483741"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 13:30:42 -0700
X-CSE-ConnectionGUID: kLYMAv4fRSWzyyizlbzogA==
X-CSE-MsgGUID: kmyA5gJISYOTGOFfw0dwpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="48223853"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 10 Jul 2024 13:30:41 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	anthony.l.nguyen@intel.com,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	lihong.yang@intel.com,
	willemb@google.com,
	almasrymina@google.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next 01/14] cache: add __cacheline_group_{begin, end}_aligned() (+ couple more)
Date: Wed, 10 Jul 2024 13:30:17 -0700
Message-ID: <20240710203031.188081-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240710203031.188081-1-anthony.l.nguyen@intel.com>
References: <20240710203031.188081-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Lobakin <aleksander.lobakin@intel.com>

__cacheline_group_begin(), unfortunately, doesn't align the group
anyhow. If it is wanted, then you need to do something like

__cacheline_group_begin(grp) __aligned(ALIGN)

which isn't really convenient nor compact.
Add the _aligned() counterparts to align the groups automatically to
either the specified alignment (optional) or ``SMP_CACHE_BYTES``.
Note that the actual struct layout will then be (on x64 with 64-byte CL):

struct x {
	u32 y;				// offset 0, size 4, padding 56
	__cacheline_group_begin__grp;	// offset 64, size 0
	u32 z;				// offset 64, size 4, padding 4
	__cacheline_group_end__grp;	// offset 72, size 0
	__cacheline_group_pad__grp;	// offset 72, size 0, padding 56
	u32 w;				// offset 128
};

The end marker is aligned to long, so that you can assert the struct
size more strictly, but the offset of the next field in the structure
will be aligned to the group alignment, so that the next field won't
fall into the group it's not intended to.

Add __LARGEST_ALIGN definition and LARGEST_ALIGN() macro.
__LARGEST_ALIGN is the value to which the compilers align fields when
__aligned_largest is specified. Sometimes, it might be needed to get
this value outside of variable definitions. LARGEST_ALIGN() is macro
which just aligns a value to __LARGEST_ALIGN.
Also add SMP_CACHE_ALIGN(), similar to L1_CACHE_ALIGN(), but using
``SMP_CACHE_BYTES`` instead of ``L1_CACHE_BYTES`` as the former
also accounts L2, needed in some cases.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 include/linux/cache.h | 59 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/include/linux/cache.h b/include/linux/cache.h
index 0ecb17bb6883..ca2a05682a54 100644
--- a/include/linux/cache.h
+++ b/include/linux/cache.h
@@ -13,6 +13,32 @@
 #define SMP_CACHE_BYTES L1_CACHE_BYTES
 #endif
 
+/**
+ * SMP_CACHE_ALIGN - align a value to the L2 cacheline size
+ * @x: value to align
+ *
+ * On some architectures, L2 ("SMP") CL size is bigger than L1, and sometimes,
+ * this needs to be accounted.
+ *
+ * Return: aligned value.
+ */
+#ifndef SMP_CACHE_ALIGN
+#define SMP_CACHE_ALIGN(x)	ALIGN(x, SMP_CACHE_BYTES)
+#endif
+
+/*
+ * ``__aligned_largest`` aligns a field to the value most optimal for the
+ * target architecture to perform memory operations. Get the actual value
+ * to be able to use it anywhere else.
+ */
+#ifndef __LARGEST_ALIGN
+#define __LARGEST_ALIGN		sizeof(struct { long x; } __aligned_largest)
+#endif
+
+#ifndef LARGEST_ALIGN
+#define LARGEST_ALIGN(x)	ALIGN(x, __LARGEST_ALIGN)
+#endif
+
 /*
  * __read_mostly is used to keep rarely changing variables out of frequently
  * updated cachelines. Its use should be reserved for data that is used
@@ -95,6 +121,39 @@
 	__u8 __cacheline_group_end__##GROUP[0]
 #endif
 
+/**
+ * __cacheline_group_begin_aligned - declare an aligned group start
+ * @GROUP: name of the group
+ * @...: optional group alignment
+ *
+ * The following block inside a struct:
+ *
+ *	__cacheline_group_begin_aligned(grp);
+ *	field a;
+ *	field b;
+ *	__cacheline_group_end_aligned(grp);
+ *
+ * will always be aligned to either the specified alignment or
+ * ``SMP_CACHE_BYTES``.
+ */
+#define __cacheline_group_begin_aligned(GROUP, ...)		\
+	__cacheline_group_begin(GROUP)				\
+	__aligned((__VA_ARGS__ + 0) ? : SMP_CACHE_BYTES)
+
+/**
+ * __cacheline_group_end_aligned - declare an aligned group end
+ * @GROUP: name of the group
+ * @...: optional alignment (same as was in __cacheline_group_begin_aligned())
+ *
+ * Note that the end marker is aligned to sizeof(long) to allow more precise
+ * size assertion. It also declares a padding at the end to avoid next field
+ * falling into this cacheline.
+ */
+#define __cacheline_group_end_aligned(GROUP, ...)		\
+	__cacheline_group_end(GROUP) __aligned(sizeof(long));	\
+	struct { } __cacheline_group_pad__##GROUP		\
+	__aligned((__VA_ARGS__ + 0) ? : SMP_CACHE_BYTES)
+
 #ifndef CACHELINE_ASSERT_GROUP_MEMBER
 #define CACHELINE_ASSERT_GROUP_MEMBER(TYPE, GROUP, MEMBER) \
 	BUILD_BUG_ON(!(offsetof(TYPE, MEMBER) >= \
-- 
2.41.0


