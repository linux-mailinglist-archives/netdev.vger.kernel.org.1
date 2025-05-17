Return-Path: <netdev+bounces-191273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AABABA811
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 05:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 712F41BC4EC4
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 03:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2E513DBA0;
	Sat, 17 May 2025 03:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="W4lTVi1Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966CC188006
	for <netdev@vger.kernel.org>; Sat, 17 May 2025 03:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747454043; cv=none; b=nuaRFzBu4/CjnaWDEBJJt/GjYc9ecmtOibX0170co8e4i4DvdxeSN4IdMAuT8RSQfjuCid4+Sx07TuYtVipM6+YKYZtQUgoUey0URGXMz7v5JC2vJoQ7p31ygeIDHN23MW8hiMngUmQsB4MngCJcpqJTbS1fnW9JW+yFieWF2hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747454043; c=relaxed/simple;
	bh=36csNQsHz8TJXklSWTz5Jtq9HqqeudNiB09wSOJ0RyQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iMEQ/JnAnY4tqEz4nI4ITlccxYm6r9V2W+aEaY7c0s2mbfM9KQGkNvJb2YaVSPXDaol23zhQ05z+KsavG/fOTg17jdDIaR5ZKpoMPiOhqn8v3JWaVLh+lKgkaS0rfg0OBpWi0z8B/NgwxXFXO3VGELYRcXoe43DyXpHSKN2oqiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=W4lTVi1Z; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747454042; x=1778990042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+5Zr+mI2XvXJRhZAvhi5vKyOoO0/qwjTn02yoP4ndJg=;
  b=W4lTVi1ZjO3mtoc3RJHX14qNH0rmaw8A9DtuzaQ32KRISK5ylQQosg6t
   PFdLOthMVQVFvtOEqRMKdWhN0X1AgFIPbrDvCWYve/Z8Djc2dugjSWgux
   d2RfMrT0efTfrhXLghlKhaQ2gLS7BCOFwl+jxyne+eTY2L+0gvRWdgjm5
   4c9zK7KPtrRu+wL4LYFglMjM2DtBrjkyWHPyG4cA95oodgfSDm3Q08cSa
   RoaFjwA4N+yhadJNPNlTlE2ZtQZK6x77aSL9UTHfVfa9AtNoMNc+eh0Zl
   6SMbX+EAykwXvOat/RYr7CiI8gu+Wupj4wPVgSvBbiRvLr2k64QYzcUjk
   w==;
X-IronPort-AV: E=Sophos;i="6.15,295,1739836800"; 
   d="scan'208";a="745594708"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2025 03:53:59 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:8210]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.47:2525] with esmtp (Farcaster)
 id b4a5a8cb-9cd2-4915-91da-add291c36db2; Sat, 17 May 2025 03:53:57 +0000 (UTC)
X-Farcaster-Flow-ID: b4a5a8cb-9cd2-4915-91da-add291c36db2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 17 May 2025 03:53:57 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.194.153) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 17 May 2025 03:53:55 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 6/6] socket: Clean up kdoc for sock_create() and sock_create_lite().
Date: Fri, 16 May 2025 20:50:27 -0700
Message-ID: <20250517035120.55560-7-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D046UWB003.ant.amazon.com (10.13.139.174) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

__sock_create() is now static and the same doc exists on sock_create()
and sock_create_kern().

Also, __sock_create() says "On failure @res is set to %NULL.", but
this is always false.

In addition, the old style kdoc is a bit corrupted and we can't see the
DESCRIPTION section:

  $ scripts/kernel-doc -man net/socket.c | scripts/split-man.pl /tmp/man
  $ man /tmp/man/sock_create.9

Let's clean them up.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/socket.c | 58 ++++++++++++++++++++++------------------------------
 1 file changed, 25 insertions(+), 33 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index aeece4c4bb08..59d052d0b8e8 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1315,18 +1315,20 @@ static long sock_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 }
 
 /**
- *	sock_create_lite - creates a socket
- *	@family: protocol family (AF_INET, ...)
- *	@type: communication type (SOCK_STREAM, ...)
- *	@protocol: protocol (0, ...)
- *	@res: new socket
+ * sock_create_lite - creates a socket
  *
- *	Creates a new socket and assigns it to @res, passing through LSM.
- *	The new socket initialization is not complete, see kernel_accept().
- *	Returns 0 or an error. On failure @res is set to %NULL.
- *	This function internally uses GFP_KERNEL.
+ * @family: protocol family (AF_INET, ...)
+ * @type: communication type (SOCK_STREAM, ...)
+ * @protocol: protocol (0, ...)
+ * @res: new socket
+ *
+ * Creates a new socket and assigns it to @res, passing through LSM.
+ *
+ * The new socket initialization is not complete, see kernel_accept().
+ *
+ * Context: Process context. This function internally uses GFP_KERNEL.
+ * Return: 0 or an error. On failure @res is set to %NULL.
  */
-
 int sock_create_lite(int family, int type, int protocol, struct socket **res)
 {
 	int err;
@@ -1452,21 +1454,6 @@ int sock_wake_async(struct socket_wq *wq, int how, int band)
 }
 EXPORT_SYMBOL(sock_wake_async);
 
-/**
- *	__sock_create - creates a socket
- *	@net: net namespace
- *	@family: protocol family (AF_INET, ...)
- *	@type: communication type (SOCK_STREAM, ...)
- *	@protocol: protocol (0, ...)
- *	@res: new socket
- *	@kern: boolean for kernel space sockets
- *
- *	Creates a new socket and assigns it to @res, passing through LSM.
- *	Returns 0 or an error. On failure @res is set to %NULL. @kern must
- *	be set to true if the socket resides in kernel space.
- *	This function internally uses GFP_KERNEL.
- */
-
 static int __sock_create(struct net *net, int family, int type, int protocol,
 			 struct socket **res, int kern)
 {
@@ -1583,16 +1570,21 @@ static int __sock_create(struct net *net, int family, int type, int protocol,
 }
 
 /**
- *	sock_create - creates a socket
- *	@family: protocol family (AF_INET, ...)
- *	@type: communication type (SOCK_STREAM, ...)
- *	@protocol: protocol (0, ...)
- *	@res: new socket
+ * sock_create - creates a socket for userspace
+ *
+ * @family: protocol family (AF_INET, ...)
+ * @type: communication type (SOCK_STREAM, ...)
+ * @protocol: protocol (0, ...)
+ * @res: new socket
  *
- *	A wrapper around __sock_create().
- *	Returns 0 or an error. This function internally uses GFP_KERNEL.
+ * Creates a new socket and assigns it to @res, passing through LSM.
+ *
+ * The socket is for userspace and should be exposed via a file
+ * descriptor and BPF hooks (see inet_create(), inet_release(), etc).
+ *
+ * Context: Process context. This function internally uses GFP_KERNEL.
+ * Return: 0 or an error.
  */
-
 int sock_create(int family, int type, int protocol, struct socket **res)
 {
 	return __sock_create(current->nsproxy->net_ns, family, type, protocol, res, 0);
-- 
2.49.0


