Return-Path: <netdev+bounces-150540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3FA9EA9BE
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 08:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86EC8284C77
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 07:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957592248A1;
	Tue, 10 Dec 2024 07:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bIbJZe9I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEC2172BD5
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 07:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733816371; cv=none; b=CYiKh9vOzD5BMhkabMtQZfMZ4zN2MoLVfJ0Jnre+YWYke6Z+4B1Mt/8a80qLcxDQqIpx0dSzzvPmExrwvz4hKMYTLpIGfdnjxdurz0Sfxstrs7FCf0Q5Ij+L2MCzFiO1PLAThliyr/d7KeQUNq9039moMjobRowIA+eBTldzSko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733816371; c=relaxed/simple;
	bh=rbY3DShp4k/ogh55nk4lg7M1n/E2RbH3loDyQB8Bglk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XuF6ToTxqaQU75O3zcpEHRo2MUQIPzS4IcaIVW2iCWfKVZWun5nLEzFuZs12RziF4ytM6tlhMeniPDvH21Qyanq8xbI23ZLgPMSPrRjJOJgeWFVTc9Wb7LlDFDnlWLNMmslpiDyXChLh4DAzKj7D4N6jFoV15ud40CFD5HFydU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=bIbJZe9I; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733816371; x=1765352371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PctpxyDD7wIKWGo6uf8GUzRwZ59P8SfF9suFAEYcy5Q=;
  b=bIbJZe9IQZh5pHw+erYwbHLKMRO3A+dymYAX8mqn1zIjHbR+yKRq7Of4
   OU0JcgKJKBqsrvAsiZ9zAfWpcztUr0bSdWoASXPnwxKY1T1AZ+btVnd4+
   DSCiodrvvLezFEnbZX7SNK0HGQFEsxi+lunPkxeoeXrgc/1KodscV/Tr2
   8=;
X-IronPort-AV: E=Sophos;i="6.12,221,1728950400"; 
   d="scan'208";a="782128212"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 07:39:24 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:35127]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.104:2525] with esmtp (Farcaster)
 id ac8c4475-040e-454f-bb99-d7de97a9eeb7; Tue, 10 Dec 2024 07:39:23 +0000 (UTC)
X-Farcaster-Flow-ID: ac8c4475-040e-454f-bb99-d7de97a9eeb7
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Dec 2024 07:39:22 +0000
Received: from 6c7e67c6786f.amazon.com (10.143.88.19) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 10 Dec 2024 07:39:19 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 02/15] socket: Pass hold_net flag to __sock_create().
Date: Tue, 10 Dec 2024 16:38:16 +0900
Message-ID: <20241210073829.62520-3-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
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


