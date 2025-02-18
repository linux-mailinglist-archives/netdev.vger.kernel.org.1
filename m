Return-Path: <netdev+bounces-167463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC440A3A5C0
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 19:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2063169A13
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 18:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DB21F585E;
	Tue, 18 Feb 2025 18:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmXOXYgG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B38C1F585B;
	Tue, 18 Feb 2025 18:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739903802; cv=none; b=Hb0UZlQFT7/m24YL6+mGS/aR35JSOeuCYHT5KlHhq3sCXxb9IoaVg75FClwb4XigN7A+ZE4ar9FWOrjkdrDrhCWtC6tmk/aQJ51n1C3NdBQwyfsCo9qZDH3XoDWHotJ9oUXwTrKEJUVnmH5C4RaAuuuI8fyLP/cvloipO2KWJO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739903802; c=relaxed/simple;
	bh=OoEmchlQBBotC5o70iyC1CwCPNurWZ6JNiqtCzdY7Ws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lypTP0a8OQ1htomv4YkBqHsAYvlMGwlWDSAQCCzY/igTOSpidLqKOgyPbAzSNzNqlBTodsIEjtredo9M10Prvyra/3OmGFXn1Bg9Y3CvkILYUgMlfjEXpTg97hv2SH5ZDkBDtwQ6240lfgZ+c/mx65/OqnHbTME5CNT2Lwjv7Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmXOXYgG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973B8C4CEE2;
	Tue, 18 Feb 2025 18:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739903801;
	bh=OoEmchlQBBotC5o70iyC1CwCPNurWZ6JNiqtCzdY7Ws=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FmXOXYgG5F/9gWkBrgA7YhMb8jEVRbVFSQB5Gx+ffUjJIA4Q8bJ7ofwhpj7hTvFpV
	 GNqTmM7LnivKyszB5CT4sBYJnSxRGjm1MCQjmxuzC+jehahjw4cKrAe1SyQBcIQWbj
	 TDVDTsoU4j564dDlY7owPNGRdcEurpTfvnIXAyzAbjtPLeShYO8QKnM0vSsVlQKU88
	 WPdb8CntBKaOu684Z6CFStRGhH95RT6mWjykw4P9vSckqNRrPmySwuHQzc8CpqKiNe
	 uHblHAfrixb0WkCQusX5BJF0ZutYW5JDyiXsNwwNWkga4bcmiuLj3N0q1l1cEASvRN
	 h2lPggPpvYQfw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 18 Feb 2025 19:36:15 +0100
Subject: [PATCH net-next 4/7] mptcp: cleanup mem accounting
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-net-next-mptcp-rx-path-refactor-v1-4-4a47d90d7998@kernel.org>
References: <20250218-net-next-mptcp-rx-path-refactor-v1-0-4a47d90d7998@kernel.org>
In-Reply-To: <20250218-net-next-mptcp-rx-path-refactor-v1-0-4a47d90d7998@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
 Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9614; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=nH6TbZ5V5qQ8waWiktorcZY2CmpT15tov8l5vC4mv4w=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBntNMnJOFs2Jj+z1+zpnXC4sNW8qFmbPHS4cKev
 9Ihdti/jfSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ7TTJwAKCRD2t4JPQmmg
 cwAkEADOPpslPpgdDoDz+9BQ2gZLK5XioxOiTRRCO/fNb1YX/gSwiS5O/Sbwq6ECQw79B+H3Y7z
 KV22bDUv0lL98m1971Rm/USGLmoEcaYBs0bhlIUGAq+Rr1+DOZG64o6p34W3qgv05oxdxAelLgn
 2sQ1IOEelqfQjm4qk6M6/mx4zndcAZF56XCpxH6YzFS4hp8CfQDAnEqgLQ8vBIASWbwW02IeSX7
 ySx8xxSiWKiFfOAoBmya6Xr2ifG0Vj+OXKyZiPo9oQqt8nUv/sZFFWEdqryYNM/Uin4SgO2oGcg
 Cjl9cd1bzs2gMo2FmOV+6UMIHsUef56Iz9UmHgH5SHGvrWWVTOJJOL1IhT56pK/aSIx1WslZg3o
 veudCoFr3TiAs8SEWr/y3m3AnncD1HT9aCcfBDC2BTpwt7myiD2Nsq2eaQXfDwEsx03yWnNhqLZ
 aF5YQEpeoKywzpuNZz0C8dpJIbCCLYcAmr8EdEEo+vyayyY8eQ9ZSs3Faak+aEvzBIDputXPMJe
 Cj/5ivwOU4FwSteTge5i546ZbyT6ouMGp5TqJJJJP3+uS+G6+lk7jHyRlR/+Ahey8EuOTXTUD52
 aBYrMa16xGoY2lvR4Artn18Tzs1jBsPw0HzZrd7NyDfvlGoEVLQ07PDASkDzSvS4ERyJo8IUBFu
 MwPax0mduj+eIlw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

