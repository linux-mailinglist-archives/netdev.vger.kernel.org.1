Return-Path: <netdev+bounces-247124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B863CF4CA6
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 17:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BB70311CB50
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 16:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326DF33CE87;
	Mon,  5 Jan 2026 16:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckkK5Ylu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE8C1AB6F1
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 16:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767630826; cv=none; b=eF2WIDH5tw8Go223y7TOJwQFAM1t0Rl8XBs315jKLpumPLIRO8GJur1P464QFKxuYUId7qWzLIiefcnlWEKZTFTFtPW1WXjVCFCgYehJ4uVI98mvH06kdsv1KCLjXLcNuuSvv98qMylLdESs9pUsW/qPEXQ4nm5yB0Vf3gnE974=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767630826; c=relaxed/simple;
	bh=vmoxE6523482SQinJPDWz8zOF8McqnHUTzbZCt9zHBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m+abpqK9EujMMtUkPeopG1clLQgdNSQlq6fsJw/QwVbd1NltDRbRnyWMk68gGhyrMEd+iy6CCZnHioiMEgQGu9iLONhYEtyUOXHwuVSqkwIR1dKhFhIsimqYnI3kO9GjBEb+SVKTeUFLIB08jr2IKpj12ruBNXd9q6Lve0pSXsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckkK5Ylu; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-790992528f6so1560447b3.1
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 08:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767630823; x=1768235623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q+MWgVGEh86h+B24QJVrFoOZkbp97hY2WyjiM2ajUhU=;
        b=ckkK5YlumtwryqfRYi1mvissP/PUTaYfoK+GtS2wATxocILwLaamhXjAPdOvQT4y/G
         9/bABIvx+lCuUXcUERFCQySeW4nAubR40l1P5fxFPkwScL+l05REtoko+6pKgZYko7MV
         kiDD5B3gA5c7hdkNtIfTAzMlC2iVgO4QkNw6Im01tRdHK/kuPOHSVc1z7c5t6pEVCJOT
         C8q2zwVeWAzJiYkqEcYoFOztYvvMNtsBkPB9SSasBMaAbTtDbhiA1VK4YTuiWfxMilTr
         VMoXEk/d38Pe+2H2vUhOQZUYUPbygk8DKGFohnBBQqOo8evxmzIekMSgRnausvlbhwPF
         LAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767630823; x=1768235623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+MWgVGEh86h+B24QJVrFoOZkbp97hY2WyjiM2ajUhU=;
        b=pkS4ba8EZGbBL9vefucsGzHZwlA7b3HggUAt2K6VjlzHCQOefFmljP2thInmQMwSwo
         0x8dVpi+7/BJpzIINYzr4bNliGxxG35C1XcNPkay1PPLpJwjGZP3Oo7Hjf2z/6Pv4Iih
         zGWcMKzghdsad3r53hg+M5BgfG6BAlzsCOskZh5VfoSRpaTHFSzPzwHLGd/cunjnaCnJ
         TJdzsZfZRyrY8SQueVowkUTffv+99xLjzRo7caS/ep9DQX7IkAscpL/prEUdU60OkjFF
         ALMn987WxOmxSyES7HkaZiOjhN3oLWUFQ3sN8LNKw9XVwsxqS9NspeQjtX8fDCG7nPIm
         oAXQ==
X-Gm-Message-State: AOJu0YwJeN/OkSHVXpOgz1+cziA5XGCizevepGK2JYC5zrPtTcspY2V/
	WjRurN+BSDoFjKohkJjTQlYXl1bRTqrhHBKprdJN5kz6+VUF/GeGe6Cytv9bVQ==
X-Gm-Gg: AY/fxX4G9MDiW5r8A7U58UqL+a1OAP0s3o5XFsbmkXmHGpr/O2azQYdkS/KcZvOGo1b
	KqYXzz1bCumBiFCFxR8+8MiEYEYH/7yUVUnKTFfJSTYCl70wPdFn8dU31Hbk7p0X9F9j6+10JJg
	lDNPxKRJ/+TWzJjggOTaZ7AQ0RY6yOTisIgWp8nfoLA55wrXi79Ull1o7A47VBNqo/eyZCp3mIT
	ML3COMM2q7X4ZVeDRlAvwHldHSh146mIzh6RFwUAz/pdHafF3F3cykd1MULkrIPc321TTP1eHcj
	0hsWlisAhT0krKpu0JlpgIp9Hlbf2ii1hiHzCy8sbSD3kQsfoHUiQ45uhjkjQajWYavq7Y8/K7+
	qIeCm9Gm7hWZ5+FOZirdo0p5QuX+a7cplc4EJkC3Ak6MCgg33pWJWxQFt4k55tvsqqfxm+udewP
	Fic2BdjgLa35mcEdcqYzFEEGPRN+VGLNMHbPH1T6oQ9Gmz22ujvKCR7Lf15fQQ0VpFh4zFnQqK+
	zSaQvobK8WyUclfKTVP
