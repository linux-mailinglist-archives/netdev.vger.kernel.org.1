Return-Path: <netdev+bounces-151701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9A99F0A72
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00859283937
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 11:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011851CBEB9;
	Fri, 13 Dec 2024 11:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="eWxV0a/S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CFD1C3C1C
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 11:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734088184; cv=none; b=HBIEeOGT0P2lAAmqNps/94ZyPh9kKRlLgNliQBynA5LhGJ8bUgCFV0P27rfKsPn0qb3JMNTwGE6TZ6Aby12lxR7liR14FTjmwTspGvaNVRz1tnyjPDEvjINQeQNRe7qV9hm5Xio4eTmaryVR/zprH74/LwWXT0f6AswSt/4da7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734088184; c=relaxed/simple;
	bh=ak9L4KdCb64Cufp3MyJmfWgbCkDpUwULqgRZwL6zyRw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c2/lQXmPEuMP5qFEHIZyQImhHbnbhSJm3VQEwZUDUOVU/kcGLrkKfu+fi6YdLO9EAjQ1QHRqPQuUMsDaFFVT9XGTIo6BG9c/DXrZ49CqPrsiItumZOqppSce+RBZdFlJQ0d/c6KRJ4CvdCnCFoK4DkSs/6LOLDHMeE2IqAK5Xu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=eWxV0a/S; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734088183; x=1765624183;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tsuvq+tiNz6X1azBZAJv0LyvECnDIs9eYAB1rUgJA8A=;
  b=eWxV0a/SsTYR4ebk9qolnwJIFcGW5SlS5AxbWHIyBAya+M8CFBLuI36I
   E6ILxVedtVJrKzJ/vqCl8/MH5p9nPo88i2R3Zg2aj6yLLZJjcN/Z1O0M+
   vme+aj7SElnPoznb08wyUyhJ7kwt+9+ouUOsGCRH0W1x6Bld/o2LPMSy1
   E=;
X-IronPort-AV: E=Sophos;i="6.12,231,1728950400"; 
   d="scan'208";a="152794027"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 11:09:41 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:51310]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.69:2525] with esmtp (Farcaster)
 id 9e988bbd-f2e2-4584-b3fc-804a836eed54; Fri, 13 Dec 2024 11:09:41 +0000 (UTC)
X-Farcaster-Flow-ID: 9e988bbd-f2e2-4584-b3fc-804a836eed54
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 11:09:40 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.208) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 11:09:37 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 02/12] af_unix: Clean up error paths in unix_stream_connect().
Date: Fri, 13 Dec 2024 20:08:40 +0900
Message-ID: <20241213110850.25453-3-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D040UWA001.ant.amazon.com (10.13.139.22) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The label order is weird in unix_stream_connect(), and all NULL checks
are unnecessary if reordered.

Let's clean up the error paths to make it easy to set a drop reason
for each path.

While at it, a comment with the old style is updated.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 23f419f561b8..21e17e739f88 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1563,15 +1563,14 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	timeo = sock_sndtimeo(sk, flags & O_NONBLOCK);
 
 	/* First of all allocate resources.
-	   If we will make it after state is locked,
-	   we will have to recheck all again in any case.
+	 * If we will make it after state is locked,
+	 * we will have to recheck all again in any case.
 	 */
 
 	/* create new sock for complete connection */
 	newsk = unix_create1(net, NULL, 0, sock->type);
 	if (IS_ERR(newsk)) {
 		err = PTR_ERR(newsk);
-		newsk = NULL;
 		goto out;
 	}
 
@@ -1579,7 +1578,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	skb = sock_wmalloc(newsk, 1, 0, GFP_KERNEL);
 	if (!skb) {
 		err = -ENOMEM;
-		goto out;
+		goto out_free_sk;
 	}
 
 restart:
@@ -1587,8 +1586,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	other = unix_find_other(net, sunaddr, addr_len, sk->sk_type);
 	if (IS_ERR(other)) {
 		err = PTR_ERR(other);
-		other = NULL;
-		goto out;
+		goto out_free_skb;
 	}
 
 	unix_state_lock(other);
@@ -1613,11 +1611,12 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 		}
 
 		timeo = unix_wait_for_peer(other, timeo);
+		sock_put(other);
 
 		err = sock_intr_errno(timeo);
 		if (signal_pending(current))
-			goto out;
-		sock_put(other);
+			goto out_free_skb;
+
 		goto restart;
 	}
 
@@ -1702,15 +1701,13 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	return 0;
 
 out_unlock:
-	if (other)
-		unix_state_unlock(other);
-
-out:
+	unix_state_unlock(other);
+	sock_put(other);
+out_free_skb:
 	kfree_skb(skb);
-	if (newsk)
-		unix_release_sock(newsk, 0);
-	if (other)
-		sock_put(other);
+out_free_sk:
+	unix_release_sock(newsk, 0);
+out:
 	return err;
 }
 
-- 
2.39.5 (Apple Git-154)


