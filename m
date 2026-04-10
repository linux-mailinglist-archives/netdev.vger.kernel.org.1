Return-Path: <netdev+bounces-277484-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHu4DWsk2WmnmggAu9opvQ
	(envelope-from <netdev+bounces-277484-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:25:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C07A83DA5E9
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 541C2306251F
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 16:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D8B3DBD5B;
	Fri, 10 Apr 2026 16:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WWTo9LTx"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633BD3203B6;
	Fri, 10 Apr 2026 16:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775838124; cv=none; b=LzfyjxXA1FuMn/8LBl3K9fvR2GZ7IlRmqEVrCMugCfEdq8PPbg3pFXYAJqBeRfKWVhPxi1qh/7311aIVEB4JzKQD5o6TalBItQ539VA8mgug0IDa0zN3OShmS9o1rRXlAkrA5GRXLTTvB3+yq4+a/h/IjkLDRnTN6ktsRMRWBpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775838124; c=relaxed/simple;
	bh=DOHeJdgg83sZ0T9jmnNAfQfxk9FMb4A2+LrUFf+Vtk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W8GhIoVFgqYEtRvULSsWS+Pvgv+3wu7GFbE9tAe8GoV30bekeFJKcXnulsJdqHqXpU+1iScRXwtgcygjxDDh5S6AUMyfIMXxCkj0ZQBqOJeHBiEcz/rRxhSahXhyvqQwV/++noSsY2IsufC9AEnQjU250xxdV2B2zyoXJHpLK74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=WWTo9LTx; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=18EucyhQlopspBaafNNDLK93kDt938llAL+OtB7xCJg=; b=WWTo9LTxV3ng
	OCBUSIWaDA90E5CJJ7xq4lbNOoRoD41Cyekl943oWR5RHCD058EcWjX2RI4/fyx2CDfxfoDpSsMdx
	AfxEKwrFk8BQDLXY+B/pCnwytSHbtfwv6lghAeDgtmnExXYZo90VFqWBINRYsUQzVTQM8u7+N70ZS
	Ke3cp+XW2SxE+r3ko50KYWUuKF4h398beIYhxNsCisYzfWpreoEmdXwWD3XfUowUWe2DDNnN9spcR
	8RzzPlJogTK8JA2cvC28yfO2bIzzc6rOZXKKwWY/1UIz1ufBZMHbQ83HjARaaMhHxraYlTgk8MpeC
	1jcY4rWmp0G8bJ9aHCy+ww==;
Received: from [130.117.225.5] (helo=finist-alma9.vzint.dev)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1wBEZo-00FvwO-2M;
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
Subject: [PATCH v3 1/2] net: fix skb_ext_total_length() BUILD_BUG_ON with CONFIG_GCOV_PROFILE_ALL
Date: Fri, 10 Apr 2026 19:21:49 +0300
Message-ID: <20260410162150.3105738-2-khorenko@virtuozzo.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=relay];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277484-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[virtuozzo.com:dkim,virtuozzo.com:email,virtuozzo.com:mid,weissschuh.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C07A83DA5E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When CONFIG_GCOV_PROFILE_ALL=y is enabled, the kernel fails to build:

  In file included from <command-line>:
  In function 'skb_extensions_init',
      inlined from 'skb_init' at net/core/skbuff.c:5214:2:
  ././include/linux/compiler_types.h:706:45: error: call to
    '__compiletime_assert_1490' declared with attribute error:
    BUILD_BUG_ON failed: skb_ext_total_length() > 255

CONFIG_GCOV_PROFILE_ALL adds -fprofile-arcs -ftest-coverage
-fno-tree-loop-im to CFLAGS globally. GCC inserts branch profiling
counters into the skb_ext_total_length() loop and, combined with
-fno-tree-loop-im (which disables loop invariant motion), cannot
constant-fold the result.
BUILD_BUG_ON requires a compile-time constant and fails.

The issue manifests in kernels with 5+ SKB extension types enabled
(e.g., after addition of SKB_EXT_CAN, SKB_EXT_PSP). With 4 extensions
GCC can still unroll and fold the loop despite GCOV instrumentation;
with 5+ it gives up.

Mark skb_ext_total_length() with __no_profile to prevent GCOV from
inserting counters into this function. Without counters the loop is
"clean" and GCC can constant-fold it even with -fno-tree-loop-im active.
This allows BUILD_BUG_ON to work correctly while keeping GCOV profiling
for the rest of the kernel.

This also removes the CONFIG_KCOV_INSTRUMENT_ALL preprocessor guard
introduced by d6e5794b06c0. That guard was added as a precaution because
KCOV instrumentation was also suspected of inhibiting constant folding.
However, KCOV uses -fsanitize-coverage=trace-pc, which inserts
lightweight trace callbacks that do not interfere with GCC's constant
folding or loop optimization passes. Only GCOV's -fprofile-arcs combined
with -fno-tree-loop-im actually prevents the compiler from evaluating
the loop at compile time. The guard is therefore unnecessary and can be
safely removed.

Fixes: 96ea3a1e2d31 ("can: add CAN skb extension infrastructure")
Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
Reviewed-by: Thomas Weissschuh <linux@weissschuh.net>
---
 net/core/skbuff.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 43ee86dcf2ea..59fb4b2bb821 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5142,7 +5142,7 @@ static const u8 skb_ext_type_len[] = {
 #endif
 };
 
-static __always_inline unsigned int skb_ext_total_length(void)
+static __always_inline __no_profile unsigned int skb_ext_total_length(void)
 {
 	unsigned int l = SKB_EXT_CHUNKSIZEOF(struct skb_ext);
 	int i;
@@ -5156,9 +5156,7 @@ static __always_inline unsigned int skb_ext_total_length(void)
 static void skb_extensions_init(void)
 {
 	BUILD_BUG_ON(SKB_EXT_NUM > 8);
-#if !IS_ENABLED(CONFIG_KCOV_INSTRUMENT_ALL)
 	BUILD_BUG_ON(skb_ext_total_length() > 255);
-#endif
 
 	skbuff_ext_cache = kmem_cache_create("skbuff_ext_cache",
 					     SKB_EXT_ALIGN_VALUE * skb_ext_total_length(),
-- 
2.43.5


