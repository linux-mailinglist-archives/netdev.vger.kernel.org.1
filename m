Return-Path: <netdev+bounces-208261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE48B0ABF0
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 00:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6FF758851D
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 22:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AB22236F0;
	Fri, 18 Jul 2025 22:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lx8Ys5QY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7752236E3;
	Fri, 18 Jul 2025 22:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752876447; cv=none; b=NpQXX/7X7sVnl+sgvVjIYGaov3+0Q3ngz/IjPuf7Rm9LD9B2k07qQeXr3jsuOeHCrhefxJZy9Xz1mZjzVzP0Fi8Ka9LYq0ZwU7VtY0CU6OzYxIG4rn6VLl5VOtCfytr+LJryU6hmr7xqxpvQuquNhX6WImt/p3KdjzF/G5dx+Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752876447; c=relaxed/simple;
	bh=/SQtUJyCpLjbf+fckE/nrzvl+r8miFRFPNgU2sEtSZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hefZavSF3tKi+9NEJKaT7x7dP8uvZyEC1F8xAJhGJ9NkLDhynIgqzsxBPC4QII+E9XhbxZSYmkwtYuzc1vj4BEOPeRSdYg652sXEMij47iqQ5gxTBeeGu2LW3nMqS4S07kNAqONoi8wrZSI2MlEZj6XRsFZw4o0lbzLeZ9/0198=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lx8Ys5QY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1F4C4CEF9;
	Fri, 18 Jul 2025 22:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752876447;
	bh=/SQtUJyCpLjbf+fckE/nrzvl+r8miFRFPNgU2sEtSZs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Lx8Ys5QYkHmp2rZY76f0bnPRwRGeY37a5q1o0e6PwsQHTu5KPOuaxaXjE0UY/3lR7
	 oY//6LSBDM4syZDXtf+VLXaBEzx+DhL6u1dObTKKdAjW6JIyEGXoBO5WFFC1vgNhjB
	 TVAgytCnaQbV8QbNHXA49HLSBjmyhj9LHqHCBxRTRAvkTp+n0Ko5zMlpwynOi+/wLn
	 INj+Gdgj+nQlzbYKpqtkJIwQsEQSlHA5qqGrsjjBf36YulB2T3rWCPDasP3wljgapJ
	 l1YvBOaMh0sxLBeMTq+FrzOMB2+z0aHO65h9si+c4xw6Trpt6H0NrNXJyaqKwoP+RA
	 q6PgEYsOkOScA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 19 Jul 2025 00:06:57 +0200
Subject: [PATCH net-next v2 2/4] tcp: add tcp_sock_set_maxseg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250719-net-next-mptcp-tcp_maxseg-v2-2-8c910fbc5307@kernel.org>
References: <20250719-net-next-mptcp-tcp_maxseg-v2-0-8c910fbc5307@kernel.org>
In-Reply-To: <20250719-net-next-mptcp-tcp_maxseg-v2-0-8c910fbc5307@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2363; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=YqIJfnbK+sopMAVXCbVtu06VBqQwQt1h8xVTfpnCAag=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKqjk5KbW6/nxu+yvPzlymT9Xn8n4tkCM7vmDnbQevM+
 9xrks89OkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbSKMvI0FudbLa8qsjvcZqP
 9pJtjq8fmrSs36v7kafhWKa31oavBxj+10zJKrwY0dHkyz373B5PoQO8U1xcj/FrH4nx6lkbces
 bOwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Add a helper tcp_sock_set_maxseg() to directly set the TCP_MAXSEG
sockopt from kernel space.

This new helper will be used in the following patch from MPTCP.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
- v2: Set the return value of tcp_sock_set_maxseg() to err.
---
 include/linux/tcp.h |  1 +
 net/ipv4/tcp.c      | 23 ++++++++++++++---------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 1a5737b3753d06165bc71e257a261bcd7a0085ce..57e478bfaef20369f5dba1cff540e52c9302ebf4 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -621,6 +621,7 @@ void tcp_sock_set_nodelay(struct sock *sk);
 void tcp_sock_set_quickack(struct sock *sk, int val);
 int tcp_sock_set_syncnt(struct sock *sk, int val);
 int tcp_sock_set_user_timeout(struct sock *sk, int val);
+int tcp_sock_set_maxseg(struct sock *sk, int val);
 
 static inline bool dst_tcp_usec_ts(const struct dst_entry *dst)
 {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 31149a0ac849192b46c67dd569efeeeb0a041a0b..71a956fbfc5533224ee00e792de2cfdccd4d40aa 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3751,6 +3751,19 @@ int tcp_set_window_clamp(struct sock *sk, int val)
 	return 0;
 }
 
+int tcp_sock_set_maxseg(struct sock *sk, int val)
+{
+	/* Values greater than interface MTU won't take effect. However
+	 * at the point when this call is done we typically don't yet
+	 * know which interface is going to be used
+	 */
+	if (val && (val < TCP_MIN_MSS || val > MAX_TCP_WINDOW))
+		return -EINVAL;
+
+	tcp_sk(sk)->rx_opt.user_mss = val;
+	return 0;
+}
+
 /*
  *	Socket option code for TCP.
  */
@@ -3883,15 +3896,7 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 
 	switch (optname) {
 	case TCP_MAXSEG:
-		/* Values greater than interface MTU won't take effect. However
-		 * at the point when this call is done we typically don't yet
-		 * know which interface is going to be used
-		 */
-		if (val && (val < TCP_MIN_MSS || val > MAX_TCP_WINDOW)) {
-			err = -EINVAL;
-			break;
-		}
-		tp->rx_opt.user_mss = val;
+		err = tcp_sock_set_maxseg(sk, val);
 		break;
 
 	case TCP_NODELAY:

-- 
2.50.0


