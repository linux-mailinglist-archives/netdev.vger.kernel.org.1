Return-Path: <netdev+bounces-114677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE82F9436DD
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 22:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E71101C2110F
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 20:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C1249627;
	Wed, 31 Jul 2024 20:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ft4TLZCk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7033B381AD
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 20:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722456589; cv=none; b=OpNjCAbUI8wJDzlReHtWyF0MqoEGwspfRshjBuoKx4GXPn5m7CJ2H18ssNDDeGI9KyIztEzmWQArZ9P4WuaydmFBOKlDeuR6tyvswHHRx63Xzt5DrG23mozBT5i5WY9Eno9M+/aUdQnldRdpeuZu7PiBYg+WOvu8q9W44XUrtM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722456589; c=relaxed/simple;
	bh=LsUXF/GV7Zfwzb2d6cqdnZCt6+GDCHP9xOgG6iqiCtA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R9NISu/MAwjV3NsYuKqDcLeO4NZbePFLZO4xP6sQnmBYmK2VQU6gEiaTSbEfQhiOX8bz3jreB/skkrW+AmwIRVFHGnEsSxAahSgMTGjbIam/tA8SxctQyh7OEqvvBzVtUs1I00aWyN5pLTM6qcTtpIGOibGnRK8vA+l7cXJupmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ft4TLZCk; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722456588; x=1753992588;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s6Cn2TLeqAxCGpnshWKjC8V+yOHdPHBLeflgZjOkg/U=;
  b=ft4TLZCkxOzgMvclPj+TXMm0spssbseYySUvH9s/DYzlUjNHefsEsENm
   v0S+ULkY6+vHd2DaUkIVAE0cWT8GKro45Ufi+is+UszK771kGFRrRVG98
   n8nOP5zaXjw9PjGVAKOWuDBhZQbD6xN0NJPNtPjvDCALlFAAl7egwzfwt
   8=;
X-IronPort-AV: E=Sophos;i="6.09,251,1716249600"; 
   d="scan'208";a="414431779"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 20:09:46 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:40073]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.107:2525] with esmtp (Farcaster)
 id 84be512d-7ab2-4159-b9fc-3fd0160e23f6; Wed, 31 Jul 2024 20:09:45 +0000 (UTC)
X-Farcaster-Flow-ID: 84be512d-7ab2-4159-b9fc-3fd0160e23f6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 31 Jul 2024 20:09:38 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 31 Jul 2024 20:09:36 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 5/6] net: Slim down setup_net().
Date: Wed, 31 Jul 2024 13:07:20 -0700
Message-ID: <20240731200721.70601-6-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D037UWB002.ant.amazon.com (10.13.138.121) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Most initialisations in setup_net() do not require pernet_ops_rwsem
and can be moved to preinit_net().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/net_namespace.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index b91c15b27fb2..eed5a28e8ee3 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -310,16 +310,26 @@ struct net *get_net_ns_by_id(const struct net *net, int id)
 EXPORT_SYMBOL_GPL(get_net_ns_by_id);
 
 /* init code that must occur even if setup_net() is not called. */
-static __net_init void preinit_net(struct net *net)
+static __net_init void preinit_net(struct net *net, struct user_namespace *user_ns)
 {
 	refcount_set(&net->passive, 1);
+	refcount_set(&net->ns.count, 1);
+	ref_tracker_dir_init(&net->refcnt_tracker, 128, "net refcnt");
 	ref_tracker_dir_init(&net->notrefcnt_tracker, 128, "net notrefcnt");
+
+	get_random_bytes(&net->hash_mix, sizeof(u32));
+	net->dev_base_seq = 1;
+	net->user_ns = user_ns;
+
+	idr_init(&net->netns_ids);
+	spin_lock_init(&net->nsid_lock);
+	mutex_init(&net->ipv4.ra_mutex);
 }
 
 /*
  * setup_net runs the initializers for the network namespace object.
  */
-static __net_init int setup_net(struct net *net, struct user_namespace *user_ns)
+static __net_init int setup_net(struct net *net)
 {
 	/* Must be called with pernet_ops_rwsem held */
 	const struct pernet_operations *ops, *saved_ops;
@@ -327,18 +337,9 @@ static __net_init int setup_net(struct net *net, struct user_namespace *user_ns)
 	LIST_HEAD(dev_kill_list);
 	int error = 0;
 
-	refcount_set(&net->ns.count, 1);
-	ref_tracker_dir_init(&net->refcnt_tracker, 128, "net refcnt");
-
-	get_random_bytes(&net->hash_mix, sizeof(u32));
 	preempt_disable();
 	net->net_cookie = gen_cookie_next(&net_cookie);
 	preempt_enable();
-	net->dev_base_seq = 1;
-	net->user_ns = user_ns;
-	idr_init(&net->netns_ids);
-	spin_lock_init(&net->nsid_lock);
-	mutex_init(&net->ipv4.ra_mutex);
 
 	list_for_each_entry(ops, &pernet_list, list) {
 		error = ops_init(ops, net);
@@ -497,7 +498,7 @@ struct net *copy_net_ns(unsigned long flags,
 		goto dec_ucounts;
 	}
 
-	preinit_net(net);
+	preinit_net(net, user_ns);
 	net->ucounts = ucounts;
 	get_user_ns(user_ns);
 
@@ -505,7 +506,7 @@ struct net *copy_net_ns(unsigned long flags,
 	if (rv < 0)
 		goto put_userns;
 
-	rv = setup_net(net, user_ns);
+	rv = setup_net(net);
 
 	up_read(&pernet_ops_rwsem);
 
@@ -1199,10 +1200,10 @@ void __init net_ns_init(void)
 #ifdef CONFIG_KEYS
 	init_net.key_domain = &init_net_key_domain;
 #endif
-	preinit_net(&init_net);
+	preinit_net(&init_net, &init_user_ns);
 
 	down_write(&pernet_ops_rwsem);
-	if (setup_net(&init_net, &init_user_ns))
+	if (setup_net(&init_net))
 		panic("Could not setup the initial network namespace");
 
 	init_net_initialized = true;
-- 
2.30.2


