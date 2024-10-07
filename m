Return-Path: <netdev+bounces-132886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C33993A0C
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 00:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 446D11C23E33
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 22:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE301DE4EA;
	Mon,  7 Oct 2024 22:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="01wA2JLY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AF01DE2C7
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 22:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728339408; cv=none; b=AJOOo2tFZpjtJyG6C4kYJB4Z+tweVic0LZuvNRHBtP5LOvD+VSMCrbXe0mLvwRcznqgWEUZuV3GbIcyfW+FJtFLAi2MxSnyxNfoEXr52RQZu1oCBTWtVRit8LMXCEV4Dgjfwe6q+Hq5SCElzcZIqnnSyzi0k4ZenK3Q/YDHGHcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728339408; c=relaxed/simple;
	bh=8byHPkmyqil4BRS4TqeQPgrllEa8K8cBiR2yYsnDLjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D1fzjhEDTTf5K1kFn22yTyHVYJ7ux9Ed4sdzn+EGmUz4gTHXwrnhaK0WSKC6y2reOrG5gMPGzbRov7TMvpwVuC8HDn48HSW00GXsv2WKsrO4P6O8+u1HA3Toxpcmgw9b4BNwR3sejaHmqMEFBs4XyRTprQ8JE/pWp//D1J2Dng0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=01wA2JLY; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-6bce380eb96so3028892a12.0
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 15:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1728339406; x=1728944206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZx20d5L+OyVbNtxxiSkP5O3ww6PEtO7CAmaLbxuvto=;
        b=01wA2JLYGHgSeBiGQFVtPj5XmmWpJyM7P8CTNjiVl2KJ2Ji/XfmK5cBgAQoYxCRUN2
         YQ6s7WZVfgFZ1VZeUOiaZLKy4f6bZz4308VNwOHyEDHOT/gMpjs5Nmo0GE9fgVIwE+CS
         77KtoGsXtMJAoD6aD8ck7HFfGmb2sLbOT13uUwuzokkLIm51VJemVI8rdLp36lhZ09uj
         BotTSEeLEg1EI0r9AcWty5VAaII4BAxYrhl3uIDx6n/dEkUgUy+3OPxhGh+VRfSp0Mwx
         KD+iAhe5O6SSJdEhWE1pBSaNBOxei6apLJdA9EjOP3YDXS8gpanCcWARAztTj2Vy+GbJ
         0feQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728339406; x=1728944206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZx20d5L+OyVbNtxxiSkP5O3ww6PEtO7CAmaLbxuvto=;
        b=bKCvvFW2wfogkOqo02XfoYQBbNXk2fxZSBWYf2p8Y2k6/lI4L4r00LHdv7kx2huLmB
         aQqU6R4gLa6+bUbsmt/tJu+3MkBE/8Yz+od7dvdFpPizdgMHaCJFj7NrkiFpq4cnJ9xk
         itjB8QBQ8BYppKyAqeotI+rrIaD5myS9BvpsKKSxfJic592GjiTj7t4mfwsRg2dXDQbM
         +noyNLznhQnOiCm1a3NVJXve84dkSiRrxd6D2T6h1ROOf+ktV5GrvmAViaVFriZhJhKA
         QglXCJHFmtHY1agFgLibQRSqzvDn8D3wslWa5we6vDS5/C3TVgQSFIazogdAg4eCOGI4
         PoLA==
X-Forwarded-Encrypted: i=1; AJvYcCXVuKLxVctA6mmMx9Nx88ykTxBf/36618WPal5ehLl5WFM0pdSql4yAID3IwB/kK9UPRs+57x8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQSbUAfRvR6WHH4LWSk7SRGk4EAH1MrAcXZ1/LdBvtFiWaoyCV
	61KT76RR3nvMs0f5+OqNhIK4UPzFPVfE0e1kU2l7EULiS5LxWw7YSkvXkHmWZ7w=
X-Google-Smtp-Source: AGHT+IGG+x8hF8UTMd+j5BFtku8i621L8kiAlMLyUacTPS2TDiYZJc55o5i83AgH/0u7kK+7KB6Q2A==
X-Received: by 2002:a17:903:234f:b0:20c:3d9e:5f2b with SMTP id d9443c01a7336-20c3d9e60acmr48053035ad.57.1728339406294;
        Mon, 07 Oct 2024 15:16:46 -0700 (PDT)
