Return-Path: <netdev+bounces-68760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98879847FC8
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 04:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 473A4284769
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 03:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428586FAE;
	Sat,  3 Feb 2024 03:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kUdPO2j/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DDC7460
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 03:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706929377; cv=none; b=I90yolYsAdYJ1F1DVx3JSrTsuoLlyzJJXBHue9lAaOHsOEm7XDHYGvYxE3MTL7AAVAZdDX+Y9+14Tkg1krXFDBcLxYjTfNmxLiQjrSzIspZ3UF5rkonUDhxrIYuTSWIZ269WEurTyOqfCRXA/sRl+WYkaKkBlnEceeh6ADniinI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706929377; c=relaxed/simple;
	bh=3cOyXxalYZfXXfAAGEyPpepjv5acwmCCJMaD/igmbE0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=THNHtGGvlawLc9yD5Tz5S6NJM+qncBC8AzOfBgJQ/quCc9ve+ty0nMrNFWC/N75oEX91/TUAL+PKWD0VskcueRtcMEke+7mIFbG2jlLFAjFlAY3imdLazOden2oPiI7bUSa6Z2PiBByTyyvGlm3pm/OUEKZRF7jquzoZjdLwdZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kUdPO2j/; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706929375; x=1738465375;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uH8GOAAPspibrtSxVvQld+qYWuHF/7YlSFjrEdy9XJI=;
  b=kUdPO2j/7VTHLOoO9Vyh3Ptj793WjrGJhnpiLlp3iyfKo01/Y0Kdy7do
   VJHoMwusxbEBiNm8EInIUJQeJPsJCdgxj8yeylaUK/9RIK4jHH9+X2n4k
   QG6kCHyRrPf40q6EIovxbf/8ixzSxmwLVYpn0pRgVE4U5ERrq7JvZ20lj
   k=;
X-IronPort-AV: E=Sophos;i="6.05,238,1701129600"; 
   d="scan'208";a="63412793"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 03:02:53 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:22604]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.186:2525] with esmtp (Farcaster)
 id 03c56abd-54e6-468d-91f1-a58f469eef69; Sat, 3 Feb 2024 03:02:53 +0000 (UTC)
X-Farcaster-Flow-ID: 03c56abd-54e6-468d-91f1-a58f469eef69
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 3 Feb 2024 03:02:53 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 3 Feb 2024 03:02:50 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 04/16] af_unix: Save listener for embryo socket.
Date: Fri, 2 Feb 2024 19:00:46 -0800
Message-ID: <20240203030058.60750-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240203030058.60750-1-kuniyu@amazon.com>
References: <20240203030058.60750-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC002.ant.amazon.com (10.13.139.238) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

This is a prep patch for the following change, where we need to
fetch the listening socket from an embryo socket in sendmsg().

We add a new field to struct unix_sock to save a pointer to a
listening socket.

We set it when connect() creates a new socket, and clear it when
accept() is called.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/af_unix.h | 1 +
 net/unix/af_unix.c    | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 54d62467a70b..438d2a18ba2e 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -79,6 +79,7 @@ struct unix_sock {
 	struct path		path;
 	struct mutex		iolock, bindlock;
 	struct sock		*peer;
+	struct sock		*listener;
 	struct unix_vertex	vertex;
 	struct list_head	link;
 	unsigned long		inflight;
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index ea7bac18a781..1ebc3c15f972 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -992,6 +992,7 @@ static struct sock *unix_create1(struct net *net, struct socket *sock, int kern,
 	sk->sk_max_ack_backlog	= net->unx.sysctl_max_dgram_qlen;
 	sk->sk_destruct		= unix_sock_destructor;
 	u = unix_sk(sk);
+	u->listener = NULL;
 	u->inflight = 0;
 	u->path.dentry = NULL;
 	u->path.mnt = NULL;
@@ -1611,6 +1612,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	newsk->sk_type		= sk->sk_type;
 	init_peercred(newsk);
 	newu = unix_sk(newsk);
+	newu->listener = other;
 	RCU_INIT_POINTER(newsk->sk_wq, &newu->peer_wq);
 	otheru = unix_sk(other);
 
@@ -1706,8 +1708,8 @@ static int unix_accept(struct socket *sock, struct socket *newsock, int flags,
 		       bool kern)
 {
 	struct sock *sk = sock->sk;
-	struct sock *tsk;
 	struct sk_buff *skb;
+	struct sock *tsk;
 	int err;
 
 	err = -EOPNOTSUPP;
@@ -1732,6 +1734,7 @@ static int unix_accept(struct socket *sock, struct socket *newsock, int flags,
 	}
 
 	tsk = skb->sk;
+	unix_sk(tsk)->listener = NULL;
 	skb_free_datagram(sk, skb);
 	wake_up_interruptible(&unix_sk(sk)->peer_wait);
 
-- 
2.30.2