After the previous patch, updating sk_forward_memory is cheap and
we can drop a lot of complexity from the MPTCP memory accounting,
removing the custom fwd mem allocations for rmem.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/fastopen.c |   2 +-
 net/mptcp/protocol.c | 115 ++++-----------------------------------------------
 net/mptcp/protocol.h |   4 +-
 3 files changed, 10 insertions(+), 111 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index f85ad19f3dd6c4bcbf31228054ccfd30755db5bc..b9e4511979028c10d232efbcaca68400fc4f2e7a 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -50,7 +50,7 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	mptcp_data_lock(sk);
 	DEBUG_NET_WARN_ON_ONCE(sock_owned_by_user_nocheck(sk));
 
-	mptcp_set_owner_r(skb, sk);
+	skb_set_owner_r(skb, sk);
 	__skb_queue_tail(&sk->sk_receive_queue, skb);
 	mptcp_sk(sk)->bytes_received += skb->len;
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8bdc7a7a58f31ac74d6a2156b2297af9cd90c635..080877f8daf7e3ff36531f3e11079d2163676f2d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -118,17 +118,6 @@ static void mptcp_drop(struct sock *sk, struct sk_buff *skb)
 	__kfree_skb(skb);
 }
 
-static void mptcp_rmem_fwd_alloc_add(struct sock *sk, int size)
-{
-	WRITE_ONCE(mptcp_sk(sk)->rmem_fwd_alloc,
-		   mptcp_sk(sk)->rmem_fwd_alloc + size);
-}
-
-static void mptcp_rmem_charge(struct sock *sk, int size)
-{
-	mptcp_rmem_fwd_alloc_add(sk, -size);
-}
-
 static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 			       struct sk_buff *from)
 {
@@ -151,7 +140,7 @@ static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 	 * negative one
 	 */
 	atomic_add(delta, &sk->sk_rmem_alloc);
-	mptcp_rmem_charge(sk, delta);
+	sk_mem_charge(sk, delta);
 	kfree_skb_partial(from, fragstolen);
 
 	return true;
@@ -166,44 +155,6 @@ static bool mptcp_ooo_try_coalesce(struct mptcp_sock *msk, struct sk_buff *to,
 	return mptcp_try_coalesce((struct sock *)msk, to, from);
 }
 
-static void __mptcp_rmem_reclaim(struct sock *sk, int amount)
-{
-	amount >>= PAGE_SHIFT;
-	mptcp_rmem_charge(sk, amount << PAGE_SHIFT);
-	__sk_mem_reduce_allocated(sk, amount);
-}
-
-static void mptcp_rmem_uncharge(struct sock *sk, int size)
-{
-	struct mptcp_sock *msk = mptcp_sk(sk);
-	int reclaimable;
-
-	mptcp_rmem_fwd_alloc_add(sk, size);
-	reclaimable = msk->rmem_fwd_alloc - sk_unused_reserved_mem(sk);
-
-	/* see sk_mem_uncharge() for the rationale behind the following schema */
-	if (unlikely(reclaimable >= PAGE_SIZE))
-		__mptcp_rmem_reclaim(sk, reclaimable);
-}
-
-static void mptcp_rfree(struct sk_buff *skb)
-{
-	unsigned int len = skb->truesize;
-	struct sock *sk = skb->sk;
-
-	atomic_sub(len, &sk->sk_rmem_alloc);
-	mptcp_rmem_uncharge(sk, len);
-}
-
-void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk)
-{
-	skb_orphan(skb);
-	skb->sk = sk;
-	skb->destructor = mptcp_rfree;
-	atomic_add(skb->truesize, &sk->sk_rmem_alloc);
-	mptcp_rmem_charge(sk, skb->truesize);
-}
-
 /* "inspired" by tcp_data_queue_ofo(), main differences:
  * - use mptcp seqs
  * - don't cope with sacks
@@ -316,25 +267,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 
 end:
 	skb_condense(skb);
-	mptcp_set_owner_r(skb, sk);
-}
-
-static bool mptcp_rmem_schedule(struct sock *sk, struct sock *ssk, int size)
-{
-	struct mptcp_sock *msk = mptcp_sk(sk);
-	int amt, amount;
-
-	if (size <= msk->rmem_fwd_alloc)
-		return true;
-
-	size -= msk->rmem_fwd_alloc;
-	amt = sk_mem_pages(size);
-	amount = amt << PAGE_SHIFT;
-	if (!__sk_mem_raise_allocated(sk, size, amt, SK_MEM_RECV))
-		return false;
-
-	mptcp_rmem_fwd_alloc_add(sk, amount);
-	return true;
+	skb_set_owner_r(skb, sk);
 }
 
 static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
@@ -352,7 +285,7 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
 	skb_orphan(skb);
 
 	/* try to fetch required memory from subflow */
