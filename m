Return-Path: <netdev+bounces-149603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D619E66E8
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 06:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF7821884D68
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 05:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B56E194120;
	Fri,  6 Dec 2024 05:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HYo2ZV6E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8C5199392
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 05:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733463052; cv=none; b=PQFdTOCRbZRfQK+UTvjkHzJxR/M+9SL3XB8GYYJC1204/OTcUWeMA/iB6RAPRDIZtiOnvhQGVpUkio9l+kNrdR3e9fL0jkK9VC7aXqqQ9utpqzRmFvvKeWdBYWAe8IoeBGKerThLSHaCOfl1fBp6hwOv9+ySdZkUUqPIGHDNjeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733463052; c=relaxed/simple;
	bh=Ykda5D9oBgc/u2ahcpc2E1EjdoFRxuQzdSG32Vz6OUc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HH6Ca5nu5FbymaSBQDjLfo1JgKTUvt1peGsqDhC8XCFPsYMzzEuaH+VRIxtFhEgEB3N42eP5QfbO2atvSUrGK8rjgNlJAktvHl8Fjz8EKEub/YuLn1VmEaIgJ7+kyicQuCcBExB/n7tBrxvQ3rYtvvBiXlPQA1faFNilQsoTFVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=HYo2ZV6E; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733463049; x=1764999049;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5O7oYkEXe1+JyU0bd1yKaN4lCMCisP97OJYjSFkKwws=;
  b=HYo2ZV6EhSGLJZQ6f7ghOW7NWsJZyLj/YcurlQJIKPP+kEkaNd13JL+p
   zByQ9RcEon/CG+FHC4QuwKZ97y/hOu9s/QUZ7+w0LuB+A71ECQc0S8iP4
   AUikq7Cz4cV5bD/6IRTDGpjbj1rTBgtWXxtPsVA/IWIDDxy74oE8Vonke
   8=;
X-IronPort-AV: E=Sophos;i="6.12,212,1728950400"; 
   d="scan'208";a="443570559"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 05:30:48 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:9774]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.101:2525] with esmtp (Farcaster)
 id 54b815a7-2a92-43d6-ad05-3ad86f27807d; Fri, 6 Dec 2024 05:30:47 +0000 (UTC)
X-Farcaster-Flow-ID: 54b815a7-2a92-43d6-ad05-3ad86f27807d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 6 Dec 2024 05:30:47 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.244.93) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 6 Dec 2024 05:30:43 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 13/15] af_unix: Clean up error path in unix_dgram_sendmsg().
Date: Fri, 6 Dec 2024 14:26:05 +0900
Message-ID: <20241206052607.1197-14-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D032UWB001.ant.amazon.com (10.13.139.152) To
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
index 9ae326eea57f..629e7a81178e 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2001,12 +2001,6 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 			if (err)
 				goto out;
 		}
-	} else {
-		other = unix_peer_get(sk);
-		if (!other) {
-			err = -ENOTCONN;
-			goto out;
-		}
 	}
 
 	if (len > READ_ONCE(sk->sk_sndbuf) - 32) {
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


