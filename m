Return-Path: <netdev+bounces-232285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA79C03D26
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 01:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C12A1A08246
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 23:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C8A298CA2;
	Thu, 23 Oct 2025 23:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d6AU34N/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123EA2D2384
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 23:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761261488; cv=none; b=VxUrqDcdmIAwLajI8GhiJ/zWHs+FwKlfMVamlb7abkstb8/K8PHk3/3i2gZBd7EZxwJ5Q3xPyFILXxyTUX1KHQ2nGnx20aX0gwXbEBD1nMXCFsH61yuS5KhRpyJOWmQate/GnXYrMVhPeP3eaDprHrU2lwXT95iE069bhQ9T38o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761261488; c=relaxed/simple;
	bh=cLOWzPckiljsvk+s9zeTQ2d6X+gpFhd9lvDyduJUFZ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NSEbNseUpXrol7VO3y5nJCgTv1JLrvTmoInlipVhwC7940PCnn+uHtf/ynuzAj279n0r9Qkap2nZzbeaPjbFC2habh53eEyvf19N6RLTVrUxx5J/1b6DGSN/7RdHuS7kvujuUDxC5bqOZSfMfLcFaG6XDWbogoenKbJXHkq8alE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d6AU34N/; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33bc5d7c289so2808015a91.0
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 16:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761261484; x=1761866284; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nHveIE9Rl1G45KitM9v7ANlIHiL7Ar/r1bbAanaqd+0=;
        b=d6AU34N/n8hFZDK2fcZapQ/fL0x1iwJrKbfHh9bnyCww2U4BAkKMVbdLZrSfByyULo
         RYwWk50Of8WV7fRce4KIEXHihZx2J/WCRyOd13t3iTugayzmOiQPeBNWp6Xi6s6BuFQr
         tkc2WSQveGUpL/G2hSICBeswLKFOewbsqinLniMHRpkpdQ6bALLGpKQaj2X76TgFaxak
         i/LIBtco9IamIKn2HFZvsidJ+jEGDDOuwQ62K6cVV+jGwrr3muchkn1N9ImX6Q/WchNi
         j+KW35OaXNrEG+DSm4Oihu/AXYWIhH5QCE737q0yNjIAxgSEtBCT/AAVxP5XB0nBIVLc
         Os1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761261484; x=1761866284;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nHveIE9Rl1G45KitM9v7ANlIHiL7Ar/r1bbAanaqd+0=;
        b=drVfk2v3u6WwObhtDaSv5wy5ZWy9Zb/FBW4BljzF012W9hHmmHsOMwf/9k9UUTmuL6
         RwMc4yU9q5liZKqbqGMrLwH4p2ui0G4Ve0VgmoajBSo6bR5DmuneDFdvB57468W8aEDJ
         6wKKCj8hj9LNFQmD5/SdasmMetODWd10uOrWUItu1sWiI+W9V2vDkBW6W+MQnbSCNTw9
         S1FFpuyrJx69bZGayoMav3YM9tZ91DkRSx8hiiU7Ql/fKDiVAutnLR6PTGKXvp3d+g0v
         ni6e2kt5SKKhOnmeUx7fGP5Nou5mc6/X/cHlzI9cdbOAQegl1coUCk91F4YJD+q0k7er
         6bjg==
X-Forwarded-Encrypted: i=1; AJvYcCXIMYlDsF1ogya9kyTvUjqMA2Qyn9oYrccEsSU+LA4G2eToqsKT/FO5fxu4DgXGyd9QjKxjil0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgwe+mAU0Y076AIQ7M+IHNNXzxizBj5ZfOtO43/JaaIbXfe+qW
	k9fxbnjLTWWIUZ+YMfx2bvskILbawNSJb3eI5RoABFMx4AmKuZfsAZBA6ygfP6o/GAGx/eHXxbJ
	ctwPQQg==
