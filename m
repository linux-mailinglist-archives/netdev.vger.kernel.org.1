Return-Path: <netdev+bounces-191269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CAEABA80B
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 05:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC18A2128D
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 03:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F31215B135;
	Sat, 17 May 2025 03:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="hGxAHMIQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941F0B665
	for <netdev@vger.kernel.org>; Sat, 17 May 2025 03:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747453973; cv=none; b=Sa4Kbrz5cmLQt5RCgjClK3Bem+EXDsHOicqOboidNx+NqzPBpCpR0Fih2c5V9h1sKJ1LGZwaqi2jnyqsJ5sXjxt4mjHIY5Nqjt/I0W5LmoeiCUi/PWpYgVvqt/tFSG0s2RtnGKxDaVMy6Ym1vXVJ+N5+CzcUO1IfEtWbHnLRVgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747453973; c=relaxed/simple;
	bh=inDll5gkEpJ5ZORTYyf+Sf30fUOsZGdYlUMghNaZnWQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WrYYLDbw1QcQEFdZpCCcYVPy+ZvD/XvNfmconp3MOlKbQZ9taczDZtpAg4uInW7s55FG3ahvwYnSRzGWoN2ilLSyBYbgaGIOPuL/6UXYNAQdl2YpZ6M81u7HdvR7Vu8rmUFPkpqSuPsmJo63/TLEXC6m2oCJNs2aqDq9aZU6nXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=hGxAHMIQ; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747453971; x=1778989971;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FN+WK0fImlx69CaRDwG1a6G3G8wJRiGFRsqVN9V0yks=;
  b=hGxAHMIQ/jfFUiDOm+0l17rz/J+RmEm0eh+WjoYdh1zyFX/0ye/qLGkr
   si1VhiWkrnMggMs4DSNApt0JtBJpmW7eymKQ8t7Fgwu5QbbKsz7XlnCcr
   U2UGK4J74gqRJjkKCZJherDs5DR+yN33kwOwO/naQP8LzNo/XTmUcv76J
   edBTQj2qu6aNpVDOqZkRGB5ySFNvfcX4FfE3ZGZRQr8pg+jqQTOYC5Vav
   R0MxHD0vsseHYIRg36Fzh9ynrr4w1aMbRtP1RcrmLmcddviKxY+HLgr18
   1+jQICvWrVSECX+pw97Dnu+NFv1Yz8QgIYE/Vb1ZlEOjcA4Eyl7hfnN65
   g==;
X-IronPort-AV: E=Sophos;i="6.15,295,1739836800"; 
   d="scan'208";a="20778436"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2025 03:52:46 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:13517]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.83:2525] with esmtp (Farcaster)
 id 01632d9a-485f-4e1a-936c-1735fdecf450; Sat, 17 May 2025 03:52:45 +0000 (UTC)
X-Farcaster-Flow-ID: 01632d9a-485f-4e1a-936c-1735fdecf450
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 17 May 2025 03:52:45 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.194.153) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 17 May 2025 03:52:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 3/6] socket: Restore sock_create_kern().
Date: Fri, 16 May 2025 20:50:24 -0700
Message-ID: <20250517035120.55560-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250517035120.55560-1-kuniyu@amazon.com>
References: <20250517035120.55560-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Let's restore sock_create_kern() that holds a netns reference.

Now, it's the same as the version before commit 26abe14379f8 ("net:
Modify sk_alloc to not reference count the netns of kernel sockets.").

Back then, after creating a socket in init_net, we used sk_change_net()
to drop the netns ref and switch to another netns, but now we can
simply use __sock_create_kern() instead.

  $ git blame -L:sk_change_net include/net/sock.h 26abe14379f8~

DEBUG_NET_WARN_ON_ONCE() is to catch a path calling sock_create_kern()
from __net_init functions, since doing so would leak the netns as
__net_exit functions cannot run until the socket is removed.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/linux/net.h |  2 ++
 net/socket.c        | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/include/linux/net.h b/include/linux/net.h
index 12180e00f882..b60e3afab344 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -254,6 +254,8 @@ bool sock_is_registered(int family);
 int sock_create(int family, int type, int proto, struct socket **res);
 int __sock_create_kern(struct net *net, int family, int type, int proto,
 		       struct socket **res);
+int sock_create_kern(struct net *net, int family, int type, int proto,
+		     struct socket **res);
 int sock_create_lite(int family, int type, int proto, struct socket **res);
 struct socket *sock_alloc(void);
 void sock_release(struct socket *sock);
diff --git a/net/socket.c b/net/socket.c
index 7c4474c966c0..aeece4c4bb08 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1632,6 +1632,48 @@ int __sock_create_kern(struct net *net, int family, int type, int protocol, stru
 }
 EXPORT_SYMBOL(__sock_create_kern);
 
+/**
+ * sock_create_kern - creates a socket for kernel space
+ *
+ * @net: net namespace
+ * @family: protocol family (AF_INET, ...)
+ * @type: communication type (SOCK_STREAM, ...)
+ * @protocol: protocol (0, ...)
+ * @res: new socket
+ *
+ * Creates a new socket and assigns it to @res.
+ *
+ * The socket is for kernel space and should not be exposed to
+ * userspace via a file descriptor nor BPF hooks except for LSM
+ * (see inet_create(), inet_release(), etc).
+ *
+ * The socket bypasses some LSMs that take care of @kern in
+ * security_socket_create() and security_socket_post_create().
+ *
+ * The socket holds a reference count of @net so that the caller
+ * does not need to care about @net's lifetime.
+ *
+ * This MUST NOT be called from the __net_init path and @net MUST
+ * be alive as of calling sock_create_net().
+ *
+ * Context: Process context. This function internally uses GFP_KERNEL.
+ * Return: 0 or an error.
+ */
+int sock_create_kern(struct net *net, int family, int type, int protocol,
+		     struct socket **res)
+{
+	int ret;
+
+	DEBUG_NET_WARN_ON_ONCE(!net_initialized(net));
+
+	ret = __sock_create(net, family, type, protocol, res, 1);
+	if (!ret)
+		sk_net_refcnt_upgrade((*res)->sk);
+
+	return ret;
+}
+EXPORT_SYMBOL(sock_create_kern);
+
 static struct socket *__sys_socket_create(int family, int type, int protocol)
 {
 	struct socket *sock;
-- 
2.49.0


