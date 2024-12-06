Return-Path: <netdev+bounces-149604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA309E66E9
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 06:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A691281E78
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 05:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CFB193060;
	Fri,  6 Dec 2024 05:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dZOyiP71"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF01194AF4
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 05:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733463072; cv=none; b=bdLYvAwEQXNZ8UNCF33iafqndSS1IfhZs/ZSWV54G1h87NAgnz7wQp98tyyaeq//o37QIn9vRySihKCtbAiJg+JQJEnzGhqKdZ+1Bgxak5XHM5maYVq6iFQj+qXcFanYuS7WiCF5FFekw8FMRGJOkoLt+G5DH8PQIxLM4UYEO3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733463072; c=relaxed/simple;
	bh=MUMFd1D6+FjAwzwU1VPEzSrrFoeUUxVQIXCuAYFQNJk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CJRj94/eLnq1XbmZw7yPDv8L8nPAc/mK2hFyRyLRl3e5E6duA9QO9io1rI6H8OJUcV6Ts3s1TOVMi6QUix67IVSq81I+VXY2LEnAJ8ebd8yYEKcciLCnp9I3VKxZrLvbwHC6F/bqOQ1WPuawbUKmHVyWN3KxSBzFlJmb4w3yXJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=dZOyiP71; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733463070; x=1764999070;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LevLZngPYHnZFbXP5IEHInbEsM8F54N4dwdSbjUuOYo=;
  b=dZOyiP71v1X1B76+KDqDgGmLfGtuEee8KubaUKhUbYxjykNUBtE42Bmk
   lAy5l1Vd8So1RoCHSNGA/retWguT7qoqHM7AAOwZTwkf7aNo8J1sYex4u
   IfGuNEZ1yJU5JALSlgPYKp9wXJ+10gnsgteBq0Tvq5HEtZe0TDsZph57v
   A=;
X-IronPort-AV: E=Sophos;i="6.12,212,1728950400"; 
   d="scan'208";a="252777605"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 05:31:09 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:27406]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.181:2525] with esmtp (Farcaster)
 id 8ab50b68-abb9-4a40-bd44-947d4ae3894f; Fri, 6 Dec 2024 05:31:08 +0000 (UTC)
X-Farcaster-Flow-ID: 8ab50b68-abb9-4a40-bd44-947d4ae3894f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 6 Dec 2024 05:31:07 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.244.93) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 6 Dec 2024 05:31:04 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 14/15] af_unix: Remove sk_locked logic in unix_dgram_sendmsg().
Date: Fri, 6 Dec 2024 14:26:06 +0900
Message-ID: <20241206052607.1197-15-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241206052607.1197-1-kuniyu@amazon.com>
References: <20241206052607.1197-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA004.ant.amazon.com (10.13.139.85) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

If the receiver socket is not connected to the sender socket and the
receiver's queue is full in unix_dgram_sendmsg(), we lock the both
sockets and retry.

The logic adds one unlikely check to the sane path and complicates the
entire function, but it's not worth that.

Let's remove the sk_locked variable and simplify the logic and the error
path.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 629e7a81178e..594c7428f22d 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1967,7 +1967,6 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 	struct scm_cookie scm;
 	struct sk_buff *skb;
 	int data_len = 0;
-	int sk_locked;
 	long timeo;
 	int err;
 
@@ -2059,7 +2058,6 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 	}
 
 restart:
-	sk_locked = 0;
 	unix_state_lock(other);
 restart_locked:
 
@@ -2082,8 +2080,7 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 			goto out_sock_put;
 		}
 
-		if (!sk_locked)
-			unix_state_lock(sk);
+		unix_state_lock(sk);
 
 		if (unix_peer(sk) == other) {
 			unix_peer(sk) = NULL;
@@ -2136,27 +2133,21 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 			goto restart;
 		}
 
-		if (!sk_locked) {
-			unix_state_unlock(other);
-			unix_state_double_lock(sk, other);
-		}
+		unix_state_unlock(other);
+		unix_state_double_lock(sk, other);
 
 		if (unix_peer(sk) != other ||
-		    unix_dgram_peer_wake_me(sk, other)) {
+		    unix_dgram_peer_wake_me(sk, other))
 			err = -EAGAIN;
-			sk_locked = 1;
+
+		unix_state_unlock(sk);
+
+		if (err)
 			goto out_unlock;
-		}
 
-		if (!sk_locked) {
-			sk_locked = 1;
-			goto restart_locked;
-		}
+		goto restart_locked;
 	}
 
-	if (unlikely(sk_locked))
-		unix_state_unlock(sk);
-
 	if (sock_flag(other, SOCK_RCVTSTAMP))
 		__net_timestamp(skb);
 	maybe_add_creds(skb, sock, other);
@@ -2169,8 +2160,6 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 	return len;
 
 out_unlock:
-	if (sk_locked)
-		unix_state_unlock(sk);
 	unix_state_unlock(other);
 out_sock_put:
 	sock_put(other);
-- 
2.39.5 (Apple Git-154)


