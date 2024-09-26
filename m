Return-Path: <netdev+bounces-129969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 647929874A5
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 15:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E36691F23672
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 13:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACCF3B7A8;
	Thu, 26 Sep 2024 13:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I3IHAHwX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FC55258;
	Thu, 26 Sep 2024 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727358254; cv=none; b=oNfMT2SuOug/vEr+SLmd2MwupAC1OJ2u0zVaYvF4teuQLw8xVT5KKLMDDGbUco1ndPsD/2vKyvoNlf/+Spm5r34W77KYiKV1lfwdHQZ3tFVaZPuN3QdluMrOqYeBz9hTz+NkXlcKnl3m92fO/9+7UUrVHQBNdTgGYUgeqk/p1Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727358254; c=relaxed/simple;
	bh=EwWY4YFFiTrI5gaJNADe+HhvhdjLiVd/51E26d97I8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OFKe4AjrcQPz2wou2Cw14ftw378Ts/5xH26nBRrw64As8weJtu48u+myyz5wa3ecIA8RXnC4Y4bV+M3jMFPFGWLuVWGnkamUXLbmoG1qhpKfoYvi/j0iwMNSqvxyZ8zfPysgKHAo013WSSBD4/Mx5QHOVKlKKF7aZi79nqhYGjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I3IHAHwX; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727358252; x=1758894252;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EwWY4YFFiTrI5gaJNADe+HhvhdjLiVd/51E26d97I8s=;
  b=I3IHAHwXwPzYqv3LMLAi/WjDnNmqkYb5sB6CF4GYp1SpwUxzmPZ9FvAj
   ykBv2KOMx8npH4GOpvXqlgUuFUg/bSgYHaGWBNsjIPwAeZ5o8k+Rx99hZ
   YOsoC0p0ni4dFJl11U0BNGoNVrsJ5LLc7S0gEJkJDXXxaMbacgsquNJ2B
   pjf3GgbVaDK/eTSPp7CvPS2TPBYTWJk+Hmvvrg4X5ycKVHsDHBsYYF54t
   ZfbwathN+jdl0znJX/eMVfOdVtaeVWGSVn06BVVU43RXAvqi8IMVsTJGV
   Tldnvqqlt/nlQxeg3nE+GVfOzZr6mGMvxp8guast6K9fmpYjBpsuqMbNk
   Q==;
X-CSE-ConnectionGUID: eqkPpwI6TCCxCJFqOUhtiA==
X-CSE-MsgGUID: kOVRkQ/0Qd+k2cWhFjII7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="48983299"
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="48983299"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 06:44:11 -0700
X-CSE-ConnectionGUID: Kled27RQQFaToMDRYDhwjg==
X-CSE-MsgGUID: 5PQNCPknRTGIhZFzbvlhWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="72048148"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa010.jf.intel.com with ESMTP; 26 Sep 2024 06:44:09 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.246.101])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 6B09A28196;
	Thu, 26 Sep 2024 14:44:06 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Cc: amadeuszx.slawinski@linux.intel.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [RFC PATCH] cleanup: make scoped_guard() to be return-friendly
Date: Thu, 26 Sep 2024 15:41:38 +0200
Message-ID: <20240926134347.19371-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simply enable one to write code like:

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

NAKed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
Andy believes that this change is completely wrong C, and wants me
to keep the following 4 corncers attached (I either don't agree
or they are irrelevant), but here we go:
1. wrong usage of scoped_guard().
   In the described cases the guard() needs to be used.
2. the code like:
	int foo(...)
	{
		my_macro(...)
			return X;
	}
   without return 0; (which is a known dead code) is counter intuitive
   from the C language perspective.
3. [about netdev not liking guard()]
   I do not buy "too hard" when it's too easy to get a preprocessed *.i
   file if needed for any diagnosis which makes things quite clear.
   Moreover, once done the developer will much easier understands how this
   "magic" works (there is no rocket science, but yes, the initial
   threshold probably a bit higher than just pure C).
4. Besides that (if you was following the minmax discussion in LKML) the
   macro expansion may be problematic and lead to the unbelievable huge .i
   files that compiles dozens of seconds on modern CPUs (I experienced
   myself that with AtomISP driver which drove the above mentioned minmax
   discussion).
   [Przemek - nested scoped_guard() usage expands linearly]
---
 include/linux/cleanup.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index d9e613803df1..6b568a8a7f9c 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -168,9 +168,16 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 
 #define __guard_ptr(_name) class_##_name##_lock_ptr
 
-#define scoped_guard(_name, args...)					\
-	for (CLASS(_name, scope)(args),					\
-	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void *)1)
+#define scoped_guard(_name, args...)	\
+	__scoped_guard_labeled(__UNIQUE_ID(label), _name, args)
+
+#define __scoped_guard_labeled(_label, _name, args...)	\
+	if (0)						\
+		_label: ;				\
+	else						\
+		for (CLASS(_name, scope)(args);		\
+		     __guard_ptr(_name)(&scope), 1;	\
+		     ({ goto _label; }))
 
 #define scoped_cond_guard(_name, _fail, args...) \
 	for (CLASS(_name, scope)(args), \

base-commit: 151ac45348afc5b56baa584c7cd4876addf461ff
-- 
2.46.0


