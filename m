Return-Path: <netdev+bounces-191651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 766B2ABC8CE
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 23:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C8E178931
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 21:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9027220D51E;
	Mon, 19 May 2025 21:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="nGRpcLa5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03D71D63FC
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 21:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747688494; cv=none; b=WtOFQh1ee7vpiRUI7VrQ7TdGi4qLHJ3rD2fp2YgO/Q4KHG/vNSYTt5Kn00zMgqqS4/VLiMlEv4zDyZSeoqQT3Q7B2WPtRY3yOhLHYYo/PXX6/mPls9nT7os9LIhlbdw99g/G/Ud9EiTaSK5VIvleuGGeCvrLbcsqaYxcKMXaQT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747688494; c=relaxed/simple;
	bh=S7d+ryySp3SR06W7cn2Da1Kxl/afGt+EJk41rOAYQ38=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JvZQjESN8VInQ4m5p3XlnQz+/fJTglgQJPzP/MR+tLvCq9dh2KzUs2+BBasWOn6nXdP0Aa6CDsGm7s71prZ4v6vp0xAd6H8EBMsq/BABAmxSUaYbEClwROMxqZsHoZbNUv1fv8sG3vw0A8yzh+8MnyezyRCoiWyXwD1gDSCpIdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=nGRpcLa5; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747688494; x=1779224494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9VypavcqTfX/SFxzr3iXiBEwkOQjsrL0xaUciZ6GDmc=;
  b=nGRpcLa5llou/UIzlgRcb/fc1yBthiq0viS59sZuXBIC+lRvba8UM/ng
   vDKeSHi12ctzy6FdowxxlJN3MJVDgE5KmyG8xH5q63rTaxDEHiKGKkcQd
   XlTpQPom143pwccuWyCIM1PBFMs6QHjvrwGT1ZqpDnRPaDHNe+A8r0p62
   4CxSDSrpq3CHMRaGVqG2wXglb7QWk7jfOjdG8GE4WeUuLnkgqp9bfp61i
   CC82uBlGnRTseENk0hrxR074UTsRlVL/9C/NONiVbo+GpP32vyGo0rzvU
   ZNTOBJ4nc6cgak0BXxL0y/n8iO6cfJWUufuv6bWXCsGj7j/MwqGrksDkX
   A==;
X-IronPort-AV: E=Sophos;i="6.15,301,1739836800"; 
   d="scan'208";a="491754561"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 21:01:32 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:7469]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.26.241:2525] with esmtp (Farcaster)
 id d3e0ffcb-4658-4d82-902d-5af1fd4e1e03; Mon, 19 May 2025 21:01:30 +0000 (UTC)
X-Farcaster-Flow-ID: d3e0ffcb-4658-4d82-902d-5af1fd4e1e03
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 19 May 2025 21:01:27 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.169.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 19 May 2025 21:01:25 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v5 net-next 7/9] af_unix: Inherit sk_flags at connect().
Date: Mon, 19 May 2025 13:57:58 -0700
Message-ID: <20250519205820.66184-8-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519205820.66184-1-kuniyu@amazon.com>
References: <20250519205820.66184-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D041UWB003.ant.amazon.com (10.13.139.176) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

For SOCK_STREAM embryo sockets, the SO_PASS{CRED,PIDFD,SEC} options
are inherited from the parent listen()ing socket.

Currently, this inheritance happens at accept(), because these
attributes were stored in sk->sk_socket->flags and the struct socket
is not allocated until accept().

This leads to unintentional behaviour.

When a peer sends data to an embryo socket in the accept() queue,
unix_maybe_add_creds() embeds credentials into the skb, even if
neither the peer nor the listener has enabled these options.

If the option is enabled, the embryo socket receives the ancillary
data after accept().  If not, the data is silently discarded.

This conservative approach works for SO_PASS{CRED,PIDFD,SEC}, but
would not for SO_PASSRIGHTS; once an SCM_RIGHTS with a hung file
descriptor was sent, it'd be game over.

To avoid this, we will need to preserve SOCK_PASSRIGHTS even on embryo
sockets.

Commit aed6ecef55d7 ("af_unix: Save listener for embryo socket.")
made it possible to access the parent's flags in sendmsg() via
unix_sk(other)->listener->sk->sk_socket->flags, but this introduces
an unnecessary condition that is irrelevant for most sockets,
accept()ed sockets and clients.

Therefore, we moved SOCK_PASSXXX into struct sock.

Let’s inherit sk->sk_scm_recv_flags at connect() to avoid receiving
SCM_RIGHTS on embryo sockets created from a parent with SO_PASSRIGHTS=0.

Note that the parent socket is locked in connect() so we don't need
READ_ONCE() for sk_scm_recv_flags.

Now, we can remove !other->sk_socket check in unix_maybe_add_creds()
to avoid slow SOCK_PASS{CRED,PIDFD} handling for embryo sockets
created from a parent with SO_PASS{CRED,PIDFD}=0.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/unix/af_unix.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 27ebda4cd9b9..900bad88fbd2 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1626,10 +1626,12 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	/* The way is open! Fastly set all the necessary fields... */
 
 	sock_hold(sk);
-	unix_peer(newsk)	= sk;
-	newsk->sk_state		= TCP_ESTABLISHED;
-	newsk->sk_type		= sk->sk_type;
+	unix_peer(newsk) = sk;
+	newsk->sk_state = TCP_ESTABLISHED;
+	newsk->sk_type = sk->sk_type;
+	newsk->sk_scm_recv_flags = other->sk_scm_recv_flags;
 	init_peercred(newsk);
+
 	newu = unix_sk(newsk);
 	newu->listener = other;
 	RCU_INIT_POINTER(newsk->sk_wq, &newu->peer_wq);
@@ -1746,7 +1748,6 @@ static int unix_accept(struct socket *sock, struct socket *newsock,
 	unix_state_lock(tsk);
 	unix_update_edges(unix_sk(tsk));
 	newsock->state = SS_CONNECTED;
-	tsk->sk_scm_recv_flags = READ_ONCE(sk->sk_scm_recv_flags);
 	sock_graft(tsk, newsock);
 	unix_state_unlock(tsk);
 	return 0;
@@ -1878,8 +1879,7 @@ static void unix_maybe_add_creds(struct sk_buff *skb, const struct sock *sk,
 	if (UNIXCB(skb).pid)
 		return;
 
-	if (unix_may_passcred(sk) ||
-	    !other->sk_socket || unix_may_passcred(other)) {
+	if (unix_may_passcred(sk) || unix_may_passcred(other)) {
 		UNIXCB(skb).pid = get_pid(task_tgid(current));
 		current_uid_gid(&UNIXCB(skb).uid, &UNIXCB(skb).gid);
 	}
-- 
2.49.0


