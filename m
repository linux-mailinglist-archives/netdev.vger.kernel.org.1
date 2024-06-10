Return-Path: <netdev+bounces-102378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1075902BD1
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 00:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DAA8B210A7
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 22:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1103615099D;
	Mon, 10 Jun 2024 22:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="N45hPTyS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA825466B
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 22:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718059138; cv=none; b=sk9m3HgoSIMAGYOFRm5ZAgze/4XtuXTj32cF2SnHPXjgMVAElosLfSMAq5E/bKqdXRPZwuVD2IfNNCPUXu5Tq8mK4VPMJwIEmR/Z7SvN5HJWunYR1bnfWE3tTzqY70dpXfso/zS7f1bGFFxwibP01RA3/c+UVzBsSsDfUOom/OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718059138; c=relaxed/simple;
	bh=JK8bQR/K89hB3kFvmkk5k7FnDK7AGnxjQ8JjJDP/mj0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d4EEJbR4Ay/civpz8PGJbz6ibKcNHlMmP9RCRmQe3XOE2aemn7UjDa7A8RMNMaoKroaDO0A58a2HYLN3B5WcH15Ea3plnmqX7Ze+yyLloZ659avy7KLGVL7u6npWkvKXgl6vjSIjKH51+rPLFAUFFlRQ7dkRgXDTsO7jUiB7+WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=N45hPTyS; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718059136; x=1749595136;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vQK+x0QjWunU3J6ihfzJjs+4tfL4DIzimRP6vPMV2Bo=;
  b=N45hPTyS0c10eOk30lkAmNxFW5yb7RQ5TT19Ndi6BTEwMgTIL0M9NJVz
   Sygh4HdX8oEoMZdvL7gRgXkWnN/CY7FrppXrY7pJM99IjLHBCLjR/36bw
   +g5GIm9TsXRo5Vuj3D8Oy1flqP3lIvJ217PtoQONrwPL1y43U1tyBTEUh
   w=;
X-IronPort-AV: E=Sophos;i="6.08,228,1712620800"; 
   d="scan'208";a="732580889"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 22:38:56 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:60069]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.183:2525] with esmtp (Farcaster)
 id 53175f42-7bb7-47f3-b3fd-42042a5f85dd; Mon, 10 Jun 2024 22:38:55 +0000 (UTC)
X-Farcaster-Flow-ID: 53175f42-7bb7-47f3-b3fd-42042a5f85dd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 10 Jun 2024 22:38:55 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 10 Jun 2024 22:38:52 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 09/11] af_unix: Set sk_peer_pid/sk_peer_cred locklessly for new socket.
Date: Mon, 10 Jun 2024 15:34:59 -0700
Message-ID: <20240610223501.73191-10-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240610223501.73191-1-kuniyu@amazon.com>
References: <20240610223501.73191-1-kuniyu@amazon.com>
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
index 1869830e8d60..9070e3d67736 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -733,6 +733,12 @@ static void unix_release_sock(struct sock *sk, int embrion)
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
@@ -740,8 +746,7 @@ static void init_peercred(struct sock *sk)
 	spin_lock(&sk->sk_peer_lock);
 	old_pid = sk->sk_peer_pid;
 	old_cred = sk->sk_peer_cred;
-	sk->sk_peer_pid  = get_pid(task_tgid(current));
-	sk->sk_peer_cred = get_current_cred();
+	init_peercred(sk);
 	spin_unlock(&sk->sk_peer_lock);
 
 	put_pid(old_pid);
@@ -793,7 +798,7 @@ static int unix_listen(struct socket *sock, int backlog)
 	WRITE_ONCE(sk->sk_state, TCP_LISTEN);
 
 	/* set credentials so connect can copy them */
-	init_peercred(sk);
+	update_peercred(sk);
 	err = 0;
 
 out_unlock:
-- 
2.30.2


