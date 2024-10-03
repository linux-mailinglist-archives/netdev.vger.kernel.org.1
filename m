Return-Path: <netdev+bounces-131569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2F898EE53
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 13:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659DB1F21F12
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 11:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8D8154C12;
	Thu,  3 Oct 2024 11:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B7LKS52/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642F51474C5;
	Thu,  3 Oct 2024 11:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727955640; cv=none; b=bGmDN6wenjfBaELkGpcEsit1uvNc2hswcvfYTpwJXtFnkubdwaYIEAgA0lXOog9udcVysRkfA16VTL/c5R76EzOWzeuCrKkRVPLOoPvwm4yMLOkXtwJtqzqU1Te5xIAirES5cyJD+bGyHHhZx0uM6aTvdBhhELi47+a37lprA7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727955640; c=relaxed/simple;
	bh=Ia7rKoih3Rx0ytKOu19RXISEA5gt9PfG989IGMd2yJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DZ1I8bNQte6VdVRNj0uypB7Sb4XLeqOquZZrFjRrcatvT3AtklQAy40bHR5D3Dg7GCtnPhkCpwHXYN04blQSXXJ3iz2+k3eexu233p2yS+7cbm6mkwKK0FITmklCIHgXg0lnEuP3CtXHEzCEsLUmDLOggjhoNqf9472JP9/zyIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B7LKS52/; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727955638; x=1759491638;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ia7rKoih3Rx0ytKOu19RXISEA5gt9PfG989IGMd2yJ0=;
  b=B7LKS52//0nQMQPefeOYylj6JcgD7JbhUEcCUYi375q0xxFFw7SyY3by
   6s4NjumIAF23lY4l9s+dnwTqouF4medlEqQ9rlmrP9CJ1eYWZPpfupZnW
   A0LXdCO27UH3uaLjKzQ1rRGCqdh6Mh9kTyTLoPcfekN3eUmJDHnoMtmeI
   +ub4Z9H0/Q0W6Bol4ghjDe0t6iK05GZVGyiumpU2GscvwhSx/z9Zy4VaE
   C8dFnfqLxxewJtHD3gjFoaQFLmD53NdCqaWgDhaomHlXpQkCHNE+fkfDa
   81Zxe+Ql4HAHEPjJcwPcox0f0Rycfer83F+sbTExNBatBIFHz3dHngsEB
   A==;
X-CSE-ConnectionGUID: Ep0pxO+mR22RCyfnqmHUkQ==
X-CSE-MsgGUID: cB29wd/MSmO6RdUJPO4CZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="30937700"
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="30937700"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 04:40:37 -0700
X-CSE-ConnectionGUID: YgjNEeofT5uOZeNFaYY1ZA==
X-CSE-MsgGUID: KSYF338UQMu9e+EkjA/tYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="75120281"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa008.jf.intel.com with ESMTP; 03 Oct 2024 04:40:32 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 2CB1427BD0;
	Thu,  3 Oct 2024 12:40:31 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: linux-kernel@vger.kernel.org
Cc: amadeuszx.slawinski@linux.intel.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	Markus Elfring <Markus.Elfring@web.de>,
	Kees Cook <kees@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v1] cleanup: adjust scoped_guard() to avoid potential warning
Date: Thu,  3 Oct 2024 13:39:06 +0200
Message-Id: <20241003113906.750116-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
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

CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>
CC: Peter Zijlstra <peterz@infradead.org>
NAKed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
Andy believes that this change enables completely wrong C, the reasons
(that I disagree with of course, are in v1, below the commit message).

PATCH v1:
changes thanks to Dmitry Torokhov:
 better writeup in commit msg;
 "__" prefix added to internal macros;
 reorder "if (0)-else" and "for" to avoid goto jumping back;
 compile-time check for scoped_cond_guard()

RFC v2:
https://lore.kernel.org/netdev/35b3305f-d2c6-4d2b-9ac5-8bbb93873b92@stanley.mountain
 remove ", 1" condition, as scoped_guard() could be used also for
 conditional locks (try-lock, irq-lock, etc) - this was pointed out by
 Dmitry Torokhov and Dan Carpenter;
 reorder macros to have them defined prior to use - Markus Elfring.

RFC v1:
https://lore.kernel.org/netdev/20240926134347.19371-1-przemyslaw.kitszel@intel.com
---
 include/linux/cleanup.h | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index a3d3e888cf1f..eb97d0520202 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -151,12 +151,17 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
  *
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
@@ -167,14 +172,25 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 	CLASS(_name, __UNIQUE_ID(guard))
 
 #define __guard_ptr(_name) class_##_name##_lock_ptr
+#define __is_cond_ptr(_name) class_##_name##_is_conditional
+
+#define __scoped_guard_labeled(_label, _name, args...)			\
+	for (CLASS(_name, scope)(args);					\
+	     __guard_ptr(_name)(&scope) || !__is_cond_ptr(_name);	\
+		     ({ goto _label; }))				\
+		if (0)							\
+		_label:							\
+			break;						\
+		else
+
+#define scoped_guard(_name, args...)	\
+	__scoped_guard_labeled(__UNIQUE_ID(label), _name, args)
 
-#define scoped_guard(_name, args...)					\
-	for (CLASS(_name, scope)(args),					\
-	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void *)1)
 
 #define scoped_cond_guard(_name, _fail, args...) \
 	for (CLASS(_name, scope)(args), \
-	     *done = NULL; !done; done = (void *)1) \
+	     *done = NULL; !done; done = (void *)1 +  	\
+	     BUILD_BUG_ON_ZERO(!__is_cond_ptr(_name)))	\
 		if (!__guard_ptr(_name)(&scope)) _fail; \
 		else
 
@@ -233,14 +249,17 @@ static inline class_##_name##_t class_##_name##_constructor(void)	\
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

base-commit: 62a0e2fa40c5c06742b8b4997ba5095a3ec28503
-- 
2.39.3


