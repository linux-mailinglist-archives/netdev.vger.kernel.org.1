Return-Path: <netdev+bounces-110636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FD492DA16
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 22:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EA25B22FD4
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 20:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D6E198A20;
	Wed, 10 Jul 2024 20:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F0zJ0amj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8298619149A
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 20:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720643446; cv=none; b=raVf55c3t7UBPUpSit/Ciqxn6QMW9dW7p9AlAhBtjCi8QQAq4wZT1Ri+XKf12FrxR7y0FDaLAYOQVHzyopmtiDgFavLf+PI23JhcA8vRtD8xRc4sC2U9ulZ/glPOjzgFFbISCYgIM9OQe0MpeTtubQBQhca2B32okNCzwsK37L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720643446; c=relaxed/simple;
	bh=Ju7Hb0tjZ0OEzm4PneQKzH9fE+Faml45koORAxsO3E8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XefZ1pCp1I6ocvpcD/h3blHmhA6w/DYuRbXzrkU9jP39EGY+nNc/69u5+8/ZorLk5rc90KCN4W4mebWZvpQcvpw4M0rmCBYEj+egaJwHsLH8aAPpeK6q6ijdaprsB7xrZYRwaIplKj+D4o4R/k8NjmBIFl4LJs8OvvRYgl33zUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F0zJ0amj; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720643444; x=1752179444;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ju7Hb0tjZ0OEzm4PneQKzH9fE+Faml45koORAxsO3E8=;
  b=F0zJ0amjyqopXEd7EfDLDpIqVLJVmYvzEnf0qy6AxVNVTTQBGmo7JnHv
   wOsMshbngCo3BBks1m2yXvZsTHYvK4bT30E6eCjLJ0Nw/XSYI6XE3fgIT
   dExlY8tn7rfNyhpmd2uvq1rR/Cd0BXWQAsXympSARUVmkoWokURcH8sOv
   3j6WAuY27WNG5nbsmH278g/4JVEf/pzv5WohQsyvsevZPKVOpVW6uJGrF
   kRHshSU7s/W62vOIRORXuNhv10fApS0vdDgKePfxUIInbKk/kL/9Fgr2+
   GcIwoIetI7jd3EuacADkDO1jqP/ZYpMR+/UAWrbUglOXzqsiKUM5SN34o
   w==;
X-CSE-ConnectionGUID: MF1o0yI/SdWIB5M5EOTdSA==
X-CSE-MsgGUID: XA1YqXSrSwaXfE4B341+pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="12483751"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="12483751"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 13:30:42 -0700
X-CSE-ConnectionGUID: sfjnq4O2T3und8+ax0MH1g==
X-CSE-MsgGUID: 35jEQ5CVRRmSMuNLVEh5Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="48223860"
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
	almasrymina@google.com
Subject: [PATCH net-next 03/14] libeth: add cacheline / struct layout assertion helpers
Date: Wed, 10 Jul 2024 13:30:19 -0700
Message-ID: <20240710203031.188081-4-anthony.l.nguyen@intel.com>
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

Add helpers to assert struct field layout, a bit more crazy and
networking-specific than in <linux/cache.h>. They assume you have
3 CL-aligned groups (read-mostly, read-write, cold) in a struct
you want to assert, and nothing besides them.
For 64-bit with 64-byte cachelines, the assertions are as strict
as possible, as the size can then be easily predicted.
For the rest, make sure they don't cross the specified bound.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
2.41.0


