Return-Path: <netdev+bounces-288572-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EA9H63qB2pFOQMAu9opvQ
	(envelope-from <netdev+bounces-288572-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 05:55:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC76555A172
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 05:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D6A5301BA5C
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC872C21C3;
	Sat, 16 May 2026 03:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCei+pG+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134AC2D1303
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 03:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778903282; cv=none; b=bad0NucC35M+ElCbhvxLxotuzqM1O2V9I6GvDtZrHm3I59lTdV5naHcmCPNNc3RuI5+872QAXQ64beNK03hLXtEK4TWtkmiYM77yiseWmMJClx794RWdsTOWHdyZ4rGORRzHCrTnK59uP6r9esCI2NYlOtDnD4glEcxZTc+1rYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778903282; c=relaxed/simple;
	bh=uhaYEKfy/mLSn84DajFajVY0p8xS1t4EFZa65JeZ8Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hg8glbXGZgHcbcBDm2Jt8flHdNZs06SsiFrRQmQzketgKx2oVJPpN9SRZRWAFfTRhCCAjximj4LTDAebv9IYpFedjeqr+6FItYN7tX5iafg9phFUUJOG0nYU2AmIaj8nwmztfVftjkOb3VcdPci1cYuHHxYXVqlQ3MTA3GvQpWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCei+pG+; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bccdc0e283so909025ad.3
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 20:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778903280; x=1779508080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LGahI1dGDETqCudvdYNhAPTVGqfoPu0gvUWu1ozEgOg=;
        b=nCei+pG+uBVJvFy6s0u1Gm9+bYqjUwqRX5vef1s/ix8puObmzcvfsiLuF1mkp4VMJ4
         yEvWVc8obBSPCpfkaflPebWWKRGYjpwMbjQlSe1eurflcDP1E6gcakxHcdsLMeBUzMeL
         p64yc1FT+O0wkYJU6ELcNHGVAONSEcNam1wAJmbGESCWmL/f4jpvQ79nQGVe97P7grXE
         7vDn+7byiiNSjEOwqFz210yQRgMy2HnBNI0B7vi+ANQNFWItxLnv7vpH9z4+dJG5JKlJ
         hCCFvWKzPsDoAOwulOf6ePYjFr2zza+XYW9GiFaZz1xI9u4B4+Sjsu9iQOO4pf/rtSfv
         XNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778903280; x=1779508080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGahI1dGDETqCudvdYNhAPTVGqfoPu0gvUWu1ozEgOg=;
        b=e5aelbTtybPb8eZ2GjT7HTMEkOYZEdy1HX1gfvcVa5/uKiAZeSiUOYZIBozHOPKmOr
         vZ5K9xymGaxDmr2n1XYDsoL49s9LDoj9N+wydZb7mJTOUwKAU6o9Fa6hjEoH/c4er3Q3
         97K4kcEuVmO5AYvz9qQWj+3abSZCQi+30qNFLonZe8CJaiozwxydFt+ugvm7VTN8esXx
         EUYeFXvI+fA6HEok0VHsHR8dmQBuoDQujfNkmwwwoFMCtwD+3VhZXuzlJ1rZxhD5LZAp
         obc1+YAX9mUwVx8TIZrlKnWxPLkRNM4Ywi9qyWkm1GmeC/UUUInOT38yZdBeHJuphsAy
         7Mzg==
X-Forwarded-Encrypted: i=1; AFNElJ9X5LXU5+BQtorNuD2BG9Ljoajl95ORu1V2oAs8zrpQHm1EUPE851GmGvhUDNvW0YyxiMOLaG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGCLSBJWbACBM7KkWPTp9xsIvRC21E/lpNP6zDND1aOI1zBvkP
	JT4kUnUTwyME1IdzRWgJUz3JXzvom+fad6ySLhWMyKeO+dlU1G+RqThK
X-Gm-Gg: Acq92OEoaRBtshJqM45jjb2eb77+oqu3U7sL36OpQwHwdF3kiJ0eBVqHS5I90Y+rd5i
	VpBkuqghhU8QAMk0Wq1csZtpZnEou8bO9uWeDCkAyAh7+yneFdKdCjygcEEOj9zl+ax7vM9CA6b
	1wpjniewbKKwVhZXDyk3GZ4mwAniIs0lczUBF+q3K9GNKem6/HeEGWxdoh+7nznRh2GWC9XB7RF
	pAjfXx0ov5up2YCHXTRBgH6fdW6oAxEXXqM1WD7gRHpd2ljpor0LOPZMvqNb7pSvbDtIGzdrp1l
	lqn/ph702Ac4OcchYzd5c7+8T0L5h/4pV5XWpJEF2Nc43AXb87YFqW232K8h9aaaW7eIUkWXmzf
	jQtEqoDIOCotyzznam+STJL1SEi+/kdVLekDFqigH7w0PB+HHi/tRfYbEGLEcY9w2yZTfAukyNA
	oiYRPgFkK6smY3JdVsbv11DsSRRJmD1pA=
X-Received: by 2002:a17:90b:4a4e:b0:35d:ab8b:abe6 with SMTP id 98e67ed59e1d1-36951b846b9mr3959969a91.4.1778903280286;
        Fri, 15 May 2026 20:48:00 -0700 (PDT)
Received: from b330-MS-7D46.. ([122.192.219.205])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695124601asm4166871a91.2.2026.05.15.20.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 20:47:59 -0700 (PDT)
From: Ziyu Zhang <ziyuzhang201@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Andy King <acking@vmware.com>,
	George Zhang <georgezhang@vmware.com>,
	Dmitry Torokhov <dtor@vmware.com>,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	r33s3n6@gmail.com,
	gality369@gmail.com,
	zhenghaoran154@gmail.com,
	hanguidong02@gmail.com,
	zzzccc427@gmail.com,
	Ziyu Zhang <ziyuzhang201@gmail.com>
Subject: [PATCH net] vsock: keep poll shutdown state consistent
Date: Sat, 16 May 2026 11:47:45 +0800
Message-ID: <20260516034745.260442-1-ziyuzhang201@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DC76555A172
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,vmware.com,lists.linux.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-288572-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziyuzhang201@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

vsock_poll() reads vsk->peer_shutdown before taking the socket
lock to set EPOLLHUP and EPOLLRDHUP, then reads it again under the
lock to report EOF readability. A shutdown packet can update
peer_shutdown while poll is waiting for the lock, so one poll invocation
can report EPOLLIN without the corresponding HUP/RDHUP bits.

Keep non-connectible sockets on a single lockless READ_ONCE()
snapshot. For connectible sockets, defer shutdown-derived poll bits
until after lock_sock() and use one READ_ONCE() snapshot for both EOF
readability and HUP/RDHUP. This preserves shutdowns that arrive before
the lock is acquired and keeps all peer-shutdown-derived bits consistent
for a poll pass.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Signed-off-by: Ziyu Zhang <ziyuzhang201@gmail.com>
---
 net/vmw_vsock/af_vsock.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index adcba1b7b..bed42347b 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1122,6 +1122,25 @@ static int vsock_shutdown(struct socket *sock, int mode)
 	return err;
 }
 
