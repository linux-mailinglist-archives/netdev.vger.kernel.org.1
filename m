Return-Path: <netdev+bounces-150544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457669EA9C8
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 08:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F23A1684CC
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 07:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FA1228389;
	Tue, 10 Dec 2024 07:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BO5Vigbl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBA5227560
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 07:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733816452; cv=none; b=N1GeHMSb7axbMRZ0KAkIBRIcym+fgD/XaTYmZZ2KdIVdtRgXN0i0YBu7EL2KVd1ufGUEaQSP8LhCaDhqSQwIbIsfgcJtM+Ieu1wZoUjAJG990G0tM3Bfdt05BhjTKQoUENTVXilGm5h88XSbT2JVU4z3nbGf/3uU3n5ebUsptG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733816452; c=relaxed/simple;
	bh=phPe+Cc8+QpKHb57YzMkHVCN/O1UawmnwQqW2Xj1OsM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k0fr1Nt+j5ZXEhiuiso3GepFaKN/pZGnbQwecbwaB/gnYy6lr1D1zxBoUMeP7K85V8Oj9SFoznShuyW0AbIrcVxwi+W3lqCsdDd3w77p4ZR2xZ7QZVqN2cfwlUIK21I+MZqFYoBSLCBkdW/mh/rfFVs8aYSazyMKJ6zGZk7lVwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BO5Vigbl; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733816452; x=1765352452;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4TKbqshIPKl/2Y+gyyNXv1gN0Rd9DpYuNeCS2Zhejz8=;
  b=BO5VigblUQ05M8TsczQievhyftAeio/cJzFMDBDGIvO9GQYLiNlIBK3x
   Yn4csRqS1L/eyKbEW8OnvznmpRRI/EHXDqf0uEfqpYYrXwEc5T4It/Yk9
   sS1MlhM/fee/8Jzp9oCyNNX73hPr/rQe81VBbyC7nfcqRi5wmUmf/aNdj
   M=;
X-IronPort-AV: E=Sophos;i="6.12,221,1728950400"; 
   d="scan'208";a="454699294"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 07:40:48 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:6700]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.104:2525] with esmtp (Farcaster)
 id 764804c4-6648-4660-9fc2-8cf39d01a4b2; Tue, 10 Dec 2024 07:40:46 +0000 (UTC)
X-Farcaster-Flow-ID: 764804c4-6648-4660-9fc2-8cf39d01a4b2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Dec 2024 07:40:46 +0000
Received: from 6c7e67c6786f.amazon.com (10.143.88.19) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 10 Dec 2024 07:40:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 06/15] nfc: Pass hold_net to struct nfc_protocol.create().
Date: Tue, 10 Dec 2024 16:38:20 +0900
Message-ID: <20241210073829.62520-7-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241210073829.62520-1-kuniyu@amazon.com>
References: <20241210073829.62520-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB004.ant.amazon.com (10.13.139.177) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will introduce a new API to create a kernel socket with netns refcnt
held.  Then, sk_alloc() need the hold_net flag passed to nfc_sock_create().

Let's pass it down to struct nfc_protocol.create() and functions that call
sk_alloc().

While at it, we convert the kern flag to boolean.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/nfc/af_nfc.c    | 3 ++-
 net/nfc/llcp.h      | 3 ++-
 net/nfc/llcp_core.c | 3 ++-
 net/nfc/llcp_sock.c | 8 +++++---
 net/nfc/nfc.h       | 3 ++-
 net/nfc/rawsock.c   | 3 ++-
 6 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/net/nfc/af_nfc.c b/net/nfc/af_nfc.c
