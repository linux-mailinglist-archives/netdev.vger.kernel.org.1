Return-Path: <netdev+bounces-22007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBC3765A85
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 19:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36C82282464
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 17:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E028F27157;
	Thu, 27 Jul 2023 17:36:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB20B27148;
	Thu, 27 Jul 2023 17:36:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1272BC433C7;
	Thu, 27 Jul 2023 17:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690479415;
	bh=MKrUk89gpzTbXM0B5xC6xWf1BYGOXULrlR87/6kKwJ4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=IPG2EopmLuSt9VDOdNJWNfaQwwixSjk8ecCB1imMEIY/BXVJCVbqST9Volt9gRavD
	 SFhX2clFKhjI+Dx1eFcjcJpD7i4GTjBtu/CHzBe7y/h8B+yWNlETwDIu/GTACiTwVz
	 dAj0DJx8fT7X4YhAWqnydF3472sl5noG48uuPeTgTugJSpCZgkxYd/lMf6aCMmcTh+
	 UEBGwAomV4qjeEnxwFPQwOe9SbP+r3WWIx7BNYp8LwKvutsQS1GnsLECSqMTE075Z3
	 EZ0jbH/c6dij2N2pOwQjf0pASBqTYazf9U1pt3xjtkLZX7FAixnNnIqkOinLM3FsoE
	 NWfWzBr3bWGZA==
Subject: [PATCH net-next v3 4/7] SUNRPC: Send TLS Closure alerts before
 closing a TCP socket
From: Chuck Lever <cel@kernel.org>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
Date: Thu, 27 Jul 2023 13:36:44 -0400
Message-ID: 
 <169047939404.5241.14392506226409865832.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: 
 <169047923706.5241.1181144206068116926.stgit@oracle-102.nfsv4bat.org>
References: 
 <169047923706.5241.1181144206068116926.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

Before closing a TCP connection, the TLS protocol wants peers to
send session close Alert notifications. Add those in both the RPC
client and server.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svcsock.c  |    2 ++
 net/sunrpc/xprtsock.c |    2 ++
 2 files changed, 4 insertions(+)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 449df8cabfcb..cca6ee716020 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1622,6 +1622,8 @@ static void svc_tcp_sock_detach(struct svc_xprt *xprt)
 {
 	struct svc_sock *svsk = container_of(xprt, struct svc_sock, sk_xprt);
 
+	tls_handshake_close(svsk->sk_sock);
+
 	svc_sock_detach(xprt);
 
 	if (!test_bit(XPT_LISTENER, &xprt->xpt_flags)) {
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 9457ebf22fb1..5096aa62de5c 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1293,6 +1293,8 @@ static void xs_close(struct rpc_xprt *xprt)
 
 	dprintk("RPC:       xs_close xprt %p\n", xprt);
 
+	if (transport->sock)
+		tls_handshake_close(transport->sock);
 	xs_reset_transport(transport);
 	xprt->reestablish_timeout = 0;
 }