-	if (!mptcp_rmem_schedule(sk, ssk, skb->truesize)) {
+	if (!sk_rmem_schedule(sk, skb, skb->truesize)) {
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
 		goto drop;
 	}
@@ -377,7 +310,7 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
 		if (tail && mptcp_try_coalesce(sk, tail, skb))
 			return true;
 
-		mptcp_set_owner_r(skb, sk);
+		skb_set_owner_r(skb, sk);
 		__skb_queue_tail(&sk->sk_receive_queue, skb);
 		return true;
 	} else if (after64(MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq)) {
@@ -1987,9 +1920,10 @@ static int __mptcp_recvmsg_mskq(struct sock *sk,
 		}
 
 		if (!(flags & MSG_PEEK)) {
-			/* we will bulk release the skb memory later */
+			/* avoid the indirect call, we know the destructor is sock_wfree */
 			skb->destructor = NULL;
-			WRITE_ONCE(msk->rmem_released, msk->rmem_released + skb->truesize);
+			atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
+			sk_mem_uncharge(sk, skb->truesize);
 			__skb_unlink(skb, &sk->sk_receive_queue);
 			__kfree_skb(skb);
 			msk->bytes_consumed += count;
@@ -2103,18 +2037,6 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 	msk->rcvq_space.time = mstamp;
 }
 
-static void __mptcp_update_rmem(struct sock *sk)
-{
-	struct mptcp_sock *msk = mptcp_sk(sk);
-
-	if (!msk->rmem_released)
-		return;
-
-	atomic_sub(msk->rmem_released, &sk->sk_rmem_alloc);
-	mptcp_rmem_uncharge(sk, msk->rmem_released);
-	WRITE_ONCE(msk->rmem_released, 0);
-}
-
 static bool __mptcp_move_skbs(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow;
@@ -2138,7 +2060,6 @@ static bool __mptcp_move_skbs(struct sock *sk)
 			break;
 
 		slowpath = lock_sock_fast(ssk);
-		__mptcp_update_rmem(sk);
 		done = __mptcp_move_skbs_from_subflow(msk, ssk, &moved);
 
 		if (unlikely(ssk->sk_err))
@@ -2146,12 +2067,7 @@ static bool __mptcp_move_skbs(struct sock *sk)
 		unlock_sock_fast(ssk, slowpath);
 	} while (!done);
 
-	ret = moved > 0;
-	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue) ||
-	    !skb_queue_empty(&sk->sk_receive_queue)) {
-		__mptcp_update_rmem(sk);
-		ret |= __mptcp_ofo_queue(msk);
-	}
+	ret = moved > 0 || __mptcp_ofo_queue(msk);
 	if (ret)
 		mptcp_check_data_fin((struct sock *)msk);
 	return ret;
