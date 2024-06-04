Return-Path: <netdev+bounces-100698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AEF8FB9A5
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 18:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64A60281945
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 16:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAD7149007;
	Tue,  4 Jun 2024 16:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="YfsXAdjM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519F0149001
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717520217; cv=none; b=VtyC1zm8CENaMI0AXL1LfBOJF1w0ImrKXRJVaDV5yCF8ND+FXrEDorXJutHOt8w5q2LZHwkv/WAtUJq6c9uYxmqoEr2ZDKbIpYuocNyIRK4oklyyTJzw2GUAG8tMGvRISHgllR121rK7pw8W1uZe969nkJk4st2gIsyCkaPwO2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717520217; c=relaxed/simple;
	bh=jQ+jXuKGacp+yGr04PMj6yuBxztI0Vnepe8iYDWXor8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gNo/DZnlw80lpK6Mgb17CfFinWuDpLYEKepRGKxBeYbJf0p/huZ8seE1wuEtriDnqCwHKB28EtpkMFUqhNE1gVMahc81MA/PjZrWMYxNpMbf0INcUQgk7vIB6r4S8wT4Wg850NPfAieoigl0qzYTyVF/rYGCWgSPeY1rVD5g4Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=YfsXAdjM; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717520216; x=1749056216;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dn0LV8EEygCSA56cpUxs6olss8r9PuJpNnkY/FH69Wg=;
  b=YfsXAdjMq0kVuTRTjSTsRk34u1FHwr8s94/laXocxETxg3oJtxFn3Enj
   rUs5xiDi18wgQZvuQvDoREkLkHmzEnAmTCIASEhvZKfvC11b21KBP3CRb
   7EYsMrZZJxBCek+bZwJcQAmYcc/yqEyTKCKVtExnoZcyovF0/KkC6xsh3
   8=;
X-IronPort-AV: E=Sophos;i="6.08,214,1712620800"; 
   d="scan'208";a="423764700"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 16:56:56 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:42153]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.213:2525] with esmtp (Farcaster)
 id ee8dcd42-aca1-4958-a11a-575e3aa5a247; Tue, 4 Jun 2024 16:56:55 +0000 (UTC)
X-Farcaster-Flow-ID: ee8dcd42-aca1-4958-a11a-575e3aa5a247
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 4 Jun 2024 16:56:55 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.50) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 4 Jun 2024 16:56:52 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net 10/15] af_unix: Annotate data-races around sk->sk_sndbuf.
Date: Tue, 4 Jun 2024 09:52:36 -0700
Message-ID: <20240604165241.44758-11-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240604165241.44758-1-kuniyu@amazon.com>
References: <20240604165241.44758-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA001.ant.amazon.com (10.13.139.100) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

sk_setsockopt() changes sk->sk_sndbuf under lock_sock(), but it's
not used in af_unix.c.

Let's use READ_ONCE() to read sk->sk_sndbuf in unix_writable(),
unix_dgram_sendmsg(), and unix_stream_sendmsg().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index e7b74207aa3b..de2a5e334a88 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -533,7 +533,7 @@ static int unix_dgram_peer_wake_me(struct sock *sk, struct sock *other)
 static int unix_writable(const struct sock *sk, unsigned char state)
 {
 	return state != TCP_LISTEN &&
-	       (refcount_read(&sk->sk_wmem_alloc) << 2) <= sk->sk_sndbuf;
+		(refcount_read(&sk->sk_wmem_alloc) << 2) <= READ_ONCE(sk->sk_sndbuf);
 }
 
 static void unix_write_space(struct sock *sk)
@@ -1967,7 +1967,7 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 	}
 
 	err = -EMSGSIZE;
-	if (len > sk->sk_sndbuf - 32)
+	if (len > READ_ONCE(sk->sk_sndbuf) - 32)
 		goto out;
 
 	if (len > SKB_MAX_ALLOC) {
@@ -2247,7 +2247,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 						   &err, 0);
 		} else {
 			/* Keep two messages in the pipe so it schedules better */
-			size = min_t(int, size, (sk->sk_sndbuf >> 1) - 64);
+			size = min_t(int, size, (READ_ONCE(sk->sk_sndbuf) >> 1) - 64);
 
 			/* allow fallback to order-0 allocations */
 			size = min_t(int, size, SKB_MAX_HEAD(0) + UNIX_SKB_FRAGS_SZ);
-- 
2.30.2


