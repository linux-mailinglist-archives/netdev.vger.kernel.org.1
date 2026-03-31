Return-Path: <netdev+bounces-273709-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAC0BzEEzGljNQYAu9opvQ
	(envelope-from <netdev+bounces-273709-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 19:28:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 944CD36EC43
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 19:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BBBB32D19D3
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 16:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300BD426EA9;
	Tue, 31 Mar 2026 16:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pbSqU2tc"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B19E4266BA;
	Tue, 31 Mar 2026 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975911; cv=none; b=ko74yVaOo+FbU911dy5cBwSINN0ho/uWGep/EwtgY+l//wZLNWTvVrfZY7pOmI4aXPmz3oJ25yCKGc/Wor8YUPK+IFDTXVGJncI/+SpnqgJIJv8c1VNT2uRUHXr0kNuOwNR2+6gmW5jgd6I+tgZkwx74krARHWQzavZMu3LE52U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975911; c=relaxed/simple;
	bh=BCrwzD6ttTbaxfhTPSf9QJlID9s+VgHuvYje0FKxhw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IqEOd+ENWi3cBOb3J4Ghs2Hd6jkz1wlmgzRi+FjxVDOqG90xumDdqmYPBhUL/Z9ZBoyO4koSr2GByc2LuUuKQNB9cALCHyRiLW8OGW80VocOvMnbCSYIEnyFri23TbHjuSZ4VxaAOr+HmxS9QJ5zT5r6fQGQVBm1DLgA/WBRpj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=pbSqU2tc; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Message-ID:Date:Subject
	:From; bh=cmyO4L0pupPYl2ZiDlWDHRDENJhqCYsBYc/D1uvpZJw=; b=pbSqU2tcrOFLN1kXXOo
	ZUMKIfNd0GGv88LBo3ZdozmnFXM6LLxtieHRlHfnFJRchtBIuas3ZZNJzRXCYky+CcmfLXpQfXu4q
	EpsSPN5f1xqzOY13G6y3VowXfCXfUW5/hmx/CB6G8JCazTazXLjiieR9w8pazfcO8EAbEirwdgiag
	fbTDEjXZKKC98k0YzTYZKiVpz3ZZ+00GB6r/0n8qLyifSBUet+k4XN+WNSBXwTLnqO47KLrcPpE4D
	xtcnXuj1NT5oSayG1D4VNJThkUKDn0yGTMhAl/lZGL4meWhkSYijRG+XMmH4W6TJ6159m4rFlbXpB
	0qg4FywdHma/W6g==;
Received: from [130.117.225.5] (helo=finist-alma9.vzint.dev)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1w7cHC-00HHGg-01;
	Tue, 31 Mar 2026 18:51:16 +0200
From: Konstantin Khorenko <khorenko@virtuozzo.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Simon Horman <horms@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: [PATCH v2 1/1] net: fix skb_ext_total_length() BUILD_BUG_ON with CONFIG_GCOV_PROFILE_ALL
Date: Tue, 31 Mar 2026 19:50:27 +0300
Message-ID: <20260331165125.959833-2-khorenko@virtuozzo.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260331165125.959833-1-khorenko@virtuozzo.com>
References: <20260331165125.959833-1-khorenko@virtuozzo.com>
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
	TAGGED_FROM(0.00)[bounces-273709-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,weissschuh.net:email,virtuozzo.com:dkim,virtuozzo.com:email,virtuozzo.com:mid]
X-Rspamd-Queue-Id: 944CD36EC43
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
constant-fold the result. BUILD_BUG_ON requires a compile-time constant
and fails.

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
introduced by d6e5794b06c0, as __no_profile handles both GCOV and KCOV
instrumentation at the root cause level rather than just disabling the
check.

Fixes: 5d21d0a65b57 ("net: generalize calculation of skb extensions length")
Fixes: d6e5794b06c0 ("net: avoid build bug in skb extension length calculation")

Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
---
 net/core/skbuff.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 0e217041958a..47c7f0ab6e84 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5145,7 +5145,7 @@ static const u8 skb_ext_type_len[] = {
 #endif
 };
 
-static __always_inline unsigned int skb_ext_total_length(void)
+static __always_inline __no_profile unsigned int skb_ext_total_length(void)
 {
 	unsigned int l = SKB_EXT_CHUNKSIZEOF(struct skb_ext);
 	int i;
@@ -5159,9 +5159,7 @@ static __always_inline unsigned int skb_ext_total_length(void)
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


