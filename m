Return-Path: <netdev+bounces-149599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 696789E66DE
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 06:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FE50169C38
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 05:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44354196C67;
	Fri,  6 Dec 2024 05:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="PJYzAih4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8515C193426
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 05:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733462969; cv=none; b=OKOPbV1MdINqgbKGAsla+0LzYKhPT2qiTyZWeE6/Sln5UC3IbPQhG/wZRBFQNPsCKTLvRYSFB4+xwHfjBYzJnLyXUZ9uHHOMihm52rTD4DVNVTZhREidW0j69Huo4m2zmnRTDBHthrOP40F7mK81xDkWPs1//v/zYrL/XkoJ3gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733462969; c=relaxed/simple;
	bh=VP0zX4yPppGyhiCaEmxUXP77+PhOdJvQlNnjwxgYr/Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FTvKJdBXL5MAluMUjDRDyyq4uJi9B9FrVu4J8QZ7VRml3nziPmPdeJ95uxWA5SvwCIL/IBdiQbun8Fth4HbHqwzyXf6kcQ1CYbGuJ/kDW59nZWZgjrGw8ZcsnAwEpKS/+NXPqQ6O4qkp5Bp0Ub4SNoKcMm9ioeV8AoZ5JNJVaMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=PJYzAih4; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733462969; x=1764998969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rB+U3o42a+NJmjgqmAglvPQ+OaYpigARU0V28firIGo=;
  b=PJYzAih4oxjZqujbcXoKNbD90vMKw7bPNp4i2tU5f9XfU8WWS185AfjR
   5AKciijNjfE0jDJjfZyM6bqTDP7sHdvLVnlyvye+MBrgmWv+fPM7mPwJI
   /IxRYbzDSskozcE93Aahlzx2KLhSdfj7k6fMpfD7Ms/nj7mc9R3ToNYd1
   Y=;
X-IronPort-AV: E=Sophos;i="6.12,212,1728950400"; 
   d="scan'208";a="448638625"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 05:29:27 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:59299]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.101:2525] with esmtp (Farcaster)
 id 73b7bca6-b005-44f5-824c-876644fc6c59; Fri, 6 Dec 2024 05:29:25 +0000 (UTC)
X-Farcaster-Flow-ID: 73b7bca6-b005-44f5-824c-876644fc6c59
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 6 Dec 2024 05:29:24 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.244.93) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 6 Dec 2024 05:29:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 09/15] af_unix: Use msg->{msg_name,msg_namelen} in unix_dgram_sendmsg().
Date: Fri, 6 Dec 2024 14:26:01 +0900
Message-ID: <20241206052607.1197-10-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D043UWA003.ant.amazon.com (10.13.139.31) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

In unix_dgram_sendmsg(), we use a local variable sunaddr pointing
NULL or msg->msg_name based on msg->msg_namelen.

Let's remove sunaddr and simplify the usage.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 0f39fe3451e0..fdcd33b4e0ce 100644
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
 
@@ -2003,7 +2002,6 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 				goto out;
 		}
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


