Return-Path: <netdev+bounces-293211-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHwaBivoGWpazwgAu9opvQ
	(envelope-from <netdev+bounces-293211-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 21:25:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A59C607D11
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 21:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0AE09304B904
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 19:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4BC36F8F9;
	Fri, 29 May 2026 19:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o9pUu1Jw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA44383300
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 19:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780082313; cv=none; b=mKCVgFt1rHAqDZwc9+uYvlWRsmc2awbzS4mxVIdLkQAQd631f9Cn8y/OKxZJ4DYA2vTspExyvMsAZZjFYS2hd/g7pUogfbxPBOKqSoCskpc4dZTOnaSKqK0W6uEw5cko4dEgp+UGH47b9/QeQ+PYAL1fIMeQvvaMgOuTedgEhZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780082313; c=relaxed/simple;
	bh=w93Q6I/ztNjIIxUMl3TL2uaBjz1/kOsNSmHLJlUi9wg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AydJgL133Qo81XiMdIJr6HTe6QPen9dy8T/UaStgluKsVTmqM3bgWGTlZpwhaMzj9XdfHttkuYZ1HQUSujknn539mwWkF/1F/Xe0dyxddoyNFMCwchg2FQF1bLCZJxd+vlqzXVgSRuNxD+7Ysx5wSVUKzU2oaV7VAw7ykE0FFlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o9pUu1Jw; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36bbdcf36f0so862935a91.0
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 12:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780082311; x=1780687111; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zTL9DgWG41207XmggXJw1dEum7YINAR+DYw5PHXJVy4=;
        b=o9pUu1JwCjUh2VtcbYIXP2LW0y87vPtUh7gQd294h9Uh4CppwL+G5f280jEEEJN+U0
         xzs32l9K/57umEBtnKCucDRCZ4JH1bwqLEDaaODwIDILL9ZxF46+9ULwax1Pr0bJE4Ky
         vUlItrTfEEpv4hF6abJ8LQpvkl4VmnDkWyZ/nIS+ejAds0T/7nyMqWEyJRsKX+cuHH1j
         /MreVcgSK3P5CnENRi5Cu8rCE8h3F5hpp5tyLy5+/wtdGwejmJJnGWZsU4t9djOPY2NU
         4gIae4c6GPWc5aBJVj7GlkPihXXT9idOvg7arGz+tWRJR6H4aUI6oxt83udj486eUoq2
         RlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780082311; x=1780687111;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zTL9DgWG41207XmggXJw1dEum7YINAR+DYw5PHXJVy4=;
        b=gEMLiKw2AnzbR/iXHUPK/o2DtSpt2Enz+osuvoN5yH/LWhoMIZXSgT2ghO1xsUYlUl
         bcYJ2oHhNXcyZn8cOGE/GJ+zToMCzwS64zLcU44zCqAf+SOoom2p1y1ww3pNEfhBjJEo
         J5wmqTTiQLhMGX/ap/MuOWPzwixBfdrQ1K1vt476zlC3U7ECxM05Dj0YZ+HkQZ+WkcUN
         V7xt0cJCxh6tGXqb5klafS1AaJZs3m9jw96HCRNwZlCVGBAguazVEpYNu/y/duJ/BU67
         0E5N9I728V+eiLuUvWn0d8smnM3WwBrmrBeLA51BfGWRioUpXMF5uBbdQNMm9EEeT3Du
         7Aig==
X-Forwarded-Encrypted: i=1; AFNElJ9y67p8PtEp0bl8kU9wMl3O8T9V8gdLyIqLJ40I9mgUsIJX1r0tosIeNeqzUzTBtK9nxCNJZwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTySdpadP1gs+uXOpb681edVwHJeJhb5OxkPRAjktu8WHIL+2u
	5kDbMOUdlZ95JxNtg+qOe9S85t5qmRc/st1Mk3twWaQLUE+SGwTmN3VLgw4N7wHYu63YYYEdhRU
	FjHE9GQ==
X-Received: from pgbdo14.prod.google.com ([2002:a05:6a02:e8e:b0:c82:798f:6280])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5746:b0:35f:c493:cac5
 with SMTP id 98e67ed59e1d1-36bbe1c11f0mr4052638a91.16.1780082311190; Fri, 29
 May 2026 12:18:31 -0700 (PDT)
Date: Fri, 29 May 2026 19:18:02 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529191829.3864438-1-kuniyu@google.com>
Subject: [PATCH v1 net-next] af_unix: Remove sock->state assignment.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293211-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9A59C607D11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Both struct socket and struct sock have a variable to
manage its state, sock->state and sk->sk_state.

When both are used, the former typically manages syscall
state and the latter manages the actual connection state.

AF_UNIX only uses sk->sk_state.

Let's remove unnecessary assignemnts for sock->state.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/unix/af_unix.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index dc71ed79be4a..628191bcb48f 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1142,8 +1142,6 @@ static int unix_create(struct net *net, struct socket *sock, int protocol,
 	if (protocol && protocol != PF_UNIX)
 		return -EPROTONOSUPPORT;
 
-	sock->state = SS_UNCONNECTED;
-
 	switch (sock->type) {
 	case SOCK_STREAM:
 		set_bit(SOCK_CUSTOM_SOCKOPT, &sock->flags);
@@ -1775,7 +1773,6 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr_unsized *uad
 	/* Set credentials */
 	copy_peercred(sk, other);
 
-	sock->state	= SS_CONNECTED;
 	WRITE_ONCE(sk->sk_state, TCP_ESTABLISHED);
 	sock_hold(newsk);
 
@@ -1831,8 +1828,7 @@ static int unix_socketpair(struct socket *socka, struct socket *sockb)
 
 	ska->sk_state = TCP_ESTABLISHED;
 	skb->sk_state = TCP_ESTABLISHED;
-	socka->state  = SS_CONNECTED;
-	sockb->state  = SS_CONNECTED;
+
 	return 0;
 }
 
@@ -1874,7 +1870,6 @@ static int unix_accept(struct socket *sock, struct socket *newsock,
 	/* attach accepted sock to socket */
 	unix_state_lock(tsk);
 	unix_update_edges(unix_sk(tsk));
-	newsock->state = SS_CONNECTED;
 	sock_graft(tsk, newsock);
 	unix_state_unlock(tsk);
 	return 0;
-- 
2.54.0.823.g6e5bcc1fc9-goog