X-Google-Smtp-Source: AGHT+IHtfkscoVZkLNWPLydZnkiQ/+P/fJOiDgdpD0POy5Es8Ze/V2LxxJguAyXw+CDiW9OJWRj5XY9oX6o=
X-Received: from pjbsd4.prod.google.com ([2002:a17:90b:5144:b0:33b:51fe:1a93])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d89:b0:32e:18f2:7a59
 with SMTP id 98e67ed59e1d1-33fd6502727mr251987a91.11.1761261484431; Thu, 23
 Oct 2025 16:18:04 -0700 (PDT)
Date: Thu, 23 Oct 2025 23:16:56 +0000
In-Reply-To: <20251023231751.4168390-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251023231751.4168390-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251023231751.4168390-8-kuniyu@google.com>
Subject: [PATCH v3 net-next 7/8] sctp: Use sctp_clone_sock() in sctp_do_peeloff().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

sctp_do_peeloff() calls sock_create() to allocate and initialise
struct sock, inet_sock, and sctp_sock, but later sctp_copy_sock()
and sctp_sock_migrate() overwrite most fields.

What sctp_do_peeloff() does is more like accept().

Let's use sock_create_lite() and sctp_clone_sock().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Export __inet_accept()
---
 net/ipv4/af_inet.c |  1 +
 net/sctp/socket.c  | 36 +++++++++++++++---------------------
 2 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 77f6ae0fc231..0784e2a873a1 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -788,6 +788,7 @@ void __inet_accept(struct socket *sock, struct socket *newsock, struct sock *new
 
 	newsock->state = SS_CONNECTED;
 }
+EXPORT_SYMBOL_GPL(__inet_accept);
 
 /*
  *	Accept a pending connection. The TCP layer now gives BSD semantics.
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 826f17747f17..60d3e340dfed 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -5671,11 +5671,11 @@ static int sctp_getsockopt_autoclose(struct sock *sk, int len, char __user *optv
 
 /* Helper routine to branch off an association to a new socket.  */
 static int sctp_do_peeloff(struct sock *sk, sctp_assoc_t id,
-		struct socket **sockp)
+			   struct socket **sockp)
 {
 	struct sctp_association *asoc = sctp_id2assoc(sk, id);
-	struct sctp_sock *sp = sctp_sk(sk);
 	struct socket *sock;
+	struct sock *newsk;
 	int err = 0;
 
 	/* Do not peel off from one netns to another one. */
@@ -5691,30 +5691,24 @@ static int sctp_do_peeloff(struct sock *sk, sctp_assoc_t id,
 	if (!sctp_style(sk, UDP))
 		return -EINVAL;
 
-	/* Create a new socket.  */
-	err = sock_create(sk->sk_family, SOCK_SEQPACKET, IPPROTO_SCTP, &sock);
-	if (err < 0)
+	err = sock_create_lite(sk->sk_family, SOCK_SEQPACKET, IPPROTO_SCTP, &sock);
+	if (err)
 		return err;
 
-	sctp_copy_sock(sock->sk, sk, asoc);
-
-	/* Make peeled-off sockets more like 1-1 accepted sockets.
-	 * Set the daddr and initialize id to something more random and also
-	 * copy over any ip options.
-	 */
-	sp->pf->to_sk_daddr(&asoc->peer.primary_addr, sock->sk);
-	sp->pf->copy_ip_options(sk, sock->sk);
-
-	/* Populate the fields of the newsk from the oldsk and migrate the
-	 * asoc to the newsk.
-	 */
-	err = sctp_sock_migrate(sk, sock->sk, asoc,
-				SCTP_SOCKET_UDP_HIGH_BANDWIDTH);
-	if (err) {
+	newsk = sctp_clone_sock(sk, asoc, SCTP_SOCKET_UDP_HIGH_BANDWIDTH);
+	if (IS_ERR(newsk)) {
 		sock_release(sock);
-		sock = NULL;
+		*sockp = NULL;
+		return PTR_ERR(newsk);
 	}
 
+	lock_sock_nested(newsk, SINGLE_DEPTH_NESTING);
+	__inet_accept(sk->sk_socket, sock, newsk);
+	release_sock(newsk);
+
+	sock->ops = sk->sk_socket->ops;
+	__module_get(sock->ops->owner);
+
 	*sockp = sock;
 
 	return err;
-- 
2.51.1.851.g4ebd6896fd-goog


