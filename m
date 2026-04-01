Return-Path: <netdev+bounces-274128-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCPVESctzWn7aQYAu9opvQ
	(envelope-from <netdev+bounces-274128-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 16:35:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C90137C381
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 16:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D331330367BD
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 14:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8339C45BD5E;
	Wed,  1 Apr 2026 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="xep1gy+O"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9893FA5FE;
	Wed,  1 Apr 2026 14:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775053232; cv=none; b=IiMM9QR2fxVL+F++/dhPhP3r6wf581/Y/99bu9BDD+zKa8GCyZCjbieAGFoVV2YFNHZPxwSyGqi594AV9BPa5AC2ikVuhJ+D3oEoAlxM8tgpdB0Sxrbd6G4R4NJJVXkOOdCGg5YKpKRKFf8yVx+r3FD37OluqFFkex5ninYUEDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775053232; c=relaxed/simple;
	bh=Y89lBkw6GOJyRay/aanAeN6/ET0pVruHgeQxkGn1zhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JU0W0sDb2nWQqQpMOn+EnnJ3I+czkqiWPCh4yNLpjV8rOLpYOiZ2IVzmyDQsV7mkpYN74oyLumt3CPdVAggMaQlE5TWRSPdknjVjgp7qgQdR/jHYsI8git+8rQmIm3ZifEOtn8GfTHgaZm3kS+NtrqC53PX2xGZnmYcpaxwx6JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=xep1gy+O; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Message-ID:Date:Subject
	:From; bh=zBG3/kXmaNP+K9YS+sQBrQLECebEezPM1muBjpsLrCs=; b=xep1gy+Oc886ZE13JzS
	si8c4t1u24ycYALNleliOqKxaVuXar51bYi6+acXeLHqAC3cLotJVzdI/d7AUfMAuNt+KbhrYrpBA
	M924R9OuDVksGhlmE5jLSIWUgKksDQL1Gtex6XjwlLqLBXY3QaMnlquXPpiAXsHHEKGV3XF9BlGhO
	F5aQtnppfl69MhwK4R9GVLdLkJDR98ND6tAD7GpoXjNYx9CfHfeXRaz7nr+LF40pgDYO9WTeEvWrB
	w8j2MYV1GHX7pvceDGJKLbYIbdfueGGVkiV40Nm5I9SK/dfdZIN/fEg1ulXvJ5Uy9ol7xpHjwHrcT
	PYKaf6HAIY65w2Q==;
Received: from [130.117.225.5] (helo=finist-alma9.vzint.dev)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1w7wOW-00HGGD-1F;
	Wed, 01 Apr 2026 16:20:20 +0200
From: Konstantin Khorenko <khorenko@virtuozzo.com>
To: Peter Oberparleiter <oberpar@linux.ibm.com>,
	Mikhail Zaslonko <zaslonko@linux.ibm.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Konstantin Khorenko <khorenko@virtuozzo.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 4/4] gcov: use atomic counter updates to fix concurrent access crashes
Date: Wed,  1 Apr 2026 17:20:20 +0300
Message-ID: <20260401142020.1434243-5-khorenko@virtuozzo.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260401142020.1434243-1-khorenko@virtuozzo.com>
References: <20260401142020.1434243-1-khorenko@virtuozzo.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=relay];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274128-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khorenko@virtuozzo.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,virtuozzo.com:dkim,virtuozzo.com:email,virtuozzo.com:mid]
X-Rspamd-Queue-Id: 1C90137C381
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

GCC's GCOV instrumentation can merge global branch counters with loop
induction variables as an optimization.  In inflate_fast(), the inner
copy loops get transformed so that the GCOV counter value is loaded
multiple times to compute the loop base address, start index, and end
bound.  Since GCOV counters are global (not per-CPU), concurrent
execution on different CPUs causes the counter to change between loads,
producing inconsistent values and out-of-bounds memory writes.

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

At the crash point, the compiler generated three loads from the same
global GCOV counter (__gcov0.inflate_fast+216) to compute base, start,
and end for an indexed loop.  Another CPU modified the counter between
loads, making the values inconsistent — the write went 3.4 MB past a
65 KB buffer.

Add -fprofile-update=atomic to CFLAGS_GCOV at the global level in the
top-level Makefile.  This tells GCC that GCOV counters may be
concurrently accessed, causing counter updates to use atomic
instructions (lock addq) instead of plain load/store.  This prevents
the compiler from merging counters with loop induction variables.

Applying this globally rather than per-subsystem not only addresses the
observed crash in zlib but makes GCOV coverage data more consistent
overall, preventing similar issues in any kernel code path that may
execute concurrently.

Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 6b1d9fb1a6b4..a55ad668d6ba 100644
--- a/Makefile
+++ b/Makefile
@@ -806,7 +806,7 @@ all: vmlinux
 
 CFLAGS_GCOV	:= -fprofile-arcs -ftest-coverage
 ifdef CONFIG_CC_IS_GCC
-CFLAGS_GCOV	+= -fno-tree-loop-im
+CFLAGS_GCOV	+= -fno-tree-loop-im -fprofile-update=atomic
 endif
 export CFLAGS_GCOV
 
-- 
2.43.5


