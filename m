Return-Path: <netdev+bounces-18012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF83754256
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 20:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA9C61C21458
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 18:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E584115ACA;
	Fri, 14 Jul 2023 18:10:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7221F931
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 18:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1272CC433C7;
	Fri, 14 Jul 2023 18:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689358258;
	bh=bxTAZ0rCFm1dsqjLX5lA1j5rbtFHpQAZvI1adKlXSo0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ozgRLv466jxGoGME6dN6gOohalvCaZCxpcqp4/qBQfhgKuBUEM5zcgjdfbq1XQg5e
	 NmsVM+37aQwGegDpvxIZWyMQbL7Djz6REMqNZcxi3XDPx1gVBYyVjzHi9VK91lugx0
	 iDzhmg/M/pm2Q1XfIz2PTGcvrbktwtbsFcicZAIx8L2wneqOgmbcPOWNBGOUuW+/KX
	 x7++FCib52tddkhe2iRa0ZU0MFL7ITLoIpEYOiStb69B/6Vrs9jb0nawn5iCPhY3RV
	 pe0p5iKLCTdtkbI3OeP7SwgQ8N3ZpqpJnyn1G4rIHdqmm3q3X3MpaTn8+Q3Lj0IXYn
	 5C4d7WZSOU+tg==
Subject: [PATCH v2 4/4] SUNRPC: Use a per-transport receive bio_vec array
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, dhowells@redhat.com
Date: Fri, 14 Jul 2023 14:10:57 -0400
Message-ID: 
 <168935825709.1984.4898358403212846149.stgit@manet.1015granger.net>
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

TCP receives are serialized, so we need only one bio_vec array per
socket. This shrinks the size of struct svc_rqst by 4144 bytes on
x86_64.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h     |    1 -
 include/linux/sunrpc/svcsock.h |    2 ++
 net/sunrpc/svcsock.c           |    2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index f8751118c122..36052188222d 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -224,7 +224,6 @@ struct svc_rqst {
 
 	struct folio_batch	rq_fbatch;
 	struct kvec		rq_vec[RPCSVC_MAXPAGES]; /* generally useful.. */
-	struct bio_vec		rq_bvec[RPCSVC_MAXPAGES];
 
 	__be32			rq_xid;		/* transmission id */
 	u32			rq_prog;	/* program number */
diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
index baea012e3b04..55446136499f 100644
--- a/include/linux/sunrpc/svcsock.h
+++ b/include/linux/sunrpc/svcsock.h
@@ -42,6 +42,8 @@ struct svc_sock {
 
 	struct completion	sk_handshake_done;
 
+	struct bio_vec		sk_recv_bvec[RPCSVC_MAXPAGES]
+						____cacheline_aligned;
 	struct bio_vec		sk_send_bvec[RPCSVC_MAXPAGES]
 						____cacheline_aligned;
 
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index e164ea4d0e0a..5cbc35e23e4f 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -299,7 +299,7 @@ static ssize_t svc_tcp_read_msg(struct svc_rqst *rqstp, size_t buflen,
 {
 	struct svc_sock *svsk =
 		container_of(rqstp->rq_xprt, struct svc_sock, sk_xprt);
-	struct bio_vec *bvec = rqstp->rq_bvec;
+	struct bio_vec *bvec = svsk->sk_recv_bvec;
 	struct msghdr msg = { NULL };
 	unsigned int i;
 	ssize_t len;



