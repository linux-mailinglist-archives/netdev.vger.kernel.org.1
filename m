Return-Path: <netdev+bounces-151661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E57989F07D3
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 10:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D64F164BDE
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 09:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E451B0F16;
	Fri, 13 Dec 2024 09:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="k5LZi/zy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A171B0103
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 09:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734081935; cv=none; b=m9/XhugIsPwj73c+AFMzVznAqt2VB8PRaaOxPQbbTYAOmTV5kk5VNkhhmQrsnqUZOpJo+u6c/lDLoNiVEcuOeFoiZZs5U0b55fzkoueBgdMkufzyJCjOi4cNFFCi0XiLCOvT95Auq6W1W78M8v48vR86+zrAgRI7IKfSNyCldhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734081935; c=relaxed/simple;
	bh=Yk9IWGsvWErZ204zKZfmFTsvtmR/dShXWe1vcamhcI0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GWFiR+Xm5gF19ULBZ70vpBJEYTfPH1rziO8VwEr2yt8IqFQrqYtp5DKPqhQtoCBrK0yroqvHNWP24BM1T+xVsdxWTnUFgpMBTWtdWKp44fq1xon3d2RpwLhmwHZpoZrW3B5tR5U33PYrxLjOPuAulQnK3vRb4RGLZJHn0CEeq3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=k5LZi/zy; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734081934; x=1765617934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=flyS28w0wCgIZ66ImaF6NOpB6Chn7fS4mpoEMHspe4U=;
  b=k5LZi/zyJgYllCoe2Ivp5l2Jq9cgGQl22/L48gJV4py/YlfH1Y0et2Wv
   RamLb4DDCNaiw4IACphZGIr3mmS3j7Jr3nVOvpu2P4bt19KvGHO8JKr6V
   MEa0zRIuTQc4mTxY/+NXXhSbSnL8Ao2LiGnW2euUF8eqAWmi4tdGfxh2m
   8=;
X-IronPort-AV: E=Sophos;i="6.12,230,1728950400"; 
   d="scan'208";a="360482223"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 09:25:34 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:62919]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.119:2525] with esmtp (Farcaster)
 id e6acd3e9-6fae-454f-b1ec-dee801e829b8; Fri, 13 Dec 2024 09:25:33 +0000 (UTC)
X-Farcaster-Flow-ID: e6acd3e9-6fae-454f-b1ec-dee801e829b8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 09:25:32 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.208) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 09:25:29 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 10/15] socket: Introduce sock_create_net().
Date: Fri, 13 Dec 2024 18:21:47 +0900
Message-ID: <20241213092152.14057-11-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
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
index 11aa6d8c0cdd..9fb57afe6848 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2229,6 +2229,7 @@ struct sock *sk_alloc(struct net *net, int family, gfp_t priority,
 		sk->sk_kern_sock = kern;
 		sock_lock_init(sk);
 
+		DEBUG_NET_WARN_ON_ONCE(hold_net && !net_initialized(net));
 		sk->sk_net_refcnt = hold_net;
 		if (likely(sk->sk_net_refcnt)) {
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


