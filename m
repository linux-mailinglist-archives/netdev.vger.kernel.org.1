Return-Path: <netdev+bounces-273215-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIEfCiGLymn09gUAu9opvQ
	(envelope-from <netdev+bounces-273215-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:39:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB95135D04D
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8BD953040643
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4202EAD1C;
	Mon, 30 Mar 2026 14:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JjRr5fxF"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1722E718B;
	Mon, 30 Mar 2026 14:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881187; cv=none; b=tmDzx9s0L9gOcWRNyrRzR9Nhz77WcOf0J4kuWMjN6u4mBRP7nee1VOTy0Jt7lRlZ5n4q6BXXzwagLEmmpA1QZtosmsOMDW5Z2nUfKFuDI90hkLjGaIty2BBF9pDt0Y4qDPSPSaKLHjYOP07CL6BPgxgJ3A9vrsVUlUHKKioxWSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881187; c=relaxed/simple;
	bh=qxmw9tCQ4IxEOm1J++NLPYYFuywD+rmlw+v+iznyjOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lOsTj8ZcH4cyp9b1V7jc1drecy9F5SpoAj42QqGto3nRoLMaxwz1d+YSk3o2RRF/bEh4x2tdNIkDECMdIljr8fqHvHDU+JmTq9QxLhR0FmRq6drIsfHBMQPyTLt2Owigwoqc5A8PjYL+hBED+bTJaW+hlk60aHiejRqcs/gtajI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=JjRr5fxF; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Message-ID:Date:Subject
	:From; bh=P687YGmtR40rq3AyhFclpSu0NvVhLjhBHv59dXgkV74=; b=JjRr5fxF7aX0jg+3eyz
	8aM22CIp1rOr5Y/ANXDeFV4+gUI3OwQJJ2fF8zWHhkkc2vnexl8LDru/R5ekV36tCD6u3VlWNy3gi
	muMpjd52ZJ1pAOzizkl/b4bG4UWMn02uX4sFTu5Pj6hQ3Du3WwFJQnYqXlsPALT51g15EU1OhmteF
	lOMKZD4ancL8tMt9HHzvAENmCOY8aLGPB1gYgUpQ6S9Lvpu1ok5iq85UaZqNevQt2qjj2a1ONOfQG
	/+NjuUXTJAEzH5bTSvlVCm5hyt44O56gPT6Ddm/tV6JeMwPyPv53okV3RPyVulQdv23ckis9ZJ3QN
	p+Eu15MDkusCHVQ==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=f0.vzint.dev)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1w7Dde-009NzU-2m;
	Mon, 30 Mar 2026 16:32:48 +0200
From: Konstantin Khorenko <khorenko@virtuozzo.com>
To: Peter Oberparleiter <oberpar@linux.ibm.com>,
	Mikhail Zaslonko <zaslonko@linux.ibm.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: [PATCH 1/1] lib/zlib: use atomic GCOV counters to prevent crash in inflate_fast
Date: Mon, 30 Mar 2026 16:32:55 +0200
Message-ID: <20260330143256.306326-2-khorenko@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330143256.306326-1-khorenko@virtuozzo.com>
References: <20260330143256.306326-1-khorenko@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=relay];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273215-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khorenko@virtuozzo.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB95135D04D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

GCC's GCOV instrumentation can merge global branch counters with loop
induction variables as an optimization. In inflate_fast(), the inner
copy loops can be transformed so that GCOV counter values participate
in computing loop addresses and bounds. Since GCOV counters are global
(not per-CPU), concurrent execution on different CPUs causes the counter
to change mid-computation, producing inconsistent address calculations
and out-of-bounds memory writes.

