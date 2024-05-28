Return-Path: <netdev+bounces-98588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D238D1D67
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56225282A94
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C36316F82E;
	Tue, 28 May 2024 13:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="THi0ilwa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413BE16F282;
	Tue, 28 May 2024 13:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716904163; cv=none; b=ff6mIa5C5cQH0X5Jgj480hRo6TX4VQ8J3RqGxUL69t/kRBtjXQC/VBtpfEmx5fnpH+2/R17hHoqksA9jOtGIR3TkYwlsLayMEFR9ztcnUqfToCz8n5OOWH21aGH2WQyrrHc3Kj/be/2Nt0eCeAZpGzWhCh9485Dk3CLb0QtN+90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716904163; c=relaxed/simple;
	bh=0IFvzSRs4SBJ/8TliqJ0oinnzSDDG3rnCZiHPjpYM6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tc3eqs0oxcLVMY6bOXhjxbTHQhsidicLWDTJLpscwhwU5aywyErytd0m16gdn+efz9hL55KlmqE2s5mMP7jvVEcV70EtJwd0rz9bmQ5Q/tb7aFq3LtytfWCww1Tvrt4T0jrbpoA42WdmIiKukY49SAQ/ae6ueBZYonJzmVQZw5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=THi0ilwa; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716904161; x=1748440161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0IFvzSRs4SBJ/8TliqJ0oinnzSDDG3rnCZiHPjpYM6E=;
  b=THi0ilwaFua3Hjg3PjJt400uQvFcf1bEYCxbNPZOZSPRKSggHS84Y/v0
   YGWTVhztdsEZin4p3xWY25M/dJ9Nv+k499Q6723g2tDXxO4qWtoROOYZG
   F9475tiKkN/WaRdRgbKkcphEI95ifyhxYWBJrvSNgS3cWzAgKNYf28nfP
   tjSrMu5cwJIPzmUn5Onzls/PLszuxhMXTuCdHPJHtpmCvWOHFTZUh6F2m
   lVPnQDWQ1nBIXUSs+DYP6Bf0LoNpap+NpQo5ySGMdAAIaJlsu2y3aGcfV
   V05R+DUTBWiYawF7T1HlOs7APysZHyQyQrhbvm7P5B3geU0zEp6oN4TiN
   g==;
X-CSE-ConnectionGUID: c6XZ1mX4SG61Ej3tRzXF0A==
X-CSE-MsgGUID: i8sFCwMzQU+veUjnAxHO2A==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13436979"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="13436979"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 06:49:21 -0700
X-CSE-ConnectionGUID: dJ9fxTzCQgGL5WEjCDNJpg==
X-CSE-MsgGUID: s3kPPNK/SAyeJolb1vTazw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="35577394"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa008.jf.intel.com with ESMTP; 28 May 2024 06:49:18 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mina Almasry <almasrymina@google.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next 01/12] libeth: add cacheline / struct alignment helpers
Date: Tue, 28 May 2024 15:48:35 +0200
Message-ID: <20240528134846.148890-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528134846.148890-1-aleksander.lobakin@intel.com>
References: <20240528134846.148890-1-aleksander.lobakin@intel.com>
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
 scripts/kernel-doc         |   1 +
 include/net/libeth/cache.h | 100 +++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)
 create mode 100644 include/net/libeth/cache.h

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 95a59ac78f82..d0cf9a2d82de 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1155,6 +1155,7 @@ sub dump_struct($$) {
         $members =~ s/\bstruct_group_attr\s*\(([^,]*,){2}/STRUCT_GROUP(/gos;
         $members =~ s/\bstruct_group_tagged\s*\(([^,]*),([^,]*),/struct $1 $2; STRUCT_GROUP(/gos;
         $members =~ s/\b__struct_group\s*\(([^,]*,){3}/STRUCT_GROUP(/gos;
+        $members =~ s/\blibeth_cacheline_group\s*\(([^,]*,)/struct { } $1; STRUCT_GROUP(/gos;
         $members =~ s/\bSTRUCT_GROUP(\(((?:(?>[^)(]+)|(?1))*)\))[^;]*;/$2/gos;
 
         my $args = qr{([^,)]+)};
diff --git a/include/net/libeth/cache.h b/include/net/libeth/cache.h
new file mode 100644
index 000000000000..5579240913d2
--- /dev/null
+++ b/include/net/libeth/cache.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2024 Intel Corporation */
+
+#ifndef __LIBETH_CACHE_H
+#define __LIBETH_CACHE_H
+
+#include <linux/cache.h>
+
+/* ``__aligned_largest`` is architecture-dependent. Get the actual alignment */
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
+	__cacheline_group_end(grp) __aligned(sizeof(long))
+
+/**
+ * libeth_cacheline_group - declare a cacheline-aligned field group
+ * @grp: name of the group (usually 'read_mostly', 'read_write', or 'cold')
+ * @...: struct fields inside the group
+ *
+ * Note that the whole group is cacheline-aligned, but the end marker is
+ * aligned to long, so that you pass the (almost) actual field size sum to
+ * the assertion macros below instead of CL-aligned values.
+ * Each cacheline group must be described in struct's kernel-doc.
+ */
+#define libeth_cacheline_group(grp, ...)				   \
+	struct_group(grp,						   \
+		__libeth_cacheline_group_begin(grp);			   \
+		__VA_ARGS__						   \
+		__libeth_cacheline_group_end(grp);			   \
+	)
+
+/**
+ * libeth_cacheline_group_assert - make sure cacheline group size is expected
+ * @type: type of the structure containing the group
+ * @grp: group name inside the struct
+ * @sz: expected group size
+ */
+#if defined(CONFIG_64BIT) && SMP_CACHE_BYTES == 64
+#define libeth_cacheline_group_assert(type, grp, sz)			   \
+	static_assert(offsetof(type, __cacheline_group_end__##grp) -	   \
+		      offsetofend(type, __cacheline_group_begin__##grp) == \
+		      (sz))
+#define __libeth_cacheline_struct_assert(type, sz)			   \
+	static_assert(sizeof(type) == (sz))
+#else /* !CONFIG_64BIT || SMP_CACHE_BYTES != 64 */
+#define libeth_cacheline_group_assert(type, grp, sz)			   \
+	static_assert(offsetof(type, __cacheline_group_end__##grp) -	   \
+		      offsetofend(type, __cacheline_group_begin__##grp) <= \
+		      (sz))
+#define __libeth_cacheline_struct_assert(type, sz)			   \
+	static_assert(sizeof(type) <= (sz))
+#endif /* !CONFIG_64BIT || SMP_CACHE_BYTES != 64 */
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
+#define libeth_cacheline_struct_assert(type, ...)			   \
+	__libeth_cacheline_struct_assert(type, __libeth_cls(__VA_ARGS__)); \
+	static_assert(__alignof(type) >= __LIBETH_LARGEST_ALIGN)
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
+#define libeth_cacheline_set_assert(type, ro, rw, c)			   \
+	libeth_cacheline_group_assert(type, read_mostly, ro);		   \
+	libeth_cacheline_group_assert(type, read_write, rw);		   \
+	libeth_cacheline_group_assert(type, cold, c);			   \
+	libeth_cacheline_struct_assert(type, ro, rw, c)
+
+#endif /* __LIBETH_CACHE_H */
-- 
2.45.1


