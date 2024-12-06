Return-Path: <netdev+bounces-149622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E53EE9E6849
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 08:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4EDA168AA0
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 07:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC291DA0E9;
	Fri,  6 Dec 2024 07:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="fRNj3C2p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7132D1DD88F
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 07:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733471759; cv=none; b=OTJsXZlYDmuFIoDqEPccph8GsCuBGAE1D8Z7yVSrjGrCcul4CfmZ7zYsZ2PVhDXFnavcW/1HX/HELDHrrO+IFbMSX0LNAPbGOYzRBotiDbFF6sz+3dSFU8rQenET81ZkOGgVPSRMvz3G0teVntANNtLCki4pCyKuXFs0ot+AyOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733471759; c=relaxed/simple;
	bh=OGpIQl6to+nNfJCwBc4/ZwgwIU+FR7WqMb3wHsjS9lQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uVxPy2fTRl+hVXbz/VidGEs0jBSOSqBpyb6FcCmmhAHe8x2kJHzA38fKCGhBTV6Jc0hwslmuLzd/mAewFOVaWArGzNaNyoIFfSs3u/r1888629BwiP86oUlMsKWlXb6cLPecgnKs3yyox6r7+SLdSyI/Cb29mLuTkcR4R5ojEQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=fRNj3C2p; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733471705; x=1765007705;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7cDxqh/ru6TBrRBMYkFarEiJk+uZIm5kDo6DspMKuTQ=;
  b=fRNj3C2pCgu0mvPnFmZOm/JN1Bsb+03BTIHMQuhieDGFximX308ENIOt
   UEzRcYg6ga3PqgOrKMkshe2cwInSYtFdSoiOcV3gmS8vOwU3UgJyCjW3Y
   P+ksox3BM6SbnyJBmQmOBfWamm0ByJOD07WAKiLoYNKBlNr2+nT/Yq5SB
   Q=;
X-IronPort-AV: E=Sophos;i="6.12,212,1728950400"; 
   d="scan'208";a="3746934"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 07:55:03 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:37073]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.223:2525] with esmtp (Farcaster)
 id 1693d8e5-a240-4e39-be29-80cbb8066f21; Fri, 6 Dec 2024 07:55:55 +0000 (UTC)
X-Farcaster-Flow-ID: 1693d8e5-a240-4e39-be29-80cbb8066f21
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 6 Dec 2024 07:55:54 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.244.93) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 6 Dec 2024 07:55:51 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 02/15] socket: Pass hold_net flag to __sock_create().
Date: Fri, 6 Dec 2024 16:54:51 +0900
Message-ID: <20241206075504.24153-3-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D042UWB003.ant.amazon.com (10.13.139.135) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will introduce a new API to create a kernel socket with netns
refcnt held.

As a prep, let's add a new hold_net argument to __sock_create().

Note that we still do not pass it down to pf->create() for ease
of review; otherwise, this change will be buried in the huge diff.

Another option would be to override the kern parameter, which is int.
But, I chose this approach to make sure, with the help of the compiler,
that all paths pass parameters down to sk_alloc() as is, and there
actually was a weird path in smc_ulp_init().

While at it, the kernel-doc is fixed up to render the DESCRIPTION part
correctly.

  scripts/kernel-doc -man net/socket.c | scripts/split-man.pl /tmp/man
  man /tmp/man/__sock_create.9

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/socket.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 433f346ffc64..dd1cc43901f3 100644
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
+ * descriptor nor BPF hooks.  If @hold_net is false, the caller must
+ * ensure that the socket is always freed before @net.
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


