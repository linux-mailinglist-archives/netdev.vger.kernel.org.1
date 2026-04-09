Return-Path: <netdev+bounces-277131-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDpUJZwe2GlaYAgAu9opvQ
	(envelope-from <netdev+bounces-277131-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 23:48:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EAD3CFFED
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 23:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B814C30233DE
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 21:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0CE357A20;
	Thu,  9 Apr 2026 21:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="t6AhNqcy"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F226E27F010;
	Thu,  9 Apr 2026 21:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775771276; cv=none; b=D4Mu0M6ugGavCRLUypB7xO4gk8ONtGYapBgBqyI7XUb5/MKZ3RIXHTeWpshslx4iuwPT3RWUP00ElmARbRq/qSQA5LHmw1QU/1AtDATWBzRz82K34NuNmfQ93ev2x8ZPe6f04RXIxpkSu1Gu5d3rt92qr4bpJx2tei24oVi6iWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775771276; c=relaxed/simple;
	bh=2Kwj0uwQMNGF1qTs9oyvvhxjeJpNgKOJ1FNETaDkkXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIHRlN7tkh5QR34G3z+6eW4yRin/un9e5XPF6/RH0DLIjxDWIdmKes5/P6R9fylizsySOdPy7YBmSHRX7QBFeZU3uWZ2FymN+DTCUU8Yr+SxVpu9CdunSGhCcQ6RqBGUFb5YCZJ021T7+fV5IgJKDaARhOtihMjJL90lwTs4opY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=t6AhNqcy; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=Uysjb/q5UJuS0519iSQYBlLFT4DSa5yN3Ap6z0VmvLQ=; b=t6AhNqcyAPyB
	DsZZHKQ17QBV1zbV40m0aBAtJpOFKf04p2yJ8HFnuNiU1gPQStlA5iFPAlgxgT6Hs3Wg6vmkNdpjv
	2YlH546/5iSwtNOFhwDFpEF4sgjDKs0CERXST18+5zUhfz1KVYiMwMFvQo1zyIiCJcChkFoJpW+LZ
	hA64wTGvKdeUzXr2NdTRDq9nq2UTEz+0zJC7Pw7DgVQ7hkQd+lFvTQm3FKy+xnm9hS0+wM1ThtzxD
	DgR6uwgNUhek9+3jY/coVw4sWb8PPtL2b6q5PgPnjpHgNrmduv+ZH2ySlz1GceCOyRTloZB02yfeB
	ifDEOv6grQlKFA5/haby3w==;
Received: from [130.117.225.5] (helo=finist-alma9.vzint.dev)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1wAxBX-002p6C-1v;
	Thu, 09 Apr 2026 23:47:34 +0200
From: Konstantin Khorenko <khorenko@virtuozzo.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Mikhail Zaslonko <zaslonko@linux.ibm.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>,
	Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: [PATCH v2 0/2] net: fix skb_ext BUILD_BUG_ON failures with GCOV
Date: Fri, 10 Apr 2026 00:47:34 +0300
Message-ID: <20260409214736.2651198-1-khorenko@virtuozzo.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260402140558.1437002-1-khorenko@virtuozzo.com>
References: <20260402140558.1437002-1-khorenko@virtuozzo.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=relay];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277131-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khorenko@virtuozzo.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E1EAD3CFFED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This mini-series fixes build failures in net/core/skbuff.c when the
kernel is built with CONFIG_GCOV_PROFILE_ALL=y.

This is part of a larger effort to add -fprofile-update=atomic to
global CFLAGS_GCOV (posted earlier as a combined series) [1].

The companion patch:
 - gcov: add -fprofile-update=atomic globally (sent to gcov/kbuild
   maintainers, depends on this series) [2]

There was another companion patch here, but i appeared to be already
applied recently: 8b72aa5704c7 ("iommupt/amdv1: mark
amdv1pt_install_leaf_entry as __always_inline").

Patch 1/2 fixes a pre-existing build failure with CONFIG_GCOV_PROFILE_ALL:
GCOV counters prevent GCC from constant-folding the skb_ext_total_length()
loop.  It also removes the CONFIG_KCOV_INSTRUMENT_ALL preprocessor guard
from d6e5794b06c0: that guard was a precaution in case KCOV instrumentation
also prevented constant folding, but KCOV's -fsanitize-coverage=trace-pc
does not interfere with GCC's constant folding (verified experimentally
with GCC 14.2 and GCC 16.0.1), so the guard is unnecessary.

Patch 2/2 is an additional fix needed when -fprofile-update=atomic is
added to CFLAGS_GCOV: __no_profile on the __always_inline function alone
is insufficient because after inlining, the code resides in the caller's
profiled body.  The caller (skb_extensions_init) needs __no_profile and
noinline to prevent re-exposure to GCOV instrumentation.

Changes v1 -> v2:
 - Patch 1/2: expanded the commit message to explain why removing the
   CONFIG_KCOV_INSTRUMENT_ALL guard is safe (KCOV's
   -fsanitize-coverage=trace-pc does not inhibit constant folding,
   unlike GCOV's -fprofile-arcs + -fno-tree-loop-im).
   Changed Fixes tag to point at the commit that introduced the 5th
   SKB extension type which triggered the failure.
   Removed empty lines in tags area.

 - Patch 2/2: added noinline to skb_extensions_init() to prevent
   the compiler from inlining it into skb_init(), which would
   re-expose the function body to GCOV instrumentation.

v1: https://lore.kernel.org/lkml/20260402140558.1437002-1-khorenko@virtuozzo.com/T/#t

[1] https://lore.kernel.org/lkml/20260401142020.1434243-1-khorenko@virtuozzo.com/T/#t
[2] https://lore.kernel.org/lkml/20260402141831.1437357-1-khorenko@virtuozzo.com/T/#t

Tested with:
 - GCC 14.2.1, CONFIG_GCOV_PROFILE_ALL=y
 - GCC 14.2.1, CONFIG_KCOV_INSTRUMENT_ALL=y (GCOV disabled)
 - GCC 16.0.1 20260327 (experimental), CONFIG_GCOV_PROFILE_ALL=y

Konstantin Khorenko (2):
  net: fix skb_ext_total_length() BUILD_BUG_ON with
    CONFIG_GCOV_PROFILE_ALL
  net: add noinline __no_profile to skb_extensions_init() for GCOV
    compatibility

 net/core/skbuff.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

-- 
2.43.5

