Return-Path: <netdev+bounces-151706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9DC9F0A80
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43EC216A6F7
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 11:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FE61DC185;
	Fri, 13 Dec 2024 11:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UHtj2f3e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A393D1DB527
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 11:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734088289; cv=none; b=KJTQ0tf8umHjy1RM3o69XFR/XmEs/8ZUse/rafI7D0JQihU4db7yhXZvNPzV5ciedwD9sgxlO8QIbFaoQpMLrcyFK3OGmFWuJS2xyPB2W4GaJq0XPshb+so+UpvLgRO6WHXXUxpZuCoEPzqN41+Z0AiK+0iQGyRn6E0BqK0zK4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734088289; c=relaxed/simple;
	bh=0e4wOYWTicbqzlQ0hDUngY1xZK1rDWPgmfcFK87bVCc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kKpll5fb1PV0NiHmc0aiIrlhxIvzUAPoyWUMgtwp4bmrZWu57rBJxMDiywNk458FLG+fopIozdBFXCEPcFfesX7rxXaRt1LyLh8gZGf4r6tKABk7KMWfXut39hME5vTUH8wOafVthplj/biHNulSs9vJk+HHr6YCxeIxVNheRm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=UHtj2f3e; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734088287; x=1765624287;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=85Qp5dvpXGydEeqOzdGX8+lR01R8IFzSJJNQIEc4cFI=;
  b=UHtj2f3eVVQbNT+0T+Ny3FcJlSPjcE6Kbd2kFFQrRGxMz8je+wro6dON
   txcuVQs3F7uxLKtx6LIz8BoW2ycb5fat1q3Xvx8/N1EF3cOCdK4/RTr17
   rUCm6F9+qCpIt7qO1hjMmLa00ysQ3XZ+wPJMnv/0YkwANbzHQGPM/8806
   4=;
X-IronPort-AV: E=Sophos;i="6.12,231,1728950400"; 
   d="scan'208";a="152794410"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 11:11:27 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:47309]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.194:2525] with esmtp (Farcaster)
 id adba2cf0-37cd-4bbe-b565-b2b6cbad45bc; Fri, 13 Dec 2024 11:11:26 +0000 (UTC)
X-Farcaster-Flow-ID: adba2cf0-37cd-4bbe-b565-b2b6cbad45bc
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 11:11:26 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.208) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 11:11:22 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 07/12] af_unix: Use msg->{msg_name,msg_namelen} in unix_dgram_sendmsg().
Date: Fri, 13 Dec 2024 20:08:45 +0900
Message-ID: <20241213110850.25453-8-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D032UWB002.ant.amazon.com (10.13.139.190) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

In unix_dgram_sendmsg(), we use a local variable sunaddr pointing
NULL or msg->msg_name based on msg->msg_namelen.

Let's remove sunaddr and simplify the usage.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 111f95384990..ae74fdcf5dcd 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1962,7 +1962,6 @@ static void scm_stat_del(struct sock *sk, struct sk_buff *skb)
 static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 			      size_t len)
 {
-	DECLARE_SOCKADDR(struct sockaddr_un *, sunaddr, msg->msg_name);
 	struct sock *sk = sock->sk, *other = NULL;
 	struct unix_sock *u = unix_sk(sk);
 	struct scm_cookie scm;
@@ -1984,7 +1983,7 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 	}
 
 	if (msg->msg_namelen) {
-		err = unix_validate_addr(sunaddr, msg->msg_namelen);
+		err = unix_validate_addr(msg->msg_name, msg->msg_namelen);
 		if (err)
 			goto out;
 
@@ -1995,7 +1994,6 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 		if (err)
 			goto out;
 	} else {
-		sunaddr = NULL;
 		other = unix_peer_get(sk);
 		if (!other) {
 			err = -ENOTCONN;
@@ -2046,8 +2044,8 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 
 restart:
 	if (!other) {
-		other = unix_find_other(sock_net(sk), sunaddr, msg->msg_namelen,
-					sk->sk_type);
+		other = unix_find_other(sock_net(sk), msg->msg_name,
+					msg->msg_namelen, sk->sk_type);
 		if (IS_ERR(other)) {
 			err = PTR_ERR(other);
 			other = NULL;
@@ -2101,7 +2099,7 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 		} else {
 			unix_state_unlock(sk);
 
-			if (!sunaddr)
+			if (!msg->msg_namelen)
 				err = -ECONNRESET;
 		}
 
-- 
2.39.5 (Apple Git-154)


