Return-Path: <netdev+bounces-273216-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBXOGKmLymn09gUAu9opvQ
	(envelope-from <netdev+bounces-273216-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:41:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B77F035D0D0
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 876633093E0F
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B67B2EC562;
	Mon, 30 Mar 2026 14:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LeyyIUo0"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E7D2E7623;
	Mon, 30 Mar 2026 14:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881188; cv=none; b=Hgx0GW7MQoSXimZsnUKxt9llb7OWyz1h8lwFT7BF+E2mackAIxx0lulYbXKiZEDyXpejWU8uG/i00QFkNIAitEWRFQ0XTvpvc02WXs5G539kwa0e3xBiD302yMKYLVkVovLI9dciEmA7MUgDuxDO9wgaqkJ7O12i1PuT6ks3Ugs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881188; c=relaxed/simple;
	bh=qXyMA/3yrrPgyhk87wJOL1csRZbxo4+mbkZUAZM/io8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AzGcjNd9aU+sE3SX1HZAS8XFI58lYqwFIE+xUHve1zPx6esBTlt9iWvRWqEGxZXb7/JgHgpMV4gjjBs63OUlrBYO+CR10cPPXfveeU45Gqn/lVLhbUnWmh9hqe7m9uENcNoW9jm0+PMhpS8ClYl6DZxYsZheh8P2j/MKlU6jtHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=LeyyIUo0; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Message-ID:Date:Subject
	:From; bh=ykovE9Ss5bS4WvX5GU5qRjuShXMBEAaY8t91/xSP7TU=; b=LeyyIUo0IQMuI2+1YjG
	y8j6KFNBWSAd9qTpze3MRd5gEQuaoTDGuA7NY1niouI39T3zhw+x1uqt9XDr3CxL8u9HBkPln18Po
	fE11EIitaV+FppRj8Mc1awBVVUcG6UcOy9bbY+zoTNjOnQuYzfKv4WtuWv7WtlnJSfnt9KMwXUlEB
	Oh6QhttlE7kG2W0F8A+9B4nAh+BbKN2RZPaFj2OKQmwwF3ZjOVOTO1aRw57XMl+kIEVVb1DCLOruF
	QqPG+4fP2jQp1boS12vrB9N/CVWCKcpvnmfxLATBP2966lh1Xd0FPRSIRqM/hhIVsdQsqJ8Kpw+rw
	mwO9PWIA4U1JEug==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=f0.vzint.dev)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1w7Dde-009NzU-1F;
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
Subject: [PATCH 0/1] lib/zlib: fix GCOV-induced crashes from concurrent inflate_fast()
Date: Mon, 30 Mar 2026 16:32:54 +0200
Message-ID: <20260330143256.306326-1-khorenko@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273216-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khorenko@virtuozzo.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,virtuozzo.com:dkim,virtuozzo.com:mid]
X-Rspamd-Queue-Id: B77F035D0D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

## Summary

GCC can merge global GCOV branch counters with loop induction variables,
causing out-of-bounds memory writes when the same function executes
concurrently on multiple CPUs. We observed kernel crashes in zlib's
inflate_fast() during IPComp (IP Payload Compression) decompression when
the kernel is built with CONFIG_GCOV_KERNEL=y.

This patch adds -fprofile-update=atomic to the zlib Makefiles to prevent
the problematic optimization.

## Problem Discovery

The issue was discovered while running the LTP networking stress test on
a 6.12-based kernel with GCOV enabled:

  Test:     LTP net_stress.ipsec_udp -> udp4_ipsec06
  Command:  udp_ipsec.sh -p comp -m transport -s 100:1000:65000:R65000
  Kernel:   6.12.0-55.52.1.el10 based (x86_64) with CONFIG_GCOV_KERNEL=y

The crash occurred in inflate_fast() during concurrent IPComp packet
decompression:

  BUG: unable to handle page fault for address: ffffd0a3c0902ffa
  RIP: inflate_fast+1431
  Call Trace:
   zlib_inflate
   __deflate_decompress
   crypto_comp_decompress
   ipcomp_decompress [xfrm_ipcomp]
   ipcomp_input [xfrm_ipcomp]
   xfrm_input

Analysis showed a write 3.4 MB past the end of a 65 KB decompression
buffer, hitting unmapped vmalloc guard pages.

## Verification on Upstream Kernel

We verified the bug is present in upstream Linux v7.0-rc5 (commit
46b513250491) with both:

- GCC 14.2.1 20250110 (Red Hat 14.2.1-7)
- GCC 16.0.1 20260327 (experimental, built from source)

We compiled lib/zlib_inflate/inffast.c with the kernel's standard GCOV
flags (including the existing -fno-tree-loop-im workaround from commit
2b40e1ea76d4) and inspected the assembly output. Both compilers exhibit
the problematic optimization.

## Root Cause: GCOV Counter IV-Merging

When CONFIG_GCOV_KERNEL=y, GCC instruments every basic block with counter
updates. In zlib's inner copy loops, GCC can optimize by merging these
global GCOV counters with the loop induction variables that compute store
addresses.

