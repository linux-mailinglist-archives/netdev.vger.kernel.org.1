Return-Path: <netdev+bounces-138862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 982659AF36B
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 22:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 441701F2133C
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 20:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69ECE28371;
	Thu, 24 Oct 2024 20:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="eSB40SBb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C977189916
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 20:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729800917; cv=none; b=WhSgBA+1pvd/MkI5H+HNASMitG2fGfSg0PIrV7U2yqGNi5rWDxSM8vMk8xNSxZhToZFhMvC2ADg4q7sQvVfEcpXn6Ac8mMFpa1tNpLPG0uTDL30nQ4PanjIR2QMMAgCYkLRGas2hxjLbCif2NACNbPz882q9ha3NFhub719IRRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729800917; c=relaxed/simple;
	bh=v+RxCmyWm71to4tDmNsHS8IZuCmoGMQNbwArr+TI3aE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jayde2KjQZfRJPNnjNqydZsxC9VXHzBLO20kZFBCRQNTwgntFsInjHzG+9lGyfe+kNjffj6pdaVrtLRS7yPPz/MyrW+106/0wNCID6G9UvJPl75sT3ufZjF4nS4XVes3sjLWjqBf/FFmnlCUekHU3nSPl2/ZFbaPCUZeneLCIws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=eSB40SBb; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729800915; x=1761336915;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KK4nUYtdu16DxSBINjAGnujgKNqQe/gpSQi77VN7nfU=;
  b=eSB40SBbBbdNSrVZc+shXpwp13kbTntJWtpGMQbbF5DDo10ux5cvwzAj
   BA8JWwcvEsdTS7qAIa+RK3LTIzST8TJnBh/Ppd0GAs0FNoNV8bXpIW3g2
   s7Cji38xOWR07hjFYrIbusBpsfBz49/MB4EuyYpi8cF87TY4r/sPgOj8E
   0=;
X-IronPort-AV: E=Sophos;i="6.11,230,1725321600"; 
   d="scan'208";a="443659086"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 20:15:11 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:14332]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.36:2525] with esmtp (Farcaster)
 id a28f95a5-85a9-44e5-bb76-2e98e5f1da78; Thu, 24 Oct 2024 20:15:10 +0000 (UTC)
X-Farcaster-Flow-ID: a28f95a5-85a9-44e5-bb76-2e98e5f1da78
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 24 Oct 2024 20:15:05 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.23) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 24 Oct 2024 20:15:03 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Ignat Korchagin <ignat@cloudflare.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v2 net-next] socket: Print pf->create() when it does not clear sock->sk on failure.
Date: Thu, 24 Oct 2024 13:14:58 -0700
Message-ID: <20241024201458.49412-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

I suggested to put DEBUG_NET_WARN_ON_ONCE() in __sock_create() to
catch possible use-after-free.

But the warning itself was not useful because our interest is in
the callee than the caller.

Let's define DEBUG_NET_WARN_ONCE() and print the name of pf->create()
and the socket identifier.

While at it, we enclose DEBUG_NET_WARN_ON_ONCE() in parentheses too
to avoid a checkpatch error.

Note that %pf or %pF were obsoleted and will be removed later as per
comment in lib/vsprintf.c.

Link: https://lore.kernel.org/netdev/202410231427.633734b3-lkp@intel.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
v2:
  * Use %ps instead of %pS as the offset is always zero

v1: https://lore.kernel.org/netdev/20241023191757.56735-1-kuniyu@amazon.com/
---
 include/net/net_debug.h | 4 +++-
 net/socket.c            | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/net/net_debug.h b/include/net/net_debug.h
index 1e74684cbbdb..9fecb1496be3 100644
--- a/include/net/net_debug.h
+++ b/include/net/net_debug.h
@@ -149,9 +149,11 @@ do {								\
 
 
 #if defined(CONFIG_DEBUG_NET)
-#define DEBUG_NET_WARN_ON_ONCE(cond) (void)WARN_ON_ONCE(cond)
+#define DEBUG_NET_WARN_ON_ONCE(cond) ((void)WARN_ON_ONCE(cond))
+#define DEBUG_NET_WARN_ONCE(cond, format...) ((void)WARN_ONCE(cond, format))
 #else
 #define DEBUG_NET_WARN_ON_ONCE(cond) BUILD_BUG_ON_INVALID(cond)
+#define DEBUG_NET_WARN_ONCE(cond, format...) BUILD_BUG_ON_INVALID(cond)
 #endif
 
 #endif	/* _LINUX_NET_DEBUG_H */
diff --git a/net/socket.c b/net/socket.c
index 9a8e4452b9b2..5fb3d265e492 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1578,7 +1578,9 @@ int __sock_create(struct net *net, int family, int type, int protocol,
 		/* ->create should release the allocated sock->sk object on error
 		 * and make sure sock->sk is set to NULL to avoid use-after-free
 		 */
-		DEBUG_NET_WARN_ON_ONCE(sock->sk);
+		DEBUG_NET_WARN_ONCE(sock->sk,
+				    "%ps must clear sock->sk on failure, family: %d, type: %d, protocol: %d\n",
+				    pf->create, family, type, protocol);
 		goto out_module_put;
 	}
 
-- 
2.39.5 (Apple Git-154)


