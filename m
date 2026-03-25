Return-Path: <netdev+bounces-271414-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKBkAvCDw2kPrQQAu9opvQ
	(envelope-from <netdev+bounces-271414-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:42:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9803C320455
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3797305B2BC
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 06:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B14235AC16;
	Wed, 25 Mar 2026 06:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FCixhAJq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7598135C185
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 06:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774420741; cv=none; b=m6sLtHDNWosuo7OMfrPHE+1f2cEBxvCDPUqBE//12Wl8pHrvd9mGoJCY99i7H3Xshu3UpNlLy4LB6YSvbKKeZ1GzJU5QvxzrrwF7nx9ahwBNOsE65iKhrAGrRm990C3togRN8NN6rMRzIDlNLMMnmcIbuK9vP6lTlf5nHxmpsm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774420741; c=relaxed/simple;
	bh=LAdKqUyxFbnfvJCphUoGLvSMksWEznMeq0lag3oTTpM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tfEtoBjPdvygiJLdf0lbkTVo32nsiQqtE6KP2aPJZRZsGHIXWxNXppSCpA0g/FlSa8J4KRvXVecIS7PeO9z1PqVq4MEnddaBGeyLdkbCYmptRdqr17QAVR/lRyYKeOLd9KHM8d3SjLY94+B3R8HwwfdHSCShPS1OkQR05Obbe/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FCixhAJq; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82a82f78a20so21781200b3a.1
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 23:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774420739; x=1775025539; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PEDu3iUfouJb04ptIbRT7+n4Z/VovB4BeMR+pdGzK3s=;
        b=FCixhAJqEA1o/rijNcD5QAs3gQB3TROg2cVbJRPHS+UFXURslFvsGYx/7ZW4BVG+Rk
         Tf0LSQfZEp43zQUdqEXwOXUj5vFuwZen5NFhVkmQDWoTbHnhKJTRc1HS/TMQ4kCRjKSv
         Qjzn0Bf/8jdtyTGKX2H9NTMfRsVl4Nf572GMWFWKIxb8ZBfFKLhaXTMLFsV9djv7IfU4
         f7iBXRx17iuyU56jkY9muvGf8iEnX8mOAVC+zSlOJM52UcfUL/6HVyORmoqE/YqJSf18
         p0+R5SnKJ+BktsXMvzcDFkz2qXYOY6d+v4vwCiYUtyoaPzV9r4tTy502miI9fZlfTmyl
         oCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774420739; x=1775025539;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PEDu3iUfouJb04ptIbRT7+n4Z/VovB4BeMR+pdGzK3s=;
        b=D5bfzw+xq3hAdeNpDC89M9nHz3EExv7rPt9j96U2W9LdJWJzNntA3fDK2MJcXfbAOm
         0CPTmX6nstmFZi2Y26zFyFLgQ4m6UIiK1v0h9irHFz8TkT6HgrpuOVu3HLS2Uv1W3vGx
         PpdOfWXGJhVvGfiwbvyHq/UcISXfTneNNFiWEFc1eQ/Edc+AWzRFMA/WHzEosfZx08vv
         mCDRZ+ufT4IuKnUZgupL0YkfY7oT8lPs5+UjC3hdUNHmm4YbH6z/OPLktWZHikeK3OGG
         TkPA+ENwaBedr98qnxMB2tDmXvMGyr7sWN57EKeII1/RjYB3b/viUpkrGyy8sL4riWRa
         1nVA==
X-Forwarded-Encrypted: i=1; AJvYcCXeWWr2AdF56M10IGSzm0IxhHwugCwuGV5fZwjio0ggzWBlgRz/Od97BBk0LtmiZA4PDnZFJQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRCkwCV4fPK9p/Zxf3gAIqrBkH5ewcvp+AKnyrgOuKE9fqjyGz
	8IHIcNxjzrFEyo/R+4Ye2eubop25R2eTIgq/IBLUnBQs9+q79Bbv67zZx0AMrMOUpqgEaYNk+TI
	j9U0NEQ==
X-Received: from pfbfa24.prod.google.com ([2002:a05:6a00:2d18:b0:829:813e:c970])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4215:b0:81f:3fa0:8c38
 with SMTP id d2e1a72fcca58-82c6ded2d60mr2408162b3a.20.1774420738537; Tue, 24
 Mar 2026 23:38:58 -0700 (PDT)
Date: Wed, 25 Mar 2026 06:38:25 +0000
In-Reply-To: <20260325063843.1790782-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260325063843.1790782-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260325063843.1790782-5-kuniyu@google.com>
Subject: [PATCH 4/5] inet: Add inet_shutdown_locked().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, linux-block@vger.kernel.org, nbd@other.debian.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271414-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org,other.debian.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9803C320455
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When NBD calls sendmsg() and shutdown() for TCP sockets,
it must use lock_sock_try() to avoid potential deadlock.

While TCP already exports tcp_sendmsg_locked(), there is
no locked variant for inet_shutdown().

Let's add inet_shutdown_locked().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/inet_common.h |  1 +
 net/ipv4/af_inet.c        | 43 +++++++++++++++++++++++++++++----------
 2 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/include/net/inet_common.h b/include/net/inet_common.h
index 5dd2bf24449e..c085c39573c9 100644
--- a/include/net/inet_common.h
+++ b/include/net/inet_common.h
@@ -38,6 +38,7 @@ void inet_splice_eof(struct socket *sock);
 int inet_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 		 int flags);
 int inet_shutdown(struct socket *sock, int how);
