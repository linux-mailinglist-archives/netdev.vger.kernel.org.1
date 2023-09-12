Return-Path: <netdev+bounces-33210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E95379D09F
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 14:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5556F1C20DF8
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 12:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE09018049;
	Tue, 12 Sep 2023 12:04:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9C618043
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 12:04:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D22B10D2;
	Tue, 12 Sep 2023 05:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694520244; x=1726056244;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AoFJ4EKmQaW5jMXHWEKuwqr4VmOnXj5Tbutvmvj/Ih8=;
  b=mdMwygVe8jCm1zm9zA4g64qUZI5edt5y8wzgByeuWIwu70f/bzt9JoNB
   52kwEVTU6B8uv1T9q/5AQkWoLoQ9z5dMjbMro/+czaslxWGlEIhVtFRF6
   ND3ShULjcM7mF6yC9vZbgqH+vboNqVPGAm25nOaoD+LF8AIDeo+kGQPnK
   75JALAlzgzWu9apVgWEwJosuWHcDuzJPOrNgOSbYZqAuWwWi3r3p5G+LV
   7SfHQSTt0JmE6PbW1ldAVUPbQ5PqoqB6l9qFu8/oRLRLT7zNVDLa8eEWH
   PjOeyyahF7RB2c8+W/fOzfzdZIfc03Nz/Rnx5wnRcubfyhDyHmWY05x9t
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="378265394"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="378265394"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 05:02:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="720389751"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="720389751"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga006.jf.intel.com with ESMTP; 12 Sep 2023 05:02:54 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 0BA0C332D1;
	Tue, 12 Sep 2023 13:02:52 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: Kees Cook <keescook@chromium.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-hardening@vger.kernel.org,
	Steven Zou <steven.zou@intel.com>,
	Anthony Nguyen <anthony.l.nguyen@intel.com>,
	David Laight <David.Laight@ACULAB.COM>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v5 1/7] overflow: add DEFINE_FLEX() for on-stack allocs
Date: Tue, 12 Sep 2023 07:59:31 -0400
Message-Id: <20230912115937.1645707-2-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230912115937.1645707-1-przemyslaw.kitszel@intel.com>
References: <20230912115937.1645707-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DEFINE_FLEX() macro for on-stack allocations of structs with
flexible array member.

Expose __struct_size() macro outside of fortify-string.h, as it could be
used to read size of structs allocated by DEFINE_FLEX().
Move __member_size() alongside it.
-Kees

Using underlying array for on-stack storage lets us to declare
known-at-compile-time structures without kzalloc().

Actual usage for ice driver is in following patches of the series.

Missing __has_builtin() workaround is moved up to serve also assembly
compilation with m68k-linux-gcc, see [1].
Error was (note the .S file extension):
In file included from ../include/linux/linkage.h:5,
                 from ../arch/m68k/fpsp040/skeleton.S:40:
../include/linux/compiler_types.h:331:5: warning: "__has_builtin" is not defined, evaluates to 0 [-Wundef]
  331 | #if __has_builtin(__builtin_dynamic_object_size)
      |     ^~~~~~~~~~~~~
../include/linux/compiler_types.h:331:18: error: missing binary operator before token "("
  331 | #if __has_builtin(__builtin_dynamic_object_size)
      |                  ^

[1] https://lore.kernel.org/netdev/202308112122.OuF0YZqL-lkp@intel.com/
Co-developed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v4: David: add _Static_assert to give better error message
    for non-const counts; add one more lvl of macros to ease up adding
    non-zeroing (or other) variant in the future;
v3: remove old macro needlessly kept in v2; fix build warning;
    reword doc comment;
v2: Kees: reuse __struct_size() instead of adding new macro
    (adding Kees as Co-dev here);
v1: change macro name; add macro for size read;
    accept struct type instead of ptr to it; change alignment;
