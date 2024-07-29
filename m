Return-Path: <netdev+bounces-113824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CE9940030
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 23:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 898421C21062
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 21:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B276E18C324;
	Mon, 29 Jul 2024 21:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="AxeO4xsP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48F918757E
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 21:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722287454; cv=none; b=Yc9I4riRl2xx5mgtW528JPxFtiThQNJe97ee+BQCz+xRBMon+XOGfODwRXGk5ABYQE5/5zd7zuKJkItfaKcujsq/L5li7UVhffNyqNnPUfa9wuQviggEtjPco6PzqxQ0EGytj1ciK6s4UnqumRKneyqNn+AC0jfz8WugziMtnjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722287454; c=relaxed/simple;
	bh=+7frqmBR8PiHkl3AajCGu8Z9GGSE46zN6yfBMsUALpg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j+Trx8uVkq4V/6leZpNgLh97DOaxOz4r/sha+IkY8x1ovxWRpcYYxrro7u0wrf2SEkG39eOuwLIQAeMiXbhl1ZabY6JGpnawql+Tyd2wz9no7P1iLKYumxi0y/XQAkaXsv40+TmRYLBsNMlC1rq+k+BDm2XjcNvBP9uJyPLe5uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=AxeO4xsP; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722287452; x=1753823452;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sTWNG6It46tbzuVv0kFSU9WSKbeHG7ogda2C9wDODvc=;
  b=AxeO4xsPuyL7P3+iw9gndVSY7DIMLPFvsofDtrICR++NwqBhKMNLHlcl
   qXpJedPnzMbR2RsyVC8BErzqMMR+5pHoaomfz1zpWUv2cQm3zFyOsz5h+
   9iAsbJuvm5UPH+F8TQMp5N2XnBQkJF9Iss25Yb/xEZbuRu1g9E4d42EK4
   8=;
X-IronPort-AV: E=Sophos;i="6.09,246,1716249600"; 
   d="scan'208";a="418075572"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 21:10:48 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:59303]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.107:2525] with esmtp (Farcaster)
 id 6c8d6f88-d1b4-4d7c-8caf-908f2e82c141; Mon, 29 Jul 2024 21:10:48 +0000 (UTC)
X-Farcaster-Flow-ID: 6c8d6f88-d1b4-4d7c-8caf-908f2e82c141
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 29 Jul 2024 21:10:48 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.6) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 29 Jul 2024 21:10:45 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 6/6] net: Initialise net.core sysctl defaults in preinit_net().
Date: Mon, 29 Jul 2024 14:08:01 -0700
Message-ID: <20240729210801.16196-7-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240729210801.16196-1-kuniyu@amazon.com>
References: <20240729210801.16196-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA004.ant.amazon.com (10.13.139.91) To
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
index 7498f2cebbfe..a96a3be77f12 100644
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


