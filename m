Return-Path: <netdev+bounces-167460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DF7A3A5B9
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 19:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 471201884E06
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 18:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB051EB5DD;
	Tue, 18 Feb 2025 18:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCVhDslj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC3517A2EC;
	Tue, 18 Feb 2025 18:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739903792; cv=none; b=PG9S90cExD7WYHtJBb9DgTuioEX+PwcOQMmFbyMfCCcs4LjZhOuMCWKqqeGXwYASO2IMVHzw6CLQzOLMKs2E1T+Iuf2UELuZG+bdbsaZdopBk7JgIoqzRTpwJG4Nty8+zm5jjRrHFVsJ3PggOW6ypODc7Tv8zzVSpqWcDvFbkng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739903792; c=relaxed/simple;
	bh=ACPJ+yPY2W1joc1pWuexOVqHoRklIHDbYoAvIJBUces=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IivbUl05UoUliazvhm92tpDHtLxLU2kplD+Wef3fkA+yIlNMgjjUKOJsw5JOMmtVY9sjdZ1wFm+9qdfXRndi4vJuF4DUv1txNd0EHayvKGfLz2u+g7qsuv0UTlCuLj/av0SP7JNEgSBpfYnXlVTN+u+MbY+skTHPyajzO3SeWSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCVhDslj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA63DC4CEEC;
	Tue, 18 Feb 2025 18:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739903790;
	bh=ACPJ+yPY2W1joc1pWuexOVqHoRklIHDbYoAvIJBUces=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vCVhDsljVOLC+ZuCrbHzsCMseOuvPK6IM8frJ6YPpjw/ofh8Gyme3GvfSIbY62w+L
	 Q/DMBlraTT0WxRBy6V1d3uJBAhEV3r8HnfFIjcKRbchcmIPyrnog7moRoxE2py5eEp
	 KXNgDfHOrmWbw4Bdrw5Ow97ckMX5RVdoiwxbDT7mrlJ64CkbjSC/ywj3q8Fzd/odaw
	 UR0qrwzX07WWlmyW12wElxeQLEKM3b5T3q1VZ1Hs56RLpJEYv60wKD2abTgkhdfDai
	 D6v5x9rbpHhTLzJ8QuhafgiQCZlziqt/UD2fkVmKXovTaIPqnnE377U5nAuf12CREt
	 Ym9hDOqMDXB6A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 18 Feb 2025 19:36:12 +0100
Subject: [PATCH net-next 1/7] mptcp: consolidate subflow cleanup
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-net-next-mptcp-rx-path-refactor-v1-1-4a47d90d7998@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3128; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=zRyPHzOQB2XFEMTBCqtrVF98bVbR+f2SqeWZUx2E3Mk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBntNMnQ625mFfmmXvXNxxfMGbI3LG3oiO7dwtQo
 VC68j5mG52JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ7TTJwAKCRD2t4JPQmmg
 cwC8D/43bwVvWQSnpOYMdB0IUUji3qmRDXfax0ap6JB5FwA6aPGzzySU8tynCEX2ZswNINX6ytJ
 vlAceGeapAN+SA6Of2kvo8vmlcBinvb1Unb50dTwjgx5fUY4/6rwYRAEXbanR2jOw87T7MHzIGq
 ozFcB/KKveDT3wM8Q1/tktDBf6SW7eyPvDsAciZpSe2keAN42A+s9rwi2wM5jiqn5BcrxGl85bw
 X9n2wKvoirZ0pYQWsa8f3O3VZeksUsPiFZK13dTtnFWbmCYrVtplUnPmFSJZQFf4sNHdtkZvP5t
 jQkf0D9PfKQ+DrofrCJpNQRDRtyYMc8SivCafViYBKSFzYAhR5UkJJWbCQbUCPEQw/fYZhtYAc7
 hhfAOJi6VfLrYg3khVuFZg29mrCJrHW0hzDKE5FjMxaBN/RPpcnPUwwJybgbNsPdhvMXNNEcRK7
 LeHnQGdXXR8OQterDWgACO2laWpUnGuoLXoXXwBnz+kX2RL/tRBj9Es5ImYrBzroBldhtDfPJWk
 rSxHqaDIGedrP2G/lptfQbarakYVXi+/ancBR5ULW/SS5MmB995Vz21664xEdtlp9XjmpLifThc
 J2u4bAb+hgiLLyNtputga+N9trgyN6qCmmBv7hF4PkJJP2uXvFpZYqwKK03xLstWOBdraruMrVq
 otSK2CtPyRpqmfA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Consolidate all the cleanup actions requiring the worker in a single
helper and ensure the dummy data fin creation for fallback socket is
performed only when the tcp rx queue is empty.

There are no functional changes intended, but this will simplify the
next patch, when the tcp rx queue spooling could be delayed at release_cb
time.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/subflow.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index fd021cf8286eff9234b950a4d4c083ea7756eba3..2926bdf88e42c5f2db6875b00b4eca2dbf49dba2 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1271,7 +1271,12 @@ static void mptcp_subflow_discard_data(struct sock *ssk, struct sk_buff *skb,
 		subflow->map_valid = 0;
 }
 
-/* sched mptcp worker to remove the subflow if no more data is pending */
+static bool subflow_is_done(const struct sock *sk)
+{
+	return sk->sk_shutdown & RCV_SHUTDOWN || sk->sk_state == TCP_CLOSE;
+}
+
+/* sched mptcp worker for subflow cleanup if no more data is pending */
 static void subflow_sched_work_if_closed(struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct sock *sk = (struct sock *)msk;
@@ -1281,8 +1286,18 @@ static void subflow_sched_work_if_closed(struct mptcp_sock *msk, struct sock *ss
 		    inet_sk_state_load(sk) != TCP_ESTABLISHED)))
 		return;
 
-	if (skb_queue_empty(&ssk->sk_receive_queue) &&
-	    !test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
+	if (!skb_queue_empty(&ssk->sk_receive_queue))
+		return;
+
+	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
+		mptcp_schedule_work(sk);
+
+	/* when the fallback subflow closes the rx side, trigger a 'dummy'
+	 * ingress data fin, so that the msk state will follow along
+	 */
+	if (__mptcp_check_fallback(msk) && subflow_is_done(ssk) &&
+	    msk->first == ssk &&
+	    mptcp_update_rcv_data_fin(msk, READ_ONCE(msk->ack_seq), true))
 		mptcp_schedule_work(sk);
 }
 
@@ -1842,11 +1857,6 @@ static void __subflow_state_change(struct sock *sk)
 	rcu_read_unlock();
 }
 
-static bool subflow_is_done(const struct sock *sk)
-{
-	return sk->sk_shutdown & RCV_SHUTDOWN || sk->sk_state == TCP_CLOSE;
-}
-
 static void subflow_state_change(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
@@ -1873,13 +1883,6 @@ static void subflow_state_change(struct sock *sk)
 		subflow_error_report(sk);
 
 	subflow_sched_work_if_closed(mptcp_sk(parent), sk);
-
-	/* when the fallback subflow closes the rx side, trigger a 'dummy'
-	 * ingress data fin, so that the msk state will follow along
-	 */
-	if (__mptcp_check_fallback(msk) && subflow_is_done(sk) && msk->first == sk &&
-	    mptcp_update_rcv_data_fin(msk, READ_ONCE(msk->ack_seq), true))
-		mptcp_schedule_work(parent);
 }
 
 void mptcp_subflow_queue_clean(struct sock *listener_sk, struct sock *listener_ssk)

-- 
2.47.1