---
 include/linux/compiler_types.h | 32 ++++++++++++++++++++-----------
 include/linux/fortify-string.h |  4 ----
 include/linux/overflow.h       | 35 ++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 15 deletions(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index c523c6683789..6f1ca49306d2 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -2,6 +2,15 @@
 #ifndef __LINUX_COMPILER_TYPES_H
 #define __LINUX_COMPILER_TYPES_H
 
+/*
+ * __has_builtin is supported on gcc >= 10, clang >= 3 and icc >= 21.
+ * In the meantime, to support gcc < 10, we implement __has_builtin
+ * by hand.
+ */
+#ifndef __has_builtin
+#define __has_builtin(x) (0)
+#endif
+
 #ifndef __ASSEMBLY__
 
 /*
@@ -134,17 +143,6 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
 # define __preserve_most
 #endif
 
-/* Builtins */
-
-/*
- * __has_builtin is supported on gcc >= 10, clang >= 3 and icc >= 21.
- * In the meantime, to support gcc < 10, we implement __has_builtin
- * by hand.
- */
-#ifndef __has_builtin
-#define __has_builtin(x) (0)
-#endif
-
 /* Compiler specific macros. */
 #ifdef __clang__
 #include <linux/compiler-clang.h>
@@ -352,6 +350,18 @@ struct ftrace_likely_data {
 # define __realloc_size(x, ...)
 #endif
 
+/*
+ * When the size of an allocated object is needed, use the best available
+ * mechanism to find it. (For cases where sizeof() cannot be used.)
+ */
+#if __has_builtin(__builtin_dynamic_object_size)
+#define __struct_size(p)	__builtin_dynamic_object_size(p, 0)
+#define __member_size(p)	__builtin_dynamic_object_size(p, 1)
+#else
+#define __struct_size(p)	__builtin_object_size(p, 0)
+#define __member_size(p)	__builtin_object_size(p, 1)
+#endif
+
 #ifndef asm_volatile_goto
 #define asm_volatile_goto(x...) asm goto(x)
 #endif
diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index da51a83b2829..1e7711185ec6 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -93,13 +93,9 @@ extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size)
 #if __has_builtin(__builtin_dynamic_object_size)
 #define POS			__pass_dynamic_object_size(1)
 #define POS0			__pass_dynamic_object_size(0)
-#define __struct_size(p)	__builtin_dynamic_object_size(p, 0)
-#define __member_size(p)	__builtin_dynamic_object_size(p, 1)
 #else
 #define POS			__pass_object_size(1)
 #define POS0			__pass_object_size(0)
-#define __struct_size(p)	__builtin_object_size(p, 0)
-#define __member_size(p)	__builtin_object_size(p, 1)
 #endif
 
 #define __compiletime_lessthan(bounds, length)	(	\
diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index f9b60313eaea..7b5cf4a5cd19 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -309,4 +309,39 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
 #define struct_size_t(type, member, count)					\
 	struct_size((type *)NULL, member, count)
 
+/**
+ * _DEFINE_FLEX() - helper macro for DEFINE_FLEX() family.
+ * Enables caller macro to pass (different) initializer.
+ *
+ * @type: structure type name, including "struct" keyword.
+ * @name: Name for a variable to define.
+ * @member: Name of the array member.
+ * @count: Number of elements in the array; must be compile-time const.
+ * @initializer: initializer expression (could be empty for no init).
+ */
+#define _DEFINE_FLEX(type, name, member, count, initializer)			\
+	_Static_assert(__builtin_constant_p(count),				\
+		       "onstack flex array members require compile-time const count"); \
+	union {									\
+		u8 bytes[struct_size_t(type, member, count)];			\
+		type obj;							\
+	} name##_u initializer;							\
+	type *name = (type *)&name##_u
+
+/**
+ * DEFINE_FLEX() - Define an on-stack instance of structure with a trailing
+ * flexible array member.
+ *
+ * @type: structure type name, including "struct" keyword.
+ * @name: Name for a variable to define.
+ * @member: Name of the array member.
+ * @count: Number of elements in the array; must be compile-time const.
+ *
+ * Define a zeroed, on-stack, instance of @type structure with a trailing
+ * flexible array member.
+ * Use __struct_size(@name) to get compile-time size of it afterwards.
+ */
+#define DEFINE_FLEX(type, name, member, count)			\
+	_DEFINE_FLEX(type, name, member, count, = {})
+
 #endif /* __LINUX_OVERFLOW_H */
-- 
2.40.1


