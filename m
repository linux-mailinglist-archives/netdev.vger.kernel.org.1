Return-Path: <netdev+bounces-114675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6599436DB
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 22:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463C5282571
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 20:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8824482DB;
	Wed, 31 Jul 2024 20:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Jp7cth6N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4E1381AD
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 20:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722456534; cv=none; b=eg/8FN+RHdkwkPCU4uJyG/Ey7x/8OnEqD4GcWYB1Nh7OUdMF2B5QKwRont5qUFInFDZ4o89Cer4LSVtcgXEsVGi/SFQu7OaJnPtsCkys63tj/KRiJocfUrMOPSR4LNbVeQXydAT08adKIC0cXbA5+y0pufHy6OJoNUQquxOa/5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722456534; c=relaxed/simple;
	bh=RkBwQjUKB3zY2PsVwOVr+cdHzNJ9AnPmy2dvB6m9S0o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JPHiXgBQoE2N5mb5uWlFFd9gZMOEppPKDif/7o5S3IfKrNgUOGGN2p/B9fnzpSS55JbftkXqiNlTSx6oqXSzuZcromSlYzDJVFiAsk2uTmFW6IZz6jmTjclv4n1h2y4G/XzleNNInl3eE/ad2WZnkHAHA1c4+4RjXqWic8itVJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Jp7cth6N; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722456533; x=1753992533;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IKfqdNCa62dm409Z5Qprky+neCCptKvPVVZheYjXlQ4=;
  b=Jp7cth6N6Wi4o5BLCTdma96l43OScCvXJhJCJNgz1VigEgcQEfDFXyzq
   U/6qbWkQfJkilq1Kc/Jgot0WfLs16n1WUMd0vWEOMOiqPjqEHIeM9uioj
   AMsx+pec22/DAr9ZPOlQTX6X6ewf9nWapzNnY+mdB98qiaKQCpTBvVMM9
   4=;
X-IronPort-AV: E=Sophos;i="6.09,251,1716249600"; 
   d="scan'208";a="222621442"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 20:08:50 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:26683]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.107:2525] with esmtp (Farcaster)
 id 21fa24d2-efb3-4544-a86b-7c5cb950ce7c; Wed, 31 Jul 2024 20:08:49 +0000 (UTC)
X-Farcaster-Flow-ID: 21fa24d2-efb3-4544-a86b-7c5cb950ce7c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 31 Jul 2024 20:08:49 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 31 Jul 2024 20:08:46 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 3/6] net: Initialise net->passive once in preinit_net().
Date: Wed, 31 Jul 2024 13:07:18 -0700
Message-ID: <20240731200721.70601-4-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D042UWB004.ant.amazon.com (10.13.139.150) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

When initialising the root netns, we set net->passive in setup_net().

However, we do it twice for non-root netns in copy_net_ns() and
setup_net().

This is because we could bypass setup_net() in copy_net_ns() if
down_read_killable() fails.

preinit_net() is a better place to put such an operation.

Let's initialise net->passive in preinit_net().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/net_namespace.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 1cd87df13f39..6c9acb086852 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -312,6 +312,7 @@ EXPORT_SYMBOL_GPL(get_net_ns_by_id);
 /* init code that must occur even if setup_net() is not called. */
 static __net_init void preinit_net(struct net *net)
 {
+	refcount_set(&net->passive, 1);
 	ref_tracker_dir_init(&net->notrefcnt_tracker, 128, "net notrefcnt");
 }
 
@@ -329,7 +330,6 @@ static __net_init int setup_net(struct net *net, struct user_namespace *user_ns)
 	refcount_set(&net->ns.count, 1);
 	ref_tracker_dir_init(&net->refcnt_tracker, 128, "net refcnt");
 
-	refcount_set(&net->passive, 1);
 	get_random_bytes(&net->hash_mix, sizeof(u32));
 	preempt_disable();
 	net->net_cookie = gen_cookie_next(&net_cookie);
@@ -498,7 +498,6 @@ struct net *copy_net_ns(unsigned long flags,
 	}
 
 	preinit_net(net);
-	refcount_set(&net->passive, 1);
 	net->ucounts = ucounts;
 	get_user_ns(user_ns);
 
-- 
2.30.2


