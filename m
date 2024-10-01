Return-Path: <netdev+bounces-130920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EC398C0EB
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 16:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9455A28524A
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 14:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415101C9B74;
	Tue,  1 Oct 2024 14:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lVwiPx8P"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2330D199381;
	Tue,  1 Oct 2024 14:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727794727; cv=none; b=HxdPntkXmAf1yeok1HxVOkkSfNdrkUoM5SHdRv/CakFFc7My4F5dOum4Uv1Nm1TljSHAz8Ewr9ZQNpcILR6sAFTSgOAnDqS9p6y+pGN8QofYCKCuajpd/l6gty3zzoBdUXrJVisHl0r1LdSyFOzk80z37p4Kw/OqqIrWWJ52yD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727794727; c=relaxed/simple;
	bh=0DMXDrBQoM9tXS8/a1iHzfVSzairo1GBHYZQlJVRaGI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n/3xXkrr/IzRj3o/l1Css051G0Q8TBx6d/v307GN4B5R3jGTcbYzTqbaaE/hMWV69BsELJVzMf1GHXTpxC0vq0pvq6y9wA9ia7WsLdeVMzZ54JvWFcG3LhV88gLUG5acqhreMc7bH5BHqVOvZaXnx0wHqtAew/5MZ4w2UrsByhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lVwiPx8P; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727794726; x=1759330726;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0DMXDrBQoM9tXS8/a1iHzfVSzairo1GBHYZQlJVRaGI=;
  b=lVwiPx8PPqxBOubynnLE5RrcEOzRru7F3ILBshsNy1Q1Tj4wcjzYtpDJ
   pyCyKs3QS+7G1W8RSFERGzojfjalMJNOA4rvmOYe1Iw87QmAzxaKCgd5E
   xDzLcgWSQllRqFSA4Xmrv1JYc0/+BirBX11CbYSdamsNq+Ix9DlZU+woo
   xEwmFxA796gWPXWB6I05VqRkFPd5cErtlKdGkDz07OJ/MJI/mL1batpG5
   z1Zz2i0M/WrjdDLJz2q6yUSXLwdd/cdIyqoniKchWbwmOAJoalzx+S2qf
   7WV6AI3LW3hMKG9nW+lY2Y3HGb0E7KVmrGVE+T5v0cnPqHKbYwcKKBJ2z
   g==;
X-CSE-ConnectionGUID: 2x4THVwxQsSFu0NLlsLOWg==
X-CSE-MsgGUID: ntqN2KRNQLuIeyvRzPMrWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="27065905"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="27065905"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 07:58:45 -0700
X-CSE-ConnectionGUID: HVJFx2DlRWO8pYsoQesihA==
X-CSE-MsgGUID: OkuHqZ1+SvS9soqjc5mZ0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="74487271"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa008.jf.intel.com with ESMTP; 01 Oct 2024 07:58:42 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 806F028199;
	Tue,  1 Oct 2024 15:58:40 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Cc: amadeuszx.slawinski@linux.intel.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	Markus Elfring <Markus.Elfring@web.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [RFC PATCH v2] Simply enable one to write code like:
Date: Tue,  1 Oct 2024 16:57:18 +0200
Message-Id: <20241001145718.8962-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

int foo(struct my_drv *adapter)
{
	scoped_guard(spinlock, &adapter->some_spinlock)
		return adapter->spinlock_protected_var;
}

Current scoped_guard() implementation does not support that,
due to compiler complaining:
error: control reaches end of non-void function [-Werror=return-type]

One could argue that for such use case it would be better to use
guard(spinlock)(&adapter->some_spinlock), I disagree. I could also say
that coding with my proposed locking style is also very pleasant, as I'm
doing so for a few weeks already.

Technical stuff about the change:
scoped_guard() macro uses common idiom of using "for" statement to declare
a scoped variable. Unfortunately, current logic is too hard for compiler
diagnostics to be sure that there is exactly one loop step; fix that.

To make any loop so trivial that there is no above warning, it must not
depend on any variable to tell if there are more steps. There is no
obvious solution for that in C, but one could use the compound statement
expression with "goto" jumping past the "loop", effectively leaving only
the subscope part of the loop semantics.

More impl details:
one more level of macro indirection is now needed to avoid duplicating
label names;
I didn't spot any other place that is using
	if (0) past_the_loop:; else for (...; 1; ({goto past_the_loop}))
