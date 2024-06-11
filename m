Return-Path: <netdev+bounces-102744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 925339046F7
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 00:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45B641F23441
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 22:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A851552E0;
	Tue, 11 Jun 2024 22:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LUGA+fHs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7923215444C
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 22:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718145185; cv=none; b=NgXm1/YiYiikQsVufXV95CQ1HTBV1R0j2cICALQXOc9AL94C6JPoAXpAcuCt4FlYDRAYixQDbqeEEChpdl8K3uWay8dUixacOukkrqekIC775Yo/As67Zi1CfeMXgS/rEEWA+I9CGBeWcl+xqvznwrifzUxCOdXhkQsKX09O8cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718145185; c=relaxed/simple;
	bh=6gRZVJZltI5pVXD+DPAujnMfoFJG3h2licI0XMMebaM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nPQ5wjf7Flfy01PIix6/EU19j/29jPLkErLWV+ykDfJVPnUkg/8HeHdJeYYmPNMskM01GaNqwlqyLjzz9En8PPSfrFTJVvwbZVSIieI2Z7OUOgqsgZfE1FDOreD8/HVg/+ORq3pzBJUGE0R+iINvEHkwnwjhgUqNeeTk4KaMrOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=LUGA+fHs; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718145184; x=1749681184;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AKeRTTnBJEKTS39Vux2KIeVAW+0nAL/FkS43Udq+3OI=;
  b=LUGA+fHsHrE8JkJR+frv+jUf96pnzIoXItnvXn+aTKM/1jv8ojc7ZRZT
   RTXCu+ohWPVsZ2pdprGZJPxq+kgka/029zickX0ICKnaZak9l3P8zkqZk
   HUIPlbh5nVvFzXAKuWn4bQGk7TJf2J9C241a/LHehuq1miHyzKcSY4Si7
   U=;
X-IronPort-AV: E=Sophos;i="6.08,231,1712620800"; 
   d="scan'208";a="349818078"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 22:32:57 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:30848]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.196:2525] with esmtp (Farcaster)
 id e75411fb-0558-4c8b-bbbb-866592da202c; Tue, 11 Jun 2024 22:32:57 +0000 (UTC)
X-Farcaster-Flow-ID: e75411fb-0558-4c8b-bbbb-866592da202c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 11 Jun 2024 22:32:56 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 11 Jun 2024 22:32:54 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 09/11] af_unix: Set sk_peer_pid/sk_peer_cred locklessly for new socket.
Date: Tue, 11 Jun 2024 15:29:03 -0700
Message-ID: <20240611222905.34695-10-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240611222905.34695-1-kuniyu@amazon.com>
References: <20240611222905.34695-1-kuniyu@amazon.com>
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
index 8959ee8753d1..6a73c5ad67ac 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -735,6 +735,12 @@ static void unix_release_sock(struct sock *sk, int embrion)
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
@@ -742,8 +748,7 @@ static void init_peercred(struct sock *sk)
 	spin_lock(&sk->sk_peer_lock);
 	old_pid = sk->sk_peer_pid;
 	old_cred = sk->sk_peer_cred;
-	sk->sk_peer_pid  = get_pid(task_tgid(current));
-	sk->sk_peer_cred = get_current_cred();
+	init_peercred(sk);
 	spin_unlock(&sk->sk_peer_lock);
 
 	put_pid(old_pid);
@@ -795,7 +800,7 @@ static int unix_listen(struct socket *sock, int backlog)
 	WRITE_ONCE(sk->sk_state, TCP_LISTEN);
 
 	/* set credentials so connect can copy them */
-	init_peercred(sk);
+	update_peercred(sk);
 	err = 0;
 
 out_unlock:
-- 
2.30.2


