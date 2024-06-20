Return-Path: <netdev+bounces-105311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8019106EC
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 15:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0963E282245
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497981AD9ED;
	Thu, 20 Jun 2024 13:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EGY+aiMx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478F71AD9D2;
	Thu, 20 Jun 2024 13:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718891788; cv=none; b=NNdfetQQ7FeZfzYKXxSPqqrAsu8p1dj0jercQmLDo6gdnOwkwE3CJLNzhIyLWZIwxaPMsvLe/jY8iCohVdzH3j3iPNzrla15jDGeBSyt3I7RQKl7XNNA8wBTleKr5aOTmPcIwwf8zUzrI3lB26wnihVIAlvtIGhiD9oOI0+3ZsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718891788; c=relaxed/simple;
	bh=mwpCFI7BY9vBTW5d7y194ARYTbqj1TULr8pdoFCGRmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eMNN8tzMEXHnBGZHy+KhNcQMbU+J59XtDsfY2hzvcZXflEAofhE8uKmThZ3P7lnvLpgLak3ttrNQI4x2C+3tDClIpcFEicO2bARAASS4U3jdpdkMjlwVnkhvDaQh5hTfJlhw4zcbhAR2W9YbLvQP8mGSR6qFiGuQ2GOR5jgEIe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EGY+aiMx; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718891787; x=1750427787;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mwpCFI7BY9vBTW5d7y194ARYTbqj1TULr8pdoFCGRmY=;
  b=EGY+aiMxH5t0e21Lv6kUTkQsN7AXn3jlA0gJ3051IkC8Km7Vhv8E0tTe
   0Pi5+3/7j+mjrYOJm2fRQN0qKuT1Ym7a0ZIbT0AOupGs8xn+Ugg5YfApb
   0H/wZ+CntsYm9b6JcqK4ppjzY+4V+wDeY1qJasJx8Hg9miQ7SzZx4Oooc
   XRpQk/rAf2OBKAP7+Ch0kaIdtFirulRYfi44NFpbD0N5OL+UBZpbnOYEX
   thVbtl+0X5/JBHFiMC000Fwt53ERs+/Jt4VrZ/zBVKPLZDoHJIpuVI6o+
   kvqyMtMj4K5dhTnliJnueLYdKqwM6OrV9gW3ZE5uiQ8CJYviqQEiWmU59
   g==;
X-CSE-ConnectionGUID: 3rWGN7iXR+GvHTkqeFnxuQ==
X-CSE-MsgGUID: fXmgT2HZQTCZaPv6tSnyrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15987788"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="15987788"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 06:56:24 -0700
X-CSE-ConnectionGUID: C557Hqh0THe05/bEu5YgCg==
X-CSE-MsgGUID: 7LK4REJQQL6q5bxHxjlrlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="46772037"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa004.fm.intel.com with ESMTP; 20 Jun 2024 06:56:21 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mina Almasry <almasrymina@google.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next v2 01/14] cache: add __cacheline_group_{begin,end}_aligned() (+ couple more)
Date: Thu, 20 Jun 2024 15:53:34 +0200
Message-ID: <20240620135347.3006818-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240620135347.3006818-1-aleksander.lobakin@intel.com>
References: <20240620135347.3006818-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
2.45.2


