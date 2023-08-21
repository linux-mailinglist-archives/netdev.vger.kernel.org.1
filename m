Return-Path: <netdev+bounces-29464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3137C7835AF
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 00:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDF3C280FC7
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 22:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E6E1ADC3;
	Mon, 21 Aug 2023 22:25:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D2C1B7D0;
	Mon, 21 Aug 2023 22:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E192C433C9;
	Mon, 21 Aug 2023 22:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692656724;
	bh=844ERc/SpZdh5idxnvmNmp7nv/VNlGd0NRgXWs3/ito=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MTGJcu395Hz2GYiE25yo3BBQcRQTxjtw5vTTMYDZ67tOikD843v2xu8bjZDwB+NtO
	 BQ0HCT1eFV3fwxBF6GkqWq1XOMdeZVL5DRsXvozx9SO+avQUmyQMeXpGWcJeZVb9B8
	 IONNolOy5HEUcygTc4vr+2EorNig3bHQy1LcwzQj1+d0EV9IGiGD97Qsma/1GDLF9T
	 grSMYNm7ar6m6pO99q46Yy0PirdcOaoBsgDbCT0lOhCzduK2cA4++mIlrErjte/5cf
	 9rooT4sN5/K0bETOQDqDsOWY+WJqSluqE0HIqq+iw12JhCb/7UCvsdDqi3XSrfEQTR
	 nwUazMGjc0YJg==
From: Mat Martineau <martineau@kernel.org>
Date: Mon, 21 Aug 2023 15:25:19 -0700
Subject: [PATCH net-next 08/10] mptcp: use get_send wrapper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230821-upstream-net-next-20230818-v1-8-0c860fb256a8@kernel.org>
References: <20230821-upstream-net-next-20230818-v1-0-0c860fb256a8@kernel.org>
In-Reply-To: <20230821-upstream-net-next-20230818-v1-0-0c860fb256a8@kernel.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Geliang Tang <geliang.tang@suse.com>, Mat Martineau <martineau@kernel.org>
X-Mailer: b4 0.12.3

From: Geliang Tang <geliang.tang@suse.com>

This patch adds the multiple subflows support for __mptcp_push_pending
and __mptcp_subflow_push_pending. Use get_send() wrapper instead of
mptcp_subflow_get_send() in them.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler, use them to send data.

Move msk_owned_by_me() and fallback checks into get_send() wrapper from
mptcp_subflow_get_send().

This commit allows the scheduler to set the subflow->scheduled bit in
multiple subflows, but it does not allow for sending redundant data.
Multiple scheduled subflows will send sequential data on each subflow.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 net/mptcp/protocol.c | 113 +++++++++++++++++++++++++++++++--------------------
 net/mptcp/sched.c    |  13 ++++++
 2 files changed, 81 insertions(+), 45 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9cd172d2c8d6..77e94ee82859 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1377,15 +1377,6 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	u64 linger_time;
 	long tout = 0;
 
-	msk_owned_by_me(msk);
-
-	if (__mptcp_check_fallback(msk)) {
-		if (!msk->first)
-			return NULL;
-		return __tcp_can_send(msk->first) &&
-		       sk_stream_memory_free(msk->first) ? msk->first : NULL;
-	}
-
 	/* pick the subflow with the lower wmem/wspace ratio */
 	for (i = 0; i < SSK_MODE_MAX; ++i) {
 		send_info[i].ssk = NULL;
@@ -1538,43 +1529,56 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 				.flags = flags,
 	};
 	bool do_check_data_fin = false;
+	int push_count = 1;
 
