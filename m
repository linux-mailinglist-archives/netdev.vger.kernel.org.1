Return-Path: <netdev+bounces-128521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D520297A14E
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 14:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 673511F240AB
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 12:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB4C15699E;
	Mon, 16 Sep 2024 12:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="bYGSkZ4u"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35689156641;
	Mon, 16 Sep 2024 12:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726488325; cv=none; b=Vo8K+q16KXy3oGvkASJZ47v1rx9gVIw0/zgqNS60RsPo7pVaBvcbhUB/7QUv2m2hqQxwtFI88sH1S5M/PWIdUiNXs0SLGplmSqUVAND5eqsi3NGaRfIrrU0wq7N0tM+Aw97JYU+penr6Xiwv6JHWxB7QHINp4UEqw30AE+jGpHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726488325; c=relaxed/simple;
	bh=xRJ7kpQL7AhhBmCM4oxjwVA457e0gVjmTiZUUtIUsWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RBBIIkUy8YbqdUPmKPV9wsDDZY4lGEX1q0S2SN9EXyyVK8dlr0Ij0fSXbegQfiP60AySl9Ld1rycjRI7Pv15U4PuwJWt+QW1/dJVAQsPp3WMTABrHFwDuDtx4yLX8AUnuniRxxgQ12MmDYgyRxc2JY7QP+u9v0th0Gi21CuvsVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=bYGSkZ4u; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1726488318;
	bh=18t7rflhaYvVgyXnOMIFDUq2RCu2sj0IPep/TMv98gk=;
	h=From:To:Cc:Subject:Date:From;
	b=bYGSkZ4uNi3nbhd6+xFM/L/builVI1Q41dpuBlNBkFGO65ljpumCpXpZsdo3clE7P
	 cn5/4048DYulkfwq4U2QK0kYE3dGeSNquMWZcyCpbbhMpeOtE1lyQ37cI82d6wUWnD
	 u/HJbZr2XQkrjmVFQ3wWxYkCQrl3YixBPcgZLXxgH2WGVvK63lA7OAIK1nz7k/Mb7a
	 mIEbIdPgdsX6HDHDeaOYYpAZvsESgx+hsQHb/qAphDP+/NqJ2Cw92+OKx/qTttma0Q
	 8c/Z8JRQLqx+TdmjbJ0JdFu+xL6TLbCPyz6Cwd4voN4YHqk922F1W709BeOGcO0oXa
	 wP3YAyzkZpbIA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X6kBP1Qc6z4x8g;
	Mon, 16 Sep 2024 22:05:17 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: <christophe.leroy@csgroup.eu>,
	<segher@kernel.crashing.org>,
	<sfr@canb.auug.org.au>,
	<linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>,
	almasrymina@google.com,
	<kuba@kernel.org>
Subject: [PATCH] powerpc/atomic: Use YZ constraints for DS-form instructions
Date: Mon, 16 Sep 2024 22:05:10 +1000
Message-ID: <20240916120510.2017749-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'ld' and 'std' instructions require a 4-byte aligned displacement
because they are DS-form instructions. But the "m" asm constraint
doesn't enforce that.

That can lead to build errors if the compiler chooses a non-aligned
displacement, as seen with GCC 14:

  /tmp/ccuSzwiR.s: Assembler messages:
  /tmp/ccuSzwiR.s:2579: Error: operand out of domain (39 is not a multiple of 4)
  make[5]: *** [scripts/Makefile.build:229: net/core/page_pool.o] Error 1

Dumping the generated assembler shows:

  ld 8,39(8)       # MEM[(const struct atomic64_t *)_29].counter, t

Use the YZ constraints to tell the compiler either to generate a DS-form
displacement, or use an X-form instruction, either of which prevents the
build error.

See commit 2d43cc701b96 ("powerpc/uaccess: Fix build errors seen with
GCC 13/14") for more details on the constraint letters.

Fixes: 9f0cbea0d8cc ("[POWERPC] Implement atomic{, 64}_{read, write}() without volatile")
Cc: stable@vger.kernel.org # v2.6.24+
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/all/20240913125302.0a06b4c7@canb.auug.org.au
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/asm-compat.h | 6 ++++++
 arch/powerpc/include/asm/atomic.h     | 5 +++--
 arch/powerpc/include/asm/uaccess.h    | 7 +------
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/asm-compat.h b/arch/powerpc/include/asm/asm-compat.h
index 2bc53c646ccd..83848b534cb1 100644
--- a/arch/powerpc/include/asm/asm-compat.h
+++ b/arch/powerpc/include/asm/asm-compat.h
@@ -39,6 +39,12 @@
 #define STDX_BE	stringify_in_c(stdbrx)
 #endif
 
+#ifdef CONFIG_CC_IS_CLANG
+#define DS_FORM_CONSTRAINT "Z<>"
+#else
+#define DS_FORM_CONSTRAINT "YZ<>"
+#endif
+
 #else /* 32-bit */
 
 /* operations for longs and pointers */
diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index 5bf6a4d49268..d1ea554c33ed 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -11,6 +11,7 @@
 #include <asm/cmpxchg.h>
 #include <asm/barrier.h>
 #include <asm/asm-const.h>
+#include <asm/asm-compat.h>
 
 /*
  * Since *_return_relaxed and {cmp}xchg_relaxed are implemented with
@@ -197,7 +198,7 @@ static __inline__ s64 arch_atomic64_read(const atomic64_t *v)
 	if (IS_ENABLED(CONFIG_PPC_KERNEL_PREFIXED))
 		__asm__ __volatile__("ld %0,0(%1)" : "=r"(t) : "b"(&v->counter));
 	else
-		__asm__ __volatile__("ld%U1%X1 %0,%1" : "=r"(t) : "m<>"(v->counter));
+		__asm__ __volatile__("ld%U1%X1 %0,%1" : "=r"(t) : DS_FORM_CONSTRAINT (v->counter));
 
 	return t;
 }
@@ -208,7 +209,7 @@ static __inline__ void arch_atomic64_set(atomic64_t *v, s64 i)
 	if (IS_ENABLED(CONFIG_PPC_KERNEL_PREFIXED))
 		__asm__ __volatile__("std %1,0(%2)" : "=m"(v->counter) : "r"(i), "b"(&v->counter));
 	else
-		__asm__ __volatile__("std%U0%X0 %1,%0" : "=m<>"(v->counter) : "r"(i));
+		__asm__ __volatile__("std%U0%X0 %1,%0" : "=" DS_FORM_CONSTRAINT (v->counter) : "r"(i));
 }
 
 #define ATOMIC64_OP(op, asm_op)						\
diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index fd594bf6c6a9..4f5a46a77fa2 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -6,6 +6,7 @@
 #include <asm/page.h>
 #include <asm/extable.h>
 #include <asm/kup.h>
+#include <asm/asm-compat.h>
 
 #ifdef __powerpc64__
 /* We use TASK_SIZE_USER64 as TASK_SIZE is not constant */
@@ -92,12 +93,6 @@ __pu_failed:							\
 		: label)
 #endif
 
-#ifdef CONFIG_CC_IS_CLANG
-#define DS_FORM_CONSTRAINT "Z<>"
-#else
-#define DS_FORM_CONSTRAINT "YZ<>"
-#endif
-
 #ifdef __powerpc64__
 #ifdef CONFIG_PPC_KERNEL_PREFIXED
 #define __put_user_asm2_goto(x, ptr, label)			\
-- 
2.46.0


