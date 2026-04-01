Return-Path: <netdev+bounces-274131-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPiBNHktzWn7aQYAu9opvQ
	(envelope-from <netdev+bounces-274131-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 16:36:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6DB37C3C7
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 16:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B32B30379C0
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 14:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59797472774;
	Wed,  1 Apr 2026 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Ut5I4zhm"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928352AEE1;
	Wed,  1 Apr 2026 14:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775053234; cv=none; b=AmxMsaMzEaKYmOmlLZX4lSxObEdiCcEGjzTY2U9Wnl9z+6ofPdymvuZ7Mo30SCTX/YSSAtBxG0YMR9moFahBtgtNBOPj59u9TRnwWyJDNgN/nOv/H/UQeoTrFmkSNbDV6M+84Cmurl1b3A7AF/HHV46Ojd4Ax4S23Ss+TDrhcnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775053234; c=relaxed/simple;
	bh=x7nlJPCh8NCwvaBijfCtK+yYzXnwXqlretiUiqWFhvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hxg6K2TLLcd5qP3ExrpLvOzdqJnObslVbBIFrh3z8DrWX/jmYg3xW1IdYBw8xcvrhPmB8tm0HAnBzgyOjJk0hwJ6Su3GsIXbZ0Z7CkuCS361z2ULS8zLjViKZnqVK0HO/Dm0K7DB4jmHlPljV3CO/T1FwILcNGOSagkoX0ehH7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=Ut5I4zhm; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=flKubMUlpSRvusUmV1lA7R0mh+WjHrdRlHbEFBmrjKM=; b=Ut5I4zhmxF3V
	j2nQeTf7i12JeSAIncFyrT+mT7FwYOLlzifuHvjSg8Krnt5WZ4diQth3+h2TQ3MlqsmRyFFS0qZg1
	ZTScQuSz9avvBICoVF5GBMfrEGMAz4hPk6rWi7yD91T97IJJ2qVWgAmRoJ79reExrWP+GJVM1A274
	Vyh1BlhCvplkYZTEfH2+79KANOgmFf70bKc8UprxSvBj5KRnX9eAb7y1j8KA7MAOs7L7etDJKybb4
	vPdKG6dpW0cLd02FJNcnNYyb5866aMlOAfQyn57++5dp5SsyfgrT0egF0mXg9HwSs/WsMHgycZIWC
	l0ugevM+G13acSgan2rcBw==;
Received: from [130.117.225.5] (helo=finist-alma9.vzint.dev)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1w7wOW-00HGGD-0T;
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
Subject: [PATCH v3 0/4] gcov: use -fprofile-update=atomic globally to fix concurrent access crashes on GCOV-enabled kernels
Date: Wed,  1 Apr 2026 17:20:16 +0300
Message-ID: <20260401142020.1434243-1-khorenko@virtuozzo.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=relay];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274131-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khorenko@virtuozzo.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gnu.org:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,virtuozzo.com:dkim,virtuozzo.com:mid]
X-Rspamd-Queue-Id: DC6DB37C3C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds -fprofile-update=atomic to global CFLAGS_GCOV and
includes preparatory patches that fix build failures exposed by the new
flag.

Background
----------

This work combines and supersedes two previously separate series:

1. Build fix for CONFIG_GCOV_PROFILE_ALL=y - skb_ext_total_length()
   BUILD_BUG_ON failure:
   https://lore.kernel.org/lkml/20260331165125.959833-1-khorenko@virtuozzo.com/T/#t

2. Runtime crash fix for zlib inflate_fast() - GCOV counter merging
   with loop induction variables caused out-of-bounds writes on SMP:
   https://lore.kernel.org/lkml/20260330143256.306326-1-khorenko@virtuozzo.com/T/#t

The original zlib fix added -fprofile-update=atomic only to zlib
Makefiles. During review, it was suggested to apply the flag globally
instead, as it not only fixes the zlib crash but makes GCOV coverage
data more consistent overall. The GCC bug report for the underlying
compiler issue is at (and they also said just to use -fprofile-update=atomic):
   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=124749

Adding -fprofile-update=atomic to global CFLAGS_GCOV exposed two
additional build failures that are addressed by preparatory patches
in this series.

Series overview
---------------

Patch 1/4: net: fix skb_ext_total_length() BUILD_BUG_ON
  Pre-existing build failure with CONFIG_GCOV_PROFILE_ALL=y. GCOV
  counters prevent GCC from constant-folding the skb_ext_total_length()
  loop. Fixed by adding __no_profile to the function and removing the
  now-unnecessary CONFIG_KCOV_INSTRUMENT_ALL preprocessor guard.
  (This is v2 of the previously posted standalone patch.)

Patch 2/4: net: add __no_profile to skb_extensions_init()
  With -fprofile-update=atomic, __no_profile on skb_ext_total_length()
  alone is insufficient - after __always_inline expansion the code
  resides in the caller's body which still has GCOV instrumentation.
  Mark the caller with __no_profile as well.

Patch 3/4: iommu/generic_pt: disable GCOV for iommu_amdv1.o
  FIELD_PREP() compile-time checks fail because the entire call chain
  is __always_inline functions generated by PT_MAKE_LEVELS() macro,
  and GCC's .constprop cloning creates new profiled function bodies
  that bypass __no_profile. Disable GCOV for this file.

Patch 4/4: gcov: use atomic counter updates to fix concurrent crashes
  The main fix. Add -fprofile-update=atomic to CFLAGS_GCOV in the
  top-level Makefile. This tells GCC to use atomic instructions for
  GCOV counter updates, preventing the compiler from merging counters
  with loop induction variables. This fixes observed crashes in zlib's
  inflate_fast() during concurrent IPComp decompression and makes GCOV
  data reliable across the entire kernel on SMP systems.

The crash that motivated this work
-----------------------------------

Observed during LTP IPComp stress testing on a GCOV-enabled kernel:

  BUG: unable to handle page fault for address: ffffd0a3c0902ffa
  RIP: inflate_fast+1431
  Call Trace:
   zlib_inflate
   __deflate_decompress
   crypto_comp_decompress
   ipcomp_decompress [xfrm_ipcomp]
   ipcomp_input [xfrm_ipcomp]
   xfrm_input

GCC merged a global GCOV counter with the loop induction variable.
Another CPU modified the counter between loads, causing a write 3.4 MB
past a 65 KB buffer. -fprofile-update=atomic forces atomic counter
updates and prevents this merging.

Testing
-------

- Build-tested with CONFIG_GCOV_PROFILE_ALL=y using GCC 11.4.1 and
  GCC 16.0.1 20260327 (experimental). Both fail without the series,
  both succeed with the full series applied.
- Assembly-verified that -fprofile-update=atomic prevents counter-IV
  merging in inflate_fast() on both compiler versions.

Konstantin Khorenko (4):
  net: fix skb_ext_total_length() BUILD_BUG_ON with CONFIG_GCOV_PROFILE_ALL
  net: add __no_profile to skb_extensions_init() for GCOV compatibility
  iommu/generic_pt: disable GCOV for iommu_amdv1.o
  gcov: use atomic counter updates to fix concurrent access crashes

 Makefile                              | 2 +-
 drivers/iommu/generic_pt/fmt/Makefile | 2 ++
 net/core/skbuff.c                     | 5 ++---
 3 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.43.5

