Return-Path: <netdev+bounces-199826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F595AE1F89
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 17:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80C39189B65A
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0184291891;
	Fri, 20 Jun 2025 15:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MbUCiA24"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BB32DF3CF
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750434956; cv=none; b=CXr2XuiQQzfVYFMwB5VczFYaFREzSpnthzsRBNaXjjBtniO4CGoaC5CxiKAKK0hUbSOlRQ9RxrIEe0mvpQZ/suq+L8Sjp04cOclxppWdem/WuUIo+SbcBjdmOIZBr39ycIidI3k+eCQVSswrD3sC5jiDWPV1eJWEcfV75Rfns/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750434956; c=relaxed/simple;
	bh=HpOlVNIauDMH+Oje7nitG38TqeJXjCPnGi9yMqa5jBo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZjpuqADYhvg66G/LB5ybOP7avQyzejYxzKAxvaQxRToHJHskKlxsaa8CgLueqDFWSVXVWmEDGDujgH72ZyD+WIycM+IWTyXFiNuzn5ooLTeGECaueQpzlgt/2KSvhyHjkNhKCTGhZn34MibQvRzdTstE570OMT817nekvmk4k3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MbUCiA24; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6facf4cf5e1so34951636d6.2
        for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 08:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750434954; x=1751039754; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Qcgg4DNegVqS5LsvXaVMj8taYqnhLy0KR9OljGH0W0=;
        b=MbUCiA24eNsfkM2zb9Hby2tRVUDwmj3ikCv53pRYbDEqNM8O7QYt8wN3DUAhAiveLj
         hBPEeC+44wc4XuOdhG+w1wTYvx+8Z5gXYVN7JC0b8DS3sM7NnlJK2Uo1PyULiTMQZbpl
         cbxw079G6MoBluxNDHd0zL3I3ZTI1mW+qhJ/FraVpBGApbwnuJ6czWMRtbZ9nq8CbcKe
         PYBn+XVnWtO04DJDxcutXr/XFWYKM/GpzUlgOt+1kp7zu3Ysv/FeCM4fZ5Bh6of7+e2H
         eJxq5osGM5aMUefOYGqVLhE6RGK4nZjiIUj4fUaW+Y8V4EAQcLHV0lZzvA5uHLGBiZpS
         7OkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750434954; x=1751039754;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Qcgg4DNegVqS5LsvXaVMj8taYqnhLy0KR9OljGH0W0=;
        b=TxPOqIQ3BONPxmzkGycibs0KfzLhcrnJf2vkZOGrRK8+g6JmCGRGU9d8cwuT4d+JhQ
         njERJ/LbCHbEqLV5wEeioDqxlKtuGmYZJp10HbbeWaDYO5XckK1laXEUY7lWMg95frcF
         YEHh4Rp7SMSGk3yiWB6hzsRd+NDzDzvWRk5ijWnTXwqBOAMpI/j1J/L99u1bH4mNx8LN
         C221IvHZNURa53lU2DWIMa+4m49YWCTAXLVjnAn47P4qRef2YTBhJe1T8rhg9waHB1PH
         X5uCYfYz4YGSWvBaOK1AU54Ivxzxf65R59X7k9m292jneGfZFAMlGlTb6aFSmiGgVrzb
         nS1g==
X-Forwarded-Encrypted: i=1; AJvYcCUCsSILr0TjOVgOTgAYDoc6kjh0Qt3DcO+iyFwXKjLmArT69+D+L8BjwcxpM+pB1cTKHxUa9t0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7xEfyYmtKcDF6PrAYKor9l6+9g/Crkwwk4p2LPy7g3QfoJplM
	7j1i99x/QCN8fS34UT+7/4Jf5T6wx98ESGBYiGJvRjbmGbR3Rytw5zgAv1cq+P/tjdHzXofxTnP
	MHtroy6Vm7OIZlg==
X-Google-Smtp-Source: AGHT+IGmHO9ltENldL6Eb1KwX5efK22Iq8NO6AlqI1ykoKtNTpTWr2bJfPa86X4wGY7OGJD6T1M4r9RXUPKwvQ==
X-Received: from qvbmf8.prod.google.com ([2002:a05:6214:5d88:b0:6fa:d74f:1ebd])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:3d9c:b0:6fa:c46c:6fa1 with SMTP id 6a1803df08f44-6fd0a46a71amr55847996d6.3.1750434953804;
 Fri, 20 Jun 2025 08:55:53 -0700 (PDT)