For example, in the pattern-fill loop in inflate_fast() (conceptually
`do { *sout++ = pat16; } while (--loops);`), GCC may generate code that:

1. Loads the current GCOV counter value from global memory
2. Uses that value to compute the base address, start index, and end bound
3. On each iteration, uses the counter as both:
   - The value to write back to the global counter
   - The index for the data store

This optimization is valid for single-threaded code but breaks when the
same function executes concurrently on multiple CPUs, because the GCOV
counter is a single global variable shared by all CPUs.

### Assembly Examples

**GCC 14.2.1 (Red Hat)** — pattern-fill loop without -fprofile-update=atomic:

    movq    __gcov0.inflate_fast+248(%rip), %r9
    leaq    1(%r9), %rax                        # rax = counter + 1
    leaq    (%r9,%rdi), %rsi                    # rsi = counter + loops (end)
    negq    %r9
    leaq    (%r15,%r9,2), %r9                   # r9 = base - counter*2
  .L42:
    movq    %rax, __gcov0.inflate_fast+248(%rip)
    movw    %cx, (%r9,%rax,2)                   # WRITE using merged counter
    addq    $1, %rax
    cmpq    %rax, %rsi
    jne     .L42

Here, %rax serves dual purpose: GCOV counter and memory index.  If another
CPU updates __gcov0.inflate_fast+248 between the initial load and the loop
iteration, the write address becomes invalid.

**GCC 16.0.1 (experimental)** — same pattern, different register allocation:

    movq    __gcov0.inflate_fast+248(%rip), %r14
    leaq    1(%r14), %rdx
    leaq    (%r14,%r8), %rdi                    # end bound from counter
    negq    %r14
    leaq    (%rbx,%r14,2), %rbx                 # base address from counter
  .L42:
    movq    %rdx, __gcov0.inflate_fast+248(%rip)
    movw    %si, (%rbx,%rdx,2)                  # WRITE using merged counter
    addq    $1, %rdx
    cmpq    %rdx, %rdi
    jne     .L42

Both compilers merge the counter with the loop IV; both are vulnerable.

**With -fprofile-update=atomic** (GCC 14.2.1):

    movq    %rdi, %r9                           # pure pointer
  .L42:
    lock addq   $1, __gcov0.inflate_fast+248(%rip)
    addq    $2, %r9
    movw    %ax, -2(%r9)                        # WRITE using pure pointer
    subq    $1, %rdx
    jne     .L42

The GCOV counter update is isolated as a standalone atomic instruction.
The write address is computed purely from local registers, making
concurrent execution safe.

## Why Existing Workarounds Don't Help

The kernel already passes -fno-tree-loop-im when building with GCOV
(commit 2b40e1ea76d4, "gcov: disable tree-loop-im to reduce stack usage").
That flag prevents GCC from hoisting loop-invariant memory operations out
of loops, which was causing excessive stack usage.

However, -fno-tree-loop-im does NOT prevent the IVopts (induction variable
optimization) pass from merging GCOV counters with loop induction
variables.  These are separate optimization passes, and the IV-merging
happens even with -fno-tree-loop-im present.

## The Fix: -fprofile-update=atomic

Adding -fprofile-update=atomic tells GCC that profile counters may be
accessed concurrently. This causes GCC to:

1. Use atomic instructions (lock addq) for counter updates
2. Treat counter variables as opaque — they cannot be merged with loop IVs

This completely eliminates the problematic optimization while preserving
GCOV functionality.

The flag is added only to lib/zlib_inflate/, lib/zlib_deflate/, and
lib/zlib_dfltcc/ Makefiles to minimize performance overhead. Zlib is
particularly vulnerable because:

- inflate_fast() has tight inner loops that GCC heavily optimizes
- IPComp and other subsystems call zlib from multiple CPUs concurrently
- The per-CPU isolation (scratch buffers, crypto transforms) protects
  data structures but cannot protect global GCOV counters

Applying -fprofile-update=atomic globally would make all GCOV counter
updates use atomic instructions, adding overhead throughout the kernel.
By scoping it to zlib, we fix the known crash site with minimal impact.

## GCC Bug Report Status

A bug report for the upstream GCC project is being filed.

i'm not sure if GCC team will accept this as a bug as the compiler
optimization looks technically valid under the C standard (data races on
non-atomic variables are undefined behavior), but it creates a practical
problem for kernel code that routinely executes the same function on
multiple CPUs.

And anyway we need to fix/workaround the issue until/if the compiler is fixed.

## Testing

Verified the fix by:

1. Compiling lib/zlib_inflate/inffast.c with and without
   -fprofile-update=atomic using the kernel's exact build flags
2. Inspecting assembly output to confirm the atomic flag prevents
   counter-IV merging
3. Testing on upstream v7.0-rc5 with GCC 14.2.1 and GCC 16.0.1

---

Konstantin Khorenko (1):
  lib/zlib: use atomic GCOV counters to prevent crash in inflate_fast

 lib/zlib_deflate/Makefile | 6 ++++++
 lib/zlib_dfltcc/Makefile  | 6 ++++++
 lib/zlib_inflate/Makefile | 7 +++++++
 3 files changed, 19 insertions(+)

-- 
2.43.0

