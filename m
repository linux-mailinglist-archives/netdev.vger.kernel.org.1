Return-Path: <netdev+bounces-18703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BF4758543
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 21:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB67B1C20E0C
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 19:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D62016439;
	Tue, 18 Jul 2023 19:00:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85AB15ADD;
	Tue, 18 Jul 2023 19:00:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F201BC433C7;
	Tue, 18 Jul 2023 19:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689706849;
	bh=RPiqMj1z1W85oICRWt2s2s+fa+nVUWtB7x0vIZ8uq7Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=NYeJjDvm2UxoftuIxYv1H/AoVGZLEYF8LWMBwKlfGr4njJ29yYoesr1UdK9ASPpnh
	 DWDkvXgZjmhabL+cC+U+RN8LIZIqnEIm5KaEWcFXWzCoLnitSMlOOIv7ry20/RvMCl
	 BGkZwvED9IIiaWO8i1iILJocPWdj0wxAt/2l/8K57BVkOJebWeokGcKFTm+Cx9kWUR
	 hqodhj3LLcQ8uy4HBMs7Idpk1j1xe9iC5AAv+nBE9Abxah9zDpjEqUx8eFOC/ra6M0
	 lrR30a8RlOggRCII9yVK1KBcDIwFmdq9M1bVSDLtzll88kg2Nb58CdFYizL9Ql5hV3
	 GhVe/rnQX8JgA==
Subject: [PATCH net-next v1 4/7] SUNRPC: Send TLS Closure alerts before
 closing a TCP socket
From: Chuck Lever <cel@kernel.org>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
Date: Tue, 18 Jul 2023 15:00:38 -0400
Message-ID: 
 <168970682801.5330.3343559673394450783.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: 
 <168970659111.5330.9206348580241518146.stgit@oracle-102.nfsv4bat.org>
References: 
 <168970659111.5330.9206348580241518146.stgit@oracle-102.nfsv4bat.org>
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
index e43f26382411..87bf685f2957 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1621,6 +1621,8 @@ static void svc_tcp_sock_detach(struct svc_xprt *xprt)
 {
 	struct svc_sock *svsk = container_of(xprt, struct svc_sock, sk_xprt);
 
+	tls_handshake_close(svsk->sk_sock);
+
 	svc_sock_detach(xprt);
 
 	if (!test_bit(XPT_LISTENER, &xprt->xpt_flags)) {
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 9f010369100a..871f141be96f 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1292,6 +1292,8 @@ static void xs_close(struct rpc_xprt *xprt)
 
 	dprintk("RPC:       xs_close xprt %p\n", xprt);
 
+	if (transport->sock)
+		tls_handshake_close(transport->sock);
 	xs_reset_transport(transport);
 	xprt->reestablish_timeout = 0;
 }



