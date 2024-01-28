Return-Path: <netdev+bounces-66456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EC883F501
	for <lists+netdev@lfdr.de>; Sun, 28 Jan 2024 11:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9B4F1F21B9A
	for <lists+netdev@lfdr.de>; Sun, 28 Jan 2024 10:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6D61B286;
	Sun, 28 Jan 2024 10:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="barjVt8E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08CB1DDC5
	for <netdev@vger.kernel.org>; Sun, 28 Jan 2024 10:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706438298; cv=none; b=SRRYdlY+genzJiJAyKUxxNRllMbj1nsgQb/v4/LZnOFVdYQXRoTy/vhO80G6uONJ0qS+lEuu7BI7fvns/LtK2GKdW2d6Rfv00mBS3EaLKkCKxMvn1xhV+043Qx4Dc/btPQ5YKwM4YdAxums4RsDp+ukwHvdKcTLb57ptPNRXvHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706438298; c=relaxed/simple;
	bh=WSJjiK5hzrLzsCJekpt4qzqSSs5KEzAuNUY/7V7SNMc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZkgWpLLyEeMPSAw8ztrj0n2o4mT3oAHx9IopnQSufS+hVwLVtH1ctJne0z7wiRk2gjZkM7ySwHcicUj6T16Xtra2ZWbK9SZSp3BCkcBJ6zuc6l4J66zuvZUgROSTM8PZHPlPCr8241JWn1WTie1IBZst/zCsasuIk0x0Nip8H1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=barjVt8E; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706438298; x=1737974298;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cykjCL2Z3XqDMdtF6/WjSV/sbHfk7mMzzu6rj7pwtxw=;
  b=barjVt8E+Z0NXaS/zJ01bKTtuTmT9nbIHRckIYW16hriVJ14GXckn0O9
   M4+2pGL676puUEbTe3PFL+gELceQ6e6edcu2322fgobRIZWwxKarefSWI
   SzWL5ZgPqvkERggibxesaydmWlU5AwOcW1tw1DRmZDotRzXfDe5TU9GJ8
   k=;
X-IronPort-AV: E=Sophos;i="6.05,220,1701129600"; 
   d="scan'208";a="634028907"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-3554bfcf.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 10:38:15 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1e-m6i4x-3554bfcf.us-east-1.amazon.com (Postfix) with ESMTPS id 0279982B11;
	Sun, 28 Jan 2024 10:38:12 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:5508]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.136:2525] with esmtp (Farcaster)
 id 3bdab98b-2921-420a-a9c9-227f5ff25bcf; Sun, 28 Jan 2024 10:38:11 +0000 (UTC)
X-Farcaster-Flow-ID: 3bdab98b-2921-420a-a9c9-227f5ff25bcf
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 28 Jan 2024 10:38:11 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 28 Jan 2024 10:38:08 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 1/2] af_unix: Set sk_peer_pid/sk_peer_cred locklessly for new socket.
Date: Sun, 28 Jan 2024 02:37:31 -0800
Message-ID: <20240128103732.18185-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240128103732.18185-1-kuniyu@amazon.com>
References: <20240128103732.18185-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB003.ant.amazon.com (10.13.139.135) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

init_peercred() is called in 3 places:

  1. socketpair() : both sockets
  2. connect()    : child socket
  3. listen()     : listening socket

The first two need not hold sk_peer_lock because no one can
touch the socket.

Let's set cred/pid without holding lock for the two cases and
rename the old init_peercred() to update_peercred() to properly
reflect the use case.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 1720419d93d6..f07374d31f7c 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -684,6 +684,12 @@ static void unix_release_sock(struct sock *sk, int embrion)
 }
 
 static void init_peercred(struct sock *sk)
+{
+	sk->sk_peer_pid = get_pid(task_tgid(current));
+	sk->sk_peer_cred = get_current_cred();
+}
+
+static void update_peercred(struct sock *sk)
 {
 	const struct cred *old_cred;
 	struct pid *old_pid;
@@ -691,8 +697,7 @@ static void init_peercred(struct sock *sk)
 	spin_lock(&sk->sk_peer_lock);
 	old_pid = sk->sk_peer_pid;
 	old_cred = sk->sk_peer_cred;
-	sk->sk_peer_pid  = get_pid(task_tgid(current));
-	sk->sk_peer_cred = get_current_cred();
+	init_peercred(sk);
 	spin_unlock(&sk->sk_peer_lock);
 
 	put_pid(old_pid);
@@ -743,7 +748,7 @@ static int unix_listen(struct socket *sock, int backlog)
 	sk->sk_max_ack_backlog	= backlog;
 	sk->sk_state		= TCP_LISTEN;
 	/* set credentials so connect can copy them */
-	init_peercred(sk);
+	update_peercred(sk);
 	err = 0;
 
 out_unlock:
-- 
2.30.2


