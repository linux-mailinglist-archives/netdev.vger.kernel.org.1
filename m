Return-Path: <netdev+bounces-189435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71913AB20EE
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 04:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9DC34E1C57
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 02:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94627267AF2;
	Sat, 10 May 2025 02:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="P9zTfp6M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C33267729
	for <netdev@vger.kernel.org>; Sat, 10 May 2025 01:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746842402; cv=none; b=qG5H3A3rNm/zURNrx8ghMtvN6uqD8IpV8/ZmswK4FZOjsxnTo1B05CQxwEFpxSPPZP/dVb+pvkFCrh/chcNXy2hLmWlDmpzruwnfibE8hvHFLz5kP9ITh7ngFQw4MX/rm5AzMqHUWBLzkTgJB2TpnT0LzF9GjjZDHzxsGzCk/OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746842402; c=relaxed/simple;
	bh=n/gS72uSjH4PHQmZE8fxX/CCIzVZBVDf1pjqhdW77ow=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GvWnuOVkxFqUAYnKdMp1HfnUy1oCu51WsQgld6a+lFNSlYoDuTgeuvNWV1v/FxavmI2wchEs6H3H/lF9SQY6hegLvkfgn5s92jPV9Vne/p741206kDWlG1RmgfkunQEXlZWZDcN18pygED/uVvTK0CbLSWz4O2XRy4DdMyHfFOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=P9zTfp6M; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1746842401; x=1778378401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HlSKhElWpev6fXoaXW5NhbWtS03BA39AHNEQ1ngmfEw=;
  b=P9zTfp6MIURJvk5q1LaVZODOmOri3luaUlq2/xmFmqR1S6VldWmGS5Zj
   IrbBIuQGzQxj/0oPm9lzLYBtEoWNXQi5ujze/0DFt8PSlkkzJUeHoijG5
   c+sGn9jq4V/y8JZ605iokcR418LifAjSoBjWcXIsnns3dYX+TKwh3ftfT
   6fEJvSvAcwJu2vko6c7hZTaJNbYfOeadt7hwrOPa7c+mFK7lQlxvHzD9D
   VvHvENhJf7sxtxu691iRM4BxrQwLd1b5896b747pA6cBTegWFDJMZEdAL
   LUozU6W6uUZYIk4lNxpHZkBkPqUEnCqKZTRW7M1PA2AdMfgI0VC6m/tTt
   g==;
X-IronPort-AV: E=Sophos;i="6.15,276,1739836800"; 
   d="scan'208";a="403791719"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 01:59:58 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:63525]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.224:2525] with esmtp (Farcaster)
 id 0b18c067-fa09-4794-9b59-0f972496bc92; Sat, 10 May 2025 01:59:58 +0000 (UTC)
X-Farcaster-Flow-ID: 0b18c067-fa09-4794-9b59-0f972496bc92
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 10 May 2025 01:59:57 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 10 May 2025 01:59:54 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 7/9] af_unix: Inherit sk_flags at connect().
Date: Fri, 9 May 2025 18:56:30 -0700
Message-ID: <20250510015652.9931-8-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250510015652.9931-1-kuniyu@amazon.com>
References: <20250510015652.9931-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D042UWB003.ant.amazon.com (10.13.139.135) To
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

This conservative approach works for SO_PASS{CRED,PIDFD,SEC}, but not
for SO_PASSRIGHTS; once an SCM_RIGHTS with a hung file descriptor is
sent, it’s game over.

To avoid this, we will need to preserve SOCK_PASSRIGHTS even on embryo
sockets.

A recent change made it possible to access the parent's flags in
sendmsg() via unix_sk(other)->listener->sk->sk_socket->flags, but
this introduces an unnecessary condition that is irrelevant for
most sockets, accept()ed sockets and clients.

Therefore, we moved SOCK_PASSXXX into struct sock.

Let’s inherit sk->sk_scm_recv_flags at connect() to avoid receiving
SCM_RIGHTS on embryo sockets created from a parent with SO_PASSRIGHTS=0.

Now, we can remove !other->sk_socket check in unix_maybe_add_creds()
to avoid slow SOCK_PASS{CRED,PIDFD} handling for embryo sockets
created from a parent with SO_PASS{CRED,PIDFD}=0.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 83436297b0b3..ba52fc36f9be 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1626,10 +1626,12 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	/* The way is open! Fastly set all the necessary fields... */
 
 	sock_hold(sk);
-	unix_peer(newsk)	= sk;
-	newsk->sk_state		= TCP_ESTABLISHED;
-	newsk->sk_type		= sk->sk_type;
+	unix_peer(newsk) =sk;
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
-	tsk->sk_scm_recv_flags = sk->sk_scm_recv_flags;
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