@@ -2817,8 +2733,6 @@ static void __mptcp_init_sock(struct sock *sk)
 	INIT_WORK(&msk->work, mptcp_worker);
 	msk->out_of_order_queue = RB_ROOT;
 	msk->first_pending = NULL;
-	WRITE_ONCE(msk->rmem_fwd_alloc, 0);
-	WRITE_ONCE(msk->rmem_released, 0);
 	msk->timer_ival = TCP_RTO_MIN;
 	msk->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
 
@@ -3044,8 +2958,6 @@ static void __mptcp_destroy_sock(struct sock *sk)
 
 	sk->sk_prot->destroy(sk);
 
-	WARN_ON_ONCE(READ_ONCE(msk->rmem_fwd_alloc));
-	WARN_ON_ONCE(msk->rmem_released);
 	sk_stream_kill_queues(sk);
 	xfrm_sk_free_policy(sk);
 
@@ -3403,8 +3315,6 @@ void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
 	/* move all the rx fwd alloc into the sk_mem_reclaim_final in
 	 * inet_sock_destruct() will dispose it
 	 */
-	sk_forward_alloc_add(sk, msk->rmem_fwd_alloc);
-	WRITE_ONCE(msk->rmem_fwd_alloc, 0);
 	mptcp_token_destroy(msk);
 	mptcp_pm_free_anno_list(msk);
 	mptcp_free_local_addr_list(msk);
@@ -3500,8 +3410,6 @@ static void mptcp_release_cb(struct sock *sk)
 		if (__test_and_clear_bit(MPTCP_SYNC_SNDBUF, &msk->cb_flags))
 			__mptcp_sync_sndbuf(sk);
 	}
-
-	__mptcp_update_rmem(sk);
 }
 
 /* MP_JOIN client subflow must wait for 4th ack before sending any data:
@@ -3672,12 +3580,6 @@ static void mptcp_shutdown(struct sock *sk, int how)
 		__mptcp_wr_shutdown(sk);
 }
 
-static int mptcp_forward_alloc_get(const struct sock *sk)
-{
-	return READ_ONCE(sk->sk_forward_alloc) +
-	       READ_ONCE(mptcp_sk(sk)->rmem_fwd_alloc);
-}
-
 static int mptcp_ioctl_outq(const struct mptcp_sock *msk, u64 v)
 {
 	const struct sock *sk = (void *)msk;
@@ -3836,7 +3738,6 @@ static struct proto mptcp_prot = {
 	.hash		= mptcp_hash,
 	.unhash		= mptcp_unhash,
 	.get_port	= mptcp_get_port,
-	.forward_alloc_get	= mptcp_forward_alloc_get,
 	.stream_memory_free	= mptcp_stream_memory_free,
 	.sockets_allocated	= &mptcp_sockets_allocated,
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 753456b73f90879126a36964924d2b6e08e2a1cc..613d556ed938a99a2800b4384ee4c6cda9483381 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -281,7 +281,6 @@ struct mptcp_sock {
 	u64		rcv_data_fin_seq;
 	u64		bytes_retrans;
 	u64		bytes_consumed;
-	int		rmem_fwd_alloc;
 	int		snd_burst;
 	int		old_wspace;
 	u64		recovery_snd_nxt;	/* in recovery mode accept up to this seq;
@@ -296,7 +295,6 @@ struct mptcp_sock {
 	u32		last_ack_recv;
 	unsigned long	timer_ival;
 	u32		token;
-	int		rmem_released;
 	unsigned long	flags;
 	unsigned long	cb_flags;
 	bool		recovery;		/* closing subflow write queue reinjected */
@@ -387,7 +385,7 @@ static inline void msk_owned_by_me(const struct mptcp_sock *msk)
  */
 static inline int __mptcp_rmem(const struct sock *sk)
 {
-	return atomic_read(&sk->sk_rmem_alloc) - READ_ONCE(mptcp_sk(sk)->rmem_released);
+	return atomic_read(&sk->sk_rmem_alloc);
 }
 
 static inline int mptcp_win_from_space(const struct sock *sk, int space)

-- 
2.47.1


