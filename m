Return-Path: <netdev+bounces-29461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 395A47835A7
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 00:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AD951C20A31
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 22:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339A21ADF3;
	Mon, 21 Aug 2023 22:25:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C081ADFC;
	Mon, 21 Aug 2023 22:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965CEC433C8;
	Mon, 21 Aug 2023 22:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692656723;
	bh=mCFf41OAOMZ9vigTZ31U28QDeMg6gYJIm3A8aWPJDAo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Acgaf8VcVt4cmcgU8e2vvMxZ0raLlT+i3htooA+dRrcwoc0H72lpT6LAuPeSp9WNJ
	 r6FrxvHr/eOiPaGR1UObvDkeFZELvImyq+m1+2Md0U4KMwsRgyfNh7sFtHf1BRWFxa
	 /nXaKE34Q6365r6aqAIOGY6V+JjM6Mf/xtij0Yv7i79NV2N+AZASsuC13H/c8amRnj
	 HvSeWSNU8hPB3TJ0+KI1BAWd5kLhACw4zh/Lq7NqDYltJHAh0Fry7aFVlqAxmptFYV
	 Q9x6vcZ+UXOHiDJWvtIfEUJEL+QnlRcP4T7dHy5n4asHOxaU0szzls/oFHf1FAyJsy
	 1t6kSOf6bWG+w==
From: Mat Martineau <martineau@kernel.org>
Date: Mon, 21 Aug 2023 15:25:16 -0700
Subject: [PATCH net-next 05/10] mptcp: add sched in mptcp_sock
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230821-upstream-net-next-20230818-v1-5-0c860fb256a8@kernel.org>
References: <20230821-upstream-net-next-20230818-v1-0-0c860fb256a8@kernel.org>
In-Reply-To: <20230821-upstream-net-next-20230818-v1-0-0c860fb256a8@kernel.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Geliang Tang <geliang.tang@suse.com>, Mat Martineau <martineau@kernel.org>
X-Mailer: b4 0.12.3

From: Geliang Tang <geliang.tang@suse.com>

This patch adds a new struct member sched in struct mptcp_sock.
And two helpers mptcp_init_sched() and mptcp_release_sched() to
init and release it.

Init it with the sysctl scheduler in mptcp_init_sock(), copy the
scheduler from the parent in mptcp_sk_clone(), and release it in
__mptcp_destroy_sock().

Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 net/mptcp/protocol.c |  8 ++++++++
 net/mptcp/protocol.h |  4 ++++
 net/mptcp/sched.c    | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f15ff80be30f..54a3eccfa731 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2697,6 +2697,7 @@ static void mptcp_ca_reset(struct sock *sk)
 static int mptcp_init_sock(struct sock *sk)
 {
 	struct net *net = sock_net(sk);
+	int ret;
 
 	__mptcp_init_sock(sk);
 
@@ -2706,6 +2707,11 @@ static int mptcp_init_sock(struct sock *sk)
 	if (unlikely(!net->mib.mptcp_statistics) && !mptcp_mib_alloc(net))
 		return -ENOMEM;
 
+	ret = mptcp_init_sched(mptcp_sk(sk),
+			       mptcp_sched_find(mptcp_get_scheduler(net)));
+	if (ret)
+		return ret;
+
 	set_bit(SOCK_CUSTOM_SOCKOPT, &sk->sk_socket->flags);
 
 	/* fetch the ca name; do it outside __mptcp_init_sock(), so that clone will
@@ -2851,6 +2857,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	mptcp_stop_timer(sk);
 	sk_stop_timer(sk, &sk->sk_timer);
 	msk->pm.status = 0;
+	mptcp_release_sched(msk);
 
 	sk->sk_prot->destroy(sk);
 
@@ -3105,6 +3112,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	msk->snd_una = msk->write_seq;
 	msk->wnd_end = msk->snd_nxt + req->rsk_rcv_wnd;
 	msk->setsockopt_seq = mptcp_sk(sk)->setsockopt_seq;
+	mptcp_init_sched(msk, mptcp_sk(sk)->sched);
 
 	/* passive msk is created after the first/MPC subflow */
 	msk->subflow_id = 2;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bfa13a50f276..548c302a757e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -312,6 +312,7 @@ struct mptcp_sock {
 				 * lock as such sock is freed after close().
 				 */
 	struct mptcp_pm_data	pm;
+	struct mptcp_sched_ops	*sched;
 	struct {
 		u32	space;	/* bytes copied in last measurement window */
 		u32	copied; /* bytes copied in this measurement window */
@@ -659,6 +660,9 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
 struct mptcp_sched_ops *mptcp_sched_find(const char *name);
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
+int mptcp_init_sched(struct mptcp_sock *msk,
+		     struct mptcp_sched_ops *sched);
+void mptcp_release_sched(struct mptcp_sock *msk);
 
 static inline bool __tcp_can_send(const struct sock *ssk)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index c5d3bbafba71..53773668b5ee 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -54,3 +54,36 @@ void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched)
 	list_del_rcu(&sched->list);
 	spin_unlock(&mptcp_sched_list_lock);
 }
+
+int mptcp_init_sched(struct mptcp_sock *msk,
+		     struct mptcp_sched_ops *sched)
+{
+	if (!sched)
+		goto out;
+
+	if (!bpf_try_module_get(sched, sched->owner))
+		return -EBUSY;
+
+	msk->sched = sched;
+	if (msk->sched->init)
+		msk->sched->init(msk);
+
+	pr_debug("sched=%s", msk->sched->name);
+
+out:
+	return 0;
+}
+
+void mptcp_release_sched(struct mptcp_sock *msk)
+{
+	struct mptcp_sched_ops *sched = msk->sched;
+
+	if (!sched)
+		return;
+
+	msk->sched = NULL;
+	if (sched->release)
+		sched->release(msk);
+
+	bpf_module_put(sched, sched->owner);
+}

-- 
2.41.0


