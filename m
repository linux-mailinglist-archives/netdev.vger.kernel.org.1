Return-Path: <netdev+bounces-151703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A28D9F0A78
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E92616A5CD
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 11:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64631D0F5A;
	Fri, 13 Dec 2024 11:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="wGx+NnmE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068C71CDA02
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 11:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734088226; cv=none; b=O5hhsHkU8XO1G/kATyp3Fq3L8cqY1BsVvImDKU1bgCG4UGT/dyARQAVZWogJFwAed92bI+vGQRSMKnTbJtK4CyVTp97tAyyQjqdV3xmu722OVCwsqTOfphNoJbZvGtHumoduncuAvpM6DDFTIRbGPpq5nOGSEjnhXaub5k/cGPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734088226; c=relaxed/simple;
	bh=szBTfftwwONZHNbSzxj3DU/9MYVYhKAMSxmkcYZyloI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n6Mc7CjclZsr4PZkHF17sUp5QMu9n9dsjWBzGEpa0kLuv0BUWxfmAZL8ewuaZWSxR+NPTc7SkV9FRyd1rNd430crENG+Pn7R1tkyuBItworKP9cc3imUh1Kkwgom4YgMo9ECXMF0p4YIaWNnsit3F3/+bKs4BiK9SuL493SzB58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=wGx+NnmE; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734088225; x=1765624225;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PIsrCuSs9eGos0ffBFBsGwimJMGjDRDZ0li2gfWStLE=;
  b=wGx+NnmEsQcv9Y6EbrZEAYOCy7Rl0TnA29AK++lXOo0G9xlcycqI1G1W
   lZkVyq3E+uSubcXe2F50X/d3pLhAz/+0gR5BogZXTOcPSoTp6uFkXDc1F
   5vL96P7G1A7g+bY2SjFqOBrP0WxYzjXmI9Q3ITskikt6v6m4EAmpoHSBV
   Q=;
X-IronPort-AV: E=Sophos;i="6.12,231,1728950400"; 
   d="scan'208";a="155580401"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 11:10:23 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:27453]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.69:2525] with esmtp (Farcaster)
 id e2f5a143-18a3-43e0-b55f-085fbab707d5; Fri, 13 Dec 2024 11:10:23 +0000 (UTC)
X-Farcaster-Flow-ID: e2f5a143-18a3-43e0-b55f-085fbab707d5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 11:10:22 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.208) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 11:10:19 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 04/12] af_unix: Clean up error paths in unix_stream_sendmsg().
Date: Fri, 13 Dec 2024 20:08:42 +0900
Message-ID: <20241213110850.25453-5-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D040UWB001.ant.amazon.com (10.13.138.82) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

If we move send_sig() to the SEND_SHUTDOWN check before
the while loop, then we can reuse the same kfree_skb()
after the pipe_err_free label.

Let's gather the scattered kfree_skb()s in error paths.

While at it, some style issues are fixed, and the pipe_err_free
label is renamed to out_pipe to match other label names.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
v2: Move send_sig() after SEND_SHUTDOWN check before goto
---
 net/unix/af_unix.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 660d8b8130ca..d30bcd50527e 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2275,8 +2275,13 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 		}
 	}
 
-	if (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN)
-		goto pipe_err;
+	if (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN) {
+		if (!(msg->msg_flags & MSG_NOSIGNAL))
+			send_sig(SIGPIPE, current, 0);
+
+		err = -EPIPE;
+		goto out_err;
+	}
 
 	while (sent < len) {
 		size = len - sent;
@@ -2305,20 +2310,18 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 
 		/* Only send the fds in the first buffer */
 		err = unix_scm_to_skb(&scm, skb, !fds_sent);
-		if (err < 0) {
-			kfree_skb(skb);
-			goto out_err;
-		}
+		if (err < 0)
+			goto out_free;
+
 		fds_sent = true;
 
 		if (unlikely(msg->msg_flags & MSG_SPLICE_PAGES)) {
 			skb->ip_summed = CHECKSUM_UNNECESSARY;
 			err = skb_splice_from_iter(skb, &msg->msg_iter, size,
 						   sk->sk_allocation);
-			if (err < 0) {
-				kfree_skb(skb);
-				goto out_err;
-			}
+			if (err < 0)
+				goto out_free;
+
 			size = err;
 			refcount_add(size, &sk->sk_wmem_alloc);
 		} else {
@@ -2326,17 +2329,15 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 			skb->data_len = data_len;
 			skb->len = size;
 			err = skb_copy_datagram_from_iter(skb, 0, &msg->msg_iter, size);
-			if (err) {
-				kfree_skb(skb);
-				goto out_err;
-			}
+			if (err)
+				goto out_free;
 		}
 
 		unix_state_lock(other);
 
 		if (sock_flag(other, SOCK_DEAD) ||
 		    (other->sk_shutdown & RCV_SHUTDOWN))
-			goto pipe_err_free;
+			goto out_pipe;
 
 		maybe_add_creds(skb, sock, other);
 		scm_stat_add(other, skb);
@@ -2359,13 +2360,13 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 
 	return sent;
 
-pipe_err_free:
+out_pipe:
 	unix_state_unlock(other);
-	kfree_skb(skb);
-pipe_err:
-	if (sent == 0 && !(msg->msg_flags&MSG_NOSIGNAL))
+	if (!sent && !(msg->msg_flags & MSG_NOSIGNAL))
 		send_sig(SIGPIPE, current, 0);
 	err = -EPIPE;
+out_free:
+	kfree_skb(skb);
 out_err:
 	scm_destroy(&scm);
 	return sent ? : err;
-- 
2.39.5 (Apple Git-154)


