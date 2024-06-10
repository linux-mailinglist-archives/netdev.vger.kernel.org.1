Return-Path: <netdev+bounces-102370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9075E902BBC
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 00:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1891C28770E
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 22:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEA91474B4;
	Mon, 10 Jun 2024 22:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Cu4HxK8/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E091577107
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 22:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718058951; cv=none; b=u2fLnklSI57DuvjE+hmb1ApaNiQlwKt8XCb0QHxhLVqp2vzxkkqpgigwANamsjV6LUeNkFQafzoGzXDszkcb0ZfFTJWUmKZz9VOPa/NYAi/uud0eLLzB32/hlpiBzfHxRF1zUC7SysuhsY5Fx8QrwknrF8L0IT91WoW3l1lXIZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718058951; c=relaxed/simple;
	bh=gMp4aV4SCsbPm4EKU0tH039zYc/yruFPf70heRz5ySA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aXQ3Nh8/Yp3Q99s21vcw85/kGXs/VRsx7k960cw7Z7peET/RMyIXrYZs0nZagVDIZH+nQrFMDPYh1ZL5MlY9pkh/M5r1Tngm+qBF1sfn/bML5ZH8Xz2kzSY7AqXnsBmUiIwTyy+kQ45ssqHUgtZrLKTrV7KvLqXxQIJ1zyNzz3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Cu4HxK8/; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718058950; x=1749594950;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=euvermPs3H2QcOb2+dlyMMnaIjpyGx1RRSgxzgl9O1Q=;
  b=Cu4HxK8/93t/uRsjZluCTvEZCKU+hlwUJXYl+Uq+HHkUxaC8nFBMglHg
   DWvbEfLEVEuRdbrgcnQmcQCT/ZkSp9lLwwPrKdjpDArsp4l0nBXHueYct
   hz0XDdMiQDd14NsHCFjcW1KA4AgNwjvgE4q1NfqPADGuUFfeh+HQ+RaCt
   E=;
X-IronPort-AV: E=Sophos;i="6.08,228,1712620800"; 
   d="scan'208";a="302453710"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 22:35:48 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:58069]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.69:2525] with esmtp (Farcaster)
 id da15b280-9a4d-44df-88df-04c55c62eb08; Mon, 10 Jun 2024 22:35:47 +0000 (UTC)
X-Farcaster-Flow-ID: da15b280-9a4d-44df-88df-04c55c62eb08
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 10 Jun 2024 22:35:40 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 10 Jun 2024 22:35:38 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 01/11] af_unix: Define locking order for unix_table_double_lock().
Date: Mon, 10 Jun 2024 15:34:51 -0700
Message-ID: <20240610223501.73191-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240610223501.73191-1-kuniyu@amazon.com>
References: <20240610223501.73191-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC001.ant.amazon.com (10.13.139.233) To
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
 net/unix/af_unix.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 3821f8945b1e..b0a9891c0384 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -126,6 +126,13 @@ static spinlock_t bsd_socket_locks[UNIX_HASH_SIZE / 2];
  *    hash table is protected with spinlock.
  *    each socket state is protected by separate spinlock.
  */
+#ifdef CONFIG_PROVE_LOCKING
+static int unix_table_lock_cmp_fn(const struct lockdep_map *a,
+				  const struct lockdep_map *b)
+{
+	return a < b ? -1 : 0;
+}
+#endif
 
 static unsigned int unix_unbound_hash(struct sock *sk)
 {
@@ -168,7 +175,7 @@ static void unix_table_double_lock(struct net *net,
 		swap(hash1, hash2);
 
 	spin_lock(&net->unx.table.locks[hash1]);
-	spin_lock_nested(&net->unx.table.locks[hash2], SINGLE_DEPTH_NESTING);
+	spin_lock(&net->unx.table.locks[hash2]);
 }
 
 static void unix_table_double_unlock(struct net *net,
@@ -3578,6 +3585,7 @@ static int __net_init unix_net_init(struct net *net)
 
 	for (i = 0; i < UNIX_HASH_SIZE; i++) {
 		spin_lock_init(&net->unx.table.locks[i]);
+		lock_set_cmp_fn(&net->unx.table.locks[i], unix_table_lock_cmp_fn, NULL);
 		INIT_HLIST_HEAD(&net->unx.table.buckets[i]);
 	}
 
-- 
2.30.2


