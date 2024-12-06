Return-Path: <netdev+bounces-149625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5319F9E684C
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 08:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14BBC280E21
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 07:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279951DD88F;
	Fri,  6 Dec 2024 07:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HUyFB5Nd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0BA1DB363
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 07:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733471821; cv=none; b=mHBXkrFCHscNjoNWKdRQu15fWjV8oWBq7N/h4WEWZgM+9OqE6ghItRZ5fT7w19RcN/FQ19xV7+AHHivI98HX/N6Jh0DDeFalSIyQZy6nhJk7a0shwyO6uwrhxrAfMfsD4IABOCeX8iMvuTlq3yLRj8ZlzAFCgnuFCYtS4BN0B0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733471821; c=relaxed/simple;
	bh=eaVkSfu8BwMoKQRK4a1hxZvFoNn0xIZUfhNVGQqXHsA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uxHadOGgPOXct1g8+e9Ky64oRViIaeC1Bu38DX67IYU0Sie0N7OYTxZsJhFYrNoxLxPs0bbXCDEqkrldBNqYIj91IiWxpeJlNqkKnK8Db0I4dk2BnlDBoSLxnBx/BrKL5iNTEI3JP92WPBIYXLV9/xtjmGa6eXooU/IVjhZiNmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=HUyFB5Nd; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733471818; x=1765007818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IgYP1pSzO0yPRRAorTmY+8uA5xekeY2AQAu14aHQEAc=;
  b=HUyFB5NdhgdGlcm2JI+NV9fYjeXyT6MMIRvFVasFg1omezdgxUXi90fj
   FGHuPX6NqqEDvQ0AkcnIYkCP9CJZgx5GcLMzkQbQE8jep6bXzIXYCfZDK
   y3gTUcuPA+X7Xi3PwaNU2U11iXxFVvml8mnjbgxEb9vTFdp9+4b3QsoBT
   o=;
X-IronPort-AV: E=Sophos;i="6.12,212,1728950400"; 
   d="scan'208";a="47151118"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 07:56:57 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:8534]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.190:2525] with esmtp (Farcaster)
 id 9b9fe7fa-e021-49b7-a73e-2ac2c809b78a; Fri, 6 Dec 2024 07:56:57 +0000 (UTC)
X-Farcaster-Flow-ID: 9b9fe7fa-e021-49b7-a73e-2ac2c809b78a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 6 Dec 2024 07:56:56 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.244.93) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 6 Dec 2024 07:56:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 05/15] ppp: Pass hold_net to struct pppox_proto.create().
Date: Fri, 6 Dec 2024 16:54:54 +0900
Message-ID: <20241206075504.24153-6-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241206075504.24153-1-kuniyu@amazon.com>
References: <20241206075504.24153-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA001.ant.amazon.com (10.13.139.22) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will introduce a new API to create a kernel socket with netns refcnt
held.  Then, sk_alloc() need the hold_net flag passed to pppox_create().

Let's pass it down to struct pppox_proto.create().

While at it, we convert the kern flag to boolean.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 drivers/net/ppp/pppoe.c  | 3 ++-
 drivers/net/ppp/pppox.c  | 2 +-
 drivers/net/ppp/pptp.c   | 3 ++-
 include/linux/if_pppox.h | 3 ++-
 net/l2tp/l2tp_ppp.c      | 3 ++-
 5 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 2ea4f4890d23..90995f8a08a3 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -533,7 +533,8 @@ static struct proto pppoe_sk_proto __read_mostly = {
  * Initialize a new struct sock.
  *
  **********************************************************************/
-static int pppoe_create(struct net *net, struct socket *sock, int kern)
+static int pppoe_create(struct net *net, struct socket *sock,
+			bool kern, bool hold_net)
 {
 	struct sock *sk;
 
diff --git a/drivers/net/ppp/pppox.c b/drivers/net/ppp/pppox.c
index 53b3f790d1f5..823b1facac6f 100644
--- a/drivers/net/ppp/pppox.c
+++ b/drivers/net/ppp/pppox.c
@@ -126,7 +126,7 @@ static int pppox_create(struct net *net, struct socket *sock, int protocol,
 	    !try_module_get(pppox_protos[protocol]->owner))
 		goto out;
 
-	rc = pppox_protos[protocol]->create(net, sock, kern);
+	rc = pppox_protos[protocol]->create(net, sock, kern, hold_net);
 
 	module_put(pppox_protos[protocol]->owner);
 out:
diff --git a/drivers/net/ppp/pptp.c b/drivers/net/ppp/pptp.c
index 689687bd2574..7bfb5c227c40 100644
--- a/drivers/net/ppp/pptp.c
+++ b/drivers/net/ppp/pptp.c
@@ -538,7 +538,8 @@ static void pptp_sock_destruct(struct sock *sk)
 	dst_release(rcu_dereference_protected(sk->sk_dst_cache, 1));
 }
 
-static int pptp_create(struct net *net, struct socket *sock, int kern)
+static int pptp_create(struct net *net, struct socket *sock,
+		       bool kern, bool hold_net)
 {
 	int error = -ENOMEM;
 	struct sock *sk;
diff --git a/include/linux/if_pppox.h b/include/linux/if_pppox.h
index ff3beda1312c..a38047e308fd 100644
--- a/include/linux/if_pppox.h
+++ b/include/linux/if_pppox.h
@@ -68,7 +68,8 @@ static inline struct sock *sk_pppox(struct pppox_sock *po)
 struct module;
 
 struct pppox_proto {
-	int		(*create)(struct net *net, struct socket *sock, int kern);
+	int		(*create)(struct net *net, struct socket *sock,
+				  bool kern, bool hold_net);
 	int		(*ioctl)(struct socket *sock, unsigned int cmd,
 				 unsigned long arg);
 	struct module	*owner;
diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 53baf2dd5d5d..bab3c7b943db 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -477,7 +477,8 @@ static int pppol2tp_backlog_recv(struct sock *sk, struct sk_buff *skb)
 
 /* socket() handler. Initialize a new struct sock.
  */
-static int pppol2tp_create(struct net *net, struct socket *sock, int kern)
+static int pppol2tp_create(struct net *net, struct socket *sock,
+			   bool kern, bool hold_net)
 {
 	int error = -ENOMEM;
 	struct sock *sk;
-- 
2.39.5 (Apple Git-154)


