Return-Path: <netdev+bounces-29463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 154807835AE
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 00:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45F851C20A29
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 22:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDA71C2B9;
	Mon, 21 Aug 2023 22:25:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA4C1BB32;
	Mon, 21 Aug 2023 22:25:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BDDC43395;
	Mon, 21 Aug 2023 22:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692656724;
	bh=Miq3TLRI/pTEoF1BRBHAq+glR+w1Dr/v8PRF9aArIpk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bMj7gzI37ZuRwKhK9iobu3o5mAacB7hXDB/EIVIC3Y2xpDx8M8yp8KKmPnl7PbVyw
	 bZrY3tk8cRfzYKVfTZquRhQ/trkLXGkyHDeY34AYOQy3xnDPA9QP6Pebc1wvmP9tfn
	 Q7mEmAKqdbKDtk2vwPav8ChniRM55RyKj9cI4tsKeHDp/9FkzSCjKKCuQQHcqDFndI
	 foFB5FpebIU6feZfbo1JgZE2Cm0xLnNGBzPN2vfB7F5pUmiYFI+SyQ9WqOXEdyBdGJ
	 JFlyZnCKwbw/z9a/SHFOO4X+XSe/cZ3qtV0l+0tRvE+MxFmO5SSkS9LBdRUxOZV9OE
	 JS9e6GK501uyg==
From: Mat Martineau <martineau@kernel.org>
Date: Mon, 21 Aug 2023 15:25:20 -0700
Subject: [PATCH net-next 09/10] mptcp: use get_retrans wrapper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230821-upstream-net-next-20230818-v1-9-0c860fb256a8@kernel.org>
References: <20230821-upstream-net-next-20230818-v1-0-0c860fb256a8@kernel.org>
In-Reply-To: <20230821-upstream-net-next-20230818-v1-0-0c860fb256a8@kernel.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Geliang Tang <geliang.tang@suse.com>, Mat Martineau <martineau@kernel.org>
X-Mailer: b4 0.12.3

From: Geliang Tang <geliang.tang@suse.com>

This patch adds the multiple subflows support for __mptcp_retrans(). Use
get_retrans() wrapper instead of mptcp_subflow_get_retrans() in it.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler, use them to send data.

Move msk_owned_by_me() and fallback checks into get_retrans() wrapper
from mptcp_subflow_get_retrans().

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 net/mptcp/protocol.c | 65 ++++++++++++++++++++++++++++++----------------------
 net/mptcp/sched.c    |  6 +++++
 2 files changed, 43 insertions(+), 28 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 77e94ee82859..61590ff2b9ee 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2233,11 +2233,6 @@ struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 	struct mptcp_subflow_context *subflow;
 	int min_stale_count = INT_MAX;
 
-	msk_owned_by_me(msk);
-
-	if (__mptcp_check_fallback(msk))
-		return NULL;
-
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
@@ -2515,16 +2510,17 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 static void __mptcp_retrans(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sendmsg_info info = {};
 	struct mptcp_data_frag *dfrag;
-	size_t copied = 0;
 	struct sock *ssk;
-	int ret;
+	int ret, err;
+	u16 len = 0;
 
 	mptcp_clean_una_wakeup(sk);
 
 	/* first check ssk: need to kick "stale" logic */
-	ssk = mptcp_subflow_get_retrans(msk);
+	err = mptcp_sched_get_retrans(msk);
 	dfrag = mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -2543,32 +2539,45 @@ static void __mptcp_retrans(struct sock *sk)
 		goto reset_timer;
 	}
 
-	if (!ssk)
+	if (err)
 		goto reset_timer;
 
-	lock_sock(ssk);
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled)) {
+			u16 copied = 0;
 
-	/* limit retransmission to the bytes already sent on some subflows */
-	info.sent = 0;
-	info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len : dfrag->already_sent;
-	while (info.sent < info.limit) {
-		ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-		if (ret <= 0)
-			break;
+			mptcp_subflow_set_scheduled(subflow, false);
 
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RETRANSSEGS);
-		copied += ret;
-		info.sent += ret;
-	}
-	if (copied) {
-		dfrag->already_sent = max(dfrag->already_sent, info.sent);
-		msk->bytes_retrans += copied;
-		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
-			 info.size_goal);
-		WRITE_ONCE(msk->allow_infinite_fallback, false);
+			ssk = mptcp_subflow_tcp_sock(subflow);
+
+			lock_sock(ssk);
+
+			/* limit retransmission to the bytes already sent on some subflows */
+			info.sent = 0;
+			info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len :
+								    dfrag->already_sent;
+			while (info.sent < info.limit) {
+				ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+				if (ret <= 0)
+					break;
+
+				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RETRANSSEGS);
+				copied += ret;
+				info.sent += ret;
+			}
+			if (copied) {
+				len = max(copied, len);
+				tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
+					 info.size_goal);
+				WRITE_ONCE(msk->allow_infinite_fallback, false);
+			}
+
+			release_sock(ssk);
+		}
 	}
 
-	release_sock(ssk);
+	msk->bytes_retrans += len;
+	dfrag->already_sent = max(dfrag->already_sent, len);
 
 reset_timer:
 	mptcp_check_and_set_pending(sk);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 078b5d44978d..cac1cc1fa3b0 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -136,6 +136,12 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sched_data data;
 
+	msk_owned_by_me(msk);
+
+	/* the following check is moved out of mptcp_subflow_get_retrans */
+	if (__mptcp_check_fallback(msk))
+		return -EINVAL;
+
 	mptcp_for_each_subflow(msk, subflow) {
 		if (READ_ONCE(subflow->scheduled))
 			return 0;

-- 
2.41.0


