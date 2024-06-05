Return-Path: <netdev+bounces-100851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BF58FC454
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 440731C20C30
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 07:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF2E18FDC7;
	Wed,  5 Jun 2024 07:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WihXUOUt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23CF18FDC2;
	Wed,  5 Jun 2024 07:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717571780; cv=none; b=ZPmQvKLO7OzIXcVGeneo0791rCNytnUqJ067f4B6AcG3E7vZd4c+nhpZGJbJGbjwBlRCgOW6tfdqnj/13IWIYiZjgwO0ZC6e1d2q8zS42SNzu4T4qtClLYKwOck/sCznNPzOI7b/q7IS67T/hx6lQoaRndpyM7XwrsJFiDh5z8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717571780; c=relaxed/simple;
	bh=1PI2nXrsvIcrYo4MrlKEOdaWNrzEuMuFERHCGG4asfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QS1sFf4d/I9PjD4l2MfuTCg0MuLGVXVt8yius+Lb5U1j2f55OBEW7yPhSoQH/03kmLv34uEFFOAQzy5Vai+/szOcP4jBWrur29rsi6PZxNYk/rx2yY7Yum5mE+TfHnn+fgf5CMZIoMAom+zPEzgPBWqWrVGLxeOzeE453JLgpDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WihXUOUt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CC0C4AF0B;
	Wed,  5 Jun 2024 07:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717571780;
	bh=1PI2nXrsvIcrYo4MrlKEOdaWNrzEuMuFERHCGG4asfI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WihXUOUt6uD/x5X6EzdVxOeS4ehKCRai5kkzTcyxiARJgmmNTER85Fqu4AS6y2TWB
	 iA9fj7TTROTpPIH+W+O1/1aTrbk41Rq4KinGVFIayj89DJi1Fud1gF65xTf7gVfPFH
	 LGI4uAbbs0ycfWKKujrly6n5+RrOX9DsRG4UC+igAwMapZ67UP45yqQXjn6gOHRRyi
	 6jJKSwIhvQsQAl8/0k0hxezMPz+SXVUEqBcfTCzUItbby/hdcv5WbOeRLl4qq/4gn9
	 QoncAl7v6GH2+8HDiuzp6rT5UyNDNaay7mHpwTyOUo6X9HpSZGkbGPPuyl4Po3TirE
	 TGf3M8gREmSzA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 05 Jun 2024 09:15:41 +0200
Subject: [PATCH net-next 2/3] mptcp: add mptcp_space_from_win helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-upstream-net-next-20240604-misc-cleanup-v1-2-ae2e35c3ecc5@kernel.org>
References: <20240605-upstream-net-next-20240604-misc-cleanup-v1-0-ae2e35c3ecc5@kernel.org>
In-Reply-To: <20240605-upstream-net-next-20240604-misc-cleanup-v1-0-ae2e35c3ecc5@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2217; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=jC86ee13yk/lZldYs4U96bt6yIokZxBGLRjbV7iwlNc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmYBC76jp890uaRvhriq27G9PKQKHzEOpBOGPsk
 k/lXHlTolyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZmAQuwAKCRD2t4JPQmmg
 c9M6EACPNPWSz/sNvtP8/rRBmLoj19WNSOqAI+N9B4bqN4vWd9bbc3+PXBNNOk9jW3AEklxx3zh
 0fDIFM1EyvSlUS7uwNRoxbYMk0ghDTye4gAvlYoKTbwxjZynAokOiwRVixnQLkTq0pFCFCyykUa
 s9IsjT4NYAzTeT6ujuHKs+hkjc1aVZDz9+ACBcrO5S8ELTxBXkTIBr080owwQ7HgE2SEp2FxmdX
 NEW/2+ORi9IrXSCblK0+kRXyo8qYoe/EOIy8M7dg0Hu9jLNJnPV2gSVcWTuNswigVHa9Jv453f4
 w1XAgPw/ye0vbogXq22OmaTe/tN+A7+TTY3QOPXt6MO7+SqlN9yGVFtLy8FOf4lXYEYBVnU2/N4
 fxiO+qf5Ew3+G6BVB4qUznA1iuCqvgHaevjAdQf3Tl1GeL1mt7HdwaeFhUojlrNNo5lQmufuMmT
 j5/vaaCpfZlhZjuzhRAvI3wOpG65y9IhDTZ2Inz4VUs7vXD6mWYfliJU94AT8WHyalj33rqmsQp
 VrnD/wxFbJKBiLaAsjJ0arYEMpb8nyewFddsK3SJr0Nm572Aw2oMuXf3Rneu/h4TiBa2iPGD9bz
 U6GtZBdlV5C5NZ4M8NM9spb1vZYN1BDPWuIJ9tHrBiy/m8cZoDxGjpuuK2AIxqaiyPzDZCBPp9v
 7tygP0/ghxWbjIw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

As a wrapper of __tcp_space_from_win(), this patch adds a MPTCP dedicated
space_from_win helper mptcp_space_from_win() in protocol.h to paired with
mptcp_win_from_space().

Use it instead of __tcp_space_from_win() in both mptcp_rcv_space_adjust()
and mptcp_set_rcvlowat().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 2 +-
 net/mptcp/protocol.h | 5 +++++
 net/mptcp/sockopt.c  | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 546c80c6702a..7ce11bee3b79 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2040,7 +2040,7 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 		do_div(grow, msk->rcvq_space.space);
 		rcvwin += (grow << 1);
 
-		rcvbuf = min_t(u64, __tcp_space_from_win(scaling_ratio, rcvwin),
+		rcvbuf = min_t(u64, mptcp_space_from_win(sk, rcvwin),
 			       READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_rmem[2]));
 
 		if (rcvbuf > sk->sk_rcvbuf) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7aa47e2dd52b..b11a4e50d52b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -386,6 +386,11 @@ static inline int mptcp_win_from_space(const struct sock *sk, int space)
 	return __tcp_win_from_space(mptcp_sk(sk)->scaling_ratio, space);
 }
 
+static inline int mptcp_space_from_win(const struct sock *sk, int win)
+{
+	return __tcp_space_from_win(mptcp_sk(sk)->scaling_ratio, win);
+}
+
 static inline int __mptcp_space(const struct sock *sk)
 {
 	return mptcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf) - __mptcp_rmem(sk));
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index f9a4fb17b5b7..2026a9a36f80 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1579,7 +1579,7 @@ int mptcp_set_rcvlowat(struct sock *sk, int val)
 	if (sk->sk_userlocks & SOCK_RCVBUF_LOCK)
 		return 0;
 
-	space = __tcp_space_from_win(mptcp_sk(sk)->scaling_ratio, val);
+	space = mptcp_space_from_win(sk, val);
 	if (space <= sk->sk_rcvbuf)
 		return 0;
 

-- 
2.43.0