Received: from localhost (fwdproxy-prn-024.fbsv.net. [2a03:2880:ff:18::face:b00c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c139a1792sm44280965ad.293.2024.10.07.15.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 15:16:45 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: David Wei <dw@davidwei.uk>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH v1 15/15] io_uring/zcrx: throttle receive requests
Date: Mon,  7 Oct 2024 15:16:03 -0700
Message-ID: <20241007221603.1703699-16-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241007221603.1703699-1-dw@davidwei.uk>
References: <20241007221603.1703699-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavel Begunkov <asml.silence@gmail.com>

io_zc_rx_tcp_recvmsg() continues until it fails or there is nothing to
receive. If the other side sends fast enough, we might get stuck in
io_zc_rx_tcp_recvmsg() producing more and more CQEs but not letting the
user to handle them leading to unbound latencies.

Break out of it based on an arbitrarily chosen limit, the upper layer
will either return to userspace or requeue the request.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 io_uring/net.c  |  5 ++++-
 io_uring/zcrx.c | 17 ++++++++++++++---
 io_uring/zcrx.h |  6 ++++--
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/io_uring/net.c b/io_uring/net.c
index 482e138d2994..c99e62c7dcfb 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1253,10 +1253,13 @@ int io_recvzc(struct io_kiocb *req, unsigned int issue_flags)
 	if (!ifq)
 		return -EINVAL;
 
-	ret = io_zcrx_recv(req, ifq, sock, zc->msg_flags | MSG_DONTWAIT);
+	ret = io_zcrx_recv(req, ifq, sock, zc->msg_flags | MSG_DONTWAIT,
+			   issue_flags);
 	if (unlikely(ret <= 0) && ret != -EAGAIN) {
 		if (ret == -ERESTARTSYS)
 			ret = -EINTR;
+		if (ret == IOU_REQUEUE)
+			return IOU_REQUEUE;
 
 		req_set_fail(req);
 		io_req_set_res(req, ret, 0);
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 7939f830cf5b..a78d82a2d404 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -26,10 +26,13 @@
 
 #if defined(CONFIG_PAGE_POOL) && defined(CONFIG_INET)
 
+#define IO_SKBS_PER_CALL_LIMIT	20
+
 struct io_zcrx_args {
 	struct io_kiocb		*req;
 	struct io_zcrx_ifq	*ifq;
 	struct socket		*sock;
+	unsigned		nr_skbs;
 };
 
 struct io_zc_refill_data {
@@ -708,6 +711,9 @@ io_zcrx_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
 	int i, copy, end, off;
 	int ret = 0;
 
+	if (unlikely(args->nr_skbs++ > IO_SKBS_PER_CALL_LIMIT))
+		return -EAGAIN;
+
 	if (unlikely(offset < skb_headlen(skb))) {
 		ssize_t copied;
 		size_t to_copy;
@@ -785,7 +791,8 @@ io_zcrx_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
 }
 
 static int io_zcrx_tcp_recvmsg(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
-				struct sock *sk, int flags)
+				struct sock *sk, int flags,
+				unsigned int issue_flags)
 {
 	struct io_zcrx_args args = {
 		.req = req,
@@ -811,6 +818,9 @@ static int io_zcrx_tcp_recvmsg(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
 			ret = -ENOTCONN;
 		else
 			ret = -EAGAIN;
+	} else if (unlikely(args.nr_skbs > IO_SKBS_PER_CALL_LIMIT) &&
+		   (issue_flags & IO_URING_F_MULTISHOT)) {
+		ret = IOU_REQUEUE;
 	} else if (sock_flag(sk, SOCK_DONE)) {
 		/* Make it to retry until it finally gets 0. */
 		ret = -EAGAIN;
@@ -821,7 +831,8 @@ static int io_zcrx_tcp_recvmsg(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
 }
 
 int io_zcrx_recv(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
-		 struct socket *sock, unsigned int flags)
+		 struct socket *sock, unsigned int flags,
+		 unsigned int issue_flags)
 {
 	struct sock *sk = sock->sk;
 	const struct proto *prot = READ_ONCE(sk->sk_prot);
@@ -830,7 +841,7 @@ int io_zcrx_recv(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
 		return -EPROTONOSUPPORT;
 
 	sock_rps_record_flow(sk);
-	return io_zcrx_tcp_recvmsg(req, ifq, sk, flags);
+	return io_zcrx_tcp_recvmsg(req, ifq, sk, flags, issue_flags);
 }
 
 #endif
diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
index ddd68098122a..bb7ca61a251e 100644
--- a/io_uring/zcrx.h
+++ b/io_uring/zcrx.h
@@ -46,7 +46,8 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 void io_unregister_zcrx_ifqs(struct io_ring_ctx *ctx);
 void io_shutdown_zcrx_ifqs(struct io_ring_ctx *ctx);
 int io_zcrx_recv(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
-		 struct socket *sock, unsigned int flags);
+		 struct socket *sock, unsigned int flags,
+		 unsigned int issue_flags);
 #else
 static inline int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 					struct io_uring_zcrx_ifq_reg __user *arg)
@@ -60,7 +61,8 @@ static inline void io_shutdown_zcrx_ifqs(struct io_ring_ctx *ctx)
 {
 }
 static inline int io_zcrx_recv(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
-			       struct socket *sock, unsigned int flags)
+				struct socket *sock, unsigned int flags,
+				unsigned int issue_flags)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.43.5


