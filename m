Return-Path: <netdev+bounces-240837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B70C7AFC8
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 18:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D4883A3847
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 17:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E2C345CCC;
	Fri, 21 Nov 2025 17:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Syw60q6P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8942522A1D5;
	Fri, 21 Nov 2025 17:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763744586; cv=none; b=sMKkt1W3oTsmrFpgEjWUtUUFbhPtDmGkMu3jLX8+u6rkUTNGsVYHgE56o47k9QdkVGT951gPNuxeFctth1rewLFHuavdkDV42V9PwIwzZt7wal4urejdkPVgMv1TwM6zEhuQcOgQgJvPzQ+QNZxky23O+abakS0GtJQcwuBy2X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763744586; c=relaxed/simple;
	bh=veFLr+o0B+jOAG0p/wdPi9gfx4GiO7j8scPu9YY5M9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WaYR6d9vc43F5Fp8PzjepX58GQoWrU/Qpeav8j4WF/A7f9jbk+jg4yaJQDr1YpXWig26sOlOBf8EKlX5wvVNv8wIsFUouk/hgZy1g39IATnzAq+7533/oTjjdYqISzDxvKOolawvrSk5lgGg7atPC2S/1klp2k6PHPeeLEf9EL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Syw60q6P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D330C116C6;
	Fri, 21 Nov 2025 17:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763744586;
	bh=veFLr+o0B+jOAG0p/wdPi9gfx4GiO7j8scPu9YY5M9s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Syw60q6PNG0xt2JIa29xtc7P2TalQlomatFxB1Vq1CA0ghACGQkW1ETNAptdc5z2S
	 zTR9iztGlqbLTPBCfommg95Pog41SpXnkNQ+TGLI3J0Qh5UZdx5o0OE93NB/zWq4Fi
	 xPYfU6N1xl1gmAd5gnX3xLQEgaan5+aFLfpvgZzLdYJTzHmsJZhZNo3zYmRk0UsVga
	 e+/ixJLf5lmm2+TUeAgwH3sE/pNW0hnjJVP6PTajdIrFRTVP8+tMnPYHvrYDJX3WOg
	 bcT9951ExwevobGEyKszvoyRHoZ3a7dIEqkN9EO/KS61hHlfTN2uuJ1x1x6obysFoh
	 fg8diW3h9Qybw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 21 Nov 2025 18:02:10 +0100
Subject: [PATCH net-next 11/14] mptcp: handle first subflow closing
 consistently
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-net-next-mptcp-memcg-backlog-imp-v1-11-1f34b6c1e0b1@kernel.org>
References: <20251121-net-next-mptcp-memcg-backlog-imp-v1-0-1f34b6c1e0b1@kernel.org>
In-Reply-To: <20251121-net-next-mptcp-memcg-backlog-imp-v1-0-1f34b6c1e0b1@kernel.org>
To: Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 Peter Krystad <peter.krystad@linux.intel.com>, 
 Florian Westphal <fw@strlen.de>, Christoph Paasch <cpaasch@apple.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 mptcp@lists.linux.dev, Davide Caratti <dcaratti@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3870; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=S64ANmhGtgjjf0LZRwCi2Y2h4lDr+CHuAO5tZ6lN/+U=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIVZst+Cf/4x1+uLyr3i3cQY8byr76t1x8smuQT67Mn8
 JPT5LezOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACby1pDhD/eMMxsPrn/3+PR0
 o4/yRa+1Wie5f69fel944oZrB2offk9gZPi0kev+fo5bR7pS7zQ+Ff7MlJ7Hu9zooMJcc/9JLe9
 eH2YAAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Currently, as soon as the PM closes a subflow, the msk stops accepting
data from it, even if the TCP socket could be still formally open in the
incoming direction, with the notable exception of the first subflow.

The root cause of such behavior is that code currently piggy back two
separate semantic on the subflow->disposable bit: the subflow context
must be released and that the subflow must stop accepting incoming
data.

The first subflow is never disposed, so it also never stop accepting
incoming data. Use a separate bit to mark the latter status and set such
bit in __mptcp_close_ssk() for all subflows.

Beyond making per subflow behaviour more consistent this will also
simplify the next patch.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 14 +++++++++-----
 net/mptcp/protocol.h |  3 ++-
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ba1237853ebf..d22f792f4760 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -851,10 +851,10 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
 	/* The peer can send data while we are shutting down this
-	 * subflow at msk destruction time, but we must avoid enqueuing
+	 * subflow at subflow destruction time, but we must avoid enqueuing
 	 * more data to the msk receive queue
 	 */
-	if (unlikely(subflow->disposable))
+	if (unlikely(subflow->closing))
 		return;
 
 	mptcp_data_lock(sk);
@@ -2437,6 +2437,13 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	bool dispose_it, need_push = false;
 
+	/* Do not pass RX data to the msk, even if the subflow socket is not
+	 * going to be freed (i.e. even for the first subflow on graceful
+	 * subflow close.
+	 */
+	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+	subflow->closing = 1;
+
 	/* If the first subflow moved to a close state before accept, e.g. due
 	 * to an incoming reset or listener shutdown, the subflow socket is
 	 * already deleted by inet_child_forget() and the mptcp socket can't
@@ -2447,7 +2454,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		/* ensure later check in mptcp_worker() will dispose the msk */
 		sock_set_flag(sk, SOCK_DEAD);
 		mptcp_set_close_tout(sk, tcp_jiffies32 - (mptcp_close_timeout(sk) + 1));
-		lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 		mptcp_subflow_drop_ctx(ssk);
 		goto out_release;
 	}
@@ -2456,8 +2462,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	if (dispose_it)
 		list_del(&subflow->node);
 
-	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
-
 	if (subflow->send_fastclose && ssk->sk_state != TCP_CLOSE)
 		tcp_set_state(ssk, TCP_CLOSE);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3d2892cc0ef2..d30806b287d2 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -536,12 +536,13 @@ struct mptcp_subflow_context {
 		send_infinite_map : 1,
 		remote_key_valid : 1,        /* received the peer key from */
 		disposable : 1,	    /* ctx can be free at ulp release time */
+		closing : 1,	    /* must not pass rx data to msk anymore */
 		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
 		valid_csum_seen : 1,        /* at least one csum validated */
 		is_mptfo : 1,	    /* subflow is doing TFO */
 		close_event_done : 1,       /* has done the post-closed part */
 		mpc_drop : 1,	    /* the MPC option has been dropped in a rtx */
-		__unused : 9;
+		__unused : 8;
 	bool	data_avail;
 	bool	scheduled;
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */

-- 
2.51.0


