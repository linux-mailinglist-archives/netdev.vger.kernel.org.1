Return-Path: <netdev+bounces-167083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B452A38C22
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 20:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DC9516E945
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 19:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A58E236421;
	Mon, 17 Feb 2025 19:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="l8+uRvtl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9061922FA
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 19:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739819537; cv=none; b=EwKb25kXBLf8HdwJ7tRe6IqvOH/pYSzP9SM0lTdEy/AsPwVInFOXbGhOxSsdbSg2sf1ah8dUeo9/AxMkj6hqgMxyCEiGEmalfcjVEgUkf/1/J48fEqnguNmkMVrcKvxqHmSu+or9YDUf60/eS4MUJks7RjoUMpTF+SJiaMOpaWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739819537; c=relaxed/simple;
	bh=0QQXOcVD8b/VIbnunj9ydPvQJYnvcOI7ub7vKxQIp9M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=um7OUyRyicJ0ZEuJ+3nb3MdTOqQK+iu4LL5UuaHz7ts04rj2wXhakJNFmNa2AydY/bu0uSff7bsXhI7h1kPu+vUZGjKrZidn3GhA085jmxTe90no3nMjVKu+Kpmov7q27VFl3l3mRWa9QrDU5oCK/2v+cny7ukQK+2Kms9UjAHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=l8+uRvtl; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739819535; x=1771355535;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0MiuopPYxo4ozcxHOMiSt4p9AfQSudv9nUhHvzqNJgA=;
  b=l8+uRvtl4165kjxgNAscJ3BSVFKWr0+fQDlhVQ8MKDiNRtwrNawWAFUN
   YuqEnjRT1iTCCD0ZsZRjTzdehu2hzj9FF66IP9cH4qQQp5m4QT8V/lrT5
   v8Zb6ZyuZFr3XbQhzuFWD30mOtIR2lh4Quv5mrackVNBFJuLESSP785SL
   g=;
X-IronPort-AV: E=Sophos;i="6.13,293,1732579200"; 
   d="scan'208";a="170486017"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 19:12:12 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:19837]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.150:2525] with esmtp (Farcaster)
 id b2d4b1f0-6ecc-4658-8d7b-920d9c42d741; Mon, 17 Feb 2025 19:12:12 +0000 (UTC)
X-Farcaster-Flow-ID: b2d4b1f0-6ecc-4658-8d7b-920d9c42d741
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 17 Feb 2025 19:12:10 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.11) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 17 Feb 2025 19:12:08 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v5 net 1/3] net: Add net_passive_inc() and net_passive_dec().
Date: Mon, 17 Feb 2025 11:11:27 -0800
Message-ID: <20250217191129.19967-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250217191129.19967-1-kuniyu@amazon.com>
References: <20250217191129.19967-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA003.ant.amazon.com (10.13.139.37) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

net_drop_ns() is NULL when CONFIG_NET_NS is disabled.

The next patch introduces a function that increments
and decrements net->passive.

As a prep, let's rename and export net_free() to
net_passive_dec() and add net_passive_inc().

Suggested-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/netdev/CANn89i+oUCt2VGvrbrweniTendZFEh+nwS=uonc004-aPkWy-Q@mail.gmail.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/net/net_namespace.h | 11 +++++++++++
 net/core/net_namespace.c    |  8 ++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 7ba1402ca779..f467a66abc6b 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -297,6 +297,7 @@ static inline int check_net(const struct net *net)
 }
 
 void net_drop_ns(void *);
+void net_passive_dec(struct net *net);
 
 #else
 
@@ -326,8 +327,18 @@ static inline int check_net(const struct net *net)
 }
 
 #define net_drop_ns NULL
+
+static inline void net_passive_dec(struct net *net)
+{
+	refcount_dec(&net->passive);
+}
 #endif
 
+static inline void net_passive_inc(struct net *net)
+{
+	refcount_inc(&net->passive);
+}
+
 /* Returns true if the netns initialization is completed successfully */
 static inline bool net_initialized(const struct net *net)
 {
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index cb39a12b2f82..4303f2a49262 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -464,7 +464,7 @@ static void net_complete_free(void)
 
 }
 
-static void net_free(struct net *net)
+void net_passive_dec(struct net *net)
 {
 	if (refcount_dec_and_test(&net->passive)) {
 		kfree(rcu_access_pointer(net->gen));
@@ -482,7 +482,7 @@ void net_drop_ns(void *p)
 	struct net *net = (struct net *)p;
 
 	if (net)
-		net_free(net);
+		net_passive_dec(net);
 }
 
 struct net *copy_net_ns(unsigned long flags,
@@ -523,7 +523,7 @@ struct net *copy_net_ns(unsigned long flags,
 		key_remove_domain(net->key_domain);
 #endif
 		put_user_ns(user_ns);
-		net_free(net);
+		net_passive_dec(net);
 dec_ucounts:
 		dec_net_namespaces(ucounts);
 		return ERR_PTR(rv);
@@ -672,7 +672,7 @@ static void cleanup_net(struct work_struct *work)
 		key_remove_domain(net->key_domain);
 #endif
 		put_user_ns(net->user_ns);
-		net_free(net);
+		net_passive_dec(net);
 	}
 	cleanup_net_task = NULL;
 }
-- 
2.39.5 (Apple Git-154)


