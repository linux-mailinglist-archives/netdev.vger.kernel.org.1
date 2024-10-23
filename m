Return-Path: <netdev+bounces-138393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4399AD499
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 21:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3171C21FC6
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 19:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83C81D0153;
	Wed, 23 Oct 2024 19:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="pJ7rRN9o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE41713CABC
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 19:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729711095; cv=none; b=PdIZQsW75Z9Bu+5aOLr1BQnOxosbehyj2E8qwYUuea56KQxI75wOLu4v/D9rHTDrDzQQaWrTer2B7cmZ3LJbjKLyKHpJmmVAAL4BloKDA+8jMQcPIl1CbyHGbF7YIUNX8epRGnXkMGmaXGJ7fTC6kXWedFdjJLZLNQjuWHcwATM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729711095; c=relaxed/simple;
	bh=A6pRpQ6UnnjV3xo4oGg+YwOLdPbi/0ZLsZ/QtYUx3Vs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ocNDM1frutJznPduvw78DqtFzXPuFsro1W++uH9uQ4iCAo4pjEkQIYqm3cNClIpsxKS4ALa+QkDmtrGiBJiXQIqeo1tucsTBkFvCo1hlIparpT8MWtWFVzpKXjFKEbIfRgCD3rApSJoASOfe+And1ihu4Fhdn5oGp+hM2iT7BYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=pJ7rRN9o; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729711094; x=1761247094;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9Wkk87gvwEw6IN8G8tnRdJmkssG5udKBWB/LehgUbKo=;
  b=pJ7rRN9oOJal2AQFA4ulCbINU7HC0X6xkrrC6ISbLRDbXd0XTGIKgb7L
   i75M3nbDMZS48mCNxU/SvtNuluIcjnNOtu3NWBNFpAgKpC/9/EdC63NOi
   aLaaWSWllv4d/w3Ce8bYxZe/7sOAZH9aftrVaH7iqyp7tAOcK19pbBaIt
   c=;
X-IronPort-AV: E=Sophos;i="6.11,226,1725321600"; 
   d="scan'208";a="241840032"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 19:18:10 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:56473]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.30.247:2525] with esmtp (Farcaster)
 id cae78f5b-d1aa-409c-88ab-884e9d436157; Wed, 23 Oct 2024 19:18:09 +0000 (UTC)
X-Farcaster-Flow-ID: cae78f5b-d1aa-409c-88ab-884e9d436157
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 23 Oct 2024 19:18:09 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 23 Oct 2024 19:18:06 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Ignat Korchagin <ignat@cloudflare.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v1 net-next] socket: Print pf->create() when it does not clear sock->sk on failure.
Date: Wed, 23 Oct 2024 12:17:57 -0700
Message-ID: <20241023191757.56735-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA002.ant.amazon.com (10.13.139.60) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

I suggested to put DEBUG_NET_WARN_ON_ONCE() in __sock_create() to
catch possible use-after-free.

But the warning itself was not useful because our interest is in
the callee than the caller.

Let's define DEBUG_NET_WARN_ONCE() and print the name of pf->create()
and the socket identifier.

While at it, we enclose DEBUG_NET_WARN_ON_ONCE() in parentheses too
to avoid a checkpatch error.

Note that %pf or %pF were obsoleted and later removed as per comment
in lib/vsprintf.c.

Link: https://lore.kernel.org/netdev/202410231427.633734b3-lkp@intel.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
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
index 9a8e4452b9b2..da00db3824e3 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1578,7 +1578,9 @@ int __sock_create(struct net *net, int family, int type, int protocol,
 		/* ->create should release the allocated sock->sk object on error
 		 * and make sure sock->sk is set to NULL to avoid use-after-free
 		 */
-		DEBUG_NET_WARN_ON_ONCE(sock->sk);
+		DEBUG_NET_WARN_ONCE(sock->sk,
+				    "%pS must clear sock->sk on failure, family: %d, type: %d, protocol: %d\n",
+				    pf->create, family, type, protocol);
 		goto out_module_put;
 	}
 
-- 
2.39.5 (Apple Git-154)