The crash manifests during IPComp (IP Payload Compression) processing
when inflate_fast() runs concurrently on multiple CPUs:

  BUG: unable to handle page fault for address: ffffd0a3c0902ffa
  RIP: inflate_fast+1431
  Call Trace:
   zlib_inflate
   __deflate_decompress
   crypto_comp_decompress
   ipcomp_decompress [xfrm_ipcomp]
   ipcomp_input [xfrm_ipcomp]
   xfrm_input

In one observed case, the compiler merged a global GCOV counter with the
loop induction variable that also indexed stores. Another CPU modified
the counter between the setup and iteration phases, causing a write
3.4 MB past the end of a 65 KB buffer.

The kernel already uses -fno-tree-loop-im for GCOV builds (commit
2b40e1ea76d4) to prevent a different optimization issue. That flag
prevents GCC from hoisting loop-invariant memory operations but does
NOT prevent the IVopts pass from merging counters with induction
variables.

Add -fprofile-update=atomic to zlib Makefiles. This tells GCC that
GCOV counters may be concurrently accessed, causing counter updates to
use atomic instructions (lock addq) instead of plain load/store.
This prevents the compiler from merging counters with loop induction
variables. The flag is scoped to zlib only to minimize performance
overhead from atomic operations in the rest of the kernel.

Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
Reviewed-by: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
Reviewed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
---
 lib/zlib_deflate/Makefile | 6 ++++++
 lib/zlib_dfltcc/Makefile  | 6 ++++++
 lib/zlib_inflate/Makefile | 7 +++++++
 3 files changed, 19 insertions(+)

diff --git a/lib/zlib_deflate/Makefile b/lib/zlib_deflate/Makefile
index 2622e03c0b942..dc0b3e5660e9e 100644
--- a/lib/zlib_deflate/Makefile
+++ b/lib/zlib_deflate/Makefile
@@ -7,6 +7,12 @@
 # decompression code.
 #
 
+# Force atomic GCOV counter updates to prevent GCC from merging global
+# counters with loop induction variables (see lib/zlib_inflate/Makefile).
+ifdef CONFIG_GCOV_KERNEL
+ccflags-y += -fprofile-update=atomic
+endif
+
 obj-$(CONFIG_ZLIB_DEFLATE) += zlib_deflate.o
 
 zlib_deflate-objs := deflate.o deftree.o deflate_syms.o
diff --git a/lib/zlib_dfltcc/Makefile b/lib/zlib_dfltcc/Makefile
index 66e1c96387c40..fb08749d2ee7b 100644
--- a/lib/zlib_dfltcc/Makefile
+++ b/lib/zlib_dfltcc/Makefile
@@ -6,6 +6,12 @@
 # This is the code for s390 zlib hardware support.
 #
 
+# Force atomic GCOV counter updates to prevent GCC from merging global
+# counters with loop induction variables (see lib/zlib_inflate/Makefile).
+ifdef CONFIG_GCOV_KERNEL
+ccflags-y += -fprofile-update=atomic
+endif
+
 obj-$(CONFIG_ZLIB_DFLTCC) += zlib_dfltcc.o
 
 zlib_dfltcc-objs := dfltcc.o dfltcc_deflate.o dfltcc_inflate.o
diff --git a/lib/zlib_inflate/Makefile b/lib/zlib_inflate/Makefile
index 27327d3e9f541..8707c649adda5 100644
--- a/lib/zlib_inflate/Makefile
+++ b/lib/zlib_inflate/Makefile
@@ -14,6 +14,13 @@
 # uncompression can be done without blocking on allocation).
 #
 
+# Force atomic GCOV counter updates to prevent GCC from merging global
+# counters with loop induction variables — concurrent inflate_fast()
+# execution on multiple CPUs causes out-of-bounds writes otherwise.
+ifdef CONFIG_GCOV_KERNEL
+ccflags-y += -fprofile-update=atomic
+endif
+
 obj-$(CONFIG_ZLIB_INFLATE) += zlib_inflate.o
 
 zlib_inflate-objs := inffast.o inflate.o infutil.o \
-- 
2.43.0


