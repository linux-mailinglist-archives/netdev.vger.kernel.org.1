Return-Path: <netdev+bounces-105455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A40789113E5
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 22:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E27AFB219D6
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 20:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50148757EE;
	Thu, 20 Jun 2024 20:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="olUnDN6C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D0F69DF7
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 20:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718917062; cv=none; b=NK8KI8EekJgJpapodQqeyA+e89oazhHlohtKVQyMDvF19Vci45QdJo+oyn9lpaGdq7H82/I0juxBNstinxsCcsKGo2g/BTyGkcAYt3DhF9ip02YSu7yqVojokMJzRuBp7hb8xgtFXVyExOkUddg0D3XfxuZUTarCZDZmg6INP+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718917062; c=relaxed/simple;
	bh=SFOkvdIY1Z2DTg6iywt7b+a1oUXcNiI3PAN1GL04fEI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K1PH4y+t/1zzR3BO/5B4rzD+KFdkOnp3YuS41e+tF/PavNa+z9WtgOzir4AEDTRGainIypaNX1wgDidr8ujJMSeO8cYO6cRSb6yRnf090acmQvYVDS5wJkdl7ou4p3Hum1N1210xbTRmhyrTfJFZI1NbMF6VPAh4cRoJzoCraDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=olUnDN6C; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718917061; x=1750453061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y/pK7a6EOaj6WvJ+tzCT6g4Wr6lQSGCH41aEqPzSf9M=;
  b=olUnDN6C7cEgOJ484eq3oKKLVGV/Qb9CZSVhE2i3tvk9UDf4TYFrrh5H
   UKIftLtw4+xK6PyDn8A2M+NHzIv1UFpJGh6cnw+O7kgEJ4Npo480ftylv
   G3woX4aRe8ccVCtV8rkGhpDcJSFDcuppeaicrz2i1BjwkT4DB/mLox5y7
   Y=;
X-IronPort-AV: E=Sophos;i="6.08,252,1712620800"; 
   d="scan'208";a="304844036"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 20:57:26 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:62991]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.145:2525] with esmtp (Farcaster)
 id d57e5d1e-2f92-4f63-9613-dcd89d05ca26; Thu, 20 Jun 2024 20:57:24 +0000 (UTC)
X-Farcaster-Flow-ID: d57e5d1e-2f92-4f63-9613-dcd89d05ca26
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 20 Jun 2024 20:57:23 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 20 Jun 2024 20:57:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v4 net-next 02/11] af_unix: Define locking order for U_LOCK_SECOND in unix_state_double_lock().
Date: Thu, 20 Jun 2024 13:56:14 -0700
Message-ID: <20240620205623.60139-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240620205623.60139-1-kuniyu@amazon.com>
References: <20240620205623.60139-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA003.ant.amazon.com (10.13.139.6) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

unix_dgram_connect() and unix_dgram_{send,recv}msg() lock the socket
and peer in ascending order of the socket address.

Let's define the order as unix_state_lock_cmp_fn() instead of using
unix_state_lock_nested().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 net/unix/af_unix.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 7889d4723959..0657f599bbef 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -134,6 +134,18 @@ static int unix_table_lock_cmp_fn(const struct lockdep_map *a,
 {
 	return cmp_ptr(a, b);
 }
+
+static int unix_state_lock_cmp_fn(const struct lockdep_map *_a,
+				  const struct lockdep_map *_b)
+{
+	const struct unix_sock *a, *b;
+
+	a = container_of(_a, struct unix_sock, lock.dep_map);
+	b = container_of(_b, struct unix_sock, lock.dep_map);
+
+	/* unix_state_double_lock(): ascending address order. */
+	return cmp_ptr(a, b);
+}
 #endif
 
 static unsigned int unix_unbound_hash(struct sock *sk)
@@ -987,6 +999,7 @@ static struct sock *unix_create1(struct net *net, struct socket *sock, int kern,
 	u->path.dentry = NULL;
 	u->path.mnt = NULL;
 	spin_lock_init(&u->lock);
+	lock_set_cmp_fn(&u->lock, unix_state_lock_cmp_fn, NULL);
 	mutex_init(&u->iolock); /* single task reading lock */
 	mutex_init(&u->bindlock); /* single task binding lock */
 	init_waitqueue_head(&u->peer_wait);
@@ -1335,11 +1348,12 @@ static void unix_state_double_lock(struct sock *sk1, struct sock *sk2)
 		unix_state_lock(sk1);
 		return;
 	}
+
 	if (sk1 > sk2)
 		swap(sk1, sk2);
 
 	unix_state_lock(sk1);
-	unix_state_lock_nested(sk2, U_LOCK_SECOND);
+	unix_state_lock(sk2);
 }
 
 static void unix_state_double_unlock(struct sock *sk1, struct sock *sk2)
-- 
2.30.2


