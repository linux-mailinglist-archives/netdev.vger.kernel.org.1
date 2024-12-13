Return-Path: <netdev+bounces-151656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A31B9F07C5
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 10:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BF162810D8
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 09:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691BC1B0F20;
	Fri, 13 Dec 2024 09:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Mil2ea3v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F7D1AB6DD
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 09:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734081832; cv=none; b=BqpEePhKEE+FVeqhxoj+y1reYdBr5F1tBAnMQR1ZLIBFy+EVJ7TgnFpm4E4f+fKxD65RmbgHJwsBqDbDKRDhZqHmnfEgGbrlRTwqDCvHE1Rjque9dFVuTMocHvPchx2Kea13Nb9n9PDM96043nd341+ClxQP9tldudf0CsCaUVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734081832; c=relaxed/simple;
	bh=eaVkSfu8BwMoKQRK4a1hxZvFoNn0xIZUfhNVGQqXHsA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NVI90AaOjRsymkgRUPiz6EdMA7M1d3SAe2fvz4PjhAIzasn9mORSFPDRGwDqXDUEtmImer4uYHkst2PuwNtAxmmwJMvErTvxyew+jRPjAKReAXhwz4etsy/f8kbdP5COoTKe4So+UeDDR3KkOYj2uuaIkkjja0wqRFPA9Dnf/OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Mil2ea3v; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734081830; x=1765617830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IgYP1pSzO0yPRRAorTmY+8uA5xekeY2AQAu14aHQEAc=;
  b=Mil2ea3vkau6Q3gMAJzad4ngC/ASWxQmnjBcfC1hbAW/X7pl7XFP6XTQ
   82dILerE9Waz7XSryoI255ey5G8Iby7IU91yhomC+AtI33BWh+H0HEPCM
   mR7Fkmf5nLxYrIb4IGjdN7J/jZ982fNG1R+tOAxYTsq7kdjlce+6fJFb2
   I=;
X-IronPort-AV: E=Sophos;i="6.12,230,1728950400"; 
   d="scan'208";a="445545819"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 09:23:48 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:8720]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.231:2525] with esmtp (Farcaster)
 id c753080a-a928-45af-bb34-625f519bf602; Fri, 13 Dec 2024 09:23:47 +0000 (UTC)
X-Farcaster-Flow-ID: c753080a-a928-45af-bb34-625f519bf602
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 09:23:47 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.208) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 09:23:43 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 05/15] ppp: Pass hold_net to struct pppox_proto.create().
Date: Fri, 13 Dec 2024 18:21:42 +0900
Message-ID: <20241213092152.14057-6-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241213092152.14057-1-kuniyu@amazon.com>
References: <20241213092152.14057-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB003.ant.amazon.com (10.13.138.115) To
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