index 4fb1c86fcc81..6cdeeccd15bc 100644
--- a/net/nfc/af_nfc.c
+++ b/net/nfc/af_nfc.c
@@ -28,7 +28,8 @@ static int nfc_sock_create(struct net *net, struct socket *sock, int proto,
 
 	read_lock(&proto_tab_lock);
 	if (proto_tab[proto] &&	try_module_get(proto_tab[proto]->owner)) {
-		rc = proto_tab[proto]->create(net, sock, proto_tab[proto], kern);
+		rc = proto_tab[proto]->create(net, sock, proto_tab[proto],
+					      kern, hold_net);
 		module_put(proto_tab[proto]->owner);
 	}
 	read_unlock(&proto_tab_lock);
diff --git a/net/nfc/llcp.h b/net/nfc/llcp.h
index d8345ed57c95..b9d539358e65 100644
--- a/net/nfc/llcp.h
+++ b/net/nfc/llcp.h
@@ -211,7 +211,8 @@ void nfc_llcp_send_to_raw_sock(struct nfc_llcp_local *local,
 			       struct sk_buff *skb, u8 direction);
 
 /* Sock API */
-struct sock *nfc_llcp_sock_alloc(struct socket *sock, int type, gfp_t gfp, int kern);
+struct sock *nfc_llcp_sock_alloc(struct socket *sock, int type, gfp_t gfp,
+				 bool kern, bool hold_net);
 void nfc_llcp_sock_free(struct nfc_llcp_sock *sock);
 void nfc_llcp_accept_unlink(struct sock *sk);
 void nfc_llcp_accept_enqueue(struct sock *parent, struct sock *sk);
diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 18be13fb9b75..96d8df013bda 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -965,7 +965,8 @@ static void nfc_llcp_recv_connect(struct nfc_llcp_local *local,
 		sock->ssap = ssap;
 	}
 
-	new_sk = nfc_llcp_sock_alloc(NULL, parent->sk_type, GFP_ATOMIC, 0);
+	new_sk = nfc_llcp_sock_alloc(NULL, parent->sk_type, GFP_ATOMIC,
+				     false, true);
 	if (new_sk == NULL) {
 		reason = LLCP_DM_REJ;
 		release_sock(&sock->sk);
diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 57a2f97004e1..14f592becce0 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -971,7 +971,8 @@ static void llcp_sock_destruct(struct sock *sk)
 	}
 }
 
-struct sock *nfc_llcp_sock_alloc(struct socket *sock, int type, gfp_t gfp, int kern)
+struct sock *nfc_llcp_sock_alloc(struct socket *sock, int type, gfp_t gfp,
+				 bool kern, bool hold_net)
 {
 	struct sock *sk;
 	struct nfc_llcp_sock *llcp_sock;
@@ -1022,7 +1023,8 @@ void nfc_llcp_sock_free(struct nfc_llcp_sock *sock)
 }
 
 static int llcp_sock_create(struct net *net, struct socket *sock,
-			    const struct nfc_protocol *nfc_proto, int kern)
+			    const struct nfc_protocol *nfc_proto,
+			    bool kern, bool hold_net)
 {
 	struct sock *sk;
 
@@ -1041,7 +1043,7 @@ static int llcp_sock_create(struct net *net, struct socket *sock,
 		sock->ops = &llcp_sock_ops;
 	}
 
-	sk = nfc_llcp_sock_alloc(sock, sock->type, GFP_ATOMIC, kern);
+	sk = nfc_llcp_sock_alloc(sock, sock->type, GFP_ATOMIC, kern, hold_net);
 	if (sk == NULL)
 		return -ENOMEM;
 
diff --git a/net/nfc/nfc.h b/net/nfc/nfc.h
index 0b1e6466f4fb..6dac305a32d3 100644
--- a/net/nfc/nfc.h
+++ b/net/nfc/nfc.h
@@ -21,7 +21,8 @@ struct nfc_protocol {
 	struct proto *proto;
 	struct module *owner;
 	int (*create)(struct net *net, struct socket *sock,
-		      const struct nfc_protocol *nfc_proto, int kern);
+		      const struct nfc_protocol *nfc_proto,
+		      bool kern, bool hold_net);
 };
 
 struct nfc_rawsock {
diff --git a/net/nfc/rawsock.c b/net/nfc/rawsock.c
index 5125392bb68e..4485b1ccb1c7 100644
--- a/net/nfc/rawsock.c
+++ b/net/nfc/rawsock.c
@@ -321,7 +321,8 @@ static void rawsock_destruct(struct sock *sk)
 }
 
 static int rawsock_create(struct net *net, struct socket *sock,
-			  const struct nfc_protocol *nfc_proto, int kern)
+			  const struct nfc_protocol *nfc_proto,
+			  bool kern, bool hold_net)
 {
 	struct sock *sk;
 
-- 
2.39.5 (Apple Git-154)


