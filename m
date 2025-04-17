Return-Path: <netdev+bounces-183867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24317A92454
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 19:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C5C246256E
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 17:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CD62566FB;
	Thu, 17 Apr 2025 17:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="PpdWa95P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E7D253F22
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 17:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744912046; cv=none; b=OdlNFWOv9+2rbHVtbQzz5Fi9E41RVUuE5AA+/nncTJrHPAbvsuQuq/kHkTuzrCczhggqH9GD90GRpVnK4eGmaYkWftxj8UkFdxaacya5lLojbl0Em/DTDLaAVSOUiF3eHVCnZbMtaNz2mEgQxs/09o0R8u3FPlxJaUcydIEl3e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744912046; c=relaxed/simple;
	bh=FwxFh8ZcyF5KMhTQioCw/JJCjLE92okS6+ZFq7YSS8k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LTe+ohyqr0DI5ftjB6oahkzMesE+BHTib06HynFrEWxoOCrIqLpJBSBh9CP/A41v4zk9Xa3Lk3mP61QfTgqV/ukQyJVmUkDsEuZesOpw0fmPA7MM1WHLtc6Aqcbq2wA+20KyJHoOcX2uMxjMSOX3rTZP8uS2fgxbp4e69gMn7aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=PpdWa95P; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744912045; x=1776448045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sDY8QkKPn4vA0dA2+f1F4PxSaVDjC+Jejdttv8uaVqw=;
  b=PpdWa95PaKQW/gdBl5GQKTLqj6HnqsgT9HfPfqY7x2a3W6CZplS5y4U8
   8FvQHhKVy8sTK0YMpTSJdhXqxADrBhUyrxPZeETEvWVJIz2IhDNmz9L/V
   GtK9L0wsyXgSSj30pKN40oaLKthr9p2Amk/P8AmhHn6MK1R4B1YNdTuB3
   g=;
X-IronPort-AV: E=Sophos;i="6.15,219,1739836800"; 
   d="scan'208";a="816906721"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 17:46:12 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:62183]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.54:2525] with esmtp (Farcaster)
 id cafafa34-df2b-4deb-9d58-a507365eb40d; Thu, 17 Apr 2025 17:46:10 +0000 (UTC)
X-Farcaster-Flow-ID: cafafa34-df2b-4deb-9d58-a507365eb40d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 17 Apr 2025 17:46:07 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.49.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 17 Apr 2025 17:46:04 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH RESEND v2 net-next 02/14] ipv6: Get rid of RTNL for SIOCDELRT and RTM_DELROUTE.
Date: Thu, 17 Apr 2025 10:45:53 -0700
Message-ID: <20250417174557.65721-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <f2c0341f-8b65-4671-891a-61f6892d6e1c@redhat.com>
References: <f2c0341f-8b65-4671-891a-61f6892d6e1c@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB001.ant.amazon.com (10.13.139.132) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Thu, 17 Apr 2025 08:46:01 +0200
> On 4/16/25 8:45 PM, Kuniyuki Iwashima wrote:
> > From: Paolo Abeni <pabeni@redhat.com>
> >> but acquiring the rcu lock after grabbing the rcu protected struct
> >> is confusing. It should be good adding a comment or moving the rcu lock
> >> before the lookup (and dropping the RCU lock from fib6_get_table())
> > 
> > There are other callers of fib6_get_table(), so I'd move rcu_read_lock()
> > before it, and will look into them if we can drop it from fib6_get_table().
> 
> you could provide a RCU-lockless __fib6_get_table() variant, use it
> here, and with time (outside this series) such helper usage could be
> extended.

I think it's worth a separate patch, but now the number of patches
is 17, so I'll add a note in the commit message that we don't need
rcu for fib6_get_table() and will post a follow up series to convert
the lockless version in some places.

Thanks!

---8<---
diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index 7c87873ae211..e5b28a732796 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -430,6 +430,7 @@ struct fib6_entry_notifier_info {
  *	exported functions
  */
 
+struct fib6_table *__fib6_get_table(struct net *net, u32 id);
 struct fib6_table *fib6_get_table(struct net *net, u32 id);
 struct fib6_table *fib6_new_table(struct net *net, u32 id);
 struct dst_entry *fib6_rule_lookup(struct net *net, struct flowi6 *fl6,
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index bf727149fdec..ba3e290a9da4 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -265,27 +265,36 @@ struct fib6_table *fib6_new_table(struct net *net, u32 id)
 }
 EXPORT_SYMBOL_GPL(fib6_new_table);
 
-struct fib6_table *fib6_get_table(struct net *net, u32 id)
+struct fib6_table *__fib6_get_table(struct net *net, u32 id)
 {
-	struct fib6_table *tb;
 	struct hlist_head *head;
-	unsigned int h;
+	struct fib6_table *tb;
 
-	if (id == 0)
+	if (!id)
 		id = RT6_TABLE_MAIN;
-	h = id & (FIB6_TABLE_HASHSZ - 1);
-	rcu_read_lock();
-	head = &net->ipv6.fib_table_hash[h];
-	hlist_for_each_entry_rcu(tb, head, tb6_hlist) {
-		if (tb->tb6_id == id) {
-			rcu_read_unlock();
+
+	head = &net->ipv6.fib_table_hash[id & (FIB6_TABLE_HASHSZ - 1)];
+
+	/* Once allocated, fib6_table is not freed until netns dismantle, so
+	 * RCU is not required (but rcu_dereference_raw() is for data-race).
+	 */
+	hlist_for_each_entry_rcu(tb, head, tb6_hlist, true)
+		if (tb->tb6_id == id)
 			return tb;
-		}
-	}
-	rcu_read_unlock();
 
 	return NULL;
 }
+
+struct fib6_table *fib6_get_table(struct net *net, u32 id)
+{
+	struct fib6_table *tb;
+
+	rcu_read_lock();
+	tb = __fib6_get_table(net, id);
+	rcu_read_unlock();
+
+	return tb;
+}
 EXPORT_SYMBOL_GPL(fib6_get_table);
 
 static void __net_init fib6_tables_init(struct net *net)
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 237e31f64a4a..af311c19dcc6 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4076,7 +4076,7 @@ static int ip6_route_del(struct fib6_config *cfg,
 	struct fib6_node *fn;
 	int err = -ESRCH;
 
-	table = fib6_get_table(cfg->fc_nlinfo.nl_net, cfg->fc_table);
+	table = __fib6_get_table(cfg->fc_nlinfo.nl_net, cfg->fc_table);
 	if (!table) {
 		NL_SET_ERR_MSG(extack, "FIB table does not exist");
 		return err;
---8<---

