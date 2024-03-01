Return-Path: <netdev+bounces-76404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED0086D9B3
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 03:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B41F280126
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 02:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1033A3A8CB;
	Fri,  1 Mar 2024 02:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KTxvpAfS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D10E3A1A2
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 02:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709259960; cv=none; b=a4968M0LJsfx/Xw3bo4KF5PLWrilcIECmSxZMrMw8SRDa8jlo7BizANI22V9Q9SlVXYEcumUV8n3kKbjiF3lFi6ATWAmCQfxhe9DqH2AlL1hPqmDAuXwkDuMOmn2ytMfRHv4u0ZlI6bMEmsImc3MAOJOKrJC5GXbdzUwxGaGrSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709259960; c=relaxed/simple;
	bh=RZWS7glsf3FVPy/SJ7WMtTihIZZowfEc/e54NcYbMfY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SdGTn/lO0qRvRdZaiNdw0ngAUqMVW7SuvTS3GLso0p09LdqaQDrLR97aPGdarznbz4QCGaDVx0PMrOe6y74QDxXR+pV9EiaNeavvaGjAVcLwSwBB/DnyEMUnkMtP7HkAVbESga0VN0vVPxaub/QwwAz+EpB0bYvOkBajp3Nxmb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=KTxvpAfS; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1709259959; x=1740795959;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RClNWoP4mmxHjeK91vF3Qzm5FnqmxwlH+sv+IDMvaUA=;
  b=KTxvpAfS6i8VnppEB1kzuBO+ktGi3yjwmX2s92qxPTI71DYO+gAxjPCT
   BEjJCJ0CSqVGQ/+tE1jfQG0qDY1pp4jv/bNNRM1GKVrQoOt1NJp92ecbk
   ziyExMczOwDEDosaGKhIAOKp9fQ8OfgAMYxvniX+zy1fJnftjggqr06rR
   E=;
X-IronPort-AV: E=Sophos;i="6.06,194,1705363200"; 
   d="scan'208";a="188440096"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 02:25:56 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:61149]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.64:2525] with esmtp (Farcaster)
 id 73494b78-0841-46b3-ab00-d6eac3c11431; Fri, 1 Mar 2024 02:25:55 +0000 (UTC)
X-Farcaster-Flow-ID: 73494b78-0841-46b3-ab00-d6eac3c11431
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 1 Mar 2024 02:25:54 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Fri, 1 Mar 2024 02:25:51 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v4 net-next 07/15] af_unix: Save listener for embryo socket.
Date: Thu, 29 Feb 2024 18:22:35 -0800
Message-ID: <20240301022243.73908-8-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240301022243.73908-1-kuniyu@amazon.com>
References: <20240301022243.73908-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC001.ant.amazon.com (10.13.139.233) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

This is a prep patch for the following change, where we need to
fetch the listening socket from the successor embryo socket
during GC.

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
index 67736767b616..dc7469191195 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -83,6 +83,7 @@ struct unix_sock {
 	struct path		path;
 	struct mutex		iolock, bindlock;
 	struct sock		*peer;
+	struct sock		*listener;
 	struct unix_vertex	*vertex;
 	struct list_head	link;
 	unsigned long		inflight;
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 24adbc4d5188..af74e7ebc35a 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -979,6 +979,7 @@ static struct sock *unix_create1(struct net *net, struct socket *sock, int kern,
 	sk->sk_max_ack_backlog	= net->unx.sysctl_max_dgram_qlen;
 	sk->sk_destruct		= unix_sock_destructor;
 	u = unix_sk(sk);
+	u->listener = NULL;
 	u->inflight = 0;
 	u->vertex = NULL;
 	u->path.dentry = NULL;
@@ -1598,6 +1599,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	newsk->sk_type		= sk->sk_type;
 	init_peercred(newsk);
 	newu = unix_sk(newsk);
+	newu->listener = other;
 	RCU_INIT_POINTER(newsk->sk_wq, &newu->peer_wq);
 	otheru = unix_sk(other);
 
@@ -1693,8 +1695,8 @@ static int unix_accept(struct socket *sock, struct socket *newsock, int flags,
 		       bool kern)
 {
 	struct sock *sk = sock->sk;
-	struct sock *tsk;
 	struct sk_buff *skb;
+	struct sock *tsk;
 	int err;
 
 	err = -EOPNOTSUPP;
@@ -1719,6 +1721,7 @@ static int unix_accept(struct socket *sock, struct socket *newsock, int flags,
 	}
 
 	tsk = skb->sk;
+	unix_sk(tsk)->listener = NULL;
 	skb_free_datagram(sk, skb);
 	wake_up_interruptible(&unix_sk(sk)->peer_wait);
 
-- 
2.30.2