Date: Fri, 20 Jun 2025 15:55:36 +0000
In-Reply-To: <20250620155536.335520-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620155536.335520-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620155536.335520-3-edumazet@google.com>
Subject: [PATCH net-next 2/2] net: make sk->sk_rcvtimeo lockless
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Followup of commit 285975dd6742 ("net: annotate data-races around
sk->sk_{rcv|snd}timeo").

Remove lock_sock()/release_sock() from ksmbd_tcp_rcv_timeout()
and add READ_ONCE()/WRITE_ONCE() where it is needed.

Also SO_RCVTIMEO_OLD and SO_RCVTIMEO_NEW can call sock_set_timeout()
without holding the socket lock.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 fs/smb/server/transport_tcp.c |  6 ++----
 include/net/sock.h            |  2 +-
 net/core/sock.c               | 10 ++++------
 net/llc/af_llc.c              |  6 +++---
 net/sctp/socket.c             |  2 +-
 net/smc/af_smc.c              |  2 +-
 net/smc/smc_clc.c             |  6 +++---
 net/strparser/strparser.c     |  2 +-
 net/x25/af_x25.c              |  2 +-
 9 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
index 4e9f98db9ff4098425ba315717f5fd1c6aae7579..f8c772a7cb439dd64ce7d294c8e431c925b78ab4 100644
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -58,12 +58,10 @@ static inline void ksmbd_tcp_reuseaddr(struct socket *sock)
 
 static inline void ksmbd_tcp_rcv_timeout(struct socket *sock, s64 secs)
 {
-	lock_sock(sock->sk);
 	if (secs && secs < MAX_SCHEDULE_TIMEOUT / HZ - 1)
-		sock->sk->sk_rcvtimeo = secs * HZ;
+		WRITE_ONCE(sock->sk->sk_rcvtimeo, secs * HZ);
 	else
-		sock->sk->sk_rcvtimeo = MAX_SCHEDULE_TIMEOUT;
-	release_sock(sock->sk);
+		WRITE_ONCE(sock->sk->sk_rcvtimeo, MAX_SCHEDULE_TIMEOUT);
 }
 
 static inline void ksmbd_tcp_snd_timeout(struct socket *sock, s64 secs)
diff --git a/include/net/sock.h b/include/net/sock.h
index 337d78bc780ec53947f7bd1f583e3d1e5a3c599f..e68eb74052c6e8910a75e455dc3347a4c1f5aeb9 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2590,7 +2590,7 @@ static inline gfp_t gfp_memcg_charge(void)
 
 static inline long sock_rcvtimeo(const struct sock *sk, bool noblock)
 {
-	return noblock ? 0 : sk->sk_rcvtimeo;
+	return noblock ? 0 : READ_ONCE(sk->sk_rcvtimeo);
 }
 
 static inline long sock_sndtimeo(const struct sock *sk, bool noblock)
diff --git a/net/core/sock.c b/net/core/sock.c
index 3e69f3b970af080e22999f2ce36d85434486fe15..b9f06924de6199cbf380e9c3b95ccbbfc6d22c4c 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1289,6 +1289,10 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 	case SO_SNDTIMEO_NEW:
 		return sock_set_timeout(&sk->sk_sndtimeo, optval,
 					optlen, optname == SO_SNDTIMEO_OLD);
+	case SO_RCVTIMEO_OLD:
+	case SO_RCVTIMEO_NEW:
+		return sock_set_timeout(&sk->sk_rcvtimeo, optval,
+					optlen, optname == SO_RCVTIMEO_OLD);
 	}
 
 	sockopt_lock_sock(sk);
@@ -1444,12 +1448,6 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 			WRITE_ONCE(sk->sk_rcvlowat, val ? : 1);
 		break;
 		}
