Return-Path: <netdev+bounces-195535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE89AD1117
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 08:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27C111645CB
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 06:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529BE1EF09C;
	Sun,  8 Jun 2025 06:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="W5Q5WZM7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A5F1372;
	Sun,  8 Jun 2025 06:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749362866; cv=none; b=De3jo7naEIRjojoaEW237m495MQp0qf5YEo6prUPpbOgQLp0MyjiAQK/Y76wAZpIaCP/hGEjdmn3FqMbA2whhvqFkW/KZsAYZeSR6EnUBPzqDZVC7O/M9T1xsGjUq0fnGtD2HFMObL5rBBJiOlRQtWbkMNx/uEnRhTRJXq67kQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749362866; c=relaxed/simple;
	bh=6CKfrQXaIsxvYjLqtf2J+UBK9lHsV3t17BaJqRbua1A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fhNQayLR7CiFGX2oaptGoBR0ssd+/UsT1u1a3qjtY+Eiw3nO2BMKa043Q8EFyhvDQjK5hEMRTS6T0rHg4inn8e9vJaY1MdRQd8L4oKNZImyiriwuRp8NzVrvnokBLQk/uEa2rQhedFM37bB5eNYewbFwTAGxQT63btxlpNiA1do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=W5Q5WZM7; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1749362865; x=1780898865;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=avBttXiSSME7van6tk2bFmYzW6QRRSSGD0yy3TEB3M4=;
  b=W5Q5WZM7h1ajYIQbQdwl7NWkHhiViKLX4JlYRq6O1Vn6RUgv+iCAuHXp
   nC4TFb9FBhHE7vpxRb1SOYzy/0fu2tjSipLoB6HocZgEpdk1nc9+f0X6B
   1jWX1twFDqK/LLpGqAZoQDhHo+s8xrL66uWDJSgrFJHGc1r7z8ebbOMGM
   +/uQVegIAxOwyECQumBgJm5MF5ii1dbhMoucHVsZBcX4N5Xq6OhQE0ABD
   BnLsR9Um/9rl6PiPd/jyl9NAmEDz9SwcH7t6MU1GQk5tqlMmi46rGbd1f
   pOFk4+JuYaxCjNYGjfHShUy8kjdDeyRCVHn1LHzFujEkw5wJeFLPpMvfM
   A==;
X-IronPort-AV: E=Sophos;i="6.16,219,1744070400"; 
   d="scan'208";a="28319561"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2025 06:07:38 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.10.100:21462]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.19.236:2525] with esmtp (Farcaster)
 id 65724dd7-c7be-4e89-b106-23a5e8fab81f; Sun, 8 Jun 2025 06:07:37 +0000 (UTC)
X-Farcaster-Flow-ID: 65724dd7-c7be-4e89-b106-23a5e8fab81f
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sun, 8 Jun 2025 06:07:37 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D018EUA004.ant.amazon.com (10.252.50.85) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Sun, 8 Jun 2025
 06:07:34 +0000
From: Eliav Farber <farbere@amazon.com>
To: <davem@davemloft.net>, <kuznet@ms2.inr.ac.ru>, <yoshfuji@linux-ipv6.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <sashal@kernel.org>,
	<edumazet@google.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <farbere@amazon.com>
Subject: [PATCH] net/ipv4: fix type mismatch in inet_ehash_locks_alloc() causing build failure
Date: Sun, 8 Jun 2025 06:07:26 +0000
Message-ID: <20250608060726.43331-1-farbere@amazon.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D035UWB004.ant.amazon.com (10.13.138.104) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

Fix compilation warning:

In file included from ./include/linux/kernel.h:15,
                 from ./include/linux/list.h:9,
                 from ./include/linux/module.h:12,
                 from net/ipv4/inet_hashtables.c:12:
net/ipv4/inet_hashtables.c: In function ‘inet_ehash_locks_alloc’:
./include/linux/minmax.h:20:35: warning: comparison of distinct pointer types lacks a cast
   20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
      |                                   ^~
./include/linux/minmax.h:26:18: note: in expansion of macro ‘__typecheck’
   26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
      |                  ^~~~~~~~~~~
./include/linux/minmax.h:36:31: note: in expansion of macro ‘__safe_cmp’
   36 |         __builtin_choose_expr(__safe_cmp(x, y), \
      |                               ^~~~~~~~~~
./include/linux/minmax.h:52:25: note: in expansion of macro ‘__careful_cmp’
   52 | #define max(x, y)       __careful_cmp(x, y, >)
      |                         ^~~~~~~~~~~~~
net/ipv4/inet_hashtables.c:946:19: note: in expansion of macro ‘max’
  946 |         nblocks = max(nblocks, num_online_nodes() * PAGE_SIZE / locksz);
      |                   ^~~
  CC      block/badblocks.o

When warnings are treated as errors, this causes the build to fail.

The issue is a type mismatch between the operands passed to the max()
macro. Here, nblocks is an unsigned int, while the expression
num_online_nodes() * PAGE_SIZE / locksz is promoted to unsigned long.

This happens because:
 - num_online_nodes() returns int
 - PAGE_SIZE is typically defined as an unsigned long (depending on the
   architecture)
 - locksz is unsigned int

The resulting arithmetic expression is promoted to unsigned long.

Thus, the max() macro compares values of different types: unsigned int
vs unsigned long.

This issue was introduced in commit b53d6e9525af ("tcp: bring back NUMA
dispersion in inet_ehash_locks_alloc()") during the update from kernel
v5.10.237 to v5.10.238.

It does not exist in newer kernel branches (e.g., v5.15.185 and all 6.x
branches), because they include commit d53b5d862acd ("minmax: allow
min()/max()/clamp() if the arguments have the same signedness.")

Fix the issue by using max_t(unsigned int, ...) to explicitly cast both
operands to the same type, avoiding the type mismatch and ensuring
correctness.

Fixes: b53d6e9525af ("tcp: bring back NUMA dispersion in inet_ehash_locks_alloc()")
Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 net/ipv4/inet_hashtables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index fea74ab2a4be..ac2d185c04ef 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -943,7 +943,7 @@ int inet_ehash_locks_alloc(struct inet_hashinfo *hashinfo)
 	nblocks = max(2U * L1_CACHE_BYTES / locksz, 1U) * num_possible_cpus();
 
 	/* At least one page per NUMA node. */
-	nblocks = max(nblocks, num_online_nodes() * PAGE_SIZE / locksz);
+	nblocks = max_t(unsigned int, nblocks, num_online_nodes() * PAGE_SIZE / locksz);
 
 	nblocks = roundup_pow_of_two(nblocks);
 
-- 
2.47.1


