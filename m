Return-Path: <netdev+bounces-19136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A308C759D58
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 20:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EC29281935
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 18:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94A324C40;
	Wed, 19 Jul 2023 18:31:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6917F3D3B2
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 18:31:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAB7C433C8;
	Wed, 19 Jul 2023 18:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689791490;
	bh=1DccyJH/V5mxxc3FHyGNfZqC5N/PPxlYjCJJzbgu52I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ruExub29BrFO6myWNunbMqMxyX4SlXG5DR+7Rt2l9rusjMekSHuulCtVlWjQBFtrQ
	 5l5y7pLVfXaWpgLbC1hDfP4uQVGCmir09oQ2mp3nQXySlqwM2xbmPTn/ByLoSI/dzR
	 BoHcBygdEsGJ2lzDebCPEyVDOAmofvINtQyDod9YKrb0KC3DFohGKY4hLwisP+f0Lr
	 m9m8f74PYn+E3r01xDzEIVlzPjh4/kCexJuBj5wu2EAKNGn83QitqvWuxtQy3YRTB1
	 gHimkPj1UwsQblOqhTJ0N1WmPbM/Ii2FrxkNXRX6QwJsnfu9PcfDeYrK/LGulNXLzQ
	 ++GcQBWjDNyPw==
Subject: [PATCH v3 5/5] SUNRPC: Reduce thread wake-up rate when receiving
 large RPC messages
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, dhowells@redhat.com
Date: Wed, 19 Jul 2023 14:31:29 -0400
Message-ID: 
 <168979148906.1905271.2650584507923874010.stgit@morisot.1015granger.net>
In-Reply-To: 
 <168979108540.1905271.9720708849149797793.stgit@morisot.1015granger.net>
References: 
 <168979108540.1905271.9720708849149797793.stgit@morisot.1015granger.net>
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

With large NFS WRITE requests on TCP, I measured 5-10 thread wake-
ups to receive each request. This is because the socket layer
calls ->sk_data_ready() frequently, and each call triggers a
thread wake-up. Each recvmsg() seems to pull in less than 100KB.

Have the socket layer hold ->sk_data_ready() calls until the full
incoming message has arrived to reduce the wake-up rate.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svcsock.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 7b7358908a21..36e5070132ea 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1088,6 +1088,9 @@ static void svc_tcp_fragment_received(struct svc_sock *svsk)
 	/* If we have more data, signal svc_xprt_enqueue() to try again */
 	svsk->sk_tcplen = 0;
 	svsk->sk_marker = xdr_zero;
+
+	smp_wmb();
+	tcp_set_rcvlowat(svsk->sk_sk, 1);
 }
 
 /**
@@ -1177,10 +1180,17 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
 		goto err_delete;
 	if (len == want)
 		svc_tcp_fragment_received(svsk);
-	else
+	else {
+		/* Avoid more ->sk_data_ready() calls until the rest
+		 * of the message has arrived. This reduces service
+		 * thread wake-ups on large incoming messages. */
+		tcp_set_rcvlowat(svsk->sk_sk,
+				 svc_sock_reclen(svsk) - svsk->sk_tcplen);
+
 		trace_svcsock_tcp_recv_short(&svsk->sk_xprt,
 				svc_sock_reclen(svsk),
 				svsk->sk_tcplen - sizeof(rpc_fraghdr));
+	}
 	goto err_noclose;
 error:
 	if (len != -EAGAIN)