-	case SO_RCVTIMEO_OLD:
-	case SO_RCVTIMEO_NEW:
-		ret = sock_set_timeout(&sk->sk_rcvtimeo, optval,
-				       optlen, optname == SO_RCVTIMEO_OLD);
-		break;
-
 	case SO_ATTACH_FILTER: {
 		struct sock_fprog fprog;
 
diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index cc77ec5769d82829cfb7a92096af8b79088df4f2..5958a80fe14cf3dea8a88d588ecfde121a9e66a5 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -210,7 +210,7 @@ static int llc_ui_release(struct socket *sock)
 	dprintk("%s: closing local(%02X) remote(%02X)\n", __func__,
 		llc->laddr.lsap, llc->daddr.lsap);
 	if (!llc_send_disc(sk))
-		llc_ui_wait_for_disc(sk, sk->sk_rcvtimeo);
+		llc_ui_wait_for_disc(sk, READ_ONCE(sk->sk_rcvtimeo));
 	if (!sock_flag(sk, SOCK_ZAPPED)) {
 		struct llc_sap *sap = llc->sap;
 
@@ -455,7 +455,7 @@ static int llc_ui_shutdown(struct socket *sock, int how)
 		goto out;
 	rc = llc_send_disc(sk);
 	if (!rc)
-		rc = llc_ui_wait_for_disc(sk, sk->sk_rcvtimeo);
+		rc = llc_ui_wait_for_disc(sk, READ_ONCE(sk->sk_rcvtimeo));
 	/* Wake up anyone sleeping in poll */
 	sk->sk_state_change(sk);
 out:
@@ -712,7 +712,7 @@ static int llc_ui_accept(struct socket *sock, struct socket *newsock,
 		goto out;
 	/* wait for a connection to arrive. */
 	if (skb_queue_empty(&sk->sk_receive_queue)) {
-		rc = llc_wait_data(sk, sk->sk_rcvtimeo);
+		rc = llc_wait_data(sk, READ_ONCE(sk->sk_rcvtimeo));
 		if (rc)
 			goto out;
 	}
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 96852ccb6decf714d7a243f83141b7371f7a034d..b3b68e9b1d6616f19b096f084a3e2ee11aa8c370 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -9492,7 +9492,7 @@ void sctp_copy_sock(struct sock *newsk, struct sock *sk,
 	newsk->sk_sndbuf = sk->sk_sndbuf;
 	newsk->sk_rcvbuf = sk->sk_rcvbuf;
 	newsk->sk_lingertime = sk->sk_lingertime;
-	newsk->sk_rcvtimeo = sk->sk_rcvtimeo;
+	newsk->sk_rcvtimeo = READ_ONCE(sk->sk_rcvtimeo);
 	newsk->sk_sndtimeo = READ_ONCE(sk->sk_sndtimeo);
 	newsk->sk_rxhash = sk->sk_rxhash;
 
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 6375a86fe2b5f4e9c5aa9f2a71650e5708692be7..8d56e4db63e041724f156aa3ab30bab745a15bad 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -487,7 +487,7 @@ static void smc_copy_sock_settings(struct sock *nsk, struct sock *osk,
 	/* options we don't get control via setsockopt for */
 	nsk->sk_type = osk->sk_type;
 	nsk->sk_sndtimeo = READ_ONCE(osk->sk_sndtimeo);
-	nsk->sk_rcvtimeo = osk->sk_rcvtimeo;
+	nsk->sk_rcvtimeo = READ_ONCE(osk->sk_rcvtimeo);
 	nsk->sk_mark = READ_ONCE(osk->sk_mark);
 	nsk->sk_priority = READ_ONCE(osk->sk_priority);
 	nsk->sk_rcvlowat = osk->sk_rcvlowat;
diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 521f5df80e10ca41ab187d7bd9c2461360ea2c49..5a4db151fe9578d25bbba7f65d2862ede1c4506e 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -688,7 +688,7 @@ int smc_clc_prfx_match(struct socket *clcsock,
 int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
 		     u8 expected_type, unsigned long timeout)
 {
-	long rcvtimeo = smc->clcsock->sk->sk_rcvtimeo;
+	long rcvtimeo = READ_ONCE(smc->clcsock->sk->sk_rcvtimeo);
 	struct sock *clc_sk = smc->clcsock->sk;
 	struct smc_clc_msg_hdr *clcm = buf;
 	struct msghdr msg = {NULL, 0};
@@ -707,7 +707,7 @@ int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
 	 * sizeof(struct smc_clc_msg_hdr)
 	 */
 	krflags = MSG_PEEK | MSG_WAITALL;
-	clc_sk->sk_rcvtimeo = timeout;
+	WRITE_ONCE(clc_sk->sk_rcvtimeo, timeout);
 	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &vec, 1,
 			sizeof(struct smc_clc_msg_hdr));
 	len = sock_recvmsg(smc->clcsock, &msg, krflags);
@@ -795,7 +795,7 @@ int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
 	}
 
 out:
-	clc_sk->sk_rcvtimeo = rcvtimeo;
+	WRITE_ONCE(clc_sk->sk_rcvtimeo, rcvtimeo);
 	return reason_code;
 }
 
diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
index d946bfb424c7f56f88dd6d074e902b6f24f9129f..43b1f558b33dbd02130a8ed975e7805f519430cf 100644
--- a/net/strparser/strparser.c
+++ b/net/strparser/strparser.c
@@ -333,7 +333,7 @@ static int strp_recv(read_descriptor_t *desc, struct sk_buff *orig_skb,
 	struct strparser *strp = (struct strparser *)desc->arg.data;
 
 	return __strp_recv(desc, orig_skb, orig_offset, orig_len,
-			   strp->sk->sk_rcvbuf, strp->sk->sk_rcvtimeo);
+			   strp->sk->sk_rcvbuf, READ_ONCE(strp->sk->sk_rcvtimeo));
 }
 
 static int default_read_sock_done(struct strparser *strp, int err)
diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index 1f8ae9f4a3f1960d63557f34a3c9e8bbf55e8633..655d1e0ae25f7cc1c6d472ec543baad1c6a95c55 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -891,7 +891,7 @@ static int x25_accept(struct socket *sock, struct socket *newsock,
 	if (sk->sk_state != TCP_LISTEN)
 		goto out2;
 
-	rc = x25_wait_for_data(sk, sk->sk_rcvtimeo);
+	rc = x25_wait_for_data(sk, READ_ONCE(sk->sk_rcvtimeo));
 	if (rc)
 		goto out2;
 	skb = skb_dequeue(&sk->sk_receive_queue);
-- 
2.50.0.rc2.701.gf1e915cc24-goog


