Return-Path: <netdev+bounces-151653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6739F07BE
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 10:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F7A7188BDBA
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 09:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B871AF0CE;
	Fri, 13 Dec 2024 09:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="C6qHwhs9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8595E1AF0C5
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 09:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734081770; cv=none; b=QXRtD2H42V+pOHgN99htdoXAIbXMRcWd8sZNL7mPvC1+718WXaFLv6VaeA8oDCrcLWQat2ygSDXYiPVxvkXoVSIyuH4ik+fwuctEKgBQcT1yGs8p7WqgBNCJhDNhNw9BgAchtsnUueaEk1JJ4PYdNcVtFJlyopsHksKDCcT5iJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734081770; c=relaxed/simple;
	bh=rbY3DShp4k/ogh55nk4lg7M1n/E2RbH3loDyQB8Bglk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sABHOInoJLr1TZ6fvhN/aF2pzqBw3YV0+x6ALKZgcOxvXzNa7IokHnQGIG2HI6F5OwIP7Qgl0haJdiRO3nQgOVPhQtVKgVE/0wetqGPF5napmxZyLD1GHyBqOjTdBmCqY6ttz0qINpEIXEQPMNRuWowVZSyqvs43UHW8e1YZr+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=C6qHwhs9; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734081770; x=1765617770;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PctpxyDD7wIKWGo6uf8GUzRwZ59P8SfF9suFAEYcy5Q=;
  b=C6qHwhs91kz+enf0k/NKQDFCM/kEdgnTK5mCVJ9ZofYj9D2VzAM2fh7J
   6oYMGp0tCtEyFmbG9ryEbg6F//j4g9RlnpMm3hJ43aOeR/JquMizR9TS4
   GfMsifa/26KxzzMbLHJd5S/STV8LxQp1G3nXIX2HrAyme7LdtnxqUvg62
   E=;
X-IronPort-AV: E=Sophos;i="6.12,230,1728950400"; 
   d="scan'208";a="450525832"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 09:22:45 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:1067]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.69:2525] with esmtp (Farcaster)
 id c248f8d6-f0e7-427a-a93b-5e3036e4db68; Fri, 13 Dec 2024 09:22:44 +0000 (UTC)
X-Farcaster-Flow-ID: c248f8d6-f0e7-427a-a93b-5e3036e4db68
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 09:22:43 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.208) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 09:22:39 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 02/15] socket: Pass hold_net flag to __sock_create().
Date: Fri, 13 Dec 2024 18:21:39 +0900
Message-ID: <20241213092152.14057-3-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D039UWA003.ant.amazon.com (10.13.139.49) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will introduce a new API to create a kernel socket with netns
refcnt held.

As a prep, let's add a new hold_net argument to __sock_create().

Note that we still do not pass it down to pf->create() for ease
of review; otherwise, this change will be buried in the huge diff.

Another option would be to override the kern parameter, which is
int, but I chose to change parameters for the following two reasons:

  1) Compilers allow us to efficiently make sure that all paths pass
     the parameters down to sk_alloc() as is.

  2) The parameter change breaks out-of-tree drivers, allowing the
     owners to choose an appropriate API.

Regarding 1), there actually was a weird path in smc_ulp_init()
that will be fixed up in the following patch.

While at it, the kernel-doc is fixed up to render the DESCRIPTION
part correctly.

  scripts/kernel-doc -man net/socket.c | scripts/split-man.pl /tmp/man
  man /tmp/man/__sock_create.9

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/socket.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 433f346ffc64..e5b4e0d34132 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1470,22 +1470,28 @@ int sock_wake_async(struct socket_wq *wq, int how, int band)
 EXPORT_SYMBOL(sock_wake_async);
 
 /**
- *	__sock_create - creates a socket
- *	@net: net namespace
- *	@family: protocol family (AF_INET, ...)
- *	@type: communication type (SOCK_STREAM, ...)
- *	@protocol: protocol (0, ...)
- *	@res: new socket
- *	@kern: boolean for kernel space sockets
+ * __sock_create - creates a socket
  *
- *	Creates a new socket and assigns it to @res, passing through LSM.
- *	Returns 0 or an error. On failure @res is set to %NULL. @kern must
- *	be set to true if the socket resides in kernel space.
- *	This function internally uses GFP_KERNEL.
+ * @net: net namespace
+ * @family: protocol family (AF_INET, ...)
+ * @type: communication type (SOCK_STREAM, ...)
+ * @protocol: protocol (0, ...)
+ * @res: new socket
+ * @kern: boolean for kernel space sockets
+ * @hold_net: boolean for netns refcnt
+ *
+ * Creates a new socket and assigns it to @res, passing through LSM.
+ *
+ * @kern must be set to true if userspace cannot touch it via a file
+ * descriptor nor BPF hooks except for LSM.  If @hold_net is false,
+ * the caller must ensure that the socket is always freed before @net.
+ *
+ * Context: Process context. This function internally uses GFP_KERNEL.
+ * Return: 0 or an error. On failure @res is set to %NULL.
  */
 
 static int __sock_create(struct net *net, int family, int type, int protocol,
-			 struct socket **res, int kern)
+			 struct socket **res, bool kern, bool hold_net)
 {
 	int err;
 	struct socket *sock;
@@ -1612,7 +1618,8 @@ static int __sock_create(struct net *net, int family, int type, int protocol,
 
 int sock_create(int family, int type, int protocol, struct socket **res)
 {
-	return __sock_create(current->nsproxy->net_ns, family, type, protocol, res, 0);
+	return __sock_create(current->nsproxy->net_ns, family, type, protocol,
+			     res, false, true);
 }
 EXPORT_SYMBOL(sock_create);
 
@@ -1628,9 +1635,10 @@ EXPORT_SYMBOL(sock_create);
  *	Returns 0 or an error. This function internally uses GFP_KERNEL.
  */
 
-int sock_create_kern(struct net *net, int family, int type, int protocol, struct socket **res)
+int sock_create_kern(struct net *net, int family, int type, int protocol,
+		     struct socket **res)
 {
-	return __sock_create(net, family, type, protocol, res, 1);
+	return __sock_create(net, family, type, protocol, res, true, false);
 }
 EXPORT_SYMBOL(sock_create_kern);
 
-- 
2.39.5 (Apple Git-154)


