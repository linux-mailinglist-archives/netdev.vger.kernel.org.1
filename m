Return-Path: <netdev+bounces-43646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E1B7D4133
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 22:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C6C8280D45
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 20:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EFF224ED;
	Mon, 23 Oct 2023 20:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1wWymDL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555F921367;
	Mon, 23 Oct 2023 20:45:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DC5C433BF;
	Mon, 23 Oct 2023 20:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698093934;
	bh=nyM3qAj+dX1T3E9H0rifWU8fe8+YDlZJN+C5xNnbe3k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=I1wWymDL3fU0T+6vNwsjqY0DkcksJ9N4aeDmHX/AhfE48rRuu5PqJPgvdrTejr0tJ
	 FUduwY8o4JXaqn/lQCiJcHmrftQmaWeRs56F3/Q/AbcaDRVaoqe1vhl4mDfE+drBkS
	 Rqga52dP/JCnkpsJSdoGSrqY4m30iU4vbt23Pp9lfDY8zJY2O6MEG7/e5fJIKWw36K
	 Fmsr9Y19FDES/dp8aWwjuLRK8g/sQOhpLAfJPy5b36gAwGrCYNPXjr2c2kB6kQ2/q6
	 cWm5pEt3zA9TuQy/E6+S8HV9M4pBy0ey9HJ+yXmK0o5qUfhWUHfbfS5M94By44F/Iq
	 ui/CP9Li3iJIQ==
From: Mat Martineau <martineau@kernel.org>
Date: Mon, 23 Oct 2023 13:44:40 -0700
Subject: [PATCH net-next 7/9] mptcp: consolidate sockopt synchronization
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-send-net-next-20231023-2-v1-7-9dc60939d371@kernel.org>
References: <20231023-send-net-next-20231023-2-v1-0-9dc60939d371@kernel.org>
In-Reply-To: <20231023-send-net-next-20231023-2-v1-0-9dc60939d371@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>
X-Mailer: b4 0.12.4

From: Paolo Abeni <pabeni@redhat.com>

Move the socket option synchronization for active subflows
at subflow creation time. This allows removing the now unused
unlocked variant of such helper.

While at that, clean-up a bit the mptcp_subflow_create_socket()
errors path.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 net/mptcp/protocol.c |  2 --
 net/mptcp/sockopt.c  | 22 ----------------------
 net/mptcp/subflow.c  | 18 +++++++++---------
 3 files changed, 9 insertions(+), 33 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5489f024dd7e..e44a3da12b96 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -121,8 +121,6 @@ struct sock *__mptcp_nmpc_sk(struct mptcp_sock *msk)
 		ret = __mptcp_socket_create(msk);
 		if (ret)
 			return ERR_PTR(ret);
-
-		mptcp_sockopt_sync(msk, msk->first);
 	}
 
 	return msk->first;
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index d15891e23f45..abf0645cb65d 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1444,28 +1444,6 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));
 }
 
-static void __mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk)
-{
-	bool slow = lock_sock_fast(ssk);
-
-	sync_socket_options(msk, ssk);
-
-	unlock_sock_fast(ssk, slow);
-}
-
-void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk)
-{
-	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
-
-	msk_owned_by_me(msk);
-
-	if (READ_ONCE(subflow->setsockopt_seq) != msk->setsockopt_seq) {
-		__mptcp_sockopt_sync(msk, ssk);
-
-		subflow->setsockopt_seq = msk->setsockopt_seq;
-	}
-}
-
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 080b16426222..df208666fd19 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1533,8 +1533,6 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	if (addr.ss_family == AF_INET6)
 		addrlen = sizeof(struct sockaddr_in6);
 #endif
-	mptcp_sockopt_sync(msk, ssk);
-
 	ssk->sk_bound_dev_if = ifindex;
 	err = kernel_bind(sf, (struct sockaddr *)&addr, addrlen);
 	if (err)
@@ -1645,7 +1643,7 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 
 	err = security_mptcp_add_subflow(sk, sf->sk);
 	if (err)
-		goto release_ssk;
+		goto err_free;
 
 	/* the newly created socket has to be in the same cgroup as its parent */
 	mptcp_attach_cgroup(sk, sf->sk);
@@ -1659,15 +1657,12 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 	get_net_track(net, &sf->sk->ns_tracker, GFP_KERNEL);
 	sock_inuse_add(net, 1);
 	err = tcp_set_ulp(sf->sk, "mptcp");
+	if (err)
+		goto err_free;
 
-release_ssk:
+	mptcp_sockopt_sync_locked(mptcp_sk(sk), sf->sk);
 	release_sock(sf->sk);
 
-	if (err) {
-		sock_release(sf);
-		return err;
-	}
-
 	/* the newly created socket really belongs to the owning MPTCP master
 	 * socket, even if for additional subflows the allocation is performed
 	 * by a kernel workqueue. Adjust inode references, so that the
@@ -1687,6 +1682,11 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 	mptcp_subflow_ops_override(sf->sk);
 
 	return 0;
+
+err_free:
+	release_sock(sf->sk);
+	sock_release(sf);
+	return err;
 }
 
 static struct mptcp_subflow_context *subflow_create_ctx(struct sock *sk,

-- 
2.41.0


