Return-Path: <netdev+bounces-240836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BD9C7B007
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 18:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A1179382AF9
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 17:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385623563DD;
	Fri, 21 Nov 2025 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtSL3LxX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D063355808;
	Fri, 21 Nov 2025 17:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763744583; cv=none; b=GEh/ATGEh0IV3/R+31szA3YROalajZ8EuRXZFgT6Oq78oyBMqOENasedPdjsU4NqtN9OEnEuHCl4v+E4aQXSN9Vtn9fJQyKvg459WzYbDH2MdROSTJc/VEaXgagI7sxw+8nXN8K6ILRddOzh5egSoCSQh+D9VrmO62lefWmRClA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763744583; c=relaxed/simple;
	bh=Y+xXgx+Uq+p1JTHqxHVETDhmBVd89PnFCtfD8cUF40M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CvxxFfC+s5NYDaxLUbUqrp+/7MltSrHMV/Su8l44i6Okpq/jXcMaAg/o1Zcd3WZXOoM/a2AIK1mJ0L+CWbEg2ZaNp1mydzDxQDVEXZJJGQFAeDoOaq3A3kj7vD7rrXn7Z3gi6L5oxqa6xTl2n5Kk7bBRMn7JO+DsOUYIShF3LQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtSL3LxX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B23AC4CEF1;
	Fri, 21 Nov 2025 17:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763744582;
	bh=Y+xXgx+Uq+p1JTHqxHVETDhmBVd89PnFCtfD8cUF40M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UtSL3LxX6bQJh5maA4a3OIZCmGL0n4Bif/vKXwZ2ZIdvaCZzpVH61Mq+sYR+kwAhp
	 xGmGnp63QYyX+3h7cK+eZ+oTjwysD0VkcJfOBZDsByjF7oTcpMn1g9e7xX15zfPfU/
	 3BDZksuT/0L3uxVLH+lBx702CjIQ47419yktDvzIOw/Ly3/y9ruL+hSCfuALZU498v
	 1BuoMsLNXLRUnm8aPGYW5faA2PY8gCZx4Wj+wrlw1iHA/4ql4tbzeiI/6c52DDPqo8
	 MXdoITA6Rr1cJImRy8+ax0p+V6g3fjnqcaidvVVO7IM6DQBdlX8OTN/CAMWu/3Iszy
	 h1X/MYc83fEFg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 21 Nov 2025 18:02:09 +0100
Subject: [PATCH net-next 10/14] mptcp: drop the __mptcp_data_ready() helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-net-next-mptcp-memcg-backlog-imp-v1-10-1f34b6c1e0b1@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1794; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=hZOTQX3O/F+vkYeO9KCBSATOUH3wCz2peNWf1iIQb6s=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIVZsvcE/u8O9dTd9KLBa2fl7w+MPkZw+3w051OdvIK4
 lNPHr3xsqOUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAi3cEMf6Xznjxcs8TG/+lH
 eaW1Jf8XmeSIfMxkse0PuCpQpnd9nj0jw5myedLqR2uXaW/sy+fdEpCsELjMZcJDGyVur5qXn39
 PYgMA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

It adds little clarity and there is a single user of such helper,
just inline it in the caller.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Geliang Tang <geliang@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 29e5bda0e913..ba1237853ebf 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -845,18 +845,10 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
 	return moved;
 }
 
-static void __mptcp_data_ready(struct sock *sk, struct sock *ssk)
-{
-	struct mptcp_sock *msk = mptcp_sk(sk);
-
-	/* Wake-up the reader only for in-sequence data */
-	if (move_skbs_to_msk(msk, ssk) && mptcp_epollin_ready(sk))
-		sk->sk_data_ready(sk);
-}
-
 void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+	struct mptcp_sock *msk = mptcp_sk(sk);
 
 	/* The peer can send data while we are shutting down this
 	 * subflow at msk destruction time, but we must avoid enqueuing
@@ -866,10 +858,13 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 		return;
 
 	mptcp_data_lock(sk);
-	if (!sock_owned_by_user(sk))
-		__mptcp_data_ready(sk, ssk);
-	else
+	if (!sock_owned_by_user(sk)) {
+		/* Wake-up the reader only for in-sequence data */
+		if (move_skbs_to_msk(msk, ssk) && mptcp_epollin_ready(sk))
+			sk->sk_data_ready(sk);
+	} else {
 		__set_bit(MPTCP_DEQUEUE, &mptcp_sk(sk)->cb_flags);
+	}
 	mptcp_data_unlock(sk);
 }
 

-- 
2.51.0


