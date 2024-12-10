Return-Path: <netdev+bounces-150549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7E09EA9D0
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 08:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 802EF16A2ED
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 07:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D090322CBF3;
	Tue, 10 Dec 2024 07:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="JAHluUwp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3092722839A
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 07:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733816557; cv=none; b=K62YlC8ApqklitSwbPL6sxG9hXp6s34LrrfFosTjB2fESkqSyLcEwR8YTdfotrTj1Km7UM7k13E/SaTpNyHAuI1/ik1/fslFEfvWuGjzdyc85xP6vsy3NBFw2kDfCQzQy2NOy8a6O1hh3Y7tsvSSqew4agGWS04GpkUk8auCs9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733816557; c=relaxed/simple;
	bh=WFfs8v5nAelcOvyzgXrQPrpg17iFWaGm10g9vIuKlTQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hGxLWOj+GzkJmTXhs0kZdI/mO+2hYoNoCHCwi5DY48XsqmufKxk8q27tSIFix+qoyEYk7RbaA/1LEevtYeVT2MuZK9an6ffQecA2487uyOtBz4joIDcb4SAm7QjT+o+v5x+CvC+U7M5q20Po9qxwcpv4wF9rtevrEF8Ht2BV6JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=JAHluUwp; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733816557; x=1765352557;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WlwakYVlw/w1RaNtyGf05OQkpqi6z1CdMr9YexJsD/s=;
  b=JAHluUwpcCEy3aNfyClFyTKpeZZvHyzW2XRfQ22SnZ7JZyIs3EktjQNh
   aeQkmZMekyRqnZScDcVRB1LsrDHS6gjRg61x2K6L/0kUPCjwHxX+qLBMk
   jPKsrZfU9PEZDnqAfvd55MkwouSFZWkyNDBigket4ZNSgDLg6RbZQ4llx
   k=;
X-IronPort-AV: E=Sophos;i="6.12,221,1728950400"; 
   d="scan'208";a="476779304"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 07:42:32 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:8799]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.76:2525] with esmtp (Farcaster)
 id 00f8ed6c-f039-4122-bafa-038450514e78; Tue, 10 Dec 2024 07:42:30 +0000 (UTC)
X-Farcaster-Flow-ID: 00f8ed6c-f039-4122-bafa-038450514e78
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Dec 2024 07:42:30 +0000
Received: from 6c7e67c6786f.amazon.com (10.143.88.19) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 10 Dec 2024 07:42:26 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 11/15] socket: Introduce sock_create_net().
Date: Tue, 10 Dec 2024 16:38:25 +0900
Message-ID: <20241210073829.62520-12-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D041UWA002.ant.amazon.com (10.13.139.121) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Let's add a new API to create a kernel socket with netns refcnt held.

We will remove the ugly kernel socket conversion in the next patch.

DEBUG_NET_WARN_ON_ONCE() is to catch a path calling sock_create_net()
from __net_init functions, which leak netns.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/linux/net.h |  2 ++
 net/core/sock.c     |  1 +
 net/socket.c        | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/include/linux/net.h b/include/linux/net.h
index c2a35a102ee2..758c99af6cf4 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -252,6 +252,8 @@ int sock_register(const struct net_proto_family *fam);
 void sock_unregister(int family);
 bool sock_is_registered(int family);
 int sock_create(int family, int type, int proto, struct socket **res);
+int sock_create_net(struct net *net, int family, int type, int proto,
+		    struct socket **res);
 int sock_create_kern(struct net *net, int family, int type, int proto, struct socket **res);
 int sock_create_lite(int family, int type, int proto, struct socket **res);
 struct socket *sock_alloc(void);
diff --git a/net/core/sock.c b/net/core/sock.c
index 4041152c7024..d0902f89e301 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2232,6 +2232,7 @@ struct sock *sk_alloc(struct net *net, int family, gfp_t priority,
 
 		sock_lock_init(sk);
 
+		DEBUG_NET_WARN_ON_ONCE(hold_net && !net_initialized(net));
 		sk->sk_net_refcnt = hold_net;
 		if (likely(sk->sk_net_refcnt))
 			get_net_track(net, &sk->ns_tracker, priority);
diff --git a/net/socket.c b/net/socket.c
index a8796d7f06be..00ece8401b17 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1623,6 +1623,38 @@ int sock_create(int family, int type, int protocol, struct socket **res)
 }
 EXPORT_SYMBOL(sock_create);
 
+/**
+ * sock_create_net - creates a socket for kernel space
+ *
+ * @net: net namespace
+ * @family: protocol family (AF_INET, ...)
+ * @type: communication type (SOCK_STREAM, ...)
+ * @protocol: protocol (0, ...)
+ * @res: new socket
+ *
+ * Creates a new socket and assigns it to @res, passing through LSM.
+ *
+ * The socket is for kernel space and should not be exposed to
+ * userspace via a file descriptor nor BPF hooks except for LSM
+ * (see inet_create(), inet_release(), etc).
+ *
+ * The socket holds a reference count of @net so that the caller does
+ * not need to care about @net's lifetime.
+ *
+ * This MUST NOT be called from the __net_init path and @net MUST be
+ * alive as of calling sock_create_net().
+ *
+ * Context: Process context. This function internally uses GFP_KERNEL.
+ * Return: 0 or an error.
+ */
+
+int sock_create_net(struct net *net, int family, int type, int protocol,
+		    struct socket **res)
+{
+	return __sock_create(net, family, type, protocol, res, true, true);
+}
+EXPORT_SYMBOL(sock_create_net);
+
 /**
  *	sock_create_kern - creates a socket (kernel space)
  *	@net: net namespace
-- 
2.39.5 (Apple Git-154)


