Return-Path: <netdev+bounces-297851-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ep5MMIDtKWoKfwMAu9opvQ
	(envelope-from <netdev+bounces-297851-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 01:04:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B58366D4C3
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 01:04:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=FOxMWFHR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297851-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297851-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74EB830117B1
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 23:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD15356766;
	Wed, 10 Jun 2026 23:04:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48643009E2;
	Wed, 10 Jun 2026 23:04:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781132653; cv=none; b=irPC12//VY3IaWBWoagiZMo8hwaHe6T1tMxnjecB9NFyC3jZLInxVaemFmIl+qFq/FxySqkyYV2zWJRq+NRljaO5b2xxa95VO+3lQsdUR4aNpy5ejYtjBeYhbWMLewPsT56T3bSZfeJC6uYYOOaDVRmdGAHlu9pekaXNZVsfizM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781132653; c=relaxed/simple;
	bh=2WEt2ZvPmO8EdZFzEBlx7T5A1KmdG5Y87ekuzMLuv9U=;
	h=Subject:To:Cc:From:Date:Message-Id; b=P89uerfmYmPyUzSvahBThk5lrOwN9SV4ND+SKtIvaqGwsnSEOcGr4ZJcCYYB+O4CKwvuPYUf8nNb+qg1pKFaZQUlD1gEQtKebQAjU7o3/Vcj7eR0WGX6MKoKM6oXP6attgX4AxGyUGxphxGTgDqszTLkgy+7x+0fYqqVas6DX/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FOxMWFHR; arc=none smtp.client-ip=198.175.65.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781132651; x=1812668651;
  h=subject:to:cc:from:date:message-id;
  bh=2WEt2ZvPmO8EdZFzEBlx7T5A1KmdG5Y87ekuzMLuv9U=;
  b=FOxMWFHRuXty4yvzIqv/HU31HDYKrMNFevZigJG46xand/Ngsh0Kqwwn
   vOZhummYrOE0GzP2cD1FFeSPpDL9PcYVdA2dU9F9281ufVE7BqksOJAEq
   Eq1sqPnZWhZgfjxKE2F3uwlKX52WdBOBRoPJW8EHy8KKjjlBQDVSPHEOA
   NjWeY+GH7AOnkmsWA/rmY1bf44O5IetFdzLi4N9an88KtvJJXM295d4jL
   hZy7POiRHQVbYn1RWFxp9HRdI4aNNspirYgExfTjcnd+j2ATy5Vb+f7yo
   j3rJJQlggcU5b5wAq8iCLqdPMZNw4Ubp4aYYd/CNTk82hTlQxpKWi+RWP
   A==;
X-CSE-ConnectionGUID: DnPT5Bl/QSqHqDJst181bA==
X-CSE-MsgGUID: dlNZ3+ZXRiGdBCZiTEt+uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="104603416"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="104603416"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 16:04:11 -0700
X-CSE-ConnectionGUID: 7TgrP9meTPiiDW9rjfO8ZQ==
X-CSE-MsgGUID: UQIYMZYcQPegPMuXE9rW3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="251409765"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa005.fm.intel.com with ESMTP; 10 Jun 2026 16:04:09 -0700
Subject: [PATCH v2 0/5] mm: Unconditional per-VMA locks and cleanups
To: linux-kernel@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Alice Ryhl <aliceryhl@google.com>, Andrew Morton <akpm@linux-foundation.org>, Arve Hjønnevåg <arve@android.com>, Carlos Llamas <cmllamas@google.com>, Christian Brauner <christian@brauner.io>, David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org, Lorenzo Stoakes <ljs@kernel.org>, netdev@vger.kernel.org, Shakeel Butt <shakeel.butt@linux.dev>, Suren Baghdasaryan <surenb@google.com>, Todd Kjos <tkjos@android.com>, Vlastimil Babka <vbabka@kernel.org>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 10 Jun 2026 16:04:09 -0700
Message-Id: <20260610230409.A44D29FA@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	R_BAD_CTE_7BIT(3.50)[unknown];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	BROKEN_CONTENT_TYPE(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297851-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER(0.00)[dave.hansen@linux.intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:dave.hansen@linux.intel.com,m:aliceryhl@google.com,m:akpm@linux-foundation.org,m:arve@android.com,m:cmllamas@google.com,m:christian@brauner.io,m:dsahern@kernel.org,m:davem@davemloft.net,m:gregkh@linuxfoundation.org,m:Liam.Howlett@oracle.com,m:linux-mm@kvack.org,m:ljs@kernel.org,m:netdev@vger.kernel.org,m:shakeel.butt@linux.dev,m:surenb@google.com,m:tkjos@android.com,m:vbabka@kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.hansen@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B58366D4C3

tl;dr: Make per-VMA locks available in all configs. Simplify some
of the per-VMA lock users now that they can rely on them being
always available.

Binder and networking folks: Your code is the target of the cleanups.
I'm cc'ing you now on v2 because there's emerging consensus on the mm
side that the approach here is sane. I'm not quite sure how this pile
would get merged, but ack/review tags would be appreciated if this
looks good to you.

Longer version:

When working on some x86 shadow stack code, it was a real pain to
avoid causing recursive locking problems with mmap_lock. One way
to avoid those was to avoid mmap_lock and use per-VMA locks instead.
They are great, but they are not available in all configs which
makes them unusable in generic code, or if you want to completely
avoid mmap_lock.

Make per-VMA locks available in all configs. Right now, they are
only available on select architectures when SMP and MMU are enabled.
But all of the primitives that per-VMA locks are built on (RCU, maple
trees, refcounts) work just fine without SMP or MMU.

The only real downside is that making VMAs a wee bit bigger on !MMU
and !SMP builds.

The upside is much cleaner code, lower complexity and less #ifdeffery.

Clean up a binder VMA locking site now that it can rely on per-VMA
locks.

Building on top of universally-available per-VMA locks, introduce a
new helper. Since the new API does not require callers to have a
fallback to mmap_lock, it's much easier to use. Callers can
potentially replace this very common kernel idiom:

	mmap_read_lock(mm);
	vma = vma_lookup()
	// fiddle with vma
	mmap_read_unlock(mm);

with:

	vma = vma_start_read_unlocked(mm, address);
	// fiddle with vma
	vma_end_read(vma);

Which avoids mmap_lock entirely in the fast path.

Use that new API for another binder site and one in the TCP code.

Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-mm@kvack.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arve Hjønnevåg <arve@android.com>
Cc: Todd Kjos <tkjos@android.com>
Cc: Christian Brauner <christian@brauner.io>
Cc: Carlos Llamas <cmllamas@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org

Changes from v1:
 * Better naming and non-loopy, simpler implementation.
   Thanks Suren and Lorenzo!
 * Cc networking and binder folks
 * Add tags. Thanks reviewers!
 * Drop x86 shadow stack changes

 arch/arm/Kconfig                       |    1 
 arch/arm64/Kconfig                     |    1 
 arch/loongarch/Kconfig                 |    1 
 arch/powerpc/platforms/powernv/Kconfig |    1 
 arch/powerpc/platforms/pseries/Kconfig |    1 
 arch/riscv/Kconfig                     |    1 
 arch/s390/Kconfig                      |    1 
 arch/x86/Kconfig                       |    2 -
 drivers/android/binder_alloc.c         |   43 ++++++++-----------------
 fs/proc/internal.h                     |    2 -
 fs/proc/task_mmu.c                     |   51 ------------------------------
 include/linux/mm.h                     |   12 -------
 include/linux/mm_types.h               |    7 ----
 include/linux/mmap_lock.h              |   51 +-----------------------------
 kernel/bpf/task_iter.c                 |    5 ---
 kernel/fork.c                          |    2 -
 mm/Kconfig                             |   13 -------
 mm/Kconfig.debug                       |    1 
 mm/debug.c                             |    4 --
 mm/init-mm.c                           |    2 -
 mm/memory.c                            |    2 -
 mm/mmap_lock.c                         |   51 ++++++++++++++++--------------
 mm/pagewalk.c                          |    2 -
 mm/rmap.c                              |    2 -
 mm/userfaultfd.c                       |   55 ---------------------------------
 net/ipv4/tcp.c                         |   31 +++++-------------
 rust/kernel/mm.rs                      |    7 ----
 tools/testing/vma/include/dup.h        |    4 --
 tools/testing/vma/vma_internal.h       |    1 
 29 files changed, 54 insertions(+), 303 deletions(-)

