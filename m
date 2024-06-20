Return-Path: <netdev+bounces-105314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B7A9106FE
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 15:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 744DAB20ECC
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE411AE86E;
	Thu, 20 Jun 2024 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V0PBNOPb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003911AE0BE;
	Thu, 20 Jun 2024 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718891794; cv=none; b=JklKKK1jYoOaSlv1nQSFKaevBgnjjGuluePzdJpasZY/7guKkROgXbYDwwY95qdRSi4ozliviZqblto0Cgr6pZ+Bp8alKik9et4hvVL2LjVIlF500gW/0NTTP2vcNySlyuBOn/qKdbDZwgFo63a5jQPJv47qJezv3wvPBxBkZWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718891794; c=relaxed/simple;
	bh=bDNRJ9pUxO+8DZxErTdiKH0DICe6eRRQQReWV8Dosdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BjHnVoKAcx+8ysTu+cAunGU5RJJFJ+goN8va8wjP3FxjKZLScEbh3uN95uJW7KLfMeggJbmwLsjaujZl5kAtWchQBUHUxY/00Atn6yVRsJJMnuh+tXgBaUjADnIzR1tDToL/v9fOhRNr26l5xpuwgx/whZEO8HkfQxSBpwAIv5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V0PBNOPb; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718891793; x=1750427793;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bDNRJ9pUxO+8DZxErTdiKH0DICe6eRRQQReWV8Dosdw=;
  b=V0PBNOPbI08xVy4wQDgwCZ84qCg7I9AmrGXNBdh6xRco1crwgjmJqgSp
   PRGPlu3d6wFkjUtJWFmdua1cuHuUizUmqd9wtiq321JotN4azDO4r6Kkl
   XEg8LtvyLYHlPrriKEUI/oIrAJe7VVBzlmEFki1QmouJReuKYM7AaSZwS
   gsR9Dh+vzWTlH9ovt6D1Ytf4n6ytyiTqTYxcxvQA2toDP2tuXl20BqxEX
   K9gd3infAOjgBRs6EW3MCijhMCwvhmyB7TqYM39yp6082jgYg7ysL20oR
   Hy0QJLPIHtbrMwVnWUAbcUK+XaEPnEJF8wPLJadVNbos6xz1LgtWwmViG
   Q==;
X-CSE-ConnectionGUID: /hNsRLaqT2KuMMMK7LXiOQ==
X-CSE-MsgGUID: oT0MjoFXQg+PrA9ukNX2Cg==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15987815"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="15987815"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 06:56:32 -0700
X-CSE-ConnectionGUID: nBo8jPV7QN+6if8pzvreKg==
X-CSE-MsgGUID: GcpVcVBQQqqrBe5wywP+ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="46772060"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa004.fm.intel.com with ESMTP; 20 Jun 2024 06:56:28 -0700
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
Subject: [PATCH iwl-next v2 03/14] libeth: add cacheline / struct layout assertion helpers
Date: Thu, 20 Jun 2024 15:53:36 +0200
Message-ID: <20240620135347.3006818-4-aleksander.lobakin@intel.com>
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

Add helpers to assert struct field layout, a bit more crazy and
networking-specific than in <linux/cache.h>. They assume you have
3 CL-aligned groups (read-mostly, read-write, cold) in a struct
you want to assert, and nothing besides them.
For 64-bit with 64-byte cachelines, the assertions are as strict
as possible, as the size can then be easily predicted.
For the rest, make sure they don't cross the specified bound.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/libeth/cache.h | 66 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 include/net/libeth/cache.h

diff --git a/include/net/libeth/cache.h b/include/net/libeth/cache.h
new file mode 100644
index 000000000000..bdb0c043ce61
--- /dev/null
+++ b/include/net/libeth/cache.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2024 Intel Corporation */
+
+#ifndef __LIBETH_CACHE_H
+#define __LIBETH_CACHE_H
+
+#include <linux/cache.h>
+
+/**
+ * libeth_cacheline_group_assert - make sure cacheline group size is expected
+ * @type: type of the structure containing the group
+ * @grp: group name inside the struct
+ * @sz: expected group size
+ */
+#if defined(CONFIG_64BIT) && SMP_CACHE_BYTES == 64
+#define libeth_cacheline_group_assert(type, grp, sz)			      \
+	static_assert(offsetof(type, __cacheline_group_end__##grp) -	      \
+		      offsetofend(type, __cacheline_group_begin__##grp) ==    \
+		      (sz))
+#define __libeth_cacheline_struct_assert(type, sz)			      \
+	static_assert(sizeof(type) == (sz))
+#else /* !CONFIG_64BIT || SMP_CACHE_BYTES != 64 */
+#define libeth_cacheline_group_assert(type, grp, sz)			      \
+	static_assert(offsetof(type, __cacheline_group_end__##grp) -	      \
+		      offsetofend(type, __cacheline_group_begin__##grp) <=    \
+		      (sz))
+#define __libeth_cacheline_struct_assert(type, sz)			      \
+	static_assert(sizeof(type) <= (sz))
+#endif /* !CONFIG_64BIT || SMP_CACHE_BYTES != 64 */
+
+#define __libeth_cls1(sz1)	SMP_CACHE_ALIGN(sz1)
+#define __libeth_cls2(sz1, sz2)	(SMP_CACHE_ALIGN(sz1) + SMP_CACHE_ALIGN(sz2))
+#define __libeth_cls3(sz1, sz2, sz3)					      \
+	(SMP_CACHE_ALIGN(sz1) + SMP_CACHE_ALIGN(sz2) + SMP_CACHE_ALIGN(sz3))
+#define __libeth_cls(...)						      \
+	CONCATENATE(__libeth_cls, COUNT_ARGS(__VA_ARGS__))(__VA_ARGS__)
+
+/**
+ * libeth_cacheline_struct_assert - make sure CL-based struct size is expected
+ * @type: type of the struct
+ * @...: from 1 to 3 CL group sizes (read-mostly, read-write, cold)
+ *
+ * When a struct contains several CL groups, it's difficult to predict its size
+ * on different architectures. The macro instead takes sizes of all of the
+ * groups the structure contains and generates the final struct size.
+ */
+#define libeth_cacheline_struct_assert(type, ...)			      \
+	__libeth_cacheline_struct_assert(type, __libeth_cls(__VA_ARGS__));    \
+	static_assert(__alignof(type) >= SMP_CACHE_BYTES)
+
+/**
+ * libeth_cacheline_set_assert - make sure CL-based struct layout is expected
+ * @type: type of the struct
+ * @ro: expected size of the read-mostly group
+ * @rw: expected size of the read-write group
+ * @c: expected size of the cold group
+ *
+ * Check that each group size is expected and then do final struct size check.
+ */
+#define libeth_cacheline_set_assert(type, ro, rw, c)			      \
+	libeth_cacheline_group_assert(type, read_mostly, ro);		      \
+	libeth_cacheline_group_assert(type, read_write, rw);		      \
+	libeth_cacheline_group_assert(type, cold, c);			      \
+	libeth_cacheline_struct_assert(type, ro, rw, c)
+
+#endif /* __LIBETH_CACHE_H */
-- 
2.45.2


