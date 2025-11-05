Return-Path: <netdev+bounces-235831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 909F8C3639F
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 16:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8BED94F2797
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 15:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1583E2C21DE;
	Wed,  5 Nov 2025 15:05:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eidolon.nox.tf (eidolon.nox.tf [185.142.180.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D331741C63
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 15:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355140; cv=none; b=QJ6OOfRbtaQ9fiA6cC+5Di5jmrfE+f9J8rpN38xp5prR/uX+PNd5VosznE/kdzviRICupJOmyV9oSWwvK69SiQqNmwBQj1gELEzaObHVLJsrJoo1Z0HF/83INZXzm0lcwtx+ZkSKt+AdcyDo0eCkJbK0/s+SegvXCMy8OHYSaM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355140; c=relaxed/simple;
	bh=p7RST2c1BKoj6BLgkZGksUPce9BLMIvHZgIsYfgLyag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gd8DACsfMBwjjJQ0uT/Vkq1hbDBUsljWsNGVXbxUvIAuXh8Fjz9N30nAIj7zCf9SSSFQw887aZ5qOgEYZaagrIMjgWENrvbIHwi6iLERJoL0bPWWedC7UM48QxNBj1CcMCRCPFH3D7FzIwjVkuMTiTt1ZWjtBzCvsruLEwSrB4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net; spf=pass smtp.mailfrom=diac24.net; arc=none smtp.client-ip=185.142.180.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=diac24.net
Received: from [2607:fa49:3805:f800::8fc7] (helo=alea)
	by eidolon.nox.tf with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <equinox@diac24.net>)
	id 1vGf4i-00000000epo-43o2;
	Wed, 05 Nov 2025 16:05:29 +0100
Received: from equinox by alea with local (Exim 4.98.2)
	(envelope-from <equinox@diac24.net>)
	id 1vGeur-000000002cc-2F6t;
	Wed, 05 Nov 2025 09:55:17 -0500
From: David Lamparter <equinox@diac24.net>
To: netdev@vger.kernel.org
Cc: David Lamparter <equinox@diac24.net>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Lorenzo Colitti <lorenzo@google.com>,
	Patrick Rohr <prohr@google.com>,
	=?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>
Subject: [PATCH net-next] net/ipv6: fix lookup for ::/0 (non-)subtree route
Date: Wed,  5 Nov 2025 09:54:45 -0500
Message-ID: <20251105145446.10001-1-equinox@diac24.net>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Assume a scenario with something like the following routes:
default via fe80::1 dev dummy0
2001:db8:1::/48 via fe80::10 dev dummy0
2001:db8:1::/48 from 2001:db8:1:2::/64 via fe80::12 dev dummy0

Now if a lookup happens for 2001:db8:1::2345, but with a source address
*not* covered by the third route, the expectation is to hit the second
one.  Unfortunately, this was broken since the code, on failing the
lookup in the subtree, didn't consider the node itself which the subtree
is attached to, i.e. route #2 above.

The fix is simple, check if the subtree is attached to a node that is
itself a valid route before backtracking to less specific destination
prefixes.

This case is somewhat rare for several reasons.  To begin with, subtree
routes are most commonly attached to the default destination.
Additionally, in the rare cases where a non-default destination prefix
is host to subtree routes, the fallback on not hitting any subtree route
is commonly a default route (or a subtree route on that).

(Note that this was working for the "::/0 from ::/0" case since the root
node is special-cased.  The issue was discovered during RFC 6724 rule
5.5 testing, trying to find edge cases.)

Signed-off-by: David Lamparter <equinox@diac24.net>
Cc: Lorenzo Colitti <lorenzo@google.com>
Cc: Patrick Rohr <prohr@google.com>
Cc: Maciej Żenczykowski <maze@google.com>
---
 net/ipv6/ip6_fib.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 02c16909f618..c18e9331770d 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -1650,8 +1650,11 @@ static struct fib6_node *fib6_node_lookup_1(struct fib6_node *root,
 					struct fib6_node *sfn;
 					sfn = fib6_node_lookup_1(subtree,
 								 args + 1);
-					if (!sfn)
+					if (!sfn) {
+						if (fn->fn_flags & RTN_RTINFO)
+							return fn;
 						goto backtrack;
+					}
 					fn = sfn;
 				}
 #endif
-- 
2.50.1


