Return-Path: <netdev+bounces-151710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAE19F0A89
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4378E28155B
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 11:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57621D6193;
	Fri, 13 Dec 2024 11:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ruIYUlMI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCF51CEEAB
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 11:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734088375; cv=none; b=OfMzJks5nStlKq4bP5Y/6A2MJdiAsZobLRjbdZ9TOEysCIsG+LmjiNiS9vW7O8s7g+KdC+jCc8T4HR+mF8JOgrRMEd8Beej3mZJxeDbyZlVf2daKXFMnwMUEHBCmADZK1A8DPAQPhNb5TE7RhGTeGwz6wtnnUNqW9o8HekY2mms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734088375; c=relaxed/simple;
	bh=Kw2tR+HiK/j8IrcMRrSlaILIwbG44YON1BXrBg5BMWs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=taTaeG+WRhksHu2pQbBi5Nuz+fnF5jzid7g7bxHnoi4AfSBgg0sy5740hmDbDm2sntdrSRhTuip6lZtc3GMhFfs6oUvbTAw1dmXaOGOTsmGkdC3QRCdI9dTUMW0O0VNbgJdQRPvPkoePFdi7a2hkn2zC3tOaDizZqDmZ+l2oW1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ruIYUlMI; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734088374; x=1765624374;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=snF9Uwl4Zmu3PU375J3W9zk+mZLoy8Pn3psF4lliRsI=;
  b=ruIYUlMId2+NkFzvm7Kh4ts9UBnmhVVWpnPVJf6+m8d4MD/1HMbJFC6c
   rG2WoiEUNxS1Y5gER/avhG2R0bQqWm/93GrIU1Nf8MfCJV4sR5xfBr7ud
   nkgNEgwS9yG5mzkX7WceFNyP3iDVfUvB9Xl8a/n1NWkizQV1RKTafCwYE
   g=;
X-IronPort-AV: E=Sophos;i="6.12,231,1728950400"; 
   d="scan'208";a="702731855"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 11:12:52 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:2778]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.119:2525] with esmtp (Farcaster)
 id a8dd8a50-7b97-4b1d-be8c-9c7733b3055b; Fri, 13 Dec 2024 11:12:51 +0000 (UTC)
X-Farcaster-Flow-ID: a8dd8a50-7b97-4b1d-be8c-9c7733b3055b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 11:12:51 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.208) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 11:12:47 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 11/12] af_unix: Clean up error paths in unix_dgram_sendmsg().
Date: Fri, 13 Dec 2024 20:08:49 +0900
Message-ID: <20241213110850.25453-12-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241213110850.25453-1-kuniyu@amazon.com>
References: <20241213110850.25453-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The error path is complicated in unix_dgram_sendmsg() because there
are two timings when other could be non-NULL: when it's fetched from
unix_peer_get() and when it's looked up by unix_find_other().

Let's move unix_peer_get() to the else branch for unix_find_other()
and clean up the error paths.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 22c689b0044f..239ce2f77d55 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1993,12 +1993,6 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 							    NULL);
 		if (err)
 			goto out;
-	} else {
-		other = unix_peer_get(sk);
-		if (!other) {
-			err = -ENOTCONN;
-			goto out;
-		}
 	}
 
 	if ((test_bit(SOCK_PASSCRED, &sock->flags) ||
@@ -2026,7 +2020,7 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 	skb = sock_alloc_send_pskb(sk, len - data_len, data_len,
 				   msg->msg_flags & MSG_DONTWAIT, &err,
 				   PAGE_ALLOC_COSTLY_ORDER);
-	if (skb == NULL)
+	if (!skb)
 		goto out;
 
 	err = unix_scm_to_skb(&scm, skb, true);
@@ -2042,13 +2036,18 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 
 	timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 
-	if (!other) {
+	if (msg->msg_namelen) {
 lookup:
 		other = unix_find_other(sock_net(sk), msg->msg_name,
 					msg->msg_namelen, sk->sk_type);
 		if (IS_ERR(other)) {
 			err = PTR_ERR(other);
-			other = NULL;
+			goto out_free;
+		}
+	} else {
+		other = unix_peer_get(sk);
+		if (!other) {
+			err = -ENOTCONN;
 			goto out_free;
 		}
 	}
@@ -2056,7 +2055,7 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 	if (sk_filter(other, skb) < 0) {
 		/* Toss the packet but do not return any error to the sender */
 		err = len;
-		goto out_free;
+		goto out_sock_put;
 	}
 
 restart:
@@ -2080,7 +2079,7 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 			 * unlike SOCK_DGRAM wants.
 			 */
 			err = -EPIPE;
-			goto out_free;
+			goto out_sock_put;
 		}
 
 		if (!sk_locked)
@@ -2096,14 +2095,14 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 			unix_dgram_disconnected(sk, other);
 			sock_put(other);
 			err = -ECONNREFUSED;
-			goto out_free;
+			goto out_sock_put;
 		}
 
 		unix_state_unlock(sk);
 
 		if (!msg->msg_namelen) {
 			err = -ECONNRESET;
-			goto out_free;
+			goto out_sock_put;
 		}
 
 		goto lookup;
@@ -2132,7 +2131,7 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 
 			err = sock_intr_errno(timeo);
 			if (signal_pending(current))
-				goto out_free;
+				goto out_sock_put;
 
 			goto restart;
 		}
@@ -2173,11 +2172,11 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 	if (sk_locked)
 		unix_state_unlock(sk);
 	unix_state_unlock(other);
+out_sock_put:
+	sock_put(other);
 out_free:
 	kfree_skb(skb);
 out:
-	if (other)
-		sock_put(other);
 	scm_destroy(&scm);
 	return err;
 }
-- 
2.39.5 (Apple Git-154)