idiom, so it's not packed for reuse what makes actual macros code cleaner.

There was also a need to introduce const 0/1 variable per lock class, it
is used to aid compiler diagnostics reasoning about "exactly 1 step" loops
(note that converting that to function would undo the whole benefit).

NAKed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
Andy believes that this change is completely wrong C, the reasons
(that I disagree with of course, are in v1, below the commit message).

v2:
 remove ", 1" condition, as scoped_guard() could be used also for
 conditional locks (try-lock, irq-lock, etc) - this was pointed out by
 Dmitry Torokhov and Dan Carpenter;
 reorder macros to have them defined prior to use - Markus Elfring.

v1:
https://lore.kernel.org/netdev/20240926134347.19371-1-przemyslaw.kitszel@intel.com
---
 include/linux/cleanup.h | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index a3d3e888cf1f..72dcfeb3ec13 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -151,12 +151,18 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
  *
  */
 
+
+#define DEFINE_CLASS_IS_CONDITIONAL(_name, _is_cond)	\
+static __maybe_unused const bool class_##_name##_is_conditional = _is_cond
+
 #define DEFINE_GUARD(_name, _type, _lock, _unlock) \
+	DEFINE_CLASS_IS_CONDITIONAL(_name, 0); \
 	DEFINE_CLASS(_name, _type, if (_T) { _unlock; }, ({ _lock; _T; }), _type _T); \
 	static inline void * class_##_name##_lock_ptr(class_##_name##_t *_T) \
 	{ return *_T; }
 
 #define DEFINE_GUARD_COND(_name, _ext, _condlock) \
+	DEFINE_CLASS_IS_CONDITIONAL(_name##_ext, 1); \
 	EXTEND_CLASS(_name, _ext, \
 		     ({ void *_t = _T; if (_T && !(_condlock)) _t = NULL; _t; }), \
 		     class_##_name##_t _T) \
@@ -167,10 +173,18 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 	CLASS(_name, __UNIQUE_ID(guard))
 
 #define __guard_ptr(_name) class_##_name##_lock_ptr
+#define __is_cond_ptr(_name) class_##_name##_is_conditional
+
+#define scoped_guard(_name, args...)	\
+	__scoped_guard_labeled(__UNIQUE_ID(label), _name, args)
 
-#define scoped_guard(_name, args...)					\
-	for (CLASS(_name, scope)(args),					\
-	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void *)1)
+#define __scoped_guard_labeled(_label, _name, args...)	\
+	if (0)						\
+		_label: ;				\
+	else						\
+		for (CLASS(_name, scope)(args);		\
+		     __guard_ptr(_name)(&scope) || !__is_cond_ptr(_name); \
+		     ({goto _label;}))
 
 #define scoped_cond_guard(_name, _fail, args...) \
 	for (CLASS(_name, scope)(args), \
@@ -233,14 +247,17 @@ static inline class_##_name##_t class_##_name##_constructor(void)	\
 }
 
 #define DEFINE_LOCK_GUARD_1(_name, _type, _lock, _unlock, ...)		\
+DEFINE_CLASS_IS_CONDITIONAL(_name, 0);					\
 __DEFINE_UNLOCK_GUARD(_name, _type, _unlock, __VA_ARGS__)		\
 __DEFINE_LOCK_GUARD_1(_name, _type, _lock)
 
 #define DEFINE_LOCK_GUARD_0(_name, _lock, _unlock, ...)			\
+DEFINE_CLASS_IS_CONDITIONAL(_name, 0);					\
 __DEFINE_UNLOCK_GUARD(_name, void, _unlock, __VA_ARGS__)		\
 __DEFINE_LOCK_GUARD_0(_name, _lock)
 
 #define DEFINE_LOCK_GUARD_1_COND(_name, _ext, _condlock)		\
+	DEFINE_CLASS_IS_CONDITIONAL(_name##_ext, 1);			\
 	EXTEND_CLASS(_name, _ext,					\
 		     ({ class_##_name##_t _t = { .lock = l }, *_T = &_t;\
 		        if (_T->lock && !(_condlock)) _T->lock = NULL;	\

base-commit: c824deb1a89755f70156b5cdaf569fca80698719
-- 
2.39.3


