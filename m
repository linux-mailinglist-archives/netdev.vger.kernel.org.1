Return-Path: <netdev+bounces-149592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D91D09E66CF
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 06:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 669EF188466B
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 05:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537801957E7;
	Fri,  6 Dec 2024 05:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bg6DMOgI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2973C194120
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 05:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733462826; cv=none; b=eGJbLUw/Nz6kg6YACy9YnMKqNbdmhwvOHovrYq7mPITfbcVSkIhlDTg4RNL/Wh8L7sE69/Ea+BLYdWST72FmwLz+s00pLoxkdjvd6L/8iXsVOAjR54IHbTrC9nS0IilIXcpG6oKRykzYBiroZfnJTXhW01qAKLjeQuw0Vz1Se3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733462826; c=relaxed/simple;
	bh=VYzL68c2xPaGlO4canXMR1Rc7t2WugtGN4guIMtAUaI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O+cpDKUBoI5qsqb/gg8s5EbMoye92E4lruBOdAOxZrqCa7Z2M+dodzVWQYYBiLW5HyVBGNM+9WoayszeBeAmWiwOiqhmz4O4tmTPk/fihvqRUQwNew1XbtSK6IYWNWE4p3WN74WLAh8o5hZUO6EwRso5u1nLitt+G0zYscFDjDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=bg6DMOgI; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733462825; x=1764998825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NqSJiaO2N+GmLDEvlN0KbuM5bmBWcd1Nogd/FYoTuRY=;
  b=bg6DMOgICXrl58/TM63g82zFTmBMjFL4L/00hsm8Ky/w+wYhNDC22Xgp
   pr22QSwf+wa3ahNyb+N0YVe3RXupSxf/e8Xx6C1SFPqnoolf0Sz3Oj+Wk
   xafcNVQFEJb2mRSkQTiKJFOKI4MA3XnBhZYf940x6Z1PhCAUBs3PX0vr2
   0=;
X-IronPort-AV: E=Sophos;i="6.12,212,1728950400"; 
   d="scan'208";a="453861973"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 05:27:01 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:35514]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.181:2525] with esmtp (Farcaster)
 id 64a9a9dd-115d-4e27-a05c-6f836090f9b6; Fri, 6 Dec 2024 05:27:00 +0000 (UTC)
X-Farcaster-Flow-ID: 64a9a9dd-115d-4e27-a05c-6f836090f9b6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 6 Dec 2024 05:26:59 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.244.93) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 6 Dec 2024 05:26:56 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 02/15] af_unix: Clean up error paths in unix_stream_connect().
Date: Fri, 6 Dec 2024 14:25:54 +0900
Message-ID: <20241206052607.1197-3-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D038UWB003.ant.amazon.com (10.13.139.157) To
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
index 6435ce699289..bdf88ddfb3e4 100644
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


