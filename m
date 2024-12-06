Return-Path: <netdev+bounces-149597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE299E66DC
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 06:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC9EA1882C4F
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 05:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3EF19644B;
	Fri,  6 Dec 2024 05:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="M1oP9fU3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049E31953BA
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 05:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733462930; cv=none; b=Jf5TCnIUqSSUmiahodW8Qyg+jIG0oSK+JxeS747HtoKdx0uPUqF0zjNqFZkw22J4Ky6SuiEuO1V4b4c+XLUx1u19/xZ5C33Grgsu7d014CD6f4L/rPwpyp+SE1f/KcF0OVFwycHmTztiqp6qFfv9fik1s56ACC0KZZcYHc7xwf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733462930; c=relaxed/simple;
	bh=Z31SgbV+XlcCikJ/UOFh8U7d+uu502Ki9toBfvqN0IY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QQYVuBo2GJOldPmRGPTvIxdNpLGMPw1ff91SboZO4yjZeN2HqIGq2E25gaH2V7cqkf6ekRHBY9X34Ett4JoJPXNbi6qsN7hPAuNeJxeZknrybknDoLVLUuAmgVM7tIKvvo2eImCxSugh48dQ7jpD9DUFndkH9u6AMxGBO4Z6N4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=M1oP9fU3; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733462928; x=1764998928;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XCcKa2RwVaOXFwDHZ+nFSdLTRcD/gsJiNK9fNVeSnz0=;
  b=M1oP9fU3pc7O4D9EkLf189rDw+1zNFmwxCjQUPa5VdrIikySMNC6lx0D
   RKLcqJlmrMoIYE3jHH9Xs+WV7Qt7XkeacaIIJtI8mfLzYXifJtzv6o3i5
   papSPlfIeaxO+pdHztnJmded0ALKWUnHn2HdnwZlFgg5TFssTA+C8ADdc
   0=;
X-IronPort-AV: E=Sophos;i="6.12,212,1728950400"; 
   d="scan'208";a="700846383"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 05:28:45 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:32170]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.230:2525] with esmtp (Farcaster)
 id 9d740ff9-8273-4ee5-8e41-84de79cf4d7f; Fri, 6 Dec 2024 05:28:45 +0000 (UTC)
X-Farcaster-Flow-ID: 9d740ff9-8273-4ee5-8e41-84de79cf4d7f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 6 Dec 2024 05:28:43 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.244.93) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 6 Dec 2024 05:28:39 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 07/15] af_unix: Call unix_autobind() only when msg_namelen is specified in unix_dgram_sendmsg().
Date: Fri, 6 Dec 2024 14:25:59 +0900
Message-ID: <20241206052607.1197-8-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

If unix_peer_get() returns non-NULL in unix_dgram_sendmsg(), the socket
have been already bound in unix_dgram_connect() or unix_bind().

Let's not call unix_autobind() in such a case in unix_dgram_sendmsg().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index e439829efc56..6fb1811da4cd 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1994,6 +1994,14 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 							    NULL);
 		if (err)
 			goto out;
+
+		if ((test_bit(SOCK_PASSCRED, &sock->flags) ||
+		     test_bit(SOCK_PASSPIDFD, &sock->flags)) &&
+		    !READ_ONCE(u->addr)) {
+			err = unix_autobind(sk);
+			if (err)
+				goto out;
+		}
 	} else {
 		sunaddr = NULL;
 		other = unix_peer_get(sk);
@@ -2003,14 +2011,6 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 		}
 	}
 
-	if ((test_bit(SOCK_PASSCRED, &sock->flags) ||
-	     test_bit(SOCK_PASSPIDFD, &sock->flags)) &&
-	    !READ_ONCE(u->addr)) {
-		err = unix_autobind(sk);
-		if (err)
-			goto out;
-	}
-
 	if (len > READ_ONCE(sk->sk_sndbuf) - 32) {
 		err = -EMSGSIZE;
 		goto out;
-- 
2.39.5 (Apple Git-154)


