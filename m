Return-Path: <netdev+bounces-103716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 454A990932D
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 22:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAFAAB242A8
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 20:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA07F1A0AE3;
	Fri, 14 Jun 2024 20:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UhrGhHAi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071AA1A01B6
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 20:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718395683; cv=none; b=mxx9RvKJ6QY4UGH/JwLEBOA0Tmnm+GoFezgct1JDuHyayuVYPjj0I+flm5CdknsYs7/3fkbIwMTY5XpWVDxDNmbDKhtqYzJJS3S/aLNCt78esRwt/rmnOadT+iRy/69KP1IQ4jhK/qI7pmWolsbofzVevSyGXAY7cQ//hpHQe2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718395683; c=relaxed/simple;
	bh=ffYdv/fnTGdmURR0f8+9zg7V+e/nZT1MfaCHoDbfBos=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jEIn+s01Qk8L2euC4df0NCpxz42yPZQdF2YodbPfl24biyhHcOgGhQNaNmRsfJsxmgFJ6TLM0iq/eqvUvFmFvzCxlWNijnvTnOq+ySirBP7pZqLxV28posAUJTo3rDJ+/6ryeTVt5tsVTuSkak5AaMoJ8PflqvmCGsOUc5tsVj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=UhrGhHAi; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718395682; x=1749931682;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oRDJoN5ueBxgNR2lTzqOqfGQ5F2LwpsPsXBOR8WdWz0=;
  b=UhrGhHAifxsj+50U6xEMqhHbVlL+GEPHyxoLud/E3zZd/RINMFLJEIGg
   ePvVFAyIjtoPNDX2iRnq++pZQL7ajfJQT//kJA4ev/z32hO9YRmFp/R72
   fmUkRJtEy4bNl/rLXASxrpRREkNIOXYPgcVfSMktqeV1WeI2kzFl7q//l
   s=;
X-IronPort-AV: E=Sophos;i="6.08,238,1712620800"; 
   d="scan'208";a="407906600"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 20:07:59 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:35975]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.144:2525] with esmtp (Farcaster)
 id 6e8774fc-ba45-44f3-872c-afa8b7e5f61e; Fri, 14 Jun 2024 20:07:58 +0000 (UTC)
X-Farcaster-Flow-ID: 6e8774fc-ba45-44f3-872c-afa8b7e5f61e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 14 Jun 2024 20:07:57 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 14 Jun 2024 20:07:55 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 01/11] af_unix: Define locking order for unix_table_double_lock().
Date: Fri, 14 Jun 2024 13:07:05 -0700
Message-ID: <20240614200715.93150-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240614200715.93150-1-kuniyu@amazon.com>
References: <20240614200715.93150-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB004.ant.amazon.com (10.13.138.91) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

When created, AF_UNIX socket is put into net->unx.table.buckets[],
and the hash is stored in sk->sk_hash.

  * unbound socket  : 0 <= sk_hash <= UNIX_HASH_MOD

When bind() is called, the socket could be moved to another bucket.

  * pathname socket : 0 <= sk_hash <= UNIX_HASH_MOD
  * abstract socket : UNIX_HASH_MOD + 1 <= sk_hash <= UNIX_HASH_MOD * 2 + 1

Then, we call unix_table_double_lock() which locks a single bucket
or two.

Let's define the order as unix_table_lock_cmp_fn() instead of using
spin_lock_nested().

The locking is always done in ascending order of sk->sk_hash, which
is the index of buckets/locks array allocated by kvmalloc_array().

  sk_hash_A < sk_hash_B
  <=> &locks[sk_hash_A].dep_map < &locks[sk_hash_B].dep_map

So, the relation of two sk->sk_hash can be derived from the addresses
of dep_map in the array of locks.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 net/unix/af_unix.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index e9c941e6a464..7889d4723959 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -126,6 +126,15 @@ static spinlock_t bsd_socket_locks[UNIX_HASH_SIZE / 2];
  *    hash table is protected with spinlock.
  *    each socket state is protected by separate spinlock.
  */
+#ifdef CONFIG_PROVE_LOCKING
+#define cmp_ptr(l, r)	(((l) > (r)) - ((l) < (r)))
+
+static int unix_table_lock_cmp_fn(const struct lockdep_map *a,
+				  const struct lockdep_map *b)
+{
+	return cmp_ptr(a, b);
+}
+#endif
 
 static unsigned int unix_unbound_hash(struct sock *sk)
 {
@@ -168,7 +177,7 @@ static void unix_table_double_lock(struct net *net,
 		swap(hash1, hash2);
 
 	spin_lock(&net->unx.table.locks[hash1]);
-	spin_lock_nested(&net->unx.table.locks[hash2], SINGLE_DEPTH_NESTING);
+	spin_lock(&net->unx.table.locks[hash2]);
 }
 
 static void unix_table_double_unlock(struct net *net,
@@ -3578,6 +3587,7 @@ static int __net_init unix_net_init(struct net *net)
 
 	for (i = 0; i < UNIX_HASH_SIZE; i++) {
 		spin_lock_init(&net->unx.table.locks[i]);
+		lock_set_cmp_fn(&net->unx.table.locks[i], unix_table_lock_cmp_fn, NULL);
 		INIT_HLIST_HEAD(&net->unx.table.buckets[i]);
 	}
 
-- 
2.30.2


