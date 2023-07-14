Return-Path: <netdev+bounces-18010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C85675424E
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 20:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CAD8282171
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 18:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59BB15ACC;
	Fri, 14 Jul 2023 18:10:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F7115AC0
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 18:10:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDE4C433C7;
	Fri, 14 Jul 2023 18:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689358245;
	bh=byFEDI4Ms42xCBRWUSKClR4VOvCmozGhJdwzzwpFm1o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=PlW4gMRttlkkDmvM4Ng8lkXg1as0sPRNt5FaZJaxZOBGfRVYiVEVpVvAg3AwEFDKi
	 YaOtNYkOxfGkorHI1ahjPBzci0FoT8wAze/1BuDogpcInY1GJIIpThLE3eYZ8c/aGM
	 zgrqF847ZfjLfZGfgqX933IYl29pYajD8U25Jn49Azjb84GCQTaOtqIwTcfSajtuAd
	 v9vVoALQeTRT9DoBTCVMZJ3JW8zAZ0qtmVGnUw8XK+uwlpVcNuokZVB+Ng8shCvVza
	 CEBlJPJcgFQ4jMJdnvAMPHjCw/u+P4MHPdrFWt9367/RHJKpNWlCbCDrtzgDUxsUMn
	 EIUl5dZegNHRw==
Subject: [PATCH v2 2/4] SUNRPC: Send RPC message on TCP with a single
 sock_sendmsg() call
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>, Chuck Lever <chuck.lever@oracle.com>,
 dhowells@redhat.com
Date: Fri, 14 Jul 2023 14:10:44 -0400
Message-ID: 
 <168935824410.1984.15912253826414043702.stgit@manet.1015granger.net>
In-Reply-To: 
 <168935791041.1984.13295336680505732841.stgit@manet.1015granger.net>
References: 
 <168935791041.1984.13295336680505732841.stgit@manet.1015granger.net>
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

There is now enough infrastructure in place to combine the stream
record marker into the biovec array used to send each outgoing RPC
message. The whole message can be more efficiently sent with a
single call to sock_sendmsg() using a bio_vec iterator.

Note that this also helps with RPC-with-TLS: the TLS implementation
can now clearly see where the upper layer message boundaries are.
Before, it would send each component of the xdr_buf in a separate
TLS record.

Suggested-by: David Howells <dhowells@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svcsock.h |    2 ++
 net/sunrpc/svcsock.c           |   33 ++++++++++++++++++---------------
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
index a9bfeadf4cbe..baea012e3b04 100644
--- a/include/linux/sunrpc/svcsock.h
+++ b/include/linux/sunrpc/svcsock.h
@@ -38,6 +38,8 @@ struct svc_sock {
 	/* Number of queued send requests */
 	atomic_t		sk_sendqlen;
 
+	struct page_frag_cache  sk_frag_cache;
+
 	struct completion	sk_handshake_done;
 
 	struct bio_vec		sk_send_bvec[RPCSVC_MAXPAGES]
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index e35e5afe4b81..bb185c0bb57c 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1213,31 +1213,30 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
 static int svc_tcp_sendmsg(struct svc_sock *svsk, struct xdr_buf *xdr,
 			   rpc_fraghdr marker, unsigned int *sentp)
 {
-	struct kvec rm = {
-		.iov_base	= &marker,
-		.iov_len	= sizeof(marker),
-	};
 	struct msghdr msg = {
-		.msg_flags	= MSG_MORE,
+		.msg_flags	= MSG_SPLICE_PAGES,
 	};
 	unsigned int count;
+	void *tmp;
 	int ret;
 
 	*sentp = 0;
 
-	ret = kernel_sendmsg(svsk->sk_sock, &msg, &rm, 1, rm.iov_len);
-	if (ret < 0)
-		return ret;
-	*sentp += ret;
-	if (ret != rm.iov_len)
-		return -EAGAIN;
+	/* The stream record marker is copied into a temporary page
+	 * buffer so that it can be included in sk_send_bvec.
+	 */
+	tmp = page_frag_alloc(&svsk->sk_frag_cache, sizeof(marker),
+			      GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+	memcpy(tmp, &marker, sizeof(marker));
+	bvec_set_virt(svsk->sk_send_bvec, tmp, sizeof(marker));
 
-	count = xdr_buf_to_bvec(svsk->sk_send_bvec,
-				ARRAY_SIZE(svsk->sk_send_bvec), xdr);
+	count = xdr_buf_to_bvec(svsk->sk_send_bvec + 1,
+				ARRAY_SIZE(svsk->sk_send_bvec) - 1, xdr);
 
-	msg.msg_flags = MSG_SPLICE_PAGES;
 	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, svsk->sk_send_bvec,
-		      count, xdr->len);
+		      1 + count, sizeof(marker) + xdr->len);
 	ret = sock_sendmsg(svsk->sk_sock, &msg);
 	if (ret < 0)
 		return ret;
@@ -1616,6 +1615,7 @@ static void svc_tcp_sock_detach(struct svc_xprt *xprt)
 static void svc_sock_free(struct svc_xprt *xprt)
 {
 	struct svc_sock *svsk = container_of(xprt, struct svc_sock, sk_xprt);
+	struct page_frag_cache *pfc = &svsk->sk_frag_cache;
 	struct socket *sock = svsk->sk_sock;
 
 	trace_svcsock_free(svsk, sock);
@@ -1625,5 +1625,8 @@ static void svc_sock_free(struct svc_xprt *xprt)
 		sockfd_put(sock);
 	else
 		sock_release(sock);
+	if (pfc->va)
+		__page_frag_cache_drain(virt_to_head_page(pfc->va),
+					pfc->pagecnt_bias);
 	kfree(svsk);
 }



