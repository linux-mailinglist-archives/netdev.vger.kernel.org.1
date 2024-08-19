Return-Path: <netdev+bounces-119909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB55F957777
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 00:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A83C9283DA6
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 22:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522181DD3B0;
	Mon, 19 Aug 2024 22:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="atyuC8up"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09465156C70
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 22:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724106893; cv=none; b=tPz2NGpXUB13PbtT8aKUhofJ5mRutf37ZR0SIpsIg8eIdz1Kpd0CbRs7rpY3gEIWD0pwa4nPNCRqlyL4BH7eXIJNsrCG3WCXLAfhrKVa2IonqtYQ06R2VYmcti11oNLFUHhcg9xo4SOIz/itottI5d1COiz+oYAmzqIMlZEzl7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724106893; c=relaxed/simple;
	bh=DJDoqp0htRfITI5CdB3sNkchUG+PTXU5e2Geme6GscI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mLqMidNxZVsVF4WTQD+emPjO2A2dYQUQ7ue+5vfsm6NzFJNgqhaN8Svu0NRj2jaCac08aOGJxJ/6OP7T0/Z7AJkhT6g0ArS3Ryy9qP4yEC75VCeNCNLSr8fJw0UDobF+FUwyngRTDzf45Us1Iq1qzYnvT0ymEC4UQ7CzM/X3NjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=atyuC8up; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724106891; x=1755642891;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DJDoqp0htRfITI5CdB3sNkchUG+PTXU5e2Geme6GscI=;
  b=atyuC8up+z1BQ9fOfkdff3q8UXOwcPG5ZAkxPQkJOBXZNHUQp0QlAUFq
   V68iLaJuBvtVE3//M66YR+DGjeZq1b+Iar7hbhx1tYFodzhVn3rhk4+2y
   avFj49ukOeOVT18Hb860xfQCtRXekWKgXw8nVZ2tL5ClrEh1Vm4i5baw5
   DrsYZEwZzoHz7hhrj9DekwPkUqAdY9InuHvyNdDdFndUQUw0fjmxST0/6
   eS+y7xz6WahPgsIg7pXctTwJlOFNYu2GmYDTX/pzXE1TZtqqpzAKf1hkc
   wz5G5rHbIdg0k+9biL2/6vFyX3B1ogsoEc79toOEdPGngj5g22jPJTwJR
   w==;
X-CSE-ConnectionGUID: a0BdZA5xQVKrsrZ5bQWEPA==
X-CSE-MsgGUID: 8uFl+6H9R8qJQyAFsFtVdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="33535149"
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="33535149"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 15:34:50 -0700
X-CSE-ConnectionGUID: LA4APdeRQ1SoTr+11jj1Dg==
X-CSE-MsgGUID: CigschchSr23Qvwe0Z3XXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="64700504"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 19 Aug 2024 15:34:49 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	joshua.a.hay@intel.com,
	michal.kubiak@intel.com,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>
Subject: [PATCH net-next v2 1/9] unroll: add generic loop unroll helpers
Date: Mon, 19 Aug 2024 15:34:33 -0700
Message-ID: <20240819223442.48013-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240819223442.48013-1-anthony.l.nguyen@intel.com>
References: <20240819223442.48013-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Lobakin <aleksander.lobakin@intel.com>

There are cases when we need to explicitly unroll loops. For example,
cache operations, filling DMA descriptors on very high speeds etc.
Add compiler-specific attribute macros to give the compiler a hint
that we'd like to unroll a loop.
Example usage:

 #define UNROLL_BATCH 8

	unrolled_count(UNROLL_BATCH)
	for (u32 i = 0; i < UNROLL_BATCH; i++)
		op(priv, i);

Note that sometimes the compilers won't unroll loops if they think this
would have worse optimization and perf than without unrolling, and that
unroll attributes are available only starting GCC 8. For older compiler
versions, no hints/attributes will be applied.
For better unrolling/parallelization, don't have any variables that
interfere between iterations except for the iterator itself.

Co-developed-by: Jose E. Marchesi <jose.marchesi@oracle.com> # pragmas
Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 include/linux/unroll.h | 50 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 include/linux/unroll.h

diff --git a/include/linux/unroll.h b/include/linux/unroll.h
new file mode 100644
index 000000000000..e305d155faa6
--- /dev/null
+++ b/include/linux/unroll.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2024 Intel Corporation */
+
+#ifndef _LINUX_UNROLL_H
+#define _LINUX_UNROLL_H
+
+#ifdef CONFIG_CC_IS_CLANG
+#define __pick_unrolled(x, y)	_Pragma(#x)
+#elif CONFIG_GCC_VERSION >= 80000
+#define __pick_unrolled(x, y)	_Pragma(#y)
+#else
+#define __pick_unrolled(x, y)	/* not supported */
+#endif
+
+/**
+ * unrolled - loop attributes to ask the compiler to unroll it
+ *
+ * Usage:
+ *
+ * #define BATCH 4
+ *	unrolled_count(BATCH)
+ *	for (u32 i = 0; i < BATCH; i++)
+ *		// loop body without cross-iteration dependencies
+ *
+ * This is only a hint and the compiler is free to disable unrolling if it
+ * thinks the count is suboptimal and may hurt performance and/or hugely
+ * increase object code size.
+ * Not having any cross-iteration dependencies (i.e. when iter x + 1 depends
+ * on what iter x will do with variables) is not a strict requirement, but
+ * provides best performance and object code size.
+ * Available only on Clang and GCC 8.x onwards.
+ */
+
+/* Ask the compiler to pick an optimal unroll count, Clang only */
+#define unrolled							    \
+	__pick_unrolled(clang loop unroll(enable), /* nothing */)
+
+/* Unroll each @n iterations of a loop */
+#define unrolled_count(n)						    \
+	__pick_unrolled(clang loop unroll_count(n), GCC unroll n)
+
+/* Unroll the whole loop */
+#define unrolled_full							    \
+	__pick_unrolled(clang loop unroll(full), GCC unroll 65534)
+
+/* Never unroll a loop */
+#define unrolled_none							    \
+	__pick_unrolled(clang loop unroll(disable), GCC unroll 1)
+
+#endif /* _LINUX_UNROLL_H */
-- 
2.42.0