-	while (mptcp_send_head(sk)) {
+	while (mptcp_send_head(sk) && (push_count > 0)) {
+		struct mptcp_subflow_context *subflow;
 		int ret = 0;
 
-		prev_ssk = ssk;
-		ssk = mptcp_subflow_get_send(msk);
+		if (mptcp_sched_get_send(msk))
+			break;
 
-		/* First check. If the ssk has changed since
-		 * the last round, release prev_ssk
-		 */
-		if (ssk != prev_ssk && prev_ssk)
-			mptcp_push_release(prev_ssk, &info);
-		if (!ssk)
-			goto out;
+		push_count = 0;
 
-		/* Need to lock the new subflow only if different
-		 * from the previous one, otherwise we are still
-		 * helding the relevant lock
-		 */
-		if (ssk != prev_ssk)
-			lock_sock(ssk);
+		mptcp_for_each_subflow(msk, subflow) {
+			if (READ_ONCE(subflow->scheduled)) {
+				mptcp_subflow_set_scheduled(subflow, false);
 
-		ret = __subflow_push_pending(sk, ssk, &info);
-		if (ret <= 0) {
-			if (ret == -EAGAIN)
-				continue;
-			mptcp_push_release(ssk, &info);
-			goto out;
+				prev_ssk = ssk;
+				ssk = mptcp_subflow_tcp_sock(subflow);
+				if (ssk != prev_ssk) {
+					/* First check. If the ssk has changed since
+					 * the last round, release prev_ssk
+					 */
+					if (prev_ssk)
+						mptcp_push_release(prev_ssk, &info);
+
+					/* Need to lock the new subflow only if different
+					 * from the previous one, otherwise we are still
+					 * helding the relevant lock
+					 */
+					lock_sock(ssk);
+				}
+
+				push_count++;
+
+				ret = __subflow_push_pending(sk, ssk, &info);
+				if (ret <= 0) {
+					if (ret != -EAGAIN ||
+					    (1 << ssk->sk_state) &
+					     (TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 | TCPF_CLOSE))
+						push_count--;
+					continue;
+				}
+				do_check_data_fin = true;
+			}
 		}
-		do_check_data_fin = true;
 	}
 
 	/* at this point we held the socket lock for the last subflow we used */
 	if (ssk)
 		mptcp_push_release(ssk, &info);
 
-out:
 	/* ensure the rtx timer is running */
 	if (!mptcp_timer_pending(sk))
 		mptcp_reset_timer(sk);
@@ -1588,30 +1592,49 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 	struct mptcp_sendmsg_info info = {
 		.data_lock_held = true,
 	};
+	bool keep_pushing = true;
 	struct sock *xmit_ssk;
 	int copied = 0;
 
 	info.flags = 0;
-	while (mptcp_send_head(sk)) {
+	while (mptcp_send_head(sk) && keep_pushing) {
+		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 		int ret = 0;
 
 		/* check for a different subflow usage only after
 		 * spooling the first chunk of data
 		 */
-		xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk);
-		if (!xmit_ssk)
-			goto out;
-		if (xmit_ssk != ssk) {
-			mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
-					       MPTCP_DELEGATE_SEND);
+		if (first) {
+			mptcp_subflow_set_scheduled(subflow, false);
+			ret = __subflow_push_pending(sk, ssk, &info);
+			first = false;
+			if (ret <= 0)
+				break;
+			copied += ret;
+			continue;
+		}
+
+		if (mptcp_sched_get_send(msk))
 			goto out;
+
+		if (READ_ONCE(subflow->scheduled)) {
+			mptcp_subflow_set_scheduled(subflow, false);
+			ret = __subflow_push_pending(sk, ssk, &info);
+			if (ret <= 0)
+				keep_pushing = false;
+			copied += ret;
 		}
 
-		ret = __subflow_push_pending(sk, ssk, &info);
-		first = false;
-		if (ret <= 0)
-			break;
-		copied += ret;
+		mptcp_for_each_subflow(msk, subflow) {
+			if (READ_ONCE(subflow->scheduled)) {
+				xmit_ssk = mptcp_subflow_tcp_sock(subflow);
+				if (xmit_ssk != ssk) {
+					mptcp_subflow_delegate(subflow,
+							       MPTCP_DELEGATE_SEND);
+					keep_pushing = false;
+				}
+			}
+		}
 	}
 
 out:
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 884606686cfe..078b5d44978d 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -99,6 +99,19 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sched_data data;
 
+	msk_owned_by_me(msk);
+
+	/* the following check is moved out of mptcp_subflow_get_send */
+	if (__mptcp_check_fallback(msk)) {
+		if (msk->first &&
+		    __tcp_can_send(msk->first) &&
+		    sk_stream_memory_free(msk->first)) {
+			mptcp_subflow_set_scheduled(mptcp_subflow_ctx(msk->first), true);
+			return 0;
+		}
+		return -EINVAL;
+	}
+
 	mptcp_for_each_subflow(msk, subflow) {
 		if (READ_ONCE(subflow->scheduled))
 			return 0;

-- 
2.41.0


