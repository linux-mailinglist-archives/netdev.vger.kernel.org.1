Return-Path: <netdev+bounces-134575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9743C99A3A8
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 14:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07C80B2160D
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 12:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C184209662;
	Fri, 11 Oct 2024 12:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jV6YcTDl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986DB1494D4;
	Fri, 11 Oct 2024 12:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728648954; cv=none; b=Yt1QQzSFNU6A7bJbmzxMtE3R6238UsqkJW2PKyP2PcPSyL33m6N2ppV9dX+zcHlZ+gHdKRw9pcEmQ5BXdBnyXHWhQMfY3Af2ipcMXWOSixz2Wbnh0A+fqJHl+wDIFp8rUIeQqjradHjN9ZM1Zdqvx+3uPsTj8Zsg9tfs2jLH1AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728648954; c=relaxed/simple;
	bh=3u60z18D7LwxQMADWHb5vuCGXZzarwojDMy7xDHWd7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k1OWGvCirYS1g7E7qeKRSZC0x+AR6ysG9EE9TB/Yp0wez+2IgB0xnV7qKdJ0Kajo5IL/TjRwEqhDAw1A2gyQ9lkeOiioQPBLPG+LipxCKOx0Ksgmktd6c5SXwOoEUv5XfTc9AZ6p0ub4ku2Nrg7hQTAsQ4KzHpIkeqvVkpl36KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jV6YcTDl; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728648952; x=1760184952;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3u60z18D7LwxQMADWHb5vuCGXZzarwojDMy7xDHWd7Y=;
  b=jV6YcTDlKOVC9SBUnh2Hs9mqVqgAUqA46JTWhgntcqH0K72doDLk8b6E
   sbca6ufyoMssBLcbpUNdsnNqURTMDuWpVgTo3Up236hyHqEwqwlr4KcOB
   9OwamTQfScw23P35WxQKiDT96wuXAYCRUAQyJfzfELPF+Lv2hCLAfI1uU
   W+zes0PVBXfj9mZOVSN4X8O1L7IN3xZXJd/KUSmDZn+FE27JliHKOZVc/
   xDLVhDZwmJuyBnYB+w/6pntfN0SePL86PZn51MJw+6jRyYc5FO0kSuj3N
   ifaUIOxPT305qdAgsb9Xz8Dk8sfR5DiMLZN44bhWPmfxWPf7JQlFC1l0q
   w==;
X-CSE-ConnectionGUID: B3kDLGn7RDSS/GCemtdebQ==
X-CSE-MsgGUID: clF8CiZnTuG6SyYStYblmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="28203973"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="28203973"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 05:15:51 -0700
X-CSE-ConnectionGUID: GyI3WlUURoerF69HxqC/1A==
X-CSE-MsgGUID: VxECejlVQBK5cZuwuzY4Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="81422578"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 11 Oct 2024 05:15:47 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.246.197])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 768E828781;
	Fri, 11 Oct 2024 13:15:45 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Cc: amadeuszx.slawinski@linux.intel.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	Markus Elfring <Markus.Elfring@web.de>,
	Kees Cook <keescook@chromium.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	David Lechner <dlechner@baylibre.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v3] cleanup: adjust scoped_guard() macros to avoid potential warning
Date: Fri, 11 Oct 2024 14:15:27 +0200
Message-ID: <20241011121535.28049-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change scoped_guard() and scoped_cond_guard() macros to make reasoning
about them easier for static analysis tools (smatch, compiler
diagnostics), especially to enable them to tell if the given usage of
scoped_guard() is with a conditional lock class (interruptible-locks,
try-locks) or not (like simple mutex_lock()).

Add compile-time error if scoped_cond_guard() is used for non-conditional
lock class.

Beyond easier tooling and a little shrink reported by bloat-o-meter
this patch enables developer to write code like:

int foo(struct my_drv *adapter)
{
	scoped_guard(spinlock, &adapter->some_spinlock)
		return adapter->spinlock_protected_var;
}

Current scoped_guard() implementation does not support that,
due to compiler complaining:
error: control reaches end of non-void function [-Werror=return-type]

Technical stuff about the change:
scoped_guard() macro uses common idiom of using "for" statement to declare
a scoped variable. Unfortunately, current logic is too hard for compiler
diagnostics to be sure that there is exactly one loop step; fix that.

To make any loop so trivial that there is no above warning, it must not
depend on any non-const variable to tell if there are more steps. There is
no obvious solution for that in C, but one could use the compound
statement expression with "goto" jumping past the "loop", effectively
leaving only the subscope part of the loop semantics.

More impl details:
one more level of macro indirection is now needed to avoid duplicating
label names;
I didn't spot any other place that is using the
"for (...; goto label) if (0) label: break;" idiom, so it's not packed for
reuse beyond scoped_guard() family, what makes actual macros code cleaner.

There was also a need to introduce const true/false variable per lock
class, it is used to aid compiler diagnostics reasoning about "exactly
1 step" loops (note that converting that to function would undo the whole
benefit).

Big thanks to Andy Shevchenko for help on this patch, both internal and
public, ranging from whitespace/formatting, through commit message
clarifications, general improvements, ending with presenting alternative
approaches - all despite not even liking the idea.

Big thanks to Dmitry Torokhov for the idea of compile-time check for
scoped_cond_guard(), and general improvements for the patch.

Big thanks to David Lechner for idea to cover also scoped_cond_guard().

CC: David Lechner <dlechner@baylibre.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
PATCH v3:
cover also scoped_cond_guard() to be able to return from them (David Lechner);
capitalize comment (Andy)

PATCH v2:
drop Andy's NACK,
 (the reasons for NACK were in RFC v1; Peter backed up my idea for this
 patch in PATCH v1 discussion, and Andy withdrawn the NACK);
