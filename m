Return-Path: <netdev+bounces-114678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A42E29436E0
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 22:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E716B21139
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 20:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C946C154C14;
	Wed, 31 Jul 2024 20:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ccapJ8QT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5B7381AD
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 20:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722456610; cv=none; b=SnFe92EwUrl0TirNEqEp2+BbVrTigXwehz7iaAD0Qi5SBuYS1cCL6S7unkDWgSAyy4nVUmo1EO7KP85aJYbh7SbJ6Iv2mtNazz+OivLFxfxQvk6aM+i36k6xNCLZlfilnXDJM6loYKLd1n4u388lv9fAp/XO8h0FBsREUqSsSpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722456610; c=relaxed/simple;
	bh=NEuovyH31Nv5VC65zGtIfdmLhhe+4vEVDr+RuEV31uM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iht+b6C6zl5mLCfkohLdD1JRNJhw/EAqCekvFk6iUGY+WX1L1sXH/wPj/NeVlMMxrGnqFisNjVR0Fd8ZA9+44C9KHTtKGxvMjHy9hgudk+WzkLynyLxYOGDqamPZLqsLRGYjFph0e2HSJ0CzyYHXIkxgeH9Xo8koJzoUjD5b0eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ccapJ8QT; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722456609; x=1753992609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=32996MBZ3t87g3T1jX+/bFh7p6X4qPbnn7Q1KmZBlFU=;
  b=ccapJ8QTgdLIOaTG2d2/GSIUWPVH2zlUzYWZ3664CPMRZQhsfMGumCrc
   95E/4fLFpUVq+84mqzXCIsXuCjSoUxpTYf4c9IfLxUCG2+Ln2pBdNe6y+
   FRCh7940ztBuU8Pw8eeTJnDXCDa2gHcQgM1fHiuHJajwM9GGOpCbuMRST
   0=;
X-IronPort-AV: E=Sophos;i="6.09,251,1716249600"; 
   d="scan'208";a="424195096"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 20:10:06 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:27071]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.107:2525] with esmtp (Farcaster)
 id 7ef6b39a-a5e3-4efa-af44-215fbea8f182; Wed, 31 Jul 2024 20:10:05 +0000 (UTC)
X-Farcaster-Flow-ID: 7ef6b39a-a5e3-4efa-af44-215fbea8f182
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 31 Jul 2024 20:10:03 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 31 Jul 2024 20:10:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 6/6] net: Initialise net.core sysctl defaults in preinit_net().
Date: Wed, 31 Jul 2024 13:07:21 -0700
Message-ID: <20240731200721.70601-7-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240731200721.70601-1-kuniyu@amazon.com>
References: <20240731200721.70601-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB003.ant.amazon.com (10.13.138.85) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Commit 7c3f1875c66f ("net: move somaxconn init from sysctl code")
introduced net_defaults_ops to make sure that net.core sysctl knobs
are always initialised even if CONFIG_SYSCTL is disabled.

Such operations better fit preinit_net() added for a similar purpose
by commit 6e77a5a4af05 ("net: initialize net->notrefcnt_tracker earlier").

Let's initialise the sysctl defaults in preinit_net().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/net_namespace.c | 37 +++++++++++--------------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index eed5a28e8ee3..11e4dd4f09ed 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -309,6 +309,16 @@ struct net *get_net_ns_by_id(const struct net *net, int id)
 }
 EXPORT_SYMBOL_GPL(get_net_ns_by_id);
 
+static __net_init void preinit_net_sysctl(struct net *net)
+{
+	net->core.sysctl_somaxconn = SOMAXCONN;
+	/* Limits per socket sk_omem_alloc usage.
+	 * TCP zerocopy regular usage needs 128 KB.
+	 */
+	net->core.sysctl_optmem_max = 128 * 1024;
+	net->core.sysctl_txrehash = SOCK_TXREHASH_ENABLED;
+}
+
 /* init code that must occur even if setup_net() is not called. */
 static __net_init void preinit_net(struct net *net, struct user_namespace *user_ns)
 {
@@ -324,6 +334,7 @@ static __net_init void preinit_net(struct net *net, struct user_namespace *user_
 	idr_init(&net->netns_ids);
 	spin_lock_init(&net->nsid_lock);
 	mutex_init(&net->ipv4.ra_mutex);
+	preinit_net_sysctl(net);
 }
 
 /*
@@ -384,32 +395,6 @@ static __net_init int setup_net(struct net *net)
 	goto out;
 }
 
-static int __net_init net_defaults_init_net(struct net *net)
-{
-	net->core.sysctl_somaxconn = SOMAXCONN;
-	/* Limits per socket sk_omem_alloc usage.
-	 * TCP zerocopy regular usage needs 128 KB.
-	 */
-	net->core.sysctl_optmem_max = 128 * 1024;
-	net->core.sysctl_txrehash = SOCK_TXREHASH_ENABLED;
-
-	return 0;
-}
-
-static struct pernet_operations net_defaults_ops = {
-	.init = net_defaults_init_net,
-};
-
-static __init int net_defaults_init(void)
-{
-	if (register_pernet_subsys(&net_defaults_ops))
-		panic("Cannot initialize net default settings");
-
-	return 0;
-}
-
-core_initcall(net_defaults_init);
-
 #ifdef CONFIG_NET_NS
 static struct ucounts *inc_net_namespaces(struct user_namespace *ns)
 {
-- 
2.30.2