+int inet_shutdown_locked(struct socket *sock, int how);
 int inet_listen(struct socket *sock, int backlog);
 int __inet_listen_sk(struct sock *sk, int backlog);
 void inet_sock_destruct(struct sock *sk);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index c7731e300a44..6fa8fd11fe6d 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -902,21 +902,11 @@ int inet_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 }
 EXPORT_SYMBOL(inet_recvmsg);
 
-int inet_shutdown(struct socket *sock, int how)
+static int __inet_shutdown(struct socket *sock, int how)
 {
 	struct sock *sk = sock->sk;
 	int err = 0;
 
-	/* This should really check to make sure
-	 * the socket is a TCP socket. (WHY AC...)
-	 */
-	how++; /* maps 0->1 has the advantage of making bit 1 rcvs and
-		       1->2 bit 2 snds.
-		       2->3 */
-	if ((how & ~SHUTDOWN_MASK) || !how)	/* MAXINT->0 */
-		return -EINVAL;
-
-	lock_sock(sk);
 	if (sock->state == SS_CONNECTING) {
 		if ((1 << sk->sk_state) &
 		    (TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_CLOSE))
@@ -953,11 +943,42 @@ int inet_shutdown(struct socket *sock, int how)
 
 	/* Wake up anyone sleeping in poll. */
 	sk->sk_state_change(sk);
+
+	return err;
+}
+
+int inet_shutdown(struct socket *sock, int how)
+{
+	struct sock *sk = sock->sk;
+	int err;
+
+	/* maps SHUT_RD (0) -> RCV_SHUTDOWN (1), etc */
+	how++;
+
+	if ((how & ~SHUTDOWN_MASK) || !how)
+		return -EINVAL;
+
+	lock_sock(sk);
+	err = __inet_shutdown(sock, how);
 	release_sock(sk);
+
 	return err;
 }
 EXPORT_SYMBOL(inet_shutdown);
 
+int inet_shutdown_locked(struct socket *sock, int how)
+{
+	sock_owned_by_me(sock->sk);
+
+	how++;
+
+	if ((how & ~SHUTDOWN_MASK) || !how)
+		return -EINVAL;
+
+	return __inet_shutdown(sock, how);
+}
+EXPORT_SYMBOL_GPL(inet_shutdown_locked);
+
 /*
  *	ioctl() calls you can issue on an INET socket. Most of these are
  *	device configuration and stuff and very rarely used. Some ioctls
-- 
2.53.0.1018.g2bb0e51243-goog