X-Google-Smtp-Source: AGHT+IEzYaxQnZIIWWh6tgmW3gR4blNIyUK6d2u0SARbXaB1YOlFcgpWcYWQ0e6Achc/r3w3KYtEoQ==
X-Received: by 2002:a53:da08:0:b0:641:f5bc:69a6 with SMTP id 956f58d0204a3-6470c957411mr42382d50.84.1767630823389;
        Mon, 05 Jan 2026 08:33:43 -0800 (PST)
Received: from willemb.c.googlers.com.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790a87f3057sm606937b3.22.2026.01.05.08.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 08:33:42 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	axboe@kernel.dk,
	kuniyu@google.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next] net: do not write to msg_get_inq in caller
Date: Mon,  5 Jan 2026 11:32:41 -0500
Message-ID: <20260105163338.3461512-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

msg_get_inq is an input field from caller to callee. Don't set it in
the callee, as the caller may not clear it on struct reuse.

This is a kernel-internal variant of msghdr only, and the only user
does reinitialize the field. So this is not critical.

But it is more robust to avoid the write, and slightly simpler code.

Callers set msg_get_inq to request the input queue length to be
returned in msg_inq. This is equivalent to but independent from the
SO_INQ request to return that same info as a cmsg (tp->recvmsg_inq).
To reduce branching in the hot path the second also sets the msg_inq.
That is WAI.

This is a small follow-on to commit 4d1442979e4a ("af_unix: don't
post cmsg for SO_INQ unless explicitly asked for"), which fixed the
inverse.

Also collapse two branches using a bitwise or.

Link: https://lore.kernel.org/netdev/willemdebruijn.kernel.24d8030f7a3de@gmail.com/
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv4/tcp.c     | 8 +++-----
 net/unix/af_unix.c | 8 +++-----
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index f035440c475a..d5319ebe2452 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2652,10 +2652,8 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
 	if (sk->sk_state == TCP_LISTEN)
 		goto out;
 
-	if (tp->recvmsg_inq) {
+	if (tp->recvmsg_inq)
 		*cmsg_flags = TCP_CMSG_INQ;
-		msg->msg_get_inq = 1;
-	}
 	timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
 
 	/* Urgent data needs to be handled specially. */
@@ -2929,10 +2927,10 @@ int tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
 	ret = tcp_recvmsg_locked(sk, msg, len, flags, &tss, &cmsg_flags);
 	release_sock(sk);
 
-	if ((cmsg_flags || msg->msg_get_inq) && ret >= 0) {
+	if ((cmsg_flags | msg->msg_get_inq) && ret >= 0) {
 		if (cmsg_flags & TCP_CMSG_TS)
 			tcp_recv_timestamp(msg, sk, &tss);
-		if (msg->msg_get_inq) {
+		if ((cmsg_flags & TCP_CMSG_INQ) | msg->msg_get_inq) {
 			msg->msg_inq = tcp_inq_hint(sk);
 			if (cmsg_flags & TCP_CMSG_INQ)
 				put_cmsg(msg, SOL_TCP, TCP_CM_INQ,
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index a7ca74653d94..d0511225799b 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2904,7 +2904,6 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 	unsigned int last_len;
 	struct unix_sock *u;
 	int copied = 0;
-	bool do_cmsg;
 	int err = 0;
 	long timeo;
 	int target;
@@ -2930,9 +2929,6 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 
 	u = unix_sk(sk);
 
-	do_cmsg = READ_ONCE(u->recvmsg_inq);
-	if (do_cmsg)
-		msg->msg_get_inq = 1;
 redo:
 	/* Lock the socket to prevent queue disordering
 	 * while sleeps in memcpy_tomsg
@@ -3090,9 +3086,11 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 
 	mutex_unlock(&u->iolock);
 	if (msg) {
+		bool do_cmsg = READ_ONCE(u->recvmsg_inq);
+
 		scm_recv_unix(sock, msg, &scm, flags);
 
-		if (msg->msg_get_inq && (copied ?: err) >= 0) {
+		if ((do_cmsg | msg->msg_get_inq) && (copied ?: err) >= 0) {
 			msg->msg_inq = READ_ONCE(u->inq_len);
 			if (do_cmsg)
 				put_cmsg(msg, SOL_SOCKET, SCM_INQ,
-- 
2.52.0.351.gbe84eed79e-goog


