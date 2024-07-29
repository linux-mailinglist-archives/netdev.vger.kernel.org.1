Return-Path: <netdev+bounces-113821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62630940026
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 23:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 942F91C2244B
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 21:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBEA18D4A0;
	Mon, 29 Jul 2024 21:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="de5qROLK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196FD18C348
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 21:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722287387; cv=none; b=s3laJdfwzbPdW+GH49KlR4Pk0jgw7Up+JqCIyYRxGSZs7KUABXetHMOBFCT/14B6lRSX8eUr08/rz6CbuXi3BycqY5oQB2+RzxTu+su16f2wCa/KXq/7zamim6nX2rEn61682nLmQ7L+Y9mQMQg2sd6Xby7ySgnWz/sacNitTtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722287387; c=relaxed/simple;
	bh=L9lqwBYuOw/IZXyHxj+WHcY3bAkMi+ysW3QONpNPJBs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KzZrxFBKouvj7jGZ3ENwb40460xypHXzXrUkzqlxeGOM8P+8JIApuAms4UY2hOZmZJSQJD4heHmdwA7ZLgamXILi2lRql3lwndOgmP1yKgbZa/D8trtED9oSlMJRKSNEHiYnW/J8W2JMlZpkqQHFTMjZZ2tmOLV+osF+LENBIDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=de5qROLK; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722287385; x=1753823385;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s5yPAdI9j9tdmDRXhyVG/xewgp37VeefBc4fmQRs4f4=;
  b=de5qROLKLTgfyzLMuk4UI6pwoJDHxS31b8VsLwC1dy6i+AcI91Q/CSC/
   JGTQIkjttGxWHNwJI01S3jYCCHhltRZUHdk8bu1aiOBLFfmMeAItk/5w3
   sQEbagpV8yhVFG7iP2vIS/Gq4tPQq8CEbMRkJHySjbYmK5OuPogeFUwDG
   M=;
X-IronPort-AV: E=Sophos;i="6.09,246,1716249600"; 
   d="scan'208";a="413957279"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 21:09:42 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:45417]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.75:2525] with esmtp (Farcaster)
 id 1fb374e5-f5a6-4506-abfe-916f876d1967; Mon, 29 Jul 2024 21:09:40 +0000 (UTC)
X-Farcaster-Flow-ID: 1fb374e5-f5a6-4506-abfe-916f876d1967
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 29 Jul 2024 21:09:33 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.6) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 29 Jul 2024 21:09:30 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 3/6] net: Initialise net->passive once in preinit_net().
Date: Mon, 29 Jul 2024 14:07:58 -0700
Message-ID: <20240729210801.16196-4-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D032UWB003.ant.amazon.com (10.13.139.165) To
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
index 1d164ae097a5..e4e99e7ba9f8 100644
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


