Return-Path: <netdev+bounces-190509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E87CAB7206
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 18:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A6454A01A9
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 16:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C34927C15B;
	Wed, 14 May 2025 16:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZNNRROlB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFCF1991CF
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 16:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747241737; cv=none; b=bdFfYGzfX0550MUnEBnpFrTCiumYAWubR1nIYm4iDSkqwSt5zLIspwbjKnU7ufjZ3ZTu7slHCnrFXw0zF9HdznLsOe2Makrbh2RJAjU0KiCldyQQSz420DSPHSNeGEoaHlpnKp01Z6x1RXHW066zzuNjJkMqrJ+zyw+1TDmNyAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747241737; c=relaxed/simple;
	bh=ivgm5Vw0klAreMJpn0rWdyhPRW1GmSBtrQkFpLCa5ec=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t6V9SToTnjz+PL6AReFQ7hryPf1jUo9Z9mOoA/x52AGDBOCIMfpvpVvzuZy1V2qJw1wCcHTvHkM3GkJlAi/MDmhzB1si4vHJGT3y17zyjUxiKxQd4IPKEPcW9u/4h6of6S127KLh1Yi3FcQW93qVL/JcEie6WN6kZUXQly6lGDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZNNRROlB; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747241735; x=1778777735;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lhCzgOeCiIHeCXgoRaskVD3yL0hDV21kEmmeITbyLpM=;
  b=ZNNRROlBhmoOCbjtoOXt+huWj3bXWvvskbsMH/IOotFHSplYkSQYljhA
   ydwrbEv8n82siYbBceX1HQ4y0CxR7RhVi35TUTnUCS91saG1xWIQcEa4x
   9Md6M5S2uOcdVYqW3obWJQXOhwD5b+irhrhblWU9e0GAm5zOB/RN3nn70
   QcJXuT3ggWt9bT8OKfSv76GA8sl21BcyZdyQqxljUSlqXsQ0ljtI99u4M
   HOW62OVP3/bUQQvJNeoFCgh5OYABYC2/bg5axASZFnbS0rGw91THXT9gV
   NlzPyaxikM+l+MZmRArwSYLjQGgOliY4GNPAu+gkR/5vuPzOPpXfBKPxF
   A==;
X-IronPort-AV: E=Sophos;i="6.15,288,1739836800"; 
   d="scan'208";a="19769463"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 16:55:29 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:45494]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.50:2525] with esmtp (Farcaster)
 id 9a7c2d4a-85d1-4101-8eff-25b476db249f; Wed, 14 May 2025 16:55:29 +0000 (UTC)
X-Farcaster-Flow-ID: 9a7c2d4a-85d1-4101-8eff-25b476db249f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 14 May 2025 16:55:28 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 14 May 2025 16:55:26 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 7/9] af_unix: Inherit sk_flags at connect().
Date: Wed, 14 May 2025 09:51:50 -0700
Message-ID: <20250514165226.40410-8-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514165226.40410-1-kuniyu@amazon.com>
References: <20250514165226.40410-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D045UWA003.ant.amazon.com (10.13.139.46) To
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


