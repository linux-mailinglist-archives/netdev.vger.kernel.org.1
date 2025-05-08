Return-Path: <netdev+bounces-188839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D766AAF0A5
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 03:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88D34C640B
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 01:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94EC1957FF;
	Thu,  8 May 2025 01:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="OAU2B5Pe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A8733FD
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 01:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746667955; cv=none; b=megfbp995CbfsNfSvCGL9QH8yC5VGehzZaloe7dDcPfWa0vx31Gu9hNajeKueOA6HH2bFECLfw7d66Gel0jIDoUCbvZ6Gie6J6VC9ZS4DCAoGbb+huF5O8wr/6b7pW+o3XCPPbxXPNtHnuO3+NxsxsTWbWHpyFfDo9cvKJrJhIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746667955; c=relaxed/simple;
	bh=l5Fe4b53RUa2x8AQblzAjds3S6XRqG6sBTivf1w7RoY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LskoOj2dStpzcrgbYGnYRMwnbvUuEyXjJa+8thID8QY2KoJijDTgK/ybG/X6NrzqLcaPR+Eo5lTgDuXhKtnocXVa8AKYfWkNRI9hh/n75QZfkNP6Cb8vwc6WCqM3hFjZCxjRxShwQ5Uma+n37GYg3VskokP6OQyqPLUkwAizBg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=OAU2B5Pe; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1746667954; x=1778203954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O7nYqoAuyXVIRinZMA8Y397S1VfF9mKD1ivcTgRU2gA=;
  b=OAU2B5Pe7MR0TWEaCyqWJIau9chUJ7yCEse+mZqwpCPCf635U+pdMX9O
   u5tAiunFgMyugJ4d/upELXihkbKl6O9RRfvYVJiZScSNLKjtbLy+HjykJ
   Zavs6dXDEz62Jtfu8CALD9gAAv+k4fcBuACHKlTNtML3hzwulCytyiqTJ
   z+q7RldrpsdaxhDesUOFHNY1bNeNN9QR7M89en1h6kzrb6OVDjpVN+dFj
   KFWO3gImeUYRTImZJySa/L5nohqDDeEtOIqnZVnvyWEHSxrZmPm4p+vCe
   2HkrbtZ9JlGT78HA23msM1KGNG5Io5IvnKQiagxAo7E5/sFH4vtkNd/xL
   g==;
X-IronPort-AV: E=Sophos;i="6.15,271,1739836800"; 
   d="scan'208";a="194693138"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 01:32:33 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:25085]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.92:2525] with esmtp (Farcaster)
 id 9dd3ad5c-6127-418e-9fa2-b952b3634dc1; Thu, 8 May 2025 01:32:33 +0000 (UTC)
X-Farcaster-Flow-ID: 9dd3ad5c-6127-418e-9fa2-b952b3634dc1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 8 May 2025 01:32:33 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.46.110) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 8 May 2025 01:32:30 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 5/7] af_unix: Inherit sk_flags at connect().
Date: Wed, 7 May 2025 18:29:17 -0700
Message-ID: <20250508013021.79654-6-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508013021.79654-1-kuniyu@amazon.com>
References: <20250508013021.79654-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

For SOCK_STREAM embryo sockets, the SO_PASS{CRED,PIDFD,SEC} options
are inherited from the parent listen()ing socket.

Currently, this inheritance happens at accept(), because these
attributes were stored in sk->sk_socket->flags and the struct socket
is not allocated until accept().

This leads to unintentional behaviour.

When a peer sends data to an embryo socket in the accept() queue,
maybe_add_creds() embeds credentials into the skb, even if neither
the peer nor the listener has enabled these options.

If the option is enabled, the embryo socket receives the ancillary
data after accept().  If not, the data is silently discarded.

This conservative approach works for SO_PASS{CRED,PIDFD,SEC}, but not
for SO_PASSRIGHTS; once an SCM_RIGHTS with a hung file descriptor is
sent, it’s game over.

To avoid this, we will need to preserve SOCK_PASSRIGHTS even on embryo
sockets.

A recent change made it possible to access the parent's flags in
sendmsg() via unix_sk(other)->listener->sk->sk_socket->flags, but
this introduces an unnecessary condition that is irrelevant for
most sockets (i.e., accepted sockets and clients).

Therefore, we moved SOCK_PASSXXX into sk->sk_flags, which does not
depend on struct socket.

Let’s inherit sk->sk_flags at connect() to avoid receiving SCM_RIGHTS
on embryo sockets created from a parent with SO_PASSRIGHTS=0.

While at it, whitespace issues around pid assignment have been fixed.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index e793e55f6c9b..daa7a8ead243 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1631,6 +1631,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	newsk->sk_state		= TCP_ESTABLISHED;
 	newsk->sk_type		= sk->sk_type;
 	init_peercred(newsk);
+	sock_copy_flags(newsk, other);
 	newu = unix_sk(newsk);
 	newu->listener = other;
 	RCU_INIT_POINTER(newsk->sk_wq, &newu->peer_wq);
@@ -1747,7 +1748,6 @@ static int unix_accept(struct socket *sock, struct socket *newsock,
 	unix_state_lock(tsk);
 	unix_update_edges(unix_sk(tsk));
 	newsock->state = SS_CONNECTED;
-	sock_copy_flags(tsk, sk);
 	sock_graft(tsk, newsock);
 	unix_state_unlock(tsk);
 	return 0;
@@ -1856,7 +1856,7 @@ static int unix_scm_to_skb(struct scm_cookie *scm, struct sk_buff *skb, bool sen
 {
 	int err = 0;
 
-	UNIXCB(skb).pid  = get_pid(scm->pid);
+	UNIXCB(skb).pid = get_pid(scm->pid);
 	UNIXCB(skb).uid = scm->creds.uid;
 	UNIXCB(skb).gid = scm->creds.gid;
 	UNIXCB(skb).fp = NULL;
@@ -1879,9 +1879,8 @@ static void maybe_add_creds(struct sk_buff *skb, const struct sock *sk,
 	if (UNIXCB(skb).pid)
 		return;
 
-	if (unix_passcred_enabled(sk) ||
-	    !other->sk_socket || unix_passcred_enabled(other)) {
-		UNIXCB(skb).pid  = get_pid(task_tgid(current));
+	if (unix_passcred_enabled(sk) || unix_passcred_enabled(other)) {
+		UNIXCB(skb).pid = get_pid(task_tgid(current));
 		current_uid_gid(&UNIXCB(skb).uid, &UNIXCB(skb).gid);
 	}
 }
-- 
2.49.0


