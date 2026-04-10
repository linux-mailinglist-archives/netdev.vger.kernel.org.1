Return-Path: <netdev+bounces-277483-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGKwAlIk2WmnmggAu9opvQ
	(envelope-from <netdev+bounces-277483-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:24:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 914933DA5D9
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20B30305DD20
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 16:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEE53DB644;
	Fri, 10 Apr 2026 16:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bDCUFlGk"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649FF3DA5D1;
	Fri, 10 Apr 2026 16:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775838124; cv=none; b=fdUyIt19NNEPXXO5GfSftSFkL9/PBIOLumaiP3peBH1Of5dqTcT8of7J8gUZWVURpxjW+gwYUxtxFDjP7kSPwxv+tFmrHKCqBYsUFn8KAm9v177NKJdVM7hecrmwon4zdBQ85txT3ql9033y5ViHAMJo7AeezMrFu2BDQovFHSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775838124; c=relaxed/simple;
	bh=gkbTTpomOFQo/PRcjGzCDH15wJLGopmMjVQHvuUkTE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3XOQwsaC5z3ZfzvQJ2zBwOV/tUDBc5nKI7RGoeoowmBvpZKBcdETPcVca3WEAQHOMMNDYSLlyq85xuNmWzBHUDv0VKL/YR3ozgoFd0Ka8rEDUfOClhhhBLaE+ZTMiUJdMy+G94uxEn+FkVkn+mrco38BXlGT45DupoEvfChqQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=bDCUFlGk; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=vDQwbU4pA2tkOClsty9Cq8ODFRev4Jm+5mUhOrtRRvs=; b=bDCUFlGkTGuG
	MKXtNrccLBBIprNtszTWyFUXfTg17ic/wvGAG2aCg9Ml9l3gQj5Uac6vIxSZBWb3NfdKsb75ccncH
	/+tpAga2p1luJwFlTIw6R2MPO1Y4vJJUSm/s7geA0ULq8wCiAET3QT+O8waBP6CB3+1GyvCLwe7hK
	9T6JI8IpESMkd/4EiHyutqoyQHVqCzACJbhTdEg12I4Uh3eC9mGqaPHMAyEtXme2kKfBXKu8yWaDF
	a8LITqNyzi4WJgELq/1vaq1kh4ANpKwxzjARQrk8J/ddZ/TyjgCEceUkeAtpnEq/I+lUQs9tIgCWL
	wFkvhv2wcxWTjsnBN+wQTQ==;
Received: from [130.117.225.5] (helo=finist-alma9.vzint.dev)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1wBEZo-00FvwO-2X;
	Fri, 10 Apr 2026 18:21:47 +0200
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
Subject: [PATCH v3 2/2] net: add noinline __init __no_profile to skb_extensions_init() for GCOV compatibility
Date: Fri, 10 Apr 2026 19:21:50 +0300
Message-ID: <20260410162150.3105738-3-khorenko@virtuozzo.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260410162150.3105738-1-khorenko@virtuozzo.com>
References: <20260409214736.2651198-1-khorenko@virtuozzo.com>
 <20260410162150.3105738-1-khorenko@virtuozzo.com>
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
	TAGGED_FROM(0.00)[bounces-277483-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[virtuozzo.com:dkim,virtuozzo.com:email,virtuozzo.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 914933DA5D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

With -fprofile-update=atomic in global CFLAGS_GCOV, GCC still cannot
constant-fold the skb_ext_total_length() loop when it is inlined into a
profiled caller.  The existing __no_profile on skb_ext_total_length()
itself is insufficient because after __always_inline expansion the code
resides in the caller's body, which still carries GCOV instrumentation.

Mark skb_extensions_init() with __no_profile so the BUILD_BUG_ON checks
can be evaluated at compile time.  Also mark it noinline to prevent the
compiler from inlining it into skb_init() (which lacks __no_profile),
which would re-expose the function body to GCOV instrumentation.

Add __init since skb_extensions_init() is only called from __init
skb_init().  Previously it was implicitly inlined into the .init.text
section; with noinline it would otherwise remain in permanent .text,
wasting memory after boot.

Build-tested with both CONFIG_GCOV_PROFILE_ALL=y and
CONFIG_KCOV_INSTRUMENT_ALL=y.

Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 59fb4b2bb821..0978f526acf4 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5153,7 +5153,7 @@ static __always_inline __no_profile unsigned int skb_ext_total_length(void)
 	return l;
 }
 
-static void skb_extensions_init(void)
+static noinline void __init __no_profile skb_extensions_init(void)
 {
 	BUILD_BUG_ON(SKB_EXT_NUM > 8);
 	BUILD_BUG_ON(skb_ext_total_length() > 255);
-- 
2.43.5