whitespace/formatting/style issues - Andy;
additional code comments - Dmitry.
https://lore.kernel.org/netdev/20241009114446.14873-1-przemyslaw.kitszel@intel.com

PATCH v1:
changes thanks to Dmitry Torokhov:
 better writeup in commit msg;
 "__" prefix added to internal macros;
 reorder "if (0)-else" and "for" to avoid goto jumping back;
 compile-time check for scoped_cond_guard()
https://lore.kernel.org/netdev/20241003113906.750116-1-przemyslaw.kitszel@intel.com

RFC v2:
https://lore.kernel.org/netdev/20241001145718.8962-1-przemyslaw.kitszel@intel.com
 remove ", 1" condition, as scoped_guard() could be used also for
 conditional locks (try-lock, irq-lock, etc) - this was pointed out by
 Dmitry Torokhov and Dan Carpenter;
 reorder macros to have them defined prior to use - Markus Elfring.

RFC v1:
https://lore.kernel.org/netdev/20240926134347.19371-1-przemyslaw.kitszel@intel.com
---
 include/linux/cleanup.h | 41 +++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index a3d3e888cf1f..6069dd6237df 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -149,14 +149,21 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
  *      similar to scoped_guard(), except it does fail when the lock
  *      acquire fails.
  *
+ *	Only for conditional locks.
+ *
  */
 
+#define __DEFINE_CLASS_IS_CONDITIONAL(_name, _is_cond)	\
+static __maybe_unused const bool class_##_name##_is_conditional = _is_cond
+
 #define DEFINE_GUARD(_name, _type, _lock, _unlock) \
+	__DEFINE_CLASS_IS_CONDITIONAL(_name, false); \
 	DEFINE_CLASS(_name, _type, if (_T) { _unlock; }, ({ _lock; _T; }), _type _T); \
 	static inline void * class_##_name##_lock_ptr(class_##_name##_t *_T) \
 	{ return *_T; }
 
 #define DEFINE_GUARD_COND(_name, _ext, _condlock) \
+	__DEFINE_CLASS_IS_CONDITIONAL(_name##_ext, true); \
 	EXTEND_CLASS(_name, _ext, \
 		     ({ void *_t = _T; if (_T && !(_condlock)) _t = NULL; _t; }), \
 		     class_##_name##_t _T) \
@@ -167,17 +174,32 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 	CLASS(_name, __UNIQUE_ID(guard))
 
 #define __guard_ptr(_name) class_##_name##_lock_ptr
+#define __is_cond_ptr(_name) class_##_name##_is_conditional
 
-#define scoped_guard(_name, args...)					\
-	for (CLASS(_name, scope)(args),					\
-	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void *)1)
+/*
+ * Helper macro for scoped_guard() and scoped_cond_guard().
+ *
+ * Note that the "__is_cond_ptr(_name)" part of the condition ensures that
+ * compiler would be sure that for the unconditional locks the body of the
+ * loop (caller-provided code glued to the else clause) could not be skipped.
+ * It is needed because the other part - "__guard_ptr(_name)(&scope)" - is too
+ * hard to deduce (even if could be proven true for unconditional locks).
+ */
+#define __scoped_guard(_name, _fail, _label, args...)				\
+	for (CLASS(_name, scope)(args);	true; ({ goto _label; }))		\
+		if (!__guard_ptr(_name)(&scope) && __is_cond_ptr(_name)) {	\
+			_fail;							\
+_label:										\
+			break;							\
+		} else
 
-#define scoped_cond_guard(_name, _fail, args...) \
-	for (CLASS(_name, scope)(args), \
-	     *done = NULL; !done; done = (void *)1) \
-		if (!__guard_ptr(_name)(&scope)) _fail; \
-		else
+#define scoped_guard(_name, args...)	\
+	__scoped_guard(_name, /* empty */, __UNIQUE_ID(label), args)
 
+#define scoped_cond_guard(_name, _fail, args...)			\
+	__scoped_guard(_name,						\
+		       BUILD_BUG_ON(!__is_cond_ptr(_name)); _fail,	\
+		       __UNIQUE_ID(label), args)
 /*
  * Additional helper macros for generating lock guards with types, either for
  * locks that don't have a native type (eg. RCU, preempt) or those that need a
@@ -233,14 +255,17 @@ static inline class_##_name##_t class_##_name##_constructor(void)	\
 }
 
 #define DEFINE_LOCK_GUARD_1(_name, _type, _lock, _unlock, ...)		\
+__DEFINE_CLASS_IS_CONDITIONAL(_name, false);				\
 __DEFINE_UNLOCK_GUARD(_name, _type, _unlock, __VA_ARGS__)		\
 __DEFINE_LOCK_GUARD_1(_name, _type, _lock)
 
 #define DEFINE_LOCK_GUARD_0(_name, _lock, _unlock, ...)			\
+__DEFINE_CLASS_IS_CONDITIONAL(_name, false);				\
 __DEFINE_UNLOCK_GUARD(_name, void, _unlock, __VA_ARGS__)		\
 __DEFINE_LOCK_GUARD_0(_name, _lock)
 
 #define DEFINE_LOCK_GUARD_1_COND(_name, _ext, _condlock)		\
+	__DEFINE_CLASS_IS_CONDITIONAL(_name##_ext, true);		\
 	EXTEND_CLASS(_name, _ext,					\
 		     ({ class_##_name##_t _t = { .lock = l }, *_T = &_t;\
 		        if (_T->lock && !(_condlock)) _T->lock = NULL;	\

base-commit: 44badc908f2c85711cb18e45e13119c10ad3a05f
-- 
2.46.0


