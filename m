Return-Path: <netdev+bounces-29458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2337835A0
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 00:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D814D280F3F
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 22:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFC71BB3B;
	Mon, 21 Aug 2023 22:25:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C1318AE5;
	Mon, 21 Aug 2023 22:25:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAAF2C433CC;
	Mon, 21 Aug 2023 22:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692656723;
	bh=EtjkMo5Utfqyb2HvZTJ81wkGvDCfsqeXl+lqQcBmj0I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vK/16cRIZTOf1gUU0TMhI0AXu3D9oHzRBO3GIJkMsbmoA7pNJ8S02nvP4j0Q6mJEZ
	 YSdrnUrkJYvWlMSSONZ0osbaSgI7zOgwSohZdJiMkOGg3gBB6baNzED9dBRwyBROjJ
	 WZOYIk0DaPQJuI1QuFuJtMMU/UdCUJnqe01kIANieTA6Dj2WvXbzF2BreJFu+hf/SP
	 X2oXKDbknliN3GaZLEhLh3MHEYx+cvvv0W1mxD45dnrvcRvYm8L8hlkRkKKsfs76f1
	 BLABacmaKBxw+u/DrUbQExVhuH75QuF1A7HuxJ7xoC0GdQd+TuEx8yZ/ew61H4spKe
	 KPhkrkukT21gQ==
From: Mat Martineau <martineau@kernel.org>
Date: Mon, 21 Aug 2023 15:25:13 -0700
Subject: [PATCH net-next 02/10] mptcp: drop last_snd and
 MPTCP_RESET_SCHEDULER
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230821-upstream-net-next-20230818-v1-2-0c860fb256a8@kernel.org>
References: <20230821-upstream-net-next-20230818-v1-0-0c860fb256a8@kernel.org>
In-Reply-To: <20230821-upstream-net-next-20230818-v1-0-0c860fb256a8@kernel.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Geliang Tang <geliang.tang@suse.com>, Mat Martineau <martineau@kernel.org>
X-Mailer: b4 0.12.3

From: Geliang Tang <geliang.tang@suse.com>

Since the burst check conditions have moved out of the function
mptcp_subflow_get_send(), it makes all msk->last_snd useless.
This patch drops them as well as the macro MPTCP_RESET_SCHEDULER.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 net/mptcp/pm.c         |  9 +--------
 net/mptcp/pm_netlink.c |  3 ---
 net/mptcp/protocol.c   | 11 +----------
 net/mptcp/protocol.h   |  2 --
 4 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 7dbbad1e4f55..d8da5374d9e1 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -299,15 +299,8 @@ void mptcp_pm_mp_prio_received(struct sock *ssk, u8 bkup)
 
 	pr_debug("subflow->backup=%d, bkup=%d\n", subflow->backup, bkup);
 	msk = mptcp_sk(sk);
-	if (subflow->backup != bkup) {
+	if (subflow->backup != bkup)
 		subflow->backup = bkup;
-		mptcp_data_lock(sk);
-		if (!sock_owned_by_user(sk))
-			msk->last_snd = NULL;
-		else
-			__set_bit(MPTCP_RESET_SCHEDULER,  &msk->cb_flags);
-		mptcp_data_unlock(sk);
-	}
 
 	mptcp_event(MPTCP_EVENT_SUB_PRIORITY, msk, ssk, GFP_ATOMIC);
 }
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index c75d9d88a053..9661f3812682 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -472,9 +472,6 @@ static void __mptcp_pm_send_ack(struct mptcp_sock *msk, struct mptcp_subflow_con
 
 	slow = lock_sock_fast(ssk);
 	if (prio) {
-		if (subflow->backup != backup)
-			msk->last_snd = NULL;
-
 		subflow->send_mp_prio = 1;
 		subflow->backup = backup;
 		subflow->request_bkup = backup;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 29c662ffcd05..f15ff80be30f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1438,16 +1438,13 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 
 	burst = min_t(int, MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
 	wmem = READ_ONCE(ssk->sk_wmem_queued);
-	if (!burst) {
-		msk->last_snd = NULL;
+	if (!burst)
 		return ssk;
-	}
 
 	subflow = mptcp_subflow_ctx(ssk);
 	subflow->avg_pacing_rate = div_u64((u64)subflow->avg_pacing_rate * wmem +
 					   READ_ONCE(ssk->sk_pacing_rate) * burst,
 					   burst + wmem);
-	msk->last_snd = ssk;
 	msk->snd_burst = burst;
 	return ssk;
 }
@@ -2379,9 +2376,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		WRITE_ONCE(msk->first, NULL);
 
 out:
-	if (ssk == msk->last_snd)
-		msk->last_snd = NULL;
-
 	if (need_push)
 		__mptcp_push_pending(sk, 0);
 }
@@ -3046,7 +3040,6 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	 * subflow
 	 */
 	mptcp_destroy_common(msk, MPTCP_CF_FASTCLOSE);
-	msk->last_snd = NULL;
 	WRITE_ONCE(msk->flags, 0);
 	msk->cb_flags = 0;
 	msk->push_pending = 0;
@@ -3316,8 +3309,6 @@ static void mptcp_release_cb(struct sock *sk)
 			__mptcp_set_connected(sk);
 		if (__test_and_clear_bit(MPTCP_ERROR_REPORT, &msk->cb_flags))
 			__mptcp_error_report(sk);
-		if (__test_and_clear_bit(MPTCP_RESET_SCHEDULER, &msk->cb_flags))
-			msk->last_snd = NULL;
 	}
 
 	__mptcp_update_rmem(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 38c7ea013361..cbf9a9e176b2 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -123,7 +123,6 @@
 #define MPTCP_RETRANSMIT	4
 #define MPTCP_FLUSH_JOIN_LIST	5
 #define MPTCP_CONNECTED		6
-#define MPTCP_RESET_SCHEDULER	7
 
 struct mptcp_skb_cb {
 	u64 map_seq;
@@ -269,7 +268,6 @@ struct mptcp_sock {
 	u64		rcv_data_fin_seq;
 	u64		bytes_retrans;
 	int		rmem_fwd_alloc;
-	struct sock	*last_snd;
 	int		snd_burst;
 	int		old_wspace;
 	u64		recovery_snd_nxt;	/* in recovery mode accept up to this seq;

-- 
2.41.0


