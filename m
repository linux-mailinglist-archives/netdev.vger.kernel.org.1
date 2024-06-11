Return-Path: <netdev+bounces-102736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A00019046E7
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 00:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44AE71F24B22
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 22:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECD315531A;
	Tue, 11 Jun 2024 22:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XTrLJBgm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855A37711C
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 22:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718144990; cv=none; b=OvJbpJxVtsuIy1hqJQDnCSuIb0m43pB6YZYRIzrRzyzvicSu+D4lNKIBDJq+wWa4XfGGZBOR1Y2VDcUQrslrnFdtmMFpovHQ4mYd+jnxDZdaM9KBGXsSQbN0E9x5a22EZx3lYkzAZflaKmZwQQqDF5mf4sKUWZLkstlqpU0GreI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718144990; c=relaxed/simple;
	bh=y2aFdIEmyQnPxo/FtTh+057DH7E2/4DyspGPW2TBToI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g21pPId4q1CLai162Npr8xP5bykoMcjXEdTlAbSfkE9zNxXNOzzpTYgzJtSn+bCsDtL1XMZZ44whmkVhmq/vEggWtE0HxB8hp40hwiY1E8A81Jt5t2we4etmiDrAKAF67CaSybkiASWqVg3QNcdADLA1qBNeqSHJldGUbdxiQXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=XTrLJBgm; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718144989; x=1749680989;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qrp1pHNh/W9B0umtbcyNDbYQcElQdcLUjbaLDmQWI1A=;
  b=XTrLJBgm2n9+QMOq5p3Z/eQNwH+92aGIeDjT+WpIyhZ+a5cGQ1Fwa73l
   psdEZ1WLpHLvv01w1f/sSWY6SymoKzSsekx46ujMXZhsd6LaoJC07yScq
   oqtB1Uiik4UitMEp2SGUvtI95unW1i5XYBzzrniRxulmRfi6S81MSXa1Q
   g=;
X-IronPort-AV: E=Sophos;i="6.08,231,1712620800"; 
   d="scan'208";a="407211296"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 22:29:46 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:20138]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.14:2525] with esmtp (Farcaster)
 id 0a435f58-df6b-4a6c-a791-c61fc7cfc5dd; Tue, 11 Jun 2024 22:29:44 +0000 (UTC)
X-Farcaster-Flow-ID: 0a435f58-df6b-4a6c-a791-c61fc7cfc5dd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 11 Jun 2024 22:29:42 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 11 Jun 2024 22:29:40 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 01/11] af_unix: Define locking order for unix_table_double_lock().
Date: Tue, 11 Jun 2024 15:28:55 -0700
Message-ID: <20240611222905.34695-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240611222905.34695-1-kuniyu@amazon.com>
References: <20240611222905.34695-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC001.ant.amazon.com (10.13.139.218) To
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
---
 net/unix/af_unix.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 3821f8945b1e..22bb941f174e 100644
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


