Return-Path: <netdev+bounces-103724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B19C909338
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 22:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05340B25235
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 20:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B6F1A3BA1;
	Fri, 14 Jun 2024 20:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dHyn3iay"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54281A2549
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 20:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718395882; cv=none; b=g87mG69+tkWIVyb9bR9biGb71EkMC6cs9LPVV+oYtBjzjuB9gvSuWNdkKGZgVJjFNP9LDgmqpCJ0TT4j9m6/I9R/HEqZzyTfqGhUMSp9lO1WWNF3TNdgHekf8mivJ4OAof5ntKRBSWvp4/tkoGpOJUIOX3w9Npl49Z22XLUuzkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718395882; c=relaxed/simple;
	bh=6rReseoN8Myeg0uFp9WimMgHv0Yb+PyLxpz8q+tekEw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V1B30udPSfY04OFGjEcQG8ouTVEg4js6EOrEzcSvDT8fcaFnOo39ogreCKnV0ePAAhFrbgEjBXn87qyYmSNXpSpYAN8/sbzhZ70P0JQibXFXKeQ70nMl2MQXwHUrWPWlCe3QUOsramarszd5QsUMu3rD7/bVLp7T/6/VdjBlhZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=dHyn3iay; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718395881; x=1749931881;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m2Sxbw3Bg/SPF+pHhibsFMP1QdrJkAPpT7IFGhnIU8I=;
  b=dHyn3iayQvtFYKU+e6MZvD0cgEqQ7dqS+6d6oBxZfR8rSyJolzH1YcYj
   lM7mfPnrQ4EFsOx02rtuSot+tkJWtesRkr0ZrMHcAtA1CsaNZRTezjSDM
   rET1zEA1jlGPyCuXZm1yCaJiCUzyvZtw6Gt/ciVajRXdBUtoktDIW622Z
   U=;
X-IronPort-AV: E=Sophos;i="6.08,238,1712620800"; 
   d="scan'208";a="5085118"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 20:11:19 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:42353]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.123:2525] with esmtp (Farcaster)
 id 424b248c-0376-4497-8911-b3a50c746203; Fri, 14 Jun 2024 20:11:17 +0000 (UTC)
X-Farcaster-Flow-ID: 424b248c-0376-4497-8911-b3a50c746203
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 14 Jun 2024 20:11:17 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 14 Jun 2024 20:11:14 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 09/11] af_unix: Set sk_peer_pid/sk_peer_cred locklessly for new socket.
Date: Fri, 14 Jun 2024 13:07:13 -0700
Message-ID: <20240614200715.93150-10-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240614200715.93150-1-kuniyu@amazon.com>
References: <20240614200715.93150-1-kuniyu@amazon.com>
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
index 9bbd112926ad..3c62fb4f3df5 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -738,6 +738,12 @@ static void unix_release_sock(struct sock *sk, int embrion)
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
@@ -745,8 +751,7 @@ static void init_peercred(struct sock *sk)
 	spin_lock(&sk->sk_peer_lock);
 	old_pid = sk->sk_peer_pid;
 	old_cred = sk->sk_peer_cred;
-	sk->sk_peer_pid  = get_pid(task_tgid(current));
-	sk->sk_peer_cred = get_current_cred();
+	init_peercred(sk);
 	spin_unlock(&sk->sk_peer_lock);
 
 	put_pid(old_pid);
@@ -798,7 +803,7 @@ static int unix_listen(struct socket *sock, int backlog)
 	WRITE_ONCE(sk->sk_state, TCP_LISTEN);
 
 	/* set credentials so connect can copy them */
-	init_peercred(sk);
+	update_peercred(sk);
 	err = 0;
 
 out_unlock:
-- 
2.30.2


