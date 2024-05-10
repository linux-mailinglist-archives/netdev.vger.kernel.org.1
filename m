Return-Path: <netdev+bounces-95511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8328C27AE
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 17:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48D6C1F26147
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 15:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3580D172BB9;
	Fri, 10 May 2024 15:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mHVMt2Nj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E3817166E;
	Fri, 10 May 2024 15:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715354847; cv=none; b=SMByFQoinkEB4VKVf474Kg3xanCnOSQu0ERlSQiG6SwP6BxWHpv5fTWjPDrjJ2qOua9GGTwbsQDOvBMQ0QHbRxf+X3ZDTwX658qIOxIxUZwyxs4RuMjnOxwSqRsom8/qYlcziIsahg2Dp0q+L/g7d4YffN3dgU9sLRQamAJBF0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715354847; c=relaxed/simple;
	bh=96/bv+FJrC/OibdNW1EQaNdvgoLzh92ZX9ptg3yrNfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kIsPRmk5LXAa5Ctv813RLXfXti0oLKdmqYeF7hCLpc5Dy4xiM/2cnayGDKYOtstmAXsC4qRCoEcnyazKI2u7rvWja10dyFjrbr02W2tdrPDPnOfHqB6Hzn5WyvdGmufVf5/dsNSl+wseUNmbl5naBCTGS/apu3EfwIhFbVhuZqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mHVMt2Nj; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715354843; x=1746890843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=96/bv+FJrC/OibdNW1EQaNdvgoLzh92ZX9ptg3yrNfQ=;
  b=mHVMt2Nj7mLRfCJxoa9Zf9prx5NlPpV0xTf7YJNHQg4pI+C8pYIgDXIe
   nKt4zP3igiOw3iFLj8xb8yeFA+C5VmmUX4lI4mRHA6n9HwvOsrI+otlWP
   ClRBIeUrieGRQOoSZaOvdm0LwHqChHQjWBL2xcbI8soeh61ptLIoqRAlu
   Trf+LxscqaTmsvWPj9OiNxTV+Temgvddk7C812tFnrLWTYfL8vq8Q2Fpv
   OSVp773hPAZqMTfEMqis5Gd6NPB9+k1h1syYhDQ93GlVf2hh6KWgGrZXe
   OpCLzUhdl2VpL73d7ebHouWdQOU9nuQUn81o/GHyhafbDSZe1bV0ox+9R
   Q==;
X-CSE-ConnectionGUID: Y9tXu5j2QYi09OP1W14vOw==
X-CSE-MsgGUID: pxT+HJvoTLm8xUwqddAs0Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="15152547"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="15152547"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 08:27:22 -0700
X-CSE-ConnectionGUID: XlGYlfGWQZGEqYtdblb2Bw==
X-CSE-MsgGUID: usbMoM40QpOhVM75OYdiyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="30208238"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa008.jf.intel.com with ESMTP; 10 May 2024 08:27:19 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC iwl-next 01/12] libeth: add cacheline / struct alignment helpers
Date: Fri, 10 May 2024 17:26:09 +0200
Message-ID: <20240510152620.2227312-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240510152620.2227312-1-aleksander.lobakin@intel.com>
References: <20240510152620.2227312-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following the latest netdev trend, i.e. effective and usage-based field
cacheline placement, add helpers to group and then assert struct fields
by cachelines.
For 64-bit with 64-byte cachelines, the assertions are more strict as
the size can then be easily predicted. For the rest, just make sure
they don't cross the specified bound.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/libeth/cache.h | 64 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 include/net/libeth/cache.h

diff --git a/include/net/libeth/cache.h b/include/net/libeth/cache.h
new file mode 100644
index 000000000000..3245a20b22d3
--- /dev/null
+++ b/include/net/libeth/cache.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2024 Intel Corporation */
+
+#ifndef __LIBETH_CACHE_H
+#define __LIBETH_CACHE_H
+
+#include <linux/cache.h>
+
+/* __aligned_largest is architecture-dependent. Get the actual alignment */
+#define ___LIBETH_LARGEST_ALIGN						   \
+	sizeof(struct { long __UNIQUE_ID(long_); } __aligned_largest)
+#define __LIBETH_LARGEST_ALIGN						   \
+	(___LIBETH_LARGEST_ALIGN > SMP_CACHE_BYTES ?			   \
+	 ___LIBETH_LARGEST_ALIGN : SMP_CACHE_BYTES)
+#define __LIBETH_LARGEST_ALIGNED(sz)					   \
+	ALIGN(sz, __LIBETH_LARGEST_ALIGN)
+
+#define __libeth_cacheline_group_begin(grp)				   \
+	__cacheline_group_begin(grp) __aligned(__LIBETH_LARGEST_ALIGN)
+#define __libeth_cacheline_group_end(grp)				   \
+	__cacheline_group_end(grp) __aligned(4)
+
+#define libeth_cacheline_group(grp, ...)				   \
+	struct_group(grp,						   \
+		__libeth_cacheline_group_begin(grp);			   \
+		__VA_ARGS__						   \
+		__libeth_cacheline_group_end(grp);			   \
+	)
+
+#if defined(CONFIG_64BIT) && L1_CACHE_BYTES == 64
+#define libeth_cacheline_group_assert(type, grp, sz)			   \
+	static_assert(offsetof(type, __cacheline_group_end__##grp) -	   \
+		      offsetofend(type, __cacheline_group_begin__##grp) == \
+		      (sz))
+#define __libeth_cacheline_struct_assert(type, sz)			   \
+	static_assert(sizeof(type) == (sz))
+#else /* !CONFIG_64BIT || L1_CACHE_BYTES != 64 */
+#define libeth_cacheline_group_assert(type, grp, sz)			   \
+	static_assert(offsetof(type, __cacheline_group_end__##grp) -	   \
+		      offsetofend(type, __cacheline_group_begin__##grp) <= \
+		      (sz))
+#define __libeth_cacheline_struct_assert(type, sz)			   \
+	static_assert(sizeof(type) <= (sz))
+#endif /* !CONFIG_64BIT || L1_CACHE_BYTES != 64 */
+
+#define __libeth_cls1(sz1)						   \
+	__LIBETH_LARGEST_ALIGNED(sz1)
+#define __libeth_cls2(sz1, sz2)						   \
+	(__LIBETH_LARGEST_ALIGNED(sz1) + __LIBETH_LARGEST_ALIGNED(sz2))
+#define __libeth_cls3(sz1, sz2, sz3)					   \
+	(__LIBETH_LARGEST_ALIGNED(sz1) + __LIBETH_LARGEST_ALIGNED(sz2) +   \
+	 __LIBETH_LARGEST_ALIGNED(sz3))
+#define __libeth_cls(...)						   \
+	CONCATENATE(__libeth_cls, COUNT_ARGS(__VA_ARGS__))(__VA_ARGS__)
+#define libeth_cacheline_struct_assert(type, ...)			   \
+	__libeth_cacheline_struct_assert(type, __libeth_cls(__VA_ARGS__))
+
+#define libeth_cacheline_set_assert(type, ro, rw, c)			   \
+	libeth_cacheline_group_assert(type, read_mostly, ro);		   \
+	libeth_cacheline_group_assert(type, read_write, rw);		   \
+	libeth_cacheline_group_assert(type, cold, c);			   \
+	libeth_cacheline_struct_assert(type, ro, rw, c)
+
+#endif /* __LIBETH_CACHE_H */
-- 
2.45.0


