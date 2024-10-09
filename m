Return-Path: <netdev+bounces-133628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 380DD996922
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 13:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7935286BC2
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 11:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005F519258B;
	Wed,  9 Oct 2024 11:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aXJwBVSn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37BF1922E4;
	Wed,  9 Oct 2024 11:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728474310; cv=none; b=bkapz1SqW1TFRuxivBau0kbWfp5voNGVBnp9tPZCDsoi6mCn8lWXzBad09VaWNPt6yIPQBA3mTMoYZTlO8BL/cBZ2MNrzJNW5HWhZrlJcO5eifFbBDMh7Wiq7tNG/XHuaWkBY8zt9AGUC2yIznhsNk+tO+FkfZuZKE0dhjloTdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728474310; c=relaxed/simple;
	bh=8r1IFl2P2ya97tepeJZtnrP9PKIoKSadVT66Pgal9qA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nzNtuW/8xz7dlVYSp+CnUAfKmzaKMxN4Ghz0uWj32XpdFo7wHre/qezwioGA94IsVQv6B6hYSrUivMusfCfiZUFwVz52JgNxZM1DF/I6CoFTzg7RYwf+dRYwZfw/btwURyc+9sdzHb819rjXMiBmFZvYgsXJ8E97EnQ/ry5n040=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aXJwBVSn; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728474309; x=1760010309;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8r1IFl2P2ya97tepeJZtnrP9PKIoKSadVT66Pgal9qA=;
  b=aXJwBVSnpLefuuY50t/5qLFnJTmfGjBAC5vkaTEzUMTxEKceWDMoRNJN
   Lj/j5I3v5aji0J1wEBbALEgPu0Scq8mS+MpmNkku827ad90OFSnBZ7JVv
   KKmJZceqr9t7gKRSWsSg3AeQ1as7vP6ju5+S/X0IevltGEXYJ1m7dY9IF
   F0xg6ISDHj+M9qF4WDkfIDp705EwFtFAZrHsHJNSyk9sDwXhIYRKJvtgL
   HHL7gdCHWq1XvVNgNdWAAJKBFQ0yyhsWXxZ0+iw2rFpOXcdnzSbUBRTRE
   ma85KslkeaHAIou4M3M1lRePUo9TAcGHfgp/O0mAZ0twaGQsIEBEDs1H5
   Q==;
X-CSE-ConnectionGUID: +DdrRX8iSCWBdLp5NNHXDQ==
X-CSE-MsgGUID: OKLe45EoRQiBx8AyIxxmSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27660761"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="27660761"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 04:45:07 -0700
X-CSE-ConnectionGUID: bB6u94LKQYqu39rxHsLkFQ==
X-CSE-MsgGUID: nrz4ZnbPTISoWFIuDDgW+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="76670556"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa007.jf.intel.com with ESMTP; 09 Oct 2024 04:45:03 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.246.72])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id CFA392878C;
	Wed,  9 Oct 2024 12:45:00 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Cc: amadeuszx.slawinski@linux.intel.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	Markus Elfring <Markus.Elfring@web.de>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2] cleanup: adjust scoped_guard() to avoid potential warning
Date: Wed,  9 Oct 2024 13:44:17 +0200
Message-ID: <20241009114446.14873-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change scoped_guard() to make reasoning about it easier for static
analysis tools (smatch, compiler diagnostics), especially to enable them
to tell if the given scoped_guard() is conditional (interruptible-locks,
try-locks) or not (like simple mutex_lock()).

Add compile-time error if scoped_cond_guard() is used for non-conditional
lock class.

Beyond easier tooling and a little shrink reported by bloat-o-meter:
add/remove: 3/2 grow/shrink: 45/55 up/down: 1573/-2069 (-496)
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
"for (...; goto label) if (0) label: break;" idiom, so it's not packed
for reuse, what makes actual macros code cleaner.

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

CC: Dan Carpenter <dan.carpenter@linaro.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
PATCH v2:
drop Andy's NACK,
 (the reasons for NACK were in RFC v1; Peter backed up my idea for this
 patch in PATCH v1 discussion, and Andy withdrawn the NACK);
whitespace/formatting/style issues - Andy;
additional code comments - Dmitry.

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
 include/linux/cleanup.h | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index a3d3e888cf1f..7cb733bc981e 100644
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
@@ -167,14 +174,33 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 	CLASS(_name, __UNIQUE_ID(guard))
 
 #define __guard_ptr(_name) class_##_name##_lock_ptr
+#define __is_cond_ptr(_name) class_##_name##_is_conditional
+
+/* helper for the scoped_guard() macro
+ *
+ * Note that the "!__is_cond_ptr(_name)" part of the condition ensures
+ * that compiler would be sure that for unconditional locks the body of
+ * the loop could not be skipped; it is needed because the other
+ * part - "__guard_ptr(_name)(&scope)" - is too hard to deduce (even if
+ * could be proven true for unconditional locks).
+ */
+#define __scoped_guard_labeled(_label, _name, args...)			\
+	for (CLASS(_name, scope)(args);					\
+	     __guard_ptr(_name)(&scope) || !__is_cond_ptr(_name);	\
+	     ({ goto _label; }))					\
+		if (0) {						\
+_label:									\
+			break;						\
+		} else
+
+#define scoped_guard(_name, args...)	\
+	__scoped_guard_labeled(__UNIQUE_ID(label), _name, args)
 
-#define scoped_guard(_name, args...)					\
-	for (CLASS(_name, scope)(args),					\
-	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void *)1)
 
 #define scoped_cond_guard(_name, _fail, args...) \
 	for (CLASS(_name, scope)(args), \
-	     *done = NULL; !done; done = (void *)1) \
+	     *done = NULL; !done; done = (void *)1 +	\
+	     BUILD_BUG_ON_ZERO(!__is_cond_ptr(_name)))	\
 		if (!__guard_ptr(_name)(&scope)) _fail; \
 		else
 
@@ -233,14 +259,17 @@ static inline class_##_name##_t class_##_name##_constructor(void)	\
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