+static __poll_t vsock_poll_shutdown(struct sock *sk, u32 peer_shutdown)
+{
+	__poll_t mask = 0;
+
+	/* INET sockets treat local write shutdown and peer write shutdown as a
+	 * case of EPOLLHUP set.
+	 */
+	if (sk->sk_shutdown == SHUTDOWN_MASK ||
+	    ((sk->sk_shutdown & SEND_SHUTDOWN) &&
+	     (peer_shutdown & SEND_SHUTDOWN)))
+		mask |= EPOLLHUP;
+
+	if (sk->sk_shutdown & RCV_SHUTDOWN ||
+	    peer_shutdown & SEND_SHUTDOWN)
+		mask |= EPOLLRDHUP;
+
+	return mask;
+}
+
 static __poll_t vsock_poll(struct file *file, struct socket *sock,
 			       poll_table *wait)
 {
@@ -1139,19 +1158,9 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
 		/* Signify that there has been an error on this socket. */
 		mask |= EPOLLERR;
 
-	/* INET sockets treat local write shutdown and peer write shutdown as a
-	 * case of EPOLLHUP set.
-	 */
-	if ((sk->sk_shutdown == SHUTDOWN_MASK) ||
-	    ((sk->sk_shutdown & SEND_SHUTDOWN) &&
-	     (vsk->peer_shutdown & SEND_SHUTDOWN))) {
-		mask |= EPOLLHUP;
-	}
-
-	if (sk->sk_shutdown & RCV_SHUTDOWN ||
-	    vsk->peer_shutdown & SEND_SHUTDOWN) {
-		mask |= EPOLLRDHUP;
-	}
+	if (!sock_type_connectible(sk->sk_type))
+		mask |= vsock_poll_shutdown(sk,
+					    READ_ONCE(vsk->peer_shutdown));
 
 	if (sk_is_readable(sk))
 		mask |= EPOLLIN | EPOLLRDNORM;
@@ -1171,6 +1180,7 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
 
 	} else if (sock_type_connectible(sk->sk_type)) {
 		const struct vsock_transport *transport;
+		u32 peer_shutdown;
 
 		lock_sock(sk);
 
@@ -1203,10 +1213,12 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
 		 * terminated should also be considered read, and we check the
 		 * shutdown flag for that.
 		 */
+		peer_shutdown = READ_ONCE(vsk->peer_shutdown);
 		if (sk->sk_shutdown & RCV_SHUTDOWN ||
-		    vsk->peer_shutdown & SEND_SHUTDOWN) {
+		    peer_shutdown & SEND_SHUTDOWN) {
 			mask |= EPOLLIN | EPOLLRDNORM;
 		}
+		mask |= vsock_poll_shutdown(sk, peer_shutdown);
 
 		/* Connected sockets that can produce data can be written. */
 		if (transport && sk->sk_state == TCP_ESTABLISHED) {
-- 
2.43.0


