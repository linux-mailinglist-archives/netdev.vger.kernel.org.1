Return-Path: <netdev+bounces-149631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 811E59E6854
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 08:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F61016243B
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 07:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0491DE2DA;
	Fri,  6 Dec 2024 07:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bKxaH2EB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15251DDC1F
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 07:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733471944; cv=none; b=fLA75e7Igsjr+/v+2iqADSZGHeUJbwEz7m0QgYqRNiT/g8NmTj4FfBV8i6z8py2YOqE1vNXhkKPkJo0IGLztdcSGWuTl4/0PI5AOnEcLmrxUhJyLgyYgb8xiHzB/o7IYZ/8lEXa4FJRSxVv4NfEYo3MIjX1IV0CvUi9BWVS8YpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733471944; c=relaxed/simple;
	bh=s2Pb4ucv8sU4Xd6W/i/j3BSRKaIxj+3xbt8wCXtlr1E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bTZoNNMvLy75igoHDqO9w+xnUQrxnOxiHuPr8aeuKr/iP184QS7sXAeRQ70tQDegtzpsjol+zv/gy4VSEkr5xPqi9BclUf1v84WPUJrxKTEeCFP8v03jTBatZ05+R14J13wJW5WUH2NSPygNDvb8Aj4mmg9n0dwy/2eEybC0ROs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=bKxaH2EB; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733471942; x=1765007942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Awoa3iAEJ1cyxANA/dX1c2+xr46kBvuzyqBGYXZopNQ=;
  b=bKxaH2EBv5s51g9KEZuUGT3uZSwlJeFOM7rbfPmoeH9UD762fCP6UCuj
   ZxDaNK6M/LLY3RS5yW/eO3grzYItsxmBYWE/bcZLle9/Epdep+pLUPWCE
   yGxTrCxjfkM3NfqKBQC/NBCor1p7REUro1kzywFgqgEFqbRqZ0KfDV7R0
   0=;
X-IronPort-AV: E=Sophos;i="6.12,212,1728950400"; 
   d="scan'208";a="47151404"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 07:59:00 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:34582]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.181:2525] with esmtp (Farcaster)
 id 1e924181-e7e3-4c81-b488-c2aabccb2e42; Fri, 6 Dec 2024 07:59:00 +0000 (UTC)
X-Farcaster-Flow-ID: 1e924181-e7e3-4c81-b488-c2aabccb2e42
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 6 Dec 2024 07:59:00 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.244.93) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 6 Dec 2024 07:58:56 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 11/15] socket: Introduce sock_create_net().
Date: Fri, 6 Dec 2024 16:55:00 +0900
Message-ID: <20241206075504.24153-12-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D036UWB002.ant.amazon.com (10.13.139.139) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Let's add a new API to create a kernel socket with netns refcnt held.

We will remove the ugly kernel socket conversion in the next patch.

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
index a4a1c0394307..03ad6a179c35 100644
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
+ * userspace via a file descriptor nor BPF hooks (see inet_create(),
+ * inet_release(), etc).
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


